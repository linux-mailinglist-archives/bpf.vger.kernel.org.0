Return-Path: <bpf+bounces-66047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86ABB2CF48
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 00:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9378E7A35A3
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB1322C9F;
	Tue, 19 Aug 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmiE+m9j"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95F31DD9F;
	Tue, 19 Aug 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642010; cv=none; b=I62h+O+MoTrDHilFuIkHU4ReBC0A+JxslRL0YxYtIYvsAtmI1iLhQz6UNvsUQ2HBMJISJYu49wB50yjiLsuFCH3JjzCxNzfJQIJhQAfs7Bwl3T8cjhlKTh/UCBVbTMGUm88nuQeeSvMWpSuVb6ch7DzaBxNotwSlYQWUmhtf3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642010; c=relaxed/simple;
	bh=qTwScyjioHSsDj0BnqZZRgvKP7UwEeCQX5ykxBAfJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikrL70YweivpwCyokWirdKFn5R99r2ZRx4oEJn5a5+4acwPKXgDGKTBhqQVEy8DGOm0iLUao+XYP6IJosfDB+uhdoPCY1yLLm+oFpwXFjL5cRFf9Y0V+FIp5ZuRQN703tCWkl9BxAXsW7TOE1UH3eW6JVeF4WEXuNvT8oTm1nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmiE+m9j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755642009; x=1787178009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTwScyjioHSsDj0BnqZZRgvKP7UwEeCQX5ykxBAfJvc=;
  b=GmiE+m9j46DE2Xy2aWEeGJ2cGUyANNRplLo3HquSIoyXb0eCMhtphXly
   r5nHqAr2yTSBmR+u/rWQMTbrFYha6IJMpuALrlibceQGGo0seW/HAK+Ty
   JwO34mUOvjhxlOHVW/FJ+7MBcm46TrCZcC4f9uN9g+OABpFg2CpSdtKor
   flQHjObIJ53mRm5rZejuWmr8U9RZZVPtS4oK2iEEMbOYQgVQf9ittkURo
   sA+e7E3Y1g2hgv2aa9vshmgGoSCtlawwExK+p9QNW5hoSmyd3kvdjavgs
   TgX9EqlEzMhfinA+NeBb6WecvJcz93RnuevBXCUR4om3CmiYaZXZm/CzI
   Q==;
X-CSE-ConnectionGUID: iQRu11NlQtaitbRjG2CGdQ==
X-CSE-MsgGUID: zQQUd8XlRQyEpU48Rpjmtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57829575"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57829575"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:20:06 -0700
X-CSE-ConnectionGUID: lbhkdObjTza57zziIMBvKw==
X-CSE-MsgGUID: xMlBvJMRTEmL8w+FImd/iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173202849"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2025 15:20:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 4/5] ixgbe: fix ndo_xdp_xmit() workloads
Date: Tue, 19 Aug 2025 15:19:58 -0700
Message-ID: <20250819222000.3504873-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Currently ixgbe driver checks periodically in its watchdog subtask if
there is anything to be transmitted (considering both Tx and XDP rings)
under state of carrier not being 'ok'. Such event is interpreted as Tx
hang and therefore results in interface reset.

This is currently problematic for ndo_xdp_xmit() as it is allowed to
produce descriptors when interface is going through reset or its carrier
is turned off.

Furthermore, XDP rings should not really be objects of Tx hang
detection. This mechanism is rather a matter of ndo_tx_timeout() being
called from dev_watchdog against Tx rings exposed to networking stack.

Taking into account issues described above, let us have a two fold fix -
do not respect XDP rings in local ixgbe watchdog and do not produce Tx
descriptors in ndo_xdp_xmit callback when there is some problem with
carrier currently. For now, keep the Tx hang checks in clean Tx irq
routine, but adjust it to not execute for XDP rings.

Cc: Tobias Böhm <tobias.boehm@hetzner-cloud.de>
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/netdev/eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de/
Fixes: 6453073987ba ("ixgbe: add initial support for xdp redirect")
Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 ++++++-------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6122a0abb41f..80e6a2ef1350 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -968,10 +968,6 @@ static void ixgbe_update_xoff_rx_lfc(struct ixgbe_adapter *adapter)
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		clear_bit(__IXGBE_HANG_CHECK_ARMED,
 			  &adapter->tx_ring[i]->state);
-
-	for (i = 0; i < adapter->num_xdp_queues; i++)
-		clear_bit(__IXGBE_HANG_CHECK_ARMED,
-			  &adapter->xdp_ring[i]->state);
 }
 
 static void ixgbe_update_xoff_received(struct ixgbe_adapter *adapter)
@@ -1214,7 +1210,7 @@ static void ixgbe_pf_handle_tx_hang(struct ixgbe_ring *tx_ring,
 	struct ixgbe_adapter *adapter = netdev_priv(tx_ring->netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 
-	e_err(drv, "Detected Tx Unit Hang%s\n"
+	e_err(drv, "Detected Tx Unit Hang\n"
 		   "  Tx Queue             <%d>\n"
 		   "  TDH, TDT             <%x>, <%x>\n"
 		   "  next_to_use          <%x>\n"
@@ -1222,16 +1218,14 @@ static void ixgbe_pf_handle_tx_hang(struct ixgbe_ring *tx_ring,
 		   "tx_buffer_info[next_to_clean]\n"
 		   "  time_stamp           <%lx>\n"
 		   "  jiffies              <%lx>\n",
-	      ring_is_xdp(tx_ring) ? " (XDP)" : "",
 	      tx_ring->queue_index,
 	      IXGBE_READ_REG(hw, IXGBE_TDH(tx_ring->reg_idx)),
 	      IXGBE_READ_REG(hw, IXGBE_TDT(tx_ring->reg_idx)),
 	      tx_ring->next_to_use, next,
 	      tx_ring->tx_buffer_info[next].time_stamp, jiffies);
 
-	if (!ring_is_xdp(tx_ring))
-		netif_stop_subqueue(tx_ring->netdev,
-				    tx_ring->queue_index);
+	netif_stop_subqueue(tx_ring->netdev,
+			    tx_ring->queue_index);
 }
 
 /**
@@ -1451,6 +1445,9 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 				   total_bytes);
 	adapter->tx_ipsec += total_ipsec;
 
+	if (ring_is_xdp(tx_ring))
+		return !!budget;
+
 	if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
 		if (adapter->hw.mac.type == ixgbe_mac_e610)
 			ixgbe_handle_mdd_event(adapter, tx_ring);
@@ -1468,9 +1465,6 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 		return true;
 	}
 
-	if (ring_is_xdp(tx_ring))
-		return !!budget;
-
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
 	txq = netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 	if (!__netif_txq_completed_wake(txq, total_packets, total_bytes,
@@ -7974,12 +7968,9 @@ static void ixgbe_check_hang_subtask(struct ixgbe_adapter *adapter)
 		return;
 
 	/* Force detection of hung controller */
-	if (netif_carrier_ok(adapter->netdev)) {
+	if (netif_carrier_ok(adapter->netdev))
 		for (i = 0; i < adapter->num_tx_queues; i++)
 			set_check_for_tx_hang(adapter->tx_ring[i]);
-		for (i = 0; i < adapter->num_xdp_queues; i++)
-			set_check_for_tx_hang(adapter->xdp_ring[i]);
-	}
 
 	if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED)) {
 		/*
@@ -8199,13 +8190,6 @@ static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
 			return true;
 	}
 
-	for (i = 0; i < adapter->num_xdp_queues; i++) {
-		struct ixgbe_ring *ring = adapter->xdp_ring[i];
-
-		if (ring->next_to_use != ring->next_to_clean)
-			return true;
-	}
-
 	return false;
 }
 
@@ -11005,6 +10989,10 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(test_bit(__IXGBE_DOWN, &adapter->state)))
 		return -ENETDOWN;
 
+	if (!netif_carrier_ok(adapter->netdev) ||
+	    !netif_running(adapter->netdev))
+		return -ENETDOWN;
+
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
-- 
2.47.1


