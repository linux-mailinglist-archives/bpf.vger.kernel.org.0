Return-Path: <bpf+bounces-53334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95BA50224
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA83167B75
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7C2512C7;
	Wed,  5 Mar 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="RG6ezzxJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2K++8eaj"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6EF24CEEC;
	Wed,  5 Mar 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185224; cv=none; b=JPRZzwfyeohTayTq2dwonBB5iDZwbH+Yl6fA47zgP3Ju0OtNsztpsIcGm+vuWr2egTXtKllda8U+e0S5d4RLjMZ/ryfr1ZsSGq64ktlS848erdb6hFMisd5kIyYc6rVBSC57aa7+U2du2HrAxQJfh8J/cQRy0yPYgHI1NEG8B14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185224; c=relaxed/simple;
	bh=JvyiaBoZ3tLM0Ebt8VBzodGkOeIPyWTP9kDQYbzbrEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuOoBV8w1zLRcXT/uFX79CTw0iKyBRpqFYTs0L4MXUtBNm4OKb1PquGg1F6VNEY5tplUkFQK9JOrKxHIDLGq3nqcPjWpP9w1OqgcTboFOUWfSaeRPvvrOxsak2Rk6kTI82R8otBEPWlYwGPceJJaGhzRQdbQZ7rGGkVRe5DBazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=RG6ezzxJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2K++8eaj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E83F1140245;
	Wed,  5 Mar 2025 09:33:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 05 Mar 2025 09:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185222; x=1741271622; bh=Z2fR/H00aT8ZpO51TEqSeEcY9pKr00k8
	tFgJuylz4bY=; b=RG6ezzxJOAmbAqi9JpJhLeNjS4xVVm4Fve4PzUg47vCv7vN/
	D43nU3kU9po7J2+XsyS6n8JQOobQbkiC9cnqzmO+9yE+pQ7kVQ8EUkIbn4zyjYGL
	RrsI1qJqF0POgtcaHfpvXZcZp3Vf3g6bc0qltxSD904VSXF/7WY0Jard2UNVovhd
	iY4JXlJqgW3R+jc1owUKYvT0KLHPGvqiJIVkm9owQs8blUtHjlMEj3bJwgZFat75
	XAmPuY2PfX9DEyWATWRJ6lPG2IgQsC24+WaAPlm0t+jKXBHd81NfGEUP6Rc+ZhPr
	19QBwzEC/iVNOdRemaY6Hi1q+6jI2B1PdqLTrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185222; x=
	1741271622; bh=Z2fR/H00aT8ZpO51TEqSeEcY9pKr00k8tFgJuylz4bY=; b=2
	K++8eajDttg3KCucbhm9iIMRqlpeiMTo8TWYsjap5fPX8AWKVhebFkkWEtHEDFnp
	fNY96IwafQUQ2EkGO2VbtdfLxfr4UTYA0zSbZHqFiymrJirQsK2ArqysxXrjmfiR
	ELBtBg1WckTRtsdRdXTm1uKm2ceHb78DVsoZjLQaj+iJhgWORrh+CQ9tHsSFUn/i
	HL6cMHs0k54bDN6epoJbQPkZSDNGN4u66aO0o0xybaTLMZHLd2Pmy72czkIy+v+p
	GtEFY3kFvbOb6Jlil+3fbPJ8Pc6WbkOH6ewE6zayZtUpRd05FQoOk12SXKvJAPmH
	7X4lXI0g9H/Jt6omEkH2w==
X-ME-Sender: <xms:xWDIZ8lFZA7e5g9TyXUsyceRig7eZQhijvBUD64Ds7JJxHSziLM4Ow>
    <xme:xWDIZ71opiJGV7raCkDEcZgUty3I9NRuqQ3CuLnMCi6NlA4hpvVpnvHsz2_m6m62I
    Z3OP6AB_L33YtyWtVY>
X-ME-Received: <xmr:xWDIZ6q-kK5-nYPgKRhhvJfldPOQUUeYlNs9mXPqSM7BQX0NI8pLuMPG28TPmDLvIGJYtY9NNruUj842vtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:xWDIZ4lWidSs8l0RwUEkuzImxt1A71r--_kDr6Os86Sr6jYgcb4q8A>
    <xmx:xWDIZ62yyLK-NOpHWkjhhTmqVzW8miGjEDON6-InKBvdHOaGi8weuQ>
    <xmx:xWDIZ_sdXq6ceQ1pgzFpIZhH4Twtli5k5QVXmYXGVFQ4P6cr-s3kzA>
    <xmx:xWDIZ2XXA43eNZJD7vXs1R7DuXWNn8zfSSWA1GkLX4hJF4LK5m4MHg>
    <xmx:xmDIZ4wrtbzO0FvHoV6NEXUGRcn6slBllSg2N039ggY7UfIZ5vHitGsc>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:40 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:11 +0100
Subject: [PATCH RFC bpf-next 14/20] mlx5: Propagate trait presence to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-14-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Call the common xdp_buff_update_skb() helper.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 77bace3b212ae18c420a11312a5e3043b5e3f4ae..4ced9109a8f2a047992ab96fa533ad2a7283bb91 100644
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


