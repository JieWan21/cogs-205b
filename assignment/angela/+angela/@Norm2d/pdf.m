function yax = pdf(obj,X)
    
    sigma1 = sqrt(obj.Covariance(1)); sigma2 = sqrt(obj.Covariance(4));
    
    z = obj.standardize(X);
    
    yax = (1 / (2*pi*sigma1*sigma2*sqrt(1-obj.Correlation^2))) ...
              * exp(obj.expTerm(z));
    
end
