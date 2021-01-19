Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A92FBBD7
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 17:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbhASQBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 11:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391818AbhASQBZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 11:01:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6EDC061786
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 08:00:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m4so20226200wrx.9
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 08:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAfSg8Fno74YY8zXaeftS+7dCj6mUJUr1YhGd25SC40=;
        b=UgWzD947TTGVrvW7arOh16ahLc6G84WlpFGyJcwFgsOAz2clt+43fPC4JZrvfzfo1T
         q52ay0Ks7gk639LogKiKFNQWP8yjBXY/HKySJHZC1dzMt09PpzJg/PaHXFzMCyMNjW+f
         j7JnvO/3zREbMTL7PgwWJ4bzjz3eAu3qiM6eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAfSg8Fno74YY8zXaeftS+7dCj6mUJUr1YhGd25SC40=;
        b=St9036YQY89mYoz45/7+kmxtCwcZxkcMb5a5h5zzSlGlT9BYQUwRRu3srdIYwIN1Ed
         NN+sTMHGMR27nzkX78TrLdx0eO3PxQSpACs/XbVjbpnW/Xg9Tjtqqks9jevbFzvw2UW+
         o766jTk13Nn/LfuNN+p9vy+csrPcVkLu4650r0Z+hyoKJd9LIOGzGOrO5TdHna5hv7t0
         LRZoYG/fvJbuXeDlBq8zWu4LZdRH/e2vTj6vTw+6H3KJ4YCxMRBTvZxYNaCdwWBsnVo6
         /VHkXwnlL7W+J2HKpNUlSL3QXE6YGJIB3ptcEQAqYeetj3Db8XP8xVQ7YYkrJhrOVJBY
         KuZg==
X-Gm-Message-State: AOAM532Uti5kOnc6KnX5WEG43/9JMAq7YUCXFuyC2an3ZOQyxbCEcemY
        15oZplWs4BJjJRFe57fWhFia8nVDMEbg3Q==
X-Google-Smtp-Source: ABdhPJyCEVFXBSzyGnJR7Uy/5wT+001olvKFYyd/vXosprgaDTgpTBP1GvcPtxJGTEga382CCaBEgg==
X-Received: by 2002:adf:ffc8:: with SMTP id x8mr5052747wrs.158.1611072009246;
        Tue, 19 Jan 2021 08:00:09 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:81f8:2ac6:58bf:7d7a])
        by smtp.gmail.com with ESMTPSA id n11sm41454944wra.9.2021.01.19.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:00:08 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Add a selftest for the tracing bpf_get_socket_cookie
Date:   Tue, 19 Jan 2021 16:59:53 +0100
Message-Id: <20210119155953.803818-4-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119155953.803818-1-revest@chromium.org>
References: <20210119155953.803818-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This builds up on the existing socket cookie test which checks whether
the bpf_get_socket_cookie helpers provide the same value in
cgroup/connect6 and sockops programs for a socket created by the
userspace part of the test.

Adding a tracing program to the existing objects requires a different
attachment strategy and different headers.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 .../selftests/bpf/prog_tests/socket_cookie.c  | 24 +++++++----
 .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
index 53d0c44e7907..e5c5e2ea1deb 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
@@ -15,8 +15,8 @@ struct socket_cookie {
 
 void test_socket_cookie(void)
 {
+	struct bpf_link *set_link, *update_sockops_link, *update_tracing_link;
 	socklen_t addr_len = sizeof(struct sockaddr_in6);
-	struct bpf_link *set_link, *update_link;
 	int server_fd, client_fd, cgroup_fd;
 	struct socket_cookie_prog *skel;
 	__u32 cookie_expected_value;
@@ -39,15 +39,21 @@ void test_socket_cookie(void)
 		  PTR_ERR(set_link)))
 		goto close_cgroup_fd;
 
-	update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
-						 cgroup_fd);
-	if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
-		  PTR_ERR(update_link)))
+	update_sockops_link = bpf_program__attach_cgroup(
+		skel->progs.update_cookie_sockops, cgroup_fd);
+	if (CHECK(IS_ERR(update_sockops_link), "update-sockops-link-cg-attach",
+		  "err %ld\n", PTR_ERR(update_sockops_link)))
 		goto free_set_link;
 
+	update_tracing_link = bpf_program__attach(
+		skel->progs.update_cookie_tracing);
+	if (CHECK(IS_ERR(update_tracing_link), "update-tracing-link-attach",
+		  "err %ld\n", PTR_ERR(update_tracing_link)))
+		goto free_update_sockops_link;
+
 	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
 	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
-		goto free_update_link;
+		goto free_update_tracing_link;
 
 	client_fd = connect_to_fd(server_fd, 0);
 	if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
@@ -71,8 +77,10 @@ void test_socket_cookie(void)
 	close(client_fd);
 close_server_fd:
 	close(server_fd);
-free_update_link:
-	bpf_link__destroy(update_link);
+free_update_tracing_link:
+	bpf_link__destroy(update_tracing_link);
+free_update_sockops_link:
+	bpf_link__destroy(update_sockops_link);
 free_set_link:
 	bpf_link__destroy(set_link);
 close_cgroup_fd:
diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
index 81e84be6f86d..1f770b732cb1 100644
--- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
 
-#include <linux/bpf.h>
-#include <sys/socket.h>
+#include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+#define AF_INET6 10
 
 struct socket_cookie {
 	__u64 cookie_key;
@@ -19,6 +21,14 @@ struct {
 	__type(value, struct socket_cookie);
 } socket_cookies SEC(".maps");
 
+/*
+ * These three programs get executed in a row on connect() syscalls. The
+ * userspace side of the test creates a client socket, issues a connect() on it
+ * and then checks that the local storage associated with this socket has:
+ * cookie_value == local_port << 8 | 0xFF
+ * The different parts of this cookie_value are appended by those hooks if they
+ * all agree on the output of bpf_get_socket_cookie().
+ */
 SEC("cgroup/connect6")
 int set_cookie(struct bpf_sock_addr *ctx)
 {
@@ -32,14 +42,14 @@ int set_cookie(struct bpf_sock_addr *ctx)
 	if (!p)
 		return 1;
 
-	p->cookie_value = 0xFF;
+	p->cookie_value = 0xF;
 	p->cookie_key = bpf_get_socket_cookie(ctx);
 
 	return 1;
 }
 
 SEC("sockops")
-int update_cookie(struct bpf_sock_ops *ctx)
+int update_cookie_sockops(struct bpf_sock_ops *ctx)
 {
 	struct bpf_sock *sk;
 	struct socket_cookie *p;
@@ -60,9 +70,30 @@ int update_cookie(struct bpf_sock_ops *ctx)
 	if (p->cookie_key != bpf_get_socket_cookie(ctx))
 		return 1;
 
-	p->cookie_value = (ctx->local_port << 8) | p->cookie_value;
+	p->cookie_value |= (ctx->local_port << 8);
 
 	return 1;
 }
 
+SEC("fexit/inet_stream_connect")
+int BPF_PROG(update_cookie_tracing, struct socket *sock,
+	     struct sockaddr *uaddr, int addr_len, int flags)
+{
+	struct socket_cookie *p;
+
+	if (uaddr->sa_family != AF_INET6)
+		return 0;
+
+	p = bpf_sk_storage_get(&socket_cookies, sock->sk, 0, 0);
+	if (!p)
+		return 0;
+
+	if (p->cookie_key != bpf_get_socket_cookie(sock->sk))
+		return 0;
+
+	p->cookie_value |= 0xF0;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.30.0.284.gd98b1dd5eaa7-goog

