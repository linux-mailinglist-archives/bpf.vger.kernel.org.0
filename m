Return-Path: <bpf+bounces-55987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F3A8A597
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9121819030DB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC858233729;
	Tue, 15 Apr 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tz9j3XMn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74615221D83;
	Tue, 15 Apr 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738182; cv=none; b=pQQY8aXsNbsjdjYh22T29aFr86/UU/kTJV2UrF0q2xjpJizGycEvosvo5QW8nF3AzRZP8S8woX0/MERwl/aInA+2M1Gkj7tSiC7J05P36JQM8uQAyiHHrTIAeBi/ddHgZapxtXjOGwQk6In+l6Pvw72xsXRCaRT9wBGJW1Lnmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738182; c=relaxed/simple;
	bh=7ne9x5DYOXVhNLNI7e4lJs8pi9J798b2PE8fgyt3Mh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPP4L7h2IDHcmIlhYzGfwgaLxDe+bXwZaUEiMXjDEbE8hWn4EBFXKX6zpbHAh+DqIC+SY62TJ0H2ZFiUU+uoDcvi916fCLtXA7S9eC1uCjuojmavq9/KT4G1os8C9AqGmhuth1FWi6Rq8vqvOK0xoxxtKblY667TtlV9Ov0nxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tz9j3XMn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738181; x=1776274181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ne9x5DYOXVhNLNI7e4lJs8pi9J798b2PE8fgyt3Mh4=;
  b=Tz9j3XMnbhBUC3NdDLS6HgoFxoioDsvGw/QpWmiI6EpdW12NxoIbS+vW
   icEHpppQJMxqchGQykJC8+Cu/GQgsmRpzI1ESk1SesrnDx3mfpuhB0HTA
   R7jlCBlVIDPLIV8uBySIYDd18u2vSTUrppVCmQyajzON9/UaU1iXSfyVf
   QaNg3Kqm2p9S7+FCZurrrpt1aFxPu9bhCLYai0LLBkyuv7TCEmE83BPkl
   WFsjCgZog7YXdyv+8HvggeWzfRae/BoOfdUtKVdARLdmTtJC8T7YDRswS
   iPreZLBRSBULugEZDXHo0WPGlRQ4pfAOb0AncgUaYS9jtVJbVgeRoxFiI
   g==;
X-CSE-ConnectionGUID: pHNJBn60TzqX2S1bSPRl0w==
X-CSE-MsgGUID: Ko1PmbfPRS6IEtK+aB0pjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46275766"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46275766"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:29:40 -0700
X-CSE-ConnectionGUID: TihOLHW3Tme1zl764xGDlg==
X-CSE-MsgGUID: jOCW74qxTw6nIlb935hAPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130729817"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2025 10:29:36 -0700
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
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 11/16] libeth: xdp: add RSS hash hint and XDP features setup helpers
Date: Tue, 15 Apr 2025 19:28:20 +0200
Message-ID: <20250415172825.3731091-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
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
index 643b0a8acab3..f0b1160bee51 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1624,6 +1624,51 @@ void name(struct libeth_xdp_tx_bulk *bq)				      \
 
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
@@ -1690,4 +1735,49 @@ static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
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
index a20ba2478097..975c34af2f0f 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -338,6 +338,75 @@ void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
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


