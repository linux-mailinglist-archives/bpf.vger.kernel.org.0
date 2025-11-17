Return-Path: <bpf+bounces-74694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8DC62646
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 06:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C030D3ADB47
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 05:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEED30E0FD;
	Mon, 17 Nov 2025 05:21:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB562459ED;
	Mon, 17 Nov 2025 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356862; cv=none; b=mMqKp7+BkvievleMdFBP0j416/TFswYakWfIYzm4VKOMXVeiKPH1Lsp0vwvLnaf9OzaKd+F3gZfTY0X3WbyNminELyajQH1uDvFmWvDgPc8nVHQgw+fM4nE+rCRMVN8N0tl6mj3XNjrXZ5P7eonT+LJZA50fmmbYLjFZncuaBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356862; c=relaxed/simple;
	bh=DOg89P6LI8gUjefFXu+8/WUEvZq9EhbRMvckxVO136Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bst0eIS5Z3kRRmzC8YVH4chxccghc2oySz6DKPCohxEd4+DcVpoCoz1vfdqK3feCV/fcZRMxT3KlB41xd0ZAc7Y6bYHMNwtst+/sAp35bQjBVWWyWK8E//IY904FuGIeZK7ke62dvhod6B+igEcQ/Ht76lYMGSRzqsb9t4hL/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-ac-691ab0b5f189
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
Subject: [RFC mm v6] mm: introduce a new page type for page pool in page type
Date: Mon, 17 Nov 2025 14:20:41 +0900
Message-Id: <20251117052041.52143-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+5//uTlandbtaEgxCqHILhS8QkhBl383KvpQJJQrT+2Qmmxp
	KgladltpVho2l6windMyp0tnajbN7iR2YZWlqdnNVi2TpoPalKhvP57nfZ7ny8tjVQUTwsvx
	eyVdvCZWzSpoxZfRF2bbr4XIc6tMU8BUXsZC6a9kKO6sYcBb9p4Ck/U6gn7vKw5+17cg+NF8
	h4XPTR4Ely4MYDA9zqThZ/kgBkftewSf8q+w8K6li4NS21roKOqloe5INYauk3dZyMocwlDv
	dXNwoMbiL65M56D1ejYDuYOXMVSnd3LwpNbEwpuy3wz0OrNouGcsoeFbXjOGjuzF0GKeBAMP
	+hA0l1dTMHDiPAvPztVSYK9/xsGZNjML3ZkdCNqaumjI8x1loSAjG8HQL3+lO6efgYLbb7jF
	4STD5WJJU99XTKpKXlDkef4pmrga7lPEYXzNEbMtkVRaZhKDqw0Tm/UYS2ye0xxpf17Hkrv5
	QzRxvI0gjpofFMk66GbXT9yiWBQjxcpJkm5OZLRCezHDwCQc3prscQelo5trDIjnRWGBWGiJ
	NqCgYWzsyWcDzAphosvlxQGeIMwVLXn9flbwWDjOi68aKoaN8cJa0Xm7gQkwLcwQW3+WoAAr
	hYViq+8hGimdKpZea8Qj+jjx3rkeOrCL/QPlhaqAjP0nB+0Fw/2i8JQX29tzmJFssHjL4qJz
	0Bjjf3Hjv7jxv7gZYStSyfFJcRo5dkG4NiVeTg7fsSfOhvyPVJTmi6pBntaNTiTwSD1a2ekK
	llWMJkmfEudEIo/VE5RH1oiyShmjSUmVdHu26RJjJb0TTeFp9WTl/IF9MSphl2avtFuSEiTd
	X5fig0LS0dmL2oxDZzdT5rBF1sqn3aFgr7qysi6smNhPf+lZsT3Hsc6+3aqiNuWaXuqPa9P6
	+Mjcz1GTI5b18aseLU/1fTB3t+2PWB2Frn4fmzjY6PvoTAkNX5fqCd49bdQM1h0tTl+amlY2
	bsl4b8WGUb2RctH0qZGhN4oLd64yJMwaM+1tqJrWazXzZmKdXvMHhfad80QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUiTYRiGefd+fy6Hn2vYx4KEURRRalDx9IN0Er1Elp4YCpWrPnQ4rbYS
	jYKZZma5tJTmnGaZ5l/NVupmajHNsoLEKFZalv1BySxdy6lYWxF5dnE/F9fRw2F5Ca3kNOmH
	RV26WqtipJR0+4aclS3NSk1UtZsCi7WJgcbJTLj21k6Dr+mzBCwNrQg8vkEWfnX2IpjoecDA
	1+5xBNWXvRgsT3Mp+GGdwuBo/4zgi+k6Ax97R1hotMXAcO0nCjpOtWEYOfeQgcLcaQydPjcL
	J+x1/vAtAwvdFX009LcaaSiZqsHQZnjLwrN2CwNvmn7R8MlZSEGfuZ6Cb6U9GIaNm6C3Kgy8
	j0cR9FjbJOA9W8HA87J2CbR0PmfhwkAVA+9zhxEMdI9QUDqTz0B5thHB9KQ/6S7y0FB+/w27
	KZJku1wM6R4dw+R2/UsJeWEqpoir65GEOMyvWVJlO0Ju1S0nBa4BTGwNpxliGz/PkqEXHQx5
	aJqmiOPdOuKwT0hIYY6biQ1LlG7cL2o1GaIuMjpJmnIlu4A+mLc7c9wdZEB3txWgIE7gVwv3
	PpiYADP8UsHl8uEAK/gooa7U42cph/kznDDYdfPPYT4fIzjvd9EBpvglQv+PehRgGb9G6J95
	gv5Gw4XG5nv47x4q9JV9oAoQ5w8tFayV8sCM/UpOSzkuQvPMcyzzf8s8x6pCuAEpNOkZaWqN
	dk2EPjUlK12TGbHvQJoN+X+l9vhMsR15nm1xIp5DqmDZMkGpkdPqDH1WmhMJHFYpZKe2CRq5
	bL8666ioO7BHd0Qr6p1oIUepFsi27hST5Hyy+rCYKooHRd2/q4QLUhpQcvReZ3LKunfBCkdj
	gvH70Fj7iqtZXxKrv/dO+CTkZH6I0uLTeu324Tt87Aa+jYTWdhoPXZpKehVxo6LycXzRMmp3
	eE1igsern9pceTJh0VDe2sXWnjxqfu2OO82z1SGKXcrRjp/xs8nyPMPTwWNhoXGO+q0Xzev3
	qLWJrXGmSBWlT1GvWo51evVvOoypUScDAAA=
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
---
I dropped all the Reviewed-by and Acked-by given for network changes
since I changed how to implement the part on the request from Jakub.
Can I keep your tags?  Jakub, are you okay with this change?

  Reviewed-by: Mina Almasry <almasrymina@google.com>
  Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
  Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

This set is supposed to go via the mm tree, but it currently also
depends on patches in the net-next tree.  For now, this set is based
on linux-next, but will apply cleanly (or get rebased) after mm tree was
rebased.

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
 mm/page_alloc.c                               |  8 +++---
 net/core/netmem_priv.h                        | 20 +++++---------
 net/core/page_pool.c                          | 18 +++++++++++--
 7 files changed, 50 insertions(+), 46 deletions(-)

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
index 600d9e981c23..01dd14123065 100644
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
 
@@ -1378,9 +1375,12 @@ __always_inline bool free_pages_prepare(struct page *page,
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


