module ApplicationHelper
  def logo(size="h2")
    image_tag("icon.png", alt: "Safe Pass Logo", class: "#{size} mx-auto mb-3").html_safe
  end

  def format_time(time)
    time.strftime("%B %d, %Y at %I:%M %p") if time  
  end

  def render_flash_messages_stream
    turbo_stream.update "flash-messages" do
      render partial: "shared/notifications"
    end
  end
end
