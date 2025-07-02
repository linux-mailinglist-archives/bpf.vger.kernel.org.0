Return-Path: <bpf+bounces-62124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4EAF5BF0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640AB4A58EB
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFAA30B9B7;
	Wed,  2 Jul 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/Jl9jhT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4F30B9A6;
	Wed,  2 Jul 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468319; cv=none; b=WMJzfjddg+yFVvb2LW2W811BX8IUMXHHjjK9BbwZ+sHcTG4zQJZmWu7cJMJsmv6i7OKemNITVEOH44o4XeCoHUlQ6zbl7JyvgOx86mQj9bgo67rbeYzpOFziHbhiV6mXJJRlMS046P0FygQE2XHLUYEZLBx42x9AnFs4td9f6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468319; c=relaxed/simple;
	bh=SA9wfILOg4J9V+vuzNFLZxhr/uT3BR9G8K+trCq0n/w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiEFB1Ys7/+TLZM0dBAM9p0dzPqyvFSo2Jnr3m2+qtTOREgMGkKpboic/hgFoFrYBqQornW5y45E71S0HdcnTbSm95XB+rDiRTu84LOm6mdIAQTJWoGlI44ho/kyM6ZaXJgbBdFZulu8uyXDjeDjph0miWMhgah+ZB6KhlTHBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/Jl9jhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C254FC4CEE7;
	Wed,  2 Jul 2025 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468318;
	bh=SA9wfILOg4J9V+vuzNFLZxhr/uT3BR9G8K+trCq0n/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=g/Jl9jhTGOEyN0fmp9pk6wE9ndXDC4Oo9AAWjyCI4kUTdaM2qMwpFKQVHStPYF9n9
	 IXrejOErjlUvsrFvGm4fB2uytmE2tifslwAGh/bdMLwNK2fDszrvU/ByyvMK69Vkzw
	 X2r+MWTL0QBhe3BQUoffXAlHFDqXiwksuV9oYva9JdBnu3WHN69VKdOmSB92+DjRFa
	 Iua4ImAIRgr39Z3eIw2qSLFh1dT7dvR1jod+W+Veo3TUYXBUqSA/i5OSiu9M4Qhxab
	 L6o8mQ7c0cAJIkUFEwBOnesEw5dP2roMrZPyuWYYzOT/fD1ZNSNZLr4w4M6H5xxo8W
	 3DqeIW3XZ+Tow==
Subject: [PATCH bpf-next V2 3/7] net: xdp: Add kfuncs to store hw metadata in
 xdp_buff
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
Date: Wed, 02 Jul 2025 16:58:32 +0200
Message-ID: <175146831297.1421237.17665319427079757435.stgit@firesoul>
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

Introduce the following kfuncs to store hw metadata provided by the NIC
into the xdp_buff struct:

- rx-hash: bpf_xdp_store_rx_hash
- rx-vlan: bpf_xdp_store_rx_vlan
- rx-hw-ts: bpf_xdp_store_rx_ts

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/xdp.h |    5 +++++
 net/core/xdp.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index f52742a25212..8c7d47e3609b 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -153,6 +153,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline bool xdp_buff_has_valid_meta_area(struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_META_AREA);
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bd3110fc7ef8..1ffba57714ea 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -963,12 +963,57 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+__bpf_kfunc int bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
+				      enum xdp_rss_hash_type rss_type)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+
+	if (!xdp_buff_has_valid_meta_area(xdp))
+		return -ENOSPC;
+
+	xdp->rx_meta->hash.val = hash;
+	xdp->rx_meta->hash.type = rss_type;
+	xdp->flags |= XDP_FLAGS_META_RX_HASH;
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_xdp_store_rx_vlan(struct xdp_md *ctx, __be16 vlan_proto,
+				      u16 vlan_tci)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+
+	if (!xdp_buff_has_valid_meta_area(xdp))
+		return -ENOSPC;
+
+	xdp->rx_meta->vlan.proto = vlan_proto;
+	xdp->rx_meta->vlan.tci = vlan_tci;
+	xdp->flags |= XDP_FLAGS_META_RX_VLAN;
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_xdp_store_rx_ts(struct xdp_md *ctx, u64 ts)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	struct skb_shared_hwtstamps *shwt = &sinfo->hwtstamps;
+
+	shwt->hwtstamp = ts;
+	xdp->flags |= XDP_FLAGS_META_RX_TS;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
 #define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_hash)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_ts)
 BTF_KFUNCS_END(xdp_metadata_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {



