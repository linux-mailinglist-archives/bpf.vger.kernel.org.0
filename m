Return-Path: <bpf+bounces-63870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B554B0BA8E
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A7A16BCA4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AED23A9AC;
	Mon, 21 Jul 2025 02:18:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1821FE44B;
	Mon, 21 Jul 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064334; cv=none; b=g81WNT5O2a9d4HAh/CmoGxod4g7W9Z6Y5bTvb0jNIp+S9TjBzVNhENwawYHYBW1mTOymIsCaSEPs91Uczm0eKUxXs1vy+z7hzwc4mi6dQ+abIxfB764uws9iLOi8bP2eDqrg4XbSiPyLqW77g7yOqVL0jlWPQkt178F3+KKFQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064334; c=relaxed/simple;
	bh=e2bZydgW45jA6wnI4gmVyclBkwDdZEmKMnI79cHP2Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oqpqZp0rGUoxoPqJ5JeFXLSnOJ4XK072DLItBtKR++v2ODDC5+6EJUcOxkJUYVYdeSj+maeet8gdKIqYFxdPTbSU2mnJ/KiSxOP36ZFG5o7fxA8+ptrd6lhW3i+6FyRCNkDgzhUogr76E9YbDjyjN1N7DgvVaneWuagrcHGTt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-58-687da38677c2
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	akpm@linux-foundation.org,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	david@redhat.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org,
	matthias.schiffer@ew.tq-group.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v12 03/12] netmem, mlx4: access ->pp_ref_count through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:26 +0900
Message-Id: <20250721021835.63939-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b93Gpq8qQZfZBtLDdFhhHk/H+Zitiz5L8uWLfrBS7b5brxb
	qy1iS7k4UUTmYoOVOCXA6oaCjlKzkiJQtSB7i4L3Csg6LbeaeS0qIoxSsGsh+/bLeZ6c55yc
	w5Gqv+gFnDYzWzJkijo1o6AUw/Enlx6oLtC8+3hkIVgdZxi4PXqCBvtEHvw+6KKhyybABe8E
	Ada6JgSvQvdYcB70kzDa3sFA9YlxEkL1hyiw3iqmYMwxScI/lwMsdMrTFNidn8LA6QcUuH9q
	JsEzlgKBw50MHCoOk1DR/yMDkbthGlpCz1goctUS0PK0kQVvk4WGo5OnSGguHIxm3e+lofu8
	lYHu/bcR9J+J0PBAjgYGa/0sWOyVCOSLNgaKildAsPEVCy+OtZMwYFkHr8tz4HJVAoxfCyK4
	d+oOARG3i4Wb/X/Q0O5oJqBnKETCeMlxBszDhxHcqThPwPXj9TTUXOshonOsh97IFAE/d1Ux
	cL94AEGXJ0DBL/ssCBytPhpG3NGVwxNWZt0H2BN8TmJXXw3CZ21/E/hR6WsC+1qvEvhcZR+L
	q5wm3FCbiqvdjwls9nWR2Fl3kMHOl0dY7O91M7izPEzhhpq9+FFDBfr8zc2K9zIknTZHMqS/
	v1WhKWv8LOtoUl7jLRddiCwJZhTHCfxK4aF8gDEjboZ/DetiZYZfJPh8ITLG8/hlwmiggzIj
	BUfyN+KFloZyIibM5bcL/7aFZ0wUnyKUeGQmxkp+leB19KDZ/smCvb5txhPHrxYC0ePHWBX1
	BJ+46FmPI04wH3l7lhOFP2t9VClSVqE5dUilzczRi1rdyjRNfqY2L+3bHXonir7b6YKpLS70
	0rteRjyH1PHKLKpAo6LFHGO+XkYCR6rnKXHHLo1KmSHm75IMO742mHSSUUZJHKWer1w+npuh
	4r8Xs6XtkpQlGf5XCS5uQSF6o8QkPU1KlssG05nIb8PGK8dspo8+1rft8e796gvTw9QOsFn1
	Xzo3Tu+cSmyi1d2LN1m/GV77xJN+rt5+1c8O7v5wZEPCpW1Bz8bk7LN9n6wZE3m3qBlaoe3s
	HyraU5k2Z8q/evdk2Vu5CxUFdZd+KEuseUezWd2aMv3dklKxdyJXTRk14rJU0mAU/wMKulQq
	agMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG93/vVKpvCsFXzS5pdCQmosRLThwsun3gn8WZJSzbIltmlTe2
	oSBppQGSRqbdjBWrTGfAlQkBgVKhpFioWC62yMUbt4JFELAEg1u9cpm1ImtN9u138vyS5yTn
	cKTMQa/lVFlHRE2WQi1nJJRk72fHN/1WoVdu6R2VgNl2hYGBuXIarK9zoXrKScOgRYDr/a8J
	MNc2IZgPjrFgPzlOwlxnNwMV5YskBBtOU2DuM1CwYHtDwkyXn4Ue9xIFVvvXMFn1mALXiWYS
	PAsbwH+mh4HThhAJJRO/MrD8IERDa/AZC8ecNQR4SnvD4z8OFvqbTDScf3OZhOaCqXDh9AgN
	Qy1mBoaODyCYuLJMw2N3uDVQM86CyXoRgbvdwsAxw1YIOOZZePFHJwmTpl3wrlgHXWVxsHg7
	gGDs8jAByy4nC/cm6mnotDUT4H0UJGGxsJQB49MzCIZLWgi4U9pAQ+VtLxHeIxVGlt8ScG6w
	jIFpwySCQY+fgj9/MSGwtfloeOkyULu+xJ7AcxI7H1YifNUySuDZs+8I7Gu7ReBrFx+yuMye
	gxtrNuIK1xMCG32DJLbXnmSw/dXvLB4fcTG4pzhE4cbKo3i2sQR989E+SVK6qFbpRM3mz/dL
	lBcce7PPr8t19DnpAmSKMyKOE/htwl8htRFFcQwfL/h8QTLCsXyiMOfvpoxIwpH83WihtbGY
	iAQxfIbwb0fovUTxG4RCj5uJsJTfLvTbvCjCAv+xYG3oeO9E8TsEf/jgEZaFncDfTvoskpSh
	D2pRrCpLl6lQqbcnaDOUeVmq3ISDhzPtKPxMVfq3RU40P5TiRjyH5NHSbEqvlNEKnTYv040E
	jpTHSnF3vlImTVfk5Yuawz9rctSi1o3WcZR8tfSr78X9Mv6Q4oiYIYrZoub/lOCi1hYgyU87
	V37RNq3vpbxTRZZzGea0AzFL6TF7vHy9PvlmWnniivi6pOHkZys6uL4iT3PS+mocTdcVrrJd
	++5C1yWLuj9vKTV+NnW948eY9g9TH53aMmtfuJHSdndmbKZF/uknKabWS3vyT1Tdb/rWlkwZ
	qwNjz3evsc68fFKgW/lDPW71yymtUpG4kdRoFf8B25VR9UgDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make mlx4 access ->pp_ref_count through netmem_desc instead of page.

While at it, add a helper, pp_page_to_nmdesc() and __pp_page_to_nmdesc(),
that can be used to get netmem_desc from page only if it's a pp page.
For now that netmem_desc overlays on page, it can be achieved by just
casting, and use macro and _Generic to cover const casting as well.

Plus, change page_pool_page_is_pp() to check for 'const struct page *'
instead of 'struct page *' since it doesn't modify data and additionally
covers const type.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  4 +++-
 include/linux/mm.h                         |  4 ++--
 include/net/netmem.h                       | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b33285d755b9..92a16ddb7d86 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -460,9 +460,11 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 
 		truesize += frag_info->frag_stride;
 		if (frag_info->frag_stride == PAGE_SIZE / 2) {
+			struct netmem_desc *desc = pp_page_to_nmdesc(page);
+
 			frags->page_offset ^= PAGE_SIZE / 2;
 			release = page_count(page) != 1 ||
-				  atomic_long_read(&page->pp_ref_count) != 1 ||
+				  atomic_long_read(&desc->pp_ref_count) != 1 ||
 				  page_is_pfmemalloc(page) ||
 				  page_to_nid(page) != numa_mem_id();
 		} else if (!priv->rx_headroom) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa538feaa8d9..ae50c1641bed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4178,12 +4178,12 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
 #ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(struct page *page)
+static inline bool page_pool_page_is_pp(const struct page *page)
 {
 	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
 }
 #else
-static inline bool page_pool_page_is_pp(struct page *page)
+static inline bool page_pool_page_is_pp(const struct page *page)
 {
 	return false;
 }
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 097bc74d9555..f7dacc9e75fd 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -285,6 +285,23 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
+/* XXX: How to extract netmem_desc from page must be changed, once
+ * netmem_desc no longer overlays on page and will be allocated through
+ * slab.
+ */
+#define __pp_page_to_nmdesc(p)	(_Generic((p),				\
+	const struct page * :	(const struct netmem_desc *)(p),	\
+	struct page * :		(struct netmem_desc *)(p)))
+
+/* CAUTION: Check if the page is a pp page before calling this helper or
+ * know it's a pp page.
+ */
+#define pp_page_to_nmdesc(p)						\
+({									\
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	__pp_page_to_nmdesc(p);						\
+})
+
 /**
  * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
  * @netmem: netmem reference to get the pointer from
-- 
2.17.1


