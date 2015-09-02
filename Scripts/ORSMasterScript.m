clear
clc
close all
clear
clc
close all

xDoc = xml2struct(fullfile('rxcrc_all.xml'));

THEEXP = {};
for expnum=1:length(xDoc.BIGLOGFILE.XMLLOG)
    rxGPS_lat = []; rxGPS_long = []; txGPS_lat = []; txGPS_long = []; rssi = []; txnode = []; d = [];
        for rxpcktnum=1:length(xDoc.BIGLOGFILE.XMLLOG{expnum}.RXPACKET)
            pckt = xDoc.BIGLOGFILE.XMLLOG{expnum}.RXPACKET{rxpcktnum};
            %nrow = str2num(xDoc.BIGLOGFILE.XMLLOG{expnum}.RXPACKET{rxpcktnum}.my_vid.Text)./10;
            %txnode(rxpcktnum) = str2num(pckt.tx_vid.Text);
            T=0;
            if str2num(pckt.my_longitude.Text) < 0 
            T = [pckt.my_longitude.Text(1:4) '.' pckt.my_longitude.Text(5:end)]; 
            else
            T = [pckt.my_longitude.Text(1:3) '.' pckt.my_longitude.Text(4:end)];
            end
            rxGPS_long(rxpcktnum) = str2num(T);
            if str2num(pckt.my_latitude.Text) < 0 
            T = [pckt.my_latitude.Text(1:4) '.' pckt.my_latitude.Text(5:end)]; 
            else
            T = [pckt.my_latitude.Text(1:3) '.' pckt.my_latitude.Text(4:end)];
            end
            rxGPS_lat(rxpcktnum) = str2num(T);
            if str2num(pckt.tx_latitude.Text) < 0 
            T = [pckt.tx_latitude.Text(1:4) '.' pckt.tx_latitude.Text(5:end)]; 
            else
            T = [pckt.tx_latitude.Text(1:3) '.' pckt.tx_latitude.Text(4:end)];
            end
            txGPS_lat(rxpcktnum) = str2num(T); 
            if str2num(pckt.tx_longitude.Text) < 0 
            T = [pckt.tx_longitude.Text(1:4) '.' pckt.tx_longitude.Text(5:end)]; 
            else
            T = [pckt.tx_longitude.Text(1:3) '.' pckt.tx_longitude.Text(4:end)];
            end
            txGPS_long(rxpcktnum) = str2num(T); 
            d(rxpcktnum) = distanceGPS(txGPS_lat(rxpcktnum), txGPS_long(rxpcktnum), rxGPS_lat(rxpcktnum), rxGPS_long(rxpcktnum));
            rssi(rxpcktnum) = str2num(pckt.rssi.Text);
        end
        THEEXP(expnum).name = xDoc.BIGLOGFILE.XMLLOG{expnum}.Attributes.expname;
    THEEXP(expnum).rxGPS_long = rxGPS_long;
    THEEXP(expnum).rxGPS_lat = rxGPS_lat;
    THEEXP(expnum).txGPS_lat = txGPS_lat;
    THEEXP(expnum).txGPS_long = txGPS_long;
    THEEXP(expnum).rssi = rssi;
    THEEXP(expnum).txnode = txnode;
    THEEXP(expnum).d = d;
end
length(THEEXP);
THEEXP.name;
rxlong = THEEXP(1).rxGPS_long;
rxlat = THEEXP(1).rxGPS_lat;
txlong = THEEXP(1).txGPS_long;
txlat = THEEXP(1).txGPS_lat;
rssi = THEEXP(1).rssi;
txnode = THEEXP(1).txnode;
d = THEEXP(1).d;

%--to obtain average RSSI...only use when running an individual file (eg. rxklaus4.xml)
%averageRSSI = ((sum(THEEXP(1).rssi)/length(THEEXP(1).rssi))+(sum(THEEXP(2).rssi)/length(THEEXP(2).rssi))+(sum(THEEXP(3).rssi)/length(THEEXP(3).rssi)))/3;

%--combines all RSSI and dist for Klaus...only use for rxklaus_all.xml
%{
klaus1RSSI = [THEEXP(1).rssi THEEXP(2).rssi THEEXP(3).rssi];
klaus2RSSI = [THEEXP(4).rssi THEEXP(5).rssi THEEXP(6).rssi];
klaus3RSSI = [THEEXP(7).rssi THEEXP(8).rssi THEEXP(9).rssi];
klaus4RSSI = [THEEXP(10).rssi THEEXP(11).rssi THEEXP(12).rssi];
zeros = [0 0 0];
klausAllRSSI = [THEEXP(1).rssi THEEXP(2).rssi THEEXP(3).rssi THEEXP(4).rssi THEEXP(5).rssi THEEXP(6).rssi THEEXP(7).rssi THEEXP(8).rssi THEEXP(9).rssi];
klausAlld = [THEEXP(1).d THEEXP(2).d THEEXP(3).d THEEXP(4).d THEEXP(5).d THEEXP(6).d THEEXP(7).d THEEXP(8).d THEEXP(9).d];
group = [repmat({'30'},length(klaus1RSSI),1); repmat({'60'},length(klaus2RSSI),1); repmat({'90'},length(klaus3RSSI),1);...
        repmat({'120'},length(klaus4RSSI),1); repmat({'150'},length(zeros),1); repmat({'180'},length(zeros),1);...
        repmat({'210'},length(zeros),1); repmat({'240'},length(zeros),1); repmat({'270'},length(zeros),1);repmat({'300'},length(zeros),1);];

 figure
hold all

bh=boxplot([klaus1RSSI,klaus2RSSI,klaus3RSSI,klaus4RSSI,zeros,zeros,zeros,zeros,zeros,zeros],group,'notch','on');
set(bh(:,:),'linewidth',3);
ylabel('RSSI','fontsize', 24);
xlabel('Experimental Distance (Arada)','fontsize', 24);
title('Experimental Distance vs RSSI (Klaus)','fontsize',34);
grid on
%}

%--combines all RSSI and dist for crc...only use for rxcrc_all.xml

crc1RSSI = [THEEXP(1).rssi THEEXP(2).rssi THEEXP(3).rssi];
crc2RSSI = [THEEXP(4).rssi THEEXP(5).rssi THEEXP(6).rssi];
crc3RSSI = [THEEXP(7).rssi THEEXP(8).rssi THEEXP(9).rssi];
crc4RSSI = [THEEXP(10).rssi THEEXP(11).rssi THEEXP(12).rssi];
crc5RSSI = [THEEXP(13).rssi THEEXP(14).rssi THEEXP(15).rssi];
crc6RSSI = [THEEXP(16).rssi THEEXP(17).rssi THEEXP(18).rssi];
crc7RSSI = [THEEXP(19).rssi THEEXP(20).rssi THEEXP(21).rssi];
crc8RSSI = [THEEXP(22).rssi THEEXP(23).rssi THEEXP(24).rssi];
crc9RSSI = [THEEXP(25).rssi THEEXP(26).rssi THEEXP(27).rssi];
crc10RSSI = [THEEXP(28).rssi THEEXP(29).rssi THEEXP(30).rssi];
zeros = [0 0 0];
crcAlld = [THEEXP(1).d THEEXP(2).d THEEXP(3).d THEEXP(4).d THEEXP(5).d THEEXP(6).d THEEXP(7).d THEEXP(8).d THEEXP(9).d THEEXP(10).d THEEXP(11).d THEEXP(12).d THEEXP(13).d THEEXP(14).d THEEXP(15).d THEEXP(16).d THEEXP(17).d THEEXP(18).d THEEXP(19).d THEEXP(20).d THEEXP(21).d THEEXP(22).d THEEXP(23).d THEEXP(24).d THEEXP(25).d THEEXP(26).d THEEXP(27).d THEEXP(28).d THEEXP(29).d THEEXP(30).d];
crcAllRSSI = [crc1RSSI crc2RSSI crc3RSSI crc4RSSI crc5RSSI crc6RSSI crc7RSSI crc8RSSI crc9RSSI crc10RSSI];
group = [repmat({'30'},length(crc1RSSI),1); repmat({'60'},length(crc2RSSI),1); repmat({'90'},length(crc3RSSI),1);...
        repmat({'120'},length(crc4RSSI),1); repmat({'150'},length(crc5RSSI),1); repmat({'180'},length(crc6RSSI),1);...
        repmat({'210'},length(crc7RSSI),1); repmat({'240'},length(crc8RSSI),1); repmat({'270'},length(crc9RSSI),1);repmat({'300'},length(crc10RSSI),1);];
%{
figure
hold all
bhc = boxplot([crc1RSSI,crc2RSSI,crc3RSSI,crc4RSSI,crc5RSSI,crc6RSSI,crc7RSSI,crc8RSSI,crc9RSSI,crc10RSSI],group,'notch','on');
set(bhc(:,:),'linewidth',3);
ylabel('RSSI', 'fontsize', 24);
xlabel('Experimental Distance (Arada)','fontsize', 24);
title('Experimental Distance vs RSSI (CRC)','fontsize', 34);
grid on
%}

%{
%Path Loss plot Klaus
figure
plotColor = 'Color';
PL = klausAllRSSI;
dd= klausAlld;
axes('FontSize',14);
semilogx(dd,PL,plotColor, 'r','LineWidth', 3);title('Klaus AVG COLLISION SAME Lane Packets');ylabel('Pathloss [dB]','interpreter', 'latex');xlabel('Distance [m]','interpreter', 'latex');
avg_safe_1lane_app_coeffs = polyfit(log10(dd), PL, 1);
mdl = LinearModel.fit(log10(dd),PL,'linear');
fittedX = linspace(log10(10),log10(300),1000);
fittedY = polyval(avg_safe_1lane_app_coeffs, fittedX);
hold on
fittedX = 10.^fittedX;
sapp = sprintf('Collision SAME Lane App Avg Model: $\\gamma$=%.4f, $\\alpha$=%.4f, $\\sigma$=%.4f',avg_safe_1lane_app_coeffs(1)/10,avg_safe_1lane_app_coeffs(2),mdl.RMSE);
semilogx(fittedX, fittedY, plotColor, 'k', 'linestyle',  '--', 'LineWidth', 3,'DisplayName',sprintf('AVG COLL MODEL: $\gamma$=%d.4, $\alpha$=%d.4, $\\sigma$=%.4f',avg_safe_1lane_app_coeffs(1)/10,avg_safe_1lane_app_coeffs(2),mdl.RMSE));
fprintf('Averaged Packets Collision Same Lane Scenario: %.4f + 10*%.4f*log10(d); stderr=%.4f\r\n',avg_safe_1lane_app_coeffs(2),avg_safe_1lane_app_coeffs(1)/10,mdl.RMSE);
legend({'Avg App',sapp}, 'interpreter', 'latex','fontsize',14,'location','NORTHEAST'); %Explicit latex
grid on
axis tight
%}
%Path Loss plot crc
figure
plotColor = 'Color';
PL = crcAllRSSI;
dd= crcAlld;
axes('FontSize',14);
semilogx(dd,PL,plotColor, 'b','LineWidth', 3);title('CRC AVG COLLISION SAME Lane Packets');ylabel('Pathloss [dB]','interpreter', 'latex');xlabel('Distance [m]','interpreter', 'latex');
avg_safe_1lane_app_coeffs = polyfit(log10(dd), PL, 1);
mdl = LinearModel.fit(log10(dd),PL,'linear');
fittedX = linspace(log10(10),log10(300),1000);
fittedY = polyval(avg_safe_1lane_app_coeffs, fittedX);
hold on
fittedX = 10.^fittedX;
sapp = sprintf('Collision SAME Lane App Avg Model: $\\gamma$=%.4f, $\\alpha$=%.4f, $\\sigma$=%.4f',avg_safe_1lane_app_coeffs(1)/10,avg_safe_1lane_app_coeffs(2),mdl.RMSE);
semilogx(fittedX, fittedY, plotColor, 'k', 'linestyle',  '--', 'LineWidth', 3,'DisplayName',sprintf('AVG COLL MODEL: $\gamma$=%d.4, $\alpha$=%d.4, $\\sigma$=%.4f',avg_safe_1lane_app_coeffs(1)/10,avg_safe_1lane_app_coeffs(2),mdl.RMSE));
fprintf('Averaged Packets Collision Same Lane Scenario: %.4f + 10*%.4f*log10(d); stderr=%.4f\r\n',avg_safe_1lane_app_coeffs(2),avg_safe_1lane_app_coeffs(1)/10,mdl.RMSE);
legend({'Avg App',sapp}, 'interpreter', 'latex','fontsize',14,'location','NORTHEAST'); %Explicit latex
grid on
axis tight
%}
%-------------------PER/RSSI GRAPHS-------------------------
distances = (30:30:300);
%klaus----------------------------------------------------
klaus_ex_dist = [17.0856 52.7145 82.8800 109.1605 150 180 210 240 270 300];
klaus_TX = [1005 992 997 1003 1114 1000 999 1001 998 1000];
klaus_RX = [547 527 551 542 0 0 0 0 0 0];
klaus_RXrssi = [33.3141 22.6084 20.0239 10.021 0 0 0 0 0 0];
klaus_GPSPhoneDist = [40.563 76.683 112.684 160.392 200.118 230.419 250.392 289.390 350.473 410.293];
klaus_GPSBoxDist = [27.0856 52.7145 82.8800 109.1605];
%klaus----------------------------------------------------

%crc------------------------------------------------------
crc_ex_dist = [29.8924 57.9223 91.5722 119.494 147.1282 175.2690 204.2215 233.8311 259.6629 292.3548];
crc_TX = [1000 1003 1004 1015 998 1002 1018 974 1016 1046];
crc_RX = [778 751 865 855 750 859 820 748 167 33];
crc_RXrssi = [43.1376 37.8642 34.2672 28.2989 18.0413 24.2949 11.6187 9.7560 6.3793 5.0375];
crc_GPSPhoneDist = [40.243 78.932 109.469 185.574 231.886 255.922 317.956 397.2912 408.3921 444.0296];
crc_GPSBoxDist = [29.8924 57.9223 91.5722 119.494 147.1282 175.2690 204.2215 233.8311 259.6629 292.3548];
%crc------------------------------------------------------

%klaus and CRC PER and RSSI vs Measured Dist
crc_PER = 1-(crc_RX./crc_TX);
klaus_PER = 1-(klaus_RX./klaus_TX);
%{
%CRC PER
figure
hold all
title('CRC PER vs Distance', 'fontsize', 34)
plot(distances,crc_PER, 'linewidth', 2.5,'marker','^','color','b','markersize',8);
ylabel('PER', 'color', 'black','fontsize',24);
xlabel('Measured Distance','color','black','fontsize',24);
axis tight
export_fig klauspathloss.png -transparent -painters
grid on

%CRC RSSI
figure
hold all
title('CRC RSSI vs Distance', 'fontsize', 34)
plot(distances,crc_RXrssi, 'linewidth', 2.5,'marker','s','color','b','markersize',8);
ylabel('RSSI', 'color', 'black','fontsize',24);
xlabel('Measured Distance','color','black','fontsize',24);
axis tight
grid on

%Klaus PER
figure
hold all
title('Klaus PER vs Distance', 'fontsize', 34)
hCxPER = plot(distances,klaus_PER, 'linewidth', 2.5,'marker','^','color','r','markersize',8);
ylabel('PER', 'color', 'black','fontsize',24);
xlabel('Measured Distance','color','black','fontsize',24);
axis tight
grid on

%Klaus RSSI
figure
hold all
title('Klaus RSSI vs Distance', 'fontsize', 34)
plot(distances,klaus_RXrssi, 'linewidth', 2.5,'marker','s','color','r','markersize',8);
ylabel('RSSI', 'color', 'black','fontsize',24);
xlabel('Measured Distance','color','black','fontsize',24);
axis tight
grid on
%}
%{
figure
hold all
title('Klaus PER and RSSI vs Distance', 'fontsize', 34)
[hKx, hPERk, hRSSIk] = plotyy(distances,klaus_PER,distances,klaus_RXrssi);
ylabel(hKx(1), 'PER', 'color', 'black','fontsize', 24);
ylabel(hKx(2), 'RSSI', 'color', 'black', 'fontsize', 24);
xlabel('Measured Distance','color','black','fontsize',24);
set(hPERk,'Marker','^','MarkerSize',8);
set(hPERk,'marker','^','color','r');
set(hPERk,'linewidth', 2.5);

set(hRSSIk,'Marker','.','MarkerSize',25);
set(hRSSIk,'marker','.','color','r');
set(hRSSIk,'linestyle','--');
set(hRSSIk,'linewidth', 2.5);

hPERkleg = legend([hPERk;hRSSIk],'PER','RSSIs');
set(hPERkleg,'fontsize',20);
gca.yTickLabel.Color = 'black';
grid on
%}

%---------------------------------------------------------------
%{
distanc = [30 60 90 120];
%CRC GPS Dist Error vs Measured Dist
crc_GPSPhoneDistErr = ((crc_GPSPhoneDist./distances)-1) .* 100;
crc_GPSBoxDistErr = ((crc_GPSBoxDist./distances)-1).* 100;
klaus_GPSPhoneDistErr = ((klaus_GPSPhoneDist./distances)-1) .* 100;
klaus_GPSBoxDistErr = ((klaus_GPSBoxDist./distanc)-1).* 100;

figure
hold all

title('% Error vs Measured Distance', 'fontsize', 34)
hPhoC = plot(distances,crc_GPSPhoneDistErr, 'color', 'blue', 'linewidth', 3, 'linestyle', '--','Marker','s');
hBoxC = plot(distances,crc_GPSBoxDistErr, 'color', 'blue', 'linewidth', 3, 'Marker', 'o');
hPhoK = plot(distances,klaus_GPSPhoneDistErr, 'color', 'red', 'linewidth', 3, 'linestyle', '--','Marker','s');
hBoxK = plot(distanc,klaus_GPSBoxDistErr, 'color', 'red', 'linewidth', 3, 'Marker','o');

GPSErrxlab = xlabel('Measured Distance','color','black','fontsize', 24);
GPSErrylab = ylabel('Percent Error','color','black','fontsize', 24);
hleg = legend([hPhoC,hBoxC,hPhoK,hBoxK],'Phone GPS (CRC)','Router GPS (CRC)','Phone GPS (Klaus)','Router GPS (Klaus)','location','northwest');
set(hleg,'fontsize',20);
grid on
axis tight
%}
%CRC PER and RSSI vs Measured Dist
%{
crc_PER = crc_RX./crc_TX;
figure
hold all
title('PER and RSSI vs Distance (CRC)')
[hCx, hPERc, hRSSIc] = plotyy(distances,crc_PER,distances,crc_RXrssi);
ylabel(hCx(1), 'PER');
ylabel(hCx(2), 'RSSI');
xlabel('Measured Distance');
grid on
%}

%Klaus PER and RSSI vs Measured Dist
%{
klaus_PER = klaus_RX./klaus_TX;
figure
hold all
title('PER and RSSI vs Distance (CRC)')
[hKx, hPERk, hRSSIk] = plotyy(distances,klaus_PER,distances,klaus_RXrssi);
ylabel(hKx(1), 'PER');
ylabel(hKx(2), 'RSSI');
xlabel('Measured Distance');
grid on
%}

% GPSphone_Klaus = []
% GPSrx_Klaus = []
% GPStx_Klaus = []
% GPSvehicles_Klaus = [GPSrx_Klaus GPStx_Klaus]
% 
% GPSphone_CRC = []
% GPSrx_CRC = []
% GPStx_CRC = []
% GPSvehicles_CRC = [GPSrx_CRC GPStx_CRC]
% 
% GPSerror_Klaus = GPSphone_Klaus - GPSvehicles_Klaus;
% GPSerror_CRC = GPSphone_CRC - GPSvehicles_CRC;
% figure
% hold on
% plot(xxx,GPSerror_Klaus,'b')
% plot(1:20,GPSerror_CRC,'r')


%----





