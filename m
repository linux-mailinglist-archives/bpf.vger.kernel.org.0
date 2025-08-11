Return-Path: <bpf+bounces-65394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA22B217B9
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633777AC3F7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F82E3B03;
	Mon, 11 Aug 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liBMLYrO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCC2D94B0;
	Mon, 11 Aug 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949349; cv=none; b=jiqO7ccpdznMjDA7SdHd32PbLbWtS9cY3yuEKWCVVeO5g7WJY/NhqeCCCbMXx0OvGyYCaWTXTJCwzqibNZRoEUN/HGAAvwc9c2sCwzZwnXnxA25ZYIKBPdxaM4lHlG8mlVF3dWW8kGOu7JGIUdVhzpynDWAi1Qc4cwWxU8nl8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949349; c=relaxed/simple;
	bh=/FW7YScjYRO5kdnIq3Em1cEl/QpLuuOpRjx4SNAMX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5BUp5K7aUXGa16LRGIWYZVOkY7v4Th8zzd7YCsPthS/NJFRpgoHnWsdTluKmknvjUeDyjeUUiWbsQXHYG0/fBMewIoROjzBVW6G9SGe9aehTAUe2SVLbj2KBP1/T8SLi37HriEREGLOZeZtIxY8a+ddSQoFLBp+Hd3nAPTouA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liBMLYrO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459e7ea3ebeso18321435e9.0;
        Mon, 11 Aug 2025 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949345; x=1755554145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+42vqfxu+fadvzihVrJmT65ksS4BxczuHau2hikdC+I=;
        b=liBMLYrORT9016tY4EWj7n2IDui09/ilxu40dhoj2zHaeieHipX5RMXH5qAjQnpIOQ
         +NSyLKGC5qzt5atySAlFnyzGDvtTrac+igDJmdzOTgsae/x1XrFhi/1p9YDOV25Pqfse
         LfBO7WevtXKJs00VIwydJl6LcsYVm6hcfdCsntZS+vbuHBk+re2IhIYbovFFsVJHQ+Ej
         GhCCbqLaTUl9zBt7mLt/LIdHqu/BYLAmvySgWsdkacKVcjlV0dRRvDc0kukT7gLK5UQ3
         RhtcCRwa0UDa+/27nhp30GaY63HN9IrxO0uuAbS6nSX97PHxw2lcPWcSDzjskI8Vfhdi
         cdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949345; x=1755554145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+42vqfxu+fadvzihVrJmT65ksS4BxczuHau2hikdC+I=;
        b=eS/wgSvHyl+OfyMoNUZM+jv4yysKsiJ5CB3Lw51Z5AdSxnsuwkeNIfXqKDjSdqjess
         E997rV2q4HPE4wsU3rkQZw0JD2m5wjNOqtllo1i3kK1xx/OhpUxpVAAMGnRMdvsEcitd
         pLJ5Bz2KqIJ8Jp28YqLqS+a5XMVv3eqUzEsHE1U3Q758xLcDL8BXcNCpN3+3XiKdj5su
         KiXZ7CYCPh+lIKVcboz5WZewiA0Fc3UVkArAB7RVwZXHqFqHrnPbKeBEp4AN+049eKdI
         mr8T9qA8HdoB5sIjhbk/cWgI9ESdsrQhHdq240fThKdjEJqOpWx9cV42fJVjCIU85LuL
         Bd9w==
X-Forwarded-Encrypted: i=1; AJvYcCV66Lnul4SLJymLOO2k0JbYonJQc8sLCwgQEnJLETulsn+PbJ7j3OB9z2OqZkJ0Jhj6avU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nMD6E7r8qTARP9pTYNFWefOBE2vufIOVEmk3c5/DTGFIr8U0
	ZDyQuR3DlGdwovR2vWzXN2blaRIodDJih+xcX2mi0kehT43DEMGgxRCg/Cv5/0K8
X-Gm-Gg: ASbGnctIplVe+IrUIbz3N64225QLdlYSFV55z4zVskwVVjRlOIim8/WllAngz9kcYaj
	Kz5ghpA3T+mQf3WJDtSh4jNtjv6X3T+37xjIdTpVG6CVXbR0t8JcHhKRiHjvzUhkIFdLaPVswRO
	SnFI7WQkbQGO+SwrqQyJSPu6s8+7Z2fEzXfG2N+XY99NOyxpOBXyH2ZcYcvC1qgsZ8Z+SMljiuv
	zcepwQm9gbNuof7ODoae9nHvlGiON+QHVfqlvRLnayxg1pItTUPs0WT8o/7TvV2lgROUgyImhpt
	Sp9NGcMe6h7ErBPkrG8TT/NeShiYe8jyInlKsgwaCYFJyLQw7fj8Od6NPdwybyXqO21hcqTmbif
	lIg9OvpOrRHNFDeNKZzfw
X-Google-Smtp-Source: AGHT+IELtoAek110IrwLUimX4ogtd4ShX1mAIrnG6for9sBCUUcbJssTrtREz9oVrrsAVcb3Y1ROWw==
X-Received: by 2002:a5d:64c2:0:b0:3b7:7489:3ddb with SMTP id ffacd0b85a97d-3b911014c88mr995251f8f.34.1754949344898;
        Mon, 11 Aug 2025 14:55:44 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm42450805f8f.66.2025.08.11.14.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:55:44 -0700 (PDT)
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
Subject: [PATCH net-next V2 6/9] eth: fbnic: Add support for XDP queues
Date: Mon, 11 Aug 2025 14:55:42 -0700
Message-ID: <20250811215542.1058193-1-mohsin.bashr@gmail.com>
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

Add support for allocating XDP_TX queues and configuring ring support.
FBNIC has been designed with XDP support in mind. Each Tx queue has 2
submission queues and one completion queue, with the expectation that
one of the submission queues will be used by the stack, and the other
by XDP. XDP queues are populated by XDP_TX and start from index 128
in the TX queue array.
The support for XDP_TX is added in the next patch.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 139 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   7 +
 3 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index bfa79ea910d8..0a6347f28210 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -20,7 +20,7 @@
 struct fbnic_net {
 	struct bpf_prog *xdp_prog;
 
-	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
+	struct fbnic_ring *tx[FBNIC_MAX_TXQS + FBNIC_MAX_XDPQS];
 	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
 
 	struct fbnic_napi_vector *napi[FBNIC_MAX_NAPI_VECTORS];
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 63e64bfb6f0f..a12f39f2a959 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -615,6 +615,37 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	}
 }
 
+static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
+			     struct fbnic_ring *ring, bool discard,
+			     unsigned int hw_head)
+{
+	unsigned int head = ring->head;
+	u64 total_bytes = 0;
+
+	while (hw_head != head) {
+		struct page *page;
+		u64 twd;
+
+		if (unlikely(!(ring->desc[head] & FBNIC_TWD_TYPE(AL))))
+			goto next_desc;
+
+		twd = le64_to_cpu(ring->desc[head]);
+		page = ring->tx_buf[head];
+
+		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
+
+		page_pool_put_page(nv->page_pool, page, -1, pp_allow_direct);
+next_desc:
+		head++;
+		head &= ring->size_mask;
+	}
+
+	if (!total_bytes)
+		return;
+
+	ring->head = head;
+}
+
 static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 			    struct fbnic_ring *ring,
 			    u64 tcd, int *ts_head, int *head0)
@@ -698,12 +729,21 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 }
 
 static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
-			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0)
+			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0,
+			    s32 head1)
 {
 	if (head0 >= 0)
 		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
 	else if (ts_head >= 0)
 		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, ts_head);
+
+	if (head1 >= 0) {
+		qt->cmpl.deferred_head = -1;
+		if (napi_budget)
+			fbnic_clean_twq1(nv, true, &qt->sub1, false, head1);
+		else
+			qt->cmpl.deferred_head = head1;
+	}
 }
 
 static void
@@ -711,6 +751,7 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 		int napi_budget)
 {
 	struct fbnic_ring *cmpl = &qt->cmpl;
+	s32 head1 = cmpl->deferred_head;
 	s32 head0 = -1, ts_head = -1;
 	__le64 *raw_tcd, done;
 	u32 head = cmpl->head;
@@ -728,7 +769,10 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 
 		switch (FIELD_GET(FBNIC_TCD_TYPE_MASK, tcd)) {
 		case FBNIC_TCD_TYPE_0:
-			if (!(tcd & FBNIC_TCD_TWQ1))
+			if (tcd & FBNIC_TCD_TWQ1)
+				head1 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD1_MASK,
+						  tcd);
+			else
 				head0 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD0_MASK,
 						  tcd);
 			/* Currently all err status bits are related to
@@ -761,7 +805,7 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 	}
 
 	/* Unmap and free processed buffers */
-	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0);
+	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0, head1);
 }
 
 static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
@@ -1268,6 +1312,17 @@ static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
 	fbn->tx[txr->q_idx] = NULL;
 }
 
+static void fbnic_remove_xdp_ring(struct fbnic_net *fbn,
+				  struct fbnic_ring *xdpr)
+{
+	if (!(xdpr->flags & FBNIC_RING_F_STATS))
+		return;
+
+	/* Remove pointer to the Tx ring */
+	WARN_ON(fbn->tx[xdpr->q_idx] && fbn->tx[xdpr->q_idx] != xdpr);
+	fbn->tx[xdpr->q_idx] = NULL;
+}
+
 static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
 				 struct fbnic_ring *rxr)
 {
@@ -1289,6 +1344,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 
 	for (i = 0; i < nv->txt_count; i++) {
 		fbnic_remove_tx_ring(fbn, &nv->qt[i].sub0);
+		fbnic_remove_xdp_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_tx_ring(fbn, &nv->qt[i].cmpl);
 	}
 
@@ -1363,6 +1419,7 @@ static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
 	ring->doorbell = doorbell;
 	ring->q_idx = q_idx;
 	ring->flags = flags;
+	ring->deferred_head = -1;
 }
 
 static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
@@ -1372,11 +1429,18 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 {
 	int txt_count = txq_count, rxt_count = rxq_count;
 	u32 __iomem *uc_addr = fbd->uc_addr0;
+	int xdp_count = 0, qt_count, err;
 	struct fbnic_napi_vector *nv;
 	struct fbnic_q_triad *qt;
-	int qt_count, err;
 	u32 __iomem *db;
 
+	/* We need to reserve at least one Tx Queue Triad for an XDP ring */
+	if (rxq_count) {
+		xdp_count = 1;
+		if (!txt_count)
+			txt_count = 1;
+	}
+
 	qt_count = txt_count + rxq_count;
 	if (!qt_count)
 		return -EINVAL;
@@ -1425,12 +1489,13 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	qt = nv->qt;
 
 	while (txt_count) {
+		u8 flags = FBNIC_RING_F_CTX | FBNIC_RING_F_STATS;
+
 		/* Configure Tx queue */
 		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TWQ0_TAIL];
 
 		/* Assign Tx queue to netdev if applicable */
 		if (txq_count > 0) {
-			u8 flags = FBNIC_RING_F_CTX | FBNIC_RING_F_STATS;
 
 			fbnic_ring_init(&qt->sub0, db, txq_idx, flags);
 			fbn->tx[txq_idx] = &qt->sub0;
@@ -1440,6 +1505,28 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 					FBNIC_RING_F_DISABLED);
 		}
 
+		/* Configure XDP queue */
+		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TWQ1_TAIL];
+
+		/* Assign XDP queue to netdev if applicable
+		 *
+		 * The setup for this is in itself a bit different.
+		 * 1. We only need one XDP Tx queue per NAPI vector.
+		 * 2. We associate it to the first Rx queue index.
+		 * 3. The hardware side is associated based on the Tx Queue.
+		 * 4. The netdev queue is offset by FBNIC_MAX_TXQs.
+		 */
+		if (xdp_count > 0) {
+			unsigned int xdp_idx = FBNIC_MAX_TXQS + rxq_idx;
+
+			fbnic_ring_init(&qt->sub1, db, xdp_idx, flags);
+			fbn->tx[xdp_idx] = &qt->sub1;
+			xdp_count--;
+		} else {
+			fbnic_ring_init(&qt->sub1, db, 0,
+					FBNIC_RING_F_DISABLED);
+		}
+
 		/* Configure Tx completion queue */
 		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TCQ_HEAD];
 		fbnic_ring_init(&qt->cmpl, db, 0, 0);
@@ -1495,6 +1582,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		qt--;
 
 		fbnic_remove_tx_ring(fbn, &qt->sub0);
+		fbnic_remove_xdp_ring(fbn, &qt->sub1);
 		fbnic_remove_tx_ring(fbn, &qt->cmpl);
 
 		txt_count++;
@@ -1729,6 +1817,10 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 	if (err)
 		return err;
 
+	err = fbnic_alloc_tx_ring_resources(fbn, &qt->sub1);
+	if (err)
+		goto free_sub0;
+
 	err = fbnic_alloc_tx_ring_resources(fbn, &qt->cmpl);
 	if (err)
 		goto free_sub1;
@@ -1736,6 +1828,8 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 	return 0;
 
 free_sub1:
+	fbnic_free_ring_resources(dev, &qt->sub1);
+free_sub0:
 	fbnic_free_ring_resources(dev, &qt->sub0);
 	return err;
 }
@@ -1923,6 +2017,15 @@ static void fbnic_disable_twq0(struct fbnic_ring *txr)
 	fbnic_ring_wr32(txr, FBNIC_QUEUE_TWQ0_CTL, twq_ctl);
 }
 
+static void fbnic_disable_twq1(struct fbnic_ring *txr)
+{
+	u32 twq_ctl = fbnic_ring_rd32(txr, FBNIC_QUEUE_TWQ1_CTL);
+
+	twq_ctl &= ~FBNIC_QUEUE_TWQ_CTL_ENABLE;
+
+	fbnic_ring_wr32(txr, FBNIC_QUEUE_TWQ1_CTL, twq_ctl);
+}
+
 static void fbnic_disable_tcq(struct fbnic_ring *txr)
 {
 	fbnic_ring_wr32(txr, FBNIC_QUEUE_TCQ_CTL, 0);
@@ -1968,6 +2071,7 @@ void fbnic_disable(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_disable_twq0(&qt->sub0);
+			fbnic_disable_twq1(&qt->sub1);
 			fbnic_disable_tcq(&qt->cmpl);
 		}
 
@@ -2082,6 +2186,8 @@ void fbnic_flush(struct fbnic_net *fbn)
 
 			/* Clean the work queues of unprocessed work */
 			fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+			fbnic_clean_twq1(nv, false, &qt->sub1, true,
+					 qt->sub1.tail);
 
 			/* Reset completion queue descriptor ring */
 			memset(qt->cmpl.desc, 0, qt->cmpl.size);
@@ -2156,6 +2262,28 @@ static void fbnic_enable_twq0(struct fbnic_ring *twq)
 	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_CTL, FBNIC_QUEUE_TWQ_CTL_ENABLE);
 }
 
+static void fbnic_enable_twq1(struct fbnic_ring *twq)
+{
+	u32 log_size = fls(twq->size_mask);
+
+	if (!twq->size_mask)
+		return;
+
+	/* Reset head/tail */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_CTL, FBNIC_QUEUE_TWQ_CTL_RESET);
+	twq->tail = 0;
+	twq->head = 0;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_BAL, lower_32_bits(twq->dma));
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_BAH, upper_32_bits(twq->dma));
+
+	/* Write lower 4 bits of log size as 64K ring size is 0 */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_SIZE, log_size & 0xf);
+
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_CTL, FBNIC_QUEUE_TWQ_CTL_ENABLE);
+}
+
 static void fbnic_enable_tcq(struct fbnic_napi_vector *nv,
 			     struct fbnic_ring *tcq)
 {
@@ -2341,6 +2469,7 @@ void fbnic_enable(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_enable_twq0(&qt->sub0);
+			fbnic_enable_twq1(&qt->sub1);
 			fbnic_enable_tcq(nv, &qt->cmpl);
 		}
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 5536f72a1c85..0e92d11115a6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -35,6 +35,7 @@ struct fbnic_net;
 
 #define FBNIC_MAX_TXQS			128u
 #define FBNIC_MAX_RXQS			128u
+#define FBNIC_MAX_XDPQS			128u
 
 /* These apply to TWQs, TCQ, RCQ */
 #define FBNIC_QUEUE_SIZE_MIN		16u
@@ -119,6 +120,12 @@ struct fbnic_ring {
 
 	u32 head, tail;			/* Head/Tail of ring */
 
+	/* Deferred_head is used to cache the head for TWQ1 if an attempt
+	 * is made to clean TWQ1 with zero napi_budget. We do not use it for
+	 * any other ring.
+	 */
+	s32 deferred_head;
+
 	struct fbnic_queue_stats stats;
 
 	/* Slow path fields follow */
-- 
2.47.3


