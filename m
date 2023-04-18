Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB66E682F
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjDRPcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjDRPcH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0F9025
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51f6461af24so585197a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831925; x=1684423925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfKeIulC4jV6FZNcjDlGGOvIECkdyQT5zakxM/ras2g=;
        b=ZSIIqF4c+fR/o5Zpydywns8+5LbrHvfoiPTv2m9CO/ZS+pzS9npT/ndWOTo0vIEjwj
         Tmyg5Y+WoLauu9GWuSuGDRymf8g19hNMKpzd9R9F5+lvm1vT/NCKpOO3LxEgruTiOfAo
         DVmEDBG2O67DBvtLY4GCLED+8I3h+xqgM63esDasWiuKHjZApGTOpjDO7uuxs3qtw4EL
         eIS+o/VqsWxeLPSVJjr/SS2HBAFrxY269B+YtC5E+jAd/slKp4sUL63VPFkdQTekIan8
         Au4EWzyrAR6D77sKSPmh5Hocuz30wmrQNO09nDmUmg9BYsWfCBp/SEs5rLljSmFHalM6
         NNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831925; x=1684423925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfKeIulC4jV6FZNcjDlGGOvIECkdyQT5zakxM/ras2g=;
        b=WnxR3WtPtTlOdY9Jx/wMR7yjztzRBg1blRqmzn9aVwmfBG+DQVIADlIq149Q0rik5w
         JdVnUxk08fhpGfOeHs2I+/1iditfFVjztgF8pkNHIfzXl4Lv0xXs2XDyDmlNhdRDCRYx
         kefIJRWfoIggNx7Noz/SbjeEzDczrhrQA9fJsUHk+EG1hlylkcPGPaQQVrcU0/EBH2uf
         Ic3pt0byd7zk/LMZJ68Aa8xbcSaSNKtHgMmNMnAUjrIHCT+XAPBKopt3fiFfOhkUfP0k
         96F0Dc6CsBbMVb+rCiP9RxTaFphTY+fPlAQM34SfI7cikisVftYCYldyY7yNb3LH/QTt
         pi/g==
X-Gm-Message-State: AAQBX9cEXzg5sHvlt5IHoZxo0ekerxdt/eXUTZvl3Kyov4EJW5im+qES
        J3oNo2LrrEVjBzryGX4lR+aGlWSX9b6LufViFQo=
X-Google-Smtp-Source: AKy350ahJHSaJD2xc16iTIomdCWSvUWfxKmDh2TYhYgw0BsBXi+BjWwRmbGBDUJcH9zM3Gcaq7HqIA==
X-Received: by 2002:a17:902:ecc4:b0:1a6:c366:1603 with SMTP id a4-20020a170902ecc400b001a6c3661603mr2874644plh.19.1681831924947;
        Tue, 18 Apr 2023 08:32:04 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:32:04 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH 7/7] selftests/bpf: Test bpf_sock_destroy
Date:   Tue, 18 Apr 2023 15:31:48 +0000
Message-Id: <20230418153148.2231644-8-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test cases for destroying sockets mirror the intended usages of the
bpf_sock_destroy kfunc using iterators.

The destroy helpers set `ECONNABORTED` error code that we can validate in
the test code with client sockets. But UDP sockets have an overriding error
code from the disconnect called during abort, so the error code the
validation is only done for TCP sockets.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 217 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 147 ++++++++++++
 2 files changed, 364 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
new file mode 100644
index 000000000000..51f2454b7b4b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/bpf_endian.h>
+
+#include "sock_destroy_prog.skel.h"
+#include "network_helpers.h"
+
+#define TEST_NS "sock_destroy_netns"
+
+static void start_iter_sockets(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+	char buf[50] = {};
+	int iter_fd, len;
+
+	link = bpf_program__attach_iter(prog, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+		goto free_link;
+
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	ASSERT_GE(len, 0, "read");
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+}
+
+static void test_tcp_client(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup_serv;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup_serv;
+
+	serv = accept(serv, NULL, NULL);
+	if (!ASSERT_GE(serv, 0, "serv accept"))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_GE(n, 0, "client send"))
+		goto cleanup;
+
+	/* Run iterator program that destroys connected client sockets. */
+	start_iter_sockets(skel->progs.iter_tcp6_client);
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
+		goto cleanup;
+	ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket");
+
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
+}
+
+static void test_tcp_server(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0, err;
+	__u16 serv_port = 0;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup_serv;
+	err = get_socket_local_port(AF_INET6, serv, &serv_port);
+	if (!ASSERT_EQ(err, 0, "get_local_port"))
+		goto cleanup;
+	skel->bss->serv_port = serv_port;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup_serv;
+
+	serv = accept(serv, NULL, NULL);
+	if (!ASSERT_GE(serv, 0, "serv accept"))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_GE(n, 0, "client send"))
+		goto cleanup;
+
+	/* Run iterator program that destroys server sockets. */
+	start_iter_sockets(skel->progs.iter_tcp6_server);
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
+		goto cleanup;
+	ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
+
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
+}
+
+
+static void test_udp_client(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup_serv;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup_serv;
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_GE(n, 0, "client send"))
+		goto cleanup;
+
+	/* Run iterator program that destroys sockets. */
+	start_iter_sockets(skel->progs.iter_udp6_client);
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
+		goto cleanup;
+	/* UDP sockets have an overriding error code after they are disconnected,
+	 * so we don't check for ECONNABORTED error code.
+	 */
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
+}
+
+static void test_udp_server(struct sock_destroy_prog *skel)
+{
+	int *listen_fds = NULL, n, i, err;
+	unsigned int num_listens = 5;
+	char buf[1];
+	__u16 serv_port;
+
+	/* Start reuseport servers. */
+	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
+					    "::1", 0, 0, num_listens);
+	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
+		goto cleanup;
+	err = get_socket_local_port(AF_INET6, listen_fds[0], &serv_port);
+	if (!ASSERT_EQ(err, 0, "get_local_port"))
+		goto cleanup;
+	skel->bss->serv_port = ntohs(serv_port);
+
+	/* Run iterator program that destroys server sockets. */
+	start_iter_sockets(skel->progs.iter_udp6_server);
+
+	for (i = 0; i < num_listens; ++i) {
+		n = read(listen_fds[i], buf, sizeof(buf));
+		if (!ASSERT_EQ(n, -1, "read") ||
+		    !ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket"))
+			break;
+	}
+	ASSERT_EQ(i, num_listens, "server socket");
+
+cleanup:
+	free_fds(listen_fds, num_listens);
+}
+
+void test_sock_destroy(void)
+{
+	struct sock_destroy_prog *skel;
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd = 0;
+
+	skel = sock_destroy_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/sock_destroy");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto close_cgroup_fd;
+
+	skel->links.sock_connect = bpf_program__attach_cgroup(
+		skel->progs.sock_connect, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
+		goto close_cgroup_fd;
+
+	SYS(fail, "ip netns add %s", TEST_NS);
+	SYS(fail, "ip -net %s link set dev lo up", TEST_NS);
+
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	if (test__start_subtest("tcp_client"))
+		test_tcp_client(skel);
+	if (test__start_subtest("tcp_server"))
+		test_tcp_server(skel);
+	if (test__start_subtest("udp_client"))
+		test_udp_client(skel);
+	if (test__start_subtest("udp_server"))
+		test_udp_server(skel);
+
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+close_cgroup_fd:
+	close(cgroup_fd);
+	sock_destroy_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
new file mode 100644
index 000000000000..1f265e0d9dea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#include "bpf_tracing_net.h"
+
+#define AF_INET6 10
+
+__u16 serv_port = 0;
+
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} tcp_conn_sockets SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} udp_conn_sockets SEC(".maps");
+
+SEC("cgroup/connect6")
+int sock_connect(struct bpf_sock_addr *ctx)
+{
+	int key = 0;
+	__u64 sock_cookie = 0;
+	__u32 keyc = 0;
+
+	if (ctx->family != AF_INET6 || ctx->user_family != AF_INET6)
+		return 1;
+
+	sock_cookie = bpf_get_socket_cookie(ctx);
+	if (ctx->protocol == IPPROTO_TCP)
+		bpf_map_update_elem(&tcp_conn_sockets, &key, &sock_cookie, 0);
+	else if (ctx->protocol == IPPROTO_UDP)
+		bpf_map_update_elem(&udp_conn_sockets, &keyc, &sock_cookie, 0);
+	else
+		return 1;
+
+	return 1;
+}
+
+SEC("iter/tcp")
+int iter_tcp6_client(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = ctx->sk_common;
+	__u64 sock_cookie = 0;
+	__u64 *val;
+	int key = 0;
+
+	if (!sk_common)
+		return 0;
+
+	if (sk_common->skc_family != AF_INET6)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk_common);
+	val = bpf_map_lookup_elem(&tcp_conn_sockets, &key);
+	if (!val)
+		return 0;
+	/* Destroy connected client sockets. */
+	if (sock_cookie == *val)
+		bpf_sock_destroy(sk_common);
+
+	return 0;
+}
+
+SEC("iter/tcp")
+int iter_tcp6_server(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = ctx->sk_common;
+	struct tcp6_sock *tcp_sk;
+	const struct inet_connection_sock *icsk;
+	const struct inet_sock *inet;
+	__u16 srcp;
+
+	if (!sk_common)
+		return 0;
+
+	if (sk_common->skc_family != AF_INET6)
+		return 0;
+
+	tcp_sk = bpf_skc_to_tcp6_sock(sk_common);
+	if (!tcp_sk)
+		return 0;
+
+	icsk = &tcp_sk->tcp.inet_conn;
+	inet = &icsk->icsk_inet;
+	srcp = inet->inet_sport;
+
+	/* Destroy server sockets. */
+	if (srcp == serv_port)
+		bpf_sock_destroy(sk_common);
+
+	return 0;
+}
+
+
+SEC("iter/udp")
+int iter_udp6_client(struct bpf_iter__udp *ctx)
+{
+	struct udp_sock *udp_sk = ctx->udp_sk;
+	struct sock *sk = (struct sock *) udp_sk;
+	__u64 sock_cookie = 0, *val;
+	int key = 0;
+
+	if (!sk)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk);
+	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
+	if (!val)
+		return 0;
+	/* Destroy connected client sockets. */
+	if (sock_cookie == *val)
+		bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
+SEC("iter/udp")
+int iter_udp6_server(struct bpf_iter__udp *ctx)
+{
+	struct udp_sock *udp_sk = ctx->udp_sk;
+	struct sock *sk = (struct sock *) udp_sk;
+	__u16 srcp;
+	struct inet_sock *inet;
+
+	if (!sk)
+		return 0;
+
+	inet = &udp_sk->inet;
+	srcp = bpf_ntohs(inet->inet_sport);
+	if (srcp == serv_port)
+		bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

