clear all;close all;clc
N=4;H=zeros(N,N);HV=zeros(N,N);
NV=500;dV=1/NV;
T=50;dt=0.01;et=fix(T/dt);
Pro_Q_T=zeros(NV,et,2);
V([1:NV],1)=-50+100*[1:NV]*dV;
J=1;J0=20;
L=0;
for alpha=[10,20]
    L=L+1;


instate=zeros(N,1);Time=zeros(et,1);
Time(:,1)=[1:et]*dt;

for ii=1:1
    instate(ii,1)=1;
end
for v=1:NV
    H(1,2)=J;H(2,3)=J0;H(3,4)=J;
    H(2,1)=J;H(3,2)=J0;H(4,3)=J;
    H(2,2)=alpha;H(3,3)=-alpha;
    H(1,1)=V(v,1);
    H(4,4)=V(v,1);

U1=expm(-1i*H*dt);
WFTn1=zeros(N,et);
WFTn1(:,1)=instate(:,1);
for t=1:et
   WFTn1(:,t+1)=U1*WFTn1(:,t);
end
    Pro_Q_T(v,1:et,L)=abs(WFTn1(N,1:et)).^2;
end
end


figure('color','w','position',[400,20,600,600]);
surf(Time,V,Pro_Q_T(:,:,1))
shading interp
grid off
xlabel('$t$','Fontsize',30,'Interpreter','LaTex')
ylabel('$V$','Fontsize',30,'Interpreter','LaTex')
view(0,90)