Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0393DE3C4
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhHCBEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:65282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233312AbhHCBEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327838"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327838"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480121"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [[RFC xdp-hints] 06/16] igc: Retrieve the TX timestamp directly (instead of in a interrupt)
Date:   Mon,  2 Aug 2021 18:03:21 -0700
Message-Id: <20210803010331.39453-7-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Handling of TX timestamp interrupt should be simple enough to not cause
issues during the interrupt context. This way, the processing is
simplified and potentially more performant.

This patch is inspired by the i40 driver approach.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c |  6 +++-
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 41 +++++------------------
 3 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 10635588263e..2b07a9dd29bb 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -216,7 +216,6 @@ struct igc_adapter {
 
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
-	struct work_struct ptp_tx_work;
 	/* Access to ptp_tx_skb and ptp_tx_start is protected by the
 	 * ptp_tx_lock.
 	 */
@@ -619,6 +618,7 @@ void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
 void igc_ptp_stop(struct igc_adapter *adapter);
 ktime_t igc_ptp_rx_pktstamp(struct igc_adapter *adapter, __le32 *buf);
+void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter);
 int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ae6ceb0790d8..400b9de51475 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4999,8 +4999,12 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 	}
 
 	if (tsicr & IGC_TSICR_TXTS) {
+		u32 tsynctxctl = rd32(IGC_TSYNCTXCTL);;
+
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		if (tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)
+			igc_ptp_tx_hwtstamp(adapter);
+
 		ack |= IGC_TSICR_TXTS;
 	}
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 92ed2760485b..3ec0baa8451a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -639,16 +639,19 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
  *
  * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
-static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
+void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
-	struct sk_buff *skb = adapter->ptp_tx_skb;
 	struct skb_shared_hwtstamps shhwtstamps;
 	struct igc_hw *hw = &adapter->hw;
+	struct sk_buff *skb;
 	int adjust = 0;
 	u64 regval;
 
+	spin_lock(&adapter->ptp_tx_lock);
+	skb = adapter->ptp_tx_skb;
+
 	if (WARN_ON_ONCE(!skb))
-		return;
+		goto done;
 
 	regval = rd32(IGC_TXSTMPL);
 	regval |= (u64)rd32(IGC_TXSTMPH) << 32;
@@ -683,35 +686,10 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 	/* Notify the stack and free the skb after we've unlocked */
 	skb_tstamp_tx(skb, &shhwtstamps);
 	dev_kfree_skb_any(skb);
-}
 
-/**
- * igc_ptp_tx_work
- * @work: pointer to work struct
- *
- * This work function polls the TSYNCTXCTL valid bit to determine when a
- * timestamp has been taken for the current stored skb.
- */
-static void igc_ptp_tx_work(struct work_struct *work)
-{
-	struct igc_adapter *adapter = container_of(work, struct igc_adapter,
-						   ptp_tx_work);
-	struct igc_hw *hw = &adapter->hw;
-	u32 tsynctxctl;
-
-	spin_lock(&adapter->ptp_tx_lock);
-
-	if (!adapter->ptp_tx_skb)
-		goto unlock;
-
-	tsynctxctl = rd32(IGC_TSYNCTXCTL);
-	if (WARN_ON_ONCE(!(tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)))
-		goto unlock;
-
-	igc_ptp_tx_hwtstamp(adapter);
-
-unlock:
+done:
 	spin_unlock(&adapter->ptp_tx_lock);
+
 }
 
 /**
@@ -803,7 +781,6 @@ void igc_ptp_init(struct igc_adapter *adapter)
 
 	spin_lock_init(&adapter->tmreg_lock);
 	spin_lock_init(&adapter->ptp_tx_lock);
-	INIT_WORK(&adapter->ptp_tx_work, igc_ptp_tx_work);
 
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
@@ -852,8 +829,6 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
 		return;
 
-	cancel_work_sync(&adapter->ptp_tx_work);
-
 	spin_lock(&adapter->ptp_tx_lock);
 
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
-- 
2.32.0

