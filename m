Return-Path: <bpf+bounces-64479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90DB13428
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0E176B89
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 05:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFE221CA03;
	Mon, 28 Jul 2025 05:28:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DE290F;
	Mon, 28 Jul 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680481; cv=none; b=uwiuIaF7sSyz/w2z0wJk/2xpDtDPoBpHmEk9VX+MDzdDg7Mre2bMLcvjBh1lv/Hyf/oz2IItO4m01TNGkdsSH2Z8YrcSwxfKtqzNO/0KYNVOn4+/YgbWPG0oMLH3frrLTuJNiQ5rSCnrE580QOJJTMbIvrULI7gyZW6RH3rfD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680481; c=relaxed/simple;
	bh=k4OI71Vt6kCoaUnk9tDHRtH6pgHOkYOleNrbTXBqc70=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cltIx3aWRDnFx+9BAcQQA3tFffkQakyKrGfQO5Pp9LYstzd6lElSLzNO02pWReWr6Uw/Kpo7X9b+JbFaKMwoNbJ3rxmYhxd8WRq6TnevMEfrk9ZDdklsxldB7CAQTpkl/+m6NJCiMEAnID4r5G0NGjdue+pSvjmkNUjppU/n8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-55-68870a5843d3
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
	linux-rdma@vger.kernel.org
Subject: [PATCH v2] mm, page_pool: introduce a new page type for page pool in page type
Date: Mon, 28 Jul 2025 14:27:42 +0900
Message-Id: <20250728052742.81294-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRgG8P7nnJ1ztlycZtTRiGhQkpVlFL1RmH07REaU0E2o1Q5tOC/M
	S85Ipo40aybWwnTCyrS5KeocTkXF5r2izFrMLlqWZuVdW97AvNC3H+/D83x5aVzSTfjSyshY
	Xh0pU0lJESEa9nq865woTbHnVwUFxrISEqzTCfD0S7UAjJYqBFMzHylYqG9FMNncRsLvpgkE
	BY88OBhf6wj4UzaLQ39rHwVWWwj0Fg0QUJfmwKHvbjsJet0cDvUzIxSkVJsxMFZqKeisyhTA
	/dlCHBzaLxS8rTWS0FOyIIABp56AjtxiAsYMzTj0ZgZDq2k9eF4MIWguc2DguZNPguthLQb3
	ukwkfNP1Iuhq6iPAMJ9OQl5yJoK56cW1kawpAeS19FDB/lzT0CjO2Yu7Mc7d8BzjanI/U5zJ
	FsdVmv25DHcXztkst0jONpFNcZ/e15Fce84cwdV8PcjVVE9inD51hOTG+z8Q3GiDizzpfV50
	WM6rlPG8enfQJZGiqm8Bi/54PME+ZMa0yBWUgYQ0y+xja7Q91H/njA0um2T8WLd7Bl/yOmYP
	azZMLVpE44ydYkvK3MuBN3OG/duWTCyZYLayw6a6ZYuZ/eyo6wGxMrqZtZY3LpdZRk+z32+b
	BSuBD/vM7Cay0GoTWmVBEmVkfIRMqdoXoNBEKhMCrkRF2NDiw4tuzF+oRhOdp52IoZHUSzx4
	4KZCIpDFx2ginIilcek6cXTh4kksl2kSeXXURXWcio9xoo00Id0g3uu5JpcwV2WxfDjPR/Pq
	/ylGC321KPCOH2YXpuRvCZ9gDUlHW7ydrsSz2dMf1v4IGy9FBWuq5NslVo0tthBzCru2nSrt
	Ee0Ievl8+6ssn8EnwjeXr2sdUcPz2sYKP3rTu7CQkK/lhr3+qecm36m0J5LS9Z6dx0D3Im49
	Xxd6KDxh1Pdn8EBxrz3UkmwvMR/piLJOTkuJGIUs0B9Xx8j+AepeyKfsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRWUgUcRwHcP8zszPj5sKsLTnZIWyHYXhB6k9axB6sSdN6KUOI3HJqF892
	1dQQNDctSbPDMF1hIzSvsFbxVsrbyhJlY/PWchE0Na/1ClOjtw/fL3xfvjRuXU/Y0sqIaF4V
	IQ+TkkJCGHAyxfGyME3hsl7iDNryMhJKV+Lg9WiNALQlVQgWVwco2GxsR7DQ2kHCVMs8glcv
	l3HQftUQsFS+hsNE+zgFpXp/GCk0EdCQVo3D+KNOEjI06zg0rs5QcLemCANtRRIFLfldAuip
	yhTAs7UCHKqTRinoq9OSMFy2KQBTcwYBXbnFBMxlt+IwkukN7bo9sPxpGkFreTUGyw/zSTC8
	qMPgaa+OhB+aEQS9LeMEZG/cJyEvORPB+srW2kzWogDy2oYp7+Ncy/QszlUWf8c4Y9NHjKvN
	HaI4nT6Gqyhy4NKNvTinL3lAcvr5JxQ3+K2B5Dpz1gmudsyTq61ZwLiMlBmS+z3RT3CzTQby
	giRIKAvhw5SxvMrZK1ioqBrfxKIGzsVVThdhScjglY4saZY5webMTVLbJhl71mhcxbctYVzY
	ouzFLQtpnKmk2LJy406xmwlkzR3JxLYJ5gj7S9ewYxHjxs4anhP/Ru3Y0rfv8SxE65BFCZIo
	I2LD5cowNyd1qCI+QhnndD0yXI+2Li1M3Hhcgxb7zjQjhkZSK9GkR6rCWiCPVceHNyOWxqUS
	UVTBViQKkccn8KrIq6qYMF7djPbRhNRG5BvIB1szN+XRfCjPR/Gq/y1GW9omoY7DrpOnZQnD
	PZnv/Ja/7FoQOx8zid+M+VX3+3y2FF8yWlwD8xWxna/qdm++/5RNkClZZzb72Zt8NFbhsfXm
	wA+Ko2e7rYb+zMZ5mPbv/SmWHZIc4KfdD3oupQbdC5C1dRfknb84mJLYdedWR2KwTFTQ6OjT
	IHPPok4pDJobhK2UUCvkrg64Si3/C0/gid/OAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Changes from v1:
	1. Rebase on linux-next.
	2. Initialize net_iov->pp = NULL when allocating net_iov in
	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
	3. Use ->pp for net_iov to identify if it's pp rather than
	   always consider net_iov as pp.
	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.

---8<---
From 08b65324282bbe683a2479faef8eb24df249fd18 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Mon, 28 Jul 2025 14:07:17 +0900
Subject: [PATCH v2] mm, page_pool: introduce a new page type for page pool in page type

->pp_magic field in struct page is current used to identify if a page
belongs to a page pool.  However, ->pp_magic will be removed and page
type bit in struct page e.i. PGTY_netpp can be used for that purpose.

Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
and __ClearPageNetpp() instead, and remove the existing APIs accessing
->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
netmem_clear_pp_magic().

For net_iov, use ->pp to identify if it's pp, with making sure that ->pp
is NULL for non-pp net_iov.

This work was inspired by the following link:

[1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/

While at it, move the sanity check for page pool to on free.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/page-flags.h                    |  6 +++++
 io_uring/zcrx.c                               |  1 +
 mm/page_alloc.c                               |  7 +++--
 net/core/devmem.c                             |  1 +
 net/core/netmem_priv.h                        | 23 +++++++---------
 net/core/page_pool.c                          | 10 +++++--
 8 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5ce1b463b7a8..79a3ceff3952 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check page_pool_page_is_pp() as we
+				/* No need to check PageNetpp() as we
 				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3bfb566ad202..d01b296e7184 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4171,10 +4171,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
@@ -4205,26 +4204,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
-#else
-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return false;
-}
-#endif
-
 #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
 #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
 #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8e4d6eda8a8d..548a68415845 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -935,6 +935,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1079,6 +1080,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
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
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 100b75ab1e64..34634552cf74 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
 		niov->type = NET_IOV_IOURING;
+		niov->pp = NULL;
 	}
 
 	area->free_count = nr_iovs;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa09154a799c..cb90d6a3fd9d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-	if (unlikely(page_pool_page_is_pp(page)))
-		bad_reason = "page_pool leak";
 	return bad_reason;
 }
 
@@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping = NULL;
 	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		WARN_ON_ONCE(PageNetpp(page));
 		/* Reset the page_type (which overlays _mapcount) */
 		page->page_type = UINT_MAX;
+	}
 
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b3a62ca0df65..40e7a4ec9009 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -285,6 +285,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov = &owner->area.niovs[i];
 			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
+			niov->pp = NULL;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..4b90332d6c64 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -8,21 +8,18 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
-static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
-{
-	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
-}
-
-static inline void netmem_clear_pp_magic(netmem_ref netmem)
-{
-	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
-
-	__netmem_clear_lsb(netmem)->pp_magic = 0;
-}
-
 static inline bool netmem_is_pp(netmem_ref netmem)
 {
-	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+	/* Use ->pp for net_iov to identify if it's pp, which requires
+	 * that non-pp net_iov should have ->pp NULL'd.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return !!__netmem_clear_lsb(netmem)->pp;
+
+	/* For system memory, page type bit in struct page can be used
+	 * to identify if it's pp.
+	 */
+	return PageNetpp(__netmem_to_page(netmem));
 }
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 05e2e22a8f7c..0a10f3026faa 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -654,7 +654,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
 	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -665,12 +664,19 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 	page_pool_fragment_netmem(netmem, 1);
 	if (pool->has_init_callback)
 		pool->slow.init_callback(netmem, pool->slow.init_arg);
+
+	if (netmem_is_net_iov(netmem))
+		return;
+	__SetPageNetpp(__netmem_to_page(netmem));
 }
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	netmem_clear_pp_magic(netmem);
 	netmem_set_pp(netmem, NULL);
+
+	if (netmem_is_net_iov(netmem))
+		return;
+	__ClearPageNetpp(__netmem_to_page(netmem));
 }
 
 static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,

base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
-- 
2.17.1


