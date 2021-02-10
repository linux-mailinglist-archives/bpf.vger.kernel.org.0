Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1796E3164FB
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBJLST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 06:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhBJLQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 06:16:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685DC0611C0
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:14:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m13so1974080wro.12
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 03:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sz6D6ERg6o5rQEjkN1863Afv5YNdZlEinqDFPvm/M+g=;
        b=Op0ecYS+MiCa7Wwvp8vwywu3BgXqJtbmCm4BRL5wZRtw589sPnZqJ6D6WeqvVkW5rH
         U/9dUnFZN0FMXVBsGuFY8rzVC6Zc7Lk2sVxB2FT21ZoZj+58AsLRHEFmm6cGWiVfaIsC
         g0YA3IgAZb5/w8QjXgTfgU9FbF51d6cqzAAUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sz6D6ERg6o5rQEjkN1863Afv5YNdZlEinqDFPvm/M+g=;
        b=s8NB4QzHsnZv17n60JFr/ZjmbtpLRSWpvEpJG8bLlK2fzMPcmfKmurgqyV5CFFsnsy
         MMbhAekP6Z0r2sup8gu5Oqp54EPVNdD5b4lOWo1CA2+dsD6dxPAk0/6ieinH2FHSn7Nm
         cM3q45nUgCzhPUQF9aM7zm/CmQOyflr3MZTweQB0j0mel2qoumkycUjJ1rqKX79s4m0s
         XfY5i9FALk+bspDP4kO0dz/Bsls4CtfBrpiTf8SAPDkLtzyeWjm09Nf63+jyxNR3R3Ry
         LZvjfdVpWy9X2+8lPqgGNI/939FSbZC+YjUdLH4S/ZWHuT6eX2n9bB6SzrU6D8/ZRXIr
         D+Bg==
X-Gm-Message-State: AOAM532dTK8plBAbMs8ntZfvACjjxD/vgLXNvyoR3renbHv0+OOsdE2P
        pxPimkdi+TTVLGlQT5yIRGadnQ9vS+WnFQ==
X-Google-Smtp-Source: ABdhPJxcm37s0uK94oOaTP7MzUMGWn1tPUXWrFZq3ATsdxayZIuFYJKkx/DJPcHbR69mum4yqgyJsw==
X-Received: by 2002:adf:f003:: with SMTP id j3mr3103159wro.335.1612955678061;
        Wed, 10 Feb 2021 03:14:38 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:31ae:b3c8:8fe:5f4d])
        by smtp.gmail.com with ESMTPSA id u10sm1907633wmj.40.2021.02.10.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:14:37 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v7 5/5] selftests/bpf: Add a selftest for the tracing bpf_get_socket_cookie
Date:   Wed, 10 Feb 2021 12:14:06 +0100
Message-Id: <20210210111406.785541-5-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210111406.785541-1-revest@chromium.org>
References: <20210210111406.785541-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This builds up on the existing socket cookie test which checks whether
the bpf_get_socket_cookie helpers provide the same value in
cgroup/connect6 and sockops programs for a socket created by the
userspace part of the test.

Instead of having an update_cookie sockops program tag a socket local
storage with 0xFF, this uses both an update_cookie_sockops program and
an update_cookie_tracing program which succesively tag the socket with
0x0F and then 0xF0.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: KP Singh <kpsingh@kernel.org>
---
 .../selftests/bpf/prog_tests/socket_cookie.c  | 11 ++++--
 .../selftests/bpf/progs/socket_cookie_prog.c  | 36 +++++++++++++++++--
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
index e12a31d3752c..232db28dde18 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/socket_cookie.c
@@ -35,9 +35,14 @@ void test_socket_cookie(void)
 	if (!ASSERT_OK_PTR(skel->links.set_cookie, "prog_attach"))
 		goto close_cgroup_fd;
 
-	skel->links.update_cookie = bpf_program__attach_cgroup(
-		skel->progs.update_cookie, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.update_cookie, "prog_attach"))
+	skel->links.update_cookie_sockops = bpf_program__attach_cgroup(
+		skel->progs.update_cookie_sockops, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.update_cookie_sockops, "prog_attach"))
+		goto close_cgroup_fd;
+
+	skel->links.update_cookie_tracing = bpf_program__attach(
+		skel->progs.update_cookie_tracing);
+	if (!ASSERT_OK_PTR(skel->links.update_cookie_tracing, "prog_attach"))
 		goto close_cgroup_fd;
 
 	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
index fbd5eaf39720..35630a5aaf5f 100644
--- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
@@ -5,6 +5,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
 
 #define AF_INET6 10
 
@@ -20,6 +21,14 @@ struct {
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
@@ -33,14 +42,14 @@ int set_cookie(struct bpf_sock_addr *ctx)
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
 	struct bpf_sock *sk = ctx->sk;
 	struct socket_cookie *p;
@@ -61,9 +70,30 @@ int update_cookie(struct bpf_sock_ops *ctx)
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
2.30.0.478.g8a0d178c01-goog

