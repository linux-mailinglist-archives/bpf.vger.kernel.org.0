Return-Path: <bpf+bounces-67797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71345B49A89
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CD14E11AD
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB62DA75F;
	Mon,  8 Sep 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpX6LruD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DA2D8DAA;
	Mon,  8 Sep 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361500; cv=none; b=aIyy2d2swZ52Ogpv2qSrM9fphKIZp1KeHHUi/hvfsKEu4ZRWbijle7LqX02Slw1S3tQSbXrNNagOE6jmF5HXoPU3txHh3ccZ01JwKFsQN80pU4Fr/Ee1t+WCMh9ufuQKKJ17MN2X5NeInlOlp9aXbR0K+N4JhZk6jOycQ1cVLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361500; c=relaxed/simple;
	bh=WZxKPWrI+BvjKF+DOpm1I3bsGssvuNOwX+cWZcci9p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwsBgUZO0+M63otc26MEWmNreRDtauyDzGSfrH7XKyQ6ocnRzUqd5XdWMxjHjMPqHsXVV3StHf5uWowy1EshwNkmo14bFTeYAXD4X7wuKLNbsD5oNcW1bbfMqR8iNhJk9GIaxs/phqKbZ+Q+HIZHyHHFbkoFEIWl2tB5NpMI6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpX6LruD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361500; x=1788897500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZxKPWrI+BvjKF+DOpm1I3bsGssvuNOwX+cWZcci9p8=;
  b=IpX6LruDTrtGmxmYzhjpsdwEUqMctMmknSAtBdHqcTtL9xSumTAQOuA2
   X/lEEvs2KF4L5KPbIjctH4WM71mLJhm6HZn0/oWhkWN0AH3+jnjuipTeT
   dbfJaDiUz18kdgHdUPmRr+AUD5X80tt8gQXqvZNR0DAJD19tZ7WaMBg9p
   Fvl1oBRZCJyYvqGZ9G7KX6CorgjcrNhl+2cYiUc3LDLGJM6py2+iMzUjN
   XDAnYCzTntKy5HCfnY/JZ0kUd0wbcbpYMmpAOXpKkBogKmbIUZrDXeJy/
   RV2bGWYqq5syHnlvLrYRt7RHoiWZw+lcg/0oARha0ChNpGY0B7N46KjvK
   g==;
X-CSE-ConnectionGUID: s8WdaZYISpSMA3UpOIBuGw==
X-CSE-MsgGUID: mapmVU1QQ2WsgV/+7bOxAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088990"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088990"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:13 -0700
X-CSE-ConnectionGUID: GKPXDFgcT8ipwmIR1En6Nw==
X-CSE-MsgGUID: moGC0juCR2iNYdzrpCmImw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189775"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	Ramu R <ramu.r@intel.com>
Subject: [PATCH net-next 13/13] idpf: add XDP RSS hash hint
Date: Mon,  8 Sep 2025 12:57:43 -0700
Message-ID: <20250908195748.1707057-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
References: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Add &xdp_metadata_ops with a callback to get RSS hash hint from the
descriptor. Declare the splitq 32-byte descriptor as 4 u64s to parse
them more efficiently when possible.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 28 +++++++++++-
 drivers/net/ethernet/intel/idpf/xdp.h | 64 +++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index b6a8304d61f9..89d5735f42f2 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -342,12 +342,38 @@ int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 				       idpf_xdp_tx_finalize);
 }
 
+static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
+			      enum xdp_rss_hash_type *rss_type)
+{
+	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
+	struct idpf_xdp_rx_desc desc __uninitialized;
+	const struct idpf_rx_queue *rxq;
+	struct libeth_rx_pt pt;
+
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	idpf_xdp_get_qw0(&desc, xdp->desc);
+
+	pt = rxq->rx_ptype_lkup[idpf_xdp_rx_pt(&desc)];
+	if (!libeth_rx_pt_has_hash(rxq->xdp_rxq.dev, pt))
+		return -ENODATA;
+
+	idpf_xdp_get_qw2(&desc, xdp->desc);
+
+	return libeth_xdpmo_rx_hash(hash, rss_type, idpf_xdp_rx_hash(&desc),
+				    pt);
+}
+
+static const struct xdp_metadata_ops idpf_xdpmo = {
+	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
+};
+
 void idpf_xdp_set_features(const struct idpf_vport *vport)
 {
 	if (!idpf_is_queue_model_split(vport->rxq_model))
 		return;
 
-	libeth_xdp_set_features_noredir(vport->netdev);
+	libeth_xdp_set_features_noredir(vport->netdev, &idpf_xdpmo);
 }
 
 static int idpf_xdp_setup_prog(struct idpf_vport *vport,
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index db8ecc1843fe..66ad83a0e85e 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -99,6 +99,70 @@ static inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent, bool flush)
 	libeth_xdpsq_unlock(&xdpsq->xdp_lock);
 }
 
+struct idpf_xdp_rx_desc {
+	aligned_u64		qw0;
+#define IDPF_XDP_RX_BUFQ	BIT_ULL(47)
+#define IDPF_XDP_RX_GEN		BIT_ULL(46)
+#define IDPF_XDP_RX_LEN		GENMASK_ULL(45, 32)
+#define IDPF_XDP_RX_PT		GENMASK_ULL(25, 16)
+
+	aligned_u64		qw1;
+#define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
+#define IDPF_XDP_RX_EOP		BIT_ULL(1)
+
+	aligned_u64		qw2;
+#define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
+
+	aligned_u64		qw3;
+} __aligned(4 * sizeof(u64));
+static_assert(sizeof(struct idpf_xdp_rx_desc) ==
+	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
+
+#define idpf_xdp_rx_bufq(desc)	!!((desc)->qw0 & IDPF_XDP_RX_BUFQ)
+#define idpf_xdp_rx_gen(desc)	!!((desc)->qw0 & IDPF_XDP_RX_GEN)
+#define idpf_xdp_rx_len(desc)	FIELD_GET(IDPF_XDP_RX_LEN, (desc)->qw0)
+#define idpf_xdp_rx_pt(desc)	FIELD_GET(IDPF_XDP_RX_PT, (desc)->qw0)
+#define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
+#define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
+#define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
+
+static inline void
+idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
+{
+#ifdef __LIBETH_WORD_ACCESS
+	desc->qw0 = ((const typeof(desc))rxd)->qw0;
+#else
+	desc->qw0 = ((u64)le16_to_cpu(rxd->pktlen_gen_bufq_id) << 32) |
+		    ((u64)le16_to_cpu(rxd->ptype_err_fflags0) << 16);
+#endif
+}
+
+static inline void
+idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
+{
+#ifdef __LIBETH_WORD_ACCESS
+	desc->qw1 = ((const typeof(desc))rxd)->qw1;
+#else
+	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
+		    rxd->status_err0_qw1;
+#endif
+}
+
+static inline void
+idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
+{
+#ifdef __LIBETH_WORD_ACCESS
+	desc->qw2 = ((const typeof(desc))rxd)->qw2;
+#else
+	desc->qw2 = ((u64)rxd->hash3 << 24) |
+		    ((u64)rxd->ff2_mirrid_hash2.hash2 << 16) |
+		    le16_to_cpu(rxd->hash1);
+#endif
+}
+
 void idpf_xdp_set_features(const struct idpf_vport *vport);
 
 int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
-- 
2.47.1


