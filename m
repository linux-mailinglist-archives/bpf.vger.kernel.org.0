Return-Path: <bpf+bounces-53512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DAA5593A
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2650D176CD3
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035127C868;
	Thu,  6 Mar 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW9v3IJd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48B278147;
	Thu,  6 Mar 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298565; cv=none; b=g9cJGlPer2JFu8UWLQFewm8qJcy8lIkZoSjWTbHHXw5znzc9Bb3HJ+Z+F+Ec3GWzQv1H7qLG7cQEpBiquC9b+2Xv8JN2GKUd3S8+YaJTtDtObWEQyX+8oX6vZv1n6JS21QCRbCeRQYaqGT1ySMvxgIgxoYSlROG0PPA7B8rfvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298565; c=relaxed/simple;
	bh=TI6cHoVsKSwW28kVC+WGOqjAE3DLRsM5y2hXa7t02hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuZE8smAZlCk2LiqrASeKkU4yunyJZi8k7/E1F0gvAClOtNrVjXMgWGHK7JzbuH8AYom2xmuC/rDSwJhSQyA1OEZta4Hnn9t3boYiUx3gvHh6owj+fJlfLqqnsyCIzMVtarNmnVIp4cDvc0EBhYhmMUsBeRHNyNl/FWGH+w4gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW9v3IJd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239aa5da08so19348835ad.3;
        Thu, 06 Mar 2025 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741298563; x=1741903363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wOjim4xlZk082hyKSlOHixdefH2Pq7iWo7w1+sb9so=;
        b=GW9v3IJdCNPj0wy5DeFwV7gw/FDc9rjC3nor9KXOCTNWySkWdzfYQU6viExB3GqzoA
         Pv6eAGc3HBZqYdz8HYAl4j93t8tvj9eoOM5FHUKSY8TjkbfjqhywP/Snv57MJ860Hl53
         Zt2prLhKdVlQr5PtQZDHVatKoVv/cVRWt4QT2Al4KcBqJ/GadoBAiVNDEDAtyMtiOJW2
         gwKgtPWH+ps/XGIH+XykOYRs/KqWe0I9P7CZpO93nCTQuR7xwJcMJ50eukCUzwVslRYk
         TNTLUklBed6C84xkOQW/xJ4cfgKD9CPpZ85ABfFmv/3V5YABJxK5mA8tvTf/l689iMtZ
         lOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298563; x=1741903363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wOjim4xlZk082hyKSlOHixdefH2Pq7iWo7w1+sb9so=;
        b=kSgwgMSmfPZpj3pBbeejnqTu5Q4qCUrz8idD9JjtEFYxOtUCOvknixb4UCEpiSSSB0
         Tcm7otuGGFLDt31rfxq2xx45xnR5USamkwQyL4TRqFp8Egp7VOHlr1lidObmmwZEhMQv
         +OyR+vacp5GqzekyplS8x+A/v63qvTJ7Bf7l23Tx21f9SMM7+Ve1GhKI0zWOIvgzmpLc
         Zv4vPef9YWE9TFc8WRbz9WIJwwnRbhNk29oU+KAcNgks2uCXzq0EbMfHe26txnpnOGjF
         KW7bW+gT/6G54++x1BEhuyYAnT2EUrTaOoeU+ipulMnqrH75GZ1gZfx+egcR4xsJuF4a
         RhkA==
X-Gm-Message-State: AOJu0Ywv6Pu8ddgvVtNixJVo3kWkihWdsS+0Yzt0AanFwNTLrxlflGXd
	ak0oxiZP8tGpJE3r+4lYfKTm9raASaqmZcWawvIzjcyZT6gg8b6+dTicCw==
X-Gm-Gg: ASbGncsYVss1F7jQnHuDErJERLb+K0OxdfMQehvn407kqyyAroKzKm+5r7UIFcG4ULP
	fq3BCYW7burkN+3FRT59ppiGANG0cZ8gIaCrJe0OiqxJwzib1bw+M+1TCZh01F+GGLBk84Bx51O
	CAOOqGyTVqEJI4t/XTbWLDkoXof7zNoLFwMeGyDP7K5KF6uhfPlI5sxTTKD1tysRoBfDtjF0jRo
	NVCq8fYmocYVEqKit96Wxqu1L59gD9JMfV+dCxxvRIV1DdnXhWnfEZzf6gIKfq/J+GGG8XMMk8Q
	TnA5PtR0Xv2TZvzf8gmDHOWUpH3mgc6ZQlSt89XwIvVLuaLZlP4T8fA=
X-Google-Smtp-Source: AGHT+IHlmg5yjU0TwztG/03Ghzlrq+tvO+b2rhfuDORrvfmvfKYyXT4W0o9z7BxkDk5FzA/TOnCXHQ==
X-Received: by 2002:a17:902:e88d:b0:21f:768:cced with SMTP id d9443c01a7336-22428886828mr12993815ad.8.1741298562961;
        Thu, 06 Mar 2025 14:02:42 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfa6sm17478775ad.33.2025.03.06.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 14:02:42 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v2 2/4] skmsg: implement slab allocator cache for sk_msg
Date: Thu,  6 Mar 2025 14:02:03 -0800
Message-Id: <20250306220205.53753-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
References: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
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


