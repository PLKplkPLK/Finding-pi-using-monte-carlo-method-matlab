clear;clc;close all;
rng(2^32-1); %or: sum(100*clock), 'default'
%number of points:
N=1e5;
%matrix with 10 different executions of algorithm
wpi=zeros(N,10);


%Add black circle onto the plot
kx=0:0.01:1;
ky=sqrt(1-kx.*kx);
hold on,subplot(2,3,1),plot(kx,ky,'black')

%evaluation of pi and creation of the 1,2 plots
hold on;
for j=1:10
    x=rand(N,1);
    y=rand(N,1);
    count=0;
    for i=1:N
        %counting how many points are inside circle
        if x(i)*x(i)+y(i)*y(i)<=1
            count=count+1;
        end
        %condition so that we won't plot one million points
        if i<200
            if x(i)*x(i)+y(i)*y(i)<=1
                hold on,subplot(2,3,1),plot(x(i),y(i),'g.','MarkerSize',5);
            else
                hold on,subplot(2,3,1),plot(x(i),y(i),'r.','MarkerSize',5);
            end
        end
        wpi(i,j)=count*4/i;
    end
    %plot 2
    hold on,subplot(2,3,[2,3]),plot(linspace(1,N,N),wpi(:,j),'b'),ylim([2.78, 3.5]);
end
%plot 1 additions
subplot(231),pbaspect([1, 1, 1])
subplot(231),title('Random points')
subplot(231),xlabel('X')
subplot(231),ylabel('Y')
%plot 2 additions
subplot(2,3,[2,3]),xlabel('Consecutive points')
subplot(2,3,[2,3]),ylabel('Pi estimation')
pi_final=mean(wpi(N,:));
subplot(2,3,[2,3]),title(sprintf('Estimated pi: %f, after %d draws. Error: %f', pi_final, N,abs(pi-pi_final)))
hold on, subplot(2,3,[2,3]),yline(pi,'r','LineWidth',2);


%boxplots
subplot(2,3,4),boxplot(wpi(1:100,:),'symbol','');
subplot(2,3,5),boxplot(wpi(1:1000,:),'symbol','');
subplot(2,3,6),boxplot(wpi,'symbol','');

%boxplots additions
hold on,subplot(234),yline(pi)
hold on,subplot(235),yline(pi)
hold on,subplot(236),yline(pi)
subplot(234),ylim([2.1,4.1])
subplot(235),ylim([2.1,4.1])
subplot(236),ylim([2.1,4.1])
subplot(234),title('100 draws')
subplot(234),xlabel('Estimated pi')
subplot(234),ylabel('Series')
subplot(235),title('1000 draws')
subplot(235),xlabel('Estimated pi')
subplot(235),ylabel('Series')
subplot(236),title(sprintf('%d draws', N))
subplot(236),xlabel('Estimated pi')
subplot(236),ylabel('Series')