Return-Path: <bpf+bounces-50445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E17A279CF
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289BF188247C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3B217F36;
	Tue,  4 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erocsO/g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCC217711;
	Tue,  4 Feb 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693869; cv=none; b=LRDYEztVyKEGpYrqd67S0zmNDveAVauCencu1IeFgfwbuDBagKEeLDiCY/5cMQTabd9LsqS8VEnUUBOz6U+LrY9WEBuxoVfuqCjbMoK87vEcj+M5gVJ3uNl/+DVsIj6NEFRX8x3bEfbWxVvr4afHkpBemML1M+qouBep/xeAjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693869; c=relaxed/simple;
	bh=VwbxkawwbD09JBYUCW67r+SjOufGMep9Bg2p+zSdrH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ug6PoiY0Wh3fLdBY46FEk1cjkU/Y7JlJlb3f+5ofX7qEFrFQpVcv/m9fN69NmmHGnghftep4rTSYMJzw3BOBO+eXtzGGM7tpE+hG89uE+s+xRL0or3La823TMcqO3i3Rke6oFv3kAiQWViqU1bSNfOne1tvBluAt2EqBqFXSHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erocsO/g; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9cb23d22cso1219944a91.1;
        Tue, 04 Feb 2025 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693867; x=1739298667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJGrKh1xB34s2kAvvKTGY5CjF5n7ybSUoLqRXmIkuF0=;
        b=erocsO/ggOisiINKWok2Dj3vSmN5R07SvKeSnrBwxjMn/F3kHL/kcNMNrhHOsbyr9h
         qTCOQ1mDYRiNA0NEXYe+jAjzXCC6Sh4knaK7LOQpTgnhjPOV0tOXfB94RE1oTsb2XiRm
         hZT7TadQke2Z382c+/Cjzr4VDn2Vzybn8uqgOYIZaBweZrO6GGSfJJziPuLuiYoOCqx4
         AjbxJC9hwnlj+vZfp/z/mZRtpDCPhaFKxi5t1RDKsmLsmq97RcUD7FvuhjgwkSrpyhZQ
         DyxlYzlBhoQDeZIu2Kou8TSARtr8/kpdNbA8fZF4RCfNBImtLWlyoGZR9OP4sWmJHn2T
         FlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693867; x=1739298667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJGrKh1xB34s2kAvvKTGY5CjF5n7ybSUoLqRXmIkuF0=;
        b=Ya7atdkga09gpdl9+3Vuqudco4aHd5hvgjRhq026+07+pZTRHKjP7+ZhkclzyEFSji
         PJo8uTu7U6OnwyRR0Bplqbv9w2HMPdNznxAHQahw75iObmozk0n0ae/yBZ3Gy6d+i8wW
         hZKFicY5xGkd1D1vhqkx9laYjhgPSvzOMwtfSxaEqSd9Nct7hL4oMqhI5wvX/TUNh8/+
         9AFBed4bGuE+Fx/Lc82pTC5Di16k6tRMxsTk5ziCr4YaIUnyDxKrajk3dAibtDQi3hXz
         /oA1yb2YS3iDiuGlDj5hHY5EpYLl86ulQWR47MtxTMF3Axph9XJvXF9+51R7mmteT7we
         p1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV+5i5PkRPr9RlrTBhsrED8x0PWhjKds2SZ5GtMNn/mMdqpx0c6AFkuTcpQK73oybKQxaNNxOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIE+qGJnwb8AEN/Aoky/jMMNOcamXReuybbK9gFk1nrNk8hE2
	ADl60JFg4bcXcfhDkea3sPpoB2SHnY2ff5P8OeqfcPKUJQWKtQhF8DhAWEvJLBA=
X-Gm-Gg: ASbGncvpJynLEKrAIt8SxLTY0bS0qk/y/aG4s4wJ9BPQZkW5w8bc2CfJKVgnLb/MQcN
	GWZK4VOap4RPp2sKvD3Ub8Xg2DU2un+FRyST03PPLmHINKqdbvsQmwDuB/sTLjnl/FidVMrE0Ik
	fB6TAXeYJ1TxeB/cSj1kq2VRIz4q9UBGqWyLJUN7d4iS51ptHyqEd9Kk4LCN54/oRf+b4iXkOYH
	9NSU/Ld58XxEWDOEuZOZzPgSrwwo2L4CnbG8B04hiZ8n3cagb2jfzeWjF68i5mR/0DsQbjOTOTw
	bbuE9v+Au/CEuyBpx9OP+uQvZN0dvkmzBuTz4mLKn5uM3rRlV31w8g==
X-Google-Smtp-Source: AGHT+IGdXsKPBGM9XGi3wrUeqBT+yDGGgDGtvbFKYuIN+Ts61ItYtfzP4CMaDZByfVIi9UsD/FpuoA==
X-Received: by 2002:a17:90b:4d06:b0:2ee:ab29:1a57 with SMTP id 98e67ed59e1d1-2f83abb3553mr41520614a91.2.1738693867353;
        Tue, 04 Feb 2025 10:31:07 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:07 -0800 (PST)
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
Subject: [PATCH bpf-next v8 06/12] bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
Date: Wed,  5 Feb 2025 02:30:18 +0800
Message-Id: <20250204183024.87508-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing SKBTX_BPF is used as an indicator telling us whether
the skb should be traced by the bpf prog.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  6 +++++-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/dev.c                 |  3 ++-
 net/core/skbuff.c              | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index dfc419281cc9..35c2e864dd4b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -490,10 +490,14 @@ enum {
 
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
index 6116eb3d1515..30d2c078966b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7032,6 +7032,10 @@ enum {
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
index d77b8389753e..4f291459d6b1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+	if (unlikely(skb_shinfo(skb)->tx_flags &
+		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6042961dfc02..b7261e886529 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5564,6 +5564,21 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
 	return false;
 }
 
+static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
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
@@ -5576,6 +5591,11 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	/* bpf extension feature entry */
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		skb_tstamp_tx_bpf(orig_skb, sk, tstype);
+
+	/* application feature entry */
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
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


