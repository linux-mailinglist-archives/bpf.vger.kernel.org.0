Return-Path: <bpf+bounces-76684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C5CC1030
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2881C3028C79
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA2333452;
	Tue, 16 Dec 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0h7cjh8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74121773F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862815; cv=none; b=GUQTRbIoqz8wrVp3/048qeBKOjdaBrU4tLezo6eHBcr58gYHgWTUp7LxMDl1WZo+zAqEv9cuHtiqXV414E1ugBTR72FlbQ9pwZgx6jYRa9Knyv+G/bEFrf2Gw8Chhg9pE7Xghy4chRqqDXraIJ6tqm2U5FD5oGTUFwEV86sPEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862815; c=relaxed/simple;
	bh=a+fVJvlC/TBc5eDADonkDiB75exR/BsVvPY0FQ428C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kszS5FOHvETvpblAwzSyq6juYR92vJxiIr9Acm+Q2I6RRYZOIrrkiOFokGRpMEmv9cUN8EHQQ69meRZ6vw1s50ITEATIzZWyQdzwuqchMxrQVEfJs0U6bUHmrVdhjRwN8kUvqPsybCCXaZVTq2JoGrIJxS3DZb1Bcp9tzG4uPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0h7cjh8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a12ebe4b74so9766085ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 21:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765862799; x=1766467599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rNM+6r+R8MkfGb0CXHwbZqFiBMF7GnFB5kqmb+Nv40=;
        b=k0h7cjh820tRXr2LnbumvBJWghN9k7p1hHRcYl4lqN3SdJwpxHCSQeRxfvrVwZB6bo
         jfE92tgB2Fu3qlD4zuycTlJqJjqcxPqs3sWwYWSZF0ob48pnbMIeTqiVJ8Wk+HRIOJzb
         MwdEADWyj7RwkPSTYyERsN9Xgk62UYqRMeBenq9XkaV3U0b7RWjm3D1Ffyn877DFxBP7
         sQg+TJAg3aCY3RJ28uxncnCpHgYfQuUXKG4su7uG/uGTtauijHXaSmt4rRbYuoo45FMh
         ltYnZlQohw2t5AWUa2iVefYqCEptW1q/NmcIB3TmN1HPuEdqAifhGSodQcG5Aqs+RtIQ
         YDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765862799; x=1766467599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rNM+6r+R8MkfGb0CXHwbZqFiBMF7GnFB5kqmb+Nv40=;
        b=gPKMnhhzXcGvAlEr+UU3fbQI4khBuKV13jsNUqpd0OmS4MYdm/ApQw3j+1jQGl9Flp
         bVhVy6ewmRpCYtk6XoEX8RCZqTPYIrqYjiRUkQHR4o70BIrkGu5gFgtnpquf6EwQskjI
         BKkB7UBsH01nGhM3liY/Xmes4dJVdk2eCYHvOYRb+jwYnDpi1A7AVe4lhN0jS2qVCtaU
         0iR7RXwzo6GVFlc6dRQyTq3wnHOxW7UheShay8c3pyGH2hMAr2Jn1eMUGzTceOSm2f/C
         F0hVPx1cPcxDHuc4ohaotmHRe7qMPEe1bYeMx/cwlgJXb9DyqSkbXko1qqGVc3S7a1FS
         fE1g==
X-Gm-Message-State: AOJu0YzlZfKxL+Hn37WeLSa2XcSC3DwOwMIPyujLp+Qnp2jnVwQ8G02S
	a9UMjh2p8UwWYdX2pMky3XFMmX5Z0FoUp/QjZuqGrwoCHvDTCbeyOd01
X-Gm-Gg: AY/fxX7hb660jvjbrUeS6oK+chraEN9O1LBh8qw4GxfwduaykPITZRnZTJJadsqEzrn
	+niWL0xDyTC1SFrxNvR37QTM0dWVl7jB7VzZUVo4A5LzTbvgo48kRCdghvHW1Jj9Xv5eCWtcbo7
	7/V840RwhdC6L9YxQTex2l7U/47PnQnm5276UVpYyUo4rYkkHO2qsdTUwukuz+fZgrt/tj/RNEH
	F7N/NblTg1dMl1RpjgjDUSHIZgI+ZAIxII/lShV0duKZFhkqy5qzOyl3zijicXqsbmikSDmi0nG
	wNSbvzC+umuOaytCvCmcWlS0XTrremGnUh0xrhtD8xcnoGC6/7eT5o8+DqtURJoNMQW+LJ4IIb/
	itDU6i5OHTXtNmXuigM+MVXBUkTbyz8UCJCCpyUcIFiEZyZPWueRQ39m0X/L8txfIquNsN7lxXb
	lOQAm9fBv5B7R6q9WN06fVdbfs8MlmQYTxXEtaA26n7fk+/GubunPkXSB3oY6kqzIF45oE
X-Google-Smtp-Source: AGHT+IGLGhuibivS8s1ilU6blmXLf3gM59OTzPxvUL35+WCNKMhTYyJnmKuZj8ktY2Kywb4Vi+TTEg==
X-Received: by 2002:a17:903:1cc:b0:298:2afa:796d with SMTP id d9443c01a7336-29f23d44e59mr132526465ad.61.1765862798915;
        Mon, 15 Dec 2025 21:26:38 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ced60ff4sm61302145ad.76.2025.12.15.21.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:26:38 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v2 2/2] xsk: introduce a dedicated local completion queue for each xsk
Date: Tue, 16 Dec 2025 13:26:23 +0800
Message-Id: <20251216052623.2697-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251216052623.2697-1-kerneljasonxing@gmail.com>
References: <20251216052623.2697-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
production"), there is one issue[1] which causes the wrong publish
of descriptors in race condidtion. The above commit fixes the issue
but adds more memory operations in the xmit hot path and interrupt
context, which can cause side effect in performance.

Based on the existing infrastructure, this patch tries to propose
a new solution to fix the problem by using a pre-allocated memory
that is local completion queue to avoid frequently performing memory
functions. The benefit comes from replacing xsk_tx_generic_cache with
local cq.

The core logics are as show below:
1. allocate a new local completion queue when setting the real queue.
2. write the descriptors into the local cq in the xmit path. And
   record the prod as @start_pos that reflects the start position of
   skb in this queue so that later the skb can easily write the desc
   addr(s) from local cq to cq addrs in the destruction phase.
3. initialize the upper 24 bits of destructor_arg to store @start_pos
   in xsk_skb_init_misc().
4. Initialize the lower 8 bits of destructor_arg to store how many
   descriptors the skb owns in xsk_inc_num_desc().
5. write the desc addr(s) from the @start_addr from the local cq
   one by one into the real cq in xsk_destruct_skb(). In turn sync
   the global state of the cq as before.

The format of destructor_arg is designed as:
 ------------------------ --------
|       start_pos        |  num   |
 ------------------------ --------
Using upper 24 bits is enough to keep the temporary descriptors. And
it's also enough to use lower 8 bits to show the number of descriptors
that one skb owns.

[1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 158 +++++++++++++++++---------------------------------
 1 file changed, 53 insertions(+), 105 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9b637d5e4528..3b8720f64eb5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -41,8 +41,6 @@ struct xsk_addrs {
 	u64 addrs[MAX_SKB_FRAGS + 1];
 };
 
-static struct kmem_cache *xsk_tx_generic_cache;
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -539,81 +537,87 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
+static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
 {
+	struct xsk_buff_pool *pool = xs->pool;
+	struct local_cq *lcq = xs->lcq;
 	int ret;
 
 	spin_lock(&pool->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
 	spin_unlock(&pool->cq_cached_prod_lock);
+	if (!ret)
+		lcq->desc[lcq->prod++ & lcq->ring_mask] = addr;
 
 	return ret;
 }
 
-static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
+#define XSK_DESTRUCTOR_DESCS_SHIFT 8
+#define XSK_DESTRUCTOR_DESCS_MASK \
+	((1ULL << XSK_DESTRUCTOR_DESCS_SHIFT) - 1)
+
+static long xsk_get_destructor_arg(struct sk_buff *skb)
 {
-	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	return (long)skb_shinfo(skb)->destructor_arg;
 }
 
-static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
+static u8 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
+	long val = xsk_get_destructor_arg(skb);
+
+	return (u8)val & XSK_DESTRUCTOR_DESCS_MASK;
 }
 
-static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+/* Record the position of first desc in local cq */
+static void xsk_skb_destructor_set_addr(struct sk_buff *skb,
+					struct xdp_sock *xs)
 {
-	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+	long val;
+
+	val = ((xs->lcq->prod - 1) & xs->lcq->ring_mask) << XSK_DESTRUCTOR_DESCS_SHIFT;
+	skb_shinfo(skb)->destructor_arg = (void *)val;
 }
 
+/* Only update the lower bits to adjust number of descriptors the skb
+ * carries. We have enough bits to increase the value of number of
+ * descriptors that should be within MAX_SKB_FRAGS, so increase it by
+ * one directly.
+ */
 static void xsk_inc_num_desc(struct sk_buff *skb)
 {
-	struct xsk_addrs *xsk_addr;
+	long val = xsk_get_destructor_arg(skb) + 1;
 
-	if (!xsk_skb_destructor_is_addr(skb)) {
-		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		xsk_addr->num_descs++;
-	}
+	skb_shinfo(skb)->destructor_arg = (void *)val;
 }
 
-static u32 xsk_get_num_desc(struct sk_buff *skb)
+static u32 xsk_get_start_addr(struct sk_buff *skb)
 {
-	struct xsk_addrs *xsk_addr;
+	long val = xsk_get_destructor_arg(skb);
 
-	if (xsk_skb_destructor_is_addr(skb))
-		return 1;
+	return val >> XSK_DESTRUCTOR_DESCS_SHIFT;
+}
 
-	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
+{
+	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
+	u32 idx, addr, pos = xsk_get_start_addr(skb);
+	struct xdp_sock *xs = xdp_sk(skb->sk);
 
-	return xsk_addr->num_descs;
+	idx = xskq_get_prod(pool->cq) + desc_processed;
+	addr = xs->lcq->desc[(pos + desc_processed) & xs->lcq->ring_mask];
+	xskq_prod_write_addr(pool->cq, idx, addr);
 }
 
-static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
-				      struct sk_buff *skb)
+static void xsk_cq_submit_addr_locked(struct sk_buff *skb)
 {
-	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addrs *xsk_addr;
-	u32 descs_processed = 0;
+	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
+	u8 i, num = xsk_get_num_desc(skb);
 	unsigned long flags;
-	u32 idx, i;
 
 	spin_lock_irqsave(&pool->cq_prod_lock, flags);
-	idx = xskq_get_prod(pool->cq);
-
-	if (unlikely(num_descs > 1)) {
-		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-
-		for (i = 0; i < num_descs; i++) {
-			xskq_prod_write_addr(pool->cq, idx + descs_processed,
-					     xsk_addr->addrs[i]);
-			descs_processed++;
-		}
-		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
-	} else {
-		xskq_prod_write_addr(pool->cq, idx,
-				     xsk_skb_destructor_get_addr(skb));
-		descs_processed++;
-	}
-	xskq_prod_submit_n(pool->cq, descs_processed);
+	for (i = 0; i < num; i++)
+		xsk_cq_write_addr(skb, i);
+	xskq_prod_submit_n(pool->cq, num);
 	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
@@ -634,30 +638,23 @@ void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
+	xsk_cq_submit_addr_locked(skb);
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs)
 {
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
-	xsk_skb_destructor_set_addr(skb, addr);
+	xsk_skb_destructor_set_addr(skb, xs);
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addrs *xsk_addr;
-
-	if (unlikely(num_descs > 1)) {
-		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
-	}
 
 	skb->destructor = sock_wfree;
 	xsk_cq_cancel_locked(xs->pool, num_descs);
@@ -734,33 +731,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		xsk_skb_init_misc(skb, xs);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
 				return ERR_PTR(err);
 		}
-	} else {
-		struct xsk_addrs *xsk_addr;
-
-		if (xsk_skb_destructor_is_addr(skb)) {
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-						     GFP_KERNEL);
-			if (!xsk_addr)
-				return ERR_PTR(-ENOMEM);
-
-			xsk_addr->num_descs = 1;
-			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-		} else {
-			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		}
-
-		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
-		 * would be dropped, which implies freeing all list elements
-		 */
-		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 	}
 
 	len = desc->len;
@@ -828,7 +804,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			xsk_skb_init_misc(skb, xs);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -837,25 +813,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
-			struct xsk_addrs *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
-			if (xsk_skb_destructor_is_addr(skb)) {
-				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-							     GFP_KERNEL);
-				if (!xsk_addr) {
-					err = -ENOMEM;
-					goto free_err;
-				}
-
-				xsk_addr->num_descs = 1;
-				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-			} else {
-				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-			}
-
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -873,8 +833,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
@@ -931,7 +889,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
+		err = xsk_cq_reserve_addr_locked(xs, desc.addr);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1984,18 +1942,8 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
-	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
-						 sizeof(struct xsk_addrs),
-						 0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!xsk_tx_generic_cache) {
-		err = -ENOMEM;
-		goto out_unreg_notif;
-	}
-
 	return 0;
 
-out_unreg_notif:
-	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
 out_sk:
-- 
2.41.3


