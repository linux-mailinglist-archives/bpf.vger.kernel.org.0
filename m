Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6236EC186
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 20:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDWSCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjDWSCQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 14:02:16 -0400
Received: from mail-lf1-x164.google.com (mail-lf1-x164.google.com [IPv6:2a00:1450:4864:20::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7EE60
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 11:02:15 -0700 (PDT)
Received: by mail-lf1-x164.google.com with SMTP id 2adb3069b0e04-4ec8ce03818so3750674e87.3
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1682272933; x=1684864933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8eN7Be/85uzfpyW2w/rr50iULiGv8D2Gnkfs37ktaYM=;
        b=c2wxVnoG53hNbe0ViANaExeN/65EyuES4Yep1AGJBc1vpRXVc5Wy/LOFKaAbQ0AfWM
         9vHNPxqv1gTPcYjEGfCpPTycR5jlCPCc0RxnyKTvg2b5+NJGmgM+rZRwl3ynD4kns4a7
         /SWgpiKzwCVQKXSqyAHvsazcpUlkE5ErifHw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682272933; x=1684864933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eN7Be/85uzfpyW2w/rr50iULiGv8D2Gnkfs37ktaYM=;
        b=gzkuNnUTOM4nGEEG/v8J4LS6icncJjXH952HyujvTuHbTIe8+kiqlbGiHuNQy32a37
         ookhZrM+4vWSIc7VgB3wYCd0QeiSsqCqLBs8xlVdA9jL1vPwOC7oyLmh95yuHSaDWRma
         q+IOWXppztTcFyv08Hlb232eq+rwcp/xsX+dnlUR39ASF5dLcDH2UUXtxCPNnr5HAvhb
         F6a35B/wzeqZOGLvAPafEQsNn/HbSAcir729grzR/QT3JFi695pLbCihRtYgk5XAXfBL
         h7vQ6MmGgWv4SCjdhYw8q8h9s1p+73I49j1yXZE9Es/V+qLJMrRoJMdWlWcFVJUXu7p9
         Rz8g==
X-Gm-Message-State: AAQBX9fX9X62QzWAHTO4pgPjEiRA9IEHQQiJRfEzpCBkOY6F9aVyQYgD
        xnq4Z0u2TodsPkicRdugRrFIOTNSx5JB9zgt4NqmYkPXl9TY
X-Google-Smtp-Source: AKy350biATVx20XIrJwVnZCBI3rne8bnweoDWn/Zxy4tiR/Umw3RnVZGAC+ZNl4ggSUdBLjV+r/IbRBuMi1O
X-Received: by 2002:ac2:53bb:0:b0:4ec:9e01:71e with SMTP id j27-20020ac253bb000000b004ec9e01071emr2608921lfh.4.1682272933293;
        Sun, 23 Apr 2023 11:02:13 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id b4-20020ac25e84000000b004eb0f3d92cdsm734213lfq.63.2023.04.23.11.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 11:02:13 -0700 (PDT)
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
Subject: [PATCH bpf-next] xsk: Use pool->dma_pages to check for DMA
Date:   Sun, 23 Apr 2023 20:01:56 +0200
Message-Id: <20230423180157.93559-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

