class Question
  PAUSE_BETWEEN_QUESTIONS = 2

  attr_accessor :question, :answer, :delay

  def initialize(question:, answer:, delay: 5)
    @question = question
    @answer = answer
    @delay = delay
  end

  def ask!
    say_question
    wait_for_answer
    say_answer
    pause_before_next_question
  end

  def say_question
    `say #{question}`
  end

  def wait_for_answer
    `sleep #{delay}`
  end

  def say_answer
    `say #{answer}`
  end

  def pause_before_next_question
    `sleep #{PAUSE_BETWEEN_QUESTIONS}`
  end
end

class Math::Addition
  def self.add(a, b, delay: nil)
    Question.new(
      question: "#{a} plus #{b}",
      answer: "#{a + b}",
      delay: delay
    )
  end

  def self.one_digit
    add rand(1..9), rand(1..9), delay: 2
  end

  def self.two_digits
    add rand(10..99), rand(10..99), delay: 8
  end

  def self.three_digits(answer_less_than: nil)
    loop do
      a, b = rand(100..999), rand(100..999)
      break add a, b, delay: 15 unless answer_less_than && (a + b >= answer_less_than)
    end
  end
end

loop do
  question = [
    Math::Addition.one_digit,
    Math::Addition.two_digits,
    # Math::Addition.three_digits(answer_less_than: 1000)
  ].sample

  question.ask!
end
