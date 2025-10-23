Return-Path: <bpf+bounces-71870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E7BFFAE9
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C429A3ABE33
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70952C1780;
	Thu, 23 Oct 2025 07:45:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED624634F;
	Thu, 23 Oct 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205501; cv=none; b=NnEDbsIaAHtc8F4Fo38MC/z4X95Mb5aUEHb5NHlWpzYPOhmjjcXYcOVdeVQw1ZqL/XmpTUyF1uRL51z1rxE5aaAAuo6D1fTjFIcPM47GH0tsXkoQpRQUM1wisUcHS+6LmAM/U2Jj1/SG6ct8IMHJ4qvoyTGVQcQlM3E2EYtQ6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205501; c=relaxed/simple;
	bh=bcO0IIMDLYsyIp56WuxfH+4Zuw9yuTNlc7vmAUjDf2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OXw+BrRO9jA0BLn10RlZy55Grs10CXg910BJatAHU0d6ccygVxEtFNAIl9Hr9cpukh4mZB0DoVsQRVZt53lNQMDustDRgibGgipgIMepfZb6A4SohzDNJbn91Z0/AqjsUxgL1fd+nBY74Qdf+JwNSsXyz5Adyx+r6g8hcBTXOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-d6-68f9dcf85542
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	willy@infradead.org,
	brauner@kernel.org,
	kas@kernel.org,
	yuzhao@google.com,
	usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com,
	almasrymina@google.com,
	toke@redhat.com,
	asml.silence@gmail.com,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: [RFC mm v4 2/2] mm: introduce a new page type for page pool in page type
Date: Thu, 23 Oct 2025 16:44:10 +0900
Message-Id: <20251023074410.78650-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251023074410.78650-1-byungchul@sk.com>
References: <20251023074410.78650-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+59zds5xuDitzNMNZZaBkV2Y8VoREgXHoJtBURE52sGNdMZm
	S4NIa1GZmlqG2YSJNE0Nc1q7oGLzXlFzXZiUrmYZaVl4GW5Wtil9+/E8z/v79NK4OEewnFaq
	Mni1SpYqIYWE8EdoxXrfB59i45VcAejr60ionc6Eqo8WAfjqvmKgr3mCYNL3noLZli4EEx3d
	JIy2jyOorPDioH+lI2Cq3o+D1fYVwUjpQxK+dHkoqDXtBbdxmIDmq2YcPDd7SMjXzeDQ4huj
	4JKlOiBuzKbA8aRAALf993EwZ3+k4LVNT8Jg3awAhu35BPSWPSDgV0kHDu6CBOgyLAXv8+8I
	OurNGHjzykl4e9eGweOWtxTcchpIGNK5ETjbPQSU/L5Gwr2cAgQz0wHlWOGkAO51DlIJsVyO
	y0Vy7d9/4lzTg36Me1daRHCu1mcYZy0boDiD6SzXWB3D5bqcOGequU5ypvFiivvwrpnkekpn
	CM76KZ6zWiYwLv/yGHkg7Jhwu5xPVWp59YYdyUJFyVPpmTuJma0vGrBs5NiWi0JolpGyb5rc
	glxEz/Hfz4eDMcmsZV0uHx7kJcxGtrpkMsBCGmdu0Oz71oa5YjFzkO3vzsOCtwSzhv38JywY
	i5g4Nsc5gs/rI9jaR21zHMJsYXv/dlJBFgc2jiI/Nb/poFlzT9I8L2OfVruIQiQyoAU1SKxU
	adNkylRprCJLpcyMPZWeZkKBxzBe+H3cgsYdh+yIoZEkVJTQPa0QC2RaTVaaHbE0Llki0h4N
	RCK5LOs8r04/qT6bymvsaAVNSMJFm73n5GImRZbBn+b5M7z6f4vRIcuzUZIxnPokpyy98pSU
	vq74RNlpfPbUosQBaflUpDHakzFUWecdLN/3Mm2nXxkxujU6ovCVTb6waV3R4+uh3pHJsF1R
	305s9tsaQjoPr99vqDrfE6FS67pL+72rI/OGe/HkRUlRawxtY1O7VxaXsca46dC+basoh1Xy
	4shFMb2njZAQGoVsUwyu1sj+AaCCXvwUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf0yMcRzHfZ/nued5Oo5np/LIjN0Ya+uHTfaxrDW/etgYs7EYOjx1R7/c
	qXVouspwlMJZ0k2Y3HWRLv1ULd1VkpJrtWv9VAlJUWldpVxt/nvt/eufN42L+wk3Wh5+gVeE
	S0MlpJAQ7vdN8JjssMu8X15fBxm5OSQYJ2PgeU+xAOw5XzHIyC5EMG5vp2CuvAbBmKWWhB/m
	UQRPH0/gkPExkYA/uVM4lJR+RTCY9oKELzW9FBhN+6A7a4CAsmtFOPTefkdCUuI0DuX2YQri
	i/WO4fw4Csy6OgE0FSYL4N7UMxyK4nooaC7NIKErZ04AA1VJBNSlGwj4pbXg0J3sDzWZrjBR
	P4TAkluEwcQtHQktD0oxKChvoeCuNZOEvsRuBFZzLwHameskPFQnI5iedEwOp4wL4GF1F+Xv
	xaltNpIzD43g3GtDG8a1pqUSnK3iPcaVpHdSXKYpisvXu3MamxXnTNk3SM40eofiOlrLSO5d
	2jTBlXzeypUUj2FcUsIwecD1qHDbGT5UHs0rvPyChDLt282R9/fEVHzIw+JQk68G0TTLbGZn
	+w9rkBNNMhtYm82Oz7Mz483qteMOFtI4c5Nm2yvyFozlzEG2rfYWNt8lmPVs/1+XeVnE+LBq
	6+BChGXWsMZXlQvsxGxh62arqXkWOzJNqVNUChJmokXZyFkeHh0mlYf6eCrPyVTh8hjP0xFh
	JuT4Pit2JrUYjTcHVCGGRpIlIv/aSZlYII1WqsKqEEvjEmdRdKBDEp2Rqi7yioiTiqhQXlmF
	VtGEZIVo7xE+SMyESC/w53g+klf8dzHayS0ONQj9zttUszoPTdm6gN2Ww6fEjW25G080XAnu
	WBbYaF15VX9sR7z657clhp0uvtO7rN/fL2a0eW98nDWV62++PHTZYoidre/sVe0JFvQJDzbv
	f6PrHth+98naNsG+CLEuZIU5a+mj0d8XF41s7PDoUT/yT398tsAY+On4l4aUUuOxS6slhFIm
	3eSOK5TSfxAth6D3AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

->pp_magic field in struct page is current used to identify if a page
belongs to a page pool.  However, ->pp_magic will be removed and page
type bit in struct page e.i. PGTY_netpp can be used for that purpose.

Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
and __ClearPageNetpp() instead, and remove the existing APIs accessing
->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
netmem_clear_pp_magic().

This work was inspired by the following link:

[1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/

While at it, move the sanity check for page pool to on free.

Suggested-by: David Hildenbrand <david@redhat.com>
Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
---
Hi Mina,

I dropped your Reviewed-by tag since there are updates on some comments
in network part.  Can I still keep your Reviewed-by?

	Byungchul
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/page-flags.h                    |  6 +++++
 include/net/netmem.h                          |  2 +-
 mm/page_alloc.c                               |  8 +++---
 net/core/netmem_priv.h                        | 17 +++---------
 net/core/page_pool.c                          | 14 +++++-----
 7 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5d51600935a6..def274f5c1ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check page_pool_page_is_pp() as we
+				/* No need to check PageNetpp() as we
 				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b6fdf3557807..f5155f1c75f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4361,10 +4361,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  * DMA mapping IDs for page_pool
  *
  * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
- * stashes it in the upper bits of page->pp_magic. We always want to be able to
- * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
- * pages can have arbitrary kernel pointers stored in the same field as pp_magic
- * (since it overlaps with page->lru.next), so we must ensure that we cannot
+ * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
+ * arbitrary kernel pointers stored in the same field as pp_magic (since
+ * it overlaps with page->lru.next), so we must ensure that we cannot
  * mistake a valid kernel pointer with any of the values we write into this
  * field.
  *
@@ -4399,26 +4398,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
 				  PP_DMA_INDEX_SHIFT)
 
-/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
- * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
- * the head page of compound page and bit 1 for pfmemalloc page, as well as the
- * bits used for the DMA index. page_is_pfmemalloc() is checked in
- * __page_pool_put_page() to avoid recycling the pfmemalloc page.
- */
-#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
-
-#ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(const struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
-#else
-static inline bool page_pool_page_is_pp(const struct page *page)
-{
-	return false;
-}
-#endif
-
 #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
 #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
 #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0091ad1986bf..edf5418c91dd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -934,6 +934,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1078,6 +1079,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
 FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
 
+/*
+ * Marks page_pool allocated pages.
+ */
+PAGE_TYPE_OPS(Netpp, netpp, netpp)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 651e2c62d1dd..0ec4c7561081 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -260,7 +260,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
  */
 #define pp_page_to_nmdesc(p)						\
 ({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
 	__pp_page_to_nmdesc(p);						\
 })
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fb91c566327c..c69ed3741bbc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			page_pool_page_is_pp(page) |
 			(page->flags.f & check_flags)))
 		return false;
 
@@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-	if (unlikely(page_pool_page_is_pp(page)))
-		bad_reason = "page_pool leak";
 	return bad_reason;
 }
 
@@ -1379,9 +1376,12 @@ __always_inline bool free_pages_prepare(struct page *page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping = NULL;
 	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		/* networking expects to clear its page type before releasing */
+		WARN_ON_ONCE(PageNetpp(page));
 		/* Reset the page_type (which overlays _mapcount) */
 		page->page_type = UINT_MAX;
+	}
 
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 5561fd556bc5..664a9fe87c66 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -8,18 +8,6 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
-static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
-{
-	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
-}
-
-static inline void netmem_clear_pp_magic(netmem_ref netmem)
-{
-	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
-
-	netmem_to_nmdesc(netmem)->pp_magic = 0;
-}
-
 static inline bool netmem_is_pp(netmem_ref netmem)
 {
 	/* net_iov may be part of a page pool.  For net_iov, ->pp in
@@ -30,7 +18,10 @@ static inline bool netmem_is_pp(netmem_ref netmem)
 	if (netmem_is_net_iov(netmem))
 		return !!netmem_to_nmdesc(netmem)->pp;
 
-	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+	/* For system memory, page type in struct page can be used to
+	 * determine if the pages belong to a page pool.
+	 */
+	return PageNetpp(__netmem_to_page(netmem));
 }
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2756b78754b0..c43a0f4479d4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -700,12 +700,11 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
 	netmem_set_pp(netmem, pool);
 
-	/* For page-backed, pp_magic is used to identify if it's pp.
-	 * For net_iov, it's ensured nmdesc->pp is non-NULL if it's pp
-	 * and nmdesc->pp is NULL if it's not.
+	/* For system memory, page type in struct page is used to
+	 * determine if the pages belong to a page pool.
 	 */
 	if (!netmem_is_net_iov(netmem))
-		netmem_or_pp_magic(netmem, PP_SIGNATURE);
+		__SetPageNetpp(__netmem_to_page(netmem));
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -720,12 +719,11 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	/* For page-backed, pp_magic is used to identify if it's pp.
-	 * For net_iov, it's ensured nmdesc->pp is non-NULL if it's pp
-	 * and nmdesc->pp is NULL if it's not.
+	/* For system memory, page type in struct page is used to
+	 * determine if the pages belong to a page pool.
 	 */
 	if (!netmem_is_net_iov(netmem))
-		netmem_clear_pp_magic(netmem);
+		__ClearPageNetpp(__netmem_to_page(netmem));
 
 	netmem_set_pp(netmem, NULL);
 }
-- 
2.17.1


