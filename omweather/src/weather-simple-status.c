/* vim: set sw=4 ts=4 et: */
/*
 * This file is part of Other Maemo Weather(omweather)
 *
 * Copyright (C) 2006-2010 Vlad Vasiliev
 * Copyright (C) 2006-2010 Pavel Fialko
 *        
 * Copyright (C) 2008 Andrew Zhilin
 *		      az@pocketpcrussia.com 
 *	for default icon set (Glance)
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU weather-config.h General Public
 * License along with this software; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
*/
/*******************************************************************************/
#include "weather-simple-status.h"
#include "weather-simple-settings.h"
#include "weather-popup.h"
/*******************************************************************************/
void
simple_settings_button_handler(GtkWidget *button, gpointer user_data){
#ifdef DEBUGFUNCTIONCALL
    START_FUNCTION;
#endif
    weather_simple_window_settings(user_data);
}
/*******************************************************************************/
GtkWidget*
create_stations_buttons(void){
  GtkWidget
          *box = NULL,
          *station1 = NULL,
          *station2 = NULL,
          *station3 = NULL,
          *station4 = NULL;
#ifdef DEBUGFUNCTIONCALL
    START_FUNCTION;
#endif
    box = gtk_hbox_new(TRUE, 5);
    station1 = gtk_button_new_with_label ("Station1");
    gtk_widget_set_size_request(station1, 150, 60);
    gtk_widget_show (station1);
    gtk_box_pack_start(GTK_BOX(box), station1, TRUE, TRUE, 0);
    station2 = gtk_button_new_with_label ("Station2");
    gtk_widget_set_size_request(station2, 150, 60);
    gtk_widget_show (station2);
    gtk_box_pack_start(GTK_BOX(box), station2, TRUE, TRUE, 0);
    station3 = gtk_button_new_with_label ("Station3");
    gtk_widget_set_size_request(station3, 150, 60);
    gtk_widget_show (station3);
    gtk_box_pack_start(GTK_BOX(box), station3, TRUE, TRUE, 0);
    station4 = gtk_button_new_with_label ("Station4");
    gtk_widget_set_size_request(station4, 150, 60);
    gtk_widget_show (station4);
    gtk_box_pack_start(GTK_BOX(box), station4, TRUE, TRUE, 0);
    return box;
}
/*******************************************************************************/
void
weather_simple_window_status(GtkWidget *widget, gpointer user_data){
  GtkWidget     *window = NULL,
                *main_table = NULL,
                *settings_button = NULL,
                *help_button = NULL,
                *left_alignment = NULL,
                *right_alignment = NULL,
                *vertical1_alignment = NULL,
                *vertical2_alignment = NULL,
                *vertical3_alignment = NULL;
/*
                *collapsed_button = NULL,
                *expanded_button = NULL,
                *hbox_view_mode = NULL;
  GSList        *group_view_mode = NULL; 
*/
  gint          result;
#ifdef DEBUGFUNCTIONCALL
    START_FUNCTION;
#endif
    window = gtk_dialog_new();
    gtk_window_set_title(GTK_WINDOW(window), "OMWeather");
    gtk_widget_show(window);

    main_table = gtk_table_new(6,7, FALSE);

    left_alignment = gtk_alignment_new (0.5, 0.5, 1, 1  );
    gtk_widget_set_size_request(left_alignment, 20, -1);
    gtk_table_attach((GtkTable*)main_table, left_alignment,
                                0, 1, 0, 1,
                                GTK_FILL | GTK_EXPAND | GTK_SHRINK,
                                (GtkAttachOptions)0, 0, 0 );
    gtk_widget_show (left_alignment);
/*
    stations_box = create_stations_buttons();
    gtk_widget_show (stations_box);
    gtk_table_attach((GtkTable*)main_table,stations_box,
                                1, 5, 1, 2, (GtkAttachOptions)0,
                                (GtkAttachOptions)0, 0, 0 );
*/
    right_alignment = gtk_alignment_new (0.5, 0.5, 1, 1  );
    gtk_widget_set_size_request(right_alignment, 20, -1);
    gtk_table_attach((GtkTable*)main_table, right_alignment,
                                6, 7, 0, 1,
                                GTK_FILL | GTK_EXPAND | GTK_SHRINK,
                                (GtkAttachOptions)0, 0, 0 );
    gtk_widget_show (right_alignment);

    vertical1_alignment = gtk_alignment_new (0.5, 0.5, 1, 1  );
    gtk_widget_set_size_request(vertical1_alignment, -1, 20);
    gtk_table_attach((GtkTable*)main_table, vertical1_alignment,
                                0, 6, 2, 3,
                                (GtkAttachOptions)0,
                                GTK_FILL |  GTK_SHRINK,
                                0, 0 );
    gtk_widget_show (vertical1_alignment);


/*    hbox_view_mode = gtk_hbox_new(TRUE, 0);
    group_view_mode = NULL;
    collapsed_button  = gtk_radio_button_new(NULL);
    gtk_container_add(GTK_CONTAINER(collapsed_button), gtk_label_new(_("Collapsed")));
        gtk_widget_set_size_request(collapsed_button, 150, 60);
//    GLADE_HOOKUP_OBJECT(window, collapsed_button, "collapsed_button");
    gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(collapsed_button), FALSE);
    gtk_box_pack_start (GTK_BOX (hbox_view_mode), collapsed_button, TRUE, TRUE, 0);
    gtk_radio_button_set_group(GTK_RADIO_BUTTON(collapsed_button), group_view_mode);

    expanded_button  = gtk_radio_button_new(NULL);
    gtk_container_add(GTK_CONTAINER(expanded_button), gtk_label_new(_("Expanded")));
    gtk_widget_set_size_request(expanded_button, 150, 60);
  //  GLADE_HOOKUP_OBJECT(window, expanded_button, "expanded_button");
    gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(expanded_button), FALSE);
    group_view_mode = gtk_radio_button_get_group(GTK_RADIO_BUTTON(collapsed_button));
    gtk_radio_button_set_group(GTK_RADIO_BUTTON(expanded_button), group_view_mode);
    gtk_box_pack_start (GTK_BOX (hbox_view_mode), expanded_button, TRUE, TRUE, 0);

    gtk_widget_show_all(hbox_view_mode);

    gtk_table_attach((GtkTable*)main_table, hbox_view_mode,
                                1, 3, 3, 4,
                                GTK_FILL | GTK_EXPAND,
                                (GtkAttachOptions)0, 5, 0 );*/

    fprintf(stderr, "\n%d\n", app->config->view_mode);

    settings_button = gtk_button_new_with_label (_("Settings"));
    gtk_widget_set_size_request(settings_button, 320, 60);
    gtk_widget_show (settings_button);
    gtk_table_attach((GtkTable*)main_table, settings_button,
                                3, 5, 3, 4, (GtkAttachOptions)0,
                                (GtkAttachOptions)0, 0, 0 );
    g_signal_connect(G_OBJECT(settings_button), "button-release-event",
                     G_CALLBACK(simple_settings_button_handler),
                     (gpointer)window);


    vertical2_alignment = gtk_alignment_new (0.5, 0.5, 1, 1  );
    gtk_widget_set_size_request(vertical2_alignment, -1, 20);
    gtk_table_attach((GtkTable*)main_table, vertical2_alignment,
                                0, 6, 4, 5,
                                (GtkAttachOptions)0,
                                GTK_FILL | GTK_SHRINK,
                                0, 0 );
    gtk_widget_show (vertical2_alignment);


    help_button = gtk_button_new_with_label (_("About"));
    gtk_widget_set_size_request(help_button, 320, 60);
    gtk_widget_show (help_button);
    gtk_table_attach((GtkTable*)main_table, help_button,
                                1, 3, 3, 4, (GtkAttachOptions)0,
                                (GtkAttachOptions)0, 5, 0 );
    g_signal_connect_after(help_button, "clicked",
                        G_CALLBACK(about_button_handler), NULL);
    vertical3_alignment = gtk_alignment_new (0.5, 0.5, 1, 1  );
    gtk_widget_set_size_request(vertical3_alignment, -1, 20);
    gtk_table_attach((GtkTable*)main_table, vertical3_alignment,
                                0, 6, 6, 7,
                                (GtkAttachOptions)0,
                                GTK_FILL | GTK_EXPAND | GTK_SHRINK,
                                0, 0 );
    gtk_widget_show (vertical3_alignment);

    gtk_box_pack_start(GTK_BOX(GTK_DIALOG(window)->vbox),
                       main_table, TRUE, TRUE, 0);

    gtk_widget_show(main_table);

    /* start dialog window */
    result = gtk_dialog_run(GTK_DIALOG(window));
    gtk_box_pack_start(GTK_BOX(GTK_DIALOG(window)->vbox),
                       main_table, TRUE, TRUE, 0);

    if (window)
        gtk_widget_destroy(window);

}
/*******************************************************************************/
