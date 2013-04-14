require './watcher_dot_net.rb'

describe MSPECTestRunner do
  before(:each) do 
    @test_runner = MSPECTestRunner.new "." 
    $stdout.stub!(:puts) { }
  end
  
  context "initializing MSPECTestRunner" do
    it "should default machine specifications runner to the package location" do
      MSPECTestRunner.mspec_path.should == ".\\packages\\Machine.Specifications.0.5.12\\tools\\mspec-clr4.exe"
    end
  end

  describe "finding test_config" do
    it "should find test config file named Local.testsettings" do
      given_test_config "./Local.testsettings"
      @test_runner.test_config.should == "Local.testsettings"
    end

    it "should find test config file named LocalTestRun.testrunconfig" do
      given_test_config "./LocalTestRun.testrunconfig"
      @test_runner.test_config.should == "LocalTestRun.testrunconfig"
    end

    def given_test_config file_name
      Find.stub!(:find).with(".").and_yield(file_name)
    end
  end
end
