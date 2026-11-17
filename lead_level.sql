-- Build one row per lead from a table of Marketo activities.
-- activities(leadId, industry, department__c, level__c, leadstatus, activityDate)
-- A lead is converted if ANY of its activity rows carries leadstatus = 'Converted'.
-- Attributes are the lead's most common non-missing value (ties: alphabetical).

DROP TABLE IF EXISTS leads;

CREATE TABLE leads AS
WITH conv AS (
    SELECT leadId,
           MAX(CASE WHEN leadstatus = 'Converted' THEN 1 ELSE 0 END) AS converted
    FROM activities
    GROUP BY leadId
),
lvl AS (
    SELECT leadId, level__c AS level,
           ROW_NUMBER() OVER (PARTITION BY leadId ORDER BY COUNT(*) DESC, level__c) AS rn
    FROM activities WHERE level__c IS NOT NULL
    GROUP BY leadId, level__c
),
dept AS (
    SELECT leadId, department__c AS department,
           ROW_NUMBER() OVER (PARTITION BY leadId ORDER BY COUNT(*) DESC, department__c) AS rn
    FROM activities WHERE department__c IS NOT NULL
    GROUP BY leadId, department__c
),
ind AS (
    SELECT leadId, industry,
           ROW_NUMBER() OVER (PARTITION BY leadId ORDER BY COUNT(*) DESC, industry) AS rn
    FROM activities WHERE industry IS NOT NULL
    GROUP BY leadId, industry
)
SELECT c.leadId,
       c.converted,
       COALESCE(i.industry, 'Missing')   AS industry,
       COALESCE(d.department, 'Missing') AS department,
       COALESCE(l.level, 'Missing')      AS level
FROM conv c
LEFT JOIN ind  i ON i.leadId = c.leadId AND i.rn = 1
LEFT JOIN dept d ON d.leadId = c.leadId AND d.rn = 1
LEFT JOIN lvl  l ON l.leadId = c.leadId AND l.rn = 1;

-- Conversion rate by job level (segments with 50+ leads)
SELECT level,
       COUNT(*)                              AS leads,
       SUM(converted)                        AS conversions,
       ROUND(100.0 * AVG(converted), 1)      AS conversion_rate_pct
FROM leads
GROUP BY level
HAVING COUNT(*) >= 50
ORDER BY conversion_rate_pct DESC;
