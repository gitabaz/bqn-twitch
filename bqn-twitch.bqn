ssw ← •Import "ssw.bqn"

crlf‿esc ← @+⟨13‿10,27⟩

url ← "irc.chat.twitch.tv"
port ← "6667"
utc ← -4

Send ⇐ { 
  bytes_sent ← ssw.Send 𝕩‿𝕨‿(≠𝕨) 
  ! bytes_sent > 0
  𝕩
}

Read ⇐ {
  bytes_read‿c ← ssw.Read 𝕩‿𝕨‿(≠𝕨)
  ! bytes_read ≥ 0
  (↕bytes_read)⊏c
}


Auth ⇐ {
  nick‿uat ← 𝕨
  ("PASS oauth:"∾uat∾crlf) Send 𝕩
  ("NICK "∾nick∾crlf) Send 𝕩
  𝕩
}

Connect ⇐ {
  nick‿uat ← 𝕩
  stream ← ssw.NewStream (url∾@)‿(port∾@)
  𝕩 Auth stream
}

Disconnect ⇐ ssw.DestroyStream

Join ⇐ {
  ("JOIN "∾𝕨∾crlf) Send 𝕩
}

RequestCap ⇐ {
  c ← crlf∾˜"CAP REQ :"∾∾⟜" "⊸∾´"twitch.tv/"⊸∾¨𝕨
  c Send 𝕩
}

SendChannelMsg ⇐ {
  ch‿msg ← 𝕨
  ("PRIVMSG "∾ch∾" :"∾msg∾crlf) Send 𝕩
}

ReadFullMsgs ⇐ {
  r ← 𝕨∾𝕩 # concat last partial message (𝕨) with new messages (𝕩)
  m ← ×∘≠¨⊸/ crlf SplitStr r # split on crlf and remove empty lists
  dlm ← -(@+10)≠¯1⊑r # drop last message if it doesn't end in nl
  dlm(↓⋈∾∘↑)m # return list of full messages and partial message
}

HandlePing ⇐ {
  ("PONG :"∾𝕨∾crlf) Send 𝕩
}

HandlePrivMsg ⇐ {
  •Out "<"∾(⊑"!" SplitStr 1⊑𝕨)∾"> "∾(2⊑𝕨)
  𝕩
}

HandleMsg ⇐ {
  p ← ":" SplitStr 𝕨 # split messages on : to get pieces
  𝕨 {
    "PING "≡⊑p ? (¯1⊑p) HandlePing 𝕩; # if ping message reply pong
    "PRIVMSG" ≡ 1⊑" "SplitStr 1⊑p ? p HandlePrivMsg 𝕩;
    •Show 𝕨
  } 𝕩
  𝕩
}

#########
# Utils #
#########

TimeFromEpoch ⇐ {
    los ← 𝕩|˜24×60×60 # left over seconds
    h ← ⌊los÷60×60
    m ← ⌊60÷˜los|˜60×60
    s ← ⌊60|los
    (24|𝕨 + h)‿m‿s
}

Colorize ⇐ {
  r‿g‿b ← •Fmt¨𝕨
  esc∾"[38;2;"∾r∾";"∾g∾";"∾b∾"m"∾𝕩∾esc∾"[0m"
}

Hex2RGB ⇐ {
  rgb ← >⟜15◶⟨⊣,-⟜('A'-':')⟩¨𝕩-'0'
  rgb ↩ 16⊸×⌾(0‿2‿4⊸⊏) rgb
  +´¨⊏⟜rgb¨⟨0‿1,2‿3,4‿5⟩
}

SplitStr ⇐ {
  𝕩⊔˜(+`∧¬)⊸-+´𝕩⊸=¨ 𝕨 # split 𝕩 on 𝕨
}

StrFromPtr ⇐ {
  @ + 𝕩.Read¨ ↕ ssw.StrLen 𝕩
}

GetEnvVar ⇐ {
  StrFromPtr ssw.GetEnv (𝕩∾@)
}
