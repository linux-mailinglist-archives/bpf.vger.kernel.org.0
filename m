Return-Path: <bpf+bounces-54040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E89A60E6B
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 11:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128621B60B57
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BAB1F416F;
	Fri, 14 Mar 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo16Sknh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541641F3B9C
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947143; cv=none; b=SHmn46jeW+O/Bsruh1wm5g5+RpHad0u84XccSE6vULGtxkX7cg0+afu+vx3Uhy4lToAJAMceav5RlZMTcTJpi0z8d3veT/SodqdOiKPxLV5awMGsDvB23zVJ5UdFHodL+yQ4PsUty4V9yvtbLE9VqWTFlhn4h/QEUdzQFfms5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947143; c=relaxed/simple;
	bh=lgxRxmGH3EqSkqPGLRwmTX5PGlD3rFE5OCI1sheAXjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAH0iQVjR1NcZcDgDD8amogXFgEsvdP9hqH2X1lC2evss0cVWUzOTOv5e/k5UH9V53Ixv/sGmxNplldwNw32kP6l6ZqYb23RrZ0WK6ALGfacY6MzZO9ZopC6ujC8FT06Yh4yG6CYPWkCs4d4E14QYwLPjAO5IEF1mGD2SzXfA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lo16Sknh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741947140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MG96L1nD9BNqKXUr9HdilPzD1EgMIYgZeATyxIiL+XI=;
	b=Lo16SknhzOJRwgV1muPNjmyDG93kjvpKOxQgaQxc1a6NSPv7rdl5OIvNyGntisqRINH+WC
	2/XK3noQNx7EklrRGOzScf2CID8ZqQawz5brOqlGPekkYvZiFvUs9+pKplpk4iC5Yg9sFC
	bxoBxZvbnbizt0axdMI1hRLhIU+fHHU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-pZVOFS86OGCBLhWf23Mmhw-1; Fri, 14 Mar 2025 06:12:19 -0400
X-MC-Unique: pZVOFS86OGCBLhWf23Mmhw-1
X-Mimecast-MFC-AGG-ID: pZVOFS86OGCBLhWf23Mmhw_1741947138
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5495a1c0be4so1201338e87.2
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 03:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947137; x=1742551937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG96L1nD9BNqKXUr9HdilPzD1EgMIYgZeATyxIiL+XI=;
        b=HxKBokyUyJg60yk5AHf+Bjg15HqpMBa4qsB+uCJyeR8W+l6zNPEQcxihHhsE3kDtPQ
         ZF6Gb6c6iYkGMVG2PDMP7ik4mAF1LhZ+q1/CirgqjJyswC7I3eNA1wK3draAgd8vEicE
         RUFc4zpD1nN/FDW2OnjF77HYZKZBMvTE8rL4wg700ZG8CXw/FJw7UHAE9MWfPzDgFPKJ
         WY+foX1QIwV17oMrgdjwhZkrxbaq9zARkQMwxqBpPMjvQs1KHDoKw+0cCcrWKMZUoOL5
         wRGQ+RZHl7jtx5BCdPsL7FJhtU1EnGYFkQxlElqtN+UeJMdGY1MU3dbby0ZEeIii/XZj
         JObg==
X-Forwarded-Encrypted: i=1; AJvYcCWR9pru36ufcHk7CGaSHApCq99PoYpGpyjWYfHip8jgjWTMrBoY1IX0QYU41tPVx5opR3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWSzFc9rI5bPFf7n6xeMUeLDLQxme1br7s63GIn0rviu1reIt
	3UrIBOPoImgsoo0hwCTl1ZLDuVoeICd6v0cC+R4mZhCLxTQszfZSB94H0QygMmk6JEgTQRmGuju
	z3q8lUdAzc0+lPD4weE+TiaQkq+r6XzEGDpzmvcgVg8FXyXGUdQ==
X-Gm-Gg: ASbGncu7hMbuQ52NMaiwCcZq3NeuuDBJeiSQdhMdlbyDIok09C3lWrgQGpxOEHh1NrX
	o1Wz6fiH9Qh6NE6dyV5bwcGJ9gric+chLmpV7VICyRGcasH1jmYo8y8aPH78lp9tHHldEaA5gs5
	YfRzLrOy9MtaCqJx/OY3UjMxVcRRhcxEXyP+FWMWzkN5eCCTVLnulk2FwuGp/92UhQv6UYBkV3T
	Et92ktZkThw8xBxGJ2U1/Q7JQVXPCI80W2Lq/4riFCHEjzYlMmPMK+RvxJMA4XTUl6NBH2SmGUa
	2rqEEOrWc39eX/CpOKqJZsutKR18XEpdpi5NdRyj
X-Received: by 2002:a05:6512:2826:b0:549:7c64:3bc0 with SMTP id 2adb3069b0e04-549c38f1fb3mr472365e87.29.1741947137556;
        Fri, 14 Mar 2025 03:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAx3kALDA6mOmLxS/XJeBJ/I21XkejnmA65cY5OZtqAXgthxp5EycvrTQUN0iEyVF8q4pJBw==
X-Received: by 2002:a05:6512:2826:b0:549:7c64:3bc0 with SMTP id 2adb3069b0e04-549c38f1fb3mr472342e87.29.1741947137122;
        Fri, 14 Mar 2025 03:12:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8b11sm482509e87.30.2025.03.14.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:12:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0C33A18FA930; Fri, 14 Mar 2025 11:12:13 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 14 Mar 2025 11:10:20 +0100
Subject: [PATCH net-next 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
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
index 7c6e0b5b6acb55f376ec725dfb71d1f70a4320c3..16e43752566feb510b3e47fbec2d8da0f26a6adc 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -337,8 +337,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
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


