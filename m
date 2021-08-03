Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943913DE3C6
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhHCBEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhHCBEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327837"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327837"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480119"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org, Andre Guedes <andre.guedes@intel.com>
Subject: [[RFC xdp-hints] 05/16] igc: Fix race condition in PTP Tx code
Date:   Mon,  2 Aug 2021 18:03:20 -0700
Message-Id: <20210803010331.39453-6-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andre Guedes <andre.guedes@intel.com>

Currently, the igc driver supports timestamping only one Tx packet at a
time. During the transmission flow, the skb that requires hardware
timestamping is saved in adapter->ptp_tx_skb. Once hardware has the
timestamp, an interrupt is delivered, and adapter->ptp_tx_work is
scheduled. In igc_ptp_tx_work(), we read the timestamp register, update
adapter->ptp_tx_skb, and notify the network stack.

While the thread executing the transmission flow (the user process
running in kernel mode) and the thread executing ptp_tx_work don't
access adapter->ptp_tx_skb concurrently, there are two other places
where adapter->ptp_tx_skb is accessed: igc_ptp_tx_hang() and
igc_ptp_suspend().

igc_ptp_tx_hang() is executed by the adapter->watchdog_task worker
thread which runs periodically so it is possible we have two threads
accessing ptp_tx_skb at the same time. Consider the following scenario:
right after __IGC_PTP_TX_IN_PROGRESS is set in igc_xmit_frame_ring(),
igc_ptp_tx_hang() is executed. Since adapter->ptp_tx_start hasn't been
written yet, this is considered a timeout and adapter->ptp_tx_skb is
cleaned up.

This patch fixes the issue described above by adding the ptp_tx_lock to
protect access to ptp_tx_skb and ptp_tx_start fields from igc_adapter.
Since igc_xmit_frame_ring() called in atomic context by the networking
stack, ptp_tx_lock is defined as a spinlock.

With the introduction of the ptp_tx_lock, the __IGC_PTP_TX_IN_PROGRESS
flag doesn't provide much of a use anymore so this patch gets rid of it.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  5 ++-
 drivers/net/ethernet/intel/igc/igc_main.c |  7 +++-
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 49 ++++++++++++++---------
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index a0ecfe5a4078..10635588263e 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -217,6 +217,10 @@ struct igc_adapter {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
 	struct work_struct ptp_tx_work;
+	/* Access to ptp_tx_skb and ptp_tx_start is protected by the
+	 * ptp_tx_lock.
+	 */
+	spinlock_t ptp_tx_lock;
 	struct sk_buff *ptp_tx_skb;
 	struct hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
@@ -387,7 +391,6 @@ enum igc_state_t {
 	__IGC_TESTING,
 	__IGC_RESETTING,
 	__IGC_DOWN,
-	__IGC_PTP_TX_IN_PROGRESS,
 };
 
 enum igc_tx_flags {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5c95bf82eaf7..ae6ceb0790d8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1439,13 +1439,14 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
 
+		spin_lock(&adapter->ptp_tx_lock);
+
 		/* FIXME: add support for retrieving timestamps from
 		 * the other timer registers before skipping the
 		 * timestamping request.
 		 */
 		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !test_and_set_bit_lock(__IGC_PTP_TX_IN_PROGRESS,
-					   &adapter->state)) {
+		    !adapter->ptp_tx_skb) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP;
 
@@ -1454,6 +1455,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
+
+		spin_unlock(&adapter->ptp_tx_lock);
 	}
 
 	if (skb_vlan_tag_present(skb)) {
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 69617d2c1be2..92ed2760485b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -598,35 +598,35 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	return 0;
 }
 
+/* Requires adapter->ptp_tx_lock held by caller. */
 static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
+	adapter->ptp_tx_start = 0;
 	adapter->tx_hwtstamp_timeouts++;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
 	rd32(IGC_TXSTMPH);
+
 	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
 }
 
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
-	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
-					      IGC_PTP_TX_TIMEOUT);
+	spin_lock(&adapter->ptp_tx_lock);
 
-	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	if (!adapter->ptp_tx_skb)
+		goto unlock;
 
-	/* If we haven't received a timestamp within the timeout, it is
-	 * reasonable to assume that it will never occur, so we can unlock the
-	 * timestamp bit when this occurs.
-	 */
-	if (timeout) {
-		cancel_work_sync(&adapter->ptp_tx_work);
-		igc_ptp_tx_timeout(adapter);
-	}
+	if (time_is_after_jiffies(adapter->ptp_tx_start + IGC_PTP_TX_TIMEOUT))
+		goto unlock;
+
+	igc_ptp_tx_timeout(adapter);
+
+unlock:
+	spin_unlock(&adapter->ptp_tx_lock);
 }
 
 /**
@@ -636,6 +636,8 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
  * If we were asked to do hardware stamping and such a time stamp is
  * available, then it must have been for this skb here because we only
  * allow only one such packet into the queue.
+ *
+ * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
@@ -676,7 +678,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 	 * while we're notifying the stack.
 	 */
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
+	adapter->ptp_tx_start = 0;
 
 	/* Notify the stack and free the skb after we've unlocked */
 	skb_tstamp_tx(skb, &shhwtstamps);
@@ -697,14 +699,19 @@ static void igc_ptp_tx_work(struct work_struct *work)
 	struct igc_hw *hw = &adapter->hw;
 	u32 tsynctxctl;
 
-	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	spin_lock(&adapter->ptp_tx_lock);
+
+	if (!adapter->ptp_tx_skb)
+		goto unlock;
 
 	tsynctxctl = rd32(IGC_TSYNCTXCTL);
 	if (WARN_ON_ONCE(!(tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)))
-		return;
+		goto unlock;
 
 	igc_ptp_tx_hwtstamp(adapter);
+
+unlock:
+	spin_unlock(&adapter->ptp_tx_lock);
 }
 
 /**
@@ -795,6 +802,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 	}
 
 	spin_lock_init(&adapter->tmreg_lock);
+	spin_lock_init(&adapter->ptp_tx_lock);
 	INIT_WORK(&adapter->ptp_tx_work, igc_ptp_tx_work);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
@@ -845,9 +853,14 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 		return;
 
 	cancel_work_sync(&adapter->ptp_tx_work);
+
+	spin_lock(&adapter->ptp_tx_lock);
+
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
+	adapter->ptp_tx_start = 0;
+
+	spin_unlock(&adapter->ptp_tx_lock);
 
 	igc_ptp_time_save(adapter);
 }
-- 
2.32.0

