#!/bin/bash
#Vitebsk
#wget -O examples/forecast.xml "http://wxdata.weather.com/wxdata/weather/local/BOXX0014?cm_ven=1CW~c&par=1CWFFv1.1.9&cm_pla=wx.com-bar&cm_cat=FFv1.1.9&unit=m&dayf=9&cc=*" 
#wget -O examples/forecast_detail.xml "http://wxdata.weather.com/wxdata/weather/local/BOXX0014?cm_ven=1CW&site=wx.com-bar&cm_ite=wx-cc&par=1CWFFv1.1.9&cm_pla=wx.com-bar&cm_cat=FFv1.1.9&unit=m&hbhf=12"
./weathercom ./examples/forecast.xml ./examples/out.xml ./examples/forecast_detail.xml 
