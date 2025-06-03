Return-Path: <bpf+bounces-59524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0BCACCC67
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86849175084
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16B1E5B8A;
	Tue,  3 Jun 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goF5UN/s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FD2C3242;
	Tue,  3 Jun 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972787; cv=none; b=POW13eTFBa3COhB3fZ5+YRu619Av2k6kuhwwyZ0e+syiIPnAGLejwSrnxehLXTaUfFGPKsrbhnndzbZBvCBrHCI7tXJR4UDNuQk3H2hhS8WeIuhnG13YVged1+SBFNke9awskQTzVqzSMM8O1SAx7nXUc5use1Uh54PrNRPd34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972787; c=relaxed/simple;
	bh=pPGqq/khaOlApziNAsBe7r3FMrqclQn0oOxLpIyDN44=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+pJ9ooikHkPIL/huURLkECqVaxBdy756k8sSw2JCopN9ZGFgkUquVJl4U7Xapv5FYS5I1J9RyvmNUIbZhJYNh0MZe6Z8uY6HQQuxCkjX8PHC9fbBoHQjM76fYqd56iAVXN1av1fMkMUAw7/fhBT0SZv98M/IzcVD9fdN/4DApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goF5UN/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7131DC4CEED;
	Tue,  3 Jun 2025 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972787;
	bh=pPGqq/khaOlApziNAsBe7r3FMrqclQn0oOxLpIyDN44=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=goF5UN/sK6FL713/c18g9US/a8WdNQSZ6iD7XlMmQVv+4aeVX/7xoSc6JQlfae4Yz
	 ZE0MxHPb2DIop046sUIOIdpwM0KMtFVASREhF4xBTQ6TrGl6zaAmWqb4noxW+CWhvT
	 ZrSLyLUHRpETJgNN4HkiiopD7DVLUH+QtKaubjTAoLKOSxc+olRyE9dnZPF1TDxFJC
	 QNK0L8cYimjc0zhifR5JU9LWgRS2JT27xHZR1wKUxqKx4VJDeQnAwPW0qIuSGA1iHl
	 TcEkc4cu0mSfc+JZZAn2bCqyMaifXko4e4BDI4kdwXOGm2/a4m/19D76D6wejb5YPR
	 IRue+SaL1tjPg==
Subject: [PATCH bpf-next V1 5/7] net: veth: Read xdp metadata from rx_meta
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
Date: Tue, 03 Jun 2025 19:46:21 +0200
Message-ID: <174897278159.1677018.3349798909066020659.stgit@firesoul>
In-Reply-To: <174897271826.1677018.9096866882347745168.stgit@firesoul>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
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
index 7bb53961c0ea..94b470b6b680 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1614,6 +1614,10 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 {
 	struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct xdp_buff *xdp = &_ctx->xdp;
+
+	if (!xdp_load_rx_ts_from_buff(xdp, timestamp))
+		return 0;
 
 	if (!_ctx->skb)
 		return -ENODATA;
@@ -1626,8 +1630,12 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
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
 
@@ -1641,9 +1649,13 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
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
index 1ecbfe2053f2..6d93f0cf1b53 100644
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
@@ -708,4 +725,44 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 
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



