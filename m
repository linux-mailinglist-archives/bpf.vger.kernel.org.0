Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2186511C1
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 19:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLSSZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 13:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLSSZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 13:25:51 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F591C2
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:25:48 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id h185-20020a636cc2000000b004820a10a57bso5943787pgc.22
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3tzCB48gF4DUiR72PsSUHhR/otUmgL5n1p4CFlOR1Q=;
        b=pGjaeZiRyDxq/83lXKFYfHcVeAsO6stm+MpcgZ269qBTqmX9/z50lYg9Iaas/UKX+D
         WvevZr+BqkcQtURHum5E34m7tfWhac1tvGUG0AzJWqcazaqxnNmBDn8IR1KokmVJH77+
         7W4D6DD/M/O1HvTZcgkTXhuzhe4R5LIjWP7HB/pHy3E52EZph14M41/X59UnS+Jr/B8B
         NSK5HP17ooQmYYyjAG9p1YNdMuUbrNZiUdYY2w16har7iEne7WGMtAYkgqeTt3BH9iAq
         R4uQsmPG5ZihQw+G3TIrH4pI2iJBz4Ia5L6XytZXzQb7+Rlf17vOiUeNDDdGEvT0WkwV
         6ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3tzCB48gF4DUiR72PsSUHhR/otUmgL5n1p4CFlOR1Q=;
        b=33b67sXzdlwaoS38ZIKfK1KSWKXVnMVBrni8VXDx9eKlpOE+5JJd2FDBq8msZuODEJ
         gskHbaDkd0HW/LfGluJAuEjkF509CQYixRfE/RVudgsK7VJuV78OaVLO/PiFj1PuIfxS
         YYv5jk4VP9FWeh2LkPhVvB78/P3v9ZBsofeU2wp2u/8YgNKaOl4VCfkGMWaDQHa+Oh34
         VwJdPelGM01I6PEkgfB3NYmyVPZwL2XC2UUuh9hPfon/TilCsnFwshGHYapX49rexWJg
         PLkxxsTdgRFVB91uPLiSh7yHC9oZ2BwEzVsgiRN4HFECSjlXuOzTkqvtfewRacVn5s9j
         strw==
X-Gm-Message-State: ANoB5pnQDAUTifwifjRsdoii5cJnD28XBizEcswCzQb3VtVFZlsIq+m5
        KzjofLzZNFF7kxWTEEM6Qq3Yhwg=
X-Google-Smtp-Source: AA0mqf6puTqQ2ucwDFK4jw3oPGRDxktjSNq/eYitXuJnjIq3osQF8HDX/WMho/CTUDgXiKHsEV8hfXw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:9192:0:b0:563:1ae2:6daf with SMTP id
 x18-20020aa79192000000b005631ae26dafmr11948705pfa.71.1671474348237; Mon, 19
 Dec 2022 10:25:48 -0800 (PST)
Date:   Mon, 19 Dec 2022 10:25:46 -0800
In-Reply-To: <16c81434c64f1c2a5d10e06c7199cc4715e467a0.1671242108.git.aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <cover.1671242108.git.aditi.ghag@isovalent.com> <16c81434c64f1c2a5d10e06c7199cc4715e467a0.1671242108.git.aditi.ghag@isovalent.com>
Message-ID: <Y6CsqsH1JQmVWgNx@google.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Add tests for bpf_sock_destroy
From:   sdf@google.com
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/17, Aditi Ghag wrote:
> The test cases for TCP and UDP mirror the
> intended usages of the helper.

> As the helper destroys sockets asynchronously,
> the tests have sleep invocation before validating
> if the sockets were destroyed by sending data.

> Also, while all the protocol specific helpers
> set `ECONNABORTED` error code on the destroyed sockets,
> only the TCP test case has the validation check. UDP
> sockets have an overriding error code from the disconnect
> call during abort.

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/sock_destroy.c   | 131 ++++++++++++++++++
>   .../selftests/bpf/progs/sock_destroy_prog.c   |  96 +++++++++++++
>   2 files changed, 227 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c  
> b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> new file mode 100644
> index 000000000000..b920f4501809
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "sock_destroy_prog.skel.h"
> +#include "network_helpers.h"
> +
> +#define ECONNABORTED 103
> +
> +static int duration;
> +
> +static void start_iter_sockets(struct bpf_program *prog)
> +{
> +	struct bpf_link *link;
> +	char buf[16] = {};
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
> +	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));

CHECK(s) are not super appealing in the new code, can you replace them
all with ASSERT(s) ? This should also let you drop 'duration' variable.

> +
> +	close(iter_fd);
> +
> +free_link:
> +	bpf_link__destroy(link);
> +}
> +
> +void test_tcp(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
> +		goto cleanup_serv;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
> +		goto cleanup_serv;
> +
> +	serv = accept(serv, NULL, NULL);
> +	if (CHECK(serv < 0, "accept", "errno %d\n", errno))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
> +		goto cleanup;
> +
> +	start_iter_sockets(skel->progs.iter_tcp6);
> +
> +	// Sockets are destroyed asynchronously.
> +	usleep(1000);
> +	n = send(clien, "t", 1, 0);

That's racy. Do some kind of:
	while (retries--) {
		usleep(100);
		n = send (...)
		if (n < 0)
			break;
	}
	ASSERT_LT(n, 0);
	ASSERT_EQ(errno, ECONNABORTED);

> +
> +	if (CHECK(n > 0, "client_send", "succeeded on destroyed socket\n"))
> +		goto cleanup;
> +	CHECK(errno != ECONNABORTED, "client_send", "unexpected error code on  
> destroyed socket\n");
> +
> +
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +
> +void test_udp(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
> +	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
> +		goto cleanup_serv;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
> +		goto cleanup_serv;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
> +		goto cleanup;
> +
> +	start_iter_sockets(skel->progs.iter_udp6);
> +
> +	// Sockets are destroyed asynchronously.
> +	usleep(1000);

Same here.

> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n > 0, "client_send", "succeeded on destroyed socket\n"))
> +		goto cleanup;
> +	// UDP sockets have an overriding error code after they are  
> disconnected.
> +
> +
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
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
> +	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
> +		goto close_cgroup_fd;
> +
> +	skel->links.sock_connect = bpf_program__attach_cgroup(
> +		skel->progs.sock_connect, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
> +		goto close_cgroup_fd;
> +
> +	test_tcp(skel);
> +	test_udp(skel);
> +
> +
> +close_cgroup_fd:
> +	close(cgroup_fd);
> +	sock_destroy_prog__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c  
> b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> new file mode 100644
> index 000000000000..ec566033f41f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +
> +#define AF_INET6 10
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
> +int iter_tcp6(struct bpf_iter__tcp *ctx)
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
> +
> +	if (!val)
> +		return 0;
> +
> +	if (sock_cookie == *val)
> +		bpf_sock_destroy(sk_common);
> +
> +	return 0;
> +}
> +
> +SEC("iter/udp")
> +int iter_udp6(struct bpf_iter__udp *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct udp_sock *udp_sk = ctx->udp_sk;
> +	struct sock *sk = (struct sock *) udp_sk;
> +	__u64 sock_cookie = 0;
> +	int key = 0;
> +	__u64 *val;
> +
> +	if (!sk)
> +		return 0;
> +
> +	sock_cookie  = bpf_get_socket_cookie(sk);
> +	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
> +
> +	if (!val)
> +		return 0;
> +
> +	if (sock_cookie == *val)
> +		bpf_sock_destroy(sk);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.34.1

