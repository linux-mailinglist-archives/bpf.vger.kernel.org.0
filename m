Return-Path: <bpf+bounces-75326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB8C7F5B9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 09:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2893A718B
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD442EB876;
	Mon, 24 Nov 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J94GZua9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6612E7F20
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971762; cv=none; b=L4Wr76mpCL9o4di2NNW35RPWH1EOt+B/3Klw7gRZ5c51q0EFDnKA8qDtQr57BfioHdgLaaYLC1mgfvxZFA0oMLgtpxRcO5/zCqxX3dc8cRgA9O9rz5ihhHaNiYme2iiRCoBw2ZGCFzirgwt8+bIbP9gPMgWPrV3vFMKIqp/Hncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971762; c=relaxed/simple;
	bh=yRucNszLhPXziuTevNi/9yYpfz6kjluRLAOnz8A3h5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYqhPYeiDrrcOOv6CKLw+fo1speyiUukCDq7tYR3ovo+NaFKsBb4/TdnEAS2zOFnoxdTS1LcyRXenEsJsk8dm7BiWOnD1IOo2maF23cD4BpXdglh3s4ORhxwifgmas5wkVkndwrloT/kSFJyC14q04fmCT/853YkNyoXQfH30oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J94GZua9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ba55660769so3422292b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971760; x=1764576560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYuVS2ay8Y6ag2txRhCrTYCj7N5x3O3OwF7222Qufzw=;
        b=J94GZua9OhCelY6f9vzm9qpAkImz1k8+ytraKoC3FbNPsIEhiF+A55IlUSXe7cDNYb
         WQxNRO3qM+8+NrlMnY+UjTNlIwRjeSZKX/OHft2sv3tsWKM0Bp1GTv/lk1sm6iFhqPWf
         GRnhDOMGB01Ezotb2adOnfbjIxbFSrWR7DOltoVDCsgG25MMG51Oh7T8ka0ziR+kBAgx
         b+/M5JWhCignvGNVHC0QvAE0+0QNn3QcOO10e2WwHuHwNQsFSDYlGdxitWID3njCP199
         BdMwE4+m6zRfBmEGxUv/drd2wJ/Nqzj/RUDvqIYvTEqlvs7EGjow3FcOiYkNZrGCe1mb
         2jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971760; x=1764576560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYuVS2ay8Y6ag2txRhCrTYCj7N5x3O3OwF7222Qufzw=;
        b=SiHN4mZlfyo6N3v9rrFVZaeT61V4PEUdUXNOYkWy9mSXJaD5Ez0mGnZF3KZ8iLTv2X
         ylRMZKY8XFBlIjNrc+7q4wZW1nVD7LaVpGrnWNQG45tUdtwrY6rsOsoTXIR6CVqEASxS
         3i25DXHZD90ZvQ+/ezSnMvkFDsJJHP744k8jApW5oAegUg76bZUpXmWpw1Y995Xf+raV
         REBXVHTWh+TaC6ZZ3kHuZlZrGxjga+ND/qVjW0u/guqgeWLtoe6CdJePqFXVehv1hh05
         wcmB9GaeujyEiqidp1vREEwmHwW42wTYJJUwyxd/rskOZ4FoNj8BigoMwKjrtKmqffF8
         zr0A==
X-Gm-Message-State: AOJu0YxqxAsm/k8kQdoK5SHucx0ukfmxPGlCx+ezjBcdRBzDPTu3xeE1
	WFz5HmRW9VmzXGMvHxzfbe+1hEkS3qWqiMkzix6btw96Zaq84tzdK8Ym
X-Gm-Gg: ASbGncuCMhlRTsI33OjOiapOz9j6c51AA0HTo7lGd7xbLgdwwUOY+vI0fw1CxPijro2
	IVF8Qghxkskxvvix7sJg4Tf9O4oSBFXy/s3tszuYp4sM37aNLOfkCzGWj0wnr89y8sOPqGP+5Iy
	bRA0Ke27IUzzkxNZGSx4+Fl4ZSuX9KhRROFI7eA42qe7nEIuvHfK2JJaqIC52aEp+0+zYya63kr
	OV1QDQ8yWcNEqE0QfP7N2k4D1zW0bdl6Ho8PnfBCTUkbhOjhRmJN1MvGC9QknGusRe0+Dv7Ei2U
	ghMoGqlFStqbBg3Mmg+gwXJOcAC7kc4eevtJPh3vB36tca04tKWLGw77Be8uAY7Z4J+xQbe2Vf3
	wXEvvM18Jz5d+WLNPqI1Hwp5rcML+sSbv+DhDZO7Q3Ui1JpOcJDLkszEU8+fUIC9d5hFY3inxDr
	8uhZIBt7xQXz7BFD8O+djiVoHKxr0DfyBLGfoMefatNsNPf8iyP42DOJMAfFiZuA==
X-Google-Smtp-Source: AGHT+IGdwt67VP/NWG1GQPsybq7EpbQfPqvSOGbrDBGPi75ncgOXY2DQj0GMNNuNIB77jHsgoC9Mwg==
X-Received: by 2002:a05:6a20:244f:b0:347:67b8:731e with SMTP id adf61e73a8af0-36150e5f6ccmr12945928637.14.1763971760407;
        Mon, 24 Nov 2025 00:09:20 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:20 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/3] xsk: add the atomic parameter around cq in generic path
Date: Mon, 24 Nov 2025 16:08:57 +0800
Message-Id: <20251124080858.89593-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251124080858.89593-1-kerneljasonxing@gmail.com>
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

No functional changes here. Add a new parameter as a prep to help
completion queue in copy mode convert into atomic type in the rest of
this series. The patch also keeps the unified interface.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       |  8 ++++----
 net/xdp/xsk_queue.h | 31 +++++++++++++++++++------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index bcfd400e9cf8..4e95b894f218 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -276,7 +276,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		xs->rx_dropped++;
 		return -ENOMEM;
 	}
-	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+	if (xskq_prod_nb_free(xs->rx, num_desc, false) < num_desc) {
 		xs->rx_queue_full++;
 		return -ENOBUFS;
 	}
@@ -519,7 +519,7 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	 * packets. This avoids having to implement any buffering in
 	 * the Tx path.
 	 */
-	nb_pkts = xskq_prod_nb_free(pool->cq, nb_pkts);
+	nb_pkts = xskq_prod_nb_free(pool->cq, nb_pkts, false);
 	if (!nb_pkts)
 		goto out;
 
@@ -551,7 +551,7 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	int ret;
 
 	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xskq_prod_reserve(pool->cq, false);
 	spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
@@ -588,7 +588,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	spin_lock(&pool->cq_cached_prod_lock);
-	xskq_prod_cancel_n(pool->cq, n);
+	xskq_prod_cancel_n(pool->cq, n, false);
 	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 44cc01555c0b..7b4d9b954584 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -378,37 +378,44 @@ static inline u32 xskq_get_prod(struct xsk_queue *q)
 	return READ_ONCE(q->ring->producer);
 }
 
-static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
+static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max, bool atomic)
 {
-	u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
+	u32 cached_prod = atomic ? atomic_read(&q->cached_prod_atomic) : q->cached_prod;
+	u32 free_entries = q->nentries - (cached_prod - q->cached_cons);
 
 	if (free_entries >= max)
 		return max;
 
 	/* Refresh the local tail pointer */
 	q->cached_cons = READ_ONCE(q->ring->consumer);
-	free_entries = q->nentries - (q->cached_prod - q->cached_cons);
+	free_entries = q->nentries - (cached_prod - q->cached_cons);
 
 	return free_entries >= max ? max : free_entries;
 }
 
-static inline bool xskq_prod_is_full(struct xsk_queue *q)
+static inline bool xskq_prod_is_full(struct xsk_queue *q, bool atomic)
 {
-	return xskq_prod_nb_free(q, 1) ? false : true;
+	return xskq_prod_nb_free(q, 1, atomic) ? false : true;
 }
 
-static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
+static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt, bool atomic)
 {
-	q->cached_prod -= cnt;
+	if (atomic)
+		atomic_sub(cnt, &q->cached_prod_atomic);
+	else
+		q->cached_prod -= cnt;
 }
 
-static inline int xskq_prod_reserve(struct xsk_queue *q)
+static inline int xskq_prod_reserve(struct xsk_queue *q, bool atomic)
 {
-	if (xskq_prod_is_full(q))
+	if (xskq_prod_is_full(q, atomic))
 		return -ENOSPC;
 
 	/* A, matches D */
-	q->cached_prod++;
+	if (atomic)
+		atomic_inc(&q->cached_prod_atomic);
+	else
+		q->cached_prod++;
 	return 0;
 }
 
@@ -416,7 +423,7 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 {
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 
-	if (xskq_prod_is_full(q))
+	if (xskq_prod_is_full(q, false))
 		return -ENOSPC;
 
 	/* A, matches D */
@@ -450,7 +457,7 @@ static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
 	struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 	u32 idx;
 
-	if (xskq_prod_is_full(q))
+	if (xskq_prod_is_full(q, false))
 		return -ENOBUFS;
 
 	/* A, matches D */
-- 
2.41.3


