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

%Filter out Gen 5 for testing
GenIndx = find(Generation < 5);
Breeder = Breeder(GenIndx);
Father = Father(GenIndx);
Generation = Generation(GenIndx);
Line = Line(GenIndx);
Mother = Mother(GenIndx);
Sex = Sex(GenIndx);
Subject = Subject(GenIndx);

%Creat data structure for undirected graph
CMatrix = zeros(size(Subject));
NodeIDs = num2str(Subject,'%5.3f');
for i = 1:size(Subject)
    if Generation(i) > 0
        CMatrix(Subject==Mother(i),i)= 1;
        CMatrix(Subject==Father(i),i)= 1;
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
      
ColonyDirectedGraph = biograph(CMatrix,NodeIDs);
set(ColonyDirectedGraph.nodes(Line==1),'Color',[0 1 0]);
set(ColonyDirectedGraph.nodes(Line==0),'Color',[0 0 1]);
set(ColonyDirectedGraph.nodes(Line==-1),'Color',[1 0 0]);

view(ColonyDirectedGraph);

