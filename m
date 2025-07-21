Return-Path: <bpf+bounces-63880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9EB0BC21
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 07:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE08179986
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 05:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0324214A94;
	Mon, 21 Jul 2025 05:49:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825D2F41;
	Mon, 21 Jul 2025 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076964; cv=none; b=SJc7VCctUHPjyw20VdPx9+aeDb+70zwjwqtjB+DnWZi3iG0VB+UcDsiX2SuWtQDek9qAwYo4VxGWTsobPRJeoXmPISEuNNldB5mxVQz+dYjR9ttO3eEuP3Igmq1viTZdD8Otc52g2oe5hizIHNHIjY+GtYr+3NnGlhBw/+4Sur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076964; c=relaxed/simple;
	bh=TARJJoAbi4u0J3Yl4vtNCmMWIScg1FJNbwOZRSclaO8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fLt7oZngF/gP7LG2Jmrq1srYr3mPGz/qtDUTskppMNwJZimDlEfn3zoWWLxNsJMmfCnM3UeJIaITR2s2HTmPKx6rDXUrapQy1Xx3/HY8x9GtGiQ+tbnfGOmlL+d6YnrAuP5xBs45GRPyBGnINJkUQqshpzv41+356JDNVwOL1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e4-687dd4da70c6
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
Subject: [PATCH] mm, page_pool: introduce a new page type for page pool in page type
Date: Mon, 21 Jul 2025 14:49:03 +0900
Message-Id: <20250721054903.39833-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRjHcf/n/HfOabU4LamTBdLKAqErSU8UZe/+b4JAI6oXNfLYRjpt
	XtJqsdIsrZlpUrlFmrjmBY15m8tu21KzQNGs46W8hAZqWmrDW5havfvAl+f35uFopYT9OK0u
	VtTr1BEqRo7l35flben4YNBsvzq9AixlJQwUTybAkx6HDCxFVQgmpjpZmHteh2DcU8/AkHsM
	QX6elwZLUzKGX2XTNPTX9bFQbD8E3dYBDLXXq2nou93AgCl5hobnUyMsXHXYKLCUG1lorkqX
	wd3pAhqqjT0stDotDHwpmZPBgMuE4W1OIYYf2R4autODoS53FXjfDSPwlFVT4L31kIG2B04K
	slpyGfia3I2gxd2HIXv2BgPmK+kIZibn10YyJmRgfvOFDQ4k7uFRmlQUtlNEetFIkZqczyzJ
	tceRclsgSZNaaGIvSmWIfSyTJV0faxnScH8Gk5rePaTGMU4RU9IIQ372d2Ay+qKNObzyuHxf
	mBihjRf12/afkmvmOsXo7wcTBrMrkRFNBKWhJZzA7xLKnd9k/235UUovmOE3C5I0tWhffrtg
	y56Yt5yj+QpWKCmTFsNKPlR4mOKmFoz5AOH1g2G0YAUfJKTeafw36i8UP321eCzwJk5oqnVS
	f8Ma4bVNwhloaS7yKUJKrS4+Uq2N2LVVk6jTJmw9HRVpR/P/thpmTzjQWHOIC/EcUi1TRGOD
	RilTx8ckRrqQwNEqXwWpv6BRKsLUiRdEfdRJfVyEGONCazmsWq3Y6T0fpuTPqGPFs6IYLer/
	V4pb4mdEl8TVheblB6Sk3Y7e/E3h9RUUyXhJ1p3uuqd75OJ8FOea5I/9Pe8rrYf9jx1x9kYS
	Q8rUp2EvVx93NDPg4u+T2Np0aCNuKSj1PM2r6rh90NwqxDKPDRu87tGcarN/0N4ELiokNLXk
	2dD7nqz1F4+1X6YHjY/anTcnr20K351mUuEYjXpHIK2PUf8BcCp0b+sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRzGcf87Z+ccV4ODWR40UEYRWKlRo19aoRD0L1ILgigQXXpsQ6e2
	qakgaGpe0OVtlTrBCM0bWdN0ilpt5rWLaMrUvGQoVKam07yRqdG7D3zhefMwhE0Tac8owiJ5
	VZgsVEKJSJGPR9LRoU/xcrcRw0nQ1VRTULUSA08nDELQVdYjsKyO0LDZ0o5gsa2Dgh+mBQRP
	Hi8ToPuYTMJSzRoBU+2TNFTpvWG8bJqE5tQGAibvd1KQlbxOQMvqLA13DeUC0NUm0GAq7hJC
	b71GCPlrpQQ0JEzQ0N+ko2CselMI08YsEroKK0iY17YRMK7xhPaSfbDcM4OgraZBAMuZxRQM
	FDQJIK+vhIKvyeMI+kyTJGg30igoStQgWF/ZWpvNtgih6O0Y7XkYm2bmCFxXMSTA5tZuAW4s
	HKVxiT4K15Y74wxzH4H1lekU1i/k0vjzYDOFOx+tk7jxyyncaFgU4KykWQr/mhom8VzrAHXZ
	9obodBAfqojmVa5nA0TyzRE+4qdXzHftS5SALNIMZM1w7AlON/+M2DbFHuLM5tUd27JuXLnW
	smURQ7B1NFddY94Je9irXPE9k2DbJHuQe1Mwg7YtZqVcek638N+oI1f1/DWRjZgSZFWJbBVh
	0UqZIlTqog6Rx4YpYlwCw5V6tPVoWfxGjgFZ+s8bEcsgyW5xBBkvtxHKotWxSiPiGEJiK8Yd
	cXIbcZAsNo5XhfurokJ5tRE5MKTETnzxGh9gw96SRfIhPB/Bq/5XAWNtn4CsfCtEuwIf2rGj
	G5lT7s3lifWXrtj7PghRHe9cchJ9SAk+MOj/+1yIKWXY6O46KfUT21s3N/r0vPpTkern1ZSX
	kY89ilbeeTh2LSt72zRIeHPYwSmtMLiUQ52p700v9sdJz6SV5Xrf1hy5oJRprhdr/cHOM/Xb
	3juVWWKvscIxCamWy445Eyq17C8y1HQ5zQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi,

I focused on converting the existing APIs accessing ->pp_magic field to
page type APIs.  However, yes.  Additional works would better be
considered on top like:

   1. Adjust how to store and retrieve dma index.  Maybe network guys
      can work better on top.

   2. Move the sanity check for page pool in mm/page_alloc.c to on free.

   Byungchul

---8<---
From 7d207a1b3e9f4ff2a72f5b54b09e3ed0c4aaaca3 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Mon, 21 Jul 2025 14:05:20 +0900
Subject: [PATCH] mm, page_pool: introduce a new page type for page pool in page type

->pp_magic field in struct page is current used to identify if a page
belongs to a page pool.  However, page type e.i. PGTY_netpp can be used
for that purpose.

Use the page type APIs e.g. PageNetpp(), __SetPageNetpp(), and
__ClearPageNetpp() instead, and remove the existing APIs accessing
->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
netmem_clear_pp_magic() since they are totally replaced.

This work was inspired by the following link by Pavel:

[1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/

Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 28 ++-----------------
 include/linux/page-flags.h                    |  6 ++++
 include/net/netmem.h                          |  2 +-
 mm/page_alloc.c                               |  4 +--
 net/core/netmem_priv.h                        | 16 ++---------
 net/core/page_pool.c                          | 10 +++++--
 7 files changed, 24 insertions(+), 44 deletions(-)

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
index ae50c1641bed..736061749535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4135,10 +4135,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
@@ -4168,25 +4167,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
 				  PP_DMA_INDEX_SHIFT)
-
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
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4fe5ee67535b..906ba7c9e372 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -957,6 +957,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
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
index f7dacc9e75fd..3667334e16e7 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
  */
 #define pp_page_to_nmdesc(p)						\
 ({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
 	__pp_page_to_nmdesc(p);						\
 })
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ef3c07266b3..71c7666e48a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -898,7 +898,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			page_pool_page_is_pp(page) |
+			PageNetpp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -925,7 +925,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-	if (unlikely(page_pool_page_is_pp(page)))
+	if (unlikely(PageNetpp(page)))
 		bad_reason = "page_pool leak";
 	return bad_reason;
 }
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..39a97703d9ed 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -8,21 +8,11 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
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
+	if (netmem_is_net_iov(netmem))
+		return true;
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
-- 
2.17.1


