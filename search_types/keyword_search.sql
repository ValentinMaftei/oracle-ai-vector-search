CREATE INDEX idx_text_documents ON documents(content) 
INDEXTYPE IS CTXSYS.CONTEXT;

-- FUZZY
SELECT id, file_name, content, SCORE(1) as relevance_score
FROM documents
WHERE CONTAINS(content, 'FUZZY(airplane)', 1) > 0
ORDER BY SCORE(1) DESC;

-- FUZZY with typo
SELECT id, file_name, content, SCORE(1) as relevance_score
FROM documents
WHERE CONTAINS(content, 'FUZZY(mouze)', 1) > 0
ORDER BY SCORE(1) DESC;

-- Simple example
SELECT id, file_name, content, SCORE(1) as relevance_score
FROM documents
WHERE CONTAINS(content, 'ZEPHYR', 1) > 0
ORDER BY SCORE(1) DESC;

-- Wildcard 
SELECT id, file_name, content, SCORE(1) as relevance_score
FROM documents
WHERE CONTAINS(content, '%XL', 1) > 0
ORDER BY SCORE(1) DESC;

-- OR operator
SELECT id, file_name, content, SCORE(1) as relevance_score
FROM documents
WHERE CONTAINS(content, 'airplane OR aircraft OR plane', 1) > 0
ORDER BY SCORE(1) DESC;

-- AND operator
SELECT id, file_name, content, SCORE(1) as relevance_score
FROM documents
WHERE CONTAINS(content, 'mice AND rats', 1) > 0
ORDER BY SCORE(1) DESC;

DROP INDEX idx_text_documents;