# Ericsson — final numbers (all from notebook.ipynb, run Nov 17 2026)

| Metric | Value |
|---|---|
| Activity rows / unique leads | 299,999 / 34,296 |
| Conversion rate, all leads | 10.8% (3,703) |
| Share of conversions from existing customers | 96.7% |
| Conversion: existing customers vs. new prospects | 37.5% vs. 0.5% |
| Customers: Manager / Staff vs. CXO | 46.7% / 40.2% vs. 12.2% |
| Baseline AUC, all leads, role only (random lead-level split) | 0.690 |
| Customer model, role only (5-fold CV, RF) | AUC 0.674, top-10% lift 1.66x |
| **Customer model, role + contact behavior (5-fold CV, RF)** | **AUC 0.691, top 10% convert at 64.6%, lift 1.72x** |
| Calling top 30% captures | 43% of conversions (random calling: 30%) |
| With marketer-driven features (likely leak, not used) | AUC 0.865 |
| SQL check vs. pandas | converted flag 100% match; level 99.8% |

## Resume bullets
- Rebuilt 300K Ericsson Marketo activity rows into a one-row-per-lead model in Python and SQL, fixing data leakage in the original class model; found 96.7% of conversions came from existing customers (37.5% vs. 0.5% for new prospects)
- Showed managers and staff at existing customers converted 3–4x more often than C-suite contacts (47% and 40% vs. 12%); a Random Forest lead score (AUC 0.69) captures 43% of conversions from the top 30% of contacts
- Tested for leakage and excluded automated marketing-program features that inflated AUC from 0.69 to 0.86

## 60-second interview story
**Situation:** a class project on Ericsson's Marketo data: which leads should sales call?
**Task:** when I revisited my model, I found the data had one row per activity, so the same lead was in both training and test.
**Action:** I rebuilt it at one row per lead. That showed almost all conversions came from existing customers, so I reframed the question to "which customer contacts to call first." I tested engagement features and threw out the ones driven by automated marketing programs, because they tracked status and inflated AUC from 0.69 to 0.86.
**Result:** an honest model, AUC 0.69, where calling the top 30% captures 43% of conversions, plus a clear targeting rule: managers and staff convert 3–4x more than C-suite.
