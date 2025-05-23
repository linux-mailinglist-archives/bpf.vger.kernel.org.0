Return-Path: <bpf+bounces-58810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48093AC1A93
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E4B1C04A31
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C4274FEB;
	Fri, 23 May 2025 03:26:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70135224AE1;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970790; cv=none; b=Ebvz3RmJlIYTruP+i6RXBOA90qPK8tVhXPFyDHAVPeLPnQdwMp5FPdtNo/SWKg/GjbcGw5qai1qliCDIvm3GnDsbkTiNNHdkyULg6mZBvsQbW/EbOBGHm1vhXaVGY89kSm3jh5WCIGaU73kxAPz8R6lqFXxfT9mxSl1HqcsTqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970790; c=relaxed/simple;
	bh=x0o0tW2WrwqtIJ0+MQrYN1XeLwC96YAL6ESpevfMv+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aKxAgc5xbTnBlQTJ/EYVID92Xcq3vZBfP/FGZFrj7/KSDRZQzUQG5MrPghQqRX7US+NzFalLbq/VysBS2wJSkirKzrsaQusuk94GqAjdYxOjdHd8tALvsDFv3mSYn328f8qXeqgwL+vTW79baVSm15vUF/V+3C0UpS2x4QHhExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d9-682feadc0d0a
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH 11/18] mlx4: use netmem descriptor and APIs for page pool
Date: Fri, 23 May 2025 12:26:02 +0900
Message-Id: <20250523032609.16334-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRiGe3fevee4Whxm6FHJamGF0MzQeNDoE+P0ow+M+lGQjTy54aay
	qWlUbGlFoiYVJbpiUZpfMFmms8RqaloWiWnMrymKSmFKmw51hrk+/l3cz83FDQ9DyVpwMKNO
	SRd0KUqNnEiw5Meax9sHv0eodpRVbwOTpYZA9XwWPBuxicFUVY9gdmGABndrO4Enjz0UmD7n
	YpizLFIw/m6UhuHyCQxNNxsoGL3dQaAg10vBNVuFCLrqC8Vwb7GMggbDCA1fXpoIOGuWxTBh
	L8DwvqQSw3DhPnhnDgBP5xSCVkuDCDz5Dwnc7TYTGMsdRtDdMoqh1FiIwNLsEIN33kT2beLr
	KvtEfGPJEM2brRn884pwPs/RTfHWqluEt7ru0Pzg1ybCdxR7Md9oc4v4gpxpwv8c78f8THMv
	4S11vZj/aG6lebc19Dh7WrI7UdCoMwVdxJ5zEpXjwy2Slh+T5RwpExvQkiIP+TEcG8VdN9ro
	/zxTc13kY8Ju5RyOBcrH69hIzj3ajvOQhKHYaTE3bvL+Kfmzh7lJl3elxDCYDeOabqh9KGV3
	cc7u+L/KDVx17Zs/Gr+VuMg5R3wsY6O5Vz39tE/JsXM0N/Twwb8NQdzbCgcuQlIzWlWFZOqU
	TK1SrYlSqLJT1FmK86laK1p5bfmVpTM25Oo6YUcsg+RrpDZJhEomVmbqs7V2xDGUfJ20bUKh
	kkkTldmXBF1qgi5DI+jtKITB8kDpTs/FRBmbpEwXkgUhTdD9v4oYv2ADOkssoVO3B1Yn6L/N
	OvosL17HtB7Bg4377caDBetDY68a8M1DqbBl8IAis/1Tf0K+32Tx3K+lqKdH4x51xW5Oqi+1
	myri20hDk/a+GIVal4OXi7XG5JOu0jFNXO0x/ydYGjiWY0u+u1F9oTNkOf94QJLzcpBJ5PLf
	2xOmWxt9So71KmVkOKXTK38D+9Dn5dYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/Z9zdnZcLo5z1EGDYGCW5ExK+1mifvNkEBFRUGQOPbnhfVPR
	KDJvoemyG4ROWpjmrWZeNk0xm3fLypkxL01ZaCamlbrUGaVG3x7e9+H98lK4qJxwpRRxSZwy
	ThYjIQWE4MTRTK/xWW/5AXWuG2h0NSRUr6TCk8kmHmiq9AiWVsf4sNjZQ0LpIxsOmndZBCzr
	1nCY6rbyYaJ8moDWGwYcrLd6SSjIsuOQ0VSBQUdJHw/e69U8uLdWhoMhfZIPQy80JFhq/vBg
	2lhAQF9RJQET6mDo1u4A2+s5BJ06Awa2/BIS7pq0JHzOmkBg6rASUHxdjUDXZuaBfUVDBkvY
	hsoRjG0u+sRntXXJbH2FJ5tnNuFsXVUuydb9vMNnxz+2kmzvAzvBNjctYmxB5jzJ/pgaJdiF
	tmGSLZ35jrG6hmGCfaPt5J90PicIiORiFCmc0jswXCA39+eSCflHUi2TZbx0tC7NQ44UQx9i
	FmqysU0maQ/GbF7FN1lM+zCL1h4iDwkonJ7nMVMa+5bkQh9jvvy0b0gURdDuTGuOYhOFtB9j
	MZ36N7mbqa5t35px3IgLLcvkJotoX6blwyi/EAm0yKEKiRVxKbEyRYyvVBUtT4tTpEoj4mPr
	0MZ75VfXbzehpaEQI6IpJHES7o31lot4shRVWqwRMRQuEQu7pqVykTBSlnaZU8ZfVCbHcCoj
	cqMIyU5h6FkuXERHyZK4aI5L4JT/W4xydE1H+5QXtsmMhSMeD9uKxOiwaPZaWP3j6e7tl8y/
	S3Rzfr+6ppr7xPeP85/2+g+uDmSfTmxtL0oM8jY02oKejwUwuzKkB0Mxa3+U6dXbmtqIsOKV
	m4HuL/3d9c/Oo2EX5+bCwW85CWe0g157HKig/aFXZgZIvearZ0dHiwVrDBGXOEkIlVzm44kr
	VbK/HKXge7kCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to seperate its own descriptor from
struct page is required and the work for page pool is on going.

Use netmem descriptor and APIs for page pool in mlx4 code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 46 +++++++++++---------
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 ++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  4 +-
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b33285d755b9..82c24931fa44 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -62,18 +62,18 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 	int i;
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
-		if (!frags->page) {
-			frags->page = page_pool_alloc_pages(ring->pp, gfp);
-			if (!frags->page) {
+		if (!frags->netmem) {
+			frags->netmem = page_pool_alloc_netmems(ring->pp, gfp);
+			if (!frags->netmem) {
 				ring->alloc_fail++;
 				return -ENOMEM;
 			}
-			page_pool_fragment_page(frags->page, 1);
+			page_pool_fragment_netmem(frags->netmem, 1);
 			frags->page_offset = priv->rx_headroom;
 
 			ring->rx_alloc_pages++;
 		}
-		dma = page_pool_get_dma_addr(frags->page);
+		dma = page_pool_get_dma_addr_netmem(frags->netmem);
 		rx_desc->data[i].addr = cpu_to_be64(dma + frags->page_offset);
 	}
 	return 0;
@@ -83,10 +83,10 @@ static void mlx4_en_free_frag(const struct mlx4_en_priv *priv,
 			      struct mlx4_en_rx_ring *ring,
 			      struct mlx4_en_rx_alloc *frag)
 {
-	if (frag->page)
-		page_pool_put_full_page(ring->pp, frag->page, false);
+	if (frag->netmem)
+		page_pool_put_full_netmem(ring->pp, frag->netmem, false);
 	/* We need to clear all fields, otherwise a change of priv->log_rx_info
-	 * could lead to see garbage later in frag->page.
+	 * could lead to see garbage later in frag->netmem.
 	 */
 	memset(frag, 0, sizeof(*frag));
 }
@@ -440,29 +440,33 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 	unsigned int truesize = 0;
 	bool release = true;
 	int nr, frag_size;
-	struct page *page;
+	netmem_ref netmem;
 	dma_addr_t dma;
 
 	/* Collect used fragments while replacing them in the HW descriptors */
 	for (nr = 0;; frags++) {
 		frag_size = min_t(int, length, frag_info->frag_size);
 
-		page = frags->page;
-		if (unlikely(!page))
+		netmem = frags->netmem;
+		if (unlikely(!netmem))
 			goto fail;
 
-		dma = page_pool_get_dma_addr(page);
+		dma = page_pool_get_dma_addr_netmem(netmem);
 		dma_sync_single_range_for_cpu(priv->ddev, dma, frags->page_offset,
 					      frag_size, priv->dma_dir);
 
-		__skb_fill_page_desc(skb, nr, page, frags->page_offset,
+		__skb_fill_netmem_desc(skb, nr, netmem, frags->page_offset,
 				     frag_size);
 
 		truesize += frag_info->frag_stride;
 		if (frag_info->frag_stride == PAGE_SIZE / 2) {
+			struct page *page = netmem_to_page(netmem);
+			atomic_long_t *pp_ref_count =
+				netmem_get_pp_ref_count_ref(netmem);
+
 			frags->page_offset ^= PAGE_SIZE / 2;
 			release = page_count(page) != 1 ||
-				  atomic_long_read(&page->pp_ref_count) != 1 ||
+				  atomic_long_read(pp_ref_count) != 1 ||
 				  page_is_pfmemalloc(page) ||
 				  page_to_nid(page) != numa_mem_id();
 		} else if (!priv->rx_headroom) {
@@ -476,9 +480,9 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 			release = frags->page_offset + frag_info->frag_size > PAGE_SIZE;
 		}
 		if (release) {
-			frags->page = NULL;
+			frags->netmem = 0;
 		} else {
-			page_pool_ref_page(page);
+			page_pool_ref_netmem(netmem);
 		}
 
 		nr++;
@@ -719,7 +723,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 		int nr;
 
 		frags = ring->rx_info + (index << priv->log_rx_info);
-		va = page_address(frags[0].page) + frags[0].page_offset;
+		va = netmem_address(frags[0].netmem) + frags[0].page_offset;
 		net_prefetchw(va);
 		/*
 		 * make sure we read the CQE after we read the ownership bit
@@ -748,7 +752,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 			/* Get pointer to first fragment since we haven't
 			 * skb yet and cast it to ethhdr struct
 			 */
-			dma = page_pool_get_dma_addr(frags[0].page);
+			dma = page_pool_get_dma_addr_netmem(frags[0].netmem);
 			dma += frags[0].page_offset;
 			dma_sync_single_for_cpu(priv->ddev, dma, sizeof(*ethh),
 						DMA_FROM_DEVICE);
@@ -788,7 +792,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 			void *orig_data;
 			u32 act;
 
-			dma = page_pool_get_dma_addr(frags[0].page);
+			dma = page_pool_get_dma_addr_netmem(frags[0].netmem);
 			dma += frags[0].page_offset;
 			dma_sync_single_for_cpu(priv->ddev, dma,
 						priv->frag_info[0].frag_size,
@@ -818,7 +822,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 				if (likely(!xdp_do_redirect(dev, &mxbuf.xdp, xdp_prog))) {
 					ring->xdp_redirect++;
 					xdp_redir_flush = true;
-					frags[0].page = NULL;
+					frags[0].netmem = 0;
 					goto next;
 				}
 				ring->xdp_redirect_fail++;
@@ -828,7 +832,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 				if (likely(!mlx4_en_xmit_frame(ring, frags, priv,
 							length, cq_ring,
 							&doorbell_pending))) {
-					frags[0].page = NULL;
+					frags[0].netmem = 0;
 					goto next;
 				}
 				trace_xdp_exception(dev, xdp_prog, act);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 87f35bcbeff8..b564a953da09 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -354,7 +354,7 @@ u32 mlx4_en_recycle_tx_desc(struct mlx4_en_priv *priv,
 	struct page_pool *pool = ring->recycle_ring->pp;
 
 	/* Note that napi_mode = 0 means ndo_close() path, not budget = 0 */
-	page_pool_put_full_page(pool, tx_info->page, !!napi_mode);
+	page_pool_put_full_netmem(pool, tx_info->netmem, !!napi_mode);
 
 	return tx_info->nr_txbb;
 }
@@ -1191,10 +1191,10 @@ netdev_tx_t mlx4_en_xmit_frame(struct mlx4_en_rx_ring *rx_ring,
 	tx_desc = ring->buf + (index << LOG_TXBB_SIZE);
 	data = &tx_desc->data;
 
-	dma = page_pool_get_dma_addr(frame->page);
+	dma = page_pool_get_dma_addr_netmem(frame->netmem);
 
-	tx_info->page = frame->page;
-	frame->page = NULL;
+	tx_info->netmem = frame->netmem;
+	frame->netmem = 0;
 	tx_info->map0_dma = dma;
 	tx_info->nr_bytes = max_t(unsigned int, length, ETH_ZLEN);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index ad0d91a75184..3ef9a0a1f783 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -213,7 +213,7 @@ enum cq_type {
 struct mlx4_en_tx_info {
 	union {
 		struct sk_buff *skb;
-		struct page *page;
+		netmem_ref netmem;
 	};
 	dma_addr_t	map0_dma;
 	u32		map0_byte_count;
@@ -246,7 +246,7 @@ struct mlx4_en_tx_desc {
 #define MLX4_EN_CX3_HIGH_ID	0x1005
 
 struct mlx4_en_rx_alloc {
-	struct page	*page;
+	netmem_ref	netmem;
 	u32		page_offset;
 };
 
-- 
2.17.1


