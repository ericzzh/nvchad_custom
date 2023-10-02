---@type ChadrcConfig
local M = {}

M.ui = { theme = 'onedark' }
M.mappings = {
  general = {
    n = {
      ["<A-UP>"] = {"<Cmd> resize -2<CR>","resize window up"},
      ["<A-DOWN>"] = {"<Cmd> resize +2<CR>","resize window down"},
      ["<A-LEFT>"] = {"<Cmd> vertical resize -2<CR>","resize window left"},
      ["<A-RIGHT>"] = {"<Cmd> vertical resize +2<CR>","resize window right"},
    },
  },

  lspconfig = {
    n = {
      ["gd"] = {"<cmd>Telescope lsp_definitions<cr>", "definition list"},
      ["gi"] = {"<cmd>Telescope lsp_implementations<cr>", "implementation list"},
      ["gr"] = {"<cmd>Telescope lsp_references<cr>", "code reference list"},
      ["<leader>el"] = {"<cmd>Telescope diagnostics<cr>", "Telescope diagnostics"},
      ["<leader>lo"] = {"<cmd>Telescope lsp_document_symbols<cr>", "Telescope document symbols"},
      ["<leader>lwo"] = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Telescope workspace symbols"},
    },
    v = {
      ["<leader>ca"] = {
        function()
          vim.lsp.buf.code_action()
        end,
        "lsp code_action",
      },
    },
  }
}

M.plugins = "custom.plugins"

return M
