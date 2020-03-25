Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D071925B8
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYKfm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 06:35:42 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34585 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgCYKfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 06:35:41 -0400
Received: by mail-oi1-f169.google.com with SMTP id e9so1651019oii.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfKvC8e+76RqAz7eX5sIQjaC5NJqhdNkxxHEsOjnayM=;
        b=AC+n5IzFhCaepZ0HQ5mbasTLbO/rUMoW+kjmQoETWdUpe485AdM9/3AFfL3Kk8lzlK
         gnuNz2opvHoBc3ZN/4Y6R7PaC6/exLCc/AdZiOYOvt1vBG9JH83k25NSncbo3NpjRC/D
         s6M/YK6TlZcUTbSxk6UKw+Cil4+CGBx1w8hM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfKvC8e+76RqAz7eX5sIQjaC5NJqhdNkxxHEsOjnayM=;
        b=NzDQQ9aYEseLUqVg9Qu9FDRpPVaBvGkdlW7n/51+VTpoE2UlTAzwJoGAzHkq49ZeDG
         jAN+2dDAkG4c2bvZTBZlKbMZGrwcSsRAsjr0KKlFjvvByzUod01NCBfPysjg6NuohuLQ
         qs3nnipMoEqQeePGxF63SSqxZzLlMwvFj8w7W1sNdbXn/jMQRh0x6AN4STa2lmxzt8pN
         80wZqOxmmNN7+j1c/owh/i0DW2enfD04rpI2ZzRChGPuY+H0SJbrzUDe7BJkChgFc3Ut
         JqfBMT7iu88Grgi/HjWAZ5whUWxMqycrNFV+DRJkJgDsLpDDX6iALE7eiFCyM7cN9vJe
         a2Ag==
X-Gm-Message-State: ANhLgQ0iEXgj/crpU+2gaw2cnoqMYV1LS8mgzytcOb/jBFQBwR7HqlKV
        jCJUU/HPhZGf/Fz5EPkY8HS9A70yTXtvxC9Qf0YVrArdtEM=
X-Google-Smtp-Source: ADFU+vt7Y0toogTN1fd7pBkQQLMAwD/oez2ENz5ejon+2MoWf2Jt7XrKGnJL8tUkh2R/pwMuK8bGf16WLj1hMi8VIDE=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr2046012oic.110.1585132539952;
 Wed, 25 Mar 2020 03:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200325055745.10710-1-joe@wand.net.nz> <20200325055745.10710-6-joe@wand.net.nz>
In-Reply-To: <20200325055745.10710-6-joe@wand.net.nz>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 25 Mar 2020 10:35:28 +0000
Message-ID: <CACAyw9-jJiAAci8dNsGGH7gf6QQCsybC2RAaSq18qsQDgaR4CQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 5/5] selftests: bpf: add test for sk_assign
To:     Joe Stringer <joe@wand.net.nz>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 25 Mar 2020 at 05:58, Joe Stringer <joe@wand.net.nz> wrote:
>
> From: Lorenz Bauer <lmb@cloudflare.com>
>
> Attach a tc direct-action classifier to lo in a fresh network
> namespace, and rewrite all connection attempts to localhost:4321
> to localhost:1234 (for port tests) and connections to unreachable
> IPv4/IPv6 IPs to the local socket (for address tests).

Can you extend this to cover UDP as well?

>
> Keep in mind that both client to server and server to client traffic
> passes the classifier.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Co-authored-by: Joe Stringer <joe@wand.net.nz>
> Signed-off-by: Joe Stringer <joe@wand.net.nz>
> ---
> v2: Rebase onto test_progs infrastructure
> v1: Initial commit
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../selftests/bpf/prog_tests/sk_assign.c      | 244 ++++++++++++++++++
>  .../selftests/bpf/progs/test_sk_assign.c      | 127 +++++++++
>  3 files changed, 372 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_assign.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 7729892e0b04..4f7f83d059ca 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -76,7 +76,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
>  # Compile but not part of 'make run_tests'
>  TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> -       test_lirc_mode2_user xdping test_cpp runqslower
> +       test_lirc_mode2_user xdping test_cpp runqslower test_sk_assign
>
>  TEST_CUSTOM_PROGS = urandom_read
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> new file mode 100644
> index 000000000000..1f0afcc20c48
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Facebook
> +// Copyright (c) 2019 Cloudflare
> +// Copyright (c) 2020 Isovalent, Inc.
> +/*
> + * Test that the socket assign program is able to redirect traffic towards a
> + * socket, regardless of whether the port or address destination of the traffic
> + * matches the port.
> + */
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "test_progs.h"
> +
> +#define TEST_DPORT 4321
> +#define TEST_DADDR (0xC0A80203)
> +#define NS_SELF "/proc/self/ns/net"
> +
> +static __u32 duration;
> +
> +static bool configure_stack(int self_net)
> +{
> +       /* Move to a new networking namespace */
> +       if (CHECK_FAIL(unshare(CLONE_NEWNET)))
> +               return false;
> +
> +       /* Configure necessary links, routes */
> +       if (CHECK_FAIL(system("ip link set dev lo up")))
> +               return false;
> +       if (CHECK_FAIL(system("ip route add local default dev lo")))
> +               return false;
> +       if (CHECK_FAIL(system("ip -6 route add local default dev lo")))
> +               return false;
> +
> +       /* Load qdisc, BPF program */
> +       if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
> +               return false;
> +       if (CHECK_FAIL(system("tc filter add dev lo ingress bpf direct-action "
> +                    "object-file ./test_sk_assign.o section sk_assign_test")))
> +               return false;
> +
> +       return true;
> +}
> +
> +static int start_server(const struct sockaddr *addr, socklen_t len)
> +{
> +       int fd;
> +
> +       fd = socket(addr->sa_family, SOCK_STREAM, 0);
> +       if (CHECK_FAIL(fd == -1))
> +               goto out;
> +       if (CHECK_FAIL(bind(fd, addr, len) == -1))
> +               goto close_out;
> +       if (CHECK_FAIL(listen(fd, 128) == -1))
> +               goto close_out;
> +
> +       goto out;
> +
> +close_out:
> +       close(fd);
> +       fd = -1;
> +out:
> +       return fd;
> +}
> +
> +static void handle_timeout(int signum)
> +{
> +       if (signum == SIGALRM)
> +               fprintf(stderr, "Timed out while connecting to server\n");
> +       kill(0, SIGKILL);
> +}
> +
> +static struct sigaction timeout_action = {
> +       .sa_handler = handle_timeout,
> +};
> +
> +static int connect_to_server(const struct sockaddr *addr, socklen_t len)
> +{
> +       int fd = -1;
> +
> +       fd = socket(addr->sa_family, SOCK_STREAM, 0);
> +       if (CHECK_FAIL(fd == -1))
> +               goto out;
> +       if (CHECK_FAIL(sigaction(SIGALRM, &timeout_action, NULL)))
> +               goto out;
> +       alarm(3);
> +       if (CHECK_FAIL(connect(fd, addr, len) == -1))
> +               goto close_out;
> +
> +       goto out;
> +
> +close_out:
> +       close(fd);
> +       fd = -1;
> +out:
> +       return fd;
> +}
> +
> +static in_port_t get_port(int fd)
> +{
> +       struct sockaddr_storage name;
> +       socklen_t len;
> +       in_port_t port = 0;
> +
> +       len = sizeof(name);
> +       if (CHECK_FAIL(getsockname(fd, (struct sockaddr *)&name, &len)))
> +               return port;
> +
> +       switch (name.ss_family) {
> +       case AF_INET:
> +               port = ((struct sockaddr_in *)&name)->sin_port;
> +               break;
> +       case AF_INET6:
> +               port = ((struct sockaddr_in6 *)&name)->sin6_port;
> +               break;
> +       default:
> +               CHECK(1, "Invalid address family", "%d\n", name.ss_family);
> +       }
> +       return port;
> +}
> +
> +static int run_test(int server_fd, const struct sockaddr *addr, socklen_t len)
> +{
> +       int client = -1, srv_client = -1;
> +       char buf[] = "testing";
> +       in_port_t port;
> +       int ret = 1;
> +
> +       client = connect_to_server(addr, len);
> +       if (client == -1) {
> +               perror("Cannot connect to server");
> +               goto out;
> +       }
> +
> +       srv_client = accept(server_fd, NULL, NULL);
> +       if (CHECK_FAIL(srv_client == -1)) {
> +               perror("Can't accept connection");
> +               goto out;
> +       }
> +       if (CHECK_FAIL(write(client, buf, sizeof(buf)) != sizeof(buf))) {
> +               perror("Can't write on client");
> +               goto out;
> +       }
> +       if (CHECK_FAIL(read(srv_client, buf, sizeof(buf)) != sizeof(buf))) {
> +               perror("Can't read on server");
> +               goto out;
> +       }
> +
> +       port = get_port(srv_client);
> +       if (CHECK_FAIL(!port))
> +               goto out;
> +       if (CHECK(port != htons(TEST_DPORT), "Expected", "port %u but got %u",
> +                 TEST_DPORT, ntohs(port)))
> +               goto out;
> +
> +       ret = 0;
> +out:
> +       close(client);
> +       close(srv_client);
> +       return ret;
> +}
> +
> +static int do_sk_assign(void)
> +{
> +       struct sockaddr_in addr4;
> +       struct sockaddr_in6 addr6;
> +       int server = -1;
> +       int server_v6 = -1;
> +       int err = 1;
> +
> +       memset(&addr4, 0, sizeof(addr4));
> +       addr4.sin_family = AF_INET;
> +       addr4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +       addr4.sin_port = htons(1234);
> +
> +       memset(&addr6, 0, sizeof(addr6));
> +       addr6.sin6_family = AF_INET6;
> +       addr6.sin6_addr = in6addr_loopback;
> +       addr6.sin6_port = htons(1234);
> +
> +       server = start_server((const struct sockaddr *)&addr4, sizeof(addr4));
> +       if (server == -1)
> +               goto out;
> +
> +       server_v6 = start_server((const struct sockaddr *)&addr6,
> +                                sizeof(addr6));
> +       if (server_v6 == -1)
> +               goto out;
> +
> +       /* Connect to unbound ports */
> +       addr4.sin_port = htons(TEST_DPORT);
> +       addr6.sin6_port = htons(TEST_DPORT);
> +
> +       test__start_subtest("ipv4 port redir");
> +       if (run_test(server, (const struct sockaddr *)&addr4, sizeof(addr4)))
> +               goto out;
> +
> +       test__start_subtest("ipv6 port redir");
> +       if (run_test(server_v6, (const struct sockaddr *)&addr6, sizeof(addr6)))
> +               goto out;
> +
> +       /* Connect to unbound addresses */
> +       addr4.sin_addr.s_addr = htonl(TEST_DADDR);
> +       addr6.sin6_addr.s6_addr32[3] = htonl(TEST_DADDR);
> +
> +       test__start_subtest("ipv4 addr redir");
> +       if (run_test(server, (const struct sockaddr *)&addr4, sizeof(addr4)))
> +               goto out;
> +
> +       test__start_subtest("ipv6 addr redir");
> +       if (run_test(server_v6, (const struct sockaddr *)&addr6, sizeof(addr6)))
> +               goto out;
> +
> +       err = 0;
> +out:
> +       close(server);
> +       close(server_v6);
> +       return err;
> +}
> +
> +void test_sk_assign(void)
> +{
> +       int self_net;
> +
> +       self_net = open(NS_SELF, O_RDONLY);
> +       if (CHECK_FAIL(self_net < 0)) {
> +               perror("Unable to open "NS_SELF);
> +               return;
> +       }
> +
> +       if (!configure_stack(self_net)) {
> +               perror("configure_stack");
> +               goto cleanup;
> +       }
> +
> +       do_sk_assign();
> +
> +cleanup:
> +       close(self_net);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
> new file mode 100644
> index 000000000000..7de30ad3f594
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Cloudflare Ltd.
> +
> +#include <stddef.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <linux/bpf.h>
> +#include <linux/if_ether.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/pkt_cls.h>
> +#include <linux/tcp.h>
> +#include <sys/socket.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +int _version SEC("version") = 1;
> +char _license[] SEC("license") = "GPL";
> +
> +/* Fill 'tuple' with L3 info, and attempt to find L4. On fail, return NULL. */
> +static struct bpf_sock_tuple *get_tuple(void *data, __u64 nh_off,
> +                                       void *data_end, __u16 eth_proto,
> +                                       bool *ipv4)
> +{
> +       struct bpf_sock_tuple *result;
> +       __u8 proto = 0;
> +       __u64 ihl_len;
> +
> +       if (eth_proto == bpf_htons(ETH_P_IP)) {
> +               struct iphdr *iph = (struct iphdr *)(data + nh_off);
> +
> +               if (iph + 1 > data_end)
> +                       return NULL;
> +               if (iph->ihl != 5)
> +                       /* Options are not supported */
> +                       return NULL;
> +               ihl_len = iph->ihl * 4;
> +               proto = iph->protocol;
> +               *ipv4 = true;
> +               result = (struct bpf_sock_tuple *)&iph->saddr;
> +       } else if (eth_proto == bpf_htons(ETH_P_IPV6)) {
> +               struct ipv6hdr *ip6h = (struct ipv6hdr *)(data + nh_off);
> +
> +               if (ip6h + 1 > data_end)
> +                       return NULL;
> +               ihl_len = sizeof(*ip6h);
> +               proto = ip6h->nexthdr;
> +               *ipv4 = false;
> +               result = (struct bpf_sock_tuple *)&ip6h->saddr;
> +       } else {
> +               return NULL;
> +       }
> +
> +       if (result + 1 > data_end || proto != IPPROTO_TCP)
> +               return NULL;
> +
> +       return result;
> +}
> +
> +SEC("sk_assign_test")
> +int bpf_sk_assign_test(struct __sk_buff *skb)
> +{
> +       void *data_end = (void *)(long)skb->data_end;
> +       void *data = (void *)(long)skb->data;
> +       struct ethhdr *eth = (struct ethhdr *)(data);
> +       struct bpf_sock_tuple *tuple, ln = {0};
> +       struct bpf_sock *sk;
> +       int tuple_len;
> +       bool ipv4;
> +       int ret;
> +
> +       if (eth + 1 > data_end)
> +               return TC_ACT_SHOT;
> +
> +       tuple = get_tuple(data, sizeof(*eth), data_end, eth->h_proto, &ipv4);
> +       if (!tuple)
> +               return TC_ACT_SHOT;
> +
> +       tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
> +       sk = bpf_skc_lookup_tcp(skb, tuple, tuple_len, BPF_F_CURRENT_NETNS, 0);
> +       if (sk) {
> +               if (sk->state != BPF_TCP_LISTEN)
> +                       goto assign;
> +
> +               bpf_sk_release(sk);
> +       }
> +
> +       if (ipv4) {
> +               if (tuple->ipv4.dport != bpf_htons(4321))
> +                       return TC_ACT_OK;
> +
> +               ln.ipv4.daddr = bpf_htonl(0x7f000001);
> +               ln.ipv4.dport = bpf_htons(1234);
> +
> +               sk = bpf_skc_lookup_tcp(skb, &ln, sizeof(ln.ipv4),
> +                                       BPF_F_CURRENT_NETNS, 0);
> +       } else {
> +               if (tuple->ipv6.dport != bpf_htons(4321))
> +                       return TC_ACT_OK;
> +
> +               /* Upper parts of daddr are already zero. */
> +               ln.ipv6.daddr[3] = bpf_htonl(0x1);
> +               ln.ipv6.dport = bpf_htons(1234);
> +
> +               sk = bpf_skc_lookup_tcp(skb, &ln, sizeof(ln.ipv6),
> +                                       BPF_F_CURRENT_NETNS, 0);
> +       }
> +
> +       /* We can't do a single skc_lookup_tcp here, because then the compiler
> +        * will likely spill tuple_len to the stack. This makes it lose all
> +        * bounds information in the verifier, which then rejects the call as
> +        * unsafe.
> +        */
> +       if (!sk)
> +               return TC_ACT_SHOT;
> +
> +       if (sk->state != BPF_TCP_LISTEN) {
> +               bpf_sk_release(sk);
> +               return TC_ACT_SHOT;
> +       }
> +
> +assign:
> +       ret = bpf_sk_assign(skb, sk, 0);
> +       bpf_sk_release(sk);
> +       return ret == 0 ? TC_ACT_OK : TC_ACT_SHOT;
> +}
> --
> 2.20.1
>


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
