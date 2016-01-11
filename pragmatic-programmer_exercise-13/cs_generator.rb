module Generator
  def self.blank_line
    "\n"
  end

  def self.comment(comment_string)
    "// #{comment_string}\n"
  end

  def self.model_start(model_name)
    "class #{model_name}\n{\n"
  end

  def self.model_end
    "}\n"
  end

  def self.field(field_name, type)
    "#{type} #{field_name};\n"
  end
end
