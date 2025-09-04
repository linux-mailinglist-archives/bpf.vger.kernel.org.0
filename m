Return-Path: <bpf+bounces-67496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A88B446B9
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0315A815A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FC275AE9;
	Thu,  4 Sep 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D71aXLmF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B7202C43;
	Thu,  4 Sep 2025 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015365; cv=none; b=Ss4YL2Zn9f8hFfOT9Vfs/cZGPwk+W2aAZNdyUlCFrUix1SIb5qyvLnKXRT8TNnv8A1mJFkUs3ZbFZ2Ut1+iGaHAcnnojtH6Jqks7j1fwaYecD1ygIOpmfPYr48hcvICkIqHnkMOXXTQM4RCEQQ3u2lvn1dsQfUpk29OGSHFBbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015365; c=relaxed/simple;
	bh=egw+ohlWEQckBRsrMmotITgNtTkBdVFwfSgpK3qzjWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OLZ6Uj6/ZhfpwY+hwZkTFzNPQ53Oh1pby9YgOiOMeDvrVZn3P+k0jeUpO4B8Ur72OaloTsOfltvbQkWJkSAwXK9q6G8uhlNCjlOfwnEbI5A2iyNX7RXivmEn0nWeRCKxsJc1ctLv4uBxnh7WKr2ZuW0Hw1leAfjhLAb6XYOC9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D71aXLmF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757015363; x=1788551363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=egw+ohlWEQckBRsrMmotITgNtTkBdVFwfSgpK3qzjWc=;
  b=D71aXLmFgYrb9JQMaohJhZf4Coi97YM4kDW2tQj91CPEqfAbo9GT7nx0
   uhqzg5zu369Xi/Pub/bk7vfpqkVLpZ+Yacweu+nSr8teii4nD65AyWKiz
   SZZM0LttN6CAM5v4xi6Xe0iaZGBeBZ1Clm461Ool9/bWMYLvSTtSSDJx5
   f9FSnYl8wqlRJPjYbnl/qLirL5j7vo4pZ3YcP2c284VH38fBrxqEKKTVd
   pK3UoqELEfzpN7FnOyo/O5ZpJJ7Bo2D3h4sRFFlXXh79NJi2eMQCakwat
   r6JDNcQybIt/YfBYHH7P7cPuNCetyQjyFDTgzFiWOaSBoJvvDY9SSO4RC
   g==;
X-CSE-ConnectionGUID: tG5gyBSnQT+bxjEgbGPKfQ==
X-CSE-MsgGUID: eYX9zyUKQuaB3kknoRRwwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63006469"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="63006469"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:49:22 -0700
X-CSE-ConnectionGUID: B+tTfBRAR1+onnYDRFPOYw==
X-CSE-MsgGUID: KODXOCTDRviKzIkaykloKw==
X-ExtLoop1: 1
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 04 Sep 2025 12:49:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v9 bpf] xsk: fix immature cq descriptor production
Date: Thu,  4 Sep 2025 21:49:07 +0200
Message-Id: <20250904194907.2342177-1-maciej.fijalkowski@intel.com>
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
would have to land as well in order to make it work.

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
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
v7:
https://lore.kernel.org/bpf/20250829180950.2305157-1-maciej.fijalkowski@intel.com/
v8:
https://lore.kernel.org/bpf/07646dce-dab4-4afe-a09a-e6a83502ac30@intel.com/T/

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
v7->v8:
* fix a problem around incrementing num_descs when kmem_cache failed to
  provide us chunk of memory (Jason)
* restore Ack from Stanislav
* include BUILD_BUG_ON to cover xsk_addr_head future growth (Stan)
* s/i/descs_processed/ in xsk_cq_submit_addr_locked() (Magnus)
v8->v9:
* fix 32bit build warnings by uintptr_t casts on void * <-> u64
  conversion

---
 net/xdp/xsk.c       | 113 ++++++++++++++++++++++++++++++++++++++------
 net/xdp/xsk_queue.h |  12 +++++
 2 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..72e34bd2d925 100644
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
@@ -532,24 +546,43 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
+	u32 descs_processed = 0;
 	unsigned long flags;
+	u32 idx;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
+	idx = xskq_get_prod(pool->cq);
+
+	xskq_prod_write_addr(pool->cq, idx,
+			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
+	descs_processed++;
+
+	if (unlikely(XSKCB(skb)->num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+			xskq_prod_write_addr(pool->cq, idx + descs_processed,
+					     pos->addr);
+			descs_processed++;
+			list_del(&pos->addr_node);
+			kmem_cache_free(xsk_tx_generic_cache, pos);
+		}
+	}
+	xskq_prod_submit_n(pool->cq, descs_processed);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
@@ -562,9 +595,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
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
@@ -576,23 +614,33 @@ static void xsk_destruct_skb(struct sk_buff *skb)
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
+	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
+	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
+	XSKCB(skb)->num_descs = 0;
+	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
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
@@ -609,6 +657,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	struct xsk_addr_node *xsk_addr;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -623,6 +672,19 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		xsk_set_destructor_arg(skb, desc->addr);
+	} else {
+		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!xsk_addr)
+			return ERR_PTR(-ENOMEM);
+
+		/* in case of -EOVERFLOW that could happen below,
+		 * xsk_consume_skb() will release this node as whole skb
+		 * would be dropped, which implies freeing all list elements
+		 */
+		xsk_addr->addr = desc->addr;
+		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 	}
 
 	addr = desc->addr;
@@ -694,8 +756,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			xsk_set_destructor_arg(skb, desc->addr);
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
+			struct xsk_addr_node *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
@@ -710,12 +775,22 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+			if (!xsk_addr) {
+				__free_page(page);
+				err = -ENOMEM;
+				goto free_err;
+			}
+
 			vaddr = kmap_local_page(page);
 			memcpy(vaddr, buffer, len);
 			kunmap_local(vaddr);
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
+
+			xsk_addr->addr = desc->addr;
+			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
 
 		if (first_frag && desc->options & XDP_TX_METADATA) {
@@ -759,7 +834,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+	xsk_inc_num_desc(skb);
 
 	return skb;
 
@@ -769,7 +844,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_num_desc(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -812,7 +887,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1815,8 +1890,18 @@ static int __init xsk_init(void)
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
2.43.0


