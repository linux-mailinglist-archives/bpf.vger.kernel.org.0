Return-Path: <bpf+bounces-6244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BCC7673D6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CE81C21209
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AC20FBA;
	Fri, 28 Jul 2023 17:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071C1FB58;
	Fri, 28 Jul 2023 17:44:40 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED835BF;
	Fri, 28 Jul 2023 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566278; x=1722102278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/LoVeU9MwFyVOuQuEJeVQ0WN2WsBdzG519CSrAsYi0=;
  b=RIVZG9yGAWo93tpnPwObULUH2rgaSU+udN2Z6aDAMRLT1aSLPzaj6E1p
   zH1Nk61BMo0uaNti3LYLXgF4A7mclwqmFRC1uB4oo2abs/vUhhYVMAFTv
   PD+w5+0ZiT7EdUIANvDltYat9F4jjGJSrPmmwtq/ope+pd6AO36rSnns/
   7++a2gDRFh8lwLZcv9TY1YNV1qcUTtF9AipNV1STvZ228M/nlXUMIcEV8
   H+qKA+PIE7fwEKfIk5TVFUlmlLsYwUo9q9zh6zL7+KuHOsieUpvDrU0HU
   CFupuR2WZpbXiqThtELiXfOdtIv30R+nNnjR4Cekcz1fsD+R73ImJzjYs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="366117417"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366117417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="851294651"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851294651"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 10:44:26 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C0D9E386AC;
	Fri, 28 Jul 2023 18:44:24 +0100 (IST)
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
Subject: [PATCH bpf-next v4 11/21] ice: use VLAN proto from ring packet context in skb path
Date: Fri, 28 Jul 2023 19:39:13 +0200
Message-ID: <20230728173923.1318596-12-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173923.1318596-1-larysa.zaremba@intel.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VLAN proto, used in ice XDP hints implementation is stored in ring packet
context. Utilize this value in skb VLAN processing too instead of checking
netdev features.

At the same time, use vlan_tci instead of vlan_tag in touched code,
because vlan_tag is misleading.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 +++++---------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 10e7ec51f4ef..6ae57a98a4d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -283,21 +283,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
  * ice_receive_skb - Send a completed packet up the stack
  * @rx_ring: Rx ring in play
  * @skb: packet to send up
- * @vlan_tag: VLAN tag for packet
+ * @vlan_tci: VLAN TCI for packet
  *
  * This function sends the completed packet (via. skb) up the stack using
  * gro receive functions (with/without VLAN tag)
  */
 void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
+ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
 {
-	netdev_features_t features = rx_ring->netdev->features;
-	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
-
-	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
-	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
+	if (vlan_tci & VLAN_VID_MASK && rx_ring->pkt_ctx.vlan_proto)
+		__vlan_hwaccel_put_tag(skb, rx_ring->pkt_ctx.vlan_proto,
+				       vlan_tci);
 
 	napi_gro_receive(&rx_ring->q_vector->napi, skb);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index b7205826fea8..8487884bf5c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -150,7 +150,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb);
 void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
+ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
 
 static inline void
 ice_xdp_meta_set_desc(struct xdp_buff *xdp,
-- 
2.41.0


