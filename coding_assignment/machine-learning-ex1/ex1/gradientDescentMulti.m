function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

n = size(X,2);
x2 = X(:,2);
x3 = X(:,3);


for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCostMulti) and gradient here.
    %
    
    %theta_prev = theta;
    %for j = 1:n
    %    deriv = ((X*theta_prev - y)' * X(:, j))/m;
    %    theta(j) = theta_prev(j)-(alpha*deriv);
    %end
    
    %--------------
    %
    h = X * theta;
    errors = h - y;
    theta = theta - ((alpha/m) * (X' * errors));
    
    
    %--------------
    %  
    %h = X * theta;
    %d = h - y;
    
    %temp_0 = theta(1) - (alpha * sum(d) / m );
    %temp_1 = theta(2) - (alpha * sum(d .* x2) / m );
    %temp_2 = theta(3) - (alpha * sum(d .* x3) / m );
    
    %theta(1) = temp_0;
    %theta(2) = temp_1;
    %theta(3) = temp_2;

    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCostMulti(X, y, theta);

end

end
