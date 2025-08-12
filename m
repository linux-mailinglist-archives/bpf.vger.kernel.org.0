Return-Path: <bpf+bounces-65464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08519B23BA7
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDE83A8A1B
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0222E0914;
	Tue, 12 Aug 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLHTinSn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DF2D978A;
	Tue, 12 Aug 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036142; cv=none; b=X7kowqayd2sS1ebcf/eIw1aHOYf0Qvvaj7AAb1KiE2w6hXcT9NH0JjkmR5finebINa437BSqoGj3ren5SGVL0bPvShLTafqM2jdsAMTNtBgDm6WJAyNCg73UjzKEUFsQM4vPO8KDkR1JMwAlzgaaqV2rJe9SDlutOBmSsK3UNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036142; c=relaxed/simple;
	bh=z5eh1bKAj+yTKJlbaWakuZx+ew3j2Q9i6btBmoQVet0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXv5Rjmf/UrmEi923HJ57+j0g4FePWEVZXs+n2qHWTQaQRFCqhxLUWB247k05qXgYew8xyuJzvU31opuHxgAjrGHm/p+4UgOxEDF/x5ovvl9kuAHNXfXi25bUIIKdLGzu/3ae538Y5w8OMapvOHR6A92CqsmoLA0UuNu2SfmW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLHTinSn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458bece40fcso30232965e9.3;
        Tue, 12 Aug 2025 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036139; x=1755640939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1WHY4FNnRPffvIFwMJXVzB++hI6LqZV5e64X1VQUxE=;
        b=JLHTinSnd6s29VYhDuacd9OGdd6JuVGGvt4CKHaPBAXIL0TXgy5okkEccMHlLT0sfN
         RWiJvVASwhLsRPyIF7y6TPbL0QoD6zmIwvAOuOELN7pdEUCOcEmzVy1EKQK65w41sPgk
         ACb/8DrVCUhgQ24V0Ro7bqynMfbGJBvWJYfdfUumMPgQt668/6HKMF++gof1nx3WMjhg
         gX2slBCeHrHomahX2G5jYz83ekp1LxNw2sEAIzng0fY7Dg0Xm5c7nsd/vex1MQaA0q7m
         uUlzWRatONGhnZlW1BUQsDWTaM7vwQ+p750MH5lw7HQQdc7NeRWJGbT0XpnY+KWiRVlL
         UJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036139; x=1755640939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1WHY4FNnRPffvIFwMJXVzB++hI6LqZV5e64X1VQUxE=;
        b=c3OFfcMFynRgiRhnxGak8ltRZpoFgjujFoinHXxT9OL4rCcIO66+xBd15zXNcSWAGH
         C5nRv21XYhPB5qzYCyH7i4cS6LF/K5ghY0RrT5D5/HuPzuy61EVwRx07JdfO3tGd8epY
         7Lw+WqRrpNQm5W294SOkFWzP4zcobMjnstZq+gJ2mb+hUV3/UFps8mD/WIYiox24j9Pi
         V81ZBVbsX5KoJXIGHW+sixTmxTs076S/AtkouXQzca5AHGJ8t+r8bsOGgTob7P6rc09G
         Zm9IYfWC96JDmXenTTI+P8IjlyyBkCMWl+aR2iNcLTDOaO+f0yo3eD/iOGR+IY/B1hfQ
         9Aig==
X-Forwarded-Encrypted: i=1; AJvYcCVP4+w1mRFVtd1OT4OwnKAAOrizuGJNivmJTgZB9XsPdhTwnt53YGIDxNKFa/xQAJdOBKs=@vger.kernel.org, AJvYcCWmtwyS//JOkWeDNhzOZ4A4478lfKbDs5MdcE9QqlN3pjRGkQzaWZHL56zx9yyzC6aQ6RyVG8gwTiE1SETd@vger.kernel.org, AJvYcCXTNBxd4pSW6HFZHxy+clfvv1J3dqKU/WwRxsT7dedaKvkpYQXfxmFpc5920pBBiRixEH3nzB8QID9V@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjq/2KEt8snWOo26AKomu5CkK2LuejCom9vGjAS2Dg0sN8BRH1
	KXYm6rANGZoCQM1SjbSaQOKA8L46UWEVYqXXZcsmR529KiRAByFNEmzWhkoOno6c
X-Gm-Gg: ASbGnct0sPyTxS0UjVdV3dbHhhekoNgAQ8TWcZYBMAptdSWPWBByFoWxCnkQov+9BsC
	r6TQ6pzklv3ITsTnzWTrGvjTl2fP7ZevmYw2UEa7n3ip4C/BaGI/Cv5rScNDy+ENwmMn0YaVsus
	cArxbU7uYYN9NZZntnmVib07P478VSkWL6kfylLL1oUEt8RElf8TozSeiZpnb43EYsNhjh5oY1B
	RN09bi1K0787/M+anyAIDuPOjC8lmVPN9fz/0eCUfU9krQLIV2y6eBCbv9j8Nw2n+bI1WnZ5OXm
	Ceno0jCXt5snH2CCOkNr0i3OCBEvCRToD7AGctxqF3nYAB+h5AqoUO1X2fWqhIRcawtyY/WHIVT
	c7JCso9jl9t7JN6gbDby3P2RGRvPRnFtPOBI=
X-Google-Smtp-Source: AGHT+IHhj4iqHQ5uOADV6ceRwSPqogu2NR0Erv3yYYyVUsyLHfwAtdOXYs0vavSGyP/jRdYNtKeNDg==
X-Received: by 2002:a05:600c:4f12:b0:455:bd8a:7e7 with SMTP id 5b1f17b1804b1-45a165afa4emr5531795e9.9.1755036138372;
        Tue, 12 Aug 2025 15:02:18 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16dcbcb1sm3632495e9.3.2025.08.12.15.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:02:17 -0700 (PDT)
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
Subject: [PATCH net-next V3 6/9] eth: fbnic: Add support for XDP queues
Date: Tue, 12 Aug 2025 15:01:47 -0700
Message-ID: <20250812220150.161848-7-mohsin.bashr@gmail.com>
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
index a669e169e3ad..8c7709f707e6 100644
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


