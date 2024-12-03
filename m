Return-Path: <bpf+bounces-46020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B2A9E29AB
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25622849B6
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5720A5E5;
	Tue,  3 Dec 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdQ5QRbo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FF20A5CB;
	Tue,  3 Dec 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247683; cv=none; b=VqeCspDnNpdcLhp9ZeYrDEqcUIuTzVE5Nwbx6gtUvuFc79CqYP/r1PE7hdpw23Xv+q/Yy+beb0Rs0us6K3HoLTR8HUlXzST6lm7xPAzJfZnI/va1ff+/kYhIssx2rpJ1mZcRDIpPob4AFI2Jp0+ZAk2T0BRER8a9xxITAP/rv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247683; c=relaxed/simple;
	bh=srzdhVSe0bOZ5dYbR4+l19hRc2bd5PzeOeDjpdTorM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3W382KCmAmOxOsP/7P+JdD95bTKyTOHHsgygi+znbGrG3kE0hz1AyNAFVWN5bfyceQGL69VVg7zF13uOo0dSOoYb0lzZ1C9ZhUwBE9ToQUgbsLG0gxp0AXllk3B7VZOVCT0GEqWKcBNbHPcu+VviTaBWDWP5uGPGF/GUDDhx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdQ5QRbo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247682; x=1764783682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=srzdhVSe0bOZ5dYbR4+l19hRc2bd5PzeOeDjpdTorM0=;
  b=JdQ5QRboUMXEWPzTm2m+cDzf5Z6wsD4q7RdJmhxfHoUE54Kt/qUHccC7
   F5V6cRag705HIWSS3JAyG/6CdkwiR6UPsAFUO5VZqj3G3rZQ6137ZWWUw
   KId3b0+buxNlxxwCpmhaPXVBLJkRT0S/SPLRqTmzu9vm3hdpaOZqhXL0D
   PSj1XcyJyDSp+9yqxuKsbnh+iDnN51hzphD8rzecoeRczz7oawrx3MaNE
   6VN0cs97mcZyD2wsWsmjw/FEZOwqJbgCUonQj+VYP0QN3RXwh7LZfwyLz
   aZTX7ghGcdWR5uYyL9Al8fBmMUeRWxxXUNZ0ePGaghMf9dtaGHiRl8PZJ
   g==;
X-CSE-ConnectionGUID: r7C83VcAQXSCmtFy0vDy4Q==
X-CSE-MsgGUID: EFBRx3O6S4Ok72TxgPQ1VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135405"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135405"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:41:22 -0800
X-CSE-ConnectionGUID: 2zqxhW3gRX+DRR6YMolS+Q==
X-CSE-MsgGUID: 9OXe8E9dSrClyQdTFOoDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124337041"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:41:18 -0800
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
Subject: [PATCH net-next v6 08/10] page_pool: make page_pool_put_page_bulk() handle array of netmems
Date: Tue,  3 Dec 2024 18:37:31 +0100
Message-ID: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, page_pool_put_page_bulk() indeed takes an array of pointers
to the data, not pages, despite the name. As one side effect, when
you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
converts page pointers to virtual addresses and then
page_pool_put_page_bulk() converts them back. Moreover, data pointers
assume every frag is placed in the host memory, making this function
non-universal.
Make page_pool_put_page_bulk() handle array of netmems. Pass frag
netmems directly and use virt_to_netmem() when freeing xdpf->data,
so that the PP core will then get the compound netmem and take care
of the rest.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h |  8 ++++----
 include/net/xdp.h             |  2 +-
 net/core/page_pool.c          | 30 +++++++++++++++---------------
 net/core/xdp.c                |  6 +++---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..1ea16b0e9c79 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -259,8 +259,8 @@ void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
-void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-			     int count);
+void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
+			       u32 count);
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -272,8 +272,8 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 {
 }
 
-static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-					   int count)
+static inline void page_pool_put_netmem_bulk(struct page_pool *pool,
+					     netmem_ref *data, u32 count)
 {
 }
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 1253fe21ede7..f4020b29122f 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -194,7 +194,7 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 struct xdp_frame_bulk {
 	int count;
 	void *xa;
-	void *q[XDP_BULK_QUEUE_SIZE];
+	netmem_ref q[XDP_BULK_QUEUE_SIZE];
 };
 
 static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f89cf93f6eb4..4c85b77cfdac 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -840,22 +840,22 @@ void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
 EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
 /**
- * page_pool_put_page_bulk() - release references on multiple pages
+ * page_pool_put_netmem_bulk() - release references on multiple netmems
  * @pool:	pool from which pages were allocated
- * @data:	array holding page pointers
- * @count:	number of pages in @data
+ * @data:	array holding netmem references
+ * @count:	number of entries in @data
  *
- * Tries to refill a number of pages into the ptr_ring cache holding ptr_ring
- * producer lock. If the ptr_ring is full, page_pool_put_page_bulk()
- * will release leftover pages to the page allocator.
- * page_pool_put_page_bulk() is suitable to be run inside the driver NAPI tx
+ * Tries to refill a number of netmems into the ptr_ring cache holding ptr_ring
+ * producer lock. If the ptr_ring is full, page_pool_put_netmem_bulk()
+ * will release leftover netmems to the memory provider.
+ * page_pool_put_netmem_bulk() is suitable to be run inside the driver NAPI tx
  * completion loop for the XDP_REDIRECT use case.
  *
  * Please note the caller must not use data area after running
- * page_pool_put_page_bulk(), as this function overwrites it.
+ * page_pool_put_netmem_bulk(), as this function overwrites it.
  */
-void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-			     int count)
+void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
+			       u32 count)
 {
 	int i, bulk_len = 0;
 	bool allow_direct;
@@ -864,7 +864,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	allow_direct = page_pool_napi_local(pool);
 
 	for (i = 0; i < count; i++) {
-		netmem_ref netmem = page_to_netmem(virt_to_head_page(data[i]));
+		netmem_ref netmem = netmem_compound_head(data[i]);
 
 		/* It is not the last user for the page frag case */
 		if (!page_pool_is_last_ref(netmem))
@@ -873,7 +873,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
 		/* Approved for bulk recycling in ptr_ring cache */
 		if (netmem)
-			data[bulk_len++] = (__force void *)netmem;
+			data[bulk_len++] = netmem;
 	}
 
 	if (!bulk_len)
@@ -882,7 +882,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
-		if (__ptr_ring_produce(&pool->ring, data[i])) {
+		if (__ptr_ring_produce(&pool->ring, (__force void *)data[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
@@ -899,9 +899,9 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	 * since put_page() with refcnt == 1 can be an expensive operation
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, (__force netmem_ref)data[i]);
+		page_pool_return_page(pool, data[i]);
 }
-EXPORT_SYMBOL(page_pool_put_page_bulk);
+EXPORT_SYMBOL(page_pool_put_netmem_bulk);
 
 static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 				       netmem_ref netmem)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index de1e9cb78718..938ad15c9857 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -518,7 +518,7 @@ void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq)
 	if (unlikely(!xa || !bq->count))
 		return;
 
-	page_pool_put_page_bulk(xa->page_pool, bq->q, bq->count);
+	page_pool_put_netmem_bulk(xa->page_pool, bq->q, bq->count);
 	/* bq->xa is not cleared to save lookup, if mem.id same in next bulk */
 	bq->count = 0;
 }
@@ -559,12 +559,12 @@ void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 		for (i = 0; i < sinfo->nr_frags; i++) {
 			skb_frag_t *frag = &sinfo->frags[i];
 
-			bq->q[bq->count++] = skb_frag_address(frag);
+			bq->q[bq->count++] = skb_frag_netmem(frag);
 			if (bq->count == XDP_BULK_QUEUE_SIZE)
 				xdp_flush_frame_bulk(bq);
 		}
 	}
-	bq->q[bq->count++] = xdpf->data;
+	bq->q[bq->count++] = virt_to_netmem(xdpf->data);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
 
-- 
2.47.0


