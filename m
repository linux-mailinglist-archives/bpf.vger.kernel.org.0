Return-Path: <bpf+bounces-28184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD78B64CD
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F156281818
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBA184105;
	Mon, 29 Apr 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEkQvVpF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C4184114
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427141; cv=none; b=BD/Y7mQ94TYERfgaUN644aV/2qrpCNG38sVMdxi3/J/hA0pQPnaLvnwvXUyoBbo7iIdPbWHoRPcVIWrkw5itas1qrnDL1LDWrKqKY3CXDeevQrH1syuP5c8Jp5Q457FyQ+0W7Vt3SsI2VJnfeg4Ym+LcbWtRR35zbPIpwmc1Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427141; c=relaxed/simple;
	bh=gH3Kew8OeVHbPt/et/Jq6DKHu1BGdkCA7/7iaJldhMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prwPmn26OOj9gMp1aWzqyyYApkIrdgSUd/1T5C00OCFJ3HYPp9JnID0hCkqzZ36LxSLOUlLfiXyxR8ilqVWuElnbGSj/VkoRhUcg/Z3IGPAR/V5uBATxtfefK83n2m7Qd6C3KkUjnnT7HUz8mnqwuWg3yaF9TykSqHeBDN2GgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEkQvVpF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso9044297276.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427139; x=1715031939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCy+fpf0yWvn0SKMsxJ2kXcAwcPbu8+bowrH/Q+MXV8=;
        b=gEkQvVpFTSnViMBoWsAxAW+FAP0q+KphJk4YEgiVOMqx+i9Jloqke8TJNTiEvXY/iy
         Y9BEtekUYxcdjwQS9WdTtIfRzzHyjENso8zT7/9g682M/IaIHufSOl8RXTzX5royFcNV
         9mzPIhBx7xrH5c8YEhRAmEB3qpHChCjjXKF7EQw8mE4KRfEDVgaUo1aHKcTVo/ISfN4M
         6AjW0GbYfXWKACgrUVIz20dFbudIrsXmlXLLOBsU1e5VV72Vqo22lElOnTv4FZTERZkC
         /Lksu4Y5WEABof99JLZtOkBLk7saLBx+Y5l7QDpDnvpDsyxHXrjY5mz05spRzTxrATpW
         XSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427139; x=1715031939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCy+fpf0yWvn0SKMsxJ2kXcAwcPbu8+bowrH/Q+MXV8=;
        b=uddIROAUfNckj/97hz5YohnNDZtFHX4x2j29PumLNGMp3+g8jO7Pf2fGiG0hRK4aLw
         wDzDcGU9DDpuYCaznuXFeG3Lbq88khGREtGmAWUuN4LUEIE2flkCUenm/VSQlULmx2RL
         N4GlT3KZxumW+ZRv6l+GYyuehmm5BgFWioTGTlAoOI8E8ylpWgFb0Jd/dKb3Wg7y0FpU
         ffftxoCJTkZYKuhUwaI7qhJtiDfRHTPgcA0P2xnl/t7Gamdpa083tJ0FEgjP4sHFjLYE
         1a+Dgdma1fT//l3GOlwaeNRGs6SYQFlAZt+YzmPbJYQnbgj/iatg4rpcGusQVZvZGLTO
         NFYA==
X-Gm-Message-State: AOJu0YznFs7y8A8I/x4Vgse0fUdG2PS+H86/4Xvq6OWfPxnYCLr0T67d
	iiOSiGuaZPFNR/4N4VL89LAu3DomFxeSy1BhzdhMlUL3dcnKf5nrABsonOjQ+/6jKB7yYVGqxaS
	HmXIn3JOob+24AtSCf1iz35KDNSk99rhtHJqfMFjuQjbXx1g9hPNsewOOSAeo6HSS18MiWACvsn
	ws4qGtu80qDg6kk8bgbO+qjqs=
X-Google-Smtp-Source: AGHT+IHoNWoNNRTxsr97FZ7/q/g/qbz5Q9ezThkgwC+EzxECZkvUoCNMvH5u9tWM17HBQabkNVhUsUZZ3Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:110c:b0:dd9:1702:4837 with SMTP id
 o12-20020a056902110c00b00dd917024837mr3741826ybu.3.1714427138565; Mon, 29 Apr
 2024 14:45:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:18 -0500
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429214529.2644801-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-2-jrife@google.com>
Subject: [PATCH v3 bpf-next 1/6] selftests/bpf: Fix bind program for big
 endian systems
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Without this fix, the bind4 and bind6 programs will reject bind attempts
on big endian systems. This patch ensures that CI tests pass for the
s390x architecture.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../testing/selftests/bpf/progs/bind4_prog.c  | 18 ++++++++++--------
 .../testing/selftests/bpf/progs/bind6_prog.c  | 18 ++++++++++--------
 tools/testing/selftests/bpf/progs/bind_prog.h | 19 +++++++++++++++++++
 3 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index a487f60b73ac4..66005c1a5b367 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -12,6 +12,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bind_prog.h"
+
 #define SERV4_IP		0xc0a801feU /* 192.168.1.254 */
 #define SERV4_PORT		4040
 #define SERV4_REWRITE_IP	0x7f000001U /* 127.0.0.1 */
@@ -118,23 +120,23 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
 
 	// u8 narrow loads:
 	user_ip4 = 0;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[0] << 0;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[1] << 8;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[2] << 16;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[3] << 24;
+	user_ip4 |= load_byte(ctx->user_ip4, 0, sizeof(user_ip4));
+	user_ip4 |= load_byte(ctx->user_ip4, 1, sizeof(user_ip4));
+	user_ip4 |= load_byte(ctx->user_ip4, 2, sizeof(user_ip4));
+	user_ip4 |= load_byte(ctx->user_ip4, 3, sizeof(user_ip4));
 	if (ctx->user_ip4 != user_ip4)
 		return 0;
 
 	user_port = 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
+	user_port |= load_byte(ctx->user_port, 0, sizeof(user_port));
+	user_port |= load_byte(ctx->user_port, 1, sizeof(user_port));
 	if (ctx->user_port != user_port)
 		return 0;
 
 	// u16 narrow loads:
 	user_ip4 = 0;
-	user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
-	user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[1] << 16;
+	user_ip4 |= load_word(ctx->user_ip4, 0, sizeof(user_ip4));
+	user_ip4 |= load_word(ctx->user_ip4, 1, sizeof(user_ip4));
 	if (ctx->user_ip4 != user_ip4)
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index d62cd9e9cf0ea..9c86c712348cf 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -12,6 +12,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bind_prog.h"
+
 #define SERV6_IP_0		0xfaceb00c /* face:b00c:1234:5678::abcd */
 #define SERV6_IP_1		0x12345678
 #define SERV6_IP_2		0x00000000
@@ -129,25 +131,25 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
 	// u8 narrow loads:
 	for (i = 0; i < 4; i++) {
 		user_ip6 = 0;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[0] << 0;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[1] << 8;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[2] << 16;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[3] << 24;
+		user_ip6 |= load_byte(ctx->user_ip6[i], 0, sizeof(user_ip6));
+		user_ip6 |= load_byte(ctx->user_ip6[i], 1, sizeof(user_ip6));
+		user_ip6 |= load_byte(ctx->user_ip6[i], 2, sizeof(user_ip6));
+		user_ip6 |= load_byte(ctx->user_ip6[i], 3, sizeof(user_ip6));
 		if (ctx->user_ip6[i] != user_ip6)
 			return 0;
 	}
 
 	user_port = 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
+	user_port |= load_byte(ctx->user_port, 0, sizeof(user_port));
+	user_port |= load_byte(ctx->user_port, 1, sizeof(user_port));
 	if (ctx->user_port != user_port)
 		return 0;
 
 	// u16 narrow loads:
 	for (i = 0; i < 4; i++) {
 		user_ip6 = 0;
-		user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;
-		user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[1] << 16;
+		user_ip6 |= load_word(ctx->user_ip6[i], 0, sizeof(user_ip6));
+		user_ip6 |= load_word(ctx->user_ip6[i], 1, sizeof(user_ip6));
 		if (ctx->user_ip6[i] != user_ip6)
 			return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/bind_prog.h b/tools/testing/selftests/bpf/progs/bind_prog.h
new file mode 100644
index 0000000000000..e830caa940c35
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bind_prog.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BIND_PROG_H__
+#define __BIND_PROG_H__
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define load_byte(src, b, s) \
+	(((volatile __u8 *)&(src))[b] << 8 * b)
+#define load_word(src, w, s) \
+	(((volatile __u16 *)&(src))[w] << 16 * w)
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define load_byte(src, b, s) \
+	(((volatile __u8 *)&(src))[(b) + (sizeof(src) - (s))] << 8 * ((s) - (b) - 1))
+#define load_word(src, w, s) \
+	(((volatile __u16 *)&(src))[w] << 16 * (((s) / 2) - (w) - 1))
+#else
+# error "Fix your compiler's __BYTE_ORDER__?!"
+#endif
+
+#endif
-- 
2.44.0.769.g3c40516874-goog


