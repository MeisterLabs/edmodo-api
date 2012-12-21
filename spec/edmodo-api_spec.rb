# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), "/spec_helper")

describe Edmodo::API::Client do
  describe 'Initialization' do
    it 'should accept an api key in the constructor' do
      Edmodo::API::Client.new('1234567890abcdefghijkl').api_key.should == '1234567890abcdefghijkl'
    end

    it "should be initialized with sandbox mode by default" do
      Edmodo::API::Client.new('1234567890abcdefghijkl' ).mode.should == :sandbox
    end

    it "should be initialized with production mode if passed to the initialize method" do
      Edmodo::API::Client.new('1234567890abcdefghijkl', mode: :production).mode.should == :production
    end

    it "should be initialized with sandbox mode if passed to the initialize method" do
      Edmodo::API::Client.new('1234567890abcdefghijkl', mode: :sandbox).mode.should == :sandbox
    end

    it "should throw an exception if an unkown mode is passed to the initialize method" do
      expect { Edmodo::API::Client.new('1234567890abcdefghijkl', mode: :mymode) }.to raise_error
    end

    it "should throw an exception if no api key is passed to the initialize method" do
      expect { Edmodo::API::Client.new }.to raise_error
    end
  end

  describe 'Config' do
    it 'should have a version on the config' do
      Edmodo::API::Config.version.should_not be_empty
    end

    it 'should have a production endopoint' do
      Edmodo::API::Config.endpoints[:production].should_not be_empty
    end

    it 'should have a sandbox endpoint' do
      Edmodo::API::Config.endpoints[:sandbox].should_not be_empty
    end
  end

  describe 'GET Requests' do
    before do
      api_key = "1234567890abcdefghijklmn"
      @client = Edmodo::API::Client.new(api_key)
    end

    it 'should get the correct hash back from the launchRequest request' do
      
      response = @client.launch_requests("5c18c7")

      response.should == {"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png", "groups"=>[{"group_id"=>379557, "is_owner"=>1}, {"group_id"=>379562, "is_owner"=>1}]}
    end

    it 'should get the correct hash back from the profiles request' do
      
      response = @client.profiles("b020c42d1")

      response.should == [{"user_token"=>"b020c42d1", "school"=>{"edmodo_school_id"=>123456, "nces_school_id"=>"ABC987654", "name"=>"Edmodo High", "address"=>"60 E. 3rd Avenue, #390", "city"=>"San Mateo", "state"=>"CA", "zip_code"=>"94401", "country_code"=>"US"}}]
    end

    it 'should get the correct hash back from the users request' do
      
      users_ids = ["b020c42d1","jd3i1c0pl"]
      response = @client.users(users_ids)

      response.should == [{"user_type"=>"TEACHER", "user_token"=>"b020c42d1", "first_name"=>"Bob", "last_name"=>"Smith", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}, {"user_type"=>"STUDENT", "user_token"=>"jd3i1c0pl", "first_name"=>"Jane", "last_name"=>"Student", "avatar_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar.png", "thumb_url"=>"http://edmodoimages.s3.amazonaws.com/default_avatar_t.png"}]
    end

    it 'should get the correct hash back from the users request' do
      pending "Need to finish implementing this method"
    end

    it 'should get the correct hash back from the groups request' do
      pending "Need to finish implementing this method"
    end

    it 'should get the correct hash back from the groups_for_user request' do
      pending "Need to finish implementing this method"
    end

    it 'should get the correct hash back from the members request' do
      pending "Need to finish implementing this method"
    end

  end

  describe 'POST Requests' do
    before do
      api_key = "1234567890abcdefghijklmn"
      @client = Edmodo::API::Client.new(api_key)
    end

    it 'should get the correct hash response from the registerBadge request' do
      response = @client.register_badge("Good Job", "You did a good job", "http://www.edmodo.com/badge_image.png")
      
      response.should == {"badge_id" => 6580}
    end

  end

end