Return-Path: <bpf+bounces-75023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33562C6C402
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 02:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 746BB4EA45D
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568223A9BD;
	Wed, 19 Nov 2025 01:27:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB71B6D08;
	Wed, 19 Nov 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515657; cv=none; b=FvzXRWDoAAdnZzoTtPYsAuKTSFb9/I01CDtwvSkmrkQta3henQNOk9K1QGlv8BpiPR56z/XDkdRtq2wUSROVluwkbdujmrZ/oIGlFvoIA/5j1ApnZFKxTAnZWkU3Y5MCYcvtcEAwStR2TO3FWEkbSq5lZ+z4i3igqVDPUH52OP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515657; c=relaxed/simple;
	bh=aqJxbP789GiJ0GxmlXaS8IOLYOOA3M6pcL4wmW3BkkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lSXnXPg5sH53+uh5RvmZjogcmgEmCGoW0vEeVVT9YeIb2SL5V7Ceb6wuJeo+MSx+4Xxob2iEJ2lKHYbKrHvb8KKJVW+pAZjcUw2bs2BOPv/A3Kz2jcnZNM4gmFqJ6AgM8sTHYlc08iR7YVQ8bxy+SDH1EhKjGyZbI6F9AUIhT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-55-691d1cf9e515
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
Subject: [RFC mm v7] mm: introduce a new page type for page pool in page type
Date: Wed, 19 Nov 2025 10:27:09 +0900
Message-Id: <20251119012709.35895-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97ds5xOjtNrZOXioEUQnbB7Amiy7f3ixgVdIVaecqRWszL
	VCy0BqbmpYtkc5VR3o3lusyJk3Jei6i8sai0lrooMzEdzQ1sWlHf/vwvvw8PD4flRkkwp0pK
	EdVJygQFI6Wl3/xur3GHhqnWnetZDXpDAwP1P9Oh+kOTBFwNDgr0dY8RTLvesjBn6UTwo72L
	ga/WKQR3bjsx6F9qaZgxzGIwNzsQfCm7x8Bop52FemMMDFeN0dCSa8JgL+5moFDrxmBxTbBw
	rqnGC36QzcKrx0USuDpbicGU/YGFvmY9A0MNcxIYayukoUdXS8NkaTuG4aLt0FmxBJzPxxG0
	G0wUOC/eYGDgejMFjywDLFzprWDgk3YYQa/VTkOp5wID5TlFCNw/vciJkmkJlHcMsdsjSY7N
	xhDr+HdMHta+ochg2SWa2FqfUcSse8+SCmMqeVATQfJtvZgY6/IYYpy6zJJ3gy0M6S5z08T8
	cTMxN/2gSOH5CWZn0AHpljgxQZUmqtduPSKNz9O6qdODynRHbrUkG1XG5iMfTuCjhGzPAPVX
	9zW6mHnN8KsEm82F53Ugv06oKZ32aimH+QJOeNvauBAE8DGCvcXE5iOOo/lw4cXoAlPGbxQm
	RsfY38wVQv39J/i3v1jouT5Cz9exl2+4KZ+3sbdy/lH5Al7g+zmh2tP/Z7tMeFpjo0uQv+6/
	ue7fXPffvALhOiRXJaUlKlUJUZHxGUmq9MhjpxKNyPtJVWc8B5vQ1KvdbYjnkMJPdmFRmEou
	UaYlZyS2IYHDikBZ+I5QlVwWp8zIFNWnDqtTE8TkNhTC0Yqlsg1OTZycP6FMEU+K4mlR/Tel
	OJ9g7yWzrvllah0X7Xv3H7UkdocWV8ESx2taE1Oiv/v8hfmsdSakuCo3Nm+TpjCvejLAOmgJ
	D/TpSOszTH72XeMp2JbFb44+5P9k9/CefQUkyG/EN3eXb+jyW8Erjd9Wh3XMvtOEtOqXabqc
	2zSGrjD3QMqcaevxsYiY6H6Lva42crpSQSfHK9dHYHWy8hdOCNbeRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRyG+853zndOy9HJxE6WFSMVotQw8RddMII6FGURYRSRQw9upFO2
	FBUCTbGyNDUFm1sY4l1ZzryiUmpTCyuUbNFlZalQpqXLNpVsFlH/vbzvw/PXy2H3AsaLU2su
	SFqNMkZBZLTs6K70bc713urA9h4CBlMtgRpHElS8a2HAWTtOgaG6CYHd+YqFxQ4LgpmeXgKf
	u6cRlN6ZxWB4mkHDd9Mchta2cQSfiuoIjFpGWKgxHwFb+RgN7ZebMYzc6COQnTGPocM5ycKl
	lkqXuCGVhW5jPwPPmnIYKJgrw9Cc+o6FoTYDgbe1iwyMdWXT0K+vouFrYQ8GW04oWEo8Yfbx
	BIIeUzMFs9eNBJ7faqOgseM5CzcHSwh8yLAhGOweoaFw4QqB4rQcBPMOl3Iy185A8cO3bGiA
	mGa1ErF7YgqL96peUuJwUR4tWjsfUWKr/g0rlpgTxIbKLWKWdRCL5uqrRDRP57Pi6+F2IvYV
	zdNi6/udYmvLDCVmp0+SY56nZbujpBh1oqQN2BshU13NmKfih5VJ45crmFRUFpaFlnMCv0MY
	qneSpUx4P8FqdeKl7MEHCpWFdleWcZi/xgmvOut/D6v5I8JIezObhTiO5n2EgdHfHjkfLEyO
	jrF/nBuFmrv38Z9+ldB/6yO9hGOX33TbfanGLiS9sRjnohX6/yj9P0r/H1WCcDXyUGsSY5Xq
	mGB/3XlVskad5B8ZF2tGrq+UX1zIa0H2oYNdiOeQwk3uyF2vdmeUibrk2C4kcFjhIffZ56rk
	UcrkFEkbd06bECPputA6jlaskR8KlyLc+WjlBem8JMVL2r8rxS33SkUhfKDvzBPiO/7lW2aQ
	5mJIgTF5ShhYeYacve0XGm2LKp3TBiXUZXpGb/XzRo2GB2PLjJXZkVTxj7g9GjkTPjdw0rbB
	2/F1T3zEKc+QsJ/POjc7UvYf/3huh0BU/h2H1246YBq2W4xuQbWlE0nhUX32PFWR74mGFwW9
	TL7blXyLgtaplNu3YK1O+QuLJBpRJwMAAA==
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

While at it, move the sanity check for page pool to on the page free
path.

Suggested-by: David Hildenbrand <david@redhat.com>
Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
I'm keeping all the Reviewed-by and Acked-by given for mm changes even
though I changed a lil bit since it obviously improves the code better.

However, I dropped all the Reviewed-by and Acked-by given for network
changes since I changed how to implement the part on the request from
Jakub.  Can I keep your tags?  Jakub, are you okay with this change?

  Reviewed-by: Mina Almasry <almasrymina@google.com>
  Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

This set is supposed to go via the mm tree, but it currently also
depends on patches in the net-next tree.  For now, this set is based
on linux-next, but will apply cleanly (or get rebased) after mm tree was
rebased.

Changes from v6:
	1. Do bad_page() and prevent the page from being returned to the
	   page allocator instead of just WARN_ON_ONCE() on detection of
	   page pool leak in the page free path. (feedbacked by Jesper
	   and David)

Changes from v5:
	1. Add @page_type to struct net_iov so as to use the page_type
	   APIs even for struct net_iov. (feedbacked by Jakub)

Changes from v4:
	1. Rebase on the latest version of linux-next as of Nov 3.
	2. Improve commit messages. (feedbacked by Jakub and Mina)
	3. Add Acked-by and Reviewed-by.  Thanks to Mina.

Changes from v3:
	1. Rebase on next-20251023 of linux-next.
	2. Split into two, mm changes and network changes.
	3. Improve the comments (feedbacked by Jakub)

Changes from v2:
	1. Rebase on linux-next as of Jul 29.
	2. Skip 'niov->pp = NULL' when it's allocated using __GFP_ZERO.
	3. Change trivial coding style. (feedbacked by Mina)
	4. Add Co-developed-by, Acked-by, and Reviewed-by properly.
	   Thanks to all.

Changes from v1:
	1. Rebase on linux-next.
	2. Initialize net_iov->pp = NULL when allocating net_iov in
	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
	3. Use ->pp for net_iov to identify if it's pp rather than
	   always consider net_iov as pp.
	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
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
index a3f97c551ad8..081e365caa1a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4252,10 +4252,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
@@ -4290,26 +4289,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
index 651e2c62d1dd..ab107b05341e 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -114,10 +114,21 @@ struct net_iov {
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
@@ -260,7 +271,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
  */
 #define pp_page_to_nmdesc(p)						\
 ({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
 	__pp_page_to_nmdesc(p);						\
 })
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..5ae55a5d7b5d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1041,7 +1041,6 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			page_pool_page_is_pp(page) |
 			(page->flags.f & check_flags)))
 		return false;
 
@@ -1068,8 +1067,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-	if (unlikely(page_pool_page_is_pp(page)))
-		bad_reason = "page_pool leak";
 	return bad_reason;
 }
 
@@ -1378,9 +1375,15 @@ __always_inline bool free_pages_prepare(struct page *page,
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
index 23175cb2bd86..6b7d90b8ebb9 100644
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
index 1a5edec485f1..27650ca789d1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -699,7 +699,14 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
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
@@ -714,7 +721,14 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
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
 

base-commit: e1f5bb196f0b0eee197e06d361f8ac5f091c2963
-- 
2.17.1


