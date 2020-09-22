%% Set up the environment
close all;
clear all;

%% Global Settings
lineWidth = 4;

%% Vbe Vs. Ib. No base resistor
[time, Vbe, Ib] = textread('Vbe_Ib.txt', '%f\t%f\t%f', 'headerlines', 1);


Vbe_Ib = figure();
plot(Vbe, Ib*1000, 'LineWidth', lineWidth);
xlabel("Vbe (volts)");
ylabel("Ib (mA)");
title("Transistor 2N2222: Base-Emitter Diode Characteristics");
print Vbe_Ib 'NPN_2N2222_Vbe_Ib.pdf'  -dpdf "-S640,480"

Vbe_Ib_zoomed = figure();
zoom_begin = round(0.5*length(Vbe));
zoom_end = round(0.8*length(Vbe));
plot(Vbe(zoom_begin:zoom_end), Ib(zoom_begin:zoom_end)*1E6, 'LineWidth', lineWidth);
xlabel("Vbe (volts)");
ylabel("Ib (uA)");
title("Transistor 2N2222: Base-Emitter Diode Characteristics");
print Vbe_Ib_zoomed 'NPN_2N2222_Vbe_Ib_zoomed.pdf'  -dpdf "-S640,480"

%% Vbe Vs. Ib with base resistor
[time, Vin_withRb, Vbe_withRb, Ib_withRb] = textread('Vin_Vbe_Ib.txt', '%f\t%f\t%f\t%f', 'headerlines', 1);
Vin_Vbe_Ib_fig = figure();
[Vin_Vbe_Ib, Vax1, Vax2] = plotyy(Vin_withRb, Vbe_withRb, Vin_withRb, Ib_withRb*1E6);
xlabel("Vin (volts)");
ylabel(Vin_Vbe_Ib(1), "Vbe(V)");
set(Vax1, 'LineWidth', lineWidth);
ylabel(Vin_Vbe_Ib(2), "Ib(uA)");
set(Vax2, 'LineWidth', lineWidth);
title("Transistor 2N2222: Base-Emitter Diode Characteristics in the presence of a base resistor");
print Vin_Vbe_Ib_fig 'NPN_2N2222_Vin_Vbe_Ib.pdf'  -dpdf "-S640,480"


Vin_Vbe_Ib_z_fig = figure();
zoom_begin = length(Vin_withRb) * (0.7 - min(Vin_withRb))/(max(Vin_withRb) - min(Vin_withRb));
zoom_end = length(Vin_withRb) * (0.98 - min(Vin_withRb))/(max(Vin_withRb) - min(Vin_withRb));
zoom_begin = round(zoom_begin);
zoom_end = round(zoom_end);
[Vin_Vbe_Ib_z, Vax1_z, Vax2_z] = plotyy(Vin_withRb(zoom_begin:zoom_end), Vbe_withRb(zoom_begin:zoom_end), Vin_withRb(zoom_begin:zoom_end), Ib_withRb(zoom_begin:zoom_end)*1E6);
xlabel("Vin (volts)");
ylabel(Vin_Vbe_Ib_z(1), "Vbe(V)");
set(Vax1_z, 'LineWidth', lineWidth);
ylabel(Vin_Vbe_Ib_z(2), "Ib(uA)");
set(Vax2_z, 'LineWidth', lineWidth);
title("Transistor 2N2222: Base-Emitter Diode Characteristics in the presence of a base resistor");
print Vin_Vbe_Ib_z_fig 'NPN_2N2222_Vin_Vbe_Ib_zoomed.pdf'  -dpdf "-S640,480"

%% Vbe, Ib Vs. Vce, Ic. With base and collector resistor
[time, Vce_withRb, Vin_withRb, Vbe_withRb, Ic_withRb, Ib_withRb] = textread('Vce_Vin_Vbe_Ic_Ib.txt', '%f\t%f\t%f\t%f\t%f\t%f', 'headerlines', 1);
zoom_begin = length(Vin_withRb) * (0.7 - min(Vin_withRb))/(max(Vin_withRb) - min(Vin_withRb));
zoom_end = length(Vin_withRb) * (0.98 - min(Vin_withRb))/(max(Vin_withRb) - min(Vin_withRb));
zoom_begin = round(zoom_begin);
zoom_end = round(zoom_end);
Ib_Ic_Vce_fig = figure();
[Ib_Ic_Vce, Vax1_z, Vax2_z] = plotyy(Ib_withRb(zoom_begin:zoom_end)*1E6, Ic_withRb(zoom_begin:zoom_end)*1E3, Ib_withRb(zoom_begin:zoom_end)*1E6, Vce_withRb(zoom_begin:zoom_end));
xlabel("Ib (uA)");
ylabel(Ib_Ic_Vce(1), "Ic(mA)");
set(Vax1_z, 'LineWidth', lineWidth);
ylabel(Ib_Ic_Vce(2), "Vce(V)");
set(Vax2_z, 'LineWidth', lineWidth);
title("Transistor 2N2222: Collector Characteristics vs. Base Current");
text(15,1, strcat("A_OL = mean(Ic/Ib) = ", num2str(mean(Ic_withRb(zoom_begin:zoom_end)./Ib_withRb(zoom_begin:zoom_end)))));
print Ib_Ic_Vce_fig 'NPN_2N2222_Ib_Ic_Vce.pdf'  -dpdf "-S640,480"

Vbe_Ic_Vce_fig = figure();
[Vbe_Ic_Vce, Vax1_z, Vax2_z] = plotyy(Vbe_withRb(zoom_begin:zoom_end), Ic_withRb(zoom_begin:zoom_end)*1E3, Vbe_withRb(zoom_begin:zoom_end), Vce_withRb(zoom_begin:zoom_end));
xlabel("Vbe (volts)");
ylabel(Vbe_Ic_Vce(1), "Ic(mA)");
set(Vax1_z, 'LineWidth', lineWidth);
ylabel(Vbe_Ic_Vce(2), "Vce(V)");
set(Vax2_z, 'LineWidth', lineWidth);
title("Transistor 2N2222: Collector Characteristics vs. Base-Emitter Voltage");
print Vbe_Ic_Vce_fig 'NPN_2N2222_Vbe_Ic_Vce.pdf'  -dpdf "-S640,480"

%% Transistor Characteristics with DC load line
[time, Vce_Ib20, Ic_Ib20, Ib_Ib20] = textread('Ib20.txt', '%f\t%f\t%f\t%f', 'headerlines', 1);
[time, Vce_Ib40, Ic_Ib40, Ib_Ib40] = textread('Ib40.txt', '%f\t%f\t%f\t%f', 'headerlines', 1);
[time, Vce_Ib60, Ic_Ib60, Ib_Ib60] = textread('Ib60.txt', '%f\t%f\t%f\t%f', 'headerlines', 1);
[time, Vce_Ib80, Ic_Ib80, Ib_Ib80] = textread('Ib80.txt', '%f\t%f\t%f\t%f', 'headerlines', 1);
[time, Vce_Ib100, Ic_Ib100, Ib_Ib100] = textread('Ib100.txt', '%f\t%f\t%f\t%f', 'headerlines', 1);

loadLineX = [13.28, 9.37, 5.68, 2.39, 0.05];
loadLineY = [4.29, 8.39, 12.03, 15.40, 17.85];
transChar = figure();
plot(Vce_Ib20, Ic_Ib20*1000, 'LineWidth', lineWidth, Vce_Ib40,  Ic_Ib40*1000, 'LineWidth', lineWidth,  Vce_Ib60, Ic_Ib60*1000, 'LineWidth', lineWidth,  Vce_Ib80, Ic_Ib80*1000, 'LineWidth', lineWidth, Vce_Ib100,  Ic_Ib100*1000, 'LineWidth', lineWidth,  loadLineX, loadLineY, 'LineWidth', lineWidth, 'Color', 'k');
axis([0, 25, 0, 25]);

text(15,6,"Ib=20uA");
text(13,10,"Ib=40uA");
text(10,14,"Ib=60uA");
text(8,18,"Ib=80uA");
text(6,22,"Ib=100uA");

xlabel("Vce (volts)");
ylabel("Ic (mA)");
title("Transistor 2N2222: Characteristic Curve");
print transChar 'TransCharacts2N2222.pdf'  -dpdf "-S640,480"

