class NetSystem
  class Record < Liza::Controller

    def self.inherited sub
      super

      return if sub.name.nil?
      return if sub.name.end_with? "Record"
      raise "please rename #{sub.name} to #{sub.name}Record"
    end

    def self.db database_id = nil
      if database_id.nil?
        db = get :db
        if db
          Liza.const(:NetBox).databases.get db
        else
          raise "please set a db to record #{self}"
        end
      else
        valid = Liza.const(:NetBox).databases.settings.keys
        if valid.include? database_id
          set :db, database_id
        else
          raise "invalid db `#{database_id}`, valid options are #{valid}"
        end
      end
    end

  end
end
