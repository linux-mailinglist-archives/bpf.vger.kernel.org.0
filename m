Return-Path: <bpf+bounces-282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808F6FDD6E
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 14:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7822811E5
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 12:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4D12B73;
	Wed, 10 May 2023 12:07:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC588C1E
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 12:07:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1247D85
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 05:07:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QGYZj6qmvz18KD9;
	Wed, 10 May 2023 20:03:25 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 10 May
 2023 20:07:36 +0800
Subject: Re: [PATCH net-next v1 1/2] net: introduce and use
 skb_frag_fill_page_desc()
To: Simon Horman <simon.horman@corigine.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, <bpf@vger.kernel.org>
References: <20230509114146.20962-1-linyunsheng@huawei.com>
 <20230509114146.20962-2-linyunsheng@huawei.com>
 <ZFtYkmvQ01YxHf9s@corigine.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e78bf687-8b3f-f40f-ac52-8c3ecf7ef40f@huawei.com>
Date: Wed, 10 May 2023 20:07:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZFtYkmvQ01YxHf9s@corigine.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/5/10 16:40, Simon Horman wrote:
> + XDP people and ML
> 
> On Tue, May 09, 2023 at 07:41:45PM +0800, Yunsheng Lin wrote:
>> Most users use __skb_frag_set_page()/skb_frag_off_set()/
>> skb_frag_size_set() to fill the page desc for a skb frag.
>>
>> Introduce skb_frag_fill_page_desc() to do that.
>>
>> net/bpf/test_run.c does not call skb_frag_off_set() to
>> set the offset, "copy_from_user(page_address(page), ...)"
>> suggest that it is assuming offset to be initialized as
>> zero, so call skb_frag_fill_page_desc() with offset being
>> zero for this case.
> 
> I think the question is, what is the value of bv_offset before this patch.

sinfo seems to be part of the 'data' kzalloced in
bpf_test_init(), so bv_offset should be zero too.

> 
> Lorenzo and Stanislav, do you have any insight here?
> 
>>
>> Also, skb_frag_set_page() is not used anymore, so remove
>> it.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> ...
> 
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 738776ab8838..30be21c7d05f 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -2411,6 +2411,15 @@ static inline unsigned int skb_pagelen(const struct sk_buff *skb)
>>  	return skb_headlen(skb) + __skb_pagelen(skb);
>>  }
>>  
>> +static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
>> +					   struct page *page,
>> +					   int off, int size)
>> +{
>> +	frag->bv_page = page;
>> +	frag->bv_offset = off;
> 
> Maybe it is slightly nicer to use skb_frag_off_set() here.

Yes, that is good idea.
But we need to move the definition of skb_frag_off_set() before
skb_frag_fill_page_desc in order to use it, I try to keep the
patch simple for reviewing for now, so I perfer to not do it
now if that is ok for you.

> 


