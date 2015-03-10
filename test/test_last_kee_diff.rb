require 'minitest_helper'

class TestLastKeeDiff < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LastKeeDiff::VERSION
  end

  def test_diff
    output = nil

    begin
      stdout_saved = $stdout
      $stdout = StringIO.new

      LastKeeDiff.diff sample_path('last_pass.csv'), sample_path('kee_pass.xml')
    ensure
      output = $stdout
      $stdout = stdout_saved
    end

    expected_lines = [
      "Reading CSV...",
      "Reading XML...",
      ">> Entries only present in LastPass:",
      "B/B1/Name 3",
      "\tUsername: user3",
      "\tPassword: password3",
      "\tURL: http://example.com/3",
      "C/Name 4",
      "\tUsername: user4",
      "\tPassword: password4",
      "\tURL: http://example.com/4",
      ">> Common entries (LastPass <-> KeePass):",
      "A/Name 1",
      "\tUsername changed: '''' <-> ''user1''",
      "B/",
      "\tPassword changed: ''password2'' <-> ''password2_''",
      "\tUrl changed: ''http://example.com/2'' <-> ''http://example.com/2-2''",
      ">> Entries only present in KeePass:",
      "A/A1/Name 5",
      "\tUsername: user5",
      "\tPassword: password5",
      "\tURL: http://example.com/5"
    ]

    i = 0
    output.rewind
    output.each_line do |line|
      assert i < expected_lines.length, 'output longer than expected'
      assert_equal "#{expected_lines[i]}\n", line
      i += 1
    end
  end
end
