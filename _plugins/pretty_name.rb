require 'json'
module PrettyName
  def pretty_name(input)
    # the first element of the ancestorName is an empty string
    return JSON.parse(input)[1..].join(" > ")
  end
end
Liquid::Template.register_filter(PrettyName)