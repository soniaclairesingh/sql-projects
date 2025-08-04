/* CTE1 - Count how many tickets each agent resolved on each date*/
WITH tkts_per_agent AS (
  SELECT
    s.agent_id,                                        /*Select agent's ID and date*/
    s.date,
    COUNT(t.ticket_id) AS tickets_handled              /*Count tickets resolved by this agent on date*/
  FROM agent_schedule s
  LEFT JOIN ticket_volume t                            /*LEFT JOIN to include agents even if zero tickets*/
    ON s.agent_id = t.resolved_by AND s.date = t.date  /*Join on agent ID and date to match tickets*/
  GROUP BY s.agent_id, s.date                          /*Group by agent and date to aggregate ticket counts*/
),

/*CTE2 - Calculate average tickets handled per agent for each date*/
avg_tickets AS (
  SELECT
    date,
    ROUND(AVG(tickets_handled),2) AS avg_tkts_per_agent         /*Average tickets per agent on date*/
  FROM tkts_per_agent
  GROUP BY date                                        /*Group by date to get daily averages*/
)

/*FINAL SELECT - Combine ticket counts with averages and classify*/
SELECT
  tpa.agent_id,
  tpa.date,
  tpa.tickets_handled,
  at.avg_tkts_per_agent,
  CASE
    WHEN tpa.tickets_handled < 0.5 * at.avg_tkts_per_agent THEN 'Underutil'
    ELSE 'Adequately util'
  END AS utilization_status                             /*Flag agents handling <50% of avg*/
FROM tkts_per_agent tpa
JOIN avg_tickets at ON tpa.date = at.date               /*Join to get average tickets for each date*/
ORDER BY tpa.date, tpa.agent_id;                        /*Order results by date then agent*/
