function plotArc(arcpoints,ind,row,col)
%plot arc points
%   Arcpoints are cells
% figure;
hold on;
for i = 1:length(ind)
    scatter(arcpoints{ind(i)}(:,1),arcpoints{ind(i)}(:,2),5);
end
xlim([0 col])
ylim([0 row])
end

