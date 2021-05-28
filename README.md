# Overview
In a multiplayer game of Civilization 6 (Civ 6), it is hard to determine any place besides 1st. The default ranking of Civ 6 is using the score calculation. This tends to be an average of the player's contribution to the game, but not an accurate representation of how well one player did against another. 

**ZX Multiplayer Ranker** adds to the World Rankings Side panel to show an overall 1st, 2nd, 3rd, etc ranking for the players. As well as adding a new window to the End Game Menu showing the final rankings and it's calculation.

# Ranking System
There are five primary victory conditions in Civ 6 and it's expansions:
* Science
* Culture
* Domination
* Religion
* Diplomacy

The game provides us an easy ordering for each of these victory types within their own context. To create an overall ranking system we can assign Rank Points (RPs) to each place of the victory track. First Place is awarded N-2 RPs where N is the number of players in the game. 2nd N-3, 3rd N-4, and so on until 0 points are awarded. For example in a 6 player game, the domination the RPs spread would be:

| Place | Awarded RPS |
|:-----:|:-----------:|
|**1st**|4 rps|
|**2nd**|3 rps|
|**3rd**|2 rps|
|**4th**|1 rps|
|**5th**|0 rps|
|**6th**|0 rps|

## Ties
Civ 6 has both primary and secondary sorting for each victory type to determine the player order:

| Victory Type | Primary | Secondary |
|--------------|---------|-----------|
| Science | space milestones | number of researches |
| Culture | number of tourists | tourism/culture income | 
| Domination | capitals owned | military strength |
| Religion | civs converted | cities converted/faith income |
| Diplomacy | diplomatic points | none |

This system uses only the primary sort value for determining rank. A tie is broken by the player that reached the current level first. If both players reached the level on the same turn, then they would split the points. For example if two players, in a six player game, both researched rocketry on the same turn and they are tied for 1st they would each get 3.5 rps.
```
(  1st  +  2nd  ) / 2
( 4 rps + 3 rps ) / 2 == 3.5 rps
```

## Qualifying
According to the game everyone is ranked all the time for each victory condition. This does not indicate if a player is putting effort into winning via that victory type. In order to sufficiently rank players they must be considered as "attempting the victory type". To qualify for a victory type each path has a minimum bar to be reached. Once a player has qualified for a victory type, they cannot become unqualified.

* Science - Complete one objective of the first Space Milestone
  * Research Rocketry
  * Build a Spaceport
  * Launch an Earth Satellite
* Culture - Recruit one foreign tourist
* Domination - Capture one foreign capitol
* Religion - Convert one foreign civilization
* Diplomacy - Earn 12 diplomatic points

# Summary
This is a personal system around my play group and our desire to create a "League" that includes multiple games. With this Rank Point system we have value in fighting for 2nd, 3rd, etc even if we can no longer win. This is valuable to us due to the amount of time it takes to not only schedule full multiplayer games, but also the amount of time it takes to win.

If anyone else finds this mod and enjoys it, that is a huge win. :smile: