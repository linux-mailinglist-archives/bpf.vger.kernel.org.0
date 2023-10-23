Return-Path: <bpf+bounces-13000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0347D35D6
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A45DB20DA3
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD818032;
	Mon, 23 Oct 2023 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AgFW9mzk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BC18023
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:53:14 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63A0DE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 04:53:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso25986825ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698061992; x=1698666792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OpOO/ujxo7qV6VnFj/vbc7gRpnZ29/Hl135s51sMGA=;
        b=AgFW9mzkVt5FKvoQ/pxyV5mJZJjs+7GrsRwDsUEtNH4aHIjgwT2TP+eCfbdxkrK3mW
         I1NzBQImL3xztARwgZMBzJi4aiIjN+17FAndZVaDTHMwPvdBcg2M1Nz+N9e9j0gRJZIY
         NMeS8D/HbCjpDJA2jV3e8uk2Q5ZF9TZaxQ5j6ImFga90Bz9fvxdweQ3Zg4OWd6vVwFJV
         kb3OumdXJS5wl+tF5D4aHeSJWyvbjc+uOLBJpj2Sx0+2rscTdrjZArVyzxtiF44Pp54g
         oV3A5H/WoS4eAgmKV3qPzkKhv3pEeMPECvSP2EEZo+d+Qi4u8wIb1n/UbFsBFtC+5WDX
         4ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061992; x=1698666792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OpOO/ujxo7qV6VnFj/vbc7gRpnZ29/Hl135s51sMGA=;
        b=DlL3nApF7pbOrQV42sTJGTYWYBnsNNxdZabFuuM0cGv1W2varN+QiFI8LATvUawHiL
         +OLumz2MuNy3wTT2ZLOmIhmnoY2J2QXSZmKHHjpnxaQduzaxRxX4hd5w6ZlI5Povk57/
         9U5jXu/UbJ0cruItC0j5vEHDT6s/Spll+Mtg6drWjiMgcwyELEmWfvcRAeDU3caLuVOK
         Nk4BIWM8iI8ijyw4sGbL8OxSsOOH1E3fFjnKh/CDj94YOrmCNtfR90w3dXKpsIVrVxQ9
         dddMlSn+Y/tlrTX/mqL+4kZZE9WXLZqYB816w3LU74FwPYMtTUvuDR4js6O0K7uRNvRa
         njsw==
X-Gm-Message-State: AOJu0Yw66jti/RRZT1mU1fEm0MCv1E46ZqDufLcARXMduQDyMOePpG+W
	4Mx5A5owdvuXBfmWYN5eKBVG2g==
X-Google-Smtp-Source: AGHT+IFSlvp9BLy+fu0YpJY2csGQHLq69ECo5byZ1gpHhXI2w9sJlTLTHPD+Z/0+59+tBVs/MvoO3Q==
X-Received: by 2002:a17:902:d506:b0:1ca:abe:a090 with SMTP id b6-20020a170902d50600b001ca0abea090mr9388853plg.62.1698061992110;
        Mon, 23 Oct 2023 04:53:12 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([240e:6b1:c0:120::2:3])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bba7aab822sm5835142pla.5.2023.10.23.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:53:11 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next] xsk: avoid starving the xsk further down the list
Date: Mon, 23 Oct 2023 19:52:54 +0800
Message-Id: <20231023115255.76934-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous implementation, when multiple xsk sockets were
associated with a single xsk_buff_pool, a situation could arise
where the xsk_tx_list maintained data at the front for one xsk
socket while starving the xsk sockets at the back of the list.
This could result in issues such as the inability to transmit packets,
increased latency, and jitter. To address this problem, we introduced
a new variable called tx_budget_cache, which limits each xsk to transmit
a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_PER_SOCKET_BUDGET is temporarily set to TX_BATCH_SIZE(32).

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  5 +++++
 net/xdp/xsk.c          | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..08cbdf6fca85 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -63,6 +63,11 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* Record the actual number of times xsk has transmitted a tx
+	 * descriptor, with a maximum limit not exceeding MAX_PER_SOCKET_BUDGET
+	 */
+	u32 tx_budget_cache;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..fd0d54b7c046 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,6 +33,7 @@
 #include "xsk.h"
 
 #define TX_BATCH_SIZE 32
+#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
 static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
 
@@ -413,16 +414,25 @@ EXPORT_SYMBOL(xsk_tx_release);
 
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+	bool xsk_cache_full = false;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_cache >= MAX_PER_SOCKET_BUDGET) {
+			xsk_cache_full = true;
+			continue;
+		}
+
 		if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
 			if (xskq_has_descs(xs->tx))
 				xskq_cons_release(xs->tx);
 			continue;
 		}
 
+		xs->tx_budget_cache++;
+
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
@@ -436,6 +446,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (xsk_cache_full) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+			xs->tx_budget_cache = 0;
+		}
+		xsk_cache_full = false;
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
@@ -1230,6 +1248,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->zc = xs->umem->zc;
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
+	xs->tx_budget_cache = 0;
 	xp_add_xsk(xs->pool, xs);
 
 out_unlock:
-- 
2.20.1


