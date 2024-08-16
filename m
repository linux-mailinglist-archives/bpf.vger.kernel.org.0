Return-Path: <bpf+bounces-37355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087F954567
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0595281EA9
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2F14431B;
	Fri, 16 Aug 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKbtkrDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmYs8Qjl"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8613D52E;
	Fri, 16 Aug 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800255; cv=none; b=Txi1SZ31qhGP1YRNv5bDwgnVv+Yw7ID246izkv9jp3JrnzFWCLKJfCjchGvq62ZA1Rl6dJ2SFNtwCzPZr75dXVIbE2HtdyMTqmee2Y10oEdJxAXkcSDJGqV7CghTHZ9GkQ20Mb9eqLfNZEkg3J0QEqpVIFVC8iHXjQkzOzSLQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800255; c=relaxed/simple;
	bh=cNAWzT2PzGI4DFtjGQKZX+80uudD0zUufetAgGvKfhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXam30OApM0anlclglLUKELifaH/5AIUgPyPXUmVvDdzrTZq/vVV2K8aK2goIg0Hb/RiYQymqo9kS+wqB8mner3W+RHE43O+J3vdI9aqferxZRguGyiY5T+vClhAwH9WDmAv8vin4R7/75rsmzfAgBROpkj6Gy+IF2Ca7Ugyynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKbtkrDK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmYs8Qjl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723800246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ka5fmZDFfq4l5gmlJyy4aVxbHR/oXLEe5oKx0MPza+I=;
	b=wKbtkrDK6jC5WiK4sQJLB2uj6byjFah+3oEGELxUfDzvpz6IHRVWOb4I+mQwG3PmVxH3LK
	/zRVBF3sGSeNnZUWTj5qE31Pn31mZt2X09BXjdiarDMlc/+BhU2OKc50IrrNXRwp06OcXz
	c3X0PVFuucmAF33KNZRGCvX4Jiv9UtDLchkTJgW9ppeabCH88NrOk573PLDMMAUkZRLIOs
	ljfA4y2IFkptNEVAP31kL2oPorSaT4oB1071Msvrrin4xMBe+KkB64QoxXodljtGcd3iPw
	AHIhoU+p3n17liIOTCIFxOLy3oKIqGr22krOXbLQzbGPNx84dY7SBN2d3rhdcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723800246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ka5fmZDFfq4l5gmlJyy4aVxbHR/oXLEe5oKx0MPza+I=;
	b=QmYs8QjlNf3MKVw9Ayp4UGpO/HUFpnPDEY1l+WPWVXRGEspmXnZdCHtXnW1/QfCmbEH6uh
	HJaxuY1qd3MRakCQ==
Date: Fri, 16 Aug 2024 11:24:01 +0200
Subject: [PATCH iwl-next v6 2/6] igb: Remove static qualifiers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-igb_zero_copy-v6-2-4bfb68773b18@linutronix.de>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5439; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=apin6g4hsdf4NqLiu8QsdTbpSf/PzeVDGqokkaQsDfk=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmvxqyDef2JoZaUIIkiPsDCwsP3/qzW9/nJjXSe
 9XkowaUVTKJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZr8asgAKCRDBk9HyqkZz
 gnL1EACiP2p+EMcDIw9ansl1NH8w6Us9t3PCJaB1TDZ/EptzqLB0nkwm4vLT1nKg02IW4edwmbU
 oaL00dRSdmFJ02DBujEmWDSKn2BxLJfsqyBqgLr27QqM8Kll8Yp3awGq9M0qcMQQpXl+B80M6Po
 KgA2yeejlmZASTNjfDq3f1IZzyJAOLBfsTypx4T0tYPFvACxQxktgcy+jGPQJlhqD1c8woZO2eb
 R9ksKDwk3uPmjXbUbdiwqTiFEIVRbYCUQLOyiLCCOTscwDe5DKSQ+Qg7Q7iufOE2OBm1CU0kqZQ
 hQwYC9yx5dwaZK0PgmbeQw6AunhGpn/9Vc4S787C1P96EeFMh1ONZ4KAfIDjKgXQb9c49g10Jcn
 dnIOEEKlY8XMl+tJf6yk+XxDW/kwv7eN+lNLEj072Yd576f82ozswwXiqlmwwc9g1YSEVXij0qz
 ThtOQO5SBdrLd3TJSlf42K6T1MMz0BKcLkEu9iyOUanNl+Y2G01RDAFX2c3YKMRUfjvvZXtSH24
 5F3kK/1RIipDwXIfXv/w4rd5j3ickFKWSXQgn1nN47Al/odyY6DOAB5NiZpai9XCza6nQiZ44VD
 E/qRCbmCAu1Qa0NBp6aFqzKq0mvTlor/wtkpU323U5Vw73nsnohxBn1L7rHX7ycvWFiPuiaYU9c
 Pj2Ld+5aPspNAaA==
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

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Split patches]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |  8 ++++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 18 ++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 3c2dc7bdebb5..c718e3d14401 100644
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
@@ -731,12 +733,18 @@ int igb_setup_tx_resources(struct igb_ring *);
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
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4d5e5691c9bd..0b81665b2478 100644
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
@@ -2915,7 +2913,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 }
 
 /* This function assumes __netif_tx_lock is held by the caller. */
-static void igb_xdp_ring_update_tail(struct igb_ring *ring)
+void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
@@ -2924,7 +2922,7 @@ static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 	writel(ring->next_to_use, ring->tail);
 }
 
-static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
+struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
 {
 	unsigned int r_idx = smp_processor_id();
 
@@ -2934,7 +2932,7 @@ static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
 	return adapter->tx_ring[r_idx];
 }
 
-static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
+int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 {
 	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
 	int cpu = smp_processor_id();
@@ -4880,7 +4878,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
  *  igb_clean_tx_ring - Free Tx Buffers
  *  @tx_ring: ring to be cleaned
  **/
-static void igb_clean_tx_ring(struct igb_ring *tx_ring)
+void igb_clean_tx_ring(struct igb_ring *tx_ring)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
@@ -4999,7 +4997,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
  *  igb_clean_rx_ring - Free Rx Buffers per Queue
  *  @rx_ring: ring to free buffers from
  **/
-static void igb_clean_rx_ring(struct igb_ring *rx_ring)
+void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;
 
@@ -8768,9 +8766,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
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


