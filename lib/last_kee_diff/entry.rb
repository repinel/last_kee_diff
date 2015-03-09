module LastKeeDiff
  class Entry
    attr_reader :group_name, :title, :username, :password, :url

    def initialize(group_name, title, username, password, url)
      @group_name = group_name
      @title = title
      @username = username
      @password = password
      @url = url
    end

    def to_s
      [
        self.key,
        "Username: #{self.username}",
        "Password: #{self.password}",
        "URL: #{self.url}"
      ].join("\n\t")
    end

    def key
      "#{self.group_name}/#{self.title}"
    end
  end
end
