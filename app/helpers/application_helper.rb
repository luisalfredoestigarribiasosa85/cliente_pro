module ApplicationHelper
  def nav_link(text, path, icon_path)
    is_active = current_page?(path)
    classes = is_active ?
      "bg-indigo-50 text-indigo-700 group flex items-center px-3 py-2 text-sm font-medium rounded-lg" :
      "text-gray-700 hover:text-gray-900 hover:bg-gray-50 group flex items-center px-3 py-2 text-sm font-medium rounded-lg"

    link_to path, class: classes do
      content_tag(:svg, class: "mr-3 h-5 w-5 flex-shrink-0 #{is_active ? 'text-indigo-500' : 'text-gray-400 group-hover:text-gray-500'}", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor") do
        content_tag(:path, "", "stroke-linecap": "round", "stroke-linejoin": "round", d: icon_path)
      end + text
    end
  end

  def status_badge(status)
    colors = {
      "new" => "bg-blue-100 text-blue-800",
      "interested" => "bg-yellow-100 text-yellow-800",
      "frequent" => "bg-green-100 text-green-800",
      "lost" => "bg-red-100 text-red-800"
    }
    labels = {
      "new" => "Nuevo",
      "interested" => "Interesado",
      "frequent" => "Frecuente",
      "lost" => "Perdido"
    }
    content_tag(:span, labels[status] || status, class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium #{colors[status]}")
  end
end