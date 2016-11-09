clear;
clc;
n = 100;
% Generate n points uniformly in 1 dimension
p = linspace(0.1,1,n);%(-1 + 2 * rand(1,n));

%%
% Initialization of Weighted distance matrix
for i = 1:n
    for j = 1:n
        W(i,j) = 1;%exp(-((p(i)-p(j)).^2));
        % if absolute dist > 0.5 - non-adjacent
        if (i==j || abs((p(i)-p(j)))>=0.1)
            W(i,j)=0;
        end
    end
end
D = zeros(20,20);
%D = diag(sum(d'));
%%
for i =1:n
    D(i,i)=sum(W(i,:)); % Diagonal matrix 
                        % each cell represent the sum of the corresponding
                        % W's row.
end
%Laplacian matrix
L = D - W;
% Retrieve right eigenvectors V and eigenvalues E for the fourier
% representation
[V,E] = eig(L);
%mu = (0*ones(1,));
%X = mvnrnd(mu,eye(20,20),1);
C = 1./(1-exp(p));% smooth function par rapport aux points p
%smooth signal
%X = exp(-((C).^(2)));
%C = exp(-C);
% put the eigenvalues in a row vector
E = sum(E);
% apply the transform to our signal
X1 = V'*C';
% add random noise to original signal
 r = 5*(2*rand(1,n))-1;
 X2 = V'*(C+r)';

figure,
plot(E,X1.^2,'linewidth',1.5);
ylabel('h(e)')
xlabel('e eigenvalues');
hold on
plot(E,X2.^2,'linewidth',1.5,'color','r');
% figure,
% plot(E,X2,'linewidth',1.5);
% ylabel('h(e)')
% xlabel('e eigenvalues');