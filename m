Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80E2D433B
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgLIN2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 08:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgLIN2B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 08:28:01 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD1C0617B0
        for <bpf@vger.kernel.org>; Wed,  9 Dec 2020 05:26:43 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so1753599wrt.2
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9mDZF7etgTn6tPi+wLjx4mpeEvfX0cxhDjOxW77JZw=;
        b=UiQzniNMGcPQKLgMJ0EzSi2Kxaf6qlPnE0Z6wiBoM3oMicnTBdvuSw0E9lg/rVc5fS
         8CSHJj6Txg/LTewz8bLBQXPXghERXgK8ndh/sScGDtcUWDffh+3JJoh1b+xBlfBVig8C
         9rvjTFdpOX3JqtGYTIwNO7j21vBUFP13Oa6i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9mDZF7etgTn6tPi+wLjx4mpeEvfX0cxhDjOxW77JZw=;
        b=FSCbtglAKi7jJbGgYe2ywR1IGE4cvZ5VOWxX2DutDvA+WeqekqCov+YGQXAu14KVxD
         Huxvurtih8MK0NDZDyH2BFxRsg4FJGJ46MRikNEsxlvfAQY6YuqKtSeiFgkpL8J5Qjkp
         hYbNyIxB5tOBNTrJtYRXuwu0AL98WZH1LehL0UzEMfCqvTXMX+ftF6W/vPrS9beOHUPh
         cnJV4p6Q0e+7pXkTKglzy5zHvcwbgKZ84QFYpnKqDj6+MjHwry+XGePyIX/xRPrydLHh
         EGMA9ojzhhG39kXwoHTkJSJjKtiJq5gTJRQd09BovVhjAYuZ814vnuwL6yg/XUY5QCQJ
         rupw==
X-Gm-Message-State: AOAM532t+AMWcQEGls0aPoJSY4H0C0L71SZCnTdqXMA0GyQj06yIQ0jz
        JWseyRuCc/wL8/1FN1Tu31LjlGyndAs4kg==
X-Google-Smtp-Source: ABdhPJyJQpvCFFprTl21K/OpcEuA7dY8Og5NuNzUxF1gbNOZpbuDZNIoWdLZ8aANWO/x2NGPBJz52Q==
X-Received: by 2002:adf:d081:: with SMTP id y1mr2734830wrh.388.1607520402020;
        Wed, 09 Dec 2020 05:26:42 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id t16sm3631490wri.42.2020.12.09.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:26:41 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Add a selftest for the tracing bpf_get_socket_cookie
Date:   Wed,  9 Dec 2020 14:26:36 +0100
Message-Id: <20201209132636.1545761-4-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201209132636.1545761-1-revest@chromium.org>
References: <20201209132636.1545761-1-revest@chromium.org>
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
2.29.2.576.ga3fc446d84-goog

