# bqn-twitch
A simple library for building a basic twitch bot in BQN.

## Getting started
This library relies on a C library as a simple socket wrapper (ssw) for POSIX
sockets that handle the connection to the twitch irc server. It currently only
supports non-TLS connections. To build run
```sh
cd ssw
make
```

To use the library in BQN simply import `bqn-twitch`. Basic functionality
revolves around `Connect`, `Join`, `Read`, `ReadFullMsgs`, `SendChannelMsg`,
and `Disconnect`.

See `tb.bqn` for an example of usage.

## Functions
### Connect 𝕩

    - 𝕩: ⟨username, user access token⟩
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
  
### 𝕨 SendChannelMsg 𝕩

    - 𝕩: socket
    - 𝕨: ⟨channel, message⟩
    - return: socket
  
### Disconnect 𝕩

    - 𝕩: socket
