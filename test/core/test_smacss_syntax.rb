require 'helper'

class TestSlimSmacssSyntax < TestSlim

  def assert_stripped_html(html, source)
    assert_html(html.split("\n").map(&:strip).join, source)
  end

  def test_base_name_added_to_nested_derived_names
    source = %q{
.body
  .+notice
    .-title
    .title
  .another-block Hello World
}

    assert_stripped_html %{
<div class="body">
  <div class="notice">
    <div class="notice_title"></div>
    <div class="title"></div>
  </div>
  <div class="another-block">Hello World</div>
</div>}, source
  end

  def test_base_name_overrides_parent_base_name
    source = %q{
.body
  .+notice
    .+block
      .-title Hello World
}

    assert_stripped_html %{
<div class="body">
  <div class="notice">
    <div class="block">
      <div class="block_title">
        Hello World
      </div>
    </div>
  </div>
</div>}, source
  end

  def test_base_name_is_appended_to_parent_base_name
    source = %q{
.body
  .+notice
    .+-block
      .-title Hello World
}

    assert_stripped_html %{
<div class="body">
  <div class="notice">
    <div class="notice_block">
      <div class="notice_block_title">
        Hello World
      </div>
    </div>
  </div>
</div>}, source
  end

  def test_work_with_other_shortcut_syntax
    source = %q{
.body
  #bla.+notice
    p.+-block
      em#zoo.-title Hello World
}

    assert_stripped_html %{
<div class="body">
  <div class="notice" id="bla">
    <p class="notice_block">
      <em class="notice_block_title" id="zoo">
        Hello World
      </em>
    </p>
  </div>
</div>}, source
  end


end
