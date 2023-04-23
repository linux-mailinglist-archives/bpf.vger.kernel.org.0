Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAEE6EBDCB
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDWHzC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDWHzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 03:55:01 -0400
Received: from mail-ed1-x563.google.com (mail-ed1-x563.google.com [IPv6:2a00:1450:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D210D9
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 00:54:59 -0700 (PDT)
Received: by mail-ed1-x563.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so5547492a12.3
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1682236498; x=1684828498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8eN7Be/85uzfpyW2w/rr50iULiGv8D2Gnkfs37ktaYM=;
        b=rNC4EJKXU49aedFwPrZkwlJrx07csMDu16FlwNyYTADq2p1Xdr/K3g3uaArMvAUc9e
         9Wrw2wXWZNQSnaKnIvDD31gFW1UpuQ6MEDUWssKk2AHRP4A3XTWiCKYEEohWO9KuTMiv
         9TD8+BTUznpT+EKqAbp45/6QMeXsJ1NjIHpeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682236498; x=1684828498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eN7Be/85uzfpyW2w/rr50iULiGv8D2Gnkfs37ktaYM=;
        b=mGompCn3KFHYjgZ+I+HsoeOfxBvysjs3943P3uMPb6IrSS0voQFQj7tbgWUc6qSVpD
         kl+ssHvd4vDFYlKc9Ep5sDmm4AHVer9MT2fvHgnPihvI/Zh8bnFuxCrJWBBmTYp6clz1
         uzfY2LS8Knt2d7aghwSyt8SZvKph9LKxFw84SsKaF8t2YmT1VWjly+DmuP47JDNATUBi
         4s6x3wYIEntLyOTYoVgkEpkFuCDcJK1FRDqlMKkFw2yKqIAFLYitOhKvO8NNaljgmR63
         K9be9wfm8ATw4WH9OfvRiu+htfkeXQXO9R5pIZViM3GOYIyWdO7uYg8/RKRF9IkQ57gz
         L/yg==
X-Gm-Message-State: AAQBX9f9OajcrzLxz0JjThRlfv3I6jAH5dVSpvU9xhx+pXSPfvpxiPQk
        M5P/tGQXeZjNZfY7kvQHd3/m5wzSBJssidGxgKa/5TI+AxeX
X-Google-Smtp-Source: AKy350YLtMPDAkgPEJsURq5+gvm+IsB0e3MuHJpNtuodio4i6qQUIhDApkdP+hTygnE+RIN7cpFUaLrJqsOA
X-Received: by 2002:aa7:d6ca:0:b0:508:4808:b62b with SMTP id x10-20020aa7d6ca000000b005084808b62bmr9552284edr.22.1682236497826;
        Sun, 23 Apr 2023 00:54:57 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id y15-20020a50bb0f000000b00504940f2549sm1549894ede.40.2023.04.23.00.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 00:54:57 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
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
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xsk: Use pool->dma_pages to check for DMA
Date:   Sun, 23 Apr 2023 09:53:34 +0200
Message-Id: <20230423075335.92597-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Compare pool->dma_pages instead of pool->dma_pages_cnt to check for an
active DMA mapping. pool->dma_pages needs to be read anyway to access
the map so this compiles to more efficient code.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 include/net/xsk_buff_pool.h | 2 +-
 net/xdp/xsk_buff_pool.c     | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index d318c769b445..a8d7b8a3688a 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -180,7 +180,7 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 	if (likely(!cross_pg))
 		return false;
 
-	return pool->dma_pages_cnt &&
+	return pool->dma_pages &&
 	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
 }
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index b2df1e0f8153..26f6d304451e 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -350,7 +350,7 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 {
 	struct xsk_dma_map *dma_map;
 
-	if (pool->dma_pages_cnt == 0)
+	if (!pool->dma_pages)
 		return;
 
 	dma_map = xp_find_dma_map(pool);
@@ -364,6 +364,7 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 
 	__xp_dma_unmap(dma_map, attrs);
 	kvfree(pool->dma_pages);
+	pool->dma_pages = NULL;
 	pool->dma_pages_cnt = 0;
 	pool->dev = NULL;
 }
@@ -503,7 +504,7 @@ static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 	if (pool->unaligned) {
 		xskb = pool->free_heads[--pool->free_heads_cnt];
 		xp_init_xskb_addr(xskb, pool, addr);
-		if (pool->dma_pages_cnt)
+		if (pool->dma_pages)
 			xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
 	} else {
 		xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
@@ -569,7 +570,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
 		if (pool->unaligned) {
 			xskb = pool->free_heads[--pool->free_heads_cnt];
 			xp_init_xskb_addr(xskb, pool, addr);
-			if (pool->dma_pages_cnt)
+			if (pool->dma_pages)
 				xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
 		} else {
 			xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
-- 
2.39.2

