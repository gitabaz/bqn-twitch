# bqn-twitch
A simple library for building a basic twitch bot in BQN.

## Getting started
This library relies on a C library as a simple socket wrapper (ssw) for POSIX
sockets that handle the connection to the twitch IRC server. It currently only
supports non-TLS connections. To build run
```sh
cd ssw
make
```

To use the library in BQN simply `•Import "bqn-twitch.bqn"`. Basic
functionality revolves around connecting to the IRC server (using `Connect`,
`RequestCap`, and `Join`) and reading/parsing/handling messages (using `Read`,
`ReadFullMsgs`, `Msg`, and `HandleMsg`). Additional "lower-level" and utility
functions exist for customization.

See `tb.bqn` for a working example of usage.

## Basic functions
### Connect 𝕩

    - 𝕩: ⟨username, user access token⟩
    - return: socket

### 𝕨 RequestCap 𝕩

    - 𝕩: socket
    - 𝕨: list of capabilities in ⟨"membership", "tags", "commands"⟩
    - return: socket
 

### 𝕨 Join 𝕩

    - 𝕩: socket
    - 𝕨: channel to join
    - return: socket
  
### 𝕨 Read 𝕩

    - 𝕩: socket
    - 𝕨: string buffer to read input
    - return: string read
  
### 𝕨 ReadFullMsgs 𝕩

    - 𝕩: string from a Read call
    - 𝕨: left over partial message from a previous ReadFullMsgs call
    - return: ⟨list of full messages, left over partial message⟩

### Msg 𝕩

    - 𝕩: string containing an IRC message
    - return: Msg object with fields t‿s‿c‿p corresponding to ⟨tags, source, command, parameters⟩

### 𝕨 HandleMsg 𝕩

    - 𝕩: socket
    - 𝕨: a Msg object
    - return:
  
### 𝕨 SendChannelMsg 𝕩

    - 𝕩: socket
    - 𝕨: ⟨channel, message⟩
    - return: socket

### Disconnect 𝕩

    - 𝕩: socket

## Utility functions
### 𝕨 TimeFromEpoch 𝕩
    
    - 𝕩: unix epoch timestamp
    - 𝕨: integer for utc offset (optional)
    - return: ⟨hours, minutes, seconds⟩ 24 clock time (utc adjusted)

### 𝕨 Colorize 𝕩

    - 𝕩: string
    - 𝕨: ⟨red, green, blue⟩ list of integers corresponding to color components in ↕256
    - return: string wrapped with ANSI escape sequences for terminal coloring

### Hex2RGB 𝕩

    - 𝕩: string of hex color
    - return: ⟨red, green, blue⟩ list of integers corresponding to color components in ↕256

### 𝕨 SplitStr 𝕩

    - 𝕩: string to split
    - 𝕨: string (list of chars) of delimeters
    - return: list of split strings

### GetEnvVar 𝕩

    > [!CAUTION]
    > May segfault if environment variable does not exist

    - 𝕩: string containing environment variable name
    - return: string containing environment variable value
