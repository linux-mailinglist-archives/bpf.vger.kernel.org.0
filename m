Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAE6CA9B6
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 17:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjC0P5r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 11:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0P5q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 11:57:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83826AB
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 08:57:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so8871477plb.3
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679932664;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NEbFSn0ImYELBPx2hNfO33gRb9KbxTjlb6MkZLt5E8=;
        b=U6e2DFg15J238Y6YVjy8i6183resSHW5FPnuz1JE/4MkFlGByRFwpmrutMpC1HzCxQ
         BptcCZoX5vrzgotGSCXJjPfFo+oKBha6ypnhdAs5CdA20+fheXDNEY+LUZrWTtxu2/vW
         DngZHndNJtGjBodr0U5K3MvwBc3xDw16moSP20Z+7yO46frwtLZmdXzYX6ujQlfbp4QU
         QP2Spms9W9EHJSnrT8G90rGs7kIOFbjjOdimGgMkhL/gQ5UDwARlDKKlsSJlDCeuv1ek
         B9GLh6fmp5tSMfn/L7gRV4Al9YyLMfJx5CVEdB+pPkG/Qxidw21iQdTxkkDpoLko1Hz4
         qtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932664;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NEbFSn0ImYELBPx2hNfO33gRb9KbxTjlb6MkZLt5E8=;
        b=rzkrf/99MXQpON1ZPyNE1OhFxf3XKNnDKuULIsy4czFfwf0a7fbRImZCTr3CkkjC4Z
         JS0Xj6lsFDInI96HeBzwIgj7UIHii5c/Pem7iuW66Wq4BiRiPw5+GeYRRikGRlFQFmYd
         1NuEuZA3mIeHUa5yVuLwiOD2ToZX4ros45/42utQYbQZYfRwscFPXJxPCBdLM7k1HXHC
         FDh7P+c7dORZz06hVR3n5sViywYbj/Ec4teCzl5IsId2tSNsIehopYOJ2cnCX63HlJaY
         JTO697eQclF9BDJPp9E+gh622WuIxNK/4wvUCOeSCc2rY3wzMxwNN4OO71oVlHRbdvOR
         SKJg==
X-Gm-Message-State: AAQBX9e1HfmZugMVUsLncLRg1P6zW1IoLkB5XgJl+7OXYdqfO1x3jRgO
        Z9sTaaOF1e603xETh101L68PCg==
X-Google-Smtp-Source: AKy350bXP2+2P8VgNx0rnoRopEQ5VeMmH8Y4ytnHqkTVJmGDef6WWQLs0NjOSqkK23ZTsfgBs1f+fg==
X-Received: by 2002:a17:902:e881:b0:19a:96d2:2407 with SMTP id w1-20020a170902e88100b0019a96d22407mr17970802plg.8.1679932664257;
        Mon, 27 Mar 2023 08:57:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:5869:bd44:1921:332? ([2601:647:4900:1fbb:5869:bd44:1921:332])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm19411229plk.148.2023.03.27.08.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:57:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 4/4] selftests/bpf: Add tests for
 bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZB4btVWyDjjdIqhV@google.com>
Date:   Mon, 27 Mar 2023 08:57:42 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD6B5D46-CDA5-4510-8647-28445AD92DE1@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-5-aditi.ghag@isovalent.com>
 <ZB4btVWyDjjdIqhV@google.com>
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



> On Mar 24, 2023, at 2:52 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/23, Aditi Ghag wrote:
>> The test cases for destroying sockets mirror the intended usages of =
the
>> bpf_sock_destroy kfunc using iterators.
>=20
>> The destroy helpers set `ECONNABORTED` error code that we can =
validate in
>> the test code with client sockets. But UDP sockets have an overriding =
error
>> code from the disconnect called during abort, so the error code the
>> validation is only done for TCP sockets.
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  .../selftests/bpf/prog_tests/sock_destroy.c   | 195 =
++++++++++++++++++
>>  .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++++++
>>  2 files changed, 346 insertions(+)
>>  create mode 100644 =
tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>>  create mode 100644 =
tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c =
b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> new file mode 100644
>> index 000000000000..cbce966af568
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> @@ -0,0 +1,195 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +
>> +#include "sock_destroy_prog.skel.h"
>> +#include "network_helpers.h"
>> +
>> +#define SERVER_PORT 6062
>> +
>> +static void start_iter_sockets(struct bpf_program *prog)
>> +{
>> +	struct bpf_link *link;
>> +	char buf[50] =3D {};
>> +	int iter_fd, len;
>> +
>> +	link =3D bpf_program__attach_iter(prog, NULL);
>> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
>> +		return;
>> +
>> +	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
>> +	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
>> +		goto free_link;
>> +
>> +	while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
>> +		;
>> +	ASSERT_GE(len, 0, "read");
>> +
>> +	close(iter_fd);
>> +
>> +free_link:
>> +	bpf_link__destroy(link);
>> +}
>> +
>> +static void test_tcp_client(struct sock_destroy_prog *skel)
>> +{
>> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> +
>> +	serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
>> +	if (!ASSERT_GE(serv, 0, "start_server"))
>> +		goto cleanup_serv;
>> +
>> +	clien =3D connect_to_fd(serv, 0);
>> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
>> +		goto cleanup_serv;
>> +
>> +	serv =3D accept(serv, NULL, NULL);
>> +	if (!ASSERT_GE(serv, 0, "serv accept"))
>> +		goto cleanup;
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (!ASSERT_GE(n, 0, "client send"))
>> +		goto cleanup;
>> +
>> +	/* Run iterator program that destroys connected client sockets. =
*/
>> +	start_iter_sockets(skel->progs.iter_tcp6_client);
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
>> +		goto cleanup;
>> +	ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed =
socket");
>> +
>> +
>> +cleanup:
>> +	close(clien);
>> +cleanup_serv:
>> +	close(serv);
>> +}
>> +
>> +static void test_tcp_server(struct sock_destroy_prog *skel)
>> +{
>> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> +
>> +	serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, =
0);
>> +	if (!ASSERT_GE(serv, 0, "start_server"))
>> +		goto cleanup_serv;
>> +
>> +	clien =3D connect_to_fd(serv, 0);
>> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
>> +		goto cleanup_serv;
>> +
>> +	serv =3D accept(serv, NULL, NULL);
>> +	if (!ASSERT_GE(serv, 0, "serv accept"))
>> +		goto cleanup;
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (!ASSERT_GE(n, 0, "client send"))
>> +		goto cleanup;
>> +
>> +	/* Run iterator program that destroys server sockets. */
>> +	start_iter_sockets(skel->progs.iter_tcp6_server);
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
>> +		goto cleanup;
>> +	ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
>> +
>> +
>> +cleanup:
>> +	close(clien);
>> +cleanup_serv:
>> +	close(serv);
>> +}
>> +
>> +
>> +static void test_udp_client(struct sock_destroy_prog *skel)
>> +{
>> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> +
>> +	serv =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
>> +	if (!ASSERT_GE(serv, 0, "start_server"))
>> +		goto cleanup_serv;
>> +
>> +	clien =3D connect_to_fd(serv, 0);
>> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
>> +		goto cleanup_serv;
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (!ASSERT_GE(n, 0, "client send"))
>> +		goto cleanup;
>> +
>> +	/* Run iterator program that destroys sockets. */
>> +	start_iter_sockets(skel->progs.iter_udp6_client);
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
>> +		goto cleanup;
>> +	/* UDP sockets have an overriding error code after they are =
disconnected,
>> +	 * so we don't check for ECONNABORTED error code.
>> +	 */
>> +
>> +cleanup:
>> +	close(clien);
>> +cleanup_serv:
>> +	close(serv);
>> +}
>> +
>> +static void test_udp_server(struct sock_destroy_prog *skel)
>> +{
>> +	int *listen_fds =3D NULL, n, i;
>> +	unsigned int num_listens =3D 5;
>> +	char buf[1];
>> +
>> +	/* Start reuseport servers. */
>> +	listen_fds =3D start_reuseport_server(AF_INET6, SOCK_DGRAM,
>> +					    "::1", SERVER_PORT, 0,
>> +					    num_listens);
>> +	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
>> +		goto cleanup;
>> +
>> +	/* Run iterator program that destroys server sockets. */
>> +	start_iter_sockets(skel->progs.iter_udp6_server);
>> +
>> +	for (i =3D 0; i < num_listens; ++i) {
>> +		n =3D read(listen_fds[i], buf, sizeof(buf));
>> +		if (!ASSERT_EQ(n, -1, "read") ||
>> +		    !ASSERT_EQ(errno, ECONNABORTED, "error code on =
destroyed socket"))
>> +			break;
>> +	}
>> +	ASSERT_EQ(i, num_listens, "server socket");
>> +
>> +cleanup:
>> +	free_fds(listen_fds, num_listens);
>> +}
>> +
>> +void test_sock_destroy(void)
>> +{
>> +	int cgroup_fd =3D 0;
>> +	struct sock_destroy_prog *skel;
>> +
>> +	skel =3D sock_destroy_prog__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +		return;
>> +
>> +	cgroup_fd =3D test__join_cgroup("/sock_destroy");
>> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>> +		goto close_cgroup_fd;
>> +
>> +	skel->links.sock_connect =3D bpf_program__attach_cgroup(
>> +		skel->progs.sock_connect, cgroup_fd);
>> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
>> +		goto close_cgroup_fd;
>> +
>> +	if (test__start_subtest("tcp_client"))
>> +		test_tcp_client(skel);
>> +	if (test__start_subtest("tcp_server"))
>> +		test_tcp_server(skel);
>> +	if (test__start_subtest("udp_client"))
>> +		test_udp_client(skel);
>> +	if (test__start_subtest("udp_server"))
>> +		test_udp_server(skel);
>> +
>> +
>> +close_cgroup_fd:
>> +	close(cgroup_fd);
>> +	sock_destroy_prog__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c =
b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> new file mode 100644
>> index 000000000000..8e09d82c50f3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> @@ -0,0 +1,151 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +
>> +#include "bpf_tracing_net.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_endian.h>
>> +
>> +#define AF_INET6 10
>=20
> [..]
>=20
>> +/* Keep it in sync with prog_test/sock_destroy. */
>> +#define SERVER_PORT 6062
>=20
> The test looks good, one optional unrelated nit maybe:
>=20
> I've been guilty of these hard-coded ports in the past, but maybe
> we should stop hard-coding them? Getting the address of the listener =
(bound to
> port 0) and passing it to the bpf program via global variable should =
be super
> easy now (with the skeletons and network_helpers).


I briefly considered adding the ports in a map, and retrieving them in =
the test. But it didn't seem worthwhile as the tests should fail clearly =
when there is a mismatch.=20

>=20
> And, unrelated, maybe also fix a bunch of places where the reverse =
christmas
> tree doesn't look reverse anymore?

Ok. The checks should be part of tooling (e.g., checkpatch) though if =
they are meant to be enforced consistently, no?

>=20
>> +
>> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, 1);
>> +	__type(key, __u32);
>> +	__type(value, __u64);
>> +} tcp_conn_sockets SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, 1);
>> +	__type(key, __u32);
>> +	__type(value, __u64);
>> +} udp_conn_sockets SEC(".maps");
>> +
>> +SEC("cgroup/connect6")
>> +int sock_connect(struct bpf_sock_addr *ctx)
>> +{
>> +	int key =3D 0;
>> +	__u64 sock_cookie =3D 0;
>> +	__u32 keyc =3D 0;
>> +
>> +	if (ctx->family !=3D AF_INET6 || ctx->user_family !=3D AF_INET6)
>> +		return 1;
>> +
>> +	sock_cookie =3D bpf_get_socket_cookie(ctx);
>> +	if (ctx->protocol =3D=3D IPPROTO_TCP)
>> +		bpf_map_update_elem(&tcp_conn_sockets, &key, =
&sock_cookie, 0);
>> +	else if (ctx->protocol =3D=3D IPPROTO_UDP)
>> +		bpf_map_update_elem(&udp_conn_sockets, &keyc, =
&sock_cookie, 0);
>> +	else
>> +		return 1;
>> +
>> +	return 1;
>> +}
>> +
>> +SEC("iter/tcp")
>> +int iter_tcp6_client(struct bpf_iter__tcp *ctx)
>> +{
>> +	struct sock_common *sk_common =3D ctx->sk_common;
>> +	struct seq_file *seq =3D ctx->meta->seq;
>> +	__u64 sock_cookie =3D 0;
>> +	__u64 *val;
>> +	int key =3D 0;
>> +
>> +	if (!sk_common)
>> +		return 0;
>> +
>> +	if (sk_common->skc_family !=3D AF_INET6)
>> +		return 0;
>> +
>> +	sock_cookie  =3D bpf_get_socket_cookie(sk_common);
>> +	val =3D bpf_map_lookup_elem(&tcp_conn_sockets, &key);
>> +	if (!val)
>> +		return 0;
>> +	/* Destroy connected client sockets. */
>> +	if (sock_cookie =3D=3D *val)
>> +		bpf_sock_destroy(sk_common);
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("iter/tcp")
>> +int iter_tcp6_server(struct bpf_iter__tcp *ctx)
>> +{
>> +	struct sock_common *sk_common =3D ctx->sk_common;
>> +	struct seq_file *seq =3D ctx->meta->seq;
>> +	struct tcp6_sock *tcp_sk;
>> +	const struct inet_connection_sock *icsk;
>> +	const struct inet_sock *inet;
>> +	__u16 srcp;
>> +
>> +	if (!sk_common)
>> +		return 0;
>> +
>> +	if (sk_common->skc_family !=3D AF_INET6)
>> +		return 0;
>> +
>> +	tcp_sk =3D bpf_skc_to_tcp6_sock(sk_common);
>> +	if (!tcp_sk)
>> +		return 0;
>> +
>> +	icsk =3D &tcp_sk->tcp.inet_conn;
>> +	inet =3D &icsk->icsk_inet;
>> +	srcp =3D bpf_ntohs(inet->inet_sport);
>> +
>> +	/* Destroy server sockets. */
>> +	if (srcp =3D=3D SERVER_PORT)
>> +		bpf_sock_destroy(sk_common);
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +SEC("iter/udp")
>> +int iter_udp6_client(struct bpf_iter__udp *ctx)
>> +{
>> +	struct seq_file *seq =3D ctx->meta->seq;
>> +	struct udp_sock *udp_sk =3D ctx->udp_sk;
>> +	struct sock *sk =3D (struct sock *) udp_sk;
>> +	__u64 sock_cookie =3D 0, *val;
>> +	int key =3D 0;
>> +
>> +	if (!sk)
>> +		return 0;
>> +
>> +	sock_cookie  =3D bpf_get_socket_cookie(sk);
>> +	val =3D bpf_map_lookup_elem(&udp_conn_sockets, &key);
>> +	if (!val)
>> +		return 0;
>> +	/* Destroy connected client sockets. */
>> +	if (sock_cookie =3D=3D *val)
>> +		bpf_sock_destroy((struct sock_common *)sk);
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("iter/udp")
>> +int iter_udp6_server(struct bpf_iter__udp *ctx)
>> +{
>> +	struct seq_file *seq =3D ctx->meta->seq;
>> +	struct udp_sock *udp_sk =3D ctx->udp_sk;
>> +	struct sock *sk =3D (struct sock *) udp_sk;
>> +	__u16 srcp;
>> +	struct inet_sock *inet;
>> +
>> +	if (!sk)
>> +		return 0;
>> +
>> +	inet =3D &udp_sk->inet;
>> +	srcp =3D bpf_ntohs(inet->inet_sport);
>> +	if (srcp =3D=3D SERVER_PORT)
>> +		bpf_sock_destroy((struct sock_common *)sk);
>> +
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> --
>> 2.34.1

