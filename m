Return-Path: <bpf+bounces-54694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA70A70580
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FE3B35DE
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD825BAA8;
	Tue, 25 Mar 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsBaq/Hr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7E29408
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917606; cv=none; b=gTY8qzBO6vpKeAylwR2xsg8t4CbG1odYrluPZ0SJKK7qqO4/Qccpboj7jOcWT3LiAeZKGFK/m7z/1GZ4+b+1XTqHn4Hrfy8GrKc8xHSQj8ljkKhvXj7gUfG8ZFIUw/eSlw9HjlK54qqof+uWvFU8Deerttjmrb4TiWMl/yqzxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917606; c=relaxed/simple;
	bh=+wrwZMqC093Z7gZ1xPNJ6NEXrS+qn3tLIr9ngcSDPyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAiTLT+3DO8Io8bBHpIhaob4xOU6+uBeVh6KJ9F382tKYPfQfEaTiGAVGbfE1FxIz219GUrZroHlcXv10AezHeMJ/mh17ABFa6mYVjZJYIaIrZMAZNir1SkQK0V3VLZYG8Qk0QqTKwus1gTIb39Ht8jonqghhqEXkEr5BvWsl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsBaq/Hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qelpf0cr1Bxyx5yCbHo7HXz9cxxZ6ghzCl2hi3M+JE=;
	b=BsBaq/HrHAP/NHNgkrEAlTtpi3PXxI/qkriefpEZCNsFA1sSbSQcGaEuQIes0Nuzt/YvIL
	01rrqB5w62M/86cr7fzCyZ39pzWE/lLNh7gqFY8DMEsuv6RAtf71UlLMONh7T6Gmn0qLE7
	J17EtiDzzo6N54mwHANNJsXRIWIhEnA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-r7jhvEPxOjWTGjRVM5t9Nw-1; Tue, 25 Mar 2025 11:46:41 -0400
X-MC-Unique: r7jhvEPxOjWTGjRVM5t9Nw-1
X-Mimecast-MFC-AGG-ID: r7jhvEPxOjWTGjRVM5t9Nw_1742917601
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac27f00a8a5so443547666b.3
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917600; x=1743522400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qelpf0cr1Bxyx5yCbHo7HXz9cxxZ6ghzCl2hi3M+JE=;
        b=mB21n5rsKkqcceCJR7ShUQEKFXFC++o7IqOqtGdPW0P0DLEscumZYlibJRZpbi5Qu8
         1wrBhstx+keEfnHGTNuD6voiOv2OyrbCE+Yz6DVoQov1B4YShmpIin477iPk77lhtcQ2
         P75kXESnpANMxA1yBsgiGFz6ms4zNM32PH57STNcVyVPO1+A/Qip/SisQRcrR9dvmdyT
         +uW/76iFdax/HdIpFWkFAvdLW8QgB/PKYaouHFwhPH3So+4UvEDJ2aHEUMgxgBGGJRrV
         NiynT2E2QFhVOTHUbz8M9VUpapJQNxxOkHM8m1Eqyf9TrVEqip9e4lnvSM5U3IuwwCbS
         mxsA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPNPOzb+IpxmxBND2+2DL4zp233toZuANMt/L1hOsx403XRiLGspq1YWLEdwsbAI0ns8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzisLBBQSFm/BnJmA3oWV9/R6V07j23RmLeCI5Pgd7pEbWTPF
	OP1vELuBD/4G1ttDZEDioCTR43+V44lSP5/EejyBCiqKb+Vqvm/ILRfbMVOEVXKteRjxbFgZbuq
	YjJxRk5T2K5kYnUugLLumq0JkGBssobk4LfMVDpRN5ZBVeyGt42zNTfddGg==
X-Gm-Gg: ASbGncvu+Q0fukJkydA4CsgSr2tN6GpMvqMKgoGLj/AHATHCadzoSKcSAnlLbs3ZPFm
	DtWchwRvYBOaHITqaNPpPSjMYsLPHUExcH3bDYQWhH5QGXeI+s2ofgtsMt2NRkFaZVThBvCYVty
	5/R52fdEiL5oaUUJk0P1/pDyXnFvPyIeef76Mo+ca+uocT6BsSFVCJXhcJr+IxdoOLWsyAXNnoe
	w9Py0fzNy36yAwwmCzE8xqjaEQ3yfBltEtByTBI5j/KvgB2YTb1p6EX7BXPRRX/rwb6PYPy04pm
	k5LtkPgak4N/1/s3+ZvpIqat2wMrUPLPdGVMRTqa
X-Received: by 2002:a17:906:c109:b0:ac6:cea2:6c7 with SMTP id a640c23a62f3a-ac6cea2122dmr209869066b.42.1742917600048;
        Tue, 25 Mar 2025 08:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOdJXWY+OX6Pisfk0vOr5e4GyVLnFPg79bwnTUB2L/Or27l1la/vuNBO9tmBFaSgYvASXEiA==
X-Received: by 2002:a17:906:c109:b0:ac6:cea2:6c7 with SMTP id a640c23a62f3a-ac6cea2122dmr209865166b.42.1742917599597;
        Tue, 25 Mar 2025 08:46:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8675a9sm876497966b.28.2025.03.25.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:46:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C8DC518FC8BA; Tue, 25 Mar 2025 16:46:36 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 25 Mar 2025 16:45:43 +0100
Subject: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
In-Reply-To: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
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

Change the single-bit booleans for dma_sync into an unsigned long with
BIT() definitions so that a subsequent patch can write them both with a
singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
side into __page_pool_dma_sync_for_cpu() so it can be disabled for
non-netmem providers as well.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/helpers.h | 6 +++---
 include/net/page_pool/types.h   | 8 ++++++--
 net/core/devmem.c               | 3 +--
 net/core/page_pool.c            | 9 +++++----
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 582a3d00cbe2315edeb92850b6a42ab21e509e45..7ed32bde4b8944deb7fb22e291e95b8487be681a 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -443,6 +443,9 @@ static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 						const dma_addr_t dma_addr,
 						u32 offset, u32 dma_sync_size)
 {
+	if (!(READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_CPU))
+		return;
+
 	dma_sync_single_range_for_cpu(pool->p.dev, dma_addr,
 				      offset + pool->p.offset, dma_sync_size,
 				      page_pool_get_dma_dir(pool));
@@ -473,9 +476,6 @@ page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
 				  const netmem_ref netmem, u32 offset,
 				  u32 dma_sync_size)
 {
-	if (!pool->dma_sync_for_cpu)
-		return;
-
 	__page_pool_dma_sync_for_cpu(pool,
 				     page_pool_get_dma_addr_netmem(netmem),
 				     offset, dma_sync_size);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index df0d3c1608929605224feb26173135ff37951ef8..fbe34024b20061e8bcd1d4474f6ebfc70992f1eb 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -33,6 +33,10 @@
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
 				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
 
+/* bit values used in pp->dma_sync */
+#define PP_DMA_SYNC_DEV	BIT(0)
+#define PP_DMA_SYNC_CPU	BIT(1)
+
 /*
  * Fast allocation side cache array/stack
  *
@@ -175,12 +179,12 @@ struct page_pool {
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
-	bool dma_sync:1;		/* Perform DMA sync for device */
-	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
 #ifdef CONFIG_PAGE_POOL_STATS
 	bool system:1;			/* This is a global percpu pool */
 #endif
 
+	unsigned long dma_sync;
+
 	__cacheline_group_begin_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
 	long frag_users;
 	netmem_ref frag_page;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6802e82a4d03b6030f6df50ae3661f81e40bc101..955d392d707b12fe784747aa2040ce1a882a64db 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -340,8 +340,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	/* dma-buf dma addresses do not need and should not be used with
 	 * dma_sync_for_cpu/device. Force disable dma_sync.
 	 */
-	pool->dma_sync = false;
-	pool->dma_sync_for_cpu = false;
+	pool->dma_sync = 0;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..d51ca4389dd62d8bc266a9a2b792838257173535 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -203,7 +203,7 @@ static int page_pool_init(struct page_pool *pool,
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
 	pool->cpuid = cpuid;
-	pool->dma_sync_for_cpu = true;
+	pool->dma_sync = PP_DMA_SYNC_CPU;
 
 	/* Validate only known flags were used */
 	if (pool->slow.flags & ~PP_FLAG_ALL)
@@ -238,7 +238,7 @@ static int page_pool_init(struct page_pool *pool,
 		if (!pool->p.max_len)
 			return -EINVAL;
 
-		pool->dma_sync = true;
+		pool->dma_sync |= PP_DMA_SYNC_DEV;
 
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
@@ -291,7 +291,7 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_ops) {
-		if (!pool->dma_map || !pool->dma_sync)
+		if (!pool->dma_map || !(pool->dma_sync & PP_DMA_SYNC_DEV))
 			return -EOPNOTSUPP;
 
 		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
@@ -466,7 +466,8 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
+	    dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1


