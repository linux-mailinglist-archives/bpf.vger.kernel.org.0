Return-Path: <bpf+bounces-12564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C677CDAF0
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7496EB211F2
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0B30F85;
	Wed, 18 Oct 2023 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56814F8F;
	Wed, 18 Oct 2023 11:47:20 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75152112;
	Wed, 18 Oct 2023 04:47:19 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9TVJ4M6WzvQ7d;
	Wed, 18 Oct 2023 19:42:32 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 19:47:17 +0800
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
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
Date: Wed, 18 Oct 2023 19:47:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231017081303.769e4fbe@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/17 23:13, Jakub Kicinski wrote:
> On Tue, 17 Oct 2023 15:56:48 +0800 Yunsheng Lin wrote:
>>> And I can't figure out now what the "cache" in the name is referring to.
>>> Looks like these are just convenience wrappers which return VA instead
>>> of struct page..  
>>
>> Yes, it is corresponding to some API like napi_alloc_frag() returning va
>> instead of 'struct page' mentioned in patch 5.
>>
>> Anyway, naming is hard, any suggestion for a better naming is always
>> welcomed:)
> 
> I'd just throw a _va (for virtual address) at the end. And not really

_va seems fine:)

> mention it in the documentation. Plus the kdoc of the function should
> say that this is just a thin wrapper around other page pool APIs, and
> it's safe to mix it with other page pool APIs?

I am not sure I understand what do 'safe' and 'mix' mean here.

For 'safe' part, I suppose you mean if there is a va accociated with
a 'struct page' without calling some API like kmap()? For that, I suppose
it is safe when the driver is calling page_pool API without the
__GFP_HIGHMEM flag. Maybe we should mention that in the kdoc and give a
warning if page_pool_*alloc_va() is called with the __GFP_HIGHMEM flag?

For the 'mix', I suppose you mean the below:
1. Allocate a page with the page_pool_*alloc_va() API and free a page with
   page_pool_free() API.
2. Allocate a page with the page_pool_*alloc() API and free a page with
   page_pool_free_va() API.

For 1, it seems it is ok as some virt_to_head_page() and page_address() call
between va and 'struct page' does not seem to change anything if we have
enforce page_pool_*alloc_va() to be called without the __GFP_HIGHMEM flag.

For 2, If the va is returned from page_address() which the allocation API is
called without __GFP_HIGHMEM flag. If not, the va is from kmap*()? which means
we may be calling page_pool_free_va() before kunmap*()? Is that possible?


> .
> 

