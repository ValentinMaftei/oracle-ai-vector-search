CREATE VECTOR INDEX documents_hnsw_idx ON documents (embedding)
ORGANIZATION INMEMORY NEIGHBOR GRAPH
DISTANCE COSINE
WITH TARGET ACCURACY 95;

SELECT 
    id, 
    file_name, 
    content, 
    VECTOR_DISTANCE(embedding, VECTOR_EMBEDDING(ALL_MINILM_L12_V2 USING 'Mouse' AS DATA), COSINE) AS distance
FROM documents
ORDER BY distance
FETCH FIRST 3 ROWS ONLY;

SELECT 
    id, 
    file_name, 
    content, 
    VECTOR_DISTANCE(embedding, VECTOR_EMBEDDING(ALL_MINILM_L12_V2 USING 'What should a mouse be used for?' AS DATA), COSINE) AS distance
FROM documents
ORDER BY distance
FETCH FIRST 3 ROWS ONLY;

SELECT 
    id, 
    file_name, 
    content, 
    VECTOR_DISTANCE(embedding, VECTOR_EMBEDDING(ALL_MINILM_L12_V2 USING 'What mirrorless camera should I buy?' AS DATA), COSINE) AS distance
FROM documents
ORDER BY distance
FETCH FIRST 3 ROWS ONLY;

SELECT 
    id, 
    file_name, 
    content, 
    VECTOR_DISTANCE(embedding, VECTOR_EMBEDDING(ALL_MINILM_L12_V2 USING 'ZEPHYR ecosystem' AS DATA), COSINE) AS distance
FROM documents
ORDER BY distance
FETCH FIRST 3 ROWS ONLY;

COMMIT;

