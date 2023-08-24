Return-Path: <bpf+bounces-8501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10815787892
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB97280366
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFB18045;
	Thu, 24 Aug 2023 19:34:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7A18036;
	Thu, 24 Aug 2023 19:34:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E31BF0;
	Thu, 24 Aug 2023 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905642; x=1724441642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjTl/GB6HZLKjSbu7LbG5oyjMbEvF6SUYZyttWw8rnc=;
  b=LFkJD9tCzMwM57XcxZGAUVwEnnWiH0OqWAtLfme/KbxzzdYEfU7wsdkM
   tErrJYGUgm0GhWtiCdt0wIumePMLzVUcF7UB5z6QAmO6vrNRPRiFcXk5b
   aDCr0jE4cDmUvIslNLxsWjSVwq+sjS32QYO8Y9jZ+QVxa/itGmR23Kigo
   lnmVUy4WYx6W2uzHeuwKUUAHHY17HWyo3yly2kFsx7hAND/kRgrqFbPes
   hDkHaWBThfnrRLM/E9PNV987rwgUn/KKnsdDKtcV0/2mAyrI1q4RAbN89
   nHjLOnay1iWOjkz7csRrDpSKgDAYO6PX1tTLP2G1kRC07cOxYyGgFUDrS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374516637"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374516637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802667394"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802667394"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 12:33:56 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 167B333EAB;
	Thu, 24 Aug 2023 20:33:54 +0100 (IST)
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
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [RFC bpf-next 04/23] ice: Make ptype internal to descriptor info processing
Date: Thu, 24 Aug 2023 21:26:43 +0200
Message-ID: <20230824192703.712881-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, rx_ptype variable is used only as an argument
to ice_process_skb_fields() and is computed
just before the function call.

Therefore, there is no reason to pass this value as an argument.
Instead, remove this argument and compute the value directly inside
ice_process_skb_fields() function.

Also, separate its calculation into a short function, so the code
can later be reused in .xmo_() callbacks.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 +-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 15 +++++++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 +-----
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 52d0a126eb61..40f2f6dabb81 100644
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
index 8b155a502b3b..07241f4229b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -241,12 +241,21 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
 	};
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
@@ -255,8 +264,10 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
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
index 2a3f0834e139..ef778b8e6d1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -870,7 +870,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		struct sk_buff *skb;
 		u16 stat_err_bits;
 		u16 vlan_tag = 0;
-		u16 rx_ptype;
 
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
@@ -950,10 +949,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 
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


