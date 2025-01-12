Return-Path: <bpf+bounces-48645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E896A0A89F
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D364B3A8C6C
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6941B0F26;
	Sun, 12 Jan 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWTa7oy+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D31B0F27;
	Sun, 12 Jan 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681912; cv=none; b=HfTBgPAwnGt03r4vIkoUGkcOFNyulSBh+9roGX+Lm7BwPR6mix2CgJuqNX9a+Gt0ASjTIKTM5rZXBTo6Yqu5I2F0V0Bx1F+4mIhRaPxfraGYe1Tw+Q9RTItyq4CrqyFYPg5r4jWUYKueK27513jc3GAuw7AFTA/klZ4hyyyuT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681912; c=relaxed/simple;
	bh=+Y8VkW1rPLeyKhkY0/ncArtR6rMW9fgkqpTbp9gHm10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bf3Rk+F9trroGaPmwxhSFLtH/Gh/PR8zhiLyj69UAScdT8LPV6wgAKL2fdmlDwWwXWCqfgfxAgz9Wnnrdd3r0XY24ec+tLpAtbi04SxmlobD+bVWgtdmXihPgrkTuJxzPVc6lmVLBwCuBv8Z6c6i52Ye1EYQJoSrzn7EwnLdTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWTa7oy+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21a1e6fd923so77078575ad.1;
        Sun, 12 Jan 2025 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681910; x=1737286710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1RCiHcUSqZQwwgY6I8u+HQGqR3XU2ZymQTTWqq7ylg=;
        b=gWTa7oy+ouAMr8tCndzOlYL2piT4uiQGbw7fUhwUj5S7FHeA/59VyExXEX4s2eGQQD
         Vc1r40wiFluRferTn4K9lMfmaItbtCFzJNaSBaaGNfQ9nUyxbstwKW6fHzBcrsEa5/eY
         BHA2/RNHkTCfXUUVs8ZQTUZAprZbUrRtb1VLCTBXww7PGH6xxqumCEzoBb82wTGLvDOb
         UBYR0GcCPmk6itmmYAjv/ypQY/BMamOtkM9/moENGj407fPV3nQv7/Srn6XnG9uR2SAa
         z/7o9JOqj3FKqFi2ATUS/VULs3LU4GGAcr305N1DB69VCABGYAeq9BxClaOJ6Gl4UjnR
         ci5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681910; x=1737286710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1RCiHcUSqZQwwgY6I8u+HQGqR3XU2ZymQTTWqq7ylg=;
        b=OM6ib6oTP9/smRT+MDxX2f9KdZB8hIOQw1q6oavVQ96ZkJP0D4f/xpziZvM2/a7b8M
         RUV0Fj7RPPSlWPxVMoZIPXDlTC1eAVGAZF0A8PEAtLRco0OBpWqkOS5pyh7xUkbgdtB7
         YPPwT3eE9Lq2Yf9ajRihp9Pxsjr1pTgWGxhAjypGSAyafBj/CdcbUSKy+lFzmgFMT6C4
         C+qtM4K/8vZNuR+bxMTQGQq6TIYcZcZcMZiCtlHOoF2jI/v13kVw4lYs9T9qV2PCS0zY
         VzqmH+zoIzG8GVCoaSScgAtIJybfUHetl7tKYayqdcUv694icMCNSotyjb5/jBGbPrMf
         lgiw==
X-Forwarded-Encrypted: i=1; AJvYcCVjc5OmI0uv4agt9PBB2HvBODpdWVm+2YqeAvbcpNN0NHQi+90JjAkgPYXV7YAbtP4efDNUhY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMOEg8yc3yPWP/5qCuiuFATiIFHdlUvwpLW4cV62RHB00UQrs
	512lME40N7IcBEnO3s5SlAQUvVkkNneAHK97ko8eHYYj4MSNUBGX
X-Gm-Gg: ASbGncuT9NqJJ2PPD7LfdFsdQXdSe+VBtnwexWwUuznQfArr2AZPmHcpi9bYNAUUpmw
	GEUmh9pz03BeLDZo79vJ2NOZwd0+Yg8TsKeFYodldVKFMXDp6CVWpgMTcSjX4qwLKnOUAHmCqMa
	aT/ay009AUMCvakeliAlihHMWZOrXG3ie/cS0rCveQ6KC11UsnirweXLkyKR+JmlQ6qDFkZKNeC
	x5R6BqDmDxlOC2mdxODJkLWHTUphLJqsxa4Dc6VzF9QYRE78fA34c23J2Vob20S4oxa4/xpouLR
	MusLOzzKEDe5nL/SxQQ=
X-Google-Smtp-Source: AGHT+IEq502QFKXZYYhiDw77wQP4J6WBlxm0IG8QypOdhUeBJTTNWt6BSBdTt5u01wuxGx6zmylgYg==
X-Received: by 2002:a17:902:ce8d:b0:216:3e86:1cb9 with SMTP id d9443c01a7336-21a83fdf1a1mr233697465ad.50.1736681909818;
        Sun, 12 Jan 2025 03:38:29 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:29 -0800 (PST)
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
Subject: [PATCH net-next v5 06/15] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Sun, 12 Jan 2025 19:37:39 +0800
Message-Id: <20250112113748.73504-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes here. I add skb_enable_app_tstamp() to test
if the orig_skb matches the usage of application SO_TIMESTAMPING
and skb_sw_tstamp_tx() to distinguish the software and hardware
timestamp when tsflag is SCM_TSTAMP_SND.

After this patch, I will soon add checks about bpf SO_TIMESTAMPING.
In this way, we can support two modes parallelly.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h | 22 ++++++++++++++++------
 net/core/dev.c         |  2 +-
 net/core/skbuff.c      | 42 ++++++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_input.c   |  3 ++-
 4 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..09461ee84d2f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4533,21 +4533,31 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
-		     struct sock *sk, int tstype);
+		     struct sock *sk, bool sw, int tstype);
 
 /**
- * skb_tstamp_tx - queue clone of skb with send time stamps
+ * skb_tstamp_tx - queue clone of skb with send time HARDWARE stamps
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
+/**
+ * skb_tstamp_tx - queue clone of skb with send time SOFTWARE stamps
+ * @orig_skb:	the original outgoing packet
+ *
+ * If the skb has a socket associated, then this function clones the
+ * skb (thus sharing the actual data and optional structures),
+ * generates a software time stamp (otherwise), then queues the clone
+ * to the error queue of the socket.  Errors are silently ignored.
+ */
+void skb_sw_tstamp_tx(struct sk_buff *orig_skb);
 
 /**
  * skb_tx_timestamp() - Driver hook for transmit timestamping
@@ -4565,7 +4575,7 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
 	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
-		skb_tstamp_tx(skb, NULL);
+		skb_sw_tstamp_tx(skb);
 }
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a90ed8cc6cc..397fbcd5e4de 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4398,7 +4398,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_assert_len(skb);
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
-		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
+		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
 	 * stops preemption for RCU.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..b34c7ec3d5e9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,10 +5539,38 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
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
+		if (sw)
+			flag = SKBTX_SW_TSTAMP;
+		else
+			flag = SKBTX_HW_TSTAMP;
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
@@ -5551,6 +5579,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
@@ -5596,10 +5627,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 
+void skb_sw_tstamp_tx(struct sk_buff *orig_skb)
+{
+	return __skb_tstamp_tx(orig_skb, NULL, NULL, orig_skb->sk, true,
+			       SCM_TSTAMP_SND);
+}
+EXPORT_SYMBOL_GPL(skb_sw_tstamp_tx);
+
 void skb_tstamp_tx(struct sk_buff *orig_skb,
 		   struct skb_shared_hwtstamps *hwtstamps)
 {
-	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
+	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk, false,
 			       SCM_TSTAMP_SND);
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cad41ad34bd5..c2cdd0acb504 100644
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


