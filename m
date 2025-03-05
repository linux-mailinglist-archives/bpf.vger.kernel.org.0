Return-Path: <bpf+bounces-53333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2CA5021F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3816D38F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE494250C0A;
	Wed,  5 Mar 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="hf1dc0L4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3nUXE0B8"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730A250BF1;
	Wed,  5 Mar 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185223; cv=none; b=JWAHKgIZE7OinmGJ0P2EtJcEQczpRjqgzu0e4Nrq/XdPK5L3SV4IakZya44nv17fAvYDuht8oATOJ995/Ljo6L9RM2wng6zgs3Xpc5ZEtoYYEND2yWujU+1a1CoXECHjNUJNBvReD9pi5f3+YJ+6kPlxqNO79ezWdHuqJs0jsqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185223; c=relaxed/simple;
	bh=tpM0cB5vXCNmMtGFfTMEtumsE+4YNdQFGV+GNpq71Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2NMpcJi1Fm57AuVEW/k3rlOlvfX6kdJ+0H45kguPLEGDoXJXkyXmICuNNQ4K/J9HpkOJHtV9TuyHTs8r+BglbrPD9EiB4JDjetjuMWiy6c22pT1tFdIquxdvvG2vx3PY2od2uXmQrhPmCbSEwQFQwC4Xm6x+xhxr7mAW8ahgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=hf1dc0L4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3nUXE0B8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 431F91140219;
	Wed,  5 Mar 2025 09:33:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Mar 2025 09:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185220; x=1741271620; bh=fTGDU7O2879ZtUCbBbFzOgm2l0L85u2g
	SYZCEXfVXFA=; b=hf1dc0L4Gqc6F4T7PM4/I01MOaIdUV8Kl4b74J5jQDBmFGtI
	dlQr3Nft1l/PmcLOEtGLOjtSviZ4oWLt1Xq9Z01H/ncOEZKSipcRBze3zdsqC6O7
	hvFLWsCIqJc4jZjwXF4czsKKt6f05xV4Iu8WC9xOgzN+APCUmkYk33pbaXSQYXfH
	pCZqNhm1ARqQUhOoUxIHY3k5kuky6FHEfGUeQXhfMlT15fYmvaZG38G7/D/nfaqY
	nQ8W4u5KX2ev5o3wK4VGBocvAx/h2A6bqY7cMvDJ5NmUTvIcPO3zz2OGuHX64/VV
	d3dQtF+z7yNnKjpzqWayf6XaAGk08+ztw6A5rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185220; x=
	1741271620; bh=fTGDU7O2879ZtUCbBbFzOgm2l0L85u2gSYZCEXfVXFA=; b=3
	nUXE0B8TsA8lZwRhllXC7w3r5UYhX1hEzqf5Z+DZqNSJtBddWxY7N4Wac/oZOhxg
	QiozLtm4OWToIu+1U2Pth/YvXeY68/IIXJ7nlZA2ubZRu7RtD70nAkw1uJ3PKxnG
	oibRmltay/oZyg5XlfCGLyukUEs39E4VagzNT61l3jfrbJdI0YmG7alJ5CrmwoI3
	V3y0rTy2zLRDLaDrMrAKe/Y4hsqs8kRwEK5FsK6EMjUKtgHFnt0+DncuhQjsA52M
	BM0V2k19D/Em3qmXOoodIHrvoBJtu5+8rApPbNw6wKyyBOB85qDT8uSXMft1OsHX
	7hE1pRCh7afYM+w4kfRgw==
X-ME-Sender: <xms:xGDIZ9LAwmCTaO47QZ6R1OTri24YuU615jRhdoyMiuf5ES14ReF4Tw>
    <xme:xGDIZ5LhtlEbdvdw1bTkqJsrEKwq73XW3BMiWGjwWCIa1az4D-NvxghyMVyM-Ey1R
    P7jq_ryEKZH1VYwh8s>
X-ME-Received: <xmr:xGDIZ1uPf58VbGzJwBImWujbyxpUkmDJsy0X_28sRiJvlhpOS93WSc4NQ6bcM-DHy_rt29yKEtxaOq3H0RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpedvtdefhedtgeehleffledvtedtkefhgeevffduheekvdetledtfeek
    hfefudetieenucffohhmrghinhepgiguphdruggrthgrnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrthhhuhhrsegrrhhthhhurhhfrggs
    rhgvrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehthhhoihhlrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgsihgr
    nhgtohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrfhgrsghrvgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepjhgrkh
    husgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohephigrnhestghlohhuughf
    lhgrrhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhgsrhgrnhguvggsuhhrghestghlohhuughflhgrrhgvrdgt
    ohhm
X-ME-Proxy: <xmx:xGDIZ-Y349ouhJFjY0vkckKYVkSTHedTDBdywk2l0BeAMT3egTSwWw>
    <xmx:xGDIZ0Y1Q499o_GFnxxJ2hCvzUHv4HbzgwEJyrSsUkik8a7kBJ9B3w>
    <xmx:xGDIZyAv6bImmCayAq9nfIB6-kWOPd3SBKm0dfh57ENog4mH96s7kw>
    <xmx:xGDIZyZivVFcYAT0f3bR1Q4jUnqmBF7-u2a1-cP-jHsgvMI8oYX_kg>
    <xmx:xGDIZykebgu-qTIvuT3Eql8wMGMdpKBNkOQRoCjTr3KM9HpKzvihE6ka>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:38 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:10 +0100
Subject: [PATCH RFC bpf-next 13/20] mlx5: move xdp_buff scope one level up
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-13-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Jesper Dangaard Brouer <hawk@kernel.org>

This is in preparation for changes.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.h    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 103 +++++++++++----------
 4 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1fe7b473ad0849cf84f189d09fd4f..9bed146806a8d8b2c0afb14b2417a4a95cc09dcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -581,14 +581,16 @@ struct mlx5e_mpw_info {
 #define MLX5E_MAX_RX_FRAGS 4
 
 struct mlx5e_rq;
+struct mlx5e_xdp_buff;
 typedef void (*mlx5e_fp_handle_rx_cqe)(struct mlx5e_rq*, struct mlx5_cqe64*);
 typedef struct sk_buff *
 (*mlx5e_fp_skb_from_cqe_mpwrq)(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			       struct mlx5_cqe64 *cqe, u16 cqe_bcnt,
-			       u32 head_offset, u32 page_idx);
+			       u32 head_offset, u32 page_idx,
+			       struct mlx5e_xdp_buff *mxbuf);
 typedef struct sk_buff *
 (*mlx5e_fp_skb_from_cqe)(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			 struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
+			 struct mlx5_cqe64 *cqe, u32 cqe_bcnt, struct mlx5e_xdp_buff *mxbuf);
 typedef bool (*mlx5e_fp_post_rx_wqes)(struct mlx5e_rq *rq);
 typedef void (*mlx5e_fp_dealloc_wqe)(struct mlx5e_rq*, u16);
 typedef void (*mlx5e_fp_shampo_dealloc_hd)(struct mlx5e_rq*, u16, u16, bool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 1b7132fa70de2805a81b878fe3fa308ca9d4de6f..4dacaa61e1061960e09dccd6f97bc2f2d02ffbb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -249,7 +249,8 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    struct mlx5_cqe64 *cqe,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
-						    u32 page_idx)
+						    u32 page_idx,
+						    struct mlx5e_xdp_buff *mxbuf_)
 {
 	struct mlx5e_xdp_buff *mxbuf = xsk_buff_to_mxbuf(wi->alloc_units.xsk_buffs[page_idx]);
 	struct bpf_prog *prog;
@@ -304,7 +305,8 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
 					      struct mlx5_cqe64 *cqe,
-					      u32 cqe_bcnt)
+					      u32 cqe_bcnt,
+					      struct mlx5e_xdp_buff *mxbuf_)
 {
 	struct mlx5e_xdp_buff *mxbuf = xsk_buff_to_mxbuf(*wi->xskp);
 	struct bpf_prog *prog;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
index cefc0ef6105d24705bdd450cfd7857435a9d0c67..0890c975042c7f58e512a61fc538f21b5e37c6b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
@@ -16,10 +16,12 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    struct mlx5_cqe64 *cqe,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
-						    u32 page_idx);
+						    u32 page_idx,
+						    struct mlx5e_xdp_buff *mxbuf_);
 struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
 					      struct mlx5_cqe64 *cqe,
-					      u32 cqe_bcnt);
+					      u32 cqe_bcnt,
+					      struct mlx5e_xdp_buff *mxbuf_);
 
 #endif /* __MLX5_EN_XSK_RX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1963bc5adb1887af5a2cadb3febf24bef0ae3338..77bace3b212ae18c420a11312a5e3043b5e3f4ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -63,11 +63,11 @@
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				u32 page_idx);
+				u32 page_idx, struct mlx5e_xdp_buff *mxbuf);
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				   u32 page_idx);
+				   u32 page_idx, struct mlx5e_xdp_buff *mxbuf);
 static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe);
 static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe);
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe);
@@ -1662,7 +1662,8 @@ static void mlx5e_fill_mxbuf(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 
 static struct sk_buff *
 mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt,
+			  struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = wi->frag_page;
 	u16 rx_headroom = rq->buff.headroom;
@@ -1684,17 +1685,15 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
-
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf))
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf))
 			return NULL; /* page/packet was consumed by XDP */
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -1710,14 +1709,14 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 static struct sk_buff *
 mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt,
+			     struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
 	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -1737,8 +1736,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	net_prefetch(va + rx_headroom);
 
 	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-			 frag_consumed_bytes, &mxbuf);
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+			 frag_consumed_bytes, mxbuf);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 	truesize = 0;
 
 	cqe_bcnt -= frag_consumed_bytes;
@@ -1750,7 +1749,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 		frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp, frag_page,
 					       wi->offset, frag_consumed_bytes);
 		truesize += frag_info->frag_stride;
 
@@ -1760,7 +1759,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 			struct mlx5e_wqe_frag_info *pwi;
 
@@ -1770,21 +1769,21 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 		return NULL; /* page/packet was consumed by XDP */
 	}
 
-	skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start, rq->buff.frame0_sz,
-				     mxbuf.xdp.data - mxbuf.xdp.data_hard_start,
-				     mxbuf.xdp.data_end - mxbuf.xdp.data,
-				     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+	skb = mlx5e_build_linear_skb(rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
+				     mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
+				     mxbuf->xdp.data_end - mxbuf->xdp.data,
+				     mxbuf->xdp.data - mxbuf->xdp.data_meta);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb_mark_for_recycle(skb);
 	head_wi->frag_page->frags++;
 
-	if (xdp_buff_has_frags(&mxbuf.xdp)) {
+	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
 		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
 					   sinfo->xdp_frags_size, truesize,
-					   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+					   xdp_buff_is_frag_pfmemalloc(&mxbuf->xdp));
 
 		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
 			pwi->frag_page->frags++;
@@ -1815,6 +1814,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -1832,7 +1832,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_linear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
@@ -1863,6 +1863,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -1879,7 +1880,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	skb = INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
@@ -1907,6 +1908,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
 	u32 head_offset    = wqe_offset & ((1 << rq->mpwqe.page_shift) - 1);
 	u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5_wq_ll *wq;
 	struct sk_buff *skb;
@@ -1932,7 +1934,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	skb = INDIRECT_CALL_2(rq->mpwqe.skb_from_cqe_mpwrq,
 			      mlx5e_skb_from_cqe_mpwrq_linear,
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
-			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx);
+			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx, &mxbuf);
 	if (!skb)
 		goto mpwrq_cqe_out;
 
@@ -1979,7 +1981,7 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				   u32 page_idx)
+				   u32 page_idx, struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
@@ -1987,7 +1989,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	unsigned int truesize = 0;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -2033,9 +2034,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 	}
 
-	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, mxbuf);
 
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
@@ -2046,7 +2047,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		else
 			truesize += ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page, frag_offset,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp, frag_page, frag_offset,
 					       pg_consumed_bytes);
 		byte_cnt -= pg_consumed_bytes;
 		frag_offset = 0;
@@ -2054,7 +2055,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
@@ -2067,10 +2068,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start,
+		skb = mlx5e_build_linear_skb(rq, mxbuf->xdp.data_hard_start,
 					     linear_frame_sz,
-					     mxbuf.xdp.data - mxbuf.xdp.data_hard_start, 0,
-					     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+					     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+					     mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL;
@@ -2080,13 +2081,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		wi->linear_page.frags++;
 		mlx5e_page_release_fragmented(rq, &wi->linear_page);
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
 			xdp_update_skb_shared_info(skb, frag_page - head_page,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(&mxbuf->xdp));
 
 			pagep = head_page;
 			do
@@ -2097,12 +2098,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	} else {
 		dma_addr_t addr;
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(&mxbuf->xdp));
 
 			pagep = frag_page - sinfo->nr_frags;
 			do
@@ -2124,7 +2125,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				u32 page_idx)
+				u32 page_idx, struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 rx_headroom = rq->buff.headroom;
@@ -2152,20 +2153,19 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
 				frag_page->frags++;
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -2288,12 +2288,14 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	bool flush		= cqe->shampo.flush;
 	bool match		= cqe->shampo.match;
 	struct mlx5e_rq_stats *stats = rq->stats;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5e_mpw_info *wi;
 	struct mlx5_wq_ll *wq;
 
 	wi = mlx5e_get_mpw_info(rq, wqe_id);
 	wi->consumed_strides += cstrides;
+	mxbuf.xdp.flags = 0;
 
 	if (unlikely(MLX5E_RX_ERR_CQE(cqe))) {
 		mlx5e_handle_rx_err_cqe(rq, cqe);
@@ -2316,7 +2318,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			*skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
 		else
 			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
-								  data_offset, page_idx);
+								  data_offset, page_idx, &mxbuf);
 		if (unlikely(!*skb))
 			goto free_hd_entry;
 
@@ -2377,6 +2379,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
 	u32 head_offset    = wqe_offset & ((1 << rq->mpwqe.page_shift) - 1);
 	u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5_wq_ll *wq;
 	struct sk_buff *skb;
@@ -2404,7 +2407,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_mpwrq_linear,
 			      rq, wi, cqe, cqe_bcnt, head_offset,
-			      page_idx);
+			      page_idx, &mxbuf);
 	if (!skb)
 		goto mpwrq_cqe_out;
 
@@ -2632,6 +2635,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -2648,7 +2652,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	skb = INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb)
 		goto wq_cyc_pop;
 
@@ -2722,6 +2726,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 trap_id;
@@ -2737,7 +2742,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 		goto wq_cyc_pop;
 	}
 
-	skb = mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt);
+	skb = mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb)
 		goto wq_cyc_pop;
 

-- 
2.43.0


