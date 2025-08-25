Return-Path: <bpf+bounces-66394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35CEB34296
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535C53AF100
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAE2FABE7;
	Mon, 25 Aug 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARQ9tSw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F712F8BE6;
	Mon, 25 Aug 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130084; cv=none; b=VqmlAqWEWOGK0WjNTgK/PgaYMo9j7OXMer8FFU78ELxwXLhGMEotptlVKQsgKY8Zpdtasc8UvFnwD6cKXIw68JpUf4miu5YhBF3q7Oyjx7RkISoov35UEWflnFdlM67AkOAgB3LA3+yPrdyiI3HZSVIzAsJBvW2VnO2lCSWjS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130084; c=relaxed/simple;
	bh=6ZT15xgI2LtsKKNFxxZqf6INkRogFfoxyylXpUoCeH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1jbts5aSBPMGpiw7MjXvq8PK4wNLoCixw+DmksDDBtB/W3nVyTagBNeBdxz1UUkBATrkQEFXSIb7xYrCDvyI+HqY4rZDjvzJhbebWXfH4pGhP+6LwM0mEFQHCP8FrjPEkybRt1XdO/co+E9Uiugy4D/ed5JT9rDWyhMdA0Gul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARQ9tSw3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3254e80ba08so2374912a91.1;
        Mon, 25 Aug 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130079; x=1756734879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEKpXtYLAfemBpEf/X+N9sVE65/y4oPjAl9O6erfNhs=;
        b=ARQ9tSw3SfrqfISx9pp7T/NnhhzMoLglwyYKTAg3UIwcBmqJ4HJgaedmljKiSb0tc9
         +2U3NMdUaT7p22uCguROTc/2rWbzGOs/HlXRUl19cPoimoMkEFyvvsA7OkcwZKbCHvhq
         JbCd676w+s6jWpHFKqEwgESsLE1CvfNcx+FFcSpaA/GAJ6nQ42702e3A2tQrrDBhBIc9
         PcKLLUg1uoaQ6hPPM3aucfImKjGNc7tkK9G5o/XeDEfmXIDufb7DOoXTWCpMc1al5N8G
         2JX7ttabrSlA7R3ni34LtDhn83gFDqXgMlLiVgLwQsRLeloijPwgdpqQsKd9hr8oD17f
         YLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130079; x=1756734879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEKpXtYLAfemBpEf/X+N9sVE65/y4oPjAl9O6erfNhs=;
        b=doY8btmsR1RZcXtjv1u/Z9yiXGS2nshjekHJoBWRFkxm0xfgeI538XMoCVPJmN8jIj
         XEAZvtVZPto82484sTWsOfIE4Ib03s3l4GR0x+FJRL6L7iUa0Wndrr7XXIIxWzPrW6fP
         +q1IdM/kf+G/QMACB6EwShH4OY93mqRBA10lqkc60vM12fa14YDYGB3UsNGHoyDH3FyL
         7nf8kB+Z8C0Vpy7BHU2lN/I9RefrMqfg6lljNbArWw6Funj8KiLGiHMO3pDREftU1d3D
         W1uOhmXbaP7vZjcOWKsIwopxTttdBiYaNFkgtiQjnRCMIb4eDjZZ7qTKThCOIUZ8Rr/l
         WczA==
X-Forwarded-Encrypted: i=1; AJvYcCVg4Q2f0M3PDs+FBwGmUsK4sObdNydckPFnhhUavqVHI+AyEtU/2PyBv1JMt/slQLDvRC30nGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDhfLqOjDbDuYv4ye6Wxilf0bbFBWhATwwyXaIQLZ9dKiUpTr
	Gga4iH9V5/lPTG944C2LtR/mChWyytreKp6imvBYAxiXJ3AwFXe9Wd7E
X-Gm-Gg: ASbGnctkCt49ESLVLU4WeHiP2y1OO5ynfkDpFTK3oVZq3fiOmXJWfT4iHFbjyq1KE67
	iT8UQyWDlmSARTVMcgtERPh6zkPPcounhRvZOvPAZXdJh/atIi/bhYz1MRdwfNwsQRFM/FDu31K
	1X5yRYCZ5QLi9iKAPpofbjU3jU48f5n14pi6renw4wmyLuDGo85ofz8+Io8OUqZDiivFk6TufTb
	hcSh8dc1C2QOke919MvOGLe2a0XzE0nkHZ+xowqUX4cEjRdeA3ijKZQmzLdq5x66eu/M9qmO0a6
	D03MV0tB0Ru9tOw8+AWdR3KFACongddfwC+tKdk9z7MLe3go8HKqs7r4qKeo3IeIg3huPKQH8y3
	bfAFM5jqD7asdXXDBHRW3fOTBLoBvhTh1ZgP4Vnii9HBOlgQzY7GmNWhw8C8=
X-Google-Smtp-Source: AGHT+IFOQ4ceNaZmqfuzQqL5EBLtTKj2GImq1BUgrlAxbN4EPVttPe8Vgz2kzqVO4YiN+a4atKQa8g==
X-Received: by 2002:a17:90b:350f:b0:325:6da7:bf86 with SMTP id 98e67ed59e1d1-3256da7c0f4mr8097490a91.25.1756130079396;
        Mon, 25 Aug 2025 06:54:39 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 7/9] xsk: support batch xmit main logic
Date: Mon, 25 Aug 2025 21:53:40 +0800
Message-Id: <20250825135342.53110-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This function __xsk_generic_xmit_batch() is the core function in batches
xmit, implement a batch version of __xsk_generic_xmit().

The whole logic is divided into sections:
1. check if we have enough available slots in tx ring and completion
   ring.
2. read descriptors from tx ring into xs->desc_batch in batches
3. reserve enough slots in completion ring to avoid backpressure
4. allocate and build skbs in batches
5. send all the possible packets in batches at one time

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 213d6100e405..90089a6e78b2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -789,6 +789,123 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return ERR_PTR(err);
 }
 
+static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
+{
+	struct xdp_desc *descs = xs->desc_batch;
+	struct xsk_buff_pool *pool = xs->pool;
+	struct sk_buff **skbs = xs->skb_cache;
+	u32 nb_pkts, nb_descs, cons_descs;
+	struct net_device *dev = xs->dev;
+	int start = 0, end = 0, cur = -1;
+	u32 i = 0, max_budget;
+	struct netdev_queue *txq;
+	bool sent_frame = false;
+	u32 max_batch, expected;
+	int err = 0;
+
+	mutex_lock(&xs->mutex);
+
+	/* Since we dropped the RCU read lock, the socket state might have changed. */
+	if (unlikely(!xsk_is_bound(xs))) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	if (xs->queue_id >= dev->real_num_tx_queues)
+		goto out;
+
+	if (unlikely(!netif_running(dev) ||
+		     !netif_carrier_ok(dev)))
+		goto out;
+
+	max_budget = READ_ONCE(xs->max_tx_budget);
+	max_batch = xs->generic_xmit_batch;
+	txq = netdev_get_tx_queue(dev, xs->queue_id);
+
+	for (i = 0; i < max_budget; i += cons_descs) {
+		expected = max_budget - i;
+		expected = max_batch > expected ? expected : max_batch;
+		nb_descs = xskq_cons_nb_entries(xs->tx, expected);
+		if (!nb_descs)
+			goto out;
+
+		/* This is the backpressure mechanism for the Tx path. Try to
+		 * reserve space in the completion queue for all packets, but
+		 * if there are fewer slots available, just process that many
+		 * packets. This avoids having to implement any buffering in
+		 * the Tx path.
+		 */
+		nb_descs = xskq_prod_nb_free(pool->cq, nb_descs);
+		if (!nb_descs) {
+			err = -EAGAIN;
+			goto out;
+		}
+
+		nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, descs, nb_descs);
+		if (!nb_descs) {
+			err = -EAGAIN;
+			xs->tx->queue_empty_descs++;
+			goto out;
+		}
+
+		nb_pkts = xskq_prod_write_addr_batch_locked(pool, descs, nb_descs);
+
+		err = xsk_alloc_batch_skb(xs, nb_pkts, nb_descs, &cons_descs, &start, &end);
+		/* Return 'nb_descs - cons_descs' number of descs to the
+		 * pool if the batch allocation partially fails
+		 */
+		if (cons_descs < nb_descs) {
+			xskq_cons_cancel_n(xs->tx, nb_descs - cons_descs);
+			xsk_cq_cancel_locked(xs->pool, nb_descs - cons_descs);
+		}
+
+		if (start >= end) {
+			int err_xmit;
+
+			err_xmit = xsk_direct_xmit_batch(skbs, dev, txq,
+							 &cur, start, end);
+			if (err_xmit == NETDEV_TX_BUSY) {
+				err = -EAGAIN;
+			} else if (err_xmit == NET_XMIT_DROP) {
+				cur++;
+				err = -EBUSY;
+			}
+
+			sent_frame = true;
+			xs->skb = NULL;
+		}
+
+		if (err)
+			goto out;
+
+		start = 0;
+		end = 0;
+		cur = -1;
+	}
+
+	/* Maximum budget of descriptors have been consumed */
+	err = -EAGAIN;
+
+	if (xskq_has_descs(xs->tx)) {
+		if (xs->skb)
+			xsk_drop_skb(xs->skb);
+	}
+
+out:
+	/* If cur is larger than end, we must to clear the rest of
+	 * sbks staying in the skb_cache
+	 */
+	for (; cur >= end; cur--) {
+		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skbs[cur]));
+		xsk_consume_skb(skbs[cur]);
+	}
+	if (sent_frame)
+		__xsk_tx_release(xs);
+
+	mutex_unlock(&xs->mutex);
+	return err;
+}
+
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-- 
2.41.3


