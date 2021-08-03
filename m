Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFBE3DE3C7
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhHCBEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:65282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233421AbhHCBEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327843"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480130"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [[RFC xdp-hints] 08/16] igc: Use irq safe locks for timestamping
Date:   Mon,  2 Aug 2021 18:03:23 -0700
Message-Id: <20210803010331.39453-9-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Now that the timestamping is done in interrupt context we should
protect against concurrent access using irq safe locks.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c |  5 +++--
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 16 ++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a2e0b71d1f4e..fe3619c25c05 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1467,9 +1467,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
+		unsigned long flags;
 		u32 tstamp_flags;
 
-		spin_lock(&adapter->ptp_tx_lock);
+		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
 		    igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
@@ -1479,7 +1480,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 			adapter->tx_hwtstamp_skipped++;
 		}
 
-		spin_unlock(&adapter->ptp_tx_lock);
+		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
 
 	if (skb_vlan_tag_present(skb)) {
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index e286b0341575..911c36a909a4 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -626,9 +626,10 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
 	struct igc_tx_timestamp_request *tstamp;
+	unsigned long flags;
 	int i;
 
-	spin_lock(&adapter->ptp_tx_lock);
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
 		tstamp = &adapter->tx_tstamp[i];
@@ -642,7 +643,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
 		igc_ptp_tx_timeout(adapter, tstamp);
 	}
 
-	spin_unlock(&adapter->ptp_tx_lock);
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 /**
@@ -659,13 +660,14 @@ void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask)
 {
 	struct skb_shared_hwtstamps shhwtstamps;
 	struct igc_hw *hw = &adapter->hw;
+	unsigned long flags;
 	struct sk_buff *skb;
 	int adjust = 0;
 	u64 regval;
 	int i;
 
 again:
-	spin_lock(&adapter->ptp_tx_lock);
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 	for (i = 0; i < IGC_MAX_TX_TSTAMP_TIMERS; i++) {
 		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
@@ -712,7 +714,7 @@ void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter, u32 mask)
 		dev_kfree_skb_any(skb);
 	}
 
-	spin_unlock(&adapter->ptp_tx_lock);
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 
 	mask = rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
 	if (mask) {
@@ -896,14 +898,16 @@ static void igc_tx_tstamp_clear(struct igc_adapter *adapter)
  */
 void igc_ptp_suspend(struct igc_adapter *adapter)
 {
+	unsigned long flags;
+
 	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
 		return;
 
-	spin_lock(&adapter->ptp_tx_lock);
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 	igc_tx_tstamp_clear(adapter);
 
-	spin_unlock(&adapter->ptp_tx_lock);
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 
 	igc_ptp_time_save(adapter);
 }
-- 
2.32.0

