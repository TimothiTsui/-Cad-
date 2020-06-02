%����ҵ��һ��

%%��ջ�������
clear all;
close all;

%%��һС��
%�˴�����KΪsys1 ״̬�ռ�ϵͳΪsys2 �㼫��ϵͳΪsys3

%sys1=K;

%״̬�ռ�ģ��->���ݺ���ģ��
A1=[0,1;-1,-5];
B1=[0;1];
C1=[1,0];
D1=0;
[num2,den2]=ss2tf(A1,B1,C1,D1);
sys2=tf(num2,den2);

%�㼫������ģ��ģ��->���ݺ���ģ��
z2=[];p2=[-1,-5];k2=2;
[num3,den3]=zp2tf(z2,p2,k2);
sys3=tf(num3,den3);

%����ϵͳ������
sys_a=feedback(sys2,sys3,1);%����ϵͳ���ӣ�

%�������ݺ�����
sys_open=sys_a;

%���켣�Ļ���
rlocus(sys_open);
figure(1);

%�����ȶ���
[k,p]=rlocfind(sys_open);
%������Զ��ж��Ƿ��ȶ�
p=real(p);
if(p<0)
disp(['ϵͳ�ȶ�'])
else
disp(['ϵͳ���ȶ�'])
end

%%�ڶ�С��

%K��ֵ�Ķ���
K=[10,20,30,40,50];

%��ջ����ݺ���
for n=1:5
    sys1=K(n);

    sys_b=series(sys1,sys_a);
    sys_close(n)=feedback(sys_b,1);%�ջ����ݺ���,�����������汸��
    str=['��K=',num2str(K(n)),'ʱ���ջ�ϵͳ���ݺ���Ϊ'];
    disp(str);
    sys_close
end

%%����С��

%��ջ�����
for n=1:5
    
    close_pole=roots(sys_close(n).Denominator{1});%��ջ�����
    %�жϱջ��������޴���0��
    
    if(~isempty(find(close_pole>=0)))
        str=['��K=',num2str(K(n)),'ʱ��ϵͳ���ȶ�'];
        disp(str);
    else
        str=['��K=',num2str(K(n)),'ʱ��ϵͳ�ȶ�'];
        disp(str);
    end
    
end

%%����С��


figure(2);  
for n=1:5
    
    %��λStep��Ӧ����
    subplot(2,3,n);
    t=0:0.01:5;
    y=step(sys_close(n));
    plot(y);
    title(['��K=',num2str(K(n)),'ʱ��ϵͳ��λ��Ծ��Ӧ����']);
    
    %��ϵͳ��Ծ��Ӧ������ָ��
    [mp(n),ess(n),ts(n)]=magicfun(y);
    str=['��K=',num2str(K(n)),'ʱ��ϵͳ��������',num2str(mp(n)),',��̬���Ϊ��',num2str(ess(n)),',���ɹ���ʱ��Ϊ��',num2str(ts(n))];
    disp(str);

end