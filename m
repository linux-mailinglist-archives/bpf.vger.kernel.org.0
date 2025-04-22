Return-Path: <bpf+bounces-56406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C923A96CA4
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D06519E005A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9328C5B5;
	Tue, 22 Apr 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="kxggHc1w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+jENH1u"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE02836A9;
	Tue, 22 Apr 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328268; cv=none; b=MkoNsSXVy9qBR7YPKtVpl900ZWjvTwuC3PU2C+yVSPbyLadllVkhSjnxqSvnxFHhJ4rs13EXXA6QONVNRIT6qP3j+fwfqvAgHQ9LUrK5+i8b4q/XRfw2mV/LU/77AHzYTxSrvlyfAYOx6+5JHO8qOu5+VnRGJWm1Pks8PxfcfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328268; c=relaxed/simple;
	bh=FhjvlfS71G46ZxngbE6or2o8QN2HYxniM8s2GGzHG5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfm7ZnDS4fdu34u6PdDUVseZ8IYraQTfS/Fn8a3cN7WfJiYIqRX3S33Dr9iW6UVuavtfCIQCHHA8FpTcOd5B4VEFZYliFdww/QSENzFVTcDz2g2TbnP91O/v/xyt7Tt2owmnjO1vFvx69H1LGHz31tSGMqSdqDX2wOR88N4Cw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=kxggHc1w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+jENH1u; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D7F611401CC;
	Tue, 22 Apr 2025 09:24:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328266; x=1745414666; bh=+WHGHcEpCGWgQ4lzQe35yrqnQ+YNncmE
	aBOLaF1Ut1M=; b=kxggHc1wKZ10q2kbT5gzaOukBHxvb+e7EIyVHxy4NP2M4x6p
	3MU2URkADmvmN/La5U+VeGPcXUe0P+WmF8N2bYMvirJ/a7qxd72Hcoit7AtnT7kK
	AAhARdKDMqdI9DQbMXD+w3MsriTvSIdkpEdOQM5zj9nJ5PaKYnkNoX+AkLdBhMx/
	dadMykIPcDg7RSyO+yRSq5U24jxudvkF7dfQj+duo12jBcV/q56LSsGlJ8EVHvqA
	+oMtSFfX6LYQuz9pjpBSQrnqy3zZgWehAimPcODbWAJkNmOfpxFPHO9m/R9pTGu4
	GqAVPd8VAl0pyRW5oOGDVLHXq6ukuNzZguhijA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328266; x=
	1745414666; bh=+WHGHcEpCGWgQ4lzQe35yrqnQ+YNncmEaBOLaF1Ut1M=; b=f
	+jENH1u0hH6Ceg2wSuI+qClEYosvyMXKad5Qn6o75t23ZVLAzc14lxm21Bp46tcH
	IW/xi1hZS7o/cDN23KJHAq3OxX/P3hV1vKsSvsXeLaQ8tBRjlLvE+npkan1fo/AG
	4MnOkhaVQC2aMEWmmlRSka6Ljw040COfCRscMfNf2q37jCgcr+r8sSBYE5MSwVq9
	Tfys0ryA/Gvnx+UMPqczUQlHVWpr35TDfWsEECl6LzoMybsIHh1A8tI2/05RcWQI
	L6rh5nHNvoCYn98IMfBBgUNegDoGfMG0SnuWdfCoU+BJT3d2VqbGZrjRV36yNGt0
	8HEsdKoL1JXpdAsL/k7iA==
X-ME-Sender: <xms:ipgHaKToWs6WB_gdSMVJuATXSami0SQ6OBTdka1uzImJKPH1qlXUQg>
    <xme:ipgHaPyB3oD0IQlM6wO0knMg4JJVCScadsmqmOplZkqmAStAR6IRgwvf3sfLUFbtX
    nXX1ZjKBNwsK-MPEoY>
X-ME-Received: <xmr:ipgHaH0YNhtyNZwYFidAuz3HteR4l91JLEnNC5807lpvu-cnBhEwNl6Ec4VHGo8fj5zzwJ3EFUHJeEkHPcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:ipgHaGAnKG5Uya3YDiVe2zeO9dssGAAp9RReVxzP_TCYpPwMOWzG4g>
    <xmx:ipgHaDjIPMPSioVK3pmMeFKDfh_bHaaWWkAxvVD8wDGpsWqtvJyaPA>
    <xmx:ipgHaCosSmEgeiqtbvXhC4idCr6H8ynoPjrn84Eqwn3yBrlbYCeSCw>
    <xmx:ipgHaGgbmKVnVLNTkbMI58m2CRvyBVHxsITfd1vZWY9YqefEVqqnlQ>
    <xmx:ipgHaOV6xZJHHDRoTzZgPnnw-dT46HDZq2NbiRuRfaerZQi96rM8qWlU>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:24 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:44 +0200
Subject: [PATCH RFC bpf-next v2 15/17] mlx5: Propagate trait presence to
 skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-15-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Call the common xdp_buff_update_skb() helper.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 7b5b81a42bedc2fb8da1ee2360a7d1fb46c24bd2..9ca82c9e831ebf4fc52dac547e97c9f3d499e8a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1632,7 +1632,8 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 static inline
 struct sk_buff *mlx5e_build_linear_skb(struct mlx5e_rq *rq, void *va,
 				       u32 frag_size, u16 headroom,
-				       u32 cqe_bcnt, u32 metasize)
+				       u32 cqe_bcnt, u32 metasize,
+				       struct mlx5e_xdp_buff *mxbuf)
 {
 	struct sk_buff *skb = napi_build_skb(va, frag_size);
 
@@ -1646,6 +1647,8 @@ struct sk_buff *mlx5e_build_linear_skb(struct mlx5e_rq *rq, void *va,
 
 	if (metasize)
 		skb_metadata_set(skb, metasize);
+	if (mxbuf)
+		xdp_buff_update_skb(&mxbuf->xdp, skb);
 
 	return skb;
 }
@@ -1696,7 +1699,7 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
-	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
+	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize, mxbuf);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -1772,7 +1775,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	skb = mlx5e_build_linear_skb(rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
 				     mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
 				     mxbuf->xdp.data_end - mxbuf->xdp.data,
-				     mxbuf->xdp.data - mxbuf->xdp.data_meta);
+				     mxbuf->xdp.data - mxbuf->xdp.data_meta, mxbuf);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -2071,7 +2074,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		skb = mlx5e_build_linear_skb(rq, mxbuf->xdp.data_hard_start,
 					     linear_frame_sz,
 					     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
-					     mxbuf->xdp.data - mxbuf->xdp.data_meta);
+					     mxbuf->xdp.data - mxbuf->xdp.data_meta, mxbuf);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL;
@@ -2168,7 +2171,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
-	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
+	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize, mxbuf);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -2202,7 +2205,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		dma_sync_single_range_for_cpu(rq->pdev, dma_addr, 0, frag_size, rq->buff.map_dir);
 		net_prefetchw(hdr);
 		net_prefetch(data);
-		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0);
+		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0, NULL);
 		if (unlikely(!skb))
 			return NULL;
 

-- 
2.43.0


