clear;
load Males;
ThetaCost = zeros(36,2);
thetaMin = 1;
thetaMax = 85;
index = 1;
for theta = thetaMin:thetaMax
   
    %Step 1: Find robust freezers after acq
    I = find(PstAcqFrz >= theta);
    CandidateSub = Subject(I);
    CandidateAcq = PstAcqFrz(I);
    CandidateExt = PstExtFrz(I);
    
    %Step 2a: Find high extinguishers
    HEExt=zeros(10,1);
    HEAcq=zeros(10,1);
    HESub=zeros(10,1);
    for x = 1:10
        [HEExt(x,1),I] = min(CandidateExt);
        HESub(x,1)=CandidateSub(I);
        HEAcq(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    %Step 2b: Find low extinguishers
    LEExt=zeros(10,1);
    LEAcq=zeros(10,1);
    LESub=zeros(10,1);
    for x = 1:10
        [LEExt(x,1),I] = max(CandidateExt);
        LESub(x,1)=CandidateSub(I);
        LEAcq(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    %Calculate group means
    LEExtMean = mean(LEExt);
    LEAcqMean = mean(LEAcq);
    HEExtMean = mean(HEExt);
    HEAcqMean = mean(HEAcq);

    %Calculate cost
    J = (1+(LEAcqMean-HEAcqMean)^2)/(LEExtMean-HEExtMean)^2;

    %Save cost for theta
    ThetaCost(index,1) = theta;
    ThetaCost(index,2) = J;
    
    index = index+1;
end

subplot(2,2,1)
plot (ThetaCost(:,1),ThetaCost(:,2));
xlabel('Cutoff requirement for post-acquisition freezing (%)')
ylabel('Classification cost')
title('Males')

%Two-step procedure for final theta
%Step 1: Find robust freezers after acq
    [cost, index] = min(ThetaCost(:,2));
    theta = (ThetaCost(index,1));
    I = find(PstAcqFrz >= theta);
    CandidateSub = Subject(I);
    CandidateAcq = PstAcqFrz(I);
    CandidateExt = PstExtFrz(I);
    
    %Step 2a: Find high extinguishers
    HEExtMales=zeros(10,1);
    HEAcqMales=zeros(10,1);
    HEMales=zeros(10,1);
    for x = 1:10
        [HEExtMales(x,1),I] = min(CandidateExt);
        HEMales(x,1)=CandidateSub(I);
        HEAcqMales(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    %Step 2b: Find low extinguishers
    LEExtMales=zeros(10,1);
    LEAcqMales=zeros(10,1);
    LEMales=zeros(10,1);
    for x = 1:10
        [LEExtMales(x,1),I] = max(CandidateExt);
        LEMales(x,1)=CandidateSub(I);
        LEAcqMales(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    
load Females;
ThetaCost = zeros(36,2);
thetaMin = 1;
thetaMax = 85;
index = 1;
for theta = thetaMin:thetaMax
   
    %Step 1: Find robust freezers after acq
    I = find(PstAcqFrz >= theta);
    CandidateSub = Subject(I);
    CandidateAcq = PstAcqFrz(I);
    CandidateExt = PstExtFrz(I);
    
    %Step 2a: Find high extinguishers
    HEExt=zeros(10,1);
    HEAcq=zeros(10,1);
    HESub=zeros(10,1);
    for x = 1:10
        [HEExt(x,1),I] = min(CandidateExt);
        HESub(x,1)=CandidateSub(I);
        HEAcq(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    %Step 2b: Find low extinguishers
    LEExt=zeros(10,1);
    LEAcq=zeros(10,1);
    LESub=zeros(10,1);
    for x = 1:10
        [LEExt(x,1),I] = max(CandidateExt);
        LESub(x,1)=CandidateSub(I);
        LEAcq(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    %Calculate group means
    LEExtMean = mean(LEExt);
    LEAcqMean = mean(LEAcq);
    HEExtMean = mean(HEExt);
    HEAcqMean = mean(HEAcq);

    %Calculate cost
    J = (1+(LEAcqMean-HEAcqMean)^2)/(LEExtMean-HEExtMean)^2;

    %Save cost for theta
    ThetaCost(index,1) = theta;
    ThetaCost(index,2) = J;
    
    index = index+1;
end

subplot(2,2,3)
plot (ThetaCost(:,1),ThetaCost(:,2));
xlabel('Cutoff requirement for post-acquisition freezing (%)')
ylabel('Classification cost')
title('Females')

%Two-step procedure for final theta
%Step 1: Find robust freezers after acq
    [cost, index] = min(ThetaCost(:,2));
    theta = (ThetaCost(index,1));
    I = find(PstAcqFrz >= theta);
    CandidateSub = Subject(I);
    CandidateAcq = PstAcqFrz(I);
    CandidateExt = PstExtFrz(I);
    
    %Step 2a: Find high extinguishers
    HEExtFemales=zeros(10,1);
    HEAcqFemales=zeros(10,1);
    HEFemales=zeros(10,1);
    for x = 1:10
        [HEExtFemales(x,1),I] = min(CandidateExt);
        HEFemales(x,1)=CandidateSub(I);
        HEAcqFemales(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end
    %Step 2b: Find low extinguishers
    LEExtFemales=zeros(10,1);
    LEAcqFemales=zeros(10,1);
    LEFemales=zeros(10,1);
    for x = 1:10
        [LEExtFemales(x,1),I] = max(CandidateExt);
        LEFemales(x,1)=CandidateSub(I);
        LEAcqFemales(x,1)=CandidateAcq(I);
        CandidateExt(I)=NaN;
    end

