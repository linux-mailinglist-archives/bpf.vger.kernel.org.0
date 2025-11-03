Return-Path: <bpf+bounces-73324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D47C2A68C
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59B3A4EFBAD
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0522C0F81;
	Mon,  3 Nov 2025 07:51:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355361411DE;
	Mon,  3 Nov 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156309; cv=none; b=da1wpnisq30793+dxCbf2hUnDEmZxV3/jGtrqtlNeojdM0523bD1m/duobWGfQQpMGu/qBqkNXQ/aZgi4HSnsQcJ6lawwa5lXLxgn13MSNuun21/nj6yDPIXIksJmYBcPBUgZDnrZiGxjyhUPrgDQ1WXURf8qPBRwI0shaz2CQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156309; c=relaxed/simple;
	bh=HZcjv4SLWrRkO22qgp4GIaRAxK0/5cYFlWxwMRi41lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oJd6go75LbQh2+A0qorulfpCvU87rcvQxxVg6yc6jXMBNmEaM05XV5+FSan7u7Noq1q+AuODg0Qs1o+MRv8ls2esmcpCbP+pRoMXpdiLEJpnUkSuAEk95SjKxtiRxGGZdwsxiqA5NLID7D/8Gm8VxyiWfjTrXauoOTK5xmoSKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-5f-69085f0c2fe6
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
Subject: [RFC mm v5 2/2] mm: introduce a new page type for page pool in page type
Date: Mon,  3 Nov 2025 16:51:08 +0900
Message-Id: <20251103075108.26437-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251103075108.26437-1-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHe+69u/e6XNym1U0/WCMJjNTK4kQRURFPlGBEH8rCRl5ypFbz
	JY2CaUPL8q0yzRYY1ZzTUKeps810W8vemBnqlqZmZGTLwsxSBzYtv/0O58/vnA9/lpSqRQGs
	IjFZUCbK42W0mBJ/8727dnEMqwjvKWdBU11FQ+WfNCgfbBLBZNVnAjT6BgTjk70MzJjtCH7a
	ntHw1TqG4N7dCRI0DjUFv6qnSDA2f0YwUvKQhk/2IQYqDZEwoB2mwJTdSMJQfjsNueppEsyT
	owxkNum84joVAx0NeSK4MfWAhEbVIANvmzU09FfNiGDYkkvB89IKCn4U2UgYyNsO9rKlMPHS
	jcBW3UjAxNU7NHTdaibgkbmLgeudZTR8VA8g6LQOUVDkuUTD7Yw8BNN/vMrRgnER3H7az2wP
	xRlOJ42t7u8krq9wEbi7pJDCzpYXBDaWvmdwmSEF1+lCcI6zk8QG/WUaG8auMbiv20Tj9pJp
	Chs/bMbGpp8Ezr04SkctOSzeGivEK1IFZdi2Y+K4b65i4vQ7nOZqNJMqVLMlB/mwPBfB6z/V
	EfOcr/9BzjLNreadzsk59ufCeV3RuJfFLMldYfnellrvwLJ+3H4+qyNtNkNxwXx/wVN6liXc
	Rr73+j3ynzOIr6xpnWMfbhNvfqWduyX1ZvT16jknz7Wy/Ps37v9PLOfbdE6qAEnK0AI9kioS
	UxPkiviI0Lj0REVa6PFTCQbk7Yb2gie6CY11HLAgjkUyX8ngcUYhFclTk9ITLIhnSZm/xKWm
	FFJJrDz9nKA8FaNMiReSLCiQpWTLJOsnzsZKuRPyZOGkIJwWlPNbgvUJUKElrwOD/J2E/xPd
	a0dA6XDQoS87FrWP1LTZ8k2vlHv3rYjwXPJ0LnRFa0cK17LTUz3Lbg6sctvDznTHRDvOX9Pe
	dNW61w/tPWfxcxDFUVbPysepGtfurX0FYa17JKrfnoORa8j7UVmGda6d2drwI/lt33fVFoYF
	b9BnHtUl+5o+rpRRSXHydSGkMkn+F6OI+pUXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTcRgG8P7nnJ1zXC2OS+pglLQIycyKtF4xxCTwX1TYp6AUHXnK4bxw
	pqaBOXNkWt6VzEsolum0tGnqxFnNS7OERDGmljMjlVIzNcksahZ9+z28D8+XlyXlk5Qzq4qK
	FcQopVpBSynpaZ/UvRtCWNX+4mwvKK2vo6H2ewI8GG+VwErdFAGl+mYESyujDPw29SBY7HpB
	w+fOBQSVFcsklL7WUfCt/gcJxrYpBJ+KHtLwsWeCgVrDKbBVTVLQntZCwkS2hYZM3SoJppU5
	Bq61VtuHG7UMdJb1SqC/OUsCBT/uk9CiHWdgsK2UhrG63xKYNGdS0FtcQ8F8YRcJtiw/6Cnf
	DMuvZhB01bcQsHyrjIahO20EPDENMZA/UE7DB50NwUDnBAWFP2/QUJKShWD1u31yLmdJAiXd
	Y4zfPpxitdK4c+YLiZtqhgn8piiXwtaOlwQ2Fr9jcLkhDjdWu+EM6wCJDfp0GhsW8hj89k07
	jS1FqxQ2vvfGxtZFAmemztGBm89Jj4QJalW8IO7zDZWGzw7fJmJGcMJwi4nUogafDOTA8pwn
	n62fJ9dMc6681bry107cfr66cMluKUtyN1l+tOOxPbDsJu4Mf70/Ya1Dcbv4sZxues0yzosf
	za8k/2268LUNz/7agTvEm/qqiDXL7R19k47MQdJytE6PnFRR8ZFKldrLQxMRnhilSvC4EB1p
	QPbvVyX9zG1FS4MBZsSxSLFBNn6BUcklynhNYqQZ8SypcJIN6yiVXBamTLwiiNEhYpxa0JjR
	VpZSbJGdOCuEyrlLylghQhBiBPH/lWAdnLXo6szu85XyiqD1zxn3oxYLk2zKCzusdXb3df0g
	ZriUbHMema4NPhhw8Wmgt21+4+ysecExtKbsuGPQZdFHf5c6pldu9/cueLKn11WdV5b2y/LV
	Nb5yTGMTtuiCj/pORx5xFANS0pqpzJ2e/v7pJx/twJJjXcaOJPfqkbiB5Ma+ewpKE6484EaK
	GuUffCXdMvkCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
determine if a page belongs to a page pool.  However, with the planned
removal of ->pp_magic, we should instead leverage the page_type in
struct page, such as PGTY_netpp, for this purpose.

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
Acked-by: Mina Almasry <almasrymina@google.com>
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


