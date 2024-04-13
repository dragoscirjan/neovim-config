local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local function isIncluded(value, list)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set[value] or false
end

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import ui extras
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import AI extras
    { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.coding.tabnine" },
    -- import generic languages
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    -- import project based languages
    (os.getenv("NEOVIM_LANG") == "clangd")
        and {
          { import = "lazyvim.plugins.extras.lang.clangd" },
          { import = "lazyvim.plugins.extras.lang.cmake" },
        }
      or nil,
    (os.getenv("NEOVIM_LANG") == "elixir") and { import = "lazyvim.plugins.extras.lang.elixir" } or nil,
    (os.getenv("NEOVIM_LANG") == "go") and { import = "lazyvim.plugins.extras.lang.go" } or nil,
    (os.getenv("NEOVIM_LANG") == "helm") and { import = "lazyvim.plugins.extras.lang.helm" } or nil,
    (os.getenv("NEOVIM_LANG") == "java") and { import = "lazyvim.plugins.extras.lang.java" } or nil,
    (os.getenv("NEOVIM_LANG") == "python") and { import = "lazyvim.plugins.extras.lang.python" } or nil,
    (os.getenv("NEOVIM_LANG") == "ruby") and { import = "lazyvim.plugins.extras.lang.ruby" } or nil,
    (os.getenv("NEOVIM_LANG") == "rust") and { import = "lazyvim.plugins.extras.lang.rust" } or nil,
    (os.getenv("NEOVIM_LANG") == "scala") and { import = "lazyvim.plugins.extras.lang.scala" } or nil,
    (os.getenv("NEOVIM_LANG") == "terraform") and { import = "lazyvim.plugins.extras.lang.terraform" } or nil,
    (os.getenv("NEOVIM_LANG") == "typescript") and { import = "lazyvim.plugins.extras.lang.typescript" } or nil,
    -- import project based languages dependants
    (isIncluded(os.getenv("NEOVIM_LANG"), { "javascript", "typescript" }))
        and {
          import = "lazyvim.plugins.extras.linting.eslint",
        }
      or nil,
    (isIncluded(os.getenv("NEOVIM_LANG"), { "javascript", "typescript" })) and {
      { import = "lazyvim.plugins.extras.formatting.prettier" },
    } or nil,
    (os.getenv("NEOVIM_LANG") == "python") and { import = "lazyvim.plugins.extras.formatting.black" } or nil,
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
