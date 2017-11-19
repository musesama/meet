defmodule MeetWeb.MarkerView do
  use MeetWeb, :view
  alias MeetWeb.MarkerView

  def render("index.json", %{markers: markers}) do
    %{data: render_many(markers, MarkerView, "marker.json")}
  end

  def render("show.json", %{marker: marker}) do
    %{data: render_one(marker, MarkerView, "marker.json")}
  end

  def render("marker.json", %{marker: marker}) do
    %{id: marker.id,
      lon: marker.lon,
      lat: marker.lat}
  end
end
