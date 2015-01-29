# scores format: (Player-1 - Player-2) 6-5,4-6,6-3
# incase of a tie breaker: 7-5
class MatchResult
  def initialize(scores)
    @scores = scores != 'default-1' && scores != 'default-2' ? scores.split(/[-,,]/).map(&:to_i) : scores
    @result = (1 if scores == 'default-1') || (2 if scores == 'default-2') || -1
    if @result == -1
      # to check if score for 1 set has been input
      validation_1 = @scores.length == 2
      # to check if any input > 7
      validation_2 = @scores.any? { |score| score > 7 }
      @result = 3 if validation_1 || validation_2
    end
  end
  
  # returns who won the match
  # output:
  # 0 for bad input/incomplete match
  # 1 for player-1
  # 2 for player-2
  # 3 bad input for sure 
  def result
    return @result if @result != -1
    return @result = (@scores.length == 4) ? two_sets : three_sets
  end

  # returns an array of points
  # returns (points_player_1 , points_player_2)
  # returns (0,0) for bad input
  def points
    temp = self.result
    (return [0, 0]) if temp == 3  
    return (complete_match_points if temp == 1 || temp == 2) || incomplete_match_points
  end

  private

  # helper method: called by RESULT method for valid matches with 2 sets
  def two_sets
    set_results = []
    [0, 2].each do |i|
      # tie breaker (assuming a 7 point tie breaker) or a 7-5 scores     
      if @scores[i] == 7 || @scores[i+1] == 7
        set_results << ( @scores[i] == 7 ? 1 : 2 )
      # regular set victory - 6 games with a margin of 2
      else
        return 0 if ( @scores[0] - @scores[1] ).abs < 2
        set_results << ( @scores[i] == 6 ? 1 : 2 )
      end  
    end 
    # 0 for incomplete match e.g: 6-4,5-3
    return (set_results[0] if set_results[0] == set_results[1]) || 0    
  end

  # helper method: called by RESULT method for valid matches with 3 sets
  def three_sets
    set_results = []
    [0, 2, 4].each do |i|
      # tie breaker (assuming a 7 point tie breaker) or a 7-5 scores     
      if @scores[i] == 7 || @scores[i + 1] == 7
        set_results << (@scores[i] == 7 ? 1 : 2)
      # regular set victory - 6 games with a margin of 2
      else
        return 0 if (@scores[0] - @scores[1]).abs < 2
        set_results << (@scores[i] == 6 ? 1 : 2)
      end  
    end 
    # checks if the result has been decided in the first 2 sets 
    # but the 3rd set is also present in the input
    return 3 if set_results[0] == set_results[1]
    return  set_results.count(1) ? 1 : 2
  end

  # helper method: called by POINTS for complete matches
  def complete_match_points
    points = [0, 0]
    @result = self.result
    points[@result - 1] = (@scores.length == 6) ? 12 : 14
    runner_up = (@result == 1) ? 2 : 1
    runner_up_points = player_points(runner_up)
    points[runner_up - 1] = runner_up_points < 8 ? runner_up_points : 8
    return points
  end

  # helper method: called by POINTS for complete matches
  def incomplete_match_points
    points = [0, 0]
    player_1_points = player_points(1)
    player_2_points = player_points(2)
    points[0] = player_1_points < 10 ? player_1_points : 10
    points[1] = player_2_points < 10 ? player_2_points : 10
    return points
  end

  # helper method: returns the POINTS of a player given the player number
  def player_points(player)
    player_scores = []   
    @scores.each_with_index { |score,index| (player_scores << score ; player +=2) if index == (player - 1) }
    player_scores = player_scores.sort! { |x, y| y <=> x }
    return player_scores[0] + player_scores[1]
  end
end
