defmodule TeacherWeb.AlbumLive.Index do
  use TeacherWeb, :live_view

  alias Teacher.Recordings
  alias Teacher.Recordings.Album

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :albums, Recordings.list_albums())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Album")
    |> assign(:album, Recordings.get_album!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Album")
    |> assign(:album, %Album{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Albums")
    |> assign(:album, nil)
  end

  @impl true
  def handle_info({TeacherWeb.AlbumLive.FormComponent, {:saved, album}}, socket) do
    {:noreply, stream_insert(socket, :albums, album)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    album = Recordings.get_album!(id)
    {:ok, _} = Recordings.delete_album(album)

    {:noreply, stream_delete(socket, :albums, album)}
  end
end
