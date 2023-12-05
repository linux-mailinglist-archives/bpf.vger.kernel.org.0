Return-Path: <bpf+bounces-16793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B680603F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0B3B20F95
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE876E2D9;
	Tue,  5 Dec 2023 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnX0b5Uj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED918F;
	Tue,  5 Dec 2023 13:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810658; x=1733346658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMTHlUnhoWk4peiWKmZ406PxiWZ8OXM+cbiU+ynEXy8=;
  b=bnX0b5Uj7OLOxWwp2C9v9YINP+vkNKJpKHn0UvbCoDeihxNc1osxgNv6
   /z568s8WaFQunCMjvtGXTNVThAekaGEFxa3sDRy0hEIY1lER9W75F2n7Q
   sHe+eBe2tUz8Qzumjn1mHGTgtNDw/umVtx6Skb9ZtvWa6ec/oufDy7J3N
   hT1RIGrZG2ERYbCQOp7duAvMvUNtUqeUnTU7OgO0si3wF8qxtmQylbAxE
   aNLSmGfh6yBJ+1CYDwSetJZjkZy4o1sXJmch2k178XjAb/0DZiNyGVh3u
   OkW0ydmUimVwYVaa++Q+DddPBrsx8F3y/OIfT57UKtARpaj3WFXBC2/Nt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421854"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421854"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757664"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757664"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:10:51 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1DD6434328;
	Tue,  5 Dec 2023 21:10:48 +0000 (GMT)
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
Subject: [PATCH bpf-next v8 03/18] ice: Make ptype internal to descriptor info processing
Date: Tue,  5 Dec 2023 22:08:32 +0100
Message-ID: <20231205210847.28460-4-larysa.zaremba@intel.com>
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

Currently, rx_ptype variable is used only as an argument
to ice_process_skb_fields() and is computed
just before the function call.

Therefore, there is no reason to pass this value as an argument.
Instead, remove this argument and compute the value directly inside
ice_process_skb_fields() function.

Also, separate its calculation into a short function, so the code
can later be reused in .xmo_() callbacks.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 +-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 15 +++++++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 +-----
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 9e97ea863068..6afe4cf1de8a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1181,7 +1181,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		unsigned int size;
 		u16 stat_err_bits;
 		u16 vlan_tag = 0;
-		u16 rx_ptype;
 
 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
@@ -1286,10 +1285,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 
 		/* populate checksum, VLAN, and protocol */
-		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
-			ICE_RX_FLEX_DESC_PTYPE_M;
-
-		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
+		ice_process_skb_fields(rx_ring, rx_desc, skb);
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 02d70a96a5a4..8904b22bfba7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -202,12 +202,21 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
 	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts_ns);
 }
 
+/**
+ * ice_get_ptype - Read HW packet type from the descriptor
+ * @rx_desc: RX descriptor
+ */
+static u16 ice_get_ptype(const union ice_32b_rx_flex_desc *rx_desc)
+{
+	return le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
+	       ICE_RX_FLEX_DESC_PTYPE_M;
+}
+
 /**
  * ice_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: Rx descriptor ring packet is being transacted on
  * @rx_desc: pointer to the EOP Rx descriptor
  * @skb: pointer to current skb being populated
- * @ptype: the packet type decoded by hardware
  *
  * This function checks the ring, descriptor, and packet information in
  * order to populate the hash, checksum, VLAN, protocol, and
@@ -216,8 +225,10 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
 void
 ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
-		       struct sk_buff *skb, u16 ptype)
+		       struct sk_buff *skb)
 {
+	u16 ptype = ice_get_ptype(rx_desc);
+
 	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
 
 	/* modifies the skb - consumes the enet header */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 115969ecdf7b..e1d49e1235b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -148,7 +148,7 @@ void ice_release_rx_desc(struct ice_rx_ring *rx_ring, u16 val);
 void
 ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
-		       struct sk_buff *skb, u16 ptype);
+		       struct sk_buff *skb);
 void
 ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
 #endif /* !_ICE_TXRX_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 99954508184f..906e383e864a 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -864,7 +864,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		struct sk_buff *skb;
 		u16 stat_err_bits;
 		u16 vlan_tag = 0;
-		u16 rx_ptype;
 
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
@@ -944,10 +943,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 
 		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
 
-		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
-				       ICE_RX_FLEX_DESC_PTYPE_M;
-
-		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
+		ice_process_skb_fields(rx_ring, rx_desc, skb);
 		ice_receive_skb(rx_ring, skb, vlan_tag);
 	}
 
-- 
2.41.0


