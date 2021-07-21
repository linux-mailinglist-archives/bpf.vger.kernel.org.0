Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8533D0A83
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhGUHis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 03:38:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12282 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhGUHfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 03:35:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GV7Z021S8z7wb4;
        Wed, 21 Jul 2021 16:10:48 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 16:15:24 +0800
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 16:15:23 +0800
Subject: Re: [PATCH rfc v6 2/4] page_pool: add interface to manipulate frag
 count in page pool
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcin Wojtas <mw@semihalf.com>, <linuxarm@openeuler.org>,
        <yisen.zhuang@huawei.com>, "Salil Mehta" <salil.mehta@huawei.com>,
        <thomas.petazzoni@bootlin.com>, <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Will Deacon" <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>, <fenghua.yu@intel.com>,
        <guro@fb.com>, Peter Xu <peterx@redhat.com>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matteo Croce <mcroce@microsoft.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "Alexander Lobakin" <alobakin@pm.me>,
        Willem de Bruijn <willemb@google.com>, <wenxu@ucloud.cn>,
        Cong Wang <cong.wang@bytedance.com>,
        Kevin Hao <haokexin@gmail.com>, <nogikh@google.com>,
        Marco Elver <elver@google.com>, Yonghong Song <yhs@fb.com>,
        <kpsingh@kernel.org>, <andrii@kernel.org>,
        "Martin KaFai Lau" <kafai@fb.com>, <songliubraving@fb.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <1626752145-27266-1-git-send-email-linyunsheng@huawei.com>
 <1626752145-27266-3-git-send-email-linyunsheng@huawei.com>
 <CAKgT0Uf=WbpngDPQ1V0X+XSJbZ91=cuaz8r_J96=BrXg01PJFA@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <92e68f4e-49a4-568c-a281-2865b54a146e@huawei.com>
Date:   Wed, 21 Jul 2021 16:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf=WbpngDPQ1V0X+XSJbZ91=cuaz8r_J96=BrXg01PJFA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021/7/20 23:43, Alexander Duyck wrote:
> On Mon, Jul 19, 2021 at 8:36 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> For 32 bit systems with 64 bit dma, dma_addr[1] is used to
>> store the upper 32 bit dma addr, those system should be rare
>> those days.
>>
>> For normal system, the dma_addr[1] in 'struct page' is not
>> used, so we can reuse dma_addr[1] for storing frag count,
>> which means how many frags this page might be splited to.
>>
>> In order to simplify the page frag support in the page pool,
>> the PAGE_POOL_DMA_USE_PP_FRAG_COUNT macro is added to indicate
>> the 32 bit systems with 64 bit dma, and the page frag support
>> in page pool is disabled for such system.
>>
>> The newly added page_pool_set_frag_count() is called to reserve
>> the maximum frag count before any page frag is passed to the
>> user. The page_pool_atomic_sub_frag_count_return() is called
>> when user is done with the page frag.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/mm_types.h | 18 +++++++++++++-----
>>  include/net/page_pool.h  | 41 ++++++++++++++++++++++++++++++++++-------
>>  net/core/page_pool.c     |  4 ++++
>>  3 files changed, 51 insertions(+), 12 deletions(-)
>>
> 
> <snip>
> 
>> +static inline long page_pool_atomic_sub_frag_count_return(struct page *page,
>> +                                                         long nr)
>> +{
>> +       long frag_count = atomic_long_read(&page->pp_frag_count);
>> +       long ret;
>> +
>> +       if (frag_count == nr)
>> +               return 0;
>> +
>> +       ret = atomic_long_sub_return(nr, &page->pp_frag_count);
>> +       WARN_ON(ret < 0);
>> +       return ret;
>>  }
>>
> 
> So this should just be an atomic_long_sub_return call. You should get
> rid of the atomic_long_read portion of this as it can cover up
> reference count errors.

atomic_long_sub_return() is used to avoid one possible cache bouncing and
barrrier caused by the last user.

You are right that that may cover up the reference count errors. How about
something like below:

static inline long page_pool_atomic_sub_frag_count_return(struct page *page,
							  long nr)
{
#ifdef CONFIG_DEBUG_PAGE_REF
	long ret = atomic_long_sub_return(nr, &page->pp_frag_count);

	WARN_ON(ret < 0);

	return ret;
#else
	if (atomic_long_read(&page->pp_frag_count) == nr)
		return 0;

	return atomic_long_sub_return(nr, &page->pp_frag_count);
#end
}

Or any better suggestion?


> .
> 
