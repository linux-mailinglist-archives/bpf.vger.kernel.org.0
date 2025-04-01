Return-Path: <bpf+bounces-55060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A455A777B0
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00558169FBB
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D541EF080;
	Tue,  1 Apr 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6JtnoDW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25391C7006
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499653; cv=none; b=IBOfBAxZKlBIscSghyefHYXwrInwHxFjnS2aByZQhrHisdLS+ER6vdrpmclFTzY7OlU0QqDz0pAIJ90suNjwLz1oucmIndI75Gr5YcadxgNskZXBWvXv6fZO4Eu2XdlgkqaGmrzadBtaQBK7x5LKEAMeIajUYCatzgfzTcEkRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499653; c=relaxed/simple;
	bh=tBaUVOmuwlUC0F0gAM0GQcCY9DRAAjxRSbfYpkziV60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1qHlJPRKkDrOeFplh0V0meJCVhJUsCmicwLEYCkoyhsmGl6ENcdl5XT54ovSZ9ZexYM5TVh4f73RcHpzymFbsWvPIVJ3wA20IHaeyY2wS8ZzbBgmawbZWcOjFO1ko+5QKamoDoozjSiaZKQSj8d/h/ix4mSIO4IHFJI6mOteU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6JtnoDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743499651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DD6/BKzSTAkniyKROx0SYrtrdsrFKedUxdUETO2d2g0=;
	b=e6JtnoDWf9QSMpoGDgI5ScHm9n59NEFa0e9xe5LeAjZD68qjQjoJNG3Gnt1rmsgC226fr8
	QHRKF0W6b5pJrLctmdLs2DPlG4l1/2dS+MD0HWwJ9IrELkEx7T08k2BCS6Q0ohQigj2PU0
	dpveuHdsQX0uOP39GCRARaqiWJ5sb/w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-8jzyfdULM_qk5w6qkMXwbw-1; Tue, 01 Apr 2025 05:27:29 -0400
X-MC-Unique: 8jzyfdULM_qk5w6qkMXwbw-1
X-Mimecast-MFC-AGG-ID: 8jzyfdULM_qk5w6qkMXwbw_1743499649
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac7791ecb7bso136262566b.0
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 02:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499649; x=1744104449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD6/BKzSTAkniyKROx0SYrtrdsrFKedUxdUETO2d2g0=;
        b=YWH/1eu0eORemTPNj6tuLfL489I42yJWEmiKBZLg/qatym+gc+Zfky9nCPBJNx2As7
         dPL3Ijc2ybrxDLnZCyB7nHE4482c6Phnq1VBc44/OFO7X/9C26B5znbQIK30fyQbW2qo
         kGmPQgTtWApWxCBnK8Qz+mlzBNRve/9VL+5dt5NXUS7P0tKkphQ2qA7I56Mj1G3bQbUM
         haNa39rGJJ2gb0OxgQnBozDRYxAcV1rOIeK2bv1FjRJUEtmE4jh+VYS+oEBtgWTOT/Le
         2lP91KmsnuniEy9Y2504yQJZHyThsV8tKW5vcTLnRNA6x1sBFFHBF0sIDArDYK8VX9TC
         pJnw==
X-Forwarded-Encrypted: i=1; AJvYcCWr9XVl2GJc7eMjdtQrsal3M/8Dpn7PQYshU8T6gYAF2oSZMJ99hVS90XaHy5ijNCjHLXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVtJ66GyxYuHmv+VRi6fbsmi0FZi8HNIXpGz4KJ/qrtqpFxqM
	lizZtYviySqhuSwdkXomyYdfkeip9qIqdztpEQ3SfXEfKGIFtxjqlS8WB39H+8B8qm8JKVTK0S1
	9d6ayKNzqX20Wm1MaS4/aDRrYT1dwAkv6/Mt+1Z6h26tNaKebEw==
X-Gm-Gg: ASbGncsLze1s9iz6rQUfeHJTYIpxrb1duJ5FWuq4c61G6oag8IY+Nu5p7F6RNUuwvfI
	kFiKGZ/Fd00CVgu7rq3I028xLXdaHScZcKiDMDCZP+ZTn+20tgxmZj2CCmOeP2tYiOW0wTg+kV9
	7rFRVUUyKMmOfqWUzyVLjnQ68tthWCT3ApOHc+meC+G8qh+Ccg1ARQUw+zXDFPy9eWV9S1wruQd
	3/x/90gPKVMXyasDpGh+NtYeb040K9s4AGSFyaNZRzl2+zbc+krGAb0u6puPdBbgSWyU6GE6DLc
	0FTOTSBNX69EfYuYnhiS4NM6Oubn23AfqlmCltjO
X-Received: by 2002:a17:906:c155:b0:ac7:3028:6d67 with SMTP id a640c23a62f3a-ac73681fcd8mr1141183166b.16.1743499648525;
        Tue, 01 Apr 2025 02:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrOYPNeSxQLyXxsP5j/BwzEGjjbGLErMD6rGLT5p4OaReguQc12bEx3/JNXtoHEWBebbAVKg==
X-Received: by 2002:a17:906:c155:b0:ac7:3028:6d67 with SMTP id a640c23a62f3a-ac73681fcd8mr1141179266b.16.1743499648091;
        Tue, 01 Apr 2025 02:27:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b190sm734107966b.45.2025.04.01.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:27:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 85E0F18FD269; Tue, 01 Apr 2025 11:27:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Apr 2025 11:27:18 +0200
Subject: [PATCH net-next v6 1/2] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250401-page-pool-track-dma-v6-1-8b83474870d4@redhat.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
In-Reply-To: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
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
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
index f803e1c93590068d3a7829b0683be4af019266d1..5ce1b463b7a8dd7969e391618658d66f6e836cc1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -707,8 +707,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
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
index 6cbf77bc61fce74c934628fd74b3a2cb7809e464..74a2d886a35b518d55b6d3cafcb8442212f9beee 100644
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


