Return-Path: <bpf+bounces-40162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8797DE03
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499D11C20B47
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26DF17C9E7;
	Sat, 21 Sep 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0X8UTg+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1D1547DA;
	Sat, 21 Sep 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937595; cv=none; b=hAq8nnMOe7+98G5pndfFOwn1m1Mt6iWOuQqV9Z2NwTs+JxzGl2DN6zKtaoTue0L4AaUM6lMQSbhbI/Ni7+KFX4p8dykDfD043zljp27tsR0JKhCeRAxTPudndD8weipMyVhMltWGeomT8ndTUYsIu2XvUi4+CzP1sxBqMPG22xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937595; c=relaxed/simple;
	bh=3jw9I0lwiO4TTcm1AqiwzBTLqWxZoiHdGD9kSgY0iRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5YfK3aZd8yV4+t6XIid2L1b6lbGvmEff8Yf5gbFKa1BZ1G2UmiMJ+Y5gdQilXFt9H45JHnGpPFWxmo/Y0V0clhz/58Hlk09RF7aXX4s8zK5ZRhgS1k3u50KtVOPj8Oh71HMsXtsmutAZQnVoWgdw5mvjT06Ie7aEJmN4feoSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0X8UTg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE731C4CEC2;
	Sat, 21 Sep 2024 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726937595;
	bh=3jw9I0lwiO4TTcm1AqiwzBTLqWxZoiHdGD9kSgY0iRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0X8UTg+dz4aJfP1I6iIW7aF1XJpGoSGCwGaAeJTO5ai5LeUVOzuRBz92hrC1ul4n
	 vhna9qluD4JeHV8sO7y6An8tK2s4jJCXSkvCusq7cSaOoEwfXOp6xItbaE8MeS9m1V
	 mspRJ1n12fJgRMfE3Ati8nRHMlQNbxo9C8rdrwTs4M+8f3hG9+BiDKwAC5jvklwa3a
	 IMHLqb2hZtv5ugwJ8Y2nfP4HRUr1OmufHjs/FNNPSGWWtnJjHJtpNbUOwUOW7KNLKp
	 V/CEUThSY6Bex1C3eaMEm6AvHE0nd8LwRxgdFNWJU/b1cJbhsMFW7Tep6sDb+LTusA
	 VUWSEHFgc3Kzg==
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
Subject: [RFC bpf-next 3/4] net: xdp: Update rx_vlan of xdp_rx_meta struct running xmo_rx_vlan_tag callback
Date: Sat, 21 Sep 2024 18:52:59 +0200
Message-ID: <26256149e5331a69ba9574907ac570a7d2d2e382.1726935917.git.lorenzo@kernel.org>
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

Set vlan_proto and vlan_tci in xdp_rx_meta struct of xdp_buff/xdp_frame
according to the value reported by the hw.
Update the xmo_rx_vlan_tag callback of xdp_metadata_ops for the
following drivers:
- ice
- mlx5
- veth
Set rx vlan_{prot, tci} reported by the hw converting the xdp_frame into
a sk_buff.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c    |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  3 +++
 drivers/net/veth.c                               |  3 +++
 include/net/xdp.h                                | 14 ++++++++++++++
 net/core/xdp.c                                   |  3 +++
 5 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e4b051a8d99c7..74dabe5b0c35c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -545,6 +545,7 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 			       u16 *vlan_tci)
 {
 	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(xdp_ext->xdp_buff);
 
 	*vlan_proto = xdp_ext->pkt_ctx->vlan_proto;
 	if (!*vlan_proto)
@@ -554,6 +555,8 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	if (!*vlan_tci)
 		return -ENODATA;
 
+	xdp_set_rx_meta_vlan(xdp, *vlan_proto, *vlan_tci);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 92fb98397751a..d3b7eee031470 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -262,6 +262,7 @@ static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 				 u16 *vlan_tci)
 {
 	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(_ctx->xdp);
 	const struct mlx5_cqe64 *cqe = _ctx->cqe;
 
 	if (!cqe_has_vlan(cqe))
@@ -269,6 +270,8 @@ static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 
 	*vlan_proto = htons(ETH_P_8021Q);
 	*vlan_tci = be16_to_cpu(cqe->vlan_info);
+	xdp_set_rx_meta_vlan(xdp, *vlan_proto, *vlan_tci);
+
 	return 0;
 }
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index cc8e90d330456..3a4b81104a6bd 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1642,6 +1642,7 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 				u16 *vlan_tci)
 {
 	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct xdp_buff *xdp = (void *)&(_ctx->xdp);
 	const struct sk_buff *skb = _ctx->skb;
 	int err;
 
@@ -1653,6 +1654,8 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 		return err;
 
 	*vlan_proto = skb->vlan_proto;
+	xdp_set_rx_meta_vlan(xdp, skb->vlan_proto, *vlan_tci);
+
 	return err;
 }
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index e1c344eb7e686..2ffaad806b9ed 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -219,6 +219,11 @@ static __always_inline bool xdp_frame_has_rx_meta_hash(struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_META_RX_HASH);
 }
 
+static __always_inline bool xdp_frame_has_rx_meta_vlan(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX_VLAN);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
@@ -518,6 +523,15 @@ xdp_set_rx_meta_hash(struct xdp_buff *xdp, u32 hash,
 	xdp->flags |= XDP_FLAGS_META_RX_HASH;
 }
 
+static __always_inline void
+xdp_set_rx_meta_vlan(struct xdp_buff *xdp, __be16 vlan_proto,
+		     u16 vlan_tci)
+{
+	xdp->rx_meta.vlan.proto = vlan_proto;
+	xdp->rx_meta.vlan.tci = vlan_tci;
+	xdp->flags |= XDP_FLAGS_META_RX_VLAN;
+}
+
 #ifdef CONFIG_NET
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index e2f4d01cf84cf..84d6b134f8e97 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -652,6 +652,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	skb->protocol = eth_type_trans(skb, dev);
 
 	xdp_set_skb_rx_hash_from_meta(xdpf, skb);
+	if (xdp_frame_has_rx_meta_vlan(xdpf))
+		__vlan_hwaccel_put_tag(skb, xdpf->rx_meta.vlan.proto,
+				       xdpf->rx_meta.vlan.tci);
 
 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
-- 
2.46.1


