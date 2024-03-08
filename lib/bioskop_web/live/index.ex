defmodule BioskopWeb.Live.Index do
  use BioskopWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
      <%= if @current == nil do %>
        <.movies movies={@movies} />
      <% else %>
      <%= if @ticket do %>
          <.ticket current={@current} selected_seat={@selected_seat} />
          <% else %>
            <.detail_movie current={@current}/>

            <.kursi kode="A" len={3} selected_seats={@selected_seat}/>
            <.kursi kode="B" len={5} selected_seats={@selected_seat}/>
            <.kursi kode="C" len={5} selected_seats={@selected_seat}/>
            <.kursi kode="D" len={5} selected_seats={@selected_seat}/>
            <.kursi kode="E" len={5} selected_seats={@selected_seat}/>
          <% end %>
      <% end %>
    """
  end

  defmodule Movie do
    defstruct [:id, :title, :durasi, :img, :pg, :show_time]
  end

  @impl true
  def mount(_session, _params, socket) do
      movies = [
        %Movie{
          id: 1,
          title: "Kung Fu Panda 4",
          durasi: "94",
          img: "https://media.21cineplex.com/webcontent/gallery/pictures/170833695317395_140x207.jpg",
          pg: "R13+",
          show_time: [
            "12:00",
            "13:00",
            "14:20",
            "15:20",
            "16:40",
            "17:40",
          ]
        },
        %Movie{
          id: 2,
          title: "Sinden Gaib",
          durasi: "96",
          img: "https://media.21cineplex.com/webcontent/gallery/pictures/17056646245470_140x207.jpg",
          pg: "R13+",
          show_time: [
            "12:35",
            "14:30",
            "16:25",
            "18:20",
            "20:15"
          ]
        },
        %Movie{
          id: 3,
          title: "Pasar Setan",
          durasi: "96",
          img: "https://media.21cineplex.com/webcontent/gallery/pictures/170773379418099_140x207.jpg",
          pg: "D17+",
          show_time: [
            "12:45",
            "14:40",
            "16:35",
            "18:30",
            "20:25"
          ]
        },
        %Movie{
          id: 4,
          title: "Dune: Part Two",
          durasi: "166",
          img: "https://media.21cineplex.com/webcontent/gallery/pictures/170687981167709_140x207.jpg",
          pg: "R13+",
          show_time: [
            "12:00",
            "13:00",
            "15:00",
            "18:00",
            "21:00"
          ]
        }
      ]

      {:ok, socket |> assign(
        movies: movies,
        current: nil,
        selected_seat: [],
        ticket: false
      )}
  end

  @impl true
  def handle_event("kembali", _params, socket), do: {:noreply, socket |> assign(current: nil, selected_seat: [])}
  def handle_event("buy_ticket", _params, socket), do: {:noreply, socket |> assign(ticket: true)}

  def handle_event("detail", %{"movie_id" => movie_id, "jam" => jam} = _params, %{assigns: %{movies: movies}} = socket) do
    {_, movie} = movies
      |> Enum.find(fn e -> e.id == movie_id
      |> String.to_integer end)
      |> Map.put(:schedule, jam)
      |> Map.pop(:show_time)
    {:noreply, socket |> assign(
      current: movie
    )}
  end

  def handle_event("seat", %{"kode" => kode} = _params, %{assigns: %{selected_seat: seats}} = socket) do
    if kode not in seats do
      updated_seats = [kode | seats]
      {:noreply, socket |> assign(
        selected_seat: updated_seats
      )}
    else
      {:noreply, socket}
    end
  end

end
