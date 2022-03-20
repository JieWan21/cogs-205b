function report(strct, dir)
%report tells you the mean and the variance of your bivariate data
%   input: strct which should be structure containing X and Y. X and Y must
%   be 1D arrays of the same size. next input is dir which is the full path
%   to the desired report file in Markdown format. In the generated report
%   you can see time, date, and the statistics of your data.
check(strct)
[matrix_mean, matrix_cov] = strct2statistics(strct);
body = create_report_body(matrix_mean, matrix_cov);
write2file(body, dir);
end

function check(strct)
try
    strct.X
catch
    error('input must have .X')
end

try
    strct.Y
catch
    error('input must have .Y')
end

X_size= size(strct.X);
Y_size= size(strct.Y);

if X_size(1) ~= 1
    error ('X must be 1D')
end

if Y_size(1) ~= 1
    error ('Y must be 1D')
end

if X_size ~= Y_size
    error('X and Y must be the same size')
end

end

function [matrix_mean, matrix_cov] = strct2statistics (strct)
x = strct.X;
y = strct.Y;

matrix = [x;y];

norm2d = hojjatazimi.Norm2d.estimate(matrix);

matrix_mean = norm2d.Mean;
matrix_cov = norm2d.Covariance;
end

function body = create_report_body(matrix_mean, matrix_cov)
header = ['# Your Variable Details' newline];
p_1 = ['We analyzed your data on ' datestr(now,'mm/DD/YYYY') ' at ' datestr(now,'HH:MM:SS') ...
    '. We calculated the **Mean** and the **Covariance Matrix** of your data and they are:' newline];
p_2 = ['* Mean: ' newline sprintf('\t') num2str(matrix_mean(1)) newline sprintf('\t') num2str(matrix_mean(2)) ...
    newline newline '* Cov: ' newline ...
    sprintf('\t') num2str(matrix_cov(1)) sprintf('\t') num2str(matrix_cov(2)) newline ...
    sprintf('\t') num2str(matrix_cov(3)) sprintf('\t') num2str(matrix_cov(4))];

body = [header p_1 p_2];
end

function write2file(body, dir)
fid = fopen(dir,'wt');
fprintf(fid, body);
fclose(fid);
end