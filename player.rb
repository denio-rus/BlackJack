class Player
  attr_reader :name

  def initialize(name)
    @name = name
    validate!
  end

  private

  def validate!
    raise "Sorry, name can't be blank" if name.empty?
    raise 'Incorrect name, please use Latin or Cyrillic characters (3 letters min).' if name !~ /^[а-яa-z]{3,}/i
  end
end
