Return-Path: <bpf+bounces-65395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7BB217BB
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905C02A83E9
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756912E3B1A;
	Mon, 11 Aug 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOVmz6gH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685322DAFA5;
	Mon, 11 Aug 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949369; cv=none; b=K5yjwLl5K+E+hHWh4dHya5ifAqlBCSnCCrExcsrz+r/cvPqvE4aXThWGEP1BeohcydxIjldDbzvxAXUXW8DQJbn1jG38dkdPGsoigPLnpizsSaPDqkQdIfawmrg6Z6ZNuoKztWV88jg49x18pNI736yoeXN4AjmpahidNxELrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949369; c=relaxed/simple;
	bh=flse8C7uVlJGNMHgx3hdCDLEA/rnKbyP7wbSr47U2/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyJO3INvzAC9fjCJfLTsQefgX9dOxMO9pXQP1vACK6/2/rGYjnQZ9JGO5uqXdQ/mw09nGjXRHteWgHmIbaD6eazovjihxjpFdXNpgwvJXXa1Xbf6XID2EX8NrlbEuEElHj9yUWBRTfpsUcTlE2zNliXf8KXO8Wi0uvmjKuqMYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOVmz6gH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so44775675e9.2;
        Mon, 11 Aug 2025 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949365; x=1755554165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/JYPERbpcqe61m3LXjYRwwRFSGhmDVH8rlGdcfhXY=;
        b=GOVmz6gHYwGBRE/vbIlvAefuIFC4xACrGzDw+pXRUAaOgH8GMYPOhAJMIek5JcT0xi
         uCWtj9e1pkPrXXjD1OEMmScVVM+Hrb+VGgoDzp4Ajk+EIiPS519if14g12PyLO6zAJk4
         ZjwBxyEMy3LEyjhablHQyyfTlqsScEFBrSR5WHOt5V1Xxew3a9PlcD4RZg9B3L9dwddI
         Hf8CDXMY0JeedX48DNgCoRCmgmuUOeRfBoZeRtkH05HZ1aT8hMdZhSTC+xUyZkCqM0TD
         vFi4zvSdIMeRVVfsmRW5MohYPU/PYkP8dD5IWf2/Iy26gwSVQ0XdKty8BnIfmGgIQfmw
         kw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949365; x=1755554165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt/JYPERbpcqe61m3LXjYRwwRFSGhmDVH8rlGdcfhXY=;
        b=YGpbaVvJ+XydUGPy68vT4BUUTVD66puSjvU8FTKU72lEIO6/4kvpU4utlErv6rmSDo
         pc4ljqDajNkatfMveu/SHarulqFeHvPy4Xz84GloMolbT+IBJSiCzQwbK2f7SH8r5m6N
         6PitCKJnhmtw4Jea5IQdjfFTPnv5Sa7iJYNq6jN69IzSbmLYEiHo+VSf879YXBeh73Tq
         71ksIgmf7k54cadhHEdRVTVcyeOqAjZibYEHWww9cg8rCodf5dEWnFBCx+Rk4FbLNw6v
         6n3c+RuLf9944ez0qthHJAUG1oGIBYxmnZ5EQysBvRu1Lvsi0WEAH3HwdPOe20Dstq7h
         safA==
X-Forwarded-Encrypted: i=1; AJvYcCVdthGU4j/Ude4p6pD8bIcE8tdYWQNu1vJmVPjyaTitE1lTVsBWz1tP1bfUL3Ww4ZNZPr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IrkfbyioIGZ5ln+as9I/BIvQHjLGGPPn12KuKITXveFOf2OI
	Z1oABkFuvkPg3y1On5wEGh9BQUp83RCg1BAgW/5RpnMhhADQFM83I9pe9USfnUGT
X-Gm-Gg: ASbGncvnDJlhel0COiOITW/IWGSP4dpg20tev1dig2x2EFDEmfq3MO6KZ3bHUWmfFUF
	ddiT/ZQRaOOhU5TvmySTAsIF/H1RYhbpMQA+b6x+jSbfC/5EuzHlcDIr/WhE70I93MYWsHhQHV+
	9acCiId5Q5JoCRo/Hvs/zegagT7kS/9fgyubPT4RpuT1t5X58KJ+SJt3uWmRZN1CbL9oRr7HJ3P
	CRvUdnZ07OYOFgrnqCv3JsUPdg7TnKjLynV6idE85p4nY1qxlUnfICPUW2b4h+8Co8RM3sjCowU
	O6ASp7sW8i6rG25YSR4yxGrXW0U0V5Erluk+b385ngeibClgOxPJn1yyRh+w+vPB2/HhmubVztS
	CWxWADlY8qkesVikR
X-Google-Smtp-Source: AGHT+IHhiOshWcNQIcVPhgtHGKaMPHz/At/HJitahWN0jUUEFA1nn/h1KOdC8IkQMGTV4uoOklKE9w==
X-Received: by 2002:a05:600c:609b:b0:456:19be:5cc with SMTP id 5b1f17b1804b1-459f5935436mr150987275e9.14.1754949365394;
        Mon, 11 Aug 2025 14:56:05 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abf0csm41081936f8f.14.2025.08.11.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:56:04 -0700 (PDT)
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
Subject: [PATCH net-next V2 7/9] eth: fbnic: Add support for XDP_TX action
Date: Mon, 11 Aug 2025 14:56:02 -0700
Message-ID: <20250811215602.1060434-1-mohsin.bashr@gmail.com>
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

Add support for XDP_TX action and cleaning the associated work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 85 +++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index a12f39f2a959..9b63311982bf 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -19,6 +19,7 @@
 enum {
 	FBNIC_XDP_PASS = 0,
 	FBNIC_XDP_CONSUME,
+	FBNIC_XDP_TX,
 	FBNIC_XDP_LEN_ERR,
 };
 
@@ -1020,6 +1021,80 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 	return skb;
 }
 
+static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
+			 struct fbnic_pkt_buff *pkt)
+{
+	struct fbnic_ring *ring = &nv->qt[0].sub1;
+	int size, offset, nsegs = 1, data_len = 0;
+	unsigned int tail = ring->tail;
+	struct skb_shared_info *shinfo;
+	skb_frag_t *frag = NULL;
+	struct page *page;
+	dma_addr_t dma;
+	__le64 *twd;
+
+	if (unlikely(xdp_buff_has_frags(&pkt->buff))) {
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		nsegs += shinfo->nr_frags;
+		data_len = shinfo->xdp_frags_size;
+		frag = &shinfo->frags[0];
+	}
+
+	if (fbnic_desc_unused(ring) < nsegs)
+		return -FBNIC_XDP_CONSUME;
+
+	page = virt_to_page(pkt->buff.data_hard_start);
+	offset = offset_in_page(pkt->buff.data);
+	dma = page_pool_get_dma_addr(page);
+
+	size = pkt->buff.data_end - pkt->buff.data;
+
+	while (nsegs--) {
+		dma_sync_single_range_for_device(nv->dev, dma, offset, size,
+						 DMA_BIDIRECTIONAL);
+		dma += offset;
+
+		ring->tx_buf[tail] = page;
+
+		twd = &ring->desc[tail];
+		*twd = cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
+				   FIELD_PREP(FBNIC_TWD_LEN_MASK, size) |
+				   FIELD_PREP(FBNIC_TWD_TYPE_MASK,
+					      FBNIC_TWD_TYPE_AL));
+
+		tail++;
+		tail &= ring->size_mask;
+
+		if (!data_len)
+			break;
+
+		offset = skb_frag_off(frag);
+		page = skb_frag_page(frag);
+		dma = page_pool_get_dma_addr(page);
+
+		size = skb_frag_size(frag);
+		data_len -= size;
+		frag++;
+	}
+
+	*twd |= FBNIC_TWD_TYPE(LAST_AL);
+
+	ring->tail = tail;
+
+	return -FBNIC_XDP_TX;
+}
+
+static void fbnic_pkt_commit_tail(struct fbnic_napi_vector *nv,
+				  unsigned int pkt_tail)
+{
+	struct fbnic_ring *ring = &nv->qt[0].sub1;
+
+	/* Force DMA writes to flush before writing to tail */
+	dma_wmb();
+
+	writel(pkt_tail, ring->doorbell);
+}
+
 static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 				     struct fbnic_pkt_buff *pkt)
 {
@@ -1040,6 +1115,8 @@ static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 	case XDP_PASS:
 xdp_pass:
 		return fbnic_build_skb(nv, pkt);
+	case XDP_TX:
+		return ERR_PTR(fbnic_pkt_tx(nv, pkt));
 	default:
 		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
 		fallthrough;
@@ -1104,10 +1181,10 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			   struct fbnic_q_triad *qt, int budget)
 {
 	unsigned int packets = 0, bytes = 0, dropped = 0, alloc_failed = 0;
+	s32 head0 = -1, head1 = -1, pkt_tail = -1;
 	u64 csum_complete = 0, csum_none = 0;
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
-	s32 head0 = -1, head1 = -1;
 	__le64 *raw_rcd, done;
 	u32 head = rcq->head;
 
@@ -1163,6 +1240,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				bytes += skb->len;
 
 				napi_gro_receive(&nv->napi, skb);
+			} else if (PTR_ERR(skb) == -FBNIC_XDP_TX) {
+				pkt_tail = nv->qt[0].sub1.tail;
+				bytes += xdp_get_buff_len(&pkt->buff);
 			} else {
 				if (!skb) {
 					alloc_failed++;
@@ -1198,6 +1278,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	rcq->stats.rx.csum_none += csum_none;
 	u64_stats_update_end(&rcq->stats.syncp);
 
+	if (pkt_tail >= 0)
+		fbnic_pkt_commit_tail(nv, pkt_tail);
+
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
 		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
-- 
2.47.3


