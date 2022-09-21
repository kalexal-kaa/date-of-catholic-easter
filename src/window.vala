namespace ValaGtkTemplate {

    [GtkTemplate (ui = "/vala-gtk-template/window.ui")]
    class Window : Adw.ApplicationWindow {
		[GtkChild]
		private unowned Gtk.Entry year;
		[GtkChild]
		private unowned Gtk.Button calculate;
		[GtkChild]
		private unowned Gtk.Label result;
        public Window (Adw.Application app) {
            Object (
                application: app,
                title: "Vala & GTK Template"
            );
            year.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        year.icon_press.connect ((pos, event) => {
              year.set_text("");
              year.grab_focus();
        });
            calculate.clicked.connect(on_calculate);
        }
         private void on_calculate(){
		   if(year.get_text().strip().length == 0){
             alert("Enter the year number");
             year.grab_focus();
             return;
           }
             int y = int.parse(year.get_text());
             if(y <= 0){
                 alert("Please enter a valid year number");
                 year.grab_focus();
                 return;
             }
             int a = y % 19;
             int b = y % 4;
             int c = y % 7;
             int k = y / 100;
             int p = (13 + 8 * k) / 25;
             int q = k / 4;
             int M = (15 - p + k - q) % 30;
             int N = (4 + k - q) % 7;
             int d = (19 * a + M) % 30;
             int e = (2*b + 4*c + 6*d + N) % 7;
             int f = d + e;
             int g;
             string h;
             if(f <= 9){
                 g = 22 + d + e;
                 h = "March";
             }else{
                 g = d + e - 9;
                 h = "April";
             }
             if(d == 29 && e == 6){
                 g = 19;
             }else if(d == 28 && e == 6){
                 g = 18;
             }
             result.set_text(h+" "+g.to_string());
		}
		private void alert (string str){
          var dialog_alert = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, str);
          dialog_alert.set_title("Message");
          dialog_alert.response.connect((_) => { dialog_alert.close(); });
          dialog_alert.show();
       }
    }

}
