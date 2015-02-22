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

    def ==(other)
      self.group_name == other.group_name && self.title == other.title &&
        self.username == other.username && self.password == other.password &&
        self.url == other.url
    end

    def to_s
      %{#{self.key}
  \tUsername: #{self.username}
  \tPassoword: #{self.password}
  \tURL: #{self.url}}
    end

    def key
      "#{self.group_name}/#{self.title}"
    end
  end
end
