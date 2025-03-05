Return-Path: <bpf+bounces-53363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F902A504B7
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F951764EF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544A18CBE8;
	Wed,  5 Mar 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg97DSVk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EED254859;
	Wed,  5 Mar 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191785; cv=none; b=prm5qfGQoxzbdkedUfDYtM7nspDa70U09+ERtIabox8G9VwNz0WDZ/kRfpZNcKjiYOxJelFrvVFiLnyUeahU+URgO1pBG5Bq0aI2WyaMTSa810oyiP/oeIIeNaulSola/gVHKKn9cM1STTEWWI7gUVtGfWsD0SBRwcLg3Su3nM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191785; c=relaxed/simple;
	bh=68DqmvsOqYPEzlicsJSgEj6nU7vVrhuIkyCy7vLEVv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKNNl+BI323D5XNBl06ELsrXgZt1LK+0KdV9QHWXQ+ZLecGM90dPeLEXQb9+8vgACg37Soo806ARKaoDjut1T+qFXC4GHskbNNAZ9HC3pqBrp1VmURLljrAAV3Xw1zkif0gPNXAnJ0Pl5yvkO2ws1pyR3as+Q+deJrMJZHZ+rrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg97DSVk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191783; x=1772727783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=68DqmvsOqYPEzlicsJSgEj6nU7vVrhuIkyCy7vLEVv4=;
  b=Qg97DSVkSJvNlCkAvVbcq6LG8EW5n0a5CtA+ZSFyLXUZYIabC8oH1C4S
   uhVjymXV+FbIH5KIHDi3dyT92dMkdYrSPFqeU6D0Nbcz07P0xCw+V2cyk
   1b8Gly4TtdeLp+C4JMGcGjslbsiJ6bReDoDOr1lsYn3bxjsm+zpJIHkcV
   AmMs06Mfubzp/fQj+94RskL67NUWykwuPI3h4O3jZgRD9diMBwlvL2IJP
   VUrKNBo/tJIu+REgPcjgCXlBEcyYaYcu5q1lp9agrkOAuTQoapSYLDkCw
   EREuLk2XTOUub00YhzUtEPcoooD/2gpcyOrwmPPUL7fSwE6bZHUQaQ+2X
   Q==;
X-CSE-ConnectionGUID: VF8tME8RSOO06tQU7MzbaQ==
X-CSE-MsgGUID: dWqh5LQIScOylQ1fXcjN5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026562"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:23:02 -0800
X-CSE-ConnectionGUID: Mxsk4rEURAOJvEiocUpgcg==
X-CSE-MsgGUID: VIBLT2nWQQCta/PkImokMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832947"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:57 -0800
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
Subject: [PATCH net-next 11/16] idpf: prepare structures to support XDP
Date: Wed,  5 Mar 2025 17:21:27 +0100
Message-ID: <20250305162132.1106080-12-aleksander.lobakin@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_*_queue',
'idpf_vport_user_config_data') by adding members necessary to support XDP.
Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT actions
without interfering with regular Tx traffic.
Also add functions dedicated to support XDP initialization for Rx and
Tx queues and call those functions from the existing algorithms of
queues configuration.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |   2 +-
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  20 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  86 ++++++--
 drivers/net/ethernet/intel/idpf/xdp.h         |  17 ++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  21 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 109 +++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  26 +--
 drivers/net/ethernet/intel/idpf/xdp.c         | 189 ++++++++++++++++++
 12 files changed, 415 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 1addd663acad..7207ee4dbae8 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -5,7 +5,7 @@ config IDPF
 	tristate "Intel(R) Infrastructure Data Path Function Support"
 	depends on PCI_MSI
 	select DIMLIB
-	select LIBETH
+	select LIBETH_XDP
 	help
 	  This driver supports Intel(R) Infrastructure Data Path Function
 	  devices.
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 2ce01a0b5898..c58abe6f8f5d 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -17,3 +17,5 @@ idpf-y := \
 	idpf_vf_dev.o
 
 idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
+
+idpf-y				+= xdp.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 50dde09c525b..4847760744ff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -257,6 +257,10 @@ struct idpf_port_stats {
  * @txq_model: Split queue or single queue queuing model
  * @txqs: Used only in hotpath to get to the right queue very fast
  * @crc_enable: Enable CRC insertion offload
+ * @xdpq_share: whether XDPSQ sharing is enabled
+ * @num_xdp_txq: number of XDPSQs
+ * @xdp_txq_offset: index of the first XDPSQ (== number of regular SQs)
+ * @xdp_prog: installed XDP program
  * @num_rxq: Number of allocated RX queues
  * @num_bufq: Number of allocated buffer queues
  * @rxq_desc_count: RX queue descriptor count. *MUST* have enough descriptors
@@ -303,6 +307,11 @@ struct idpf_vport {
 	struct idpf_tx_queue **txqs;
 	bool crc_enable;
 
+	bool xdpq_share;
+	u16 num_xdp_txq;
+	u16 xdp_txq_offset;
+	struct bpf_prog *xdp_prog;
+
 	u16 num_rxq;
 	u16 num_bufq;
 	u32 rxq_desc_count;
@@ -380,6 +389,7 @@ struct idpf_rss_data {
  *		      ethtool
  * @num_req_rxq_desc: Number of user requested RX queue descriptors through
  *		      ethtool
+ * @xdp_prog: requested XDP program to install
  * @user_flags: User toggled config flags
  * @mac_filter_list: List of MAC filters
  *
@@ -391,6 +401,7 @@ struct idpf_vport_user_config_data {
 	u16 num_req_rx_qs;
 	u32 num_req_txq_desc;
 	u32 num_req_rxq_desc;
+	struct bpf_prog *xdp_prog;
 	DECLARE_BITMAP(user_flags, __IDPF_USER_FLAGS_NBITS);
 	struct list_head mac_filter_list;
 };
@@ -604,6 +615,15 @@ static inline int idpf_is_queue_model_split(u16 q_model)
 	       q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
 }
 
+/**
+ * idpf_xdp_is_prog_ena - check if there is an XDP program on adapter
+ * @vport: vport to check
+ */
+static inline bool idpf_xdp_is_prog_ena(const struct idpf_vport *vport)
+{
+	return vport->adapter && vport->xdp_prog;
+}
+
 #define idpf_is_cap_ena(adapter, field, flag) \
 	idpf_is_capability_ena(adapter, false, field, flag)
 #define idpf_is_cap_ena_all(adapter, field, flag) \
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index fb3b352d542e..6d9eb6f4ab38 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -7,8 +7,10 @@
 #include <linux/dim.h>
 
 #include <net/libeth/cache.h>
-#include <net/tcp.h>
+#include <net/libeth/types.h>
 #include <net/netdev_queues.h>
+#include <net/tcp.h>
+#include <net/xdp.h>
 
 #include "idpf_lan_txrx.h"
 #include "virtchnl2_lan_desc.h"
@@ -291,6 +293,7 @@ struct idpf_ptype_state {
  * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
  * @__IDPF_Q_NOIRQ: queue is polling-driven and has no interrupt
+ * @__IDPF_Q_XDP: this is an XDP queue
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -301,6 +304,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
 	__IDPF_Q_NOIRQ,
+	__IDPF_Q_XDP,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -483,19 +487,21 @@ struct idpf_txq_stash {
  * @napi: NAPI instance corresponding to this queue (splitq)
  * @rx_buf: See struct &libeth_fqe
  * @pp: Page pool pointer in singleq mode
- * @netdev: &net_device corresponding to this queue
  * @tail: Tail offset. Used for both queue models single and split.
  * @flags: See enum idpf_queue_flags_t
  * @idx: For RX queue, it is used to index to total RX queue across groups and
  *	 used for skb reporting.
  * @desc_count: Number of descriptors
+ * @num_xdp_txq: total number of XDP Tx queues
+ * @xdpqs: shortcut for XDP Tx queues array
  * @rxdids: Supported RX descriptor ids
+ * @truesize: data buffer truesize in singleq
  * @rx_ptype_lkup: LUT of Rx ptypes
+ * @xdp_rxq: XDP queue info
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
  * @skb: Pointer to the skb
- * @truesize: data buffer truesize in singleq
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
  * @q_id: Queue id
@@ -525,15 +531,23 @@ struct idpf_rx_queue {
 			struct page_pool *pp;
 		};
 	};
-	struct net_device *netdev;
 	void __iomem *tail;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u16 idx;
 	u16 desc_count;
 
-	u32 rxdids;
+	u32 num_xdp_txq;
+	union {
+		struct idpf_tx_queue **xdpqs;
+		struct {
+			u32 rxdids;
+			u32 truesize;
+		};
+	};
 	const struct libeth_rx_pt *rx_ptype_lkup;
+
+	struct xdp_rxq_info xdp_rxq;
 	__cacheline_group_end_aligned(read_mostly);
 
 	__cacheline_group_begin_aligned(read_write);
@@ -542,7 +556,6 @@ struct idpf_rx_queue {
 	u16 next_to_alloc;
 
 	struct sk_buff *skb;
-	u32 truesize;
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_rx_queue_stats q_stats;
@@ -561,8 +574,11 @@ struct idpf_rx_queue {
 	u16 rx_max_pkt_size;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
-			    80 + sizeof(struct u64_stats_sync),
+libeth_cacheline_set_assert(struct idpf_rx_queue,
+			    ALIGN(64, __alignof(struct xdp_rxq_info)) +
+			    sizeof(struct xdp_rxq_info),
+			    72 + offsetof(struct idpf_rx_queue, q_stats) -
+			    offsetofend(struct idpf_rx_queue, skb),
 			    32);
 
 /**
@@ -574,6 +590,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @desc_ring: virtual descriptor ring address
  * @tx_buf: See struct idpf_tx_buf
  * @txq_grp: See struct idpf_txq_group
+ * @complq: corresponding completion queue in XDP mode
  * @dev: Device back pointer for DMA mapping
  * @tail: Tail offset. Used for both queue models single and split
  * @flags: See enum idpf_queue_flags_t
@@ -601,6 +618,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  *	--------------------------------
  *
  *	This gives us 8*8160 = 65280 possible unique values.
+ * @thresh: XDP queue cleaning threshold
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
@@ -619,6 +637,10 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
+ * @pending: number of pending descriptors to send in QB
+ * @xdp_tx: number of pending &xdp_buff or &xdp_frame buffers
+ * @timer: timer for XDP Tx queue cleanup
+ * @xdp_lock: lock for XDP Tx queues sharing
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
  * @q_id: Queue id
@@ -637,7 +659,10 @@ struct idpf_tx_queue {
 		void *desc_ring;
 	};
 	struct libeth_sqe *tx_buf;
-	struct idpf_txq_group *txq_grp;
+	union {
+		struct idpf_txq_group *txq_grp;
+		struct idpf_compl_queue *complq;
+	};
 	struct device *dev;
 	void __iomem *tail;
 
@@ -645,8 +670,13 @@ struct idpf_tx_queue {
 	u16 idx;
 	u16 desc_count;
 
-	u16 tx_min_pkt_len;
-	u16 compl_tag_gen_s;
+	union {
+		struct {
+			u16 tx_min_pkt_len;
+			u16 compl_tag_gen_s;
+		};
+		u32 thresh;
+	};
 
 	struct net_device *netdev;
 	__cacheline_group_end_aligned(read_mostly);
@@ -656,17 +686,28 @@ struct idpf_tx_queue {
 	u16 next_to_clean;
 
 	union {
-		u32 cleaned_bytes;
-		u32 clean_budget;
-	};
-	u16 cleaned_pkts;
-
-	u16 tx_max_bufs;
-	struct idpf_txq_stash *stash;
+		struct {
+			union {
+				u32 cleaned_bytes;
+				u32 clean_budget;
+			};
+			u16 cleaned_pkts;
+
+			u16 tx_max_bufs;
+			struct idpf_txq_stash *stash;
+
+			u16 compl_tag_bufid_m;
+			u16 compl_tag_cur_gen;
+			u16 compl_tag_gen_max;
+		};
+		struct {
+			u32 pending;
+			u32 xdp_tx;
 
-	u16 compl_tag_bufid_m;
-	u16 compl_tag_cur_gen;
-	u16 compl_tag_gen_max;
+			struct libeth_xdpsq_timer *timer;
+			struct libeth_xdpsq_lock xdp_lock;
+		};
+	};
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_tx_queue_stats q_stats;
@@ -681,7 +722,8 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    88 + sizeof(struct u64_stats_sync),
+			    80 + offsetof(struct idpf_tx_queue, q_stats) -
+			    offsetofend(struct idpf_tx_queue, timer),
 			    24);
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
new file mode 100644
index 000000000000..8ace8384f348
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _IDPF_XDP_H_
+#define _IDPF_XDP_H_
+
+#include <linux/types.h>
+
+struct idpf_vport;
+
+int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
+void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
+
+int idpf_vport_xdpq_get(const struct idpf_vport *vport);
+void idpf_vport_xdpq_put(const struct idpf_vport *vport);
+
+#endif /* _IDPF_XDP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 59b1a1a09996..1ca322bfe92f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -186,9 +186,11 @@ static void idpf_get_channels(struct net_device *netdev,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
+	const struct idpf_vport *vport;
 	u16 num_txq, num_rxq;
 	u16 combined;
 
+	vport = idpf_netdev_to_vport(netdev);
 	vport_config = np->adapter->vport_config[np->vport_idx];
 
 	num_txq = vport_config->user_config.num_req_tx_qs;
@@ -202,8 +204,8 @@ static void idpf_get_channels(struct net_device *netdev,
 	ch->max_rx = vport_config->max_q.max_rxq;
 	ch->max_tx = vport_config->max_q.max_txq;
 
-	ch->max_other = IDPF_MAX_MBXQ;
-	ch->other_count = IDPF_MAX_MBXQ;
+	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
+	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;
 
 	ch->combined_count = combined;
 	ch->rx_count = num_rxq - combined;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2594ca38e8ca..0f4edc9cd1ad 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_virtchnl.h"
+#include "xdp.h"
 
 static const struct net_device_ops idpf_netdev_ops;
 
@@ -888,6 +889,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 
 	vport->link_up = false;
 	idpf_vport_intr_deinit(vport);
+	idpf_xdp_rxq_info_deinit_all(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
 	np->state = __IDPF_VPORT_DOWN;
@@ -1262,13 +1264,13 @@ static void idpf_restore_features(struct idpf_vport *vport)
  */
 static int idpf_set_real_num_queues(struct idpf_vport *vport)
 {
-	int err;
+	int err, txq = vport->num_txq - vport->num_xdp_txq;
 
 	err = netif_set_real_num_rx_queues(vport->netdev, vport->num_rxq);
 	if (err)
 		return err;
 
-	return netif_set_real_num_tx_queues(vport->netdev, vport->num_txq);
+	return netif_set_real_num_tx_queues(vport->netdev, txq);
 }
 
 /**
@@ -1377,20 +1379,29 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	}
 
 	idpf_rx_init_buf_tail(vport);
+
+	err = idpf_xdp_rxq_info_init_all(vport);
+	if (err) {
+		netdev_err(vport->netdev,
+			   "Failed to initialize XDP RxQ info for vport %u: %pe\n",
+			   vport->vport_id, ERR_PTR(err));
+		goto intr_deinit;
+	}
+
 	idpf_vport_intr_ena(vport);
 
 	err = idpf_send_config_queues_msg(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure queues for vport %u, %d\n",
 			vport->vport_id, err);
-		goto intr_deinit;
+		goto rxq_deinit;
 	}
 
 	err = idpf_send_map_unmap_queue_vector_msg(vport, true);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map queue vectors for vport %u: %d\n",
 			vport->vport_id, err);
-		goto intr_deinit;
+		goto rxq_deinit;
 	}
 
 	err = idpf_send_enable_queues_msg(vport);
@@ -1438,6 +1449,8 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	idpf_send_disable_queues_msg(vport);
 unmap_queue_vectors:
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
+rxq_deinit:
+	idpf_xdp_rxq_info_deinit_all(vport);
 intr_deinit:
 	idpf_vport_intr_deinit(vport);
 queues_rel:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b6c515d14cbf..5e6e0758e24c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -9,6 +9,7 @@
 
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS("LIBETH");
+MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_LICENSE("GPL");
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index aeb2ca5f5a0a..c81065b4fb24 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -601,7 +601,7 @@ static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq,
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (!libeth_rx_pt_has_checksum(rxq->netdev, decoded))
+	if (!libeth_rx_pt_has_checksum(rxq->xdp_rxq.dev, decoded))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
@@ -740,7 +740,7 @@ static void idpf_rx_singleq_base_hash(struct idpf_rx_queue *rx_q,
 {
 	u64 mask, qw1;
 
-	if (!libeth_rx_pt_has_hash(rx_q->netdev, decoded))
+	if (!libeth_rx_pt_has_hash(rx_q->xdp_rxq.dev, decoded))
 		return;
 
 	mask = VIRTCHNL2_RX_BASE_DESC_FLTSTAT_RSS_HASH_M;
@@ -768,7 +768,7 @@ static void idpf_rx_singleq_flex_hash(struct idpf_rx_queue *rx_q,
 				      const union virtchnl2_rx_desc *rx_desc,
 				      struct libeth_rx_pt decoded)
 {
-	if (!libeth_rx_pt_has_hash(rx_q->netdev, decoded))
+	if (!libeth_rx_pt_has_hash(rx_q->xdp_rxq.dev, decoded))
 		return;
 
 	if (FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_M,
@@ -801,7 +801,7 @@ idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
 	struct libeth_rx_csum csum_bits;
 
 	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_q->netdev);
+	skb->protocol = eth_type_trans(skb, rx_q->xdp_rxq.dev);
 
 	/* Check if we're using base mode descriptor IDs */
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5d51e68c2878..97513822d614 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
-#include <net/libeth/rx.h>
-#include <net/libeth/tx.h>
+#include <net/libeth/xdp.h>
 
 #include "idpf.h"
 #include "idpf_virtchnl.h"
+#include "xdp.h"
 
 struct idpf_tx_stash {
 	struct hlist_node hlist;
@@ -78,8 +78,10 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 	struct libeth_sq_napi_stats ss = { };
 	struct idpf_buf_lifo *buf_stack;
 	struct idpf_tx_stash *stash;
+	struct xdp_frame_bulk bq;
 	struct libeth_cq_pp cp = {
 		.dev	= txq->dev,
+		.bq	= &bq,
 		.ss	= &ss,
 	};
 	struct hlist_node *tmp;
@@ -89,9 +91,13 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 	if (!txq->tx_buf)
 		return;
 
+	xdp_frame_bulk_init(&bq);
+
 	/* Free all the Tx buffer sk_buffs */
 	for (i = 0; i < txq->desc_count; i++)
-		libeth_tx_complete(&txq->tx_buf[i], &cp);
+		libeth_tx_complete_any(&txq->tx_buf[i], &cp);
+
+	xdp_flush_frame_bulk(&bq);
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
@@ -133,7 +139,9 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
 {
 	idpf_tx_buf_rel_all(txq);
-	netdev_tx_reset_subqueue(txq->netdev, txq->idx);
+
+	if (!idpf_queue_has(XDP, txq))
+		netdev_tx_reset_subqueue(txq->netdev, txq->idx);
 
 	if (!txq->desc_ring)
 		return;
@@ -331,7 +339,8 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 				goto err_out;
 			}
 
-			if (!idpf_is_queue_model_split(vport->txq_model))
+			if (!idpf_is_queue_model_split(vport->txq_model) ||
+			    idpf_queue_has(XDP, txq))
 				continue;
 
 			txq->compl_tag_cur_gen = 0;
@@ -589,6 +598,7 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 	struct libeth_fq fq = {
 		.count	= bufq->desc_count,
 		.type	= LIBETH_FQE_HDR,
+		.xdp	= idpf_xdp_is_prog_ena(bufq->q_vector->vport),
 		.nid	= idpf_q_vector_to_mem(bufq->q_vector),
 	};
 	int ret;
@@ -788,6 +798,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 		.count		= bufq->desc_count,
 		.type		= type,
 		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
+		.xdp		= idpf_xdp_is_prog_ena(bufq->q_vector->vport),
 		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
 	};
 	int ret;
@@ -1093,6 +1104,8 @@ void idpf_vport_queues_rel(struct idpf_vport *vport)
 {
 	idpf_tx_desc_rel_all(vport);
 	idpf_rx_desc_rel_all(vport);
+
+	idpf_vport_xdpq_put(vport);
 	idpf_vport_queue_grp_rel_all(vport);
 
 	kfree(vport->txqs);
@@ -1158,6 +1171,18 @@ void idpf_vport_init_num_qs(struct idpf_vport *vport,
 	if (idpf_is_queue_model_split(vport->rxq_model))
 		vport->num_bufq = le16_to_cpu(vport_msg->num_rx_bufq);
 
+	vport->xdp_prog = config_data->xdp_prog;
+	if (idpf_xdp_is_prog_ena(vport)) {
+		vport->xdp_txq_offset = config_data->num_req_tx_qs;
+		vport->num_xdp_txq = le16_to_cpu(vport_msg->num_tx_q) -
+				     vport->xdp_txq_offset;
+		vport->xdpq_share = libeth_xdpsq_shared(vport->num_xdp_txq);
+	} else {
+		vport->xdp_txq_offset = 0;
+		vport->num_xdp_txq = 0;
+		vport->xdpq_share = false;
+	}
+
 	/* Adjust number of buffer queues per Rx queue group. */
 	if (!idpf_is_queue_model_split(vport->rxq_model)) {
 		vport->num_bufqs_per_qgrp = 0;
@@ -1229,9 +1254,10 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 	int dflt_splitq_txq_grps = 0, dflt_singleq_txqs = 0;
 	int dflt_splitq_rxq_grps = 0, dflt_singleq_rxqs = 0;
 	u16 num_req_tx_qs = 0, num_req_rx_qs = 0;
+	struct idpf_vport_user_config_data *user;
 	struct idpf_vport_config *vport_config;
 	u16 num_txq_grps, num_rxq_grps;
-	u32 num_qs;
+	u32 num_qs, num_xdpq;
 
 	vport_config = adapter->vport_config[vport_idx];
 	if (vport_config) {
@@ -1273,6 +1299,24 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 		vport_msg->num_rx_bufq = 0;
 	}
 
+	if (!vport_config)
+		return 0;
+
+	user = &vport_config->user_config;
+	user->num_req_rx_qs = le16_to_cpu(vport_msg->num_rx_q);
+	user->num_req_tx_qs = le16_to_cpu(vport_msg->num_tx_q);
+
+	if (vport_config->user_config.xdp_prog)
+		num_xdpq = libeth_xdpsq_num(user->num_req_rx_qs,
+					    user->num_req_tx_qs,
+					    vport_config->max_q.max_txq);
+	else
+		num_xdpq = 0;
+
+	vport_msg->num_tx_q = cpu_to_le16(user->num_req_tx_qs + num_xdpq);
+	if (idpf_is_queue_model_split(le16_to_cpu(vport_msg->txq_model)))
+		vport_msg->num_tx_complq = vport_msg->num_tx_q;
+
 	return 0;
 }
 
@@ -1322,14 +1366,13 @@ static void idpf_vport_calc_numq_per_grp(struct idpf_vport *vport,
 static void idpf_rxq_set_descids(const struct idpf_vport *vport,
 				 struct idpf_rx_queue *q)
 {
-	if (idpf_is_queue_model_split(vport->rxq_model)) {
-		q->rxdids = VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M;
-	} else {
-		if (vport->base_rxd)
-			q->rxdids = VIRTCHNL2_RXDID_1_32B_BASE_M;
-		else
-			q->rxdids = VIRTCHNL2_RXDID_2_FLEX_SQ_NIC_M;
-	}
+	if (idpf_is_queue_model_split(vport->rxq_model))
+		return;
+
+	if (vport->base_rxd)
+		q->rxdids = VIRTCHNL2_RXDID_1_32B_BASE_M;
+	else
+		q->rxdids = VIRTCHNL2_RXDID_2_FLEX_SQ_NIC_M;
 }
 
 /**
@@ -1545,7 +1588,6 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 setup_rxq:
 			q->desc_count = vport->rxq_desc_count;
 			q->rx_ptype_lkup = vport->rx_ptype_lkup;
-			q->netdev = vport->netdev;
 			q->bufq_sets = rx_qgrp->splitq.bufq_sets;
 			q->idx = (i * num_rxq) + j;
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
@@ -1606,15 +1648,19 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
 	if (err)
 		goto err_out;
 
-	err = idpf_tx_desc_alloc_all(vport);
+	err = idpf_vport_init_fast_path_txqs(vport);
 	if (err)
 		goto err_out;
 
-	err = idpf_rx_desc_alloc_all(vport);
+	err = idpf_vport_xdpq_get(vport);
 	if (err)
 		goto err_out;
 
-	err = idpf_vport_init_fast_path_txqs(vport);
+	err = idpf_tx_desc_alloc_all(vport);
+	if (err)
+		goto err_out;
+
+	err = idpf_rx_desc_alloc_all(vport);
 	if (err)
 		goto err_out;
 
@@ -2148,16 +2194,24 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
  */
 void idpf_wait_for_sw_marker_completion(struct idpf_tx_queue *txq)
 {
-	struct idpf_compl_queue *complq = txq->txq_grp->complq;
 	struct idpf_splitq_4b_tx_compl_desc *tx_desc;
-	s16 ntc = complq->next_to_clean;
+	struct idpf_compl_queue *complq;
 	unsigned long timeout;
 	bool flow, gen_flag;
-	u32 pos = ntc;
+	u32 pos;
+	s16 ntc;
 
 	if (!idpf_queue_has(SW_MARKER, txq))
 		return;
 
+	if (idpf_queue_has(XDP, txq))
+		complq = txq->complq;
+	else
+		complq = txq->txq_grp->complq;
+
+	ntc = complq->next_to_clean;
+	pos = ntc;
+
 	flow = idpf_queue_has(FLOW_SCH_EN, complq);
 	gen_flag = idpf_queue_has(GEN_CHK, complq);
 
@@ -2935,10 +2989,11 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
  */
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
+	const struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
 	struct idpf_tx_queue *tx_q;
 
-	if (unlikely(skb_get_queue_mapping(skb) >= vport->num_txq)) {
+	if (unlikely(skb_get_queue_mapping(skb) >=
+		     vport->num_txq - vport->num_xdp_txq)) {
 		dev_kfree_skb_any(skb);
 
 		return NETDEV_TX_OK;
@@ -2975,7 +3030,7 @@ idpf_rx_hash(const struct idpf_rx_queue *rxq, struct sk_buff *skb,
 {
 	u32 hash;
 
-	if (!libeth_rx_pt_has_hash(rxq->netdev, decoded))
+	if (!libeth_rx_pt_has_hash(rxq->xdp_rxq.dev, decoded))
 		return;
 
 	hash = le16_to_cpu(rx_desc->hash1) |
@@ -3001,7 +3056,7 @@ static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (!libeth_rx_pt_has_checksum(rxq->netdev, decoded))
+	if (!libeth_rx_pt_has_checksum(rxq->xdp_rxq.dev, decoded))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
@@ -3170,7 +3225,7 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	/* process RSS/hash */
 	idpf_rx_hash(rxq, skb, rx_desc, decoded);
 
-	skb->protocol = eth_type_trans(skb, rxq->netdev);
+	skb->protocol = eth_type_trans(skb, rxq->xdp_rxq.dev);
 	skb_record_rx_queue(skb, rxq->idx);
 
 	if (le16_get_bits(rx_desc->hdrlen_flags,
@@ -4181,8 +4236,8 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
  */
 static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 {
+	u16 num_txq_grp = vport->num_txq_grp - vport->num_xdp_txq;
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
-	u16 num_txq_grp = vport->num_txq_grp;
 	struct idpf_rxq_group *rx_qgrp;
 	struct idpf_txq_group *tx_qgrp;
 	u32 i, qv_idx, q_index;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index aa45821f38f1..a86eea9ccd18 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1602,9 +1602,12 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 		for (j = 0; j < num_rxq; j++, k++) {
 			const struct idpf_bufq_set *sets;
 			struct idpf_rx_queue *rxq;
+			u32 rxdids;
 
 			if (!idpf_is_queue_model_split(vport->rxq_model)) {
 				rxq = rx_qgrp->singleq.rxqs[j];
+				rxdids = rxq->rxdids;
+
 				goto common_qi_fields;
 			}
 
@@ -1637,6 +1640,8 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 					cpu_to_le16(rxq->rx_hbuf_size);
 			}
 
+			rxdids = VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M;
+
 common_qi_fields:
 			qi[k].queue_id = cpu_to_le32(rxq->q_id);
 			qi[k].model = cpu_to_le16(vport->rxq_model);
@@ -1647,7 +1652,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			qi[k].data_buffer_size = cpu_to_le32(rxq->rx_buf_size);
 			qi[k].qflags |=
 				cpu_to_le16(VIRTCHNL2_RX_DESC_SIZE_32BYTE);
-			qi[k].desc_ids = cpu_to_le64(rxq->rxdids);
+			qi[k].desc_ids = cpu_to_le64(rxdids);
 		}
 	}
 
@@ -1881,6 +1886,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 
 			if (idpf_queue_has(NOIRQ, txq))
 				vec = NULL;
+			else if (idpf_queue_has(XDP, txq))
+				vec = txq->complq->q_vector;
 			else if (idpf_is_queue_model_split(vport->txq_model))
 				vec = txq->txq_grp->complq->q_vector;
 			else
@@ -1899,9 +1906,6 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		}
 	}
 
-	if (vport->num_txq != k)
-		return -EINVAL;
-
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 		u16 num_rxq;
@@ -1937,13 +1941,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		}
 	}
 
-	if (idpf_is_queue_model_split(vport->txq_model)) {
-		if (vport->num_rxq != k - vport->num_complq)
-			return -EINVAL;
-	} else {
-		if (vport->num_rxq != k - vport->num_txq)
-			return -EINVAL;
-	}
+	if (k != num_q)
+		return -EINVAL;
 
 	/* Chunk up the vector info into multiple messages */
 	config_sz = sizeof(struct virtchnl2_queue_vector_maps);
@@ -3129,7 +3128,10 @@ int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport)
 	u32 req;
 
 	vec_info.num_curr_vecs = vport->num_q_vectors + IDPF_RESERVED_VECS;
-	req = max(vport->num_txq, vport->num_rxq) + IDPF_RESERVED_VECS;
+
+	/* XDPSQs are all bound to the NOIRQ vector from IDPF_RESERVED_VECS */
+	req = max(vport->num_txq - vport->num_xdp_txq, vport->num_rxq) +
+	      IDPF_RESERVED_VECS;
 	vec_info.num_req_vecs = req;
 
 	vec_info.default_vport = vport->default_vport;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
new file mode 100644
index 000000000000..8770249b5abe
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
+
+#include <net/libeth/xdp.h>
+
+#include "idpf.h"
+#include "xdp.h"
+
+static int idpf_rxq_for_each(const struct idpf_vport *vport,
+			     int (*fn)(struct idpf_rx_queue *rxq, void *arg),
+			     void *arg)
+{
+	bool splitq = idpf_is_queue_model_split(vport->rxq_model);
+
+	if (!vport->rxq_grps)
+		return -ENETDOWN;
+
+	for (u32 i = 0; i < vport->num_rxq_grp; i++) {
+		const struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
+		u32 num_rxq;
+
+		if (splitq)
+			num_rxq = rx_qgrp->splitq.num_rxq_sets;
+		else
+			num_rxq = rx_qgrp->singleq.num_rxq;
+
+		for (u32 j = 0; j < num_rxq; j++) {
+			struct idpf_rx_queue *q;
+			int err;
+
+			if (splitq)
+				q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
+			else
+				q = rx_qgrp->singleq.rxqs[j];
+
+			err = fn(q, arg);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * __idpf_xdp_rxq_info_init - Setup XDP RxQ info for a given Rx queue
+ * @rxq: Rx queue for which the resources are setup
+ * @arg: flag indicating if the HW works in split queue mode
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
+{
+	const struct idpf_vport *vport = rxq->q_vector->vport;
+	bool split = idpf_is_queue_model_split(vport->rxq_model);
+	const struct page_pool *pp;
+	int err;
+
+	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
+				 rxq->q_vector->napi.napi_id,
+				 rxq->rx_buf_size);
+	if (err)
+		return err;
+
+	pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
+	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
+
+	if (!split)
+		return 0;
+
+	rxq->xdpqs = &vport->txqs[vport->xdp_txq_offset];
+	rxq->num_xdp_txq = vport->num_xdp_txq;
+
+	return 0;
+}
+
+/**
+ * idpf_xdp_rxq_info_init_all - initialize RxQ info for all Rx queues in vport
+ * @vport: vport to setup the info
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport)
+{
+	return idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_init, NULL);
+}
+
+/**
+ * __idpf_xdp_rxq_info_deinit - Deinit XDP RxQ info for a given Rx queue
+ * @rxq: Rx queue for which the resources are destroyed
+ * @arg: flag indicating if the HW works in split queue mode
+ *
+ * Return: always 0.
+ */
+static int __idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, void *arg)
+{
+	if (idpf_is_queue_model_split((size_t)arg)) {
+		rxq->xdpqs = NULL;
+		rxq->num_xdp_txq = 0;
+	}
+
+	xdp_rxq_info_detach_mem_model(&rxq->xdp_rxq);
+	xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+	return 0;
+}
+
+/**
+ * idpf_xdp_rxq_info_deinit_all - deinit RxQ info for all Rx queues in vport
+ * @vport: vport to setup the info
+ */
+void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport)
+{
+	idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_deinit,
+			  (void *)(size_t)vport->rxq_model);
+}
+
+int idpf_vport_xdpq_get(const struct idpf_vport *vport)
+{
+	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
+	struct net_device *dev;
+	u32 sqs;
+
+	if (!idpf_xdp_is_prog_ena(vport))
+		return 0;
+
+	timers = kvcalloc(vport->num_xdp_txq, sizeof(*timers), GFP_KERNEL);
+	if (!timers)
+		return -ENOMEM;
+
+	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
+		timers[i] = kzalloc_node(sizeof(*timers[i]), GFP_KERNEL,
+					 cpu_to_mem(i));
+		if (!timers[i]) {
+			for (int j = i - 1; j >= 0; j--)
+				kfree(timers[j]);
+
+			return -ENOMEM;
+		}
+	}
+
+	dev = vport->netdev;
+	sqs = vport->xdp_txq_offset;
+
+	for (u32 i = sqs; i < vport->num_txq; i++) {
+		struct idpf_tx_queue *xdpq = vport->txqs[i];
+
+		xdpq->complq = xdpq->txq_grp->complq;
+
+		idpf_queue_clear(FLOW_SCH_EN, xdpq);
+		idpf_queue_clear(FLOW_SCH_EN, xdpq->complq);
+		idpf_queue_set(NOIRQ, xdpq);
+		idpf_queue_set(XDP, xdpq);
+		idpf_queue_set(XDP, xdpq->complq);
+
+		xdpq->timer = timers[i - sqs];
+		libeth_xdpsq_get(&xdpq->xdp_lock, dev, vport->xdpq_share);
+
+		xdpq->pending = 0;
+		xdpq->xdp_tx = 0;
+		xdpq->thresh = libeth_xdp_queue_threshold(xdpq->desc_count);
+	}
+
+	return 0;
+}
+
+void idpf_vport_xdpq_put(const struct idpf_vport *vport)
+{
+	struct net_device *dev;
+	u32 sqs;
+
+	if (!idpf_xdp_is_prog_ena(vport))
+		return;
+
+	dev = vport->netdev;
+	sqs = vport->xdp_txq_offset;
+
+	for (u32 i = sqs; i < vport->num_txq; i++) {
+		struct idpf_tx_queue *xdpq = vport->txqs[i];
+
+		if (!idpf_queue_has_clear(XDP, xdpq))
+			continue;
+
+		libeth_xdpsq_put(&xdpq->xdp_lock, dev);
+
+		kfree(xdpq->timer);
+		idpf_queue_clear(NOIRQ, xdpq);
+	}
+}
-- 
2.48.1


