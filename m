Return-Path: <bpf+bounces-10931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9A17AFD48
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 51A6B282D58
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5C1CFBF;
	Wed, 27 Sep 2023 07:58:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F61CABA;
	Wed, 27 Sep 2023 07:58:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE34192;
	Wed, 27 Sep 2023 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801498; x=1727337498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4FvQHLR1N+f4Esc2uC/HIP8mZcnq/zuM3ieQ/BPGhtI=;
  b=kR8FUpIhK6zFO6dGCqFaZIvyHbJ/X5o/kui+QDsYBhL3UHRUmOuPgWDK
   DO1a3MmjEiS03n+8FoBv09I6l5lNxp5fSI3+1ZPoIXOVSAZ6rTajyja8S
   TpLiIP9/nzs+kO3KdSuNWxI89EuhB63COInm1NtQaEjH+UrUUmXxrTrnO
   fVGHN4Eux+9rRovD0i2cWvAEi4PolIQ0KGlaIoHChboH7uwLinhYnBOID
   eJi6y8cEcGMrWPORudawW/5kHUXWbR9i2omwB5QaEsJl93nuuWgOFYWY8
   gsMqAWR/mH3dphI6aKyUvbUzHN8Etp8E4o4ERjPrAitRO5faEQw0Sq1zj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366818068"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366818068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725714040"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725714040"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 00:58:10 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9ED276D51D;
	Wed, 27 Sep 2023 08:58:07 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [RFC bpf-next v2 11/24] ice: use VLAN proto from ring packet context in skb path
Date: Wed, 27 Sep 2023 09:51:11 +0200
Message-ID: <20230927075124.23941-12-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927075124.23941-1-larysa.zaremba@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index fa138f66e1c4..cc4ba7e995b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -271,21 +271,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
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
+	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->pkt_ctx.vlan_proto)
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


