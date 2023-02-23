Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EB6A12C7
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjBWWY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 17:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWWY5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 17:24:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEBF12F31
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:24:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso5171554pjv.0
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBNzc8p88I/R+gWzcNq7o59EvqyQmvL9vUiSdsz+Fp4=;
        b=Mfaf0xpnZ1LvdOQxvvK8885fgU/AQDq2lMcf+loWMrJ9yLpJuHYRWt0DJS5LF6wc2E
         Yf4pt4h9Rrrmaayvb1SOcK0eFlifEcFazohozw/reVwtXpBXuGDZEL4N5Nq1aR3893CB
         HNX4oU0ErKBS3lwS0YPz7mPfbnkkG6wSxs7JTjZSIW91Tl8MzLI467ur1RZ2tcBaO+Tq
         q/6ux7Zzzt7V9CpTz/HWc2V5okkPoPY46YRncmSkRXDDBwTzjN+17tJK5gPF2f3K7ufd
         maNIep7lSTYsjyqj8lj3mDRxgCIDGLCqpkUvsDoBDumQleTfZkTiO4PT1FAtzWbhHkTi
         /rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBNzc8p88I/R+gWzcNq7o59EvqyQmvL9vUiSdsz+Fp4=;
        b=VzYG+AEA3rx1lUNLu6Sw8RYa3dDMUxNAVRP6roDTm6+Gfvqmc6d1vqsCQOGC6xNn8e
         sVVY2fSRr8725qHZ0xvazIx86N1lnh+d7QFrUi1N2R6Ps+tJgNoMC+Hyk/T3oHBXCVxH
         eW3N1gC8Kr90SEtfcywGgF5cidgtlh2OAwTnOxIiG5ATch0vpK6sAbGvXQa9JggB4t21
         MqNMb3Qxb1QuEOitFzzHch9BOBlrtkj6aAkJnmIAKVcpT4hI0vnEQPSXOmDgrvTnVPlr
         gNqXfP4eAZFlVGS1UdPv2bWZOgEnMdfCcyO8RqTrH/99PO41LW87bGQWR5LyGyLYB8FO
         HDSA==
X-Gm-Message-State: AO0yUKW/Sxvf0Y7sTHsDtLJQNpokUYrzhOBO0BAENwd5cZraasZNX+x/
        FavXGKQYWl3R0bKkbGSHtLqXPwQ1uJfJmBGI
X-Google-Smtp-Source: AK7set/OboPTRm4v10Bq3y2S+SWuvfy839EEhxJc4VztiFR6ZpcH5fduBJ3fDqX/9/Fsol009son2A==
X-Received: by 2002:a17:902:e888:b0:19a:95ab:6b2b with SMTP id w8-20020a170902e88800b0019a95ab6b2bmr16738150plg.69.1677191094964;
        Thu, 23 Feb 2023 14:24:54 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:28ee:5de8:8f1:37ad? ([2601:647:4900:b6:28ee:5de8:8f1:37ad])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090ab28700b00233acae2ce6sm191661pjr.23.2023.02.23.14.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 14:24:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 2/2] selftests/bpf: Add tests for bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <Y6CsqsH1JQmVWgNx@google.com>
Date:   Thu, 23 Feb 2023 14:24:53 -0800
Cc:     bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF001436-C8CA-4695-A0BF-4707C817B8B5@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <16c81434c64f1c2a5d10e06c7199cc4715e467a0.1671242108.git.aditi.ghag@isovalent.com>
 <Y6CsqsH1JQmVWgNx@google.com>
To:     sdf@google.com
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Dec 19, 2022, at 10:25 AM, sdf@google.com wrote:
>=20
> On 12/17, Aditi Ghag wrote:
>> The test cases for TCP and UDP mirror the
>> intended usages of the helper.
>=20
>> As the helper destroys sockets asynchronously,
>> the tests have sleep invocation before validating
>> if the sockets were destroyed by sending data.
>=20
>> Also, while all the protocol specific helpers
>> set `ECONNABORTED` error code on the destroyed sockets,
>> only the TCP test case has the validation check. UDP
>> sockets have an overriding error code from the disconnect
>> call during abort.
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  .../selftests/bpf/prog_tests/sock_destroy.c   | 131 =
++++++++++++++++++
>>  .../selftests/bpf/progs/sock_destroy_prog.c   |  96 +++++++++++++
>>  2 files changed, 227 insertions(+)
>>  create mode 100644 =
tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>>  create mode 100644 =
tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c =
b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> new file mode 100644
>> index 000000000000..b920f4501809
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +
>> +#include "sock_destroy_prog.skel.h"
>> +#include "network_helpers.h"
>> +
>> +#define ECONNABORTED 103
>> +
>> +static int duration;
>> +
>> +static void start_iter_sockets(struct bpf_program *prog)
>> +{
>> +	struct bpf_link *link;
>> +	char buf[16] =3D {};
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
>> +	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
>=20
> CHECK(s) are not super appealing in the new code, can you replace them
> all with ASSERT(s) ? This should also let you drop 'duration' =
variable.

Sorry, I missed this comment. I can look into replacing CHECK(s) with =
ASSERT(s)
as a follow-up. Will wait for reviews on patch v2 for now.=20
=20
>=20
>> +
>> +	close(iter_fd);
>> +
>> +free_link:
>> +	bpf_link__destroy(link);
>> +}
>> +
>> +void test_tcp(struct sock_destroy_prog *skel)
>> +{
>> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> +
>> +	serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
>> +	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
>> +		goto cleanup_serv;
>> +
>> +	clien =3D connect_to_fd(serv, 0);
>> +	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
>> +		goto cleanup_serv;
>> +
>> +	serv =3D accept(serv, NULL, NULL);
>> +	if (CHECK(serv < 0, "accept", "errno %d\n", errno))
>> +		goto cleanup;
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (CHECK(n < 0, "client_send", "client failed to send on =
socket\n"))
>> +		goto cleanup;
>> +
>> +	start_iter_sockets(skel->progs.iter_tcp6);
>> +
>> +	// Sockets are destroyed asynchronously.
>> +	usleep(1000);
>> +	n =3D send(clien, "t", 1, 0);
>=20
> That's racy. Do some kind of:
> 	while (retries--) {
> 		usleep(100);
> 		n =3D send (...)
> 		if (n < 0)
> 			break;
> 	}
> 	ASSERT_LT(n, 0);
> 	ASSERT_EQ(errno, ECONNABORTED);

This isn't applicable anymore as sockets are destroyed synchronously in =
the latest patches. =20

>=20
>> +
>> +	if (CHECK(n > 0, "client_send", "succeeded on destroyed =
socket\n"))
>> +		goto cleanup;
>> +	CHECK(errno !=3D ECONNABORTED, "client_send", "unexpected error =
code on destroyed socket\n");
>> +
>> +
>> +cleanup:
>> +	close(clien);
>> +cleanup_serv:
>> +	close(serv);
>> +}
>> +
>> +
>> +void test_udp(struct sock_destroy_prog *skel)
>> +{
>> +	int serv =3D -1, clien =3D -1, n =3D 0;
>> +
>> +	serv =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
>> +	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
>> +		goto cleanup_serv;
>> +
>> +	clien =3D connect_to_fd(serv, 0);
>> +	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
>> +		goto cleanup_serv;
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (CHECK(n < 0, "client_send", "client failed to send on =
socket\n"))
>> +		goto cleanup;
>> +
>> +	start_iter_sockets(skel->progs.iter_udp6);
>> +
>> +	// Sockets are destroyed asynchronously.
>> +	usleep(1000);
>=20
> Same here.
>=20
>> +
>> +	n =3D send(clien, "t", 1, 0);
>> +	if (CHECK(n > 0, "client_send", "succeeded on destroyed =
socket\n"))
>> +		goto cleanup;
>> +	// UDP sockets have an overriding error code after they are =
disconnected.
>> +
>> +
>> +cleanup:
>> +	close(clien);
>> +cleanup_serv:
>> +	close(serv);
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
>> +	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation =
failed\n"))
>> +		goto close_cgroup_fd;
>> +
>> +	skel->links.sock_connect =3D bpf_program__attach_cgroup(
>> +		skel->progs.sock_connect, cgroup_fd);
>> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
>> +		goto close_cgroup_fd;
>> +
>> +	test_tcp(skel);
>> +	test_udp(skel);
>> +
>> +
>> +close_cgroup_fd:
>> +	close(cgroup_fd);
>> +	sock_destroy_prog__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c =
b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> new file mode 100644
>> index 000000000000..ec566033f41f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#define AF_INET6 10
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
>> +int iter_tcp6(struct bpf_iter__tcp *ctx)
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
>> +
>> +	if (!val)
>> +		return 0;
>> +
>> +	if (sock_cookie =3D=3D *val)
>> +		bpf_sock_destroy(sk_common);
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("iter/udp")
>> +int iter_udp6(struct bpf_iter__udp *ctx)
>> +{
>> +	struct seq_file *seq =3D ctx->meta->seq;
>> +	struct udp_sock *udp_sk =3D ctx->udp_sk;
>> +	struct sock *sk =3D (struct sock *) udp_sk;
>> +	__u64 sock_cookie =3D 0;
>> +	int key =3D 0;
>> +	__u64 *val;
>> +
>> +	if (!sk)
>> +		return 0;
>> +
>> +	sock_cookie  =3D bpf_get_socket_cookie(sk);
>> +	val =3D bpf_map_lookup_elem(&udp_conn_sockets, &key);
>> +
>> +	if (!val)
>> +		return 0;
>> +
>> +	if (sock_cookie =3D=3D *val)
>> +		bpf_sock_destroy(sk);
>> +
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> --
>> 2.34.1

