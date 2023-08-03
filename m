Return-Path: <bpf+bounces-6859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558876EBC2
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F561C21575
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09521D4C;
	Thu,  3 Aug 2023 14:06:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE03D8E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:05:59 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E60422B
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:05:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb893e6365so6840405ad.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071534; x=1691676334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+EKFuLLGda3oiEd1qoWkJ3WKIdEe7yI+fFIgxoez3I=;
        b=fwe4/jwUmizIlQByLG/O10dPGK2dq5O1KyDOna7TN71l452ImeRZyualxarybGdLTE
         KSINW/D7yJGI/aFLQkhxK3+64JQiodpZvCwoGQg9YTTRbW5UIBKGDIGqSCDZc0josq2d
         2P9Mp7v9JLZYEnKdld7C+HuTI+F9QlP+06UlKoisZWQYVZTBEVOxhHgulrtl2LX2dsLj
         T14TWHGsmOO/0dAKlV2/RtTPFXi7/aWi6ccZCUGBq76s4ZGEvQgdo9wugFVEtweVmFCk
         koL+jVBuohHproWlNCAlhWsk57vd+MbRFaTzJhLqjDR+JpizjbmPbOzaXkgS2AvXJWJo
         PDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071534; x=1691676334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+EKFuLLGda3oiEd1qoWkJ3WKIdEe7yI+fFIgxoez3I=;
        b=g26IjNUcxRs6odvIYQN4n+oPFW+VKJQvHqz5tm5OcDLFSQWlqRJCGt8o/CoBf+3gOR
         rm4HYVp9BqFAC+gOqgIAOsohIZW4d2cJkZv0PWFmIEgOCOeXVnJUc7+zu+J/14LKp/F5
         4o/rr2gl/1vbXrDvASn5vp3ONNQZ0JlhjO3PjnnJmeXgXKSpfrVdj37gjz2r4jZMOebd
         xtmEzRa4V0wg3GkxJyaHrhrXwVSUqiCrH6sFFoa297+cG4XanW2CcxzmIDatS/wnxjfr
         NGG0bCzr9vFNYXQ8wv51jQTKaE+dbZ0tgmb+vNKqGIDSMi0JvEMcJ5MrYrlJGLyOH6Mz
         /cPA==
X-Gm-Message-State: ABy/qLbdYpyswKeCgvoVpC/oavWKxi6l0/J3UNVvScmBKqzkFo9ltNYW
	rG9HYTfOlEjg56NYEn3BcJY3OA==
X-Google-Smtp-Source: APBJJlGHmcO6FVU+0C9TTuH74fwzKYtkeokBQvVwLyE+muThaGpUX7ZWrGdCmBMnIU1ezs9YL+1y/g==
X-Received: by 2002:a17:902:e811:b0:1bc:2c79:c6b5 with SMTP id u17-20020a170902e81100b001bc2c79c6b5mr7539181plg.4.1691071533982;
        Thu, 03 Aug 2023 07:05:33 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:05:33 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 02/10] xsk: add dma_check_skip for  skipping dma check
Date: Thu,  3 Aug 2023 22:04:28 +0800
Message-Id: <20230803140441.53596-3-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

for the virtual net device such as veth, there is
no need to do dma check if we support zero copy.

add this flag after unaligned. beacause there are 4 bytes hole
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

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
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


