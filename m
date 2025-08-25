Return-Path: <bpf+bounces-66438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E8B34AFF
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D651B23532
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D532853FA;
	Mon, 25 Aug 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNhkvxBe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38002836BE;
	Mon, 25 Aug 2025 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150764; cv=none; b=rNU/IAWcpUGnZTUlJyVsxHchSr7dCKz/D3iagUic7yKhESpuhTAWmbWFtu2CQU819DcCiZrf2Cg4szHC7jsHV8HXIVEaPEK0LmG1WeAU16nF8GnMnlGqSx6I7izb3cAY3AU2S1FHWE/NsHuvCPAB0P6MTrkiJNuj9ZerFU+8doU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150764; c=relaxed/simple;
	bh=6zbQsLGryGht3IxR9YTLPXsIEJIPNar4pof0HIfansM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfguantCZQ0uCrsMLCY6nyNRCjE3Z3p3cRW+L52fUwKMtx0MBrW6traKCa1sYTXEMafL8NDp8aw9ZKEFu66gqyB07WAvDbmbi68bS5sILusLmk6TcSmalKqjiZsWDqM2UcnuMDJ0/SCc3z6k/NeNcL60jlwi3wLorO7kTNnbhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNhkvxBe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4263517a12.3;
        Mon, 25 Aug 2025 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150762; x=1756755562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42IL8kYbsE6npAmM7AFRlW6DjNLWnjEJ71+rb9UJB+I=;
        b=YNhkvxBeZ2WIpwXqdwWKbjrlEV7gkRq7RwuyRRZJAxcECRn4H3YMiFlyIPrKpFXNyO
         2ubD2LqOcEJMTHSf0I++vAoJC7oDKqCAIMfT4iNDhT/K9YlxPWKooQgkDwSERHP6Lsxh
         50t88X0ksaiv8QsRYH1Eb/MMTE1Ub2oAcKy5k1VhE506PzUdysWyBy9TtU/1/LAN5Epp
         RHqkAcN8OXXyXcTi5kz6aaMA393pQLR/LfdybqFF462QnK1b7I3G3xoOn28I+tWlXaMt
         ImST/Cj5NLtkU/eqv0py6+6NkhKplPmKLcS/PY33vj4yA1U40B4t8yO2rN2IXsw/5Oe1
         V/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150762; x=1756755562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42IL8kYbsE6npAmM7AFRlW6DjNLWnjEJ71+rb9UJB+I=;
        b=UNfvroGXUtu4zmNY3qBvYb1GjVl4f525cabxjVI5E/Wbtam/gTtrfYQatAUu9F/6/p
         OqFgtvepqbmDKb6TNcyzO6YQ0us4gAH6G6eoGaJDIp6EmkxS5iKlMbemLP8RiYKB9yHF
         75biy8I6M+Qu/lbkO/iLbX7PfoAX3soYApWvIcBRF2vbmYTSc/Q+UqOYdS6PhPz0L1J5
         Q5BMSVBjYRdwq4i/UuqM7RZPVc2Njym+pvt/zsdVuSva1l3OxNz/ryQWR6bh7+ybzHcN
         ntB/8bntyj/i1fCzSj9KAY3qtaEb0EwHnu0YNQsJnfHnerJ0RkjX+da53yhch99bOXf1
         ha6w==
X-Gm-Message-State: AOJu0Yw7jOBBogSf2XAOET6oQ54A6m+UxglfzI7RjteTCuK7ppK0/XrV
	iIvFOKK37I3PVoK/6v6iy8auloDVu2hdWQ9BT1c9YKNv81WoRv+Bj2Smt1CNzg==
X-Gm-Gg: ASbGncsGtL8XGrbMXQiRzDsBv3BO7UMX1VLnMHiPuV7dfABOe82JNsdQ1YnsUwbIJ/6
	6omFMq8xUoM9lz75foG12pO2o5RUHZfqE3ToIyHIBpFTu5MzMpp8luRA8fOEl3qjW/b7x2uQMeC
	vwu7C8E5+gGEckcjpkIkYsGz3gLa+QIxU0MFj9SOSS1iZ1Z9sJ52qx/TwbaLjnewrKor90/dK8b
	KgTA0VHnmATmpy/ANffDlh6pA2tiwjrlGsXcQDo5+IpgnFmgY1GfoocSjW/h7BdU3xBfdntw3Lg
	PcYWE7QgB7YIa9o16iy1UpBj891U53XQu00F8LHM8SZXfYTXATS2ECt41iLYs2yzGyva9Z58hfr
	bIRPLnQ+08/mnpA==
X-Google-Smtp-Source: AGHT+IE9XEvRjJFo99xizn5ubeoENHTl/f+50ms85cV08Avl04eZQztqI1GOODqtMGvZ6qS1w64A/Q==
X-Received: by 2002:a17:90b:258c:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-32515ef1bb1mr17232678a91.33.1756150761863;
        Mon, 25 Aug 2025 12:39:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa6e27esm7731240a91.25.2025.08.25.12.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 1/7] net/mlx5e: Fix generating skb from nonlinear xdp_buff
Date: Mon, 25 Aug 2025 12:39:12 -0700
Message-ID: <20250825193918.3445531-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp programs can change the layout of an xdp_buff through
bpf_xdp_adjust_tail(), bpf_xdp_adjust_head(). Therefore, the driver
cannot assume the size of the linear data area nor fragments. Fix the
bug in mlx5e driver by generating skb according to xdp_buff layout.

Currently, when handling multi-buf xdp, the mlx5e driver assumes the
layout of an xdp_buff to be unchanged. That is, the linear data area
continues to be empty and the fragments remains the same. This may
cause the driver to generate erroneous skb or triggering a kernel
warning. When an xdp program added linear data through
bpf_xdp_adjust_head() the linear data will be ignored as
mlx5e_build_linear_skb() builds an skb with empty linear data and then
pull data from fragments to fill the linear data area. When an xdp
program has shrunk the nonlinear data through bpf_xdp_adjust_tail(),
the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
data size and trigger the BUG_ON in it.

To fix the issue, first build the skb with linear data area matching
the xdp_buff. Then, call __pskb_pull_tail() to fill the linear data for
up to MLX5E_RX_MAX_HEAD bytes. In addition, recalculate nr_frags and
truesize after xdp program runs.

Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 59 ++++++++++++++-----
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..c5173f1ccb4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1725,16 +1725,17 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	struct mlx5e_wqe_frag_info *pwi, *head_wi = wi;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
-	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
 	struct skb_shared_info *sinfo;
-	u32 frag_consumed_bytes;
+	u32 frag_consumed_bytes, i;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	dma_addr_t addr;
 	u32 truesize;
+	u8 nr_frags;
 	void *va;
 
 	frag_page = wi->frag_page;
@@ -1775,14 +1776,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+			pwi = head_wi;
+			while (pwi->frag_page->netmem != sinfo->frags[0].netmem && pwi < wi)
+				pwi++;
 
-			for (pwi = head_wi; pwi < wi; pwi++)
+			for (i = 0; i < sinfo->nr_frags; i++, pwi++)
 				pwi->frag_page->frags++;
 		}
 		return NULL; /* page/packet was consumed by XDP */
 	}
 
+	nr_frags = sinfo->nr_frags;
+	pwi = head_wi + 1;
+
+	if (prog) {
+		truesize = sinfo->nr_frags * frag_info->frag_stride;
+
+		while (pwi->frag_page->netmem != sinfo->frags[0].netmem && pwi < wi)
+			pwi++;
+	}
+
 	skb = mlx5e_build_linear_skb(
 		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
 		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
@@ -1796,12 +1809,12 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
-		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
+		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size, truesize,
 					   xdp_buff_is_frag_pfmemalloc(
 						&mxbuf->xdp));
 
-		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
+		for (i = 0; i < nr_frags; i++, pwi++)
 			pwi->frag_page->frags++;
 	}
 
@@ -2073,12 +2086,18 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
+		u8 nr_frags;
+		u32 len, i;
+
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-				struct mlx5e_frag_page *pfp;
+				struct mlx5e_frag_page *pagep = head_page;
+
+				while (pagep->netmem != sinfo->frags[0].netmem && pagep < frag_page)
+					pagep++;
 
-				for (pfp = head_page; pfp < frag_page; pfp++)
-					pfp->frags++;
+				for (i = 0; i < sinfo->nr_frags; i++)
+					pagep->frags++;
 
 				wi->linear_page.frags++;
 			}
@@ -2087,9 +2106,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+		nr_frags = sinfo->nr_frags;
+
 		skb = mlx5e_build_linear_skb(
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
-			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
@@ -2102,20 +2124,25 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
-			struct mlx5e_frag_page *pagep;
+			struct mlx5e_frag_page *pagep = head_page;
+
+			truesize = nr_frags * PAGE_SIZE;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
-			xdp_update_skb_shared_info(skb, frag_page - head_page,
+			xdp_update_skb_shared_info(skb, nr_frags,
 						   sinfo->xdp_frags_size, truesize,
 						   xdp_buff_is_frag_pfmemalloc(
 							&mxbuf->xdp));
 
-			pagep = head_page;
-			do
+			while (pagep->netmem != sinfo->frags[0].netmem && pagep < frag_page)
+				pagep++;
+
+			for (i = 0; i < nr_frags; i++, pagep++)
 				pagep->frags++;
-			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, sinfo->xdp_frags_size);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-- 
2.47.3


