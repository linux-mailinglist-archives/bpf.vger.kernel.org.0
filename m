Return-Path: <bpf+bounces-5357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A30759DAE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750521C2110A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306F275CE;
	Wed, 19 Jul 2023 18:41:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0301BB25;
	Wed, 19 Jul 2023 18:41:54 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7349C6;
	Wed, 19 Jul 2023 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792112; x=1721328112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qz6hpuLmviOaGmr6V7y7olDqf74RE+uzgNC6icYUHTw=;
  b=gPTPDnnd1VyAJSowBOXwn2e2c0Ci4hQL/xl042f5Qp3ItpyOsRPUfh1y
   oCao6yUsU/Lo9GAEX/aF+Mjvrxuv3lyszZiSxuDQnDPVyQ0731cbDjFN6
   ffM0lWQwFxG/PMjzaGLg9a9CGNXtcI5LrmG8WqkWPJDkJcxc+rNUORzSc
   mOeljkezvKPFjwhvktAt8K/JqOM5BmtPorAjtC+21wNrNexvpok+ewyuh
   qSfTq5tagMZBIbLdw9Yx+9iMpO2m0zjsWUgg2n6cUifqCB2pCE3xPN17/
   TBBcDLf5xdjZIpeoD+RYB9/xFGgemuScdK0/sqGy+t9ySoLUpKDYRbIYX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356504715"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356504715"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674405667"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674405667"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 11:41:47 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 87B8E33BE5;
	Wed, 19 Jul 2023 19:41:45 +0100 (IST)
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
Subject: [PATCH bpf-next v3 03/21] ice: make RX checksum checking code more reusable
Date: Wed, 19 Jul 2023 20:37:16 +0200
Message-ID: <20230719183734.21681-4-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183734.21681-1-larysa.zaremba@intel.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previously, we only needed RX checksum flags in skb path,
hence all related code was written with skb in mind.
But with the addition of XDP hints via kfuncs to the ice driver,
the same logic will be needed in .xmo_() callbacks.

Put generic process of determining checksum status into
a separate function.

Now we cannot operate directly on skb, when deducing
checksum status, therefore introduce an intermediate enum for checksum
status. Fortunately, in ice, we have only 4 possibilities: checksum
validated at level 0, validated at level 1, no checksum, checksum error.
Use 3 bits for more convenient conversion.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
 1 file changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index b2f241b73934..8b155a502b3b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
 		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
 }
 
+enum ice_rx_csum_status {
+	ICE_RX_CSUM_LVL_0	= 0,
+	ICE_RX_CSUM_LVL_1	= BIT(0),
+	ICE_RX_CSUM_NONE	= BIT(1),
+	ICE_RX_CSUM_ERROR	= BIT(2),
+	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
+};
+
 /**
- * ice_rx_csum - Indicate in skb if checksum is good
- * @ring: the ring we care about
- * @skb: skb currently being received and modified
+ * ice_rx_csum_lvl - Get checksum level from status
+ * @status: driver-specific checksum status
+ */
+static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
+{
+	return status & ICE_RX_CSUM_LVL_1;
+}
+
+/**
+ * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
+ * @status: driver-specific checksum status
+ */
+static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
+{
+	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
+}
+
+/**
+ * ice_get_rx_csum_status - Deduce checksum status from descriptor
  * @rx_desc: the receive descriptor
  * @ptype: the packet type decoded by hardware
  *
- * skb->protocol must be set before this function is called
+ * Returns driver-specific checksum status
  */
-static void
-ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
-	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+static enum ice_rx_csum_status
+ice_get_rx_csum_status(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
 {
 	struct ice_rx_ptype_decoded decoded;
 	u16 rx_status0, rx_status1;
@@ -124,20 +147,12 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 
 	decoded = ice_decode_rx_desc_ptype(ptype);
 
-	/* Start with CHECKSUM_NONE and by default csum_level = 0 */
-	skb->ip_summed = CHECKSUM_NONE;
-	skb_checksum_none_assert(skb);
-
-	/* check if Rx checksum is enabled */
-	if (!(ring->netdev->features & NETIF_F_RXCSUM))
-		return;
-
 	/* check if HW has decoded the packet and checksum */
 	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
-		return;
+		return ICE_RX_CSUM_NONE;
 
 	if (!(decoded.known && decoded.outer_ip))
-		return;
+		return ICE_RX_CSUM_NONE;
 
 	ipv4 = (decoded.outer_ip == ICE_RX_PTYPE_OUTER_IP) &&
 	       (decoded.outer_ip_ver == ICE_RX_PTYPE_OUTER_IPV4);
@@ -146,43 +161,61 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S) |
 				   BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))
-		goto checksum_fail;
+		return ICE_RX_CSUM_FAIL;
 
 	if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
-		goto checksum_fail;
+		return ICE_RX_CSUM_FAIL;
 
 	/* check for L4 errors and handle packets that were not able to be
 	 * checksummed due to arrival speed
 	 */
 	if (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S))
-		goto checksum_fail;
+		return ICE_RX_CSUM_FAIL;
 
 	/* check for outer UDP checksum error in tunneled packets */
 	if ((rx_status1 & BIT(ICE_RX_FLEX_DESC_STATUS1_NAT_S)) &&
 	    (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EUDPE_S)))
-		goto checksum_fail;
-
-	/* If there is an outer header present that might contain a checksum
-	 * we need to bump the checksum level by 1 to reflect the fact that
-	 * we are indicating we validated the inner checksum.
-	 */
-	if (decoded.tunnel_type >= ICE_RX_PTYPE_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
+		return ICE_RX_CSUM_FAIL;
 
 	/* Only report checksum unnecessary for TCP, UDP, or SCTP */
 	switch (decoded.inner_prot) {
 	case ICE_RX_PTYPE_INNER_PROT_TCP:
 	case ICE_RX_PTYPE_INNER_PROT_UDP:
 	case ICE_RX_PTYPE_INNER_PROT_SCTP:
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		break;
-	default:
-		break;
+		/* If there is an outer header present that might contain
+		 * a checksum we need to bump the checksum level by 1 to reflect
+		 * the fact that we have validated the inner checksum.
+		 */
+		return decoded.tunnel_type >= ICE_RX_PTYPE_TUNNEL_IP_GRENAT ?
+		       ICE_RX_CSUM_LVL_1 : ICE_RX_CSUM_LVL_0;
 	}
-	return;
 
-checksum_fail:
-	ring->vsi->back->hw_csum_rx_error++;
+	return ICE_RX_CSUM_NONE;
+}
+
+/**
+ * ice_rx_csum_into_skb - Indicate in skb if checksum is good
+ * @ring: the ring we care about
+ * @skb: skb currently being received and modified
+ * @rx_desc: the receive descriptor
+ * @ptype: the packet type decoded by hardware
+ */
+static void
+ice_rx_csum_into_skb(struct ice_rx_ring *ring, struct sk_buff *skb,
+		     const union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+{
+	enum ice_rx_csum_status csum_status;
+
+	/* check if Rx checksum is enabled */
+	if (!(ring->netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	csum_status = ice_get_rx_csum_status(rx_desc, ptype);
+	if (csum_status & ICE_RX_CSUM_ERROR)
+		ring->vsi->back->hw_csum_rx_error++;
+
+	skb->ip_summed = ice_rx_csum_ip_summed(csum_status);
+	skb->csum_level = ice_rx_csum_lvl(csum_status);
 }
 
 /**
@@ -229,7 +262,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 
-	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
+	ice_rx_csum_into_skb(rx_ring, skb, rx_desc, ptype);
 
 	if (rx_ring->ptp_rx)
 		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
-- 
2.41.0


