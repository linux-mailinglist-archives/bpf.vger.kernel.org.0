Return-Path: <bpf+bounces-79140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD483D28173
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5C53301EA3F
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3D3064A2;
	Thu, 15 Jan 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5fROcFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D2304972
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505280; cv=none; b=ITobzwwoSy30pI14Fcbp+Ds0p8fiGc20fBw4eGxF6gws9RenaXCCwl0ObWkGdGr/ehPGcZGl31dV0DPiCTL82u2oLqxrDWU/8/RBHWsmrGZdt4Q7xgRpQpjg1Eh2fxTlUAXpOrkdOAXWT1cYibVq1e88RaeeQUo6LJhyn1LOuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505280; c=relaxed/simple;
	bh=olTg6hXy2UOIs/E5+FMogUgEqTdZDvxa+0gcsxXuKm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6JUzokLKEqZmoMtS/b95vTD0pvPELWKBBgX5NckZNImheg/WiCOaoxTEbtWGjsMMgVZWfYxn1nuFYkJIqAJ+tsVME/02WxAs9eDgrjt7XkC+UsxuUjQnn4O9bvRDIyg5y16Xh3tTs4tnEYR4SwpH1hH3yPay4D1X9X2MjC38Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5fROcFT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a3e89aa5d0so11462605ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505273; x=1769110073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXMZV8D4SK0rj+49FcmchxTVbQT7E5LzQd3mS1H/yrc=;
        b=A5fROcFT4ugnWFn7VcPpmuIFySL0wglwKOTUfYWBSEGEW7ur/KO5vtIul98gLYLQKU
         HkS6i2exCI4IiA2mVLjeU+btKns3pu9e4oSBiqYv4olQE+CjG+Xigc3AF0iOe7tfZ1vZ
         wuqnmwtNGvBsa4LBmK8nA1HDMG3zEhxS/Q25dhiEOnn++xLI+Di3neIiUfb1Q3ccARD1
         BGNwDuEPA+DExGDTWGS2vQ7SLOVrOiio6hhPtzySNkVGKK/EirwrL2GOj7DYmRTqr1Eo
         qAJFemfOQyRjFCs7dr7DjkjwcgQWqCzfmS9OqMM6z1Ut7XzmiMk9VgUxWg1wN12ADSno
         RCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505273; x=1769110073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXMZV8D4SK0rj+49FcmchxTVbQT7E5LzQd3mS1H/yrc=;
        b=eu45/vD6B2ZHGRnlQObrNnCuIYvW9k00EJnMTgt0vmjh6Nw2hPxUEV9Arp6yjRyne3
         wmh/UqO6w/pdldivpn/ScNdXX36c8FwVEGloL6gbUbd1B/cRWfpjD+Lc7lYESoSIGMX6
         /WhNwhkuJJL64rvNI4zTJtnTmcaCj1260DwftdWSlLFAPHTOA+xiF/aPP3K2XA/vswa7
         UwBxzGgH1OEtrexQp1Ror4/j+M0zYQ3YswtRTnyCI/J7atIMMdXrDs/fRingfJBCVZ0I
         0Ivdg4tKM+i883H2ucIN5ELIIjdIMw8A+WXz0+GGXX7b8abbf93tt5UDqGXF4V2sUjSs
         XPAA==
X-Forwarded-Encrypted: i=1; AJvYcCVo18GOQtiwFjEartV/d3dMnEUJ7L0lUanSKB7Is0FNzoTXfllT6++qfVuEYiWHSooH1rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFSAoO5RHD5MxMDwbp+eoNYALCviPZ6oY6iunF+kxI/NAreN7
	UOmMql/fLMAE1AzXJjPYMVQBA6c3AfOgfdbwce36CVt0XNwXatswHH1s
X-Gm-Gg: AY/fxX7PNRiJVbiRl3XbmUfzEHQoHxDU3EhZoqvrs9xeAFhll8TbKR7mkA5X05SDp7R
	PBWPBktlvbnRDIYp+ZHvq0WyNp/OUKFYgTo2Eu2IzMG7IYTr9IH1RkN/cxh9td8hIY9NKRg1CC4
	GoH0MJl2vfaymkOITWj34gkRgv+xL/GzWphWr+UVmutIw6bEiBUHT8OyvIjSs+Qr+Ew/0jewod+
	4JC4esoMFil0l6bqx1MCih4tvzJUBJ1Lq448Px4PWQ6UXrmpMVwuFx5rIgbSaK2P13bh4aNTv0z
	m4Z3bNByLis39cQLLFrlZJaTb6xCs3bKC/FJpXxvaPyUAIwP0gpJDS5y+sC97Fcgn/60IBQEdc/
	baSUdqjmaGodXMtqo52oif4bE/ZKfy0R4GOTscnW+jQ1+OINlZUs8DgeqVKsphtAogajYT6rxaY
	otEUpb6Hwg+ny1CvLi
X-Received: by 2002:a17:902:c951:b0:2a0:de4f:ca7 with SMTP id d9443c01a7336-2a7174efc8amr5602905ad.1.1768505272756;
        Thu, 15 Jan 2026 11:27:52 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:52 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v6 2/4] skmsg: implement slab allocator cache for sk_msg
Date: Thu, 15 Jan 2026 11:27:35 -0800
Message-Id: <20260115192737.743857-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
References: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
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
 net/ipv4/tcp_bpf.c    |  9 ++++-----
 3 files changed, 37 insertions(+), 21 deletions(-)

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
index a0a385e07094..e4dd5d098a31 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -38,7 +38,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 	struct sk_msg *tmp;
 	int i, ret = 0;
 
-	tmp = kzalloc(sizeof(*tmp), __GFP_NOWARN | GFP_KERNEL);
+	tmp = sk_msg_alloc(GFP_KERNEL);
 	if (unlikely(!tmp))
 		return -ENOMEM;
 
@@ -80,7 +80,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sk_psock_data_ready(sk, psock);
 	} else {
 		sk_msg_free(sk, tmp);
-		kfree(tmp);
+		kfree_sk_msg(tmp);
 	}
 
 	release_sock(sk);
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
@@ -466,7 +465,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		}
 		if (cork) {
 			sk_msg_free(sk, msg);
-			kfree(msg);
+			kfree_sk_msg(msg);
 			msg = NULL;
 			ret = 0;
 		}
-- 
2.34.1


