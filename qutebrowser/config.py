config.load_autoconfig(True)

config.bind('<Ctrl-J>', 'spawn --userscript qute-pass --password-store ~/.password-store')
config.bind('<Ctrl-Shift-J>', 'spawn --userscript qute-pass --password-store ~/.password-store --username-only')
config.bind('<Ctrl-Alt-J>', 'spawn --userscript qute-pass --password-store ~/.password-store --password-only')
