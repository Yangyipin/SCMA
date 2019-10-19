function [X,repeat_times]=MPA(y,sigma2)
%初始化参数
X=zeros(6,2);
Lx=zeros(4,24);
Ly=zeros(4,24);
itera_max=10; %最大迭代次数
itera_count=0;
L_getx=zeros(1,4);
L_gety=zeros(3,4);
rota_angle=[1,exp(1i*2*pi/3),exp(1i*4*pi/3)];
F=[1 1 1 0 0 0;1 0 0 1 1 0;0 1 0 1 0 1;0 0 1 0 1 1];
for row_index=1:4
r=1;
for column_index=1:6
if F(row_index,column_index)==1
F(row_index,column_index)=rota_angle(r);
r=r+1;
end
end
end
global cdbook1 cdbook2
cdbook1=[0.4472+1.3416*1i,1.3416 - 0.4472*1i,-1.3416+0.4472*1i,-0.4472-1.3416*1i];
cdbook2=[1.3416+0.4472*1i,0.4472 - 1.3416*1i,-0.4472+1.3416*1i,-1.3416-0.4472*1i]; %00 10 01 11
% cdbook=[-1-1i,1-1i,-1+1i,1+1i];
c4=de2bi(0:3);% 00 10 01 11
% map=[1 1 1 0 0 0;2 0 0 1 1 0;0 2 0 2 0 1;0 0 2 0 2 2];
for k1=1:4
for k2=1:6
if F(k1,k2)~=0
Ly(k1,(k2-1)*4+1)=0.25;
Ly(k1,(k2-1)*4+2)=0.25;
Ly(k1,(k2-1)*4+3)=0.25;
Ly(k1,(k2-1)*4+4)=0.25;
end
end
end
% X_before2=zeros(1,12);
X_before1=ones(1,12);
X=X_before1-1;
%主程序

for itera_count=1:itera_max
%*******************************更新Lx*****************************
for row_index=1:4
x_loca=find(F(row_index,:)); %存放每一行非零位置，即与y有关系的x
for t=1:3
column_index=x_loca(t);
ent_k=[1 2 3];
ent_k(t)=[];
for k=1:3 %此函数换位置
L_gety(k,1)=Ly(row_index,(x_loca(k)-1)*4+1);
L_gety(k,2)=Ly(row_index,(x_loca(k)-1)*4+2);
L_gety(k,3)=Ly(row_index,(x_loca(k)-1)*4+3);
L_gety(k,4)=Ly(row_index,x_loca(k)*4);
end
%计算四个概率值,3个x有64种符号的全排列
x_map=zeros(1,3);
for x_k=1:4 %当前求得xk，对应t
x_map(t)=const_map(x_k,row_index,x_loca(t));%星座映射
for k2=1:4
x_map(ent_k(1))=const_map(k2,row_index,x_loca(ent_k(1)));%星座映射
for k3=1:4
x_map(ent_k(2))=const_map(k3,row_index,x_loca(ent_k(2)));%星座映射
x_map_rota=x_map.*rota_angle;
y_map=sum(x_map_rota);
temp=L_gety(ent_k(1),k2)*L_gety(ent_k(2),k3);
dif_y(k2,k3)=y(row_index)-y_map;
Lx_xk_temp(k2,k3)=temp*exp(-0.5/sigma2*(abs(dif_y(k2,k3)))^2);
end
end
Lx(row_index,(column_index-1)*4+x_k)=sum(sum(Lx_xk_temp));
end
%标准化normalization
lamada=1/(Lx(row_index,(column_index-1)*4+1)+Lx(row_index,(column_index-1)*4+2)+Lx(row_index,(column_index-1)*4+3)+Lx(row_index,(column_index-1)*4+4));
Lx(row_index,(column_index-1)*4+1)=lamada*Lx(row_index,(column_index-1)*4+1);
Lx(row_index,(column_index-1)*4+2)=lamada*Lx(row_index,(column_index-1)*4+2);
Lx(row_index,(column_index-1)*4+3)=lamada*Lx(row_index,(column_index-1)*4+3);
Lx(row_index,(column_index-1)*4+4)=lamada*Lx(row_index,(column_index-1)*4+4);
end
end
%***********************更新Ly****************************************
for column_index=1:6
y_loca=find(F(:,column_index))'; %加了转置 存放每一列非零位置，即与x有关系的y
for t=1:2
row_index=y_loca(t);
%计算四个概率值
for k=1:2
if k~=t
L_getx(1)=Lx(y_loca(k),(column_index-1)*4+1);
L_getx(2)=Lx(y_loca(k),(column_index-1)*4+2);
L_getx(3)=Lx(y_loca(k),(column_index-1)*4+3);
L_getx(4)=Lx(y_loca(k),(column_index*4));
end
end
for k1=1:4
Ly(row_index,(column_index-1)*4+k1)=L_getx(k1);
end
%必须进行标准化
lamada=1/(Ly(row_index,(column_index-1)*4+1)+Ly(row_index,(column_index-1)*4+2)+Ly(row_index,(column_index-1)*4+3)+Ly(row_index,(column_index-1)*4+4));
Ly(row_index,(column_index-1)*4+1)=lamada*Ly(row_index,(column_index-1)*4+1);
Ly(row_index,(column_index-1)*4+2)=lamada*Ly(row_index,(column_index-1)*4+2);
Ly(row_index,(column_index-1)*4+3)=lamada*Ly(row_index,(column_index-1)*4+3);
Ly(row_index,(column_index-1)*4+4)=lamada*Ly(row_index,(column_index-1)*4+4);
end
end
end
%***********************判断一次X***********************
for t=1:6
y_loca=find(F(:,t));
p00=Lx(y_loca(1),(t-1)*4+1)*Lx(y_loca(2),(t-1)*4+1);
p10=Lx(y_loca(1),(t-1)*4+2)*Lx(y_loca(2),(t-1)*4+2);
p01=Lx(y_loca(1),(t-1)*4+3)*Lx(y_loca(2),(t-1)*4+3);
p11=Lx(y_loca(1),(t-1)*4+4)*Lx(y_loca(2),(t-1)*4+4);
p=[p00,p10,p01,p11];
% [~,K]=max(p);
% X_judge(t,:)=c4(K,:);
X_judge_out(t,:)=[log((p10+p11)/(p01+p00)),log((p01+p11)/(p10+p00))];
end
% X=reshape(X_judge',1,12);
% if itera_count>1
% if X_before1==X
% repeat_times=itera_count;
% itera_count=itera_max;
% % end
% else if itera_count==itera_max
% repeat_times=itera_max;
% end
% end
% end
% end
repeat_times=10;
X=reshape(X_judge_out',1,12);
end