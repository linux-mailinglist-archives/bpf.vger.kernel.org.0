Return-Path: <bpf+bounces-65531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677EB251AA
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17FFD4E50DC
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417D17578;
	Wed, 13 Aug 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGIRrd0U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C98303C89;
	Wed, 13 Aug 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105200; cv=none; b=GkJ7TxvQvo9T6VMPyy6mE9Whxp1hQ6eigTEtFf5bM8UEvMjgBciwXuPxra5JPHUme+FiUap3SArOL9h669l6cLVhV564HoeBhrftbOFsYro/l71xRlgc+bAUIOkwrVhYK6W0XAcPlpOwqs1PIwQ0/ylkux9iC9CJAf4PBEJN0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105200; c=relaxed/simple;
	bh=nI2JFqURfWVLDvax3sxLHJHu84H6Oka27pOCgRf7x2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lcBwusFNAp635jXiDS+fQFYeJLhiki2sYh6dIEk8ei4FTq5+q5C6BZ/DFzRGFrHl8MLkut1h08Oq7bL0Sqiz8dxRm63Qu+FXHQ9ugxKTScE7UhCas65Zwz1fJ4bYgdKNMBIymNddDryVfFtyAGYuBw4IIbIZIoqx14WgBiMD0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGIRrd0U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755105198; x=1786641198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nI2JFqURfWVLDvax3sxLHJHu84H6Oka27pOCgRf7x2k=;
  b=iGIRrd0UMGzzeBaSDoxOUcDuIsUCgtIPX7IxZsgN9/SUY8vAYGi5PdNR
   uix6Gft1Alg/CD9xn9HJ31FGRPkvk/6FY9WbmTenJVHVVOALk3bQq5N7m
   2cb5jYLYrDAcGx897qlHDJ9OgnVwGUvxD8TLH4Qmn8ZfavlVWIHZG05ix
   w5bg/2ajbJKoHW3v+s6ZrbGs4T/lOLEoeuzNQuF1lEOZHlO9g2HR0jWeV
   YaveESWazLh7s0DYeY0b0vw0kKU8QM0NsZVX+7cBgWatXIOo26q80Fwts
   g+Mct4loBpQepjiNscYPm9Yxz2keow1/BK3rUHCeK67xHXTxEsrbRcNY5
   g==;
X-CSE-ConnectionGUID: +YZoLk7PTGewgUn3nuSMtg==
X-CSE-MsgGUID: 5flbjvf/SWu0m5QPqkt9mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="79982567"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="79982567"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:13:16 -0700
X-CSE-ConnectionGUID: 0vjPpSAZRN+5iaPB/fdJww==
X-CSE-MsgGUID: ujHtSRV/Qh+XtPlqCwcgYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170981417"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 13 Aug 2025 10:13:13 -0700
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
Subject: [PATCH v4 bpf] xsk: fix immature cq descriptor production
Date: Wed, 13 Aug 2025 19:12:11 +0200
Message-Id: <20250813171210.2205259-1-maciej.fijalkowski@intel.com>
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
xsk_addrs, but be smart about scalability, as assigning unique cache per
each socket might be expensive.

Store kmem_cache as percpu variables with embedded refcounting and let
the xsk code index it by queue id. In case when a NIC#0 already runs
copy mode xsk socket on queue #10 and user starts a socket on
<NIC#1,qid#10> tuple, the kmem_cache is reused. Keep the pointer to
kmem_cache in xdp_sock to avoid accessing bss in data path.

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

---
 include/net/xdp_sock.h |   1 +
 net/xdp/xsk.c          | 140 +++++++++++++++++++++++++++++++++++------
 net/xdp/xsk_queue.h    |  12 ++++
 3 files changed, 135 insertions(+), 18 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..4701e7f41bee 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -61,6 +61,7 @@ struct xdp_sock {
 		XSK_BOUND,
 		XSK_UNBOUND,
 	} state;
+	struct kmem_cache *generic_cache;
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..d245784163ec 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,6 +36,18 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
+struct xsk_addrs {
+	u32 num_descs;
+	u64 addrs[MAX_SKB_FRAGS + 1];
+};
+
+struct xsk_generic_cache {
+	struct kmem_cache *cache;
+	refcount_t users;
+};
+
+DEFINE_PER_CPU(struct xsk_generic_cache, system_xsk_generic_cache);
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -532,25 +544,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
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
+	kmem_cache_free(xs->generic_cache, xsk_addrs);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
@@ -562,11 +588,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
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
@@ -576,21 +597,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
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
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	return addrs->num_descs;
+}
 
-	skb_shinfo(skb)->destructor_arg = (void *)num;
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
 
+	kmem_cache_free(xs->generic_cache,
+			(struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
 	skb->destructor = sock_wfree;
 	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
 	/* Free skb without triggering the perf drop trace */
@@ -605,10 +642,12 @@ static void xsk_drop_skb(struct sk_buff *skb)
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
-					      struct xdp_desc *desc)
+					      struct xdp_desc *desc,
+					      struct kmem_cache *cache)
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -623,6 +662,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		addrs = kmem_cache_zalloc(cache, GFP_KERNEL);
+		if (!addrs)
+			return ERR_PTR(-ENOMEM);
+
+		xsk_set_destructor_arg(skb, addrs);
 	}
 
 	addr = desc->addr;
@@ -662,12 +707,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 {
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
+	struct xsk_addrs *addrs = NULL;
 	struct sk_buff *skb = xs->skb;
 	bool first_frag = false;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, desc, xs->generic_cache);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			goto free_err;
@@ -694,6 +740,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			addrs = kmem_cache_zalloc(xs->generic_cache, GFP_KERNEL);
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
@@ -759,7 +814,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+
+	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	addrs->addrs[addrs->num_descs++] = desc->addr;
 
 	return skb;
 
@@ -769,7 +826,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_skb_descs(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -812,7 +869,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1095,6 +1152,7 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 
 static int xsk_release(struct socket *sock)
 {
+	struct xsk_generic_cache *pcpu_cache;
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct net *net;
@@ -1123,6 +1181,15 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
 
+	pcpu_cache = per_cpu_ptr(&system_xsk_generic_cache, xs->queue_id);
+	if (pcpu_cache->cache) {
+		if (refcount_dec_and_test(&pcpu_cache->users)) {
+			kmem_cache_destroy(pcpu_cache->cache);
+			pcpu_cache->cache = NULL;
+			xs->generic_cache = NULL;
+		}
+	}
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1153,6 +1220,33 @@ static bool xsk_validate_queues(struct xdp_sock *xs)
 	return xs->fq_tmp && xs->cq_tmp;
 }
 
+static int xsk_alloc_generic_xmit_cache(struct xdp_sock *xs, u16 qid)
+{
+	struct xsk_generic_cache *pcpu_cache =
+		per_cpu_ptr(&system_xsk_generic_cache, qid);
+	struct kmem_cache *cache;
+	char cache_name[32];
+
+	if (refcount_read(&pcpu_cache->users) > 0) {
+		refcount_inc(&pcpu_cache->users);
+		xs->generic_cache = pcpu_cache->cache;
+		return 0;
+	}
+
+	snprintf(cache_name, sizeof(cache_name),
+		 "xsk_generic_xmit_cache%d", qid);
+	cache = kmem_cache_create(cache_name, sizeof(struct xsk_addrs), 0,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!cache)
+		return -ENOMEM;
+
+	refcount_set(&pcpu_cache->users, 1);
+	pcpu_cache->cache = cache;
+	xs->generic_cache = pcpu_cache->cache;
+
+	return 0;
+}
+
 static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
 	struct sockaddr_xdp *sxdp = (struct sockaddr_xdp *)addr;
@@ -1306,6 +1400,16 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->zc = xs->umem->zc;
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
+
+	if (!xs->zc) {
+		err = xsk_alloc_generic_xmit_cache(xs, qid);
+		if (err) {
+			xp_destroy(xs->pool);
+			xs->pool = NULL;
+			goto out_unlock;
+		}
+	}
+
 	xp_add_xsk(xs->pool, xs);
 
 	if (qid < dev->real_num_rx_queues) {
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


