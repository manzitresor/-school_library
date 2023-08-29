require_relative 'base_decorator'
class TrimmerDecorator
  def correct_name
    originale_name = @nameable.correct_name
    if originale_name.length > 10
      "#{originale_name[0, 10]}..."
    else
      originale_name
    end
  end
end
