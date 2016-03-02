# 2016 Campaign Tech

An entirely unofficial look at the technology stacks of the 2016 Presidential Campaigns

## Results

You can see the full results in the [`candidates.csv`](candidates.csv) file, but here's the overview:

| Check              | Overall        | Republicans    | Democrats    |
|:-------------------|:---------------|:---------------|:-------------|
| www?               | 15/15 (100.0%) | 10/10 (100.0%) | 5/5 (100.0%) |
| non_www?           | 14/15 (93.33%) | 9/10 (90.0%)   | 5/5 (100.0%) |
| https?             | 14/15 (93.33%) | 10/10 (100.0%) | 4/5 (80.0%)  |
| enforces_https?    | 10/15 (66.67%) | 8/10 (80.0%)   | 2/5 (40.0%)  |
| downgrades_https?  | 0/15 (0.0%)    | 0/10 (0.0%)    | 0/5 (0.0%)   |
| canonically_www?   | 7/15 (46.67%)  | 5/10 (50.0%)   | 2/5 (40.0%)  |
| canonically_https? | 13/15 (86.67%) | 10/10 (100.0%) | 3/5 (60.0%)  |
| hsts?              | 3/15 (20.0%)   | 1/10 (10.0%)   | 2/5 (40.0%)  |
| hsts_preload?      | 1/15 (6.67%)   | 0/10 (0.0%)    | 1/5 (20.0%)  |
| sitemap?           | 8/15 (53.33%)  | 5/10 (50.0%)   | 3/5 (60.0%)  |
| robots_txt?        | 11/15 (73.33%) | 7/10 (70.0%)   | 4/5 (80.0%)  |
| humans_txt?        | 1/15 (6.67%)   | 0/10 (0.0%)    | 1/5 (20.0%)  |
| proper_404s?       | 13/15 (86.67%) | 9/10 (90.0%)   | 4/5 (80.0%)  |
| dnssec?            | 4/15 (26.67%)  | 2/10 (20.0%)   | 2/5 (40.0%)  |
| ipv6?              | 8/15 (53.33%)  | 6/10 (60.0%)   | 2/5 (40.0%)  |
| google_apps?       | 2/15 (13.33%)  | 1/10 (10.0%)   | 1/5 (20.0%)  |
| open_source?       | 6/15 (40.0%)   | 5/10 (50.0%)   | 1/5 (20.0%)  |

## How the data is gathered

[Site Inspector](https://github.com/benbalter/site-inspector).

## Is it accurate?

Your guess is as good as mine. Use at your own peril.
