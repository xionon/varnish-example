require 'test_helper'

class SlowThingsControllerTest < ActionController::TestCase
  setup do
    @slow_thing = slow_things(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slow_things)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slow_thing" do
    assert_difference('SlowThing.count') do
      post :create, slow_thing: { name: @slow_thing.name }
    end

    assert_redirected_to slow_thing_path(assigns(:slow_thing))
  end

  test "should show slow_thing" do
    get :show, id: @slow_thing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slow_thing
    assert_response :success
  end

  test "should update slow_thing" do
    patch :update, id: @slow_thing, slow_thing: { name: @slow_thing.name }
    assert_redirected_to slow_thing_path(assigns(:slow_thing))
  end

  test "should destroy slow_thing" do
    assert_difference('SlowThing.count', -1) do
      delete :destroy, id: @slow_thing
    end

    assert_redirected_to slow_things_path
  end
end
