require 'last_kee_diff/entry'
require 'last_kee_diff/version'

require 'csv'
require 'nokogiri'

module LastKeeDiff
  def self.diff(csv_file, xml_file)
    csv_entries = self.read_csv csv_file
    xml_entries = self.read_xml xml_file

    #... extra csv entries
    puts '>> Entries only present in LastPass:'
    (csv_entries.keys - xml_entries.keys).each do |key|
      puts csv_entries[key]
    end

    #... common entries
    puts '>> Common entries (LastPass <-> KeePass):'
    (csv_entries.keys & xml_entries.keys).each do |key|
      io = StringIO.new

      csv_entries[key].instance_variables.each do |att|
        att = att.to_s[1..-1]
        if csv_entries[key].send(att).to_s.sub(/^http:\/\//, '') != xml_entries[key].send(att).to_s.sub(/^http:\/\//, '')
          io.puts "\t#{att.capitalize} changed: ''#{csv_entries[key].send(att)}'' <-> ''#{xml_entries[key].send(att)}''"
        end
      end

      if io.size > 0
        puts key
        puts io.string
      end
    end

    #... extra xml entries
    puts '>> Entries only present in KeePass:'
    (xml_entries.keys - csv_entries.keys).each do |key|
      puts xml_entries[key]
    end
  end

  # CSV format:
  # 0: url
  # 1: username
  # 2: password
  # 3: extra
  # 4: name
  # 5: grouping
  # 6: fav
  def self.read_csv(file_name)
    puts "Reading CSV..."

    entries = {}

    CSV.foreach file_name, headers: true do |row|
      entry = Entry.new row[5].to_s.gsub(/\\/, '/'), row[4], row[1], row[2], row[0]
      self.add_if_not_duplicated entries, entry
    end

    entries
  end

  # XML format:
  # <database>
  #   <group>
  #     <title></title>
  #     <entry>
  #       <title></title>
  #       <username></username>
  #       <password></password>
  #       <url></url>
  #     </entry>
  #     <!-- multiples entries or groups -->
  #   </group>
  #   <!-- multiples groups -->
  # </database>
  def self.read_xml(file_name)
    puts "Reading XML..."

    entries = {}

    File.open file_name do |f|
      doc = Nokogiri::XML f

      doc.xpath('//group').each do |group|
        # skip backups
        next if group.at_css('title').text == 'Backup' && group.parent && group.parent.name != 'group'

        group_name = group.at_css('title').text.tap do |text|
          parent = group.parent
          while parent && parent.name == 'group'
            text.prepend "#{parent.at_css('title').text}/"
            parent = parent.parent
          end
        end

        group.xpath('./entry').each do |entry|
          entry = Entry.new group_name,
                            entry.at_css('title').text,
                            entry.at_css('username').text,
                            entry.at_css('password').text,
                            entry.at_css('url').text

          self.add_if_not_duplicated entries, entry
        end
      end
    end

    entries
  end

  def self.add_if_not_duplicated(entries, entry)
    if entries[entry.key]
      puts "Duplicated key: #{entry.key}"
    else
      entries[entry.key] = entry
    end
  end
end
