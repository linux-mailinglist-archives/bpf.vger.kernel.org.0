Return-Path: <bpf+bounces-15102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE47EC9F1
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC04B20BF3
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069B433D2;
	Wed, 15 Nov 2023 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nt57Q0ov"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57681A3;
	Wed, 15 Nov 2023 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070870; x=1731606870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TK64ivuFuRCIeLcjq7GOORv6AeTZ7OZrTjy41scyu54=;
  b=Nt57Q0ovtFXfWFcWywzEEII1oqjyHyEMNy+HuYwW81LgfFSSffdC+ApX
   3Vxn5ZbSb3KAFyMr8o+i4nbBhkdFF2Uo2gkH3DCl2fVShtxWNG71MOtW1
   qwTeWmoRHAnSABeUpPG0jyZGhTpC/RcYDqw8+DzBzk3OUEt6pvdf8WnnE
   cJT6VFBjjcWUsspzkz2CoIGHvbVFkU1/PTovTFaOdnHHpPMytHjmrxLyt
   MA+6SEqHJk4iABcwq3tajwEK2+fgQ17wppPwM/OTy5kfo/s7rjXy2wfjL
   WjH78P0nX5uJ/YuR6m6FByn/WPB4smZLqBSY16zkyeeh7gN65g/VhUZZQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422020421"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="422020421"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12842574"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2023 09:54:24 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 050013581F;
	Wed, 15 Nov 2023 17:54:19 +0000 (GMT)
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
Subject: [PATCH bpf-next v7 01/18] ice: make RX hash reading code more reusable
Date: Wed, 15 Nov 2023 18:52:43 +0100
Message-ID: <20231115175301.534113-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115175301.534113-1-larysa.zaremba@intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 7e06373e14d9..17530359aaf8 100644
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


