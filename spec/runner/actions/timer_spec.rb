require File.dirname(__FILE__) + '/../../spec_helper'
require 'mspec/runner/actions/timer'
require 'mspec/runner/mspec'
require 'time'

describe TimerAction do
  before :each do
    @timer = TimerAction.new
  end

  it "responds to #start by recording the current time" do
    Time.should_receive(:now)
    @timer.start
  end

  it "responds to #finish by recording the current time" do
    Time.should_receive(:now)
    @timer.finish
  end

  it "responds to #elapsed by returning the difference between stop and start" do
    Time.stub(:now).and_return(Time.parse('Mon Mar 30 14:05:19 -0700 2009'))
    @timer.start
    Time.stub(:now).and_return(Time.parse('Mon Mar 30 14:05:52 -0700 2009'))
    @timer.finish
    @timer.elapsed.should == 33
  end

  it "responds to #format by returning a readable string of elapsed time" do
    Time.stub(:now).and_return(Time.parse('Mon Mar 30 14:05:19 -0700 2009'))
    @timer.start
    Time.stub(:now).and_return(Time.parse('Mon Mar 30 14:05:52 -0700 2009'))
    @timer.finish
    @timer.format.should == "Finished in 33.000000 seconds"
  end

  it "responds to #register by registering itself with MSpec for appropriate actions" do
    MSpec.should_receive(:register).with(:start, @timer)
    MSpec.should_receive(:register).with(:finish, @timer)
    @timer.register
  end
end
