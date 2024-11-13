Return-Path: <bpf+bounces-44764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16699C772C
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BE42843E1
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE602071FA;
	Wed, 13 Nov 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkzM88BE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C14206E71;
	Wed, 13 Nov 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511538; cv=none; b=MF0GWUrhw2VbXbfL7hPrpW0axpgnE2DDkj1QLXNnc/H4sZ6KWVAe3O9bS4yumglcAM70oyzce9WsgSjY5QF2ghUym28aFYrUSQRg41DKFGDx2P/Ir0CnMX4pOWjII/ie1Hmu7fn5T5PjWPw1y9yN0mHBMo7XOqB+GXXsE3C0QWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511538; c=relaxed/simple;
	bh=H5EWsB5X8TMvpXemtCG/qOm20YK3S2tsf/Uf0SCDpPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuoQnukRVHiav5BQRHJG0KtvQ2nt+Q3j3/Q6QF7gLlRvqCkPk8au30zCLTrPj/HxFczlVG3RaFb39x9nF+avcF6URWOZinJogtOKELQL5cbS4rJjkpL0n7tc3iQnVwstrFJ9UeUUU9EV+tFVIKxrrJ/jUCnN+7V8EMwjqDp12fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkzM88BE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511537; x=1763047537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5EWsB5X8TMvpXemtCG/qOm20YK3S2tsf/Uf0SCDpPE=;
  b=IkzM88BES7mz1N/XizBPOuiafL0BuMStcSGCg3ouKh2ttzwzamVFhsZy
   32RUNkWzU8merQDfcA5ZAEAbc1ywjh807B5/ms4KbFDLVCplcq1LIvWks
   Xb6uhN80g70bSRerbZ0N9ws9IeQZBDF2X8XmXvx8G+uuxWj4/p2zsp/7X
   0FZVS3cDj63ujeyeam0VhCH935m2rQOI9Em+Ba1lK7lke81TvDA/+apVE
   AuQ2n4/+vfUb/1tntSXtqiL4+aKtbgEw6sUYvKHzQej+e2JApxxMRdWbR
   25ai+GCd+qOW3yh2+D9GXK2kP26kHBcdSGGU4IUxPEmsl2IO9V10Vt47b
   Q==;
X-CSE-ConnectionGUID: iPTh1pMVSBmdYD/ihG16hA==
X-CSE-MsgGUID: 3qBGyH9cQgGhJnKziWEv6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799335"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799335"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:37 -0800
X-CSE-ConnectionGUID: gq3cRwsWSwiHVh24t8IKsQ==
X-CSE-MsgGUID: SNBNAKQHRZmOZ+Xl2rf2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726948"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:33 -0800
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
Subject: [PATCH net-next v5 09/19] page_pool: allow mixing PPs within one bulk
Date: Wed, 13 Nov 2024 16:24:32 +0100
Message-ID: <20241113152442.4000468-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
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


