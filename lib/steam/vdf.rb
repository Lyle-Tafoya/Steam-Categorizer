require "steam/categorizer/version"

module Steam
  require 'json'

  class VDF

    # Parse a VDF string into a hash
    def self.parse(vdf)
      transformed_vdf = vdf.gsub(/^\t*{\n\t+"/, '{"') # Map opening
      transformed_vdf.gsub!(/(".+")\t\t(".*")/, '\1:\2') # Key with string value
      transformed_vdf.gsub!(/(".+")\n\t*{/, '\1:{') # Key with map value
      transformed_vdf.gsub!(/(["}])\n\t*"/, '\1,"') # Key value pair followed by key value pair
      map = JSON.parse("{" + transformed_vdf + "}")

      return map
    end

    # Given a hash, output a VDF string
    def self.generate(map)
      json = JSON.pretty_generate(map, { indent: "\t", space: "" })
      transformed_json = json.split("\n").to_a[1..-2].join("\n") # Remove opening and closing braces
      transformed_json.gsub!(/^\t/, '') # Remove excess indentation
      transformed_json.gsub!(/(\t*)(".+"):{/, "\\1\\2\n\\1{") # Key with map value
      transformed_json.gsub!(/(".+"):(".*"),{,1}/, "\\1\t\t\\2") # Key with string value
      transformed_json.gsub!(/\},/, '}') # Remove trailing commas

      return transformed_json
    end

    def self.pretty_generate(hash)
      VDF.generate(hash)
    end
  end
end
