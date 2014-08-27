class Bowling
  attr_accessor :game, :current_frame
  def initialize
    @game = {
              1  => {frame_score: 0, rolls: []},
              2  => {frame_score: 0, rolls: []},
              3  => {frame_score: 0, rolls: []},
              4  => {frame_score: 0, rolls: []},
              5  => {frame_score: 0, rolls: []},
              6  => {frame_score: 0, rolls: []},
              7  => {frame_score: 0, rolls: []},
              8  => {frame_score: 0, rolls: []},
              9  => {frame_score: 0, rolls: []},
              10 => {frame_score: 0, rolls: []}
            }
      @current_frame = 1
  end
  def roll(score)
    @game[@current_frame][:frame_score] += score
    
    if last_was_strike?
      @game[@current_frame - 1][:frame_score] += score
    end

    if beginning_of_frame?
      if last_was_spare?
        @game[@current_frame - 1][:frame_score] += score
      end

      @game[@current_frame][:rolls] << score

      if score == 10
        next_frame!
      end
    else
      @game[@current_frame][:rolls] << score
      next_frame!
    end
  end

  def score
    @game.map{|k,v| v[:frame_score]}.inject(&:+)
  end

  private

  def next_frame!
    @current_frame += 1
  end

  def beginning_of_frame?
    @game[@current_frame][:rolls].length == 0
  end

  def last_was_spare?
    @current_frame != 1 && 
    @game[@current_frame - 1][:frame_score] == 10 && 
    @game[@current_frame - 1][:rolls].length > 1
  end

  def last_was_strike?
    @current_frame != 1 && 
    @game[@current_frame - 1][:frame_score] >= 10 && 
    @game[@current_frame - 1][:rolls].length == 1
  end


end