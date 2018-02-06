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

I = eye(num_labels);
Y = zeros(m, num_labels);  % 5000 x 10
%disp(size(y)); % 5000 x 1
for i = 1:m
    Y(i,:) = I(y(i),:);
end

% feed forward
a1 = [ones(m, 1) X];
z2 = a1 * Theta1';                                               %'
%disp(size(a1));      % 5000(data) x 401(feature)
%disp(size(Theta1));  % 25 x 401
%disp(size(z2));      % 5000 x 25
a2 = [ones(size(z2, 1), 1) sigmoid(z2)]; % 5000 x 26
%disp(size(Theta2));  % 10 x 26
z3 = a2 * Theta2';                                               %'
a3 = sigmoid(z3);
h = a3;
%disp(size(h));       % 5000 x 10 

% calculate penalty (Regularization)
Theta1Reg = Theta1(:, 2:end);
Theta2Reg = Theta2(:, 2:end);
reg = (lambda/(2*m)) * (sum(sum(Theta1Reg.^2))+ sum(sum(Theta2Reg.^2)));

% calculate J
j1 = sum(sum((-Y) .* log(h) - (1-Y) .* log(1-h), 2)) / m;
% disp(size(j1))
% with regularization
J = j1 + reg;

%%%%%%%%%%%%%%%%%%%%%
%%%% back propagation
%%%%%%%%%%%%%%%%%%%%%
% calculate sigmas
sigma3 = a3 - Y;  % 5000 x 10
z2_1 = [ones(size(z2, 1), 1) z2];
    % Theta2 size = 10 x 26
    % hidden layer l = 2
sigma2 = (sigma3 * Theta2) .* sigmoidGradient(z2_1);  % 5000 x 26
sigma2 = sigma2(:, 2:end); % 5000 x 25

% accumulate gradients
delta_1 = sigma2' * a1;                             %' 
delta_2 = sigma3' * a2;                             %'

% calculate gradient
Theta1_grad_withoutReg = delta_1 ./ m;
Theta2_grad_withoutReg = delta_2 ./ m;

% calculate regularized
p1 = (lambda/m) * [zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
p2 = (lambda/m) * [zeros(size(Theta2, 1), 1) Theta2(:, 2:end)];

% final grad
Theta1_grad = Theta1_grad_withoutReg + p1;
Theta2_grad = Theta2_grad_withoutReg + p2;

%disp(size(Theta1_grad));
%disp(size(Theta2_grad));

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];
%disp(size(grad));

end
