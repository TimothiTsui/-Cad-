%大作业第一题

%%清空环境变量
clear all;
close all;

%%第一小题
%此处定义K为sys1 状态空间系统为sys2 零极点系统为sys3

%sys1=K;

%状态空间模型->传递函数模型
A1=[0,1;-1,-5];
B1=[0;1];
C1=[1,0];
D1=0;
[num2,den2]=ss2tf(A1,B1,C1,D1);
sys2=tf(num2,den2);

%零极点增益模型模型->传递函数模型
z2=[];p2=[-1,-5];k2=2;
[num3,den3]=zp2tf(z2,p2,k2);
sys3=tf(num3,den3);

%反馈系统的连接
sys_a=feedback(sys2,sys3);%反馈系统连接，

%开环传递函数，
sys_open=sys_a;

%根轨迹的绘制
rlocus(sys_open);
figure(1);

%分析稳定性
[k,p]=rlocfind(sys_open);
%鼠标点击自动判断是否稳定
p=real(p);
if(p<0)
disp(['系统稳定'])
else
disp(['系统不稳定'])
end

%%第二小题

%K的值的定义
K=[10,20,30,40,50];

%求闭环传递函数
for n=1:5
    sys1=K(n);

    sys_b=series(sys1,sys_a);
    sys_close(n)=feedback(sys_b,1);%闭环传递函数,定义该数组后面备用
    str=['当K=',num2str(K(n)),'时，闭环系统传递函数为'];
    disp(str);
    sys_close
end

%%第三小题

%求闭环极点
for n=1:5
    
    close_pole=roots(sys_close(n).Denominator{1});%求闭环极点
    %判断闭环极点有无大于0的
    
    if(~isempty(find(close_pole>=0)))
        str=['当K=',num2str(K(n)),'时，系统不稳定'];
        disp(str);
    else
        str=['当K=',num2str(K(n)),'时，系统稳定'];
        disp(str);
    end
    
end

%%第四小题


figure(2);  
for n=1:5
    
    %求单位Step响应曲线
    subplot(2,3,n);
    t=0:0.01:5;
    y=step(sys_close(n));
    plot(y);
    title(['当K=',num2str(K(n)),'时，系统单位阶跃响应曲线']);
    
    %求系统阶跃响应的性能指标
    [mp(n),ess(n),ts(n)]=magicfun(sys_close(n));
    str=['当K=',num2str(K(n)),'时，系统超调量：',num2str(mp(n)),',稳态误差为：',num2str(ess(n)),',过渡过程时间为：',num2str(ts(n))];
    disp(str);

end
