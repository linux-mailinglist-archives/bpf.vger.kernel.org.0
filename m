Return-Path: <bpf+bounces-65136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B89B1C8E5
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969CA62523A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221F1292B53;
	Wed,  6 Aug 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hl+oe05+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D819A;
	Wed,  6 Aug 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494894; cv=none; b=lLLJJulImRF8Ll2EyimgywHl16YKKxQ/eFIwN/TAbgMEpPhuqTD6/NVo7nnfuN0GrlFxZssH177FNw/9JNiXy50GFlNGnPTdLZod6wEfDAkNyH0g/rS3kjNrlJUUAO7ScEavGSi8YI3PIv+iQampNHxQeFKx4ON3FBWzljtZCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494894; c=relaxed/simple;
	bh=3Rv3jk44gwh5BzjHMiW3nk3U0pOZ0H5IWjdQcWCBzRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhT9R6mGIcH9gS2AGE4mbr4JI+VBDYwkgjDe6Vh+jgFcKtLT7+ddPDeDhhrCTXi8ykVHicFW+DArvGJ2evIfiUTNyO7Z8sCFBfwwrChduA5qFNKJs2Ri8Ed528R/H/k9ytVaOD4YARzZYjuDla48j+gbEFkdXPzhsuxzOv+WI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hl+oe05+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754494893; x=1786030893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Rv3jk44gwh5BzjHMiW3nk3U0pOZ0H5IWjdQcWCBzRE=;
  b=Hl+oe05+faUmD4tAkMFASnUNSXi6j/RH1Ww054JdYc6aMHkrBIaUz+jd
   K/iN7EEpr1sGpxxSWtG59M+LsA91v7zwMp/4kUDO0Pe1nDqfVPaqXbg6y
   EgbYtEU8/I83tqhI/Z6H7i1ndCO13EykvSQuFIRRcnOLbpQDWyWDOikk5
   h9PG4mBb4hu8shGwpAur7cVICQjoAld2fqoaEMzszZXtF/j79GpGnd9+v
   Jv8XkKAgiVgvgD8DnQgTWd/ViOZAw670epeANqOKNYqPNF+gwtWRryAdg
   BqUQ0bX0UXOx2GlM5aiaJ+WboUvO25PsM0mp0WRXPxV3jMZrRP+Xtr5lx
   g==;
X-CSE-ConnectionGUID: Q/Z2btgHSPCVnBoEaI43bw==
X-CSE-MsgGUID: vQKfmuzYS3ui1L24jNbO3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="55853623"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="55853623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:41:32 -0700
X-CSE-ConnectionGUID: fDJIeYvuQLO7LuEFmxlPmA==
X-CSE-MsgGUID: 1lW/SuGqSTCe9X6iW8r/Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165582485"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa010.fm.intel.com with ESMTP; 06 Aug 2025 08:41:29 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: [PATCH v3 bpf] xsk: fix immature cq descriptor production
Date: Wed,  6 Aug 2025 17:41:27 +0200
Message-Id: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
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
coming from memory allocations, let us introduce kmem_cache of xsk_addrs
onto xdp_sock. Utilize the existing struct hole in xdp_sock for that.

Commit from fixes tag introduced the buggy behavior, it was not broken
from day 1, but rather when xsk multi-buffer got introduced.

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v1:
https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
v2:
https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/

v1->v2:
* store addrs in array carried via destructor_arg instead having them
  stored in skb headroom; cleaner and less hacky approach;
v2->v3:
* use kmem_cache for xsk_addrs allocation (Stan/Olek)
* set err when xsk_addrs allocation fails (Dan)
* change xsk_addrs layout to avoid holes
* free xsk_addrs on error path
* rebase
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 94 ++++++++++++++++++++++++++++++++++--------
 net/xdp/xsk_queue.h    | 12 ++++++
 3 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..5ba9ad4c110f 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -61,6 +61,7 @@ struct xdp_sock {
 		XSK_BOUND,
 		XSK_UNBOUND,
 	} state;
+	struct kmem_cache *xsk_addrs_cache;
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..d77cde0131be 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,6 +36,11 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
+struct xsk_addrs {
+	u64 addrs[MAX_SKB_FRAGS + 1];
+	u32 num_descs;
+};
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -532,25 +537,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
+	for (i = 0; i < num_desc; i++, idx++)
+		xskq_prod_write_addr(pool->cq, idx, xsk_addrs->addrs[i]);
+	xskq_prod_submit_n(pool->cq, num_desc);
+
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	kmem_cache_free(xs->xsk_addrs_cache, xsk_addrs);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
@@ -562,35 +581,45 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
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
+	xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb)
+static u32 xsk_get_num_desc(struct sk_buff *skb)
+{
+	struct xsk_addrs *addrs;
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	return addrs->num_descs;
+}
+
+static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
 {
-	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
+	skb_shinfo(skb)->destructor_arg = (void *)addrs;
+}
+
+static void xsk_inc_skb_descs(struct sk_buff *skb)
+{
+	struct xsk_addrs *addrs;
 
-	skb_shinfo(skb)->destructor_arg = (void *)num;
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	addrs->num_descs++;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 
+	kmem_cache_free(xs->xsk_addrs_cache,
+			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
 	skb->destructor = sock_wfree;
 	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
 	/* Free skb without triggering the perf drop trace */
@@ -609,6 +638,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -623,6 +653,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
+		if (!addrs)
+			return ERR_PTR(-ENOMEM);
+
+		xsk_set_destructor_arg(skb, addrs);
 	}
 
 	addr = desc->addr;
@@ -662,6 +698,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 {
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	bool first_frag = false;
 	int err;
@@ -694,6 +731,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			addrs = kmem_cache_zalloc(xs->xsk_addrs_cache, GFP_KERNEL);
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
@@ -759,7 +805,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	addrs->addrs[addrs->num_descs++] = desc->addr;
 
 	return skb;
 
@@ -769,7 +817,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_skb_descs(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -812,7 +860,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1122,6 +1170,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	kmem_cache_destroy(xs->xsk_addrs_cache);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1765,6 +1814,15 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	sock_prot_inuse_add(net, &xsk_proto, 1);
 
+	xs->xsk_addrs_cache = kmem_cache_create("xsk_generic_xmit_cache",
+						sizeof(struct xsk_addrs), 0,
+						SLAB_HWCACHE_ALIGN, NULL);
+
+	if (!xs->xsk_addrs_cache) {
+		sk_free(sk);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
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


