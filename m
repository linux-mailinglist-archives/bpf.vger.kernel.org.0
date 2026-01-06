Return-Path: <bpf+bounces-77905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC8CF6468
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 02:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9749930119EB
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56522279DC0;
	Tue,  6 Jan 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cizdRs/4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DD26D4DD
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663086; cv=none; b=CMsDsB75+wqtqTV71J7XnpQ+0vA6b0Za8DMIDp8VBNKCvN8M1YXDlwubWCUnXFcNoCN18huVYYXCWK+/rZgsk2Fo7xLYYz3L/wqBC/BwX05o6eySRpjJJTdqzngEiY5ab444xvss3+SsGDr8cWWVtAHYWurE0Vaf9l5lEgoFu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663086; c=relaxed/simple;
	bh=iFOjWoPhxg3t7eBaMyFBLT+tXL3mjtPxiiafXceNxzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBv/iVLig7K9g0wcwVHKyctSTVkE3ydM0BdIvHsLWVfN0CL8N8Cr4DxplOQ174Ng06oxSWWsvInMuK0NdgCgWMmaV+FYSEb53DBgbciFCwdMuo/aq50hDkSoIpuDiK9lSDXQ7cW587ZDT4mEA+MzjUiVwW1o6JmUVOaLvE7LSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cizdRs/4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso429843a91.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 17:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767663084; x=1768267884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36dhxZqhoIQQhhEMrHz1gupE6TH8vQ91Ce45pP+oIbU=;
        b=cizdRs/4iMXJM0qhCIRftpm6RvSPGVCE667I5lpyfe3UtY14krYdfxM4BnjBvUYu+N
         DdfmsKgCoBn2Y4xkp1ZDYOzAvd4UlIRt+13ooqCxkDMJAmry1kxFn/LGCVyjpDGmQCk3
         9/2JWRc14m/Nj7J0CZxEDCJcOcNqUt0s6pml+zQ8iLDN8nrq4h5XOWOzVm95i/iBDDkz
         5my8zvoHJhe8Ma6uXzD/WhFTdH8l4e+4/324YRP3DGxpwQSuUErRrqO4wodL5JbCoiAb
         Sxk3yJ52NYLfS08cT9+hpyWPOXdUYGZY7OMmIh+PinQqyyfBbDqTg75jjWF638PL0elO
         ZTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767663084; x=1768267884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36dhxZqhoIQQhhEMrHz1gupE6TH8vQ91Ce45pP+oIbU=;
        b=CMqrCGqDEsnxhQxV0RdEQ3s5RfCx2ytKwb46t0p4VC4eatVo3VrsOfIVC0Qp0dg5K8
         zNAmZ77yZTvWln93+7DaB3r9YpTN7pamZDizuuHZFfEIElPEWmI/G9Eimdw2z0K8Lyb4
         RiuZwDHUiwXGxhRBkq4dJq4Ie5IFGw6xIXlAyWIz86csebk4ifyfyodsTTRDou/wWITl
         rQ4N3gc5zTUxjf85U8Bo5umMtyZgD8UNGt/YxLyDDMyiqwC/BvWekKig/2oKIJu0aDWL
         qXCIRBIiscD6z7jumqrp+O9Dd1ph5/3562cu4m7mvtPDnIrUJ7xBF/W28NIQ/fV9nkl1
         oiWA==
X-Gm-Message-State: AOJu0YwzFHtmEEO9S9XeZObd8PR/9GHHusMybt/In5oAXvZvVfT6Mj86
	wma3tbbMDo6WjigbPM7AnN8LuC4v9vHv8p0XmZgdEET1PSPzga6B1CVG
X-Gm-Gg: AY/fxX6d0iP4qmSgatf2yedG/uJIT0IG047NsnVPrA/NMy6omBThMK5cNdT/A4KYkpw
	ZdqPLML6Vs5HTreBk9lAvnAwir7hny5g5lfRq0h0gvupejZfUxDXB4unQEHVX8PCPhiX0gB3J9W
	rSeiGTtE6MLuVdihsII8OOVY7QPJO2Uy4Ej0Gsm9v1Acv+lwqSznVxn5PPJuaxrDuGQcDL1IfYo
	uuNXHaJyf7MtDheOGd4vljzVq73nSixKwwF1aQgvo31OqVCN/IuSj1jMZzas6racg1o/64Mi/Ae
	iyc/yoAH/l3D20U7KW/t7FDX62PUS7J3Yx8/Keaows3XHMpsdkbac03U2Nq5ykC3EhN0Sni4L6+
	Xv6OjhkpJY+xd6JYc/wXkM7/gMJpJ7DTLZmQvjv7CrkqnyHSMc4gCZI6ZrUGnQjPBTowMDmszR/
	EjDIpvVB+HWBbJb2m44sjfhkkHckA9ulWQTrYBXP/m5Hj8oLZNgAjsPC3/EA==
X-Google-Smtp-Source: AGHT+IErBTNSHUDX0zHCfa/WUUuMGzglARLgnRlxXuYU2Hb7tlAOlT4KteEsa05VTV0DkrnjSf9tHw==
X-Received: by 2002:a17:90b:33cf:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-34f5f280ebbmr949225a91.9.1767663084319;
        Mon, 05 Jan 2026 17:31:24 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa947ecsm544110a91.6.2026.01.05.17.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:31:23 -0800 (PST)
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
Subject: [PATCH bpf-next v4 1/2] xsk: introduce local_cq for each af_xdp socket
Date: Tue,  6 Jan 2026 09:31:11 +0800
Message-Id: <20260106013112.56250-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260106013112.56250-1-kerneljasonxing@gmail.com>
References: <20260106013112.56250-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is a prep that will be used to store the addr(s) of descriptors so
that each skb going to the end of life can publish corresponding addr(s)
in its completion queue that can be read by userspace.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  8 +++++++
 net/xdp/xsk.c          | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..c53ab2609d8c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -45,6 +45,12 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+struct local_cq {
+	u32 prod ____cacheline_aligned_in_smp;
+	u32 ring_mask ____cacheline_aligned_in_smp;
+	u64 desc[] ____cacheline_aligned_in_smp;
+};
+
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -89,6 +95,8 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	/* Maintain addr(s) of descriptors locally */
+	struct local_cq *lcq;
 };
 
 /*
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..f41e0b480aa4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1212,6 +1212,34 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 	}
 }
 
+/* Initialize local compeletion queue for each xsk */
+static int xsk_init_local_cq(struct xdp_sock *xs)
+{
+	struct xsk_queue *cq = xs->pool->cq;
+	size_t size;
+
+	if (!cq || !cq->nentries)
+		return -EINVAL;
+
+	size = struct_size_t(struct local_cq, desc, cq->nentries);
+	xs->lcq = vmalloc(size);
+	if (!xs->lcq)
+		return -ENOMEM;
+	xs->lcq->ring_mask = cq->nentries - 1;
+	xs->lcq->prod = 0;
+
+	return 0;
+}
+
+static void xsk_clear_local_cq(struct xdp_sock *xs)
+{
+	if (!xs->lcq)
+		return;
+
+	vfree(xs->lcq);
+	xs->lcq = NULL;
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1360,9 +1388,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 				goto out_unlock;
 			}
 
+			err = xsk_init_local_cq(xs);
+			if (err) {
+				xp_destroy(xs->pool);
+				xs->pool = NULL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			err = xp_assign_dev_shared(xs->pool, umem_xs, dev,
 						   qid);
 			if (err) {
+				xsk_clear_local_cq(xs);
 				xp_destroy(xs->pool);
 				xs->pool = NULL;
 				sockfd_put(sock);
@@ -1380,6 +1417,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			xp_get_pool(umem_xs->pool);
 			xs->pool = umem_xs->pool;
 
+			err = xsk_init_local_cq(xs);
+			if (err) {
+				xp_put_pool(xs->pool);
+				xs->pool = NULL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
 			/* If underlying shared umem was created without Tx
 			 * ring, allocate Tx descs array that Tx batching API
 			 * utilizes
@@ -1387,6 +1431,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			if (xs->tx && !xs->pool->tx_descs) {
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
+					xsk_clear_local_cq(xs);
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
 					sockfd_put(sock);
@@ -1409,8 +1454,16 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			goto out_unlock;
 		}
 
+		err = xsk_init_local_cq(xs);
+		if (err) {
+			xp_destroy(xs->pool);
+			xs->pool = NULL;
+			goto out_unlock;
+		}
+
 		err = xp_assign_dev(xs->pool, dev, qid, flags);
 		if (err) {
+			xsk_clear_local_cq(xs);
 			xp_destroy(xs->pool);
 			xs->pool = NULL;
 			goto out_unlock;
@@ -1836,6 +1889,7 @@ static void xsk_destruct(struct sock *sk)
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
 
+	xsk_clear_local_cq(xs);
 	if (!xp_put_pool(xs->pool))
 		xdp_put_umem(xs->umem, !xs->pool);
 }
-- 
2.41.3


