# 
# Do not Edit! Generated by:
# spectacle version 0.18
# 
# >> macros
#%define wantmeegopanel 0
#%define all_x86 i386 i586 i686 %{ix86}
#%define all_arm %{arm}
# << macros
%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Name:       harbour-meecast
Summary:    Weather forecast application for SailfishOS
Version:    0.9.15
Release:    1
Group:      Utility
License:    GPLv2.1
URL:        https://github.com/Meecast/meecast 
Source0:    %{name}-%{version}.tar.bz2
#Temporary
#Requires:       libmeegotouch-devel
BuildRequires:  pkgconfig(sailfishapp)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(qdeclarative5-boostable)
BuildRequires:  desktop-file-utils
BuildRequires:  pkgconfig(libcurl)
BuildRequires:  pkgconfig(zlib)
BuildRequires:  pkgconfig(sqlite3)
#BuildRequires:  pkgconfig(gconf-2.0)
BuildRequires:  pkgconfig(dbus-glib-1)
BuildRequires:  pkgconfig(libxml-2.0)
#BuildRequires:  libxml2-devel
BuildRequires:  gettext
BuildRequires:  pkgconfig(dconf) 
BuildRequires:  libkeepalive-devel
#BuildRequires:  libqt-devel
BuildRequires: qt5-qtpositioning-devel
#Requires:      qt5-qtpositioning 
#Requires:      sailfishsilica-qt5
#Requires:      qt5-qtdeclarative-import-models2 
#Requires:      zlib 

%description
MeeCast - multiplatform highly customizable open source weather forecast client based on OMWeather code

%package daemon
Version: 0.1
Summary: Daemon for Weather forecast application MeeCast on SailfishOS
Group:      Utility
License:    GPLv2.1
%description daemon
MeeCast daemon for multiplatform highly customizable open source weather forecast client based on OMWeather code


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
#export PATH=/usr/lib/qt4/bin:$PATH
%qtc_qmake5
%qtc_make %{?_smp_mflags}
#make
# << build pre


# >> build post
# << build post
%install
rm -rf %{buildroot}
# >> install pre
# << install pre

# >> install post
%qmake5_install
#make INSTALL_ROOT=%{buildroot} install
#rm %{buildroot}/opt/com.meecast.omweather/lib/libomweather-core.a
# << install post
desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%pre daemon
killall meecastd

%postun daemon
killall meecastd

%files
%defattr(-,root,root,-)
/usr/share/applications/harbour-meecast.desktop
/usr/bin/harbour-meecast
/usr/share/harbour-meecast
#/usr/share/iconsets
/usr/share/icons/hicolor/86x86/apps
#/opt/com.meecast.omweather/share

%files daemon
%defattr(-,root,root,-)
/usr/bin/meecastd
/usr/bin/meecast_predaemon
/usr/lib/systemd/user/meecastd.service


%changelog
* Mon Dec 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.15

  * Added daemon for controlling updating weather forecast and displaying weather on wallpaper 

* Mon Dec 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.14

  * Added string for translation from openweathermap.org source 
  * Removed unnecessary second refresh action on cover page. Thanks George Nikandrov
  * Set source logo to top of cover page. Thanks George Nikandrov
  * Fixed problem with Icon and Null wind speed data on cover page
  * Fixed problem with 'Next station' and 'Update' buttons on cover page. Thanks TMavica

* Fri Dec 12 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.13
  * Added Durovka to gismeteo.ru and foreca.com sources
  * Added India to Openweathermap.org
  * Decreased font size in station name on cover page for station name length from 19 to 20
  * Fixed problem with Beaufort Wind unit
  * Updated Catalan, Dutch, Finnish, Germany, Slovenian, Spanish, Italian,
    Czech, Swedish, Russian, Danish translations

* Thu Nov 27 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.12
  * Fixed problem with hourly forecast view
  * Added Palanga(Lithuania) to weather.com, yr.no, openweathermap.org sources
  * Removed donation link
  * Added wake up internet connection for refresh weather forecast
  * Added station Poselok rudnika Kupol to gismeteo.ru source
  * Fixed problem with Denmark, Germany stations in openweathermap.org source
  * Fixed incorrect name of pressure from "Pa" to "kPa"
  * Updated Catalan, Dutch, Finnish, Germany, Norway, Slovenian, Spanish,
    Italian, Czech, Danish translations

* Tue Oct 28 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.11
  * Fixed broken cover (for new firmware)

* Mon Sep 01 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.10
  * Added translation string for gismeteo.ru
  * Adapted for big size screen
  * Updated Slovenian, Italian, Swedish translations
  * Fixed issue with auto update 

* Thu Aug 26 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.9
  * Fixed problem with USA like style time for last update, sunrise, sunset
    and hourly information 
  * Added stations Lignano Pineta, Lignano Riviera, Lignano Sabbiadoro (Italy) to
    weather.com, foreca.com source  
  * Added stations Lignano Sabbiadoro (Italy) to gismeteo.ru source  
  * Added all stations from Regione Autonoma Friuli Venezia Giulia to
    openwearthermap.org source
  * Added station Cesena, ER, Italy to weather.com, openweathermap.com source  
  * Added many stations from Italy to yr.no source
  * Changed value for opacity in backgaound on Cover Page to 0.0 
  * Fixed problem with actions on Cover page
  * Fixed problem with function 'Next station' on Cover page
  * Updated Finnish, Germany translations

* Thu Aug 14 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.8
  * Added Sunrise and sunset for fmi.fi source
  * Added Precipitation
  * Added Precipitation rate
  * Added Precipitation data to hourly page
  * Added Dewpoint
  * Added dewpoint for weather.com source
  * Fixed problem with big icon on Main form
  * Fixed problem with a lag after removal station
  * Updated Catalan, Spanish, Russian, Dannish translations

* Sun Aug 03 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.7
  * Fixed sunrise and sunset time for weather.com source again :)
  * Updated Italian, Hungarian, Turkish translations

* Tue Jul 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.6
  * Fixed donation link 
  * Added translation string for gismeteo.ru
  * Fixed sunrise and sunset time for weather.com source
  * Added fmi.fi source
  * Updated Catalan, Germany, Slovenian, Spanish,
    Russian, Hungarian, Danish, Italian, Finnish translations
  * Fixed problem with null wind direction on main form
  * Added the new source fmi.fi

* Sun Jul 03 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.5
  * Fixed problem with Now/Today waether data for Main Page 
  * Fixed problem with null data for day forecast in weather.com source
  * Updated Catalan, Finnish, Norwegian, Slovenian, Danish,
    Spanish, Italian, Russian, Hungarian, French translations
  * Fixed problem with data (humidity, feels like...) in current weather in foreca.com source
  * Decreased font for 'Last update" on cover page
  * Fixed problem with station name font size on cover page
  * Added stations to Finland in yr.no source
  * Added hourly weather forecast for yr.no source

* Sun Jun 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.4
  * Fixed problem with current night forecast
  * Fixed memory leaks
  * Fixed crashing

* Sun Jun 15 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.3
  * Fixed problem with data(not current day) for more then one station
  * Added United Kingdom to foreca.com source
  * Added Germany's stations to openweathermap.org source

* Wed Jun 11 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.2
  * Fixed problem with hours forecast button
  * Fixed problem with today data for weather.com source
  * Fixed problem with n/a icon for Atmos iconset
  * Fixed problem with hourly foreasts
  * Added Danish translation
  * Updated Catalan, Chinese (Taiwan), Czech, Finnish, 
    German, Italian, Norwegian, Serbian, Slovenian,
    Spanish, Russian, Hungarian, French translations

* Fri May 02 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.9.1
  * Fixed problem with swiping to another station 
  * Improved design of transparent and black themes
  * Added stations to Finland in source yr.no
  * Fixed problem with converting map URLs
  * Added separator for stations on Main form
  * Added icon for openstreetmap.org

* Fri Apr 18 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.18.1
  * Fixed problem with current weather in foreca.com source 
  * Updated Catalan, Serbian, Slovenian, Spanish, Russian translations
  * Fixed problems with transparency

* Fri Apr 08 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.17.1
  * Added transparency
  * Fixed problem with Units view in Menu Settings 
  * Fixed problem with current weather in foreca.com source
  * Changed behaviour for displaying label (Now/Today) on Cover Page
  * Updated Catalan, Czech, Finnish, Slovenian, Spanish,
    German, Italian, Arabic translations

* Sun Mar 30 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.16.1
  * Fixed segmentation fault 
  * Fixed problem with translations
  * Fixed problem with logo on cover page
  * Fixed centering problem of the graphics on the details page
  * Increased icon size on CoverPage
  * Reordered items in Main PullMenu
  * Updated German and Russian translations
  * Changed label text "Update" to "Refresh"

* Wed Mar 26 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.15.1
  * Updated Denmark for openstreetmap.org 
  * Disabled menu item "Adjust GPS station"
  * Fixed problem with crashing application with foreca.com data
  * Changed order of items in PullMenu
  * Fixed font size in station name on Cover Page
  * Fixed problem with size of map image
  * Updated Catalan, Czech, Finnish, Norwegian, Serbian, Slovenian, Spanish,
    Turkish, German translations

* Sun Feb 23 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.14.1
  * Fixed problem with downloading

* Sat Feb 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.13.1
  * Fixed problem on Cover page

* Sat Feb 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.12.1
  * Fixed problem on Cover page

* Sat Feb 22 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.11.1
  * Polished Cover page
  * Disable unused configuration files 

* Wed Feb 18 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.10.1
  * Adapted for Harbour (Jolla store)
  * Disabled GPS-station

* Sat Feb 15 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.9.1
  * Updated Finnish, Norwegian, Arabic, Serbian, Turkish, Dutch, Hungarian translations
  * Added Slovenian and Czech translations
  * Fixed memory leaks
  * Fixed problem with yr.no database for Belarus
  * Added icon and descripion string for openweathermap.org source

* Sun Feb 02 2014 Vlad Vasilyeu <vasvlad@gmail.com> 0.8.8.1
  * Fixed problem with long text in last update string
  * Added possibility to switch off 'Last update' on Cover Page
  * Fixed problem in About Page 
  * Redesigned wind information on Cover Page 
  * Updated Norwegian, Arabic, Serbian, Turkish, Dutch, Hungarian translations
  * Added Slovenian and Czech translations
* Tue Jan 26 2014  Vlad Vasilyeu <vasvlad@gmail.com> 0.8.7.1
  * Added Wind speed and Wind direction to Cover Page
  * Added text 'Now' to Cover Page
  * Polished Cover Page
* Tue Jan 23 2014  Vlad Vasilyeu <vasvlad@gmail.com> 0.8.6.1
  * Removed button refresh from main form and add Item menu 'Update' to pulley menu 
  * Redesigned form for delete location
  * Fixed problem with transparency Cover window and font size on Cover Window
  * Added last update information on Cover Page
  * Added new icons from Stephan Beyerle (Thank you very much Stephan)
  * Added background Image to Cover (Thank you very much Stephan again)
* Sun Jan 19 2014  Vlad Vasilyeu <vasvlad@gmail.com> 0.8.5
  * Fixed various small problems
  * Fixed problem with size of font in CoverPage
  * Fixed problem with scroll down for hours in FullWeather page
  * Added possibility to refresh weather forecast using the CoverPage
  * Fixed problem with open many applications(MeeCast) when you click the icon 
* Sat Jan 18 2014  Vlad Vasilyeu <vasvlad@gmail.com> 0.8.4.2
  * Fixed problem with refreshing weather forecast
* Fri Jan 17 2014  Vlad Vasilyeu <vasvlad@gmail.com> 0.8.4.1
  * First release SailfishOS
# << files


