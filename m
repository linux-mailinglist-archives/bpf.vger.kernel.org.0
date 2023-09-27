Return-Path: <bpf+bounces-10922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B431D7AFD31
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9B8B72827B7
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513F1CAB6;
	Wed, 27 Sep 2023 07:57:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211E1CA9D;
	Wed, 27 Sep 2023 07:57:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C80711D;
	Wed, 27 Sep 2023 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801458; x=1727337458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4CnrcnuYoc2jJmfpS5RjlaIk68wYTv9Od645Z+g6PU=;
  b=Wprx1bxJW3HN4r/g8i75gkTYsVvPTmmRMgFewK7qJnPTgu/im9IDVOhS
   a/SMtflEe5Br7r6/PKP8uRB0bALg0/QDyBrFaa9jue1Z91AV/jpNzcrqM
   lq5KYgvyvX8akaoElOCwAlJM0qWgKSE0c1P1qm8ffmPIMPuT6DCJw5TtW
   aQHogGckQWRxm565v/TuIbrtEHpWKe4qBoETW8ge/FssJsAmQ45C7cQat
   bIs7YCo0EW25ZwexLhCGcSXA1IDrZKpMaaVOY3YH7f0wphAmHrozyFg0A
   XIkAgrHJjlSBAf+OZqXaDycuznbu9mAwg+1k8muCoPe2F7t94dxl6GpTC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366817816"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366817816"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1080039380"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1080039380"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2023 00:57:31 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BE0547EAC2;
	Wed, 27 Sep 2023 08:57:29 +0100 (IST)
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
Subject: [RFC bpf-next v2 01/24] ice: make RX hash reading code more reusable
Date: Wed, 27 Sep 2023 09:51:01 +0200
Message-ID: <20230927075124.23941-2-larysa.zaremba@intel.com>
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

Previously, we only needed RX hash in skb path,
hence all related code was written with skb in mind.
But with the addition of XDP hints via kfuncs to the ice driver,
the same logic will be needed in .xmo_() callbacks.

Separate generic process of reading RX hash from a descriptor
into a separate function.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 36 +++++++++++++------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index c8322fb6f2b3..987050dacead 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -63,28 +63,42 @@ static enum pkt_hash_types ice_ptype_to_htype(u16 ptype)
 }
 
 /**
- * ice_rx_hash - set the hash value in the skb
+ * ice_get_rx_hash - get RX hash value from descriptor
+ * @rx_desc: specific descriptor
+ *
+ * Returns hash, if present, 0 otherwise.
+ */
+static u32 ice_get_rx_hash(const union ice_32b_rx_flex_desc *rx_desc)
+{
+	const struct ice_32b_rx_flex_desc_nic *nic_mdid;
+
+	if (unlikely(rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC))
+		return 0;
+
+	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+	return le32_to_cpu(nic_mdid->rss_hash);
+}
+
+/**
+ * ice_rx_hash_to_skb - set the hash value in the skb
  * @rx_ring: descriptor ring
  * @rx_desc: specific descriptor
  * @skb: pointer to current skb
  * @rx_ptype: the ptype value from the descriptor
  */
 static void
-ice_rx_hash(struct ice_rx_ring *rx_ring, union ice_32b_rx_flex_desc *rx_desc,
-	    struct sk_buff *skb, u16 rx_ptype)
+ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
+		   const union ice_32b_rx_flex_desc *rx_desc,
+		   struct sk_buff *skb, u16 rx_ptype)
 {
-	struct ice_32b_rx_flex_desc_nic *nic_mdid;
 	u32 hash;
 
 	if (!(rx_ring->netdev->features & NETIF_F_RXHASH))
 		return;
 
-	if (rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC)
-		return;
-
-	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
-	hash = le32_to_cpu(nic_mdid->rss_hash);
-	skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
+	hash = ice_get_rx_hash(rx_desc);
+	if (likely(hash))
+		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
 }
 
 /**
@@ -186,7 +200,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb, u16 ptype)
 {
-	ice_rx_hash(rx_ring, rx_desc, skb, ptype);
+	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
 
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
-- 
2.41.0


