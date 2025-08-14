Return-Path: <bpf+bounces-65651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CAB2690D
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9C81C238DA
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DED3002C3;
	Thu, 14 Aug 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o4EUZp7e"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADF2FE068;
	Thu, 14 Aug 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180253; cv=none; b=Ft1crqGz3YEM9RTWLuN2H8XXlW/MUjRU6Ny1THIs067WWXciiSWsK2XHPgLnvG9AEuhwC5Bh+9Db0lE6DOOMvKYAn1/maJQzbrjEwXLhfoMdP9rZAuhrjBK59gdTuEewjovWZk5yPLDDA2mgo6Kay+zHXdlz/76e9qDFJvFdS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180253; c=relaxed/simple;
	bh=As9vrC7IC2q8iJ9LHFF2keqpU5lN5U6mE2zKrc71Y2o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JH8c9JzCWny5W3/0pyNovUAWrVtEh6DCimvilnOpAyJWT5kaBdje3yxhoGu2vc4m0SlNbCdXuH65k6BO8b3CRYB2w8cvjB7vB955kI/UUrdvfabRW2xocxl5G+7RZn1NatcfTfz7ypcEpmR0X9qbcM1M+TAMSs9p/m1ndbGKbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o4EUZp7e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 79CEC2015E7F; Thu, 14 Aug 2025 07:04:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79CEC2015E7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755180250;
	bh=zYCT6Jet8CDRw5oxMXtwIXVigIas5OE8tAujKD9wZN0=;
	h=Date:From:To:Subject:From;
	b=o4EUZp7e7RocA31ZJR2CUP1IKEUe8S+wnOZzntoAXEPMN6WC0ra24wk60RgJ64h09
	 w7iZbcqIMLiG/BVJs9brX0ObEhE7JuTGJAC8KJHFAwu8lRPS2dFNzH1BtLoJJUXYdQ
	 NK49+fhBOiPoTWGp03kVZ9y68y01cETmuAcjRRZM=
Date: Thu, 14 Aug 2025 07:04:10 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: horms@kernel.org, kuba@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
	michal.kubiak@intel.com, ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	rosenp@gmail.com, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com, dipayanroy@microsoft.com
Subject: [PATCH net-next v5] net: mana: Use page pool fragments for RX
 buffers instead of full pages to improve memory efficiency.
Message-ID: <20250814140410.GA22089@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

This patch enhances RX buffer handling in the mana driver by allocating
pages from a page pool and slicing them into MTU-sized fragments, rather
than dedicating a full page per packet. This approach is especially
beneficial on systems with large base page sizes like 64KB.

Key improvements:

- Proper integration of page pool for RX buffer allocations.
- MTU-sized buffer slicing to improve memory utilization.
- Reduce overall per Rx queue memory footprint.
- Automatic fallback to full-page buffers when:
   * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
   * The XDP path is active, to avoid complexities with fragment reuse.

Testing on VMs with 64KB pages shows around 200% throughput improvement.
Memory efficiency is significantly improved due to reduced wastage in page
allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
page for MTU size of 1500, instead of 1 rx buffer per page previously.

Tested:

- iperf3, iperf2, and nttcp benchmarks.
- Jumbo frames with MTU 9000.
- Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
  testing the XDP path in driver.
- Memory leak detection (kmemleak).
- Driver load/unload, reboot, and stress scenarios.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
Changes in v5:
  - Switch to old_prog on allocation/reconfig failure in mana_xdp_set.
Changes in v4:
  - Better error handling in mana_xdp_set.
Changes in v3:
  - Retained the pre-alloc rxbuf for driver reconfig paths
    to better handle low memory scenario during reconfig.
Changes in v2:
  - Fixed mana_xdp_set() to return error code on failure instead of
    always returning 0.
  - Moved all local variable declarations to the start of functions
    in mana_get_rxbuf_cfg.
  - Removed unnecessary parentheses and wrapped lines to <= 80 chars.
  - Use mana_xdp_get() for checking bpf_prog.
  - Factored repeated page put/free logic into a static helper function.
---
 .../net/ethernet/microsoft/mana/mana_bpf.c    |  46 +++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 151 ++++++++++++------
 include/net/mana/mana.h                       |   4 +
 3 files changed, 150 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index d30721d4516f..7697c9b52ed3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -174,6 +174,7 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	struct bpf_prog *old_prog;
 	struct gdma_context *gc;
+	int err;
 
 	gc = apc->ac->gdma_dev->gdma_context;
 
@@ -195,11 +196,45 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	 */
 	apc->bpf_prog = prog;
 
-	if (old_prog)
-		bpf_prog_put(old_prog);
+	if (apc->port_is_up) {
+		/* Re-create rxq's after xdp prog was loaded or unloaded.
+		 * Ex: re create rxq's to switch from full pages to smaller
+		 * size page fragments when xdp prog is unloaded and
+		 * vice-versa.
+		 */
+
+		/* Pre-allocate buffers to prevent failure in mana_attach */
+		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "XDP: Insufficient memory for tx/rx re-config");
+			return err;
+		}
+
+		err = mana_detach(ndev, false);
+		if (err) {
+			netdev_err(ndev,
+				   "mana_detach failed at xdp set: %d\n", err);
+			NL_SET_ERR_MSG_MOD(extack,
+					   "XDP: Re-config failed at detach");
+			goto err_dealloc_rxbuffs;
+		}
+
+		err = mana_attach(ndev);
+		if (err) {
+			netdev_err(ndev,
+				   "mana_attach failed at xdp set: %d\n", err);
+			NL_SET_ERR_MSG_MOD(extack,
+					   "XDP: Re-config failed at attach");
+			goto err_dealloc_rxbuffs;
+		}
 
-	if (apc->port_is_up)
 		mana_chn_setxdp(apc, prog);
+		mana_pre_dealloc_rxbufs(apc);
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 	if (prog)
 		ndev->max_mtu = MANA_XDP_MTU_MAX;
@@ -207,6 +242,11 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
 
 	return 0;
+
+err_dealloc_rxbuffs:
+	apc->bpf_prog = old_prog;
+	mana_pre_dealloc_rxbufs(apc);
+	return err;
 }
 
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a7973651ae51..3efe2e696589 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -56,6 +56,15 @@ static bool mana_en_need_log(struct mana_port_context *apc, int err)
 		return true;
 }
 
+static void mana_put_rx_page(struct mana_rxq *rxq, struct page *page,
+			     bool from_pool)
+{
+	if (from_pool)
+		page_pool_put_full_page(rxq->page_pool, page, false);
+	else
+		put_page(page);
+}
+
 /* Microsoft Azure Network Adapter (MANA) functions */
 
 static int mana_open(struct net_device *ndev)
@@ -629,21 +638,40 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 }
 
 /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
-static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, u32 *alloc_size,
-			       u32 *headroom)
+static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
+			       int mtu, u32 *datasize, u32 *alloc_size,
+			       u32 *headroom, u32 *frag_count)
 {
-	if (mtu > MANA_XDP_MTU_MAX)
-		*headroom = 0; /* no support for XDP */
-	else
-		*headroom = XDP_PACKET_HEADROOM;
+	u32 len, buf_size;
 
-	*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+	/* Calculate datasize first (consistent across all cases) */
+	*datasize = mtu + ETH_HLEN;
 
-	/* Using page pool in this case, so alloc_size is PAGE_SIZE */
-	if (*alloc_size < PAGE_SIZE)
-		*alloc_size = PAGE_SIZE;
+	/* For xdp and jumbo frames make sure only one packet fits per page */
+	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
+		if (mana_xdp_get(apc)) {
+			*headroom = XDP_PACKET_HEADROOM;
+			*alloc_size = PAGE_SIZE;
+		} else {
+			*headroom = 0; /* no support for XDP */
+			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
+						     *headroom);
+		}
 
-	*datasize = mtu + ETH_HLEN;
+		*frag_count = 1;
+		return;
+	}
+
+	/* Standard MTU case - optimize for multiple packets per page */
+	*headroom = 0;
+
+	/* Calculate base buffer size needed */
+	len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+	buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
+
+	/* Calculate how many packets can fit in a page */
+	*frag_count = PAGE_SIZE / buf_size;
+	*alloc_size = buf_size;
 }
 
 int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_queues)
@@ -655,8 +683,9 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
 	void *va;
 	int i;
 
-	mana_get_rxbuf_cfg(new_mtu, &mpc->rxbpre_datasize,
-			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom);
+	mana_get_rxbuf_cfg(mpc, new_mtu, &mpc->rxbpre_datasize,
+			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom,
+			   &mpc->rxbpre_frag_count);
 
 	dev = mpc->ac->gdma_dev->gdma_context->dev;
 
@@ -1841,8 +1870,11 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 
 drop:
 	if (from_pool) {
-		page_pool_recycle_direct(rxq->page_pool,
-					 virt_to_head_page(buf_va));
+		if (rxq->frag_count == 1)
+			page_pool_recycle_direct(rxq->page_pool,
+						 virt_to_head_page(buf_va));
+		else
+			page_pool_free_va(rxq->page_pool, buf_va, true);
 	} else {
 		WARN_ON_ONCE(rxq->xdp_save_va);
 		/* Save for reuse */
@@ -1858,33 +1890,46 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 			     dma_addr_t *da, bool *from_pool)
 {
 	struct page *page;
+	u32 offset;
 	void *va;
-
 	*from_pool = false;
 
-	/* Reuse XDP dropped page if available */
-	if (rxq->xdp_save_va) {
-		va = rxq->xdp_save_va;
-		rxq->xdp_save_va = NULL;
-	} else {
-		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
+	/* Don't use fragments for jumbo frames or XDP where it's 1 fragment
+	 * per page.
+	 */
+	if (rxq->frag_count == 1) {
+		/* Reuse XDP dropped page if available */
+		if (rxq->xdp_save_va) {
+			va = rxq->xdp_save_va;
+			page = virt_to_head_page(va);
+			rxq->xdp_save_va = NULL;
+		} else {
+			page = page_pool_dev_alloc_pages(rxq->page_pool);
+			if (!page)
+				return NULL;
+
+			*from_pool = true;
+			va = page_to_virt(page);
+		}
+
+		*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
+				     DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, *da)) {
+			mana_put_rx_page(rxq, page, *from_pool);
 			return NULL;
+		}
 
-		*from_pool = true;
-		va = page_to_virt(page);
+		return va;
 	}
 
-	*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
-			     DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, *da)) {
-		if (*from_pool)
-			page_pool_put_full_page(rxq->page_pool, page, false);
-		else
-			put_page(virt_to_head_page(va));
-
+	page =  page_pool_dev_alloc_frag(rxq->page_pool, &offset,
+					 rxq->alloc_size);
+	if (!page)
 		return NULL;
-	}
+
+	va  = page_to_virt(page) + offset;
+	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
+	*from_pool = true;
 
 	return va;
 }
@@ -1901,9 +1946,9 @@ static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
 	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 	if (!va)
 		return;
-
-	dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
-			 DMA_FROM_DEVICE);
+	if (!rxoob->from_pool || rxq->frag_count == 1)
+		dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
+				 DMA_FROM_DEVICE);
 	*old_buf = rxoob->buf_va;
 	*old_fp = rxoob->from_pool;
 
@@ -2314,15 +2359,15 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		if (!rx_oob->buf_va)
 			continue;
 
-		dma_unmap_single(dev, rx_oob->sgl[0].address,
-				 rx_oob->sgl[0].size, DMA_FROM_DEVICE);
-
 		page = virt_to_head_page(rx_oob->buf_va);
 
-		if (rx_oob->from_pool)
-			page_pool_put_full_page(rxq->page_pool, page, false);
-		else
-			put_page(page);
+		if (rxq->frag_count == 1 || !rx_oob->from_pool) {
+			dma_unmap_single(dev, rx_oob->sgl[0].address,
+					 rx_oob->sgl[0].size, DMA_FROM_DEVICE);
+			mana_put_rx_page(rxq, page, rx_oob->from_pool);
+		} else {
+			page_pool_free_va(rxq->page_pool, rx_oob->buf_va, true);
+		}
 
 		rx_oob->buf_va = NULL;
 	}
@@ -2428,11 +2473,22 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	struct page_pool_params pprm = {};
 	int ret;
 
-	pprm.pool_size = mpc->rx_queue_size;
+	pprm.pool_size = mpc->rx_queue_size / rxq->frag_count + 1;
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
 	pprm.netdev = rxq->ndev;
 	pprm.order = get_order(rxq->alloc_size);
+	pprm.queue_idx = rxq->rxq_idx;
+	pprm.dev = gc->dev;
+
+	/* Let the page pool do the dma map when page sharing with multiple
+	 * fragments enabled for rx buffers.
+	 */
+	if (rxq->frag_count > 1) {
+		pprm.flags =  PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pprm.max_len = PAGE_SIZE;
+		pprm.dma_dir = DMA_FROM_DEVICE;
+	}
 
 	rxq->page_pool = page_pool_create(&pprm);
 
@@ -2471,9 +2527,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	rxq->rxq_idx = rxq_idx;
 	rxq->rxobj = INVALID_MANA_HANDLE;
 
-	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
-			   &rxq->headroom);
-
+	mana_get_rxbuf_cfg(apc, ndev->mtu, &rxq->datasize, &rxq->alloc_size,
+			   &rxq->headroom, &rxq->frag_count);
 	/* Create page pool for RX queue */
 	err = mana_create_page_pool(rxq, gc);
 	if (err) {
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index e1030a7d2daa..0921485565c0 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -65,6 +65,8 @@ enum TRI_STATE {
 #define MANA_STATS_RX_COUNT 5
 #define MANA_STATS_TX_COUNT 11
 
+#define MANA_RX_FRAG_ALIGNMENT 64
+
 struct mana_stats_rx {
 	u64 packets;
 	u64 bytes;
@@ -328,6 +330,7 @@ struct mana_rxq {
 	u32 datasize;
 	u32 alloc_size;
 	u32 headroom;
+	u32 frag_count;
 
 	mana_handle_t rxobj;
 
@@ -510,6 +513,7 @@ struct mana_port_context {
 	u32 rxbpre_datasize;
 	u32 rxbpre_alloc_size;
 	u32 rxbpre_headroom;
+	u32 rxbpre_frag_count;
 
 	struct bpf_prog *bpf_prog;
 
-- 
2.43.0


