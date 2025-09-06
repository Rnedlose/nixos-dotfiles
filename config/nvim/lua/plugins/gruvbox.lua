return {
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      terminal_colors = true,
      bold = true,
      italic = { comments = true, strings = false, operators = false, folds = true },
      inverse = true,             -- invert bg for search/diff/statusline
      contrast = "hard",          -- "", "soft", or "hard"
      dim_inactive = false,
      transparent_mode = false,   -- set true if you want transparent bg
    },
  },
  -- Tell LazyVim to use it
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
}
