Return-Path: <bpf+bounces-12696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0607CFAD9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8701F23D17
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2127458;
	Thu, 19 Oct 2023 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11F2744B;
	Thu, 19 Oct 2023 13:22:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A96B114;
	Thu, 19 Oct 2023 06:22:11 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SB7ZV1q4wzRt4X;
	Thu, 19 Oct 2023 21:18:26 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 21:22:08 +0800
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related API
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexander Duyck <alexander.duyck@gmail.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231016182725.6aa5544f@kernel.org>
 <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
 <20231017081303.769e4fbe@kernel.org>
 <67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
 <20231018083516.60f64c1a@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <fd8a3e6d-579f-666d-7674-67732e250978@huawei.com>
Date: Thu, 19 Oct 2023 21:22:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231018083516.60f64c1a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/10/18 23:35, Jakub Kicinski wrote:
> On Wed, 18 Oct 2023 19:47:16 +0800 Yunsheng Lin wrote:
>>> mention it in the documentation. Plus the kdoc of the function should
>>> say that this is just a thin wrapper around other page pool APIs, and
>>> it's safe to mix it with other page pool APIs?  
>>
>> I am not sure I understand what do 'safe' and 'mix' mean here.
>>
>> For 'safe' part, I suppose you mean if there is a va accociated with
>> a 'struct page' without calling some API like kmap()? For that, I suppose
>> it is safe when the driver is calling page_pool API without the
>> __GFP_HIGHMEM flag. Maybe we should mention that in the kdoc and give a
>> warning if page_pool_*alloc_va() is called with the __GFP_HIGHMEM flag?
> 
> Sounds good. Warning wrapped in #if CONFIG_DEBUG_NET perhaps?

How about something like __get_free_pages() does with gfp flags?
https://elixir.free-electrons.com/linux/v6.4-rc6/source/mm/page_alloc.c#L4818

how about something like below on top of this patchset:
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 7550beeacf3d..61cee55606c0 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -167,13 +167,13 @@ static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
        return page_pool_alloc(pool, offset, size, gfp);
 }

-static inline void *page_pool_cache_alloc(struct page_pool *pool,
-                                         unsigned int *size, gfp_t gfp)
+static inline void *page_pool_alloc_va(struct page_pool *pool,
+                                      unsigned int *size, gfp_t gfp)
 {
        unsigned int offset;
        struct page *page;

-       page = page_pool_alloc(pool, &offset, size, gfp);
+       page = page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM);
        if (unlikely(!page))
                return NULL;

@@ -181,21 +181,22 @@ static inline void *page_pool_cache_alloc(struct page_pool *pool,
 }

 /**
- * page_pool_dev_cache_alloc() - allocate a cache.
+ * page_pool_dev_alloc_va() - allocate a page or a page fragment.
  * @pool: pool from which to allocate
  * @size: in as the requested size, out as the allocated size
  *
- * Get a cache from the page allocator or page_pool caches.
+ * This is just a thin wrapper around the page_pool_alloc() API, and
+ * it returns va of the allocated page or page fragment.
  *
  * Return:
- * Return the addr for the allocated cache, otherwise return NULL.
+ * Return the va for the allocated page or page fragment, otherwise return NULL.
  */
-static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
-                                             unsigned int *size)
+static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
+                                          unsigned int *size)
 {
        gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);

-       return page_pool_cache_alloc(pool, size, gfp);
+       return page_pool_alloc_va(pool, size, gfp);
 }

 /**
@@ -338,17 +339,17 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
                (sizeof(dma_addr_t) > sizeof(unsigned long))

 /**
- * page_pool_cache_free() - free a cache into the page_pool
- * @pool: pool from which cache was allocated
- * @data: addr of cache to be free
+ * page_pool_free_va() - free a va into the page_pool
+ * @pool: pool from which va was allocated
+ * @va: va to be free
  * @allow_direct: freed by the consumer, allow lockless caching
  *
  * Free a cache allocated from page_pool_dev_cache_alloc().
  */
-static inline void page_pool_cache_free(struct page_pool *pool, void *data,
-                                       bool allow_direct)
+static inline void page_pool_free_va(struct page_pool *pool, void *va,
+                                    bool allow_direct)
 {
-       page_pool_put_page(pool, virt_to_head_page(data), -1, allow_direct);
+       page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
 }




