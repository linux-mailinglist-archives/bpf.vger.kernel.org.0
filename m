Return-Path: <bpf+bounces-7154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340CB7723CF
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E227A281322
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB11101F4;
	Mon,  7 Aug 2023 12:23:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986B101EE
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:23:45 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFDC128
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 05:23:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc7b25c699so589865ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411023; x=1692015823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foBrBXdOwtDKCq/cydfflnj4IbGd0R2nKQL39Yldago=;
        b=GnmYBiNpOf2ZKoNDZSeQ7wUkAcu+xKnDmwbHrK34Y7Ua2erUZDLoT8JJxk5fl8TGiB
         OoHuCCiTUoQ2wtEX7kztN7VB5MCCVQGv/wy5MNOVhivYLoAGl9+OeQx/Kw/+jDyh+IZk
         Xf34XG9jJ7w+QASgtv2fyUxkkyrMGyP6/I0vtcn4k1nIAQ0LStSdIMZUtZi7KPcerJJm
         ttyh2eo2Mr2IAudL5/+IPgdfq3sDTaPtRnlakn9I6901GtcSgiHbI4JxFOOvxNdmgD/v
         L3YtslWMidkywD9iDeTKaE3PmiyYyUFd8OWljozaVGFRKrWaaUvz+k4RQubOkOeKf9I2
         XGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411023; x=1692015823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foBrBXdOwtDKCq/cydfflnj4IbGd0R2nKQL39Yldago=;
        b=M0r5t1nZ+lQ0Z5uhbbT3WerIBxmOpUMoFTFDKhCmKTldZgRe2sScH79OKb2V7QRQMv
         J+Xb1LMnIcXb7M78yCozgeZl3yVNGbU2RiKTTCkOcIiPKcdJ79TvLMva7tXEmswV9bBk
         /hvqJnpcpbsTT85wTvqv5a8o7mzB2s4vjzkJah7JT9nkmJ7ea2sFpu6tYVbASpyXo50e
         kXq50PTBZxU+v3KLss98Bur/WrowHYhvNRhh6SqoY6EbJQt3ha/NACzGDLVkCKy9FATn
         qBHGIBqaRCpuBoGTrPNocKs4ciaxravdTZI7EWdvWsVgMRSDp58xYU8LbTDf98PZHker
         05Cw==
X-Gm-Message-State: AOJu0YyBgVTl9BICb4HROMtT7vT0hmO6Gun4QIyGFCtSeOYNHI9h4pjw
	2meYd7z4wjD8o31EpINlcYSguA==
X-Google-Smtp-Source: AGHT+IHC5uCrys4OzS5COe5Y4fFinKxUPnbKTC2Fp/O9uWUOctQ/U/MnuwwTmOi5qU48U+ui/3Lqbg==
X-Received: by 2002:a17:903:18d:b0:1bc:5d0:e8e8 with SMTP id z13-20020a170903018d00b001bc05d0e8e8mr8191638plg.20.1691411023337;
        Mon, 07 Aug 2023 05:23:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001ab2b4105ddsm6766864plg.60.2023.08.07.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:23:42 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org (open list:XDP SOCKETS (AF_XDP)),
	bpf@vger.kernel.org (open list:XDP SOCKETS (AF_XDP)),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 4/9] xsk: add xsk_tx_completed_addr function
Date: Mon,  7 Aug 2023 20:23:32 +0800
Message-Id: <20230807122332.85628-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Return desc to the cq by using the descriptor address.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock_drv.h |  1 +
 net/xdp/xsk.c              |  6 ++++++
 net/xdp/xsk_queue.h        | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 1f6fc8c7a84c..5220454bff5c 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_XDP_SOCKETS
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
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


