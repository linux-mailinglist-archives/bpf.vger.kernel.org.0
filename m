Return-Path: <bpf+bounces-49936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD6BA20676
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A1D168E34
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2041DF756;
	Tue, 28 Jan 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5Nvi4VC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3861DED67;
	Tue, 28 Jan 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054025; cv=none; b=ZKrYV5IpttAbYV1f6gOD8p+HR5U4UkQYjeleEqbtxGgy5U5mKQPE6ql0c/ta7OnU8HRXzoMENxsn9IywT6ZZpoIKru/Em4eaVKTfSJKhcox2tMvXbfU8+LYZCo0CpqMtNDNDuDU7OHPtbDHgfe4pIuwyPJ1pTQ9peoGAKa+veP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054025; c=relaxed/simple;
	bh=QApQtC5XUqZW26wLg8a9HCJozP8Mzr+LBUJglp2VALk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhNHULuSwGGahM3XV4DvnDaGdaGfp/NzJ6Ro8727LHRO8qdAYyEtREbcaD9NtuoyjMkUPS1sKZOMTNAkm4QQa0rJaQVFektPi3+2Rj/ZAFGnRJlNQ9REcarMMU2Dy63lsAH4cmgDn7R8QHGNopQoEedcD8M+3M+eU4OmjTGWbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5Nvi4VC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166651f752so110262745ad.3;
        Tue, 28 Jan 2025 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054023; x=1738658823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzNnDEADoQ3Tn/NnieMSGDXghu1f1Kdjynrdkn9Gsf4=;
        b=D5Nvi4VCR3zXFz556fXmRj2eFmL/3ZjXB9EEpRSaCHJ7De7tWj6dl2oTswAa2IggMT
         2wtg+A8Ptc8ujK8gJ4CU2m4Nsjm0rHAeE8vjj1xqgD6dxrl/NPG3Ag4IFe95eorjxfdA
         0meZqFbVfJRFgtJbsHoPOn6isHJ/aSATBvHG8paPf36LZV7MpxZwUIdFJGYLwzRx4SHv
         KlNnYLEc1l71uAYF1yyEiUyRZjqFYNukjHa1yvCE6FH1o3LfA4ikZaloOUKsizZ8sxf0
         6Xx0opLOhM2IgZ8zVT5OYePwqAvmoNzQq6ZqpPVCAyRfCqa1KI5WB9PMidoywYoa/Z02
         n1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054023; x=1738658823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzNnDEADoQ3Tn/NnieMSGDXghu1f1Kdjynrdkn9Gsf4=;
        b=QwRlRbCyEjQ4C4Uxa2RnodHNun+ONqDN/GFc66ElvH/B3gAFY/kfytWVjPuks5r1Yh
         tPUFh16fQpLPlS1VT3IeOwmL7o4Ocy1xLLZliJO/foUsuwUTBsF5hI4+uzGtpmD0fR/a
         HpMcnUVypiWYQoiYhVDDNCytdorqfAx7hcIkE9pJgB5MMOP+X/VaR6z2lfdUskkRLp3N
         wmYM01TfJvMTcuZ6y9EtKb2cvay1O04o41XgF1Qrwg5BpV2WdIAMEW/hpGzmwXUM7hCD
         h/K3haTgYGDxN/xkqSnBMo0qKBCAx2xDKLhYDWXhBOgpkdsM2Sdankt8RN1q9ExcO5p3
         /U1g==
X-Forwarded-Encrypted: i=1; AJvYcCVxqQExREK2DDbzzv2h1O+hQ1F0ERC8YIjkdBqzVU2LZrWkhPk4TMtdozFsHRmbB8tWojaBCKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+duDFVFC+504ejvkSbARDWDGGqnCXNOW31y80nEQ3tWTqaPW
	+vKKrFCH3WmtnAIickzIPi1qN9MyZE5lBz25fDNwVUoHkK26Ekfk
X-Gm-Gg: ASbGncsqkPP3vGuTC1Pa+hyU6+LQrvlAq16eNhMuMR2p1NLIQW4EzR3FyF7oxX3XyIr
	J7gUd2OPpdfxUKyPu8F2peamDfJafiWUSnE+BLEmvxtRqlhWZGVniBg7GM6MIi7O9BrUWZCkoSf
	Zc6aMG13rumj50c7sfDbdX4flZjC/27316Ii1inJsrLliXczPD7EmptAWkrE88WzIctRawkaUla
	fstUfv+IiO+t3f7TFOTaCdClDIkv755ghVUrOQeJ2kZCTrtSU/eu07U4u3n68SlMXKDGavNF4Un
	eWr8MQ1LmkZijIjVcsK+XP7JPiUjS+/ryYN2jKDFcqwqs65/OQuFmg==
X-Google-Smtp-Source: AGHT+IHT4vI6hH5UHmjiil8kr+jszmy7QoRwyrP7c3v14WFztu/DTBGJ8BY38gKu44cp3581f9I0VA==
X-Received: by 2002:a17:903:2312:b0:216:69ca:770b with SMTP id d9443c01a7336-21c3550eaacmr736564255ad.12.1738054022485;
        Tue, 28 Jan 2025 00:47:02 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:02 -0800 (PST)
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
Subject: [PATCH bpf-next v7 05/13] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Tue, 28 Jan 2025 16:46:12 +0800
Message-Id: <20250128084620.57547-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
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


