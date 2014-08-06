module TheMill
  class Puppy
    attr_reader :breed, :name, :age, :id, :created_at
    
    def initialize(breed, name, age, id=nil, created_at=nil)
      @breed = breed
      @name = name
      @age = age
      @id = id
      @created_at = created_at
    end
  end
end
