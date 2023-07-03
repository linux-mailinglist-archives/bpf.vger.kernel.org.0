Return-Path: <bpf+bounces-3897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D49F74620B
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6361C2039E
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133F125A8;
	Mon,  3 Jul 2023 18:17:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48C11C85;
	Mon,  3 Jul 2023 18:17:27 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577BE10DC;
	Mon,  3 Jul 2023 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408227; x=1719944227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPs+QqrE7DYCSpmfrjr3V9OXSRfVGq64QEUHjo4opww=;
  b=K676gjp2DN63OwU3AdUhHSuUsLzCs3HhRC95hgomHZt0AthUIwIf2nwT
   CXl1uNbuAXyi4lsNyMqx2ZmfMhA3lKti8t9v8W6clPQHVKVvvvmo4PmZ3
   jHZXUW2xlXjEnIqQJu1009c2qHmv0YHEVjvuO2byFPgF9OI4uKPARt13f
   99kl9UkMV6yKNBsKdkoaHIaX1a2eG1KFBQWZYP7iNeyLgU2LFNYan81wE
   zvHElfC6g84Tg4pmZPvVoXo8nn+xd/j8DbKZfQDPs6aAjimi4/fkGfgjh
   O/qgfRAmzlLUOR56m6tk8Mc3NISm5RNsAXqiIisXQK325AmG3MZjik4+N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393682640"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393682640"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892615129"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892615129"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 11:17:00 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A9FDF35804;
	Mon,  3 Jul 2023 19:16:58 +0100 (IST)
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
Subject: [PATCH bpf-next v2 10/20] ice: Implement VLAN tag hint
Date: Mon,  3 Jul 2023 20:12:16 +0200
Message-ID: <20230703181226.19380-11-larysa.zaremba@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement .xmo_rx_vlan_tag callback to allow XDP code to read
packet's VLAN tag.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  2 +-
 6 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f21996b812ea..ab7129b0dc67 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5930,6 +5930,23 @@ ice_fix_features(struct net_device *netdev, netdev_features_t features)
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
@@ -5972,6 +5989,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
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
index 4e6546d9cf85..1eee7d98f92c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1278,7 +1278,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			continue;
 		}
 
-		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
+		vlan_tag = ice_get_vlan_tag(rx_desc);
 
 		/* pad the skb if needed, to make a valid ethernet frame */
 		if (eth_skb_pad(skb))
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
index b11cfaedb81c..c290c9d20c5c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -639,7 +639,33 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
+ * @ctx: XDP buff pointer
+ * @vlan_tag: destination address for VLAN tag
+ * @vlan_proto: destination address for VLAN protocol
+ *
+ * Copy VLAN tag (if was stripped) and corresponding protocol
+ * to the destination address.
+ */
+static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
+			       __be16 *vlan_proto)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+
+	*vlan_proto = xdp_ext->pkt_ctx.vlan_proto;
+	if (!*vlan_proto)
+		return -ENODATA;
+
+	*vlan_tag = ice_get_vlan_tag(xdp_ext->pkt_ctx.eop_desc);
+	if (!*vlan_tag)
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
index 145883eec129..d0af716c1497 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -84,7 +84,7 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
 }
 
 /**
- * ice_get_vlan_tag_from_rx_desc - get VLAN from Rx flex descriptor
+ * ice_get_vlan_tag - get VLAN from Rx flex descriptor
  * @rx_desc: Rx 32b flex descriptor with RXDID=2
  *
  * The OS and current PF implementation only support stripping a single VLAN tag
@@ -92,7 +92,7 @@ ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
  * one is found return the tag, else return 0 to mean no VLAN tag was found.
  */
 static inline u16
-ice_get_vlan_tag_from_rx_desc(union ice_32b_rx_flex_desc *rx_desc)
+ice_get_vlan_tag(const union ice_32b_rx_flex_desc *rx_desc)
 {
 	u16 stat_err_bits;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 197ebefc6307..cf205ea177fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -859,7 +859,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
-		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
+		vlan_tag = ice_get_vlan_tag(rx_desc);
 
 		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
 				       ICE_RX_FLEX_DESC_PTYPE_M;
-- 
2.41.0


