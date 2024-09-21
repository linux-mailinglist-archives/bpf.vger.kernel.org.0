Return-Path: <bpf+bounces-40163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3787797DE05
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 18:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581231C20C68
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8243217D372;
	Sat, 21 Sep 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0equYT9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A871547DA;
	Sat, 21 Sep 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937598; cv=none; b=cEFcpEsMu4g6/MvKx0dFYZ4sutS+/qnFRmdg6IS+b1VfhTSKEl++qb5p8ptKlzKI60SCrkugOI1g7EoWP2DUjdQUKwfp6RRgg7NbXLDdVIs/YEfEINWVAh5/VtJoZRlPoZcBlL/5laHDqgp29Vl0j8X3p8Rri5DEGgxwYoj4tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937598; c=relaxed/simple;
	bh=pH4e8OUiYnFljQThlJQzDja0lcvpvuiTePZIdXTOrJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuPZgXSNRI7Y1cah+PTrzy09m0uzy9B1Qus2mj1+pTE4BNoIEzNdBEIdEHiGRP5TwLn717xghjqEkF3lpsIIKK3bkic0fH7AE0CNfQk9f7wCXXXVjqdh/sxzaguB3LRVNkkYpPGVRKxsRJ5RQWsKcz2jYuieDHgiqfln5dPXS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0equYT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C17C4CEC6;
	Sat, 21 Sep 2024 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726937597;
	bh=pH4e8OUiYnFljQThlJQzDja0lcvpvuiTePZIdXTOrJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0equYT9i7Jy9RpGQCgVuzSQBbcqp9vIAJfk9v23yFjyAcbMN0MQXzbr7WX3iLmtc
	 CNLR5ZFUCTRCtgnQ4HrZppgBz3hKrsX/VzeHjUztnvAn0eJs+fra1QGs5jigeBzgu7
	 xGCkK2c3+Mne5mNOe1TFZLmE+V3o6XHGS3McUAVCqAI59wTIoRa5UU0BqoLQYDR2Xb
	 FsT1XyPmV9SrgPHvsWcpSQHLrBRXSP2zEnDpYG5OWIWqsB+scUCaPf0iVPCqdSRkRI
	 dgIUrFGKaP2tv2/jOpUN3eqppefmWzQl8gxpckI8MGHwja4ZB65zuB8Im7FjCPtWz6
	 5hxc/Ka7/bjug==
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
Subject: [RFC bpf-next 4/4] net: xdp: Update rx timestamp of xdp_rx_meta struct running xmo_rx_timestamp callback
Date: Sat, 21 Sep 2024 18:53:00 +0200
Message-ID: <4683b6c75e4ee0842a9d24faf4a2ca4e2be45223.1726935918.git.lorenzo@kernel.org>
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

Set rx_timestamp in xdp_rx_meta struct of xdp_buff/xdp_frame according
to the value reported by the hw.
Update the xmo_rx_timestamp callback of xdp_metadata_ops for the
following drivers:
- ice
- igc
- mlx5
- mlx4
- stmmac
- veth
Set rx_timestamp reported by the hw converting the xdp_frame into a
sk_buff.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  3 +++
 drivers/net/ethernet/intel/igc/igc_main.c     |  3 +++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  3 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  3 +++
 drivers/net/veth.c                            |  5 +++++
 include/net/xdp.h                             | 20 +++++++++++++++++++
 net/core/xdp.c                                |  6 ++++++
 8 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 74dabe5b0c35c..d5ff77784d756 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -489,12 +489,15 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
 static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
 {
 	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(xdp_ext->xdp_buff);
 
 	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->eop_desc,
 				     xdp_ext->pkt_ctx);
 	if (!*ts_ns)
 		return -ENODATA;
 
+	xdp_set_rx_meta_ts(xdp, *ts_ns);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ed22a7a70695e..240c52f0c6ec4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6795,7 +6795,10 @@ static int igc_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
 	struct igc_inline_rx_tstamps *tstamp = ctx->rx_ts;
 
 	if (igc_test_staterr(ctx->rx_desc, IGC_RXDADV_STAT_TSIP)) {
+		struct xdp_buff *xdp = (void *)&(ctx->xdp);
+
 		*timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer0);
+		xdp_set_rx_meta_ts(xdp, *timestamp);
 
 		return 0;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index ef6c687866f9d..dc714b3d9631c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -681,6 +681,8 @@ int mlx4_en_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 
 	*timestamp = mlx4_en_get_hwtstamp(_ctx->mdev,
 					  mlx4_en_get_cqe_ts(_ctx->cqe));
+	xdp_set_rx_meta_ts(&(_ctx->xdp), *timestamp);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index d3b7eee031470..507322e0c8dd0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -178,12 +178,15 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 static int mlx5e_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 {
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(_ctx->xdp);
 
 	if (unlikely(!mlx5e_rx_hw_stamp(_ctx->rq->tstamp)))
 		return -ENODATA;
 
 	*timestamp =  mlx5e_cqe_ts_to_ns(_ctx->rq->ptp_cyc2time,
 					 _ctx->rq->clock, get_cqe_ts(_ctx->cqe));
+	xdp_set_rx_meta_ts(xdp, *timestamp);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaeac..4da3200816eda 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7458,9 +7458,12 @@ static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
 
 	/* Check if timestamp is available */
 	if (stmmac_get_rx_timestamp_status(priv, desc, ndesc, priv->adv_ts)) {
+		struct xdp_buff *xdp = (void *)&(ctx->xdp);
+
 		stmmac_get_timestamp(priv, desc_contains_ts, priv->adv_ts, &ns);
 		ns -= priv->plat->cdc_error_adj;
 		*timestamp = ns_to_ktime(ns);
+		xdp_set_rx_meta_ts(xdp, *timestamp);
 		return 0;
 	}
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3a4b81104a6bd..3eaba1709a915 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1619,6 +1619,11 @@ static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 		return -ENODATA;
 
 	*timestamp = skb_hwtstamps(_ctx->skb)->hwtstamp;
+	/* Here we just need to set the XDP_FLAGS_META_RX_TS bit in the
+	 * xdp_buff flags.
+	 */
+	xdp_buff_set_rx_meta_ts_flag(&(_ctx->xdp));
+
 	return 0;
 }
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 2ffaad806b9ed..c30c01b23709e 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -88,6 +88,7 @@ enum xdp_buff_flags {
 						   */
 	XDP_FLAGS_META_RX_HASH		= BIT(2), /* hw rx hash */
 	XDP_FLAGS_META_RX_VLAN		= BIT(3), /* hw rx vlan */
+	XDP_FLAGS_META_RX_TS		= BIT(4), /* hw rx timestamp */
 };
 #define XDP_FLAGS_META_RX		(XDP_FLAGS_META_RX_HASH |	\
 					 XDP_FLAGS_META_RX_VLAN)
@@ -134,6 +135,11 @@ static __always_inline bool xdp_buff_has_rx_meta(struct xdp_buff *xdp)
 	return !!(xdp->flags & XDP_FLAGS_META_RX);
 }
 
+static __always_inline void xdp_buff_set_rx_meta_ts_flag(struct xdp_buff *xdp)
+{
+	xdp->flags |= XDP_FLAGS_META_RX_TS;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -224,6 +230,11 @@ static __always_inline bool xdp_frame_has_rx_meta_vlan(struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_META_RX_VLAN);
 }
 
+static __always_inline bool xdp_frame_has_rx_meta_ts(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX_TS);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
@@ -532,6 +543,15 @@ xdp_set_rx_meta_vlan(struct xdp_buff *xdp, __be16 vlan_proto,
 	xdp->flags |= XDP_FLAGS_META_RX_VLAN;
 }
 
+static __always_inline void xdp_set_rx_meta_ts(struct xdp_buff *xdp, u64 ts)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	struct skb_shared_hwtstamps *shwt = &sinfo->hwtstamps;
+
+	shwt->hwtstamp = ts;
+	xdp->flags |= XDP_FLAGS_META_RX_TS;
+}
+
 #ifdef CONFIG_NET
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 84d6b134f8e97..5c9efcf1436d0 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -619,11 +619,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	unsigned int headroom, frame_size;
 	void *hard_start;
 	u8 nr_frags;
+	u64 ts;
 
 	/* xdp frags frame */
 	if (unlikely(xdp_frame_has_frags(xdpf)))
 		nr_frags = sinfo->nr_frags;
 
+	if (unlikely(xdp_frame_has_rx_meta_ts(xdpf)))
+		ts = sinfo->hwtstamps.hwtstamp;
+
 	/* Part of headroom was reserved to xdpf */
 	headroom = sizeof(*xdpf) + xdpf->headroom;
 
@@ -655,6 +659,8 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	if (xdp_frame_has_rx_meta_vlan(xdpf))
 		__vlan_hwaccel_put_tag(skb, xdpf->rx_meta.vlan.proto,
 				       xdpf->rx_meta.vlan.tci);
+	if (unlikely(xdp_frame_has_rx_meta_ts(xdpf)))
+		skb_hwtstamps(skb)->hwtstamp = ts;
 
 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
-- 
2.46.1


