require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'author order' do
    book = Book.create! title: 'デザインパターン'
    john = Author.create! name: 'ジョン'
    richard = Author.create! name: 'リチャード'
    ralph = Author.create! name: 'ラルフ'
    eric = Author.create! name: 'エリック'

    book.authors << [eric, ralph, richard, john]

    # Author#id順
    assert_equal(
      [john, richard, ralph, eric],
      book.authors.order(:id)
    )
    puts book.authors.order(:id).to_sql
    # SELECT "authors".*
    # FROM "authors"
    # INNER JOIN "book_authors"
    # ON "authors"."id" = "book_authors"."author_id"
    # WHERE "book_authors"."book_id" = 1
    # ORDER BY "authors"."id" ASC

    # Authorの追加順
    assert_equal(
      [eric, ralph, richard, john],
      book.authors.order('book_authors.id')
    )
    puts book.authors.order('book_authors.id').to_sql
    # SELECT "authors".*
    # FROM "authors"
    # INNER JOIN "book_authors"
    # ON "authors"."id" = "book_authors"."author_id"
    # WHERE "book_authors"."book_id" = 1
    # ORDER BY book_authors.id
  end
end
