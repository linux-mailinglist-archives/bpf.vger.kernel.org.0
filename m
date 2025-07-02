Return-Path: <bpf+bounces-62092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48575AF1177
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 12:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C633A1114
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0325392B;
	Wed,  2 Jul 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtGRBAsP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0123D2B5;
	Wed,  2 Jul 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451467; cv=none; b=jIi1vCDZ3xSO2jX1p2GCs0mKnXCA0k+GLijHzoX6h8r2INbP1cj7z+oS868AiSen4cwPSt9NE3nPcGcjhYQMN8CiScnO0hyK1SxOHtitnlS2IV+3c16kz93qNpPl6CoCRXMjFiXvLmZicS+Lt03AYVI4AL6SEnMHild5NYgv38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451467; c=relaxed/simple;
	bh=dpWeEtX1mRle3l03ElDpyIk2fOl1EYbNOjdX7vVp0V4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFi05aSxcZtZ8tKMhtA8/3h4X+dmreUDJkupQgN1sftSzxRZJrr7fBexVHHQhAyaeWjKsuQ1ErcvOZx+WOlUfduS+oGoktYCZHsj4r5gkg+CCt9pzXzr54jzuOLWEPju9yAPeXfOQ5bj0Q0hwjSsBS/XeHp//SZITDMutzRSR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtGRBAsP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751451466; x=1782987466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dpWeEtX1mRle3l03ElDpyIk2fOl1EYbNOjdX7vVp0V4=;
  b=RtGRBAsPtgeAEekMOoepJom1M2EM334AVbIiO8aWga9dxXZLZU+wrdYm
   KUgwrDykOlX3JGEwHjWwiPuEaau2EkUv4emPHzfiJyNGkOctk2RPk0UGa
   jllDIi0MTbfgB+0bOVHGJ74zr1DAbkRRtMNPzzSlryWHEZXHBTnU7a9cv
   lDuDir+7dDn8K7OS+/yfRxEvloZWjAkxqi0ObwYspoqQ6r0yxiYLjoCzd
   2b34tKDw1jkeM6xAfrbulm2wl3Xo7J2RujNy/vTfqp2dHjUNxBJbe8WwF
   Qnu56rLD0s0xli9hFDB1+Wa5rK77k7dttgkex8IME9yZUlpSRAQsgUhnp
   w==;
X-CSE-ConnectionGUID: HvAGbQVLS1ez+BFE05aYJQ==
X-CSE-MsgGUID: 9BDTsyxYRwqQRiwKhrKMFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64338838"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64338838"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 03:17:45 -0700
X-CSE-ConnectionGUID: 9GsAksglSrKIbZwlg0plJg==
X-CSE-MsgGUID: 8aKl+nWiSLC7BX6UA8ppDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="184975326"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jul 2025 03:17:43 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: [PATCH bpf] xsk: fix immature cq descriptor production
Date: Wed,  2 Jul 2025 12:16:48 +0200
Message-Id: <20250702101648.1942562-1-maciej.fijalkowski@intel.com>
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

Store addrs at the beginning of skb's linear part and have a sanity
check if in any case driver would encapsulate headers in a way that data
would overwrite the [head, head + sizeof(xdp_desc::addr) *
(MAX_SKB_FRAGS + 1)] region, which we dedicate for umem addresses that
will be produced onto xsk_buff_pool's completion queue.

This approach appears to survive scenario where underlying driver
linearizes the skb because pskb_pull_tail() under the hood will copy
header part to newly allocated memory. If this array would live in
tailroom it would get overridden when pulling frags onto linear part.
This happens when driver receives skb with frag count higher than what
HW is able to swallow (I came across this case on ice driver that has
maximum s/g count equal to 8).

Initially we also considered storing 8-byte addr at the end of page
allocated by frag but xskxceiver has a test which writes full 4k to frag
and this resulted in corrupted addr.

xsk_cq_submit_addr_locked() has to use xsk_get_num_desc() to find out
frag count as skb that we deal with within destructor might not have the
frags at all - as mentioned earlier drivers in their ndo_start_xmit()
might linearize the skb. We will not use cached_prod to update
producer's global state as its value might already have been increased,
which would result in too many addresses being submitted onto cq.

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c       | 92 +++++++++++++++++++++++++++++++--------------
 net/xdp/xsk_queue.h | 12 ++++++
 2 files changed, 75 insertions(+), 29 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..86473073513c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -528,27 +528,18 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
-}
-
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	unsigned long flags;
@@ -563,19 +554,6 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
 }
 
-static void xsk_destruct_skb(struct sk_buff *skb)
-{
-	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
-
-	if (compl->tx_timestamp) {
-		/* sw completion timestamp, not a real one */
-		*compl->tx_timestamp = ktime_get_tai_fast_ns();
-	}
-
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
-	sock_wfree(skb);
-}
-
 static void xsk_set_destructor_arg(struct sk_buff *skb)
 {
 	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
@@ -600,11 +578,52 @@ static void xsk_drop_skb(struct sk_buff *skb)
 	xsk_consume_skb(skb);
 }
 
+static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
+				      struct sk_buff *skb)
+{
+	unsigned long flags;
+	u32 num_desc, i;
+	u64 *addr;
+	u32 idx;
+
+	if (unlikely(skb->data <= skb->head + sizeof(u64) * (MAX_SKB_FRAGS + 1))) {
+		WARN(1, "possible corruption of umem addr array; dropping skb");
+		xsk_drop_skb(skb);
+		return;
+	}
+
+	num_desc = xsk_get_num_desc(skb);
+
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	idx = xskq_get_prod(pool->cq);
+
+	for (i = 0, addr = (u64 *)(skb->head); i < num_desc; i++, addr++, idx++)
+		xskq_prod_write_addr(pool->cq, idx, *addr);
+	xskq_prod_submit_n(pool->cq, num_desc);
+
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
+}
+
+static void xsk_destruct_skb(struct sk_buff *skb)
+{
+	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
+
+	if (compl->tx_timestamp) {
+		/* sw completion timestamp, not a real one */
+		*compl->tx_timestamp = ktime_get_tai_fast_ns();
+	}
+
+	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
+	sock_wfree(skb);
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
+	size_t addr_arr_sz = sizeof(desc->addr) * (MAX_SKB_FRAGS + 1);
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	size_t addr_sz = sizeof(desc->addr);
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -614,11 +633,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		skb = sock_alloc_send_skb(&xs->sk, hr + addr_arr_sz, 1, &err);
 		if (unlikely(!skb))
 			return ERR_PTR(err);
 
-		skb_reserve(skb, hr);
+		skb_reserve(skb, hr + addr_arr_sz);
 	}
 
 	addr = desc->addr;
@@ -648,6 +667,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	skb->data_len += len;
 	skb->truesize += ts;
 
+	memcpy(skb->head + (addr_sz * xsk_get_num_desc(skb)),
+	       &desc->addr, addr_sz);
+
 	refcount_add(ts, &xs->sk.sk_wmem_alloc);
 
 	return skb;
@@ -656,10 +678,13 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
+	size_t addr_arr_sz = sizeof(desc->addr) * (MAX_SKB_FRAGS + 1);
+	size_t addr_sz = sizeof(desc->addr);
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	bool first_frag = false;
+	u8 *addr_arr;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
@@ -680,16 +705,21 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			skb = sock_alloc_send_skb(&xs->sk,
+						  hr + addr_arr_sz + len + tr,
+						  1, &err);
 			if (unlikely(!skb))
 				goto free_err;
 
-			skb_reserve(skb, hr);
+			skb_reserve(skb, hr + addr_arr_sz);
 			skb_put(skb, len);
 
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+			addr_arr = skb->head;
+			memcpy(addr_arr, &desc->addr, addr_sz);
+
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -712,6 +742,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
+
+			addr_arr = skb->head;
+			memcpy(addr_arr + (addr_sz * skb_shinfo(skb)->nr_frags),
+			       &desc->addr, addr_sz);
 		}
 
 		if (first_frag && desc->options & XDP_TX_METADATA) {
@@ -807,7 +841,7 @@ static int __xsk_generic_xmit(struct sock *sk)
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


