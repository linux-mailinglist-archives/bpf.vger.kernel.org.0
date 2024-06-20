Return-Path: <bpf+bounces-32652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC4911597
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20F31C22AD1
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119A155723;
	Thu, 20 Jun 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aHW3Xsw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB801552E0
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921975; cv=none; b=Lzk78SwA76Hg6a4j/fIKOhEwaJqlaJUMewp63wAnKdXGJeLbwy/1LxCRjT+gahdGi3Niie/GGoyfljClu1zlHJWWQHR7dlTd0KGFOEFVFYaOcwiC//IWiajddp5pmfVMrtn2OKNThIQjMu81OWnKua2hXN7xELx/XZdnphUp+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921975; c=relaxed/simple;
	bh=5NFFxPVvZiB990JZW1dZ4CHiL7ACNygPdHqSlrsa7z4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqiMfcAp+SOin0YER1Qo5S04uuoE2P+prNxPvqPwePyVm4+hsxE4X+4YJ+0rTaeOlCo6ElQ1vfNx0iK/TAwn4K7xR526i996IGOp2jWRIc+JrKh3e898UtPi6LE858C2VT6JphXPJ4Mg0cHQYqpTh0fzRqTbSDatDKAPzqM1SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aHW3Xsw3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-441567d352bso7958701cf.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921971; x=1719526771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rykvLwThOhLrOOeeNqCjBeseo9IibL0Bdz+4MdzT9Nw=;
        b=aHW3Xsw3/rvH7W/PSf5PZXZHx2lKH3vDD9o81M3R6NwUGEC8JUDdpLuZ58ecj6Atjh
         BWgsD04L5bi/PfHxs32ocX5eJUPAhwROQPVAfzNtKjMrilewV5NrydvG/ApSEzuY8Wkf
         YVrnROFCEAO6QpuaGv7iYwWL5TXxB2tmiXDq5yGD1s9T9rlirHZa7WD/6805N5sw9bZJ
         ci1Fnu23NsIeSNhQtn57/2cQNt7ocmojtcN9mPSOs3U8u69R/0xPSDwwerWRkxs4f4EL
         8WI9mymLVBaMiuk+d+CoJBoOBSp03gvB/AhPkBcIkHEn07h/YaVf/AIajbiTLPrULlgg
         s/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921971; x=1719526771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rykvLwThOhLrOOeeNqCjBeseo9IibL0Bdz+4MdzT9Nw=;
        b=YghYhf002e5zcQ22hASVbCdXUaTbaeEtrwtLHNg46+dH2DkfB34JnAN+2Q9vZpTFb/
         giyy2LZwjnkKiKfb37Lftfd4ZZDRu2rmovVasTHfRY5dRcSGSgNv5lpVtLaSWfmQUmPn
         Jio63URXNK9P2GfhkXfITAcDB37DSdtr6m+cz9zvNQi5oDeq87slqywN7QQ8lgh0HKhk
         ufTDrm+enP5UHB+kzD1cqiiQreSL2ttxZt6XHdbiR7kh9lhpY1WoLzvo02XT5DOLNn1w
         p6+Mud9RUNLFWFHw7S9i/Q6aSa18oxtubqItvzub+mLH7BS0tzTssbDzn+tIdIc80VUQ
         SOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoOdk4ulM+V9lc7/gEaPZENK9od6HWYaTnF5cNVOHvqQIUMfyE097bSm9OFXtGP5jG6+j4i5w80TYUVTA8O9HN5aSz
X-Gm-Message-State: AOJu0YxPdeEIwkpWlA7VfsWEPmRP7zZq8cwPlRLPRhJIoKQTmAryIBBW
	vSSFCDQVStgqY3GC5iC99ELl8ujx/qSCTRjA8JeThBNLH7JrkRgZAavvLR/1cmw=
X-Google-Smtp-Source: AGHT+IG8SQF3m3IlxRlHF/5JsZ+TboQGIMJ+L1bIDhhhEA3zuZEzDdHGY8kz+7qvbwzEpIV8spi//w==
X-Received: by 2002:a05:622a:305:b0:440:607a:dcb with SMTP id d75a77b69052e-444a79e14bdmr75009831cf.29.1718921971108;
        Thu, 20 Jun 2024 15:19:31 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b96f1bsm1964241cf.50.2024.06.20.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:30 -0700 (PDT)
From: Jesper Dangaard Brouer <yan@cloudflare.com>
X-Google-Original-From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Thu, 20 Jun 2024 15:19:28 -0700
To: netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yan Zhai <yan@cloudflare.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 7/9] mlx5: move xdp_buff scope one level up
Message-ID: <5b7a761d6efa1be2ace4c12c1681f341a87d8d24.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

This is in preparation for changes.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |   6 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.h   |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 103 +++++++++---------
 4 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 6a343a8f162f..3d26f976f692 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -580,14 +580,16 @@ struct mlx5e_mpw_info {
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
index 1b7132fa70de..4dacaa61e106 100644
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
index cefc0ef6105d..0890c975042c 100644
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
index 225da8d691fc..1a592a1ab988 100644
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
@@ -1658,7 +1658,8 @@ static void mlx5e_fill_mxbuf(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 
 static struct sk_buff *
 mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt,
+			  struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = wi->frag_page;
 	u16 rx_headroom = rq->buff.headroom;
@@ -1680,17 +1681,15 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
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
@@ -1706,14 +1705,14 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
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
@@ -1733,8 +1732,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	net_prefetch(va + rx_headroom);
 
 	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-			 frag_consumed_bytes, &mxbuf);
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+			 frag_consumed_bytes, mxbuf);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 	truesize = 0;
 
 	cqe_bcnt -= frag_consumed_bytes;
@@ -1746,7 +1745,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 		frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp, frag_page,
 					       wi->offset, frag_consumed_bytes);
 		truesize += frag_info->frag_stride;
 
@@ -1756,7 +1755,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 			struct mlx5e_wqe_frag_info *pwi;
 
@@ -1766,21 +1765,21 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
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
@@ -1811,6 +1810,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -1828,7 +1828,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_linear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
@@ -1859,6 +1859,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -1875,7 +1876,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	skb = INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
@@ -1903,6 +1904,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
 	u32 head_offset    = wqe_offset & ((1 << rq->mpwqe.page_shift) - 1);
 	u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5_wq_ll *wq;
 	struct sk_buff *skb;
@@ -1928,7 +1930,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	skb = INDIRECT_CALL_2(rq->mpwqe.skb_from_cqe_mpwrq,
 			      mlx5e_skb_from_cqe_mpwrq_linear,
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
-			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx);
+			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx, &mxbuf);
 	if (!skb)
 		goto mpwrq_cqe_out;
 
@@ -1975,7 +1977,7 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				   u32 page_idx)
+				   u32 page_idx, struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
@@ -1983,7 +1985,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	unsigned int truesize = 0;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -2029,9 +2030,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 	}
 
-	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, mxbuf);
 
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
@@ -2042,7 +2043,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		else
 			truesize += ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page, frag_offset,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp, frag_page, frag_offset,
 					       pg_consumed_bytes);
 		byte_cnt -= pg_consumed_bytes;
 		frag_offset = 0;
@@ -2050,7 +2051,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
@@ -2063,10 +2064,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
@@ -2076,13 +2077,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
@@ -2093,12 +2094,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
@@ -2120,7 +2121,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				u32 page_idx)
+				u32 page_idx, struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 rx_headroom = rq->buff.headroom;
@@ -2148,20 +2149,19 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 
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
@@ -2283,12 +2283,14 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
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
@@ -2311,7 +2313,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			*skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
 		else
 			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
-								  data_offset, page_idx);
+								  data_offset, page_idx, &mxbuf);
 		if (unlikely(!*skb))
 			goto free_hd_entry;
 
@@ -2369,6 +2371,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
 	u32 head_offset    = wqe_offset & ((1 << rq->mpwqe.page_shift) - 1);
 	u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5_wq_ll *wq;
 	struct sk_buff *skb;
@@ -2396,7 +2399,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_mpwrq_linear,
 			      rq, wi, cqe, cqe_bcnt, head_offset,
-			      page_idx);
+			      page_idx, &mxbuf);
 	if (!skb)
 		goto mpwrq_cqe_out;
 
@@ -2624,6 +2627,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -2640,7 +2644,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	skb = INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb)
 		goto wq_cyc_pop;
 
@@ -2714,6 +2718,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 trap_id;
@@ -2729,7 +2734,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 		goto wq_cyc_pop;
 	}
 
-	skb = mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt);
+	skb = mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb)
 		goto wq_cyc_pop;
 
-- 
2.30.2



