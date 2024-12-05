# AoC2024
The codes for AoC20204

## Day 1
There are no codes for Day 1 since I did it with Excel. If you know how to sort and sum up in Excel, you're good to go with both parts!

## Day 2
Two functions might be required! The First One (Part 1) would be to check the rules, and the Second One (Part 2) is to test if the ones that failed in Part 1 can be fixed.

## Day 3
How to use regular expressions. That's probably one reason why Perl is still my to-go language for such problems.
The only "smart" part I made was to split strings by the RE matches in a certain way, in which the summing up is straightforward.

## Day 4
It's not the best code I ever did. One mistake I made was wrongfully thinking `=~/MAS/g` + `=~/SAM/g` would be equivalent to `=~/SAM|MAS/g`, which turned out to be a total of ~2h debugging until I realize that they're not same (Maybe I should've asked ChatGPT first instead). The `=~/SAM|MAS/g` would only return one match for a palindrome sequence (such as MASAM or SAMAS etc.), whereas you would get two matches if you did it the first way. Lessons are learned.

## Day 5
The recursive function would be your best friend for part 2. My part 2 code is essentially a copy of part 1 with one more function to adjust the order by swapping trouble variables pairs that break the rules. Although I thought the 2nd part could be potentially ordering items while working on part 1, I didn't think efficient to functionize it. So I did that in part 2.

## Day 6
TBD
