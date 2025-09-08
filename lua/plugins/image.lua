return {
  {
    "3rd/image.nvim",
    dependencies = {
      "leafo/magick", -- Lua биндинги для ImageMagick
    },
    config = function()
      require("image").setup {
        backend = "kitty",
        processor = "magick_rock", -- используем magick
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = 50,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      }
    end,
  },
}
