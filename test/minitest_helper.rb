$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'last_kee_diff'

require 'minitest/autorun'

def sample_path(file_name)
  File.expand_path "../samples/#{file_name}", __FILE__
end

