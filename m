Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A376C3972
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCUSqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjCUSq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:46:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC55652B
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso16834690pjb.3
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbANLhf3hqhIyGGt/ULscXDjjpqtdotAlnChBBHHfc0=;
        b=H4BOwD8qXkex/aCS2BFONce/ndIBsl8WuxXInjHTAnq2Xz5IxIEBW1rHhRezsvRV9F
         PNYQePAPb4X51pG5fV8XoYgxEOe53fFwyMO1L5b2PeRXahNid8QvE3Zf5FpnA2ZWSNDt
         rvMfXxLSiFYGe3lksovUMyAl634rAahTq+wHEGN/C51tjhSxxInpoXL4BNykpsC7G1pM
         ahxxp14rvatYBH2qkF/0/lcR6PWmsrLrhiffj0k+bM0vW54gYkX5HwOHY6LaduKWmbT9
         g7ZLFe4fUgpKND0OC3HcwVIKeqyIMsMIHQczs1O1le319LdOngxHAHUTEqDZ0QWmnXys
         dUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbANLhf3hqhIyGGt/ULscXDjjpqtdotAlnChBBHHfc0=;
        b=uS7BFvJ1DGCS4ToEaFMa5r/gbuYIvJFzMQodK7jd/pshJ9/UjUd2uNvZSrgW8G0Qac
         08wKlD/sTcBZlDG5q+7savZKJSFRgHnRdVA1bo3yT4OTSOXPgnT9fQNUgrNGxH+F3hBP
         410RVwJSxQUOCJWRyWgRkLi5ZVhzxXOIEoFVQOr6UBh7iMwvouyPoL33yjyDghplj4cp
         uko7nZtZY31m+Fdko1G0MMirp58zqtUIHNDq3qFxKE4jf6NqDSxUmge1t/JRNNpFyQXE
         FsSEgIi+zku9beLytAJpBMg1W+X6xnIEhS1Qt5aqmuwQEh7BpQH+A+4stFQ0AjjZ4bXd
         QRwQ==
X-Gm-Message-State: AO0yUKWMGOx9IaQhfTYoE9iB26RjtF32V/Exnf6VOeMAg6tm1Xf/g9sl
        N9aHNgIkwNfzulcG9mn3OfzxBc2yEZxm2rXw2mg=
X-Google-Smtp-Source: AK7set/mRuL11fQG2APBE27NKAPSePbfzh4H4EQqpGxVIoiRiu6OJgtoryTNVFLpX+HoTaHFgUmqQw==
X-Received: by 2002:a17:902:dac7:b0:19f:3d59:e0ac with SMTP id q7-20020a170902dac700b0019f3d59e0acmr113366plx.44.1679424352839;
        Tue, 21 Mar 2023 11:45:52 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019cf747253csm9095878plj.87.2023.03.21.11.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:52 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH 5/5] selftests/bpf: Add tests for bpf_sock_destroy
Date:   Tue, 21 Mar 2023 18:45:41 +0000
Message-Id: <20230321184541.1857363-6-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test cases for TCP and UDP iterators mirror the intended usages of the
helper using BPF iterators.

The destroy helpers set `ECONNABORTED` error code that we can validate in
the test code with client sockets. But UDP sockets have an overriding error
code from the disconnect called during abort, so the error code the
validation is only done for TCP sockets.

The `struct sock` is redefined as vmlinux.h forward declares the struct,
and the loader fails to load the program as it finds the BTF FWD type for
the struct incompatible with the BTF STRUCT type.

Here are the snippets of the verifier error, and corresponding BTF output:

```
verifier error: extern (func ksym) ...: func_proto ... incompatible with kernel

BTF for selftest prog binary:

[104] FWD 'sock' fwd_kind=struct
[70] PTR '(anon)' type_id=104
[84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
	'(anon)' type_id=70
[85] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
--
[96] DATASEC '.ksyms' size=0 vlen=1
	type_id=85 offset=0 size=0 (FUNC 'bpf_sock_destroy')

BTF for selftest vmlinux:

[74923] FUNC 'bpf_sock_destroy' type_id=48965 linkage=static
[48965] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
	'sk' type_id=1340
[1340] PTR '(anon)' type_id=2363
[2363] STRUCT 'sock' size=1280 vlen=93
```

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 190 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++++++
 2 files changed, 341 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
new file mode 100644
index 000000000000..86c29f2c9d50
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "sock_destroy_prog.skel.h"
+#include "network_helpers.h"
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
+	int *listen_fds = NULL, serv = 0;
+	unsigned int num_listens = 5;
+
+	/* Start reuseport servers */
+	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
+					    "::1", 6062, 0,
+					    num_listens);
+	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
+		goto cleanup;
+
+	/* Run iterator program that destroys sockets. */
+	start_iter_sockets(skel->progs.iter_udp6_server);
+
+	/* Start a regular server that binds on the same port as the destroyed
+	 * sockets.
+	 */
+	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6062, 0);
+	ASSERT_GE(serv, 0, "start_server failed");
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
index 000000000000..3ccce63f0245
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define sock sock___not_used
+#include "vmlinux.h"
+#undef sock
+
+#include <bpf/bpf_helpers.h>
+
+#define AF_INET6 10
+
+/* Redefine the struct: vmlinux.h forward declares it, and the loader fails
+ * to load the program as it finds the BTF FWD type for the struct incompatible
+ * with the BTF STRUCT type.
+ */
+struct sock {
+	struct sock_common	__sk_common;
+#define sk_family		__sk_common.skc_family
+#define sk_cookie		__sk_common.skc_cookie
+};
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
+
+	if (!val)
+		return 0;
+
+	/* Destroy server sockets. */
+	if (sock_cookie != *val)
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
+
+	if (!sk)
+		return 0;
+
+	bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

