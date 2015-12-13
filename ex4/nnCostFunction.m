function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

%add bias
X=[ones(size(X,1),1),X];% adding ones to the first column in X

%Set a new y matrix, recoding the labels as vectors containing values 0 or
%1
Y=[zeros(size(y,1),num_labels)];
for i=1:size(Y,1)
	Y(i,y(i))=1; 
end 

% Part 1: Feedforward the neural network
a1 = X;
a2=sigmoid(Theta1*a1');	
a2=[ones(1,size(a2,2));a2];	% adding ones to the columns
a3=(sigmoid(Theta2*a2))';
J=(sum(sum(((-1.*Y).*log(a3))-((1-Y).*log(1-a3)),2)))/m;
J=J+((((sum(sum((Theta1(:,2:size(Theta1,2)).^2),2),1))+(sum(sum((Theta2(:,2:size(Theta2,2)).^2),2),1))))*(lambda)/(2*m));


c_delta1= zeros(size(Theta1));
c_delta2= zeros(size(Theta2));

%size(Theta1)
%size(Theta2)
for t=1:m
    %Part one:
	a1=X(t,:)';	
	%fprintf("a1 %d-%d\n",size(a1));	
	z2=Theta1*a1;
	%fprintf("z2 %d-%d\n",size(z2));	
	a2=sigmoid(z2);
	a2=[1;a2];
	%z2=[1;z2];
	%fprintf("a2 %d-%d\n",size(a2));	
	z3=Theta2*a2;
	a3=sigmoid(z3);
	%fprintf("a3 %d-%d\n",size(a3));
    
    %Part two
	delta3=a3-Y(t,:)';
	Y(t,:)';
	%fprintf("delta3 %d-%d\n",size(delta3));
    
    %Part three
	%fprintf("delta2 partial %d-%d\n",size(((Theta2)'*delta3)));%remove one theta ,bcoz its back propagation, No bias theta needed
	delta2=((Theta2(:,2:end))'*delta3).*(sigmoidGradient(z2));
	size(delta2);
	%delta2=delta2(2:end);
	%a1=a1(2:end);
	c_delta1=c_delta1+delta2*(a1)';
	c_delta2=c_delta2+delta3*(a2)';
        %break;
end
Theta1_grad=c_delta1/m;
Theta2_grad=c_delta2/m;

R_tg=Theta1_grad(:,2:end)+Theta1(:,2:end)*(lambda/m);
Theta1_grad=[Theta1_grad(:,1),R_tg];
R_tg=Theta2_grad(:,2:end)+Theta2(:,2:end)*(lambda/m);
Theta2_grad=[Theta2_grad(:,1),R_tg];













% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
