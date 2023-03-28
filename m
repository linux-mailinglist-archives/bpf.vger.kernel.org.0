Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535076CC9A5
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjC1Ru6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1Ru5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:50:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0835DCDD2
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:50:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso13422517pjb.3
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680025855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnvOaVhyZTV5ltrEuNCGq8uu/wT7o2Xw2j89HBk1mYY=;
        b=XL5X9USYMzEMAlbgTS8iX/UyTVsIFr0CuPsxE4gJIV0n8OQG/76Ok3ceqW6mlYTppR
         q6b6YqOGrokb5Ca6W+1AyV17bBsEQD4SJLOD25oT+MrI8TKOQh+NmgsuH50du+hMWBFL
         3GI1POrHT2EmJqbjan4Nm6KU7sZiSQd++lVDtWs6dq+3XWCYYDIhP8JjNhjAA3ftuqh8
         t8l+dvgOBH8UxXspafzF73LrZOA4ZTUyjIJ42L0ocuvd9TfcS0stekX4+akBMYZioXZU
         6BzOAR4YcwRfBoWGj1PcF4aYHuL/8gKG7lGskmJURDQzuC9QeOmZciHcQThXBg1Ffg6Q
         FiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnvOaVhyZTV5ltrEuNCGq8uu/wT7o2Xw2j89HBk1mYY=;
        b=DPfxvwOiuHwaV61bQXektvrbM6+5LqIewa5l3ZSCy2DC2OghJUQtGd2yO9mR4MYiPr
         O0fDH/d3XKjZEnB/B7OqJ4GE3xd1LEeJqnM00vFPKGhKp06de3ZaERHx+kAp+px4JN0C
         WNLFgrjTtOA/7kUb20fLJRhJC+XxApNI66Fvq1hMZOrl9EPuEdo1rEXPYT+w9td8FvEb
         btDdL1yLhJR5dnH+rd54RVeC/7amKf7BV9K3GOxzTYH66TUtK2NabSDVFHr0CM0Pmr9K
         JEn/xf8AdW0ea8AnP9JeykHwNNt1rzT6U61k0JCjfziTdh5TN5pIbIeSfwzm825pOIaK
         mDbw==
X-Gm-Message-State: AO0yUKXHiLKSd0m+SECg1Za5NXGxRFE65tqTm1yQp5F/+LX8HGaH/5dY
        QK4XHDskPBrkXQuG/buiGxdApg==
X-Google-Smtp-Source: AK7set/pGXH04M01uRghPJAnH9yvfmRwd1NZCvJB2uSDO+NHxem7UnrLIxHh2MVbkjPqpBOi7rPobQ==
X-Received: by 2002:a05:6a20:1bd8:b0:de:5c1a:d0e9 with SMTP id cv24-20020a056a201bd800b000de5c1ad0e9mr11971361pzb.15.1680025855304;
        Tue, 28 Mar 2023 10:50:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:74d3:2bc6:6239:344c? ([2601:647:4900:1fbb:74d3:2bc6:6239:344c])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7800e000000b0062d8e79ea22sm3681409pfi.40.2023.03.28.10.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 10:50:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 4/4] selftests/bpf: Add tests for
 bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZCHKY4Bmb6mgc8ea@google.com>
Date:   Tue, 28 Mar 2023 10:50:53 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3202D0D-A607-4B66-86B1-2CA1ED67E0BB@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-5-aditi.ghag@isovalent.com>
 <ZB4btVWyDjjdIqhV@google.com>
 <DD6B5D46-CDA5-4510-8647-28445AD92DE1@isovalent.com>
 <ZCHKY4Bmb6mgc8ea@google.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 27, 2023, at 9:54 AM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/27, Aditi Ghag wrote:
>=20
>=20
>> > On Mar 24, 2023, at 2:52 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>> >
>> > On 03/23, Aditi Ghag wrote:
>> >> The test cases for destroying sockets mirror the intended usages =
of the
>> >> bpf_sock_destroy kfunc using iterators.
>> >
>> >> The destroy helpers set `ECONNABORTED` error code that we can =
validate in
>> >> the test code with client sockets. But UDP sockets have an =
overriding error
>> >> code from the disconnect called during abort, so the error code =
the
>> >> validation is only done for TCP sockets.
>> >
>> >> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> >> ---
>> >>  .../selftests/bpf/prog_tests/sock_destroy.c   | 195 =
++++++++++++++++++
>> >>  .../selftests/bpf/progs/sock_destroy_prog.c   | 151 =
++++++++++++++
>> >>  2 files changed, 346 insertions(+)
>> >>  create mode 100644 =
tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> >>  create mode 100644 =
tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> >
>> >> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c =
b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> >> new file mode 100644
>> >> index 000000000000..cbce966af568
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> >> @@ -0,0 +1,195 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +#include <test_progs.h>
>> >> +
>> >> +#include "sock_destroy_prog.skel.h"
>> >> +#include "network_helpers.h"
>> >> +
>> >> +#define SERVER_PORT 6062
>> >> +
>> >> +static void start_iter_sockets(struct bpf_program *prog)
>> >> +{
>> >> +	struct bpf_link *link;
>> >> +	char buf[50] =3D {};
>> >> +	int iter_fd, len;
>> >> +
>> >> +	link =3D bpf_program__attach_iter(prog, NULL);
>> >> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
>> >> +		return;
>> >> +
>> >> +	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
>> >> +	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
>> >> +		goto free_link;
>> >> +
>> >> +	while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
>> >> +		;
>> >> +	ASSERT_GE(len, 0, "read");
>> >> +
>> >> +	close(iter_fd);
>> >> +
>> >> +free_link:
>> >> +	bpf_link__destroy(link);
>> >> +}
>> >> +
>> >> +static void test_tcp_client(struct sock_destroy_prog *skel)
>> >> +{
>> >> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> >> +
>> >> +	serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
>> >> +	if (!ASSERT_GE(serv, 0, "start_server"))
>> >> +		goto cleanup_serv;
>> >> +
>> >> +	clien =3D connect_to_fd(serv, 0);
>> >> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
>> >> +		goto cleanup_serv;
>> >> +
>> >> +	serv =3D accept(serv, NULL, NULL);
>> >> +	if (!ASSERT_GE(serv, 0, "serv accept"))
>> >> +		goto cleanup;
>> >> +
>> >> +	n =3D send(clien, "t", 1, 0);
>> >> +	if (!ASSERT_GE(n, 0, "client send"))
>> >> +		goto cleanup;
>> >> +
>> >> +	/* Run iterator program that destroys connected client sockets. =
*/
>> >> +	start_iter_sockets(skel->progs.iter_tcp6_client);
>> >> +
>> >> +	n =3D send(clien, "t", 1, 0);
>> >> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
>> >> +		goto cleanup;
>> >> +	ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed =
socket");
>> >> +
>> >> +
>> >> +cleanup:
>> >> +	close(clien);
>> >> +cleanup_serv:
>> >> +	close(serv);
>> >> +}
>> >> +
>> >> +static void test_tcp_server(struct sock_destroy_prog *skel)
>> >> +{
>> >> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> >> +
>> >> +	serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, =
0);
>> >> +	if (!ASSERT_GE(serv, 0, "start_server"))
>> >> +		goto cleanup_serv;
>> >> +
>> >> +	clien =3D connect_to_fd(serv, 0);
>> >> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
>> >> +		goto cleanup_serv;
>> >> +
>> >> +	serv =3D accept(serv, NULL, NULL);
>> >> +	if (!ASSERT_GE(serv, 0, "serv accept"))
>> >> +		goto cleanup;
>> >> +
>> >> +	n =3D send(clien, "t", 1, 0);
>> >> +	if (!ASSERT_GE(n, 0, "client send"))
>> >> +		goto cleanup;
>> >> +
>> >> +	/* Run iterator program that destroys server sockets. */
>> >> +	start_iter_sockets(skel->progs.iter_tcp6_server);
>> >> +
>> >> +	n =3D send(clien, "t", 1, 0);
>> >> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
>> >> +		goto cleanup;
>> >> +	ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
>> >> +
>> >> +
>> >> +cleanup:
>> >> +	close(clien);
>> >> +cleanup_serv:
>> >> +	close(serv);
>> >> +}
>> >> +
>> >> +
>> >> +static void test_udp_client(struct sock_destroy_prog *skel)
>> >> +{
>> >> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> >> +
>> >> +	serv =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
>> >> +	if (!ASSERT_GE(serv, 0, "start_server"))
>> >> +		goto cleanup_serv;
>> >> +
>> >> +	clien =3D connect_to_fd(serv, 0);
>> >> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
>> >> +		goto cleanup_serv;
>> >> +
>> >> +	n =3D send(clien, "t", 1, 0);
>> >> +	if (!ASSERT_GE(n, 0, "client send"))
>> >> +		goto cleanup;
>> >> +
>> >> +	/* Run iterator program that destroys sockets. */
>> >> +	start_iter_sockets(skel->progs.iter_udp6_client);
>> >> +
>> >> +	n =3D send(clien, "t", 1, 0);
>> >> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
>> >> +		goto cleanup;
>> >> +	/* UDP sockets have an overriding error code after they are =
disconnected,
>> >> +	 * so we don't check for ECONNABORTED error code.
>> >> +	 */
>> >> +
>> >> +cleanup:
>> >> +	close(clien);
>> >> +cleanup_serv:
>> >> +	close(serv);
>> >> +}
>> >> +
>> >> +static void test_udp_server(struct sock_destroy_prog *skel)
>> >> +{
>> >> +	int *listen_fds =3D NULL, n, i;
>> >> +	unsigned int num_listens =3D 5;
>> >> +	char buf[1];
>> >> +
>> >> +	/* Start reuseport servers. */
>> >> +	listen_fds =3D start_reuseport_server(AF_INET6, SOCK_DGRAM,
>> >> +					    "::1", SERVER_PORT, 0,
>> >> +					    num_listens);
>> >> +	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
>> >> +		goto cleanup;
>> >> +
>> >> +	/* Run iterator program that destroys server sockets. */
>> >> +	start_iter_sockets(skel->progs.iter_udp6_server);
>> >> +
>> >> +	for (i =3D 0; i < num_listens; ++i) {
>> >> +		n =3D read(listen_fds[i], buf, sizeof(buf));
>> >> +		if (!ASSERT_EQ(n, -1, "read") ||
>> >> +		    !ASSERT_EQ(errno, ECONNABORTED, "error code on =
destroyed socket"))
>> >> +			break;
>> >> +	}
>> >> +	ASSERT_EQ(i, num_listens, "server socket");
>> >> +
>> >> +cleanup:
>> >> +	free_fds(listen_fds, num_listens);
>> >> +}
>> >> +
>> >> +void test_sock_destroy(void)
>> >> +{
>> >> +	int cgroup_fd =3D 0;
>> >> +	struct sock_destroy_prog *skel;
>> >> +
>> >> +	skel =3D sock_destroy_prog__open_and_load();
>> >> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
>> >> +		return;
>> >> +
>> >> +	cgroup_fd =3D test__join_cgroup("/sock_destroy");
>> >> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>> >> +		goto close_cgroup_fd;
>> >> +
>> >> +	skel->links.sock_connect =3D bpf_program__attach_cgroup(
>> >> +		skel->progs.sock_connect, cgroup_fd);
>> >> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
>> >> +		goto close_cgroup_fd;
>> >> +
>> >> +	if (test__start_subtest("tcp_client"))
>> >> +		test_tcp_client(skel);
>> >> +	if (test__start_subtest("tcp_server"))
>> >> +		test_tcp_server(skel);
>> >> +	if (test__start_subtest("udp_client"))
>> >> +		test_udp_client(skel);
>> >> +	if (test__start_subtest("udp_server"))
>> >> +		test_udp_server(skel);
>> >> +
>> >> +
>> >> +close_cgroup_fd:
>> >> +	close(cgroup_fd);
>> >> +	sock_destroy_prog__destroy(skel);
>> >> +}
>> >> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c =
b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> >> new file mode 100644
>> >> index 000000000000..8e09d82c50f3
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> >> @@ -0,0 +1,151 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +
>> >> +#include "vmlinux.h"
>> >> +
>> >> +#include "bpf_tracing_net.h"
>> >> +#include <bpf/bpf_helpers.h>
>> >> +#include <bpf/bpf_endian.h>
>> >> +
>> >> +#define AF_INET6 10
>> >
>> > [..]
>> >
>> >> +/* Keep it in sync with prog_test/sock_destroy. */
>> >> +#define SERVER_PORT 6062
>> >
>> > The test looks good, one optional unrelated nit maybe:
>> >
>> > I've been guilty of these hard-coded ports in the past, but maybe
>> > we should stop hard-coding them? Getting the address of the =
listener (bound to
>> > port 0) and passing it to the bpf program via global variable =
should be super
>> > easy now (with the skeletons and network_helpers).
>=20
>=20
>> I briefly considered adding the ports in a map, and retrieving them =
in the test. But it didn't seem worthwhile as the tests should fail =
clearly when there is a mismatch.
>=20
> My worry is that the amount of those tests that have a hard-coded port
> grows and at some point somebody will clash with somebody else.
> And it might not be 100% apparent because test_progs is now =
multi-threaded
> and racy..
>=20

So you would like the ports to be unique across all the tests.=20

>Getting the address of the listener (bound to
> port 0) and passing it to the bpf program via global variable should =
be super
> easy now (with the skeletons and network_helpers).

Just so that we are on the same page, could you point to which network =
helpers are you referring to here for passing global variables?


>> >
>> > And, unrelated, maybe also fix a bunch of places where the reverse =
christmas
>> > tree doesn't look reverse anymore?
>=20
>> Ok. The checks should be part of tooling (e.g., checkpatch) though if =
they are meant to be enforced consistently, no?
>=20
> They are networking specific, so they are not part of a checkpath :-(
> I won't say they are consistently enforced, but we try to keep then
> whenever possible.
>=20
>> >
>> >> +
>> >> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
>> >> +
>> >> +struct {
>> >> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> >> +	__uint(max_entries, 1);
>> >> +	__type(key, __u32);
>> >> +	__type(value, __u64);
>> >> +} tcp_conn_sockets SEC(".maps");
>> >> +
>> >> +struct {
>> >> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> >> +	__uint(max_entries, 1);
>> >> +	__type(key, __u32);
>> >> +	__type(value, __u64);
>> >> +} udp_conn_sockets SEC(".maps");
>> >> +
>> >> +SEC("cgroup/connect6")
>> >> +int sock_connect(struct bpf_sock_addr *ctx)
>> >> +{
>> >> +	int key =3D 0;
>> >> +	__u64 sock_cookie =3D 0;
>> >> +	__u32 keyc =3D 0;
>> >> +
>> >> +	if (ctx->family !=3D AF_INET6 || ctx->user_family !=3D AF_INET6)
>> >> +		return 1;
>> >> +
>> >> +	sock_cookie =3D bpf_get_socket_cookie(ctx);
>> >> +	if (ctx->protocol =3D=3D IPPROTO_TCP)
>> >> +		bpf_map_update_elem(&tcp_conn_sockets, &key, =
&sock_cookie, 0);
>> >> +	else if (ctx->protocol =3D=3D IPPROTO_UDP)
>> >> +		bpf_map_update_elem(&udp_conn_sockets, &keyc, =
&sock_cookie, 0);
>> >> +	else
>> >> +		return 1;
>> >> +
>> >> +	return 1;
>> >> +}
>> >> +
>> >> +SEC("iter/tcp")
>> >> +int iter_tcp6_client(struct bpf_iter__tcp *ctx)
>> >> +{
>> >> +	struct sock_common *sk_common =3D ctx->sk_common;
>> >> +	struct seq_file *seq =3D ctx->meta->seq;
>> >> +	__u64 sock_cookie =3D 0;
>> >> +	__u64 *val;
>> >> +	int key =3D 0;
>> >> +
>> >> +	if (!sk_common)
>> >> +		return 0;
>> >> +
>> >> +	if (sk_common->skc_family !=3D AF_INET6)
>> >> +		return 0;
>> >> +
>> >> +	sock_cookie  =3D bpf_get_socket_cookie(sk_common);
>> >> +	val =3D bpf_map_lookup_elem(&tcp_conn_sockets, &key);
>> >> +	if (!val)
>> >> +		return 0;
>> >> +	/* Destroy connected client sockets. */
>> >> +	if (sock_cookie =3D=3D *val)
>> >> +		bpf_sock_destroy(sk_common);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +SEC("iter/tcp")
>> >> +int iter_tcp6_server(struct bpf_iter__tcp *ctx)
>> >> +{
>> >> +	struct sock_common *sk_common =3D ctx->sk_common;
>> >> +	struct seq_file *seq =3D ctx->meta->seq;
>> >> +	struct tcp6_sock *tcp_sk;
>> >> +	const struct inet_connection_sock *icsk;
>> >> +	const struct inet_sock *inet;
>> >> +	__u16 srcp;
>> >> +
>> >> +	if (!sk_common)
>> >> +		return 0;
>> >> +
>> >> +	if (sk_common->skc_family !=3D AF_INET6)
>> >> +		return 0;
>> >> +
>> >> +	tcp_sk =3D bpf_skc_to_tcp6_sock(sk_common);
>> >> +	if (!tcp_sk)
>> >> +		return 0;
>> >> +
>> >> +	icsk =3D &tcp_sk->tcp.inet_conn;
>> >> +	inet =3D &icsk->icsk_inet;
>> >> +	srcp =3D bpf_ntohs(inet->inet_sport);
>> >> +
>> >> +	/* Destroy server sockets. */
>> >> +	if (srcp =3D=3D SERVER_PORT)
>> >> +		bpf_sock_destroy(sk_common);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +
>> >> +SEC("iter/udp")
>> >> +int iter_udp6_client(struct bpf_iter__udp *ctx)
>> >> +{
>> >> +	struct seq_file *seq =3D ctx->meta->seq;
>> >> +	struct udp_sock *udp_sk =3D ctx->udp_sk;
>> >> +	struct sock *sk =3D (struct sock *) udp_sk;
>> >> +	__u64 sock_cookie =3D 0, *val;
>> >> +	int key =3D 0;
>> >> +
>> >> +	if (!sk)
>> >> +		return 0;
>> >> +
>> >> +	sock_cookie  =3D bpf_get_socket_cookie(sk);
>> >> +	val =3D bpf_map_lookup_elem(&udp_conn_sockets, &key);
>> >> +	if (!val)
>> >> +		return 0;
>> >> +	/* Destroy connected client sockets. */
>> >> +	if (sock_cookie =3D=3D *val)
>> >> +		bpf_sock_destroy((struct sock_common *)sk);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +SEC("iter/udp")
>> >> +int iter_udp6_server(struct bpf_iter__udp *ctx)
>> >> +{
>> >> +	struct seq_file *seq =3D ctx->meta->seq;
>> >> +	struct udp_sock *udp_sk =3D ctx->udp_sk;
>> >> +	struct sock *sk =3D (struct sock *) udp_sk;
>> >> +	__u16 srcp;
>> >> +	struct inet_sock *inet;
>> >> +
>> >> +	if (!sk)
>> >> +		return 0;
>> >> +
>> >> +	inet =3D &udp_sk->inet;
>> >> +	srcp =3D bpf_ntohs(inet->inet_sport);
>> >> +	if (srcp =3D=3D SERVER_PORT)
>> >> +		bpf_sock_destroy((struct sock_common *)sk);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +char _license[] SEC("license") =3D "GPL";
>> >> --
>> >> 2.34.1

