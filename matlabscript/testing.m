%% new test

elli1 = output(1,:);
elli2 = output(23,:);

data = zeros(2,5);
data(1,:) = elli1;
data(2,:) = elli2;

rec = zeros(2:4:2);
for i = 1:2
    rotatemt = [cos(data(i,5)),-sin(data(i,5));sin(data(i,5)),cos(data(i,5))];
    rec(:,1,i) = [rotatemt,data(i,1:2)']*[data(i,3:4)';1];
    rec(:,2,i) = [rotatemt,data(i,1:2)']*[diag([-1,1])*data(i,3:4)';1];
    rec(:,3,i) = [rotatemt,data(i,1:2)']*[diag([-1,-1])*data(i,3:4)';1];
    rec(:,4,i) = [rotatemt,data(i,1:2)']*[diag([1,-1])*data(i,3:4)';1];
end
rect1 = polyshape(rec(1,:,1)',rec(2,:,1)');
rect2 = polyshape(rec(1,:,2)',rec(2,:,2)');

in = intersect(rect1,rect2);
un = union(rect1,rect2);

figure
imshow(sourceimg)
% hold on
% plot(polyshape(rec(1,:,1)',rec(2,:,1)'))
% hold on
% plot(polyshape(rec(1,:,2)',rec(2,:,2)'))
hold on
plot(in)
hold on
%% old test
% n = 27;
% a = out_ellipse(n, 8);
% b = out_ellipse(n, 9);
% x0 = out_ellipse(n, 6);
% y0 = out_ellipse(n, 7);
% theta = out_ellipse(n, 10);
% phi1 = out_ellipse(n, 11);
% phi2 = out_ellipse(n, 12);
% x1 = out_ellipse(n, 2);
% y1 = out_ellipse(n, 3);
% x2 = out_ellipse(n, 4);
% y2 = out_ellipse(n, 5);
% %
% % rosin_dist([x1,y1],[x0,y0,a,b,theta])
% astart = atan2((y1-y0),(x1-x0));
% aend = atan2((y2-y0),(x2-x0));
%
% if astart < 0
%     astart = astart + 2 * pi;
% end
% if aend < 0
%     aend = aend + 2 * pi;
% end
%
% if astart > aend
%     tang = aend + 2 * pi;
% else
%     tang = aend;
% end
% astart
% aend
% astart-phi1
% aend-phi2
%
% % x0 + a * cos(theta) * cos (phi1) + b * sin(theta) * sin(phi1)
%
% set = arcpoints(out_ellipse(n,:));%arc points
%
% figure;
% scatter(set(:,1),set(:,2));
% axis equal;
%
% for i = 1:size(out_ellipse,1)
%     point{i} = arcpoints(out_ellipse(i,:));
% end
%
% for i = 1:size(out_ellipse,1)
%     for phi = 0:0.5:360
%         phi_ = phi /180 * pi;
%         x = x0 + a * cos(theta) * cos (phi_) - b * sin(theta) * sin(phi_);
%         y = y0 + a * cos(theta) * sin (phi_) + b * sin(theta) * cos(phi_);
%         set = [set;[round(x),round(y)]];
%     end
%     ellipse_point{i} = ellipsePoint(out_ellipse(i,6:10));
% end
%
%
% %
% DM = distanceMatrix(out_ellipse(:,:),point,ellipse_point,arc_len)
%
% group=[1,3,7,8,19,23];
% dm = DM(group,group)
% %%
% DM
%
% for n=1:27
%     x0 = out_ellipse(n, 6);
%     y0 = out_ellipse(n, 7);
%     x1 = out_ellipse(n, 2);
%     y1 = out_ellipse(n, 3);
%     x2 = out_ellipse(n, 4);
%     y2 = out_ellipse(n, 5);
%     out_ellipse(n,14) = atan2((y1-y0),(x1-x0));
%     out_ellipse(n,15) = atan2((y2-y0),(x2-x0));
% end
% 
% diff = out_ellipse(:,14:15)-out_ellipse(:,11:12);
% 
%%
k=find(arc_names==1);
mansol = fitEllipse(arc_points{k,1}(:,1),arc_points{k,1}(:,2));
ell3 =fit_ellipse(arc_points{k,1}(:,1),arc_points{k,1}(:,2));
% ell3 = [ell_.X0_in,ell_.Y0_in,ell_.long_axis,ell_.short_axis,ell_.phi];
% ell3 = [ell_.Y0_in,ell_.X0_in,ell_.b,ell_.a,ell_.phi];

r1 = Residuals_ellipse(arc_points{k,1},mansol);
r2 = Residuals_ellipse(arc_points{k,1},output(k,:));
r3 = Residuals_ellipse(arc_points{k,1},ell3);
% figure
drawEllipseandShow(mansol',sourceimg);
% figure
drawEllipseandShow(output(k,:)',sourceimg);
% figure
drawEllipseandShow(ell3',sourceimg);
figure
imshow(sourceimg);
hold on
scatter(arc_points{k,1}(:,2),arc_points{k,1}(:,1),5,'green','filled','square');
hold off

%%

% when plotting
% (x,y) <- (row,col)
% x = cols
% y = row

figure


for i = 1:out_num
    imshow(sourceimg)
    hold on
    scatter(arc_points{arc_names(i),1}(:,2),arc_points{arc_names(i),1}(:,1),5,'green')
    hold off
end
