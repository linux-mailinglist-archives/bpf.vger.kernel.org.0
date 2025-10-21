Return-Path: <bpf+bounces-71571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F20BF6B1A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1BDE504594
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16A335079;
	Tue, 21 Oct 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUQsp2X6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289D334C13
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052372; cv=none; b=taHtlOOgk4W/Jg1iaC0VVSgMho2Ja5m0iasyBa1DBpKulLvQJqODri/MeJyGM3KGqAEwAK/PHhaoID3fg2P508nibovxfN29rFZlBTNIKZj9rTSNZQacboxyqsl/7hJnzX4VBqYgBJknIynEQqwdlCGVt1UJJloChk3uyJ1af8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052372; c=relaxed/simple;
	bh=9D6o2seMmUJvsbN+DuC++XIRcRSaJe63DeDm/DK3IiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lbngjqkp3MNPQVdaWriIpFX3njsx2hVDwPHFNXBECjARdjspyPVVhHTEyuvmkyp4xMAFlTgM1/ji0DCID/dTkBVhz1R2e9g1PZ9CLSK1VKW03KpPVjXBQZqOy8ZIUbaukrf0KiliIx/kYEj9YRigVeKASh8WYbDHHJ/bkMvD024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUQsp2X6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-279e2554c8fso51946035ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052369; x=1761657169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCHpnqaCnmuQwlsQYxnl8jND0G0Yea1tAyo1BGydydQ=;
        b=fUQsp2X6D8QJ+9Kxnq+YCeX94e+zPSmiv/FgnI9EKq6G4pGErHiQXrhgtyzck8kWhy
         tz/jHs2wQ3HyQD+l21V2ie7J6huHFmU2pSfHfGnisGLARLsPVf7SrHuJfFU1MaHDrNb0
         XymgEn2CRXNq/7eyoPyQxEe5ek0XCC2kprcqZaCB4+Hl4AjJzsu+qh5kRXeUFixVxCnl
         x1qpuPzfuDQ2XHoEXxJ6d6dZAXtgGY0GPSysHauCDrpJJq45fwQsSyL8aDup5rbH31AM
         Fl03Ckp1ONaM8Uflgw3KUQJXwEA6p0sXGg76MnX6qEHE0Vkv+gpyrBPCIleCzy0tn4nm
         V1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052369; x=1761657169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCHpnqaCnmuQwlsQYxnl8jND0G0Yea1tAyo1BGydydQ=;
        b=vlYIJHh1atc9H1h0z8dab8XbdQOLqHymUf/7/QXe7RkTswcpcP9Nj0GyQqjYKO0pAs
         LxT58NMR97QWf8he2XopNN0I6BIF50+VmmnD4vSnx3pNlYzr40hs76IZBi2LAgkQIT0B
         yuCV3pHr6GKhTyYdpibsO69T0GdoZ1d38sbeiH36cVByDKmOXNWRrhahDUTg06FpV6c5
         KFfe/TIPu+0/h2Q5bYjFkehuJxZLzbZfSBe7iYOPk1GU0EjssNsRCV9gauoqDv+IGoUP
         po7TQGChmHIjAIkvbvq9f+8hNR0bj9rKlAJsIjoEuyKVSdEaNljFO9DAKvsb/C535yUU
         SIKw==
X-Gm-Message-State: AOJu0Yx6iWhzeHT1FcaFqkeKx7om8x/1s+oDkyBNBg3hPe7Fa5hvnSHb
	7ojIYKMlenJFr4WgLaSFIdRBBJG6EZ7fXAcTm6Fl3PJXHefzzjBhyW+J
X-Gm-Gg: ASbGncvH7UxTfJh3CAczuywaoBHo0p49kt6HsfisH4bKGcLq7hsrBMB+VYddAKksARg
	/hva+LAlWZ9jt0SclzHvLR8jQ8nrxzcPt4wVglUX9WS7Pro1j0GRjbxt7lSK4scGXtHQnSLdV99
	bKRfL6qvDfdX31MphLmhSJUp4ob+OTfGt8Z7Ykq4XnZwieKy6xJuN6Q9PPT0oFYcruK0vWEKt3C
	hnr07wzJC6P/gzhIbR85h5BxlOxfj/Wk9PACpEQUVkCDbrRii/u9wTVB0NzN+TltozjtJho+iuW
	0lyP+n5pr8tOrQXZrHOSCJ5/paHai8lV/2GI8/3wFM/gF8w+P8xtIazdIrKaxxJTfKX2JX8qEKw
	L6p6NeTINYyAIKq5zU2tKxKN2WlUh6O8EpnDKAaLXYj4FuDRzqC1dA0mwCzc2gOFyl3WoAF9nNT
	ZlstVn+gq7gzctLe6KdmUvIL4RM3lJpd7uTQtbvgRIKv9o/U4=
X-Google-Smtp-Source: AGHT+IEQCepTB3yxcvlRZKZP9O64GR2yI1M00dxCDtyyW8QGqS0i3xPN8kpiXo+wM2xE3qEX2u3PrQ==
X-Received: by 2002:a17:903:19e6:b0:273:31fb:a872 with SMTP id d9443c01a7336-290c9c89c81mr205906715ad.6.1761052368967;
        Tue, 21 Oct 2025 06:12:48 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:48 -0700 (PDT)
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
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 7/9] xsk: support batch xmit main logic
Date: Tue, 21 Oct 2025 21:12:07 +0800
Message-Id: <20251021131209.41491-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
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
2. read descriptors from tx ring into pool->tx_descs in batches
3. reserve enough slots in completion ring to avoid backpressure
4. allocate and build skbs in batches
5. send all the possible packets in batches at one time

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d30090a8420f..1fa099653b7d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -878,6 +878,114 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return ERR_PTR(err);
 }
 
+static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
+{
+	struct xsk_batch *batch = &xs->batch;
+	struct xdp_desc *descs = batch->desc_cache;
+	struct xsk_buff_pool *pool = xs->pool;
+	u32 nb_pkts, nb_descs, cons_descs;
+	struct net_device *dev = xs->dev;
+	bool sent_frame = false;
+	u32 max_batch, expected;
+	u32 i = 0, max_budget;
+	struct sk_buff *skb;
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
+	max_batch = batch->generic_xmit_batch;
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
+		nb_pkts = 0;
+		nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, descs,
+						     nb_descs, &nb_pkts);
+		if (!nb_descs) {
+			err = -EAGAIN;
+			xs->tx->queue_empty_descs++;
+			goto out;
+		}
+
+		cons_descs = xsk_alloc_batch_skb(xs, nb_pkts, nb_descs, &err);
+		/* Return 'nb_descs - cons_descs' number of descs to the
+		 * pool if the batch allocation partially fails
+		 */
+		if (cons_descs < nb_descs) {
+			xskq_cons_cancel_n(xs->tx, nb_descs - cons_descs);
+			xsk_cq_cancel_locked(xs->pool, nb_descs - cons_descs);
+		}
+
+		if (!skb_queue_empty(&batch->send_queue)) {
+			int err_xmit;
+
+			err_xmit = xsk_direct_xmit_batch(xs, dev);
+			if (err_xmit == NETDEV_TX_BUSY)
+				err = -EAGAIN;
+			else if (err_xmit == NET_XMIT_DROP)
+				err = -EBUSY;
+
+			sent_frame = true;
+			xs->skb = NULL;
+		}
+
+		if (err)
+			goto out;
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
+	/* If send_queue has more pending skbs, we must to clear
+	 * the rest of them.
+	 */
+	while ((skb = __skb_dequeue(&batch->send_queue)) != NULL) {
+		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
+		xsk_consume_skb(skb);
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


