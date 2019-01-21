helpers do
  def render_view(path, options = {})
    erb(path.to_sym, options)
  end

  def h(text)
    Rack::Utils.escape_html(text)
  end
end
