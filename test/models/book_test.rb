require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'author order' do
    book = Book.create! title: 'デザインパターン'
    john = Author.create! name: 'ジョン'
    richard = Author.create! name: 'リチャード'
    ralph = Author.create! name: 'ラルフ'
    eric = Author.create! name: 'エリック'

    book.authors << eric
    book.authors << ralph
    book.authors << richard
    book.authors << john

    assert_equal(
      [john, richard, ralph, eric],
      book.authors.order(:id)
    )

    assert_equal(
      [eric, ralph, richard, john],
      book.authors.order('book_authors.id')
    )
  end
end
