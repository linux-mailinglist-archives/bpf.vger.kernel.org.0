Return-Path: <bpf+bounces-64207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A4B0FABA
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809041C86152
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFD822759B;
	Wed, 23 Jul 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OilOB7zJ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73017131E2D;
	Wed, 23 Jul 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297628; cv=none; b=VQhT64tUkv4jqykHmjK0v5EZh8lW5G7KNvOHf9dOfNFbnd9Por7WcFiBpuJwQv1JTJCipH6fgcb12v1t1bMwptkLAdSG1spS0oC3WMTifUiAnL713OCY/6IYxnQAYrW7POvJzjJ/O2QAkkD3PI7msSPEC+CHZsu2aA7pL4IyezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297628; c=relaxed/simple;
	bh=CRXoHfFHJ4VG0tZrTjAYJr0scXNKajBMHF9mYJbQNLE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IH5sPi9tR0rjmhlJkmSwnDvGO+a1fODgF8+0/5+gUQviAR34WplK4tvgea6CCIMr8FiwT/cx1iSpEaOTK3dCvo2VkfG22XAsLj8kULSJMRKdHAh5jX0hy4mIqTIOEDO+g+A39GaxXzius/nQ1KoNW6githYMS0pknwo6ovKiBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OilOB7zJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 0FDC4202186D; Wed, 23 Jul 2025 12:07:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FDC4202186D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753297626;
	bh=DTviX0vfFyqMCoLY78u7546r5DpEFiV3ZG/rpxiWQ0g=;
	h=Date:From:To:Subject:From;
	b=OilOB7zJjCC4HOwQsFPwliJ5JII8uOHSnQrDFQV2alWIb6FaMgdJrAigNggLzTKCL
	 M6omAoLPXf0xPn01/O3Jpr6AkFI72eIiRYhiJL/Q42JAVF+Id+b3WqQit7OV3bSs3J
	 rbU/T69QnROQkacNE/PQUwnN1Tuj7CmFHKIl45xo=
Date: Wed, 23 Jul 2025 12:07:06 -0700
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
Subject: [PATCH v2] net: mana: Use page pool fragments for RX buffers instead
 of full pages to improve memory efficiency.
Message-ID: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
beneficial on systems with large page sizes like 64KB.

Key improvements:

- Proper integration of page pool for RX buffer allocations.
- MTU-sized buffer slicing to improve memory utilization.
- Reduce overall per Rx queue memory footprint.
- Automatic fallback to full-page buffers when:
   * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
   * The XDP path is active, to avoid complexities with fragment reuse.
- Removal of redundant pre-allocated RX buffers used in scenarios like MTU
  changes, ensuring consistency in RX buffer allocation.

Testing on VMs with 64KB pages shows around 200% throughput improvement.
Memory efficiency is significantly improved due to reduced wastage in page
allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
page for MTU size of 1500, instead of 1 rx buffer per page previously.

Tested:

- iperf3, iperf2, and nttcp benchmarks.
- Jumbo frames with MTU 9000.
- Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
  testing the XDP path in driver.
- Page leak detection (kmemleak).
- Driver load/unload, reboot, and stress scenarios.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
Changes in v2:
  - Fixed mana_xdp_set() to return error code on failure instead of
    always returning 0.
  - Moved all local variable declarations to the start of functions
    in mana_get_rxbuf_cfg.
  - Removed unnecessary parentheses and wrapped lines to <= 80 chars.
  - Use mana_xdp_get() for checking bpf_prog.
  - Factored repeated page put logic into a static helper function.
---
 .../net/ethernet/microsoft/mana/mana_bpf.c    |  25 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 286 ++++++------------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  13 -
 include/net/mana/mana.h                       |  13 +-
 4 files changed, 119 insertions(+), 218 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index d30721d4516f..f2dee2655352 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -174,6 +174,7 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	struct bpf_prog *old_prog;
 	struct gdma_context *gc;
+	int err = 0;
 
 	gc = apc->ac->gdma_dev->gdma_context;
 
@@ -198,15 +199,33 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
-	if (apc->port_is_up)
+	if (apc->port_is_up) {
+		/* Re-create rxq's after xdp prog was loaded or unloaded.
+		 * Ex: re create rxq's to switch from full pages to smaller
+		 * size page fragments when xdp prog is unloaded and vice-versa.
+		 */
+
+		err = mana_detach(ndev, false);
+		if (err) {
+			netdev_err(ndev, "mana_detach failed at xdp set: %d\n", err);
+			goto out;
+		}
+
+		err = mana_attach(ndev);
+		if (err) {
+			netdev_err(ndev, "mana_attach failed at xdp set: %d\n", err);
+			goto out;
+		}
+
 		mana_chn_setxdp(apc, prog);
+	}
 
 	if (prog)
 		ndev->max_mtu = MANA_XDP_MTU_MAX;
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
-
-	return 0;
+out:
+	return err;
 }
 
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a7973651ae51..9276833e434b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -56,6 +56,14 @@ static bool mana_en_need_log(struct mana_port_context *apc, int err)
 		return true;
 }
 
+static void mana_put_rx_page(struct mana_rxq *rxq, struct page *page, bool from_pool)
+{
+	if (from_pool)
+		page_pool_put_full_page(rxq->page_pool, page, false);
+	else
+		put_page(page);
+}
+
 /* Microsoft Azure Network Adapter (MANA) functions */
 
 static int mana_open(struct net_device *ndev)
@@ -548,171 +556,48 @@ static u16 mana_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return txq;
 }
 
-/* Release pre-allocated RX buffers */
-void mana_pre_dealloc_rxbufs(struct mana_port_context *mpc)
-{
-	struct device *dev;
-	int i;
-
-	dev = mpc->ac->gdma_dev->gdma_context->dev;
-
-	if (!mpc->rxbufs_pre)
-		goto out1;
-
-	if (!mpc->das_pre)
-		goto out2;
-
-	while (mpc->rxbpre_total) {
-		i = --mpc->rxbpre_total;
-		dma_unmap_single(dev, mpc->das_pre[i], mpc->rxbpre_datasize,
-				 DMA_FROM_DEVICE);
-		put_page(virt_to_head_page(mpc->rxbufs_pre[i]));
-	}
-
-	kfree(mpc->das_pre);
-	mpc->das_pre = NULL;
-
-out2:
-	kfree(mpc->rxbufs_pre);
-	mpc->rxbufs_pre = NULL;
-
-out1:
-	mpc->rxbpre_datasize = 0;
-	mpc->rxbpre_alloc_size = 0;
-	mpc->rxbpre_headroom = 0;
-}
-
-/* Get a buffer from the pre-allocated RX buffers */
-static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
-{
-	struct net_device *ndev = rxq->ndev;
-	struct mana_port_context *mpc;
-	void *va;
-
-	mpc = netdev_priv(ndev);
-
-	if (!mpc->rxbufs_pre || !mpc->das_pre || !mpc->rxbpre_total) {
-		netdev_err(ndev, "No RX pre-allocated bufs\n");
-		return NULL;
-	}
-
-	/* Check sizes to catch unexpected coding error */
-	if (mpc->rxbpre_datasize != rxq->datasize) {
-		netdev_err(ndev, "rxbpre_datasize mismatch: %u: %u\n",
-			   mpc->rxbpre_datasize, rxq->datasize);
-		return NULL;
-	}
-
-	if (mpc->rxbpre_alloc_size != rxq->alloc_size) {
-		netdev_err(ndev, "rxbpre_alloc_size mismatch: %u: %u\n",
-			   mpc->rxbpre_alloc_size, rxq->alloc_size);
-		return NULL;
-	}
-
-	if (mpc->rxbpre_headroom != rxq->headroom) {
-		netdev_err(ndev, "rxbpre_headroom mismatch: %u: %u\n",
-			   mpc->rxbpre_headroom, rxq->headroom);
-		return NULL;
-	}
-
-	mpc->rxbpre_total--;
-
-	*da = mpc->das_pre[mpc->rxbpre_total];
-	va = mpc->rxbufs_pre[mpc->rxbpre_total];
-	mpc->rxbufs_pre[mpc->rxbpre_total] = NULL;
-
-	/* Deallocate the array after all buffers are gone */
-	if (!mpc->rxbpre_total)
-		mana_pre_dealloc_rxbufs(mpc);
-
-	return va;
-}
-
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
-
-	*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
-
-	/* Using page pool in this case, so alloc_size is PAGE_SIZE */
-	if (*alloc_size < PAGE_SIZE)
-		*alloc_size = PAGE_SIZE;
+	u32 len, buf_size;
 
+	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
-}
-
-int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_queues)
-{
-	struct device *dev;
-	struct page *page;
-	dma_addr_t da;
-	int num_rxb;
-	void *va;
-	int i;
-
-	mana_get_rxbuf_cfg(new_mtu, &mpc->rxbpre_datasize,
-			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom);
-
-	dev = mpc->ac->gdma_dev->gdma_context->dev;
-
-	num_rxb = num_queues * mpc->rx_queue_size;
-
-	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
-	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
-	if (!mpc->rxbufs_pre)
-		goto error;
-
-	mpc->das_pre = kmalloc_array(num_rxb, sizeof(dma_addr_t), GFP_KERNEL);
-	if (!mpc->das_pre)
-		goto error;
-
-	mpc->rxbpre_total = 0;
-
-	for (i = 0; i < num_rxb; i++) {
-		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
-		if (!page)
-			goto error;
 
-		va = page_to_virt(page);
-
-		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
-				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
-		if (dma_mapping_error(dev, da)) {
-			put_page(page);
-			goto error;
+	/* For xdp and jumbo frames make sure only one packet fits per page */
+	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
+		if (mana_xdp_get(apc)) {
+			*headroom = XDP_PACKET_HEADROOM;
+			*alloc_size = PAGE_SIZE;
+		} else {
+			*headroom = 0; /* no support for XDP */
+			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
+						     *headroom);
 		}
 
-		mpc->rxbufs_pre[i] = va;
-		mpc->das_pre[i] = da;
-		mpc->rxbpre_total = i + 1;
+		*frag_count = 1;
+		return;
 	}
 
-	return 0;
+	/* Standard MTU case - optimize for multiple packets per page */
+	*headroom = 0;
 
-error:
-	netdev_err(mpc->ndev, "Failed to pre-allocate RX buffers for %d queues\n", num_queues);
-	mana_pre_dealloc_rxbufs(mpc);
-	return -ENOMEM;
+	/* Calculate base buffer size needed */
+	len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+	buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
+
+	/* Calculate how many packets can fit in a page */
+	*frag_count = PAGE_SIZE / buf_size;
+	*alloc_size = buf_size;
 }
 
 static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 {
-	struct mana_port_context *mpc = netdev_priv(ndev);
 	unsigned int old_mtu = ndev->mtu;
 	int err;
 
-	/* Pre-allocate buffers to prevent failure in mana_attach later */
-	err = mana_pre_alloc_rxbufs(mpc, new_mtu, mpc->num_queues);
-	if (err) {
-		netdev_err(ndev, "Insufficient memory for new MTU\n");
-		return err;
-	}
-
 	err = mana_detach(ndev, false);
 	if (err) {
 		netdev_err(ndev, "mana_detach failed: %d\n", err);
@@ -728,7 +613,6 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 out:
-	mana_pre_dealloc_rxbufs(mpc);
 	return err;
 }
 
@@ -1841,8 +1725,11 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 
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
@@ -1854,37 +1741,47 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	return;
 }
 
-static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool *from_pool)
+static void *mana_get_rxfrag(struct mana_rxq *rxq,
+			     struct device *dev, dma_addr_t *da, bool *from_pool)
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
+	/* Don't use fragments for jumbo frames or XDP (i.e when fragment = 1 per page) */
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
+	page =  page_pool_dev_alloc_frag(rxq->page_pool, &offset, rxq->alloc_size);
+	if (!page)
 		return NULL;
-	}
+
+	va  = page_to_virt(page) + offset;
+	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
+	*from_pool = true;
 
 	return va;
 }
@@ -1901,9 +1798,9 @@ static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
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
 
@@ -2314,15 +2211,15 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
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
+		if (rxq->frag_count == 1) {
+			dma_unmap_single(dev, rx_oob->sgl[0].address, rx_oob->sgl[0].size,
+					 DMA_FROM_DEVICE);
+			mana_put_rx_page(rxq, page, rx_oob->from_pool);
+		} else {
+			page_pool_free_va(rxq->page_pool, rx_oob->buf_va, true);
+		}
 
 		rx_oob->buf_va = NULL;
 	}
@@ -2338,16 +2235,11 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 			    struct mana_rxq *rxq, struct device *dev)
 {
-	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
 	bool from_pool = false;
 	dma_addr_t da;
 	void *va;
 
-	if (mpc->rxbufs_pre)
-		va = mana_get_rxbuf_pre(rxq, &da);
-	else
-		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
-
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 	if (!va)
 		return -ENOMEM;
 
@@ -2428,11 +2320,22 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
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
+	/* Let the page pool do the dma map when page sharing with multiple fragments
+	 * enabled for rx buffers.
+	 */
+	if (rxq->frag_count > 1) {
+		pprm.flags =  PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pprm.max_len = PAGE_SIZE;
+		pprm.dma_dir = DMA_FROM_DEVICE;
+	}
 
 	rxq->page_pool = page_pool_create(&pprm);
 
@@ -2471,9 +2374,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
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
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index a1afa75a9463..7ede03c74fb9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -396,12 +396,6 @@ static int mana_set_channels(struct net_device *ndev,
 	unsigned int old_count = apc->num_queues;
 	int err;
 
-	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
-	if (err) {
-		netdev_err(ndev, "Insufficient memory for new allocations");
-		return err;
-	}
-
 	err = mana_detach(ndev, false);
 	if (err) {
 		netdev_err(ndev, "mana_detach failed: %d\n", err);
@@ -416,7 +410,6 @@ static int mana_set_channels(struct net_device *ndev,
 	}
 
 out:
-	mana_pre_dealloc_rxbufs(apc);
 	return err;
 }
 
@@ -465,12 +458,7 @@ static int mana_set_ringparam(struct net_device *ndev,
 
 	/* pre-allocating new buffers to prevent failures in mana_attach() later */
 	apc->rx_queue_size = new_rx;
-	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
 	apc->rx_queue_size = old_rx;
-	if (err) {
-		netdev_err(ndev, "Insufficient memory for new allocations\n");
-		return err;
-	}
 
 	err = mana_detach(ndev, false);
 	if (err) {
@@ -488,7 +476,6 @@ static int mana_set_ringparam(struct net_device *ndev,
 		apc->rx_queue_size = old_rx;
 	}
 out:
-	mana_pre_dealloc_rxbufs(apc);
 	return err;
 }
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index e1030a7d2daa..99a3847b0f9d 100644
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
 
@@ -503,14 +506,6 @@ struct mana_port_context {
 	/* This points to an array of num_queues of RQ pointers. */
 	struct mana_rxq **rxqs;
 
-	/* pre-allocated rx buffer array */
-	void **rxbufs_pre;
-	dma_addr_t *das_pre;
-	int rxbpre_total;
-	u32 rxbpre_datasize;
-	u32 rxbpre_alloc_size;
-	u32 rxbpre_headroom;
-
 	struct bpf_prog *bpf_prog;
 
 	/* Create num_queues EQs, SQs, SQ-CQs, RQs and RQ-CQs, respectively. */
@@ -574,8 +569,6 @@ int mana_query_link_cfg(struct mana_port_context *apc);
 int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 		      int enable_clamping);
 void mana_query_phy_stats(struct mana_port_context *apc);
-int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
-void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
 extern struct dentry *mana_debugfs_root;
-- 
2.43.0


