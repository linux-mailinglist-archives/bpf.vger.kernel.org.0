Return-Path: <bpf+bounces-44262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D939C0B3D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77451C234CF
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2012194A0;
	Thu,  7 Nov 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtiF8NAS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C9219480;
	Thu,  7 Nov 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996063; cv=none; b=AWYgI18Q3PqdrN+sZSQwrRAlBpC+1S1bo/9WwXEpyNwUWs5tY/lefIudZ08l7u3/HWPa11qh86AWhr8wGdi59kzUFGenMRflqYhAnkHAT6ceFEE9sl5nQMz8FeAOumRss2v+RgANjjjZZo8SFtVElcutz6T6SfiPhkZ/anFoYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996063; c=relaxed/simple;
	bh=H5EWsB5X8TMvpXemtCG/qOm20YK3S2tsf/Uf0SCDpPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQxCccgHop5J258SECHwhSYXy26LSa5vBDdAQ8UxIcesAS4qSVmR2WmsxT2HnWUHQTYI32hBBb6bWe+cOApCdg6PA0OhuKvBCaw61vDFoKbXKLZLAbSsG7G320BKjFCfcqFFjSxpDKQJK7J14DE+fzqF5oPns6yZ6EdixomwIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtiF8NAS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996062; x=1762532062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5EWsB5X8TMvpXemtCG/qOm20YK3S2tsf/Uf0SCDpPE=;
  b=EtiF8NASZ10UrGqajTbTGakuSGA1XsI5QRTLzWqlu9kPHkVNYRQpSJ6w
   CF1cIlFWbHb1CwS2JnF0MT6XJQ6wPOIRRVq8DUr7cfLILwSOQW4ES4Um9
   YWwDOXxeJFJfIHC3l3VZ7mCApraZYthayDo28pWxcWVGUumDD/oghAGSw
   xnQbV0OaDWrAFA73Ozt45toLLWMeJtBP57a9FWqVXHs1pJK6BuHwzrDAM
   ZGLZi6aTM11A0ByxXZA7FX3TfQoBCwVnbBoC7SGRAT1bHp1l1XT+kLdEh
   wd4SuYPvbLNVlPHwN+GpcP7OOydjpdtFedbuRcrfEZ3Iu4+UrPY0czeqw
   g==;
X-CSE-ConnectionGUID: amH0BrHLS+uphJe6O6hQGQ==
X-CSE-MsgGUID: bTJPkAV8TIWRFrTp9jBzbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41955954"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41955954"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:20 -0800
X-CSE-ConnectionGUID: Z8HTsGHoTlmzkW1pt4MURg==
X-CSE-MsgGUID: FWYHC3KFQXCt5WXHrKnSCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258213"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:17 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 09/19] page_pool: allow mixing PPs within one bulk
Date: Thu,  7 Nov 2024 17:10:16 +0100
Message-ID: <20241107161026.2903044-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main reason for this change was to allow mixing pages from different
&page_pools within one &xdp_buff/&xdp_frame. Why not?
Adjust xdp_return_frame_bulk() and page_pool_put_page_bulk(), so that
they won't be tied to a particular pool. Let the latter create a
separate bulk of pages which's PP is different and process it after
the main loop.
This greatly optimizes xdp_return_frame_bulk(): no more hashtable
lookups. Also make xdp_flush_frame_bulk() inline, as it's just one if +
function call + one u32 read, not worth extending the call ladder.

Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com> # iterative
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h |  6 ++--
 include/net/xdp.h             | 16 +++++++---
 net/core/page_pool.c          | 60 +++++++++++++++++++++++++++--------
 net/core/xdp.c                | 29 +----------------
 4 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6c1be99a5959..269ee1788388 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -259,8 +259,7 @@ void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
-void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
-			     u32 count);
+void page_pool_put_page_bulk(struct page **data, u32 count);
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -272,8 +271,7 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 {
 }
 
-static inline void page_pool_put_page_bulk(struct page_pool *pool,
-					   struct page **data, u32 count)
+static inline void page_pool_put_page_bulk(struct page **data, u32 count)
 {
 }
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 4416cd4b5086..cce819ee17d3 100644
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
 	struct page *q[XDP_BULK_QUEUE_SIZE];
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
+	page_pool_put_page_bulk(bq->q, bq->count);
+	bq->count = 0;
+}
+
 static __always_inline unsigned int
 xdp_get_frame_len(const struct xdp_frame *xdpf)
 {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ad219206ee8d..2d67c2cc3d77 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -841,7 +841,6 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
 /**
  * page_pool_put_page_bulk() - release references on multiple pages
- * @pool:	pool from which pages were allocated
  * @data:	array holding page pointers
  * @count:	number of pages in @data
  *
@@ -854,35 +853,61 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
  * Please note the caller must not use data area after running
  * page_pool_put_page_bulk(), as this function overwrites it.
  */
-void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
-			     u32 count)
+void page_pool_put_page_bulk(struct page **data, u32 count)
 {
-	int i, bulk_len = 0;
+	netmem_ref bulk[XDP_BULK_QUEUE_SIZE];
+	int i, bulk_len, foreign;
+	struct page_pool *pool;
+	bool again = false;
 	bool allow_direct;
 	bool in_softirq;
 
-	allow_direct = page_pool_napi_local(pool);
+again:
+	pool = NULL;
+	bulk_len = 0;
+	foreign = 0;
 
 	for (i = 0; i < count; i++) {
-		netmem_ref netmem = page_to_netmem(compound_head(data[i]));
+		struct page *page;
+		netmem_ref netmem;
+
+		if (!again) {
+			page = compound_head(data[i]);
+			netmem = page_to_netmem(page);
 
-		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_ref(netmem))
+			/* It is not the last user for the page frag case */
+			if (!page_pool_is_last_ref(netmem))
+				continue;
+		} else {
+			page = data[i];
+			netmem = page_to_netmem(page);
+		}
+
+		if (unlikely(!pool)) {
+			pool = page->pp;
+			allow_direct = page_pool_napi_local(pool);
+		} else if (page->pp != pool) {
+			/*
+			 * If the page belongs to a different page_pool, save
+			 * it for a second round after the main loop.
+			 */
+			data[foreign++] = page;
 			continue;
+		}
 
 		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
 		/* Approved for bulk recycling in ptr_ring cache */
 		if (netmem)
-			data[bulk_len++] = (__force void *)netmem;
+			bulk[bulk_len++] = netmem;
 	}
 
 	if (!bulk_len)
-		return;
+		goto out;
 
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
-		if (__ptr_ring_produce(&pool->ring, data[i])) {
+		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
@@ -893,13 +918,22 @@ void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
 
 	/* Hopefully all pages was return into ptr_ring */
 	if (likely(i == bulk_len))
-		return;
+		goto out;
 
 	/* ptr_ring cache full, free remaining pages outside producer lock
 	 * since put_page() with refcnt == 1 can be an expensive operation
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, (__force netmem_ref)data[i]);
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
 EXPORT_SYMBOL(page_pool_put_page_bulk);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 779e646f347b..0fde1bb54192 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -508,46 +508,19 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
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
-	page_pool_put_page_bulk(xa->page_pool, bq->q, bq->count);
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


