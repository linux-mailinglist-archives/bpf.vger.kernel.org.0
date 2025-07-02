Return-Path: <bpf+bounces-62126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD21AF5BF8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473A8522E9A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8D30B9A4;
	Wed,  2 Jul 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsMasTU5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D05275874;
	Wed,  2 Jul 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468332; cv=none; b=leNHbHMtAI9OZwThqC+PaL/ZRqri8MK0P+IbwmFwYwW8MLsHPO2frapFwfKnuH1CrvhNYa2KQUqlbBMz0L6sdm8rSqI6H4f3d9lzZoMjPEihKcWtTDY/JKQTjfvBvKYQOba/hk0ptmWw0plxA+I7b2kRvqTaBXZKuluBGikSB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468332; c=relaxed/simple;
	bh=nrluY+4FgTApImqd4q0eudO6t1vIjhXhLYj6hyfwiwI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajDQEOms+V75fPC1pSa8YABR94kX6SnbIZFIjWOEDeRTRU/xkBge54zKNpfUY+fF13jR5xdV+9kzd8ATf3f8hxPEtqeNFUZvPoxBwtpnCTEQH4VxmywXTcwAOga23+78F6fkl83Ojga5Uwc1kU3rudPKX1Nyr2WfDKhPtcKZ/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsMasTU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2052AC4CEE7;
	Wed,  2 Jul 2025 14:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468331;
	bh=nrluY+4FgTApImqd4q0eudO6t1vIjhXhLYj6hyfwiwI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SsMasTU5jNJJ3NWoz+ZIAbZECsGXDALB4I2ODSG1Pm36yLc/37ufdjt+KSEKdLDGm
	 gLPXGiegUt5rlgype1WyZkkRT8qoU0/eln/lXNy1jWYdehrJR43JOGoBenZNIa4U/k
	 GlURhJ85O9Qa6MbYkHHJnZa34K/OcJvNOnVB41GQds2erbt7rMdKDIM2291doXy5t2
	 J7J91XdPAVN34DMlAOtyiMBVtW2hPb47gPZmOh7XpJM1soekDpa2oULKj82nrhPsI3
	 /xxWlSJ3vyxwWbJrLOljGs99ZGjbRk9RVj5trYwk7yWBDfEo2G4wD063t0l0o+Fm4D
	 3ZuGYAVPGFWOg==
Subject: [PATCH bpf-next V2 5/7] net: veth: Read xdp metadata from rx_meta
 struct if available
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Wed, 02 Jul 2025 16:58:46 +0200
Message-ID: <175146832628.1421237.12409230319726025813.stgit@firesoul>
In-Reply-To: <175146824674.1421237.18351246421763677468.stgit@firesoul>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

Report xdp_rx_meta info if available in xdp_buff struct in
xdp_metadata_ops callbacks for veth driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c |   12 +++++++++++
 include/net/xdp.h  |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..c3a08b7d8192 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1651,6 +1651,10 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 {
 	struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct xdp_buff *xdp = &_ctx->xdp;
+
+	if (!xdp_load_rx_ts_from_buff(xdp, timestamp))
+		return 0;
 
 	if (!_ctx->skb)
 		return -ENODATA;
@@ -1663,8 +1667,12 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			    enum xdp_rss_hash_type *rss_type)
 {
 	struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct xdp_buff *xdp = &_ctx->xdp;
 	struct sk_buff *skb = _ctx->skb;
 
+	if (!xdp_load_rx_hash_from_buff(xdp, hash, rss_type))
+		return 0;
+
 	if (!skb)
 		return -ENODATA;
 
@@ -1678,9 +1686,13 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 				u16 *vlan_tci)
 {
 	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct xdp_buff *xdp = &_ctx->xdp;
 	const struct sk_buff *skb = _ctx->skb;
 	int err;
 
+	if (!xdp_load_rx_vlan_tag_from_buff(xdp, vlan_proto, vlan_tci))
+		return 0;
+
 	if (!skb)
 		return -ENODATA;
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 3d1a9711fe82..2b495feedfb0 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -158,6 +158,23 @@ static __always_inline bool xdp_buff_has_valid_meta_area(struct xdp_buff *xdp)
 	return !!(xdp->flags & XDP_FLAGS_META_AREA);
 }
 
+static __always_inline bool
+xdp_buff_has_rx_meta_hash(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_META_RX_HASH);
+}
+
+static __always_inline bool
+xdp_buff_has_rx_meta_vlan(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_META_RX_VLAN);
+}
+
+static __always_inline bool xdp_buff_has_rx_meta_ts(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_META_RX_TS);
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -712,4 +729,44 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 
 	return act;
 }
+
+static inline int xdp_load_rx_hash_from_buff(const struct xdp_buff *xdp,
+					     u32 *hash,
+					     enum xdp_rss_hash_type *rss_type)
+{
+	if (!xdp_buff_has_rx_meta_hash(xdp))
+		return -ENODATA;
+
+	*hash = xdp->rx_meta->hash.val;
+	*rss_type = xdp->rx_meta->hash.type;
+
+	return 0;
+}
+
+static inline int xdp_load_rx_vlan_tag_from_buff(const struct xdp_buff *xdp,
+						 __be16 *vlan_proto,
+						 u16 *vlan_tci)
+{
+	if (!xdp_buff_has_rx_meta_vlan(xdp))
+		return -ENODATA;
+
+	*vlan_proto = xdp->rx_meta->vlan.proto;
+	*vlan_tci = xdp->rx_meta->vlan.tci;
+
+	return 0;
+}
+
+static inline int xdp_load_rx_ts_from_buff(const struct xdp_buff *xdp, u64 *ts)
+{
+	struct skb_shared_info *sinfo;
+
+	if (!xdp_buff_has_rx_meta_ts(xdp))
+		return -ENODATA;
+
+	sinfo = xdp_get_shared_info_from_buff(xdp);
+	*ts = sinfo->hwtstamps.hwtstamp;
+
+	return 0;
+}
+
 #endif /* __LINUX_NET_XDP_H__ */



