defmodule TicTacToeWeb.Components.Board do
  use Phoenix.Component

  def board(assigns) do
    ~L"""
    <div class="grid grid-cols-3 w-72">
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-b-2" id="cell-0"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-b-2 border-r-2 border-l-2" id="cell-1"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-b-2" id="cell-2"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-b-2" id="cell-3"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-b-2 border-r-2 border-l-2" id="cell-4"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-b-2" id="cell-5"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed" id="cell-6"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed border-r-2 border-l-2" id="cell-7"></div>
      <div class="w-32 h-32 font-bold text-4xl border-blue-500 disabled:cursor-not-allowed" id="cell-8"></div>
    </div>
    """
  end
end
