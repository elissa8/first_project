clc;
clear all;
Ce=10;
R=0.5;
k=4*10^(-9);
s= 10^(-8);
Deff= 10^(-10);


N=[4 40 100 400 4000 40000];

for e =1:6
    dr=R/N(e);



    d1= (Deff)/(dr^2);
    d2= Deff/(2*dr);
    
    K=zeros(N(e)+1,N(e)+1);
    F=zeros(N(e)+1,1);
    
    C0=0;
    
    K(1,1)=-1;
    K(1,2)=1;
    K(N(e)+1,N(e)+1)=1;
    F(1,1)=0;
    F(N(e)+1,1)=Ce;
    for i = 2:N(e);
            K(i,i-1:i+1) = [d1-d2/(dr*(i-1)) -2*d1 d1+d2/(dr*(i-1))];
            F(i,1) = s;
    end
    
    U=K\F;
    
    x=0:dr:R;
    figure(e)
    hold on
    plot(x,U,'DisplayName','numerical solution')
    
    
    X= (1/4).*(s./Deff).*(x.^2-R^2)+Ce;
    plot(x,X,'DisplayName','analytical solution')
    
    title('Combine Plots')
    xlabel('r-values')
    ylabel('y-values')
    
    hold off
    % initial value of norme 1 and 2 
    L_1 =1/(N(e)+1)*(abs(U(1)-X(1)));
    L_2=(1/(N(e)+1)*(abs(U(1)-X(1)))^2);
    % storing in a matrix the error to find the maximum for Linfinity
    store = [abs(U(1)-X(1))];
    % applying the sum and concatination of matrices
    for j=2:N(e)+1
        L_1=L_1+ 1/(N(e)+1)*(abs(U(j)-X(j)));
        L_2=L_2+ (1/(N(e)+1)*(abs(U(j)-X(j)))^2);
        
        store(j)=[abs(U(j)-X(j))];
       
    end
    % displaying the norms
    Lf_1(e)=L_1
    Lf_2(e)=L_2^0.5
    Lf_3(e)=max(store)
end

dr=R./N
[]
figure(7)
hold on
loglog(dr,Lf_1,'DisplayName','L1')
loglog(dr,Lf_2,'DisplayName','L2')
loglog(dr,Lf_3,'DisplayName','L3')


% plot(log(Lf_1),log(dr),'DisplayName','L1')
% plot(log(Lf_2),log(dr),'DisplayName','L2')
% plot(log(Lf_3),log(dr),'DisplayName','L3')
title('log L vs log dr')
xlabel('log dr')
ylabel('log L')
hold off