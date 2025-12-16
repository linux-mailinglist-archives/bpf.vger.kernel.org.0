Return-Path: <bpf+bounces-76683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD56CC1039
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64160306A05B
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 05:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11D32D440;
	Tue, 16 Dec 2025 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLUROdA8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F623346A0
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862812; cv=none; b=P5+xjPO1rlnKiipld1van/wtdq9SRBJo2Txyj6KhIUELswgC1q+QOnY5d5nxAQxDPtTufqhX6DprLbGZN4PMOzncvLXnIDXTxcLSIln2uJzRnZmgZsdQXiGzi5qGpDAu/f4krIxCjEuXBPIdCzSe2R6XAFGnx52dKy1O9Q5NBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862812; c=relaxed/simple;
	bh=LNQTmx05UfHa7+kjeseQeGFPRDNqhugipZZe0P2hlCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHb1FZw111oj96XxMNL/uUpLpF3+cMGU/Jwwk4w+RQo2HsYsVOd2vhS1FGxF9YrqM00a2podHHNRyA3RxS5TISMAVRynX7v3F8dZe88q2/I6TkM+4TTitSOxpRTaT9DYFWJrBE7t4laWbVaqPlIoUI4o804SqT0vRR+h8iOAqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLUROdA8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0a95200e8so21301245ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 21:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765862795; x=1766467595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45NfsAeZxXjlvrV+xPVwCfR5PZ/N2G0Ef2M0M7B0EmI=;
        b=GLUROdA8oWWVUjJ+U38FoIuxZuO4ayBFejJOyO4xOcrpzT3juKkEOcnF84XPg8aFTt
         0omhwxsitWJr1TjQ3OaWpbUCT9pOhReGosJXTySXwzNgvLrN7cB0jLWW7JkrcoNMwXpz
         cJ6sTnZyrKz/FY++N/ZCL7wIK7IGvucDyvWXIymXeCIFYynuL5LCnoHzdVvwtWGtewbg
         z6LwtTHtP8uSPp5BRoLqk+yYVZF6H325GmCkGeAE18puEsfsru2KbgmBskxinPgpK+pu
         VU6w7O/J/o2SmotZkEiMbGIVSd74gtmj9jvdK2mgZ5pF7AqhAFSfDaCEbUV6f0cq8Fzv
         Rw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765862795; x=1766467595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45NfsAeZxXjlvrV+xPVwCfR5PZ/N2G0Ef2M0M7B0EmI=;
        b=p+VjMU34/Iqv0m6gpQSRB6oSZ5wCY4+M43s0lM8oyuOoK3FVz/sDjuLZxYEkze1Ape
         H2AkdRzhwsAmECqmti+92qb3ZR0rR0IxKZWm66W9r9s7xXJzcw9XeXIlZYAfX+PBxyPC
         kY7gjn3O1sKTmLFh5gWg6DGob+W/sVmg3qhNQe+IlKt9DXA3O3p2QENR0wQ33/CX6K+F
         luObY4EmlDGUUKjGSICf/dSNvDWPIxMlLroMmP1sXKJ3QMbNnC5P5gVRCZSVTYzNZQKo
         /Xw7DCDce0nqeUMwkIMAhl9me5IHxD9V3/jZqnmSSCMtTuH4TNxhU/fZuU4qgDZEjW6U
         rGbQ==
X-Gm-Message-State: AOJu0Yw7gBGDFOws1Gn3hMKDzoeTIs4IEiJ4SAQlXLw+yjRksST53lS/
	iytFTegDTgZx1zlEZvFmQ5hZrU1/yNBGv+aGae6p2Y7o45L6UY4tp96q
X-Gm-Gg: AY/fxX7CxV+CztxtiHF8VedP3qFGZIYBc6GYtifYRrKu9GXDfMoMSVqeEjEFJYBLGsu
	q8G4HPAY4XwxZalIk4TaYSVEf85qO6n728jZHqJ5G83bmcN3ZSNiRwuDpLqJHBfBHPRso2L3yta
	iRIECQ9asHnSlXlz9yNn/d8OhoGNZiLZC/b3pR5AT7HDmsyaMRhD8pcJqgBg/RcsxKEa1Mt1Jtg
	L9N/7bzE1os1jQxxZ6Hmcb/NLV9PJXBTYTNVbo4q6dhfyDZtmpv1nKxgoh6LWMvHv2pGoqEvVM3
	yrpQbDBblRH23xynfi4H+jKX7RY/DwUfafn8MI6HnXpOP9cxyvBr5SzLuT+GqzJ0yzlkiwTPALe
	oZtjthLN+uTArXLsgvaUbUgILzhx/8st8nn+Xg7x1kswPCYmpOvP3CFgRlSmCoONRq+OJ6NxHct
	MUfDR0IM464K9ggjP15H5tmozTbtAZEtJ5YSA0OqLd0v2QX2iunqq1eLxxBg==
X-Google-Smtp-Source: AGHT+IGJ5+lCrSa/xUUrEqZPjqMKwh+vrFqSUwSK5bMaWvBDa5kZrSceIJZlo6ya9usy7+oafXakLA==
X-Received: by 2002:a17:902:d551:b0:298:1013:9d11 with SMTP id d9443c01a7336-29f23caa21amr123368905ad.43.1765862794756;
        Mon, 15 Dec 2025 21:26:34 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ced60ff4sm61302145ad.76.2025.12.15.21.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:26:34 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] xsk: introduce local_cq for each af_xdp socket
Date: Tue, 16 Dec 2025 13:26:22 +0800
Message-Id: <20251216052623.2697-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251216052623.2697-1-kerneljasonxing@gmail.com>
References: <20251216052623.2697-1-kerneljasonxing@gmail.com>
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
 net/xdp/xsk.c          | 50 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index f093c3453f64..9b637d5e4528 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1212,6 +1212,30 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
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
+	vfree(xs->lcq);
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1241,6 +1265,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	xsk_clear_local_cq(xs);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1360,9 +1385,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
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
@@ -1380,6 +1414,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
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
@@ -1387,6 +1428,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			if (xs->tx && !xs->pool->tx_descs) {
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
+					xsk_clear_local_cq(xs);
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
 					sockfd_put(sock);
@@ -1409,8 +1451,16 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
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
-- 
2.41.3


