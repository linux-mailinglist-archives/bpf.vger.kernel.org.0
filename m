Return-Path: <bpf+bounces-10570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D527A9CDE
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B048DB25310
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3894CFBF;
	Thu, 21 Sep 2023 18:11:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB04B216;
	Thu, 21 Sep 2023 18:11:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BEBA0F4F;
	Thu, 21 Sep 2023 10:57:03 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rrv5n1mB5z15NQt;
	Thu, 21 Sep 2023 19:57:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 21 Sep
 2023 19:59:24 +0800
Subject: Re: [PATCH net-next v9 5/6] page_pool: update document about frag API
To: Dima Tisnek <dimaqq@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
	<edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <linux-doc@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20230920115855.27631-1-linyunsheng@huawei.com>
 <20230920115855.27631-6-linyunsheng@huawei.com>
 <CAGGBzXLu7rO4bTet0wqb2Z7FmqsSu0BVuVw_LprcJcPKO1vXEg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <addf5abe-1683-d432-bf4b-e011ceba134c@huawei.com>
Date: Thu, 21 Sep 2023 19:59:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGGBzXLu7rO4bTet0wqb2Z7FmqsSu0BVuVw_LprcJcPKO1vXEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/9/21 9:02, Dima Tisnek wrote:
> Minor comment on natural language:
> 
> On Wed, Sep 20, 2023 at 9:04 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> As more drivers begin to use the frag API, update the
>> document about how to decide which API to use for the
>> driver author.
> 
> the fragment API
> 
>> +/**
>> + * page_pool_dev_alloc_frag() - allocate a page frag.
> 
> allocate a page fragment.
> 
> the precedent is set in
> https://www.kernel.org/doc/html/v5.0/vm/page_frags.html
> foo_frag is used in C code, and foo fragment in English docs.

Sure.

It seems I need to respin anyway as the newly merged idpf driver
from intel is also using the frag API, and removing PP_FLAG_PAGE_FRAG
flag breaks it.

And idpf driver really should be using the new API instead of
selecting which API to use according to the buf_size as below
in drivers/net/ethernet/intel/idpf/idpf_txrx.h, as it seems to
be assuming PAGE_SIZE always being 4K, and we may be able to
enable page split for buf_size > 2048 and PAGE_SIZE > 4K if using
the new API.

static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
                                         struct idpf_rx_buf *buf,
                                         unsigned int buf_size)
{
        if (buf_size == IDPF_RX_BUF_2048)
                buf->page = page_pool_dev_alloc_frag(pool, &buf->page_offset,
                                                     buf_size);
        else
                buf->page = page_pool_dev_alloc_pages(pool);

        if (!buf->page)
                return DMA_MAPPING_ERROR;

        buf->truesize = buf_size;

        return page_pool_get_dma_addr(buf->page) + buf->page_offset +
               pool->p.offset;
}

> 
> .
> 

