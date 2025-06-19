Return-Path: <bpf+bounces-61066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D317AE01FC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3557AF474
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564FD220F37;
	Thu, 19 Jun 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKt1VgKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35521B9C0;
	Thu, 19 Jun 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326426; cv=none; b=Ir+3VBuA7HZyYX5rtKzNcnMmipCge7zd//qCu0+f7WoeYFLLdNz82lnU0tOzoTrDWfDnDBGEc8TvlcFumMjgfV634D++cbIXvQlRkqqMqoMe7xNuVQidRXI5dj11so+InSR5OJDtcgXU9KSiWOCMBL6SsICW1vYA7xagyyTttGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326426; c=relaxed/simple;
	bh=jo4S4oP37pMlRWEMLh1A4wsCbWwOGpq0aSS3GjoaWMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7kqdneMVA2R7khvFzf07/P2oYUeaq520qFqvPq7gbP4G8ENJ8aImyO6zmBwvvXpi+hEdMG0kyrMVLFDD2rU/HozulMpl2Dh7LwOJCVwekSq16Yi67kvktDUEkWY2qZxKNtl0lQ7JsWtM+8jBJg3W+qa9W7CY+n5U1Hv4vhtgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKt1VgKE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4e62619afso81253f8f.1;
        Thu, 19 Jun 2025 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750326423; x=1750931223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wpyHDstt56CkQjT7Xqq7Dy0LffgxF5WyMGLP3dXWQc=;
        b=RKt1VgKEWiMgG7Ln7HQGPWN9fCRpkDYYda89yqwmpbEzRNtCGjYmwfsrIZpE1rsSkz
         LQ+IEPYUrM1qwIaXa8jOgSCy8WG6PZmtJIJDPP+HmU406pMPviyBmN7nt/L/ZO0q+mEI
         pEPc0ZKTkgEQUqoivQFZhiFqh6EzibIgtlKkfrizOcEAZxClqa6f3NCuRaWBBome8Ula
         81mqO5xuOvvTnwQVilu3TeFkn4nyHLQavMVPSaDiJjyzntP6Csz1aBX1rzj383rkf9Jt
         tpMbmOvn6wHWe0sMAsLoaRWP9u9DOCxje1rnnCyXVpDac5fFGt0MOgQzafMrwY4bsmyi
         NpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750326423; x=1750931223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wpyHDstt56CkQjT7Xqq7Dy0LffgxF5WyMGLP3dXWQc=;
        b=fMezlSQn/ksKuPIcmnLmyVfQDsgae3JbSjPoAv+qjZG9APO6yDTAkfg4HhUP/gTsyW
         LWHbj4pxr85LVNRZIAXJS4O4v112uBmreRrTcZPWfhh3YVJDgkhHQh/Rd0ribhRFtZ8r
         NwkHWFXmKesKjTDDXSLpNg4vRfAJQjCXn+nEyYJEcd5eu7znaiNiebHVOPS1k84iivUn
         dA6MA6bquJEoNSIopTy87pLTaD3S7llORsLs2UtPyY+mv3uUDiQu8zQffkSFxg9dpvml
         mTxmhC5hluYRUxIId/tFb74fVmllGb2zM2qJjyASi12MqBOMhEumdmnisPinrjsFyqtH
         DYmw==
X-Forwarded-Encrypted: i=1; AJvYcCVWeMD9u/YCE4R1fjb7pb1dM17IVUdh04jkKRnRqDQWlmhi8S0BUtCqjw1R7Cgm/oZmtHH98RpB80/omx+N@vger.kernel.org, AJvYcCVysFgtO5Z2d2fP8N7gTqs7g0OE9HCWxi1e8KUyH693wcSQ5XRen7/bx/+K91nH5Ou+JOIAC4Y2@vger.kernel.org, AJvYcCWt96fDRKxNfqNpPMZYW8xdthQ+uVb3pLb3lTczzxl6W1CLWliZJqnKaToNVbno4vV5z80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyW77sLlR7FM3U4n0X9vlBig7IwhIoE3/mpuQXi/avzdlm61K
	TGj4QVIWFCUdIDTxcKDWHpRI1q5j3V9etb1OY5XffwupNzQIWde9CLm7
X-Gm-Gg: ASbGnctUQuyjGucFZXaa9OX+r0RZksgx8ugDlxN6gTO6KdVsfW44UBGrJyayePGgpHJ
	j783nBGue+8YipTcxhYnlTW9HlwJNIEcVItu6U1M6fqcCJby8eqGxnzOEDRANAt5tVllDdQxdub
	yxk3AKmJb5k/xwfZ5/Azwr0TIcc8m23h5nbj+66yVY5HWPLI75jNsvyHNH1/3UcM0z3zJL+q/hd
	W/owQjzBtV3IPSidFSxWG6xPNOyKQmbE8TC+BJNCqTLV/LUAsbnG71n+/Dy7reBhf0ToOgQQgH1
	xZUt5jQIpa+J/ehJGtTWgo7a8TH3FnF4zbnhV4++dFNsUBSE+/YHnR7KWdDX2VsJspewb5Sh4J/
	KH4/TQv+ptLZg60RBmLLTSvAAuW385BLi9Xt2/OFyl0/ZvOZy3udQtmCDcNnmaYM8hpS0g9ZuXd
	o=
X-Google-Smtp-Source: AGHT+IEpqro60YlzzzeszDwSvToDBSiVTr/feKFQAwvdfZL6g25ljawMqwhjbgmAVFDKx/RglSW7ng==
X-Received: by 2002:a05:6000:1789:b0:3a5:324a:9bd with SMTP id ffacd0b85a97d-3a585f2ec3emr3358471f8f.2.1750326423230;
        Thu, 19 Jun 2025 02:47:03 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec3008c7e3874bfd786a1.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:8c7e:3874:bfd7:86a1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b089b5sm18825847f8f.48.2025.06.19.02.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:47:02 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Taehee Yoo <ap420073@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3] ethernet: ionic: Fix DMA mapping tests
Date: Thu, 19 Jun 2025 11:45:30 +0200
Message-ID: <20250619094538.283723-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change error values of `ionic_tx_map_single()` and `ionic_tx_map_frag()`
from 0 to `DMA_MAPPING_ERROR` to prevent collision with 0 as a valid
address.

This also fixes the use of `dma_mapping_error()` to test against 0 in
`ionic_xdp_post_frame()`

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Fixes: 56e41ee12d2d ("ionic: better dma-map error handling")
Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2ac59564ded1..d10b58ebf603 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -321,7 +321,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 					   len, DMA_TO_DEVICE);
 	} else /* XDP_REDIRECT */ {
 		dma_addr = ionic_tx_map_single(q, frame->data, len);
-		if (!dma_addr)
+		if (dma_addr == DMA_MAPPING_ERROR)
 			return -EIO;
 	}
 
@@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 			} else {
 				dma_addr = ionic_tx_map_frag(q, frag, 0,
 							     skb_frag_size(frag));
-				if (dma_mapping_error(q->dev, dma_addr)) {
+				if (dma_addr == DMA_MAPPING_ERROR) {
 					ionic_tx_desc_unmap_bufs(q, desc_info);
 					return -EIO;
 				}
@@ -1083,7 +1083,7 @@ static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 		net_warn_ratelimited("%s: DMA single map failed on %s!\n",
 				     dev_name(dev), q->name);
 		q_to_tx_stats(q)->dma_map_err++;
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 	return dma_addr;
 }
@@ -1100,7 +1100,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
 				     dev_name(dev), q->name);
 		q_to_tx_stats(q)->dma_map_err++;
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 	return dma_addr;
 }
@@ -1116,7 +1116,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	int frag_idx;
 
 	dma_addr = ionic_tx_map_single(q, skb->data, skb_headlen(skb));
-	if (!dma_addr)
+	if (dma_addr == DMA_MAPPING_ERROR)
 		return -EIO;
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = skb_headlen(skb);
@@ -1126,7 +1126,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	nfrags = skb_shinfo(skb)->nr_frags;
 	for (frag_idx = 0; frag_idx < nfrags; frag_idx++, frag++) {
 		dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-		if (!dma_addr)
+		if (dma_addr == DMA_MAPPING_ERROR)
 			goto dma_fail;
 		buf_info->dma_addr = dma_addr;
 		buf_info->len = skb_frag_size(frag);
-- 
2.43.0


