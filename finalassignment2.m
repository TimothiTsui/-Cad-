%第二大题
clear all;
%变量定义
M=0.5;m=0.2;b=0.1;l=0.3;I=0.006;g=9.8;

%建立模型
A=[0 1 0 0;
    0 ((-(I+m*l^2)*b)/(I*(M+m)+M*m*l^2)) ((m^2*g*l^2)/(I*(M+m)+M*m*l^2)) 0;
    0 0 0 1;
    0 ((-m*l*b)/(I*(M+m)+M*m*l^2)) (((m*l*g)*(m+M))/(I*(M+m)+M*m*l^2)) 0];
B=[0;
    ((I+m*l^2)/(I*(M+m)+M*m*l^2));
    0;
    ((m*l)/(I*(M+m)+M*m*l^2))];
C=[1 0 0 0;0 0 1 0];
D=[0;0];

rc=rank(ctrb(A,B))
ro=rank(obsv(A,C))

n=length(A);
if rc==n
    disp('controllable')
else
    disp('uncontrollable');
end

J=[-1 -2 -1+i -1-i];
K=place(A,B,J)

sim('simu_ass2');
plot(simout);