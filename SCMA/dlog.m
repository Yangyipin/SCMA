function [answer]=dlog(Qv)
%对数似然比
hpy=log((Qv(1)+Qv(2))/(Qv(3)+Qv(4)));
hpy1=log((Qv(1)+Qv(3))/(Qv(2)+Qv(4)));  
if hpy >= 0 && hpy1 >= 0
        answer=-1.000000000000000 - 1.000000000000000i;
end
if hpy >= 0 && hpy1 < 0
        answer=-1.000000000000000 + 1.000000000000000i;
end
if hpy < 0 && hpy1 >= 0
        answer= 1.000000000000000 - 1.000000000000000i;
end
if hpy < 0 && hpy1 < 0
        answer= 1.000000000000000 + 1.000000000000000i; 
end
 
end
