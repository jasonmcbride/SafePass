module ApplicationHelper
  def logo(size="h2")
    image_tag("icon.png", alt: "Safe Pass Logo", class: "#{size} mx-auto mb-3").html_safe
  end
end
