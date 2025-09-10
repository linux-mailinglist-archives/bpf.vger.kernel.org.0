Return-Path: <bpf+bounces-67988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC9B50C5D
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 05:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B4A1C62627
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAD26A1AF;
	Wed, 10 Sep 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEIcwdEu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E8140E5F;
	Wed, 10 Sep 2025 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475668; cv=none; b=nbGLh4BHI2RKLHE6Vbx9xmQrmUp6jnv7AIiU5bk+z5TyUu7JWKfY4PId0Ouc9k8Busufohmx+YvIAbxQianTke3h0rr6Vv2Q8XLn3gzt3t95RQ213pcWGIFxzkZBzTvrgBSuB+6lEdgRj+LYoWAZL5K0C7BEcNzFmFguCbNPs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475668; c=relaxed/simple;
	bh=UnIdQq7G+BVp/Z1SsHZauK7Tdpkmd0sDGf+N+6/eX/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njAQWqlGuZnblB6ahvQIx6gCMah1xK9KTZzNugSRbgc6Y4bvS+9YOzSAu9MXEzHjlviisF/GxUWEIeedxJ/xvBzb7TWuayZpb++4orqdsfW1aRdXr54YYIo+OFON1JYgSk3XTOxybCrVc4EDYauHFlQv+2Ruf5ssChm2S/+fpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEIcwdEu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b70820360so5068639a91.2;
        Tue, 09 Sep 2025 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757475666; x=1758080466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq9TvENOKVK+uTZlWssAoHWiNekvJW8vR6s9LI1bDYk=;
        b=nEIcwdEuOpWd1/OZE23U+K36SyX9Jh+Zrh26+8x28E3tRpT3dICrh8pTXXaIxrSc+U
         4w4mjOG3UOsa1U8AZgiJ4p0pcI1RsH3oQtbfb+wV6RC4OVOUyc4sVIZcvVSvd8THZd6o
         W9jxoqvYNmTZ5KoqQMNAnrN/F3XfYzGnziN4uFw+jZeDLk8v+O30fFOKcFE1o+E2x6hb
         VHlwMnKjSeaSklr2qMSuzuHjRikgLKk9fAaOmcGiIYzfqrD+YGZA7VHgdkAD4CTKuO8i
         nt3HMA8+GALihNI1kEyni3PB2jv1JsWdxxMCgpn7AyZ/c4fvYN+dg++6cmXcN8s+4u3p
         mBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757475666; x=1758080466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq9TvENOKVK+uTZlWssAoHWiNekvJW8vR6s9LI1bDYk=;
        b=uEPZcgZAHrZTs9r0n/F6HVox2R85rMc4jp5Fsr4OveWirM9ZNMa8SWpb/wh4ilJ+mA
         5AOOYFB8oxqIk1nnAQEgp52pk9+D95AeEHYAAtqdjfr/xHVK8eoUeeIi1hN83cJzPM6/
         U4BOgZytie50OsxGsOfPrXfz/k+lPFCf9DSuNQsqxCQjsMGGaWZ1+kXkWbP3u/A2beBv
         gvFdRctZU6KSoFTsBisuB+rO8Gv2OWvAfkMCZM4p+yspjUnhPFM+jpZuRfoCGmei7mFw
         vliRpUJrekMc13PHedSqShp1I8LCITDo4FwTggUezDSvVHVt/NRnyImYhEAKAscHy0M7
         SHag==
X-Gm-Message-State: AOJu0YwDpmortptsDhwI0HiCZ0esn7Pk6PSVDKaxCx0S9TSqB95PDHQ3
	PNc75712clj+5HAWADMNZY7BvbPIGJI8KKtSbHMghLUy7V1nnZZ96JY2QtTKxw==
X-Gm-Gg: ASbGncvyiju7mVsSiKeKVsmH9yISkFq4n4cDZLdEse2gP/5toqWnHieN3mETKZ59Z3k
	lxa/XyVyIlg4gxc2tgTrEjUlhbO/WjvldRdlWS1v98TvmqFxIEA8cnu5Z/E6jMxZxUezG9JqD4k
	JEjGwgaO2FbMPXSI1TOeq+23dZ76hQhk9RaLmrg3LzmyG3Ewy2BTNOMp4yH9sMN6jXa3nY1VlDW
	91DwX1pTAMOQ9osm7mSkc2X/7OrpNAsD/uK2QCOiGA/QXvnIjqhJ7PuCKyEKvrIyM9WQKV6o3Rn
	DhvYpIN+2F6LwkG/fZ1SzA79zzIcffxZBsRknGNNxfNN3ZvLFSEUFk/j2SUqhSYFiGSgsf03SRE
	Lb4tuSJv5/G8NG4YNpVpOGK6H
X-Google-Smtp-Source: AGHT+IH9cLw+W9RroiW7d5TDtd8doUeUAJjA5jF37tQClZxXdqb55nHiDToGVmlB98HzASjW3C3cdA==
X-Received: by 2002:a17:90b:280a:b0:32d:8eb1:4e26 with SMTP id 98e67ed59e1d1-32d8eb14e6amr11182711a91.30.1757475666029;
        Tue, 09 Sep 2025 20:41:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32da8a7db90sm1725922a91.1.2025.09.09.20.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:41:05 -0700 (PDT)
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
Subject: [PATCH net v1 1/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
Date: Tue,  9 Sep 2025 20:41:02 -0700
Message-ID: <20250910034103.650342-2-ameryhung@gmail.com>
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

XDP programs can release xdp_buff fragments when calling
bpf_xdp_adjust_tail(). The driver currently assumes the number of
fragments to be unchanged and may generate skb with wrong truesize or
containing invalid frags. Fix the bug by generating skb according to
xdp_buff after the XDP program runs.

Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the non-linear legacy RQ")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..1d3eacfd0325 100644
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
@@ -1772,17 +1773,25 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
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
+	wi -= nr_frags_free;
+	truesize -= nr_frags_free * frag_info->frag_stride;
+
 	skb = mlx5e_build_linear_skb(
 		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
 		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
-- 
2.47.3


