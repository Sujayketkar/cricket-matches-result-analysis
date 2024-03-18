CREATE TABLE matches(
team1 varchar(50),
team2 varchar(50),
match_result varchar(50)
)

select * FROM matches;


 


WITH teamScores AS (
select team,
sum( CASE WHEN match_result = team then 1 ELSE 0 END) AS wins,
sum( CASE WHEN match_result!= 'No Result' AND match_result!= team then 1 ELSE 0 END) AS Losses,
sum( CASE WHEN match_result = 'No Result' then 1 ELSE 0 END) AS no_result
FROM 
(SELECT team1 as team, match_result FROM matches
 UNION ALL
SELECT team2 as team, match_result FROM matches

) AS combined_results
GROUP BY team)

SELECT team,
COALESCE(wins,0) + COALESCE(losses,0)+ COALESCE(no_result,0) AS games_played,
COALESCE(wins,0) as wins,
COALESCE(losses,0) as losses,
COALESCE (no_result,0) as no_result,
COALESCE (wins,0)* 3 + COALESCE(no_result,0) as points
FROM teamScores
ORDER BY points DESC;


 











		   
		   
		   