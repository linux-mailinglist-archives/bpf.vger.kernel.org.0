Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028E6CAB1D
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjC0QzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0QzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 12:55:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44628BA
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:55:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ie21-20020a17090b401500b0023b4ba1e433so2360494pjb.0
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679936101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9nZgO2QyhrQbIAc34yMAPgtgLqPKHfAvM25MYc6Y44=;
        b=Ibs0EM3huINW6OW8v4EuLAZ5k6QCf/asubJ7Bple02bXIGpSSOSC845+N39l/BfV4E
         qBoNt1bkqeCS/4hpAX9YT1jz9mONbZayZYVPrWB+NLhpq9SgMQZR5wa+nU9bULmtKtLS
         1XyFCAoVmnH3K+D8Kyu15UMplm0/81jsXydqUMjIC2MzucA2DTGWI3M8lx5zuDCz9o8c
         s+j9pvJrwX/hzCF6ZGPDwXKYFeda3KrYhXmjBEmUencSaRnwQsF4nZcnS30+nlRMXWUa
         lZOkWos5KmGqCtqzBa/VtZS+IhrEPv5g575itnkHZx8mQFuN6tqIV1o+0tioMDnhCgQl
         XHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9nZgO2QyhrQbIAc34yMAPgtgLqPKHfAvM25MYc6Y44=;
        b=8A57niOZN76l/NppXLm/IOf4kFYYGmTCoxzZyeHueMSTQ5ucPvFeuLlFj0KhjhZ3Me
         4IXJlB00eoUzO0XXJOvedk1VdpTq8wo5pYeG999ocyzUSL37J/UDIHWvTkJ9ZikF0dsm
         D8Yhy5DuAJS2bKKWts0PSWJuR2IPzqyQpY9k4jBRdh9x570X+RhIqeRpr+RCeXhlLk/p
         tjzy8REw2x5/nsTZFTxGUbU0NX/30Vv3qTD9eYY3p6Rf7pmZAL+zvCPhX/eYQCbICK06
         wDr3WgKARf2NwomRfwkNHwpr01VcpOZWIOfg7eobAdhRXIhCt+hQWUJ81mJ0vlMYMzSz
         pi3g==
X-Gm-Message-State: AAQBX9fj/BoyMEJ+4mvVygU3HjyzIKzFNhByDZO5jGe/RpnEcd+n4iiR
        +V6xzgJphUsUiWlFod6CFSySOSs=
X-Google-Smtp-Source: AKy350Z01ymq7Yr2M8MjyMmTv48NSET6h9XsABFrlX6jFUyiwQvBQafdTl6UarHy4PjTNGtn5U7Ylq8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4f4b:b0:23b:5155:309f with SMTP id
 pj11-20020a17090b4f4b00b0023b5155309fmr7416125pjb.0.1679936100742; Mon, 27
 Mar 2023 09:55:00 -0700 (PDT)
Date:   Mon, 27 Mar 2023 09:54:59 -0700
In-Reply-To: <DD6B5D46-CDA5-4510-8647-28445AD92DE1@isovalent.com>
Mime-Version: 1.0
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-5-aditi.ghag@isovalent.com> <ZB4btVWyDjjdIqhV@google.com>
 <DD6B5D46-CDA5-4510-8647-28445AD92DE1@isovalent.com>
Message-ID: <ZCHKY4Bmb6mgc8ea@google.com>
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

On 03/27, Aditi Ghag wrote:


> > On Mar 24, 2023, at 2:52 PM, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 03/23, Aditi Ghag wrote:
> >> The test cases for destroying sockets mirror the intended usages of the
> >> bpf_sock_destroy kfunc using iterators.
> >
> >> The destroy helpers set `ECONNABORTED` error code that we can validate  
> in
> >> the test code with client sockets. But UDP sockets have an overriding  
> error
> >> code from the disconnect called during abort, so the error code the
> >> validation is only done for TCP sockets.
> >
> >> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> >> ---
> >>  .../selftests/bpf/prog_tests/sock_destroy.c   | 195 ++++++++++++++++++
> >>  .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++++++
> >>  2 files changed, 346 insertions(+)
> >>  create mode 100644  
> tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> >>  create mode 100644  
> tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> >
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c  
> b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> >> new file mode 100644
> >> index 000000000000..cbce966af568
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> >> @@ -0,0 +1,195 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +#include <test_progs.h>
> >> +
> >> +#include "sock_destroy_prog.skel.h"
> >> +#include "network_helpers.h"
> >> +
> >> +#define SERVER_PORT 6062
> >> +
> >> +static void start_iter_sockets(struct bpf_program *prog)
> >> +{
> >> +	struct bpf_link *link;
> >> +	char buf[50] = {};
> >> +	int iter_fd, len;
> >> +
> >> +	link = bpf_program__attach_iter(prog, NULL);
> >> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> >> +		return;
> >> +
> >> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> >> +	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> >> +		goto free_link;
> >> +
> >> +	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> >> +		;
> >> +	ASSERT_GE(len, 0, "read");
> >> +
> >> +	close(iter_fd);
> >> +
> >> +free_link:
> >> +	bpf_link__destroy(link);
> >> +}
> >> +
> >> +static void test_tcp_client(struct sock_destroy_prog *skel)
> >> +{
> >> +	int serv = -1, clien = -1, n = 0;
> >> +
> >> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> >> +	if (!ASSERT_GE(serv, 0, "start_server"))
> >> +		goto cleanup_serv;
> >> +
> >> +	clien = connect_to_fd(serv, 0);
> >> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> >> +		goto cleanup_serv;
> >> +
> >> +	serv = accept(serv, NULL, NULL);
> >> +	if (!ASSERT_GE(serv, 0, "serv accept"))
> >> +		goto cleanup;
> >> +
> >> +	n = send(clien, "t", 1, 0);
> >> +	if (!ASSERT_GE(n, 0, "client send"))
> >> +		goto cleanup;
> >> +
> >> +	/* Run iterator program that destroys connected client sockets. */
> >> +	start_iter_sockets(skel->progs.iter_tcp6_client);
> >> +
> >> +	n = send(clien, "t", 1, 0);
> >> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> >> +		goto cleanup;
> >> +	ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket");
> >> +
> >> +
> >> +cleanup:
> >> +	close(clien);
> >> +cleanup_serv:
> >> +	close(serv);
> >> +}
> >> +
> >> +static void test_tcp_server(struct sock_destroy_prog *skel)
> >> +{
> >> +	int serv = -1, clien = -1, n = 0;
> >> +
> >> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, 0);
> >> +	if (!ASSERT_GE(serv, 0, "start_server"))
> >> +		goto cleanup_serv;
> >> +
> >> +	clien = connect_to_fd(serv, 0);
> >> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> >> +		goto cleanup_serv;
> >> +
> >> +	serv = accept(serv, NULL, NULL);
> >> +	if (!ASSERT_GE(serv, 0, "serv accept"))
> >> +		goto cleanup;
> >> +
> >> +	n = send(clien, "t", 1, 0);
> >> +	if (!ASSERT_GE(n, 0, "client send"))
> >> +		goto cleanup;
> >> +
> >> +	/* Run iterator program that destroys server sockets. */
> >> +	start_iter_sockets(skel->progs.iter_tcp6_server);
> >> +
> >> +	n = send(clien, "t", 1, 0);
> >> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> >> +		goto cleanup;
> >> +	ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
> >> +
> >> +
> >> +cleanup:
> >> +	close(clien);
> >> +cleanup_serv:
> >> +	close(serv);
> >> +}
> >> +
> >> +
> >> +static void test_udp_client(struct sock_destroy_prog *skel)
> >> +{
> >> +	int serv = -1, clien = -1, n = 0;
> >> +
> >> +	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
> >> +	if (!ASSERT_GE(serv, 0, "start_server"))
> >> +		goto cleanup_serv;
> >> +
> >> +	clien = connect_to_fd(serv, 0);
> >> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> >> +		goto cleanup_serv;
> >> +
> >> +	n = send(clien, "t", 1, 0);
> >> +	if (!ASSERT_GE(n, 0, "client send"))
> >> +		goto cleanup;
> >> +
> >> +	/* Run iterator program that destroys sockets. */
> >> +	start_iter_sockets(skel->progs.iter_udp6_client);
> >> +
> >> +	n = send(clien, "t", 1, 0);
> >> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> >> +		goto cleanup;
> >> +	/* UDP sockets have an overriding error code after they are  
> disconnected,
> >> +	 * so we don't check for ECONNABORTED error code.
> >> +	 */
> >> +
> >> +cleanup:
> >> +	close(clien);
> >> +cleanup_serv:
> >> +	close(serv);
> >> +}
> >> +
> >> +static void test_udp_server(struct sock_destroy_prog *skel)
> >> +{
> >> +	int *listen_fds = NULL, n, i;
> >> +	unsigned int num_listens = 5;
> >> +	char buf[1];
> >> +
> >> +	/* Start reuseport servers. */
> >> +	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
> >> +					    "::1", SERVER_PORT, 0,
> >> +					    num_listens);
> >> +	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
> >> +		goto cleanup;
> >> +
> >> +	/* Run iterator program that destroys server sockets. */
> >> +	start_iter_sockets(skel->progs.iter_udp6_server);
> >> +
> >> +	for (i = 0; i < num_listens; ++i) {
> >> +		n = read(listen_fds[i], buf, sizeof(buf));
> >> +		if (!ASSERT_EQ(n, -1, "read") ||
> >> +		    !ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed  
> socket"))
> >> +			break;
> >> +	}
> >> +	ASSERT_EQ(i, num_listens, "server socket");
> >> +
> >> +cleanup:
> >> +	free_fds(listen_fds, num_listens);
> >> +}
> >> +
> >> +void test_sock_destroy(void)
> >> +{
> >> +	int cgroup_fd = 0;
> >> +	struct sock_destroy_prog *skel;
> >> +
> >> +	skel = sock_destroy_prog__open_and_load();
> >> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> >> +		return;
> >> +
> >> +	cgroup_fd = test__join_cgroup("/sock_destroy");
> >> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> >> +		goto close_cgroup_fd;
> >> +
> >> +	skel->links.sock_connect = bpf_program__attach_cgroup(
> >> +		skel->progs.sock_connect, cgroup_fd);
> >> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
> >> +		goto close_cgroup_fd;
> >> +
> >> +	if (test__start_subtest("tcp_client"))
> >> +		test_tcp_client(skel);
> >> +	if (test__start_subtest("tcp_server"))
> >> +		test_tcp_server(skel);
> >> +	if (test__start_subtest("udp_client"))
> >> +		test_udp_client(skel);
> >> +	if (test__start_subtest("udp_server"))
> >> +		test_udp_server(skel);
> >> +
> >> +
> >> +close_cgroup_fd:
> >> +	close(cgroup_fd);
> >> +	sock_destroy_prog__destroy(skel);
> >> +}
> >> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c  
> b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> >> new file mode 100644
> >> index 000000000000..8e09d82c50f3
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> >> @@ -0,0 +1,151 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include "vmlinux.h"
> >> +
> >> +#include "bpf_tracing_net.h"
> >> +#include <bpf/bpf_helpers.h>
> >> +#include <bpf/bpf_endian.h>
> >> +
> >> +#define AF_INET6 10
> >
> > [..]
> >
> >> +/* Keep it in sync with prog_test/sock_destroy. */
> >> +#define SERVER_PORT 6062
> >
> > The test looks good, one optional unrelated nit maybe:
> >
> > I've been guilty of these hard-coded ports in the past, but maybe
> > we should stop hard-coding them? Getting the address of the listener  
> (bound to
> > port 0) and passing it to the bpf program via global variable should be  
> super
> > easy now (with the skeletons and network_helpers).


> I briefly considered adding the ports in a map, and retrieving them in  
> the test. But it didn't seem worthwhile as the tests should fail clearly  
> when there is a mismatch.

My worry is that the amount of those tests that have a hard-coded port
grows and at some point somebody will clash with somebody else.
And it might not be 100% apparent because test_progs is now multi-threaded
and racy..

> >
> > And, unrelated, maybe also fix a bunch of places where the reverse  
> christmas
> > tree doesn't look reverse anymore?

> Ok. The checks should be part of tooling (e.g., checkpatch) though if  
> they are meant to be enforced consistently, no?

They are networking specific, so they are not part of a checkpath :-(
I won't say they are consistently enforced, but we try to keep then
whenever possible.

> >
> >> +
> >> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
> >> +
> >> +struct {
> >> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> >> +	__uint(max_entries, 1);
> >> +	__type(key, __u32);
> >> +	__type(value, __u64);
> >> +} tcp_conn_sockets SEC(".maps");
> >> +
> >> +struct {
> >> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> >> +	__uint(max_entries, 1);
> >> +	__type(key, __u32);
> >> +	__type(value, __u64);
> >> +} udp_conn_sockets SEC(".maps");
> >> +
> >> +SEC("cgroup/connect6")
> >> +int sock_connect(struct bpf_sock_addr *ctx)
> >> +{
> >> +	int key = 0;
> >> +	__u64 sock_cookie = 0;
> >> +	__u32 keyc = 0;
> >> +
> >> +	if (ctx->family != AF_INET6 || ctx->user_family != AF_INET6)
> >> +		return 1;
> >> +
> >> +	sock_cookie = bpf_get_socket_cookie(ctx);
> >> +	if (ctx->protocol == IPPROTO_TCP)
> >> +		bpf_map_update_elem(&tcp_conn_sockets, &key, &sock_cookie, 0);
> >> +	else if (ctx->protocol == IPPROTO_UDP)
> >> +		bpf_map_update_elem(&udp_conn_sockets, &keyc, &sock_cookie, 0);
> >> +	else
> >> +		return 1;
> >> +
> >> +	return 1;
> >> +}
> >> +
> >> +SEC("iter/tcp")
> >> +int iter_tcp6_client(struct bpf_iter__tcp *ctx)
> >> +{
> >> +	struct sock_common *sk_common = ctx->sk_common;
> >> +	struct seq_file *seq = ctx->meta->seq;
> >> +	__u64 sock_cookie = 0;
> >> +	__u64 *val;
> >> +	int key = 0;
> >> +
> >> +	if (!sk_common)
> >> +		return 0;
> >> +
> >> +	if (sk_common->skc_family != AF_INET6)
> >> +		return 0;
> >> +
> >> +	sock_cookie  = bpf_get_socket_cookie(sk_common);
> >> +	val = bpf_map_lookup_elem(&tcp_conn_sockets, &key);
> >> +	if (!val)
> >> +		return 0;
> >> +	/* Destroy connected client sockets. */
> >> +	if (sock_cookie == *val)
> >> +		bpf_sock_destroy(sk_common);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +SEC("iter/tcp")
> >> +int iter_tcp6_server(struct bpf_iter__tcp *ctx)
> >> +{
> >> +	struct sock_common *sk_common = ctx->sk_common;
> >> +	struct seq_file *seq = ctx->meta->seq;
> >> +	struct tcp6_sock *tcp_sk;
> >> +	const struct inet_connection_sock *icsk;
> >> +	const struct inet_sock *inet;
> >> +	__u16 srcp;
> >> +
> >> +	if (!sk_common)
> >> +		return 0;
> >> +
> >> +	if (sk_common->skc_family != AF_INET6)
> >> +		return 0;
> >> +
> >> +	tcp_sk = bpf_skc_to_tcp6_sock(sk_common);
> >> +	if (!tcp_sk)
> >> +		return 0;
> >> +
> >> +	icsk = &tcp_sk->tcp.inet_conn;
> >> +	inet = &icsk->icsk_inet;
> >> +	srcp = bpf_ntohs(inet->inet_sport);
> >> +
> >> +	/* Destroy server sockets. */
> >> +	if (srcp == SERVER_PORT)
> >> +		bpf_sock_destroy(sk_common);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +
> >> +SEC("iter/udp")
> >> +int iter_udp6_client(struct bpf_iter__udp *ctx)
> >> +{
> >> +	struct seq_file *seq = ctx->meta->seq;
> >> +	struct udp_sock *udp_sk = ctx->udp_sk;
> >> +	struct sock *sk = (struct sock *) udp_sk;
> >> +	__u64 sock_cookie = 0, *val;
> >> +	int key = 0;
> >> +
> >> +	if (!sk)
> >> +		return 0;
> >> +
> >> +	sock_cookie  = bpf_get_socket_cookie(sk);
> >> +	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
> >> +	if (!val)
> >> +		return 0;
> >> +	/* Destroy connected client sockets. */
> >> +	if (sock_cookie == *val)
> >> +		bpf_sock_destroy((struct sock_common *)sk);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +SEC("iter/udp")
> >> +int iter_udp6_server(struct bpf_iter__udp *ctx)
> >> +{
> >> +	struct seq_file *seq = ctx->meta->seq;
> >> +	struct udp_sock *udp_sk = ctx->udp_sk;
> >> +	struct sock *sk = (struct sock *) udp_sk;
> >> +	__u16 srcp;
> >> +	struct inet_sock *inet;
> >> +
> >> +	if (!sk)
> >> +		return 0;
> >> +
> >> +	inet = &udp_sk->inet;
> >> +	srcp = bpf_ntohs(inet->inet_sport);
> >> +	if (srcp == SERVER_PORT)
> >> +		bpf_sock_destroy((struct sock_common *)sk);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +char _license[] SEC("license") = "GPL";
> >> --
> >> 2.34.1

