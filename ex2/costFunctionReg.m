function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));


% I will need the grad and cost of logistic regression
[J, grad] = costFunction(theta, X, y);


J = J+ (lambda/(2*m)) .* (sum(theta.^2)); % penalizing the cost function, 
%J = J+((lambda/(2*m))*(sum((theta(2:size(theta,1),:).^2))));
% I need to ignore the first item since the first item shouldn't be
% regularized
grad(2:end) = grad(2:end) + (lambda/m)*(theta(2:end));% I have to take it from the second item


% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta






% =============================================================

end
