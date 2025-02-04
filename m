Return-Path: <bpf+bounces-50444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1BA279CD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C1818854FA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5903216E2C;
	Tue,  4 Feb 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us65EOlz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922C217711;
	Tue,  4 Feb 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693864; cv=none; b=fvIWFseY0htQp72gHeM3YzIfc97BY+hkBeMc7CiZJXpsGwia8Rktpk44X5ekz8EFwHG/pN9d4H+ahMiJomFbgol1xEmdD2IrF83U491/R6yPUUN+c7dSdUh+huUYSfOVMXOi3PXg6GRW+qOOkDyisNWpqFEn1bbzEsTf3/17r0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693864; c=relaxed/simple;
	bh=P29bkQwH7Ds8XAKNvbY1nEQ3uSSHQzdQ2g/mJx+hWCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ss+5PYvNl1jrY1nPcJ9rnRGR7EqSSJJK+KLwx7v7hY1PcWDKVTFeqh1BnsJDZ64PX5W6stdBHZrJFI9PFLQrbLyNOqplZ/YbFWhlWuUxL+/o+0vnCKpWWRYlO/TUCZ/1BCXIaNGFSnyhui1cfa62xn8jptkZSoDa2R1NaXQL7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us65EOlz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9da2a7004so404550a91.0;
        Tue, 04 Feb 2025 10:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693862; x=1739298662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztGS39EtdCrUg2P/R2l3ObPMe+jhMRGbji2Nk4/+AMI=;
        b=Us65EOlzJb1qUGn9RHX3w7cYimUJykI2v2sxkx2Zq6Ep5npP40CSqzwL2A+cw+XmFF
         tHbM+z5hh8H8IE6GMysKTRtpZIUBcKeLTb7UtCpTy6H/qZL1Pcc50aPl6pDY4E5BXsab
         P0z0azKdQIGDcaH/W9w0t+zcrCKU3K2lrFzG2MVPB9VC1ZJO0RJZBVZUo00WlgMl+SaQ
         DCbTdDbmlhBl7QtJgCPOOLqCCMofZRmY2ey58TR5cvp7yGOn3uU/W/dQ2hciWwYJX0VP
         C1kGKVIE/V7MkOWBDdoKVGG5YTWV3NrC9gPPkTgQ0jFhbYhAvygWnTUNrBQaODjMeAeO
         36hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693862; x=1739298662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztGS39EtdCrUg2P/R2l3ObPMe+jhMRGbji2Nk4/+AMI=;
        b=jovcqdK7LEfwvzs/lc4+uWWqp6WFLQJ4RhrinTNjejSXHGh/ilWt910PCIH/sDEk4P
         n9asrCTnGvj0bOv2nM6OzhHkNoHYOb2nC2iagR0K/K+c43QLzJLTwXyT+Iukm9vN+KdV
         kMbW9Ng0bGs7xNX6izbxZAmkXhMnb8Ul0sWn5V4rFwF0p1f+VGqiskO/UmzWS3dvFd8m
         yvu21UU4kMpC5CvnJJ7RfYAh6iVEZoeve79HQjnalD5xqJhQQXaczXIGAua62dKaOKaC
         QcDLoRe/zRBpumDqAcW6wDGBSKngwf9Ud8FZ4P1DQCeIIBKZzBnK7D2xRbegrlPqxUoN
         +ncg==
X-Forwarded-Encrypted: i=1; AJvYcCVpYol0CLFslQWCNnj07BlqEJkhCONiKcVrDvmotqYq7XxIm5es1nfkHQ61igYCNhDkDR0t8hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCMr1No4cNJdKuGjxbXTSKeU2zE7HIl8YtGY/JFiMmgnsHBJA
	a31+y64QGf9cU156G1LEhab+U77NDUtpknBRr2WwjOGkJuUD/Vv9
X-Gm-Gg: ASbGnctFt6dR5GtiNm+6DFYyJveiqcLE7kHwag4iGXrEbTZK0KJjJhXuekQ/cri99ac
	45aqVwhIF6tRce5H1jmXS2GkRrxJLD6x98bXmMMnHkS29YwX2W1FqBJVg1SzSLe9KRaLWxb3stZ
	JvXgr5nFqJgKoqt3t7d3ptNG4VicGcn3IL5Ht63whTeStBUq3u+F4QJZ8joku85s5lTQSBQetWH
	wnwPOg8kxaFGUAJxgdRSWOyWCEbLauVkXjbIdMeBxTNi5oG2/B/RDktSwV5oJuJvjLeFcsPe6/8
	SyskacaLSIj73hI7eNp5doz0m/bDsStig5JqlGBLnjgNWRsFnlbcBw==
X-Google-Smtp-Source: AGHT+IEakh3pXT3SabKHMgY+mnV6UfM0/q/YQk9KFpwiLJtsJPy1iBGQUFRTgTsbcO/KGSOA4MBQUA==
X-Received: by 2002:a17:90b:1f8c:b0:2ee:94d1:7a89 with SMTP id 98e67ed59e1d1-2f83ab8c371mr36914003a91.1.1738693861691;
        Tue, 04 Feb 2025 10:31:01 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:01 -0800 (PST)
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
Subject: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Wed,  5 Feb 2025 02:30:17 +0800
Message-Id: <20250204183024.87508-6-kerneljasonxing@gmail.com>
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

No functional changes here, only add skb_enable_app_tstamp() to test
if the orig_skb matches the usage of application SO_TIMESTAMPING
or its bpf extension. And it's good to support two modes in
parallel later in this series.

Also, this patch deliberately distinguish the software and
hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order
to avoid such a case where hardware may go wrong and pass a NULL
hwstamps, which is even though unlikely to happen. If it really
happens, bpf prog will finally consider it as a software timestamp.
It will be hardly recognized. Let's make the timestamping part
more robust.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h | 13 +++++++------
 net/core/dev.c         |  2 +-
 net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++--
 net/ipv4/tcp_input.c   |  3 ++-
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..dfc419281cc9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -39,6 +39,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <uapi/linux/errqueue.h>
 
 /**
  * DOC: skb checksums
@@ -4533,18 +4534,18 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
-		     struct sock *sk, int tstype);
+		     struct sock *sk, bool sw, int tstype);
 
 /**
- * skb_tstamp_tx - queue clone of skb with send time stamps
+ * skb_tstamp_tx - queue clone of skb with send HARDWARE timestamps
  * @orig_skb:	the original outgoing packet
  * @hwtstamps:	hardware time stamps, may be NULL if not available
  *
  * If the skb has a socket associated, then this function clones the
  * skb (thus sharing the actual data and optional structures), stores
- * the optional hardware time stamping information (if non NULL) or
- * generates a software time stamp (otherwise), then queues the clone
- * to the error queue of the socket.  Errors are silently ignored.
+ * the optional hardware time stamping information (if non NULL) then
+ * queues the clone to the error queue of the socket.  Errors are
+ * silently ignored.
  */
 void skb_tstamp_tx(struct sk_buff *orig_skb,
 		   struct skb_shared_hwtstamps *hwtstamps);
@@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
 	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
-		skb_tstamp_tx(skb, NULL);
+		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SND);
 }
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..d77b8389753e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4501,7 +4501,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_assert_len(skb);
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
-		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
+		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
 	 * stops preemption for RCU.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..6042961dfc02 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,10 +5539,35 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
+{
+	int flag;
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		flag = SKBTX_SCHED_TSTAMP;
+		break;
+	case SCM_TSTAMP_SND:
+		flag = sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
+		break;
+	case SCM_TSTAMP_ACK:
+		if (TCP_SKB_CB(skb)->txstamp_ack)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+
+	if (skb_shinfo(skb)->tx_flags & flag)
+		return true;
+
+	return false;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
-		     struct sock *sk, int tstype)
+		     struct sock *sk, bool sw, int tstype)
 {
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
@@ -5551,6 +5576,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
@@ -5599,7 +5627,7 @@ EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 void skb_tstamp_tx(struct sk_buff *orig_skb,
 		   struct skb_shared_hwtstamps *hwtstamps)
 {
-	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
+	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk, false,
 			       SCM_TSTAMP_SND);
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 77185479ed5e..62252702929d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3330,7 +3330,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
 	if (!before(shinfo->tskey, prior_snd_una) &&
 	    before(shinfo->tskey, tcp_sk(sk)->snd_una)) {
 		tcp_skb_tsorted_save(skb) {
-			__skb_tstamp_tx(skb, ack_skb, NULL, sk, SCM_TSTAMP_ACK);
+			__skb_tstamp_tx(skb, ack_skb, NULL, sk, true,
+					SCM_TSTAMP_ACK);
 		} tcp_skb_tsorted_restore(skb);
 	}
 }
-- 
2.43.5


