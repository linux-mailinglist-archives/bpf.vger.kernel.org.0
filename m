Return-Path: <bpf+bounces-40161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53997DE01
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6371F218F6
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3617BEB8;
	Sat, 21 Sep 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkBYEes6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC21547DA;
	Sat, 21 Sep 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937592; cv=none; b=i2ldYVBQSYMSrP8AqstP+NJmjoQXXkqiqwFtYpnQHoG3N8PcDMnBqjQxlrzYplVAePHihEETgcjCss+Z4k2Wo/dxYdLyqcWyD9p7sGosRGAiQy5dJbts4sc0Qzq1Xs7yQyt/6CVvQzP6JpFTCxbTZE3Pqm5Ezu7Vqqbj7OPJ9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937592; c=relaxed/simple;
	bh=FtECcRJ9XXZ3jnvA5WKYiudLQt/ewvPA8UCT9rYB6eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbWBZCCMGCdayBrB+xmfOtDK9opC8hrWMqSJAIWyrO49HHTXPF4tK3WG7E1Hjmhzv/6iEfCAifp+bbKOwradnYrLRLVgNmsKEk5tNjfADlyY0Uyh+5pj4JpaLXSAdvX38SCdFNNsSDq2x7G8rs3bh1NUDl7nWhkcwcbbvBRr4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkBYEes6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82A8C4CEC2;
	Sat, 21 Sep 2024 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726937592;
	bh=FtECcRJ9XXZ3jnvA5WKYiudLQt/ewvPA8UCT9rYB6eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkBYEes6AI7AnET4LlfzKJfKdkZ+nZyYEzbAV0SyGCSHvLg77jwOlWSFFSAwlWmXZ
	 ryQvlxKYJDn8T3n+XSQxKYDRCPodVDD3FWFqJrT0Y9GfjfOuGdPVRTFfVf/CRCjoeV
	 Z6BQ7mjQRzJDdEX1HrrwcFvJD8Gx2iDH+ceTYMuaVeWSNnKeSG0CDM9QbJTevv7GWK
	 ggt/GThXtZaXBNrEO/IC9FJeOzb/dBujbHhE14y0sN9/97XjTMWqXDynMVYLSYiJbp
	 kg9CcjP9ott+U53Cmp8y5Qxy5bFu5E/vLIzbusZx6MXzHkLRTsXZbb6vIORCp6Lr3B
	 RKDmA85MRm5Lw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	toke@toke.dk,
	aleksander.lobakin@intel.com,
	sdf@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	mst@redhat.com,
	jasowang@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Subject: [RFC bpf-next 2/4] net: xdp: Update rx_hash of xdp_rx_meta struct running xmo_rx_hash callback
Date: Sat, 21 Sep 2024 18:52:58 +0200
Message-ID: <01ce17910fdd7b693c23132663fa884d5ec7f440.1726935917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1726935917.git.lorenzo@kernel.org>
References: <cover.1726935917.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set rx_hash in xdp_rx_meta struct of xdp_buff/xdp_frame according to
the value reported by the hw.
Update the xmo_rx_hash callback of xdp_metadata_ops for the following
drivers:
- ice
- igc
- mlx4
- mlx5
- veth
- virtio_net
Set rx_hash value/type reported by the hw converting the xdp_frame into
a sk_buff.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  3 +++
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 ++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 ++
 drivers/net/veth.c                            |  1 +
 drivers/net/virtio_net.c                      |  3 ++-
 include/net/xdp.h                             | 14 +++++++++++++
 net/core/xdp.c                                | 20 ++++++++++++++++++-
 8 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 2719f0e20933f..e4b051a8d99c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -520,12 +520,15 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			   enum xdp_rss_hash_type *rss_type)
 {
 	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(xdp_ext->xdp_buff);
 
 	*hash = ice_get_rx_hash(xdp_ext->eop_desc);
 	*rss_type = ice_xdp_rx_hash_type(xdp_ext->eop_desc);
 	if (!likely(*hash))
 		return -ENODATA;
 
+	xdp_set_rx_meta_hash(xdp, *hash, *rss_type);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index dfd6c00b4205d..ed22a7a70695e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6776,12 +6776,14 @@ static int igc_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 			   enum xdp_rss_hash_type *rss_type)
 {
 	const struct igc_xdp_buff *ctx = (void *)_ctx;
+	struct xdp_buff *xdp = (void *)&(ctx->xdp);
 
 	if (!(ctx->xdp.rxq->dev->features & NETIF_F_RXHASH))
 		return -ENODATA;
 
 	*hash = le32_to_cpu(ctx->rx_desc->wb.lower.hi_dword.rss);
 	*rss_type = igc_xdp_rss_type[igc_rss_type(ctx->rx_desc)];
+	xdp_set_rx_meta_hash(xdp, *hash, *rss_type);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 15c57e9517e9a..ef6c687866f9d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -708,6 +708,7 @@ int mlx4_en_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 		if (cqe->ipv6_ext_mask)
 			xht |= XDP_RSS_L3_DYNHDR;
 	}
+	xdp_set_rx_meta_hash(&(_ctx->xdp), *hash, xht);
 	*rss_type = xht;
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 4610621a340e5..92fb98397751a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -238,6 +238,7 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			     enum xdp_rss_hash_type *rss_type)
 {
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(_ctx->xdp);
 	const struct mlx5_cqe64 *cqe = _ctx->cqe;
 	u32 hash_type, l4_type, ip_type, lookup;
 
@@ -252,6 +253,7 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	l4_type = FIELD_GET(CQE_RSS_HTYPE_L4, hash_type);
 	lookup = ip_type | l4_type;
 	*rss_type = mlx5_xdp_rss_type[lookup];
+	xdp_set_rx_meta_hash(xdp, *hash, *rss_type);
 
 	return 0;
 }
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a950672..cc8e90d330456 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1633,6 +1633,7 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 
 	*hash = skb_get_hash(skb);
 	*rss_type = skb->l4_hash ? XDP_RSS_TYPE_L4_ANY : XDP_RSS_TYPE_NONE;
+	xdp_set_rx_meta_hash(&(_ctx->xdp), *hash, *rss_type);
 
 	return 0;
 }
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3f10c72743e94..1d1ada8eeda0e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6250,8 +6250,8 @@ virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] = {
 static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type)
 {
-	const struct xdp_buff *xdp = (void *)_ctx;
 	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct xdp_buff *xdp = (void *)_ctx;
 	struct virtnet_info *vi;
 	u16 hash_report;
 
@@ -6267,6 +6267,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 
 	*rss_type = virtnet_xdp_rss_type[hash_report];
 	*hash = __le32_to_cpu(hdr_hash->hash_value);
+	xdp_set_rx_meta_hash(xdp, *hash, *rss_type);
 	return 0;
 }
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 5e08b58a2a10f..e1c344eb7e686 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -214,6 +214,11 @@ static __always_inline bool xdp_frame_has_rx_meta(struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_META_RX);
 }
 
+static __always_inline bool xdp_frame_has_rx_meta_hash(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX_HASH);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
@@ -504,6 +509,15 @@ struct xdp_metadata_ops {
 				   u16 *vlan_tci);
 };
 
+static __always_inline void
+xdp_set_rx_meta_hash(struct xdp_buff *xdp, u32 hash,
+		     enum xdp_rss_hash_type rss_type)
+{
+	xdp->rx_meta.hash.val = hash;
+	xdp->rx_meta.hash.type = rss_type;
+	xdp->flags |= XDP_FLAGS_META_RX_HASH;
+}
+
 #ifdef CONFIG_NET
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424b..e2f4d01cf84cf 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -594,6 +594,23 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
 
+static void xdp_set_skb_rx_hash_from_meta(struct xdp_frame *frame,
+					  struct sk_buff *skb)
+{
+	enum pkt_hash_types hash_type = PKT_HASH_TYPE_NONE;
+
+	if (!xdp_frame_has_rx_meta_hash(frame))
+		return;
+
+	if (frame->rx_meta.hash.type & XDP_RSS_TYPE_L4_ANY)
+		hash_type = PKT_HASH_TYPE_L4;
+	else if (frame->rx_meta.hash.type & (XDP_RSS_TYPE_L3_IPV4 |
+					     XDP_RSS_TYPE_L3_IPV6))
+		hash_type = PKT_HASH_TYPE_L3;
+
+	skb_set_hash(skb, frame->rx_meta.hash.val, hash_type);
+}
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
@@ -634,9 +651,10 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
 
+	xdp_set_skb_rx_hash_from_meta(xdpf, skb);
+
 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 
-- 
2.46.1


