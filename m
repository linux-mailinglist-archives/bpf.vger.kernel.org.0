Return-Path: <bpf+bounces-75716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F2C922CF
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9D4E60D2
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624023D7F5;
	Fri, 28 Nov 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMvD/KVB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D31C701F
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337586; cv=none; b=tcy46HU32LN/jsCxU2OUjdjCvfxAhFSnUSRFTaVRr9Q3LVoGfOuBMqIfVzzyoZsPfhN1mjpDfd+lGGs1nFr7y+uACTp4y8F4+Us0Tet6IO4y2AC8KwXSW2IWw8U5bFvSv4XZ+Ee8qhRk2RKqD9FeRKJ0bIfe15blHTEs78hlbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337586; c=relaxed/simple;
	bh=KR4grrT8SD955/MgFQUYQtPvjQ/NO97IWPVFe4EfgGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHag6NBi8cM56Zmier//uycv6IS0WE/rPMEDacVGO47QPXIJRVhlcK89pzl1ASQA4dAWg4qQi4QqUCyUlto50ncfU5Ytc8a3H4AiZAooTG0gPILHfUZkCBHALLDHuClGOEM2DguJdKVIozr+hVv7U1zjhfaPcBscteeVLlaTP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMvD/KVB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1820061b3a.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337584; x=1764942384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpxD35MumNPzTl+ELYmx5t3jmJ1EzXuG/pCsj8wGD00=;
        b=UMvD/KVBtn86VuMdmnsGZxewjXBSAcF5YelKQJP4LZYeS6QrM3PO9mnwC5467jYmhV
         LxrI7/rg18wcPW3utRaW1zLZgzjqWubuOpXZ8R1bSrSwaSs5IxVnue/HoMVqt6gqpg5e
         1GWtU0umLyYT5yjFZsWOAESTH5+HmeaqHEcXPRUdymxRutoGF2PaHsITCIxKI1pTggev
         EO0FeGqblxnJJJMKKbwpo00FuirWES489Eo4ZZGuGksYbDOYub/e/hdjPrJxU85hTO2N
         54r9HS8Ot1vSTjtOBq9F3Rmm3SbGwgzbfDaUvXn1H7y2QBL4aEOQ8HkCQBSPGRc0U42u
         cHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337584; x=1764942384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WpxD35MumNPzTl+ELYmx5t3jmJ1EzXuG/pCsj8wGD00=;
        b=kIFQoq4lYPOYdz3ifpz+grfukPdHVIIQYOds7vmI3WuzW+z4HzbHMPRD9ohOuYoM0G
         7wQbG2iJH5wd1GG0eEIUTfsG6ABHLXhurwzVCPRuv9119lHHHmKViRgNUbgoPt2PJcwh
         rEtLaG6cOEeARqyiEphVVV2W2sch8bk770DnR1L8p4d+VT7/tS5XEBdaqAV+RwZAoYkc
         CPovTnk/Ebzb7Qk06P/+UFGqX5rgB10z6/281A+e+plj6Q6Oyk5UUsgI+ewNYbFoqkMp
         vDzzabZ1fuFcv50UG/8xHcjA4DHuugLzIkp2343BG7Xw3mg8e85WckSeAmHxap+QYbkv
         GN8g==
X-Gm-Message-State: AOJu0YwTd7UX0O0WV0GzsHAsPYPENPX4wGRfX/EM3EmpY8FiirhSy472
	f5IKzCMZsiNYY2O0O8sEEaMGIU6nrM75NXMS1bjuJfMJN1Z5Mn0bNquO
X-Gm-Gg: ASbGncslJVuX5gxCxvHo/xHh7O8zSmWaNxOfgumhzUUdVqFJUlQwiJIIDUkf/4r/n3l
	FkCbnZqxu809JGyY35keWkjasqMhvTFNVBXjNxlEpV6bzzmraaXELdQYjLK4MswJzjpOv444eL/
	3adCpK7WxBAmFPlhKth9O6JYzmgLh+rNlxNzlbIr0A5shde3dkvolXNuH7AZKLoqmDjQ3xvLo0Y
	FWQtht5G3DpoRqGaIpgjAOJHa6VN1UolA1nY9gnDitFTWdhkSx++Ox7MppZUkpfodhVKNXdqo64
	ZT/v8vGnjiSfzwEuqP2CFED+35v98mRm/x8Racwwo8myyBNJKEEIoWR6VZXwt7vtmJQQhWlqyum
	BDLA6wwKVNvgKoJRolgBE9xsslQNJE78bomhB0ZbRgRR7eWY0oZTckn4uc0Ob1lW0yZqZZ65HU+
	Vj5UUW+N+bx4ifJFbLEo4GKQsLkwmtAcb4fkSJPmS7UImt8qb281vSrUJfDEA=
X-Google-Smtp-Source: AGHT+IH1Xp/RilpJaPDY23Ob1bPvy5Lw52/NTeRatwcDcPJ5Jh5g/Sv8tRwJSmrQj6zb2SgjnwP7GQ==
X-Received: by 2002:a05:6300:8b0f:b0:35f:9743:f4a with SMTP id adf61e73a8af0-36150ea9786mr31081390637.26.1764337584044;
        Fri, 28 Nov 2025 05:46:24 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:23 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 3/3] xsk: remove spin lock protection of cached_prod
Date: Fri, 28 Nov 2025 21:46:01 +0800
Message-Id: <20251128134601.54678-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128134601.54678-1-kerneljasonxing@gmail.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Remove the spin lock protection along with some functions adjusted.

Now cached_prod is fully converted to atomic, which does help in the
contended case where umem is shared between xsks.

Removing that lock can avoid manipulating one extra cacheline in the
extremely hot path which directly improves the performance by around
5% over different platforms as Paolo found[1].

[1]: https://lore.kernel.org/all/4c645223-8c52-40d3-889b-f3cf7fa09f89@redhat.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 21 ++++-----------------
 net/xdp/xsk_buff_pool.c     |  1 -
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 92a2358c6ce3..0b1abdb99c9e 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -90,11 +90,6 @@ struct xsk_buff_pool {
 	 * destructor callback.
 	 */
 	spinlock_t cq_prod_lock;
-	/* Mutual exclusion of the completion ring in the SKB mode.
-	 * Protect: when sockets share a single cq when the same netdev
-	 * and queue id is shared.
-	 */
-	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b63409b1422e..ae8a92c168b8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -546,17 +546,6 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
-{
-	int ret;
-
-	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xsk_cq_cached_prod_reserve(pool->cq);
-	spin_unlock(&pool->cq_cached_prod_lock);
-
-	return ret;
-}
-
 static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 				      struct sk_buff *skb)
 {
@@ -585,11 +574,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
-static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_cached_prod_cancel(struct xsk_buff_pool *pool, u32 n)
 {
-	spin_lock(&pool->cq_cached_prod_lock);
 	atomic_sub(n, &pool->cq->cached_prod_atomic);
-	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
@@ -643,7 +630,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	}
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs->pool, num_descs);
+	xsk_cq_cached_prod_cancel(xs->pool, num_descs);
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -860,7 +847,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-		xsk_cq_cancel_locked(xs->pool, 1);
+		xsk_cq_cached_prod_cancel(xs->pool, 1);
 	}
 
 	return ERR_PTR(err);
@@ -898,7 +885,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
+		err = xsk_cq_cached_prod_reserve(xs->pool->cq);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..9539f121b290 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -91,7 +91,6 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_prod_lock);
-	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


