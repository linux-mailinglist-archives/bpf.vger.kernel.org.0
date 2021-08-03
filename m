Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C83DE3C5
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhHCBEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232849AbhHCBEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327840"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327840"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480126"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [[RFC xdp-hints] 07/16] igc: Add support for multiple in-flight TX timestamps
Date:   Mon,  2 Aug 2021 18:03:22 -0700
Message-Id: <20210803010331.39453-8-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Adds support for using the four sets of timestamping registers that
i225 has available for TX.

In some TSN workloads, where multiple applications request hardware
transmission timestamps, it was possible that some of those requests
were denied because the only in use register was already occupied.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  20 ++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   3 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   7 +
 drivers/net/ethernet/intel/igc/igc_main.c    |  45 +++--
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 172 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_regs.h    |  12 ++
 6 files changed, 192 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 2b07a9dd29bb..6fd5901f07c7 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -67,6 +67,17 @@ struct igc_rx_packet_stats {
 	u64 other_packets;
 };
 
+#define IGC_MAX_TX_TSTAMP_TIMERS	4
+
+struct igc_tx_timestamp_request {
+	struct sk_buff *skb;
+	unsigned long start;
+	u32 mask;
+	u32 regl;
+	u32 regh;
+	u32 flags;
+};
+
 struct igc_ring_container {
 	struct igc_ring *ring;          /* pointer to linked list of rings */
 	unsigned int total_bytes;       /* total bytes processed this int */
@@ -220,9 +231,8 @@ struct igc_adapter {
 	 * ptp_tx_lock.
 	 */
 	spinlock_t ptp_tx_lock;
-	struct sk_buff *ptp_tx_skb;
+	struct igc_tx_timestamp_request tx_tstamp[IGC_MAX_TX_TSTAMP_TIMERS];
 	struct hwtstamp_config tstamp_config;
-	unsigned long ptp_tx_start;
 	unsigned int ptp_flags;
 	/* System time value lock */
 	spinlock_t tmreg_lock;
@@ -401,6 +411,10 @@ enum igc_tx_flags {
 	/* olinfo flags */
 	IGC_TX_FLAGS_IPV4	= 0x10,
 	IGC_TX_FLAGS_CSUM	= 0x20,
+
+	IGC_TX_FLAGS_TSTAMP_1	= 0x100,
+	IGC_TX_FLAGS_TSTAMP_2	= 0x200,
+	IGC_TX_FLAGS_TSTAMP_3	= 0x400,
 };
 
 enum igc_boards {
@@ -618,7 +632,7 @@ void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
 void igc_ptp_stop(struct igc_adapter *adapter);
 ktime_t igc_ptp_rx_pktstamp(struct igc_adapter *adapter, __le32 *buf);
-void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter);
+void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask);
 int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index ce530f5fd7bd..0d2b4482cb2f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -32,6 +32,9 @@ struct igc_adv_tx_context_desc {
 
 /* Adv Transmit Descriptor Config Masks */
 #define IGC_ADVTXD_MAC_TSTAMP	0x00080000 /* IEEE1588 Timestamp packet */
+#define IGC_ADVTXD_TSTAMP_REG_1	0x00010000 /* IEEE1588 Timestamp packet */
+#define IGC_ADVTXD_TSTAMP_REG_2	0x00020000 /* IEEE1588 Timestamp packet */
+#define IGC_ADVTXD_TSTAMP_REG_3	0x00030000 /* IEEE1588 Timestamp packet */
 #define IGC_ADVTXD_DTYP_CTXT	0x00200000 /* Advanced Context Descriptor */
 #define IGC_ADVTXD_DTYP_DATA	0x00300000 /* Advanced Data Descriptor */
 #define IGC_ADVTXD_DCMD_EOP	0x01000000 /* End of Packet */
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index c6315690e20f..04759c2c81eb 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -446,6 +446,9 @@
 
 /* Time Sync Transmit Control bit definitions */
 #define IGC_TSYNCTXCTL_TXTT_0			0x00000001  /* Tx timestamp reg 0 valid */
+#define IGC_TSYNCTXCTL_TXTT_1			0x00000002  /* Tx timestamp reg 1 valid */
+#define IGC_TSYNCTXCTL_TXTT_2			0x00000004  /* Tx timestamp reg 2 valid */
+#define IGC_TSYNCTXCTL_TXTT_3			0x00000008  /* Tx timestamp reg 3 valid */
 #define IGC_TSYNCTXCTL_ENABLED			0x00000010  /* enable Tx timestamping */
 #define IGC_TSYNCTXCTL_MAX_ALLOWED_DLY_MASK	0x0000F000  /* max delay */
 #define IGC_TSYNCTXCTL_SYNC_COMP_ERR		0x20000000  /* sync err */
@@ -453,6 +456,10 @@
 #define IGC_TSYNCTXCTL_START_SYNC		0x80000000  /* initiate sync */
 #define IGC_TSYNCTXCTL_TXSYNSIG			0x00000020  /* Sample TX tstamp in PHY sop */
 
+#define IGC_TSYNCTXCTL_TXTT_ANY ( \
+		IGC_TSYNCTXCTL_TXTT_0 | IGC_TSYNCTXCTL_TXTT_1 | \
+		IGC_TSYNCTXCTL_TXTT_2 | IGC_TSYNCTXCTL_TXTT_3)
+
 /* Timer selection bits */
 #define IGC_AUX_IO_TIMER_SEL_SYSTIM0	(0u << 30) /* Select SYSTIM0 for auxiliary time stamp */
 #define IGC_AUX_IO_TIMER_SEL_SYSTIM1	(1u << 30) /* Select SYSTIM1 for auxiliary time stamp */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 400b9de51475..a2e0b71d1f4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1146,6 +1146,15 @@ static u32 igc_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
 	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP,
 				 (IGC_ADVTXD_MAC_TSTAMP));
 
+	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP_1,
+				 (IGC_ADVTXD_TSTAMP_REG_1));
+
+	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP_2,
+				 (IGC_ADVTXD_TSTAMP_REG_2));
+
+	cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP_3,
+				 (IGC_ADVTXD_TSTAMP_REG_3));
+
 	/* insert frame checksum */
 	cmd_type ^= IGC_SET_FLAG(skb->no_fcs, 1, IGC_ADVTXD_DCMD_IFCS);
 
@@ -1403,6 +1412,26 @@ static int igc_tso(struct igc_ring *tx_ring,
 	return 1;
 }
 
+static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *skb, u32 *flags)
+{
+	int i;
+
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		if (tstamp->skb)
+			continue;
+
+		tstamp->skb = skb_get(skb);
+		tstamp->start = jiffies;
+		*flags = tstamp->flags;
+
+		return true;
+	}
+
+	return false;
+}
+
 static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 				       struct igc_ring *tx_ring)
 {
@@ -1438,20 +1467,14 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
+		u32 tstamp_flags;
 
 		spin_lock(&adapter->ptp_tx_lock);
 
-		/* FIXME: add support for retrieving timestamps from
-		 * the other timer registers before skipping the
-		 * timestamping request.
-		 */
 		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !adapter->ptp_tx_skb) {
+		    igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			tx_flags |= IGC_TX_FLAGS_TSTAMP;
-
-			adapter->ptp_tx_skb = skb_get(skb);
-			adapter->ptp_tx_start = jiffies;
+			tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
@@ -5001,9 +5024,7 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 	if (tsicr & IGC_TSICR_TXTS) {
 		u32 tsynctxctl = rd32(IGC_TSYNCTXCTL);;
 
-		/* retrieve hardware timestamp */
-		if (tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)
-			igc_ptp_tx_hwtstamp(adapter);
+		igc_ptp_tx_hwtstamp(adapter, tsynctxctl & IGC_TSYNCTXCTL_TXTT_ANY);
 
 		ack |= IGC_TSICR_TXTS;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 3ec0baa8451a..e286b0341575 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -541,8 +541,17 @@ static void igc_ptp_enable_tx_timestamp(struct igc_adapter *adapter)
 	wr32(IGC_TSYNCTXCTL, IGC_TSYNCTXCTL_ENABLED | IGC_TSYNCTXCTL_TXSYNSIG);
 
 	/* Read TXSTMP registers to discard any timestamp previously stored. */
-	rd32(IGC_TXSTMPL);
-	rd32(IGC_TXSTMPH);
+	rd32(IGC_TXSTMPL_0);
+	rd32(IGC_TXSTMPH_0);
+
+	rd32(IGC_TXSTMPL_1);
+	rd32(IGC_TXSTMPH_1);
+
+	rd32(IGC_TXSTMPL_2);
+	rd32(IGC_TXSTMPH_2);
+
+	rd32(IGC_TXSTMPL_3);
+	rd32(IGC_TXSTMPH_3);
 }
 
 /**
@@ -599,33 +608,40 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 }
 
 /* Requires adapter->ptp_tx_lock held by caller. */
-static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
+static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
+			       struct igc_tx_timestamp_request *tstamp)
 {
 	struct igc_hw *hw = &adapter->hw;
 
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
-	adapter->ptp_tx_skb = NULL;
-	adapter->ptp_tx_start = 0;
+	dev_kfree_skb_any(tstamp->skb);
+	tstamp->skb = NULL;
+	tstamp->start = 0;
 	adapter->tx_hwtstamp_timeouts++;
 	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
-	rd32(IGC_TXSTMPH);
+	rd32(tstamp->regh);
 
 	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
 }
 
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
+	struct igc_tx_timestamp_request *tstamp;
+	int i;
+
 	spin_lock(&adapter->ptp_tx_lock);
 
-	if (!adapter->ptp_tx_skb)
-		goto unlock;
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
+		tstamp = &adapter->tx_tstamp[i];
 
-	if (time_is_after_jiffies(adapter->ptp_tx_start + IGC_PTP_TX_TIMEOUT))
-		goto unlock;
+		if (!tstamp->skb)
+			continue;
 
-	igc_ptp_tx_timeout(adapter);
+		if (time_is_after_jiffies(tstamp->start + IGC_PTP_TX_TIMEOUT))
+			continue;
+
+		igc_ptp_tx_timeout(adapter, tstamp);
+	}
 
-unlock:
 	spin_unlock(&adapter->ptp_tx_lock);
 }
 
@@ -639,57 +655,73 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
  *
  * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
-void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
+void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask)
 {
 	struct skb_shared_hwtstamps shhwtstamps;
 	struct igc_hw *hw = &adapter->hw;
 	struct sk_buff *skb;
 	int adjust = 0;
 	u64 regval;
+	int i;
 
+again:
 	spin_lock(&adapter->ptp_tx_lock);
-	skb = adapter->ptp_tx_skb;
-
-	if (WARN_ON_ONCE(!skb))
-		goto done;
 
-	regval = rd32(IGC_TXSTMPL);
-	regval |= (u64)rd32(IGC_TXSTMPH) << 32;
-	igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
-
-	switch (adapter->link_speed) {
-	case SPEED_10:
-		adjust = IGC_I225_TX_LATENCY_10;
-		break;
-	case SPEED_100:
-		adjust = IGC_I225_TX_LATENCY_100;
-		break;
-	case SPEED_1000:
-		adjust = IGC_I225_TX_LATENCY_1000;
-		break;
-	case SPEED_2500:
-		adjust = IGC_I225_TX_LATENCY_2500;
-		break;
-	}
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		if (!(mask & tstamp->mask))
+			continue;
+
+		skb = tstamp->skb;
+		if (!skb)
+			continue;
+
+		regval = rd32(tstamp->regl);
+		regval |= (u64)rd32(tstamp->regh) << 32;
+		igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
+
+		switch (adapter->link_speed) {
+		case SPEED_10:
+			adjust = IGC_I225_TX_LATENCY_10;
+			break;
+		case SPEED_100:
+			adjust = IGC_I225_TX_LATENCY_100;
+			break;
+		case SPEED_1000:
+			adjust = IGC_I225_TX_LATENCY_1000;
+			break;
+		case SPEED_2500:
+			adjust = IGC_I225_TX_LATENCY_2500;
+			break;
+		}
 
-	shhwtstamps.hwtstamp =
-		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
+		shhwtstamps.hwtstamp =
+			ktime_add_ns(shhwtstamps.hwtstamp, adjust);
 
-	/* Clear the lock early before calling skb_tstamp_tx so that
-	 * applications are not woken up before the lock bit is clear. We use
-	 * a copy of the skb pointer to ensure other threads can't change it
-	 * while we're notifying the stack.
-	 */
-	adapter->ptp_tx_skb = NULL;
-	adapter->ptp_tx_start = 0;
+		/* Clear the lock early before calling skb_tstamp_tx so that
+		 * applications are not woken up before the lock bit is clear. We use
+		 * a copy of the skb pointer to ensure other threads can't change it
+		 * while we're notifying the stack.
+		 */
+		tstamp->skb = NULL;
+		tstamp->start = 0;
 
-	/* Notify the stack and free the skb after we've unlocked */
-	skb_tstamp_tx(skb, &shhwtstamps);
-	dev_kfree_skb_any(skb);
+		/* Notify the stack and free the skb after we've unlocked */
+		skb_tstamp_tx(skb, &shhwtstamps);
+		dev_kfree_skb_any(skb);
+	}
 
-done:
 	spin_unlock(&adapter->ptp_tx_lock);
 
+	mask = rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
+	if (mask) {
+		/* Some timestamps arrived while we were handling the
+		 * previous ones
+		 */
+		goto again;
+	}
+
 }
 
 /**
@@ -747,9 +779,34 @@ int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr)
 void igc_ptp_init(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct igc_tx_timestamp_request *tstamp;
 	struct igc_hw *hw = &adapter->hw;
 	int i;
 
+	tstamp = &adapter->tx_tstamp[0];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_0;
+	tstamp->regl = IGC_TXSTMPL_0;
+	tstamp->regh = IGC_TXSTMPH_0;
+	tstamp->flags = 0;
+
+	tstamp = &adapter->tx_tstamp[1];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_1;
+	tstamp->regl = IGC_TXSTMPL_1;
+	tstamp->regh = IGC_TXSTMPH_1;
+	tstamp->flags = IGC_TX_FLAGS_TSTAMP_1;
+
+	tstamp = &adapter->tx_tstamp[2];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_2;
+	tstamp->regl = IGC_TXSTMPL_2;
+	tstamp->regh = IGC_TXSTMPH_2;
+	tstamp->flags = IGC_TX_FLAGS_TSTAMP_2;
+
+	tstamp = &adapter->tx_tstamp[3];
+	tstamp->mask = IGC_TSYNCTXCTL_TXTT_3;
+	tstamp->regl = IGC_TXSTMPL_3;
+	tstamp->regh = IGC_TXSTMPH_3;
+	tstamp->flags = IGC_TX_FLAGS_TSTAMP_3;
+
 	switch (hw->mac.type) {
 	case igc_i225:
 		for (i = 0; i < IGC_N_SDP; i++) {
@@ -817,6 +874,19 @@ static void igc_ptp_time_restore(struct igc_adapter *adapter)
 	igc_ptp_write_i225(adapter, &ts);
 }
 
+static void igc_tx_tstamp_clear(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		dev_kfree_skb_any(tstamp->skb);
+		tstamp->skb = NULL;
+		tstamp->start = 0;
+	}
+}
+
 /**
  * igc_ptp_suspend - Disable PTP work items and prepare for suspend
  * @adapter: Board private structure
@@ -831,9 +901,7 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 
 	spin_lock(&adapter->ptp_tx_lock);
 
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
-	adapter->ptp_tx_skb = NULL;
-	adapter->ptp_tx_start = 0;
+	igc_tx_tstamp_clear(adapter);
 
 	spin_unlock(&adapter->ptp_tx_lock);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 828c3501c448..313b28e33165 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -242,6 +242,18 @@
 #define IGC_SYSTIMR	0x0B6F8  /* System time register Residue */
 #define IGC_TIMINCA	0x0B608  /* Increment attributes register - RW */
 
+/* TX Timestamp Low */
+#define IGC_TXSTMPL_0		0x0B618
+#define IGC_TXSTMPL_1		0x0B698
+#define IGC_TXSTMPL_2		0x0B6B8
+#define IGC_TXSTMPL_3		0x0B6D8
+
+/* TX Timestamp High */
+#define IGC_TXSTMPH_0		0x0B61C
+#define IGC_TXSTMPH_1		0x0B69C
+#define IGC_TXSTMPH_2		0x0B6BC
+#define IGC_TXSTMPH_3		0x0B6DC
+
 #define IGC_TXSTMPL	0x0B618  /* Tx timestamp value Low - RO */
 #define IGC_TXSTMPH	0x0B61C  /* Tx timestamp value High - RO */
 
-- 
2.32.0

