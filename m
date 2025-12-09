Return-Path: <bpf+bounces-76349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22151CAF5F7
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB7D3065E04
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712125C809;
	Tue,  9 Dec 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwBfvLx1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4723D7CD
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270822; cv=none; b=GFV11tlkCWb8pV80zG/2sphcldgfxSHhAGmLkzEfF4wn6RZuh7jdLNRR8WUKKy2HX7TOQnp6kVGJjOjahR+csv/7nZZ07fTSG0ES+jlUkyDIinLfvI7hLHVewvd+76lBT4L1FFFJfWYoo6uJ/iEkl93RFQsefawVdxhuVEiZAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270822; c=relaxed/simple;
	bh=un5H7br7XALbO1hxuV/oJ4lRocGZ41j3gukUunc9sKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osQiFGUXV6e+0Y/5z7EwQ4a0tBBRiY+k98/iEmD/vR2u3tkkwg1HR4DHdC10Xk3musPftuqWwF7g1LSSw9BCK5ohsEL6LrgRvpziKzWif2cwqm4uWvvNjrbemToAEOlZKPixK+uAQB6joS6IO7BQ38JW8gFccSSbT0YqL+H1aRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwBfvLx1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b80fed1505so5630442b3a.3
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 01:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270820; x=1765875620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDda+dcW4AbMmjnV4qEIWorqhmPjh94CzTNy5YW4r4s=;
        b=OwBfvLx1d70wKFl3p4avmB9EZwj5jz4gXehmGXvF9uTec92H/oO2f6YCYOrA+aG0hK
         g/b9fWpfSSmUdfyBFuwfWeXCs8cwhCOH3P8x1+ohA4Nn4h7lgqx+h5JpJhMUCKretveJ
         Zna5B/cIHJPFnd/46DA0HpHseBbF3lsLljP6lQsZcfy78gtxy3FnfvM+1T1JSVHqzqBU
         eou1wvNQCF3S+sxaTTtjTmfIXI4JXJwFW+NNHnHuX1/9p1fAN4aUrh4nc/ZUIQ84Tnj8
         xW0vQaEBPXau0Vf00N2jO3V5wDH7rpbF052ggcs9+Zb3ch1lf/pRcnjO7a0NNEmSVd5u
         N1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270820; x=1765875620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDda+dcW4AbMmjnV4qEIWorqhmPjh94CzTNy5YW4r4s=;
        b=mqbYRylmTidCdTAd4bsH/QaTG52WuVsAYzORVJvlzDOKrkXkKx0AtI/Erh3uJaIqWK
         YKy4uLWNMbUrbhuMXjjsYfszjirFggMYhJy67O26Y/YfYyhMqdWH4xbMSzu0pQmPriuO
         GcdswarvOKq7uExFUQ6WQJ1YoQ5B67Nd9TyOsbybMnG9AQu8/CgdRqunnvNeysNrUrkP
         qLGzCj8HTRvVrYukRTlbTt3Kcw4lfVn1KTAsB1Y+e1RhrOPkDGJSo7HBSqgKr2tGT42K
         EAyeFwKzgyVJopFPbkWZtwjpYz03VdaaJ7CzvrUHvkUOKaRfuf7FbbUkC9nxf/aCVyWD
         sGKw==
X-Gm-Message-State: AOJu0YxHpMkvosYP1UmcYv8/LDOJnLX9GckzeZVa/PtanlH/B+f3bIgQ
	IM1hHu8Z5qo6D2Xs3TLYsXjIVOyyyd+9mEOzh/OLoVimAAoOxuIiRgqC
X-Gm-Gg: ASbGnctWFWIzMf+YN8Mv5XpjN7ZsmqwWMmFLUdd2ueR4poM+isBgMNSi0CDP03gB9k8
	qF1kghDN7dfbhyi4tcfD/wUsUWdxgpl7yFOhPYTkQ9z10Q9Zt3Wv6G7CAO8QNLhFg03tVDKrrzK
	EovsYjcfo0+jUGpEsklW4lWqq9sWPGPRIYFxZ+mBj/vmOWK2PBglorjzcfmyLhn7/CLpDT8I0tG
	vWd4dfqt20yf3lEYhkJzYYZyjlThcCiwh38ubtNoPW8RlskV6/XW+wzg/VA6tr3XWZx1f/wg12I
	Q+ciYKbo2lu50B56k5XMHeAtCYGCmT9SAj+npxb9dYnD6/0PQrI0Ffakyv1pyHlq5QJm6xh/5HT
	DUtgN3DmO66SDYkioFQH4VieDRIXFDqf3dVoTexOF29JfFuEZOF07VWbKoxdBVqPykLEqpzYnrh
	AowiB7IBXGYIeM+pT+IWG7FzTHGNw+rYPYKTC28RR5mpf57jpQL/2V/kQU6Q==
X-Google-Smtp-Source: AGHT+IEdDbpAntmu9krp/omhNJHpDRYQjtDzkqtsx7bztT/SimQAT6dLaLlhjhZIBtQR8XhrsrisXA==
X-Received: by 2002:a05:6a00:1784:b0:7e8:4398:b370 with SMTP id d2e1a72fcca58-7e8c63bfb35mr8781722b3a.67.1765270819697;
        Tue, 09 Dec 2025 01:00:19 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ee0b3sm15529015b3a.7.2025.12.09.01.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:00:19 -0800 (PST)
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
Subject: [PATCH bpf-next v1 2/2] xsk: introduce a dedicated local completion queue for each xsk
Date: Tue,  9 Dec 2025 16:59:50 +0800
Message-Id: <20251209085950.96231-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251209085950.96231-1-kerneljasonxing@gmail.com>
References: <20251209085950.96231-1-kerneljasonxing@gmail.com>
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
index ce165d093105..c51ea9526e5f 100644
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
@@ -1978,18 +1936,8 @@ static int __init xsk_init(void)
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


