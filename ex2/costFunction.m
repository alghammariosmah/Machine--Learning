function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));%the result has to be(3,1) matrix

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
%grad = 
%   -0.1000
%  -12.0092
%  -11.2628
% Note: grad should have the same dimensions as theta
%
sigmoidFunction = sigmoid(X*theta); % We have already defined a function sigmoid
J = (1/m)*sum(-y.*log(sigmoidFunction) - (1-y).*log(1-sigmoidFunction)); %logistic regression cost function
%J = ((-1/m).* (sum( y .* log(sigmoidFunction ) + (1 - y).* log(1 - sigmoidFunction ))));
tempValue= grad;

for iter=1:length(y)% Just like my previous implementation for gradient descent multi
    Jtheta= (sigmoidFunction-y);
    for i = 1: length(theta)
        tempValue(i,1) = sum(Jtheta.*X(:,i));
    end
    grad = (1/m)*tempValue;
end 

%another implementation
%tempValue = (sigmoidFunction-y); %gradient of the cost function
%Tempgrad = tempValue;
% for i=1:length(theta)
%     for j = 1:length(y)
%         Tempgrad(j,1) = tempValue(j)*X(j,i); % j for samples and i for features +1
%     end 
%     grad(i) = (1/m)*sum(Tempgrad);
% end 


end
