module Generator
  def self.blank_line
    "\n"
  end

  def self.comment(comment_string)
    "// #{comment_string}\n"
  end

  def self.model_start(model_name)
    "type #{model_name} = {\n"
  end

  def self.model_end
    "}\n"
  end

  def self.field(field_name, type)
    "#{field_name} : #{type};\n"
  end
end
