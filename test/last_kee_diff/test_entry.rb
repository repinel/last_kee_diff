require 'minitest_helper'

class TestEntry < Minitest::Test
  def setup
    @entry = LastKeeDiff::Entry.new 'Email', 'Example', 'foo@example.com', '123', 'http://example.com'
  end

  def test_it_initalizes_attributes
    assert_equal 'Email', @entry.group_name
    assert_equal 'Example', @entry.title
    assert_equal 'foo@example.com', @entry.username
    assert_equal '123', @entry.password
    assert_equal 'http://example.com', @entry.url
  end

  def test_it_converts_entry_to_string
    assert_equal "Email/Example\n\tUsername: foo@example.com\n\tPassword: 123\n\tURL: http://example.com", @entry.to_s
  end

  def test_it_generates_key_from_group_and_title
    assert_equal 'Email/Example', @entry.key
  end
end
