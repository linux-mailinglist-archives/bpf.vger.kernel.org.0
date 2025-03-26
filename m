Return-Path: <bpf+bounces-54738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D6A7127A
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 09:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FD17651A
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36A1A705C;
	Wed, 26 Mar 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9eqXvaC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520411A5B8A
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977151; cv=none; b=WU6v+6GydT/Qh4Agz8VF8F1ZAJ1RMB5MtMXYuuK9Js2l2lSEfbz8sqN0EAzQNmGxytSjCSWt1eg+dwwm/tOE2rdeW3p7PAVePXCHQ2rMMw6UFkmJBu2U+Bszv7J2fOfWbqt7YWV7uyHbO6HWG0KnmjdeqPFJNC7Th613+PaEenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977151; c=relaxed/simple;
	bh=4I05eVH/+uUp2ErZURt+83KwIztisW9+7S+LIhJyfXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJtkhiiRTZ6XmsfBuivoC/1p1S1oKr8VFRlIS2wishCsuj0l0EbwuqJZy+nKO+2w8m9MYLSnGD7gR4eI/6jSsT7RGLoLGsnjlsdI5sHHLBAuQndblycTBx1m43tSrY1o+YPKp/qSr0azIZGgnWDFRGwv20CAYmGquTD7kUpXGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9eqXvaC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742977148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHU3gd5R+PcFSPJyd+8lTgr7QvXzHN6SGWRXjaUKaHA=;
	b=J9eqXvaCFtbw/plQjS16WGNAqXgs+YgY08Bm8w/yiQV20Fdoefa/57lCdGdzakvo+Ja3bU
	B38vvyF3z9Tq7L7JVaiB3IWQQsqgmQB8DU3yxFPP2aX2vlbVsIurJlZapUtlq2th7to74x
	AE54heBIWAf5ZWY825pws8zgswhq1Bk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-NdTk69UlN0Cr9rEC-wiIbw-1; Wed, 26 Mar 2025 04:18:58 -0400
X-MC-Unique: NdTk69UlN0Cr9rEC-wiIbw-1
X-Mimecast-MFC-AGG-ID: NdTk69UlN0Cr9rEC-wiIbw_1742977137
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac6ef2d1b7dso15663766b.0
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 01:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977137; x=1743581937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHU3gd5R+PcFSPJyd+8lTgr7QvXzHN6SGWRXjaUKaHA=;
        b=vx11OJvk1BGpnUGNi8Jbsj5cDVQZWmaiZH3k0Lv8Ab4dFZravpokGG3ug/UsfalGzR
         YeDOOFu+AuMLWDVWWuPXnLXlOhyFTTdV/GFVh4Fmo7v38NP7tFvXJNUqNNc6Ee1iA5z0
         mDxG8hR7lvF5WTLamnrdrh5DpdncXqRstF9sdgwOhz69KtEzeQksh0sF6ZYFyxgG/td9
         G/Sp6vkyeuvPvmQtUDzkziPON2I9/HbZIF59L4HlVucQuHmMOgzjkDHaJdhmiGrJntKh
         ojuDuVx0+5VWXHmc4WeMzYR2xSSastKq+t/B8CdAjCHfSDX/wSZT7gKDxbDp8WH6RRSY
         lv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJIEjx4i9igN/lqv2oKcMDbPhUP4Z26uhgqbgmcbwf9Boxum6yi9jxJ0LIbf9GLRjxGAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbFfibr1bpWa6yuoa1GgIxN+2c7W1H8URcHdGl0LsuwX1Fr4y
	dC0jAohZ6ScAVA6f1Wtww/IT6tn+Msg4AIXdZKL/q+HaIFeOF4APwDrGz/5cHt9K32xjzv43H31
	QuwcQ/1S9Qs53FeOCp0rg61ixEMRmsiqL+ld7LAFjWp7PzKVjuQ==
X-Gm-Gg: ASbGnct8G4WQXZz8BBnDOGNZPDY/d6zoqDiA0wSmO9yRohTHNmrCMsdIlY9lM1n3EsJ
	IfGr/dsIVnMX5bUEGBDHfftKH6z/ga4Pu7lTQiWNHYJ78/9mdW2hNKtWB0LOu4OSNSt7nLBDKBs
	mW+P5oC27HEgOrcZw/ce6tv5RPSMAclceHvVzFp7kdutAyOiP+XAZXJ2KhoRYzYagSc/ffDpWHB
	n5cuM02SLaZRR8Pt1gpTtc+ryRdhQZg49J+Y9f8tnscwAjlFcTlHN1XNN0qVa0ztRiT0oNbsc90
	LkbWO2WYgSdu1qtdi3cdXFoxLwJPHeJ2RzgTdjm2
X-Received: by 2002:a17:907:6ea6:b0:ac6:b731:d327 with SMTP id a640c23a62f3a-ac6b731d3dcmr641047566b.4.1742977136835;
        Wed, 26 Mar 2025 01:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwezWzI1MgFdP9DAT+/2zNUhExClr8nnWD8c6ObA/s1wOXjNoqUjslh6fgHhj93GwDZJxa9g==
X-Received: by 2002:a17:907:6ea6:b0:ac6:b731:d327 with SMTP id a640c23a62f3a-ac6b731d3dcmr641044566b.4.1742977136301;
        Wed, 26 Mar 2025 01:18:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c74b9sm8933274a12.62.2025.03.26.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:18:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 50AE618FC9CC; Wed, 26 Mar 2025 09:18:54 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 26 Mar 2025 09:18:38 +0100
Subject: [PATCH net-next v3 1/3] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-page-pool-track-dma-v3-1-8e464016e0ac@redhat.com>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
In-Reply-To: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Since we are about to stash some more information into the pp_magic
field, let's move the magic signature checks into a pair of helper
functions so it can be changed in one place.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
 include/net/page_pool/types.h                    | 18 ++++++++++++++++++
 mm/page_alloc.c                                  |  9 +++------
 net/core/netmem_priv.h                           |  5 +++++
 net/core/skbuff.c                                | 16 ++--------------
 net/core/xdp.c                                   |  4 ++--
 6 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 6f3094a479e1ec61854bb48a6a0c812167487173..70c6f0b2abb921778c98fbd428594ebd7986a302 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -706,8 +706,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-				 * as we know this is a page_pool page.
+				/* No need to check page_pool_page_is_pp() as we
+				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb26173135ff37951ef8 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -54,6 +54,14 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page.
+ * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
+ * the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~0x3UL
+
 /**
  * struct page_pool_params - page pool parameters
  * @fast:	params accessed frequently on hotpath
@@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 {
 }
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
 #endif
 
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 542d25f77be80304b731411ffd29b276ee13be0c..3535ee76afe946cbb042ecbce603bdbedc9233b9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/page_pool/types.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -872,9 +873,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -901,10 +900,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-#ifdef CONFIG_PAGE_POOL
-	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
+	if (unlikely(page_pool_page_is_pp(page)))
 		bad_reason = "page_pool leak";
-#endif
 	return bad_reason;
 }
 
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e002fd1cc2cef8a313d2ea7df76f301..f33162fd281c23e109273ba09950c5d0a2829bc9 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -18,6 +18,11 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
+static inline bool netmem_is_pp(netmem_ref netmem)
+{
+	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
 {
 	__netmem_clear_lsb(netmem)->pp = pool;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab8acb737b93299f503e5c298b87e18edd59d555..a64d777488e403d5fdef83ae42ae9e4924c1a0dc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_netmem(netmem_ref netmem)
-{
-	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -995,14 +990,7 @@ bool napi_pp_put_page(netmem_ref netmem)
 {
 	netmem = netmem_compound_head(netmem);
 
-	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
-	 * in order to preserve any existing bits, such as bit 0 for the
-	 * head page of compound page and bit 1 for pfmemalloc page, so
-	 * mask those bits for freeing side when doing below checking,
-	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
-	 * to avoid recycling the pfmemalloc page.
-	 */
-	if (unlikely(!is_pp_netmem(netmem)))
+	if (unlikely(!netmem_is_pp(netmem)))
 		return false;
 
 	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
@@ -1042,7 +1030,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
-		if (likely(is_pp_netmem(head_netmem)))
+		if (likely(netmem_is_pp(head_netmem)))
 			page_pool_ref_netmem(head_netmem);
 		else
 			page_ref_inc(netmem_to_page(head_netmem));
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a77eb63a96a85aa6d068d3e94f077..0ba73943c6eed873b3d1c681b3b9a802b590f2d9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -437,8 +437,8 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		netmem = netmem_compound_head(netmem);
 		if (napi_direct && xdp_return_frame_no_direct())
 			napi_direct = false;
-		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-		 * as mem->type knows this a page_pool page
+		/* No need to check netmem_is_pp() as mem->type knows this a
+		 * page_pool page
 		 */
 		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
 					  napi_direct);

-- 
2.48.1


