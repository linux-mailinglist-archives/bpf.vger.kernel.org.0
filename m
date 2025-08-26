Return-Path: <bpf+bounces-66571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84780B36FFE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CB9982F91
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB30374281;
	Tue, 26 Aug 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXHtXl7J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1531374274;
	Tue, 26 Aug 2025 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224867; cv=none; b=EDkICv8ojQPua82egvghVt2p+jh1xpTfjnr5FjPqDjUXRdLj8B0BieepmRtvqqbDoANtkraUHJUfq4hfjYSZXeEki3M2yq6v800BgXBzqORBu25JUu88zVEDrEzsRNQgDgZys/HpYiaJYb2bKQsC9xCLoEtopnpBviQUXwuYrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224867; c=relaxed/simple;
	bh=nZtTZePcJLv/YRyNX7vGsbCe1aj4pTMRnNPvHJnXDj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZgBPBvn1YEjyp2d5uN9N5IuGdlWhWptMs/I3EBeMEof5ycj+nGj/mf+bP1ihtwwC6kiGw7G7E99n20Je5E0w3l7B31uFm79DK4CgDQv/xvF0pkylNld/2K/3MVcvggeYvmdXpVq0+3TGBFFG9wQpsbwA5ho5jz5bYvrSSDMDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXHtXl7J; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224866; x=1787760866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZtTZePcJLv/YRyNX7vGsbCe1aj4pTMRnNPvHJnXDj4=;
  b=LXHtXl7JoRMoIWtk2VUXET1Z3JtkZ/k0k6fVMdK+TzupJx6uPPqH8Pxb
   N1u98cFAR8ewQxIka1gAKkoIMYQdEEq1Tfz6JFjF+mGCJJxNS2UapZ9nN
   5f4kXS436qcP4059jRGamDIWFSuKQsdINK3bOHrR6ewdmvFTlDuaSCtKD
   JcWM4H+2ISybwlOMWMoNzDP/PRqolQ/UhuvMUWVyMCnTmjnb/PpCu0Oa8
   Q5WKJgkE4jmF2o2v2CVHflKjzz7BwnG3sik8Xd9G/ycMSJaG63y25EwIe
   JbIPhbzfBacvqqRyYx13apg8+fbThfuYsG7H0ubHFg/yPAoa5/7CtVx90
   g==;
X-CSE-ConnectionGUID: ISij/YqZQKiDyTtRbM074g==
X-CSE-MsgGUID: sEAdLbDETd6OOF6Fcoci8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46045127"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46045127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:14:25 -0700
X-CSE-ConnectionGUID: /XPE5bhdRJC8jFb8LkKBjQ==
X-CSE-MsgGUID: lsP1l7wTSfucNU1ErUoNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562710"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:14:21 -0700
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
Subject: [PATCH iwl-next v5 13/13] idpf: add XDP RSS hash hint
Date: Tue, 26 Aug 2025 17:55:07 +0200
Message-ID: <20250826155507.2138401-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
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
-- 
2.51.0


