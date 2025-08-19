Return-Path: <bpf+bounces-66001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDBB2C277
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F6D5A4E66
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77060335BA5;
	Tue, 19 Aug 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y78WrFOo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62311AE844;
	Tue, 19 Aug 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604573; cv=none; b=CMS6Ax/CpT0phvVq7IhXBEFga0qE9NcXWmV+N5XmhArYIyNk9jgpFlGiMk65HECsSX6bREvHyQmJgDoMZvHwtrmTGH4Z43igwakwAFbPCEUgUURGzxspo1wOsHT9t6SoCrQ8yqPl3CSnjOf+UhOqy8A8XS2BakKxMgkLg0+Nd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604573; c=relaxed/simple;
	bh=cEVnPyO6O8Vaxm9l2V/iU2h7Vv2NpjNTZWMap4RcFBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClpfGmJ2L3p8VQw2Xseazu/rfKXXDbkfKdei2enYs3bR35vxqkSeai9BoPZE9y/VwFxIloWxynwn4coBwN2zdj5hO7ddJJU1cJutED1J/jEV0eD4zIa/eP+jhFHkNiMAKiKbAzGrGeZVHh3nDo6z7hhRpOOVG7u/TO+EFKUcj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y78WrFOo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755604571; x=1787140571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cEVnPyO6O8Vaxm9l2V/iU2h7Vv2NpjNTZWMap4RcFBU=;
  b=Y78WrFOoViKmyXUWkgz9sBmsthcnvw3RDwbvyqRQLclX3GsdhX0mM+wD
   m4P5/X4XLbIIszEiunM34aeBdzxOYKArtcORQZn1DLjithcxCNO9gxZR3
   O/FK2drF2arvcigWwoeSE629C6RESrcFGOHjVmOmRioS5FWFHomzCCNvh
   SilFq55r91pT/MAynIQpxklMX8MhtWMjWsSDygjaQbu4TwyoS9e66i2Pf
   3Vg9V4TEZWchJXD+0X8KjWXl83cGLF+BWo1sgfkSxnZl+Rpa/AfPoxnje
   OD/oGenV7Vc5IEINIVRWIEK3zUQXsw41yAMtQOsAXLjeABDlAODRAfTLq
   w==;
X-CSE-ConnectionGUID: 92+zy3+NR86c9NZmOGIMeA==
X-CSE-MsgGUID: D1VwLatcQGG4ITCCsk9/yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57947313"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57947313"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 04:56:10 -0700
X-CSE-ConnectionGUID: xh+MSlMAQ+m5X2GPSDhzew==
X-CSE-MsgGUID: LI8GxQfXQ32l8hsHDtW4IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172070861"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2025 04:56:07 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: [PATCH v5 bpf] xsk: fix immature cq descriptor production
Date: Tue, 19 Aug 2025 13:55:18 +0200
Message-Id: <20250819115518.2240942-1-maciej.fijalkowski@intel.com>
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

Introduce struct xsk_addrs which will carry descriptor count with array
of addresses taken from processed descriptors that will be carried via
skb_shared_info::destructor_arg. This way we can refer to it within
xsk_destruct_skb(). In order to mitigate the overhead that will be
coming from memory allocations, let us introduce kmem_cache of
xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
system.

Commit from fixes tag introduced the buggy behavior, it was not broken
from day 1, but rather when xsk multi-buffer got introduced.

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
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

---
 net/xdp/xsk.c       | 91 +++++++++++++++++++++++++++++++++++++--------
 net/xdp/xsk_queue.h | 12 ++++++
 2 files changed, 87 insertions(+), 16 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..012991de9df2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,6 +36,13 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
+struct xsk_addrs {
+	u32 num_descs;
+	u64 addrs[MAX_SKB_FRAGS + 1];
+};
+
+static struct kmem_cache *xsk_tx_generic_cache;
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -532,25 +539,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
+static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
+				      struct sk_buff *skb)
 {
+	struct xsk_buff_pool *pool = xs->pool;
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
+	for (i = 0; i < num_desc; i++)
+		xskq_prod_write_addr(pool->cq, idx + i, xsk_addrs->addrs[i]);
+	xskq_prod_submit_n(pool->cq, num_desc);
+
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	kmem_cache_free(xsk_tx_generic_cache, xsk_addrs);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
@@ -562,11 +583,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
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
@@ -576,21 +592,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
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
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 
+	kmem_cache_free(xsk_tx_generic_cache,
+			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
 	skb->destructor = sock_wfree;
 	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
 	/* Free skb without triggering the perf drop trace */
@@ -609,6 +641,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -623,6 +656,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!addrs)
+			return ERR_PTR(-ENOMEM);
+
+		xsk_set_destructor_arg(skb, addrs);
 	}
 
 	addr = desc->addr;
@@ -662,6 +701,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 {
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	bool first_frag = false;
 	int err;
@@ -694,6 +734,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+			if (!addrs) {
+				err = -ENOMEM;
+				goto free_err;
+			}
+
+			xsk_set_destructor_arg(skb, addrs);
+
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -759,7 +808,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	addrs->addrs[addrs->num_descs++] = desc->addr;
 
 	return skb;
 
@@ -769,7 +820,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_skb_descs(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -812,7 +863,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1815,6 +1866,14 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
+	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
+						 sizeof(struct xsk_addrs), 0,
+						 SLAB_HWCACHE_ALIGN, NULL);
+	if (!xsk_tx_generic_cache) {
+		err = -ENOMEM;
+		goto out_pernet;
+	}
+
 	return 0;
 
 out_pernet:
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


