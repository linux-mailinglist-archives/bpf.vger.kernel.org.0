Return-Path: <bpf+bounces-65358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBEB211DD
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4EF56056C
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD72E54DC;
	Mon, 11 Aug 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuBwMEwW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01B2E54B5;
	Mon, 11 Aug 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928810; cv=none; b=i5i/u/Nbo7VqCdHxGVY3VAbtpOXI3gRRsDgJT6SmnY5omtpF9hdKiyAhO3nNTQ89NaTbLrTObFWdLEOYPCqbIXcWgGAvaQbJ2Eht4Z+98dpOrn0X8Nqlw5H4rAd5j6z2dvuDaBnb1M+dMn7OhyW971SLRUoTvHIeEgCBOZ3+SzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928810; c=relaxed/simple;
	bh=AR4Wl0w4pgU0n1cl40F12XXJCQwq8i9u+KgkUJXzqy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWKgfJhanh9Xy9fKKbSsq0cl3JCzq2R/S6Re2rMH9RNK45gYJ7XS/8z161FezAaLI4A574z2KE84jBhoPh1x/CKtIpVFBYILz1Ayx+y712JtMsI9whc11hA2ZX/srl6wmvGtHCgaK0U3jRJu/MmxQBXJxFk9FX0De5VemVTZ0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuBwMEwW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928809; x=1786464809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AR4Wl0w4pgU0n1cl40F12XXJCQwq8i9u+KgkUJXzqy0=;
  b=MuBwMEwWHpl7bC20f5k9wBMbFkIkAqhjSq+2tt1amZ8DiUtwvTEtejjN
   Mkbrnqvn2VomqNLBLLbxwrwQmF+NN3i74B6Nu5OHsqwktfzL5t2ccEWSR
   SxxZUn/wk6dHrw5jElwx+Vszdmb4x118OsdztGp8pmYjiGJmnYmcc7Tv7
   5Im9FaM7QrDRI+al03LqMEIeGhv4YSlTJbA+5NZGjmHwWZyAbMsr7R2Ad
   j80zFIfrX8MEMDhTL4WuXthVGsG27E9/f0fhjuoSJF0o0QxOKlmALSNLY
   La4q/IH/krfbhgiE4+78bcsnlLV+6U9AtbAoyO4Z9zfVNssxfz97vN3eR
   w==;
X-CSE-ConnectionGUID: fqYO3qAITDWGYgo4mziilg==
X-CSE-MsgGUID: Ul7mUsNMSS6ELqb8i1xAUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56899692"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56899692"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:13:28 -0700
X-CSE-ConnectionGUID: Am7VaF5ATWm+9BO1NmOHqw==
X-CSE-MsgGUID: lAqU6aqaT9Kcb3NOc4Qd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165163234"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 09:13:24 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v4 10/13] idpf: use generic functions to build xdp_buff and skb
Date: Mon, 11 Aug 2025 18:10:41 +0200
Message-ID: <20250811161044.32329-11-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation of XDP support, move from having skb as the main frame
container during the Rx polling to &xdp_buff.
This allows to use generic and libeth helpers for building an XDP
buffer and changes the logics: now we try to allocate an skb only
when we processed all the descriptors related to the frame.
Store &libeth_xdp_stash instead of the skb pointer on the Rx queue.
It's only 8 bytes wider, but contains everything we may need.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  17 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 104 ++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 145 +++++-------------
 3 files changed, 90 insertions(+), 176 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f898a9c8de1d..5039feafdee9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -484,7 +484,7 @@ struct idpf_tx_queue_stats {
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
- * @skb: Pointer to the skb
+ * @xdp: XDP buffer with the current frame
  * @cached_phc_time: Cached PHC time for the Rx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
@@ -536,11 +536,11 @@ struct idpf_rx_queue {
 	__cacheline_group_end_aligned(read_mostly);
 
 	__cacheline_group_begin_aligned(read_write);
-	u16 next_to_use;
-	u16 next_to_clean;
-	u16 next_to_alloc;
+	u32 next_to_use;
+	u32 next_to_clean;
+	u32 next_to_alloc;
 
-	struct sk_buff *skb;
+	struct libeth_xdp_buff_stash xdp;
 	u64 cached_phc_time;
 
 	struct u64_stats_sync stats_sync;
@@ -563,8 +563,8 @@ struct idpf_rx_queue {
 libeth_cacheline_set_assert(struct idpf_rx_queue,
 			    ALIGN(64, __alignof(struct xdp_rxq_info)) +
 			    sizeof(struct xdp_rxq_info),
-			    72 + offsetof(struct idpf_rx_queue, q_stats) -
-			    offsetofend(struct idpf_rx_queue, skb),
+			    96 + offsetof(struct idpf_rx_queue, q_stats) -
+			    offsetofend(struct idpf_rx_queue, cached_phc_time),
 			    32);
 
 /**
@@ -1047,9 +1047,6 @@ int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss(struct idpf_vport *vport);
 void idpf_deinit_rss(struct idpf_vport *vport);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport);
-void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
-		      unsigned int size);
-struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size);
 void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 178c2f3825e3..61e613066140 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
-#include <net/libeth/rx.h>
-#include <net/libeth/tx.h>
+#include <net/libeth/xdp.h>
 
 #include "idpf.h"
 
@@ -834,7 +833,7 @@ static void idpf_rx_singleq_flex_hash(struct idpf_rx_queue *rx_q,
 }
 
 /**
- * idpf_rx_singleq_process_skb_fields - Populate skb header fields from Rx
+ * __idpf_rx_singleq_process_skb_fields - Populate skb header fields from Rx
  * descriptor
  * @rx_q: Rx ring being processed
  * @skb: pointer to current skb being populated
@@ -846,17 +845,14 @@ static void idpf_rx_singleq_flex_hash(struct idpf_rx_queue *rx_q,
  * other fields within the skb.
  */
 static void
-idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
-				   struct sk_buff *skb,
-				   const union virtchnl2_rx_desc *rx_desc,
-				   u16 ptype)
+__idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
+				     struct sk_buff *skb,
+				     const union virtchnl2_rx_desc *rx_desc,
+				     u16 ptype)
 {
 	struct libeth_rx_pt decoded = rx_q->rx_ptype_lkup[ptype];
 	struct libeth_rx_csum csum_bits;
 
-	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_q->xdp_rxq.dev);
-
 	/* Check if we're using base mode descriptor IDs */
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M) {
 		idpf_rx_singleq_base_hash(rx_q, skb, rx_desc, decoded);
@@ -867,7 +863,6 @@ idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
 	}
 
 	idpf_rx_singleq_csum(rx_q, skb, csum_bits, decoded);
-	skb_record_rx_queue(skb, rx_q->idx);
 }
 
 /**
@@ -1003,6 +998,32 @@ idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
 		idpf_rx_singleq_extract_flex_fields(rx_desc, fields);
 }
 
+static bool
+idpf_rx_singleq_process_skb_fields(struct sk_buff *skb,
+				   const struct libeth_xdp_buff *xdp,
+				   struct libeth_rq_napi_stats *rs)
+{
+	struct libeth_rqe_info fields;
+	struct idpf_rx_queue *rxq;
+
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	idpf_rx_singleq_extract_fields(rxq, xdp->desc, &fields);
+	__idpf_rx_singleq_process_skb_fields(rxq, skb, xdp->desc,
+					     fields.ptype);
+
+	return true;
+}
+
+static void idpf_xdp_run_pass(struct libeth_xdp_buff *xdp,
+			      struct napi_struct *napi,
+			      struct libeth_rq_napi_stats *rs,
+			      const union virtchnl2_rx_desc *desc)
+{
+	libeth_xdp_run_pass(xdp, NULL, napi, rs, desc, NULL,
+			    idpf_rx_singleq_process_skb_fields);
+}
+
 /**
  * idpf_rx_singleq_clean - Reclaim resources after receive completes
  * @rx_q: rx queue to clean
@@ -1012,14 +1033,15 @@ idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
  */
 static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 {
-	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
-	struct sk_buff *skb = rx_q->skb;
+	struct libeth_rq_napi_stats rs = { };
 	u16 ntc = rx_q->next_to_clean;
+	LIBETH_XDP_ONSTACK_BUFF(xdp);
 	u16 cleaned_count = 0;
-	bool failure = false;
+
+	libeth_xdp_init_buff(xdp, &rx_q->xdp, &rx_q->xdp_rxq);
 
 	/* Process Rx packets bounded by budget */
-	while (likely(total_rx_pkts < (unsigned int)budget)) {
+	while (likely(rs.packets < budget)) {
 		struct libeth_rqe_info fields = { };
 		union virtchnl2_rx_desc *rx_desc;
 		struct idpf_rx_buf *rx_buf;
@@ -1046,73 +1068,41 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
 
 		rx_buf = &rx_q->rx_buf[ntc];
-		if (!libeth_rx_sync_for_cpu(rx_buf, fields.len))
-			goto skip_data;
-
-		if (skb)
-			idpf_rx_add_frag(rx_buf, skb, fields.len);
-		else
-			skb = idpf_rx_build_skb(rx_buf, fields.len);
-
-		/* exit if we failed to retrieve a buffer */
-		if (!skb)
-			break;
-
-skip_data:
+		libeth_xdp_process_buff(xdp, rx_buf, fields.len);
 		rx_buf->netmem = 0;
 
 		IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
 		cleaned_count++;
 
 		/* skip if it is non EOP desc */
-		if (idpf_rx_singleq_is_non_eop(rx_desc) || unlikely(!skb))
+		if (idpf_rx_singleq_is_non_eop(rx_desc) ||
+		    unlikely(!xdp->data))
 			continue;
 
 #define IDPF_RXD_ERR_S FIELD_PREP(VIRTCHNL2_RX_BASE_DESC_QW1_ERROR_M, \
 				  VIRTCHNL2_RX_BASE_DESC_ERROR_RXE_M)
 		if (unlikely(idpf_rx_singleq_test_staterr(rx_desc,
 							  IDPF_RXD_ERR_S))) {
-			dev_kfree_skb_any(skb);
-			skb = NULL;
-			continue;
-		}
-
-		/* pad skb if needed (to make valid ethernet frame) */
-		if (eth_skb_pad(skb)) {
-			skb = NULL;
+			libeth_xdp_return_buff_slow(xdp);
 			continue;
 		}
 
-		/* probably a little skewed due to removing CRC */
-		total_rx_bytes += skb->len;
-
-		/* protocol */
-		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc,
-						   fields.ptype);
-
-		/* send completed skb up the stack */
-		napi_gro_receive(rx_q->pp->p.napi, skb);
-		skb = NULL;
-
-		/* update budget accounting */
-		total_rx_pkts++;
+		idpf_xdp_run_pass(xdp, rx_q->pp->p.napi, &rs, rx_desc);
 	}
 
-	rx_q->skb = skb;
-
 	rx_q->next_to_clean = ntc;
+	libeth_xdp_save_buff(&rx_q->xdp, xdp);
 
 	page_pool_nid_changed(rx_q->pp, numa_mem_id());
 	if (cleaned_count)
-		failure = idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
+		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
-	u64_stats_add(&rx_q->q_stats.packets, total_rx_pkts);
-	u64_stats_add(&rx_q->q_stats.bytes, total_rx_bytes);
+	u64_stats_add(&rx_q->q_stats.packets, rs.packets);
+	u64_stats_add(&rx_q->q_stats.bytes, rs.bytes);
 	u64_stats_update_end(&rx_q->stats_sync);
 
-	/* guarantee a trip back through this routine if there was a failure */
-	return failure ? budget : (int)total_rx_pkts;
+	return rs.packets;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7224f92624cb..bfda32959945 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -401,10 +401,7 @@ static void idpf_rx_desc_rel(struct idpf_rx_queue *rxq, struct device *dev,
 	if (!rxq)
 		return;
 
-	if (rxq->skb) {
-		dev_kfree_skb_any(rxq->skb);
-		rxq->skb = NULL;
-	}
+	libeth_xdp_return_stash(&rxq->xdp);
 
 	if (!idpf_is_queue_model_split(model))
 		idpf_rx_buf_rel_all(rxq);
@@ -3082,7 +3079,7 @@ idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
 }
 
 /**
- * idpf_rx_process_skb_fields - Populate skb header fields from Rx descriptor
+ * __idpf_rx_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rxq: Rx descriptor ring packet is being transacted on
  * @skb: pointer to current skb being populated
  * @rx_desc: Receive descriptor
@@ -3092,8 +3089,8 @@ idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
  * other fields within the skb.
  */
 static int
-idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
-			   const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
+__idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
+			     const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
 	struct libeth_rx_csum csum_bits;
 	struct libeth_rx_pt decoded;
@@ -3109,9 +3106,6 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	if (idpf_queue_has(PTP, rxq))
 		idpf_rx_hwtstamp(rxq, rx_desc, skb);
 
-	skb->protocol = eth_type_trans(skb, rxq->xdp_rxq.dev);
-	skb_record_rx_queue(skb, rxq->idx);
-
 	if (le16_get_bits(rx_desc->hdrlen_flags,
 			  VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M))
 		return idpf_rx_rsc(rxq, skb, rx_desc, decoded);
@@ -3122,23 +3116,24 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	return 0;
 }
 
-/**
- * idpf_rx_add_frag - Add contents of Rx buffer to sk_buff as a frag
- * @rx_buf: buffer containing page to add
- * @skb: sk_buff to place the data into
- * @size: packet length from rx_desc
- *
- * This function will add the data contained in rx_buf->page to the skb.
- * It will just attach the page as a frag to the skb.
- * The function will then update the page offset.
- */
-void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
-		      unsigned int size)
+static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
+				       const struct libeth_xdp_buff *xdp,
+				       struct libeth_rq_napi_stats *rs)
 {
-	u32 hr = netmem_get_pp(rx_buf->netmem)->p.offset;
+	struct idpf_rx_queue *rxq;
+
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
 
-	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags, rx_buf->netmem,
-			       rx_buf->offset + hr, size, rx_buf->truesize);
+	return !__idpf_rx_process_skb_fields(rxq, skb, xdp->desc);
+}
+
+static void
+idpf_xdp_run_pass(struct libeth_xdp_buff *xdp, struct napi_struct *napi,
+		  struct libeth_rq_napi_stats *ss,
+		  const struct virtchnl2_rx_flex_desc_adv_nic_3 *desc)
+{
+	libeth_xdp_run_pass(xdp, NULL, napi, ss, desc, NULL,
+			    idpf_rx_process_skb_fields);
 }
 
 /**
@@ -3182,36 +3177,6 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 	return copy;
 }
 
-/**
- * idpf_rx_build_skb - Allocate skb and populate it from header buffer
- * @buf: Rx buffer to pull data from
- * @size: the length of the packet
- *
- * This function allocates an skb. It then populates it with the page data from
- * the current receive descriptor, taking care to set up the skb correctly.
- */
-struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
-{
-	struct page *buf_page = __netmem_to_page(buf->netmem);
-	u32 hr = pp_page_to_nmdesc(buf_page)->pp->p.offset;
-	struct sk_buff *skb;
-	void *va;
-
-	va = page_address(buf_page) + buf->offset;
-	prefetch(va + hr);
-
-	skb = napi_build_skb(va, buf->truesize);
-	if (unlikely(!skb))
-		return NULL;
-
-	skb_mark_for_recycle(skb);
-
-	skb_reserve(skb, hr);
-	__skb_put(skb, size);
-
-	return skb;
-}
-
 /**
  * idpf_rx_splitq_test_staterr - tests bits in Rx descriptor
  * status and error fields
@@ -3253,13 +3218,15 @@ static bool idpf_rx_splitq_is_eop(struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_de
  */
 static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 {
-	int total_rx_bytes = 0, total_rx_pkts = 0;
 	struct idpf_buf_queue *rx_bufq = NULL;
-	struct sk_buff *skb = rxq->skb;
+	struct libeth_rq_napi_stats rs = { };
 	u16 ntc = rxq->next_to_clean;
+	LIBETH_XDP_ONSTACK_BUFF(xdp);
+
+	libeth_xdp_init_buff(xdp, &rxq->xdp, &rxq->xdp_rxq);
 
 	/* Process Rx packets bounded by budget */
-	while (likely(total_rx_pkts < budget)) {
+	while (likely(rs.packets < budget)) {
 		struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
 		struct libeth_fqe *hdr, *rx_buf = NULL;
 		struct idpf_sw_queue *refillq = NULL;
@@ -3325,7 +3292,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 
 		hdr = &rx_bufq->hdr_buf[buf_id];
 
-		if (unlikely(!hdr_len && !skb)) {
+		if (unlikely(!hdr_len && !xdp->data)) {
 			hdr_len = idpf_rx_hsplit_wa(hdr, rx_buf, pkt_len);
 			/* If failed, drop both buffers by setting len to 0 */
 			pkt_len -= hdr_len ? : pkt_len;
@@ -3335,75 +3302,35 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			u64_stats_update_end(&rxq->stats_sync);
 		}
 
-		if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
-			skb = idpf_rx_build_skb(hdr, hdr_len);
-			if (!skb)
-				break;
-
-			u64_stats_update_begin(&rxq->stats_sync);
-			u64_stats_inc(&rxq->q_stats.hsplit_pkts);
-			u64_stats_update_end(&rxq->stats_sync);
-		}
+		if (libeth_xdp_process_buff(xdp, hdr, hdr_len))
+			rs.hsplit++;
 
 		hdr->netmem = 0;
 
 payload:
-		if (!libeth_rx_sync_for_cpu(rx_buf, pkt_len))
-			goto skip_data;
-
-		if (skb)
-			idpf_rx_add_frag(rx_buf, skb, pkt_len);
-		else
-			skb = idpf_rx_build_skb(rx_buf, pkt_len);
-
-		/* exit if we failed to retrieve a buffer */
-		if (!skb)
-			break;
-
-skip_data:
+		libeth_xdp_process_buff(xdp, rx_buf, pkt_len);
 		rx_buf->netmem = 0;
 
 		idpf_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
 
 		/* skip if it is non EOP desc */
-		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!skb))
-			continue;
-
-		/* pad skb if needed (to make valid ethernet frame) */
-		if (eth_skb_pad(skb)) {
-			skb = NULL;
-			continue;
-		}
-
-		/* probably a little skewed due to removing CRC */
-		total_rx_bytes += skb->len;
-
-		/* protocol */
-		if (unlikely(idpf_rx_process_skb_fields(rxq, skb, rx_desc))) {
-			dev_kfree_skb_any(skb);
-			skb = NULL;
+		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!xdp->data))
 			continue;
-		}
 
-		/* send completed skb up the stack */
-		napi_gro_receive(rxq->napi, skb);
-		skb = NULL;
-
-		/* update budget accounting */
-		total_rx_pkts++;
+		idpf_xdp_run_pass(xdp, rxq->napi, &rs, rx_desc);
 	}
 
 	rxq->next_to_clean = ntc;
+	libeth_xdp_save_buff(&rxq->xdp, xdp);
 
-	rxq->skb = skb;
 	u64_stats_update_begin(&rxq->stats_sync);
-	u64_stats_add(&rxq->q_stats.packets, total_rx_pkts);
-	u64_stats_add(&rxq->q_stats.bytes, total_rx_bytes);
+	u64_stats_add(&rxq->q_stats.packets, rs.packets);
+	u64_stats_add(&rxq->q_stats.bytes, rs.bytes);
+	u64_stats_add(&rxq->q_stats.hsplit_pkts, rs.hsplit);
 	u64_stats_update_end(&rxq->stats_sync);
 
-	/* guarantee a trip back through this routine if there was a failure */
-	return total_rx_pkts;
+	return rs.packets;
 }
 
 /**
-- 
2.50.1


