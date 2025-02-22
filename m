Return-Path: <bpf+bounces-52255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BFA40AF9
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ED117783C
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F8420C021;
	Sat, 22 Feb 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th1rh+8B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBF20B7F7;
	Sat, 22 Feb 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249071; cv=none; b=UhYEgPI1h5THZXKykrPNypP/ZP6UITOaqkvnqjqz+qUeMskC1oRAloFr4BiZiJ12vLSKpOhElHHc2U5LMDb7Go5Wp1Lf3qKAaG9HoFIx9jVWaWNgY4MTFB8U78TCvlF5280DeIQqnlS3ZdYKg/oFohszIj+JobSxyVnWiB8OKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249071; c=relaxed/simple;
	bh=TI6cHoVsKSwW28kVC+WGOqjAE3DLRsM5y2hXa7t02hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjFRFfGRET1lsQfyY0SMcC0memwOG2g8O8pe60eZhkShElLgWn8dpuj6TVC1pfBefeArzU3/9eMkErQ3VgLifKLX4fsj9++o0zCCJiM+85J2MjN773tJmRLM8JjWmZF67mC5Y9fvyAFYzEkWwCHeNxn2lwn1bGYa0FkGnDetBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th1rh+8B; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so7340712a91.0;
        Sat, 22 Feb 2025 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740249068; x=1740853868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wOjim4xlZk082hyKSlOHixdefH2Pq7iWo7w1+sb9so=;
        b=Th1rh+8B/1pdz+F63EcWeRYsJJMxqhQvggxkzIyQxTFQfXzBFZ3SRs5cK7jJon3tl/
         vU8upeVoWQmOKnFxnHOJw8/g7bB6XDJa8+aO8qThSbdA4xcU0H86GtXy+qQpp2ieyocK
         QT8dVU1bk6ME7+xT/rQoZk2I9EKRYszZj9lLwumL5n0vs0DA/EhGaRvqHV+T2Pl0u+Aa
         dbE09LNV16UDKFTF/TzSK/MNfXQqUXtS2cGNQYVT2PQMgGYwTbPVwF+rn1hUjAz0CnVq
         Xyq3sNYltmz6/BgcpgcWHUcTLFPFKcXqxUSi/M7a52qvnbnqjuJjAw2E5YRE0CSPYMJg
         8Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249068; x=1740853868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wOjim4xlZk082hyKSlOHixdefH2Pq7iWo7w1+sb9so=;
        b=QbX95ZXkk5Rl+02mSejVdFTmcLLqu0SJEScIKjhbOUePZ+8xgj+FK+iSJx27O/wG++
         yBQNCt8O+stCaEcY5St72NQOnY8a5I0mWJJsHd57RHosZd/6tT5jBb3CEp7P3o3k7Jv9
         +ZSqn1N8NL4O16GFRwFnaRzzb+hZ4T+47CLSedoPs1lDkwSFOGxrsda5PI7WMAD2CJae
         p6jYsGGdwzTH2o2ZayODi18B8+MYhYti/4Qqcg5Hhg7rMcSeBRvzWE3hl/ay7980cAi5
         J60CWO9UUHYN1RwX3BNlv/gSJeQwg8ofaHvyHTR6KwFlxNGyjx98KZSy/QjFT+v/NsSI
         091g==
X-Gm-Message-State: AOJu0YwnVT3cb3LFL8psv9XYHhOauqHoclHmtzusLUBVpQvYaZxqKLv3
	0qoNWUFKMazg2kJcLRFdBNcHwi+/iP64vFlhh1ZntOtUcdvbIUdmVHuipg==
X-Gm-Gg: ASbGnctRtHXYhIMBouLTZ9xRrikK61mRXGa5UAnl0+FqnTxl3qHVyHo06cJDlQm4jLn
	VQV4LwurZ+8q9DJuVKhiL0Tr2AC/GPnYa/4BiNAl8jnt1Suiy64sofeoUY3XZljTbS9rfFQqPOL
	fQ2gdu8IozAdFa9INUf0ql8gElNsVO62CGlv0QeOGTIDUokd4X1js6oKAOmTRz55sx0ZabaJfTo
	ywv8FjYlOKMHCPVJRKKnDZ1RuTE3LcrTGLfY8C/N6N1ftxBzUsA0B2TBSPYkoO7PLlqPYHMtJHw
	88o7d9QDHyIc5fca10KnWrwqP5hAXA/idNXWBcmz7M3jP9gJjawnWmo=
X-Google-Smtp-Source: AGHT+IFiQllMOo7IZ27br3pEb/4UmsFTPjSJV4qpYiYd939IwuiLI8MyRqU3mqUt3nFVh/YEpAa1Cg==
X-Received: by 2002:a05:6a20:a11b:b0:1ee:cfec:9e5e with SMTP id adf61e73a8af0-1eef3e1ec9fmr12613439637.21.1740249068189;
        Sat, 22 Feb 2025 10:31:08 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2714:159c:631a:37c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73250dd701bsm16442959b3a.131.2025.02.22.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 10:31:07 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zhoufeng.zf@bytedance.com,
	zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next 2/4] skmsg: implement slab allocator cache for sk_msg
Date: Sat, 22 Feb 2025 10:30:55 -0800
Message-Id: <20250222183057.800800-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
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

Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/linux/skmsg.h | 21 ++++++++++++---------
 net/core/skmsg.c      | 28 +++++++++++++++++++++-------
 net/ipv4/tcp_bpf.c    |  5 ++---
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d6f0a8cd73c4..bf28ce9b5fdb 100644
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
index 4695cbd9c16f..25c53c8c9857 100644
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
@@ -592,7 +595,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
 	if (err < 0)
-		kfree(msg);
+		kfree_sk_msg(msg);
 	return err;
 }
 
@@ -603,7 +606,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
 				     u32 off, u32 len)
 {
-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
+	struct sk_msg *msg = sk_msg_alloc(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
 	int err;
 
@@ -612,7 +615,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
 	if (err < 0)
-		kfree(msg);
+		kfree_sk_msg(msg);
 	return err;
 }
 
@@ -781,7 +784,7 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 		if (!msg->skb)
 			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
-		kfree(msg);
+		kfree_sk_msg(msg);
 	}
 }
 
@@ -1266,3 +1269,14 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
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
index 85b64ffc20c6..f0ef41c951e2 100644
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
 			if (!psock->cork)
 				return -ENOMEM;
 		}
-- 
2.34.1


