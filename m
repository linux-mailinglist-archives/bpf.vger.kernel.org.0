Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E99350C5D
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 04:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhDACIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 22:08:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:22177 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233167AbhDACID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 22:08:03 -0400
IronPort-SDR: IkEPhQvYiu9IDjOxdi2MDT5c0o6hz6eic7A33P7WGkSmljUIuxu8DF6FFiUWYISDqrIHyXfEba
 /3wmotAv5KZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="172163672"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="172163672"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 19:08:02 -0700
IronPort-SDR: zcu4Yn+LhyRi83eGTXv95/rznlWErmfLk8y7c60WNPm8OfwiwzTBka8CHKReuLXcpCZ7R/p5WN
 4y32HrWKfV6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="528004267"
Received: from glass.png.intel.com ([10.158.65.59])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2021 19:07:57 -0700
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Ong Boon Leong <boon.leong.ong@intel.com>
Subject: [PATCH net-next v4 5/6] net: stmmac: Add support for XDP_TX action
Date:   Thu,  1 Apr 2021 10:11:16 +0800
Message-Id: <20210401021117.13360-6-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401021117.13360-1-boon.leong.ong@intel.com>
References: <20210401021117.13360-1-boon.leong.ong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support for XDP_TX action which enables XDP program to
transmit back received frames.

This patch has been tested with the "xdp2" app located in samples/bpf
dir. The DUT receives burst traffic packet generated using pktgen script
'pktgen_sample03_burst_single_flow.sh'.

v4: Moved stmmac_tx_timer_arm() to be done once at the end of NAPI RX.
    Fixed stmmac_xdp_xmit_back() to return STMMAC_XDP_CONSUMED if
    XDP buffer to frame conversion fails. Thanks to Jakub's input.

v3: Added 'nq->trans_start = jiffies' to avoid TX time-out as we are
    sharing TX queue between slow path and XDP. Thanks to Jakub Kicinski
    for pointing out.

Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  12 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 238 ++++++++++++++++--
 2 files changed, 232 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index e72224c8fbac..a93e22a6be59 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -36,12 +36,18 @@ struct stmmac_resources {
 	int tx_irq[MTL_MAX_TX_QUEUES];
 };
 
+enum stmmac_txbuf_type {
+	STMMAC_TXBUF_T_SKB,
+	STMMAC_TXBUF_T_XDP_TX,
+};
+
 struct stmmac_tx_info {
 	dma_addr_t buf;
 	bool map_as_page;
 	unsigned len;
 	bool last_segment;
 	bool is_jumbo;
+	enum stmmac_txbuf_type buf_type;
 };
 
 #define STMMAC_TBS_AVAIL	BIT(0)
@@ -57,7 +63,10 @@ struct stmmac_tx_queue {
 	struct dma_extended_desc *dma_etx ____cacheline_aligned_in_smp;
 	struct dma_edesc *dma_entx;
 	struct dma_desc *dma_tx;
-	struct sk_buff **tx_skbuff;
+	union {
+		struct sk_buff **tx_skbuff;
+		struct xdp_frame **xdpf;
+	};
 	struct stmmac_tx_info *tx_skbuff_dma;
 	unsigned int cur_tx;
 	unsigned int dirty_tx;
@@ -77,6 +86,7 @@ struct stmmac_rx_buffer {
 struct stmmac_rx_queue {
 	u32 rx_count_frames;
 	u32 queue_index;
+	struct xdp_rxq_info xdp_rxq;
 	struct page_pool *page_pool;
 	struct stmmac_rx_buffer *buf_pool;
 	struct stmmac_priv *priv_data;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0dad8ab93eb5..65163b51f8ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -71,6 +71,7 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");
 
 #define STMMAC_XDP_PASS		0
 #define STMMAC_XDP_CONSUMED	BIT(0)
+#define STMMAC_XDP_TX		BIT(1)
 
 static int flow_ctrl = FLOW_AUTO;
 module_param(flow_ctrl, int, 0644);
@@ -1442,7 +1443,8 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv, u32 queue, int i)
 {
 	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
 
-	if (tx_q->tx_skbuff_dma[i].buf) {
+	if (tx_q->tx_skbuff_dma[i].buf &&
+	    tx_q->tx_skbuff_dma[i].buf_type != STMMAC_TXBUF_T_XDP_TX) {
 		if (tx_q->tx_skbuff_dma[i].map_as_page)
 			dma_unmap_page(priv->device,
 				       tx_q->tx_skbuff_dma[i].buf,
@@ -1455,12 +1457,20 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv, u32 queue, int i)
 					 DMA_TO_DEVICE);
 	}
 
-	if (tx_q->tx_skbuff[i]) {
+	if (tx_q->xdpf[i] &&
+	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX) {
+		xdp_return_frame(tx_q->xdpf[i]);
+		tx_q->xdpf[i] = NULL;
+	}
+
+	if (tx_q->tx_skbuff[i] &&
+	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
 		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
 		tx_q->tx_skbuff[i] = NULL;
-		tx_q->tx_skbuff_dma[i].buf = 0;
-		tx_q->tx_skbuff_dma[i].map_as_page = false;
 	}
+
+	tx_q->tx_skbuff_dma[i].buf = 0;
+	tx_q->tx_skbuff_dma[i].map_as_page = false;
 }
 
 /**
@@ -1568,6 +1578,7 @@ static int init_dma_rx_desc_rings(struct net_device *dev, gfp_t flags)
 
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
+		int ret;
 
 		netif_dbg(priv, probe, priv->dev,
 			  "(%s) dma_rx_phy=0x%08x\n", __func__,
@@ -1575,6 +1586,14 @@ static int init_dma_rx_desc_rings(struct net_device *dev, gfp_t flags)
 
 		stmmac_clear_rx_descriptors(priv, queue);
 
+		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
+						   MEM_TYPE_PAGE_POOL,
+						   rx_q->page_pool));
+
+		netdev_info(priv->dev,
+			    "Register MEM_TYPE_PAGE_POOL RxQ-%d\n",
+			    rx_q->queue_index);
+
 		for (i = 0; i < priv->dma_rx_size; i++) {
 			struct dma_desc *p;
 
@@ -1775,6 +1794,9 @@ static void free_dma_rx_desc_resources(struct stmmac_priv *priv)
 					  sizeof(struct dma_extended_desc),
 					  rx_q->dma_erx, rx_q->dma_rx_phy);
 
+		if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
+			xdp_rxq_info_unreg(&rx_q->xdp_rxq);
+
 		kfree(rx_q->buf_pool);
 		if (rx_q->page_pool)
 			page_pool_destroy(rx_q->page_pool);
@@ -1837,8 +1859,10 @@ static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv)
 	/* RX queues buffers and DMA */
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
+		struct stmmac_channel *ch = &priv->channel[queue];
 		struct page_pool_params pp_params = { 0 };
 		unsigned int num_pages;
+		int ret;
 
 		rx_q->queue_index = queue;
 		rx_q->priv_data = priv;
@@ -1884,6 +1908,14 @@ static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv)
 			if (!rx_q->dma_rx)
 				goto err_dma;
 		}
+
+		ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev,
+				       rx_q->queue_index,
+				       ch->rx_napi.napi_id);
+		if (ret) {
+			netdev_err(priv->dev, "Failed to register xdp rxq info\n");
+			goto err_dma;
+		}
 	}
 
 	return 0;
@@ -1985,11 +2017,13 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv)
  */
 static void free_dma_desc_resources(struct stmmac_priv *priv)
 {
-	/* Release the DMA RX socket buffers */
-	free_dma_rx_desc_resources(priv);
-
 	/* Release the DMA TX socket buffers */
 	free_dma_tx_desc_resources(priv);
+
+	/* Release the DMA RX socket buffers later
+	 * to ensure all pending XDP_TX buffers are returned.
+	 */
+	free_dma_rx_desc_resources(priv);
 }
 
 /**
@@ -2181,10 +2215,22 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	entry = tx_q->dirty_tx;
 	while ((entry != tx_q->cur_tx) && (count < budget)) {
-		struct sk_buff *skb = tx_q->tx_skbuff[entry];
+		struct xdp_frame *xdpf;
+		struct sk_buff *skb;
 		struct dma_desc *p;
 		int status;
 
+		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX) {
+			xdpf = tx_q->xdpf[entry];
+			skb = NULL;
+		} else if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
+			xdpf = NULL;
+			skb = tx_q->tx_skbuff[entry];
+		} else {
+			xdpf = NULL;
+			skb = NULL;
+		}
+
 		if (priv->extend_desc)
 			p = (struct dma_desc *)(tx_q->dma_etx + entry);
 		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
@@ -2214,10 +2260,12 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 				priv->dev->stats.tx_packets++;
 				priv->xstats.tx_pkt_n++;
 			}
-			stmmac_get_tx_hwtstamp(priv, p, skb);
+			if (skb)
+				stmmac_get_tx_hwtstamp(priv, p, skb);
 		}
 
-		if (likely(tx_q->tx_skbuff_dma[entry].buf)) {
+		if (likely(tx_q->tx_skbuff_dma[entry].buf &&
+			   tx_q->tx_skbuff_dma[entry].buf_type != STMMAC_TXBUF_T_XDP_TX)) {
 			if (tx_q->tx_skbuff_dma[entry].map_as_page)
 				dma_unmap_page(priv->device,
 					       tx_q->tx_skbuff_dma[entry].buf,
@@ -2238,11 +2286,19 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 		tx_q->tx_skbuff_dma[entry].last_segment = false;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = false;
 
-		if (likely(skb != NULL)) {
-			pkts_compl++;
-			bytes_compl += skb->len;
-			dev_consume_skb_any(skb);
-			tx_q->tx_skbuff[entry] = NULL;
+		if (xdpf &&
+		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX) {
+			xdp_return_frame_rx_napi(xdpf);
+			tx_q->xdpf[entry] = NULL;
+		}
+
+		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
+			if (likely(skb)) {
+				pkts_compl++;
+				bytes_compl += skb->len;
+				dev_consume_skb_any(skb);
+				tx_q->tx_skbuff[entry] = NULL;
+			}
 		}
 
 		stmmac_release_tx_desc(priv, p, priv->mode);
@@ -3667,6 +3723,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_q->tx_skbuff_dma[first_entry].buf = des;
 	tx_q->tx_skbuff_dma[first_entry].len = skb_headlen(skb);
+	tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
+	tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
 
 	if (priv->dma_cap.addr64 <= 32) {
 		first->des0 = cpu_to_le32(des);
@@ -3702,12 +3760,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
 		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_frag_size(frag);
 		tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
+		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 	}
 
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].last_segment = true;
 
 	/* Only the last descriptor gets to point to the skb. */
 	tx_q->tx_skbuff[tx_q->cur_tx] = skb;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* Manage tx mitigation */
 	tx_packets = (tx_q->cur_tx + 1) - first_tx;
@@ -3914,6 +3974,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_q->tx_skbuff_dma[entry].map_as_page = true;
 		tx_q->tx_skbuff_dma[entry].len = len;
 		tx_q->tx_skbuff_dma[entry].last_segment = last_segment;
+		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
 
 		/* Prepare the descriptor and set the own bit too */
 		stmmac_prepare_tx_desc(priv, desc, 0, len, csum_insertion,
@@ -3922,6 +3983,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Only the last descriptor gets to point to the skb. */
 	tx_q->tx_skbuff[entry] = skb;
+	tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* According to the coalesce parameter the IC bit for the latest
 	 * segment is reset and the timer re-started to clean the tx status.
@@ -4000,6 +4062,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto dma_map_err;
 
 		tx_q->tx_skbuff_dma[first_entry].buf = des;
+		tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
+		tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
 
 		stmmac_set_desc_addr(priv, first, des);
 
@@ -4181,6 +4245,110 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	return plen - len;
 }
 
+static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
+				struct xdp_frame *xdpf)
+{
+	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
+	struct page *page = virt_to_page(xdpf->data);
+	unsigned int entry = tx_q->cur_tx;
+	struct dma_desc *tx_desc;
+	dma_addr_t dma_addr;
+	bool set_ic;
+
+	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
+		return STMMAC_XDP_CONSUMED;
+
+	if (likely(priv->extend_desc))
+		tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
+	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
+		tx_desc = &tx_q->dma_entx[entry].basic;
+	else
+		tx_desc = tx_q->dma_tx + entry;
+
+	dma_addr = page_pool_get_dma_addr(page) + sizeof(*xdpf) +
+		   xdpf->headroom;
+	dma_sync_single_for_device(priv->device, dma_addr,
+				   xdpf->len, DMA_BIDIRECTIONAL);
+
+	tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_TX;
+
+	tx_q->tx_skbuff_dma[entry].buf = dma_addr;
+	tx_q->tx_skbuff_dma[entry].map_as_page = false;
+	tx_q->tx_skbuff_dma[entry].len = xdpf->len;
+	tx_q->tx_skbuff_dma[entry].last_segment = true;
+	tx_q->tx_skbuff_dma[entry].is_jumbo = false;
+
+	tx_q->xdpf[entry] = xdpf;
+
+	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
+
+	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
+			       true, priv->mode, true, true,
+			       xdpf->len);
+
+	tx_q->tx_count_frames++;
+
+	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
+		set_ic = true;
+	else
+		set_ic = false;
+
+	if (set_ic) {
+		tx_q->tx_count_frames = 0;
+		stmmac_set_tx_ic(priv, tx_desc);
+		priv->xstats.tx_set_ic_bit++;
+	}
+
+	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+
+	entry = STMMAC_GET_ENTRY(entry, priv->dma_tx_size);
+	tx_q->cur_tx = entry;
+
+	return STMMAC_XDP_TX;
+}
+
+static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
+				   int cpu)
+{
+	int index = cpu;
+
+	if (unlikely(index < 0))
+		index = 0;
+
+	while (index >= priv->plat->tx_queues_to_use)
+		index -= priv->plat->tx_queues_to_use;
+
+	return index;
+}
+
+static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
+				struct xdp_buff *xdp)
+{
+	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	int queue;
+	int res;
+
+	if (unlikely(!xdpf))
+		return STMMAC_XDP_CONSUMED;
+
+	queue = stmmac_xdp_get_tx_queue(priv, cpu);
+	nq = netdev_get_tx_queue(priv->dev, queue);
+
+	__netif_tx_lock(nq, cpu);
+	/* Avoids TX time-out as we are sharing with slow path */
+	nq->trans_start = jiffies;
+
+	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf);
+	if (res == STMMAC_XDP_TX)
+		stmmac_flush_tx_descriptors(priv, queue);
+
+	__netif_tx_unlock(nq);
+
+	return res;
+}
+
 static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 					   struct xdp_buff *xdp)
 {
@@ -4201,6 +4369,9 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 	case XDP_PASS:
 		res = STMMAC_XDP_PASS;
 		break;
+	case XDP_TX:
+		res = stmmac_xdp_xmit_back(priv, xdp);
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
@@ -4217,6 +4388,18 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 	return ERR_PTR(-res);
 }
 
+static void stmmac_finalize_xdp_rx(struct stmmac_priv *priv,
+				   int xdp_status)
+{
+	int cpu = smp_processor_id();
+	int queue;
+
+	queue = stmmac_xdp_get_tx_queue(priv, cpu);
+
+	if (xdp_status & STMMAC_XDP_TX)
+		stmmac_tx_timer_arm(priv, queue);
+}
+
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -4236,6 +4419,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct xdp_buff xdp;
+	int xdp_status = 0;
 	int buf_sz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
@@ -4357,6 +4541,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		}
 
 		if (!skb) {
+			unsigned int pre_len, sync_len;
+
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 
@@ -4365,16 +4551,26 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp.data_hard_start = page_address(buf->page);
 			xdp_set_data_meta_invalid(&xdp);
 			xdp.frame_sz = buf_sz;
+			xdp.rxq = &rx_q->xdp_rxq;
 
+			pre_len = xdp.data_end - xdp.data_hard_start -
+				  buf->page_offset;
 			skb = stmmac_xdp_run_prog(priv, &xdp);
+			/* Due xdp_adjust_tail: DMA sync for_device
+			 * cover max len CPU touch
+			 */
+			sync_len = xdp.data_end - xdp.data_hard_start -
+				   buf->page_offset;
+			sync_len = max(sync_len, pre_len);
 
 			/* For Not XDP_PASS verdict */
 			if (IS_ERR(skb)) {
 				unsigned int xdp_res = -PTR_ERR(skb);
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_recycle_direct(rx_q->page_pool,
-								 buf->page);
+					page_pool_put_page(rx_q->page_pool,
+							   virt_to_head_page(xdp.data),
+							   sync_len, true);
 					buf->page = NULL;
 					priv->dev->stats.rx_dropped++;
 
@@ -4388,6 +4584,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 					count++;
 					continue;
+				} else if (xdp_res & STMMAC_XDP_TX) {
+					xdp_status |= xdp_res;
+					buf->page = NULL;
+					skb = NULL;
+					count++;
+					continue;
 				}
 			}
 		}
@@ -4470,6 +4672,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		rx_q->state.len = len;
 	}
 
+	stmmac_finalize_xdp_rx(priv, xdp_status);
+
 	stmmac_rx_refill(priv, queue);
 
 	priv->xstats.rx_pkt_n += count;
-- 
2.25.1

