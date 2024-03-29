% @Author: WU Zihan
% @Date:   2022-09-27 22:24:30
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:44:44
function yxsize = readyxsize(filename, dataLines)
    %READYXSIZE Import size from a pgm file
    %  YXSIZE = IMPORTFILE(FILENAME) reads data from text file FILENAME for
    %  the default selection.  Returns the numeric data.
    %
    %  YXSIZE = IMPORTFILE(FILE, DATALINES) reads data for the specified row
    %  interval(s) of text file FILENAME. Specify DATALINES as a positive
    %  scalar integer or a N-by-2 array of positive scalar integers for
    %  dis-contiguous row intervals.
    %
    %  Example:
    %  yxsize = importfile("/home/wu/codes/cocluster_matlab/ELSDc/Dataset4_mydataset/043_0011_reg.pgm", [2, 2]);
    %
    %  See also READTABLE.
    %
    % Auto-generated by MATLAB on 26-9月-2022 15:44:02

    %% Input handling

    % If dataLines is not specified, define defaults
    if nargin < 2
        dataLines = [2, 2];
    end

    %% Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 8);

    % Specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = " ";

    % Specify column names and types
    opts.VariableNames = ["P2", "VarName2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8"];
    opts.SelectedVariableNames = ["P2", "VarName2"];
    opts.VariableTypes = ["double", "double", "string", "string", "string", "string", "string", "string"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    opts.ConsecutiveDelimitersRule = "join";
    opts.LeadingDelimitersRule = "ignore";

    % Specify variable properties
    opts = setvaropts(opts, ["Var3", "Var4", "Var5", "Var6", "Var7", "Var8"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var3", "Var4", "Var5", "Var6", "Var7", "Var8"], "EmptyFieldRule", "auto");

    % Import the data
    yxsize = readtable(filename, opts);

    %% Convert to output type
    yxsize = table2array(yxsize);
end
