module PruneFilename
  def prune_filename(input)
    input = /(?:apps|packages)\/(.*)/.match(input)[1]
  end
end

Liquid::Template.register_filter(PruneFilename)