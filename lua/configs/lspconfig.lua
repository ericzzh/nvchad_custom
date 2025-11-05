require("nvchad.configs.lspconfig").defaults()
local map = vim.keymap.set

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local function opts(desc)
      return { buffer = args.buf, desc = "LSP " .. desc }
    end
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
      map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts "definition list")
      map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts "implementation list")
      map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts "code reference list")
      map("n", "<leader>el", "<cmd>Telescope diagnostics<cr>", opts "Telescope diagnostics")
      map("n", "<leader>lo", "<cmd>Telescope lsp_document_symbols<cr>", opts "Telescope document symbols")
      map("n", "<leader>lwo", "<cmd>Telescope lsp_workspace_symbols<cr>", opts "Telescope workspace symbols")
    end
  end,
})

local servers = { "html", "cssls", 'pyright', 'gopls', 'tsserver', 'rust_analyzer', 'clangd', 'jdtls','bashls', 'groovyls' }
vim.lsp.enable(servers)

