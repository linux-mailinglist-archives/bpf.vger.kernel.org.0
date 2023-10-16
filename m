Return-Path: <bpf+bounces-12248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8547C9DA7
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 05:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D3B281653
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804481C14;
	Mon, 16 Oct 2023 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="efevaxTD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E17185C
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 03:17:10 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416ED6
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 20:17:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c87a85332bso35029835ad.2
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426228; x=1698031028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gcDF6obS9msoNGbrvp8VjI3eEmOOKndQkCumFLGk4Q=;
        b=efevaxTDxwJGJGS0dUk31db53gixwaHeSqy55hTLRJd/aVWej4JZAd7FjlCe78XrUu
         KFbc9UKoSoKfH/+rgsc/4sg5jS2BqBL1boHp5L9b7SnrNH/K8bUJ25R+5y2BKQjW2Mmu
         5N83kD9Qxp5KzbvznX55REYGDQxRJKTzs28+EeGxqixG5yduhCmnGEZELYmhFoWpaUKJ
         IXWjyDEqI9Umt/4MWUSK2muG/M4v3WDI3HvB4lQiLoqvNC67LXsQ3RM0pEbQSzAY3kyh
         Q8rT53qDVNo/+HCx/me0NiOgSMGEib+ma27B9KxYXRC3wCrHT/+6liqO/WiPcH9JFex/
         Ue4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426228; x=1698031028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gcDF6obS9msoNGbrvp8VjI3eEmOOKndQkCumFLGk4Q=;
        b=i5suBXCoZpc2o2JdahvLwOcEY9qfKN8gEgQgOV/RiPWPP8wxpeiTz8FUYWGMR7zds3
         h6ZrYpyt1rZp5XnaIxOcR4ZNlRr19YZFlGGdVqw41oAO2VmhxQ9uoowU63tLPHbE3FkM
         q5V0fXwCNsy/lPamJHjWG6TZo0EE7aGY6m9JBxdFV+PVqwgq4UfywnzbgwVyLrKjdx8P
         E3Yi7ivJmGvrkF60S6KVFolbGhBdCbaUW6zO9cEWtQdQlcw47CI59PHTogUiPBr+a0wN
         EA2Gwx7YGMa15UHWLlSwmqcYcWnBnf4LKzlBouRrxxqQGGR8xRWBUL81nulNwKqZtlph
         h9hg==
X-Gm-Message-State: AOJu0YzBV9+sWoLaetKYOubXToKofU6mHekmTf/iq2Y60hyxZaFXhTuh
	+B2Gc2OzSUXJPvjV6CGFqGtETQ==
X-Google-Smtp-Source: AGHT+IG/AkDpyZ/tVSGq9dCcSfxYTyeru3TiqUeRhv2rK+sA9A8t/AMd1s2NWxUK8WU13xEjJOxsmw==
X-Received: by 2002:a17:902:f14c:b0:1c9:e0f9:a668 with SMTP id d12-20020a170902f14c00b001c9e0f9a668mr8430661plb.18.1697426227817;
        Sun, 15 Oct 2023 20:17:07 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902934c00b001b9da42cd7dsm7320172plp.279.2023.10.15.20.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 20:17:07 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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
Subject: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
Date: Mon, 16 Oct 2023 11:16:48 +0800
Message-Id: <20231016031649.35088-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the previous implementation, when multiple xsk sockets were
associated with a single xsk_buff_pool, a situation could arise
where the xsk_tx_list maintained data at the front for one xsk
socket while starving the xsk sockets at the back of the list.
This could result in issues such as the inability to transmit packets,
increased latency, and jitter. To address this problem, we introduced
a new variable called tx_budget_cache, which limits each xsk to transmit
a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_XSK_TX_BUDGET is temporarily set to 16.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  6 ++++++
 net/xdp/xsk.c          | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..f617ff54e38c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -44,6 +44,7 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+#define MAX_XSK_TX_BUDGET 16
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -63,6 +64,11 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* Record the actual number of times xsk has transmitted a tx
+	 * descriptor, with a maximum limit not exceeding MAX_XSK_TX_BUDGET
+	 */
+	u32 tx_budget_cache;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..087f2675333c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
 
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+	u32 xsk_full_count = 0;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_cache >= MAX_XSK_TX_BUDGET) {
+			xsk_full_count++;
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
@@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (unlikely(xsk_full_count > 0)) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+			xs->tx_budget_cache = 0;
+		}
+		xsk_full_count = 0;
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
@@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->zc = xs->umem->zc;
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
+	xs->tx_budget_cache = 0;
 	xp_add_xsk(xs->pool, xs);
 
 out_unlock:
-- 
2.20.1


