Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD56D0E0A
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjC3SqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjC3SqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:46:08 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289D119
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:46:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 16-20020a056a00073000b006260bbaa3a4so9302448pfm.16
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOoyqUdyGAFU6KUlb8jCCkuXcGWvCQhC8bjosXcGMkc=;
        b=F1wTzreXOJaBcx6ipDBiTExrlNEw+yYBQ+UmlE2IdVMZq64oN4el+395jBaGkUwysJ
         wVt16PyI2kicYxYeVQec29TPdBxA5Pk7n0N42nsiIf4yJIzBlRztoendUWWODTirgtI7
         l4iiuE+M04TaQYqOJAhDZfLRjzQCcke9nCD7aYR7OMYSi/dJjOilvdv6oHeJ4+JVoDwv
         epQ+wLEh9V0nkgEFOBE+9Qtwx124qsGbqDScrIenKsCjRR4PGIiHGxdOxPpw+/w4mjmK
         4WIGNfq1ro0oGPgNUWlvjYXtExNy5e/3Z15h47jMtI9f31vSJc1Glc9eoXe7x1znwmWI
         pPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOoyqUdyGAFU6KUlb8jCCkuXcGWvCQhC8bjosXcGMkc=;
        b=QniPWLtvRidmzjOwR80EB/mr2o00y5/v9BS7SMT/6Y32eeYZ8QcPTAk0agy65rrVCQ
         OgSWuHVsYNyPCeYFmbkHdAbY2s5nmBdIGlYuTBwK+OrT72ORzteZsq+4wQFBBBvqWL1g
         hXuGpvNy5JVUpRjiRNM/530qV4UxWqJPacafH5iZCVuaEUXAwohvqrX02LqzEV1abul4
         cs4vskeYnElwiWH4EmcxM6GEFiXlnW46Ev3NNTXDpBYwbI2JsV0iU3arxX3VMtZ4dEhS
         E8yV67TDVcYDpQvLJOMEiHnLpwQYSPJ7Tn4wWym5pGWgmA6pULvQe6w3IQ08WAEgpO5d
         Bdxw==
X-Gm-Message-State: AAQBX9f45qQtma151ISXad2+43zw4NXG68viSAcMvB5IeUGgCG/1qltv
        nWFcelQQS24nkQNJEzLn6kPDzug=
X-Google-Smtp-Source: AKy350bCD8Xed/9D+k5gR/2X/B80XLK9/GiJoYbIM3NPCEV9pp1fW04Wpqos3yjxEO5hWIVQLnS3NPg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:23d3:b0:62a:424b:2af0 with SMTP id
 g19-20020a056a0023d300b0062a424b2af0mr11900683pfc.0.1680201964512; Thu, 30
 Mar 2023 11:46:04 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:46:02 -0700
In-Reply-To: <20230330151758.531170-8-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230330151758.531170-1-aditi.ghag@isovalent.com> <20230330151758.531170-8-aditi.ghag@isovalent.com>
Message-ID: <ZCXY6mOY8pPLhdBF@google.com>
Subject: Re: [PATCH v5 bpf-next 7/7] selftests/bpf: Test bpf_sock_destroy
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

On 03/30, Aditi Ghag wrote:
> The test cases for destroying sockets mirror the intended usages of the
> bpf_sock_destroy kfunc using iterators.

> The destroy helpers set `ECONNABORTED` error code that we can validate in
> the test code with client sockets. But UDP sockets have an overriding  
> error
> code from the disconnect called during abort, so the error code the
> validation is only done for TCP sockets.

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/sock_destroy.c   | 203 ++++++++++++++++++
>   .../selftests/bpf/progs/sock_destroy_prog.c   | 147 +++++++++++++
>   2 files changed, 350 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c  
> b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> new file mode 100644
> index 000000000000..d5d16fabac48
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/bpf_endian.h>
> +
> +#include "sock_destroy_prog.skel.h"
> +#include "network_helpers.h"
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
> +	int serv = -1, clien = -1, n = 0, err;
> +	__u16 serv_port = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup_serv;
> +	err = get_sock_port6(serv, &serv_port);
> +	if (!ASSERT_EQ(err, 0, "get_sock_port6"))
> +		goto cleanup;
> +	skel->bss->serv_port = ntohs(serv_port);

This looks great, thank you for removing those hard codes!

I have one optional nit, feel free to ignore: you do ntohs here and in
the bpf program. Why not store the port in network byte order? Then
you can avoid all those ntohs and compare the ports directly...

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
> +	err = get_sock_port6(listen_fds[0], &serv_port);
> +	if (!ASSERT_EQ(err, 0, "get_sock_port6"))
> +		goto cleanup;
> +	skel->bss->serv_port = ntohs(serv_port);
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
> +	int cgroup_fd = 0;
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
> index 000000000000..5c1e65d50598
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
> +	srcp = bpf_ntohs(inet->inet_sport);
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
> +	if (srcp == serv_port)
> +		bpf_sock_destroy((struct sock_common *)sk);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.34.1

