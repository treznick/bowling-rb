require 'spec_helper'
require 'bowling'
describe Bowling do
  let(:game) {Bowling.new}
  describe "#game" do
    it "should be a hash" do
      expect(game.game).to be_a Hash
    end
  end

  describe "#score" do
    it "should return a sum of the rolls" do
      game.roll 3
      game.roll 4
      expect(game.score).to eq 7
    end

    it "should count spares correctly" do
      game.roll 3
      game.roll 7  # spare!
      expect(game.current_frame).to eq 2
      game.roll 4
      game.roll 0
      expect(game.score).to eq(18)
    end

    it "should work with a strike and a spare" do
      game.roll 5 
      game.roll 5 # spare!
      game.roll 3 
      game.roll 7 # spare!
      game.roll 5
      game.roll 0
      expect(game.score).to eq 33
    end


    it "strikes should correctly increment the current_frame" do
      game.roll 10
      expect(game.current_frame).to eq 2
    end

    it "should count strikes correctly" do
      game.roll 10 # frame 1
      # skip second roll of frame 1
      game.roll 3 # frame 2
      game.roll 5 # frame 2
      expect(game.score).to eq 26
    end
  end

  describe "#roll" do
    it "should push a new score onto the game stack" do
      game.roll(3)
      expect(game.score).to eq 3
    end
  end



end