class Question
  @@questions = []
  attr_reader :answer

  def initialize(number_one, number_two)
    @number_one = number_one
    @number_two = number_two
    @answer = number_one + number_two
    @@questions.push(self)
    question?
  end

  def question?
    print "What is #{@number_one} plus #{@number_two}: "
  end

  def self.questions?
    @@questions
  end
end
