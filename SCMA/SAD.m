%SCMA
clc;
clear all;
codebook1=[0,0,0,0;-0.1815-0.1318*1i,-0.6351-0.4615*1i,0.6351+0.4615*1i,0.1815+0.1318*1i;0,0,0,0;0.7851,-0.2243,0.2243,-0.7851];
codebook2=[0.7851,-0.2243,0.2243,-0.7851;0,0,0,0;-0.1815-0.1318*1i,-0.6351-0.4615*1i,0.6351+0.4615*1i,0.1815+0.1318*1i;0,0,0,0];
codebook3=[-0.6351+0.4615*1i,0.1815-0.1318*1i,-0.1815+0.1318*1i,0.6351-0.4615*1i;0.1392-0.1759*1i,0.4873-0.6156*1i,-0.4873+0.6156*1i,-0.1392+0.1759*1i;0,0,0,0;0,0,0,0];
codebook4=[0,0,0,0;0,0,0,0;0.7851,-0.2243,0.2243,-0.7851;-0.0055-0.2242*1i,-0.0193-0.7848*1i,0.0193+0.7848*1i,0.0055+0.2242*1i];
codebook5=[-0.0055-0.2242*1i,-0.0193-0.7848*1i,0.0193+0.7848*1i,0.0055+0.2242*1i;0,0,0,0;0,0,0,0;-0.6351+0.4615*1i,0.1815-0.1318*1i,-0.1815+0.1318*1i,0.6351-0.4615*1i];
codebook6=[0,0,0,0;0.7851,-0.2243,0.2243,-0.7851;0.1392-0.1759*1i,0.4873-0.6156*1i,-0.4873+0.6156*1i,-0.1392+0.1759*1i;0,0,0,0];
M=4; % modulation order 4QAM
Nfft=64; %FFT size
Ng=Nfft/4;  % Guard Interval length
Nsym=Nfft+Ng;  %Symbol duration
EbN0=[0:30:30];  % EbN0
N_iter=15; %number of iteration for each EbN0
Nframe=6; %用户数量
Nframe1=4; %子载波数量

        X=randi([0,M-1],1,Nfft*Nframe);% bit: integer vector
        X_mod=qammod(X,M); % 4QAM mapping
%SCMA编码
    for i=1:64
        scma_mod1=SCMA_coding(X_mod,codebook1,i);
        scma_mod2=SCMA_coding(X_mod,codebook2,i+64);
        scma_mod3=SCMA_coding(X_mod,codebook3,i+128);
        scma_mod4=SCMA_coding(X_mod,codebook4,i+192);
        scma_mod5=SCMA_coding(X_mod,codebook5,i+256);
        scma_mod6=SCMA_coding(X_mod,codebook6,i+320);
%四个子载波
        scma_signal1(i)=scma_mod1(1,1)+scma_mod2(1,1)+scma_mod3(1,1)+scma_mod4(1,1)+scma_mod2(1,1)+scma_mod6(1,1);
        scma_signal2(i)=scma_mod1(2,1)+scma_mod2(2,1)+scma_mod3(2,1)+scma_mod4(2,1)+scma_mod2(2,1)+scma_mod6(2,1);
        scma_signal3(i)=scma_mod1(3,1)+scma_mod2(3,1)+scma_mod3(3,1)+scma_mod4(3,1)+scma_mod2(3,1)+scma_mod6(3,1);
        scma_signal4(i)=scma_mod1(4,1)+scma_mod2(4,1)+scma_mod3(4,1)+scma_mod4(4,1)+scma_mod2(4,1)+scma_mod6(4,1);
    end         
    scma_code=[scma_signal1(1:64),scma_signal2(1:64),scma_signal3(1:64),scma_signal4(1:64)];

%SCMA解码MPA算法 
%第signum个数据
Xmode_r=scma_code;
for signum=1:64
    for i=1:4  %初始化赋值
Iv2g1(i)=0.25;Iv2g3(i)=0.25;
Iv3g1(i)=0.25;Iv4g3(i)=0.25;
Iv5g1(i)=0.25;Iv6g3(i)=0.25;
Iv1g2(i)=0.25;Iv1g4(i)=0.25;
Iv3g2(i)=0.25;Iv4g4(i)=0.25;
Iv6g2(i)=0.25;Iv5g4(i)=0.25;
apv1(i)=0.25;apv2(i)=0.25;
apv3(i)=0.25;apv4(i)=0.25;
apv5(i)=0.25;apv6(i)=0.25;
    end
for n_num=1:N_iter
Ig1v2=IGV(signum,1,1,Xmode_r,Iv3g1,Iv5g1,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig1v3=IGV(signum,1,2,Xmode_r,Iv2g1,Iv5g1,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig1v5=IGV(signum,1,3,Xmode_r,Iv2g1,Iv3g1,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6); 

Ig2v1=IGV(signum,2,1,Xmode_r,Iv3g2,Iv6g2,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig2v3=IGV(signum,2,2,Xmode_r,Iv1g2,Iv6g2,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig2v6=IGV(signum,2,3,Xmode_r,Iv1g2,Iv3g2,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);  

Ig3v2=IGV(signum,3,1,Xmode_r,Iv4g3,Iv6g3,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig3v4=IGV(signum,3,2,Xmode_r,Iv2g3,Iv6g3,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig3v6=IGV(signum,3,3,Xmode_r,Iv2g3,Iv4g3,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);  

Ig4v1=IGV(signum,4,1,Xmode_r,Iv4g4,Iv5g4,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig4v4=IGV(signum,4,2,Xmode_r,Iv1g4,Iv5g4,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);
Ig4v5=IGV(signum,4,3,Xmode_r,Iv1g4,Iv4g4,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6);    



Iv1g2=mapminmax(apv1.*Ig4v1,0.0000001,1);
Iv1g4=mapminmax(apv1.*Ig2v1,0.0000001,1);
Iv2g1=mapminmax(apv2.*Ig3v2,0.0000001,1);
Iv2g3=mapminmax(apv2.*Ig1v2,0.0000001,1);
Iv3g1=mapminmax(apv3.*Ig2v3,0.0000001,1);
Iv3g2=mapminmax(apv3.*Ig1v3,0.0000001,1);
Iv4g3=mapminmax(apv4.*Ig4v4,0.0000001,1);
Iv4g4=mapminmax(apv4.*Ig3v4,0.0000001,1);
Iv5g1=mapminmax(apv5.*Ig4v5,0.0000001,1);
Iv5g4=mapminmax(apv5.*Ig1v5,0.0000001,1);    
Iv6g2=mapminmax(apv6.*Ig3v6,0.0000001,1);
Iv6g3=mapminmax(apv6.*Ig2v6,0.0000001,1);
     
end  
Qv1=apv1.*Ig2v1.*Ig4v1;
Qv2=apv2.*Ig1v2.*Ig3v2;
Qv3=apv3.*Ig1v3.*Ig2v3;
Qv4=apv4.*Ig3v4.*Ig4v4;
Qv5=apv5.*Ig1v5.*Ig4v5;
Qv6=apv6.*Ig2v6.*Ig3v6;

answer1(signum)=dlog(Qv1);
answer2(signum)=dlog(Qv2);
answer3(signum)=dlog(Qv3);
answer4(signum)=dlog(Qv4);
answer5(signum)=dlog(Qv5);
answer6(signum)=dlog(Qv6);
    
    
    
end

scma_decode=[answer1(1:64),answer2(1:64),answer3(1:64),answer4(1:64),answer5(1:64),answer6(1:64)];
result=0
for i=1:384
        if X_mod(i) == scma_decode(i)
         result=result+1;
        end
end
result=result/384;
result=result*100;
result=strcat(num2str(result),'%')
%X_r=qamdemod(Xmode_r,M); % demodulation
% Neb=Neb+sum(sum(de2bi(X_r, 4)~=de2bi(X,4))); %compute the error bit
   
%  Ber(k)=Neb/(4*Nfft*N_iter*Nframe);




%plot the graph of Ber
%semilogy(EbN0,Ber,'-*');
%legend('Rayleigh fading');
%xlabel('EbN0[dB]');ylabel('Ber');






