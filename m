Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBDD304CB8
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbhAZWyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391715AbhAZSkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 13:40:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F27BC0612F2
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u14so3617763wmq.4
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9Q3vBsrN4kSRC0Phs6WIgTXwFPhSM5DGk+qTSLm7PY=;
        b=NeH84JFEVFXF7+GiXIMX/GCjnXob/Fgu7anF1tbUOKRRdPctL4+UBJiGk93YePZ4D2
         +xk2jPJejxelnillK/8mal5C9+3OUh1NdFeOM4RD/PMsZw5iA4YdoA/P/kQRL4BeZRE3
         oH+1GgbUpQJzJ6kDlGmO76xASFnG0b74rowUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9Q3vBsrN4kSRC0Phs6WIgTXwFPhSM5DGk+qTSLm7PY=;
        b=TyWEtCJCAu78UQEtiKZXXhjKdcoVDcW3IcFaW53Oi/coA1N5u4hEZERte6Xi1nnae0
         s4ROu+gGmlfyiVc/N5BtpwueYIiI9UkiR9r5eZppCGB/MkaDX6DNM49D+6xMcB/qtLdB
         P+8Y9+24vvsUKdW/syuM4yI7a5MQTz40rqWj4eWVm0D7UonzMtFwocXS/ZY2HdNhLoHW
         5TlF7irNI9wLBcYnrGtO0z5BXvmkipXKnRfQwFuzY8JWfUMZB13/uDry4cLVotb67XGq
         1/X8nWO73Xff0AqFL7GdmtUIPKGrEDsK0qe4iCxpNse1BAEw32O4evtlSJcniR7O7muQ
         0ZcQ==
X-Gm-Message-State: AOAM530BXzeAsXRZtuPW3Z8k1gyxjKGlO/DUW1sQXZBMMyaa+ndS20DO
        6JBBDoZIfQNtT6DJ55wq4YbM1nZagN87RQ==
X-Google-Smtp-Source: ABdhPJzuyBaTzPU2THhjJ2muYoIcYHGKc1ehgO9P+soid8ZmX4BCIFLeUJg8EMy/1oaAJab58Km+rg==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr920406wmq.142.1611686170661;
        Tue, 26 Jan 2021 10:36:10 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:deb:d0ec:3143:2380])
        by smtp.gmail.com with ESMTPSA id d13sm28339354wrx.93.2021.01.26.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:36:10 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Add a selftest for the tracing bpf_get_socket_cookie
Date:   Tue, 26 Jan 2021 19:35:59 +0100
Message-Id: <20210126183559.1302406-5-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126183559.1302406-1-revest@chromium.org>
References: <20210126183559.1302406-1-revest@chromium.org>
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
2.30.0.280.ga3ce27912f-goog

