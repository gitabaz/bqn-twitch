LibSSW ← "ssw/libssw.so"⊸•FFI

newstream ⇐ LibSSW "i32"‿"ssw_new_stream"‿"*u8:c8"‿"*u8:c8"
send ⇐ LibSSW "i32"‿"ssw_send"‿"i32"‿"*u8:c8"‿"u32"
read ⇐ LibSSW "i32"‿"ssw_read"‿"i32"‿"&u8:c8"‿"u32"
destroystream ⇐ LibSSW ""‿"ssw_destroy_stream"‿">i32"

# from libc
strlen ⇐ @ •FFI "u64"‿"strlen"‿">*u8"
getenv ⇐ @ •FFI "*u8"‿"getenv"‿">*u8:c8"
