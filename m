Return-Path: <bpf+bounces-77456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A9CE037C
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32A4C302CF52
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302319258E;
	Sun, 28 Dec 2025 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK7P8cJr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459713D539
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881363; cv=none; b=KYdsOnLKyXfgxMGxvYkimV/pjxdmlx6GIEM9EFKJPcnHBe2POnZ0SX98mURxfCwzzMvcm9eOXOoKxDYmDiqoLMtt1DkkRizIpuUY5y2FrMPusbfPNwT7a+xEa6dJcl0+a/6qkpUyXoh+eqaqB4NjVrjDyLYpEJg90/vrB0x7S9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881363; c=relaxed/simple;
	bh=nH0ioqPLX4Yonzd0paxLct1of3dBym1CbG7xOH6U/JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOnCG4F/ldB0xqM+1G0ZXBni3Nv9QLDDdrU5d6e0/w5+qqJUEkurXZz7JRs8GNrfqao3Jou+TQ5cy9Ljkr0JvfLBHquJUUXR0YgsUhLCACO/QRHE8HgBu7FysmDY8/gnC7BbhsrNv1jGO0wSMRVSvjjihIwPJhEoPMI5/Mj0g08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK7P8cJr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a102494058so44778675ad.0
        for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 16:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881361; x=1767486161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVd7onUGI6GCcC+6roCNasvSI9b/C7exSzA691i4SCI=;
        b=mK7P8cJrIH7FM9O369MjvpGHEfBsNb6fqmt53NwQ4NG3O+lY4hlxFb0lnSSQYy4Yno
         s4nm20I6MY28Slp1YeUh2ajQCY9e1vGXe7JYLdJmzUzyZ0zBbQ3p0xZ8BGg+yyVs+M1L
         ofmSgn7sJxbkXmUgK8Lvnc0dLnr3V/N1Ore5+bb+zSbUT4ioajInEIOEjaUUDQvFxEHE
         b6xgme25ibBIzY3MXu4igo/+dFdFwDH+Gl7+ojNOUg7392zAjmoUe2UfrHtPMHppw2Nf
         OWfvAZkTCBJjcTbYiMLubSgWxdT/Gfplz//7NI1R3Q+VnJkuGP+fF5pHw6opTflIHVnG
         AUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881361; x=1767486161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVd7onUGI6GCcC+6roCNasvSI9b/C7exSzA691i4SCI=;
        b=njqXXDSTX1SlBI0o6l9imQvpo32Z/mHhruiJMXlLRZVVEKNjUtFxEuKe/KWmohh1l4
         +2k5xe71zObYIl+3bKCrsDz1aRGZuy921gijOzF1TMpClkUyXirvjdhneVb6TtCx3thL
         pxVSK3yyaoiX81xuzP6BciZ8AoUe0AS9vui5AKEQmQ5csQ02Lu0Bju2hp5WroQzFKXkL
         f8ZrucOQTX9hRx2b3KjJtJFDjfr/0EtlmCOUY4Aq1R1F9NN1GcdPwh4LzrS4qNVAGNnI
         iWMghJCpW5AK3i3Axtc5JseDS/+4CmEjBuGtPjpKYjhodFvuK/Xq1+706pCAseDdPzi1
         ddog==
X-Forwarded-Encrypted: i=1; AJvYcCVIESjCCkCdZJxuAO37z6vDCM+LnKa/d3ZqGufD/KWezb8fia5Ntexw5brHxYI/fPozOVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKj/akiQI/vFrsrym8LtaooDZTAh+wOelbuRWjSssgQdFArJ5
	bfzqOWPnbRKX/PFezstKJKWVw3TesY82g8jJMfPH08V754b5v2BHjX01
X-Gm-Gg: AY/fxX5Y23IpL14hhr7g0w+UQMZrp8557GFZcPCIg+PE7XyJGl0DRrYKY3GBxeZk2Kv
	U2upTPf3cQjOvfBqJsfK3Uq5agXWY4A9FIOX5oSRzbX8dzNZFKnztb9ctEVp13Yh62LyQuC445N
	0VcGJiAr5s91YM7o9LykA5dsiZYCKpNiMqyMrChpZRCQfB2D3HgkLlHy365d8yh/NWMmzMxOIN/
	es5RI+uZHI84i9Uwb/CrH9mQx0Cai9pRRveMWCDRNAaivigMdnez+3oE0nzCQAoT5NDxN529nLB
	8AEHAvIfBKd63xvgxuNE0mXbLjj9mKUd+CLycwSDGWEXWIB4u6q6kON0nVrWrbz1t+QWFh61VKC
	t5R0D/IT5NG1HOWR0s0bXIYnXbvoUzfWjTcBOTTBTCuhCnQN32KkRF28AYhkNls+FL6wgRoBcee
	kjO5XAOLYVErCceu1B
X-Google-Smtp-Source: AGHT+IHnJx96JcTkwa7/Meqg9VcjVLeapIaaXJr0nmMmS3POIYTzspnaw7XBWQ1zVCR8aUnx0gqRLg==
X-Received: by 2002:a17:902:e74c:b0:299:bda7:ae45 with SMTP id d9443c01a7336-2a2cab60b33mr285565035ad.25.1766881360763;
        Sat, 27 Dec 2025 16:22:40 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:39 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v5 2/4] skmsg: implement slab allocator cache for sk_msg
Date: Sat, 27 Dec 2025 16:22:17 -0800
Message-Id: <20251228002219.1183459-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Optimizing redirect ingress performance requires frequent allocation and
deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
sk_msg to reduce memory allocation overhead and improve performance.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/linux/skmsg.h | 21 ++++++++++++---------
 net/core/skmsg.c      | 28 +++++++++++++++++++++-------
 net/ipv4/tcp_bpf.c    |  5 ++---
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 84ec69568bb7..61e2c2e6840b 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -121,6 +121,7 @@ struct sk_psock {
 	struct rcu_work			rwork;
 };
 
+struct sk_msg *sk_msg_alloc(gfp_t gfp);
 int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
 		  int elem_first_coalesce);
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
@@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
 bool sk_msg_is_readable(struct sock *sk);
 
+extern struct kmem_cache *sk_msg_cachep;
+
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
 {
 	WARN_ON(i == msg->sg.end && bytes);
@@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static inline void kfree_sk_msg(struct sk_msg *msg)
+{
+	if (msg->skb)
+		consume_skb(msg->skb);
+	kmem_cache_free(sk_msg_cachep, msg);
+}
+
 static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
@@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 		ret = true;
 	} else {
 		sk_msg_free(psock->sk, msg);
-		kfree(msg);
+		kfree_sk_msg(msg);
 		ret = false;
 	}
 	spin_unlock_bh(&psock->ingress_lock);
@@ -378,13 +388,6 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
 	return psock ? list_empty(&psock->ingress_msg) : true;
 }
 
-static inline void kfree_sk_msg(struct sk_msg *msg)
-{
-	if (msg->skb)
-		consume_skb(msg->skb);
-	kfree(msg);
-}
-
 static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 {
 	struct sock *sk = psock->sk;
@@ -441,7 +444,7 @@ static inline void sk_psock_cork_free(struct sk_psock *psock)
 {
 	if (psock->cork) {
 		sk_msg_free(psock->sk, psock->cork);
-		kfree(psock->cork);
+		kfree_sk_msg(psock->cork);
 		psock->cork = NULL;
 	}
 }
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0812e01e3171..45ff311ccf49 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -10,6 +10,8 @@
 #include <net/tls.h>
 #include <trace/events/sock.h>
 
+struct kmem_cache *sk_msg_cachep;
+
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
 	if (msg->sg.end > msg->sg.start &&
@@ -503,16 +505,17 @@ bool sk_msg_is_readable(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_msg_is_readable);
 
-static struct sk_msg *alloc_sk_msg(gfp_t gfp)
+struct sk_msg *sk_msg_alloc(gfp_t gfp)
 {
 	struct sk_msg *msg;
 
-	msg = kzalloc(sizeof(*msg), gfp | __GFP_NOWARN);
+	msg = kmem_cache_zalloc(sk_msg_cachep, gfp | __GFP_NOWARN);
 	if (unlikely(!msg))
 		return NULL;
 	sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
 	return msg;
 }
+EXPORT_SYMBOL_GPL(sk_msg_alloc);
 
 static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
 						  struct sk_buff *skb)
@@ -523,7 +526,7 @@ static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
 	if (!sk_rmem_schedule(sk, skb, skb->truesize))
 		return NULL;
 
-	return alloc_sk_msg(GFP_KERNEL);
+	return sk_msg_alloc(GFP_KERNEL);
 }
 
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
@@ -598,7 +601,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
-		kfree(msg);
+		kfree_sk_msg(msg);
 	return err;
 }
 
@@ -609,7 +612,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
 				     u32 off, u32 len, bool take_ref)
 {
-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
+	struct sk_msg *msg = sk_msg_alloc(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
 	int err;
 
@@ -618,7 +621,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
-		kfree(msg);
+		kfree_sk_msg(msg);
 	return err;
 }
 
@@ -802,7 +805,7 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 		if (!msg->skb)
 			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
-		kfree(msg);
+		kfree_sk_msg(msg);
 	}
 }
 
@@ -1287,3 +1290,14 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	sk->sk_data_ready = psock->saved_data_ready;
 	psock->saved_data_ready = NULL;
 }
+
+static int __init sk_msg_cachep_init(void)
+{
+	sk_msg_cachep = kmem_cache_create("sk_msg_cachep",
+					  sizeof(struct sk_msg),
+					  0,
+					  SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
+					  NULL);
+	return 0;
+}
+late_initcall(sk_msg_cachep_init);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a0a385e07094..ed049a912a23 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -38,7 +38,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 	struct sk_msg *tmp;
 	int i, ret = 0;
 
-	tmp = kzalloc(sizeof(*tmp), __GFP_NOWARN | GFP_KERNEL);
+	tmp = sk_msg_alloc(GFP_KERNEL);
 	if (unlikely(!tmp))
 		return -ENOMEM;
 
@@ -406,8 +406,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	    msg->cork_bytes > msg->sg.size && !enospc) {
 		psock->cork_bytes = msg->cork_bytes - msg->sg.size;
 		if (!psock->cork) {
-			psock->cork = kzalloc(sizeof(*psock->cork),
-					      GFP_ATOMIC | __GFP_NOWARN);
+			psock->cork = sk_msg_alloc(GFP_ATOMIC);
 			if (!psock->cork) {
 				sk_msg_free(sk, msg);
 				*copied = 0;
-- 
2.34.1


