require 'test_helper'

class CarTest < ActiveSupport::TestCase
 
     def setup
    @car = Car.new(model: "Example", style: "every",
    manufacturer: "goof", status: "ferry", license_no: "ABC-123" , location: "dummy", hourly_rate: "34.56" )
  end 
    
  test "should be valid" do
    assert @car.valid?   
  end
    
    test "model should be present" do
    @car.model = "     "
    assert_not @car.valid?
end
    
    test "style should be present" do
    @car.style = "    "
    assert_not @car.valid?
  end
     test "manufacturer should be present" do
    @car.manufacturer = "    "
    assert_not @car.valid?
  end
     test "status should be present" do
    @car.status = "    "
    assert_not @car.valid?
  end
    
      test "license no should be present" do
    @car.license_no = "    "
    assert_not user.valid?
  end  
      test "location should be present" do
    @car.location = "    "
    assert_not @user.valid?
  end 
      test "hourly_rate should be present" do
    @car.hourly_rate = "    "
    assert_not @user.valid?
  end
    test "model should not be too long" do
    @car.model = "a" * 51
    assert_not @car.valid?
end
    test "license no  should be unique" do
    duplicate_car = @user.dup
    duplicate_car.license_no = @car.license_no.upcase
    @car.save
    assert_not duplicate_car.valid?
end
    
     test "license no validation should accept valid license no " do
    valid_lpno= %w[123456 123WER 23-3456 23-QWER QWER23 456.879 657.ERT QWERTY]
                         
    valid_lpno.each do |valid_lpno|
      @car.license_no = valid_lpno
      assert @car.valid?, "#{valid_lpno.inspect} should be valid"
    end
end
    
    test "license no validation should reject invalid license no" do
    invalid_lpno = %w[1234,678 u&sdf3 ^ertygh EdSasW
                        34567& *123456 DeF234 h1d3@d3 ]
    invalid_lpno.each do |invalid_lpno|
      @car.license_no = invalid_lpno
      assert_not @car.valid?, "#{invalid_lpno.inspect} should be invalid"
    end
end
    
    
end
