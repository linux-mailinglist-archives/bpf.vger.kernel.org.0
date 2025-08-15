Return-Path: <bpf+bounces-65793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED8B2874D
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 22:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88015E2055
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC9308F2D;
	Fri, 15 Aug 2025 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJVuOE6f"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA82C0F80;
	Fri, 15 Aug 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290536; cv=none; b=J5dNEnqygF16HrhQVB4Zo+bvAdpsgJQCFR3GOFilp0idOvCgQGkdqj8Rp6ZnoHoxvCeb8txwBbzHlxgXJmHPywgZIWKuXYMrEBjRptiM5X2Kn59bIDuboKYwCLnfyhEzO1PLGgxcrgGalUQDxVk/pDTtPLdMlaqJ3Rb5Znpi8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290536; c=relaxed/simple;
	bh=qTwScyjioHSsDj0BnqZZRgvKP7UwEeCQX5ykxBAfJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/DL/1YWSY+T62k2dRoSeJMWNi5LiD70g89I+vxeLSat+kLMkUdTUbaRuqmUewxj7HU7LRM86BY4fnIjxAN0sUgsiOiWIHe6Lehaum11UiSm+WB6i1DOxnJkQIyokV2nA/P1+gkdljA1f7TIILrzJFRP7+s/Q48T6wJdTqUp+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJVuOE6f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755290534; x=1786826534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTwScyjioHSsDj0BnqZZRgvKP7UwEeCQX5ykxBAfJvc=;
  b=RJVuOE6f8TKfWP7zdtggkCKcQ17l8WsVp53B3YoFMLsAP9tBH3wRcy3H
   RnybWHgsT25G7J77IPIlDuHwr2Z+249rt5f0oCIeYcIoi+mbhDxBMdq6u
   QeW2YAw5fwKK31uUgrHceHDYaa6y/Q/TdLlFQDyYVmTjVZsdyRBvgup1F
   HvS0p5De9MxnuZvbNGCAGBouqnC/3yipiemSC1SO882e7thxDrAbA3WNy
   gpv40N7LynXlruP8HZAGWl/ZhpkLFZYqu9FJoXIvBlivWl1BMJVkX5ofO
   dN7w0ewIist33wUp1QrV6hguKskgW9AfXtIFjDgQyilBbK7DUrn2fUZYu
   w==;
X-CSE-ConnectionGUID: 1TwbAUZ2SnqiK+26PpJpzQ==
X-CSE-MsgGUID: u13PfKJwRFWcACsk0T4/2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68320327"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68320327"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:42:11 -0700
X-CSE-ConnectionGUID: OnXMJl7gQsqmPru+UvGeoA==
X-CSE-MsgGUID: eMXSpnxmQfiQVKt8hnIFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198084326"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 13:42:10 -0700
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
Subject: [PATCH net 5/6] ixgbe: fix ndo_xdp_xmit() workloads
Date: Fri, 15 Aug 2025 13:42:01 -0700
Message-ID: <20250815204205.1407768-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
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


