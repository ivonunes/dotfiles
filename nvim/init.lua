vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.wrap = false
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 400

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.list = true
vim.opt.listchars = {
  tab = "> ",
  trail = ".",
  nbsp = "+",
}

local function macos_is_dark()
  local result = vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }):wait()
  return result.code == 0 and result.stdout:match("Dark") ~= nil
end

local function apply_catppuccin()
  local dark = macos_is_dark()

  local c = dark and {
    base = "#1e1e2e",
    mantle = "#181825",
    surface = "#313244",
    text = "#cdd6f4",
    subtext = "#a6adc8",
    overlay = "#7f849c",
    blue = "#89b4fa",
    green = "#a6e3a1",
    mauve = "#cba6f7",
    peach = "#fab387",
    red = "#f38ba8",
    yellow = "#f9e2af",
  } or {
    base = "#eff1f5",
    mantle = "#e6e9ef",
    surface = "#ccd0da",
    text = "#4c4f69",
    subtext = "#6c6f85",
    overlay = "#8c8fa1",
    blue = "#1e66f5",
    green = "#40a02b",
    mauve = "#8839ef",
    peach = "#fe640b",
    red = "#d20f39",
    yellow = "#df8e1d",
  }

  vim.opt.background = dark and "dark" or "light"
  vim.cmd("highlight clear")

  local groups = {
    Normal = { fg = c.text, bg = "NONE" },
    NormalNC = { fg = c.text, bg = "NONE" },
    NormalFloat = { fg = c.text, bg = c.mantle },
    FloatBorder = { fg = c.blue, bg = c.mantle },
    CursorLine = { bg = c.mantle },
    LineNr = { fg = c.overlay },
    CursorLineNr = { fg = c.blue, bold = true },
    SignColumn = { fg = c.overlay, bg = "NONE" },
    FoldColumn = { fg = c.overlay, bg = "NONE" },
    ColorColumn = { bg = c.mantle },
    Visual = { bg = c.surface },
    Search = { fg = c.base, bg = c.yellow },
    IncSearch = { fg = c.base, bg = c.peach },
    MatchParen = { fg = c.peach, bold = true },
    NonText = { fg = c.surface },
    SpecialKey = { fg = c.surface },

    Comment = { fg = c.overlay, italic = true },
    Constant = { fg = c.peach },
    String = { fg = c.green },
    Identifier = { fg = c.text },
    Function = { fg = c.blue },
    Statement = { fg = c.mauve },
    Keyword = { fg = c.mauve },
    PreProc = { fg = c.yellow },
    Type = { fg = c.yellow },
    Special = { fg = c.peach },
    Underlined = { fg = c.blue, underline = true },

    DiagnosticError = { fg = c.red },
    DiagnosticWarn = { fg = c.yellow },
    DiagnosticInfo = { fg = c.blue },
    DiagnosticHint = { fg = c.green },

    Pmenu = { fg = c.text, bg = c.mantle },
    PmenuSel = { fg = c.base, bg = c.blue },
    StatusLine = { fg = c.text, bg = c.mantle },
    StatusLineNC = { fg = c.overlay, bg = c.mantle },
    VertSplit = { fg = c.surface, bg = "NONE" },
    EndOfBuffer = { fg = c.surface, bg = "NONE" },
  }

  for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

apply_catppuccin()

vim.api.nvim_create_autocmd("FocusGained", {
  callback = apply_catppuccin,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>x<CR>", { silent = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
