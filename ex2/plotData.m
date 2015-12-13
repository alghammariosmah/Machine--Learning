function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

pos = find(y==0);
neg = find(y==1);

admitted = plot(X(neg,1), X(neg,2), 'k+','MarkerSize',8,'LineWidth',2)
not_admitted = plot(X(pos,1), X(pos,2), 'ko','MarkerSize',5,'LineWidth',2,'color','y')



% =========================================================================



hold off;

end
