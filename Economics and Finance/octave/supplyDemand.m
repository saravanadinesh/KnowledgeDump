## Copyright (C) 2016 schandraseka
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} supplyDemand (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: schandraseka <schandraseka@SCHANDRASEKA-LT>
## Created: 2016-03-27

function [retval] = supplyDemand ()

retVal = 0; % Just a dummy placeholder

% Visualizing Demand curve
x = 10:509;
yd = 100*exp(-3.069*x/max(x));
ys = 100*(1 - exp(-3.07*x/max(x)));

figure(1);
demandPlot = plot(x, yd, 'lineWidth', 3, 'b');
title('Demand Curve'), xlabel('Demanded quantity (tonnes)'), ylabel('offering price (Rs/Kg)');
print demandPlot 'demandCurve.pdf' -dpdf '-S640,480'

figure(2);
supplyPlot = plot(x, ys, 'lineWidth', 3, 'r');
title('Supply Curve'), xlabel('Supplied quantity (tonnes)'), ylabel('Asking price (Rs/Kg)');
print demandPlot 'supplyCurve.pdf' -dpdf '-S640,480'

figure(3);
transactionPlot = plot(x, yd, 'b', 'lineWidth', 3, x, ys, 'r', 'lineWidth', 3);
legend('Demand Curve', 'Supply Curve', 'location', 'east');
title('A Transaction'), xlabel ('Quantity (tonnes)'), ylabel('Price (Rs/Kg)');
hold on;
plot(x(106), yd(106), 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'LineWidth', 5);
line('XData', [x(106) x(106) 0], 'YData', [0 yd(106) yd(106)], 'LineWidth', 2, 'LineStyle', '--', 'color', 'k');
text(x(106+10), yd(106), '-->115 tonnes sold at 50 Rs/Kg');
hold off;
print transactionPlot 'transaction.pdf' -dpdf '-S640,480'


%% Supply/Demand curve shifts laterally
% Demand Shifts Right
rShift = 100; 
xR = x-rShift;
ydr = 100*exp(-3.069*xR/max(x));

figure(4);
plot(x(1:500-rShift), yd(1:500-rShift), 'color', [0.8 0.8 1], 'lineWidth', 3, x(1+rShift:500), ydr(1+rShift:500), 'b', 'lineWidth', 3, x, ys, 'r', 'lineWidth', 3);
axis([0 600 0 100]);
legend('Original Demand Curve', 'New Demand Curve', 'Supply Curve', 'location', 'east');
title('Increased Purchasing Power Shifts Demand to Right'), xlabel ('Quantity (tonnes)'), ylabel('Price (Rs/Kg)');
grid on;
hold on;

% Plot old transaction point
plot(x(106), yd(106), 'o', 'MarkerFaceColor', [0.8 0.8 0.8], 'MarkerEdgeColor', [0.8 0.8 0.8], 'LineWidth', 5);
line('XData', [x(106) x(106) 0], 'YData', [0 yd(106) yd(106)], 'LineWidth', 2, 'LineStyle', '--', 'color', [0.8 0.8 0.8]);
text(x(106+10), yd(106), '-->115 tonnes sold at 50 Rs/Kg', 'color', [0.8 0.8 0.8]);

% Plot new transaction point
plot(x(163), ydr(163), 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'LineWidth', 5);
line('XData', [x(163) x(163) 0], 'YData', [0 ydr(163) ydr(163)], 'LineWidth', 2, 'LineStyle', '--', 'color', 'k');
text(x(163+10), ydr(163), '-->172 tonnes sold at 64.6 Rs/Kg');
hold off;

print 'rightShiftDemand' -dpdf '-S640,480'

% Supply Shifts left
lShift = 100; 
xL = x+lShift;
ysl = 100*(1 - exp(-3.07*xL/max(x)));

figure(5);
plot( x, yd, 'b', 'lineWidth', 3, x(1+lShift:500), ys(1+lShift:500), 'color', [1 0.8 0.8], 'lineWidth', 3, x(1:500-lShift), ysl(1:500-lShift), 'r', 'lineWidth', 3);
axis([0 600 0 100]);
legend('Demand Curve', 'Old Supply Curve', 'New Supply Curve', 'location', 'east');
title('Increased Fuel Price Shifts Supply to Left'), xlabel ('Quantity (tonnes)'), ylabel('Price (Rs/Kg)');
grid on;
hold on;

% Plot old transaction point
plot(x(106), yd(106), 'o', 'MarkerFaceColor', [0.8 0.8 0.8], 'MarkerEdgeColor', [0.8 0.8 0.8], 'LineWidth', 5);
line('XData', [x(106) x(106) 0], 'YData', [0 yd(106) yd(106)], 'LineWidth', 2, 'LineStyle', '--', 'color', [0.8 0.8 0.8]);
text(x(106+10), yd(106), '-->115 tonnes sold at 50 Rs/Kg', 'color', [0.8 0.8 0.8]);

% Plot new transaction point
plot(x(63), ysl(63), 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'LineWidth', 5);
line('XData', [x(63) x(63) 0], 'YData', [0 ysl(63) ysl(63)], 'LineWidth', 2, 'LineStyle', '--', 'color', 'k');
text(x(63+10), ysl(63), '-->72 tonnes sold at 64.6 Rs/Kg');
hold off;

print 'leftShiftSupply' -dpdf '-S640,480'

endfunction

