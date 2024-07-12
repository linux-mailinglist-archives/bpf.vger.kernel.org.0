Return-Path: <bpf+bounces-34635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A8D92F75C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33AD284126
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD4143C6E;
	Fri, 12 Jul 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUKpw4dY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qJ0+cHk"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBB1428F1;
	Fri, 12 Jul 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774556; cv=none; b=CJAn2HJtq9AF4Q/+X1U77VGv4Bpay0NS7HBovielrtQMf721PBhoGYTbJTvFFf2+z7QwkPCDKeSX9TBoB0vKS9GQmpJ0gjE6jmIk/mzhvr7hBuRdCFL0QJL+3QspA517Lhi2jzY0nLlMWZQg/ePrQbe4Y/mqGmcnIi672F+bcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774556; c=relaxed/simple;
	bh=7uZ5g95tclQs/SzM+w3/IUsXff2dLCY1rux76A9LiRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FizfAQ3Xdb2KSt5WPdDCFOjcnmSVF9aSA/1F5MUDZJPAIyhKX5wQqVCSfs3iFidj5ibyysfB7pru5nOiUZJIzedhQ6R97wi8NPigWgrzDXZbV5EqLzWizqlWGslAxgASLSH5VOAWD4Q52boFLZAM8sZrGvK9sRaLJgydcDxH8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUKpw4dY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qJ0+cHk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720774553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q70TNir7IBy52CbPauTJ3qNqdXl8vBAfbwUA/7ETBE=;
	b=OUKpw4dY7+c8OeaHbG3nWN6OYBKwGO8cTUZI71w300cPkMdCG78VVT8RAkg/SpG2m2Gnsy
	HOBel1qqCaYgrj68jaWZv5YO/6BSXxnde4tM9abeyGinRKlg8MjBLV6kc7p72ujih6v5k6
	N6zhw0i9xJM8RWv3TNc38QhuAz3tl1NoW4PKeZOr33nPzlcRkd7e+X8o0OkI0iNCK0AIS0
	of8feF74iT41cTeKIhdTHLLq45JwODQ/O20g/m23rWE7HZHogzez0QiPOC133gQ6MoK+J8
	vbLvgjG1SeIOxNOvfXN2K0Mak33WPJuYEHTyOTz69lno29l/6F3xZjdE+9yYpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720774553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q70TNir7IBy52CbPauTJ3qNqdXl8vBAfbwUA/7ETBE=;
	b=0qJ0+cHkqB7yPwcVrmGgPzKyU94wvR9IeZ+KtC7MZxppq20puzFwWEr9SH5CQhZwFRbmlC
	YEqrKb/75GGKh8DA==
Date: Fri, 12 Jul 2024 10:55:29 +0200
Subject: [PATCH iwl-next v5 1/4] igb: prepare for AF_XDP zero-copy support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-igb_zero_copy-v5-1-f3f455113b11@linutronix.de>
References: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
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
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6788; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=karr5T8HuyUwA088auP3gGhvt/no1iXDgJPYDayi7vg=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmkO+WOBYC3tcGL39gclFbXDK6Zi4EbWSdTfPU/
 xRsxl8QEb6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZpDvlgAKCRDBk9HyqkZz
 gnDXEACNzkOn+7o+SynoIJo0o4KOg8X3oFaBWoR4wnZEHC3Cn2wfz2h3ZqY9lGBXaDI6Gu2F1Xq
 M2ATwtv9yXGq/sCu6rEUwceLIENnYwfQLrpBkXMx5+QtkMkoF5iF7/50hP3x/3CmB6lKAhlYh7o
 2oYXd7lQu6LLYQmtq+Y8CLGxGYa0RG00UrmWlt/twLAp1EMN0tPUfItCRlXSTi7ZX8+5Iqnks4+
 J1h+xBA0ezCVWRjNeDh4DvEFDibhcFcJWS+xGBBhxUUbCv7f9n+TmE3mlOOwY3NbYrMz3Mcr9DZ
 Ci2mgQQbQ351IccXPMpPOm+Bgrw5AznueCbR7sAIIyaOlXhaafvI7CrKmqa64ZYB+5W9B0i/NhC
 AdPvPjPXnEdPhioMphW3fBcfT330CYgGe9drw3GNsKIT/ZrN86sunYAI24TQtiTXUGh9nWgZrmU
 e/SIly8i+THhmScgb5mkmwjULqPdB7oLvVkcF6Gf0mUqLZfraaTuyofHWbtRBSGa8LOkontffmt
 IR0UsytjJiBeYe/XatpM1frb4WblIcHdhrPFj3i09JnCXAMmJeF9Wkw+lc1M09cxnYmUdsW0Kv1
 XHU2aitnrYmbJB4L3eEm6DFcr4d+1ArzdKPyJ0KvIP3jzdOFpsAVaNlxP/MrUDi7G6CoQ25gVSx
 mkD2m6N16oyWBFw==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Always call igb_xdp_ring_update_tail under __netif_tx_lock, add a
comment to indicate that. This is needed to share the same TX ring
between XDP, XSK and slow paths.

Remove static qualifiers on the following functions to be able to call
from XSK specific file that is added in the later patches
- igb_xdp_tx_queue_mapping
- igb_xdp_ring_update_tail
- igb_clean_tx_ring
- igb_clean_rx_ring
- igb_run_xdp
- igb_process_skb_fields

Introduce igb_xdp_is_enabled() to check if an XDP program is assigned to
the device.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      | 15 +++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 29 ++++++++++++++---------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 3c2dc7bdebb5..0de71ec324ed 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -718,6 +718,8 @@ extern char igb_driver_name[];
 int igb_xmit_xdp_ring(struct igb_adapter *adapter,
 		      struct igb_ring *ring,
 		      struct xdp_frame *xdpf);
+struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter);
+void igb_xdp_ring_update_tail(struct igb_ring *ring);
 int igb_open(struct net_device *netdev);
 int igb_close(struct net_device *netdev);
 int igb_up(struct igb_adapter *);
@@ -731,12 +733,20 @@ int igb_setup_tx_resources(struct igb_ring *);
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
+struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
+			    struct igb_ring *rx_ring,
+			    struct xdp_buff *xdp);
+void igb_process_skb_fields(struct igb_ring *rx_ring,
+			    union e1000_adv_rx_desc *rx_desc,
+			    struct sk_buff *skb);
 void igb_alloc_rx_buffers(struct igb_ring *, u16);
 void igb_update_stats(struct igb_adapter *);
 bool igb_has_link(struct igb_adapter *adapter);
@@ -797,6 +807,11 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
 	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 }
 
+static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
+{
+	return !!adapter->xdp_prog;
+}
+
 int igb_add_filter(struct igb_adapter *adapter,
 		   struct igb_nfc_filter *input);
 int igb_erase_filter(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3af03a211c3c..7f84e4117fa7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -115,8 +115,6 @@ static void igb_configure_tx(struct igb_adapter *);
 static void igb_configure_rx(struct igb_adapter *);
 static void igb_clean_all_tx_rings(struct igb_adapter *);
 static void igb_clean_all_rx_rings(struct igb_adapter *);
-static void igb_clean_tx_ring(struct igb_ring *);
-static void igb_clean_rx_ring(struct igb_ring *);
 static void igb_set_rx_mode(struct net_device *);
 static void igb_update_phy_info(struct timer_list *);
 static void igb_watchdog(struct timer_list *);
@@ -2915,7 +2913,8 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
-static void igb_xdp_ring_update_tail(struct igb_ring *ring)
+/* This function assumes __netif_tx_lock is held by the caller. */
+void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
@@ -2924,7 +2923,7 @@ static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 	writel(ring->next_to_use, ring->tail);
 }
 
-static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
+struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
 {
 	unsigned int r_idx = smp_processor_id();
 
@@ -3001,11 +3000,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 		nxmit++;
 	}
 
-	__netif_tx_unlock(nq);
-
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		igb_xdp_ring_update_tail(tx_ring);
 
+	__netif_tx_unlock(nq);
+
 	return nxmit;
 }
 
@@ -4880,7 +4879,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
  *  igb_clean_tx_ring - Free Tx Buffers
  *  @tx_ring: ring to be cleaned
  **/
-static void igb_clean_tx_ring(struct igb_ring *tx_ring)
+void igb_clean_tx_ring(struct igb_ring *tx_ring)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
@@ -4999,7 +4998,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
  *  igb_clean_rx_ring - Free Rx Buffers per Queue
  *  @rx_ring: ring to free buffers from
  **/
-static void igb_clean_rx_ring(struct igb_ring *rx_ring)
+void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;
 
@@ -6614,7 +6613,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (adapter->xdp_prog) {
+	if (igb_xdp_is_enabled(adapter)) {
 		int i;
 
 		for (i = 0; i < adapter->num_rx_queues; i++) {
@@ -8570,9 +8569,9 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 	return skb;
 }
 
-static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
-				   struct igb_ring *rx_ring,
-				   struct xdp_buff *xdp)
+struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
+			    struct igb_ring *rx_ring,
+			    struct xdp_buff *xdp)
 {
 	int err, result = IGB_XDP_PASS;
 	struct bpf_prog *xdp_prog;
@@ -8768,9 +8767,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
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
2.39.2


