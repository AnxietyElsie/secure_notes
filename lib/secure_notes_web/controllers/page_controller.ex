defmodule SecureNotesWeb.PageController do
  use SecureNotesWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
