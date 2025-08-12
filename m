Return-Path: <bpf+bounces-65461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDBB23B8F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE927B09A3
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8042E5431;
	Tue, 12 Aug 2025 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBiy9oay"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1272D9ECF;
	Tue, 12 Aug 2025 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036130; cv=none; b=BTyah2dOLafcGBdG218U1sSkQklYcYeumCKUVzo6pKv+coIgqKcEkW3HtdsCewQLRsdrvHpnxFcpsa66DKSYanNFf3T48FKjUqA2OoVHZlxBEFYX//j14Q3JwHVMrWSarHyJUJLzdUYDHK2YoUcCRMs52MKS3WWqdHoYmacwBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036130; c=relaxed/simple;
	bh=14Rs9zHg4QyJJlrXCDIaH33G+iRF67OxQsjU8vdMJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw7fHPnOGEIRwX3gWfcSslIFmBjlheUSaT2yN30cWYMJrPLapIcz/DGnSqqQU/B7X8M4GaKgi7KRmPMGxJDao8aqbNjHtfCAvKE9/wTGLlWLnhnamyqZJsX04M8G9jAzFdqhZ7phZthztRI+xhtYcIRoXoi2wu2v0UPUie0P92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBiy9oay; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b914186705so606743f8f.0;
        Tue, 12 Aug 2025 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036127; x=1755640927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXGxGfMZImq48xpQEp7KdaMDkTKOy1FyiWgUccTmK/M=;
        b=SBiy9oayQA5aPtptex/4L5U+Z8bVc+2OlCHz3eT/C/zvVa0RYWsQ/oDY/cdHO0K32U
         hy3pH78wCo2noGBQaQBuexO4maEWxjOM3kYgg877Ag7UGjOVB0x85j3817KqbKTMQMli
         jp4bIxP9/MoYxryGomDugiz0u2zyo1vrZo9GJ/zeuaufPc/zO6gH7RgEVWFkk5jok7Gf
         lNd/GqLWBJnDVNzFOGxLRKGCik3kOzRrxS+p6GeB5vVN/qSs3fcCTedOoEAUEQrUMk6A
         uXbX7IcGe+uYEfJ0YX/2ZwYljhD9qRqrkmmM8EJ2jJQa5nEfJe2R1+k4JI2zOMu6vf0+
         1rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036127; x=1755640927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXGxGfMZImq48xpQEp7KdaMDkTKOy1FyiWgUccTmK/M=;
        b=nwTzIhdkn3PcxkKKgM/juRjAhXdtpftZxesuj8hXjmGk/UzGccHa7G0L4mXyWJ4Ne7
         4Dqj0hDhqSkfLUs9UzfOB1ya36UE3m2yfNESLecdehFBpQRmg8H6JMH/fw5p/JHEY85h
         jRB60X4nDP9KgA6mGf4GErcB75Bt+kC+nAtB4d/xqL+iSYDBfHNqnnRDf2H0rwLA0qrd
         WCGkergZmJqaQztt917QMH92zjeGYIixKHnFpS9QquVBHkgEekcPqpTEG/Ew0htuqT+8
         VtjISTqOiWV1RWsAGrVoXMZcq5UrIM8qtR/RNwRAXK2pGvRYOoI8nvVkFPorrKf2nFK5
         7CKw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7GCx3aFgptSjmQ2nr7RcoZYxaJS9NQA2BQObGYg9pKWAU7i077qGwUr+Gue86VvLmUG9XIaSMhCulvri@vger.kernel.org, AJvYcCWzszr1Oil85QZdlUuzXVuDnqWrS1q2XJl17PfbGPdXZMsjMUVLtPbpO1ITFcJIh7bMxIMC2w4kM1i9@vger.kernel.org, AJvYcCX/1pcYmIT3Dr/SIgWtd1t+VPArMPwMpnsRDac5OIbLWTAmvnSVadmVYLLpZOf9csRhaOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyabbMryRJ3OjuXyl4tQa7qqzOh+5W/0g3tymCBLZp7VkG3Qwqp
	B79LfNxxrqAK1Q38FCrVNTZ2sJXQ010VQtwJw3ghuF7EjvJLamPRC2LUfDDPdxUw
X-Gm-Gg: ASbGncvPuu3HcFIp78Pr0tiPfFxabmlYOi4tcZZR5tTgMd7pBRB7GDrZwaobjudFzRZ
	VZz0eaKkGLc/6l1nU2xbn1/AXq/GGyHTp7uVkIyxLXjiaJFZNZDhm9Hw2Dy49Qad6G1ByYdO3DD
	yTaO4+3vFEAgD58QED84eqfYdlGxJdUcFWHmiik/zDaPSDkqFl6KX4Ma2ogIyV+SDXVNF+Bdt7F
	aOGfezwgVjP8+EZ3DJ+AqCKSItK+wnGcwjKUunt+VZG+nrkY7xxoUyWQSsszo18+QGYsHDOyvUx
	JXjMxo5xgkl1/fJYcEUo6z/J1Fg3aWhX0TH+AA/I/KoNeHaqURUSFJL/yzhH68gkZAWboA/CR0G
	wIMS+/9C8C3JQNsCKBYA=
X-Google-Smtp-Source: AGHT+IE1eFrFWI41ShdEyS5u3/rwanCB94CukprRy2jfe1vfPstlPuhnnCrDpxJ1J9wOgTWV4VjgRQ==
X-Received: by 2002:a05:6000:238a:b0:3b9:1697:75f0 with SMTP id ffacd0b85a97d-3b917edccd2mr364804f8f.56.1755036126820;
        Tue, 12 Aug 2025 15:02:06 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm47439921f8f.8.2025.08.12.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:02:06 -0700 (PDT)
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
Subject: [PATCH net-next V3 3/9] eth: fbnic: Use shinfo to track frags state on Rx
Date: Tue, 12 Aug 2025 15:01:44 -0700
Message-ID: <20250812220150.161848-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
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


