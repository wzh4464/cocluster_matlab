% @Author: WU Zihan
% @Date:   2022-09-30 16:26:35
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-04 22:35:23
classdef frame < matlab.mixin.Copyable
    %FRAME current status for caluculation
    %   Detailed explanation goes here

    properties
        points
        elli
        residue
        res_sum
        sourceimg
        group
        ANum
        cor
        ratio
        index % index gives the group label of the arcs
    end

    methods

        function obj = frame(varargin)
            %FRAME Construct an instance of this class
            %   raw_arc, elli, points, ind

            if nargin == 1 % raw_arc 

                raw_arc = varargin{1};
                num = length(raw_arc.id);
                obj.group = cell(num, 1);
                obj.elli = raw_arc.elli;
                obj.points = raw_arc.points;
                obj.sourceimg = raw_arc.sourceimg;
                obj.cor = raw_arc.cor;

                for i = 1:num
                    obj.group{i} = i;
                end

                obj.index = raw_arc.label;


            else

                if nargin == 5 % elli, points, group, sourceimg, ind
                    obj.elli = varargin{1};
                    obj.points = varargin{2};
                    % group = varargin{4};
                    % num = max(ind);
                    obj.group = varargin{3};
                    % for i = 1:num
                    %     obj.group{i} = find(ind==i);
                    % end
                    obj.sourceimg = varargin{4};
                    obj.index = varargin{5};

                    out_num = size(obj.elli, 1);
                    obj.cor = zeros(out_num);

                    for i = 1:out_num

                        for j = 1:out_num
                            obj.cor(i, j) = iou(obj.elli(i, :), obj.elli(j, :));
                        end

                    end

                end % ! from ind

            end

            obj.ANum = size(obj.elli, 1);
            obj.calculateResidue();

            obj.res_sum = obj.resSum();
            % unique the points read
            for i = 1:obj.ANum
                obj.points{i} = unique(obj.points{i}, "row");
            end

            obj.ratio = obj.calculateRatio();

        end

        function showPoints(obj, arc_num)
            arcShow(arc_num, obj.sourceimg, obj.points);
        end

        function showEllipse(obj, arc_num)
            drawEllipseandShow(obj.elli(arc_num, :)', obj.sourceimg);
        end

        function res_sum = resSum(obj)
            %resSum
            %
            % Syntax: res_sum = resSum()
            %
            % calculate total error for this frame

            res_sum = sum(obj.residue);

        end

        %         function pointset = pointOfSet(obj, raw_arc, k)
        %             %pointOfSet - pointset of group k
        %             %
        %             % Syntax: pointset = pointOfSet(raw_arc,k)
        %             pointset = [];
        %
        %             for i = 1:length(group)
        %             end
        %
        %         end
        function comparePaE(obj, k)
            drawEllipseandShow(obj.elli(k, :)', obj.sourceimg);
            hold on
            scatter(obj.points{k}(:, 2), obj.points{k}(:, 1), 10, 'green', 'filled', 'square');
        end

        function showAllElli(obj)
            drawEllipseandShow(obj.elli', obj.sourceimg);
        end

        function obj = dropSmallArcs(obj, threshold_ratio, threshold_e)
            %dropSmallArcs - the last step
            %
            % Syntax: frame = dropSmallArcs(obj, threshold_ratio)
            %
            % if the ellipse's angle is too small, it is highly probable to be a wrong one
            % if e is too big, it's also a wrong one
            % well it's not actually e, but b/a
            if ~exist ('threshold_ratio', 'var')
                threshold_ratio = 1;
            end

            if ~exist ('threshold_e', 'var')
                threshold_e = 0.1;
            end

            j = 0;

            for i = 1:obj.ANum
                j = j + 1;

                if (obj.ratio(j) < threshold_ratio) || ((obj.elli(j, 4) / obj.elli(j, 3)) < threshold_e)
                    % fprintf("j = %d\nratio = %f\n",j,obj.ratio(j));
                    obj.ANum = obj.ANum - 1;
                    obj.elli(j, :) = [];
                    obj.points(j) = [];
                    obj.group{i} = [];
                    obj.ratio(j) = [];
                    j = j - 1;
                end

            end

            obj.calculateResidue();
            obj.res_sum = obj.resSum();
            obj.cor = zeros(obj.ANum);

            for i = 1:obj.ANum

                for j = 1:obj.ANum
                    obj.cor(i, j) = iou(obj.elli(i, :), obj.elli(j, :));
                end

            end

        end

        function calculateResidue(obj)
            %calculateResidue - as title
            %
            % Syntax: calculateResidue(obj)
            %
            % As title
            obj.residue = zeros(obj.ANum, 1);

            for i = 1:obj.ANum

                obj.residue(i) = Residuals_ellipse(obj.points{i}, obj.elli(i, :));

            end

        end

        function ratio = calculateRatio(obj)
            %calculateRatio - Description
            %
            % Syntax: ratio = calculateRatio(obj)
            %
            % Long description
            ratio = zeros(1, obj.ANum);

            for j = 1:obj.ANum
                ratio(j) = size(obj.points{j}, 1) / (obj.elli(j, 3) + obj.elli(j, 4));
            end

        end

    end

end
