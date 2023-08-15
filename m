Return-Path: <bpf+bounces-7808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944177CC90
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F5D1C20CCF
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C9611CB7;
	Tue, 15 Aug 2023 12:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE56DDD1;
	Tue, 15 Aug 2023 12:26:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9701FD5;
	Tue, 15 Aug 2023 05:25:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ9Nm6XLWzNmlV;
	Tue, 15 Aug 2023 20:21:28 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 20:24:59 +0800
Subject: Re: [PATCH net-next v6 5/6] page_pool: update document about frag API
To: Randy Dunlap <rdunlap@infradead.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
	<edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <linux-doc@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-6-linyunsheng@huawei.com>
 <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0cbf592e-2f21-30ca-799e-5cc15e89c3f8@huawei.com>
Date: Tue, 15 Aug 2023 20:24:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/15 6:42, Randy Dunlap wrote:
> Hi--

Thanks for the reviewing.

> 

...

>> @@ -100,6 +115,14 @@ static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
>>       return __page_pool_alloc_frag(pool, offset, size, gfp);
>>   }
>>   +/**
>> + * page_pool_dev_alloc_frag() - allocate a page frag.
>> + * @pool[in]    pool from which to allocate
>> + * @offset[out]    offset to the allocated page
>> + * @size[in]    requested size
> 
> Please use kernel-doc syntax/notation here.

Will change to:

/**
 * page_pool_dev_alloc_frag() - allocate a page frag.
 * @pool: pool from which to allocate
 * @offset: offset to the allocated page
 * @size: requested size
 *
 * Get a page frag from the page allocator or page_pool caches.
 *
 * Return:
 * Returns allocated page frag, otherwise return NULL.
 */


> 
>> + *
>> + * Get a page frag from the page allocator or page_pool caches.
>> + */
>>   static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
>>                               unsigned int *offset,
>>                               unsigned int size)
>> @@ -143,6 +166,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
>>       return page;
>>   }
>>   +/**
>> + * page_pool_dev_alloc() - allocate a page or a page frag.
>> + * @pool[in]:        pool from which to allocate
>> + * @offset[out]:    offset to the allocated page
>> + * @size[in, out]:    in as the requested size, out as the allocated size
> 
> and here.

/**
 * page_pool_dev_alloc() - allocate a page or a page frag.
 * @pool: pool from which to allocate
 * @offset: offset to the allocated page
 * @size: in as the requested size, out as the allocated size
 *
 * Get a page or a page frag from the page allocator or page_pool caches.
 *
 * Return:
 * Returns a page or a page frag, otherwise return NULL.
 */

> 
>> + *
>> + * Get a page or a page frag from the page allocator or page_pool caches.
>> + */
>>   static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
>>                              unsigned int *offset,
>>                              unsigned int *size)
>> @@ -165,6 +196,13 @@ static inline void *page_pool_cache_alloc(struct page_pool *pool,
>>       return page_address(page) + offset;
>>   }
>>   +/**
>> + * page_pool_dev_cache_alloc() - allocate a cache.
>> + * @pool[in]:        pool from which to allocate
>> + * @size[in, out]:    in as the requested size, out as the allocated size
> 
> and here.


/**
 * page_pool_dev_cache_alloc() - allocate a cache.
 * @pool: pool from which to allocate
 * @size: in as the requested size, out as the allocated size
 *
 * Get a cache from the page allocator or page_pool caches.
 *
 * Return:
 * Returns the addr for the allocated cache, otherwise return NULL.
 */

> 
>> + *
>> + * Get a cache from the page allocator or page_pool caches.
>> + */
>>   static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
>>                             unsigned int *size)
>>   {
>> @@ -316,6 +354,14 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>>       page_pool_put_full_page(pool, page, true);
>>   }
>>   +/**
>> + * page_pool_cache_free() - free a cache into the page_pool
>> + * @pool[in]:        pool from which cache was allocated
>> + * @data[in]:        cache to free
>> + * @allow_direct[in]:    freed by the consumer, allow lockless caching
> 
> and here.

/**
 * page_pool_cache_free() - free a cache into the page_pool
 * @pool: pool from which cache was allocated
 * @data: addr of cache to be free
 * @allow_direct: freed by the consumer, allow lockless caching
 *
 * Free a cache allocated from page_pool_dev_cache_alloc().
 */


> 
>> + *
>> + * Free a cache allocated from page_pool_dev_cache_alloc().
>> + */
>>   static inline void page_pool_cache_free(struct page_pool *pool, void *data,
>>                       bool allow_direct)
>>   {
> 
> Thanks.

