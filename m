Return-Path: <bpf+bounces-12049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777057C73C4
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E8C282CEF
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453DF347CD;
	Thu, 12 Oct 2023 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keWObJNt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8630CFD;
	Thu, 12 Oct 2023 17:12:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DACC0;
	Thu, 12 Oct 2023 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130761; x=1728666761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4CnrcnuYoc2jJmfpS5RjlaIk68wYTv9Od645Z+g6PU=;
  b=keWObJNto+YKVmd7g8M8peGL8xaZdP86LayVu/3a+8JzS4+oquWU4yO/
   QZAh2y4b7oIsq55Pobh6DL3QU73ZO5wpPKnqUaEYPipW5lK2eriwo/Hvd
   b7julAot0kCFJuZ+6k4rWQF8YKOnpeO5t0azf+bRdV7YgB/FefWnitsbx
   r/gyAcJeriM0BAgLw4ke3PSStD3IMiMt9BWsFx4AjAYRvO7pxeHjBU8gf
   28bLeKvwP/d3Q3XKnrO8ZlpgfTpWBcbjp/Ts4ZN8zACZtoJWWpq08ldpe
   qI2hOrYuLaq/g4WhnquRXKPCD9ofq6V26oKp1gTTvl9NK41aagsO6ZlIZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416027538"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416027538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783773917"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783773917"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2023 10:11:50 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8A70533E8C;
	Thu, 12 Oct 2023 18:11:47 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v6 01/18] ice: make RX hash reading code more reusable
Date: Thu, 12 Oct 2023 19:05:07 +0200
Message-ID: <20231012170524.21085-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012170524.21085-1-larysa.zaremba@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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


