Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197642B72F7
	for <lists+bpf@lfdr.de>; Wed, 18 Nov 2020 01:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKRARv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 19:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgKRARv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 19:17:51 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF10C0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 16:17:50 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id g12so241218qtc.15
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 16:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VzXoBRfshr313+9gIneP9I2MWmf6E3h+V7ZM0j63Np0=;
        b=pp3tDofiOM9GL46Apy3UaPGl248BmZDI7ijzGVyvw5nkYS7aguny0+PxDHamNv8U7a
         0EchfihtL8EOuS1UonEE4MeeqJoIxMDjcRAK3DDKTMdKjzKnOc9nNJbyGsGGegvKI3b1
         XE44XFvHn8awyeMaujMoLq1Hz/k6u1ZIwaqVGWgFlx7FFYtmOtNdawoq4OBoDYI1R5Dk
         XdtkOmboSoU/a3YtHrXik8URGPpJwPQ0o2XhXxk3HW4E/i6zb9R3EjSdldh2dtXCW4Jj
         gN20jcLyEXJdAfDxHlboIs7GzG0w0fblu8bCM8H/6kcahYEsxCxzm3gX9OD/3NzHAhXE
         mr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VzXoBRfshr313+9gIneP9I2MWmf6E3h+V7ZM0j63Np0=;
        b=Tc9bwZJxo33RHddIQwaz+xkbNCcWiDTiWbIDMVyaj6q8x5Wq4dXiihEMvgD/t9ZiBk
         jEgNAWZDh4gYFfY0WwWgFgb3i8Rj+qlWI1fwaEqGzMY4ZT/SsKYB/bfoND74VpO4hktM
         Lh+NyBB8n+fe2YWTYsy14Bdt4JH83H4GrDT6SmYd0xVhVLTiHYlFZZ743Esg+HdImNgO
         lTeNNfKBinrJUFA8gu4QCPemmBNv337wnALrkUTYgq8hRBViOvmh1brdlxDABGab16LP
         6jY+FQqJyRRHHTmciG+MxpDfbf+NUoQ56tAWMrrqbgJgMX0HJRdKnx/9ja9Z6xrG1/C4
         QOGA==
X-Gm-Message-State: AOAM531YUWpPR/YHF4aJ/AsURzWZ5Lny6o7rBblA8t8N4D8jvHaooaEZ
        QgoodcAukPNXMAMRet1twuJR6ek=
X-Google-Smtp-Source: ABdhPJw7QIa+i4andL8Xb7qok1LSXeMYuSu2YwrqgDvdSXVdanFMn+OcC63kJTrWSAMay522DjmapqQ=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:12ed:: with SMTP id
 w13mr2276765qvv.23.1605658669986; Tue, 17 Nov 2020 16:17:49 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:17:42 -0800
In-Reply-To: <20201118001742.85005-1-sdf@google.com>
Message-Id: <20201118001742.85005-4-sdf@google.com>
Mime-Version: 1.0
References: <20201118001742.85005-1-sdf@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH bpf-next 3/3] selftests/bpf: extend bind{4,6} programs with a
 call to bpf_setsockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To make sure it doesn't trigger sock_owned_by_me splat.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../testing/selftests/bpf/progs/bind4_prog.c  | 31 +++++++++++++++++++
 .../testing/selftests/bpf/progs/bind6_prog.c  | 31 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index ff3def2ee6f9..9d1d8d642edc 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -19,8 +19,35 @@
 #define SERV4_REWRITE_IP	0x7f000001U /* 127.0.0.1 */
 #define SERV4_REWRITE_PORT	4444
 
+#ifndef IFNAMSIZ
+#define IFNAMSIZ 16
+#endif
+
 int _version SEC("version") = 1;
 
+static __inline int bind_to_device(struct bpf_sock_addr *ctx)
+{
+	char veth1[IFNAMSIZ] = "test_sock_addr1";
+	char veth2[IFNAMSIZ] = "test_sock_addr2";
+	char missing[IFNAMSIZ] = "nonexistent_dev";
+	char del_bind[IFNAMSIZ] = "";
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&veth1, sizeof(veth1)))
+		return 1;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&veth2, sizeof(veth2)))
+		return 1;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&missing, sizeof(missing)) != -ENODEV)
+		return 1;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&del_bind, sizeof(del_bind)))
+		return 1;
+
+	return 0;
+}
+
 SEC("cgroup/bind4")
 int bind_v4_prog(struct bpf_sock_addr *ctx)
 {
@@ -64,6 +91,10 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
 	if (ctx->user_ip4 != user_ip4)
 		return 0;
 
+	/* Bind to device and unbind it. */
+	if (bind_to_device(ctx))
+		return 0;
+
 	ctx->user_ip4 = bpf_htonl(SERV4_REWRITE_IP);
 	ctx->user_port = bpf_htons(SERV4_REWRITE_PORT);
 
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index 97686baaae65..a443927dae53 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -25,8 +25,35 @@
 #define SERV6_REWRITE_IP_3	0x00000001
 #define SERV6_REWRITE_PORT	6666
 
+#ifndef IFNAMSIZ
+#define IFNAMSIZ 16
+#endif
+
 int _version SEC("version") = 1;
 
+static __inline int bind_to_device(struct bpf_sock_addr *ctx)
+{
+	char veth1[IFNAMSIZ] = "test_sock_addr1";
+	char veth2[IFNAMSIZ] = "test_sock_addr2";
+	char missing[IFNAMSIZ] = "nonexistent_dev";
+	char del_bind[IFNAMSIZ] = "";
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&veth1, sizeof(veth1)))
+		return 1;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&veth2, sizeof(veth2)))
+		return 1;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&missing, sizeof(missing)) != -ENODEV)
+		return 1;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_BINDTODEVICE,
+				&del_bind, sizeof(del_bind)))
+		return 1;
+
+	return 0;
+}
+
 SEC("cgroup/bind6")
 int bind_v6_prog(struct bpf_sock_addr *ctx)
 {
@@ -78,6 +105,10 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
 			return 0;
 	}
 
+	/* Bind to device and unbind it. */
+	if (bind_to_device(ctx))
+		return 0;
+
 	ctx->user_ip6[0] = bpf_htonl(SERV6_REWRITE_IP_0);
 	ctx->user_ip6[1] = bpf_htonl(SERV6_REWRITE_IP_1);
 	ctx->user_ip6[2] = bpf_htonl(SERV6_REWRITE_IP_2);
-- 
2.29.2.299.gdc1121823c-goog

