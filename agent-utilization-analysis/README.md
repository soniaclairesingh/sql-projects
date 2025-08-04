# Agent Utilization Analysis

## Problem space
Determine which agents resolve the fewest tickets (vs. peers) during shifts to optimize workload distribution.

## Solution
- Join agent schedules with ticket resolution data  
- Count tickets per agent per day  
- Tabulate average tickets resolved per agent  
- Highlight agents resolving <50% of average tickets
- Outcome: one agent was being underutilized and can now be helped by the workforce manager.

## Tools
- SQL (CTEs, JOIN, GROUP BY, aggregate, CASE)
- CSV datasets for shifts and tickets
- DB Browser for SQLite (manual data upload)

## Description
Using a simulated operations dataset, this basic SQL query is designed to join agent schedules with ticket resolution data, calculate average ticket loads per agent per day and identify staff who were underutilized (handling less than 50% of the average) - so that they can be re-trained. 
-Such analytics can help workforce managers make decisions reg. staffing, training, and task allocation.
