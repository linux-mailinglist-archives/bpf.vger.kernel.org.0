Return-Path: <bpf+bounces-72927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B985C1DA7F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31907189C059
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88CC2FBDE3;
	Wed, 29 Oct 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1Fygul5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9032F12CF;
	Wed, 29 Oct 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779630; cv=none; b=szwWxn827lWeW5WSqWbw2TUV8SeSg/+15OG9J91a7AzNyZrkrx7MyyWaSHNPc7236mrUk9uS6nFgGqOOzVp8E517XEf72zZNaZyIw3ysN0UulEZ822nuZ+8yFA3Vl7i+BQ7wkDpzhFwQHrGYbLxDU7b7oYSzG6U+1ll6yDRXeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779630; c=relaxed/simple;
	bh=qfwFONSTkAI4l6LVwuW5YQcLZAPKM9vXUIXWteB5hYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7x59NVVIsBd+STL9T/VhIVxGk8NHen3ipb/X4ODuL3PUOM1fNKxawJrVIBUihVCY8KopIfLjXyFk/6YJa9pGCGtvSfNZ1SqU9KIWzgiovJ9K26GOvBNwoFj1qT4Doz5p8v+nDwqeJ6JLnVTy8y3BxKMlmXf14/yAgThJK13pSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1Fygul5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779628; x=1793315628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qfwFONSTkAI4l6LVwuW5YQcLZAPKM9vXUIXWteB5hYA=;
  b=c1Fygul5OvPzoffSM5PT0WQ5JXtd+jmW+Uj4mCiuifuMcIcJdbc031tE
   uKkm3nZoQRKib/pc+8RyBvWgvAOjqmr4JG5vMFeiex9tmGyU8/41PV4rt
   zXZreat/CMf3oeUzGj9HGQicpn2Og5yxACjaXafllytF0+1sgegAL9uHR
   eOp8vaEASZ0gNAbEkhWfLvdT+CEw9qLD3CpZxRoqBxGXrUSnLevcQOkG+
   txDv045jPvPuwja/7QNcveV//3PZl3A2xV3aQ4nyg0xU51fF7jeYIDfFZ
   BUVZ6q/Ja6EgD2u9/OxqQ2q89BrGgVqaRqICIQpFjyQCEO0JyJWP9HuMY
   Q==;
X-CSE-ConnectionGUID: D8ircEVXRNuiSW4If/h4Dg==
X-CSE-MsgGUID: KbpgGoZwQlW8ZI3QQW3AWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817604"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:46 -0700
X-CSE-ConnectionGUID: QpKg/dePRUCw91fHRns0Nw==
X-CSE-MsgGUID: ukecf599R4yvuBMhxp+W0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729689"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 2/9] ice: drop page splitting and recycling
Date: Wed, 29 Oct 2025 16:12:09 -0700
Message-ID: <20251029231218.1277233-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

As part of the transition toward Page Pool integration, remove the
legacy page splitting and recycling logic from the ice driver. This
mirrors the approach taken in commit 920d86f3c552 ("iavf: drop page
splitting and recycling").

The previous model attempted to reuse partially consumed pages by
splitting them and tracking their usage across descriptors. While
this was once a memory optimization, it introduced significant
complexity and overhead in the Rx path, including:
- Manual refcount management and page reuse heuristics;
- Per-descriptor buffer shuffling, which could involve moving dozens
  of `ice_rx_buf` structures per NAPI cycle;
- Increased branching and cache pressure in the hotpath.

This change simplifies the Rx logic by always allocating fresh pages
and letting the networking stack handle their lifecycle. Although this
may temporarily reduce performance (up to ~98% in some XDP cases), it
greatly improves maintainability and paves the way for Page Pool,
which will restore and exceed previous performance levels.

The `ice_rx_buf` array is retained for now to minimize diffstat and
ease future replacement with a shared buffer abstraction.

Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c    |  29 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 139 ++-----------------
 drivers/net/ethernet/intel/ice/ice_txrx.h    |  72 ----------
 drivers/net/ethernet/intel/ice/virt/queues.c |   5 +-
 5 files changed, 24 insertions(+), 223 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 28de4273c2e8..3d4d8b88631b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -374,6 +374,8 @@ struct ice_vsi {
 	spinlock_t arfs_lock;	/* protects aRFS hash table and filter state */
 	atomic_t *arfs_last_fltr_id;
 
+	u16 max_frame;
+
 	struct ice_aqc_vsi_props info;	 /* VSI properties */
 	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b3eb9f512500..fee58f879d9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -495,7 +495,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+	rlan_ctx.dbuf = DIV_ROUND_UP(ICE_RXBUF_3072,
 				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
@@ -536,8 +536,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Max packet size for this queue - must not be set to a larger value
 	 * than 5 x DBUF
 	 */
-	rlan_ctx.rxmax = min_t(u32, ring->max_frame,
-			       ICE_MAX_CHAINED_RX_BUFS * ring->rx_buf_len);
+	rlan_ctx.rxmax = min_t(u32, vsi->max_frame,
+			       ICE_MAX_CHAINED_RX_BUFS * ICE_RXBUF_3072);
 
 	/* Rx queue threshold in units of 64 */
 	rlan_ctx.lrxqthresh = 1;
@@ -608,7 +608,7 @@ static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
 #if (PAGE_SIZE >= 8192)
 	frame_sz = rx_ring->rx_buf_len;
 #else
-	frame_sz = ice_rx_pg_size(rx_ring) / 2;
+	frame_sz = PAGE_SIZE;
 #endif
 
 	return frame_sz;
@@ -624,6 +624,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
+	u32 rx_buf_len;
 	int err;
 
 	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
@@ -631,7 +632,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
+						 ICE_RXBUF_3072);
 			if (err)
 				return err;
 		}
@@ -640,12 +641,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		if (ring->xsk_pool) {
 			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
-			ring->rx_buf_len =
+			rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
+						 rx_buf_len);
 			if (err)
 				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -663,7 +664,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 							 ring->q_index,
 							 ring->q_vector->napi.napi_id,
-							 ring->rx_buf_len);
+							 ICE_RXBUF_3072);
 				if (err)
 					return err;
 			}
@@ -735,17 +736,9 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
 static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi, struct ice_rx_ring *ring)
 {
 	if (!vsi->netdev) {
-		ring->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		ring->rx_buf_len = ICE_RXBUF_1664;
-#if (PAGE_SIZE < 8192)
-	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
-		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		ring->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		ring->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
-#endif
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
 	} else {
-		ring->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		ring->rx_buf_len = ICE_RXBUF_3072;
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 5d59ee45d3da..2b46e4c8be86 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -543,13 +543,13 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 		 */
 		dma_sync_single_range_for_cpu(dev, rx_buf->dma,
 					      rx_buf->page_offset,
-					      rx_ring->rx_buf_len,
+					      ICE_RXBUF_3072,
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
-		dma_unmap_page_attrs(dev, rx_buf->dma, ice_rx_pg_size(rx_ring),
+		dma_unmap_page_attrs(dev, rx_buf->dma, PAGE_SIZE,
 				     DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
+		__free_page(rx_buf->page);
 
 		rx_buf->page = NULL;
 		rx_buf->page_offset = 0;
@@ -803,10 +803,6 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	struct page *page = bi->page;
 	dma_addr_t dma;
 
-	/* since we are recycling buffers we should seldom need to alloc */
-	if (likely(page))
-		return true;
-
 	/* alloc new page for storage */
 	page = dev_alloc_pages(ice_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
@@ -815,7 +811,7 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0, ice_rx_pg_size(rx_ring),
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
 				 DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
@@ -831,7 +827,6 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	bi->page = page;
 	bi->page_offset = rx_ring->rx_offset;
 	page_ref_add(page, USHRT_MAX - 1);
-	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -902,7 +897,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 		/* sync the buffer for use by the device */
 		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
 						 bi->page_offset,
-						 rx_ring->rx_buf_len,
+						 ICE_RXBUF_3072,
 						 DMA_FROM_DEVICE);
 
 		/* Refresh the desc even if buffer_addrs didn't change
@@ -931,69 +926,6 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 	return !!cleaned_count;
 }
 
-/**
- * ice_rx_buf_adjust_pg_offset - Prepare Rx buffer for reuse
- * @rx_buf: Rx buffer to adjust
- * @size: Size of adjustment
- *
- * Update the offset within page so that Rx buf will be ready to be reused.
- * For systems with PAGE_SIZE < 8192 this function will flip the page offset
- * so the second half of page assigned to Rx buffer will be used, otherwise
- * the offset is moved by "size" bytes
- */
-static void
-ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
-{
-#if (PAGE_SIZE < 8192)
-	/* flip page offset to other buffer */
-	rx_buf->page_offset ^= size;
-#else
-	/* move offset up to the next cache line */
-	rx_buf->page_offset += size;
-#endif
-}
-
-/**
- * ice_can_reuse_rx_page - Determine if page can be reused for another Rx
- * @rx_buf: buffer containing the page
- *
- * If page is reusable, we have a green light for calling ice_reuse_rx_page,
- * which will assign the current buffer to the buffer that next_to_alloc is
- * pointing to; otherwise, the DMA mapping needs to be destroyed and
- * page freed
- */
-static bool
-ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
-{
-	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
-	struct page *page = rx_buf->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-	/* if we are only owner of page we can reuse it */
-	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
-		return false;
-#if (PAGE_SIZE >= 8192)
-#define ICE_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
-	if (rx_buf->page_offset > ICE_LAST_OFFSET)
-		return false;
-#endif /* PAGE_SIZE >= 8192) */
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(pagecnt_bias == 1)) {
-		page_ref_add(page, USHRT_MAX - 1);
-		rx_buf->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
 /**
  * ice_add_xdp_frag - Add contents of Rx buffer to xdp buf as a frag
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1032,35 +964,6 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	return 0;
 }
 
-/**
- * ice_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: Rx descriptor ring to store buffers on
- * @old_buf: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- */
-static void
-ice_reuse_rx_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *old_buf)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct ice_rx_buf *new_buf;
-
-	new_buf = &rx_ring->rx_buf[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* Transfer page from old buffer to new buffer.
-	 * Move each member individually to avoid possible store
-	 * forwarding stalls and unnecessary copy of skb.
-	 */
-	new_buf->dma = old_buf->dma;
-	new_buf->page = old_buf->page;
-	new_buf->page_offset = old_buf->page_offset;
-	new_buf->pagecnt_bias = old_buf->pagecnt_bias;
-}
-
 /**
  * ice_get_rx_buf - Fetch Rx buffer and synchronize data for use
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1086,9 +989,6 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 				      rx_buf->page_offset, size,
 				      DMA_FROM_DEVICE);
 
-	/* We have pulled a buffer for use, so decrement pagecnt_bias */
-	rx_buf->pagecnt_bias--;
-
 	return rx_buf;
 }
 
@@ -1183,16 +1083,10 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	if (!rx_buf)
 		return;
 
-	if (ice_can_reuse_rx_page(rx_buf)) {
-		/* hand second half of page back to the ring */
-		ice_reuse_rx_page(rx_ring, rx_buf);
-	} else {
-		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
-				     ice_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
-				     ICE_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
-	}
+	/* we are not reusing the buffer so unmap it */
+	dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
+			     PAGE_SIZE, DMA_FROM_DEVICE,
+			     ICE_RX_DMA_ATTR);
 
 	/* clear contents of buffer_info */
 	rx_buf->page = NULL;
@@ -1218,27 +1112,12 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	u32 idx = rx_ring->first_desc;
 	u32 cnt = rx_ring->count;
 	struct ice_rx_buf *buf;
-	u32 xdp_frags = 0;
-	int i = 0;
-
-	if (unlikely(xdp_buff_has_frags(xdp)))
-		xdp_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
 
 	while (idx != ntc) {
 		buf = &rx_ring->rx_buf[idx];
 		if (++idx == cnt)
 			idx = 0;
 
-		/* An XDP program could release fragments from the end of the
-		 * buffer. For these, we need to keep the pagecnt_bias as-is.
-		 * To do this, only adjust pagecnt_bias for fragments up to
-		 * the total remaining after the XDP program has run.
-		 */
-		if (verdict != ICE_XDP_CONSUMED)
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		else if (i++ <= xdp_frags)
-			buf->pagecnt_bias++;
-
 		ice_put_rx_buf(rx_ring, buf);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 427f672fe053..3c7830f787de 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -27,71 +27,7 @@
 
 #define ICE_MAX_TXQ_PER_TXQG	128
 
-/* Attempt to maximize the headroom available for incoming frames. We use a 2K
- * buffer for MTUs <= 1500 and need 1536/1534 to store the data for the frame.
- * This leaves us with 512 bytes of room.  From that we need to deduct the
- * space needed for the shared info and the padding needed to IP align the
- * frame.
- *
- * Note: For cache line sizes 256 or larger this value is going to end
- *	 up negative.  In these cases we should fall back to the legacy
- *	 receive path.
- */
-#if (PAGE_SIZE < 8192)
-#define ICE_2K_TOO_SMALL_WITH_PADDING \
-	((unsigned int)(NET_SKB_PAD + ICE_RXBUF_1536) > \
-			SKB_WITH_OVERHEAD(ICE_RXBUF_2048))
-
-/**
- * ice_compute_pad - compute the padding
- * @rx_buf_len: buffer length
- *
- * Figure out the size of half page based on given buffer length and
- * then subtract the skb_shared_info followed by subtraction of the
- * actual buffer length; this in turn results in the actual space that
- * is left for padding usage
- */
-static inline int ice_compute_pad(int rx_buf_len)
-{
-	int half_page_size;
-
-	half_page_size = ALIGN(rx_buf_len, PAGE_SIZE / 2);
-	return SKB_WITH_OVERHEAD(half_page_size) - rx_buf_len;
-}
-
-/**
- * ice_skb_pad - determine the padding that we can supply
- *
- * Figure out the right Rx buffer size and based on that calculate the
- * padding
- */
-static inline int ice_skb_pad(void)
-{
-	int rx_buf_len;
-
-	/* If a 2K buffer cannot handle a standard Ethernet frame then
-	 * optimize padding for a 3K buffer instead of a 1.5K buffer.
-	 *
-	 * For a 3K buffer we need to add enough padding to allow for
-	 * tailroom due to NET_IP_ALIGN possibly shifting us out of
-	 * cache-line alignment.
-	 */
-	if (ICE_2K_TOO_SMALL_WITH_PADDING)
-		rx_buf_len = ICE_RXBUF_3072 + SKB_DATA_ALIGN(NET_IP_ALIGN);
-	else
-		rx_buf_len = ICE_RXBUF_1536;
-
-	/* if needed make room for NET_IP_ALIGN */
-	rx_buf_len -= NET_IP_ALIGN;
-
-	return ice_compute_pad(rx_buf_len);
-}
-
-#define ICE_SKB_PAD ice_skb_pad()
-#else
-#define ICE_2K_TOO_SMALL_WITH_PADDING false
 #define ICE_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
-#endif
 
 /* We are assuming that the cache line is always 64 Bytes here for ice.
  * In order to make sure that is a correct assumption there is a check in probe
@@ -202,7 +138,6 @@ struct ice_rx_buf {
 	struct page *page;
 	unsigned int page_offset;
 	unsigned int pgcnt;
-	unsigned int pagecnt_bias;
 };
 
 struct ice_q_stats {
@@ -368,7 +303,6 @@ struct ice_rx_ring {
 	struct ice_tx_ring *xdp_ring;
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
-	u16 max_frame;
 	u16 rx_buf_len;
 	dma_addr_t dma;			/* physical address of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
@@ -475,15 +409,9 @@ struct ice_coalesce_stored {
 
 static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
 {
-#if (PAGE_SIZE < 8192)
-	if (ring->rx_buf_len > (PAGE_SIZE / 2))
-		return 1;
-#endif
 	return 0;
 }
 
-#define ice_rx_pg_size(_ring) (PAGE_SIZE << ice_rx_pg_order(_ring))
-
 union ice_32b_rx_flex_desc;
 
 void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 370f6ec2a374..7928f4e8e788 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -842,18 +842,17 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
 				goto error_param;
-			ring->rx_buf_len = qpi->rxq.databuffer_size;
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64)
 				goto error_param;
 
-			ring->max_frame = qpi->rxq.max_pkt_size;
+			vsi->max_frame = qpi->rxq.max_pkt_size;
 			/* add space for the port VLAN since the VF driver is
 			 * not expected to account for it in the MTU
 			 * calculation
 			 */
 			if (ice_vf_is_port_vlan_ena(vf))
-				ring->max_frame += VLAN_HLEN;
+				vsi->max_frame += VLAN_HLEN;
 
 			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
 				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to configure RX queue %d\n",
-- 
2.47.1


