function [ SuggestedPairs ] = FindMates( Males,Females,Relations )
%FindMates Find least related male and female pairs
%   Males is a (m by 1) column vector of subject ids for males.
%   Females is a (1 by n) row vector of subject ids for females.
%   Relations is a (m x n) matrix with the ith,jth cell corresponding to
%   the degree of separation between ith male and jth female. Males should
%   be represented along rows and females along columns. Returns a 3 column
%   matrix where each row is a suggested pairing with male in 1st column,
%   female in 2nd column, and degree of relation is in the 3rd column.

SuggestedPairs = zeros(max(size(Males,1),size(Females,1)),3);
i = 1;

%Complicated code to achieve simple desire to sort Relations matrix such
%that males with the fewest mating options go to the top and females with
%the fewest mating options go to the left. Insures that these animals get
%first choice of mate in the algortihm that follows.
rowsums = sum(Relations,2); %higher row sums = better options for males
temp = cat(2,rowsums,Males,Relations); %concatenate sums, subjects, and relations together before sorting
temp = sortrows(temp); %sort males by breeding options
Males = temp(:,2); %set Males equal to sort
Relations = temp(:,3:end); %set Relations equal to sort
colsums = sum(Relations,1);  %higher column sums = better options for females
temp = cat(1,colsums,Females,Relations); %concatenate sums, subjects, and relations together before sorting
temp = (sortrows(temp.'))'; %transpose concatenated matrix to use sortrows because there is no function to sort columns!
Females = temp(2,:);%set Females equal to sort
Relations = temp(3:end,:); %set Relations equal to sort

while ~isempty(Males) && ~isempty(Females)
    [Degree,FemaleIndex] = max(Relations(1,:));
    SuggestedPairs(i,1) = Males(1);
    SuggestedPairs(i,2) = Females(FemaleIndex);
    SuggestedPairs(i,3) = Degree;
    Males(1)=[];
    Females(FemaleIndex)=[];
    Relations(1,:)=[];
    Relations(:,FemaleIndex)=[];
    i=i+1;
end
%Clean up any leftover males or females
while ~isempty(Males)
    SuggestedPairs(i,1) = Males(1);
    Males(1)=[];
    Relations(1,:)=[];
    i = i+1;
end
while ~isempty(Females)
    SuggestedPairs(i,2) = Females(1);
    Females(1)=[];
    Relations(:,1)=[];
    i = i+1;
end
end

