Return-Path: <bpf+bounces-46649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA0A9ED37B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15C9167686
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662B1FF5EA;
	Wed, 11 Dec 2024 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bf909Bn9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A41FF1D8;
	Wed, 11 Dec 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938122; cv=none; b=BidSC+TLAIQjpxNvb1upjnbB2ymMKfI81RHrouVtC4CDZrc5VsqagMoibxT7KYVmfslSjPLfaPMfebmyfXo/4hXRNV/nCGY7KLtj4uj5vng/4aflieAAZSSh7wGDb/pROO5dtkcI8zS3Johf6u39mgo1w370gAL6Q7BN4659rT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938122; c=relaxed/simple;
	bh=coimtJvSzbRkkZlz8bU5k7oSmrKJ14aYGjTo77fKFlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbvd4j0JuL5oTwtjOdDMnMVtQaYc4pWjjh7K+QCx2r0FZap2iEV58oxfZpnC+F8BfAcBcT9ol93jlRxZsy+8GVUlC3UFS9oPk5uM2zg0Hc6SuCTiVe+2e1U92L2k98VWXaj1PbLB7ZIOpG4ZGFnSU8Mr3ldRdPAXfr2SjJGGfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bf909Bn9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938121; x=1765474121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=coimtJvSzbRkkZlz8bU5k7oSmrKJ14aYGjTo77fKFlU=;
  b=bf909Bn9CdX9iaeGBpZA7n4/xBvDzWXkOG348l5P1QdxjacxivA5OuCD
   hcQWnldBPccPnbQuQN8cXe60dje68z9eiI5S2879hUA9bs5xodsKVz0pD
   jflyGbtGwRcdvWnlivqbg4MFSbvQD04Uw2XH31jrCAuOKgT4+w+6QbkWD
   6cgV+LX8gdM6Pqx0uhw8a6GIv/u3lNfokW1LfEEVAuls5kacmntIA1ci7
   yk5JQzBWxcwYjCsvJAWxew5cXIWWCb7YVqTVA9cviif0cimVLmFK/oJY7
   8wo9wKqhi/q9o40hqHFpBulrqSjRNuw2rz1EjJDkSbtQhcss/k9PNGZhO
   g==;
X-CSE-ConnectionGUID: aKraRuulT562rg0kOPr40w==
X-CSE-MsgGUID: i59N4UttT9Ouq01Mz4Q5cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859458"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859458"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:28:41 -0800
X-CSE-ConnectionGUID: 7QK2WAQOQ8mK4a9sIjzukg==
X-CSE-MsgGUID: 39ITWS6hQ++Dzz4D9rY+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122084"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:28:35 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/12] page_pool: allow mixing PPs within one bulk
Date: Wed, 11 Dec 2024 18:26:38 +0100
Message-ID: <20241211172649.761483-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main reason for this change was to allow mixing pages from different
&page_pools within one &xdp_buff/&xdp_frame. Why not? With stuff like
devmem and io_uring zerocopy Rx, it's required to have separate PPs for
header buffers and payload buffers.
Adjust xdp_return_frame_bulk() and page_pool_put_netmem_bulk(), so that
they won't be tied to a particular pool. Let the latter create a
separate bulk of pages which's PP is different from the first netmem of
the bulk and process it after the main loop.
This greatly optimizes xdp_return_frame_bulk(): no more hashtable
lookups and forced flushes on PP mismatch. Also make
xdp_flush_frame_bulk() inline, as it's just one if + function call + one
u32 read, not worth extending the call ladder.

Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com> # iterative
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org> # while (count)
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h |   6 +-
 include/net/xdp.h             |  16 +++--
 net/core/page_pool.c          | 109 ++++++++++++++++++++++------------
 net/core/xdp.c                |  29 +--------
 4 files changed, 87 insertions(+), 73 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1ea16b0e9c79..05a864031271 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -259,8 +259,7 @@ void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
-void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
-			       u32 count);
+void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -272,8 +271,7 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 {
 }
 
-static inline void page_pool_put_netmem_bulk(struct page_pool *pool,
-					     netmem_ref *data, u32 count)
+static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 {
 }
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index f4020b29122f..9e7eb8223513 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -11,6 +11,8 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h> /* skb_shared_info */
 
+#include <net/page_pool/types.h>
+
 /**
  * DOC: XDP RX-queue information
  *
@@ -193,14 +195,12 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
-	void *xa;
 	netmem_ref q[XDP_BULK_QUEUE_SIZE];
 };
 
 static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
 {
-	/* bq->count will be zero'ed when bq->xa gets updated */
-	bq->xa = NULL;
+	bq->count = 0;
 }
 
 static inline struct skb_shared_info *
@@ -317,10 +317,18 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
 void xdp_return_buff(struct xdp_buff *xdp);
-void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq);
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq);
 
+static inline void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq)
+{
+	if (unlikely(!bq->count))
+		return;
+
+	page_pool_put_netmem_bulk(bq->q, bq->count);
+	bq->count = 0;
+}
+
 static __always_inline unsigned int
 xdp_get_frame_len(const struct xdp_frame *xdpf)
 {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4c85b77cfdac..10cef95f12e3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -839,9 +839,41 @@ void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
+static void page_pool_recycle_ring_bulk(struct page_pool *pool,
+					netmem_ref *bulk,
+					u32 bulk_len)
+{
+	bool in_softirq;
+	u32 i;
+
+	/* Bulk produce into ptr_ring page_pool cache */
+	in_softirq = page_pool_producer_lock(pool);
+
+	for (i = 0; i < bulk_len; i++) {
+		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
+			/* ring full */
+			recycle_stat_inc(pool, ring_full);
+			break;
+		}
+	}
+
+	page_pool_producer_unlock(pool, in_softirq);
+	recycle_stat_add(pool, ring, i);
+
+	/* Hopefully all pages were returned into ptr_ring */
+	if (likely(i == bulk_len))
+		return;
+
+	/*
+	 * ptr_ring cache is full, free remaining pages outside producer lock
+	 * since put_page() with refcnt == 1 can be an expensive operation.
+	 */
+	for (; i < bulk_len; i++)
+		page_pool_return_page(pool, bulk[i]);
+}
+
 /**
  * page_pool_put_netmem_bulk() - release references on multiple netmems
- * @pool:	pool from which pages were allocated
  * @data:	array holding netmem references
  * @count:	number of entries in @data
  *
@@ -854,52 +886,55 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
  * Please note the caller must not use data area after running
  * page_pool_put_netmem_bulk(), as this function overwrites it.
  */
-void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
-			       u32 count)
+void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 {
-	int i, bulk_len = 0;
-	bool allow_direct;
-	bool in_softirq;
-
-	allow_direct = page_pool_napi_local(pool);
+	u32 bulk_len = 0;
 
-	for (i = 0; i < count; i++) {
+	for (u32 i = 0; i < count; i++) {
 		netmem_ref netmem = netmem_compound_head(data[i]);
 
-		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_ref(netmem))
-			continue;
-
-		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
-		/* Approved for bulk recycling in ptr_ring cache */
-		if (netmem)
+		if (page_pool_is_last_ref(netmem))
 			data[bulk_len++] = netmem;
 	}
 
-	if (!bulk_len)
-		return;
-
-	/* Bulk producer into ptr_ring page_pool cache */
-	in_softirq = page_pool_producer_lock(pool);
-	for (i = 0; i < bulk_len; i++) {
-		if (__ptr_ring_produce(&pool->ring, (__force void *)data[i])) {
-			/* ring full */
-			recycle_stat_inc(pool, ring_full);
-			break;
+	count = bulk_len;
+	while (count) {
+		netmem_ref bulk[XDP_BULK_QUEUE_SIZE];
+		struct page_pool *pool = NULL;
+		bool allow_direct;
+		u32 foreign = 0;
+
+		bulk_len = 0;
+
+		for (u32 i = 0; i < count; i++) {
+			struct page_pool *netmem_pp;
+			netmem_ref netmem = data[i];
+
+			netmem_pp = netmem_get_pp(netmem);
+			if (unlikely(!pool)) {
+				pool = netmem_pp;
+				allow_direct = page_pool_napi_local(pool);
+			} else if (netmem_pp != pool) {
+				/*
+				 * If the netmem belongs to a different
+				 * page_pool, save it for another round.
+				 */
+				data[foreign++] = netmem;
+				continue;
+			}
+
+			netmem = __page_pool_put_page(pool, netmem, -1,
+						      allow_direct);
+			/* Approved for bulk recycling in ptr_ring cache */
+			if (netmem)
+				bulk[bulk_len++] = netmem;
 		}
-	}
-	recycle_stat_add(pool, ring, i);
-	page_pool_producer_unlock(pool, in_softirq);
 
-	/* Hopefully all pages was return into ptr_ring */
-	if (likely(i == bulk_len))
-		return;
+		if (bulk_len)
+			page_pool_recycle_ring_bulk(pool, bulk, bulk_len);
 
-	/* ptr_ring cache full, free remaining pages outside producer lock
-	 * since put_page() with refcnt == 1 can be an expensive operation
-	 */
-	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, data[i]);
+		count = foreign;
+	}
 }
 EXPORT_SYMBOL(page_pool_put_netmem_bulk);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 938ad15c9857..56127e8ec85f 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -511,46 +511,19 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
  * xdp_frame_bulk is usually stored/allocated on the function
  * call-stack to avoid locking penalties.
  */
-void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq)
-{
-	struct xdp_mem_allocator *xa = bq->xa;
-
-	if (unlikely(!xa || !bq->count))
-		return;
-
-	page_pool_put_netmem_bulk(xa->page_pool, bq->q, bq->count);
-	/* bq->xa is not cleared to save lookup, if mem.id same in next bulk */
-	bq->count = 0;
-}
-EXPORT_SYMBOL_GPL(xdp_flush_frame_bulk);
 
 /* Must be called with rcu_read_lock held */
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq)
 {
-	struct xdp_mem_info *mem = &xdpf->mem;
-	struct xdp_mem_allocator *xa;
-
-	if (mem->type != MEM_TYPE_PAGE_POOL) {
+	if (xdpf->mem.type != MEM_TYPE_PAGE_POOL) {
 		xdp_return_frame(xdpf);
 		return;
 	}
 
-	xa = bq->xa;
-	if (unlikely(!xa)) {
-		xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
-		bq->count = 0;
-		bq->xa = xa;
-	}
-
 	if (bq->count == XDP_BULK_QUEUE_SIZE)
 		xdp_flush_frame_bulk(bq);
 
-	if (unlikely(mem->id != xa->mem.id)) {
-		xdp_flush_frame_bulk(bq);
-		bq->xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
-	}
-
 	if (unlikely(xdp_frame_has_frags(xdpf))) {
 		struct skb_shared_info *sinfo;
 		int i;
-- 
2.47.1


