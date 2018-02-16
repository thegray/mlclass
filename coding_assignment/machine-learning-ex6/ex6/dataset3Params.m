function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
minError = 1000;
min_i = 0;
min_j = 0;
pv = [0.01; 0.03; 0.1; 0.3; 1; 3; 10; 30];
maxloop = length(pv);
curLoop = 1;
for i = 1:maxloop
    for j = 1:maxloop
        fprintf('PBK training SVM No. %d \n', curLoop);
        C = pv(i);
        sigma = pv(j);
        model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
        predictions = svmPredict(model, Xval);
        erVal = mean(double(predictions ~= yval));
        if (erVal < minError)
            fprintf('Error smaller found with val: %d \n', erVal);
            minError = erVal;
            min_i = i;
            min_j = j;
            fprintf('Value of i,j = (%d, %d) \nC, sigma = (%d, %d) \n', i, j, pv(i), pv(j));
        endif
        fprintf('PBK end of training \n---------------------- \n\n');
        curLoop = curLoop + 1;
    end
end

fprintf('Best combi value found: \nC = %d \nsigma = %d \n', pv(min_i), pv(min_j) );
C = pv(min_i);
sigma = pv(min_j);


% =========================================================================

end
