Return-Path: <bpf+bounces-48016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BDA0328E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D950164A59
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83301E1C0F;
	Mon,  6 Jan 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mw8qMG8T"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26141E0B62;
	Mon,  6 Jan 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201980; cv=none; b=lTHuvjDPBDOJOXCpM6lYU3EAU+MYipFd4p82brDKDMooBMmB3gE51adDOODO5hho7r3LYjuApz6eW7B96meDKJptN8th9NY4OZujQJA7x5o7J/guEkajGm7C799HNusJF1utodHrr2z4aBNFVPl5CXORK0nLnDDm7T9+PjkgWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201980; c=relaxed/simple;
	bh=EW+X27cQKRRKdFG71urV7lxxRW+AWaUwm1YTUq6uFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBD+/MRMhFoyX/zKeus8UegSiVtF//MGRFoD5U68H+VOwK1YiBVpcTbwRxAEu6Vvu1+5iAygMZZrBQy7z9xlzTOunAjNSDHhLuIfs/c92apgmMzFbiJzwEZQVuha3l0QPP9kifi3f91nJLlebDRRIm3XMB4QKeEtRsUR/cReefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mw8qMG8T; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201979; x=1767737979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EW+X27cQKRRKdFG71urV7lxxRW+AWaUwm1YTUq6uFSc=;
  b=mw8qMG8TuVuzHhj3245manFg3hOT8tOYSoXbO2YRxGNaEwgduiMKQUvs
   dpp0gKFB70Xwmc2cH6wZBWyFNYWD9s581th0X3piH5HU30ojWWI3jWR2L
   vfEDUNVFjx6Mk+S5K9bfiKunMtEiIbqNJJPhh3twZRgHYCBQO2SIlv1Sv
   4DqH5J+q43Yu+CBuNjsiODsASO3lRwISp9ze0toLdNRRTX0VloXeW6fYX
   GgrM8Wj6KjVp/Hs2zSHAcVzJ2XS0SrfrOthWPKu+tagJhmhficsQbo6Dk
   gvjiow2VQjjF9/2IKSpXE13ZzH4C6M1r2HMaYGqemPLXc8aevYvt5DJBy
   Q==;
X-CSE-ConnectionGUID: svsn6uB4R2eYAhx+vpqNmg==
X-CSE-MsgGUID: 0nC02ZdaSzuJDP/DPJ/gAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858677"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:37 -0800
X-CSE-ConnectionGUID: EpBPKP8ISaOFJ/9WD4ITHA==
X-CSE-MsgGUID: 1JGjzdO7TY6Ay7IsezRQtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368460"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	sriram.yagnaraman@ericsson.com,
	richardcochran@gmail.com,
	benjamin.steinke@woks-audio.com,
	bigeasy@linutronix.de,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Subject: [PATCH net-next 04/15] igb: Add XDP finalize and stats update functions
Date: Mon,  6 Jan 2025 14:19:12 -0800
Message-ID: <20250106221929.956999-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

Move XDP finalize and Rx statistics update into separate functions. This
way, they can be reused by the XDP and XDP/ZC code later.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  3 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 54 +++++++++++++++--------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c30d6f9708f8..1e65b41a48d8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -740,6 +740,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring);
 void igb_clean_rx_ring(struct igb_ring *rx_ring);
 void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
+void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status);
+void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
+			 unsigned int bytes);
 void igb_setup_tctl(struct igb_adapter *);
 void igb_setup_rctl(struct igb_adapter *);
 void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8329096af8ef..be914b44e39d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8856,6 +8856,38 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 	rx_buffer->page = NULL;
 }
 
+void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status)
+{
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+
+	if (status & IGB_XDP_REDIR)
+		xdp_do_flush();
+
+	if (status & IGB_XDP_TX) {
+		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
+
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
+		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
+	}
+}
+
+void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
+			 unsigned int bytes)
+{
+	struct igb_ring *ring = q_vector->rx.ring;
+
+	u64_stats_update_begin(&ring->rx_syncp);
+	ring->rx_stats.packets += packets;
+	ring->rx_stats.bytes += bytes;
+	u64_stats_update_end(&ring->rx_syncp);
+
+	q_vector->rx.total_packets += packets;
+	q_vector->rx.total_bytes += bytes;
+}
+
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
 	unsigned int total_bytes = 0, total_packets = 0;
@@ -8863,9 +8895,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	struct igb_ring *rx_ring = q_vector->rx.ring;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
 	struct sk_buff *skb = rx_ring->skb;
-	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
-	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8987,24 +9017,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	/* place incomplete frames back on ring for completion */
 	rx_ring->skb = skb;
 
-	if (xdp_xmit & IGB_XDP_REDIR)
-		xdp_do_flush();
-
-	if (xdp_xmit & IGB_XDP_TX) {
-		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
-
-		nq = txring_txq(tx_ring);
-		__netif_tx_lock(nq, cpu);
-		igb_xdp_ring_update_tail(tx_ring);
-		__netif_tx_unlock(nq);
-	}
+	if (xdp_xmit)
+		igb_finalize_xdp(adapter, xdp_xmit);
 
-	u64_stats_update_begin(&rx_ring->rx_syncp);
-	rx_ring->rx_stats.packets += total_packets;
-	rx_ring->rx_stats.bytes += total_bytes;
-	u64_stats_update_end(&rx_ring->rx_syncp);
-	q_vector->rx.total_packets += total_packets;
-	q_vector->rx.total_bytes += total_bytes;
+	igb_update_rx_stats(q_vector, total_packets, total_bytes);
 
 	if (cleaned_count)
 		igb_alloc_rx_buffers(rx_ring, cleaned_count);
-- 
2.47.1


