GtkBuilder *widgetstree;

GPid pid;
guint progressbar_handler_id;
gboolean fullpercent;
gboolean pulsebar;

void on_copy_btn_clicked (GtkWidget *widget, gpointer user_data);

void on_cancel_btn_clicked (GtkWidget *widget, gpointer user_data);

gboolean progressbar_handler(gpointer data);

void on_process_end (GPid thepid, gint status, gpointer data);

void do_action(gboolean save);

void on_exitp (GtkWidget *widget, gpointer user_data);

