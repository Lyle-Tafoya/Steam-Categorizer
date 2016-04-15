require "steam/categorizer/version"

module Steam
  module Categorizer
    require 'httparty'
    require 'nokogiri'
    require 'json'
    require 'ruby-progressbar'
    require 'vdf4r'
    require 'set'

    class GameLibrary

      def initialize(api_key, steam_id, birthday)
        url = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{api_key}&steamid=#{steam_id}&include_appinfo=true&format=json"
        @owned_games = HTTParty.get(url)['response']['games']
        @birthday = birthday
        @tag_map = {}
        @all_tags = Set.new
        @categories = {}
        @category_config = {}
      end

      # Lookup store page for each game and compile a hash of tags
      def populate_tags()
        progressbar = ProgressBar.create(:title => "Looking up user defined tags", :total => @owned_games.size)
        headers = { 'Cookie'=>"birthtime=#{@birthday}; lastagecheckage=#{Time.at(@birthday).strftime("%e-%B-%Y")}" }

        # 16 Threads should be sufficient
        @owned_games.each_slice(16) do |games|
          threads = []
          games.each do |game|
            threads.push(Thread.new {
              progressbar.increment
              store_page = Nokogiri::HTML(HTTParty.get("http://store.steampowered.com/app/#{game['appid']}/", :headers=>headers))

              discovered_game_tags = Set.new

              # Scan developer defined game categories
              store_page.css("div.game_area_details_specs").css("a.name").each do |category_node|
                next if category_node.text().strip() == 'Downloadable Content'
                discovered_game_tags.add(category_node.text)
              end

              # Identify all community tags associated with this game
              tags_script = store_page.search("script").select{ |script_node| script_node.text.include?('InitAppTagModal') }
              unless tags_script.empty?
                steam_tags = JSON.parse(tags_script.first.text[/\[\{.*tagid.*\}\]/])
                steam_tags.each do |steam_tag|
                  discovered_game_tags.add(steam_tag['name'])
                end
              end

              store_page.search("script").each do |script_element|
                next unless script_element.text.include?("InitAppTagModal")
                steam_tags = JSON.parse(script_element.text[/\[\{\".*tagid.*\}\]/])
                steam_tags.each do |steam_tag|
                  discovered_game_tags.add(steam_tag['name'])
                end
              end

              next if discovered_game_tags.empty?
              @tag_map[game['appid']] = discovered_game_tags.to_a
              @all_tags.merge(discovered_game_tags)
            })
          end
          threads.each do |thread|
            thread.join()
          end
        end
      end

      # Compile list of category names to be used and assign id values
      def compile_categories(preferences_file)
        all_categories = Set.new
        @category_config = JSON.parse(File.read(preferences_file))
        @all_tags.to_a.sort.each do |tag_name|
          next unless @category_config.key?(tag_name)
          @category_config[tag_name].each do |category_name|
            all_categories.add(category_name)
          end
        end
        all_categories.to_a.sort.each do |category_name|
          @categories[category_name] = "#{@categories.size}"
        end
      end

      # Generate the "apps" map for the vdf config file
      def generate_steam_config(steam_config_filename)
        apps = {}
        @tag_map.each do |appid, steam_tags|
          app_categories = {}
          steam_tags.each do |tag_name|
            next unless @category_config.key?(tag_name)
            @category_config[tag_name].each do |category_name|
              app_categories[@categories[category_name]] = category_name
            end
          end
          next if app_categories.empty?
          apps["#{appid}"] = { "tags" => app_categories }
        end

        # Open the existing steam config file
        vdf4r_parser = VDF4R::Parser.new(File.open(steam_config_filename))
        steam_config = vdf4r_parser.parse

        # Delete any existing categories
        steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'].each do |appid, app_map|
          if app_map.key?("tags")
            steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'][appid].delete('tags')
            if steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'][appid].empty?
              steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'].delete(appid)
            end
          end
        end
        # Merge the newly generated apps map with the old one
        apps.each do |appid, app_map|
          if steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'].key?(appid)
            steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'][appid].merge!(apps[appid])
          else
            steam_config['UserRoamingConfigStore']['Software']['Valve']['Steam']['apps'][appid] = apps[appid]
          end
        end

        return steam_config
      end
    end

  end
end
