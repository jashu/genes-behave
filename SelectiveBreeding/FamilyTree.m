load SubjectInfo

%Filter out non-breeders
BreederIndx = find(Breeder == 1);
Breeder = Breeder(BreederIndx);
Father = Father(BreederIndx);
Generation = Generation(BreederIndx);
Line = Line(BreederIndx);
Mother = Mother(BreederIndx);
Sex = Sex(BreederIndx);
Subject = Subject(BreederIndx);

%Create data structure for directed graph
CMatrix = zeros(size(Subject));
NodeIDs = num2str(Subject,'%5.3f');
for i = 1:size(Subject)
    if Generation(i) > 0
        %Mark mother as first-degree relative
        CMatrix(Subject==Mother(i),i)= 1;
        CMatrix(i,Subject==Mother(i))= 1;
        %Mark father as first-degree relaative
        CMatrix(Subject==Father(i),i)= 1;
        CMatrix(i,Subject==Father(i))= 1;
    end 
end

%Remove lines with dead ends (infertile pairs)
i = 1;
while i <= size(CMatrix)
    if ~any(CMatrix(i,:)) && Generation(i)< max(Generation)
        Breeder(i)=[];
        Father(i)=[];
        Generation(i)=[];
        Line(i)=[];
        Mother(i)=[];
        Sex(i)=[];
        Subject(i)=[];
        CMatrix(i,:)=[];
        CMatrix(:,i)=[];
        NodeIDs(i,:)=[];
    else
        i=i+1;
    end
end
      
ColonyBioGraph = biograph(CMatrix,NodeIDs);
set(ColonyBioGraph.nodes(Line==1),'Color',[0 1 0]);
set(ColonyBioGraph.nodes(Line==0),'Color',[0 0 1]);
set(ColonyBioGraph.nodes(Line==-1),'Color',[1 0 0]);

save ColonyBioGraph;

