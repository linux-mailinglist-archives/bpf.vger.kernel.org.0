Return-Path: <bpf+bounces-48017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A74A03290
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCAB16494B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2171DF984;
	Mon,  6 Jan 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9UtCuSX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14F1E1020;
	Mon,  6 Jan 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201981; cv=none; b=lq8kk1H3q8YyA25NvlMb+TX355CTVbAFjZfj9wCLLOKGsAUtxHrvLChgbDcuB7zgwvYnFJmrhBj+R+0DUcKSGdjw/E5hhQuyG84HvkaQGbVmnHXP+xvI++RdTxTaoawC1pgMZYPHxbcUYuSnk49blHPKs1IfPvKZDN7wEAnDT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201981; c=relaxed/simple;
	bh=t5V3SI+CdUMHRl06R6+s9ey9W/Hl47wQn24aQLL4dyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csShuGDz++Gi/PKv1tRA0qIfmcm9+jrKtRmQWpM6AT9U9jvF3ObPGn4hfVxNSG8P5jDJSYxcxOFkBaglb49Q/8OEqIsidT3xRcMaEdMJ+0f6jGAI9Xz+dG4OZ4SZkALnDXQQzaUIWLWAkXjRdUdE5ulPcqSNAcCNJoVe+nwjt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9UtCuSX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201980; x=1767737980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t5V3SI+CdUMHRl06R6+s9ey9W/Hl47wQn24aQLL4dyQ=;
  b=m9UtCuSX/dYEbgXBINYWsiJLFNpNjMWtkohMTmTnSBKJsH1NbvidX+4S
   Vdy2blzwWYAS8Qff1rK3VKG5aO8r6gHPujKb6bGBRz3Fx8qf3JtHr/RLB
   hy1iKfpwqtoPcVW1PRUbPxlApuRNf1+1MPOnIYzh9iCuJazpowJdRTNRh
   WVIABemaUcfgOoqQjq5hkA45HTDfWGaZZjzC+MvQCWr6MaIJwN7pEWvGs
   qLtWBvXUOe5m7mKj9uQOyQ75AQg9zRcLUcsu0vxaqtraEdLqGUD8rPCch
   QNW+QrySFXYqAXeeVf19Zxw+AySJbf2vuwi59fPHo3pK6QD2t29H107go
   g==;
X-CSE-ConnectionGUID: h+6VbfRtQ3uztC4a0iSRkQ==
X-CSE-MsgGUID: 94nZcHc4SSuABEEpertGyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858689"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858689"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:38 -0800
X-CSE-ConnectionGUID: +X0dUqhQQ+W53XdEXpD7fw==
X-CSE-MsgGUID: 5IBZJC0sQ0CGEoDvXjKFDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368463"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
	richardcochran@gmail.com,
	benjamin.steinke@woks-audio.com,
	bigeasy@linutronix.de,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Subject: [PATCH net-next 05/15] igb: Add AF_XDP zero-copy Rx support
Date: Mon,  6 Jan 2025 14:19:13 -0800
Message-ID: <20250106221929.956999-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Add support for AF_XDP zero-copy receive path.

When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
xsk buff pool using igb_alloc_rx_buffers_zc().

Use xsk_pool_get_rx_frame_size() to set SRRCTL rx buf size when zero-copy
is enabled.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Port to v6.12 and provide napi_id for xdp_rxq_info_reg(),
       RCT, remove NETDEV_XDP_ACT_XSK_ZEROCOPY, update NTC handling,
       READ_ONCE() xsk_pool, likelyfy for XDP_REDIRECT case]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |   6 +
 drivers/net/ethernet/intel/igb/igb_main.c |  79 ++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 294 +++++++++++++++++++++-
 3 files changed, 360 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1e65b41a48d8..e4a85867aa18 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -88,6 +88,7 @@ struct igb_adapter;
 #define IGB_XDP_CONSUMED	BIT(0)
 #define IGB_XDP_TX		BIT(1)
 #define IGB_XDP_REDIR		BIT(2)
+#define IGB_XDP_EXIT		BIT(3)
 
 struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
@@ -853,6 +854,11 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		       struct xsk_buff_pool *pool,
 		       u16 qid);
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
+			     struct xsk_buff_pool *xsk_pool, u16 count);
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
+			struct xsk_buff_pool *xsk_pool, const int budget);
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index be914b44e39d..b478b7818adb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
 
 		for (i = 0; i < rx_ring->count; i++) {
 			const char *next_desc;
-			struct igb_rx_buffer *buffer_info;
-			buffer_info = &rx_ring->rx_buffer_info[i];
+			dma_addr_t dma = (dma_addr_t)0;
+			struct igb_rx_buffer *buffer_info = NULL;
 			rx_desc = IGB_RX_DESC(rx_ring, i);
 			u0 = (struct my_u0 *)rx_desc;
 			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
 
+			if (!rx_ring->xsk_pool) {
+				buffer_info = &rx_ring->rx_buffer_info[i];
+				dma = buffer_info->dma;
+			}
+
 			if (i == rx_ring->next_to_use)
 				next_desc = " NTU";
 			else if (i == rx_ring->next_to_clean)
@@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
 					"R  ", i,
 					le64_to_cpu(u0->a),
 					le64_to_cpu(u0->b),
-					(u64)buffer_info->dma,
+					(u64)dma,
 					next_desc);
 
 				if (netif_msg_pktdata(adapter) &&
-				    buffer_info->dma && buffer_info->page) {
+				    buffer_info && dma && buffer_info->page) {
 					print_hex_dump(KERN_INFO, "",
 					  DUMP_PREFIX_ADDRESS,
 					  16, 1,
@@ -1987,7 +1992,11 @@ static void igb_configure(struct igb_adapter *adapter)
 	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
-		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
+		if (ring->xsk_pool)
+			igb_alloc_rx_buffers_zc(ring, ring->xsk_pool,
+						igb_desc_unused(ring));
+		else
+			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
 	}
 }
 
@@ -4409,7 +4418,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-			       rx_ring->queue_index, 0);
+			       rx_ring->queue_index,
+			       rx_ring->q_vector->napi.napi_id);
 	if (res < 0) {
 		dev_err(dev, "Failed to register xdp_rxq index %u\n",
 			rx_ring->queue_index);
@@ -4705,12 +4715,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
 	struct e1000_hw *hw = &adapter->hw;
 	int reg_idx = ring->reg_idx;
 	u32 srrctl = 0;
+	u32 buf_size;
 
-	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	if (ring_uses_large_buffer(ring))
-		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+	if (ring->xsk_pool)
+		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+	else if (ring_uses_large_buffer(ring))
+		buf_size = IGB_RXBUFFER_3072;
 	else
-		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+		buf_size = IGB_RXBUFFER_2048;
+
+	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
+	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
 	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
 	if (hw->mac.type >= e1000_82580)
 		srrctl |= E1000_SRRCTL_TIMESTAMP;
@@ -4742,9 +4757,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	u32 rxdctl = 0;
 
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
-	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					   MEM_TYPE_PAGE_SHARED, NULL));
 	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
+	if (ring->xsk_pool) {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_XSK_BUFF_POOL,
+						   NULL));
+		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
+	} else {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_PAGE_SHARED,
+						   NULL));
+	}
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
@@ -4771,9 +4794,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	rxdctl |= IGB_RX_HTHRESH << 8;
 	rxdctl |= IGB_RX_WTHRESH << 16;
 
-	/* initialize rx_buffer_info */
-	memset(ring->rx_buffer_info, 0,
-	       sizeof(struct igb_rx_buffer) * ring->count);
+	if (ring->xsk_pool)
+		memset(ring->rx_buffer_info_zc, 0,
+		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
+	else
+		memset(ring->rx_buffer_info, 0,
+		       sizeof(*ring->rx_buffer_info) * ring->count);
 
 	/* initialize Rx descriptor 0 */
 	rx_desc = IGB_RX_DESC(ring, 0);
@@ -4961,8 +4987,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
 
 	rx_ring->xdp_prog = NULL;
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	vfree(rx_ring->rx_buffer_info);
-	rx_ring->rx_buffer_info = NULL;
+	if (rx_ring->xsk_pool) {
+		vfree(rx_ring->rx_buffer_info_zc);
+		rx_ring->rx_buffer_info_zc = NULL;
+	} else {
+		vfree(rx_ring->rx_buffer_info);
+		rx_ring->rx_buffer_info = NULL;
+	}
 
 	/* if not set, then don't free */
 	if (!rx_ring->desc)
@@ -5000,6 +5031,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 	dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;
 
+	if (rx_ring->xsk_pool) {
+		igb_clean_rx_ring_zc(rx_ring);
+		goto skip_for_xsk;
+	}
+
 	/* Free all the Rx ring sk_buffs */
 	while (i != rx_ring->next_to_alloc) {
 		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
@@ -5027,6 +5063,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 			i = 0;
 	}
 
+skip_for_xsk:
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -8181,6 +8218,7 @@ static int igb_poll(struct napi_struct *napi, int budget)
 	struct igb_q_vector *q_vector = container_of(napi,
 						     struct igb_q_vector,
 						     napi);
+	struct xsk_buff_pool *xsk_pool;
 	bool clean_complete = true;
 	int work_done = 0;
 
@@ -8192,7 +8230,12 @@ static int igb_poll(struct napi_struct *napi, int budget)
 		clean_complete = igb_clean_tx_irq(q_vector, budget);
 
 	if (q_vector->rx.ring) {
-		int cleaned = igb_clean_rx_irq(q_vector, budget);
+		int cleaned;
+
+		xsk_pool = READ_ONCE(q_vector->rx.ring->xsk_pool);
+		cleaned = xsk_pool ?
+			igb_clean_rx_irq_zc(q_vector, xsk_pool, budget) :
+			igb_clean_rx_irq(q_vector, budget);
 
 		work_done += cleaned;
 		if (cleaned >= budget)
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 7b632be3e7e3..3d64a9f6360c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -70,7 +70,11 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 	 * at least 1 descriptor unused to make sure
 	 * next_to_use != next_to_clean
 	 */
-	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+	if (rx_ring->xsk_pool)
+		igb_alloc_rx_buffers_zc(rx_ring, rx_ring->xsk_pool,
+					igb_desc_unused(rx_ring));
+	else
+		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
 
 	/* Rx/Tx share the same napi context. */
 	napi_enable(&rx_ring->q_vector->napi);
@@ -169,6 +173,294 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		igb_xsk_pool_disable(adapter, qid);
 }
 
+static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
+			     union e1000_adv_rx_desc *rx_desc, u16 count)
+{
+	dma_addr_t dma;
+	u16 buffs;
+	int i;
+
+	/* nothing to do */
+	if (!count)
+		return 0;
+
+	buffs = xsk_buff_alloc_batch(pool, xdp, count);
+	for (i = 0; i < buffs; i++) {
+		dma = xsk_buff_xdp_get_dma(*xdp);
+		rx_desc->read.pkt_addr = cpu_to_le64(dma);
+		rx_desc->wb.upper.length = 0;
+
+		rx_desc++;
+		xdp++;
+	}
+
+	return buffs;
+}
+
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
+			     struct xsk_buff_pool *xsk_pool, u16 count)
+{
+	u32 nb_buffs_extra = 0, nb_buffs = 0;
+	union e1000_adv_rx_desc *rx_desc;
+	u16 ntu = rx_ring->next_to_use;
+	u16 total_count = count;
+	struct xdp_buff **xdp;
+
+	rx_desc = IGB_RX_DESC(rx_ring, ntu);
+	xdp = &rx_ring->rx_buffer_info_zc[ntu];
+
+	if (ntu + count >= rx_ring->count) {
+		nb_buffs_extra = igb_fill_rx_descs(xsk_pool, xdp, rx_desc,
+						   rx_ring->count - ntu);
+		if (nb_buffs_extra != rx_ring->count - ntu) {
+			ntu += nb_buffs_extra;
+			goto exit;
+		}
+		rx_desc = IGB_RX_DESC(rx_ring, 0);
+		xdp = rx_ring->rx_buffer_info_zc;
+		ntu = 0;
+		count -= nb_buffs_extra;
+	}
+
+	nb_buffs = igb_fill_rx_descs(xsk_pool, xdp, rx_desc, count);
+	ntu += nb_buffs;
+	if (ntu == rx_ring->count)
+		ntu = 0;
+
+	/* clear the length for the next_to_use descriptor */
+	rx_desc = IGB_RX_DESC(rx_ring, ntu);
+	rx_desc->wb.upper.length = 0;
+
+exit:
+	if (rx_ring->next_to_use != ntu) {
+		rx_ring->next_to_use = ntu;
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64).
+		 */
+		wmb();
+		writel(ntu, rx_ring->tail);
+	}
+
+	return total_count == (nb_buffs + nb_buffs_extra);
+}
+
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
+{
+	u16 ntc = rx_ring->next_to_clean;
+	u16 ntu = rx_ring->next_to_use;
+
+	while (ntc != ntu) {
+		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
+
+		xsk_buff_free(xdp);
+		ntc++;
+		if (ntc >= rx_ring->count)
+			ntc = 0;
+	}
+}
+
+static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
+					    struct xdp_buff *xdp,
+					    ktime_t timestamp)
+{
+	unsigned int totalsize = xdp->data_end - xdp->data_meta;
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+
+	net_prefetch(xdp->data_meta);
+
+	/* allocate a skb to store the frags */
+	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
+	if (unlikely(!skb))
+		return NULL;
+
+	if (timestamp)
+		skb_hwtstamps(skb)->hwtstamp = timestamp;
+
+	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
+	       ALIGN(totalsize, sizeof(long)));
+
+	if (metasize) {
+		skb_metadata_set(skb, metasize);
+		__skb_pull(skb, metasize);
+	}
+
+	return skb;
+}
+
+static int igb_run_xdp_zc(struct igb_adapter *adapter, struct igb_ring *rx_ring,
+			  struct xdp_buff *xdp, struct xsk_buff_pool *xsk_pool,
+			  struct bpf_prog *xdp_prog)
+{
+	int err, result = IGB_XDP_PASS;
+	u32 act;
+
+	prefetchw(xdp->data_hard_start); /* xdp_frame write */
+
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+
+	if (likely(act == XDP_REDIRECT)) {
+		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
+		if (!err)
+			return IGB_XDP_REDIR;
+
+		if (xsk_uses_need_wakeup(xsk_pool) &&
+		    err == -ENOBUFS)
+			result = IGB_XDP_EXIT;
+		else
+			result = IGB_XDP_CONSUMED;
+		goto out_failure;
+	}
+
+	switch (act) {
+	case XDP_PASS:
+		break;
+	case XDP_TX:
+		result = igb_xdp_xmit_back(adapter, xdp);
+		if (result == IGB_XDP_CONSUMED)
+			goto out_failure;
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+out_failure:
+		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		result = IGB_XDP_CONSUMED;
+		break;
+	}
+
+	return result;
+}
+
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
+			struct xsk_buff_pool *xsk_pool, const int budget)
+{
+	struct igb_adapter *adapter = q_vector->adapter;
+	unsigned int total_bytes = 0, total_packets = 0;
+	struct igb_ring *rx_ring = q_vector->rx.ring;
+	u32 ntc = rx_ring->next_to_clean;
+	struct bpf_prog *xdp_prog;
+	unsigned int xdp_xmit = 0;
+	bool failure = false;
+	u16 entries_to_alloc;
+	struct sk_buff *skb;
+
+	/* xdp_prog cannot be NULL in the ZC path */
+	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+
+	while (likely(total_packets < budget)) {
+		union e1000_adv_rx_desc *rx_desc;
+		ktime_t timestamp = 0;
+		struct xdp_buff *xdp;
+		unsigned int size;
+		int xdp_res = 0;
+
+		rx_desc = IGB_RX_DESC(rx_ring, ntc);
+		size = le16_to_cpu(rx_desc->wb.upper.length);
+		if (!size)
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		dma_rmb();
+
+		xdp = rx_ring->rx_buffer_info_zc[ntc];
+		xsk_buff_set_size(xdp, size);
+		xsk_buff_dma_sync_for_cpu(xdp);
+
+		/* pull rx packet timestamp if available and valid */
+		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+			int ts_hdr_len;
+
+			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
+							 xdp->data,
+							 &timestamp);
+
+			xdp->data += ts_hdr_len;
+			xdp->data_meta += ts_hdr_len;
+			size -= ts_hdr_len;
+		}
+
+		xdp_res = igb_run_xdp_zc(adapter, rx_ring, xdp, xsk_pool,
+					 xdp_prog);
+
+		if (xdp_res) {
+			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
+				xdp_xmit |= xdp_res;
+			} else if (xdp_res == IGB_XDP_EXIT) {
+				failure = true;
+				break;
+			} else if (xdp_res == IGB_XDP_CONSUMED) {
+				xsk_buff_free(xdp);
+			}
+
+			total_packets++;
+			total_bytes += size;
+			ntc++;
+			if (ntc == rx_ring->count)
+				ntc = 0;
+			continue;
+		}
+
+		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
+
+		/* exit if we failed to retrieve a buffer */
+		if (!skb) {
+			rx_ring->rx_stats.alloc_failed++;
+			break;
+		}
+
+		xsk_buff_free(xdp);
+		ntc++;
+		if (ntc == rx_ring->count)
+			ntc = 0;
+
+		if (eth_skb_pad(skb))
+			continue;
+
+		/* probably a little skewed due to removing CRC */
+		total_bytes += skb->len;
+
+		/* populate checksum, timestamp, VLAN, and protocol */
+		igb_process_skb_fields(rx_ring, rx_desc, skb);
+
+		napi_gro_receive(&q_vector->napi, skb);
+
+		/* update budget accounting */
+		total_packets++;
+	}
+
+	rx_ring->next_to_clean = ntc;
+
+	if (xdp_xmit)
+		igb_finalize_xdp(adapter, xdp_xmit);
+
+	igb_update_rx_stats(q_vector, total_packets, total_bytes);
+
+	entries_to_alloc = igb_desc_unused(rx_ring);
+	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
+		failure |= !igb_alloc_rx_buffers_zc(rx_ring, xsk_pool,
+						    entries_to_alloc);
+
+	if (xsk_uses_need_wakeup(xsk_pool)) {
+		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+			xsk_set_rx_need_wakeup(xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(xsk_pool);
+
+		return (int)total_packets;
+	}
+	return failure ? budget : (int)total_packets;
+}
+
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
-- 
2.47.1


