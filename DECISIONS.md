## Ericsson
1. **One row per lead.** The data is one row per marketing activity. Lead = converted if any row has leadstatus "Converted"; attributes = first non-missing value. Reproduced the baseline exactly (34,296 leads, 10.8%, AUC 0.690, top-10% lift 2.1x).
2. **Dropped the time-based split.** 85% of leads first appear in Q1 2024; 2025 leads convert at 2.3% vs. 11.3% for 2024 because they haven't had time. A time split would measure that, not model quality. Used lead-level 5-fold stratified CV instead (no lead appears in both train and test).
3. **Reframed to existing customers.** Customers convert at 37.5%, everyone else at 0.5%, and customers account for 96.7% of conversions. Contact type is used to define the population, never as a feature: in testing, adding it as a feature pushed AUC to about 0.90, and it may be updated after conversion.
4. **30-day feature window.** Engagement features only count each lead's first 30 days. Leads first seen after 2025-08-13 dropped (2 leads).
5. **Excluded marketer-driven activity.** "Add to Nurture" comes from one automated program; 78% of converted customers were added on day 1 vs. 28% of others. Active days, program count and bounces also reflect which sends marketing chose, possibly based on status (e.g., 3 active days → 62% conversion, 2 days → 10%, a pattern no behavior explains). With no conversion date, these can't be proven pre-conversion. Headline model uses only what the contact did: opens, clicks, page visits, form fills, click rate. Leaky version reported for transparency (AUC 0.865).
6. **Result accepted as is.** Contact behavior adds little (AUC 0.674 → 0.691). Not tuned further.
7. **No ROI.** No cost data.
8. **SQL** uses each lead's most common attribute value (pandas uses the first listed); 99.8% of levels match and 100% of converted flags.

