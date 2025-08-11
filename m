Return-Path: <bpf+bounces-65391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321CFB217A9
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF417A8905
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5580E2DCC0B;
	Mon, 11 Aug 2025 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8w0cmd1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298F21FF53;
	Mon, 11 Aug 2025 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948988; cv=none; b=WM+6RF+8PwvTDLpcfkUAHVk/XCR8UfaLHPlbDb5iU3eWNsxfQZ/WTpBtnA7xkHwlTLHlpba2UwxOMjt30TTTbP8Nf5nFW5TvPlBNcKf1IoiIMMyP96Cm+Xr9mwX7DeMqlTd5h0mumz9dAZ1f18F8wSaaj3KhamLcT3Z84DE16fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948988; c=relaxed/simple;
	bh=iKAPa7ekbpFpk5BqmsoUT03OQFiQWLBw9upJTqT6Bt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KleHlujgb1angRaXcQt4zI1+G5ALDWTFyftQYHUyJExR6JrNPYzNKatA9r0zlxbzx24aQs8oRARaIQEE3ZnFI/ckhhQNV5/Gm2Q9yvLzumGDBnoyI8Pds8he11KDBxXUXpzJBCzeIL2ehAvGVvbh3N8PA44CfZCu/uQcHvENDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8w0cmd1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so2889492f8f.2;
        Mon, 11 Aug 2025 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754948985; x=1755553785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ribG41vgVNpaISWAFmou7/3xELnJxrsnPd0h2YITzas=;
        b=J8w0cmd19XOOEKepFaM0e1QDggbgSrkYldQUoEWFpJlHkv4MiLyxC31Ghqq9H1XTS6
         1PqQrn3nDjx3GOl+HLf+2gjBeKSPxOpW8PXKFCCCmMrfaXAnler3m4zNkSKbtKdCTyl8
         hh4t92fd/QJ0I9rUnMMkWlmk/vTSS5KjZp8UKcIr1jabtP4hTZL5MmEGOo0M06C70/0l
         WJbl5z4+UQdY4paIuqvGgav3TTK5fXDvujWJp7+Y8pCuZniilPR2eTNM1Mgf7RZjcSx9
         7yDYsoP4BxsvaMU/DjHOOsTwRLlcXV24iR4U6L4CpB6iQ/beAfiOZ/ntlO2qyMc3DOZ9
         Gb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754948985; x=1755553785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ribG41vgVNpaISWAFmou7/3xELnJxrsnPd0h2YITzas=;
        b=LCb9bMxa6bi1H4eQbY/yVBN7eX2u7oJp3IQuXRhWq6/isdmaZw0es/OmrIKLGoOLvX
         /9fu3cAPfyT9so+6TjJl4JE1SEXaEHlwmfoUzjahzFuHZLXLEMqUCob1BvN3YHDp0gK3
         kRhBdByCn1qUzb3/QiF8yXmeQwC5hGPIq2a8ABV2CjzYLliXIh3WaX/wMfQr1XIL7BSw
         LH8Nz7U2XLCvUaH+weX4FuPnS39Dr2L+qZWjI9pMZ6dJpHODu3wpfLzUP2bx+0mu93A7
         /uW/KWuh2kDYUXuUlJCsNGg0oILkPNxoqECTWrBT1FlCwf3oxgzqGFf8hu2KTpgiTn4E
         vw/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtK0pv/U4nUVuV1aVAyCPJOMPrbA7dvwfdoLztjUKj+sU2AAyysbfyYsZq5vcIT8b5nn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysG5tTSeZJVxRVUGUwXBvLmOkKoP7F24Tac04dVfNll440g/vJ
	GECJvbSCfAWbobA1jPBW0QIGwonHA94hq/QvL4t2DxuC7dUwV/9MH3IMYPJqvatJ
X-Gm-Gg: ASbGncscnJL8sDPRkyae9Uhv5jG59II8mFh2gGKj6k393o27fsdTCngQoDKObh0j1tn
	qPY3FJfe85/gijo2zJ9AeE5KP9Z5pTZ/T3END7b/EF1cjidKduXuag8Xw/5u87wqZu/k30e5+dW
	pq2YURi1qnAg6N5hH3ka5+RDZM9j5qNBO0ehc/0GIXU1X9gOA/mzGBJcoJJlk6dhr9+nvh2uaEt
	iso4QUzPdPiRIn9QlAlHl+BhEHUVQp+Td6My0RG+fw6xHCFCw7CYcMy5hCbAjgXQGgHOEzlwc+4
	sthASbML9r9NDpIdQ0OMYD+qTXuOnHJq3Bpg6By/DffhQAH+Cajjql/HZIsNvIuMBlJUzq9lYE1
	PMvGozOBjyvOxnxt1bYU=
X-Google-Smtp-Source: AGHT+IGXdjSNy/Sgt52pQ6Y8/H+kBsoddKLvdFmKN0iXa4Qz3oV6+FlqdCmdSEAk1ydMTb4eeWohqA==
X-Received: by 2002:a05:6000:2f86:b0:3b7:9b4d:70e9 with SMTP id ffacd0b85a97d-3b911032da9mr831757f8f.43.1754948984468;
        Mon, 11 Aug 2025 14:49:44 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5b84674sm290271575e9.30.2025.08.11.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:49:43 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
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
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 3/9] eth: fbnic: Use shinfo to track frags state on Rx
Date: Mon, 11 Aug 2025 14:49:35 -0700
Message-ID: <20250811214935.1030938-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
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
index c80cbde50925..819234aa5bd4 100644
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
index 2154a9aac3a7..0260d4ccb96b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -69,9 +69,7 @@ struct fbnic_net;
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


