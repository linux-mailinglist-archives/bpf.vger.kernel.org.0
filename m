Return-Path: <bpf+bounces-7576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203677945A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AB1C21709
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D2360C8;
	Fri, 11 Aug 2023 16:20:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8746360C0;
	Fri, 11 Aug 2023 16:20:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2B92;
	Fri, 11 Aug 2023 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691770842; x=1723306842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69SLNieOMYH9CALkb/az9AtO+g5KYeF9MrPXL3ZVWcI=;
  b=O/B2FNnJnChBtURl/0qzbL7nnKfDxpXNJ+RKIJiJ1WhF2MWLqLVKtEre
   4N2jBfgHz2toJu6zbYnRcICW3kz1qL4HYKiuHgx7eoEkX6k0uxI5GqIme
   SYIAgA8s+glmMvc0J1IyQC8M3cbGYW8j9Cpo70WoIhuxIXqk5d2wezYem
   33vlxpoN4e7bTIKwUinLAYRCUdLrdno+bIdK1jNeKGo7h8/suFIelJ3QO
   BzM1WH4Ph01EP0Rl4I2uC/C07XaloIxFwHuW57MK6CnGKabeBruYbZO6n
   4SWjXe6sZKVsvqfJsksXRl2hjZP7+FG+fMwda3DhyeY4DUHSQaJf2ZTdU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="356672083"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="356672083"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063363809"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1063363809"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 09:20:27 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DE133332D6;
	Fri, 11 Aug 2023 17:20:25 +0100 (IST)
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
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf-next v5 10/21] ice: Implement VLAN tag hint
Date: Fri, 11 Aug 2023 18:14:58 +0200
Message-ID: <20230811161509.19722-11-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement .xmo_rx_vlan_tag callback to allow XDP code to read
packet's VLAN tag.

At the same time, use vlan_tci instead of vlan_tag in touched code,
because vlan_tag is misleading.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 ++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++---
 6 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 557c6326ff87..aff4fa1a75f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6007,6 +6007,23 @@ ice_fix_features(struct net_device *netdev, netdev_features_t features)
 	return features;
 }
 
+/**
+ * ice_set_rx_rings_vlan_proto - update rings with new stripped VLAN proto
+ * @vsi: PF's VSI
+ * @vlan_ethertype: VLAN ethertype (802.1Q or 802.1ad) in network byte order
+ *
+ * Store current stripped VLAN proto in ring packet context,
+ * so it can be accessed more efficiently by packet processing code.
+ */
+static void
+ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)
+{
+	u16 i;
+
+	ice_for_each_alloc_rxq(vsi, i)
+		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
+}
+
 /**
  * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
  * @vsi: PF's VSI
@@ -6049,6 +6066,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
 	if (strip_err || insert_err)
 		return -EIO;
 
+	if (enable_stripping)
+		ice_set_rx_rings_vlan_proto(vsi, htons(vlan_ethertype));
+	else
+		ice_set_rx_rings_vlan_proto(vsi, 0);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4e6546d9cf85..4fd7614f243d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1183,7 +1183,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		struct sk_buff *skb;
 		unsigned int size;
 		u16 stat_err_bits;
-		u16 vlan_tag = 0;
+		u16 vlan_tci;
 
 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
@@ -1278,7 +1278,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			continue;
 		}
 
-		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
+		vlan_tci = ice_get_vlan_tci(rx_desc);
 
 		/* pad the skb if needed, to make a valid ethernet frame */
 		if (eth_skb_pad(skb))
@@ -1292,7 +1292,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
-		ice_receive_skb(rx_ring, skb, vlan_tag);
+		ice_receive_skb(rx_ring, skb, vlan_tci);
 
 		/* update budget accounting */
 		total_rx_pkts++;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 4237702a58a9..41e0b14e6643 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -260,6 +260,7 @@ enum ice_rx_dtype {
 struct ice_pkt_ctx {
 	const union ice_32b_rx_flex_desc *eop_desc;
 	u64 cached_phctime;
+	__be16 vlan_proto;
 };
 
 struct ice_xdp_buff {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index b11cfaedb81c..10e7ec51f4ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -639,7 +639,33 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
+ * @ctx: XDP buff pointer
+ * @vlan_tci: destination address for VLAN tag
+ * @vlan_proto: destination address for VLAN protocol
+ *
+ * Copy VLAN tag (if was stripped) and corresponding protocol
+ * to the destination address.
+ */
+static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
+			       __be16 *vlan_proto)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+
+	*vlan_proto = xdp_ext->pkt_ctx.vlan_proto;
+	if (!*vlan_proto)
+		return -ENODATA;
+
+	*vlan_tci = ice_get_vlan_tci(xdp_ext->pkt_ctx.eop_desc);
+	if (!*vlan_tci)
+		return -ENODATA;
+
+	return 0;
+}
+
 const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
+	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 145883eec129..b7205826fea8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -84,7 +84,7 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
 }
 
 /**
- * ice_get_vlan_tag_from_rx_desc - get VLAN from Rx flex descriptor
+ * ice_get_vlan_tci - get VLAN TCI from Rx flex descriptor
  * @rx_desc: Rx 32b flex descriptor with RXDID=2
  *
  * The OS and current PF implementation only support stripping a single VLAN tag
@@ -92,7 +92,7 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
  * one is found return the tag, else return 0 to mean no VLAN tag was found.
  */
 static inline u16
-ice_get_vlan_tag_from_rx_desc(union ice_32b_rx_flex_desc *rx_desc)
+ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc)
 {
 	u16 stat_err_bits;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index fdeddad9b639..eeb02f76b4a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -878,7 +878,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		struct xdp_buff *xdp;
 		struct sk_buff *skb;
 		u16 stat_err_bits;
-		u16 vlan_tag = 0;
+		u16 vlan_tci;
 
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
@@ -957,10 +957,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
-		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
+		vlan_tci = ice_get_vlan_tci(rx_desc);
 
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
-		ice_receive_skb(rx_ring, skb, vlan_tag);
+		ice_receive_skb(rx_ring, skb, vlan_tci);
 	}
 
 	rx_ring->next_to_clean = ntc;
-- 
2.41.0


