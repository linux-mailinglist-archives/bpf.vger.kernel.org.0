Return-Path: <bpf+bounces-46021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565E9E29B2
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0F285741
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BE20ADEC;
	Tue,  3 Dec 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+oGVyHD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3220ADC7;
	Tue,  3 Dec 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247687; cv=none; b=JN0JOvB45t1qgQKKZm8AiWCNplgcSaDTH7+FDjAu/qqPh8ouNTDCwJDD2wjP1ME6+SkiltqxBDN9qd3s3TGa9J9fGArgG0WNNcy8+b/ItNEWpwfFYRruz68WAKaBpfDDSBpTq7rNSnwaUxxA3V5eSbVIO/7igDcW+LEhHRmm+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247687; c=relaxed/simple;
	bh=EWj+eSqqv9vkBNcbHcZd0XKt/9Lfn/yqLyteSTZyC68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmfXkhsqr8yNtfdrWHSl/9R+iTsdT3sbYh9zC/uis/4O/Aue9TPWKM+muD2BMmUKfGAEC1oVJ4F4iGte8Q0aTmpih+UlUt+HsVzBiNne6RHlWlsn7DoUpurDGBJ4nze3nUOGqqZ+jSWKswprQpRwwRUlVaz0JjQUJdZY18GiOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+oGVyHD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247687; x=1764783687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EWj+eSqqv9vkBNcbHcZd0XKt/9Lfn/yqLyteSTZyC68=;
  b=m+oGVyHDP9J1jaZQRmDECR1MsGux46+TVxYxAKMMP7yoh5QsqIAuyFz3
   Z9dRKhIn+sj9wx2e6niZFle4Dpd5895Dy65uUxHPr4QKFB36R1j5F6k59
   m8KO46m8Omm3C6mYcU3iLq6y3uLcWuRFlK5BQ/d+TGoC4vKpE8hv8T0UW
   qF5Ekl2Foln58ZkyImBKKcuSimKWFWK6r4WcsjH0Hu7noSXFuZdsfGWCY
   IIvCAkZs5BZBJXm+WCXq3jrMlVUSKojB1LLJaWzM9AORHsv/wlKELhc0D
   qlyhV3reCcnByM/Tk0wDYL7Muzx1lrcJz0ny3ipzIEV1GBFxo12VLUHdL
   Q==;
X-CSE-ConnectionGUID: WkFyrUikRjirP4LCK8SeeQ==
X-CSE-MsgGUID: +54azD4cSPiLLzGSU7M8Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135429"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135429"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:41:26 -0800
X-CSE-ConnectionGUID: ypKAqCwBTjmCi/rw8a5GMg==
X-CSE-MsgGUID: FXTSM9maTWmreoaPP+aYnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124337044"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:41:22 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 09/10] page_pool: allow mixing PPs within one bulk
Date: Tue,  3 Dec 2024 18:37:32 +0100
Message-ID: <20241203173733.3181246-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
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
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h |  6 ++--
 include/net/xdp.h             | 16 ++++++---
 net/core/page_pool.c          | 61 ++++++++++++++++++++++++++---------
 net/core/xdp.c                | 29 +----------------
 4 files changed, 61 insertions(+), 51 deletions(-)

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
index 4c85b77cfdac..62cd1fcb9e97 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -841,7 +841,6 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
 /**
  * page_pool_put_netmem_bulk() - release references on multiple netmems
- * @pool:	pool from which pages were allocated
  * @data:	array holding netmem references
  * @count:	number of entries in @data
  *
@@ -854,35 +853,58 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
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
+	bool allow_direct, in_softirq, again = false;
+	netmem_ref bulk[XDP_BULK_QUEUE_SIZE];
+	u32 i, bulk_len, foreign;
+	struct page_pool *pool;
 
-	allow_direct = page_pool_napi_local(pool);
+again:
+	pool = NULL;
+	bulk_len = 0;
+	foreign = 0;
 
 	for (i = 0; i < count; i++) {
-		netmem_ref netmem = netmem_compound_head(data[i]);
+		struct page_pool *netmem_pp;
+		netmem_ref netmem;
+
+		if (!again) {
+			netmem = netmem_compound_head(data[i]);
 
-		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_ref(netmem))
+			/* It is not the last user for the page frag case */
+			if (!page_pool_is_last_ref(netmem))
+				continue;
+		} else {
+			netmem = data[i];
+		}
+
+		netmem_pp = netmem_get_pp(netmem);
+		if (unlikely(!pool)) {
+			pool = netmem_pp;
+			allow_direct = page_pool_napi_local(pool);
+		} else if (netmem_pp != pool) {
+			/*
+			 * If the netmem belongs to a different page_pool, save
+			 * it for another round after the main loop.
+			 */
+			data[foreign++] = netmem;
 			continue;
+		}
 
 		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
 		/* Approved for bulk recycling in ptr_ring cache */
 		if (netmem)
-			data[bulk_len++] = netmem;
+			bulk[bulk_len++] = netmem;
 	}
 
 	if (!bulk_len)
-		return;
+		goto out;
 
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
-		if (__ptr_ring_produce(&pool->ring, (__force void *)data[i])) {
+		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
@@ -893,13 +915,22 @@ void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
 
 	/* Hopefully all pages was return into ptr_ring */
 	if (likely(i == bulk_len))
-		return;
+		goto out;
 
 	/* ptr_ring cache full, free remaining pages outside producer lock
 	 * since put_page() with refcnt == 1 can be an expensive operation
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, data[i]);
+		page_pool_return_page(pool, bulk[i]);
+
+out:
+	if (!foreign)
+		return;
+
+	count = foreign;
+	again = true;
+
+	goto again;
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
2.47.0


