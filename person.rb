class Person
    attr_reader :id, :name, :age
    attr_writer :name, :age
    def initialize(name = "unknown",age,parent_permission = true)
        @id = Random.rand(1..1000)
        @name = name
        @age = age
        @parent_permission = parent_permission
    end
    private
    def of_age
        if @age >= 18
            return true
        else
            return false
        end
    end
    def can_use_services
        if @age >=18 || parent_permission
            return true
        end
    end

    
end