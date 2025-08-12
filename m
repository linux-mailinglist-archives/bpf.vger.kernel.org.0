Return-Path: <bpf+bounces-65469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB04B23BB8
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F3D1AA659E
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809428CF6F;
	Tue, 12 Aug 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8ek1SLF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1A2F0687;
	Tue, 12 Aug 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037285; cv=none; b=eZ7+guXqP3uiFzuIgAErnQj1A3GpTFpj8yz5ZAy5eOpollUmDsV87pP+Syv1bzMPfnUw0a67AmvzOSsFrno80lSZfnoWz0TPGv9MpywKSr2wYgp0/IZFLRDt2NIG1YjrchDcP1bHRdPt/mxW3tGS01rX0zrFq5VTc36Wjb0w/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037285; c=relaxed/simple;
	bh=YqC55mj2AR86dA7/RdCYznw/7ElZag4idFv+o2F57cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ0HwGOBCLWsINVsA83anP3hBo3A29EuY2N1eaGy38ckkvklFy+XzC2jGwKBdqohcOPi9xqnhxdFVeNbvhdDYG3V6xGbrK/NF9pkUWlODweRtUlTFV25i9A0Hzc9iptS78q01FH9zRe5DoEcVYOgvE9qrhLDhPVyAuJNy3qGdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8ek1SLF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so2893934f8f.2;
        Tue, 12 Aug 2025 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755037282; x=1755642082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIdEO3Lv0YC4PSIjYiDP/NYDWSHMj+gKzJ0lri3ow8Y=;
        b=h8ek1SLFEIm1rVDe/QSc0EYwgeTQ2u/yOhCht5LDFhH/pOikQKVNWeQGY+i4bv4+C0
         fRVqC37rjo5FgMaaPoOldfzwBTZ1qnBT+xEROPVV/8QEHhBP4H+j21FJS5nt8OsRGARN
         8s9EE5Sg7dUhSie1A7hQZz5kCL/rwgHTFvnfegrwu3NUS73pUYgoc0V/bdCTF243auts
         IWUmZIG5PHSbpE9+PKWbrbgRg5tN4q9WnQquHd2rMCJOl7x6b4JTjCY/YFoACrt1xZ9/
         jbYutS4p+BMl/g2RviSOJMqz2DdBdmtBAye+SBoleBgzzqVe12CF3Dxo4q6S2KVwDz0+
         DjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037282; x=1755642082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIdEO3Lv0YC4PSIjYiDP/NYDWSHMj+gKzJ0lri3ow8Y=;
        b=K8viM9tw9yh5s2IqcafSuvCjvgFC09IRwfenKPOcGjCA+cP9JRXy2BfKy53hqG8OJd
         iY2TNm2RRKCBT8vzTghkm2Ik2HoqwaWP5QstxPXldRMiEeQy4rZAZoH3r43NjlqckSWm
         nNpYSlpSSbKP0GqpEn6t2wqUrc27PbnxNPDExMrlj7cBugOMEnvopZE3Bk3V0iwI+SAR
         TFpYg+gMq3zNmPA3DcGKy08CEJRWnckH/t8VYnCHfa09jEWrPzVjPJKzq0TjNebMQovI
         XeHhIPHu33OVwIm4HY9372zPNq/G93g+A0AvNSTadI4uh14uc+gDIWMuXQ2ysX9WQ0iM
         RHkA==
X-Forwarded-Encrypted: i=1; AJvYcCUzN0EVz2prO3BkeO8+Ow6e6um3j9I3MaqAeP08H48tmZh33epJ7TFug2nhmgijoxITAIULu36dDLUB@vger.kernel.org, AJvYcCVOeIr/pX6Vzbo2AQiAAvkfdBGUXu9tM6FnVG+3X5ubeS7LD9kgRmPFrZa4lBEmj6/9iTp/r5nlGiDyYZ10@vger.kernel.org, AJvYcCXFbUyOHPJKsILQKFQG1zbPJMYwM/pa0Ngfyl9DLpEBc2Ne9EbjXgSqePR1t89R4Z0uaHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIKCjsOh3f2JPRUy4evrEzaj/ODeJr77Z507v88lhoEN0Hhnu
	8GOcUqpqtDUT4nq7XpYZ2uDMAblm1Xzjxuj4Q0o7sAqbTRPTJNSQ05HFF+cuUTtw
X-Gm-Gg: ASbGnctaRT7geRDm/Jy7flQGYeoifE2GDX4AOU1hV4h8uwF02G4cIUihhK5mbYPU4B+
	6rWE/G94M7mTWge2SkTquU7HdvXaMJrafIAYhK0G/n+QTZaqShdGPr3DCL70e9YQhwi6xHaryPR
	8EMUq6IBZSwodiWmGZf+t2hC4rzw15Esez/yfBmtmrIUxoEQR5d2Yhs7NZMIcz1H47+vNsvo1v6
	rZwJJWE0nIBIk3qmxTQDoW2B+7vDnt/0quM4LHRQGgq0WSW3s1NBP26P6UlZ7EDR5e9nNURoqq2
	4KWatXLZWEvSD+YWAXW403zH99mJKPFJ9WCYIsW0trvgeMk4Xj/pMnKkh/W5FaRzdZM43DKoHs9
	YKlRYBinD7Ar5sMkopdlHkYee
X-Google-Smtp-Source: AGHT+IHA5DUl+DA0WohBTVWkK29VWMdgV6UPb962ECdnGiG2D+fadf2fCZ9elXR3p2BKlNnxuRUpxQ==
X-Received: by 2002:a5d:5d10:0:b0:3b9:1457:df79 with SMTP id ffacd0b85a97d-3b917d1e6b2mr402840f8f.5.1755037281893;
        Tue, 12 Aug 2025 15:21:21 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16de6f70sm3861605e9.14.2025.08.12.15.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:21:21 -0700 (PDT)
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
Subject: [PATCH net-next V3 7/9] eth: fbnic: Add support for XDP_TX action
Date: Tue, 12 Aug 2025 15:21:18 -0700
Message-ID: <20250812222118.254587-1-mohsin.bashr@gmail.com>
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

Add support for XDP_TX action and cleaning the associated work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 85 +++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 8c7709f707e6..3ce1762bd11d 100644
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


