defmodule BioskopWeb.CustomComponents do
  use Phoenix.Component

  attr :movies, :list, default: []
  def movies(assigns) do
    ~H"""
        <div class="flex justify-between items-center mb-4">
            <h1 class="text-4xl font-bold">Cinema Elix</h1>
        </div>

        <h1 class="text-2xl text-center">Now Playing</h1>

        <div class="bg-white rounded shadow-lg p-6">
            <%= for m <- @movies do %>
            <div class="card p-3 mb-10 flex justify-between">
                <div>
                  <img src={m.img} width="200" height="200" />
                  <div class="text-sm font-semibold text-gray-600 mb-2"><%= m.durasi %> Minutes | <%= m.pg %></div>
                </div>
                <div class="ml-5">
                  <h2 class="text-2xl font-bold mb-2"><%= m.title %></h2>
                  <div class="flex flex-wrap mx-2">
                      <!-- Showtime Buttons -->
                      <p>Show Time:</p>
                      <span class="m-2">
                          <%= for waktu <- m.show_time do %>
                          <button phx-click="detail" phx-value-movie_id={m.id} phx-value-jam={waktu} class="m-1 text-green-800 px-4 py-1 border border-green-800 rounded"><%= waktu %></button>
                          <% end %>
                      </span>
                      <!-- Add more buttons for other showtimes -->
                  </div>
                </div>
            </div>
            <% end %>
        </div>
    """
  end

  attr :current, :map, default: %{}
  def detail_movie(assigns) do
    ~H"""
      <button phx-click="kembali">Back</button>
        <!-- Movie Details -->
        <div class="flex justify-between">
          <div class="mb-4">
              <h2 class="text-lg font-semibold text-gray-800"><%= @current.title %></h2>
              <p class="text-gray-600 text-sm"><%= @current.durasi %> Minutes</p>
              <p class="text-gray-600 text-sm mb-2">Rated: <%= @current.pg %></p>
              <div class="text-blue-600 font-bold">Schedule: Today, <%= @current.schedule %></div>
          </div>

          <div class="text-center">
            <button phx-click="buy_ticket" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
              Buy Tickets
            </button>
          </div>
        </div>

        <!-- Legend -->
        <div class="flex justify-center items-center mb-4">
            <div class="flex items-center">
                <div class="w-4 h-4 bg-gray-300 border border-gray-400 mr-2 rounded-full"></div>
                Available
            </div>
            <div class="flex items-center mx-4">
                <div class="w-4 h-4 bg-yellow-400 mr-2 rounded-full"></div>
                Selected
            </div>
        </div>

        <!-- Screen Illustration -->
        <div class="relative mb-4">
            <div class="absolute inset-x-0 bottom-0 bg-blue-600 h-1 w-full rounded-t-full"></div>
            <div class="text-xs text-center pt-2">Cinema Screen</div>
        </div>
    """
  end

  attr :kode, :string, default: ""
  attr :len, :integer, default: 0
  attr :selected_seats, :list, default: []
  def kursi(assigns) do
    ~H"""
      <!-- Seats Layout -->
        <div class="flex flex-wrap justify-center gap-1 mb-4">
            <!-- Generate your seat divs here -->
            <!-- Example Seat Row A -->
            <%= for i <- 1..@len do %>
              <div
                phx-click="seat"
                phx-value-kode={"#{@kode}#{i}"}
                class={
                  "w-8 h-8 hover:bg-blue-300 border border-gray-400 rounded-md flex justify-center items-center text-xs cursor-pointer " <>
                  if "#{@kode}#{i}" in @selected_seats, do: "bg-yellow-400", else: "bg-gray-300"
                }
              >
                <%= @kode %><%= i %>
              </div>
            <% end %>
            <!-- ... other seats in row A ... -->
            <!-- Repeat for all rows and seats -->
        </div>
    """
  end

  attr :current, :map, default: %{}
  attr :selected_seat, :list, default: []
  def ticket(assigns) do
    ~H"""
      <div class="container mx-auto px-4 py-6">
          <div class="max-w-sm mx-auto bg-white rounded-lg overflow-hidden shadow-lg">
            <div class="p-4">
              <h2 class="text-2xl font-bold mb-2">Movie Ticket</h2>
              <hr class="border-gray-200 my-2" />

              <h3 class="text-xl font-semibold"><%= @current.title %></h3>
              <p class="text-gray-600">Duration: <%= @current.durasi %> Minutes</p>
              <p class="text-gray-600">Rating: <%= @current.pg %></p>
              <p class="text-gray-600">Show Time: <%= @current.schedule %></p>
              <p class="text-gray-600">Seat: <%= @selected_seat |> Enum.join(", ") %></p>
              <div class="flex justify-center my-4">
                <img src="https://www.imgonline.com.ua/examples/qr-code-url.png" alt="QR Code" class="h-32 w-32"/>
              </div>

                <hr class="border-gray-200 my-2" />

            <div class="text-center">
              <p class="text-gray-600 text-sm">Show this QR code at the entrance</p>
            </div>
          </div>
        </div>
      </div>
    """
  end
end
