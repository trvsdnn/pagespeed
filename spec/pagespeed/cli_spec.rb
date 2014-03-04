require 'pagespeed/cli'

describe PageSpeed::CLI do
  subject(:cli) { described_class }

  before do
    IO.any_instance.stub(:puts) # globally
  end

  it "has no parameters" do
    actual = cli.set_options([])
    expect(actual).to eq({"strategy" => "desktop"})
  end

  it "has help parameter" do
    lambda { cli.set_options(["-h"]) }.should raise_error SystemExit
  end

  it "has version parameter" do
    lambda { cli.set_options(["-v"]) }.should raise_error SystemExit
  end

  it "has incomplete strategy parameter" do
    lambda { cli.set_options(["-s"]) }.should raise_error SystemExit
  end

  it "has complete strategy parameter" do
    actual = cli.set_options(["-s", "mobile"])
    expect(actual).to eq({"strategy" => "mobile"})
  end

  it "has positional url argument" do
    actual = cli.set_options(["google.com"])
    expect(actual).to eq({"strategy" => "desktop"})
  end

end
