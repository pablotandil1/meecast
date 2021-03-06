AC_PREREQ(2.59)
AC_INIT(omweather, 0.28.13)
AM_INIT_AUTOMAKE(omweather, 0.28.13)
AC_CONFIG_HEADER([src/config.h:src/config.h.in])
AC_CONFIG_SRCDIR([src/weather-main.c])
AC_CANONICAL_HOST
AC_GNU_SOURCE
dnl Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AC_PROG_CC
AC_PROG_LIBTOOL
#Problem in Fremantle
#AC_PROG_INTLTOOL([0.23])
dnl Checks for libraries.
AC_CHECK_LIB([sqlite3], [sqlite3Init], [LIBS="-lsqlite3 $LIBS"])
AC_CHECK_LIB([dl], [dlopen], [LIBS="-ldl $LIBS"])

dnl Checks for header files.
AC_HEADER_DIRENT
AC_HEADER_STDC
AC_CHECK_HEADERS([arpa/inet.h fcntl.h memory.h netdb.h netinet/in.h stdlib.h])
AC_CHECK_HEADERS([libintl.h values.h wchar.h limits.h math.h string.h])
AC_CHECK_HEADERS([sys/param.h sys/socket.h sys/time.h unistd.h])

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_HEADER_TIME
AC_STRUCT_TM
AC_TYPE_SIZE_T

dnl Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_CLOSEDIR_VOID
AC_FUNC_MALLOC
AC_FUNC_MKTIME
AC_FUNC_REALLOC
AC_FUNC_STAT
AC_FUNC_STRFTIME
AC_CHECK_FUNCS([clock_gettime gethostbyname gettimeofday memset strcasecmp strchr strncasecmp])
AC_CHECK_FUNCS([strcspn strdup strerror strstr memmove setlocale strptime sqrt])

dnl glibc2 needs this
AC_DEFINE([_XOPEN_SOURCE], [1], [glibc2 needs this])

dnl Localisation
localedir=`pkg-config osso-af-settings --variable=localedir`
if test "$localedir" == ""; then
#Hack for non Maemo Platform
#    localedir="${datarootdir}/locale"
    localedir="/usr/share/locale"
    #${datadir}
fi
GETTEXT_PACKAGE=$PACKAGE
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE], "${GETTEXT_PACKAGE}", [Name of gettext package])
AC_DEFINE_UNQUOTED([LOCALEDIR], "${localedir}", [Path to store localization files])
ALL_LINGUAS="ru_RU fr_FR fi_FI en_GB en_US it_IT de_DE es_ES es_MX pl_PL bg_BG lv_LV sk_SK"
AM_GLIB_GNU_GETTEXT

dnl Path for .desktop files
DESKTOPDIR=`pkg-config osso-af-settings --variable=homedesktopentrydir`
AC_SUBST(DESKTOPDIR)

AC_ARG_ENABLE(nonmaemo,
      [  --enable-nonmaemo   Not Maemo platform],
      [case "${enableval}" in
            yes) nonmaemo=true ;;
            no)  nonmaemo=false ;;
            *) AC_MSG_ERROR(bad value ${enableval} for --enable-nonmaemo) ;;
      esac],[nonmaemo=false])

if test "$nonmaemo" == "true"; then
    AC_DEFINE(NONMAEMO, 1, [NON MAEMO platform])
fi

AC_ARG_ENABLE(debug,
      [  --enable-debug   Debug],
      [case "${enableval}" in
            yes) debug=true ;;
            no)  debug=false ;;
            *) AC_MSG_ERROR(bad value ${enableval} for --enable-debug) ;;
      esac],[debug=false])

if test "$debug" == "true"; then
    AC_DEFINE(DEBUGFUNCTIONCALL, 1, [DEBUG])
fi


dnl Path for .so .a .la files
DESKTOPLIBDIR=`pkg-config osso-af-settings --variable=hildondesktoplibdir`
AC_SUBST(DESKTOPLIBDIR)

PKG_CHECK_MODULES(GTK, [gtk+-2.0])
AC_SUBST(GTK_LIBS)
AC_SUBST(GTK_CFLAGS)

PKG_CHECK_MODULES(OSSO, [libosso >= 1])
AC_SUBST(OSSO_LIBS)
AC_SUBST(OSSO_CFLAGS)

PKG_CHECK_MODULES(LIBXML2, [libxml-2.0 >= 2.6.16])
AC_SUBST(LIBXML2_LIBS)
AC_SUBST(LIBXML2_CFLAGS)

PKG_CHECK_MODULES(LIBCURL, [libcurl])
AC_SUBST(LIBCURL_LIBS)
AC_SUBST(LIBCURL_CFLAGS)

PKG_CHECK_MODULES(GNOME_VFS, [gnome-vfs-2.0 >= 2.8.4.11 gnome-vfs-module-2.0 >= 2.8.4.11])
AC_SUBST(GNOME_VFS_LIBS)
AC_SUBST(GNOME_VFS_CFLAGS)

PKG_CHECK_MODULES(GCONF, [gconf-2.0 >= 2.6.2])
AC_SUBST(GCONF_LIBS)
AC_SUBST(GCONF_CFLAGS)

PKG_CHECK_MODULES(SQLITE, [sqlite3])
AC_SUBST(SQLITE_LIBS)
AC_SUBST(SQLITE_CFLAGS)


PKG_CHECK_MODULES(DESKTOP, [hildon-desktop], [desktop=yes], [desktop=no])
if test "$hildon-desktop" == "yes"; then 
         AC_DEFINE(DESKTOP, 1, [hildon-desktop used]) 
fi 
AC_SUBST(DESKTOP_LIBS)
AC_SUBST(DESKTOP_CFLAGS)

if test "$nonmaemo" == "false"; then

    PKG_CHECK_MODULES(HILDONDESKTOP, [libhildondesktop], [hildondesktop=yes], [hildondesktop=no]) 
    if test "$hildondesktop" == "yes"; then 
         AC_DEFINE(HILDONDESKTOP, 1, [Hildon desktop used]) 
    else
          PKG_CHECK_MODULES(HILDONDESKTOP, [libhildondesktop-1], [hildondesktop1=yes], [hildondesktop1=no]) 
          if test "$hildondesktop1" == "yes"; then
             AC_DEFINE(OS2009, 1, [Version of hildon libraries])

          fi
#         PKG_CHECK_MODULES(DESK, hildon-status-bar-lib >= 0.7.1) 

    fi
    AC_SUBST(HILDONDESKTOP_LIBS)
    AC_SUBST(HILDONDESKTOP_CFLAGS)
fi

PKG_CHECK_MODULES(HILDON, [hildon-1 >= 0.9.9], [hildon=yes],[hildon=no])
if test "$hildon" == "yes"; then
	  if test "$hildondesktop" == "yes" && test "$nonmaemo" != "true"; then
                 AC_DEFINE(OS2008, 1, [Version of hildon libraries])
          fi
else    
	  PKG_CHECK_MODULES(HILDON_LIBS, [hildon-libs >= 0.12.0])
	  
fi
    AC_SUBST(HILDON_CFLAGS)
    AC_SUBST(HILDON_LIBS)


PKG_CHECK_MODULES(DBUS, [dbus-1],
    [
        use_dbus="yes"
    ],
    [
        use_dbus="no"
        echo 'No New Connectivity DBUS Library!'
    ]
    )
if test "$use_dbus" = "yes"; then
    AC_SUBST(DBUS_CFLAGS)
    AC_SUBST(DBUS_LIBS)
    AC_DEFINE(USE_DBUS, 1,"Set to 1 if enable-dbus is yes")
fi

PKG_CHECK_MODULES(OSSOIC, [osso-ic >= 0.21], [ossoic=yes], [ossoic=no])
if test "$ossoic" == "yes"; then
    AC_DEFINE(OSSOIC, 1 , [OSSO IC used])
fi
AC_SUBST(OSSOIC_LIBS)
AC_SUBST(OSSOIC_CFLAGS)

PKG_CHECK_EXISTS(tablet-browser-interface, [
    AC_DEFINE(ENABLE_BROWSER_INTERFACE, 1,"tablet-browser-interface was found")
  ], [AC_MSG_NOTICE([WARNING: No tablet-browser-interface found, disabling microb interface!])])


dnl GPS
AC_ARG_ENABLE(gps, [ --enable-gps=[yes|no] ], [use_gps=$enableval ])
if test "$use_gps" == "yes"; then
    AC_DEFINE(ENABLE_GPS, 1, [Enable GPS])
fi

AC_ARG_ENABLE(conic, [ --enable-conic=[yes|no] ], [use_conic=$enableval ])
if test "$use_conic" != "no"; then
PKG_CHECK_MODULES(CONIC, [conic],
    [
            use_conic="yes"
    ],
    [
        use_conic="no"
        echo 'No New Connectivity CONIC Library!!!!.'
    ]
)
if test "$use_conic" = "yes"; then
AC_SUBST(CONIC_CFLAGS)
AC_SUBST(CONIC_LIBS)
        AC_DEFINE(USE_CONIC, 1,"Set to 1 if enable-conic is yes")
fi
fi

if test "$hildon" == "yes" && test "$use_gps" == "yes"; then
  PKG_CHECK_MODULES(LOCATION, [liblocation])
  AC_SUBST(LOCATION_CFLAGS)
  AC_SUBST(LOCATION_LIBS)
fi

if test "$hildondesktop1" != "yes"; then
    if test "$hildon" == "yes"; then
        PKG_CHECK_MODULES(LIBOSSOHELP, [libosso >= 1 hildon-help])
    else
        dnl check for osso-help
        PKG_CHECK_MODULES(LIBOSSOHELP, [libossohelp], [libossohelp=yes], [libossohelp=no])
    fi
        AC_SUBST(LIBOSSOHELP_LIBS)
        AC_SUBST(LIBOSSOHELP_CFLAGS)
fi


AC_ARG_ENABLE(clutter,
      [  --enable-clutter   Enable GTK-clutter],
      [case "${enableval}" in
            yes) clutter=true ;;
            no)  clutter=false ;;
            *) AC_MSG_ERROR(bad value ${enableval} for --enable-clutter) ;;
      esac],[clutter=false])

if test "$clutter" == "true"; then
#    PKG_CHECK_MODULES(CLUTTER, [clutter-gtk-0.8 >= 0.8 clutter-x11-0.8 >= 0.8])
    PKG_CHECK_MODULES(CLUTTER, [clutter-gtk-0.8 >= 0.8 ])
    AC_DEFINE(CLUTTER, 1, [Enable GTK-clutter])
    AC_SUBST(CLUTTER_CFLAGS)
    AC_SUBST(CLUTTER_LIBS)
fi
AC_ARG_ENABLE(hildonanimation,
      [  --enable-hildonanimation   Enable Hildon Animation],
      [case "${enableval}" in
            yes) hildonanimation=true ;;
            no)  hildonanimation=false ;;
            *) AC_MSG_ERROR(bad value ${enableval} for --enable-hildonanimation) ;;
      esac],[hildonanimation=false])


if test "$hildonanimation" == "true"; then
#    PKG_CHECK_MODULES(HILDONANIMATION, [clutter-0.8])
    AC_DEFINE(HILDONANIMATION, 1, [Enable Hildon Animation])
    AC_SUBST(HILDONANIMATION_CFLAGS)
    AC_SUBST(HILDONANIMATION_LIBS)
fi




AM_CONDITIONAL(OS2008, test "$hildondesktop" != "xyes")
AM_CONDITIONAL(NONMAEMO, test "x$nonmaemo" == "xtrue")
AM_CONDITIONAL(CLUTTER, test "x$clutter" == "xtrue")
AM_CONDITIONAL(OS2009, test "$hildondesktop1" == "yes")

if test "$hildondesktop1" != "yes"; then
	dnl Help file install directory
	helpfile_enusdir=$datadir/osso-help/en_US
	AC_SUBST(helpfile_enusdir)
	helpfile_engbdir=$datadir/osso-help/en_GB
	AC_SUBST(helpfile_engbdir)
	helpfile_rurudir=$datadir/osso-help/ru_RU
	AC_SUBST(helpfile_rurudir)
	helpfile_fifidir=$datadir/osso-help/fi_FI
	AC_SUBST(helpfile_fifidir)
	helpfile_frfrdir=$datadir/osso-help/fr_FR
	AC_SUBST(helpfile_frfrdir)
	helpfile_ititdir=$datadir/osso-help/it_IT
	AC_SUBST(helpfile_ititdir)
	helpfile_dededir=$datadir/osso-help/de_DE
	AC_SUBST(helpfile_dededir)
	helpfile_esesdir=$datadir/osso-help/es_ES
	AC_SUBST(helpfile_esesdir)
	helpfile_esmxdir=$datadir/osso-help/es_MX
	AC_SUBST(helpfile_esmxdir)
	helpfile_plpldir=$datadir/osso-help/pl_PL
	AC_SUBST(helpfile_plpldir)
	helpfile_bgbgdir=$datadir/osso-help/bg_BG
	AC_SUBST(helpfile_bgbgdir)
	helpfile_lvlvdir=$datadir/osso-help/lv_LV
	AC_SUBST(helpfile_lvlvdir)
	helpfile_skskdir=$datadir/osso-help/sk_SK
	AC_SUBST(helpfile_skskdir)

fi

dnl Config files
if test "$hildondesktop1" == "yes"; then
	AC_CONFIG_FILES([Makefile
		src/Makefile
		po/Makefile.in
		data/Makefile])
else
	AC_CONFIG_FILES([data/help/Makefile
		])
fi
dnl Produce output files
AC_OUTPUT

