Return-Path: <bpf+bounces-67026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06656B3C244
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1E6E4E19D3
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA220343213;
	Fri, 29 Aug 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpCGE+kW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392D3431F1;
	Fri, 29 Aug 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491036; cv=none; b=W78blpcp2CJ14k/11TsYE83P52Q+E/ySpSsbAoB3WkD1/VBUz1ODN+Ujd7tzBuT3bKwU6IDXm4dAQNuEAS8f5v20BQm40F5rxpPGXgizjmYb+m9TuIicu/izVeL+lznZfiCjTRYMophlSRpe+rOfUW6UCYcIoay3QvS9NxDNaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491036; c=relaxed/simple;
	bh=A7JfuLgDIeJf62pjQAa24R19A6wX0Q5EQa0adpix6KA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pwtw/4k0y1CxOXtlK7j0XUTjDKkQZ2DR1EpwDZo9x5amIE02B2H7CRASAxVaB6Nv384u+WPiFq90Wy7Gfn79PHFfV4WoQrnGGJyswPhj0RSxLiHO1jHBZMT2qP6paXOfHWKrS1XMAWD+bwi6jRbh24oVM2PN1a7sGsmBEUe1izI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpCGE+kW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756491034; x=1788027034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A7JfuLgDIeJf62pjQAa24R19A6wX0Q5EQa0adpix6KA=;
  b=UpCGE+kWaFaca8aCIkZUHgiFk+uvHRYOFMOK2JPkiX64usa6s85H5C4E
   Aqt/w9xL996yYVn5SOr6hryrualH9pBFnAaPKJDsbxWfoq19yKswAEmvU
   4K4FUuyE420kkkI/Gzvx5jkiWtt7uvf2od85WV7NuZ4ahlQXQcRYSKYzQ
   VU4GGAoFVjbQe+SpSTKJ1mUjFh/42DKeL1KikWq8ndQlWmcRKDqdzxSoe
   g7VGj6W0RRtjs/mTcgWDYeqIkWzlpMF+m5t93OOSCrQbdKDhHRxupsdPC
   fzdnl/deQG1AcmNm4Vpxxq5Q7EQ9hnzQtKfDjNwmAk2jm6z93MO5HAgW2
   g==;
X-CSE-ConnectionGUID: Vy4oxPytQPC4dISeeCJSNA==
X-CSE-MsgGUID: jIJApfppTm6gjXXl4NHy3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="84190466"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="84190466"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 11:10:33 -0700
X-CSE-ConnectionGUID: I2vZIwumS1S1DJ7exvRWWQ==
X-CSE-MsgGUID: Fb6coEuoQee9o1JF9yh2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175738604"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 29 Aug 2025 11:10:31 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: [PATCH v7 bpf] xsk: fix immature cq descriptor production
Date: Fri, 29 Aug 2025 20:09:50 +0200
Message-Id: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
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
from day 1, but rather when XSK multi-buffer got introduced.

In order to mitigate performance impact as much as possible, mimic the
linear and frag parts within skb by storing the first address from XSK
descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
via list. The nodes that will go onto list will be allocated via
kmem_cache. xsk_destruct_skb() will consume address stored at
::destructor_arg and optionally go through list from ::cb, if count of
descriptors associated with this particular skb is bigger than 1.

Previous approach where whole array for storing UMEM addresses from XSK
descriptors was pre-allocated during first fragment processing yielded
too big performance regression for 64b traffic. In current approach
impact is much reduced on my tests and for jumbo frames I observed
traffic being slower by at most 9%.

Magnus suggested to have this way of processing special cased for
XDP_SHARED_UMEM, so we would identify this during bind and set different
hooks for 'backpressure mechanism' on CQ and for skb destructor, but
given that results looked promising on my side I decided to have a
single data path for XSK generic Tx. I suppose other auxiliary stuff
such as helpers introduced in this patch would have to land as well in
order to make it work, so we might have ended up with more noisy diff.

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---

Jason, please test this v7 on your setup, I would appreciate if you
would report results from your testbed. Thanks!

v1:
https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
v2:
https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
v3:
https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
v4:
https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
v5:
https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
v6:
https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkowski@intel.com/

v1->v2:
* store addrs in array carried via destructor_arg instead having them
  stored in skb headroom; cleaner and less hacky approach;
v2->v3:
* use kmem_cache for xsk_addrs allocation (Stan/Olek)
* set err when xsk_addrs allocation fails (Dan)
* change xsk_addrs layout to avoid holes
* free xsk_addrs on error path
* rebase
v3->v4:
* have kmem_cache as percpu vars
* don't drop unnecessary braces (unrelated) (Stan)
* use idx + i in xskq_prod_write_addr (Stan)
* alloc kmem_cache on bind (Stan)
* keep num_descs as first member in xsk_addrs (Magnus)
* add ack from Magnus
v4->v5:
* have a single kmem_cache per xsk subsystem (Stan)
v5->v6:
* free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
  (Stan)
* unregister netdev notifier if creating kmem_cache fails (Stan)
v6->v7:
* don't include Acks from Magnus/Stan; let them review the new
  approach:)
* store first desc at sk_buff::destructor_arg and rest of frags in list
  stored at sk_buff::cb
* keep the kmem_cache but don't use it for allocation of whole array at
  one shot but rather alloc single nodes of list

---
 net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-------
 net/xdp/xsk_queue.h | 12 ++++++
 2 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..3d12d1fbda41 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,6 +36,20 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
+struct xsk_addr_node {
+	u64 addr;
+	struct list_head addr_node;
+};
+
+struct xsk_addr_head {
+	u32 num_descs;
+	struct list_head addrs_list;
+};
+
+static struct kmem_cache *xsk_tx_generic_cache;
+
+#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -532,24 +546,41 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
+	struct xsk_addr_node *pos, *tmp;
 	unsigned long flags;
+	u32 i = 0;
+	u32 idx;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
+	idx = xskq_get_prod(pool->cq);
+
+	xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
+	i++;
+
+	if (unlikely(XSKCB(skb)->num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+			xskq_prod_write_addr(pool->cq, idx + i, pos->addr);
+			i++;
+			list_del(&pos->addr_node);
+			kmem_cache_free(xsk_tx_generic_cache, pos);
+		}
+	}
+	xskq_prod_submit_n(pool->cq, i);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
@@ -562,9 +593,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
+static void xsk_inc_num_desc(struct sk_buff *skb)
+{
+	XSKCB(skb)->num_descs++;
+}
+
 static u32 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
+	return XSKCB(skb)->num_descs;
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
@@ -576,23 +612,32 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb)
+static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
 {
-	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
-
-	skb_shinfo(skb)->destructor_arg = (void *)num;
+	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
+	XSKCB(skb)->num_descs = 0;
+	skb_shinfo(skb)->destructor_arg = (void *)addr;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
+	u32 num_descs = xsk_get_num_desc(skb);
+	struct xsk_addr_node *pos, *tmp;
+
+	if (unlikely(num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+			list_del(&pos->addr_node);
+			kmem_cache_free(xsk_tx_generic_cache, pos);
+		}
+	}
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
+	xsk_cq_cancel_locked(xs->pool, num_descs);
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -623,6 +668,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		xsk_set_destructor_arg(skb, desc->addr);
 	}
 
 	addr = desc->addr;
@@ -694,6 +741,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			xsk_set_destructor_arg(skb, desc->addr);
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -759,7 +808,19 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+
+	xsk_inc_num_desc(skb);
+	if (unlikely(xsk_get_num_desc(skb) > 1)) {
+		struct xsk_addr_node *xsk_addr;
+
+		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!xsk_addr) {
+			err = -ENOMEM;
+			goto free_err;
+		}
+		xsk_addr->addr = desc->addr;
+		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+	}
 
 	return skb;
 
@@ -769,7 +830,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_num_desc(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -812,7 +873,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1815,8 +1876,18 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
+	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
+						 sizeof(struct xsk_addr_node),
+						 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!xsk_tx_generic_cache) {
+		err = -ENOMEM;
+		goto out_unreg_notif;
+	}
+
 	return 0;
 
+out_unreg_notif:
+	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
 out_sk:
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


