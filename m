Return-Path: <bpf+bounces-59522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE7ACCC65
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418703A6E80
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4D1E503C;
	Tue,  3 Jun 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSRqqob2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681B1BC3F;
	Tue,  3 Jun 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972773; cv=none; b=pxtnPjJYqAXitbV0cA8gEjQug0DzXjwb4M7+y4FG+j1xEVjTJIQ6aZsgS0GVYxxYEhykHNgpl61jo4tCOhpmMB5USR3miZraCmYApT2N6C0JNuG/pteJ6xVR0nZae2OmCrK+qf7sDnido90BOFeTSNFaJHFTrjwP71j9pQirwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972773; c=relaxed/simple;
	bh=OzIvNh+mKrDJeOE8MUUUulECgSRVybs0VAqSRQcLl1U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUx84DdUz1OaL1yUxoffnIlAlCsayOZZZb7oNBSBu3ChTZaAo4qAUD6rgJTMgengHOr5QqlY6hlvCY5nV9HQnV8LoBp4+RKBoukKj670POsZ7imuRoGAvf/KzSpThbJQeeOBQnLdmM2p4KMdwRnavuo0G2NYhBgpzuKZWEZfY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSRqqob2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E7C4CEED;
	Tue,  3 Jun 2025 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972773;
	bh=OzIvNh+mKrDJeOE8MUUUulECgSRVybs0VAqSRQcLl1U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RSRqqob237uJMYSevae3++Vvsq1T3gEumDVv2zPP+h6eJ0wLPtihflKViUz98yvsx
	 Cip9Dz5qqZLizwZC/vb14sFfWeOuXBcJq0zAS6Pjg4ZIhsnGkYrJFkRC8PSvoTBCYZ
	 /KOQmlfV+42WcTfnOFfKcZVX75RRpInRScO8rN3GlKy/Bq3V/feO5/bZVFKfflqEgi
	 BPM9dsZRr14DyeQEKYU65wvkVPW17eTzyhlPY19Zm/PvimupTIcmAe1ZL8DgBoUH8m
	 IWAerUYfqkwgZPAzZBhOAjO2B3qoLByT8JxLe/9yMoJSU+AtyST5Vpbwkk73ZquZI2
	 YK+iYNLG3N1Eg==
Subject: [PATCH bpf-next V1 3/7] net: xdp: Add kfuncs to store hw metadata in
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
Date: Tue, 03 Jun 2025 19:46:08 +0200
Message-ID: <174897276809.1677018.15753779269046278541.stgit@firesoul>
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
index 5dcdf634ae4a..ef73f0bcc441 100644
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
index 61edbd424494..7d59543d7916 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -957,12 +957,57 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
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



