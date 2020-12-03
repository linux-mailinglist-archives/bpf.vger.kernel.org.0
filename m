Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E232CE0CF
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLCVfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgLCVfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 16:35:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA82C061A55
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 13:33:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so3375858wrn.1
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnaHuQwLv5J2e530Io2NN9WaHguCzooJl32xWS8vIoQ=;
        b=mFM7qWW98WrweOYKU/AMSCKc+6ye+7IoMEv8pvEEMqvqwSuzCHb2qV2Iyuoa8Om6TR
         r0LjEhi/ikG+54Bnxu2QMUxhiJCHst0HTlB1OLJJ9MmVRlCYoBKUAnhEbs1fo7ojWDGs
         CHWZrkwqjh7e9lPPwBYdeiGLziKI3GTUNWbFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnaHuQwLv5J2e530Io2NN9WaHguCzooJl32xWS8vIoQ=;
        b=ZqyhlkkjSmZmOmkuDX4nCu0bTmTPZ9eoRRZPPYZSKPTdB4IgRh5o05q/dnW0RLDVb9
         DrFA5hGmgUky7V2QSWTuMLAE1d/66wBKykJeEVGXGuTLozNfq2sJPGk9X76gs5X7JSvT
         uquDp5NNfOf1EP8pOB9BiCCoAbWZls8KIlI7FiPQHXsI2TxJhuwRvQwDFexIYw5uO0Uz
         2E7KRieCIUh5bVMPulFjkUuPPdxp4geyvqcXOzScmyg1iVCL7o4DuXKkncyl0hBo9Q2E
         xoNtEWbRhunbyXM5cg8+AWGynpk35ZYBPyij6wgO9lAdAQ/bSv622vcuSrze6Wc5tVAd
         PViw==
X-Gm-Message-State: AOAM532nLXln4h6SUG/Wc2S9HOnfK/DfkwS+whvnCf5UqsYdDibt5Nqu
        u+Zn00XZPM36qzVOXP6TOSuXZbm0k6JOwg==
X-Google-Smtp-Source: ABdhPJzdbq5v+PbGH2lQ/GGqD30fvo+U+LeQ5CGKKbcNzW6BIvvgipoXkGUJ4jN3I+4uQwy0s9q8ZQ==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr1337572wro.58.1607031224483;
        Thu, 03 Dec 2020 13:33:44 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id h83sm754013wmf.9.2020.12.03.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:33:43 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] bpf: Add a selftest for the tracing bpf_get_socket_cookie
Date:   Thu,  3 Dec 2020 22:33:30 +0100
Message-Id: <20201203213330.1657666-3-revest@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203213330.1657666-1-revest@google.com>
References: <20201203213330.1657666-1-revest@google.com>
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

Signed-off-by: Florent Revest <revest@google.com>
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

