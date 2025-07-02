Return-Path: <bpf+bounces-62125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E93AF5BF2
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C54B1C2640E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162230E83F;
	Wed,  2 Jul 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGzPPwzg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CF307AFC;
	Wed,  2 Jul 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468325; cv=none; b=MRNIwS/0KtfXuYJBS/5eMvqNfFXsY3ydfsFfccMphkxC3WWf26KNJMkmM8eNWfXxgfHRiU7oMXADyozoVMuXeA6fkoLMUxtF6CBtNBr2LxhwuRU+Bdw812I7eVR9zHTxeL/WKf+T9jMM1MUxv6d6kzUhB2uh/PQAr5SIHe9zsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468325; c=relaxed/simple;
	bh=iLNUwhn8Ec+aD/8O82h19EWGbHgFsaXzvcUBb0HirCw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mdcf8D5hS/3Io2yZpY0t6gzrIlhN1ZY5fWT21SmztruN13EVCbwwgzbAuyInzKvxWNwpDkHX260LrsXNlpBPSjNUnaSywbk2Vl2SXnHA288sAaEgcET/v8mOwefi9w/b23QpNK22oayaMn9f3rjY+9PqXhGKbubfY5TLgjujo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGzPPwzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697DDC4CEED;
	Wed,  2 Jul 2025 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468324;
	bh=iLNUwhn8Ec+aD/8O82h19EWGbHgFsaXzvcUBb0HirCw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GGzPPwzgR9ZtaBxQFIAlwL5NvsA15pkkKhNnPNhUr1AOuGRfc2Dpo8xxvgBn+9AcP
	 iTeFk9ifyY9ipoe+pt/k4CCmZQQ1RuU2xik1/rpFmr8U/Gz1RbGGYV+iQ0Neyb2MQ2
	 GNQpfgEJmWx7wkYS32b5v2uybdTyqGDIvzRcG8psh8v7MvWLIJswBWaGKsQ0uhC9qM
	 7EAsC+LyGXqkulx9gdsyO+YyHN5e01utWogvxbpAQRhKkQLzreZeZBzK1GMMaSE1s8
	 ZRYnNfiAB/2rGIq0FlrNByJw1D5kViYYDfdiumCRSTb2OxAya46NEWv4EuEngAjpjA
	 XnkoJgkknLu+Q==
Subject: [PATCH bpf-next V2 4/7] net: xdp: Set skb hw metadata from xdp_frame
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
Date: Wed, 02 Jul 2025 16:58:39 +0200
Message-ID: <175146831960.1421237.9105904582430357235.stgit@firesoul>
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
index 8c7d47e3609b..3d1a9711fe82 100644
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
index 1ffba57714ea..f1b2a3b4ba95 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -792,6 +792,23 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
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
@@ -800,11 +817,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
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
 
@@ -832,9 +853,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
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
 



