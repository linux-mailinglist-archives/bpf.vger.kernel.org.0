Return-Path: <bpf+bounces-46354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED889E814E
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8AF18847C3
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083914F9ED;
	Sat,  7 Dec 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PILyNm28"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53D42A9B;
	Sat,  7 Dec 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593112; cv=none; b=HJyhNQuHtnAs8oVAR75TFWeQc/yGX+bhjf2irq4J8UxQOU3OvGiO6P88QNpRmeL24jhceh9FaMtwCsn6NQdlAqt/Ol9U4PcT3eJjVpQ518DYoAdtcED8UkYd3y45T7neQXdBrnsHx1mBpFDuEtloPrkVkYK4uUJ3c9H/s2PSeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593112; c=relaxed/simple;
	bh=06LU3PN2LIfmwscR/LZxftU+4nxCBfsuInwzYsviXD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqfmtrl2QZmaydTFFBFdizyrwL2FX9ZWPDmQX6VakRRSC3VqcLshOwDQ/jrlyyN5biCviwqMn1adMHB6jrirmwsQALwCb0lsHZw4R5edtZvZtJF9IGnFdCwSoZOA+XpkVLERN5OenncUXoTK2QrNYY9WMKCx1V9X8B1XPwqtrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PILyNm28; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so1146979a12.2;
        Sat, 07 Dec 2024 09:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593110; x=1734197910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfhKvZmgJ3rN19OMmm6l89z4fv+IJn/AoCGuTyb0i9M=;
        b=PILyNm284N76mUZr9OO9ySfpsLWtp0rIgQvjASivqLCNJ4FcVShTE50q12flqrmcXC
         IVs5Ey+qm5f1+cMq7rBk1bQWp0od/8FlIoAttuXPOYJDeE8qB/cXFUi4EdDnvQpbUc+5
         q4GmX9uQIZ1dFeJ2+tcGdvfkcps/WsaAcT93LBBiWxnTUust9KgF+/XgpYnIuKT830e6
         18kDXDj/gMEsWig/nkgRlgM71YpvSEHokq6QQnyhIeJBZYm+Sinl8yfkiS9Ykn42tW6c
         ROcNFDYzyVMAn8Aclj1EbscNV5oKU28JX+wopXVFXbmMGSXvifaM+0tflnd6nta6em5V
         XhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593110; x=1734197910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfhKvZmgJ3rN19OMmm6l89z4fv+IJn/AoCGuTyb0i9M=;
        b=KWpWB2OenW0kotiCAUo0k4KWtGqJdHYOyBGAszoORb93ovCtegWOwZjDl8ZCXUme5X
         fPi2gsI6IImh0xTClvOSnUjyup72seZxKdDU0nYsYgN7Ob3K/6QsQm4dLGCsYF7FdIIO
         MXH7FD7DPnWDB1k7j4NnaKefIXHTrW4ylUSTBJIJdcKIfyX/i3vUYTi6+0wreIxlXVAA
         M+Z2jyzpMLqn5C/eaTl61Lr2lbv+/foGo3tNzjRY2ZYJfIZvjgSmOo7vH8hqauUpAdY+
         YcHdYn7PLlYv0wOr669dDcLSKDQfA32X5Xz6U9/pR4r3yBxi/3rmIYTVC3A2Woc8dVYp
         G8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXO9FUgMpmFBmK23cpBFYBkOGfMabPU0wszYlx+4TIKv352lT7B787dLwT1rFV/SKiqtJaG98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqq2SCNHZVl/LNxVqWqymf+rJe+ZTPtFJGN6E9kvfsG6pc1g/Q
	1rVVn6+OzOY0uP5rAMBxttlQGTewu0ymQMb+jaleH1B3ZCLdQDLi
X-Gm-Gg: ASbGncsUvN8EeoydazblPoyHpDN1HPkepP2V+XMv0Eoo5adr1mM50rob7uOc74+aPq5
	WPJQWEYPL8jKjfeRhPbP9a3IW+tScADO4Td6/gOobloRKs5r+C38xHyBuNYnNAPnGhYbVM/65BD
	40GNKoEDQ2Qx11soHjWl4h4KboAeR26OHYV9XLN6BUoaFbYugOoIItAHxXRFXLc6dQgnzoRcPwN
	1wHhWDcnJPKNlqRNXNE38U1qGI1H3gqOCJ5aADhF6LtEC2FQGxaYyN5K+ibjC3YRm+J43q6eTmc
	MMOSXY5vVIOs
X-Google-Smtp-Source: AGHT+IGCbiq0+Pk54tHWA7qCTsitcvbbRVfW8oT29MinKFP/HPLNp6eQfa2NRFAF7Once+3XPQTmmQ==
X-Received: by 2002:a17:90b:5386:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2ef6ab29ceamr11628407a91.35.1733593110329;
        Sat, 07 Dec 2024 09:38:30 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:30 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 03/11] net-timestamp: reorganize in skb_tstamp_tx_output()
Date: Sun,  8 Dec 2024 01:37:55 +0800
Message-Id: <20241207173803.90744-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's a prep for bpf print function later. This patch only puts the
original generating logic into one function, so that we integrate
bpf print easily. No functional changes here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/skbuff.h |  4 ++--
 net/core/dev.c         |  3 +--
 net/core/skbuff.c      | 41 +++++++++++++++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 58009fa66102..53c6913560e4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -39,6 +39,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <uapi/linux/errqueue.h>
 
 /**
  * DOC: skb checksums
@@ -4535,8 +4536,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
-		skb_tstamp_tx(skb, NULL);
+	__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
 }
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 45a8c3dd4a64..5d584950564b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4350,8 +4350,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
-		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
+	__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
 
 	/* Disable soft irqs for various locks below. Also
 	 * stops preemption for RCU.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..74b840ffaf94 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,10 +5539,10 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
-void __skb_tstamp_tx(struct sk_buff *orig_skb,
-		     const struct sk_buff *ack_skb,
-		     struct skb_shared_hwtstamps *hwtstamps,
-		     struct sock *sk, int tstype)
+static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
+				 const struct sk_buff *ack_skb,
+				 struct skb_shared_hwtstamps *hwtstamps,
+				 struct sock *sk, int tstype)
 {
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
@@ -5594,13 +5594,42 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
+
+static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype)
+{
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
+			return true;
+		return false;
+	case SCM_TSTAMP_SND:
+		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP))
+			return true;
+		return false;
+	case SCM_TSTAMP_ACK:
+		if (TCP_SKB_CB(skb)->txstamp_ack)
+			return true;
+		return false;
+	}
+
+	return false;
+}
+
+void __skb_tstamp_tx(struct sk_buff *orig_skb,
+		     const struct sk_buff *ack_skb,
+		     struct skb_shared_hwtstamps *hwtstamps,
+		     struct sock *sk, int tstype)
+{
+	if (unlikely(skb_tstamp_is_set(orig_skb, tstype)))
+		skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
+}
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 
 void skb_tstamp_tx(struct sk_buff *orig_skb,
 		   struct skb_shared_hwtstamps *hwtstamps)
 {
-	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
-			       SCM_TSTAMP_SND);
+	return skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk,
+				    SCM_TSTAMP_SND);
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
 
-- 
2.37.3


