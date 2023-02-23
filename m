Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A446A1254
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBWVxX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWVxW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:53:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEC37F1A
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:53:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so741191pjz.1
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQsj6Auoo0IN8RyxVRlu6+qbOuFqvCmMHtfhRU40ih8=;
        b=NEiC6ZZhVZqYjG89SLzMI8kKLXRAYOMPyavq5dURcLym6z2iLbqkkaEe0ZF5pm7pwF
         3C0Hf9E3iYI/ZmccgiBBoZkjsfgEDSYwTA+iumnzY3aykwiB/DobAjBfqfJooRyHwLMZ
         fDE4z2Sp5ekrWezrPY7mzhUteMQ36pN3ntVm0RnthNQvwb0N8MiPf2Jhr62BR3q1ObVE
         kgereCitxOh74A7h5fOo/gEBjyb0BSsdgcaJMn+0vBmZbfxj8PZLgZod6zcHKj8KGNl7
         HmhGgL7EGQ3BgjgOKSVEPRKN+qR8DKcKZHQ9tN/pcTxdOhAUQiAl5vuYigUkuKHmXoQX
         BTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQsj6Auoo0IN8RyxVRlu6+qbOuFqvCmMHtfhRU40ih8=;
        b=P2BAIUg54aUwdiYFjHIKTwtiH+F3hLKOtIOcmovuIqiVn609MEPs0OdWIeNJy+CPff
         Tp+UqXOmTVjftaIZvAbl06lmTulxMWUqR1edV4bemKxp75cDYH0IV+sbp5pBMKM9uIT+
         LRtgp9/T+bqDh9Z4EmL6tm9HrfNjgZvfBa4FBwjK7RIlid33YtEAqYhU8Zu6K6lnAXbK
         EmcBqzzizfsaqeeUQjwAJTstbYWU3JlBOwNMBVgJfZO+PyQ8srNPtedT1rHQaWBSnhtt
         W1fLiqJGpAfdN02jF1DhoNU7NAhEjcQ+c7nh7JjyonIGdJ49WC/rKD04+4/GEF+YNvC3
         XVVg==
X-Gm-Message-State: AO0yUKXSIsyeOWTLYZE2E6omL2rUJ8dv940I/1PBuhQKQzNp+0qM1YDA
        jQN/FA9GYi3tXc5Av+MpmvvQfEM2Nq/8JqHy
X-Google-Smtp-Source: AK7set+kD6dXwgRkn/MJ8Ek+A4SsZdZQN7E6EtH9OTgtLWEJjr7A6sqnjJ5Yrp+VF+PsUXuxoZFCWQ==
X-Received: by 2002:a17:903:1c9:b0:19a:b683:e11f with SMTP id e9-20020a17090301c900b0019ab683e11fmr17037061plh.27.1677189200571;
        Thu, 23 Feb 2023 13:53:20 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0019c33ee4730sm8292686pld.146.2023.02.23.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:53:20 -0800 (PST)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for bpf_sock_destroy
Date:   Thu, 23 Feb 2023 21:53:11 +0000
Message-Id: <20230223215311.926899-4-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223215311.926899-1-aditi.ghag@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test cases for TCP and UDP iterators mirror the intended usages of the
helper.

The destroy helpers set `ECONNABORTED` error code that we can validate in the
test code with client sockets. But UDP sockets have an overriding error code
from the disconnect called during abort, so the error code the validation is
only done for TCP sockets.

The `struct sock` is redefined as vmlinux.h forward declares the struct, and the
loader fails to load the program as it finds the BTF FWD type for the struct
incompatible with the BTF STRUCT type.

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
 .../selftests/bpf/prog_tests/sock_destroy.c   | 125 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 110 +++++++++++++++
 2 files changed, 235 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
new file mode 100644
index 000000000000..d9da9d3578e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "sock_destroy_prog.skel.h"
+#include "network_helpers.h"
+
+#define ECONNABORTED 103
+
+static int duration;
+
+static void start_iter_sockets(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+	char buf[16] = {};
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
+	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+}
+
+void test_tcp(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
+		goto cleanup_serv;
+
+	clien = connect_to_fd(serv, 0);
+	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
+		goto cleanup_serv;
+
+	serv = accept(serv, NULL, NULL);
+	if (CHECK(serv < 0, "accept", "errno %d\n", errno))
+		goto cleanup;
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
+		goto cleanup;
+
+	start_iter_sockets(skel->progs.iter_tcp6);
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n > 0, "client_send after destroy", "succeeded on destroyed socket\n"))
+		goto cleanup;
+	CHECK(errno != ECONNABORTED, "client_send", "unexpected error code on destroyed socket\n");
+
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
+}
+
+
+void test_udp(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n = 0;
+
+	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
+	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
+		goto cleanup_serv;
+
+	clien = connect_to_fd(serv, 0);
+	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
+		goto cleanup_serv;
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
+		goto cleanup;
+
+	start_iter_sockets(skel->progs.iter_udp6);
+
+	n = send(clien, "t", 1, 0);
+	if (CHECK(n > 0, "client_send after destroy", "succeeded on destroyed socket\n"))
+		goto cleanup;
+	// UDP sockets have an overriding error code after they are disconnected.
+
+
+cleanup:
+	close(clien);
+cleanup_serv:
+	close(serv);
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
+	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
+		goto close_cgroup_fd;
+
+	skel->links.sock_connect = bpf_program__attach_cgroup(
+		skel->progs.sock_connect, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
+		goto close_cgroup_fd;
+
+	test_tcp(skel);
+	test_udp(skel);
+
+
+close_cgroup_fd:
+	close(cgroup_fd);
+	sock_destroy_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
new file mode 100644
index 000000000000..c6805a9b7594
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -0,0 +1,110 @@
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
+int iter_tcp6(struct bpf_iter__tcp *ctx)
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
+	if (sock_cookie == *val)
+		bpf_sock_destroy(sk_common);
+
+	return 0;
+}
+
+SEC("iter/udp")
+int iter_udp6(struct bpf_iter__udp *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct udp_sock *udp_sk = ctx->udp_sk;
+	struct sock *sk = (struct sock *) udp_sk;
+	__u64 sock_cookie = 0;
+	int key = 0;
+	__u64 *val;
+
+	if (!sk)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk);
+	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
+
+	if (!val)
+		return 0;
+
+	if (sock_cookie == *val)
+		bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

