Return-Path: <bpf+bounces-61400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FBFAE6CD0
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EA64A42EA
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77C2EA47E;
	Tue, 24 Jun 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2H1PQCp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384082E9ED8;
	Tue, 24 Jun 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783571; cv=none; b=YLv1QxEjdQRAzwKTcmP6tNWX9J4yd8+kvkSWZdKTbr3i1c27t42lbfPYIWOOyCP5LFRwl/ybW5iIRNXTPQNb+HXCZQKhRihJHkCwG4hs3M89K7QMscRrtg8ZtagkSh7kTQ/y81LhOViB1ECMvRva21lUKI/2TYyZ9FfjK6tb26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783571; c=relaxed/simple;
	bh=oG2mxV3FgG7XwGefnVnRXqbkOMTWcGzLyKEtafxQTT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szYV7ea539S3sN20z6NHk9+LGO0LKfMdw9u7MsErSWhb3ZiZQ0VH5eccwOEAH+D9PhG4S+PzE9R3b8O2ivPCrCBeEAJ0IzdnXOPUk/rLvB576uUlzXYaJ5Hmf0Iri6oaawwpdsvrpZw0kRclACFV/zuMq42MS5TVUDSJ/QlqFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2H1PQCp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750783569; x=1782319569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oG2mxV3FgG7XwGefnVnRXqbkOMTWcGzLyKEtafxQTT0=;
  b=G2H1PQCpZhLLyomVgZXwWo8zaGAI+fac0Fqqcu8vzzlwiC9H38JtXn6A
   zNmn55zye+R6ZFbfe6EK1m+7hCN0LeOyQ/k4ovtylvPIvCpLRGx1R4ZmV
   /q91K1buCcc5RLpWekeJ45XpgxPcO6/z9dOPee1YpvCLmspEAr0IcfHe5
   vOlKz2kBmoL6YznZ3WcWUR5YprCJvPNh+uyfF9trfIpCdTpHKZM7Y25E3
   XmOIWhQYBZ19Bz0ryqb2CotTZnK/qBPzsV7Gq2DBQfOr5UYPILOrZcY6M
   1N2adU3trZdjH4jRu8ZbpxxY3JaBJQB5KDzHLmkDpBVk7+s91yi5mn0EP
   g==;
X-CSE-ConnectionGUID: zvox/cMWQueDF3OaIlc6Qw==
X-CSE-MsgGUID: 3Jv8qxtTR/aW3cSxKBtbJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64091244"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64091244"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 09:46:08 -0700
X-CSE-ConnectionGUID: QSIXMzjfQ6u1Cqgp5kXbXQ==
X-CSE-MsgGUID: 0+wS4CFbRSS6PXk+k6jexQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="152669481"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jun 2025 09:46:04 -0700
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
Subject: [PATCH iwl-next v2 07/12] idpf: prepare structures to support XDP
Date: Tue, 24 Jun 2025 18:45:10 +0200
Message-ID: <20250624164515.2663137-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
References: <20250624164515.2663137-1-aleksander.lobakin@intel.com>
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
Note that "other count" in Ethtool will now also include XDP Tx queues.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |   2 +-
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  16 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  89 +++++++---
 drivers/net/ethernet/intel/idpf/xdp.h         |  17 ++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  21 ++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 107 +++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  25 +--
 drivers/net/ethernet/intel/idpf/xdp.c         | 165 ++++++++++++++++++
 12 files changed, 388 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 2c359a8551c7..adab2154125b 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -6,7 +6,7 @@ config IDPF
 	depends on PCI_MSI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select DIMLIB
-	select LIBETH
+	select LIBETH_XDP
 	help
 	  This driver supports Intel(R) Infrastructure Data Path Function
 	  devices.
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 83ac5e296382..4405a26dc70c 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -20,3 +20,5 @@ idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
 
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
+
+idpf-y				+= xdp.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 316b601a03b6..1ef7974f48aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -261,6 +261,10 @@ struct idpf_port_stats {
  * @txq_model: Split queue or single queue queuing model
  * @txqs: Used only in hotpath to get to the right queue very fast
  * @crc_enable: Enable CRC insertion offload
+ * @xdpsq_share: whether XDPSQ sharing is enabled
+ * @num_xdp_txq: number of XDPSQs
+ * @xdp_txq_offset: index of the first XDPSQ (== number of regular SQs)
+ * @xdp_prog: installed XDP program
  * @num_rxq: Number of allocated RX queues
  * @num_bufq: Number of allocated buffer queues
  * @rxq_desc_count: RX queue descriptor count. *MUST* have enough descriptors
@@ -310,6 +314,11 @@ struct idpf_vport {
 	struct idpf_tx_queue **txqs;
 	bool crc_enable;
 
+	bool xdpsq_share;
+	u16 num_xdp_txq;
+	u16 xdp_txq_offset;
+	struct bpf_prog *xdp_prog;
+
 	u16 num_rxq;
 	u16 num_bufq;
 	u32 rxq_desc_count;
@@ -391,6 +400,7 @@ struct idpf_rss_data {
  *		      ethtool
  * @num_req_rxq_desc: Number of user requested RX queue descriptors through
  *		      ethtool
+ * @xdp_prog: requested XDP program to install
  * @user_flags: User toggled config flags
  * @mac_filter_list: List of MAC filters
  *
@@ -402,6 +412,7 @@ struct idpf_vport_user_config_data {
 	u16 num_req_rx_qs;
 	u32 num_req_txq_desc;
 	u32 num_req_rxq_desc;
+	struct bpf_prog *xdp_prog;
 	DECLARE_BITMAP(user_flags, __IDPF_USER_FLAGS_NBITS);
 	struct list_head mac_filter_list;
 };
@@ -625,6 +636,11 @@ static inline int idpf_is_queue_model_split(u16 q_model)
 	       q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
 }
 
+static inline bool idpf_xdp_enabled(const struct idpf_vport *vport)
+{
+	return vport->adapter && vport->xdp_prog;
+}
+
 #define idpf_is_cap_ena(adapter, field, flag) \
 	idpf_is_capability_ena(adapter, false, field, flag)
 #define idpf_is_cap_ena_all(adapter, field, flag) \
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4cce3c5c3739..03215f386bf6 100644
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
@@ -294,6 +296,7 @@ struct idpf_ptype_state {
  * @__IDPF_Q_PTP: indicates whether the Rx timestamping is enabled for the
  *		  queue
  * @__IDPF_Q_NOIRQ: queue is polling-driven and has no interrupt
+ * @__IDPF_Q_XDP: this is an XDP queue
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -305,6 +308,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_HSPLIT_EN,
 	__IDPF_Q_PTP,
 	__IDPF_Q_NOIRQ,
+	__IDPF_Q_XDP,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -488,19 +492,21 @@ struct idpf_txq_stash {
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
+ * @xdpsqs: shortcut for XDP Tx queues array
  * @rxdids: Supported RX descriptor ids
+ * @truesize: data buffer truesize in singleq
  * @rx_ptype_lkup: LUT of Rx ptypes
+ * @xdp_rxq: XDP queue info
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
  * @skb: Pointer to the skb
- * @truesize: data buffer truesize in singleq
  * @cached_phc_time: Cached PHC time for the Rx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
@@ -531,15 +537,23 @@ struct idpf_rx_queue {
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
+		struct idpf_tx_queue **xdpsqs;
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
@@ -548,7 +562,6 @@ struct idpf_rx_queue {
 	u16 next_to_alloc;
 
 	struct sk_buff *skb;
-	u32 truesize;
 	u64 cached_phc_time;
 
 	struct u64_stats_sync stats_sync;
@@ -568,8 +581,11 @@ struct idpf_rx_queue {
 	u16 rx_max_pkt_size;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
-			    88 + sizeof(struct u64_stats_sync),
+libeth_cacheline_set_assert(struct idpf_rx_queue,
+			    ALIGN(64, __alignof(struct xdp_rxq_info)) +
+			    sizeof(struct xdp_rxq_info),
+			    72 + offsetof(struct idpf_rx_queue, q_stats) -
+			    offsetofend(struct idpf_rx_queue, skb),
 			    32);
 
 /**
@@ -581,6 +597,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @desc_ring: virtual descriptor ring address
  * @tx_buf: See struct idpf_tx_buf
  * @txq_grp: See struct idpf_txq_group
+ * @complq: corresponding completion queue in XDP mode
  * @dev: Device back pointer for DMA mapping
  * @tail: Tail offset. Used for both queue models single and split
  * @flags: See enum idpf_queue_flags_t
@@ -608,6 +625,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  *	--------------------------------
  *
  *	This gives us 8*8160 = 65280 possible unique values.
+ * @thresh: XDP queue cleaning threshold
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
@@ -626,6 +644,10 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
+ * @pending: number of pending descriptors to send in QB
+ * @xdp_tx: number of pending &xdp_buff or &xdp_frame buffers
+ * @timer: timer for XDP Tx queue cleanup
+ * @xdp_lock: lock for XDP Tx queues sharing
  * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
  * @tstamp_task: Work that handles Tx timestamp read
  * @stats_sync: See struct u64_stats_sync
@@ -646,7 +668,10 @@ struct idpf_tx_queue {
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
 
@@ -654,8 +679,13 @@ struct idpf_tx_queue {
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
@@ -665,17 +695,28 @@ struct idpf_tx_queue {
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
 
 	struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
 	struct work_struct *tstamp_task;
@@ -693,7 +734,11 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    112 + sizeof(struct u64_stats_sync),
+			    104 +
+			    offsetof(struct idpf_tx_queue, cached_tstamp_caps) -
+			    offsetofend(struct idpf_tx_queue, timer) +
+			    offsetof(struct idpf_tx_queue, q_stats) -
+			    offsetofend(struct idpf_tx_queue, tstamp_task),
 			    24);
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
new file mode 100644
index 000000000000..cf6823b24ba5
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
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
+int idpf_xdpsqs_get(const struct idpf_vport *vport);
+void idpf_xdpsqs_put(const struct idpf_vport *vport);
+
+#endif /* _IDPF_XDP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 9bdb309b668e..d3836f695b6d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -187,9 +187,11 @@ static void idpf_get_channels(struct net_device *netdev,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
+	const struct idpf_vport *vport;
 	u16 num_txq, num_rxq;
 	u16 combined;
 
+	vport = idpf_netdev_to_vport(netdev);
 	vport_config = np->adapter->vport_config[np->vport_idx];
 
 	num_txq = vport_config->user_config.num_req_tx_qs;
@@ -203,8 +205,8 @@ static void idpf_get_channels(struct net_device *netdev,
 	ch->max_rx = vport_config->max_q.max_rxq;
 	ch->max_tx = vport_config->max_q.max_txq;
 
-	ch->max_other = IDPF_MAX_MBXQ;
-	ch->other_count = IDPF_MAX_MBXQ;
+	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
+	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;
 
 	ch->combined_count = combined;
 	ch->rx_count = num_rxq - combined;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index caac316bf7f2..e2631c710573 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -4,6 +4,7 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 #include "idpf_ptp.h"
+#include "xdp.h"
 
 static const struct net_device_ops idpf_netdev_ops;
 
@@ -856,6 +857,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 
 	vport->link_up = false;
 	idpf_vport_intr_deinit(vport);
+	idpf_xdp_rxq_info_deinit_all(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
 	np->state = __IDPF_VPORT_DOWN;
@@ -1239,13 +1241,13 @@ static void idpf_restore_features(struct idpf_vport *vport)
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
@@ -1354,20 +1356,29 @@ static int idpf_vport_open(struct idpf_vport *vport)
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
@@ -1415,6 +1426,8 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	idpf_send_disable_queues_msg(vport);
 unmap_queue_vectors:
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
+rxq_deinit:
+	idpf_xdp_rxq_info_deinit_all(vport);
 intr_deinit:
 	idpf_vport_intr_deinit(vport);
 queues_rel:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 0efd9c0c7a90..b5802103014b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -9,6 +9,7 @@
 
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS("LIBETH");
+MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_LICENSE("GPL");
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 555879b1248d..4685e3b7229a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -602,7 +602,7 @@ static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq,
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (!libeth_rx_pt_has_checksum(rxq->netdev, decoded))
+	if (!libeth_rx_pt_has_checksum(rxq->xdp_rxq.dev, decoded))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
@@ -741,7 +741,7 @@ static void idpf_rx_singleq_base_hash(struct idpf_rx_queue *rx_q,
 {
 	u64 mask, qw1;
 
-	if (!libeth_rx_pt_has_hash(rx_q->netdev, decoded))
+	if (!libeth_rx_pt_has_hash(rx_q->xdp_rxq.dev, decoded))
 		return;
 
 	mask = VIRTCHNL2_RX_BASE_DESC_FLTSTAT_RSS_HASH_M;
@@ -769,7 +769,7 @@ static void idpf_rx_singleq_flex_hash(struct idpf_rx_queue *rx_q,
 				      const union virtchnl2_rx_desc *rx_desc,
 				      struct libeth_rx_pt decoded)
 {
-	if (!libeth_rx_pt_has_hash(rx_q->netdev, decoded))
+	if (!libeth_rx_pt_has_hash(rx_q->xdp_rxq.dev, decoded))
 		return;
 
 	if (FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_M,
@@ -802,7 +802,7 @@ idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
 	struct libeth_rx_csum csum_bits;
 
 	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_q->netdev);
+	skb->protocol = eth_type_trans(skb, rx_q->xdp_rxq.dev);
 
 	/* Check if we're using base mode descriptor IDs */
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e1cdc35e2bfa..c176af58c0e2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
-#include <net/libeth/rx.h>
-#include <net/libeth/tx.h>
+#include <net/libeth/xdp.h>
 
 #include "idpf.h"
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
+#include "xdp.h"
 
 struct idpf_tx_stash {
 	struct hlist_node hlist;
@@ -79,8 +79,10 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
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
@@ -90,9 +92,13 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
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
@@ -133,8 +139,15 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
  */
 static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
 {
+	bool xdp = idpf_queue_has(XDP, txq);
+
+	if (xdp)
+		libeth_xdpsq_deinit_timer(txq->timer);
+
 	idpf_tx_buf_rel_all(txq);
-	netdev_tx_reset_subqueue(txq->netdev, txq->idx);
+
+	if (!xdp)
+		netdev_tx_reset_subqueue(txq->netdev, txq->idx);
 
 	if (!txq->desc_ring)
 		return;
@@ -332,7 +345,8 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 				goto err_out;
 			}
 
-			if (!idpf_is_queue_model_split(vport->txq_model))
+			if (!idpf_is_queue_model_split(vport->txq_model) ||
+			    idpf_queue_has(XDP, txq))
 				continue;
 
 			txq->compl_tag_cur_gen = 0;
@@ -590,6 +604,7 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 	struct libeth_fq fq = {
 		.count	= bufq->desc_count,
 		.type	= LIBETH_FQE_HDR,
+		.xdp	= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid	= idpf_q_vector_to_mem(bufq->q_vector),
 	};
 	int ret;
@@ -789,6 +804,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 		.count		= bufq->desc_count,
 		.type		= type,
 		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
+		.xdp		= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
 	};
 	int ret;
@@ -1094,6 +1110,8 @@ void idpf_vport_queues_rel(struct idpf_vport *vport)
 {
 	idpf_tx_desc_rel_all(vport);
 	idpf_rx_desc_rel_all(vport);
+
+	idpf_xdpsqs_put(vport);
 	idpf_vport_queue_grp_rel_all(vport);
 
 	kfree(vport->txqs);
@@ -1167,6 +1185,18 @@ void idpf_vport_init_num_qs(struct idpf_vport *vport,
 	if (idpf_is_queue_model_split(vport->rxq_model))
 		vport->num_bufq = le16_to_cpu(vport_msg->num_rx_bufq);
 
+	vport->xdp_prog = config_data->xdp_prog;
+	if (idpf_xdp_enabled(vport)) {
+		vport->xdp_txq_offset = config_data->num_req_tx_qs;
+		vport->num_xdp_txq = le16_to_cpu(vport_msg->num_tx_q) -
+				     vport->xdp_txq_offset;
+		vport->xdpsq_share = libeth_xdpsq_shared(vport->num_xdp_txq);
+	} else {
+		vport->xdp_txq_offset = 0;
+		vport->num_xdp_txq = 0;
+		vport->xdpsq_share = false;
+	}
+
 	/* Adjust number of buffer queues per Rx queue group. */
 	if (!idpf_is_queue_model_split(vport->rxq_model)) {
 		vport->num_bufqs_per_qgrp = 0;
@@ -1238,9 +1268,10 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 	int dflt_splitq_txq_grps = 0, dflt_singleq_txqs = 0;
 	int dflt_splitq_rxq_grps = 0, dflt_singleq_rxqs = 0;
 	u16 num_req_tx_qs = 0, num_req_rx_qs = 0;
+	struct idpf_vport_user_config_data *user;
 	struct idpf_vport_config *vport_config;
 	u16 num_txq_grps, num_rxq_grps;
-	u32 num_qs;
+	u32 num_qs, num_xdpsq;
 
 	vport_config = adapter->vport_config[vport_idx];
 	if (vport_config) {
@@ -1282,6 +1313,24 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
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
+		num_xdpsq = libeth_xdpsq_num(user->num_req_rx_qs,
+					     user->num_req_tx_qs,
+					     vport_config->max_q.max_txq);
+	else
+		num_xdpsq = 0;
+
+	vport_msg->num_tx_q = cpu_to_le16(user->num_req_tx_qs + num_xdpsq);
+	if (idpf_is_queue_model_split(le16_to_cpu(vport_msg->txq_model)))
+		vport_msg->num_tx_complq = vport_msg->num_tx_q;
+
 	return 0;
 }
 
@@ -1331,14 +1380,13 @@ static void idpf_vport_calc_numq_per_grp(struct idpf_vport *vport,
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
@@ -1554,7 +1602,6 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 setup_rxq:
 			q->desc_count = vport->rxq_desc_count;
 			q->rx_ptype_lkup = vport->rx_ptype_lkup;
-			q->netdev = vport->netdev;
 			q->bufq_sets = rx_qgrp->splitq.bufq_sets;
 			q->idx = (i * num_rxq) + j;
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
@@ -1615,15 +1662,19 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
 	if (err)
 		goto err_out;
 
-	err = idpf_tx_desc_alloc_all(vport);
+	err = idpf_vport_init_fast_path_txqs(vport);
 	if (err)
 		goto err_out;
 
-	err = idpf_rx_desc_alloc_all(vport);
+	err = idpf_xdpsqs_get(vport);
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
 
@@ -2127,14 +2178,17 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
  */
 void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 {
-	struct idpf_compl_queue *complq = txq->txq_grp->complq;
-	u32 ntc = complq->next_to_clean;
+	struct idpf_compl_queue *complq;
 	unsigned long timeout;
 	bool flow, gen_flag;
+	u32 ntc;
 
 	if (!idpf_queue_has(SW_MARKER, txq))
 		return;
 
+	complq = idpf_queue_has(XDP, txq) ? txq->complq : txq->txq_grp->complq;
+	ntc = complq->next_to_clean;
+
 	flow = idpf_queue_has(FLOW_SCH_EN, complq);
 	gen_flag = idpf_queue_has(GEN_CHK, complq);
 
@@ -2978,10 +3032,11 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
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
@@ -3018,7 +3073,7 @@ idpf_rx_hash(const struct idpf_rx_queue *rxq, struct sk_buff *skb,
 {
 	u32 hash;
 
-	if (!libeth_rx_pt_has_hash(rxq->netdev, decoded))
+	if (!libeth_rx_pt_has_hash(rxq->xdp_rxq.dev, decoded))
 		return;
 
 	hash = le16_to_cpu(rx_desc->hash1) |
@@ -3044,7 +3099,7 @@ static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (!libeth_rx_pt_has_checksum(rxq->netdev, decoded))
+	if (!libeth_rx_pt_has_checksum(rxq->xdp_rxq.dev, decoded))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
@@ -3243,7 +3298,7 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	if (idpf_queue_has(PTP, rxq))
 		idpf_rx_hwtstamp(rxq, rx_desc, skb);
 
-	skb->protocol = eth_type_trans(skb, rxq->netdev);
+	skb->protocol = eth_type_trans(skb, rxq->xdp_rxq.dev);
 	skb_record_rx_queue(skb, rxq->idx);
 
 	if (le16_get_bits(rx_desc->hdrlen_flags,
@@ -4242,8 +4297,8 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
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
index 3e3fa3df2ac0..ababdb746f1e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1574,9 +1574,12 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
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
 
@@ -1609,6 +1612,8 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 					cpu_to_le16(rxq->rx_hbuf_size);
 			}
 
+			rxdids = VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M;
+
 common_qi_fields:
 			qi[k].queue_id = cpu_to_le32(rxq->q_id);
 			qi[k].model = cpu_to_le16(vport->rxq_model);
@@ -1619,7 +1624,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			qi[k].data_buffer_size = cpu_to_le32(rxq->rx_buf_size);
 			qi[k].qflags |=
 				cpu_to_le16(VIRTCHNL2_RX_DESC_SIZE_32BYTE);
-			qi[k].desc_ids = cpu_to_le64(rxq->rxdids);
+			qi[k].desc_ids = cpu_to_le64(rxdids);
 		}
 	}
 
@@ -1853,6 +1858,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 
 			if (idpf_queue_has(NOIRQ, txq))
 				vec = NULL;
+			else if (idpf_queue_has(XDP, txq))
+				vec = txq->complq->q_vector;
 			else if (idpf_is_queue_model_split(vport->txq_model))
 				vec = txq->txq_grp->complq->q_vector;
 			else
@@ -1871,9 +1878,6 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		}
 	}
 
-	if (vport->num_txq != k)
-		return -EINVAL;
-
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 		u16 num_rxq;
@@ -1909,13 +1913,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
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
@@ -3110,7 +3109,9 @@ int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport)
 	if (vec_info.num_curr_vecs)
 		vec_info.num_curr_vecs += IDPF_RESERVED_VECS;
 
-	req = max(vport->num_txq, vport->num_rxq) + IDPF_RESERVED_VECS;
+	/* XDPSQs are all bound to the NOIRQ vector from IDPF_RESERVED_VECS */
+	req = max(vport->num_txq - vport->num_xdp_txq, vport->num_rxq) +
+	      IDPF_RESERVED_VECS;
 	vec_info.num_req_vecs = req;
 
 	vec_info.default_vport = vport->default_vport;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
new file mode 100644
index 000000000000..08d63462dca4
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
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
+	rxq->xdpsqs = &vport->txqs[vport->xdp_txq_offset];
+	rxq->num_xdp_txq = vport->num_xdp_txq;
+
+	return 0;
+}
+
+int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport)
+{
+	return idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_init, NULL);
+}
+
+static int __idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, void *arg)
+{
+	if (idpf_is_queue_model_split((size_t)arg)) {
+		rxq->xdpsqs = NULL;
+		rxq->num_xdp_txq = 0;
+	}
+
+	xdp_rxq_info_detach_mem_model(&rxq->xdp_rxq);
+	xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+	return 0;
+}
+
+void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport)
+{
+	idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_deinit,
+			  (void *)(size_t)vport->rxq_model);
+}
+
+int idpf_xdpsqs_get(const struct idpf_vport *vport)
+{
+	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
+	struct net_device *dev;
+	u32 sqs;
+
+	if (!idpf_xdp_enabled(vport))
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
+		struct idpf_tx_queue *xdpsq = vport->txqs[i];
+
+		xdpsq->complq = xdpsq->txq_grp->complq;
+
+		idpf_queue_clear(FLOW_SCH_EN, xdpsq);
+		idpf_queue_clear(FLOW_SCH_EN, xdpsq->complq);
+		idpf_queue_set(NOIRQ, xdpsq);
+		idpf_queue_set(XDP, xdpsq);
+		idpf_queue_set(XDP, xdpsq->complq);
+
+		xdpsq->timer = timers[i - sqs];
+		libeth_xdpsq_get(&xdpsq->xdp_lock, dev, vport->xdpsq_share);
+
+		xdpsq->pending = 0;
+		xdpsq->xdp_tx = 0;
+		xdpsq->thresh = libeth_xdp_queue_threshold(xdpsq->desc_count);
+	}
+
+	return 0;
+}
+
+void idpf_xdpsqs_put(const struct idpf_vport *vport)
+{
+	struct net_device *dev;
+	u32 sqs;
+
+	if (!idpf_xdp_enabled(vport))
+		return;
+
+	dev = vport->netdev;
+	sqs = vport->xdp_txq_offset;
+
+	for (u32 i = sqs; i < vport->num_txq; i++) {
+		struct idpf_tx_queue *xdpsq = vport->txqs[i];
+
+		if (!idpf_queue_has_clear(XDP, xdpsq))
+			continue;
+
+		libeth_xdpsq_put(&xdpsq->xdp_lock, dev);
+
+		kfree(xdpsq->timer);
+		idpf_queue_clear(NOIRQ, xdpsq);
+	}
+}
-- 
2.49.0


