function max_label = pgmMaxLabel(filename, dataLines)
%pgmMaxLabel Import data from a pgm file
%  MAX_LABEL = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the numeric data.
%
%  MAX_LABEL = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  max_label = importfile("/home/wu/codes/cocluster_matlab/ELSDc/Dataset4_mydataset/043_0011_reg.pgm", [3, 3]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 26-9月-2022 16:13:36

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [3, 3];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 8);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["P2", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8"];
opts.SelectedVariableNames = "P2";
opts.VariableTypes = ["double", "string", "string", "string", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8"], "EmptyFieldRule", "auto");

% Import the data
max_label = readtable(filename, opts);

%% Convert to output type
max_label = table2array(max_label);
end