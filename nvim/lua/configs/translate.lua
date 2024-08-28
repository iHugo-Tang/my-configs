local wk = require("which-key")

wk.register({
  t = {
    name = "Translate",
    e = { "<cmd>Translate EN<cr>", "show English" },
    r = { "<cmd>Translate EN -output=replace<cr>", "replace with English" },
    c = { "<cmd>Translate zh<cr>", "show Chinese" },
    v = { "<cmd>Translate zh -output=replace<cr>", "replace with Chinese" },
  },
}, { prefix = "<leader>" })
