#include "ssw.c"

#include <stdio.h>
#include <stdbool.h>

int main() {
    int s = ssw_new_stream("irc.chat.twitch.tv", "6667");

    const char *cap_req = "CAP REQ :twitch.tv/membership twitch.tv/tags twitch.tv/commands\n";
    size_t bytes_sent = ssw_send(s, cap_req, strlen(cap_req));
    printf("sent: %zu bytes\n", bytes_sent);

    char buf[512] = {0};

    ssize_t bytes_recv = ssw_read(s, buf, 512);
    printf("sent: %zu bytes\n", bytes_recv);
    printf("%s\n", buf);

    
    char pass[512] = {0};
    snprintf(pass, 512, "PASS oauth:%s\n", getenv("OLAB0T_USER_ACCESS_TOKEN"));
    const char *nick = "NICK olab0t\n";
    bytes_sent = ssw_send(s, pass, strlen(pass));
    bytes_sent = ssw_send(s, nick, strlen(nick));

    bytes_recv = ssw_read(s, buf, 512);
    printf("bytes: %zu\n%s", bytes_recv, buf);

    const char *join = "JOIN #olabaz\n";
    bytes_sent = ssw_send(s, join, strlen(join));

    bytes_recv = ssw_read(s, buf, 512);
    printf("bytes: %zu\n%s", bytes_recv, buf);

    while(true) {
        bytes_recv = ssw_read(s, buf, 512);
        if (bytes_recv > 0) {
            printf("bytes: %zu\n%s", bytes_recv, buf);
        } else {
            break;
        }
    }

    ssw_destroy_stream(s);

    return 0;
}
