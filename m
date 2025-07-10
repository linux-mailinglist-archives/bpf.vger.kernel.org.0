Return-Path: <bpf+bounces-62899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB51AFFC5A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339E2580D9D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDF29B23E;
	Thu, 10 Jul 2025 08:28:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693528DEE4;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136113; cv=none; b=s4WGFmUaBxIz10iKDj66CdoG1UNjjad1NKoA/tbDf7hL+PV9qiutT3F6laE8ghcef5OVsK8CTV0GszoBtVwzIqbHFLVx8MzUYauPniMvel1It8I/9gCyUcXCVyP5dgy6nHHqkS5YaPeXFwNmIEEyEcllHGUOQ3lJEki+KEi6EbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136113; c=relaxed/simple;
	bh=7zC/36ooVLBFCzQX6UCj1AUYzrfHYBeqvMujF7ao+zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SEGeFlsq2iotQw6aeU1ZzNcdv1CyW/2ZVExgJg7JNaOXjTTQ9hVGpzKFYWr+/JR22yLpwiFcpaB4744NF0NZabmLTji/zhZ7RdO7Jm5tUed0DGJYoRmBWS1yZsgpkhQayzHr9qqEkXaZjZF/rtw+9pmwoBSb3pMzOzcXPYi2pXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0e-686f79a1c52f
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v9 6/8] mlx4: use netmem descriptor and APIs for page pool
Date: Thu, 10 Jul 2025 17:28:05 +0900
Message-Id: <20250710082807.27402-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTYRgH8N6dd+ecDYenJXbSIBhWJNkNiweJEKJ4oYIuH4qEcuRhW21T
	5yXtIprLy0iLSpDUmIq3zVgsyXVbZaaGRUOZrSxnmpcPXlKnqQtqS/r243n+z//Lw1LyXhzB
	avTpgkGv1CpoKZZOhlTH1GQnq3d8L2Oh0tZMg3UxCxoGHWKotDxG4FvqZ2CuvZOG2uoFCio/
	GjHM25YpGOkYYsBqPwLe+lEMzwtbKRi62UVDidFPwYulKQauORpF4HpcKoa7y3UUtOYOMtD7
	tJKGgeY/YhhtK8Hw7l4TBm9pPHSYw2GhewJBu61VBAs3qmi402OmYdjoRdDzZghDRV4pApvT
	Iwb/YqCj4u0AEx9F3kxMU6Sl6bOIPLn3jSFmewZ51BhNTJ4eitgtxTSxz95myNe+5zTpKvdj
	8sQxJyIl+VM0mRn5gsm0000TW4sbk/fmdubo6tPSvUmCVpMpGLbvS5Sq8yvGcEpdXFbtTA3K
	RcXbTUjC8lws3/ziPvPfLy3XRUHT3Gbe41migg7jdvJzQ53YhKQsxT2g+fbm/n8Ha7gTvNc5
	gIPG3Eb+U/l9cdAybjfvmjdSK6UbeOvDVwGzrITbwzuGLwfH8kDE7zb96+S56yx/c7JQtJJf
	x79u9OBbSGZGqyxIrtFn6pQabew2dbZek7XtXLLOjgKvrr/6O8GBZl0n2hDHIkWIzKXSq+Vi
	ZWZatq4N8SylCJMtntKq5bIkZfYlwZB81pChFdLaUCSLFWtluxYuJsk5lTJduCAIKYLh/1bE
	SiJyUWm+Jqykmhw3d59URUiqht8nJVZv8Wt+nY1JqRtN2Br3J26989mxss3CoYsN4g2+UN3I
	Ur10rEinOlMT1hd7uioypylxfFOUtbajOyPHdn61KzXmwIf4gmODF/aH/uzpM/UXXPIfLHL7
	EvarfUyDdTD1cGHIeHjR2BVJ37n0H7l5CpymVu6Mpgxpyr85Rj8U5gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRXUhTcRgG8P47//PhanCYUgcjqkEIQamg9mIS5o2nT/qgFAly5KEt55RN
	hxaBtWm1cpV5YTljJdo2jcX8mmEmm6nRRTbRZqbTmRZR9jEVdVFtRHc/3ufhuXkZQtqOYxml
	uljQqOUqGSXG4sO79TselBUqEn43poDZ0UJB83IpPJpykWC2dyBYWBmnIdg3QEHDgyUCzK8N
	GBYdqwTM9gdoaHYeAn/THIbuK50EBG4OUlBlCBHwbGWehssuqwg89S9JGOowkVCz2khAZ/kU
	DcNPzRRMtvwhYc5dheHlPRsGvykd+i3rYenVFwR9jk4RLN2op+CO10LBjMGPwOsJYKi7ZELg
	6PGREFoOb9S9mKTTt/GeL98Ivs02JuK77k3QvMVZwrdat/NGn5fgnfZrFO/8WU3z70e7KX6w
	NoT5LldQxFfp5yn+x+w7zH/rGaH4hk/fRbyjbQQfkeaI0/IElVInaOL35IoV+rqPuKgxtbTh
	x0NUjq7FG1EUw7FJ3HN7hShiio3jfL4VIuIYNpELBgawEYkZgn1McX0t43QkiGaPc/6eSRwx
	Zrdxb2vvkxFL2GRuaNFA/BvdzDU/6Q2bYaLYFM41cyFyloYroREjvoXEFrTGjmKUal2BXKlK
	3qnNV5SplaU7zxQWOFH4mU0Xf912oYXhTDdiGSRbJxk6q1ZISblOW1bgRhxDyGIky9kqhVSS
	Jy87L2gKT2tKVILWjTYyWLZBsj9LyJWyZ+XFQr4gFAma/6mIiYotR5vitnoKbDl9q4ZTa72n
	3UFda9W++fajx7dk3a0kR6tp+S7bOQN5/arq62t0sMaXli39QFZUCJ0Z1TcOp55MHThg3Ss+
	kTCmPyba0ua5GGd9/jlpOlFdqZuuSCxOcPf7B4r3jlcGut8wpozyXruOy2/3WhXpmRO52Rut
	wei19TKsVcgTtxMarfwv0nstasgCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to separate its own descriptor from
struct page is required and the work for page pool is on going.

Use netmem descriptor and APIs for page pool in mlx4 code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 48 +++++++++++---------
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 ++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  4 +-
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b33285d755b9..7cf0d2dc5011 100644
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
-				     frag_size);
+		__skb_fill_netmem_desc(skb, nr, netmem, frags->page_offset,
+				       frag_size);
 
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


