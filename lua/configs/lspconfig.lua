-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local map = vim.keymap.set

local lspconfig = require "lspconfig"


local my_attach = function(client, bufnr)
  on_attach(client, bufnr)

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts "definition list")
  map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts "implementation list")
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts "code reference list")
  map("n", "<leader>el", "<cmd>Telescope diagnostics<cr>", opts "Telescope diagnostics")
  map("n", "<leader>lo", "<cmd>Telescope lsp_document_symbols<cr>", opts "Telescope document symbols")
  map("n", "<leader>lwo", "<cmd>Telescope lsp_workspace_symbols<cr>", opts "Telescope workspace symbols")

  require("dap")
end

-- lsps with default config
local servers = { "html", "cssls", 'gopls', 'tsserver', 'rust_analyzer', 'clangd', 'jdtls','bashls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = my_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig["pyright"].setup {
  on_attach = my_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
}


local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)
  local global_ts = '/Users/zzh/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig['volar'].setup {
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  on_attach = my_attach,
  capabilities = capabilities,
}

-- -- typescript
-- lspconfig.tsserver.setup {
--   on_attach = my_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
