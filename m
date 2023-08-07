Return-Path: <bpf+bounces-7152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6C7723B2
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA70E2812F2
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F3101C9;
	Mon,  7 Aug 2023 12:20:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E800FC17
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:20:01 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6BD1BE8
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 05:19:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc6624623cso12030565ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691410772; x=1692015572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSkaRhEoax/kU+S7BeIv84prtFC3VRpkmwXx3cyNhW4=;
        b=lNSdc/+v7DVvIEdGXmh9m6TWjMuePx5ixHEq5A3moRUidZPbc2VkVmgz1HIHwnketG
         iYbjjR8DZZK5NGxcmtk9G8i7h01IWnAeFmogRREbWXxQdB2EObvt44H1JoEpCjKbiuHC
         T57RpuMx0LOtogAgDRmTcNHhLJhyJTLgUnc2UgsniuZpFVkr4JH6dprrwRSG2kSfmWgt
         wadkCo10VcLkZ+OEiFVhdCQdxybRGB5eoyhqF5gj/aQr4p6d9334in9xO74pK7dl6UVJ
         4d7212QuSx1U5p8qpETqLnQRyUeq2pHeC2RruKBBb4hgNQeHaypp1chUN9oxFR4w2mK9
         +A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410772; x=1692015572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSkaRhEoax/kU+S7BeIv84prtFC3VRpkmwXx3cyNhW4=;
        b=aqOh7xBfD7oocaf0Fjrvu6plwak6VwovHsFTkj+SLRrzQY+cSgFnMlCy/qwa9aloni
         9znHEbJHJdfoGdFMTUsqjerC/8/3E8+BHO3dbDyu9luHXOYfR9i8UAVl0Kkwo/GEgJCF
         yIu8t6JKT036LWNS2NxoZ48z4NJeflf7rYWIPhqsipxSu0T2CdG77GIbZt1K7OAgW7D6
         CJ91Ucaex1vVNIHHHR3LmWr62DRMfKuOXudvX9SbfiK+0YTCwPpb1dqYNzwT8hTs0+yt
         nt+5KGqJoVe+MFnGQAb67HkWjv0d6C7bTuTv/dRdMKt5krRYqhRxFMgu6bzBElTdNIZX
         6ELQ==
X-Gm-Message-State: AOJu0YxfR+BuNDydQDH0rpsRUWDCgmBaLA/d8E9Srfn1Ome40QlpBofE
	PHthjTjWpBNqjO2ZYYCqwSpHKA==
X-Google-Smtp-Source: AGHT+IG0EOJYPbVCZdHWLuCBSIWm1P+FwFwIuu5YzmQQNlmkkc7aqTPCBYttrj4ssxYQsG4YxAEaPw==
X-Received: by 2002:a17:902:e743:b0:1bb:8e13:deba with SMTP id p3-20020a170902e74300b001bb8e13debamr11182082plf.11.1691410772101;
        Mon, 07 Aug 2023 05:19:32 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001b9d95945afsm6758444plx.155.2023.08.07.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:19:31 -0700 (PDT)
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
Subject: [RFC v2 Optimizing veth xsk performance 2/9] xsk: add dma_check_skip for skipping dma check
Date: Mon,  7 Aug 2023 20:19:17 +0800
Message-Id: <20230807121917.84905-1-huangjie.albert@bytedance.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

for the virtual net device such as veth, there is
no need to do dma check if we support zero copy.

add this flag after unaligned. beacause there is 4 bytes hole
pahole -V ./net/xdp/xsk_buff_pool.o:
-----------
...
	/* --- cacheline 3 boundary (192 bytes) --- */
	u32                        chunk_size;           /*   192     4 */
	u32                        frame_len;            /*   196     4 */
	u8                         cached_need_wakeup;   /*   200     1 */
	bool                       uses_need_wakeup;     /*   201     1 */
	bool                       dma_need_sync;        /*   202     1 */
	bool                       unaligned;            /*   203     1 */

	/* XXX 4 bytes hole, try to pack */

	void *                     addrs;                /*   208     8 */
	spinlock_t                 cq_lock;              /*   216     4 */
...
-----------

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xsk_buff_pool.h | 1 +
 net/xdp/xsk_buff_pool.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index b0bdff26fc88..fe31097dc11b 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -81,6 +81,7 @@ struct xsk_buff_pool {
 	bool uses_need_wakeup;
 	bool dma_need_sync;
 	bool unaligned;
+	bool dma_check_skip;
 	void *addrs;
 	/* Mutual exclusion of the completion ring in the SKB mode. Two cases to protect:
 	 * NAPI TX thread and sendmsg error paths in the SKB destructor callback and when
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b3f7b310811e..ed251b8e8773 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		XDP_PACKET_HEADROOM;
 	pool->umem = umem;
 	pool->addrs = umem->addrs;
+	pool->dma_check_skip = false;
 	INIT_LIST_HEAD(&pool->free_list);
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
@@ -202,7 +203,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		goto err_unreg_pool;
 
-	if (!pool->dma_pages) {
+	if (!pool->dma_pages && !pool->dma_check_skip) {
 		WARN(1, "Driver did not DMA map zero-copy buffers");
 		err = -EINVAL;
 		goto err_unreg_xsk;
-- 
2.20.1


