%Breeders

%This is the program to run to determine breeding pairs for the next
%generation.

%Should only be performed once candidate breeders have been
%determined and placed in the file SubjectInfo.

%Should only be performed after 'FamilyTree' is run to create the
%ColonyBioGraph object.

%Requires helper function 'FindMates'


load SubjectInfo;
load ColonyBioGraph;

%Candidate males along rows, females along columns
HEIndices=find(Line==1);
RBIndices=find(Line==0);
LEIndices=find(Line==-1);
MaleIndices=find(Sex==1);
FemaleIndices=find(Sex==0);
HEMales = Subject(intersect(MaleIndices,HEIndices));
HEFemales = Subject(intersect(FemaleIndices,HEIndices));
HERelations = zeros(size(HEMales,1),size(HEFemales,1));
for m = 1:size(HEMales)
    for n = 1:size(HEFemales)
        HERelations(m,n) = shortestpath(ColonyBioGraph,find(Subject==HEMales(m)),find(Subject==HEFemales(n)));
    end
end

LEMales = Subject(intersect(MaleIndices,LEIndices));
LEFemales = Subject(intersect(FemaleIndices,LEIndices));
LERelations = zeros(size(LEMales,1),size(LEFemales,1));
for m = 1:size(LEMales)
    for n = 1:size(LEFemales)
        LERelations(m,n) = shortestpath(ColonyBioGraph,find(Subject==LEMales(m)),find(Subject==LEFemales(n)));
    end
end

RBMales = Subject(intersect(MaleIndices,RBIndices));
RBFemales = Subject(intersect(FemaleIndices,RBIndices));
RBRelations = zeros(size(RBMales,1),size(RBFemales,1));
for m = 1:size(RBMales)
    for n = 1:size(RBFemales)
        RBRelations(m,n) = shortestpath(ColonyBioGraph,find(Subject==RBMales(m)),find(Subject==RBFemales(n)));
    end
end

%Find most distant relations for mating
LESuggestedPairs = FindMates(LEMales,LEFemales,LERelations);
RBSuggestedPairs = FindMates(RBMales,RBFemales,RBRelations);
HESuggestedPairs = FindMates(HEMales,HEFemales,HERelations);
