Return-Path: <bpf+bounces-48013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69642A03288
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20471164958
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0A1E0DD8;
	Mon,  6 Jan 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGXfsT9N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3981DDA20;
	Mon,  6 Jan 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201978; cv=none; b=AFt6io3pLPJhdH20/3hkW1wwYqCZlfJw/+o1NLt8m1HvImiURZO5QipjHVF1EZP7wAFM+XChC9BeaxXfofiTOObUzpR0yzzEuhkj9Wzt6LeTPRBkbYnKY6KFuFhxqTaNuDv95xLnkeg3vF+RqnwF1/nkZnLoFTDAMV/kGwxsOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201978; c=relaxed/simple;
	bh=IgI2SyTkBZHlvj4ckcuh3LRMyWqn9MpcvLgf1yCGs2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXNyaroYbl0qc/RQBbqASv0f1pVsNop0tJ/S6EgxEqjJTKRfc2WlFq8JdoauU2JKGVAwtlZWaVHnJOnUOy4u0rH+Me0YHlueywNsZZeFx9hGv7yy6rr7AjLAjI+2g/JeurCfBLvSpg8dF1VyBc8y/kPkt5Oqhi+JWB0bTqNhrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGXfsT9N; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201977; x=1767737977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgI2SyTkBZHlvj4ckcuh3LRMyWqn9MpcvLgf1yCGs2Q=;
  b=hGXfsT9NBrCa290+EAxVK5IymyfoMdZfpJF71fX5/EPYjgq/sZgjFvvZ
   GeU1JF+crOv6HZcKAKDJBOMpXGGiPn49OuBNRt/M5Hg8fXBcPlE/4Gpl+
   zpRL2Q+jZQ8tzaag9yg3Hd46sQDARkix5uatP4V575veFLslYRoasWAPM
   g2BmI4ERl2+hBKFM1Gk+nc0mex6tAcihvCc56CTJByud/Ra+9/QGARGxx
   7/s/WQAyiZMU5Elpg1v/t6uXpR4D7nbhV+aZA8lhOQCgAFFnciYMwrYmi
   3ywxZFU6CfAu4eiwCynJxIzBE5t9dskjtxaeq198XkkYtwhAV1mUwy7iT
   w==;
X-CSE-ConnectionGUID: vUKVZVHBQ8K0h5nfvSWa1w==
X-CSE-MsgGUID: GY3MMfc6SF6ZF626FPWzHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858641"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:35 -0800
X-CSE-ConnectionGUID: T52CwA8pSDuCDit5hYflEQ==
X-CSE-MsgGUID: qo8852YuRL69eZVr8cNbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368451"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
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
Subject: [PATCH net-next 01/15] igb: Remove static qualifiers
Date: Mon,  6 Jan 2025 14:19:09 -0800
Message-ID: <20250106221929.956999-2-anthony.l.nguyen@intel.com>
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

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Remove static qualifiers on the following functions to be able to call
from XSK specific file that is added in the later patches:
- igb_xdp_tx_queue_mapping()
- igb_xdp_ring_update_tail()
- igb_clean_tx_ring()
- igb_clean_rx_ring()
- igb_xdp_xmit_back()
- igb_process_skb_fields()

While at it, inline igb_xdp_tx_queue_mapping() and
igb_xdp_ring_update_tail(). These functions are small enough and used in
XDP hot paths.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Split patches, inline small XDP functions]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      | 29 ++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 37 ++++-------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 3c2dc7bdebb5..1bfe703e73d9 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -18,6 +18,7 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/pci.h>
 #include <linux/mdio.h>
+#include <linux/lockdep.h>
 
 #include <net/xdp.h>
 
@@ -731,12 +732,18 @@ int igb_setup_tx_resources(struct igb_ring *);
 int igb_setup_rx_resources(struct igb_ring *);
 void igb_free_tx_resources(struct igb_ring *);
 void igb_free_rx_resources(struct igb_ring *);
+void igb_clean_tx_ring(struct igb_ring *tx_ring);
+void igb_clean_rx_ring(struct igb_ring *rx_ring);
 void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_setup_tctl(struct igb_adapter *);
 void igb_setup_rctl(struct igb_adapter *);
 void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
 netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
+int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp);
+void igb_process_skb_fields(struct igb_ring *rx_ring,
+			    union e1000_adv_rx_desc *rx_desc,
+			    struct sk_buff *skb);
 void igb_alloc_rx_buffers(struct igb_ring *, u16);
 void igb_update_stats(struct igb_adapter *);
 bool igb_has_link(struct igb_adapter *adapter);
@@ -797,6 +804,28 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
 	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 }
 
+/* This function assumes __netif_tx_lock is held by the caller. */
+static inline void igb_xdp_ring_update_tail(struct igb_ring *ring)
+{
+	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
+
+	/* Force memory writes to complete before letting h/w know there
+	 * are new descriptors to fetch.
+	 */
+	wmb();
+	writel(ring->next_to_use, ring->tail);
+}
+
+static inline struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
+{
+	unsigned int r_idx = smp_processor_id();
+
+	if (r_idx >= adapter->num_tx_queues)
+		r_idx = r_idx % adapter->num_tx_queues;
+
+	return adapter->tx_ring[r_idx];
+}
+
 int igb_add_filter(struct igb_adapter *adapter,
 		   struct igb_nfc_filter *input);
 int igb_erase_filter(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 288a4bb2683a..77a6d1470f8b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -33,7 +33,6 @@
 #include <linux/bpf_trace.h>
 #include <linux/pm_runtime.h>
 #include <linux/etherdevice.h>
-#include <linux/lockdep.h>
 #ifdef CONFIG_IGB_DCA
 #include <linux/dca.h>
 #endif
@@ -116,8 +115,6 @@ static void igb_configure_tx(struct igb_adapter *);
 static void igb_configure_rx(struct igb_adapter *);
 static void igb_clean_all_tx_rings(struct igb_adapter *);
 static void igb_clean_all_rx_rings(struct igb_adapter *);
-static void igb_clean_tx_ring(struct igb_ring *);
-static void igb_clean_rx_ring(struct igb_ring *);
 static void igb_set_rx_mode(struct net_device *);
 static void igb_update_phy_info(struct timer_list *);
 static void igb_watchdog(struct timer_list *);
@@ -2919,29 +2916,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
-/* This function assumes __netif_tx_lock is held by the caller. */
-static void igb_xdp_ring_update_tail(struct igb_ring *ring)
-{
-	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
-
-	/* Force memory writes to complete before letting h/w know there
-	 * are new descriptors to fetch.
-	 */
-	wmb();
-	writel(ring->next_to_use, ring->tail);
-}
-
-static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
-{
-	unsigned int r_idx = smp_processor_id();
-
-	if (r_idx >= adapter->num_tx_queues)
-		r_idx = r_idx % adapter->num_tx_queues;
-
-	return adapter->tx_ring[r_idx];
-}
-
-static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
+int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 {
 	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
 	int cpu = smp_processor_id();
@@ -4888,7 +4863,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
  *  igb_clean_tx_ring - Free Tx Buffers
  *  @tx_ring: ring to be cleaned
  **/
-static void igb_clean_tx_ring(struct igb_ring *tx_ring)
+void igb_clean_tx_ring(struct igb_ring *tx_ring)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
@@ -5007,7 +4982,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
  *  igb_clean_rx_ring - Free Rx Buffers per Queue
  *  @rx_ring: ring to free buffers from
  **/
-static void igb_clean_rx_ring(struct igb_ring *rx_ring)
+void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;
 
@@ -8786,9 +8761,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
  *  order to populate the hash, checksum, VLAN, timestamp, protocol, and
  *  other fields within the skb.
  **/
-static void igb_process_skb_fields(struct igb_ring *rx_ring,
-				   union e1000_adv_rx_desc *rx_desc,
-				   struct sk_buff *skb)
+void igb_process_skb_fields(struct igb_ring *rx_ring,
+			    union e1000_adv_rx_desc *rx_desc,
+			    struct sk_buff *skb)
 {
 	struct net_device *dev = rx_ring->netdev;
 
-- 
2.47.1


