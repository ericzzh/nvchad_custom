-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- Enable underline, use default values
--     underline = false,
--     -- Enable virtual text, override spacing to 4
--     virtual_text = false,
--     -- Use a function to dynamically turn signs off
--     -- and on, using buffer local variables
--     -- signs = function(bufnr, client_id)
--     --   return vim.bo[bufnr].show_signs == false
--     -- end,
--     -- Disable a feature
--     -- update_in_insert = false,
--   }
-- )

-- custom.plugins.lspconfig
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)

  local global_ts = '/Users/zzh/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
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
  on_attach = on_attach,
  capabilities = capabilities,
}

local other_servers = {
  'gopls',
  'tsserver',
  'rust_analyzer',
  'clangd',
  'pyright',
  -- 'jedi_language_server',
  'jdtls',
}

for _, lsp in ipairs(other_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


