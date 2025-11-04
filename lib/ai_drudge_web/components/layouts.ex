defmodule AiDrudgeWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use AiDrudgeWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <!-- Header -->
    <header class="bg-gradient-to-r from-blue-800 via-indigo-900 to-red-800 text-white shadow-md">
      <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <div class="font-techno">
          <h1 class="text-3xl font-extrabold tracking-tight">AI-DRUDGE</h1>
          <p class="text-sm text-white/80 dark:text-white/60">
            AI-powered analysis of political news & commentary
          </p>
        </div>
      </div>
    </header>
    <!-- Main Layout -->
    <main class="h-full w-full max-w-7xl px-6">
      &nbsp;
      <div class="flex flex-cols gap-6 mx-auto  h-full">
        {render_slot(@inner_block)}
      </div>
    </main>

    <!-- Footer -->
    <footer class="mt-8 border-t border-slate-800 bg-slate-900/60 backdrop-blur text-sm text-gray-400">
      <div class="max-w-7xl mx-auto px-6 py-4 flex flex-col md:flex-row justify-between items-center">
        <p>© <span id="year"></span> AI-DRUDGE</p>
        <div class="flex gap-3">
          <a href="#" class="hover:text-blue-300">Privacy</a>
          <a href="#" class="hover:text-blue-300">Terms</a>
          <a href="#" class="hover:text-blue-200">About</a>
        </div>
      </div>
    </footer>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end

  @doc """
  Provides The Left Sidebar

  ## Examples

      <.left_sidebar trending={@trending} />
  """
  attr :trending, :list, default: [], doc: "List of Trending Topics"

  def left_sidebar(assigns) do
    ~H"""
    <aside class="hidden lg:block bg-slate-800/40 backdrop-blur border border-slate-700 rounded-lg shadow-sm p-4">
      <h2 class="text-lg font-semibold mb-3 text-white">Trending Topics</h2>

      <ul :for={topic <- @trending} class="text-sm space-y-2 text-gray-300">
        <li><a href="#" class="hover:text-blue-300">{topic}</a></li>
      </ul>
    </aside>
    """
  end

  @doc """
  Provides The Right Sidebar

  ## Examples

      <.right_sidebar />
  """
  def right_sidebar(assigns) do
    ~H"""
    <aside class="hidden lg:block bg-slate-800/40 dark:bg-slate-600/40 backdrop-blur border border-slate-700 rounded-lg shadow-sm  w-20">
      <h2 class="text-lg font-semibold mb-3 text-white dark:text-black">AI Insights</h2>
      <p class="text-sm text-gray-300 dark:text-grey-100 mb-3">
        AI detects bias, sentiment, and framing across political spectrums.
      </p>
      <div class="GreatVibesRegular bg-gradient-to-r from-blue-700 to-red-700 text-white dark:text-grey-400 text-center rounded-md py-2 font-semibold">
        Balanced by Design
      </div>
    </aside>
    """
  end

  @doc """
  Shows the feed article and content.

  ## Examples

      <.article article={@article} />
  """
  attr :article, :map, doc: "the contents of the article"

  def article(assigns) do
    ~H"""
    <div class="grid grid-cols-3 text-sm py-3 items-center text-center gap-2">
      <!-- Conservative -->
      <div class="mx-2 text-red-400 bg-gray-300">
        {@article.republican}
      </div>
      
    <!-- Center (headline + description) -->
      <div class="px-2 flex flex-col items-center justify-center text-center bg-slate-200 dark:bg-slate-800 rounded-md py-2">
        <.link navigate={@article.host} class="font-semibold text-blue-400 hover:underline">
          {@article.title}
        </.link>
        <div class="text-gray-700 dark:text-gray-300 text-sm mt-1">
          {@article.description}
        </div>
      </div>
      
    <!-- Liberal -->
      <div class="px-2 text-blue-400 bg-gray-300">
        {@article.democrat}
      </div>
    </div>
    """
  end
end
