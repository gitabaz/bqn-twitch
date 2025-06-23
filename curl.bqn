libcurlpath ← "/usr/lib/libcurl.so"

Libcurl ← libcurlpath⊸•FFI

strlen ← @ •FFI "u64"‿"strlen"‿">*u8"

curl_easy_init ← Libcurl "*"‿"curl_easy_init"
curl_easy_cleanup ← Libcurl ""‿"curl_easy_cleanup"‿">*"
curl_easy_setopt ← Libcurl "i32"‿"curl_easy_setopt"‿"*"‿"i32"‿"*u8:c8"
curl_easy_perform ← Libcurl "i32"‿"curl_easy_perform"‿">*"
curl_easy_strerror ← Libcurl "*u8"‿"curl_easy_strerror"‿">i32"

#p ← Curl_easy_init ⟨⟩
#Curl_easy_setopt p‿10002‿("https://example.com"∾@)
#Curl_easy_perform p
#r ← Curl_easy_strerror 1
#@+r.Read¨ ↕Strlen r
