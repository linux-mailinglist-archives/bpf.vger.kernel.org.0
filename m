Return-Path: <bpf+bounces-68453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4282AB587EC
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04CB1AA7D85
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D012DAFB9;
	Mon, 15 Sep 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS8kWx0w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EF286D60
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977142; cv=none; b=lDx2ugUFiI4OZPNN0wwe42P7UmG26l7++gd9OLbUwAvl1aiVwNmA0rTk1CyPSzmjIVwySAMSFN9cmIGSE0ByHJ/MpV46VhEWTQxkPm/9gOPZ0waHEZFZ/Qg8uajzRhh8GslbK6/P+jY35kzJaWMZgxRoS9rdJlEIlg/AaqRXBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977142; c=relaxed/simple;
	bh=oJxZ0LJpiaRLyNvWrHRBYmWKDR9q/SiCzqlMoBmKTwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUVFyJDjoqBTNfsja6UL5QrEU7Yq/YfY+pVkP2pElMTzO0VZ0ADG8D+2brDVuUdJxm6uEUaerhz7fgN72zH5anzGeS9+0SJAw1ITb5T3WvWSgpkc8HzJpAFj2XFwRByMSsXFIrXSvhOuesHWky/KmSXqU2NT1KtnxpY7EeFjcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS8kWx0w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26060bcc5c8so26900305ad.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977140; x=1758581940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFpvUejFadK36BdJ1wBmBitmXKjhSS9UT5HZga+oq7w=;
        b=HS8kWx0wPjbHaSyyeJy6eqW11F/0cDcbbo8+qhOWpMSaIFgdyyrSSeeq+fhCbx8rhD
         8M6zFeMkFcxXlqCL0dHNBf9r++MwZs3rdsbf60/0IIL1FrrZaZ7cWzgNRzf6E84ejxwi
         jPT/PEfcjCH1ow5F7t7HeXTD/uLngPREJNoePmGZgvdsK1IJInsGa/lh38EG7Xal73/i
         6zq2VTBB0HIhXFwReLCMduHqr35VwaTNLS7otGLjxW03Fj88L7nViKxdhzTst3kf8YHX
         OWOxvD/BllZXl1kNXW8gPx7DKLgJBvRhRC/DmLi5C8uEdFx+kNjOEOkLl6oBXmDYt7y+
         SKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977140; x=1758581940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFpvUejFadK36BdJ1wBmBitmXKjhSS9UT5HZga+oq7w=;
        b=Z0Yvvkn6D+sH0fzLkI/+EKicKX0d2p9zMleCyQjcRAbRksU2jz7z3OWRxDlgs2rYmi
         AE0lpZtUuvBqnI8kURBxZ6EppAMLd/pbIkL+MQcWnrGagIJwvwk0Kx4R0b+VODjJUOx5
         nENlYB+Gc6/z67r7ECGLzh1T8Qz7LYLW+TloZl9JQveUn44vXN0YN4ujt4sW4KVwr2IJ
         4K3hSbPgLehWZMkHB3SHnzhrUbOpTsIJXKk4u1Srji33yj2s3xR2zKYZiBU3ij37W0Ow
         lqUsYNkDZPBQWNV905adVT5DlUPzi8sEueQJ+ULZEKE+SpHUwWzA0JsjF4nX2mk4bSJG
         pdIg==
X-Gm-Message-State: AOJu0YzFm2yadXA+eyhssXhlh9NcviHkmU2bOKGp5lemqa0SEhLIXMKy
	E9UJGhd2Rb4IhKAmds7ZX9hi6ISfYZnpFsY/Cyzv/NsIogGCI2caOJL4
X-Gm-Gg: ASbGncsUcw3mGYznTyRFZJmcZBQX9V+c/p+nBABJxIQd2aYUpjJmOhGt4nhssTHd8eS
	pEnenYxmioWOl9dvkg8u2es64g8PUu30VwGWcGwjNcPtRTkVnPiCAZ9fas1eYiu0yBaU3OhfNsC
	+AZqXB0PFcZS+cpO1BxpByXLhGvkumIdP9iXnXxSfhxhvWiMTH/VaOLKk2GnOHCSCExed6b/ZUl
	Sfi1bML5GwqHHeKjIEshjKW9zZ/XyLxYNtEbW9pDSol+T2g+zvx9c0ExXRwHebjt4yhSXs4x4/H
	jzN5mlB1LwL/4q4Kh+3lrqxQ57cPYtXNrutgoaxRMatAaMYgFPWs8V9Com5R/XhO4TR1zNGQmCb
	7d9dF3kgliUG//gtcy9Ji2Cg=
X-Google-Smtp-Source: AGHT+IEXQ0S8aPcKl1Zt8DDOYbgd6c+4EMejzZmAL6ZqpmLq0pwFmRt8DDQ5wktIjHik9QCXPh5Bcg==
X-Received: by 2002:a17:903:1a26:b0:25d:d848:1cce with SMTP id d9443c01a7336-25dd8482072mr164256295ad.19.1757977139904;
        Mon, 15 Sep 2025 15:58:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-260e10401ebsm83673445ad.91.2025.09.15.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:58:59 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
Date: Mon, 15 Sep 2025 15:58:56 -0700
Message-ID: <20250915225857.3024997-2-ameryhung@gmail.com>
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

XDP programs can release xdp_buff fragments when calling
bpf_xdp_adjust_tail(). The driver currently assumes the number of
fragments to be unchanged and may generate skb with wrong truesize or
containing invalid frags. Fix the bug by generating skb according to
xdp_buff after the XDP program runs.

Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the non-linear legacy RQ")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..fadf04564981 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1773,14 +1773,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
+			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
+				struct mlx5e_wqe_frag_info *pwi;
+
+				wi -= old_nr_frags - sinfo->nr_frags;
+
+				for (pwi = head_wi; pwi < wi; pwi++)
+					pwi->frag_page->frags++;
+			}
+			return NULL; /* page/packet was consumed by XDP */
+		}
 
-			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->frag_page->frags++;
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			wi -= nr_frags_free;
+			truesize -= nr_frags_free * frag_info->frag_stride;
 		}
-		return NULL; /* page/packet was consumed by XDP */
 	}
 
 	skb = mlx5e_build_linear_skb(
-- 
2.47.3


