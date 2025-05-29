Return-Path: <bpf+bounces-59249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AAAC7642
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C4D1C04677
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A525C701;
	Thu, 29 May 2025 03:11:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265324BD00;
	Thu, 29 May 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488274; cv=none; b=VOhY9ZIdSdBFFJRGBMlSE6AcsGVNOaMb/9M7c3QLqjwMT9L3qvPSuT2Gth3JiWhHIj9scQg14aPuD7fvWmcGsr6xedBhq7k7zcpRZU5YgKNBG36Myu2zCywf3gt2j0ImNvR/FP/4F0JMpWH9o6Tz/JJXqxl9hxUpAgbVGIK1EHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488274; c=relaxed/simple;
	bh=7zC/36ooVLBFCzQX6UCj1AUYzrfHYBeqvMujF7ao+zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EqnOnsldALVLY+y61mbkCjbgb3zSyD5ki3QeDQYrAJlSMombzFVw/x7urVq9dRUQeJQt+QH456F3XQpyNF6i5z3R/VmGptpTz8WxQlNaaUOOQBuwlm0HX5hpLMX3F+1HpTwrCMnCQH5Qif0uf7w7Rt9rlHzBsPuj3Ajspcs05mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-37-6837d042e999
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
Subject: [RFC v3 11/18] mlx4: use netmem descriptor and APIs for page pool
Date: Thu, 29 May 2025 12:10:40 +0900
Message-Id: <20250529031047.7587-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG++/8d3YcGx2W1MlEc5WVlaZovpSYGMSpvhRBHyrK0U5uOKcd
	L6kUeJnktJlUiukJVqZ5g8UKnSWSa6hR4DK0mZVmaUJe8ja8BOaUvv14Hp7f++GlCIUD+1Ba
	fSrH61U6JSnF0gnZowOxzkjNwR/GHSBYGkloWMiAp0M2MQj1TQjmFgckMOvoJKHqkZsAoduA
	Yd6yRMBIx7AEBmtGMbTeaiZg+E4XCSbDMgG5tloROJuKxXB/qZqA5uwhCXx8KZDwrXFFDKN2
	E4a3FXUYBotjoMO8GdzvxhE4LM0icN9+SMK9HjMJPwyDCHreDGOozClGYGlziWF5QSBjAtgX
	df0itqXiq4Q1W9PY57VBbKGrh2Ct9UaStc7clbBf+lpJtqt8GbMttlkRa8qbJNnpkc+YnWrr
	JVnLi17Mvjc7JOys1e80fV4apeZ02nSOD4mOk2ryKn/h5OrDGVXTj1E2MoYUIi+KocMZx58P
	4v881ZCPPEzSuxmXa5HwsDcdyswOd+JCJKUIelLMjAjLIk+xiT7JfO8TsIcxvYvp/9S6mlOU
	nI5g5ib4dac/0/Ds9ZrHazUue162NlWs3npQ2E56nAw9L2F+lxtF64OtTHutC5cguRltqEcK
	rT49UaXVhQdrMvXajOArSYlWtPrbmpt/L9jQjPOsHdEUUsrkXShSoxCr0lMyE+2IoQiltzz3
	6CGNQq5WZWZxfNJlPk3HpdjRNgort8jD3NfVCjpelcolcFwyx/9vRZSXTzbKlEUV7XH6h16s
	m7kUf2Sf/4Q3aGsaR8b27vwZWFqX218RdPWJhpfY/bLGDBFwzRHYOXGq01fNG9W+3QWx/kUr
	BdMzJULT/o0JC5UGWeK5yoyA7bnHNG/1VtPlOJMuffxD2Jn8afVAWZultCXHHX3qVXe0LVmG
	T9iWhBvdzuNKnKJRhQYRfIrqH4Ymy0zXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTcRzF/e3e3V2Hg9uceTVBGIYkpAmZX0rK6o+uEmFvqECHXtxwc7qp
	uB5gapTDLXtJ6YSV+JrCajM3Q0Sn+KAkUzQfNV9pgaXpzHyRbUb/fTiHc84fh8SENXggKUvP
	YlXpErmY4OP8M0cK9p/oj5Ye2O7zA4O5gYD6tVyombRzwWBqQrCyPs4DV2c3AZXPVzEwvC/E
	4Zd5A4PZrmkeTFTP4dBy14bB9P0eAnSFmxjk22s50FHRy4X+Jj0XHm9UYWDLm+TB4BsDAc6G
	bS7MOXQ49JbV4TChj4Uu425YffsdQafZxoHV4goCHg0YCZgpnEAw0DGNQ/ltPQJz6wgXNtcM
	RKyYaawb5TDNZZ95jNGSzVhrwxjtyADGWExFBGNZfshjPg23EEzP002caba7OIyuYIFglmbH
	cGaxdYhgKr/95DDmxiGceWfs5CXsusKPSWHlshxWFXE0iS8tKP+KZ1Qdzq1ceoHyUFGEFnmT
	NHWQXqy/gzxMUKH0yMg65mERFUm7prtxLeKTGLXApWcNmxyP4UvF01PDBtzDOLWXHv3Y4tZJ
	UkBF0Ss/VP86g+n6l207Pd5uudRauhMVureeaduJEsQ3Ii8TEsnScxQSmTwqXJ0m1aTLcsOT
	lQoLct9XfWvrgR2tDJ5yIIpEYh9BD4qWCrmSHLVG4UA0iYlFgvxjh6RCQYpEc51VKRNV2XJW
	7UB7SFzsL4i/zCYJqVRJFpvGshms6r/LIb0D85DXlE/GeJC5IuBsal9yNlJkzgfH+120sbWN
	s0Ehbee3YorG2s9d8P1zL8RxQxRdLChFbWEx+vmF0791y3Fqv2vOPwGJZR9MV9vHAi2xYV9e
	WZ/0Hxe5TorG+c76mUTxPkOdaMbfanRlFs1nKEtWE53K15fibhKhFm13XYJmoFmMq6WSyDBM
	pZb8BSk6e5K6AgAA
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


