Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7F6C87BC
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjCXVw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 17:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXVw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 17:52:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E73CBA
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 14:52:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id qa18-20020a17090b4fd200b002400d8a8d1dso2794908pjb.7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679694774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlRcEgUypjhWp0KDJ3+vzkXbHrvQa/enaKjXiSZFbdA=;
        b=ZJuNf4xHJboudQkLI4rrUmE6vnw3/FRiTz6VqcafrPOaZl1rSbSczJM2w7jRK/WGZc
         BpvpwysrEthtX6+sO6z/zJOO9ii81rUsdiGDerDPuiY5/I6ZJHp4iUPZnawtbzMTBGR1
         DXeoSlbi9h+xCl97SJaPY1moKNtPVwzx4W3bd6QuW7PhwaLh4dsSTt9mpLB72hO5ZBqj
         H+kIQ8WJlPtvw6IrqqAyw49oOCZ/+3B4ZmxTuSx0S1k2L0ew/Ozbt9jICMMm0niGTtNU
         QPEDL+HL3FkdGpuzHXkWjqC2Zmgu4jYOcmmIaKqIsDowukvsByxVykzc5kx0eQX/QqNo
         Zm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679694774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlRcEgUypjhWp0KDJ3+vzkXbHrvQa/enaKjXiSZFbdA=;
        b=RPVy3rfQ7M/AY1kK0NLTHGsL/NthfEYlJKn9bGUmC8wbWGrapxbpHLhsG9BX9/7cCR
         TUYluYaP3nsoYnvlhArT7PMN6r9eGFp3ORnh1gfOrswyH/M8AdznB+0rlFG4Kk8zXNBi
         6WMUeVf9t9Fz6arurh2p+biUhZ7gVlIbEOIe9z4Jf3HqyHPnOI8zj1JFXklB2SyCjaf3
         YYsISSZ1pQ9+xkpz9yEc1sPIBY46pXaZxHqILy1T6hr7qYzYdV3+oJVr0+4JYc112/it
         mFxIMJVZFkISoKBAyHF2vFc5Au3E+8IKbWdY4cQqkHElDlyTBNLc1IsOLSNDsHKJ3Wi+
         1dxQ==
X-Gm-Message-State: AAQBX9e9VDrh8n1XoljGHI2kHFqaxhV9olFDxmEdSksklqJSvVuH8AWq
        MW+QT8D2QElwWkZM/ZbcPzDraRE=
X-Google-Smtp-Source: AKy350aHgoEtrqe3lQguXXiZClVmnswpQ8bh3UZe7Gy1dFc1ccWvmY1/nXj4BhA0oR096wku5yAkVyE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2da5:b0:624:c7cc:3d0e with SMTP id
 fb37-20020a056a002da500b00624c7cc3d0emr2345877pfb.6.1679694774683; Fri, 24
 Mar 2023 14:52:54 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:52:53 -0700
In-Reply-To: <20230323200633.3175753-5-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com> <20230323200633.3175753-5-aditi.ghag@isovalent.com>
Message-ID: <ZB4btVWyDjjdIqhV@google.com>
Subject: Re: [PATCH v4 bpf-next 4/4] selftests/bpf: Add tests for bpf_sock_destroy
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23, Aditi Ghag wrote:
> The test cases for destroying sockets mirror the intended usages of the
> bpf_sock_destroy kfunc using iterators.

> The destroy helpers set `ECONNABORTED` error code that we can validate in
> the test code with client sockets. But UDP sockets have an overriding  
> error
> code from the disconnect called during abort, so the error code the
> validation is only done for TCP sockets.

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/sock_destroy.c   | 195 ++++++++++++++++++
>   .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++++++
>   2 files changed, 346 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c  
> b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> new file mode 100644
> index 000000000000..cbce966af568
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "sock_destroy_prog.skel.h"
> +#include "network_helpers.h"
> +
> +#define SERVER_PORT 6062
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
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +static void test_tcp_server(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, 0);
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
> +	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
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
> +	/* UDP sockets have an overriding error code after they are  
> disconnected,
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
> +	int *listen_fds = NULL, n, i;
> +	unsigned int num_listens = 5;
> +	char buf[1];
> +
> +	/* Start reuseport servers. */
> +	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
> +					    "::1", SERVER_PORT, 0,
> +					    num_listens);
> +	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
> +		goto cleanup;
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
> +	int cgroup_fd = 0;
> +	struct sock_destroy_prog *skel;
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
> +close_cgroup_fd:
> +	close(cgroup_fd);
> +	sock_destroy_prog__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c  
> b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> new file mode 100644
> index 000000000000..8e09d82c50f3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +#define AF_INET6 10

[..]

> +/* Keep it in sync with prog_test/sock_destroy. */
> +#define SERVER_PORT 6062

The test looks good, one optional unrelated nit maybe:

I've been guilty of these hard-coded ports in the past, but maybe
we should stop hard-coding them? Getting the address of the listener (bound  
to
port 0) and passing it to the bpf program via global variable should be  
super
easy now (with the skeletons and network_helpers).

And, unrelated, maybe also fix a bunch of places where the reverse christmas
tree doesn't look reverse anymore?

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
> +	struct seq_file *seq = ctx->meta->seq;
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
> +	struct seq_file *seq = ctx->meta->seq;
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
> +	srcp = bpf_ntohs(inet->inet_sport);
> +
> +	/* Destroy server sockets. */
> +	if (srcp == SERVER_PORT)
> +		bpf_sock_destroy(sk_common);
> +
> +	return 0;
> +}
> +
> +
> +SEC("iter/udp")
> +int iter_udp6_client(struct bpf_iter__udp *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
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
> +	struct seq_file *seq = ctx->meta->seq;
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
> +	if (srcp == SERVER_PORT)
> +		bpf_sock_destroy((struct sock_common *)sk);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.34.1

