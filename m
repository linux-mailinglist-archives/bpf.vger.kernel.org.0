Return-Path: <bpf+bounces-67989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD20B50C5F
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 05:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B792A7AE0E7
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 03:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C626C3B0;
	Wed, 10 Sep 2025 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLI8uNDf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F6265620;
	Wed, 10 Sep 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475669; cv=none; b=Wlr4hiWrUDokTs+M80C77Qu/fpZdYY08pI4H4assefshza38W3nRq+udruvdYxl3Era/OWJCdz6JjHEaRgjx/JDYhJuwvJkcqEUlZNznvW6ID0/HK9uo+aOqmrhsIDawsLVkqynahQhHtn1TAXIThEjnYdgJR/1gBbXAoU/43p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475669; c=relaxed/simple;
	bh=0c93aM9nKwr6XM13DtCwkj9gQSzVAlEVmNpgjwbZo8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXH3ZGjlH+em94I7t2f/eI6F7O8YNf4mPgZkj5FEGuxBU3x5CzIE3UeEBt35u6nCHFAfopKxRJb4XxeswyY+jOjVTTJPnaJ+ApCkrC4585J751XTZ2/5Ya89vF9ZHI4mwZh/sdppcr+u8lovUU/2zSlj/tSNKeQ+D+Bo2Az0/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLI8uNDf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5767611a12.1;
        Tue, 09 Sep 2025 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757475667; x=1758080467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFGDTUzvgTMiMdp7ZXYHTaeJTJeNdJI16BCNbHH/jVg=;
        b=eLI8uNDf+ZY9xDM0hY95Kq2XPBcZ0ooVa5wZQ+HKlmiiB5KprcLu3F+wIVUxTzPy0k
         mSZW88B1A214/AQB+eOPhEZdmfLhMVfMzLHm5J3le+J3lg8CVgokIeIpvmbDNpyqH9b5
         vBs7aFcTXq1eICHy+etoYidk9eg8GPaEHTx2mXub4CeXogWFUm+4UYux3BjFRXRgcQTj
         EdGzl8E1aOrl/4v8Jx50TLbFAz3sy7RV7Yw9P9KGbkVTcwN3xTYk8CLEQTB3oQUvrRmn
         aalk0lppWR4SzqvYqlhSe00jY+0rXXH4Mq+VwdZKOrH1yKIca9BMdZbxGQVt8OwJk30u
         dXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757475667; x=1758080467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFGDTUzvgTMiMdp7ZXYHTaeJTJeNdJI16BCNbHH/jVg=;
        b=HcodI4LNj8C5R7k4RSPituJUzAl4aLvR/h9Yt/qnAR/WuJmn7DvWCZbPSwJig2mCYs
         tZd9jSwAP7IlaK/mGRdLs8DNksjyuC6+4q0CM2ZOKBTMglMuQHco9GFIXFfMqzPWB7Uv
         AsVf2OMTG3pRkvkoWSMTE01bOoSiwiQdVq1nNFEfZDc1OO3A6yhqnHKZQQZQgXlIYOT+
         pFcfMAIU/UjRyQ+f+7YcZXkISFBfZICUZouPZr02Ev41HlwzG9F6kf/HOYJRR2IS2fpn
         XGyCKEcUu6t75LF7swBnkSAu0NQGxhpYx3AFKpKfSPPIT+JgOPihwkZ+8BUouH6NauUN
         DTag==
X-Gm-Message-State: AOJu0YwWqj6tnSGfDBQJunjVcDKEQR6lENYGf+UWlyMTXSh2J7C/J786
	q/0MifUCTFpmnxytA+wjpDMXJpYz+NwkjWGnkP9xuqvMsgRkU1xnrLI8FGTc6g==
X-Gm-Gg: ASbGncuepv9dFhWMvN8H85Kf4wIV3jcyqqm/vbAJJRd2yhsMuxjA249rC82ni+gUjwO
	QoUVKnkeOQ2C+2lJvUpIMsh/nVaGZVSEFNyi73lvpE69OwL9XW1J3joPrrKOYRCRPU/gZiYGgUh
	i6oWPBpkrTQnfB59/Z38YN3l6BSEUZyf3ACO+367fSiBVAp1zBFEU56tb4QgoBypMMPVEf3S00U
	n33iEjijmG9advc+1ohdCbC+dDT1wyssiq/MUDA44aoBnWDI7Nfn7jTx761Tk8d83+ShxkIPpXo
	yW2WVsOSNCk8RC/Hu1MW0gEQjiUEx5eM/L7tgTKAINhSC9gZjan9fqlkZ2yHMcKvBWJmf819xQv
	jt/jA+9Gh975haEu7A12x2MJJ
X-Google-Smtp-Source: AGHT+IGNnC3cUjip1QMTTjCIEN6nAmqHD6tD8d0qu4GkmzCNH132RH6s49i4ZDA3G/QSliFYRmDDhg==
X-Received: by 2002:a05:6a20:2447:b0:246:7032:2c1d with SMTP id adf61e73a8af0-2533fab7a36mr19782275637.23.1757475667133;
        Tue, 09 Sep 2025 20:41:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:15::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466119e6fsm3580532b3a.32.2025.09.09.20.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:41:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	martin.lau@kernel.org,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	cpaasch@openai.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net v1 2/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ
Date: Tue,  9 Sep 2025 20:41:03 -0700
Message-ID: <20250910034103.650342-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910034103.650342-1-ameryhung@gmail.com>
References: <20250910034103.650342-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP programs can change the layout of an xdp_buff through
bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
cannot assume the size of the linear data area nor fragments. Fix the
bug in mlx5 by generating skb according to xdp_buff after XDP programs
run.

Currently, when handling multi-buf XDP, the mlx5 driver assumes the
layout of an xdp_buff to be unchanged. That is, the linear data area
continues to be empty and fragments remain the same. This may cause
the driver to generate erroneous skb or triggering a kernel
warning. When an XDP program added linear data through
bpf_xdp_adjust_head(), the linear data will be ignored as
mlx5e_build_linear_skb() builds an skb without linear data and then
pull data from fragments to fill the linear data area. When an XDP
program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
data size and trigger the BUG_ON in it.

To fix the issue, first record the original number of fragments. If the
number of fragments changes after the XDP program runs, rewind the end
fragment pointer by the difference and recalculate the truesize. Then,
build the skb with the linear data area matching the xdp_buff. Finally,
only pull data in if there is non-linear data and fill the linear part
up to 256 bytes.

Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1d3eacfd0325..fc881d8d2d21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2013,6 +2013,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2066,7 +2067,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2082,10 +2083,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
 
@@ -2096,9 +2102,16 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		frag_page -= nr_frags_free;
+		truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) +
+			    (nr_frags_free - 1) * ALIGN(PAGE_SIZE, BIT(rq->mpwqe.log_stride_sz));
+
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
 		skb = mlx5e_build_linear_skb(
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
-			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
@@ -2123,8 +2136,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, skb->data_len);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-- 
2.47.3


