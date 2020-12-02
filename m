Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98212CC3A2
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 18:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgLBR0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 12:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgLBR0j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 12:26:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A640C061A47
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 09:25:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j138so2625530ybg.20
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MTbHV8okuT5HRxc+/IJXXaeKBpFbDCXy11Dtl4K4Ls4=;
        b=SwXDX0KN7/GqSAMgFaISJwTrUBOk9lmWHh+pC5H845NsHx8IrBOoEBOVamVhQQx13m
         A1vfsUZ1OFXZSTbfrYMkTEkqnqyaEvDxO8sf79nmauGhbMp1iZr+oFv2L9+fhFVb2a1t
         /icHxJWhIwAyWAyb3x3/zXqUN2qK3b//2ZbqCSYqR2h0+ynBFVT82AqyMKySNzx2t40m
         qdg/Xi4635igRAeX8t3QYF4+SZg1xzcIqi8vCd15H8yQtCBefsuSwXLcyAhWrASEo64S
         UJ3rUdtxHgQ/T8A/n5kHQq72toJ05ZUoqvZQTUajbc59HqmXlwLqu55YGh0ol3qjI/h8
         Xg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MTbHV8okuT5HRxc+/IJXXaeKBpFbDCXy11Dtl4K4Ls4=;
        b=K49wYd1n1AKdvh1e+9IPy/6Q+YgBieFD1aBiwMVpNiQXK75gpLi8RJFXN1NNc0+xRA
         pdBascZlwZTxD1MNkntDKilwP21axe/ccj7cYYZuFywRnw4y/MQecc8tAuFdzBJ9BhB6
         kzHZzBWJDWBWMOlsCToLId6r9CejFkkwu28Hsov0XW6PbztHXQ++Qpoj0fpkJg/3ha9B
         yVPCo6uk/HZ3SfxtoYGyzCAAxXNzKy8FXHmeODgBNiQXnThKGVTMQp2MbPKFtRjTFqol
         RemkqdbKmrLRKHZWVdL5U5qtm4oQcJdb1C+96b1ForB0XfbFznplzqbwRlueHT4L1AQx
         Pjig==
X-Gm-Message-State: AOAM531qumPhTibRzoG/F5F4CGWEu3bIWGDye5w0WZ/OfxZoYh8bDPf+
        E+Nksbi1GVBkoc5ww3xeYdUHim4=
X-Google-Smtp-Source: ABdhPJxc2B0xOWx8MTM4tUP5N21tpbE8SOAfIsI2xJHkx43PQg1uFY1g2L8SHtTPJSorc4RZSJdPyMQ=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:748a:: with SMTP id p132mr4446339ybc.430.1606929924404;
 Wed, 02 Dec 2020 09:25:24 -0800 (PST)
Date:   Wed,  2 Dec 2020 09:25:16 -0800
In-Reply-To: <20201202172516.3483656-1-sdf@google.com>
Message-Id: <20201202172516.3483656-4-sdf@google.com>
Mime-Version: 1.0
References: <20201202172516.3483656-1-sdf@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next 3/3] selftests/bpf: extend bind{4,6} programs with a
 call to bpf_setsockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To make sure it doesn't trigger sock_owned_by_me splat.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/progs/bind4_prog.c  | 31 +++++++++++++++++++
 .../testing/selftests/bpf/progs/bind6_prog.c  | 31 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index 0951302a984a..c6520f21f5f5 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -19,6 +19,33 @@
 #define SERV4_REWRITE_IP	0x7f000001U /* 127.0.0.1 */
 #define SERV4_REWRITE_PORT	4444
 
+#ifndef IFNAMSIZ
+#define IFNAMSIZ 16
+#endif
+
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
@@ -62,6 +89,10 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
 	if (ctx->user_ip4 != user_ip4)
 		return 0;
 
+	/* Bind to device and unbind it. */
+	if (bind_to_device(ctx))
+		return 0;
+
 	ctx->user_ip4 = bpf_htonl(SERV4_REWRITE_IP);
 	ctx->user_port = bpf_htons(SERV4_REWRITE_PORT);
 
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index 16da1cf85418..4358e44dcf47 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -25,6 +25,33 @@
 #define SERV6_REWRITE_IP_3	0x00000001
 #define SERV6_REWRITE_PORT	6666
 
+#ifndef IFNAMSIZ
+#define IFNAMSIZ 16
+#endif
+
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
@@ -76,6 +103,10 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
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
2.29.2.454.gaff20da3a2-goog

