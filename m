Return-Path: <bpf+bounces-7213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB549773799
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6CB1C20D9B
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3E3D6C;
	Tue,  8 Aug 2023 03:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD517FD
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:20:38 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D010DC
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:20:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbff6b2679so33589295ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464836; x=1692069636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSkaRhEoax/kU+S7BeIv84prtFC3VRpkmwXx3cyNhW4=;
        b=d6NExLM8tFgWdgX9G9vZowhLgc1yvXqs7IkLMLHXraFw++XbkXxgetWnrYgoDnH2PL
         bKoG+iR2qZdyLwagLCZt6X9V4gshueZ4JBNkk7hSH9GzbbXtE6DV8cFw2t6L291TW3Bl
         RkrxAU1mOtbcr70fK4bljLdaAEYWd4A5hr9wZ96t2zuuh/S5KsRZqo4l/VpAuTJk/0th
         pUM4uhplW0joZl356oAtpSoeLbDUed2TyxXYGQvRA20cg/tISFQFjAtUbYl0jgSapqG8
         fJpW3L2C0NbOqpLGIqYRwXCjCJ31gazngAztABsx8PEOY9U9Ou7Yy/RRiZiEIIQEcmLC
         ZkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464836; x=1692069636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSkaRhEoax/kU+S7BeIv84prtFC3VRpkmwXx3cyNhW4=;
        b=Em2m7eXwbkBYiVVgHZaJpI7fxQkXIWG8NzbuQmqj6v7h73W7oYmdGswz79iLbQZWKX
         BjnbtvnnrwObC2KoCGB87CzGBdxJ05+IephLRA3WSpmH6UrSIvbrJHW2mf+UEyxtJHjk
         V8qDerLdgfMK1E20MLM2R/t2WFSR4cGEjsvK2qvTDh3lWyJM6TAmkDTudEX3A22P2TQ7
         0BBtHvw+i80WN401o//NH0yOxCslDqy9bR/vnKHyyAtnDtmdk2lUrRKa8SU6reYY04qV
         ZAjSx7Tmi+ItkWWcSPGBieJOpc8mrKfbunS8XsEiq5ftLAIXZSvfeQQMV/QfDRHGfMBI
         cyCg==
X-Gm-Message-State: AOJu0Yy+8kqwPdqkn44eAqy4wC4ERTUDVVwK3mztRNJl2cdhpaAdzB0X
	VFnlNjh9FRXgxiwVwWjK66l1Jw==
X-Google-Smtp-Source: AGHT+IH2VXJ6Ghkxwofrs8nrrcDgKtW93x4dyG1q9rUxYCzHKLPem259aEOah6YsFt5u9x/X6BX1Lw==
X-Received: by 2002:a17:902:d48c:b0:1bc:1df2:4c07 with SMTP id c12-20020a170902d48c00b001bc1df24c07mr11625675plg.63.1691464836135;
        Mon, 07 Aug 2023 20:20:36 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:35 -0700 (PDT)
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
Subject: [RFC v3 Optimizing veth xsk performance 2/9] xsk: add dma_check_skip for skipping dma check
Date: Tue,  8 Aug 2023 11:19:06 +0800
Message-Id: <20230808031913.46965-3-huangjie.albert@bytedance.com>
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
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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


