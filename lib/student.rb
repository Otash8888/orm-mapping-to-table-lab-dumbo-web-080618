class Student

attr_reader :id
attr_accessor :name, :grade

def initialize(name,grade)
  @name = name
  @grade = grade
end

  def self.create_table
    sql = <<-SQL
            CREATE TABLE students
            (id INTEGER PRIMARY KEY,
             name TEXT,
             grade TEXT);
            SQL
   DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
            DROP TABLE students
            SQL
    DB[:conn].execute(sql)

  end

def change_id=(x)
  @id = x
end


def save
  sql = <<-SQL
          INSERT INTO students (
          name, grade)
          VALUES (?,?);
          SQL
  DB[:conn].execute(sql,self.name,self.grade)
  sql1 =         <<-SQL
              SELECT * FROM students
              ORDER BY id DESC
              LIMIT 1
              SQL
   student_arr = DB[:conn].execute(sql1)
  self.change_id = student_arr[0][0]
end

def self.create (hash)
  name = hash[:name]
  grade = hash[:grade]
  student1 = self.new(name,grade)
  student1.save
  student1
end

def self.all
 @@all
end

end
