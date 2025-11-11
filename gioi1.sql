-- 1
-- a
SELECT * FROM post
WHERE is_public = TRUE AND LOWER(content) ILIKE '%du lịch%';
CREATE INDEX idx_lower_content ON post (LOWER(content));

-- b
EXPLAIN ANALYZE SELECT * FROM post WHERE is_public = TRUE AND LOWER(content) ILIKE '%du lịch%';

-- 2
SELECT * FROM post WHERE tags @> ARRAY['travel']::text[];
CREATE INDEX idx_tags_gin ON post USING GIN (tags);

EXPLAIN ANALYZE SELECT * FROM post WHERE tags @> ARRAY['travel']::text[];

-- 3
-- a
CREATE INDEX idx_post_recent_public
ON post (post_id)
WHERE is_public = TRUE AND created_at > NOW() - INTERVAL '7 days';

-- b
SELECT * FROM post
WHERE is_public = TRUE AND created_at > NOW() - INTERVAL '7 days';

-- 4
CREATE INDEX idx_user_created_at
ON post (user_id, created_at DESC);

