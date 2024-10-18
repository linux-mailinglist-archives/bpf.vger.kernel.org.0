Return-Path: <bpf+bounces-42378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C749A38C8
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E101C23F85
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A818EFD4;
	Fri, 18 Oct 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIa6xUnT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5/+sYUiP"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285D188CD8;
	Fri, 18 Oct 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240809; cv=none; b=hpwrewOy7I8KAedZ5TdM+P8Z07vxrM2wqteABf5srE+HFwOa18oXBTEL6tCnYbfxqvt4CQrT73las0L1OMy9CNOcZuIUO/6hQLWdEJ78EW8NhWvVuEoI6RTNDtPufIgBUu1ygAIIAM8Cuv7LA7BhuyDAU3GsOZwhY+bXh74bn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240809; c=relaxed/simple;
	bh=+fA6nhglS6ZT/ZJLig8lFuvpgLKu6VoBFoYP6DM22tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTiHivuVMXao4UaZqsxx8Zz7V82aj6A2PrMlF46gPsLBTKTN4yb07tScbtc63sPv6MhFcrCyfJ33BMHNgT+Ps3IFXOwYcJ3gLDDx/XEISOvAMAKMtpJSat6l9BRdOCRfMrYLjBtCCuEpJkzZIMiCucnRNLM9RbP30g9ivQfamA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIa6xUnT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5/+sYUiP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729240805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMV5IKYRE0bfzD6vtMbN46Iti3rOQFEW1vD3ct3pc0g=;
	b=vIa6xUnTJv29RImXeZX90VpLQZIT6ByQJjT82sC8FOu3KFR5zN5+uWTqiFFhDyhTdKACEi
	A0joB0hgawY8Bicf5DUVHgkkceS+aIZkKZjmwT7FtaGNk5NsCJcyXtsGXHHvHNAfQrkRLa
	bXDLipsOC3pFxp5k1FUcmKdgOQm73wx5NE7k45jnabh3uwBbZbEkhHSXqGveiylfwIfnfP
	2mwnWIgx9VywSqbrwTlTMMpy6EbzXn7i1BmwPNSkPIhhu9ktN4yqFX5ohhMC+DjfN49GQ6
	5UqlwOSuUCIBV1jYQKnM5RvBw1+amqdemoibdz8Jz5MgmVc8W7VWivRnvYdWUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729240805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMV5IKYRE0bfzD6vtMbN46Iti3rOQFEW1vD3ct3pc0g=;
	b=5/+sYUiPTn7m74okdGHIND8GuRcNSMGKgvav2rCt628CGcqNE/RxPmks/x5im118ib0W2v
	MtEb+yN12mp/WXDA==
Date: Fri, 18 Oct 2024 10:39:57 +0200
Subject: [PATCH iwl-next v9 1/6] igb: Remove static qualifiers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-b4-igb_zero_copy-v9-1-da139d78d796@linutronix.de>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Benjamin Steinke <benjamin.steinke@woks-audio.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6449; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=2VHuu2hzDaq14UfD30TJ9OM3e+KStIKYPQI109hxTkI=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnEh7iHpjdh5YMYZK2UQPQIr1W5LNZI63r7rvdN
 4j3vAAg412JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZxIe4gAKCRDBk9HyqkZz
 ghiIEACgyYrUqsQJ28U2h8PgVRjk9Ptajfc1GCZF+ZiLngkAF3KORwZR2Srq5OOxHUqOznPnrdw
 /fCCznHdG3mo6LiSPNjtq6dNs247GtSNBYmlrKwmRfLa1GmqQ5vM/pgx+kMoMhZ3TIqG88OJJE+
 hyDkDq8Nuxs1X1iDUbuI0I2oXVDZ3eJ43WdZG2v6SF6ZZjxR+eppoOaS8XtY6sWUPBM8h87BNZd
 Nt6xgOSD38QP8fQ+hxk6oH0rRt9vGd6lu1nZzrHD7DIeVMM4fNW8N+DASUriYYsKgLJbdrEwrf7
 GbkvzYrt4yCTATW69dy08Zg397cceSBHXxLc3hpdO20LJUGyBJRWhSSCjVwUtbrb0nPDkb0T+56
 9gU1/hnKGpsx1ZtDMKV+Wt98jYH66QskioKBa5Q0Yt/Sy+yNz+0BWwwlQF+0RgG/NkXomKMtvBL
 B5Kja28EpoQdLLmTObOYjaA3eTKJgpZY+s5Z03rVK1PxG2SgjpGQ1wKdxQVdafinxKOtlEyTcAo
 sp/A1KQQ7D+bdtECWNBHDtEJwCOamG1iNsWb9rwprPrt5R3vXiKF8+o+KxrDj7xeAgoXPkyYFvJ
 cQPVehL63i2C+Zre21ugkSvxLcn0ybX22JrrGGzsbA4es3QjdRVeb9mf+cDz+XbdVtbWdMErWDs
 C2u7G9uZ+8P9iWg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

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
---
 drivers/net/ethernet/intel/igb/igb.h      | 29 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 37 +++++--------------------------
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
index f1d088168723..5a44867bcb26 100644
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
@@ -2915,29 +2912,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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
@@ -4884,7 +4859,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
  *  igb_clean_tx_ring - Free Tx Buffers
  *  @tx_ring: ring to be cleaned
  **/
-static void igb_clean_tx_ring(struct igb_ring *tx_ring)
+void igb_clean_tx_ring(struct igb_ring *tx_ring)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
@@ -5003,7 +4978,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
  *  igb_clean_rx_ring - Free Rx Buffers per Queue
  *  @rx_ring: ring to free buffers from
  **/
-static void igb_clean_rx_ring(struct igb_ring *rx_ring)
+void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;
 
@@ -8782,9 +8757,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
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
2.39.5


