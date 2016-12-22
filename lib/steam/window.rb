require "steam/categorizer/version"

module Steam
  require 'gtk3'

  class Window
    def initialize(library)

      app = Gtk::Application.new('org.gtk.example', :flags_none)
      app.signal_connect "activate" do |application|
        window = Gtk::ApplicationWindow.new(application)
        window.set_title("SteamCategorizer")
        window.set_border_width(10)
        
        grid = Gtk::Grid.new()
        window.add(grid)

        button = Gtk::Button.new(:label=>'Retrieve Categories')
        button.signal_connect('clicked') { library.collect_metadata() }
        grid.attach(button, 0, 0, 1, 1)
        
        button = Gtk::Button.new(:label=>'Export Steam Config')
        button.signal_connect('clicked') { library.generate_steam_config(); library.export_steam_config() }
        grid.attach(button, 1, 0, 1, 1)

        button = Gtk::Button.new(:label=>'Quit')
        button.signal_connect('clicked') { window.destroy }
        grid.attach(button, 0, 1, 2, 1)

        window.show_all()
      end
      app.run()
    end
  end

end
