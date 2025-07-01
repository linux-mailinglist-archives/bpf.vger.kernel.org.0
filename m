Return-Path: <bpf+bounces-61925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9733AEEBD6
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7386C189D4F2
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F541A0BC5;
	Tue,  1 Jul 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu5COfOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067291CAB3;
	Tue,  1 Jul 2025 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332349; cv=none; b=hCQ6wQynKmUkNss+6wEjaJ9bvrp4nHDnAsxx/ootaQoH8WH02JazH/9zcKwPiH1kFEJhxRU0AbD+RnsldIZywkwBdPn/kBeFrcBEzuyJmCwcbBZwbrkUDCl33sRlR1Eylv2bzULOzv29ad+o0t3cLI+3ZAwbdptZsvMqOooRwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332349; c=relaxed/simple;
	bh=CxHtjc+h/0S3AocQZUDI0kJwwWJzK2BnH05I/48CLzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7AaTH6aECXSckAsBmRU+6hM6LQW8vMZ26JFg1SlrzWVau/OelvJySpk34IKSRvipnhXuK2mEl/jVXRTdGhDxx2iSkrJK8F+lkCGB19VeHszizXrrA1OGKIRxxcudLjMeno8vzG1DK/0IBOe3GKljf1A1ALyKw2EPc1NwCKc/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu5COfOC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so5012166a91.0;
        Mon, 30 Jun 2025 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332347; x=1751937147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIgnuTooXBjk8HlY1JAYf+Yloa8rGBo7wnb43YjiE0M=;
        b=fu5COfOCpeL4voQT41Eo/hYqOm5BOdYkXEtT6YCLE7Qp75QVuBMxf/7pQXNNNT+Uos
         /OvAWiCX+hRS/6Y823nnNYasTFnotb9J7IZ5JIYKhH5YF12PMH8VpYqgdtDNfo0x29q1
         u9FjblumTgs8Nks5gT//3oc72X6NXIyJaOulMuhpjNwnA68pj1D/qmY16UYnIMyM7ogo
         WeubyOmZ42L8ILUC87CX7+XB/zTAwkdITrJO3WbPf3QhjFdo+TR9aHkbwkgjfDKsq17u
         3f6pckHMqA85BiP/xAwIzBm1GrjJ89YfcGu+B8RssVplT3mKmssnIh4+/Fs/6ZsMrjXU
         lyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332347; x=1751937147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIgnuTooXBjk8HlY1JAYf+Yloa8rGBo7wnb43YjiE0M=;
        b=ivF5aeFc+MZacNFoQPlHbrSgddFGXT8gia4dFTL/xxnyqVLxxYgIPnXOHiLEAzEKNQ
         1uKPJUFOlG+9MMeZFdQFRpReMdR4hRX/wJ5W9zq4+wbJrZLVmqfhELa8R1ABLAttRf3l
         QgjPtZmzAee9MhKqSONFwR0+N+kfmVcdtKMgds0AQN+9VcbbyMdK+XfCfmD2QU5TGmt3
         BUamMw7aFyaqhEUgPBccgaMvcWRQU8z9LMbO8CNqyfQBF7CvGj62j+yEoWmU3wPfsLLa
         QAUvJVKU7aPaXbxIgaVE/Vc8jHZiXPRmS4LPlxAD2k4bbhvBivBUgNMWVot8+AwnK4Ek
         zP3Q==
X-Gm-Message-State: AOJu0Yzp5PE+lXOzqnsN7AI3Hah4qiLLJAz5iemunKxkSmUfwWjVeN2U
	U/PYwbUSwSqni7uDgZHs76fd2BFkhz1SnqAVTylE8jDm7XfcjLwEUnHY8OTX9Q==
X-Gm-Gg: ASbGncsVkBrE6YjscGWjvN6ZWz6UiMj2PnLUzK5VpYEN5vrN4Ndb09Xv/0zOl8AIcnb
	lNskLmPc6IL7xnp5/ODVAriECgAFSc6n9Gu2CSEtEyE+F9kBRlbqXvi2W3SmMc+wn0mE4uPezpf
	chqAkaPKKmQyUg1OsPv+Tp8QHpkQ5LzOznVogexpOm6DJZ8vzSszbZKjkOwGCc+ayCpy4KElsi7
	1JmmGs03x6czqw7wcvNk8n4nR8SLNHgGTYLZyKL1GghFyJLhva56wrQp2PjVPI3K5XgkBsFphfG
	2mo6ebV/sKQogLIg2fRkMDm4uJ7xtB4Nuv2dV19Qt2XaA2wqyDLce+PMCa3A44oXvjFKMKdc
X-Google-Smtp-Source: AGHT+IFuButku/E+7UjT2Y+q9xQWQJ86dsMzCm5Pz5iNsKJdQoOpAN9UmynkyLp7meFo+59GbnYd0A==
X-Received: by 2002:a17:90b:4c8e:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-31939ad81c3mr2521952a91.8.1751332346603;
        Mon, 30 Jun 2025 18:12:26 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfbesm100007455ad.109.2025.06.30.18.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:12:25 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v4 2/4] skmsg: implement slab allocator cache for sk_msg
Date: Mon, 30 Jun 2025 18:11:59 -0700
Message-Id: <20250701011201.235392-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
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
index 0939356828a4..5aafa5817394 100644
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
 
@@ -795,7 +798,7 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 		if (!msg->skb)
 			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
-		kfree(msg);
+		kfree_sk_msg(msg);
 	}
 }
 
@@ -1280,3 +1283,14 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
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


