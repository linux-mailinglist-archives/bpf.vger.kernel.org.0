Return-Path: <bpf+bounces-16795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B17806046
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4EEB21103
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FF6E2BE;
	Tue,  5 Dec 2023 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMbwLi+P"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5955318B;
	Tue,  5 Dec 2023 13:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810662; x=1733346662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIPs8OkxbcRyH9fN/7CIMfvpVVKSW10/NHWPjuFwP8c=;
  b=WMbwLi+PVmUH/QMZ0LqHduc0PJFM2htD9Ndnv3sJHeo6HkwvytxQEbhR
   CswrmPbtipqnhNP/o0EC9toaIn2tRfsuhdbjJwawCj6RM0iMIP1qBuVLY
   qYUYI1NOcq57uA0oW9V67d6zqB/Eo5jU5a4s1/vOpMO4/oC20QJ45GbT+
   lB7YMtNfXXydE+WbYojzm6ORkSYxVE7eEZo8p1R5aQc311RCo27/TFeDm
   1DWQp2uWRseyuC/cmLOchRf0waxkvo1q6raPFggpVadblPWcm46sD2QEi
   kNygaRMxvvIdQRLyYovBYRzrFcUpDsgZiKVH+/tnWVSX0kdxh8cp7zSAk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421885"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421885"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757703"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757703"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:10:56 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 299BE3433E;
	Tue,  5 Dec 2023 21:10:54 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v8 05/18] ice: Support HW timestamp hint
Date: Tue,  5 Dec 2023 22:08:34 +0100
Message-ID: <20231205210847.28460-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use previously refactored code and create a function
that allows XDP code to read HW timestamp.

Also, introduce packet context, where hints-related data will be stored.
ice_xdp_buff contains only a pointer to this structure, to avoid copying it
in ZC mode later in the series.

HW timestamp is the first supported hint in the driver,
so also add xdp_metadata_ops.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  2 ++
 drivers/net/ethernet/intel/ice/ice_base.c     |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  6 ++---
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  4 +--
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 10 +++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 25 ++++++++++++++++++-
 7 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index cd7dcd0fa7f2..9cf4ed3d2885 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -996,4 +996,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
 	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
 }
+
+extern const struct xdp_metadata_ops ice_xdp_md_ops;
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7fa43827a3f0..2d83f3c029e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -575,6 +575,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 
 	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
 	ring->xdp.data = NULL;
+	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
 	err = ice_setup_rx_ctx(ring);
 	if (err) {
 		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 43ba3e55b8c1..0a2415dd78f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3397,6 +3397,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->netdev_ops = &ice_netdev_ops;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
+	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
 
 	if (vsi->type != ICE_VSI_PF)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index bb54f43b5a18..a4d3a9ee409a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2129,12 +2129,12 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 /**
  * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
  * @rx_desc: Receive descriptor
- * @rx_ring: Ring to get the cached time
+ * @pkt_ctx: Packet context to get the cached time
  *
  * The driver receives a notification in the receive descriptor with timestamp.
  */
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
-			struct ice_rx_ring *rx_ring)
+			const struct ice_pkt_ctx *pkt_ctx)
 {
 	u64 ts_ns, cached_time;
 	u32 ts_high;
@@ -2142,7 +2142,7 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
 		return 0;
 
-	cached_time = READ_ONCE(rx_ring->cached_phctime);
+	cached_time = READ_ONCE(pkt_ctx->cached_phctime);
 
 	/* Do not report a timestamp if we don't have a cached PHC time */
 	if (!cached_time)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 45327cb92bc6..5c6450e4f2f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -299,7 +299,7 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
-			struct ice_rx_ring *rx_ring);
+			const struct ice_pkt_ctx *pkt_ctx);
 void ice_ptp_reset(struct ice_pf *pf);
 void ice_ptp_prepare_for_reset(struct ice_pf *pf);
 void ice_ptp_init(struct ice_pf *pf);
@@ -331,7 +331,7 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
 
 static inline u64
 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
-		    struct ice_rx_ring *rx_ring)
+		    const struct ice_pkt_ctx *pkt_ctx)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index cd93394fab17..ce3434c73a4b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -257,9 +257,14 @@ enum ice_rx_dtype {
 	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
 };
 
+struct ice_pkt_ctx {
+	u64 cached_phctime;
+};
+
 struct ice_xdp_buff {
 	struct xdp_buff xdp_buff;
 	const union ice_32b_rx_flex_desc *eop_desc;
+	const struct ice_pkt_ctx *pkt_ctx;
 };
 
 /* Required for compatibility with xdp_buffs from xsk_pool */
@@ -328,6 +333,10 @@ struct ice_rx_ring {
 		struct xdp_buff xdp;
 	};
 	/* CL3 - 3rd cacheline starts here */
+	union {
+		struct ice_pkt_ctx pkt_ctx;
+		u64 cached_phctime;
+	};
 	struct bpf_prog *xdp_prog;
 	u16 rx_offset;
 
@@ -346,7 +355,6 @@ struct ice_rx_ring {
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
 	dma_addr_t dma;			/* physical address of ring */
-	u64 cached_phctime;
 	u16 rx_buf_len;
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 ptp_rx;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 8904b22bfba7..13b8a9addfac 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -197,7 +197,7 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
 		       const union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb)
 {
-	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, rx_ring);
+	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, &rx_ring->pkt_ctx);
 
 	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts_ns);
 }
@@ -507,3 +507,26 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
 			spin_unlock(&xdp_ring->tx_lock);
 	}
 }
+
+/**
+ * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
+ * @ctx: XDP buff pointer
+ * @ts_ns: destination address
+ *
+ * Copy HW timestamp (if available) to the destination address.
+ */
+static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+
+	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->eop_desc,
+				     xdp_ext->pkt_ctx);
+	if (!*ts_ns)
+		return -ENODATA;
+
+	return 0;
+}
+
+const struct xdp_metadata_ops ice_xdp_md_ops = {
+	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
+};
-- 
2.41.0


