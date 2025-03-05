Return-Path: <bpf+bounces-53366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4372A504C0
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7E176EDA
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D92561DF;
	Wed,  5 Mar 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVbNdI7+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373182561B9;
	Wed,  5 Mar 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191797; cv=none; b=UqQrkV3XnxOPXYSAnaYNmVYdqcLuOSD43ee2+PWDKH2AKpYxhyx5nIY1S3lffRV7g7Rty3FI0ZqAr/rSgrClrGmr1DjiMRtgLdR+LGnx0INeOO0g3u76Ji9HJNwHQiNXpmvhU4Egxajj4PkkJ9TP3jCBFdVZUs0kqvDOFNh8CnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191797; c=relaxed/simple;
	bh=jH3/aFW3p54Wrswk5tybuWj5Zwto0J/wsivgfC94QW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYhM8mzH9e2l2ZbjWceRaVjBUTeNcf9dBTXiD8j7KcVTxy1DxRmHeshma4kfy9VUz6RsRfOapiyP0qBeJYZ74ZHEMZwItRI1r9Z/xhvBC7161bgd/Ru05/YpzFGNqWKMvR0ZnUH0ExPGm9vAYINIx0R6Xdc8MSsOV7gsRhAPL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVbNdI7+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191796; x=1772727796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jH3/aFW3p54Wrswk5tybuWj5Zwto0J/wsivgfC94QW0=;
  b=nVbNdI7+r5IU3VPIVaSt9AlKYcmQaXgKVmlLW3LG8buCGRR20rS8AlTf
   hrL4ufhbRmREJSPALsavDlx7BCJE02HKW6x5Cie9nJrQeO0cPZx67vA22
   MqufLgYxAOrIjiNZ4mNj+yDFT5VWX7SlgxAPBF5ol6RrQppBe8q4S1Jgv
   15OI/S5nuJAA2EZdmLA9Fh3L5PDQg+96aVoKUNTHVYako2aeFloux01S3
   OcdGQbEH8zRnz93m+DJjNvbw8Nce18yAMxLgvULbOovcsSX4s+qFtOb8l
   kT7V8RT8VgsDy20DMFq5nR1HuBxa0Yk1ATKoVkWpfY36fND1YYkz7XbPP
   A==;
X-CSE-ConnectionGUID: ozuTzIqAR/OxrS0gdujQ6Q==
X-CSE-MsgGUID: JZV+0aBPQEuTr2PRdzKo9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026614"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026614"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:23:15 -0800
X-CSE-ConnectionGUID: fPnzIwIaQR29ad9kt53nJA==
X-CSE-MsgGUID: bMqy4WiSRaWrj93bftuRXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123833006"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:23:10 -0800
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 14/16] idpf: add support for XDP on Rx
Date: Wed,  5 Mar 2025 17:21:30 +0100
Message-ID: <20250305162132.1106080-15-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use libeth XDP infra to support running XDP program on Rx polling.
This includes all of the possible verdicts/actions.
XDP Tx queues are cleaned only in "lazy" mode when there are less than
1/4 free descriptors left on the ring. libeth helper macros to define
driver-specific XDP functions make sure the compiler could uninline
them when needed.
Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
applicable. It really gives some good boosts and code size reduction
on x86_64.

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |   4 +-
 drivers/net/ethernet/intel/idpf/xdp.h       | 100 ++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  23 +--
 drivers/net/ethernet/intel/idpf/xdp.c       | 155 +++++++++++++++++++-
 5 files changed, 264 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index e36c55baf23f..5d62074c94b1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -684,8 +684,8 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(read_mostly);
 
 	__cacheline_group_begin_aligned(read_write);
-	u16 next_to_use;
-	u16 next_to_clean;
+	u32 next_to_use;
+	u32 next_to_clean;
 
 	union {
 		struct {
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index a72a7638a6ea..fde85528a315 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -4,12 +4,9 @@
 #ifndef _IDPF_XDP_H_
 #define _IDPF_XDP_H_
 
-#include <linux/types.h>
+#include <net/libeth/xdp.h>
 
-struct bpf_prog;
-struct idpf_vport;
-struct net_device;
-struct netdev_bpf;
+#include "idpf_txrx.h"
 
 int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
 void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
@@ -19,6 +16,99 @@ void idpf_copy_xdp_prog_to_qs(const struct idpf_vport *vport,
 int idpf_vport_xdpq_get(const struct idpf_vport *vport);
 void idpf_vport_xdpq_put(const struct idpf_vport *vport);
 
+bool idpf_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags);
+
+/**
+ * idpf_xdp_tx_xmit - produce a single HW Tx descriptor out of XDP desc
+ * @desc: XDP descriptor to pull the DMA address and length from
+ * @i: descriptor index on the queue to fill
+ * @sq: XDP queue to produce the HW Tx descriptor on
+ * @priv: &xsk_tx_metadata_ops on XSk xmit or %NULL
+ */
+static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
+				    const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct idpf_flex_tx_desc *tx_desc = sq->descs;
+	u32 cmd;
+
+	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_DTYPE_M,
+			 IDPF_TX_DESC_DTYPE_FLEX_L2TAG1_L2TAG2);
+	if (desc.flags & LIBETH_XDP_TX_LAST)
+		cmd |= FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M,
+				  IDPF_TX_DESC_CMD_EOP);
+	if (priv && (desc.flags & LIBETH_XDP_TX_CSUM))
+		cmd |= FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M,
+				  IDPF_TX_FLEX_DESC_CMD_CS_EN);
+
+	tx_desc = &tx_desc[i];
+	tx_desc->buf_addr = cpu_to_le64(desc.addr);
+#ifdef __LIBETH_WORD_ACCESS
+	*(u64 *)&tx_desc->qw1 = ((u64)desc.len << 48) | cmd;
+#else
+	tx_desc->qw1.buf_size = cpu_to_le16(desc.len);
+	tx_desc->qw1.cmd_dtype = cpu_to_le16(cmd);
+#endif
+}
+
+/**
+ * idpf_set_rs_bit - set RS bit on last produced descriptor
+ * @xdpq: XDP queue to produce the HW Tx descriptors on
+ */
+static inline void idpf_set_rs_bit(const struct idpf_tx_queue *xdpq)
+{
+	u32 ntu, cmd;
+
+	ntu = xdpq->next_to_use;
+	if (unlikely(!ntu))
+		ntu = xdpq->desc_count;
+
+	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M, IDPF_TX_DESC_CMD_RS);
+#ifdef __LIBETH_WORD_ACCESS
+	*(u64 *)&xdpq->flex_tx[ntu - 1].q.qw1 |= cmd;
+#else
+	xdpq->flex_tx[ntu - 1].q.qw1.cmd_dtype |= cpu_to_le16(cmd);
+#endif
+}
+
+/**
+ * idpf_xdpq_update_tail - update the XDP Tx queue tail register
+ * @xdpq: XDP Tx queue
+ */
+static inline void idpf_xdpq_update_tail(const struct idpf_tx_queue *xdpq)
+{
+	dma_wmb();
+	writel_relaxed(xdpq->next_to_use, xdpq->tail);
+}
+
+/**
+ * idpf_xdp_tx_finalize - Update RS bit and bump XDP Tx tail
+ * @_xdpq: XDP Tx queue
+ * @sent: whether any frames were sent
+ * @flush: whether to update RS bit and the tail register
+ *
+ * This function bumps XDP Tx tail and should be called when a batch of packets
+ * has been processed in the napi loop.
+ */
+static inline void idpf_xdp_tx_finalize(void *_xdpq, bool sent, bool flush)
+{
+	struct idpf_tx_queue *xdpq = _xdpq;
+
+	if ((!flush || unlikely(!sent)) &&
+	    likely(xdpq->desc_count != xdpq->pending))
+		return;
+
+	libeth_xdpsq_lock(&xdpq->xdp_lock);
+
+	idpf_set_rs_bit(xdpq);
+	idpf_xdpq_update_tail(xdpq);
+
+	libeth_xdpsq_queue_timer(xdpq->timer);
+
+	libeth_xdpsq_unlock(&xdpq->xdp_lock);
+}
+
+void idpf_xdp_set_features(const struct idpf_vport *vport);
+
 int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
 
 #endif /* _IDPF_XDP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 84ca8c08bd56..2d1efcb854be 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -814,6 +814,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->features |= dflt_features;
 	netdev->hw_features |= dflt_features | offloads;
 	netdev->hw_enc_features |= dflt_features | offloads;
+	idpf_xdp_set_features(vport);
+
 	idpf_set_ethtool_ops(netdev);
 	netif_set_affinity_auto(netdev);
 	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f25c50d8947b..cddcc5fc291f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
-#include <net/libeth/xdp.h>
-
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
@@ -3247,14 +3245,12 @@ static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
 	return !__idpf_rx_process_skb_fields(rxq, skb, xdp->desc);
 }
 
-static void
-idpf_xdp_run_pass(struct libeth_xdp_buff *xdp, struct napi_struct *napi,
-		  struct libeth_rq_napi_stats *ss,
-		  const struct virtchnl2_rx_flex_desc_adv_nic_3 *desc)
-{
-	libeth_xdp_run_pass(xdp, NULL, napi, ss, desc, NULL,
-			    idpf_rx_process_skb_fields);
-}
+LIBETH_XDP_DEFINE_START();
+LIBETH_XDP_DEFINE_RUN(static idpf_xdp_run_pass, idpf_xdp_run_prog,
+		      idpf_xdp_tx_flush_bulk, idpf_rx_process_skb_fields);
+LIBETH_XDP_DEFINE_FINALIZE(static idpf_xdp_finalize_rx, idpf_xdp_tx_flush_bulk,
+			   idpf_xdp_tx_finalize);
+LIBETH_XDP_DEFINE_END();
 
 /**
  * idpf_rx_hsplit_wa - handle header buffer overflows and split errors
@@ -3338,9 +3334,12 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 {
 	struct idpf_buf_queue *rx_bufq = NULL;
 	struct libeth_rq_napi_stats rs = { };
+	struct libeth_xdp_tx_bulk bq;
 	LIBETH_XDP_ONSTACK_BUFF(xdp);
 	u16 ntc = rxq->next_to_clean;
 
+	libeth_xdp_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
+				rxq->xdpqs, rxq->num_xdp_txq);
 	libeth_xdp_init_buff(xdp, &rxq->xdp, &rxq->xdp_rxq);
 
 	/* Process Rx packets bounded by budget */
@@ -3435,11 +3434,13 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!xdp->data))
 			continue;
 
-		idpf_xdp_run_pass(xdp, rxq->napi, &rs, rx_desc);
+		idpf_xdp_run_pass(xdp, &bq, rxq->napi, &rs, rx_desc);
 	}
 
 	rxq->next_to_clean = ntc;
+
 	libeth_xdp_save_buff(&rxq->xdp, xdp);
+	idpf_xdp_finalize_rx(&bq);
 
 	u64_stats_update_begin(&rxq->stats_sync);
 	u64_stats_add(&rxq->q_stats.packets, rs.packets);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index c0322fa7bfee..abf75e840c0a 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2024 Intel Corporation */
 
-#include <net/libeth/xdp.h>
-
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
@@ -143,6 +141,8 @@ void idpf_copy_xdp_prog_to_qs(const struct idpf_vport *vport,
 	idpf_rxq_for_each(vport, idpf_xdp_rxq_assign_prog, xdp_prog);
 }
 
+static void idpf_xdp_tx_timer(struct work_struct *work);
+
 int idpf_vport_xdpq_get(const struct idpf_vport *vport)
 {
 	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
@@ -183,6 +183,8 @@ int idpf_vport_xdpq_get(const struct idpf_vport *vport)
 
 		xdpq->timer = timers[i - sqs];
 		libeth_xdpsq_get(&xdpq->xdp_lock, dev, vport->xdpq_share);
+		libeth_xdpsq_init_timer(xdpq->timer, xdpq, &xdpq->xdp_lock,
+					idpf_xdp_tx_timer);
 
 		xdpq->pending = 0;
 		xdpq->xdp_tx = 0;
@@ -209,6 +211,7 @@ void idpf_vport_xdpq_put(const struct idpf_vport *vport)
 		if (!idpf_queue_has_clear(XDP, xdpq))
 			continue;
 
+		libeth_xdpsq_deinit_timer(xdpq->timer);
 		libeth_xdpsq_put(&xdpq->xdp_lock, dev);
 
 		kfree(xdpq->timer);
@@ -216,6 +219,154 @@ void idpf_vport_xdpq_put(const struct idpf_vport *vport)
 	}
 }
 
+static int
+idpf_xdp_parse_compl_desc(const struct idpf_splitq_4b_tx_compl_desc *desc,
+			  bool gen)
+{
+	u32 val;
+
+#ifdef __LIBETH_WORD_ACCESS
+	val = *(const u32 *)desc;
+#else
+	val = ((u32)le16_to_cpu(desc->q_head_compl_tag.q_head) << 16) |
+	      le16_to_cpu(desc->qid_comptype_gen);
+#endif
+	if (!!(val & IDPF_TXD_COMPLQ_GEN_M) != gen)
+		return -ENODATA;
+
+	if (unlikely((val & GENMASK(IDPF_TXD_COMPLQ_GEN_S - 1, 0)) !=
+		     FIELD_PREP(IDPF_TXD_COMPLQ_COMPL_TYPE_M,
+				IDPF_TXD_COMPLT_RS)))
+		return -EINVAL;
+
+	return upper_16_bits(val);
+}
+
+static u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
+{
+	struct idpf_compl_queue *cq = xdpsq->complq;
+	u32 tx_ntc = xdpsq->next_to_clean;
+	u32 tx_cnt = xdpsq->desc_count;
+	u32 ntc = cq->next_to_clean;
+	u32 cnt = cq->desc_count;
+	u32 done_frames;
+	bool gen;
+
+	gen = idpf_queue_has(GEN_CHK, cq);
+
+	for (done_frames = 0; done_frames < budget; ) {
+		int ret;
+
+		ret = idpf_xdp_parse_compl_desc(&cq->comp_4b[ntc], gen);
+		if (ret >= 0) {
+			done_frames = ret > tx_ntc ? ret - tx_ntc :
+						     ret + tx_cnt - tx_ntc;
+			goto next;
+		}
+
+		switch (ret) {
+		case -ENODATA:
+			goto out;
+		case -EINVAL:
+			break;
+		}
+
+next:
+		if (unlikely(++ntc == cnt)) {
+			ntc = 0;
+			gen = !gen;
+			idpf_queue_change(GEN_CHK, cq);
+		}
+	}
+
+out:
+	cq->next_to_clean = ntc;
+
+	return done_frames;
+}
+
+/**
+ * idpf_clean_xdp_irq - Reclaim a batch of TX resources from completed XDP_TX
+ * @_xdpq: XDP Tx queue
+ * @budget: maximum number of descriptors to clean
+ *
+ * Returns number of cleaned descriptors.
+ */
+static u32 idpf_clean_xdp_irq(void *_xdpq, u32 budget)
+{
+	struct libeth_xdpsq_napi_stats ss = { };
+	struct idpf_tx_queue *xdpq = _xdpq;
+	u32 tx_ntc = xdpq->next_to_clean;
+	u32 tx_cnt = xdpq->desc_count;
+	struct xdp_frame_bulk bq;
+	struct libeth_cq_pp cp = {
+		.dev	= xdpq->dev,
+		.bq	= &bq,
+		.xss	= &ss,
+		.napi	= true,
+	};
+	u32 done_frames;
+
+	done_frames = idpf_xdpsq_poll(xdpq, budget);
+	if (unlikely(!done_frames))
+		return 0;
+
+	xdp_frame_bulk_init(&bq);
+
+	for (u32 i = 0; likely(i < done_frames); i++) {
+		libeth_xdp_complete_tx(&xdpq->tx_buf[tx_ntc], &cp);
+
+		if (unlikely(++tx_ntc == tx_cnt))
+			tx_ntc = 0;
+	}
+
+	xdp_flush_frame_bulk(&bq);
+
+	xdpq->next_to_clean = tx_ntc;
+	xdpq->pending -= done_frames;
+	xdpq->xdp_tx -= cp.xdp_tx;
+
+	return done_frames;
+}
+
+static u32 idpf_xdp_tx_prep(void *_xdpq, struct libeth_xdpsq *sq)
+{
+	struct idpf_tx_queue *xdpq = _xdpq;
+	u32 free;
+
+	libeth_xdpsq_lock(&xdpq->xdp_lock);
+
+	free = xdpq->desc_count - xdpq->pending;
+	if (free <= xdpq->thresh)
+		free += idpf_clean_xdp_irq(xdpq, xdpq->thresh);
+
+	*sq = (struct libeth_xdpsq){
+		.sqes		= xdpq->tx_buf,
+		.descs		= xdpq->desc_ring,
+		.count		= xdpq->desc_count,
+		.lock		= &xdpq->xdp_lock,
+		.ntu		= &xdpq->next_to_use,
+		.pending	= &xdpq->pending,
+		.xdp_tx		= &xdpq->xdp_tx,
+	};
+
+	return free;
+}
+
+LIBETH_XDP_DEFINE_START();
+LIBETH_XDP_DEFINE_TIMER(static idpf_xdp_tx_timer, idpf_clean_xdp_irq);
+LIBETH_XDP_DEFINE_FLUSH_TX(idpf_xdp_tx_flush_bulk, idpf_xdp_tx_prep,
+			   idpf_xdp_tx_xmit);
+LIBETH_XDP_DEFINE_END();
+
+void idpf_xdp_set_features(const struct idpf_vport *vport)
+{
+	if (!idpf_is_queue_model_split(vport->rxq_model))
+		return;
+
+	libeth_xdp_set_features_noredir(vport->netdev);
+}
+
 /**
  * idpf_xdp_setup_prog - handle XDP program install/remove requests
  * @vport: vport to configure
-- 
2.48.1


