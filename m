Return-Path: <bpf+bounces-60499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F3AD77E0
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CB9188BA2F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6E2D3A96;
	Thu, 12 Jun 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYZxkqxl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966412D3235;
	Thu, 12 Jun 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744626; cv=none; b=jBkU4MKnrnPxBsDs2aBrZ5cvZsmoFOi5kRcOesuC2b3kgrTvocp56FgpwNTuDq8BHr5D39icgZjhFFrxFNznQJZrBPBDm/t6A2e8X9HWYdlxmNaA2/Zqb46UyO/v80UBkWAh6oY8avUMvQzaho8oje8rV4PXnl0iDMB5+xo114Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744626; c=relaxed/simple;
	bh=wPH1cvCqRw3ACcUVi06Ys8qB+6Dv7ccwPlYFXZBUpkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0xqaOHfpCozdJz59hb/eTBqHKht821qoIPMHW11R66wjR/owK0weJtczPOMUO0Iw9nzITAluJEUgo3yk0jZWJlq2jGAOgafvIfruP9nvWHUoxwUy78GcihzQ9V+z/Zk2O0VDqNhwdc1G3yKY5wgjjibtUS0oMFOmkEgDj46i00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYZxkqxl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744624; x=1781280624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wPH1cvCqRw3ACcUVi06Ys8qB+6Dv7ccwPlYFXZBUpkY=;
  b=fYZxkqxlLhndkxCPM1a04B/mShze3o09DUnT2YHDBCZS6Hw2KjeSWVih
   5s6q/vS8YDZVbjqBMzbLPioKuqakxpZn/PUDfmqe4gvRN3Vg+AAXvnpMC
   oz8nk9MGjE/ahhdT1/Qg8859ZBXoOIN1hHYC0p2QLK+6ZlkmJzvm5yTrU
   8VXNd9Da/gXXBkFlTl1F6QiJ3hUkMdow6ZtkKK1HNMa/C6dPGTdMqMgDB
   KflkTaMlzIh4uBrOydqcb9XVPbaC12NyiEVwo96o5/AMkfl+F+dybmcaT
   7/ekyyoemwuqLdEfuCq2x+vnLo9A/CggjlGqV/BFUum+ACMironKUcZIP
   A==;
X-CSE-ConnectionGUID: Wya+mjZUT6WsyVk7ojbDww==
X-CSE-MsgGUID: 7Ue8FBsLRdK2hmyDg7+fCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55739065"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55739065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:10:24 -0700
X-CSE-ConnectionGUID: rkgdSCYuSHeE3cBoSuoogQ==
X-CSE-MsgGUID: Du8hV7gzS+KQss3MfXVX6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468611"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:10:19 -0700
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 12/17] libeth: xdp: add RSS hash hint and XDP features setup helpers
Date: Thu, 12 Jun 2025 18:02:29 +0200
Message-ID: <20250612160234.68682-13-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612160234.68682-1-aleksander.lobakin@intel.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

End the XDP section by adding helpers to setup XDP features, flipping
.ndo_xdp_xmit() support at runtime (in case when it's not always on),
and calculating the queue clean/refill threshold.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/xdp.h                | 90 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/xdp.c | 69 +++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 46a2ec3c3037..c36b2ca0d04c 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1631,6 +1631,51 @@ void name(struct libeth_xdp_tx_bulk *bq)				      \
 
 #define LIBETH_XDP_DEFINE_END()		__diag_pop()
 
+/* XMO */
+
+/**
+ * libeth_xdp_buff_to_rq - get RQ pointer from an XDP buffer pointer
+ * @xdp: &libeth_xdp_buff corresponding to the queue
+ * @type: typeof() of the driver Rx queue structure
+ * @member: name of &xdp_rxq_info inside @type
+ *
+ * Often times, pointer to the RQ is needed when reading/filling metadata from
+ * HW descriptors. The helper can be used to quickly jump from an XDP buffer
+ * to the queue corresponding to its &xdp_rxq_info without introducing
+ * additional fields (&libeth_xdp_buff is precisely 1 cacheline long on x64).
+ */
+#define libeth_xdp_buff_to_rq(xdp, type, member)			      \
+	container_of_const((xdp)->base.rxq, type, member)
+
+/**
+ * libeth_xdpmo_rx_hash - convert &libeth_rx_pt to an XDP RSS hash metadata
+ * @hash: pointer to the variable to write the hash to
+ * @rss_type: pointer to the variable to write the hash type to
+ * @val: hash value from the HW descriptor
+ * @pt: libeth parsed packet type
+ *
+ * Handle zeroed/non-available hash and convert libeth parsed packet type to
+ * the corresponding XDP RSS hash type. To be called at the end of
+ * xdp_metadata_ops idpf_xdpmo::xmo_rx_hash() implementation.
+ * Note that if the driver doesn't use a constant packet type lookup table but
+ * generates it at runtime, it must call libeth_rx_pt_gen_hash_type(pt) to
+ * generate XDP RSS hash type for each packet type.
+ *
+ * Return: 0 on success, -ENODATA when the hash is not available.
+ */
+static inline int libeth_xdpmo_rx_hash(u32 *hash,
+				       enum xdp_rss_hash_type *rss_type,
+				       u32 val, struct libeth_rx_pt pt)
+{
+	if (unlikely(!val))
+		return -ENODATA;
+
+	*hash = val;
+	*rss_type = pt.hash_type;
+
+	return 0;
+}
+
 /* Tx buffer completion */
 
 void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
@@ -1697,4 +1742,49 @@ static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
 	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk);
 }
 
+/* Misc */
+
+u32 libeth_xdp_queue_threshold(u32 count);
+
+void __libeth_xdp_set_features(struct net_device *dev,
+			       const struct xdp_metadata_ops *xmo);
+void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
+
+/**
+ * libeth_xdp_set_features - set XDP features for netdev
+ * @dev: &net_device to configure
+ * @...: optional params, see __libeth_xdp_set_features()
+ *
+ * Set all the features libeth_xdp supports, including .ndo_xdp_xmit(). That
+ * said, it should be used only when XDPSQs are always available regardless
+ * of whether an XDP prog is attached to @dev.
+ */
+#define libeth_xdp_set_features(dev, ...)				      \
+	CONCATENATE(__libeth_xdp_feat,					      \
+		    COUNT_ARGS(__VA_ARGS__))(dev, ##__VA_ARGS__)
+
+#define __libeth_xdp_feat0(dev)						      \
+	__libeth_xdp_set_features(dev, NULL)
+#define __libeth_xdp_feat1(dev, xmo)					      \
+	__libeth_xdp_set_features(dev, xmo)
+
+/**
+ * libeth_xdp_set_features_noredir - enable all libeth_xdp features w/o redir
+ * @dev: target &net_device
+ * @...: optional params, see __libeth_xdp_set_features()
+ *
+ * Enable everything except the .ndo_xdp_xmit() feature, use when XDPSQs are
+ * not available right after netdev registration.
+ */
+#define libeth_xdp_set_features_noredir(dev, ...)			      \
+	__libeth_xdp_set_features_noredir(dev, __UNIQUE_ID(dev_),	      \
+					  ##__VA_ARGS__)
+
+#define __libeth_xdp_set_features_noredir(dev, ud, ...) do {		      \
+	struct net_device *ud = (dev);					      \
+									      \
+	libeth_xdp_set_features(ud, ##__VA_ARGS__);			      \
+	libeth_xdp_set_redirect(ud, false);				      \
+} while (0)
+
 #endif /* __LIBETH_XDP_H */
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index 1607579d65bb..4eb0f3c6cdab 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -340,6 +340,75 @@ void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
 }
 EXPORT_SYMBOL_GPL(libeth_xdp_return_buff_bulk);
 
+/* Misc */
+
+/**
+ * libeth_xdp_queue_threshold - calculate XDP queue clean/refill threshold
+ * @count: number of descriptors in the queue
+ *
+ * The threshold is the limit at which RQs start to refill (when the number of
+ * empty buffers exceeds it) and SQs get cleaned up (when the number of free
+ * descriptors goes below it). To speed up hotpath processing, threshold is
+ * always pow-2, closest to 1/4 of the queue length.
+ * Don't call it on hotpath, calculate and cache the threshold during the
+ * queue initialization.
+ *
+ * Return: the calculated threshold.
+ */
+u32 libeth_xdp_queue_threshold(u32 count)
+{
+	u32 quarter, low, high;
+
+	if (likely(is_power_of_2(count)))
+		return count >> 2;
+
+	quarter = DIV_ROUND_CLOSEST(count, 4);
+	low = rounddown_pow_of_two(quarter);
+	high = roundup_pow_of_two(quarter);
+
+	return high - quarter <= quarter - low ? high : low;
+}
+EXPORT_SYMBOL_GPL(libeth_xdp_queue_threshold);
+
+/**
+ * __libeth_xdp_set_features - set XDP features for netdev
+ * @dev: &net_device to configure
+ * @xmo: XDP metadata ops (Rx hints)
+ *
+ * Set all the features libeth_xdp supports. Only the first argument is
+ * necessary.
+ * Use the non-underscored versions in drivers instead.
+ */
+void __libeth_xdp_set_features(struct net_device *dev,
+			       const struct xdp_metadata_ops *xmo)
+{
+	xdp_set_features_flag(dev,
+			      NETDEV_XDP_ACT_BASIC |
+			      NETDEV_XDP_ACT_REDIRECT |
+			      NETDEV_XDP_ACT_NDO_XMIT |
+			      NETDEV_XDP_ACT_RX_SG |
+			      NETDEV_XDP_ACT_NDO_XMIT_SG);
+	dev->xdp_metadata_ops = xmo;
+}
+EXPORT_SYMBOL_GPL(__libeth_xdp_set_features);
+
+/**
+ * libeth_xdp_set_redirect - toggle the XDP redirect feature
+ * @dev: &net_device to configure
+ * @enable: whether XDP is enabled
+ *
+ * Use this when XDPSQs are not always available to dynamically enable
+ * and disable redirect feature.
+ */
+void libeth_xdp_set_redirect(struct net_device *dev, bool enable)
+{
+	if (enable)
+		xdp_features_set_redirect_target(dev, true);
+	else
+		xdp_features_clear_redirect_target(dev);
+}
+EXPORT_SYMBOL_GPL(libeth_xdp_set_redirect);
+
 /* Module */
 
 static const struct libeth_xdp_ops xdp_ops __initconst = {
-- 
2.49.0


