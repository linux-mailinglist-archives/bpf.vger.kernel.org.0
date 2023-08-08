Return-Path: <bpf+bounces-7215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100397737A1
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415D31C20E0D
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0379D5;
	Tue,  8 Aug 2023 03:20:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FA1C29
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:20:52 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE010D1
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:20:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so45762835ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464850; x=1692069650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhqzuKs8acODjWqieOr60TzQPrln+0aaO9utMxKEwXY=;
        b=OJL9LrbSgQt70QJMij8iZC+JU41pG03VeJ0y7Nl922F2ZaU7U87A5B753UGGc0Yzx1
         /bOWzzKWiz5MHCq3MgepwcOP88c3QaVKgVkTsFPHfIKsB1CIEy7ISR3PzFTQvfTVch3s
         WnjevnnH9SsiyAEF6GrygCCohR3vtxY6qtYmJVOnIJAzQC5P3SlBXIP0HPbiUcyU/Tpg
         WzO3Noh9RFrUXrGlfzBi0PbKEYMSibgslfmMf83UoYgMOmjvVh7T/nHKLh9NspmzZ0bp
         ZmzvtRNd6WNniQsh/hzTpgIkY/Il5uuKqN/T/P4pQ1UI1p7bI63YzkuOWTSh/Dn//l3M
         qjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464850; x=1692069650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhqzuKs8acODjWqieOr60TzQPrln+0aaO9utMxKEwXY=;
        b=TS84LsIdmgNJdIxBpdH30TRFv0uI4iMy6SvKSsVmA2BTxyNEazPRRCwyCNz6e2j4Gs
         aom0IZPY13sPW1p//P8DCcRXttIcZ0cd+9qkudfxPfWKYw+jZ1+zIksIaICXGllNvWp+
         g2c0s9IraDohXngvOAxNFnzucHax21ZnwpcdMBYCK5XanSjQ6xCOO3j2Fv0zYuD2k3Vs
         O4ZltNOpjHtoIr0j8ZqpZrw3ZMQbRjqKliFDFsM5wnOQUc3ofobT9chdZ+WOdoI5U/Qe
         HzX5G/2RRCAiC1F8ye9VVnHsIMaSpdjjOiHtKvi9Ty9LO01DRkFvjup9h/+9jTCMeMjB
         4NfQ==
X-Gm-Message-State: AOJu0Yz6vJQk1nsk7NpcPvXKTFD+oAhN9LgPgWJXrdLd14Tjl1YRm2Bq
	/O1FGKUn/yIhrv59gzwec2cGJA==
X-Google-Smtp-Source: AGHT+IFJntj41Gt0ECRGUl7vLwT94BPvXtio+ZQROoGCzVRtLpUoICA2rzvmhhrD1xkeCfFkMSjNtw==
X-Received: by 2002:a17:902:eccc:b0:1b8:1335:b775 with SMTP id a12-20020a170902eccc00b001b81335b775mr13965313plh.0.1691464850307;
        Mon, 07 Aug 2023 20:20:50 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:49 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 4/9] xsk: add xsk_tx_completed_addr function
Date: Tue,  8 Aug 2023 11:19:08 +0800
Message-Id: <20230808031913.46965-5-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Return desc to the cq by using the descriptor address.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock_drv.h |  5 +++++
 net/xdp/xsk.c              |  6 ++++++
 net/xdp/xsk_queue.h        | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 1f6fc8c7a84c..de82c596e48f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_XDP_SOCKETS
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
@@ -188,6 +189,10 @@ static inline void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 }
 
+static inline void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr)
+{
+}
+
 static inline bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
 				    struct xdp_desc *desc)
 {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4f1e0599146e..b2b8aa7b0bcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -396,6 +396,12 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 }
 EXPORT_SYMBOL(xsk_tx_completed);
 
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr)
+{
+	xskq_prod_submit_addr(pool->cq, addr);
+}
+EXPORT_SYMBOL(xsk_tx_completed_addr);
+
 void xsk_tx_release(struct xsk_buff_pool *pool)
 {
 	struct xdp_sock *xs;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 13354a1e4280..3a5e26a81dc2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -428,6 +428,16 @@ static inline void __xskq_prod_submit(struct xsk_queue *q, u32 idx)
 	smp_store_release(&q->ring->producer, idx); /* B, matches C */
 }
 
+static inline void xskq_prod_submit_addr(struct xsk_queue *q, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+	u32 idx = q->ring->producer;
+
+	ring->desc[idx++ & q->ring_mask] = addr;
+
+	__xskq_prod_submit(q, idx);
+}
+
 static inline void xskq_prod_submit(struct xsk_queue *q)
 {
 	__xskq_prod_submit(q, q->cached_prod);
-- 
2.20.1


