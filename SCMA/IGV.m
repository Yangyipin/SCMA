function [data1]=IGV(signum,fab,c,Xmode_r,Ivg1,Ivg2,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6)
%�˺�����������Ig��v�ĳ�ֵ��� 
%%signum��ʾ�������ݵĵڼ������ݣ�fab��ʾ�ڼ������ز���c��ʾ�ڼ����û��Ӷ����������ں�������ĺ�����Xmode_r��ʾ���������
 ab=1;
 Adata=f(signum,Xmode_r,fab,c,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
for codem=1:4
     Igv3(codem)=0;
    for m2=1:4
        for m3=1:4
    ls(ab)=Adata(ab)*Ivg1(m2)*Ivg2(m3);
     Igv3(codem)= Igv3(codem)+ls(ab);%������
    ab=ab+1;
        end
    end
 
end

data1=Igv3;
end



