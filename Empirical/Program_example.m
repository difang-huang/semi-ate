 %===================================
% (1) Birth weight
%===================================

clear,clc

load birth_data

data = psmatchdata13new;

x = [data(:,1) data(:,2) data(:,3)];
d = data(:,4);
y = data(:,6);


l = 0;
u = 1;
k1 = 3;

[beta,sd] = psrlse1(y,x,d,l,u,k1);


%===================================
% (2) Job training
%===================================

clear,clc

load job_data

data = jobdata;

x = [data(:,2) data(:,3)];
d = data(:,1);
y = data(:,10);


l = 0.02;
u = 0.98;
k1 = 3;

[beta,sd] = psrlse1(y,x,d,l,u,k1);

 

