Return-Path: <bpf+bounces-49319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E3AA175B5
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3017A30AD
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB91465A5;
	Tue, 21 Jan 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIPl3mhy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452E2581;
	Tue, 21 Jan 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422982; cv=none; b=K7Icxh30Qz3VPdug0wYwe8tialG/+N1fv1MYYnnfTUYJc8+duWNrAN7rz2R5XPLWI1rD+u6KMhbgqTLlLzjtrGiuCz6h4FmC7mMroOZBLGYuf8v35am/fyJ/46ZzXfogY5KIr7/m1NIzsqLQRtE+MfvVJeFLuJ5di0ZDbaPb+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422982; c=relaxed/simple;
	bh=QApQtC5XUqZW26wLg8a9HCJozP8Mzr+LBUJglp2VALk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdzEHmb1dV5XsOWg2q9uzixn027YI05UHiJqvgY1+2WeGjq7tBUyaKGzc+Rty3hcHes0PlrG/DQ4L0ml/wsDZcWwmKlJDuYxoRp3RZylNYgxz/yz/8KapsvuJS9Dhy+XDEQHrF6js4tDnMxrDkz8cco+OmT02sgeUv7hoxGdF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIPl3mhy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so9056866a91.3;
        Mon, 20 Jan 2025 17:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422980; x=1738027780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzNnDEADoQ3Tn/NnieMSGDXghu1f1Kdjynrdkn9Gsf4=;
        b=jIPl3mhyZFjkhWt9P3XYNMKU8zPoMkHcNk4HlGMopChq/v8YGwMjOwc92WKn2IeHc+
         DVfWLIhwoo9vvLfk8/UNv9YK5PeqqX6t+GqbqoBJE2c85jJB2NY25nDgBq0srobxkrwP
         jhVvU4eTevi6oq0uNDMQbpgI9UARhmoD0IrmnmIRGRDpZ+pzL1WLYRkf9ubJ73qZhAMt
         OK/264cdqmPlhyCMBHJhmD7td0rLUyEzzH0+Wgi0nVALvZvttcVSger4i0xmC/5cgYWa
         S3gHT+dGfDBDcii2PJ47AzmmiNsKnAxmw8/ytP2bmmQsrU8b8c/Lo0TXkSsl/QkLukt8
         yy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422980; x=1738027780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzNnDEADoQ3Tn/NnieMSGDXghu1f1Kdjynrdkn9Gsf4=;
        b=KEIv1H/3e51hZvcWasry+pIkrhIcprNfQaZgGsJvlvebe0p0SJkQY904lhXZt4eX93
         Jw6JUAyFxmnvqY0pYcCXUtYWpBHLiRW/WuMro2pjo6AG4vE7cArO3uVDEdCQYNVMVfn+
         c5AxYZwN/AyaDxSTrtlE8B1vzTitglRNHIfVijAeMQncmhsMdsLp/5su4WVlvDyH1sgc
         Yo+J5fz591aB7x0wt7ajrCiGQOLeDaVQOwWBEEg5TfEX7GDWx3iIo8kTf1oLMvGhF9zW
         OrqIYsb6/mPud9rBW3RLXxAgIFabKu3E39oa/L4uJCHBzA1XI2h9XGXCGDavstHVT5nS
         rUKA==
X-Forwarded-Encrypted: i=1; AJvYcCVGkkI5vSCezl9iFj4pUh0jY9C5s2DUHnd0VLM0ScjGVZLZhVUCBX26tSfbwjv56ZKCYcGM0PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQGeLrd29UiQIp11S7s/U4uWnw20zc1DSuYp/DrrS4Wc0hSBZ
	8+pojGdrr2BzPNIn1ftICGuIAV52M8ZimJHtBGQqtM0xDaUxooMl
X-Gm-Gg: ASbGncs+CUyRoY3kOk1cK03cGF7bUf7R3mkrt/1ez4AJPp0nQ3DjbV/DvMqeZq8eEFV
	qoMt5uv5bIJTScaKGuBcXtkRz/kWYBWMC2nfdoJgLeaNQjkeT1q9SmE6JYqMRhITGPLcYRUm+Gq
	a1Q4dmCfKRKRClCarfZ6D8pUtVj/NrSVCGsdi2N40qUrz9U5PHuGISS2kQoVQ/qpYzOO/RBZNoi
	oYYkt8Gd4PihJ6628tGwlfi3yq5hZriC9J2oJ/GjC8972K4pSTCh21Ne9U0ukVJzIdsxKn7EzQ/
	Q4N/y7OXGgUgCfZtr9u4hN2u+HJp9cEj
X-Google-Smtp-Source: AGHT+IEj5DA+mxVJutVUlE7lrrQHxt9FDHy5LRYEhBHvspEIRk3xKk+bwLQyIortJ7EF4NbvAPmZlQ==
X-Received: by 2002:aa7:8884:0:b0:725:973f:9d53 with SMTP id d2e1a72fcca58-72dafb71bfdmr20326853b3a.15.1737422979582;
        Mon, 20 Jan 2025 17:29:39 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:39 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 05/13] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Tue, 21 Jan 2025 09:28:53 +0800
Message-Id: <20250121012901.87763-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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

Also, I deliberately distinguish the the software and hardware
SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order to
avoid such a case where hardware may go wrong and pass a NULL
hwstamps, which is even though unlikely to happen. If it really
happens, bpf prog will finally consider it as a software timestamp.
It will be hardly recognized. Let's make the timestamping part
more robust.

After this patch, I will soon add checks about bpf SO_TIMESTAMPING.
In this way, we can support two modes parallelly.

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


