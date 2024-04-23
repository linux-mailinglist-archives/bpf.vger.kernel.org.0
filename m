Return-Path: <bpf+bounces-27551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19AE8AE8EE
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D702881AE
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFE313C9A4;
	Tue, 23 Apr 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrXJlNwK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1D13CA97;
	Tue, 23 Apr 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880766; cv=none; b=rQ3Swy1iORQdGwCQFn7iiFeRE1kf/DFu/0kTRw9KEcKk4UMp52OpsLsHsoWIq6VPa01BSTySA+XuNlI0tsD8UkwAdeGc2BikjfAjP/Vn3e4DNg2vel8Us1YQEMVNt0ewjG1fXyiBB4XvO7IqC1FaYqERbFlAFoqeFuvYbG5zjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880766; c=relaxed/simple;
	bh=a6GBMoetkyL5U151DNbmvgCKmuVUnTZ2swdqkInhFnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeEMzhQPCT7N+0mpM2ERkouvPaOpTxNXH1RQUZFbh/jbmHSiq1b86cRfptjBAcF5MRZtFIN/Wt+FM9GQsgBzg1Acal0M2ALdIoE50QBl51RzMpfh5EeTHCIezuHBVH6T50Bk1a00xlyUcORugZV+Wsobw+qSuoxL2+9U/J9Jyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrXJlNwK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880765; x=1745416765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a6GBMoetkyL5U151DNbmvgCKmuVUnTZ2swdqkInhFnU=;
  b=IrXJlNwKYKm1wSj8yY4/7WPFWuLpxBwWE/0pr3jAJRsCqXPJ4gvRVITB
   Ryt+Q7rq31k5Odiz91KMkF9xPY6TINJ1o+QWEY3zHXq9e+rql36rDCW5K
   opVnGsKyvnLv/9p7egTHwkY19u5TWRYfJGlUTD7lE9TJOjarp46ty7auS
   UttsSO2hDRYR8aUhI5TDPWhdptRPpfPTyiLes8PqkTMAapynoP3Ou+fo6
   jZvx7uI0Bumjx4nlWhbzM7H0BCeWcGMV8SfesGMhrCD2aFyv9AHzlXUcq
   Ma7WU1yHsWAIPrQKZHYgtfjW72VweiejUKkvd5wrzG+zn3pjUdDRun1ET
   Q==;
X-CSE-ConnectionGUID: 7zzaZB2mQNyPG6IEQwfuFA==
X-CSE-MsgGUID: Km+tGq3zQWevEMwW3YogqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921596"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:59:18 -0700
X-CSE-ConnectionGUID: dDmUugkrTSy067GR1DywkQ==
X-CSE-MsgGUID: biC6+3stQ7ybjXN7bQdUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431970"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:59:14 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 7/7] xsk: use generic DMA sync shortcut instead of a custom one
Date: Tue, 23 Apr 2024 15:58:32 +0200
Message-ID: <20240423135832.2271696-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XSk infra's been using its own DMA sync shortcut to try avoiding
redundant function calls. Now that there is a generic one, remove
the custom implementation and rely on the generic helpers.
xsk_buff_dma_sync_for_cpu() doesn't need the second argument anymore,
remove it.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp_sock_drv.h                    |  7 ++---
 include/net/xsk_buff_pool.h                   | 14 +++-------
 drivers/net/ethernet/engleder/tsnep_main.c    |  2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-xsk.c  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 net/xdp/xsk_buff_pool.c                       | 28 ++-----------------
 13 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index c9aec9ab6191..0a5dca2b2b3f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -219,13 +219,10 @@ static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool
 	return meta;
 }
 
-static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
+static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
 
-	if (!pool->dma_need_sync)
-		return;
-
 	xp_dma_sync_for_cpu(xskb);
 }
 
@@ -402,7 +399,7 @@ static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool
 	return NULL;
 }
 
-static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
+static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
 {
 }
 
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 99dd7376df6a..bacb33f1e3e5 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -43,7 +43,6 @@ struct xsk_dma_map {
 	refcount_t users;
 	struct list_head list; /* Protected by the RTNL_LOCK */
 	u32 dma_pages_cnt;
-	bool dma_need_sync;
 };
 
 struct xsk_buff_pool {
@@ -82,7 +81,6 @@ struct xsk_buff_pool {
 	u8 tx_metadata_len; /* inherited from umem */
 	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
-	bool dma_need_sync;
 	bool unaligned;
 	bool tx_sw_csum;
 	void *addrs;
@@ -155,21 +153,17 @@ static inline dma_addr_t xp_get_frame_dma(struct xdp_buff_xsk *xskb)
 	return xskb->frame_dma;
 }
 
-void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb);
 static inline void xp_dma_sync_for_cpu(struct xdp_buff_xsk *xskb)
 {
-	xp_dma_sync_for_cpu_slow(xskb);
+	dma_sync_single_for_cpu(xskb->pool->dev, xskb->dma,
+				xskb->pool->frame_len,
+				DMA_BIDIRECTIONAL);
 }
 
-void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
-				 size_t size);
 static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
 					  dma_addr_t dma, size_t size)
 {
-	if (!pool->dma_need_sync)
-		return;
-
-	xp_dma_sync_for_device_slow(pool, dma, size);
+	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
 }
 
 /* Masks for xdp_umem_page flags.
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 4b15af6b7122..44da335d66bd 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1587,7 +1587,7 @@ static int tsnep_rx_poll_zc(struct tsnep_rx *rx, struct napi_struct *napi,
 		length = __le32_to_cpu(entry->desc_wb->properties) &
 			 TSNEP_DESC_LENGTH_MASK;
 		xsk_buff_set_size(entry->xdp, length - ETH_FCS_LEN);
-		xsk_buff_dma_sync_for_cpu(entry->xdp, rx->xsk_pool);
+		xsk_buff_dma_sync_for_cpu(entry->xdp);
 
 		/* RX metadata with timestamps is in front of actual data,
 		 * subtract metadata size to get length of actual data and
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
index 051748b997f3..a466c2379146 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c
@@ -55,7 +55,7 @@ static u32 dpaa2_xsk_run_xdp(struct dpaa2_eth_priv *priv,
 	xdp_set_data_meta_invalid(xdp_buff);
 	xdp_buff->rxq = &ch->xdp_rxq;
 
-	xsk_buff_dma_sync_for_cpu(xdp_buff, ch->xsk_pool);
+	xsk_buff_dma_sync_for_cpu(xdp_buff);
 	xdp_act = bpf_prog_run_xdp(xdp_prog, xdp_buff);
 
 	/* xdp.data pointer may have changed */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index a85b425794df..4e885df789ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -482,7 +482,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 		bi = *i40e_rx_bi(rx_ring, next_to_process);
 		xsk_buff_set_size(bi, size);
-		xsk_buff_dma_sync_for_cpu(bi, rx_ring->xsk_pool);
+		xsk_buff_dma_sync_for_cpu(bi);
 
 		if (!first)
 			first = bi;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index aa81d1162b81..7541f223bf4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -878,7 +878,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 				   ICE_RX_FLX_DESC_PKT_LEN_M;
 
 		xsk_buff_set_size(xdp, size);
-		xsk_buff_dma_sync_for_cpu(xdp, xsk_pool);
+		xsk_buff_dma_sync_for_cpu(xdp);
 
 		if (!first) {
 			first = xdp;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d9bd001af7ba..303404752deb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2812,7 +2812,7 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		}
 
 		bi->xdp->data_end = bi->xdp->data + size;
-		xsk_buff_dma_sync_for_cpu(bi->xdp, ring->xsk_pool);
+		xsk_buff_dma_sync_for_cpu(bi->xdp);
 
 		res = __igc_xdp_run_prog(adapter, prog, bi->xdp);
 		switch (res) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 397cb773fabb..3e3b471e53f0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -303,7 +303,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		}
 
 		bi->xdp->data_end = bi->xdp->data + size;
-		xsk_buff_dma_sync_for_cpu(bi->xdp, rx_ring->xsk_pool);
+		xsk_buff_dma_sync_for_cpu(bi->xdp);
 		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, bi->xdp);
 
 		if (likely(xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR))) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index b8dd74453655..1b7132fa70de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -270,7 +270,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 	/* mxbuf->rq is set on allocation, but cqe is per-packet so set it here */
 	mxbuf->cqe = cqe;
 	xsk_buff_set_size(&mxbuf->xdp, cqe_bcnt);
-	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp, rq->xsk_pool);
+	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp);
 	net_prefetch(mxbuf->xdp.data);
 
 	/* Possible flows:
@@ -319,7 +319,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 	/* mxbuf->rq is set on allocation, but cqe is per-packet so set it here */
 	mxbuf->cqe = cqe;
 	xsk_buff_set_size(&mxbuf->xdp, cqe_bcnt);
-	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp, rq->xsk_pool);
+	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp);
 	net_prefetch(mxbuf->xdp.data);
 
 	prog = rcu_dereference(rq->xdp_prog);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index d601b5faaed5..b5333da20e8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -917,7 +917,7 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq)
 
 	if (!rq->xsk_pool) {
 		count = mlx5e_refill_rx_wqes(rq, head, wqe_bulk);
-	} else if (likely(!rq->xsk_pool->dma_need_sync)) {
+	} else if (likely(!dma_dev_need_sync(rq->pdev))) {
 		mlx5e_xsk_free_rx_wqes(rq, head, wqe_bulk);
 		count = mlx5e_xsk_alloc_rx_wqes_batched(rq, head, wqe_bulk);
 	} else {
diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
index 45be6954d5aa..01cfa9cc1b5e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
@@ -184,7 +184,7 @@ nfp_nfd3_xsk_rx(struct nfp_net_rx_ring *rx_ring, int budget,
 		xrxbuf->xdp->data += meta_len;
 		xrxbuf->xdp->data_end = xrxbuf->xdp->data + pkt_len;
 		xdp_set_data_meta_invalid(xrxbuf->xdp);
-		xsk_buff_dma_sync_for_cpu(xrxbuf->xdp, r_vec->xsk_pool);
+		xsk_buff_dma_sync_for_cpu(xrxbuf->xdp);
 		net_prefetch(xrxbuf->xdp->data);
 
 		if (meta_len) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2ea9f0fa0cf9..cfda1a0956e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5354,7 +5354,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* RX buffer is good and fit into a XSK pool buffer */
 		buf->xdp->data_end = buf->xdp->data + buf1_len;
-		xsk_buff_dma_sync_for_cpu(buf->xdp, rx_q->xsk_pool);
+		xsk_buff_dma_sync_for_cpu(buf->xdp);
 
 		prog = READ_ONCE(priv->xdp_prog);
 		res = __stmmac_xdp_run_prog(priv, prog, buf->xdp);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index ce60ecd48a4d..b2cce6dbe6d8 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -338,7 +338,6 @@ static struct xsk_dma_map *xp_create_dma_map(struct device *dev, struct net_devi
 
 	dma_map->netdev = netdev;
 	dma_map->dev = dev;
-	dma_map->dma_need_sync = false;
 	dma_map->dma_pages_cnt = nr_pages;
 	refcount_set(&dma_map->users, 1);
 	list_add(&dma_map->list, &umem->xsk_dma_list);
@@ -424,7 +423,6 @@ static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_
 
 	pool->dev = dma_map->dev;
 	pool->dma_pages_cnt = dma_map->dma_pages_cnt;
-	pool->dma_need_sync = dma_map->dma_need_sync;
 	memcpy(pool->dma_pages, dma_map->dma_pages,
 	       pool->dma_pages_cnt * sizeof(*pool->dma_pages));
 
@@ -460,8 +458,6 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 			__xp_dma_unmap(dma_map, attrs);
 			return -ENOMEM;
 		}
-		if (dma_need_sync(dev, dma))
-			dma_map->dma_need_sync = true;
 		dma_map->dma_pages[i] = dma;
 	}
 
@@ -557,11 +553,8 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 	xskb->xdp.data_meta = xskb->xdp.data;
 	xskb->xdp.flags = 0;
 
-	if (pool->dma_need_sync) {
-		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
-						 pool->frame_len,
-						 DMA_BIDIRECTIONAL);
-	}
+	xp_dma_sync_for_device(pool, xskb->dma, pool->frame_len);
+
 	return &xskb->xdp;
 }
 EXPORT_SYMBOL(xp_alloc);
@@ -633,7 +626,7 @@ u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
 {
 	u32 nb_entries1 = 0, nb_entries2;
 
-	if (unlikely(pool->dma_need_sync)) {
+	if (unlikely(dma_dev_need_sync(pool->dev))) {
 		struct xdp_buff *buff;
 
 		/* Slow path */
@@ -693,18 +686,3 @@ dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr)
 		(addr & ~PAGE_MASK);
 }
 EXPORT_SYMBOL(xp_raw_get_dma);
-
-void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
-{
-	dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
-				      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
-}
-EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
-
-void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
-				 size_t size)
-{
-	dma_sync_single_range_for_device(pool->dev, dma, 0,
-					 size, DMA_BIDIRECTIONAL);
-}
-EXPORT_SYMBOL(xp_dma_sync_for_device_slow);
-- 
2.44.0


