Return-Path: <bpf+bounces-3906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1067746246
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2701C208C5
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518417AC5;
	Mon,  3 Jul 2023 18:17:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B617AAF;
	Mon,  3 Jul 2023 18:17:33 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890B10C1;
	Mon,  3 Jul 2023 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408248; x=1719944248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VVfvPZk07eYXOKS3obL93Fx2WtN98r9PPSTw/tJOPIo=;
  b=UOWeScYBOkPyyluz2Z+9bsjFPoqIa84oZgIhfU9HXE/N2U33XAyaDwVG
   zvn6llNiRzSR37q0dzehmnlEjdqwcF4attDjvEg9hXncudR1NuPZ9XMNj
   XbRiYLlpY8j1+DHpp6hWSEPObxb8QsA0eHt/3sPZcsqUW+QcX426mIn1y
   zSr/pvBpjkgDdHNAd9HK92oVgXMfQ+m9DI7NBgz1HfJq/tL7RN36nr4ll
   EmFmirFxprQ6wXShoHy5IWh+O0/hmVVUwZuGtolFV0qKO1EnuDs+XgpPe
   BReSmoX5SgCr41b0oL3Tg6smpFan+J/xbx9Ir5RUrsZfOgcxowCTAmuJz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="428982930"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="428982930"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753816414"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="753816414"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 11:16:47 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 96C6C35804;
	Mon,  3 Jul 2023 19:16:45 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 06/20] ice: Support HW timestamp hint
Date: Mon,  3 Jul 2023 20:12:12 +0200
Message-ID: <20230703181226.19380-7-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703181226.19380-1-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use previously refactored code and create a function
that allows XDP code to read HW timestamp.

Also, move cached_phctime into packet context, this way this data still
stays in the ring structure, just at the different address.

HW timestamp is the first supported hint in the driver,
so also add xdp_metadata_ops.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  2 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 24 +++++++++++++++++++
 7 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 4ba3d99439a0..7a973a2229f1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -943,4 +943,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
 	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
 }
+
+extern const struct xdp_metadata_ops ice_xdp_md_ops;
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8d5cbbd0b3d5..3c3b9cbfbcd3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2837,7 +2837,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		/* clone ring and setup updated count */
 		rx_rings[i] = *vsi->rx_rings[i];
 		rx_rings[i].count = new_rx_cnt;
-		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
+		rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].rx_buf = NULL;
 		/* this is to allow wr32 to have something to write to
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 00e3afd507a4..eb69b0ac7956 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->netdev = vsi->netdev;
 		ring->dev = dev;
 		ring->count = vsi->num_rx_desc;
-		ring->cached_phctime = pf->ptp.cached_phc_time;
+		ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
 		WRITE_ONCE(vsi->rx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 93979ab18bc1..f21996b812ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3384,6 +3384,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->netdev_ops = &ice_netdev_ops;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
+	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
 
 	if (vsi->type != ICE_VSI_PF)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a31333972c68..70697e4829dd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1038,7 +1038,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 		ice_for_each_rxq(vsi, j) {
 			if (!vsi->rx_rings[j])
 				continue;
-			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
+			WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime, systime);
 		}
 	}
 	clear_bit(ICE_CFG_BUSY, pf->state);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index d0ab2c4c0c91..4237702a58a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -259,6 +259,7 @@ enum ice_rx_dtype {
 
 struct ice_pkt_ctx {
 	const union ice_32b_rx_flex_desc *eop_desc;
+	u64 cached_phctime;
 };
 
 struct ice_xdp_buff {
@@ -354,7 +355,6 @@ struct ice_rx_ring {
 	struct ice_tx_ring *xdp_ring;
 	struct xsk_buff_pool *xsk_pool;
 	dma_addr_t dma;			/* physical address of ring */
-	u64 cached_phctime;
 	u16 rx_buf_len;
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 ptp_rx;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index beb1c5bb392a..463d9e5cbe05 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
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
+	u64 cached_time;
+
+	cached_time = READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
+	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->pkt_ctx.eop_desc, cached_time);
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


