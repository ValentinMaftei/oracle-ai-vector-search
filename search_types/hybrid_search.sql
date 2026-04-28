CREATE HYBRID VECTOR INDEX documents_hybrid_idx ON 
documents (content)
PARAMETERS('MODEL ALL_MINILM_L12_V2');


SELECT id, file_name, content
FROM documents
WHERE CONTAINS(content, 'smartphone', 1) > 0
ORDER BY VECTOR_DISTANCE(embedding, VECTOR_EMBEDDING(ALL_MINILM_L12_V2 USING 'ZEPHYR ecosystem' AS DATA))
FETCH FIRST 3 ROWS ONLY;

SELECT DBMS_HYBRID_VECTOR.SEARCH(
    json('{ "hybrid_index_name" : "documents_hybrid_idx",
            "search_text"       : "Mouse is a beautiful animal"
          }'))
FROM dual;

SELECT jt.*
FROM DUAL,
     JSON_TABLE(
        -- Aici pui funcția ta care returnează JSON-ul
        DBMS_HYBRID_VECTOR.SEARCH(
            json('{ "hybrid_index_name" : "documents_hybrid_idx",
                    "search_text"       : "Who invented the plane?"
                }')
        ),
        -- Calea către array-ul de rezultate
        '$[*]' 
        COLUMNS (
            r_id          VARCHAR2(20)   PATH '$.rowid',
            final_score   NUMBER         PATH '$.score',
            v_score       NUMBER         PATH '$.vector_score',
            t_score       NUMBER         PATH '$.text_score',
            v_rank        NUMBER         PATH '$.vector_rank',
            t_rank        NUMBER         PATH '$.text_rank',
            content_chunk CLOB           PATH '$.chunk_text'
        )
     ) jt;

commit;


DROP INDEX documents_hybrid_idx;