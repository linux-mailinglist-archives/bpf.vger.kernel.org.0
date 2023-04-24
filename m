Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15156ED53E
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjDXTUj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjDXTUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 15:20:38 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387674C2B
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:20:35 -0700 (PDT)
Message-ID: <79062e12-6492-362e-c5e3-b08931da0818@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682364033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3CEdFWGw09p9O4pUP393uVZOgjdY4uYMfAlPb3fOhw=;
        b=Xop/z1P5khmkDPUXS7Cfz3uNE/rjYBwukAXjofrqzxKx8QdmgzkS5l/Y7n4rzYnxUvwbVy
        XI1CCPd5pTc+B1pcOEPyImFgvoAMxasqGrxbSPXiUmxKJMyzcKo4vHvHRRX2iYJvLgjKnS
        MqDM1gLTuIT4pWGH9Ef8PXu1fJnv334=
Date:   Mon, 24 Apr 2023 12:20:30 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] selftests/bpf: Test bpf_sock_destroy
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com, bpf@vger.kernel.org
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-8-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230418153148.2231644-8-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/18/23 8:31 AM, Aditi Ghag wrote:
> The test cases for destroying sockets mirror the intended usages of the
> bpf_sock_destroy kfunc using iterators.
> 
> The destroy helpers set `ECONNABORTED` error code that we can validate in
> the test code with client sockets. But UDP sockets have an overriding error
> code from the disconnect called during abort, so the error code the
> validation is only done for TCP sockets.
> 
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/sock_destroy.c   | 217 ++++++++++++++++++
>   .../selftests/bpf/progs/sock_destroy_prog.c   | 147 ++++++++++++
>   2 files changed, 364 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> new file mode 100644
> index 000000000000..51f2454b7b4b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/bpf_endian.h>
> +
> +#include "sock_destroy_prog.skel.h"
> +#include "network_helpers.h"
> +
> +#define TEST_NS "sock_destroy_netns"
> +
> +static void start_iter_sockets(struct bpf_program *prog)
> +{
> +	struct bpf_link *link;
> +	char buf[50] = {};
> +	int iter_fd, len;
> +
> +	link = bpf_program__attach_iter(prog, NULL);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		return;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> +		goto free_link;
> +
> +	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +		;
> +	ASSERT_GE(len, 0, "read");
> +
> +	close(iter_fd);
> +
> +free_link:
> +	bpf_link__destroy(link);
> +}
> +
> +static void test_tcp_client(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;

Together with the multiple goto labels, all the ' = -1' init looks weird. May as 
well: keep this ' = -1' init, always test for -1 before close() and remove the 
need to have mulpite goto label in each test_*() function.

The 'n = 0' init is not needed for sure.

> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup_serv;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> +		goto cleanup_serv;
> +
> +	serv = accept(serv, NULL, NULL);
> +	if (!ASSERT_GE(serv, 0, "serv accept"))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_GE(n, 0, "client send"))

nit. Could be more strict. ASSERT_EQ(n, 1, ...)?

> +		goto cleanup;
> +
> +	/* Run iterator program that destroys connected client sockets. */
> +	start_iter_sockets(skel->progs.iter_tcp6_client);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> +		goto cleanup;
> +	ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket");
> +
> +

Patchwork 
(https://patchwork.kernel.org/project/netdevbpf/patch/20230418153148.2231644-8-aditi.ghag@isovalent.com/) 
reports:

CHECK: Please don't use multiple blank lines
#90: FILE: tools/testing/selftests/bpf/prog_tests/sock_destroy.c:62:
+
+

CHECK: Please don't use multiple blank lines
#130: FILE: tools/testing/selftests/bpf/prog_tests/sock_destroy.c:102:
+
+

CHECK: Please don't use multiple blank lines
#137: FILE: tools/testing/selftests/bpf/prog_tests/sock_destroy.c:109:
+
+

> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +static void test_tcp_server(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0, err;
> +	__u16 serv_port = 0;

serv_port init is also not needed.

> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup_serv;
> +	err = get_socket_local_port(AF_INET6, serv, &serv_port);
> +	if (!ASSERT_EQ(err, 0, "get_local_port"))
> +		goto cleanup;

Like here, it is obvious that it should be 'goto cleanup_serv;'
Test -1 before close() and avoid this multiple goto label confusion.

> +	skel->bss->serv_port = serv_port;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> +		goto cleanup_serv;
> +
> +	serv = accept(serv, NULL, NULL);
> +	if (!ASSERT_GE(serv, 0, "serv accept"))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_GE(n, 0, "client send"))
> +		goto cleanup;
> +
> +	/* Run iterator program that destroys server sockets. */
> +	start_iter_sockets(skel->progs.iter_tcp6_server);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> +		goto cleanup;
> +	ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
> +
> +
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +
> +static void test_udp_client(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup_serv;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> +		goto cleanup_serv;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_GE(n, 0, "client send"))
> +		goto cleanup;
> +
> +	/* Run iterator program that destroys sockets. */
> +	start_iter_sockets(skel->progs.iter_udp6_client);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> +		goto cleanup;
> +	/* UDP sockets have an overriding error code after they are disconnected,
> +	 * so we don't check for ECONNABORTED error code.
> +	 */
> +
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +static void test_udp_server(struct sock_destroy_prog *skel)
> +{
> +	int *listen_fds = NULL, n, i, err;
> +	unsigned int num_listens = 5;
> +	char buf[1];
> +	__u16 serv_port;
> +
> +	/* Start reuseport servers. */
> +	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
> +					    "::1", 0, 0, num_listens);
> +	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
> +		goto cleanup;
> +	err = get_socket_local_port(AF_INET6, listen_fds[0], &serv_port);
> +	if (!ASSERT_EQ(err, 0, "get_local_port"))
> +		goto cleanup;
> +	skel->bss->serv_port = ntohs(serv_port);

This is different from test_tcp_server() which has serv_port in network order. 
Either order is fine but be consistent across tests.

> +
> +	/* Run iterator program that destroys server sockets. */
> +	start_iter_sockets(skel->progs.iter_udp6_server);
> +
> +	for (i = 0; i < num_listens; ++i) {
> +		n = read(listen_fds[i], buf, sizeof(buf));
> +		if (!ASSERT_EQ(n, -1, "read") ||
> +		    !ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket"))
> +			break;
> +	}
> +	ASSERT_EQ(i, num_listens, "server socket");
> +
> +cleanup:
> +	free_fds(listen_fds, num_listens);
> +}
> +
> +void test_sock_destroy(void)
> +{
> +	struct sock_destroy_prog *skel;
> +	struct nstoken *nstoken = NULL;

This init looks unnecessary.

> +	int cgroup_fd = 0;

Looks wrong to init a fd to 0. I don't think an init is needed either.

> +
> +	skel = sock_destroy_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	cgroup_fd = test__join_cgroup("/sock_destroy");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto close_cgroup_fd;
> +
> +	skel->links.sock_connect = bpf_program__attach_cgroup(
> +		skel->progs.sock_connect, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
> +		goto close_cgroup_fd;
> +
> +	SYS(fail, "ip netns add %s", TEST_NS);
> +	SYS(fail, "ip -net %s link set dev lo up", TEST_NS);
> +
> +	nstoken = open_netns(TEST_NS);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto fail;
> +
> +	if (test__start_subtest("tcp_client"))
> +		test_tcp_client(skel);
> +	if (test__start_subtest("tcp_server"))
> +		test_tcp_server(skel);
> +	if (test__start_subtest("udp_client"))
> +		test_udp_client(skel);
> +	if (test__start_subtest("udp_server"))
> +		test_udp_server(skel);
> +
> +
> +fail:
> +	if (nstoken)
> +		close_netns(nstoken);
> +	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
> +close_cgroup_fd:
> +	close(cgroup_fd);
> +	sock_destroy_prog__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> new file mode 100644
> index 000000000000..1f265e0d9dea
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +#include "bpf_tracing_net.h"
> +
> +#define AF_INET6 10

Not needed. This has already been defined in bpf_tracing_net.h.

> +
> +__u16 serv_port = 0;
> +
> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} tcp_conn_sockets SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} udp_conn_sockets SEC(".maps");
> +
> +SEC("cgroup/connect6")
> +int sock_connect(struct bpf_sock_addr *ctx)
> +{
> +	int key = 0;
> +	__u64 sock_cookie = 0;
> +	__u32 keyc = 0;
> +
> +	if (ctx->family != AF_INET6 || ctx->user_family != AF_INET6)
> +		return 1;
> +
> +	sock_cookie = bpf_get_socket_cookie(ctx);
> +	if (ctx->protocol == IPPROTO_TCP)
> +		bpf_map_update_elem(&tcp_conn_sockets, &key, &sock_cookie, 0);
> +	else if (ctx->protocol == IPPROTO_UDP)
> +		bpf_map_update_elem(&udp_conn_sockets, &keyc, &sock_cookie, 0);
> +	else
> +		return 1;
> +
> +	return 1;
> +}
> +
> +SEC("iter/tcp")
> +int iter_tcp6_client(struct bpf_iter__tcp *ctx)
> +{
> +	struct sock_common *sk_common = ctx->sk_common;
> +	__u64 sock_cookie = 0;
> +	__u64 *val;
> +	int key = 0;
> +
> +	if (!sk_common)
> +		return 0;
> +
> +	if (sk_common->skc_family != AF_INET6)
> +		return 0;
> +
> +	sock_cookie  = bpf_get_socket_cookie(sk_common);
> +	val = bpf_map_lookup_elem(&tcp_conn_sockets, &key);
> +	if (!val)
> +		return 0;
> +	/* Destroy connected client sockets. */
> +	if (sock_cookie == *val)
> +		bpf_sock_destroy(sk_common);
> +
> +	return 0;
> +}
> +
> +SEC("iter/tcp")
> +int iter_tcp6_server(struct bpf_iter__tcp *ctx)
> +{
> +	struct sock_common *sk_common = ctx->sk_common;
> +	struct tcp6_sock *tcp_sk;
> +	const struct inet_connection_sock *icsk;
> +	const struct inet_sock *inet;
> +	__u16 srcp;
> +
> +	if (!sk_common)
> +		return 0;
> +
> +	if (sk_common->skc_family != AF_INET6)
> +		return 0;
> +
> +	tcp_sk = bpf_skc_to_tcp6_sock(sk_common);
> +	if (!tcp_sk)
> +		return 0;
> +
> +	icsk = &tcp_sk->tcp.inet_conn;
> +	inet = &icsk->icsk_inet;
> +	srcp = inet->inet_sport;
> +
> +	/* Destroy server sockets. */
> +	if (srcp == serv_port)
> +		bpf_sock_destroy(sk_common);
> +
> +	return 0;
> +}
> +
> +
> +SEC("iter/udp")
> +int iter_udp6_client(struct bpf_iter__udp *ctx)
> +{
> +	struct udp_sock *udp_sk = ctx->udp_sk;
> +	struct sock *sk = (struct sock *) udp_sk;
> +	__u64 sock_cookie = 0, *val;
> +	int key = 0;
> +
> +	if (!sk)
> +		return 0;
> +
> +	sock_cookie  = bpf_get_socket_cookie(sk);
> +	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
> +	if (!val)
> +		return 0;
> +	/* Destroy connected client sockets. */
> +	if (sock_cookie == *val)
> +		bpf_sock_destroy((struct sock_common *)sk);
> +
> +	return 0;
> +}
> +
> +SEC("iter/udp")
> +int iter_udp6_server(struct bpf_iter__udp *ctx)
> +{
> +	struct udp_sock *udp_sk = ctx->udp_sk;
> +	struct sock *sk = (struct sock *) udp_sk;
> +	__u16 srcp;
> +	struct inet_sock *inet;
> +
> +	if (!sk)
> +		return 0;
> +
> +	inet = &udp_sk->inet;
> +	srcp = bpf_ntohs(inet->inet_sport);

Try sk->sk_num if host order is preferred.

> +	if (srcp == serv_port)
> +		bpf_sock_destroy((struct sock_common *)sk);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

