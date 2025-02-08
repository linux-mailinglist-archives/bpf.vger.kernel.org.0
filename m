Return-Path: <bpf+bounces-50859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82789A2D58A
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02813188D837
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E21B4243;
	Sat,  8 Feb 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V63/dkL4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7721B0F19;
	Sat,  8 Feb 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010783; cv=none; b=WTIafP0zrw49uOILNOIefPdF0+9uTkApGtNNw2znV1LbFT+x3fpZoc3m+zVB3IkmOcRNQCX2CWZ/eq/z5opPAt9tMaBIVzkc7IUcmj4dOfVDw/ZepiBDPF3M7cLAOZy3FOPT59zi5QTfSWB/yaIkKR7AzTANihlt38xJ+/k30Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010783; c=relaxed/simple;
	bh=aHyAM5svxhWj2sF7AHGWfOZftFC4LgmiePb1+qDeyVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwpcWe2yEoTIPlOZoEy/5+V7woHFnXU8Pa5fywstjj/LOSLFIzDw/7bPIrytUBGP4YWjJQ8Ea4S0wbcDbMx5S/szW3nXQ5wbdZutfI1eGBoyJuI9sCUk++2QcsDrgZsTyh3MqQeL/Zx9jOErRH2BU11+hoFmqylE49rX65Df0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V63/dkL4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f0444b478so42884705ad.0;
        Sat, 08 Feb 2025 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010781; x=1739615581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFM1macd022s7HGXie9TIhcIgvi8V+I1eZg2vJ35r2U=;
        b=V63/dkL4mBXVqsHB7lS1cqK3r+Vrw78uCO4JotouUqnUqOTgFSNdDcm9/eU3qXFS/E
         xfiX6CcAIzbspy6h+hRBJUo2ImpIi4bvP+wiv7ETGzzni0Cq55druKosvo1zIJnNjXDK
         LjtrYVWYqobOI1uM23uMjMxeSfy/SkRK9lxBQabG3yk3kk+VDuVDQ3TxAx4Bt9r2IwQo
         aRvq4bVohdrRCwKpzc6BeXUfx5XuEHAzA5GunrwytBLG85T9GPDY6uL4sO19eWA5N0i/
         rBTdU3VgJoZDncG0wnHT2SDD93YH70GQIXGbqxFi5MF14y0ZXBDxnqFo2ddV+0hLNbEu
         RJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010781; x=1739615581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFM1macd022s7HGXie9TIhcIgvi8V+I1eZg2vJ35r2U=;
        b=tHLReBeroAUiLBYSfoGWN2hNmQhe/4+doenFkfZnmiwRkOJOC5FQQ+HVFqsDI6l9rv
         9+Wwei7cs1oAM07khnAdcKqLZ972ztm5um3bf7Fhxg8QBn2yTyfcOmmsXOAnAX+JqqfP
         3f7MYpjXQq+xaFk57Mor0HgpigDaYcIbxs7FxZPm3Tdw/dKisNlkoWxhcEFXvaIuUloU
         Nd6uZkPrxabT2++vDTB7c8ZJ0wccGSfPVmL2uQLTLvLKt2u9k6K3LXlfvroWBBavoP5W
         i5JVl/5aqTRCZmRPypp6fw+6FOQKrBcoNzPih+SoEWpcz4hP5k8rOiS5Vv+nQSEb8AT9
         x1uA==
X-Forwarded-Encrypted: i=1; AJvYcCWLDrZYXRX2iNUwhf3n6aWjnXJnclqzK8HGA+AHaPVCHdpJ2wUJGz7hyAJAEybwfZh2P/y3VBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvytDOA0llPDFI3O5/A+/ET4z6tum7rTBB+hPJ92fT3+y7v5gt
	j3KC7a8PdzmRJBnOoCuyBnPVWaqJFqrmcf9MZgcl7+CAuMV7bS0l
X-Gm-Gg: ASbGncv/QqxG4jxhlTB/+rx/m17PMayeeOX48ou2QrzOkjsRqMGook315L/2bTmw546
	VdGfxNusoCvUDoTRdqZgme4FztNTQPojrHchgz6isNEzgAGzeG5Cj2obhdYGdvQJnOjzeSbc0j1
	VILZD/7WIEQ15mEY38q7r5x536t9OtXYGhomCA5eS7V1LZHEcZUl7RY5luaEWgppROgS/YXCIKT
	QwbUuKFdFxEXj/5KKfOZ9g7bKiZEsBMt+KOHjOtUcpPzx1X3hav1/PHbzq/vxrYDJLw5DroYmYi
	lYe0WSZIk6mkBMpGCZujPWYBe13UEjSlWFj62k+MDPQWf8taDfQW4w==
X-Google-Smtp-Source: AGHT+IE6zHffg6eatYFb3uOH4TJZ59KqBT6RcSCgi1MgezaJ6VbRuVJfyvyUrAbMjxJGfss03JYMNQ==
X-Received: by 2002:a17:902:e5c8:b0:21f:1ae1:dd26 with SMTP id d9443c01a7336-21f4e7a1157mr94770325ad.52.1739010780709;
        Sat, 08 Feb 2025 02:33:00 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:00 -0800 (PST)
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
Subject: [PATCH bpf-next v9 06/12] bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
Date: Sat,  8 Feb 2025 18:32:14 +0800
Message-Id: <20250208103220.72294-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCM_TSTAMP_SCHED case. Introduce SKBTX_BPF used as
an indicator telling us whether the skb should be traced
by the bpf prog.

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
index afa2282f2604..d57946c96511 100644
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
index 46530d516909..6f55eb90a632 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5555,6 +5555,23 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
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
@@ -5567,6 +5584,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, tstype, sw))
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


