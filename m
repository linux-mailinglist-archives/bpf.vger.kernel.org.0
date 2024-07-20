Return-Path: <bpf+bounces-35175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC16938226
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C6B1F21826
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4041146A76;
	Sat, 20 Jul 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWG0EF1i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C62B2CC;
	Sat, 20 Jul 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721494015; cv=none; b=fD59GLOb7QnkVWuEJsiFo7D2DoeC9vcEv4of3IUG/iU0VJBRWHzKlkki6QJ5a5wt6uh8cIASVXy5gJ0oib0v+wng5+yyk7B+daUeyMEf6IdH0ar4lqUEBBeX1n9WMomAAq5jurxdMDYaw6lZokDWfAEeAYcJBCmLti1mattfya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721494015; c=relaxed/simple;
	bh=8dqSyfOZbflIwM35rZGKAyMZYEYJN0/dCBhKuEnbGMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHmJ3JzfRMpSlKBX9OAT/an7vwjWY7qiiQeQNA13779DjMYiuCYtWSDl4ih4qZeifsM81dRYCRjY6xOKgg3BByX7NK0NHMCs1vQHZT4oTGe7+hh+svoYkZ0gBuTgehtbK/81rDYf+3FtbRyYipq4JaebZRoo6hde0SqGj/iF5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWG0EF1i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368663d7f80so1252821f8f.3;
        Sat, 20 Jul 2024 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721494012; x=1722098812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6XmwiNF0U9ALABlmqNHLWtjd5nTEgsEVV0Hcqvx7zs=;
        b=dWG0EF1iI1d8pdYln2AntC1GftrEMe0CalfeYuhLScQRcSCHLbVEBg3qBoCWWa2Ozu
         PkW1/01eI/Tjm0bxkw6ZxZsbt2ctIDxkwCoAcPXo/cyTOFS6vqDYFJV2fNv3X9Brmqcu
         Q2+J4X9OGB19/k5gmxs+R59nxfp78AWe/yDMcbbzOZqRmDbOLCDPZVyfHWsw5EzRvzXW
         Dae9xiWKc9B6sDR5LakzwGOQNuRn67OCiFCa8sGMN+N9BLD5nrryxvVlhr5DuhNkCT1d
         pOg9JDzGnDD7uY1OEOjvNB+lLsPXWEtTp2euU6U778hwM5xqgc6MeccomyhErMRXxtVo
         /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721494012; x=1722098812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6XmwiNF0U9ALABlmqNHLWtjd5nTEgsEVV0Hcqvx7zs=;
        b=lbZkTWeNPodZvQH/nPLLsgeji33nUA4LpFIiBAultS0mnL6tDoUtjIAt8l7BCSPlo6
         G0JkR+Itg56pPgi7xc0r58Gwho8yW70amDUDV0sxZzge17xlvH3KRzyPD232ulsp1mzM
         TPx7gcZJgtWmzCgQaOl0erVYrz0vEzaifrk2TTGPmhl2z7MGuhP079q/0kPRcMvBFIgS
         Fg1Z+dIc1ZoB9055RG1KHLcP526zxKfuusE/HE8odznd4wfrzU22yj86MWiDziYmw7CW
         w3grrDm/gn7gNqLzYmizRr+xvmwgjIRtAeploY6wkOAG0mUQ9EIp8YyuQO3G8kxJf8hA
         tGow==
X-Forwarded-Encrypted: i=1; AJvYcCUwDWOe471GMctEbl7cOOfYM+QZAk6gGZB8OSn77OgglbSt+mqia02MuntGRNeLx+y7qPPUR9ZJB0Ov+ElcKorxI9ZySQb8jFRp6nVbbg/4d3uiyTvGS2O5LF+eurJl107nx5X/Kpdv+WllOakQjTRXxhA/2Vx6Hnwn
X-Gm-Message-State: AOJu0YzzFWyevaTM9Ui+urD6FcrgHX4667S/2KRKFd8BpTqM2bUlyVft
	ud6ylY2PQi5XcHAix84fGPviTv9md/6AYsScBSLxsDAg8NxjBRjn
X-Google-Smtp-Source: AGHT+IE5Pz7ugxkqfgR4dRjntSLua/ddvvNazQUyapOJH+FfafymKxtCwgQeo94JmRGb5cwc1ufI9w==
X-Received: by 2002:adf:a15a:0:b0:367:4dce:1ff5 with SMTP id ffacd0b85a97d-369bae50e74mr1120538f8f.32.1721494011616;
        Sat, 20 Jul 2024 09:46:51 -0700 (PDT)
Received: from yifee.lan ([176.230.105.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787eda2fsm4293616f8f.108.2024.07.20.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 09:46:51 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: use prefetch methods
Date: Sat, 20 Jul 2024 19:46:18 +0300
Message-ID: <20240720164621.1983-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize kernel prefetch methods for faster cache line access.
This change boosts driver performance,
allowing the CPU to handle about 5% more packets/sec.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 0cc2dd85652f..1a0704166103 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1963,6 +1963,7 @@ static u32 mtk_xdp_run(struct mtk_eth *eth, struct mtk_rx_ring *ring,
 	if (!prog)
 		goto out;
 
+	prefetchw(xdp->data_hard_start);
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -2039,7 +2040,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
 		rxd = ring->dma + idx * eth->soc->rx.desc_size;
 		data = ring->data[idx];
-
+		prefetch(rxd);
 		if (!mtk_rx_get_desc(eth, &trxd, rxd))
 			break;
 
@@ -2105,6 +2106,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			if (ret != XDP_PASS)
 				goto skip_rx;
 
+			net_prefetch(xdp.data_meta);
 			skb = build_skb(data, PAGE_SIZE);
 			if (unlikely(!skb)) {
 				page_pool_put_full_page(ring->page_pool,
@@ -2113,6 +2115,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 				goto skip_rx;
 			}
 
+			prefetchw(skb->data);
 			skb_reserve(skb, xdp.data - xdp.data_hard_start);
 			skb_put(skb, xdp.data_end - xdp.data);
 			skb_mark_for_recycle(skb);
@@ -2143,6 +2146,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
 					 ring->buf_size, DMA_FROM_DEVICE);
 
+			net_prefetch(data);
 			skb = build_skb(data, ring->frag_size);
 			if (unlikely(!skb)) {
 				netdev->stats.rx_dropped++;
@@ -2150,6 +2154,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 				goto skip_rx;
 			}
 
+			prefetchw(skb->data);
 			skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 			skb_put(skb, pktlen);
 		}
-- 
2.45.2


