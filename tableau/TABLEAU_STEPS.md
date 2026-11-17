# Build the Ericsson dashboard in Tableau Public (about 45 minutes)

Files: `segments.csv` (conversion by level and department) and `score_deciles.csv` (conversion rate for each tenth of contacts, ranked by score).

1. Open Tableau Public → Connect → Text file → `segments.csv`. Then Data → New Data Source → `score_deciles.csv`.

**Sheet 1 — Conversion by job level**
2. Data source: segments. Drag `segment` to Rows, `rate_%` to Columns.
3. Filters: `segment_type` = level, `population` = existing customers.
4. Sort descending. Drag `leads` to Label. Title: "Existing-customer conversion by job level".

**Sheet 2 — Conversion by department**
5. Duplicate Sheet 1 and change the `segment_type` filter to department.

**Sheet 3 — Who to call first**
6. Data source: score_deciles. Drag `decile` to Columns (as a dimension) and `conversion_rate_pct` to Rows.
7. Add a reference line: Analytics → Reference Line → constant 37.5, labeled "average 37.5%".
8. Title: "Conversion rate by score decile (1 = highest score)".

**Dashboard**
9. New Dashboard, Size: Automatic. Put Sheet 3 across the top and Sheets 1 and 2 side by side below.
10. Add a text box at the top: "96.7% of conversions come from existing customers. Managers and staff convert 3–4x more than C-suite. Calling the top 30% of scored contacts captures 43% of conversions."
11. File → Save to Tableau Public. Copy the link into the README and your resume.
