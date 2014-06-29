Selective Breeding
============================
MATLAB code for managing a breeding colony in an artificial selection experiment for behavioral extremes
------------------------------------------------------------------------
***Requires the Bioinformatics Toolbox***

**IMPORTANT:** You must first update the genealogical database by running [FamilyTree](FamilyTree.m) before running [Breeders](Breeders.m) to determine breeding pairs for the next generation. Both functions require you to have imported the following vectors from a data table and saved them as 'SubjectInfo.mat'. To facilitate importing, maintain the data for your colony in a table where each row represents a single animal with the following column headers:
- *Subject*: Unique subject ID
- *Generation*: Integer indicating to which generation the subject belongs
- *Line*: Assumes you are breeding three lines, dummy-coded as follows:
  - -1: Low-extreme
  -  0: Randomly bred
  -  1: High-extreme
- *Sex*: Binary classification:
  - 0: Females
  - 1: Males
- *Mother*: Subject ID of mother
- *Father*: Subject ID of father
- *Breeder*: Binary classification:
  - 0: Subject does not meet criteria for breeding
  - 1: Subject does meet criteria for breeding

###Main Functions
***Must be run in sequence***

1. [FamilyTree](FamilyTree.m): Takes the above SubjectInfo data and saves a 'biograph' object that can be used to graph the family tree and compute degree of relationship between relatives.

2. [Breeders](Breeders.m): Uses the 'biograph' object created in Step 1 to optimize breeding pairs to minimize inbreeding. The algorithm computes the shortest paths between every potential male-female pair in the genealogical graph and then uses [FiindMates](FindMates.m) to select the mating pairs with the largest degrees of separation (in essence, the set of pairs that results in the longest of the shortest paths). Suggested parings are returned in the following 3-column matrices, where each row is a suggested pairing, with male in 1st column, female in 2nd column, and degree of relation in 3rd column.:
  - *LESuggestedPairs* for the low-extreme line
  - *RBSuggestedPairs* for the randomly-bred line
  - *HESuggestedPairs* for the high-extreme line

###Helper Functions
[FiindMates](FindMates.m): Used by [Breeders](Breeders.m) to find the least related male and female pairs. Returns a matrix of recommended matings for the next generation that will minimize the overall rate of inbreeding. Requires that you have constructed the following vectors and matrices before running (which is handled by the [Breeders](Breeders.m) function):
- *Males* is a (m by 1) column vector of subject ids for males.
- *Females* is a (1 by n) row vector of subject ids for females.
- *Relations* is a (m x n) matrix with the ith,jth cell corresponding to the degree of separation between ith male and jth female. Males should be represented along rows and females along columns. Returns a 3 column matrix where each row is a suggested pairing with male in 1st column, female in 2nd column, and degree of relation is in the 3rd column.