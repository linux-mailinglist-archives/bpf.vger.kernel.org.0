Return-Path: <bpf+bounces-64716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD1B16433
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D31886F4D
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730452E0936;
	Wed, 30 Jul 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3CJWb2p"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA42E0915;
	Wed, 30 Jul 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891691; cv=none; b=NWZlHDRh6DjPUB7cEo7Afrjm0X3Z3cUsJ/RyKpm1wEHJyVpb2SOc6S53owFQIANNdp5QpvWIu5Rkez3u+6fV9QCrs8g2CIMxVdm6QZSlz5+hI2OiGqP7Rcgz0Gyt1b27AAgGgcpFLoDMW0ce99IPXm2lZPpMw9JQtK/HI2ZrVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891691; c=relaxed/simple;
	bh=eCeVGFULYNNwwl48oBXWqC/T/qrQl+yHWbEl1cR8M44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVJWORcQcA39KYMTfxmekaMp778p1uTPftBMm4umIh+26YvhRaXV21xzSy88eY4mU4fkA5NgbBEIFEoP/5pakRCe2Rj9wWY30z3z6BeFqjTcPo0KpQpiDkGSeUexyW+ehRWWStifY8L3sDdbsw0zgNPSqoPCJB0gEv6w0XOVnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3CJWb2p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891690; x=1785427690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCeVGFULYNNwwl48oBXWqC/T/qrQl+yHWbEl1cR8M44=;
  b=E3CJWb2pF73ODyo3eqXPpM2UadH6ljVPSB9XDOWVrIYJAXAbI2QjkaRe
   E5/SdmVhVrsYE9lpbtqfwB6EANMYGT6FGe6+FqxY3Ud70vGeL91nQjykJ
   vF8yVbeJdq3Dhvvk9eX/qQWgjJP/I8bp9Y5toWeX2LuEDO9xAUQOgbjsG
   vQLSihNzn7Kf/X4y0Hfk1BsXJ8pRwzHHt5B7vvWlBev+xczFQXM2dL7rK
   dHYV58YQ5MB26o3O7VoSAHy7Zub7Wf+0QHw5PJYweTz7Qz7Qau4cBdIEG
   Np0lT+YgBBy0TlvbDE5n32Lzr0mPbItvjDV6fAJDxyBroaJ9SoJM2Pxsi
   A==;
X-CSE-ConnectionGUID: +/e1Zf7oQn2//X3tFBLyGw==
X-CSE-MsgGUID: f/G4NkndRoqwV6uufpPNgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67278799"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67278799"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:08:09 -0700
X-CSE-ConnectionGUID: O0YLgngKQ4i1L2a+dtBKug==
X-CSE-MsgGUID: nLQrCF5+QiyMWoHadKZ3PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163812894"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:08:04 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v3 05/18] idpf: stop Tx if there are insufficient buffer resources
Date: Wed, 30 Jul 2025 18:07:04 +0200
Message-ID: <20250730160717.28976-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730160717.28976-1-aleksander.lobakin@intel.com>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

The Tx refillq logic will cause packets to be silently dropped if there
are not enough buffer resources available to send a packet in flow
scheduling mode. Instead, determine how many buffers are needed along
with number of descriptors. Make sure there are enough of both resources
to send the packet, and stop the queue if not.

Fixes: 7292af042bcf ("idpf: fix a race in txq wakeup")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 15 +++++-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 47 +++++++++++++------
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index d86246c320c8..9565e4dc3514 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1026,6 +1026,17 @@ static inline void idpf_vport_intr_set_wb_on_itr(struct idpf_q_vector *q_vector)
 	       reg->dyn_ctl);
 }
 
+/**
+ * idpf_tx_splitq_get_free_bufs - get number of free buf_ids in refillq
+ * @refillq: pointer to refillq containing buf_ids
+ */
+static inline u32 idpf_tx_splitq_get_free_bufs(struct idpf_sw_queue *refillq)
+{
+	return (refillq->next_to_use > refillq->next_to_clean ?
+		0 : refillq->desc_count) +
+	       refillq->next_to_use - refillq->next_to_clean - 1;
+}
+
 int idpf_vport_singleq_napi_poll(struct napi_struct *napi, int budget);
 void idpf_vport_init_num_qs(struct idpf_vport *vport,
 			    struct virtchnl2_create_vport *vport_msg);
@@ -1053,8 +1064,8 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
 netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb);
-unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
-					 struct sk_buff *skb);
+unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
+					struct sk_buff *skb, u32 *buf_count);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 57c0f5ab8f9e..b19b462e0bb6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -415,11 +415,11 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 {
 	struct idpf_tx_offload_params offload = { };
 	struct idpf_tx_buf *first;
+	u32 count, buf_count = 1;
 	int csum, tso, needed;
-	unsigned int count;
 	__be16 protocol;
 
-	count = idpf_tx_desc_count_required(tx_q, skb);
+	count = idpf_tx_res_count_required(tx_q, skb, &buf_count);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 97bafd83ca5e..edba032b990b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2190,15 +2190,22 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
-/* Global conditions to tell whether the txq (and related resources)
- * has room to allow the use of "size" descriptors.
+/**
+ * idpf_tx_splitq_has_room - check if enough Tx splitq resources are available
+ * @tx_q: the queue to be checked
+ * @descs_needed: number of descriptors required for this packet
+ * @bufs_needed: number of Tx buffers required for this packet
+ *
+ * Return: 0 if no room available, 1 otherwise
  */
-static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
+static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 descs_needed,
+			     u32 bufs_needed)
 {
-	if (IDPF_DESC_UNUSED(tx_q) < size ||
+	if (IDPF_DESC_UNUSED(tx_q) < descs_needed ||
 	    IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
 		IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
-	    IDPF_TX_BUF_RSV_LOW(tx_q))
+	    IDPF_TX_BUF_RSV_LOW(tx_q) ||
+	    idpf_tx_splitq_get_free_bufs(tx_q->refillq) < bufs_needed)
 		return 0;
 	return 1;
 }
@@ -2207,14 +2214,21 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 size)
  * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop conditions
  * @tx_q: the queue to be checked
  * @descs_needed: number of descriptors required for this packet
+ * @bufs_needed: number of buffers needed for this packet
  *
- * Returns 0 if stop is not needed
+ * Return: 0 if stop is not needed
  */
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
-				     unsigned int descs_needed)
+				     u32 descs_needed,
+				     u32 bufs_needed)
 {
+	/* Since we have multiple resources to check for splitq, our
+	 * start,stop_thrs becomes a boolean check instead of a count
+	 * threshold.
+	 */
 	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-				      idpf_txq_has_room(tx_q, descs_needed),
+				      idpf_txq_has_room(tx_q, descs_needed,
+							bufs_needed),
 				      1, 1))
 		return 0;
 
@@ -2256,14 +2270,16 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 }
 
 /**
- * idpf_tx_desc_count_required - calculate number of Tx descriptors needed
+ * idpf_tx_res_count_required - get number of Tx resources needed for this pkt
  * @txq: queue to send buffer on
  * @skb: send buffer
+ * @bufs_needed: (output) number of buffers needed for this skb.
  *
- * Returns number of data descriptors needed for this skb.
+ * Return: number of data descriptors and buffers needed for this skb.
  */
-unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
-					 struct sk_buff *skb)
+unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
+					struct sk_buff *skb,
+					u32 *bufs_needed)
 {
 	const struct skb_shared_info *shinfo;
 	unsigned int count = 0, i;
@@ -2274,6 +2290,7 @@ unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 		return count;
 
 	shinfo = skb_shinfo(skb);
+	*bufs_needed += shinfo->nr_frags;
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		unsigned int size;
 
@@ -2891,11 +2908,11 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 	};
 	union idpf_flex_tx_ctx_desc *ctx_desc;
 	struct idpf_tx_buf *first;
-	unsigned int count;
+	u32 count, buf_count = 1;
 	int tso, idx;
 	u32 buf_id;
 
-	count = idpf_tx_desc_count_required(tx_q, skb);
+	count = idpf_tx_res_count_required(tx_q, skb, &buf_count);
 	if (unlikely(!count))
 		return idpf_tx_drop_skb(tx_q, skb);
 
@@ -2905,7 +2922,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 	/* Check for splitq specific TX resources */
 	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
-	if (idpf_tx_maybe_stop_splitq(tx_q, count)) {
+	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		return NETDEV_TX_BUSY;
-- 
2.50.1


