ssw ← •Import "ssw.bqn"

nl‿cr ← @+10‿13

url ← "irc.chat.twitch.tv"∾@
port ← "6667"∾@

cap_req ← "CAP REQ :twitch.tv/membership twitch.tv/tags twitch.tv/commands"∾nl


c ← 512⥊@
stream ← ssw.NewStream url‿port
bytes_sent ← ssw.Send stream‿cap_req‿(≠cap_req)
bytes_read ← ssw.Read stream‿c‿(≠c)

