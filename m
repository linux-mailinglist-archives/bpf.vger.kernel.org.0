Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6832C15F
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446748AbhCCWlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843078AbhCCKZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13634C08ED8D
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 02:18:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m1so5752843wml.2
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNT0BrgEQwgpk+nE5OFlRQqSY1z2sQW181Q6sU6WNZA=;
        b=ixUC3jyIW/7jGGl3J4G8VD2srJpSOgycHcCHRQXQCnN4c0HrMeL/ONP3BNW0eb/Ykm
         ovZNP72aXnkJF+5DCgJKUcriI827Zq8TiBufzNMYPBmcdmqXPTLybjQ2Wwy33mrGbzB8
         R7FKPhVjSxrlbkRKeQGhogxSIYI9RJ+cvqXA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNT0BrgEQwgpk+nE5OFlRQqSY1z2sQW181Q6sU6WNZA=;
        b=UYwywS0+8N1KmBd0XhF3Bl/hgrFh8iV4TwOQBhsqt9GnuFukUFMPXoZuCYwk1qi3c7
         oiWspoaLOlHtTWrgIR4uyt6YV8IwWbZESqQ5TU0du9Hm+YZVe6PaNF943a+Oq1SCCojC
         diOmE7u5CgMVePiW+fNWuQMRBCfdZPB569muy08mxyCZycIlfPCRbRLr0qPUAhX2sY8D
         dJSRUyGnVRr3l0rO5ZjbTMHNPahgs+dS2kua9feiA2sMZcEvDLubwVrl3er/tUIqOIR8
         x3c2LVNdYxw9lQOhRYe3NeiKi3rrmCYn2UihP7qbzho4crh0RN1SaAQ4xmz/QvUhZbVt
         HcaA==
X-Gm-Message-State: AOAM532ux6qWjfRa5RgHewp4lOhgfDFcYz0QjdBM3LAhC0eLOoZNfhbv
        Ubydtn6VJ1UAsfuyv41tVnSBFA==
X-Google-Smtp-Source: ABdhPJznNnlojn2yrNdW2FsXWhPQyyrotZBvrDr5ra02Joi9tr+M0IYdi/gunzUVhYujS/mewsXwvA==
X-Received: by 2002:a05:600c:614:: with SMTP id o20mr8123662wmm.66.1614766708795;
        Wed, 03 Mar 2021 02:18:28 -0800 (PST)
Received: from localhost.localdomain (c.a.8.8.c.1.2.8.8.7.0.2.6.c.a.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1ac6:2078:821c:88ac])
        by smtp.gmail.com with ESMTPSA id r26sm1710761wmn.28.2021.03.03.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:18:28 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 3/5] selftests: bpf: convert sk_lookup ctx access tests to PROG_TEST_RUN
Date:   Wed,  3 Mar 2021 10:18:14 +0000
Message-Id: <20210303101816.36774-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303101816.36774-1-lmb@cloudflare.com>
References: <20210303101816.36774-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert the selftests for sk_lookup narrow context access to use
PROG_TEST_RUN instead of creating actual sockets. This ensures that
ctx is populated correctly when using PROG_TEST_RUN.

Assert concrete values since we now control remote_ip and remote_port.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 83 +++++++++++++++----
 .../selftests/bpf/progs/test_sk_lookup.c      | 62 +++++++++-----
 2 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 9ff0412e1fd3..45c82db3c58c 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -241,6 +241,48 @@ static int make_client(int sotype, const char *ip, int port)
 	return -1;
 }
 
+static __u64 socket_cookie(int fd)
+{
+	__u64 cookie;
+	socklen_t cookie_len = sizeof(cookie);
+
+	if (CHECK(getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie, &cookie_len) < 0,
+		  "getsockopt(SO_COOKIE)", "%s\n", strerror(errno)))
+		return 0;
+	return cookie;
+}
+
+static int fill_sk_lookup_ctx(struct bpf_sk_lookup *ctx, const char *local_ip, __u16 local_port,
+			      const char *remote_ip, __u16 remote_port)
+{
+	void *local, *remote;
+	int err;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->local_port = local_port;
+	ctx->remote_port = htons(remote_port);
+
+	if (is_ipv6(local_ip)) {
+		ctx->family = AF_INET6;
+		local = &ctx->local_ip6[0];
+		remote = &ctx->remote_ip6[0];
+	} else {
+		ctx->family = AF_INET;
+		local = &ctx->local_ip4;
+		remote = &ctx->remote_ip4;
+	}
+
+	err = inet_pton(ctx->family, local_ip, local);
+	if (CHECK(err != 1, "inet_pton", "local_ip failed\n"))
+		return 1;
+
+	err = inet_pton(ctx->family, remote_ip, remote);
+	if (CHECK(err != 1, "inet_pton", "remote_ip failed\n"))
+		return 1;
+
+	return 0;
+}
+
 static int send_byte(int fd)
 {
 	ssize_t n;
@@ -1009,18 +1051,27 @@ static void test_drop_on_reuseport(struct test_sk_lookup *skel)
 
 static void run_sk_assign(struct test_sk_lookup *skel,
 			  struct bpf_program *lookup_prog,
-			  const char *listen_ip, const char *connect_ip)
+			  const char *remote_ip, const char *local_ip)
 {
-	int client_fd, peer_fd, server_fds[MAX_SERVERS] = { -1 };
-	struct bpf_link *lookup_link;
+	int server_fds[MAX_SERVERS] = { -1 };
+	struct bpf_sk_lookup ctx;
+	__u64 server_cookie;
 	int i, err;
 
-	lookup_link = attach_lookup_prog(lookup_prog);
-	if (!lookup_link)
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &ctx,
+		.ctx_size_in = sizeof(ctx),
+		.ctx_out = &ctx,
+		.ctx_size_out = sizeof(ctx),
+	);
+
+	if (fill_sk_lookup_ctx(&ctx, local_ip, EXT_PORT, remote_ip, INT_PORT))
 		return;
 
+	ctx.protocol = IPPROTO_TCP;
+
 	for (i = 0; i < ARRAY_SIZE(server_fds); i++) {
-		server_fds[i] = make_server(SOCK_STREAM, listen_ip, 0, NULL);
+		server_fds[i] = make_server(SOCK_STREAM, local_ip, 0, NULL);
 		if (server_fds[i] < 0)
 			goto close_servers;
 
@@ -1030,23 +1081,25 @@ static void run_sk_assign(struct test_sk_lookup *skel,
 			goto close_servers;
 	}
 
-	client_fd = make_client(SOCK_STREAM, connect_ip, EXT_PORT);
-	if (client_fd < 0)
+	server_cookie = socket_cookie(server_fds[SERVER_B]);
+	if (!server_cookie)
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(lookup_prog), &opts);
+	if (CHECK(err, "test_run", "failed with error %d\n", errno))
+		goto close_servers;
+
+	if (CHECK(ctx.cookie == 0, "ctx.cookie", "no socket selected\n"))
 		goto close_servers;
 
-	peer_fd = accept(server_fds[SERVER_B], NULL, NULL);
-	if (CHECK(peer_fd < 0, "accept", "failed\n"))
-		goto close_client;
+	CHECK(ctx.cookie != server_cookie, "ctx.cookie",
+	      "selected sk %llu instead of %llu\n", ctx.cookie, server_cookie);
 
-	close(peer_fd);
-close_client:
-	close(client_fd);
 close_servers:
 	for (i = 0; i < ARRAY_SIZE(server_fds); i++) {
 		if (server_fds[i] != -1)
 			close(server_fds[i]);
 	}
-	bpf_link__destroy(lookup_link);
 }
 
 static void run_sk_assign_v4(struct test_sk_lookup *skel,
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index 1032b292af5b..ac6f7f205e25 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -64,6 +64,10 @@ static const int PROG_DONE = 1;
 static const __u32 KEY_SERVER_A = SERVER_A;
 static const __u32 KEY_SERVER_B = SERVER_B;
 
+static const __u16 SRC_PORT = bpf_htons(8008);
+static const __u32 SRC_IP4 = IP4(127, 0, 0, 2);
+static const __u32 SRC_IP6[] = IP6(0xfd000000, 0x0, 0x0, 0x00000002);
+
 static const __u16 DST_PORT = 7007; /* Host byte order */
 static const __u32 DST_IP4 = IP4(127, 0, 0, 1);
 static const __u32 DST_IP6[] = IP6(0xfd000000, 0x0, 0x0, 0x00000001);
@@ -398,11 +402,12 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 	if (LSW(ctx->protocol, 0) != IPPROTO_TCP)
 		return SK_DROP;
 
-	/* Narrow loads from remote_port field. Expect non-0 value. */
-	if (LSB(ctx->remote_port, 0) == 0 && LSB(ctx->remote_port, 1) == 0 &&
-	    LSB(ctx->remote_port, 2) == 0 && LSB(ctx->remote_port, 3) == 0)
+	/* Narrow loads from remote_port field. Expect SRC_PORT. */
+	if (LSB(ctx->remote_port, 0) != ((SRC_PORT >> 0) & 0xff) ||
+	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff) ||
+	    LSB(ctx->remote_port, 2) != 0 || LSB(ctx->remote_port, 3) != 0)
 		return SK_DROP;
-	if (LSW(ctx->remote_port, 0) == 0)
+	if (LSW(ctx->remote_port, 0) != SRC_PORT)
 		return SK_DROP;
 
 	/* Narrow loads from local_port field. Expect DST_PORT. */
@@ -415,11 +420,14 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 
 	/* Narrow loads from IPv4 fields */
 	if (v4) {
-		/* Expect non-0.0.0.0 in remote_ip4 */
-		if (LSB(ctx->remote_ip4, 0) == 0 && LSB(ctx->remote_ip4, 1) == 0 &&
-		    LSB(ctx->remote_ip4, 2) == 0 && LSB(ctx->remote_ip4, 3) == 0)
+		/* Expect SRC_IP4 in remote_ip4 */
+		if (LSB(ctx->remote_ip4, 0) != ((SRC_IP4 >> 0) & 0xff) ||
+		    LSB(ctx->remote_ip4, 1) != ((SRC_IP4 >> 8) & 0xff) ||
+		    LSB(ctx->remote_ip4, 2) != ((SRC_IP4 >> 16) & 0xff) ||
+		    LSB(ctx->remote_ip4, 3) != ((SRC_IP4 >> 24) & 0xff))
 			return SK_DROP;
-		if (LSW(ctx->remote_ip4, 0) == 0 && LSW(ctx->remote_ip4, 1) == 0)
+		if (LSW(ctx->remote_ip4, 0) != ((SRC_IP4 >> 0) & 0xffff) ||
+		    LSW(ctx->remote_ip4, 1) != ((SRC_IP4 >> 16) & 0xffff))
 			return SK_DROP;
 
 		/* Expect DST_IP4 in local_ip4 */
@@ -448,20 +456,32 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 
 	/* Narrow loads from IPv6 fields */
 	if (!v4) {
-		/* Expect non-:: IP in remote_ip6 */
-		if (LSB(ctx->remote_ip6[0], 0) == 0 && LSB(ctx->remote_ip6[0], 1) == 0 &&
-		    LSB(ctx->remote_ip6[0], 2) == 0 && LSB(ctx->remote_ip6[0], 3) == 0 &&
-		    LSB(ctx->remote_ip6[1], 0) == 0 && LSB(ctx->remote_ip6[1], 1) == 0 &&
-		    LSB(ctx->remote_ip6[1], 2) == 0 && LSB(ctx->remote_ip6[1], 3) == 0 &&
-		    LSB(ctx->remote_ip6[2], 0) == 0 && LSB(ctx->remote_ip6[2], 1) == 0 &&
-		    LSB(ctx->remote_ip6[2], 2) == 0 && LSB(ctx->remote_ip6[2], 3) == 0 &&
-		    LSB(ctx->remote_ip6[3], 0) == 0 && LSB(ctx->remote_ip6[3], 1) == 0 &&
-		    LSB(ctx->remote_ip6[3], 2) == 0 && LSB(ctx->remote_ip6[3], 3) == 0)
+		/* Expect SRC_IP6 in remote_ip6 */
+		if (LSB(ctx->remote_ip6[0], 0) != ((SRC_IP6[0] >> 0) & 0xff) ||
+		    LSB(ctx->remote_ip6[0], 1) != ((SRC_IP6[0] >> 8) & 0xff) ||
+		    LSB(ctx->remote_ip6[0], 2) != ((SRC_IP6[0] >> 16) & 0xff) ||
+		    LSB(ctx->remote_ip6[0], 3) != ((SRC_IP6[0] >> 24) & 0xff) ||
+		    LSB(ctx->remote_ip6[1], 0) != ((SRC_IP6[1] >> 0) & 0xff) ||
+		    LSB(ctx->remote_ip6[1], 1) != ((SRC_IP6[1] >> 8) & 0xff) ||
+		    LSB(ctx->remote_ip6[1], 2) != ((SRC_IP6[1] >> 16) & 0xff) ||
+		    LSB(ctx->remote_ip6[1], 3) != ((SRC_IP6[1] >> 24) & 0xff) ||
+		    LSB(ctx->remote_ip6[2], 0) != ((SRC_IP6[2] >> 0) & 0xff) ||
+		    LSB(ctx->remote_ip6[2], 1) != ((SRC_IP6[2] >> 8) & 0xff) ||
+		    LSB(ctx->remote_ip6[2], 2) != ((SRC_IP6[2] >> 16) & 0xff) ||
+		    LSB(ctx->remote_ip6[2], 3) != ((SRC_IP6[2] >> 24) & 0xff) ||
+		    LSB(ctx->remote_ip6[3], 0) != ((SRC_IP6[3] >> 0) & 0xff) ||
+		    LSB(ctx->remote_ip6[3], 1) != ((SRC_IP6[3] >> 8) & 0xff) ||
+		    LSB(ctx->remote_ip6[3], 2) != ((SRC_IP6[3] >> 16) & 0xff) ||
+		    LSB(ctx->remote_ip6[3], 3) != ((SRC_IP6[3] >> 24) & 0xff))
 			return SK_DROP;
-		if (LSW(ctx->remote_ip6[0], 0) == 0 && LSW(ctx->remote_ip6[0], 1) == 0 &&
-		    LSW(ctx->remote_ip6[1], 0) == 0 && LSW(ctx->remote_ip6[1], 1) == 0 &&
-		    LSW(ctx->remote_ip6[2], 0) == 0 && LSW(ctx->remote_ip6[2], 1) == 0 &&
-		    LSW(ctx->remote_ip6[3], 0) == 0 && LSW(ctx->remote_ip6[3], 1) == 0)
+		if (LSW(ctx->remote_ip6[0], 0) != ((SRC_IP6[0] >> 0) & 0xffff) ||
+		    LSW(ctx->remote_ip6[0], 1) != ((SRC_IP6[0] >> 16) & 0xffff) ||
+		    LSW(ctx->remote_ip6[1], 0) != ((SRC_IP6[1] >> 0) & 0xffff) ||
+		    LSW(ctx->remote_ip6[1], 1) != ((SRC_IP6[1] >> 16) & 0xffff) ||
+		    LSW(ctx->remote_ip6[2], 0) != ((SRC_IP6[2] >> 0) & 0xffff) ||
+		    LSW(ctx->remote_ip6[2], 1) != ((SRC_IP6[2] >> 16) & 0xffff) ||
+		    LSW(ctx->remote_ip6[3], 0) != ((SRC_IP6[3] >> 0) & 0xffff) ||
+		    LSW(ctx->remote_ip6[3], 1) != ((SRC_IP6[3] >> 16) & 0xffff))
 			return SK_DROP;
 		/* Expect DST_IP6 in local_ip6 */
 		if (LSB(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0) & 0xff) ||
-- 
2.27.0

