-- 1
CREATE INDEX idx_author ON book USING btree (author);
CREATE INDEX idx_genre ON book USING btree (genre);

-- 2
EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';

-- 3
-- a. B-tree cho genre
CREATE INDEX idx_genre_btree ON book USING btree (genre);
-- b. GIN cho title hoặc description (phục vụ tìm kiếm full-text)
CREATE INDEX idx_title_gin ON book USING gin (to_tsvector('english', title));

-- 4
CLUSTER book USING idx_genre;

