Return-Path: <bpf+bounces-55324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6574DA7BA85
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 12:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125B51768BE
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5C1B3950;
	Fri,  4 Apr 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Via5tDQN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394E18FDD5
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761932; cv=none; b=nGVlVbTFTnhgRmM49DT9g1nHve/wZMwQm0ZIoSVAz5qf0nWEGFnbws8NTSDqUpeQGJihv5KRw6CJTSZ8vMhBr+XMsv/hG1n0w8ylD0pfQhJZ85LGtd3NdP3caXLdzjvL3ziVDzdYTNHyBtOnfb/Fhpe6QrQmj4h9JYEuCqVexow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761932; c=relaxed/simple;
	bh=jspAozAj/vLMyyrCfFfRZENjLAVy9g9t8428u5MiFyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7oA/O2/Oiywm6Ey2i/Yd2nknX6Fxa9Mbcq3EZEWIhsPndC/IRnG57nEEmv9d0VHfzwcCxk8Dx1jowYfro6I7yamkOBjKKxnLgyYw3yafcRioXn/Wmy8IIgLY18Gbsoe5SE1kfD5p7axqeGAzVCS83kVqsY9wh5L/kwq+ERdwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Via5tDQN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743761929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4+5hsM5ZBTs5xBrEabWDCLK+Od0ba/LsqZmsY1szhM=;
	b=Via5tDQNrNmAazmIFu9qShvs4smbsa8sQhyaXgQULv+kLZrO61Gq8bHFl5RfMyrerBhtLG
	8tR0El7tvgLBw1daGpNQmliCHh+H+4H7XUoRIZ2WK+W5LHIJJacmpIkraDrXp4e/OMJSEC
	4vH5M80LT+kzDdgDEsemyc9Qh+lbMzY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-3mF05L8lMme6T93uP2dK6g-1; Fri, 04 Apr 2025 06:18:48 -0400
X-MC-Unique: 3mF05L8lMme6T93uP2dK6g-1
X-Mimecast-MFC-AGG-ID: 3mF05L8lMme6T93uP2dK6g_1743761927
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf554ea7bso9616671fa.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743761927; x=1744366727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4+5hsM5ZBTs5xBrEabWDCLK+Od0ba/LsqZmsY1szhM=;
        b=a1HhTAtv263ZKMnWNrF2v2SRUFWS6/C75l96v+FzziegrK8rTr8gtjnSZzl5A48riY
         YsTBa7cREyJtEiw9EQkhIwTg0gC4QgO2isLz4uf4Ao3wevcW0v5DR9n6egHPT0Lj1P45
         4I14ecyBvdvFraMbLSyTcow2QwhpHWyODQnphU+J6aT9Rx6hb7RBRLNoYvBwi+BCUY6d
         OBSESHpKnOY4wB9ghsDoS91s8lcbynp+zIo05HvuiBS5tg1exyMz1i1OgaOcmhj+JEMd
         331AZwTifC115xj+VPOvxNL//4m1C88S9tkn3/QlSbCqSMQIQ97epsXxh98bRrnIynWj
         wRoA==
X-Forwarded-Encrypted: i=1; AJvYcCWOqDjT+WSa7QnTXrgP3BkqM9nhGmSl3KM2aDzCcvtQeoPUHykMMJEPhF0wGAVF3lL8H6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGHQ5XvSg+iwFipYu+mu8ARC0nhEz7eZPX6Oov0cEP6Iez+6i
	93j3Wx30Pi/oJxI93R5IGkPvF+R1njnZk7JlODJtZ1KfQDOtVEmTCBboUybqwVamB6novEDa4p7
	/a4Win44WkmKwBMW2N/tR7QgSfvy0hQstNP3FWLjYhI0T7fou8A==
X-Gm-Gg: ASbGnctFUtT7NrpyRPc2MXGIKLVfdgRhwoI26CMmatsNupQFeF6yuVwbef23Tg9zaMY
	QkZNAqTQQjaoxQ1CSMmcwpqqvVltgSgEKa1jZHgSDTJrEW5EFdgpSrPkpSiwOprNM4l3UwHzH3I
	rXSnFTiVzEbDXgEYLRNnn6u8n1fVQ8uZz1Mzyp3BkltqOdmPHsMX3QeSU6zpzqVFXccFcCJ+YHf
	/8H5C6zlIFYXjqklW2xTklBkBkSYfABaaalCye3Vyy0Fm2aLf4dxwPKG5hldX8pKUgzVfTuNK/d
	eca/EhOLdj8VKfnFrGFWGbER1tQB/x8TY5vFFoFI
X-Received: by 2002:a2e:bd02:0:b0:30b:f0da:3ae7 with SMTP id 38308e7fff4ca-30f0a70e09dmr8549001fa.14.1743761927077;
        Fri, 04 Apr 2025 03:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi8FvjFb2phTAUuS/o5yj005VkalTxf39MNnqr7MnG0ADfb0rXyNWNd9MypI2JLw6h1MTyaw==
X-Received: by 2002:a2e:bd02:0:b0:30b:f0da:3ae7 with SMTP id 38308e7fff4ca-30f0a70e09dmr8548781fa.14.1743761926662;
        Fri, 04 Apr 2025 03:18:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314b908sm5149931fa.55.2025.04.04.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 03:18:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 902D618FD727; Fri, 04 Apr 2025 12:18:44 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 04 Apr 2025 12:18:35 +0200
Subject: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
In-Reply-To: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
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
index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0d198947be7c503526 100644
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
@@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
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


