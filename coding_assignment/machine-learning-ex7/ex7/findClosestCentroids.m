function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

mx = size(X,1);
% You need to return the following variables correctly.
idx = zeros(mx, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

% fprintf('[PB] centroids size (%d, %d) \n', size(centroids, 1), size(centroids, 2) );

% fprintf('[PB] X size (%d, %d) \n', size(X,1), size(X,2) );
vecVal = zeros(1, K);
for i = 1:mx
    for j = 1:K
        y = X(i,:) - centroids(j,:);
        vecVal(j) = sum(y .^ 2);
    end
    [val, in] = min(vecVal);
    idx(i) = in;
    % fprintf('[PB] closest found val, id (%d, %d) \n', val, in );
end



% =============================================================

end

