# AoC2024
The codes for AoC20204

## Day 1
There are no codes for Day 1 since I did it with Excel. If you know how to sort and sum up in Excel, you're good to go with both parts!

## Day 2
Two functions might be required! The First One (Part 1) would be to check the rules, and the Second One (Part 2) is to test if the ones that failed in Part 1 can be fixed.

## Day 3
How to use regular expressions. That's one reason why Perl is still my go-to language for such problems.
The only "smart" part I made was splitting strings by the RE matches in a certain way, which makes the sum up straightforward.

## Day 4
It's not the best code I ever did. One mistake I made was wrongfully thinking `=~/MAS/g` + `=~/SAM/g` would be equivalent to `=~/SAM|MAS/g`, which turned out to be a total of ~2h debugging until I realize that they're not same (Maybe I should've asked ChatGPT first instead). The `=~/SAM|MAS/g` would only return one match for a palindrome sequence (such as MASAM or SAMAS etc.), whereas you would get two matches if you did it the first way. Lessons are learned.

## Day 5
The recursive function would be your best friend for part 2. My part 2 code is essentially a copy of part 1 with one more function to adjust the order by swapping trouble variable pairs that break the rules. Although I thought the second part could potentially order items while working on part 1, I didn't think hard enough to functionalize it, so I wrapped that in part 2.

## Day 6
Why Python? Because the puzzle reminds me of the maze_gen script I wrote earlier this year, which is Python. One similar/analog thing of the puzzle is the Honkai: Starrail pathfinder mini-puzzle. Thus, I decided to use my gaming mind to write the codes for potential game use. This time a Player class was used, and basic class Player functions were included. You will also need a collision-detecting function. Nothing fancy here. I also noticed that my code for part 2 ran quite a long time up to several minutes. I'll keep looking if there are smart ways to skip running the real simulation shortcuts to downsize the running time.

## Day 7
Maybe seven days is enough for me!
