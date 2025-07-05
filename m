Return-Path: <bpf+bounces-62471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8ECAFA05B
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815EB1C23C94
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120FD1A3029;
	Sat,  5 Jul 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3nwUBSS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BA16A94A;
	Sat,  5 Jul 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723732; cv=none; b=SpnEYHZ9XwuWnAgZhxeQObSWmYQiCBl/4gg/LuZVFey01K+r+qik0zoQLMVD1eKZcjIj3mNcWmaHSSKAHJnXrK2pI7XWvNTtgAaQ6YVvibc2tXXrxiggdBNK6b8hGxJ/MvaqF4AYDDwA3E55eNilOIK9WPQ2qgOxC4FgRVhQcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723732; c=relaxed/simple;
	bh=r87OgMbXYiO7V2apzj9mzNldcqlYtfF4qDVkAUXMIPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTj1GbQl5Hwx6gLPSuu+BbKpp/uFNsSmnXQMaVlTTpL7y8eTKf63IM5UlAFbMGQz9sHeQ+iYjR4gAXLdAT6ru3DvKLH7FnkKSUg/pqTAF6+f/qgtCZ9zRW/FYRHcaXtrXT7aMATKQP1hG+F4JoP9q1lmdfKOubJtAfsGVTWti50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3nwUBSS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751723730; x=1783259730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r87OgMbXYiO7V2apzj9mzNldcqlYtfF4qDVkAUXMIPo=;
  b=e3nwUBSSKtVTHpgz6MLcMuv4EIQ0I+VxH1whepm26pYf4hc7JHbCtaNh
   sqYQ/7a0J6u+v6z80RAd4wR3rDrxylHSN8pXR6MYYoKhKwi8YDb1TwdsT
   gefRiBifyfi6DJMLTBRHG5n9zu7E9+7h5Ctlf2QDaV532rHwJxAyo3GtE
   bnhEOl1cHz1b0ua8QNyblIk2cFVuEKjumIB0T0v2Q1UAOSJ3gZJHYlJYI
   I3f49wdHQrT5bQYcgv2XZSczufDXUsc/ESlvp52uhpQPkI8KvmYasoUnB
   7167+4EyPumFEB0I0o1K0r91LCgh6dpyZBtD8wrcB6BtXoKph7sMrmn4W
   A==;
X-CSE-ConnectionGUID: x1922X3tQPu3Wy2GqJ35vA==
X-CSE-MsgGUID: I8PdgkONQx+JzTpL2SFbvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="71589964"
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="71589964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 06:55:29 -0700
X-CSE-ConnectionGUID: ywlnfC7OT8qNzqD3HUkrtQ==
X-CSE-MsgGUID: ZOz6wsqGQbecCGzn/DZLWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="155402747"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 05 Jul 2025 06:55:28 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Date: Sat,  5 Jul 2025 15:55:12 +0200
Message-Id: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eryk reported an issue that I have put under Closes: tag, related to
umem addrs being prematurely produced onto pool's completion queue.
Let us make the skb's destructor responsible for producing all addrs
that given skb used.

Commit from fixes tag introduced the buggy behavior, it was not broken
from day 1, but rather when xsk multi-buffer got introduced.

Introduce a struct which will carry descriptor count with array of
addresses taken from processed descriptors that will be carried via
skb_shared_info::destructor_arg. This way we can refer to it within
xsk_destruct_skb().

To summarize, behavior is changed from:
- produce addr to cq, increase cq's cached_prod
- increment descriptor count and store it on
- (xmit and rest of path...)
  skb_shared_info::destructor_arg
- use destructor_arg on skb destructor to update global state of cq
  producer

to the following:
- increment cq's cached_prod
- increment descriptor count, save xdp_desc::addr in custom array and
  store this custom array on skb_shared_info::destructor_arg
- (xmit and rest of path...)
- use destructor_arg on skb destructor to walk the array of addrs and
  write them to cq and finally update global state of cq producer

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v1:
https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/

v1->v2:
* store addrs in array carried via destructor_arg instead having them
  stored in skb headroom; cleaner and less hacky approach;
---
 net/xdp/xsk.c       | 79 ++++++++++++++++++++++++++++++++++-----------
 net/xdp/xsk_queue.h | 12 +++++++
 2 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..9f0ce87d440f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,6 +36,11 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
+struct xsk_addrs {
+	u32 num_descs;
+	u64 addrs[MAX_SKB_FRAGS + 1];
+};
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -528,25 +533,38 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
+static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	ret = xskq_prod_reserve_addr(pool->cq, addr);
+	ret = xskq_prod_reserve(pool->cq);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
+				      struct sk_buff *skb)
 {
+	struct xsk_addrs *xsk_addrs;
 	unsigned long flags;
+	u32 num_desc, i;
+	u32 idx;
+
+	xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	num_desc = xsk_addrs->num_descs;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
+	idx = xskq_get_prod(pool->cq);
+
+	for (i = 0; i < num_desc; i++, idx++)
+		xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);
+	xskq_prod_submit_n(pool->cq, num_desc);
+
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	kfree(xsk_addrs);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
@@ -558,29 +576,37 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
-static u32 xsk_get_num_desc(struct sk_buff *skb)
-{
-	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
-}
-
 static void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
 
-	if (compl->tx_timestamp) {
+	if (compl->tx_timestamp)
 		/* sw completion timestamp, not a real one */
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
-	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb)
+static u32 xsk_get_num_desc(struct sk_buff *skb)
 {
-	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
+	struct xsk_addrs *addrs;
 
-	skb_shinfo(skb)->destructor_arg = (void *)num;
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	return addrs->num_descs;
+}
+
+static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
+{
+	skb_shinfo(skb)->destructor_arg = (void *)addrs;
+}
+
+static void xsk_inc_skb_descs(struct sk_buff *skb)
+{
+	struct xsk_addrs *addrs;
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	addrs->num_descs++;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -605,6 +631,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -619,6 +646,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		addrs = kzalloc(sizeof(*addrs), GFP_KERNEL);
+		if (!addrs)
+			return ERR_PTR(-ENOMEM);
+
+		xsk_set_destructor_arg(skb, addrs);
 	}
 
 	addr = desc->addr;
@@ -658,6 +691,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 {
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	bool first_frag = false;
 	int err;
@@ -690,6 +724,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			addrs = kzalloc(sizeof(*addrs), GFP_KERNEL);
+			if (!addrs)
+				goto free_err;
+
+			xsk_set_destructor_arg(skb, addrs);
+
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -755,7 +796,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	addrs->addrs[addrs->num_descs++] = desc->addr;
 
 	return skb;
 
@@ -765,7 +808,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_skb_descs(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -807,7 +850,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 46d87e961ad6..f16f390370dc 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
 
 /* Functions for producers */
 
+static inline u32 xskq_get_prod(struct xsk_queue *q)
+{
+	return READ_ONCE(q->ring->producer);
+}
+
 static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
 {
 	u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
@@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
+static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+
+	ring->desc[idx & q->ring_mask] = addr;
+}
+
 static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
 					      u32 nb_entries)
 {
-- 
2.34.1


