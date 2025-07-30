Return-Path: <bpf+bounces-64729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D9B16460
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AF45826E0
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888BD2DE6E7;
	Wed, 30 Jul 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do8ofpoy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DC2E7645;
	Wed, 30 Jul 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891743; cv=none; b=BlBYCIh/KJzIYQP6hvc0nW3ZETZzlZiEpbJqo3e0TDiUP6CZNKONzsC0W+a5lWK1unA2zsj1P+xzCFasgsKvzyqCEMsCNccYhEcRS0VacuPDmiNd4ynBQ151M6j4UXOpemMFcMbsdqsRUlW9IQIYlla+llKkh7euht2vBIrBU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891743; c=relaxed/simple;
	bh=CjvGV5hPrqqR5jpzUsV/mVpTr+53npZ/zD34Fh+5nM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtAiPh6X3ntH/rdmjux5pp9vnyiKXUmVp8JOH5nom3cr4KsW54DdYC5aiZXAeF7krueFP3z4bA2m+iPVQKq0Og4ew8tgMnoboqvrD/YFwBDBfRVUVMnXxBKnlKjgjyhQ0iLNbsoQYFkBmFyXPK8xUdGFHVYdw8R2xIAH1ZboZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do8ofpoy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891742; x=1785427742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CjvGV5hPrqqR5jpzUsV/mVpTr+53npZ/zD34Fh+5nM0=;
  b=do8ofpoyZ/nF6SWnR6zGuQNEOeAGCpclPRt8OE3n1NjtBhd8IXrRWTCl
   wIZVXL5Epo0E6miRYm0+0FP7bnztj5h5lHoJpMfLkWqJ9Gbcw6pcWT193
   2DzimdGljK2Nzwav+lnGWIVjAAHVTpE/fuMdueoGsCaolMXPNnwsPsNPR
   CWTq1Ve6K00eEXOI3yKzCCJK1O57O7XaO9FhjHdVrlT9ZE6NisAKroQUR
   EQLU3XmiXqtqR+rO+0EOXhfuGJyu18LOwm08qjinKOFE300Zhpw46yksM
   DomqX/e+z8T2qUT//seVQIeiyhLkaoFIjfGmopOoy4J4pVeWJxDk2QFCj
   g==;
X-CSE-ConnectionGUID: WrNMIJP7SOOHjy9YvEwuUQ==
X-CSE-MsgGUID: C0D9pOMkTXSuyjIbQOJoFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67279008"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67279008"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:09:01 -0700
X-CSE-ConnectionGUID: yYCfxNg6T667veVV8q54tA==
X-CSE-MsgGUID: 3/6sTqFyS9S0zSBvEZRNSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163813094"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:08:57 -0700
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
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v3 18/18] idpf: add XDP RSS hash hint
Date: Wed, 30 Jul 2025 18:07:17 +0200
Message-ID: <20250730160717.28976-19-aleksander.lobakin@intel.com>
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

Add &xdp_metadata_ops with a callback to get RSS hash hint from the
descriptor. Declare the splitq 32-byte descriptor as 4 u64s to parse
them more efficiently when possible.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.h | 64 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.c | 28 +++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

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
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index d2549f8b8e24..c143b5dc9e2b 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -340,12 +340,38 @@ int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
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
-- 
2.50.1


