ssw ← •Import "ssw.bqn"

crlf ← @+13‿10

url ← "irc.chat.twitch.tv"
port ← "6667"

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

#########
# Utils #
#########

SplitStr ⇐ {
  𝕩⊔˜(+`∧¬)⊸-+´𝕩⊸=¨ 𝕨 # split 𝕩 on 𝕨
}

StrFromPtr ⇐ {
  @ + 𝕩.Read¨ ↕ ssw.StrLen 𝕩
}

GetEnvVar ⇐ {
  StrFromPtr ssw.GetEnv (𝕩∾@)
}
