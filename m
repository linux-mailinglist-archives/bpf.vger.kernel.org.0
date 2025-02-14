Return-Path: <bpf+bounces-51498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17AA35362
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B10189071B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A043596D;
	Fri, 14 Feb 2025 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzKWddX9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D214275419;
	Fri, 14 Feb 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494882; cv=none; b=ElKkNfHw2FSDM7GrXhWynQMJSX4zOw49nYqyEY2HfM13SrIRCZAcZmHPc2bxalpc3IARiXMxaNmULiZfA/2eFbRa+6BmN1QwGxeFWzEa9FyyVqB3gd/WWMn1UPQEow7j6gBXpUwGBh+eGwbcIplgBEYL9aa3NcWpIJ9BFTRQ4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494882; c=relaxed/simple;
	bh=MwnhAchlDNKve5J+/cAJpVlmx6+Xk3aqDL+WS1Pv+Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPLUknv7ISJvAjPwegOFgDLHe5KAPJzS/XkGJqznWsVT/mxdkVC2f8fkLHc2LGatEu9Ns55HZ6z6v6yMRYzHrPxRTS/MrVtp8TLvTjaqV1BKmPAIinHVrEdkIOF9Ek4vAKg56ERz5pFemDe493PBFplZt/43/aNCbHpC5ZIh/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzKWddX9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d28c215eso20477605ad.1;
        Thu, 13 Feb 2025 17:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494881; x=1740099681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeqW566o5arTPjVwkcb4h3wmjpR1zsB/qZsvzlvgmI4=;
        b=kzKWddX9WCmuBOUoo6bT6MQ4CwgAqIYBU5MXrT1q3dGETrxwVGu+Kt24FZ7T4Ae18+
         YQHMXRvL3ffrglwF7RqyJxSDd81gD7suzTG8iS+lr7totzKNerLzvyIuZiLxNW9X2EFC
         lLFPTIu9moIhKR8Fr2PfybfKST8n7WkE4WrNdJh7HfVeBDuA0fz/lnKXM4S+aAmRsK01
         Gi8utYPea1pzU/jArEU+abkI3ZLPkwFYSVwtgFUodaMppERTZV0aUqL/XdGDTOyZDEZR
         dsZytJMzPY2BceZtXpBTfuaYPS/O5RzKzMTUPzMQ75+gaX2z0G5E9HwNbum4IWwlFhhw
         kmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494881; x=1740099681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeqW566o5arTPjVwkcb4h3wmjpR1zsB/qZsvzlvgmI4=;
        b=FtxVPUEw2IhpNhwuuP8uWzirPHhQNZ4MPDO9ohyElbJs0KcBDxajInTLitRFoNuKt3
         b3Q0aLW4Xtl19zbs74/N1cZiK/FoUh4LO+6fF2X+WWY1JLhuUYnWIcQIPJN6plCUw+uI
         NVtvsVcs3yYZoYN9lTdMqnAawWK0bOqRUfhOGTqJhtKCH+2F0RkiyUu6EX3kv1I2igIB
         NSnjyCm4bq2zHXkUS0/BLL5o25fc4KnGbyhivED5p++V5XiZEwoych7tBu4NhDgNQCtY
         mRu5LHkeax3lgv1Ap4DJEGD41zlSgv4K5ylodaIPU9PEHcLjPkogyP2zqFCoJnJmBMih
         n4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWUMHUzrS3c0dxuRfB2w1HVGHepXQVpWKBVjzNHRWGCVaNwph1UYg4NWQNPzGPt9hmGUJ5TQoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEytbsB+wQ9UviCGH8fdY+IrjAgEUh5PIe7nJNYSTuo9yQ5Ng
	Fp9VorWl9FbdujhLSN1PWtC3dh2O7y5F1X8pHZIN+99AEqwalcIp
X-Gm-Gg: ASbGnctbtzaRJLw3CejQMeM8vyAU2O1h15UA/uWve5NVcoJ6RucRV8oVZZUs0Gwi+tC
	CccLx0Zi35djzl8pIJpijp+eQ6h/ioOybKilG7C4iY5LiGGDIRH4Qs0pns0GVkizQMFid2aZPMO
	ZpJLqhzsHBP60zOyDCqayHaZ2vFA5Ckg8VeSuHBjLPES7r0AnnBH7Hg5o8iUIyjeF0tX96uvHHt
	N681zlSm1NMEODYzP1TFmOnhVHs5pE0XnWwCatITkAllrHW/mI71ntsW8LJcUlxPQptV/Nzw7Ng
	g0gzwSSU63UQ2wDQNUoF4rBfZxNubYzjo7vK1pNQNiN21jTCEecVWQ==
X-Google-Smtp-Source: AGHT+IGoCHPP4536o+gtGftFX/OumVM4i5ntXF3ulveRA/xroiyGPEk+Om4BAd99OuBfMgJL8xjSjA==
X-Received: by 2002:a17:903:1d0:b0:21f:7821:55b6 with SMTP id d9443c01a7336-220d1ed1ca9mr76075975ad.13.1739494880197;
        Thu, 13 Feb 2025 17:01:20 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:19 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v11 06/12] bpf: add BPF_SOCK_OPS_TS_SCHED_OPT_CB callback
Date: Fri, 14 Feb 2025 09:00:32 +0800
Message-Id: <20250214010038.54131-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCM_TSTAMP_SCHED case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TS_SCHED_OPT_CB. This
callback will occur at the same timestamping point as the user
space's SCM_TSTAMP_SCHED. The BPF program can use it to get the
same SCM_TSTAMP_SCHED timestamp without modifying the user-space
application.

A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags,
ensuring that the new BPF timestamping and the current user
space's SO_TIMESTAMPING do not interfere with each other.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..52f6e033e704 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -489,10 +489,14 @@ enum {
 
 	/* generate software time stamp when entering packet scheduling */
 	SKBTX_SCHED_TSTAMP = 1 << 6,
+
+	/* used for bpf extension when a bpf program is loaded */
+	SKBTX_BPF = 1 << 7,
 };
 
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
-				 SKBTX_SCHED_TSTAMP)
+				 SKBTX_SCHED_TSTAMP | \
+				 SKBTX_BPF)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
 				 SKBTX_HW_TSTAMP_USE_CYCLES | \
 				 SKBTX_ANY_SW_TSTAMP)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fa666d51dffe..68664ececdc0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7035,6 +7035,10 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..cbbde68c17cb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+	if (unlikely(skb_shinfo(skb)->tx_flags &
+		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 341a3290e898..0aa54d102624 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5556,6 +5556,23 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 	return false;
 }
 
+static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
+						  struct sock *sk,
+						  int tstype)
+{
+	int op;
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
+		break;
+	default:
+		return;
+	}
+
+	bpf_skops_tx_timestamping(sk, skb, op);
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5568,6 +5585,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
 		return;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70366f74ef4e..eed91b7296b7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7025,6 +7025,10 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
+					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


