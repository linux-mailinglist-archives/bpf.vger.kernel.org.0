Return-Path: <bpf+bounces-41428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B2997000
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC88281A89
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14EF1E5727;
	Wed,  9 Oct 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvNj4M9z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0F1E5713;
	Wed,  9 Oct 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487753; cv=none; b=obXt2aM+ZFf3bAJfe6eCRct8KwCFxBXkvBzmSunZM6pkJw4ej+Ji8klxA1+XoTFyaEe28ynrKPYEsCN+4GhdlW13JCzSXc4atxvnlV6Q83xYzRnfWONLDjEHd7gByah+FGFNlIbqp0VqLRQhaokpxEUGgkSqeGbiz9gpfn3droM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487753; c=relaxed/simple;
	bh=dKSd1kPDw+yeIAzbWu7UjF1bVJ2WCtTpGkqUxz/8jlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSUo0bKGJCpMIv+n77jZ6WIJiDjMTANWnzRH6frbGPJpyURBfeXcgBX/TEkKMlPuji7WJjyNE8QR1R3unZYfd+58dAKhFxjMryHq2yKegix+KKfOGEUyYJWL7srDHiq/6wwv6rqr6TOyHJrSjtKLMZL6hgGbpCv/3ov382hd+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvNj4M9z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487751; x=1760023751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dKSd1kPDw+yeIAzbWu7UjF1bVJ2WCtTpGkqUxz/8jlI=;
  b=fvNj4M9zzZzgJ1ru4WHBpdRzWPjzV9XyDYDuXdaynYTdjFW3W/nZTrv4
   Npch+OeD1LUVDIIUHnW/YNHARr4rq5ckKfCr8gXsNX8Z8kTQgdOTfotwh
   iBsJ+FYAdmS2a8D2xBLvqri+woXfk4wUQs6Y6h9FbsYMeZnc2ondGCyOe
   kwP+123CIN9YkoYO5f8zY9tU2RQFFxlle7eEJKCioPR+hT4qRQkTQDeJm
   qaHLrHfpuDvEQfdpPDfqhfV7+P/7x+SzLbhlW2/Hoa8v2m5Opu2hbVelj
   VfSpjN6qACikTrpVbg0eECn663YTblhQa/klj4RForYPC8AJnVIkdQvoi
   w==;
X-CSE-ConnectionGUID: UkUWQvptTX+rFjsq+q17dQ==
X-CSE-MsgGUID: Mi0yBwAAQvuyUmp8neC6/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675782"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:29:11 -0700
X-CSE-ConnectionGUID: +Zm6UkXyRFGO8j4Q0KLQaw==
X-CSE-MsgGUID: q3AE64BTR0KLs8eDFNu98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305983"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:29:07 -0700
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/18] page_pool: allow mixing PPs within one bulk
Date: Wed,  9 Oct 2024 17:27:47 +0200
Message-ID: <20241009152756.3113697-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main reason for this change was to allow mixing pages from different
&page_pools within one &xdp_buff/&xdp_frame. Why not?
Adjust xdp_return_frame_bulk() and page_pool_put_page_bulk(), so that
they won't be tied to a particular pool. Let the latter create a
separate bulk of pages which's PP is different and flush it recursively.
This greatly optimizes xdp_return_frame_bulk(): no more hashtable
lookups. Also make xdp_flush_frame_bulk() inline, as it's just one if +
function call + one u32 read, not worth extending the call ladder.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h |  7 +++--
 include/net/xdp.h             | 16 ++++++++---
 net/core/page_pool.c          | 50 ++++++++++++++++++++++++++++++-----
 net/core/xdp.c                | 29 +-------------------
 4 files changed, 59 insertions(+), 43 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6c1be99a5959..9a01ce864afa 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -259,8 +259,7 @@ void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
-void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
-			     u32 count);
+void page_pool_put_page_bulk(struct page **data, u32 count, bool rec);
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -272,8 +271,8 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 {
 }
 
-static inline void page_pool_put_page_bulk(struct page_pool *pool,
-					   struct page **data, u32 count)
+static inline void page_pool_put_page_bulk(struct page **data, u32 count,
+					   bool rec)
 {
 }
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index f99fbe9bf5a5..38f27b8b9efd 100644
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
@@ -316,10 +316,18 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
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
+	page_pool_put_page_bulk(bq->q, bq->count, false);
+	bq->count = 0;
+}
+
 static __always_inline unsigned int
 xdp_get_frame_len(const struct xdp_frame *xdpf)
 {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ad219206ee8d..22b44f86dfa0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -839,11 +839,22 @@ void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
+static void page_pool_bulk_rec_add(struct xdp_frame_bulk *bulk,
+				   struct page *page)
+{
+	bulk->q[bulk->count++] = page;
+
+	if (unlikely(bulk->count == ARRAY_SIZE(bulk->q))) {
+		page_pool_put_page_bulk(bulk->q, ARRAY_SIZE(bulk->q), true);
+		bulk->count = 0;
+	}
+}
+
 /**
  * page_pool_put_page_bulk() - release references on multiple pages
- * @pool:	pool from which pages were allocated
  * @data:	array holding page pointers
  * @count:	number of pages in @data
+ * @rec:	whether it's called recursively by itself
  *
  * Tries to refill a number of pages into the ptr_ring cache holding ptr_ring
  * producer lock. If the ptr_ring is full, page_pool_put_page_bulk()
@@ -854,21 +865,43 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
  * Please note the caller must not use data area after running
  * page_pool_put_page_bulk(), as this function overwrites it.
  */
-void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
-			     u32 count)
+void page_pool_put_page_bulk(struct page **data, u32 count, bool rec)
 {
+	struct page_pool *pool = NULL;
+	struct xdp_frame_bulk sub;
 	int i, bulk_len = 0;
 	bool allow_direct;
 	bool in_softirq;
 
-	allow_direct = page_pool_napi_local(pool);
+	xdp_frame_bulk_init(&sub);
 
 	for (i = 0; i < count; i++) {
-		netmem_ref netmem = page_to_netmem(compound_head(data[i]));
+		struct page *page;
+		netmem_ref netmem;
+
+		if (!rec) {
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
+			 * it to handle recursively after the main loop.
+			 */
+			page_pool_bulk_rec_add(&sub, page);
 			continue;
+		}
 
 		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
 		/* Approved for bulk recycling in ptr_ring cache */
@@ -876,6 +909,9 @@ void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
 			data[bulk_len++] = (__force void *)netmem;
 	}
 
+	if (sub.count)
+		page_pool_put_page_bulk(sub.q, sub.count, true);
+
 	if (!bulk_len)
 		return;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 4b2ff5a280bb..60a2d4122606 100644
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
2.46.2


