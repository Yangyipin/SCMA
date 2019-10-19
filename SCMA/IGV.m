function [data1]=IGV(signum,fab,c,Xmode_r,Ivg1,Ivg2,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6)
%此函数用于生成Ig到v的乘值求和 
%%signum表示传输数据的第几个数据，fab表示第几个子载波，c表示第几个用户从而做出有利于后续计算的函数，Xmode_r表示传输的数据
 ab=1;
 Adata=f(signum,Xmode_r,fab,c,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
for codem=1:4
     Igv3(codem)=0;
    for m2=1:4
        for m3=1:4
    ls(ab)=Adata(ab)*Ivg1(m2)*Ivg2(m3);
     Igv3(codem)= Igv3(codem)+ls(ab);%相乘求和
    ab=ab+1;
        end
    end
 
end

data1=Igv3;
end



