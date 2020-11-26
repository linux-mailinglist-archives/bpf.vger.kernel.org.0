Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C492C59FE
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 18:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404274AbgKZRCY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 12:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403803AbgKZRCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 12:02:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDD1C0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 09:02:17 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so2847926wrw.10
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 09:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyZHVQfg5UasRnRBi3W8BI7EDbmbn+6eB9vLQ5Pp2HY=;
        b=fA0RiKXkxKUleTSpu9sFswF9isRUHKBVQcc0iFHjQytBucWWbVkKm99wSwmhMaR/Mp
         xbSzn8VCCNM0WPBgYSBY66IDgYKSeffh0eL8hG6F7EL+nVdJYqL6LPKbkee27QJjNF4I
         skam84Z6jUkO8ERvzzxbt85mvwAGwZkudWBcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyZHVQfg5UasRnRBi3W8BI7EDbmbn+6eB9vLQ5Pp2HY=;
        b=Xh9Vw+jziLXo3vd/4oV+VjQwDxZF+pQvdFHSbGH+91c188rE17oYJvNZJTzh1C3mwk
         RXfPb4DZWxtC9QaPtNZm40ayA/60xzKeNmPEz/JTAQTQUPvIbdBobE90UqFFc72lyVZf
         AgnK988qBHyk0BskXFRHEjeeq6Lzqpqb8tChh7DSGkosspl0/weg1oKo1PF6ma3+CUfE
         kgP0/SSACAnscALNfrD/gjqCakX8b/lvxpSIxXXOhzYxwStrrtr2RwP5rjV49z1QgNDN
         6WXiKrMb6o9clyBYdi83L+06qdnFWgV/QuzlpQ/y7Nf8UlHfFVTzsjU27fz/X2OWYlfN
         U0Rw==
X-Gm-Message-State: AOAM530DSjD9EFx5guyw7VYiuzZsIh+gonR2963BT4QJyLyD3NtXc47/
        R1ljonBKV/HUUw4Exxq+d/Qh2vw/YIZ6swsX
X-Google-Smtp-Source: ABdhPJy0yhbmTT4EP0QCtY4CaJGWo9teCucIPZrWJdlHYhJ2EnwPpFySLQRhraU7zDnUBdbWuOmGRA==
X-Received: by 2002:adf:de12:: with SMTP id b18mr5008582wrm.187.1606410136330;
        Thu, 26 Nov 2020 09:02:16 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d17sm9373192wro.62.2020.11.26.09.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:02:15 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf: Add a selftest for the tracing bpf_get_socket_cookie
Date:   Thu, 26 Nov 2020 18:02:12 +0100
Message-Id: <20201126170212.1749137-2-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126170212.1749137-1-revest@google.com>
References: <20201126170212.1749137-1-revest@google.com>
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
 .../selftests/bpf/progs/socket_cookie_prog.c  | 41 ++++++++++++++++---
 .../selftests/bpf/test_socket_cookie.c        | 18 +++++---
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
index 0cb5656a22b0..a11026aeaaf1 100644
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
@@ -60,11 +70,32 @@ int update_cookie(struct bpf_sock_ops *ctx)
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
 int _version SEC("version") = 1;
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_socket_cookie.c b/tools/testing/selftests/bpf/test_socket_cookie.c
index ca7ca87e91aa..0d955c65a4f8 100644
--- a/tools/testing/selftests/bpf/test_socket_cookie.c
+++ b/tools/testing/selftests/bpf/test_socket_cookie.c
@@ -133,6 +133,7 @@ static int run_test(int cgfd)
 	struct bpf_prog_load_attr attr;
 	struct bpf_program *prog;
 	struct bpf_object *pobj;
+	struct bpf_link *link;
 	const char *prog_name;
 	int server_fd = -1;
 	int client_fd = -1;
@@ -153,11 +154,18 @@ static int run_test(int cgfd)
 	bpf_object__for_each_program(prog, pobj) {
 		prog_name = bpf_program__section_name(prog);
 
-		if (libbpf_attach_type_by_name(prog_name, &attach_type))
-			goto err;
-
-		err = bpf_prog_attach(bpf_program__fd(prog), cgfd, attach_type,
-				      BPF_F_ALLOW_OVERRIDE);
+		if (bpf_program__is_tracing(prog)) {
+			link = bpf_program__attach(prog);
+			err = !link;
+			continue;
+		} else {
+			if (libbpf_attach_type_by_name(prog_name, &attach_type))
+				goto err;
+
+			err = bpf_prog_attach(bpf_program__fd(prog), cgfd,
+					      attach_type,
+					      BPF_F_ALLOW_OVERRIDE);
+		}
 		if (err) {
 			log_err("Failed to attach prog %s", prog_name);
 			goto out;
-- 
2.29.2.454.gaff20da3a2-goog

