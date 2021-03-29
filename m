Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C603C34D157
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhC2Ng7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 09:36:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:45673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhC2Ngv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 09:36:51 -0400
IronPort-SDR: ZDRAr8rmtH2AH+4EkdHCeOf+aWwru0CD2cym6R+Wra+Pc3q+G2zhUSQ0KdyOtugODfSVDy13fB
 7z88yRogBDIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191578744"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191578744"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 06:36:51 -0700
IronPort-SDR: UUoUqMYDBG9Q9REinDzFe3AkwJnqEogrxjyTZUqrW33w15qJq7LsGfuKabhTtAUIZyxYXJV3Di
 ICldNfIxmb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="411079495"
Received: from glass.png.intel.com ([10.158.65.59])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2021 06:36:46 -0700
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
Subject: [PATCH net-next 6/6] net: stmmac: Add support for XDP_REDIRECT action
Date:   Mon, 29 Mar 2021 21:40:13 +0800
Message-Id: <20210329134013.9516-7-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329134013.9516-1-boon.leong.ong@intel.com>
References: <20210329134013.9516-1-boon.leong.ong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the support of XDP_REDIRECT to another remote cpu for
further action. It also implements ndo_xdp_xmit ops, enabling the driver
to transmit packets forwarded to it by XDP program running on another
interface.

This patch has been tested using "xdp_redirect_cpu" for XDP_REDIRECT
+ drop testing. It also been tested with "xdp_redirect" sample app
which can be used to exercise ndo_xdp_xmit ops. The burst traffics are
generated using pktgen_sample03_burst_single_flow.sh in samples/pktgen
directory.

Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 96 +++++++++++++++++--
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index a93e22a6be59..c49debb62b05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -39,6 +39,7 @@ struct stmmac_resources {
 enum stmmac_txbuf_type {
 	STMMAC_TXBUF_T_SKB,
 	STMMAC_TXBUF_T_XDP_TX,
+	STMMAC_TXBUF_T_XDP_NDO,
 };
 
 struct stmmac_tx_info {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b92355561609..3af783b7a0a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -72,6 +72,7 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");
 #define STMMAC_XDP_PASS		0
 #define STMMAC_XDP_CONSUMED	BIT(0)
 #define STMMAC_XDP_TX		BIT(1)
+#define STMMAC_XDP_REDIRECT	BIT(2)
 
 static int flow_ctrl = FLOW_AUTO;
 module_param(flow_ctrl, int, 0644);
@@ -1458,7 +1459,8 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv, u32 queue, int i)
 	}
 
 	if (tx_q->xdpf[i] &&
-	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX) {
+	    (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX ||
+	     tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_NDO)) {
 		xdp_return_frame(tx_q->xdpf[i]);
 		tx_q->xdpf[i] = NULL;
 	}
@@ -2220,7 +2222,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 		struct dma_desc *p;
 		int status;
 
-		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX) {
+		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX ||
+		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_NDO) {
 			xdpf = tx_q->xdpf[entry];
 			skb = NULL;
 		} else if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
@@ -2292,6 +2295,12 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 			tx_q->xdpf[entry] = NULL;
 		}
 
+		if (xdpf &&
+		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_NDO) {
+			xdp_return_frame(xdpf);
+			tx_q->xdpf[entry] = NULL;
+		}
+
 		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
 			if (likely(skb)) {
 				pkts_compl++;
@@ -4237,10 +4246,9 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 }
 
 static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
-				struct xdp_frame *xdpf)
+				struct xdp_frame *xdpf, bool dma_map)
 {
 	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
-	struct page *page = virt_to_page(xdpf->data);
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc;
 	dma_addr_t dma_addr;
@@ -4256,12 +4264,23 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	else
 		tx_desc = tx_q->dma_tx + entry;
 
-	dma_addr = page_pool_get_dma_addr(page) + sizeof(*xdpf) +
-		   xdpf->headroom;
-	dma_sync_single_for_device(priv->device, dma_addr,
-				   xdpf->len, DMA_BIDIRECTIONAL);
+	if (dma_map) {
+		dma_addr = dma_map_single(priv->device, xdpf->data,
+					  xdpf->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(priv->device, dma_addr))
+			return STMMAC_XDP_CONSUMED;
+
+		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_NDO;
+	} else {
+		struct page *page = virt_to_page(xdpf->data);
 
-	tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_TX;
+		dma_addr = page_pool_get_dma_addr(page) + sizeof(*xdpf) +
+			   xdpf->headroom;
+		dma_sync_single_for_device(priv->device, dma_addr,
+					   xdpf->len, DMA_BIDIRECTIONAL);
+
+		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_TX;
+	}
 
 	tx_q->tx_skbuff_dma[entry].buf = dma_addr;
 	tx_q->tx_skbuff_dma[entry].map_as_page = false;
@@ -4328,7 +4347,7 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	nq = netdev_get_tx_queue(priv->dev, queue);
 
 	__netif_tx_lock(nq, cpu);
-	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf);
+	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
 	if (res == STMMAC_XDP_TX) {
 		stmmac_flush_tx_descriptors(priv, queue);
 		stmmac_tx_timer_arm(priv, queue);
@@ -4361,6 +4380,12 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 	case XDP_TX:
 		res = stmmac_xdp_xmit_back(priv, xdp);
 		break;
+	case XDP_REDIRECT:
+		if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
+			res = STMMAC_XDP_CONSUMED;
+		else
+			res = STMMAC_XDP_REDIRECT;
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
@@ -4396,6 +4421,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct xdp_buff xdp;
+	int xdp_status = 0;
 	int buf_sz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
@@ -4565,6 +4591,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 					skb = NULL;
 					count++;
 					continue;
+				} else if (xdp_res & STMMAC_XDP_REDIRECT) {
+					xdp_status |= xdp_res;
+					buf->page = NULL;
+					skb = NULL;
+					count++;
+					continue;
 				}
 			}
 		}
@@ -4645,6 +4677,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		rx_q->state.len = len;
 	}
 
+	if (xdp_status & STMMAC_XDP_REDIRECT)
+		xdp_do_flush();
+
 	stmmac_rx_refill(priv, queue);
 
 	priv->xstats.rx_pkt_n += count;
@@ -5571,6 +5606,46 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
+static int stmmac_xdp_xmit(struct net_device *dev, int num_frames,
+			   struct xdp_frame **frames, u32 flags)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	int i, nxmit = 0;
+	int queue;
+
+	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	queue = stmmac_xdp_get_tx_queue(priv, cpu);
+	nq = netdev_get_tx_queue(priv->dev, queue);
+
+	__netif_tx_lock(nq, cpu);
+
+	for (i = 0; i < num_frames; i++) {
+		int res;
+
+		res = stmmac_xdp_xmit_xdpf(priv, queue, frames[i], true);
+		if (res == STMMAC_XDP_CONSUMED)
+			break;
+
+		nxmit++;
+	}
+
+	if (flags & XDP_XMIT_FLUSH) {
+		stmmac_flush_tx_descriptors(priv, queue);
+		stmmac_tx_timer_arm(priv, queue);
+	}
+
+	__netif_tx_unlock(nq);
+
+	return nxmit;
+}
+
 static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_open = stmmac_open,
 	.ndo_start_xmit = stmmac_xmit,
@@ -5590,6 +5665,7 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_vlan_rx_add_vid = stmmac_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = stmmac_vlan_rx_kill_vid,
 	.ndo_bpf = stmmac_bpf,
+	.ndo_xdp_xmit = stmmac_xdp_xmit,
 };
 
 static void stmmac_reset_subtask(struct stmmac_priv *priv)
-- 
2.25.1

