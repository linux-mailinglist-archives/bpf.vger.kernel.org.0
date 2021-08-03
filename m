Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1284F3DE3CB
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhHCBED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:65283 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233427AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327851"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327851"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480132"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 11/16] igc: XDP packet TX timestamp
Date:   Mon,  2 Aug 2021 18:03:26 -0700
Message-Id: <20210803010331.39453-12-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ADD the PTP timestamp of when a packet was transmitted to the XDP hints.
An application using AF_XDP can get this timestamp by inspecting the XDP
frame metadata when it gets to the completion queue.

One notable difference from TX timestamp for SKB, is that the XDP frame
actually resides in the UMEM. As such, the timestamp is added to the
frame, and user space applications can access it when the frame is sent
to the completion queue.

When performing the clean-up of TX descriptors, driver will check if an
XDP socket frame is "expecting" a TX timestamp. If so, driver will stop
clean-up to give an opportunity for the TX timestamp interrupt arrive.

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  22 ++--
 drivers/net/ethernet/intel/igc/igc_main.c | 122 ++++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_ptp.c  |  47 ++++++---
 3 files changed, 152 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 84e5f3c97351..eb955b5fb58f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -68,11 +68,23 @@ struct igc_rx_packet_stats {
 	u64 other_packets;
 };
 
+enum igc_tx_buffer_type {
+	IGC_TX_BUFFER_TYPE_SKB,
+	IGC_TX_BUFFER_TYPE_XDP,
+	IGC_TX_BUFFER_TYPE_XSK,
+};
+
 #define IGC_MAX_TX_TSTAMP_TIMERS	4
 
 struct igc_tx_timestamp_request {
-	struct sk_buff *skb;
+	union igc_pending_ts_pkt {
+		struct sk_buff *skb;
+		struct xdp_desc xsk_desc;
+		void *ptr;
+	} pending_ts_pkt;
+	struct xsk_buff_pool *xsk_pool;
 	unsigned long start;
+	enum igc_tx_buffer_type type;
 	u32 mask;
 	u32 regl;
 	u32 regh;
@@ -435,12 +447,6 @@ enum igc_boards {
 #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
 #define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
 
-enum igc_tx_buffer_type {
-	IGC_TX_BUFFER_TYPE_SKB,
-	IGC_TX_BUFFER_TYPE_XDP,
-	IGC_TX_BUFFER_TYPE_XSK,
-};
-
 /* wrapper around a pointer to a socket buffer,
  * so a DMA handle can be stored along with the buffer
  */
@@ -451,6 +457,7 @@ struct igc_tx_buffer {
 	union {
 		struct sk_buff *skb;
 		struct xdp_frame *xdpf;
+		struct xdp_desc xsk_desc;
 	};
 	unsigned int bytecount;
 	u16 gso_segs;
@@ -641,6 +648,7 @@ int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
 void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
+ktime_t igc_retrieve_ptp_tx_timestamp(struct igc_adapter *adapter);
 
 #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 82e9b493cad6..46c8c393d03e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1157,7 +1157,8 @@ static u32 igc_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
 				 (IGC_ADVTXD_TSTAMP_REG_3));
 
 	/* insert frame checksum */
-	cmd_type ^= IGC_SET_FLAG(skb->no_fcs, 1, IGC_ADVTXD_DCMD_IFCS);
+	if (skb)
+		cmd_type ^= IGC_SET_FLAG(skb->no_fcs, 1, IGC_ADVTXD_DCMD_IFCS);
 
 	return cmd_type;
 }
@@ -1413,17 +1414,25 @@ static int igc_tso(struct igc_ring *tx_ring,
 	return 1;
 }
 
-static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *skb, u32 *flags)
+static bool igc_request_tx_tstamp(struct igc_adapter *adapter,
+				  union igc_pending_ts_pkt ts_pkt, u32 *flags,
+				  struct xsk_buff_pool *xsk_pool)
 {
 	int i;
 
 	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
 		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
 
-		if (tstamp->skb)
+		if (tstamp->pending_ts_pkt.ptr)
 			continue;
 
-		tstamp->skb = skb_get(skb);
+		tstamp->pending_ts_pkt = ts_pkt;
+		if (xsk_pool) {
+			tstamp->xsk_pool = xsk_pool;
+			tstamp->type = IGC_TX_BUFFER_TYPE_XSK;
+		} else {
+			tstamp->type = IGC_TX_BUFFER_TYPE_SKB;
+		}
 		tstamp->start = jiffies;
 		*flags = tstamp->flags;
 
@@ -1468,17 +1477,20 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
+		union igc_pending_ts_pkt ts_pkt;
 		unsigned long flags;
 		u32 tstamp_flags;
 
 		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
+		ts_pkt.skb = skb_get(skb);
 		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
+		    igc_request_tx_tstamp(adapter, ts_pkt, &tstamp_flags, NULL)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
 		} else {
 			adapter->tx_hwtstamp_skipped++;
+			skb_unref(skb);
 		}
 
 		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
@@ -2163,7 +2175,8 @@ static int igc_xdp_init_tx_buffer(struct igc_tx_buffer *buffer,
 
 /* This function requires __netif_tx_lock is held by the caller. */
 static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
-				      struct xdp_frame *xdpf)
+				      struct xdp_frame *xdpf,
+				      u32 tx_flags)
 {
 	struct igc_tx_buffer *buffer;
 	union igc_adv_tx_desc *desc;
@@ -2191,6 +2204,7 @@ static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
 	netdev_tx_sent_queue(txring_txq(ring), buffer->bytecount);
 
 	buffer->next_to_watch = desc;
+	buffer->tx_flags = tx_flags;
 
 	ring->next_to_use++;
 	if (ring->next_to_use == ring->count)
@@ -2228,7 +2242,7 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	nq = txring_txq(ring);
 
 	__netif_tx_lock(nq, cpu);
-	res = igc_xdp_init_tx_descriptor(ring, xdpf);
+	res = igc_xdp_init_tx_descriptor(ring, xdpf, 0);
 	__netif_tx_unlock(nq);
 	return res;
 }
@@ -2630,6 +2644,7 @@ static void igc_update_tx_stats(struct igc_q_vector *q_vector,
 
 static void igc_xdp_xmit_zc(struct igc_ring *ring)
 {
+	struct igc_adapter *adapter = netdev_priv(ring->netdev);
 	struct xsk_buff_pool *pool = ring->xsk_pool;
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
@@ -2646,13 +2661,36 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-		u32 cmd_type, olinfo_status;
+		u32 cmd_type, olinfo_status, tx_flags = 0;
 		struct igc_tx_buffer *bi;
+		unsigned long flags;
 		dma_addr_t dma;
 
-		cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
-			   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
-			   xdp_desc.len;
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
+		    adapter->btf_enabled) {
+			union igc_pending_ts_pkt ts_pkt;
+			struct xdp_hints___igc *hints;
+			u32 tstamp_flags;
+
+			/* Ensure there's no garbage on metadata */
+			hints = (struct xdp_hints___igc *)
+				((char *)xsk_buff_raw_get_data(pool, xdp_desc.addr)
+				 - sizeof(*hints));
+			hints->valid_map = 0;
+			spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+			ts_pkt.xsk_desc = xdp_desc;
+			if (igc_request_tx_tstamp(
+			    adapter, ts_pkt, &tstamp_flags, pool)) {
+				tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
+				hints->tx_timestamp = 0;;
+			} else
+				adapter->tx_hwtstamp_skipped++;
+
+			spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+		}
+
+		cmd_type = igc_tx_cmd_type(NULL, tx_flags) | IGC_TXD_DCMD | xdp_desc.len;
 		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
 
 		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
@@ -2670,6 +2708,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		bi->gso_segs = 1;
 		bi->time_stamp = jiffies;
 		bi->next_to_watch = tx_desc;
+		bi->xsk_desc = xdp_desc;
 
 		netdev_tx_sent_queue(txring_txq(ring), xdp_desc.len);
 
@@ -2687,6 +2726,47 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	__netif_tx_unlock(nq);
 }
 
+static bool igc_xsk_complete_tx_tstamp(struct igc_adapter *adapter,
+				       struct igc_tx_buffer *tx_buffer)
+{
+	unsigned long flags;
+	bool ret = true;
+	int i;
+
+	if (!adapter->btf_enabled)
+		return ret;
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		if (!tstamp->pending_ts_pkt.ptr)
+			continue;
+
+		if (tstamp->type == IGC_TX_BUFFER_TYPE_XSK) {
+			struct xdp_desc xdp_desc = tstamp->pending_ts_pkt.xsk_desc;
+
+			if (xdp_desc.addr == tx_buffer->xsk_desc.addr) {
+				struct xdp_hints___igc *hints;
+				struct xsk_buff_pool *pool;
+
+				pool = tstamp->xsk_pool;
+				hints = (struct xdp_hints___igc *)
+					((char *)xsk_buff_raw_get_data(pool, xdp_desc.addr)
+					 - sizeof(*hints));
+				if (hints->tx_timestamp) {
+					ret = false;
+					break;
+				}
+				tstamp->pending_ts_pkt.ptr = NULL;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+
+	return ret;
+}
+
 /**
  * igc_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: pointer to q_vector containing needed info
@@ -2726,15 +2806,10 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		if (!(eop_desc->wb.status & cpu_to_le32(IGC_TXD_STAT_DD)))
 			break;
 
-		/* clear next_to_watch to prevent false hangs */
-		tx_buffer->next_to_watch = NULL;
-
-		/* update the statistics for this packet */
-		total_bytes += tx_buffer->bytecount;
-		total_packets += tx_buffer->gso_segs;
-
 		switch (tx_buffer->type) {
 		case IGC_TX_BUFFER_TYPE_XSK:
+			if (!igc_xsk_complete_tx_tstamp(adapter, tx_buffer))
+				goto budget_out;
 			xsk_frames++;
 			break;
 		case IGC_TX_BUFFER_TYPE_XDP:
@@ -2750,6 +2825,13 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 			break;
 		}
 
+		/* clear next_to_watch to prevent false hangs */
+		tx_buffer->next_to_watch = NULL;
+
+		/* update the statistics for this packet */
+		total_bytes += tx_buffer->bytecount;
+		total_packets += tx_buffer->gso_segs;
+
 		/* clear last DMA location and unmap remaining buffers */
 		while (tx_desc != eop_desc) {
 			tx_buffer++;
@@ -2783,6 +2865,7 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		budget--;
 	} while (likely(budget));
 
+budget_out:
 	netdev_tx_completed_queue(txring_txq(tx_ring),
 				  total_packets, total_bytes);
 
@@ -5986,6 +6069,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	struct igc_ring *ring;
+	u32 tx_flags = 0;
 	int i, drops;
 
 	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
@@ -6004,7 +6088,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 		int err;
 		struct xdp_frame *xdpf = frames[i];
 
-		err = igc_xdp_init_tx_descriptor(ring, xdpf);
+		err = igc_xdp_init_tx_descriptor(ring, xdpf, tx_flags);
 		if (err) {
 			xdp_return_frame_rx_napi(xdpf);
 			drops++;
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 911c36a909a4..0f6b91a421e9 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -9,6 +9,9 @@
 #include <linux/ptp_classify.h>
 #include <linux/clocksource.h>
 #include <linux/ktime.h>
+#include <net/xdp_sock_drv.h>
+
+#include "igc_xdp.h"
 
 #define INCVALUE_MASK		0x7fffffff
 #define ISGN			0x80000000
@@ -613,9 +616,10 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
 {
 	struct igc_hw *hw = &adapter->hw;
 
-	dev_kfree_skb_any(tstamp->skb);
-	tstamp->skb = NULL;
+	if (tstamp->type == IGC_TX_BUFFER_TYPE_SKB)
+		dev_kfree_skb_any(tstamp->pending_ts_pkt.skb);
 	tstamp->start = 0;
+	tstamp->pending_ts_pkt.ptr = NULL;
 	adapter->tx_hwtstamp_timeouts++;
 	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
 	rd32(tstamp->regh);
@@ -634,7 +638,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
 	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
 		tstamp = &adapter->tx_tstamp[i];
 
-		if (!tstamp->skb)
+		if (!tstamp->pending_ts_pkt.ptr)
 			continue;
 
 		if (time_is_after_jiffies(tstamp->start + IGC_PTP_TX_TIMEOUT))
@@ -661,7 +665,6 @@ void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask)
 	struct skb_shared_hwtstamps shhwtstamps;
 	struct igc_hw *hw = &adapter->hw;
 	unsigned long flags;
-	struct sk_buff *skb;
 	int adjust = 0;
 	u64 regval;
 	int i;
@@ -675,12 +678,13 @@ void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask)
 		if (!(mask & tstamp->mask))
 			continue;
 
-		skb = tstamp->skb;
-		if (!skb)
-			continue;
-
+		/* Always need to read register, to clean interrupt cause */
 		regval = rd32(tstamp->regl);
 		regval |= (u64)rd32(tstamp->regh) << 32;
+
+		if (!tstamp->pending_ts_pkt.ptr)
+			continue;
+
 		igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
 
 		switch (adapter->link_speed) {
@@ -706,12 +710,27 @@ void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask)
 		 * a copy of the skb pointer to ensure other threads can't change it
 		 * while we're notifying the stack.
 		 */
-		tstamp->skb = NULL;
 		tstamp->start = 0;
 
 		/* Notify the stack and free the skb after we've unlocked */
-		skb_tstamp_tx(skb, &shhwtstamps);
-		dev_kfree_skb_any(skb);
+		if (tstamp->type == IGC_TX_BUFFER_TYPE_SKB) {
+			skb_tstamp_tx(tstamp->pending_ts_pkt.skb, &shhwtstamps);
+			dev_kfree_skb_any(tstamp->pending_ts_pkt.skb);
+			tstamp->pending_ts_pkt.ptr = NULL;
+		} else if (tstamp->type == IGC_TX_BUFFER_TYPE_XSK) {
+			struct xdp_hints___igc *hints;
+			struct xsk_buff_pool *pool;
+			struct xdp_desc xdp_desc;
+
+			pool = tstamp->xsk_pool;
+			xdp_desc = tstamp->pending_ts_pkt.xsk_desc;
+			hints = (struct xdp_hints___igc *)
+				((char *)xsk_buff_raw_get_data(pool, xdp_desc.addr)
+				 - sizeof(*hints));
+			hints->tx_timestamp = shhwtstamps.hwtstamp;
+			hints->valid_map = XDP_GENERIC_HINTS_TX_TIMESTAMP;
+			hints->btf_id = btf_obj_id(adapter->btf);
+		}
 	}
 
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
@@ -883,8 +902,10 @@ static void igc_tx_tstamp_clear(struct igc_adapter *adapter)
 	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
 		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
 
-		dev_kfree_skb_any(tstamp->skb);
-		tstamp->skb = NULL;
+		if (tstamp->pending_ts_pkt.ptr && tstamp->type == IGC_TX_BUFFER_TYPE_SKB)
+			dev_kfree_skb_any(tstamp->pending_ts_pkt.skb);
+
+		tstamp->pending_ts_pkt.ptr = NULL;
 		tstamp->start = 0;
 	}
 }
-- 
2.32.0

