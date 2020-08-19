Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023D0249FC1
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgHSN0T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 09:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbgHSNPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 09:15:52 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043992078D;
        Wed, 19 Aug 2020 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597842887;
        bh=Vk1YbgaBkHei/2MD1rPLJYGsI6Slzxptqcnu/TrAs2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSgaErYSOQ3ooSh9g5709jV1bEf6hkY9qTNb9PW8vI6rKHKyRkvlYu43wn5VckHa+
         2TdP0cqFLTGhTZ9K04XYrAT5FPLDIUUEzSVrZMTuGQhlzRz8bYDMCmxF/EdpvlRu73
         ql9id+qd+7q++Zl6gHufkaqwLUR4CFpI3vA6SgNc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org
Subject: [PATCH net-next 2/6] xdp: initialize xdp_buff mb bit to 0 in all XDP drivers
Date:   Wed, 19 Aug 2020 15:13:47 +0200
Message-Id: <1d1c63f50dd169244d9fb8ffd956611475074504.1597842004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597842004.git.lorenzo@kernel.org>
References: <cover.1597842004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Initialize multi-buffer bit (mb) to 0 in all XDP-capable drivers.
This is a preliminary patch to enable xdp multi-buffer support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c        | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c       | 1 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c    | 1 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    | 1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c         | 1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c           | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c       | 1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c   | 1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c     | 1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     | 1 +
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 1 +
 drivers/net/ethernet/qlogic/qede/qede_fp.c          | 1 +
 drivers/net/ethernet/sfc/rx.c                       | 1 +
 drivers/net/ethernet/socionext/netsec.c             | 1 +
 drivers/net/ethernet/ti/cpsw.c                      | 1 +
 drivers/net/ethernet/ti/cpsw_new.c                  | 1 +
 drivers/net/hyperv/netvsc_bpf.c                     | 1 +
 drivers/net/tun.c                                   | 2 ++
 drivers/net/veth.c                                  | 1 +
 drivers/net/virtio_net.c                            | 2 ++
 drivers/net/xen-netfront.c                          | 1 +
 net/core/dev.c                                      | 1 +
 23 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 2a6c9725e092..02a32196c226 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1607,6 +1607,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	res_budget = budget;
 	xdp.rxq = &rx_ring->xdp_rxq;
 	xdp.frame_sz = ENA_PAGE_SIZE;
+	xdp.mb = 0;
 
 	do {
 		xdp_verdict = XDP_PASS;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 2704a4709bc7..63dde7a369b7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -139,6 +139,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	xdp.data_end = *data_ptr + *len;
 	xdp.rxq = &rxr->xdp_rxq;
 	xdp.frame_sz = PAGE_SIZE; /* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
+	xdp.mb = 0;
 	orig_data = xdp.data;
 
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c1378b5c780c..28448033750d 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -553,6 +553,7 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
 	xdp.data_end = xdp.data + len;
 	xdp.rxq = &rq->xdp_rxq;
 	xdp.frame_sz = RCV_FRAG_LEN + XDP_PACKET_HEADROOM;
+	xdp.mb = 0;
 	orig_data = xdp.data;
 
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 457106e761be..3e7b1cf94c09 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -361,6 +361,7 @@ static u32 run_xdp(struct dpaa2_eth_priv *priv,
 
 	xdp.frame_sz = DPAA2_ETH_RX_BUF_RAW_SIZE -
 		(dpaa2_fd_get_offset(fd) - XDP_PACKET_HEADROOM);
+	xdp.mb = 0;
 
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3e5c566ceb01..7d5a8afa8a4c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2324,6 +2324,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	xdp.frame_sz = i40e_rx_frame_truesize(rx_ring, 0);
 #endif
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.mb = 0;
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		struct i40e_rx_buffer *rx_buffer;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 9d0d6b0025cf..d96a9525942a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1095,6 +1095,7 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 #if (PAGE_SIZE < 8192)
 	xdp.frame_sz = ice_rx_frame_truesize(rx_ring, 0);
 #endif
+	xdp.mb = 0;
 
 	/* start the loop to process Rx packets bounded by 'budget' */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2f8a4cfc5fa1..46409f66d04d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2303,6 +2303,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 #if (PAGE_SIZE < 8192)
 	xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, 0);
 #endif
+	xdp.mb = 0;
 
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a428113e6d54..f96fe937f4e9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1133,6 +1133,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	struct xdp_buff xdp;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.mb = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2a8a5842eaef..d02e08eb3df8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3475,6 +3475,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			xdp.data = data + MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 			xdp.data_end = xdp.data + rx_bytes;
 			xdp.frame_sz = PAGE_SIZE;
+			xdp.mb = 0;
 
 			if (bm_pool->pkt_size == MVPP2_BM_SHORT_PKT_SIZE)
 				xdp.rxq = &rxq->xdp_rxq_short;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b50c567ef508..0bbc666511ba 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -684,6 +684,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 	xdp_prog = rcu_dereference(ring->xdp_prog);
 	xdp.rxq = &ring->xdp_rxq;
 	xdp.frame_sz = priv->frag_info[0].frag_stride;
+	xdp.mb = 0;
 	doorbell_pending = 0;
 
 	/* We assume a 1:1 mapping between CQEs and Rx descriptors, so Rx
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 65828af120b7..098e0b47812e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1121,6 +1121,7 @@ static void mlx5e_fill_xdp_buff(struct mlx5e_rq *rq, void *va, u16 headroom,
 	xdp->data_end = xdp->data + len;
 	xdp->rxq = &rq->xdp_rxq;
 	xdp->frame_sz = rq->buff.frame0_sz;
+	xdp->mb = 0;
 }
 
 static struct sk_buff *
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 39ee23e8c0bf..0bfccf2a7b1c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1824,6 +1824,7 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 	true_bufsz = xdp_prog ? PAGE_SIZE : dp->fl_bufsz;
 	xdp.frame_sz = PAGE_SIZE - NFP_NET_RX_BUF_HEADROOM;
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.mb = 0;
 	tx_ring = r_vec->xdp_ring;
 
 	while (pkts_polled < budget) {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index a2494bf85007..14a54094ca08 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1096,6 +1096,7 @@ static bool qede_rx_xdp(struct qede_dev *edev,
 	xdp.data_end = xdp.data + *len;
 	xdp.rxq = &rxq->xdp_rxq;
 	xdp.frame_sz = rxq->rx_buf_seg_size; /* PAGE_SIZE when XDP enabled */
+	xdp.mb = 0;
 
 	/* Queues always have a full reset currently, so for the time
 	 * being until there's atomic program replace just mark read
diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 59a43d586967..8fd6023995d4 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -301,6 +301,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	xdp.data_end = xdp.data + rx_buf->len;
 	xdp.rxq = &rx_queue->xdp_rxq_info;
 	xdp.frame_sz = efx->rx_page_buf_step;
+	xdp.mb = 0;
 
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 	rcu_read_unlock();
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 25db667fa879..c73108ce0a32 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -947,6 +947,7 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 
 	xdp.rxq = &dring->xdp_rxq;
 	xdp.frame_sz = PAGE_SIZE;
+	xdp.mb = 0;
 
 	rcu_read_lock();
 	xdp_prog = READ_ONCE(priv->xdp_prog);
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 9b17bbbe102f..53a55c540adc 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -407,6 +407,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		xdp.data_hard_start = pa;
 		xdp.rxq = &priv->xdp_rxq[ch];
 		xdp.frame_sz = PAGE_SIZE;
+		xdp.mb = 0;
 
 		port = priv->emac_port + cpsw->data.dual_emac;
 		ret = cpsw_run_xdp(priv, ch, &xdp, page, port);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 1247d35d42ef..703d079fd479 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -349,6 +349,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		xdp.data_hard_start = pa;
 		xdp.rxq = &priv->xdp_rxq[ch];
 		xdp.frame_sz = PAGE_SIZE;
+		xdp.mb = 0;
 
 		ret = cpsw_run_xdp(priv, ch, &xdp, page, priv->emac_port);
 		if (ret != CPSW_XDP_PASS)
diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 440486d9c999..a4bafc64997f 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -50,6 +50,7 @@ u32 netvsc_run_xdp(struct net_device *ndev, struct netvsc_channel *nvchan,
 	xdp->data_end = xdp->data + len;
 	xdp->rxq = &nvchan->xdp_rxq;
 	xdp->frame_sz = PAGE_SIZE;
+	xdp->mb = 0;
 
 	memcpy(xdp->data, data, len);
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 3c11a77f5709..317fe5c8db60 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1659,6 +1659,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp.data_end = xdp.data + len;
 		xdp.rxq = &tfile->xdp_rxq;
 		xdp.frame_sz = buflen;
+		xdp.mb = 0;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
@@ -2406,6 +2407,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		xdp_set_data_meta_invalid(xdp);
 		xdp->rxq = &tfile->xdp_rxq;
 		xdp->frame_sz = buflen;
+		xdp->mb = 0;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		err = tun_xdp_act(tun, xdp_prog, xdp, act);
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e56cd562a664..71734f4eb8be 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -711,6 +711,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	/* SKB "head" area always have tailroom for skb_shared_info */
 	xdp.frame_sz = (void *)skb_end_pointer(skb) - xdp.data_hard_start;
 	xdp.frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	xdp.mb = 0;
 
 	orig_data = xdp.data;
 	orig_data_end = xdp.data_end;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0ada48edf749..3bee68f59e19 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -690,6 +690,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		xdp.data_meta = xdp.data;
 		xdp.rxq = &rq->xdp_rxq;
 		xdp.frame_sz = buflen;
+		xdp.mb = 0;
 		orig_data = xdp.data;
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		stats->xdp_packets++;
@@ -860,6 +861,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		xdp.data_meta = xdp.data;
 		xdp.rxq = &rq->xdp_rxq;
 		xdp.frame_sz = frame_sz - vi->hdr_len;
+		xdp.mb = 0;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		stats->xdp_packets++;
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 458be6882b98..02ed7f26097d 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -870,6 +870,7 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	xdp->data_end = xdp->data + len;
 	xdp->rxq = &queue->xdp_rxq;
 	xdp->frame_sz = XEN_PAGE_SIZE - XDP_PACKET_HEADROOM;
+	xdp->mb = 0;
 
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
diff --git a/net/core/dev.c b/net/core/dev.c
index 7df6c9617321..a00aa737ce29 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4639,6 +4639,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 	/* SKB "head" area always have tailroom for skb_shared_info */
 	xdp->frame_sz  = (void *)skb_end_pointer(skb) - xdp->data_hard_start;
 	xdp->frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	xdp->mb = 0;
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
-- 
2.26.2

