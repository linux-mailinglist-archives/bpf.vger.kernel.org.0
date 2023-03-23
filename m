Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E16C7189
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCWUG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjCWUG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 16:06:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF327D72
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:06:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so3202318pjz.1
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679602015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqlCtkrEe4IG93h1sBoZV6/NlO9q0b2uUq4t5Cc8lEw=;
        b=XMaCj/5TqxWdOx/gaoorvxMzSdRXCusEzWN93LR8TcAJ7NeQfvX3WD9o1QEjsDz+0I
         H2TmkNJtxc+2qMTdfBz+pgbmLDo2V8qNwQb/v8HZIAejrnw6m5m+dGb4gLqbhLo4k4AD
         nQNEDUePsR1+IYuvwHlF8vWPLnVsQBDD9POtNDBJYDFHstME7g3wERrP98h7IEo0DR1h
         q05OBx97DXdPnt2AZu9LSm6f2li8BsdxpgVGcNmJH67eqaP0FmGm/1Of5hXxkptQ6XCW
         G9hojRVhIxHfc7/7mPqwjH4C7cCQjAWqgqKdpd0OMbJ2VUsDWppWMyNeuNtMC+tABi2n
         KaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679602015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqlCtkrEe4IG93h1sBoZV6/NlO9q0b2uUq4t5Cc8lEw=;
        b=6jHQ4gfYNJhTKc4ZWAQzpMng8Qm2SAOUkwfTNkpxGi8ZKg4ncaAx+5geuSdwqM93lz
         26AOKehtVCp1qDN8oXPyYr1sjB5POSpSxf2LNojW32P5iduCvh8Dyvhj/kONcNOlz9SP
         /5FrJTiU1QbiIUZJZ6g+V2IrEQsgwn432aVk+9M+SSayHUtFopPZj1O2ye8lXHJTxvou
         pKhBIfP+NpvG8NAdIG3GOSFXLffAfiMViadbnrPcZQIksdcALJjAnJ8pVJm31sGo9zuO
         E/w98WhwJuN798skgfgpt+df6ha14VWSDVJm4DzT4LBYM2msvaPwWw3TFIa+ufQYjICU
         c06A==
X-Gm-Message-State: AAQBX9eil0hGRvF2vMAFNKALqymmijaOfVvcxpwCIWtYMbIokrn3u1Qj
        6Eatrx1vIK911TvI+HDy883q7s6kOlnEYGU47Ts=
X-Google-Smtp-Source: AKy350ZDC4kdwtzrHXFXAP4YvoguLeP33fmmEthejpJjzDVnKFSR5PY3TgFETTuQQRtO1kUBn+MBWQ==
X-Received: by 2002:a17:903:22cb:b0:1a1:b174:8363 with SMTP id y11-20020a17090322cb00b001a1b1748363mr61488plg.59.1679602014928;
        Thu, 23 Mar 2023 13:06:54 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b0019aaab3f9d7sm12701698plt.113.2023.03.23.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:06:54 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v4 bpf-next 4/4] selftests/bpf: Add tests for bpf_sock_destroy
Date:   Thu, 23 Mar 2023 20:06:33 +0000
Message-Id: <20230323200633.3175753-5-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../selftests/bpf/prog_tests/sock_destroy.c   | 195 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++++++
 2 files changed, 346 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
new file mode 100644
index 000000000000..cbce966af568
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "sock_destroy_prog.skel.h"
+#include "network_helpers.h"
+
+#define SERVER_PORT 6062
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
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, SERVER_PORT, 0);
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
+	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
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
+	int *listen_fds = NULL, n, i;
+	unsigned int num_listens = 5;
+	char buf[1];
+
+	/* Start reuseport servers. */
+	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
+					    "::1", SERVER_PORT, 0,
+					    num_listens);
+	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
+		goto cleanup;
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
+	int cgroup_fd = 0;
+	struct sock_destroy_prog *skel;
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
+close_cgroup_fd:
+	close(cgroup_fd);
+	sock_destroy_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
new file mode 100644
index 000000000000..8e09d82c50f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define AF_INET6 10
+/* Keep it in sync with prog_test/sock_destroy. */
+#define SERVER_PORT 6062
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
+	struct seq_file *seq = ctx->meta->seq;
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
+	struct seq_file *seq = ctx->meta->seq;
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
+	srcp = bpf_ntohs(inet->inet_sport);
+
+	/* Destroy server sockets. */
+	if (srcp == SERVER_PORT)
+		bpf_sock_destroy(sk_common);
+
+	return 0;
+}
+
+
+SEC("iter/udp")
+int iter_udp6_client(struct bpf_iter__udp *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
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
+	struct seq_file *seq = ctx->meta->seq;
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
+	if (srcp == SERVER_PORT)
+		bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

