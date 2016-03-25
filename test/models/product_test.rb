require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    fixtures :products

    test "product attributes must not be empty" do
        # свойства товара не должны оставаться пустыми
        product = Product.new
        assert product.invalid?
        assert product.errors[:title].any?
        assert product.errors[:description].any?
        assert product.errors[:price].any?
    end

    test "product price must be positive" do
        # цена товара должна быть положительной
        product = Product.new(title: "My Book Title", description: "yyy")
        product.price = -1
        assert product.invalid?
        assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

        # должна быть больше или равна 0.01
        product.price = 0
        assert product.invalid?
        assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
        product.price = 1
        assert product.valid?
    end

    test "product is not valid without a unique title" do
        # если у товара нет уникального названия, то он недопустим
        product = Product.new(title: products(:ruby).title,
                              description: "yyy",
                              price: 1)
        assert product.invalid?
        assert_equal ["has already been taken"], product.errors[:title]
        # уже было использовано
    end

    # test "product is not valid without a unique title - i18n" do
    #     product = Product.new(title: products(:ruby).title,
    #                           description: "yyy",
    #                           price: 1)
    #     assert product.invalid?
    #     assert_equal [I18n.translate('activerecord.errors.messages.taken')], product.errors[:title]
    # end
end