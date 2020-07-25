class Dog 
  
  attr_accessor :name, :breed, :id
  
  def initialize(dog_data)
    dog_data.each do |key,value|
      self.send(("#{key}="),value)
     @name = name
     @breed = breed
     @id = id
    end
  end
  
  def self.create_table
    
    sql = <<-SQL
              CREATE TABLE IF NOT EXISTS dogs (
              id INTEGER PRIMARY KEY,
              name TEXT,
              breed TEXT
              )
          SQL
          
          DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE dogs"
    
    DB[:conn].execute(sql)
  end
  
  def save
    
    sql = <<-SQL
          INSERT INTO dogs (name, breed)
          VALUES (?, ?)
          SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
  
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    
    self
    
  end
  
  def self.create(attributes)
   
    dog = Dog.new(attributes)
    dog.save
    
  end
  
  def self.new_from_db(row)
    
     dog = Dog.new
     dog.id = row[0]
     dog.name = row[1]
     dog.breed = row[2]
     dog
  
  end
  
end