require 'test_helper'

class StoreControllerTest < ActionController::TestCase
    test "should get index" do
        get :index
        assert_response :success
        assert_select '#navbar-collapse .nav.navbar-nav li', minimum: 4
        assert_select '.product', minimun: 3
        assert_select '.price', /\$[,\d]+\.\d\d/
    end

end
