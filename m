Return-Path: <bpf+bounces-16801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BB806057
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979231F21525
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479B66E2DB;
	Tue,  5 Dec 2023 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kef03BW8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFFA1A4;
	Tue,  5 Dec 2023 13:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810680; x=1733346680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7euoZru5kbJKpbcCOk0geyp/0OeG4K2Km0V418j+bA=;
  b=Kef03BW8UcNGNbHNEW6oK6dXx6WBFfKWk8um0vfdFSqnMTlnNdv7Zh/l
   P7vFcQfGmMn4KPRNWxIw8STDCvWE1rOTtk5trOp0kPU7PIHaDza7Ss1hU
   rUIhQQ5bP/vwWEHfQhkwwrw/1p7BnAWvZO4pL7XEThRk6m1EE3XV6sFvi
   JKLueT5LsWavK3fGSh2uX0E3JbmT5CjfUyB/QHmCALL2IlvxzpukM9zvV
   vDzRiwR8Nf3ykDkgYKCqxxo84KOmu6HLF9L0l/R+vbTZIQxoAIlMTJgTa
   sKwflEXDVi+DvsO3/qVA2pMlYN1KKfKE9UD20ZCXfC+wJJxKyr4oFEGRC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421962"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421962"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757847"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757847"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:11:14 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A7D2934328;
	Tue,  5 Dec 2023 21:11:12 +0000 (GMT)
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
Subject: [PATCH bpf-next v8 11/18] ice: use VLAN proto from ring packet context in skb path
Date: Tue,  5 Dec 2023 22:08:40 +0100
Message-ID: <20231205210847.28460-12-larysa.zaremba@intel.com>
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

VLAN proto, used in ice XDP hints implementation is stored in ring packet
context. Utilize this value in skb VLAN processing too instead of checking
netdev features.

At the same time, use vlan_tci instead of vlan_tag in touched code,
because VLAN tag often refers to VLAN proto and VLAN TCI combined,
while in the code we clearly store only VLAN TCI.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 +++++---------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 25ffb539b474..839e5da24ad5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -244,21 +244,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
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
+	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
+		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
+				       vlan_tci);
 
 	napi_gro_receive(&rx_ring->q_vector->napi, skb);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 3893af1c11f3..762047508619 100644
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


