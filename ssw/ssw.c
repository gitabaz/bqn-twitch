#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <unistd.h>


int ssw_new_stream(const char *url, const char *port) {

    struct addrinfo hints, *server_info;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo(url, port, &hints, &server_info) != 0) {
        return -1;
    }

    int sock = socket(server_info->ai_family, server_info->ai_socktype, server_info->ai_protocol);
    if (sock < 0)  {
        freeaddrinfo(server_info);
        return -1;
    }

    if(connect(sock, server_info->ai_addr, server_info->ai_addrlen) != 0) {
        freeaddrinfo(server_info);
        close(sock);
        return -1;
    }

    freeaddrinfo(server_info);

    return sock;
}

ssize_t ssw_send(int sock, const char* buf, size_t buf_size) {
    size_t bytes_sent = send(sock,  buf, buf_size, 0);
    return bytes_sent;
}

ssize_t ssw_read(int sock, char *buf, size_t buf_size) {
    ssize_t bytes_recv = recv(sock, buf, buf_size-1, 0);
    if (bytes_recv > 0) {
        buf[bytes_recv] = '\0';
    }
    return bytes_recv;
}

void ssw_destroy_stream(int sock) {
    close(sock);
}
