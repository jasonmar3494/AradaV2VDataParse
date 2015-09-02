clear
clc
close all

xDoc = xml2struct(fullfile('20150228_2240_20_0000_E290_0001.xml'));

THEEXP = {};
for expnum=1:length(xDoc.BIGLOGFILE.XMLLOG)
    rxGPS_lat = []; rxGPS_long = []; txGPS_lat = []; txGPS_long = []; rssi = []; txnode = []; d = [];
    if length(xDoc.BIGLOGFILE.XMLLOG) == 1
        for rxpcktnum=1:length(xDoc.BIGLOGFILE.XMLLOG.RXPACKET)
        pckt = xDoc.BIGLOGFILE.XMLLOG.RXPACKET{rxpcktnum};
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
        THEEXP(expnum).name = xDoc.BIGLOGFILE.XMLLOG.Attributes.expname;
    else
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
    end
    THEEXP(expnum).rxGPS_long = rxGPS_long;
    THEEXP(expnum).rxGPS_lat = rxGPS_lat;
    THEEXP(expnum).txGPS_lat = txGPS_lat;
    THEEXP(expnum).txGPS_long = txGPS_long;
    THEEXP(expnum).rssi = rssi;
    %THEEXP(expnum).txnode = txnode;
    THEEXP(expnum).d = d;
end
length(THEEXP)
THEEXP.name
rxlong = THEEXP(1).rxGPS_long;
rxlat = THEEXP(1).rxGPS_lat;
txlong = THEEXP(1).txGPS_long;
txlat = THEEXP(1).txGPS_lat;
rssi = THEEXP(1).rssi;
%txnode = THEEXP(1).txnode;
d = THEEXP(1).d;