import os

config.load_autoconfig(True)

# qutebrowser on macOS inherits a minimal PATH from Finder.
# Add Homebrew bins so userscripts can find `pass`, `gpg`, etc.
os.environ['PATH'] = '/opt/homebrew/bin:/opt/homebrew/sbin:' + os.environ.get('PATH', '')

config.bind('<Ctrl-J>', 'spawn --userscript qute-pass')
config.bind('<Ctrl-Shift-J>', 'spawn --userscript qute-pass --username-only')
config.bind('<Ctrl-Alt-J>', 'spawn --userscript qute-pass --password-only')
