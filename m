Return-Path: <bpf+bounces-65573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60AB25659
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AE21C804A3
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297D30E836;
	Wed, 13 Aug 2025 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDAk8/QZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E730AAB8;
	Wed, 13 Aug 2025 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123219; cv=none; b=OnjTbAFy7LvxV4oI+/3lKodL5ueLdWL9SpgGMbw7r0EP15fK57FSt9d//d8IUGbFcVrMgWZXwb6TlqY4vn8nLI6qSpe6siAVGK588Tz75HcEpAYETfahGrrAUjRt4SDwXm6ZIW4ZJzgKdRm8+RbLv9Ffh9wF55pxhml5PnZONcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123219; c=relaxed/simple;
	bh=14Rs9zHg4QyJJlrXCDIaH33G+iRF67OxQsjU8vdMJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHgXqS9XYlXvcTpFJh83H+kgTHb2HJWR9ymtsqcVqJ7QZ0Wx+H7jMTqq5iCqM+oifY2vFf4C4dunm1Tlwr9HVPvDMBvVe3jI4/9wVyBAicHd1wwSVpslxwzefTUonzNiMHV85DAufHeHkXhGwZ2oBzQI0vLVZKJx3tQW4kPfdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDAk8/QZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso240751f8f.0;
        Wed, 13 Aug 2025 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123215; x=1755728015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXGxGfMZImq48xpQEp7KdaMDkTKOy1FyiWgUccTmK/M=;
        b=UDAk8/QZh5eYXW6i8xtj5ZXCj1MutN6Fmk9oxx3tpycMbS3e9O4iqnaleVZSS3uA61
         13MMm4QzzVna3ZkJNL4z0QCax3YXqMLLXbavH6URdiPnueXKFkaNwkrbg1PLm1YSSyvp
         Wh+cBgn/Q9ndJS6yGQu6k4MCqeI7ZnUJACJ4hm9qVTK9B4cMCjR2cSJjDXFCjgxJLqjl
         w1m0T6rd+7z518xnJ+lX/rM4BuioMGN5wKHeDQKLyEW6oMDn28jdIn5eNnYxh9Q2zcWl
         oL6sJ6B805lwE2Vq3Osv5WuGSVbRJmIJpY++4ywmVcILk3iVlHaDQn6qlu60sNK0LB3N
         l4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123215; x=1755728015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXGxGfMZImq48xpQEp7KdaMDkTKOy1FyiWgUccTmK/M=;
        b=aABGpVtDRxoQx0PgMZ8f5ksQrsIz4huEgc9uUXtNct90OdvEIJcyHirOt05c8zvFiL
         h6O4zsEr3nQQcf1R4OiI1cjfVlEk2vHpD406zk/sBldX//zAp0SaNY0l5JUdMBbnEh7W
         plsAmNu8R4zAJVn72utYQIcSAvH2S89QFFset/bDnQHR9xDEvZOP52GcfMcjCu7/2Bbw
         yEffwvHL+aZPsiBUjP2gdE11hfvBTxJ90PNaQ6yWeClGh2KYTMkQVcbr2f48kgSNyz5y
         QVe4yrJUJgOpfoEMhsy7Wuq3oZ7O7OYjkQLb0eEvwMvEnGoupzhfJLFGTxjlKDmSe8XP
         6c6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoBOv4RpVVDeiLO7khgp6vK0suqPc/LAXovfzcCkYm1/EG9Bvz46PzWiQSYpFnTY1n9Vw=@vger.kernel.org, AJvYcCXN/N/HdGC8S4XPXQJU0S13nBPs8j4NfnPtTpkIzwDy3vdOwYF3uJQuf3XNf36HCp3+T/95KoBgQu25i54M@vger.kernel.org, AJvYcCXZyzSIZ3ePt1x7azl1FRPry1t2TiU/G0MNJbPSHUtBlfo5jocFW9QTwNCvtY/p7Y0+70swuu3BSDfQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ81aB5fHNbJhn8UI6MiQKuEKcMQ2QD1bcIbOna2UKT6+TUbeD
	5Ioqb1xQAeTEw48obIskiSZz7XEtQ2IRMHhsCa6pRXaUmYkad3Z0/Thh4aiFgTK5
X-Gm-Gg: ASbGncu+27dlmDTmMioLCrxhAbyBp+WpwMhyFNeBO5nR88cDzRcbTtJmm7ND0YS82KG
	/OMEDNSI/rPTNFbP8X3hWN1Aeb1OYABlYd5BdRwe2YgMdagkW2zNGDSzyOCfwA0m/vz4fmfNP/6
	el48I+Rtqza1Uxz6gI6kbgMqYRuxdV+uPTC5GE/VJd7xIX46ZH5j1Q+BMifzKNttHEgxyZvmwdF
	2crtoD3/dVzS6OmqekSv3BN+G5DkeSG+aNvXOMhpSzi8+WU6Us1/dj+rKDWS6bEyxGkl4e5cOzo
	n1ovyB/xrlPKvwFJ+tWRjMxVG2ZvjX63V00M+RJsvs8SrfAsO80OZ/+2TWuZ9DbC0P+eMqxa5tG
	Sw3ANxgQb5mHoYyAQVV97wNzD
X-Google-Smtp-Source: AGHT+IFVKxwpknkJMwJp39+E2cpeTEbHUO63EDnfXbOJaqCPW5YMugfnoQbe1n9vLbpVGJlj05LG+Q==
X-Received: by 2002:a05:6000:26c3:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3ba50d6364dmr167421f8f.29.1755123215425;
        Wed, 13 Aug 2025 15:13:35 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm49900361f8f.4.2025.08.13.15.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:34 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V4 3/9] eth: fbnic: Use shinfo to track frags state on Rx
Date: Wed, 13 Aug 2025 15:13:13 -0700
Message-ID: <20250813221319.3367670-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove local fields that track frags state and instead store this
information directly in the shinfo struct. This change is necessary
because the current implementation can lead to inaccuracies in certain
scenarios, such as when using XDP multi-buff support. Specifically, the
XDP program may update nr_frags without updating the local variables,
resulting in an inconsistent state.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 80 ++++++--------------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h |  4 +-
 2 files changed, 26 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7c69f6381d9e..2adbe175ac09 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -892,9 +892,8 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
-	pkt->data_truesize = 0;
-	pkt->data_len = 0;
-	pkt->nr_frags = 0;
+	pkt->hwtstamp = 0;
+	pkt->add_frag_failed = false;
 }
 
 static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
@@ -905,8 +904,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
 	struct page *page = fbnic_page_pool_get(&qt->sub1, pg_idx);
-	struct skb_shared_info *shinfo;
 	unsigned int truesize;
+	bool added;
 
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
@@ -918,34 +917,34 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
 				      pg_off, truesize, DMA_BIDIRECTIONAL);
 
-	/* Add page to xdp shared info */
-	shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-
-	/* We use gso_segs to store truesize */
-	pkt->data_truesize += truesize;
-
-	__skb_fill_page_desc_noacc(shinfo, pkt->nr_frags++, page, pg_off, len);
-
-	/* Store data_len in gso_size */
-	pkt->data_len += len;
+	added = xdp_buff_add_frag(&pkt->buff, page_to_netmem(page), pg_off, len,
+				  truesize);
+	if (unlikely(!added)) {
+		pkt->add_frag_failed = true;
+		netdev_err_once(nv->napi.dev,
+				"Failed to add fragment to xdp_buff\n");
+	}
 }
 
 static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 			       struct fbnic_pkt_buff *pkt, int budget)
 {
-	struct skb_shared_info *shinfo;
 	struct page *page;
-	int nr_frags;
 
 	if (!pkt->buff.data_hard_start)
 		return;
 
-	shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-	nr_frags = pkt->nr_frags;
+	if (xdp_buff_has_frags(&pkt->buff)) {
+		struct skb_shared_info *shinfo;
+		int nr_frags;
 
-	while (nr_frags--) {
-		page = skb_frag_page(&shinfo->frags[nr_frags]);
-		page_pool_put_full_page(nv->page_pool, page, !!budget);
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		nr_frags = shinfo->nr_frags;
+
+		while (nr_frags--) {
+			page = skb_frag_page(&shinfo->frags[nr_frags]);
+			page_pool_put_full_page(nv->page_pool, page, !!budget);
+		}
 	}
 
 	page = virt_to_page(pkt->buff.data_hard_start);
@@ -955,43 +954,12 @@ static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 				       struct fbnic_pkt_buff *pkt)
 {
-	unsigned int nr_frags = pkt->nr_frags;
-	struct skb_shared_info *shinfo;
-	unsigned int truesize;
 	struct sk_buff *skb;
 
-	truesize = xdp_data_hard_end(&pkt->buff) + FBNIC_RX_TROOM -
-		   pkt->buff.data_hard_start;
-
-	/* Build frame around buffer */
-	skb = napi_build_skb(pkt->buff.data_hard_start, truesize);
-	if (unlikely(!skb))
+	skb = xdp_build_skb_from_buff(&pkt->buff);
+	if (!skb)
 		return NULL;
 
-	/* Push data pointer to start of data, put tail to end of data */
-	skb_reserve(skb, pkt->buff.data - pkt->buff.data_hard_start);
-	__skb_put(skb, pkt->buff.data_end - pkt->buff.data);
-
-	/* Add tracking for metadata at the start of the frame */
-	skb_metadata_set(skb, pkt->buff.data - pkt->buff.data_meta);
-
-	/* Add Rx frags */
-	if (nr_frags) {
-		/* Verify that shared info didn't move */
-		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-		WARN_ON(skb_shinfo(skb) != shinfo);
-
-		skb->truesize += pkt->data_truesize;
-		skb->data_len += pkt->data_len;
-		shinfo->nr_frags = nr_frags;
-		skb->len += pkt->data_len;
-	}
-
-	skb_mark_for_recycle(skb);
-
-	/* Set MAC header specific fields */
-	skb->protocol = eth_type_trans(skb, nv->napi.dev);
-
 	/* Add timestamp if present */
 	if (pkt->hwtstamp)
 		skb_hwtstamps(skb)->hwtstamp = pkt->hwtstamp;
@@ -1094,7 +1062,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			/* We currently ignore the action table index */
 			break;
 		case FBNIC_RCD_TYPE_META:
-			if (likely(!fbnic_rcd_metadata_err(rcd)))
+			if (unlikely(pkt->add_frag_failed))
+				skb = NULL;
+			else if (likely(!fbnic_rcd_metadata_err(rcd)))
 				skb = fbnic_build_skb(nv, pkt);
 
 			/* Populate skb and invalidate XDP */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 66c84375e299..d236152bbaaa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -70,9 +70,7 @@ struct fbnic_net;
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
-	u32 data_truesize;
-	u16 data_len;
-	u16 nr_frags;
+	bool add_frag_failed;
 };
 
 struct fbnic_queue_stats {
-- 
2.47.3


