Return-Path: <bpf+bounces-68454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91AB587EE
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DA217ACC2
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4E2DC32D;
	Mon, 15 Sep 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSDytJSd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F71F7575
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977144; cv=none; b=FWsGdQalx6WDyqMYKyhgiTH+0j+rMsTnWS49ASpujj7kphgUQqQ/HSF8p5QUAVYI8KcDJ3YOdcVkv9Zxw44H47bZWn8t4RqHZtY1LrO9b82zHKlcq98GMW9svpeTfJAb9CAx5TuftMYty7dzJlRTgt4cNxYZZTRKW2ZfK1JbYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977144; c=relaxed/simple;
	bh=Hkl7Hrg9IFCZBYKnKnj3rKJzTmnbfDzbuHherwt+gR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qjed6vW+VlbCxR31d3EBIu//4ndjsXkrM2ymDEWL7ULp64ofx4ZPsOEKGg2weEYcZjyoZAcC3vVxDlKwP2nq5vodDM9x1B0VJApFHsZxyEFHSk/p3CtF3XZvh22p6AONg5LqIwxExm+48yS1ZeeWnf91CVVf2+ovBAyH23k8rO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSDytJSd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7761bca481dso2357499b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977141; x=1758581941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS72FUrrcjhUlTELkw2tpyEfgDIXEpCHERwaP4sAcqA=;
        b=VSDytJSdwp481YwAMcM1udnOKwW69fwD+8FrfCpwxbYBhO5G7G1SVLbHS84flYXjGa
         pnVbt+LkoHA67uC6v8HugJ6Eh9bRP/LpXknn4JkFF9T5wxJ1s61Yyd0lCipUJ7TQOObK
         4kff70JKPPoRfBtYnQU68+IFT+bsbiTWfxWBeF++S3jvogqf07qTEPHH9Me5gg527v9Q
         J+esn2K9kjqwKfJcQ67o/Jp22egN7kZ4yA+wDXJWUKOIqCvlfJONK3VvKPxtbh1iI5o+
         ZL0X7J8/pCQDt0izTfUlnlvqzcAc/B9g+2kcA2OwxK7h/nk7LoyhEm/2yKiEapcLki0D
         XXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977141; x=1758581941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS72FUrrcjhUlTELkw2tpyEfgDIXEpCHERwaP4sAcqA=;
        b=A4p1Wb6RCthwILFNs5oz7Us+GTwulXNVenzijgKveMfkMtHsFc0nY+5/1zM1vgZZYq
         avZipKub/L9WhJ6pKMBUtMXf5SOM34Zipo28nQjezuKvoPkMMypJs7stc+QtqH7PJ2N+
         FogVbPlhdImOXjkfJ9sgCkdkdVypBWMuR2u0xP2Qk0nJthtNqkVSwJ4SZOtRBxwzqoK+
         Vws4qdMoOC4D/0c+zLiA7kIf8ZUYkFLG+n1RSnOUVe6dwn7+vxNgkqPA7klgsavoatMV
         ewbf7r33ZYwshSaEa8m9lrSqZoUD3JsteIFQUVvhih5hqCJDABk8H2xnBmcjgmnqqOkQ
         Gf6g==
X-Gm-Message-State: AOJu0Yxzw/f3NjivJdHrRIfAPQ9hdWkNnN6tU5oI7LrJPI4SFoja4j9w
	DE1CSFq/y5xvdyc8avAa5sbh3byEaFx3KOzpCsc6it/BgIxRgMak9qMX
X-Gm-Gg: ASbGncsZHe1FfcAtr+YsJfes0OeEzaxvdwr+/EV3/Di5t30p7ymwvjQCBE0ftV+Ojmo
	FXktTC4uLqyRpuBZYZTegeoknmzr7w044ST0sN3Rh0d0Pd+fbm4ylAOnSxiKHfUHQMIiNiAYDT8
	3961Jd0O5UusjS1vhZRJFkRH6VMO4D7M+9JupTMEzmCJkKrD8spotZMvNWf+/s/P+tp2NMcRDaZ
	fe2dcmGhuFAotNDcj19dYLhQBBfXPbgqaMckWmTFbY+2grbvpDw6WwZLGdp5wjk/unQiTqkQC+M
	bm7/iTQ9aKrqn5sngQ2AAu5FObhsNqeyefM27CoM9+hwLb4hGwTG0wH8h0yMo0x50Hc4XUekDC9
	QsXf8+poYvUZ3RfgvSoJV0KA=
X-Google-Smtp-Source: AGHT+IHKP8ioierObvVqSiz84UtnesEULzdgz8cFdan1n6u2IG9xL8UfAUyAkVOjV0biNTBODJNixQ==
X-Received: by 2002:a05:6a20:3949:b0:262:af30:e4c with SMTP id adf61e73a8af0-262af303e80mr10211981637.53.1757977140912;
        Mon, 15 Sep 2025 15:59:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47310sm13959355b3a.27.2025.09.15.15.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:59:00 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ
Date: Mon, 15 Sep 2025 15:58:57 -0700
Message-ID: <20250915225857.3024997-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915225857.3024997-1-ameryhung@gmail.com>
References: <20250915225857.3024997-1-ameryhung@gmail.com>
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
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index fadf04564981..aa1368698a40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2016,6 +2016,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2069,7 +2070,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2085,10 +2086,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
 
@@ -2099,9 +2105,18 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+			truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) +
+				    (nr_frags_free - 1) * PAGE_SIZE;
+		}
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
@@ -2126,8 +2141,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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


