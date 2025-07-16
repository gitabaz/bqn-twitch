#!/usr/bin/env BQN

tc ← •Import "bqn-twitch.bqn"

usn ← "olab0t"
uat ← tc.GetEnvVar "OLAB0T_USER_ACCESS_TOKEN"
ch ← "#chess"
cap ← "membership"‿"tags"‿"commands"

# buffers
c ← 512⥊@ # input buffer for reads
fm ← ⟨⟩ # holds list of full messages
lo ← "" # holds left over messages

s ← ch tc.Join cap tc.RequestCap tc.Connect usn‿uat

MainLoop ← {
  fm‿lo ↩ lo tc.ReadFullMsgs c tc.Read 𝕩
  tc.HandleMsg⟜𝕩∘tc.Msg¨ fm
  𝕩
}

MainLoop •_while_ 1 s

tc.Disconnect s

