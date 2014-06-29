Selective Breeding
============================
MATLAB code for managing a breeding colony in an artificial selection experiment for behavioral extremes
------------------------------------------------------------------------

You must first update the genealogical database by running [FamilyTree](FamilyTree.m) before running [Breeders](Breeders.m) to determine breeding pairs for the next generation:

1. [FamilyTree](FamilyTree.m): Contains MATLAB code that takes a table where each row is a tuple of offspring ID, motherID, and fatherID, and creates a 'biograph' object that can be used to graph the family tree and compute degree of relationship between relatives.

2. [Breeders](Breeders.m): Requires that you have imported the following vectors from a data table and saved them as 'SubjectInfo.mat':
- *Subjects*: Subject IDs of your candidate breeders
- *Line*: Assumes you are breeding three lines, dummy-coded as follows:
  - -1: Low-extreme
  -  0: Randomly bred
  -  1: High-extreme
- *Sex*:
  - 0: Females
  - 1: Males
Optimal breeding pairs to minimize inbreeding are determined by computing the shortest paths between every potential male-female pair in the genealogical graph and then selecting mating pairs with the largest degrees of separation (in essence, the set of pairs that results in the longest of the shortest paths). Suggested parings are returned in the following (m X 2) matrices:
- *LESuggestedPairs* for the low-extreme line
- *RBSuggestedPairs* for the randomly-bred line
- *HESuggestedPairs* for the high-extreme line

###Helper Functions
[FiindMates](FindMates.m): Used by [Breeders](Breeders.m) to find the least related male and female pairs. Returns a matrix of recommended matings for the next generation that will minimize the overall rate of inbreeding. Requires that you have constructed the following vectors and matrices before running:
- *Males* is a (m by 1) column vector of subject ids for males.
- *Females* is a (1 by n) row vector of subject ids for females.
- *Relations* is a (m x n) matrix with the ith,jth cell corresponding to the degree of separation between ith male and jth female. Males should be represented along rows and females along columns. Returns a 3 column matrix where each row is a suggested pairing with male in 1st column, female in 2nd column, and degree of relation is in the 3rd column.