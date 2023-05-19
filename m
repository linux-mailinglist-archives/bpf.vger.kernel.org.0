Return-Path: <bpf+bounces-983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD13070A2F6
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833A7281C40
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648513ACF;
	Fri, 19 May 2023 22:52:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E86FB7
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:15 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113011BD
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643990c5373so3931533b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536731; x=1687128731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tfC9jLasULEUqFHkxkOSJ44RqqR1/d/wgZXkL5/Tb4=;
        b=KbSHzcTil0ABQAVbbi2wXzpKtAD7wafoO63VwvYla7hGtls5lx5gUyrB9YJ13HlT7Z
         rgcnx69nfkSGD3DX65+/CNrn6jy3iy86x2vSaeNn8NuIHhS0U3EWh91fCqUbOM7mjzOs
         jLQ5gb2MpGqXM8sP6fkwCcDUzJA70TGuQH+uWcRADCwHGGOKHTfN9PS9zPjNP748V141
         KrCQ759mVVZP6Dtp0E8tqBlvuAF6hc8dhwcicXZ1NCmXMFd6oLMGsa+7UX3qcwjTCJl3
         pf/91A2JO2eRjZHkU7mRIh3hYnvUCzNzioRv93Y8yg4DYywfSaW0uihsKQZJ4tJHXm8S
         ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536731; x=1687128731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tfC9jLasULEUqFHkxkOSJ44RqqR1/d/wgZXkL5/Tb4=;
        b=MQ4vjl3sdsMfLFSOMxpW2prQp9ieLiIhFycPQ8xXFHDT/g+uYmRwXtYjvtOMjUhG7X
         HjdoGFkkpI6Rt2VMxoXTB0WG8zyoBG6zKSQOLVutXuwUxxgP/73qLLmpjI1a+PdqejQg
         RPcJwLmHqLCggej/SibIROxxuxCfYaOGMOGPSQoGjllSjkTlTojuN5r/nNdvGxY3x6ea
         vJ3ZjKo+bdMd4UOUd34Xcc9lhlXqaQZ6+4e0F+5C1dR9o71z6E5Lpg/Mht+F9zemQOVe
         ewSKzrJ1FqmBQ8/0/Auw6BgYau8f5mrx62q4NoW/wC2uOsm5EzI69/aE1eltD94HoDlv
         rtiQ==
X-Gm-Message-State: AC+VfDyLHVnG6gGd3u4SYQ9gx2GTvH7+v0cENBfrsrlbUr+I8plMejfe
	cp5HDjuYOdd5PO9g+VnSYCXlbgZfKWwxYqasjbg=
X-Google-Smtp-Source: ACHHUZ6h1gVIxtxN6YJbvKc//VM1VrQIbG3GhEv0pFoBMx+3clSoOoDPjOOllzDOt8WrWPiig/Q5YQ==
X-Received: by 2002:a17:903:4284:b0:1a9:b0a3:f03a with SMTP id ju4-20020a170903428400b001a9b0a3f03amr3829930plb.9.1684536730793;
        Fri, 19 May 2023 15:52:10 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:10 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v9 bpf-next 9/9] selftests/bpf: Test bpf_sock_destroy
Date: Fri, 19 May 2023 22:51:57 +0000
Message-Id: <20230519225157.760788-10-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test cases for destroying sockets mirror the intended usages of the
bpf_sock_destroy kfunc using iterators.

The destroy helpers set `ECONNABORTED` error code that we can validate
in the test code with client sockets. But UDP sockets have an overriding
error code from `disconnect()` called during abort, so the error code
validation is only done for TCP sockets.

The failure test cases validate that the `bpf_sock_destroy` kfunc is not
allowed from program attach types other than BPF trace iterator, and
such programs fail to load.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 221 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 145 ++++++++++++
 .../bpf/progs/sock_destroy_prog_fail.c        |  22 ++
 3 files changed, 388 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
new file mode 100644
index 000000000000..b0583309a94e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/bpf_endian.h>
+
+#include "sock_destroy_prog.skel.h"
+#include "sock_destroy_prog_fail.skel.h"
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
+	int serv = -1, clien = -1, accept_serv = -1, n;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup;
+
+	accept_serv = accept(serv, NULL, NULL);
+	if (!ASSERT_GE(accept_serv, 0, "serv accept"))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_EQ(n, 1, "client send"))
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
+cleanup:
+	if (clien != -1)
+		close(clien);
+	if (accept_serv != -1)
+		close(accept_serv);
+	if (serv != -1)
+		close(serv);
+}
+
+static void test_tcp_server(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, accept_serv = -1, n, serv_port;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+	serv_port = get_socket_local_port(serv);
+	if (!ASSERT_GE(serv_port, 0, "get_sock_local_port"))
+		goto cleanup;
+	skel->bss->serv_port = (__be16) serv_port;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup;
+
+	accept_serv = accept(serv, NULL, NULL);
+	if (!ASSERT_GE(accept_serv, 0, "serv accept"))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_EQ(n, 1, "client send"))
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
+cleanup:
+	if (clien != -1)
+		close(clien);
+	if (accept_serv != -1)
+		close(accept_serv);
+	if (serv != -1)
+		close(serv);
+}
+
+static void test_udp_client(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (!ASSERT_EQ(n, 1, "client send"))
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
+	if (clien != -1)
+		close(clien);
+	if (serv != -1)
+		close(serv);
+}
+
+static void test_udp_server(struct sock_destroy_prog *skel)
+{
+	int *listen_fds = NULL, n, i, serv_port;
+	unsigned int num_listens = 5;
+	char buf[1];
+
+	/* Start reuseport servers. */
+	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
+					    "::1", 0, 0, num_listens);
+	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
+		goto cleanup;
+	serv_port = get_socket_local_port(listen_fds[0]);
+	if (!ASSERT_GE(serv_port, 0, "get_sock_local_port"))
+		goto cleanup;
+	skel->bss->serv_port = (__be16) serv_port;
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
+	int cgroup_fd;
+
+	skel = sock_destroy_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/sock_destroy");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	skel->links.sock_connect = bpf_program__attach_cgroup(
+		skel->progs.sock_connect, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
+		goto cleanup;
+
+	SYS(cleanup, "ip netns add %s", TEST_NS);
+	SYS(cleanup, "ip -net %s link set dev lo up", TEST_NS);
+
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto cleanup;
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
+	RUN_TESTS(sock_destroy_prog_fail);
+
+cleanup:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	sock_destroy_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
new file mode 100644
index 000000000000..9e0bf7a54cec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#include "bpf_tracing_net.h"
+
+__be16 serv_port = 0;
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
+	__u64 sock_cookie = 0;
+	int key = 0;
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
+	const struct inet_connection_sock *icsk;
+	const struct inet_sock *inet;
+	struct tcp6_sock *tcp_sk;
+	__be16 srcp;
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
+	struct inet_sock *inet;
+	__be16 srcp;
+
+	if (!sk)
+		return 0;
+
+	inet = &udp_sk->inet;
+	srcp = inet->inet_sport;
+	if (srcp == serv_port)
+		bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
new file mode 100644
index 000000000000..dd6850b58e25
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+
+SEC("tp_btf/tcp_destroy_sock")
+__failure __msg("calling kernel function bpf_sock_destroy is not allowed")
+int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
+{
+	/* should not load */
+	bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
-- 
2.34.1


