Return-Path: <bpf+bounces-72928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A966C1DA7C
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B884E3BE2
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A872FF17F;
	Wed, 29 Oct 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKv28sPd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF52F659C;
	Wed, 29 Oct 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779631; cv=none; b=nfPMwnCxhguLMXWrNz+Jnm6u8ob/R6nSDseTUgvXIxr9rJPWsFduzSBsKsKLW2Cr+bckREdIGD3ATUvDMfZfOmH8SOiSfIPENSJR65Z8M9vr5WKgVCjnYFQLfZPuEbsApeKsbsddZl4TEq0Lyyvb7R39Lp0YLa0P7ewRNtY3jr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779631; c=relaxed/simple;
	bh=nT27agA2UqrDOKb07Im02GggU7Hnt6lex95rG2Cki5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E44MZPNXlEAcmVWiS0q0ZyK/sbtuW4erJ7Y/TviP+VKIMVfeUpOo3WR+AhC7V/pzR5/bm60XfmuNqOMySr3P5NsVbA87fiNTEFTLsnx0bvGHWdAo8Qhj6VpEuFiXDBSLGdglE0zUaXXscx6unI0YZ+crlHg7N5VCC0s5cKmeRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKv28sPd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779629; x=1793315629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nT27agA2UqrDOKb07Im02GggU7Hnt6lex95rG2Cki5U=;
  b=XKv28sPdhLcAMubNwC6ADJ4P7Ginna9B/TzVqvo7JV4Eq9+G0iHBViGn
   ne57jIHPAwypRXtx+aqmRIaDK+O6+Fp/+o/gjv/+4CmtBlnhqzphlc4P4
   Q4Rxlc22dVTLQ1Keo1rJXCJL75PnggeVJVNw2a3jzbyz/dWgqXPKJ5L5w
   gGnmbHaO6nV66Eh+U7TmCQ/DcpHsRj4uL1w+aJEaKufQFoGlN/NQ0lZXh
   WgUCMTenYLT5wKQTo04KdxvoM5toVK5t45Dy6yNc2sMIqN0IG7PPUTfbw
   GYgwKpAR2rRcjR7DTmmJ4QjXy4e/m55tzPoSBp55MC3bLFuWlQAoF/NnK
   A==;
X-CSE-ConnectionGUID: 3MyKDbiASW6nRIi5fRdJ3Q==
X-CSE-MsgGUID: IjFbfdBPT2S1QfjehOmWCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817606"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817606"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:46 -0700
X-CSE-ConnectionGUID: /LnJTuwDSZO6k+kMuRUIYA==
X-CSE-MsgGUID: lWsveb/KS7aiubrelc9JWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729695"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Alexander Nowlin <alexander.nowlin@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/9] ice: implement configurable header split for regular Rx
Date: Wed, 29 Oct 2025 16:12:11 -0700
Message-ID: <20251029231218.1277233-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Add second page_pool for header buffers to each Rx queue and ability
to toggle the header split on/off using Ethtool (default to off to
match the current behaviour).
Unlike idpf, all HW backed up by ice doesn't require any W/As and
correctly splits all types of packets as configured: after L4 headers
for TCP/UDP/SCTP, after L3 headers for other IPv4/IPv6 frames, after
the Ethernet header otherwise (in case of tunneling, same as above,
but after innermost headers).
This doesn't affect the XSk path as there are no benefits of having
it there.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c     | 89 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 15 +++-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  3 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 89 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  7 ++
 6 files changed, 168 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 3d4d8b88631b..147aaee192a7 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -351,6 +351,7 @@ struct ice_vsi {
 	u16 num_q_vectors;
 	/* tell if only dynamic irq allocation is allowed */
 	bool irq_dyn_alloc;
+	bool hsplit:1;
 
 	u16 vsi_num;			/* HW (absolute) index of this VSI */
 	u16 idx;			/* software index in pf->vsi[] */
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index eabab50fab33..eadb1e3d12b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -524,8 +524,29 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	else
 		rlan_ctx.l2tsel = 1;
 
-	rlan_ctx.dtype = ICE_RX_DTYPE_NO_SPLIT;
-	rlan_ctx.hsplit_0 = ICE_RLAN_RX_HSPLIT_0_NO_SPLIT;
+	if (ring->hdr_pp) {
+		rlan_ctx.hbuf = ring->rx_hdr_len >> ICE_RLAN_CTX_HBUF_S;
+		rlan_ctx.dtype = ICE_RX_DTYPE_HEADER_SPLIT;
+
+		/*
+		 * If the frame is TCP/UDP/SCTP, it will be split by the
+		 * payload.
+		 * If not, but it's an IPv4/IPv6 frame, it will be split by
+		 * the IP header.
+		 * If not IP, it will be split by the Ethernet header.
+		 *
+		 * In any case, the header buffer will never be left empty.
+		 */
+		rlan_ctx.hsplit_0 = ICE_RLAN_RX_HSPLIT_0_SPLIT_L2 |
+				    ICE_RLAN_RX_HSPLIT_0_SPLIT_IP |
+				    ICE_RLAN_RX_HSPLIT_0_SPLIT_TCP_UDP |
+				    ICE_RLAN_RX_HSPLIT_0_SPLIT_SCTP;
+	} else {
+		rlan_ctx.hbuf = 0;
+		rlan_ctx.dtype = ICE_RX_DTYPE_NO_SPLIT;
+		rlan_ctx.hsplit_0 = ICE_RLAN_RX_HSPLIT_0_NO_SPLIT;
+	}
+
 	rlan_ctx.hsplit_1 = ICE_RLAN_RX_HSPLIT_1_NO_SPLIT;
 
 	/* This controls whether VLAN is stripped from inner headers
@@ -581,6 +602,53 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	return 0;
 }
 
+static int ice_rxq_pp_create(struct ice_rx_ring *rq)
+{
+	struct libeth_fq fq = {
+		.count		= rq->count,
+		.nid		= NUMA_NO_NODE,
+		.hsplit		= rq->vsi->hsplit,
+		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
+		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
+	};
+	int err;
+
+	err = libeth_rx_fq_create(&fq, &rq->q_vector->napi);
+	if (err)
+		return err;
+
+	rq->pp = fq.pp;
+	rq->rx_fqes = fq.fqes;
+	rq->truesize = fq.truesize;
+	rq->rx_buf_len = fq.buf_len;
+
+	if (!fq.hsplit)
+		return 0;
+
+	fq = (struct libeth_fq){
+		.count		= rq->count,
+		.type		= LIBETH_FQE_HDR,
+		.nid		= NUMA_NO_NODE,
+		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
+	};
+
+	err = libeth_rx_fq_create(&fq, &rq->q_vector->napi);
+	if (err)
+		goto destroy;
+
+	rq->hdr_pp = fq.pp;
+	rq->hdr_fqes = fq.fqes;
+	rq->hdr_truesize = fq.truesize;
+	rq->rx_hdr_len = fq.buf_len;
+
+	return 0;
+
+destroy:
+	ice_rxq_pp_destroy(rq);
+
+	return err;
+}
+
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -589,12 +657,6 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
  */
 static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
-	struct libeth_fq fq = {
-		.count		= ring->count,
-		.nid		= NUMA_NO_NODE,
-		.xdp		= ice_is_xdp_ena_vsi(ring->vsi),
-		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
-	};
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_DESC_UNUSED(ring);
 	u32 rx_buf_len;
@@ -636,15 +698,10 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
 		} else {
-			err = libeth_rx_fq_create(&fq, &ring->q_vector->napi);
+			err = ice_rxq_pp_create(ring);
 			if (err)
 				return err;
 
-			ring->pp = fq.pp;
-			ring->rx_fqes = fq.fqes;
-			ring->truesize = fq.truesize;
-			ring->rx_buf_len = fq.buf_len;
-
 			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 							 ring->q_index,
@@ -699,9 +756,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	return 0;
 
 err_destroy_fq:
-	libeth_rx_fq_destroy(&fq);
-	ring->rx_fqes = NULL;
-	ring->pp = NULL;
+	ice_rxq_pp_destroy(ring);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 36fdac4fddc3..a1d9abee97e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3151,6 +3151,10 @@ ice_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	ring->rx_jumbo_max_pending = 0;
 	ring->rx_mini_pending = 0;
 	ring->rx_jumbo_pending = 0;
+
+	kernel_ring->tcp_data_split = vsi->hsplit ?
+				      ETHTOOL_TCP_DATA_SPLIT_ENABLED :
+				      ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
 static int
@@ -3167,6 +3171,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	int i, timeout = 50, err = 0;
 	struct ice_hw *hw = &pf->hw;
 	u16 new_rx_cnt, new_tx_cnt;
+	bool hsplit;
 
 	if (ring->tx_pending > ICE_MAX_NUM_DESC_BY_MAC(hw) ||
 	    ring->tx_pending < ICE_MIN_NUM_DESC ||
@@ -3192,9 +3197,12 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		netdev_info(netdev, "Requested Rx descriptor count rounded up to %d\n",
 			    new_rx_cnt);
 
+	hsplit = kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+
 	/* if nothing to do return success */
 	if (new_tx_cnt == vsi->tx_rings[0]->count &&
-	    new_rx_cnt == vsi->rx_rings[0]->count) {
+	    new_rx_cnt == vsi->rx_rings[0]->count &&
+	    hsplit == vsi->hsplit) {
 		netdev_dbg(netdev, "Nothing to change, descriptor count is same as requested\n");
 		return 0;
 	}
@@ -3224,6 +3232,8 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 				vsi->xdp_rings[i]->count = new_tx_cnt;
 		vsi->num_tx_desc = (u16)new_tx_cnt;
 		vsi->num_rx_desc = (u16)new_rx_cnt;
+		vsi->hsplit = hsplit;
+
 		netdev_dbg(netdev, "Link is down, descriptor count change happens when link is brought up\n");
 		goto done;
 	}
@@ -3330,6 +3340,8 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	}
 
 process_link:
+	vsi->hsplit = hsplit;
+
 	/* Bring interface down, copy in the new ring info, then restore the
 	 * interface. if VSI is up, bring it down and then back up
 	 */
@@ -4811,6 +4823,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH,
 	.supported_input_xfrm	= RXH_XFRM_SYM_XOR,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
 	.get_fec_stats		= ice_get_fec_stats,
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 10c312d49e05..185672c7e17d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -342,6 +342,9 @@ enum ice_flg64_bits {
 /* for ice_32byte_rx_flex_desc.pkt_length member */
 #define ICE_RX_FLX_DESC_PKT_LEN_M	(0x3FFF) /* 14-bits */
 
+/* ice_32byte_rx_flex_desc::hdr_len_sph_flex_flags1 */
+#define ICE_RX_FLEX_DESC_HDR_LEN_M	GENMASK(10, 0)
+
 enum ice_rx_flex_desc_status_error_0_bits {
 	/* Note: These are predefined bit offsets */
 	ICE_RX_FLEX_DESC_STATUS0_DD_S = 0,
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 5a966138eacf..ad76768a4232 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -508,16 +508,34 @@ int ice_setup_tx_ring(struct ice_tx_ring *tx_ring)
 	return -ENOMEM;
 }
 
+void ice_rxq_pp_destroy(struct ice_rx_ring *rq)
+{
+	struct libeth_fq fq = {
+		.fqes	= rq->rx_fqes,
+		.pp	= rq->pp,
+	};
+
+	libeth_rx_fq_destroy(&fq);
+	rq->rx_fqes = NULL;
+	rq->pp = NULL;
+
+	if (!rq->hdr_pp)
+		return;
+
+	fq.fqes = rq->hdr_fqes;
+	fq.pp = rq->hdr_pp;
+
+	libeth_rx_fq_destroy(&fq);
+	rq->hdr_fqes = NULL;
+	rq->hdr_pp = NULL;
+}
+
 /**
  * ice_clean_rx_ring - Free Rx buffers
  * @rx_ring: ring to be cleaned
  */
 void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 {
-	struct libeth_fq fq = {
-		.fqes	= rx_ring->rx_fqes,
-		.pp	= rx_ring->pp,
-	};
 	u32 size;
 
 	if (rx_ring->xsk_pool) {
@@ -533,9 +551,10 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 
 	/* Free all the Rx ring sk_buffs */
 	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
-		const struct libeth_fqe *rx_fqes = &rx_ring->rx_fqes[i];
+		libeth_rx_recycle_slow(rx_ring->rx_fqes[i].netmem);
 
-		libeth_rx_recycle_slow(rx_fqes->netmem);
+		if (rx_ring->hdr_pp)
+			libeth_rx_recycle_slow(rx_ring->hdr_fqes[i].netmem);
 
 		if (unlikely(++i == rx_ring->count))
 			i = 0;
@@ -547,12 +566,9 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	}
 
-	libeth_rx_fq_destroy(&fq);
-	rx_ring->rx_fqes = NULL;
-	rx_ring->pp = NULL;
+	ice_rxq_pp_destroy(rx_ring);
 
 rx_skip_free:
-
 	/* Zero out the descriptor ring */
 	size = ALIGN(rx_ring->count * sizeof(union ice_32byte_rx_desc),
 		     PAGE_SIZE);
@@ -806,6 +822,12 @@ void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 count)
  */
 bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 {
+	const struct libeth_fq_fp hdr_fq = {
+		.pp		= rx_ring->hdr_pp,
+		.fqes		= rx_ring->hdr_fqes,
+		.truesize	= rx_ring->hdr_truesize,
+		.count		= rx_ring->count,
+	};
 	const struct libeth_fq_fp fq = {
 		.pp		= rx_ring->pp,
 		.fqes		= rx_ring->rx_fqes,
@@ -836,6 +858,20 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 		 */
 		rx_desc->read.pkt_addr = cpu_to_le64(addr);
 
+		if (!hdr_fq.pp)
+			goto next;
+
+		addr = libeth_rx_alloc(&hdr_fq, ntu);
+		if (addr == DMA_MAPPING_ERROR) {
+			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+
+			libeth_rx_recycle_slow(fq.fqes[ntu].netmem);
+			break;
+		}
+
+		rx_desc->read.hdr_addr = cpu_to_le64(addr);
+
+next:
 		rx_desc++;
 		ntu++;
 		if (unlikely(ntu == rx_ring->count)) {
@@ -933,14 +969,16 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		unsigned int size;
 		u16 stat_err_bits;
 		u16 vlan_tci;
+		bool rxe;
 
 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
-		/* status_error_len will always be zero for unused descriptors
-		 * because it's cleared in cleanup, and overlaps with hdr_addr
-		 * which is always zero because packet split isn't used, if the
-		 * hardware wrote DD then it will be non-zero
+		/*
+		 * The DD bit will always be zero for unused descriptors
+		 * because it's cleared in cleanup or when setting the DMA
+		 * address of the header buffer, which never uses the DD bit.
+		 * If the hardware wrote the descriptor, it will be non-zero.
 		 */
 		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
 		if (!ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
@@ -954,12 +992,27 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		ice_trace(clean_rx_irq, rx_ring, rx_desc);
 
+		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_HBO_S) |
+				BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
+		rxe = ice_test_staterr(rx_desc->wb.status_error0,
+				       stat_err_bits);
+
+		if (!rx_ring->hdr_pp)
+			goto payload;
+
+		size = le16_get_bits(rx_desc->wb.hdr_len_sph_flex_flags1,
+				     ICE_RX_FLEX_DESC_HDR_LEN_M);
+		if (unlikely(rxe))
+			size = 0;
+
+		rx_buf = &rx_ring->hdr_fqes[ntc];
+		libeth_xdp_process_buff(xdp, rx_buf, size);
+		rx_buf->netmem = 0;
+
+payload:
 		size = le16_to_cpu(rx_desc->wb.pkt_len) &
 			ICE_RX_FLX_DESC_PKT_LEN_M;
-
-		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
-		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
-					      stat_err_bits)))
+		if (unlikely(rxe))
 			size = 0;
 
 		/* retrieve a buffer from the ring */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e97a38ef3fe7..e440c55d9e9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -255,6 +255,9 @@ struct ice_rx_ring {
 	};
 
 	/* CL2 - 2nd cacheline starts here */
+	struct libeth_fqe *hdr_fqes;
+	struct page_pool *hdr_pp;
+
 	union {
 		struct libeth_xdp_buff_stash xdp;
 		struct libeth_xdp_buff *xsk;
@@ -273,6 +276,8 @@ struct ice_rx_ring {
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
+
+	u32 hdr_truesize;
 	u32 truesize;
 
 	/* stats structs */
@@ -284,6 +289,7 @@ struct ice_rx_ring {
 	struct ice_tx_ring *xdp_ring;
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
+	u16 rx_hdr_len;
 	u16 rx_buf_len;
 	dma_addr_t dma;			/* physical address of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
@@ -396,6 +402,7 @@ static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
 union ice_32b_rx_flex_desc;
 
 void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
+void ice_rxq_pp_destroy(struct ice_rx_ring *rq);
 bool ice_alloc_rx_bufs(struct ice_rx_ring *rxr, unsigned int cleaned_count);
 netdev_tx_t ice_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 u16
-- 
2.47.1


