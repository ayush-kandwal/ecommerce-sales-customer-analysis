CREATE SCHEMA analytics;

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'analytics';
