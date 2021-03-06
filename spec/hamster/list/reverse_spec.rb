require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'hamster/list'

describe Hamster::List do

  describe "#reverse" do

    describe "on a really big list" do

      before do
        @list = Hamster.interval(0, STACK_OVERFLOW_DEPTH)
      end

      it "doesn't run out of stack" do
        lambda { @list.reverse }.should_not raise_error
      end

    end

    it "is lazy" do
      lambda { Hamster.stream { fail }.reverse }.should_not raise_error
    end

    [
      [[], []],
      [["A"], ["A"]],
      [["A", "B", "C"], ["C", "B", "A"]],
    ].each do |values, expected|

      describe "on #{values.inspect}" do

        before do
          @original = Hamster.list(*values)
          @result = @original.reverse { |item| item.downcase }
        end

        it "preserves the original" do
          @original.should == Hamster.list(*values)
        end

        it "returns #{expected.inspect}" do
          @result.should == Hamster.list(*expected)
        end

      end

    end

  end

end
