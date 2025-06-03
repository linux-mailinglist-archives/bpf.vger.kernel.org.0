Return-Path: <bpf+bounces-59523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D678ACCC6A
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB5F1896927
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1951E503C;
	Tue,  3 Jun 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaEgzXWQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36884A01;
	Tue,  3 Jun 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972780; cv=none; b=M9Z/6r8z9afRDVQTira+oV9xx6lhqRFDhylb9fqulvEZ+b1DQNejtfgiFf/1mhNQokURkFJfGL+b+wLkkercek4Aem1FGwK89OeOPHCaG/bHljMACppSFjS0oprG3OLeFmfJpkciN9Kd78JbKMEHroejxt7wy7Xlk57nVBYKzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972780; c=relaxed/simple;
	bh=hmBH+sLKIp7Ypu6vIaGpMbHCpm6p6q6RNT5uHBzABAE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBbgwt32kQs7zojcVadgMrtEVYmEFlKSp8T/5hzUHDpY1bY0Ho7j9YssDPwx5hXj21hTiXfEu4EoOH3r9vLdphNu7RHMuXkSm/hPBnGIUeLaT4LXZojoeCmX0VOGp3hhwheZRj+qqk1GuDwJmVUOzDb3gWPzTuDDb33F3gdBd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaEgzXWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE314C4CEED;
	Tue,  3 Jun 2025 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972780;
	bh=hmBH+sLKIp7Ypu6vIaGpMbHCpm6p6q6RNT5uHBzABAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TaEgzXWQ4FeMv7/YKH7EdVRhpIKgdBm4Zfz4mGn043cuiE4aROpMclV3ezhZdo/hE
	 ssiZZGmd6is2p1D4g2Wfab9V6Jne43R0oGdrVTh/Zc4vuFqEe+9OdEekCVZ5+VaiSq
	 yTW/Brxum2wHT+nR4zgyGxwYv9c4+fU/tQ6+Drs+Rt+Cxjx4yjaaOFkELQpw11ZFV+
	 /NAIgyVNSLfrMYT7xJLDqr7ooiWZWoWskzGTJytFvzVrWEkSeNAwLr2e3IiYvxLyGm
	 YUwx2GKswC7cgLwgDtPNoYohZxDBhAkRWcPZghqkptOnwijrxvNBVmB9efBBO1wBDx
	 94AiFqgq3RfkQ==
Subject: [PATCH bpf-next V1 4/7] net: xdp: Set skb hw metadata from xdp_frame
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
Date: Tue, 03 Jun 2025 19:46:14 +0200
Message-ID: <174897277482.1677018.1195726795235767459.stgit@firesoul>
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

Update the following hw metadata provided by the NIC building the skb
from a xdp_frame.
- rx hash
- rx vlan
- rx hw-ts

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h |   15 +++++++++++++++
 net/core/xdp.c    |   29 ++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index ef73f0bcc441..1ecbfe2053f2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -310,6 +310,21 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
 
+static __always_inline bool xdp_frame_has_rx_meta_hash(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX_HASH);
+}
+
+static __always_inline bool xdp_frame_has_rx_meta_vlan(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX_VLAN);
+}
+
+static __always_inline bool xdp_frame_has_rx_meta_ts(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX_TS);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 7d59543d7916..69077cf4c541 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -786,6 +786,23 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
 
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
@@ -794,11 +811,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
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
 
@@ -826,9 +847,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
 
+	xdp_set_skb_rx_hash_from_meta(xdpf, skb);
+	if (xdp_frame_has_rx_meta_vlan(xdpf))
+		__vlan_hwaccel_put_tag(skb, xdpf->rx_meta.vlan.proto,
+				       xdpf->rx_meta.vlan.tci);
+	if (unlikely(xdp_frame_has_rx_meta_ts(xdpf)))
+		skb_hwtstamps(skb)->hwtstamp = ts;
+
 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 



