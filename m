Return-Path: <bpf+bounces-65577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D03B25665
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93905A7CAC
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275E3002DF;
	Wed, 13 Aug 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkopFhum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77133002BE;
	Wed, 13 Aug 2025 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123231; cv=none; b=NbQE6kNK/DIz8L5S10cIMToMIXyqjtzroP/hIVRHuVav3qM/JZAW4dmmPIuS2Fn4ddYeiWtkzLYc84eHrZJEPGGcgB9vZ0InkSh/SydS5YfEu2dthX2fTpEDNNlVz8OeQfAISZvQ+oe/dqieOnCEtWX+pJiggSybbtn+LI5Vovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123231; c=relaxed/simple;
	bh=iGLPwLTWNwop6RMFh7j0QYriyX4zvp+U62kQYD5P7BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZPfLjcDddAldfrZj+MaxkjdPodL1OhCunATeIr2DqZ1pv+2GBpYSWO7f8ez8KYa7FIl4J6Y5qw+VtVw8doOW4ScUtcALGS6IdsUh4xX6J7/5ETOQXb9apnTDrJl/TFqxj/tq4ENdJpHhYKfF4uzTB927/hqGoNMsN++Rnx8vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkopFhum; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso200716f8f.0;
        Wed, 13 Aug 2025 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123228; x=1755728028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9TwM/oJ+vBg3tLeYBvNykLhtDAg9/aYnDOk66ERKqU=;
        b=mkopFhumm0nRGJHUNXHPfJ5XuGivqFRVcmtC7X6/1LsUbxOgrv7/7s2Ktu/Lp0gVzO
         PNoUFn5jDmjJb90K89caKqI76/SPURa992ib2N3ZqFt3Sx4q/Vh2XG1wMf8vV78y8thw
         xXU/M3d6DFav6+xu+qFsat3ScpVQPWwhOhFKdj5ZG6vzcrBUkSw6WkkXy6jETY/FH5Fq
         w0ohP30tDFLGK2cxTmX3l1e/8tAdYMavnpwaBVPWRNNjlnVBLUXh10RE6P8JuUoS1GZa
         JvRaOcfxn0aCov1Jq7ym6wHu0fFcNQvR91TPiVY7Zdk4ftOD5AXCFA+16sRhd/qIEu8l
         K9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123228; x=1755728028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9TwM/oJ+vBg3tLeYBvNykLhtDAg9/aYnDOk66ERKqU=;
        b=QPmN9W6TZG729y71q8hn+D6bIw9FOAtoROwMhmJPLwtEMd7sfH+zyuQ5qv7xmVzaS8
         GuLoNddiOu90An74VzCvMGkU7YauZOgNQ4L6N3TPdmKwakcLFTjYr6gkfcZlhQTaAHfC
         HMSOz+lOqklN73KcAUTsUT8nslivOuSPDroKsYU4ZukWfPC8jwxzLuDZBNJHIeJ9li77
         mKFt0Y5F32mgsPV878K6lUQAMQQP1AJjb7bxulRLBhGeZ/23bOK5VORDr4HuSr9j8FSv
         tqO3o7rSFNv16+GK73rDGVkg+T4r4BdxT7dDppGeda9hZ9e/Ecgnk//FJaDUYdZuvw9k
         hJVg==
X-Forwarded-Encrypted: i=1; AJvYcCUy9rP0Vi7TNI4WfKjuBRjuPmhl6my1LJkzPzFgBC13QCk/kCNiTe9SIqGYXxiakj6psRE=@vger.kernel.org, AJvYcCVG2yRDYXvkFk2jQHK27t4aYJz11xC829ITCQWv2hddZDvnCwf/ITE0/d042yzRiPG9yLRjnhJK1hO/@vger.kernel.org, AJvYcCXRBxTdnGq3yoEFmC5K/WiYRFDA5+G2a5J11lA7SaN21AJUwOo2UimDru7cJ5z04hlExgsyxCPmHHMSTZ3B@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbYhMNeADvQCbtlD8rQkJL7+cE2wwZWuwhVFNuHfmS+QfKV9A
	g8dx6/MIgTfyJPGmIa8oZ7mk8C6/Hp7RevVU4tJlfzqx4atGfDXmjF5bxiusPk9P
X-Gm-Gg: ASbGncuK1FTUJB8MhKBYDv+PDH/g9q3FtH8qI1anZkMfmI7ee54R2T7o/k5/3KN3vxh
	6M5NpcXLAKP63aEg2oNZHX1cxtJD5KHDPPVI7QX8h5Cawxm8D91loZd+RR74RBcROQoIPebqssk
	W32FHflNqPoHaW1ALLC3x1zGR4ufvhnS+K1WuKcM+vKkh9D885k2g1Mw7zC7Gp2Tk6+JyLR2ihc
	IKhf+fz7gMg6Ole4k96huJrKGrqWB0j8WC7IGY7+aZK7ZrpXxTQptpId8VAQ21jeB06ruq/N64w
	BP9UOds6ibltrb7QHVRCVB/qnOfJqU7seiixEEOzxBldScYdyaPeVxtBDdPH+IfmJPyZFCmQBfZ
	4OpCVzWoTNj+nz9+GTJK3GeTZtskejOuRMAo=
X-Google-Smtp-Source: AGHT+IH4Q1XAD40GRpI0mu9XNK438yyqymK/KYQGRaX8w3+/UTg+oY+MoLpSuVNMSfAsopCTn26I3Q==
X-Received: by 2002:a05:6000:178d:b0:3b7:8dd1:d7a1 with SMTP id ffacd0b85a97d-3b9e41785a6mr527545f8f.19.1755123227349;
        Wed, 13 Aug 2025 15:13:47 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm47548992f8f.33.2025.08.13.15.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:45 -0700 (PDT)
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
Subject: [PATCH net-next V4 7/9] eth: fbnic: Add support for XDP_TX action
Date: Wed, 13 Aug 2025 15:13:17 -0700
Message-ID: <20250813221319.3367670-8-mohsin.bashr@gmail.com>
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

Add support for XDP_TX action and cleaning the associated work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 85 +++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 8c7709f707e6..de3610a7491a 100644
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
+			} else if (skb == ERR_PTR(-FBNIC_XDP_TX)) {
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


