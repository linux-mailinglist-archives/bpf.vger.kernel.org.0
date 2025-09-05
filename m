Return-Path: <bpf+bounces-67590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA1EB4603B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7107E1BC8E46
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979F3469E0;
	Fri,  5 Sep 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bejeNx0u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EE309F06;
	Fri,  5 Sep 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093636; cv=none; b=ERagkAH1TFp+gIWUJEEzytUtNgsp1/IWoOpHECbP4/b33NPcjDfPRAyzwGLWBSjc4bK4V/aceo5Gvx5N873UfBNXibU6eZiskPhQLUjdXV/dv7Dtygj0HQmdYY+OQVKwl+yJY8q37er+ibrwQOGc6xQmWWlO4rxqoxWzFFP6DL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093636; c=relaxed/simple;
	bh=mZD8K1CZwyZfQFWNeIwWlVBXw+Mi/b+m+16+Kh7l1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBhaxoQYXzi80V+2OI74h0neVvM0hSjELruTcqEZuOPDIrT8tGHSnSSvnb1ynXhyhtt7BHQwWgrWEZpZ1gYBxjSZTjCFmln9+JEQwMU1hDVcfNiz60r3Ra2+LATUM38tlK9boc7tD53Akj9kXbkKotpRYs0UzdKBj52Bg5z3S5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bejeNx0u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-248ff68356aso22022115ad.1;
        Fri, 05 Sep 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093634; x=1757698434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXIx8dqrBHU/MrXBvIKJT9wN1m4rqVR2RSNfNKfLSRc=;
        b=bejeNx0uoUUUFfioKBuqXXx/9ZiGlvt4ilm1xHMVMLsLirfw2pXFPTnI9X6dTCMGkE
         H4AL4/Pdv5T/pqSZVqR0B5s+UYA2oiXrLQ2IvYlgETPMU/2Brt82yfbB06qHHyQ5F/mH
         BZwrdHXMnURkdN3baxPrbjxOLZTuUxqQg6Pje4t6zVzwg5Uh53E+sBfJxgEZJsVoiIyz
         8QXHZQrD80k7dVQcD1ZgdLbdcArMI/DlKT0LNC01aZtOQeU4L+WGNbZhKJitjxeM4txb
         TuRoa3gsNr9jLUzUbSkuEZgS/oywEbjDnf15XCJNpjkZzyzYCeFIG4AZli6mOA3lRKW/
         wOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093634; x=1757698434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXIx8dqrBHU/MrXBvIKJT9wN1m4rqVR2RSNfNKfLSRc=;
        b=lMLmDAZMiHuQ08iCTANKYO/ZaauRk9qmIrWr66VuAwgWIB9CwzVptwvfeYYCNHhoqo
         3of04qZM7Orlm3jrDMXW6fbYxFR1Ao+xiT81iVt76bvor7vNL4F3pwqUnblad0vD2c+m
         +W2+BGtvi6MIRIYPFz+qn2vDZ7TVe/1/J9fkki2FXzN8txO69hUEWh6stwRc+73GzyNo
         /1KVKnWHfjX1Xju3Ml17cn/ZxzkDyYlraD8PW4QOct/uMRD2tbtYrv0Zk731uDP6UAP5
         WjvwB0YQ9+8/0QsKrmlWsJOWGI/QaHgcDjCWNSgRUJv51XfHfXz6GcE0JM8HsUYsP/ru
         9a6g==
X-Gm-Message-State: AOJu0Yx1Ip6Sopm2qtwnCX0ozp75w19nztr0/66NZzD6hMpErWiCvUUU
	JGJnGKsJGltE9hwPlw4bIrvDVPRawSSzVo+cJqDDEz6wr0tiGTnPbVmHaE6+8g==
X-Gm-Gg: ASbGncv9Mn97jEapnHwPOr5IZ3uhvgu8im390c1P5+sC5wqBNWjvxlbrO11E7F1QycF
	REcFe4beQa8+Yh9AsZy2rnpMdsJcDqH3xMjrO2EUEFlJNUYXrakycKt6YD58L6+bXv1Yn0XRR/O
	DCbJUOlNJclAemXXgZpldFWhLKoG+pakxGHlcT889FloQK3LVIF3lVuMohBZoAJ3YbBgj7G9tuA
	G6h1FWF/ViPVG5WYcQYUX/+1g8QNEsMpsIImImU6AKkpBTtXM/kuU9v8aiw3EGKWOanek324oMy
	sB1KWAIoHhqNHKeJNiD9qQjrWogwTX5epFVhkxhK5h7V47vu5Lm0PlrB1tGVCpyQBtx1b29X2O8
	Xu6VUxH3pspAU6w==
X-Google-Smtp-Source: AGHT+IEC2S0idjEUrVf9uMxIJI//Kh/DAxLo2YLPeb26wa6P2LXZNJZv7YNwfmkWDOUw5QYaqk5O4Q==
X-Received: by 2002:a17:903:41c8:b0:249:1828:f4cf with SMTP id d9443c01a7336-24cef5278f9mr60432395ad.18.1757093634130;
        Fri, 05 Sep 2025 10:33:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af5ff6edesm120923265ad.78.2025.09.05.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/7] net/mlx5e: Fix generating skb from nonlinear xdp_buff
Date: Fri,  5 Sep 2025 10:33:45 -0700
Message-ID: <20250905173352.3759457-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp programs can change the layout of an xdp_buff through
bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
cannot assume the size of the linear data area nor fragments. Fix the
bug in mlx5 by generating skb according to xdp_buff after xdp programs
run.

Currently, when handling multi-buf xdp, the mlx5 driver assumes the
layout of an xdp_buff to be unchanged. That is, the linear data area
continues to be empty and fragments remains the same. This may cause
the driver to generate erroneous skb or triggering a kernel
warning. When an xdp program added linear data through
bpf_xdp_adjust_head(), the linear data will be ignored as
mlx5e_build_linear_skb() builds an skb without linear data and then
pull data from fragments to fill the linear data area. When an xdp
program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
data size and trigger the BUG_ON in it.

To fix the issue, first record the original number of fragments. If the
number of fragments changes after the xdp program runs, rewind the end
fragment pointer by the difference and recalculate the truesize. Then,
build the skb with linear data area matching the xdp_buff. Finally, only
pull data in if there is non-linear data and fill the linear part up to
256 bytes.

Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..6b6bb90cf003 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1729,6 +1729,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
+	u8 nr_frags_free, old_nr_frags;
 	struct skb_shared_info *sinfo;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
@@ -1772,17 +1773,27 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 		wi++;
 	}
 
+	old_nr_frags = sinfo->nr_frags;
+
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 			struct mlx5e_wqe_frag_info *pwi;
 
+			wi -= old_nr_frags - sinfo->nr_frags;
+
 			for (pwi = head_wi; pwi < wi; pwi++)
 				pwi->frag_page->frags++;
 		}
 		return NULL; /* page/packet was consumed by XDP */
 	}
 
+	nr_frags_free = old_nr_frags - sinfo->nr_frags;
+	if (unlikely(nr_frags_free)) {
+		wi -= nr_frags_free;
+		truesize -= nr_frags_free * frag_info->frag_stride;
+	}
+
 	skb = mlx5e_build_linear_skb(
 		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
 		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
@@ -2004,6 +2015,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2057,7 +2069,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2073,10 +2085,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u32 len;
+
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
+				frag_page -= old_nr_frags - sinfo->nr_frags;
+
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -2087,9 +2104,22 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+
+			/* the last frag is always freed first */
+			truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
+			while (--nr_frags_free)
+				truesize -= nr_frags_free *
+					    ALIGN(PAGE_SIZE, BIT(rq->mpwqe.log_stride_sz));
+		}
+
 		skb = mlx5e_build_linear_skb(
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
-			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
@@ -2114,8 +2144,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, sinfo->xdp_frags_size);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-- 
2.47.3


