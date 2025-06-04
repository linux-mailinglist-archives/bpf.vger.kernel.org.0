Return-Path: <bpf+bounces-59622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60751ACD625
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72239189D5A8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234E257436;
	Wed,  4 Jun 2025 02:53:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3322A4F6;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005594; cv=none; b=Qin4HbVP4eaIinkxIsHq95xByr9IbdrW8RSW29wQg5ag/V40jvuvybIvPc1wcEhf983EBSTpfEohypDjV0sH8cLS+bR7iagsi+Zbm55hv+hpXWUfIuUDk2je7hxPwLbj8EvCsF7i+IqhTcmOzw1IVfCfGGjif0nyHDq5ThVNnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005594; c=relaxed/simple;
	bh=7zC/36ooVLBFCzQX6UCj1AUYzrfHYBeqvMujF7ao+zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hqgW2pGVoTfx+oAMM98svdF8CAc7mK1F4HFfj9a+LTlpqI071h0D4/qFDbpwttONRriRfEdrch1+pIjDCO1LBSD+Ihj/v6f7Bf09u+NdS8QUG/xSpwhkZksGmXfAgYQLYVN4RDohS8NFITZs3GgppowC5Vmvp/srbLiIFIBLH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-28-683fb50a2444
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
Subject: [RFC v4 11/18] mlx4: use netmem descriptor and APIs for page pool
Date: Wed,  4 Jun 2025 11:52:39 +0900
Message-Id: <20250604025246.61616-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e+cnbMNF6cl7aSQtIrSzGVZ/LpgQi+HQoiUHjKyqac2mpc2
	tRkE1gTRmoqJia6Yeb/AYnmZoWLLa0qN2WyVpk2mD+V1Zt7AnOLbh++Xz/fly8NE3bgvT5GY
	wqoSZUoJIcAF095lxwVNF+UnimwU6I0NBNQva6B63MwFfV0zgsWVHyS4u3oJKC9bwkD/OROH
	v8ZVDFw9ThLGqiZxaMtqwcCZ10eALnMNgyfmGg5Ym3O5ULhaiUFLxjgJQ+/0BPxs2ODCpEWH
	Q39JLQ5jueHQY9gLSwN/EHQZWziw9OwlAc9tBgImMscQ2D44cSh9nIvA2OHgwtqyngg/wDTW
	fuMwrSWjJGMwpTJvawKZHIcNY0x12QRjWiggmZHhNoLpK17DmVazm8PotDMEM+/6jjOzHXaC
	MTbacWbQ0EUybtP+q9QNwYV4VqlIY1XSsNsCubZ0Ck+uPKcpn3+NMlC2NAfxeTQVSv8edJA7
	rG1q43qYoI7QDscK5mEfKoR2O3vxHCTgYdQMl3bp1zieYg91mXZZO7dknDpMr5i+Ig8LqTP0
	REUHsT3qT9e/6dwa4m/mIzMvtlwRdZrWmb9gnlGamibpdksh2hb20e9rHHg+EhqQVx0SKRLT
	EmQKZWiwPD1RoQmOS0owoc1zqx6tR5vRgjXSgigekngLzSNhchFXlqZOT7AgmodJfIT+AZuR
	MF6W/pBVJcWoUpWs2oL8eLhELDy59CBeRN2VpbD3WDaZVe20HB7fNwMZPk1WVH8syjfw8wbv
	P3UGUde954LvcPj/IoyRsRhBv4paL2i/Zgs4tmEQ81MWdQOj/RF+u8K04vNiOupKzJS9KJas
	tZaiBv+jqrjJJE34wQVKEjrbl0f237xUH3n2VkZ+z3CYlzSWDeo+pM36Re4eIirnWGktitYL
	TxXbJbhaLgsJxFRq2X+ipmzg2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/e9cNoeT47I82YMxkEhIE1J+mJjZg4chwxLRIsihhzacUzbv
	YFguQnF2pUInzfuVJmu6o4iXKepKyLzONBVF8yEsL5nXzBW9ffh8+X5fvgJMXId7C5TqdFaj
	lqskpBAXyi4XXBC2XlFcLL8HBlMzCU072VC3wBFgaGxDsLU7w4fN/kESqiq2MTB81OHw07SH
	wfLAIh/ma1dw6HxkxWDx8RAJet0+Bg+4eh70ldsJGGkrIeDFXg0G1vwFPox1GEiYaz4iYMWm
	x8Fe2oDDfEk4DBhPwfaHbwj6TVYebBeXk/B81EjCkm4ewWjfIg5l90sQmLocBOzvGMhwCWNp
	mOYx7aVf+IzRnMG8q/djihyjGGNuLCQZ88YzPjM72UkyQ6/3caad2+Qx+oI1kllf/owz37sm
	SKZq9QePMVkmcGbY2M+P9rglDE1iVcpMVhMQliBUFJR9xdNqQrKr1itRPioMKEKuApq6RBe0
	dhJOJqlztMOxiznZkwqkNxcH8SIkFGDUGkEvG/Z5zuAEJaWXR3r4TsYpX3rXPIWcLKKC6aXq
	LvLfqA/d1NLzd8j12M+uvfrbFVNBtJ4bx54goRG5NCJPpTozRa5UBflrkxU5amW2f2Jqihkd
	31ebd/CUQ1tjkTZECZDETcTNhinEhDxTm5NiQ7QAk3iKfM4fK1GSPCeX1aTe0WSoWK0NnRHg
	Ei+RNI5NEFN35elsMsumsZr/KU/g6p2P/Oe8KFulC26//uYh974i6FoTe1KqjrG/ze26Ics6
	O9wZ2RsboRO/jCc6tqa4OffujembMW5xiSF5Q/YoCJq9miguzkqbiV3pnmlZr62ePOzN9DiI
	8k3KHbN+qrSftqzoycPw27/de8ZXh37JuJaQoxJZaERwX3RzfG+31MJKcK1CHuiHabTyP/Wm
	b1y6AgAA
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


