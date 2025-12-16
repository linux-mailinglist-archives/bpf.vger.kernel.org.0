Return-Path: <bpf+bounces-76675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EFCC0ABE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 04:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C8D8302716E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C232502BE;
	Tue, 16 Dec 2025 03:03:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E5A59;
	Tue, 16 Dec 2025 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854216; cv=none; b=D0ibi6wISNXSQS3I0ByOe1JgBvyKkbCqewYDuBtQEGi1qTzwvwddNIxQJXdq/BUqoKe/szO0XU/iqPd5bdb4UlposB5/2SQr3SzvoTt3IpoepNDBdcgB4OITE4EKhskEDfKxddXuRHw5ot1pQv/ywFyFbmazUB2ou4D0hTpbvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854216; c=relaxed/simple;
	bh=sSKeR5qbAmosX44UJSW1gJ9GYSlyPAnvpz0/jMFWhVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/Ai0ZwZmmG30cKskP1utwVyTVkLwsqaqWlNbNCNbLkWoLAvJtLlfUTVwGysZXSuz2RW+yxHG0QRGvCOEc0hkFCAMGfe4b+g6VYcXZ8qkgs/x30vTacUCPiYKo+cAEyDUL0ZLhjpzFpL28izUhq45iLyRmeabdBkNVRVS8nUzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-50-6940cc005167
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
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
Subject: [PATCH v2 1/1] mm: introduce a new page type for page pool in page type
Date: Tue, 16 Dec 2025 12:03:14 +0900
Message-Id: <20251216030314.29728-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251216030314.29728-1-byungchul@sk.com>
References: <20251216030314.29728-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe/eenXMcDU6r7NWoYBCRmF0weYIy6fp+EYxuUHYZecqhTpll
	KgQzjUzSzFzZZrEoy7y0mKlTty5q62JQWMqi2mqlXTQLXZaXWJsS9e3H8/z/v+fLw2NFhzSU
	V2sOilqNKlnJyhjZ16mXFk15EqNeYvUEQ7m5hoXqX5lw7a1VCiM1HyVQXtWAwDvyigOf3YFg
	qP0BC31tgwguXxrGUP40j4Ef5lEMTc0fEXwpq2Whx+HhoNoSC+6rvQzYjjdi8Jx6yEJh3hgG
	+8gAB0etlX5xnY6DZw1FUigdrcDQqHvLwfPmchZcNT4p9LYWMvDIcJ2B7/p2DO6iGHCYgmG4
	ox9Bu7lRAsMnL7DQdb5ZAvX2Lg7OdJpYeJ/nRtDZ5mFAP57PgjGnCMHYL79yoNgrBeN9FxcT
	QXOcTpa29X/D9Nb1lxLaXXaaoc7bjyW0yfCGoybLIVpXGUYLnJ2YWqpOsNQyWMLR1902lj4s
	G2No07sVtMk6JKGFuQNs3MwdspUJYrI6Q9Qujt4rS+z5bJakPdmU2eWoxTrkWFOAgngiRJLB
	SiPzl03HunGAWWEBcTpHJniGEEtuNLxABUjGY2GAI7Y7P9nAYroQR1quuFGAGWE+Kf59YUIk
	F5aT/h/38aR0Hqm+eXeCg4Qo8uqmfSKv8GfsulHpZH4aeXT+g7/L+w8sIOaLisAY+6u59UYc
	uEuEfp7YPt1Ck84Qcq/SyRQjwfBf3fCvbvivbkK4CinUmowUlTo5MiIxS6POjNiXmmJB/he7
	emR8pxUNPtvcigQeKafKqW+1WiFVZaRnpbQiwmPlDHm+M1qtkCeosrJFbeoe7aFkMb0VzeYZ
	5Sz5suHDCQrhgOqgmCSKaaL271bCB4Xq0K4j+qyj8Vv1cXuGStd6Nj5uCd4Zvty73Xss+02q
	XlrzZVOHvq9eYwzbvcG2zRpWscNo25Ib7nsd+Xl3eNeStJw5Okt878LClpy0c9XXlDQqit3/
	KSTbdfZDrrfCK3dRx5bxuovr3EmZsYrYpLme/PgeWZWmNnSVLypirms9KQlRMumJqqVhWJuu
	+gM2/5eLXgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfe/7e+q47ec0/YaxnVljc7E5+xgSZr6zeX4a/nC/8aPf1LG7
	tDIPlzJEyUOTq+wMoafL9XSXTtbVEXmK2lm4lDQkRlIdy11m/Pfa5/N6vz//fDisLqLHcbIh
	TjIaxBgNo6SUK+YmTx/RGCXPMJfSkGMrZKCgPwGutTloGCjsUkBOfgWC3oFWFoZcHgTf6u4y
	8NH9FcHlS30Ych6nUPDdNojBWdWF4ENWEQOdnnYWCuzLwZf3joLqo5UY2k/dYyAtxY/BNdDD
	wmHH9UBxqZkFd24DDU8q0mk4N3gVQ6W5jYVnVTkMvC4couFdbRoFDZYbFHzJrMPgS48Cj3Us
	9D3oRlBnq1RA38lcBpovVCmg3NXMwtkmKwMdKT4ETe52CjJ/HmMgOykdgb8/UNmT0UtDdv1r
	NiqCJHm9DHF3f8ak7MYLBWnJOk0R7+37CuK0vGKJ1b6XlF6fRlK9TZjY848zxP71DEtetlQz
	5F6WnyLON3OI0/FNQdKSe5hVYzcr522XYuR4yRgRqVdGd763KfY0rk5o9hRhM/IsSkUhnMDP
	EqxHWnCQGT5c8HoHhjmUXy4UVzxHqUjJYb6HFaprfjDBxRh+lXDrig8FmeKnCBm/cqkgq3id
	0P29Hv8pnSQUlNwZ5hB+ttBa4hr21QHHZR6k//ijhYYLbwNZLnAgXLBdVAfHOBBNLs/GGUhl
	+c+y/LMs/1lWhPNRqGyIjxXlGJ3WtCs60SAnaLftjrWjwBPlHfh52oF6ny2tRTyHNKNUZGiB
	rKbFeFNibC0SOKwJVR3zRspq1XYxcZ9k3L3VuDdGMtWi8RylCVMt2yjp1fxOMU7aJUl7JOPf
	rYILGWdGzpP19cZOcYJszoAN/ohef/Ejuz7uebde725dgD6Rm+L6g84DQ5+lyM2TGg3hbdo1
	WVPD1jgsuhPLOtaNfKqbPxmSboYeGTNrx6biflSkdSz0ddSUbN3yfuVad8iOxfqr53fur1nf
	cTG9TNl1QjdRDmMOTXiY6R6flvdpiTZa3aKhTNHizGnYaBJ/AwrqE/1AAwAA
X-CFilter-Loop: Reflected

Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
determine if a page belongs to a page pool.  However, with the planned
removal of @pp_magic, we should instead leverage the page_type in struct
page, such as PGTY_netpp, for this purpose.

Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
and __ClearPageNetpp() instead, and remove the existing APIs accessing
@pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
netmem_clear_pp_magic().

Plus, add @page_type to struct net_iov at the same offset as struct page
so as to use the page_type APIs for struct net_iov as well.  While at it,
reorder @type and @owner in struct net_iov to avoid a hole and
increasing the struct size.

This work was inspired by the following link:

  https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/

While at it, move the sanity check for page pool to on the free path.

Suggested-by: David Hildenbrand <david@redhat.com>
Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/page-flags.h                    |  6 +++++
 include/net/netmem.h                          | 15 +++++++++--
 mm/page_alloc.c                               | 11 +++++---
 net/core/netmem_priv.h                        | 20 +++++---------
 net/core/page_pool.c                          | 18 +++++++++++--
 7 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 80f9fc10877ad..7d90d2485c787 100644
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
index 15076261d0c2e..94f824bf0d38c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4565,10 +4565,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
@@ -4603,26 +4602,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
index f7a0e4af0c734..39a21ee87b437 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -934,6 +934,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1066,6 +1067,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
 PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
 
+/*
+ * Marks page_pool allocated pages.
+ */
+PAGE_TYPE_OPS(Netpp, netpp, netpp)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 9e10f4ac50c3d..2a73b68f16b15 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -110,10 +110,21 @@ struct net_iov {
 			atomic_long_t pp_ref_count;
 		};
 	};
-	struct net_iov_area *owner;
+
+	unsigned int page_type;
 	enum net_iov_type type;
+	struct net_iov_area *owner;
 };
 
+/* Make sure 'the offset of page_type in struct page == the offset of
+ * type in struct net_iov'.
+ */
+#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
+	static_assert(offsetof(struct page, pg) ==	\
+		      offsetof(struct net_iov, iov))
+NET_IOV_ASSERT_OFFSET(page_type, page_type);
+#undef NET_IOV_ASSERT_OFFSET
+
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
@@ -256,7 +267,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
  */
 #define pp_page_to_nmdesc(p)						\
 ({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
 	__pp_page_to_nmdesc(p);						\
 })
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5bb3a7844abb6..c126a9790953b 100644
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
 
@@ -1379,9 +1376,15 @@ __always_inline bool free_pages_prepare(struct page *page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping = NULL;
 	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		/* networking expects to clear its page type before releasing */
+		if (unlikely(PageNetpp(page))) {
+			bad_page(page, "page_pool leak");
+			return false;
+		}
 		/* Reset the page_type (which overlays _mapcount) */
 		page->page_type = UINT_MAX;
+	}
 
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 23175cb2bd866..6b7d90b8ebb9b 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -8,21 +8,15 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
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
-	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	return PageNetpp(__netmem_to_page((__force unsigned long)netmem & ~NET_IOV));
 }
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 265a729431bb7..323314b1333ee 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -703,7 +703,14 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
 	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
+
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	__SetPageNetpp(__netmem_to_page((__force unsigned long)netmem & ~NET_IOV));
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -718,7 +725,14 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	netmem_clear_pp_magic(netmem);
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	__ClearPageNetpp(__netmem_to_page((__force unsigned long)netmem & ~NET_IOV));
+
 	netmem_set_pp(netmem, NULL);
 }
 
-- 
2.17.1


