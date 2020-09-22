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
x = linspace(10, 509, 1000);
yd = 100*exp(-3.069*x/max(x));
ys = 100*(1 - exp(-3.07*x/max(x)));

figure(1);
demandPlot = plot(x, yd, 'lineWidth', 3, 'b');
title('Demand Curve'), xlabel('Demanded quantity (tonnes)'), ylabel('offering price (Rs/Kg)');
print demandPlot 'demandCurve.pdf' -dpdf "-S640,480"

figure(2);
supplyPlot = plot(x, ys, 'lineWidth', 3, 'r');
title('Supply Curve'), xlabel('Supplied quantity (tonnes)'), ylabel('Asking price (Rs/Kg)');
print supplyPlot 'supplyCurve.pdf' -dpdf "-S640,480"

figure(3);
transactionPlot = plot(x, yd, 'b', 'lineWidth', 3, x, ys, 'r', 'lineWidth', 3);
legend('Demand Curve', 'Supply Curve', 'location', 'east');
line('XData', [x(211) x(211) 0], 'YData', [0 ys(211) ys(211)], 'LineWidth', 3, 'LineStyle', '--', 'Color', [0 0 0]);
title('A Transaction'), xlabel('Qunatity (tonnes)'), ylabel('Price (Rs/Kg)');
hold on;
plot(x(211), ys(211), 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'MarkerSize', 6, 'LineWidth', 5);
text(130, 50, '-> 115 tonnes sold at 50 Rs/Kg'); 
print transactionPlot 'transaction.pdf' -dpdf "-S640,480" 
hold off;

endfunction
