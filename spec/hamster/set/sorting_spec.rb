require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'hamster/set'

describe Hamster::Set do

  [
    [:sort, lambda { |left, right| left.length <=> right.length }],
    [:sort_by, lambda { |item| item.length }],
  ].each do |method, comparator|

    describe "##{method}" do

      [
        [[], []],
        [["A"], ["A"]],
        [["Ichi", "Ni", "San"], ["Ni", "San", "Ichi"]],
      ].each do |values, expected|

        describe "on #{values.inspect}" do

          before do
            @original = Hamster.set(*values)
          end

          describe "with a block" do

            before do
              @result = @original.send(method, &comparator)
            end

            it "returns #{expected.inspect}" do
              @result.should == Hamster.list(*expected)
            end

          end

          describe "without a block" do

            before do
              @result = @original.send(method)
            end

            it "returns #{expected.sort.inspect}" do
              @result.should == Hamster.list(*expected.sort)
            end

          end

        end

      end

    end

  end

end
