Return-Path: <bpf+bounces-39605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A579750D6
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 13:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661501C2031F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EBB187332;
	Wed, 11 Sep 2024 11:31:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7314F100;
	Wed, 11 Sep 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054282; cv=none; b=lulZSmpmyJXg5o4kvfoIdJnYaHeKKFetXlT2sqWcSi3nvxoh9f5SqjPuUw/Lql7lCTUBmlfIAtFF60OIfTe1vTgfHwZsfXJ1cgbji6bps39YsF5q19vQZ1/d+7TrTTz1u/asNeUGHawW7HMH4oZzqDw5c7D51iVXXcpDRNisWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054282; c=relaxed/simple;
	bh=RNMWO2WtthbJKl9msB3Y5qZod76Z7zlwONaoHt/pM3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gpie8H4BaAFtKEdM2ohbXV2dE3tsuESuzncgCY6cCOGcUDz6rc4G/wvd6UkBzoymOn/jIXB5HSEMzjRYhsngyCgJxGHXtle0hct7xIYQU00hnMkbWrMyOcRKfIenGRxIGDTKsGUfI30/W/CMLZlQeCbEUC95lk/CdtXvBG6Ohrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X3dfv3VlSz2Cp5l;
	Wed, 11 Sep 2024 19:30:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D79FF14010C;
	Wed, 11 Sep 2024 19:31:16 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 19:31:16 +0800
Message-ID: <15d963c2-1854-4fb7-a7a4-d8ed8cafead3@huawei.com>
Date: Wed, 11 Sep 2024 19:31:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 12/14] net: replace page_frag with
 page_frag_cache
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Ayush Sawal <ayush.sawal@chelsio.com>, Eric
 Dumazet <edumazet@google.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, John Fastabend
	<john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, David
 Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Jamal
 Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>,
	<bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
 <20240906073646.2930809-13-linyunsheng@huawei.com>
 <1884e171-cc87-4238-abd1-0f6be1e0b279@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <1884e171-cc87-4238-abd1-0f6be1e0b279@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/10 22:04, Paolo Abeni wrote:
> On 9/6/24 09:36, Yunsheng Lin wrote:
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index 49811c9281d4..6190d9bfd618 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -953,7 +953,7 @@ static int __ip_append_data(struct sock *sk,
>>                   struct flowi4 *fl4,
>>                   struct sk_buff_head *queue,
>>                   struct inet_cork *cork,
>> -                struct page_frag *pfrag,
>> +                struct page_frag_cache *nc,
>>                   int getfrag(void *from, char *to, int offset,
>>                       int len, int odd, struct sk_buff *skb),
>>                   void *from, int length, int transhdrlen,
>> @@ -1228,13 +1228,19 @@ static int __ip_append_data(struct sock *sk,
>>               copy = err;
>>               wmem_alloc_delta += copy;
>>           } else if (!zc) {
>> +            struct page_frag page_frag, *pfrag;
>>               int i = skb_shinfo(skb)->nr_frags;
>> +            void *va;
>>                 err = -ENOMEM;
>> -            if (!sk_page_frag_refill(sk, pfrag))
>> +            pfrag = &page_frag;
>> +            va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
>> +            if (!va)
>>                   goto error;
>>                 skb_zcopy_downgrade_managed(skb);
>> +            copy = min_t(int, copy, pfrag->size);
>> +
>>               if (!skb_can_coalesce(skb, i, pfrag->page,
>>                             pfrag->offset)) {
>>                   err = -EMSGSIZE;
>> @@ -1242,18 +1248,18 @@ static int __ip_append_data(struct sock *sk,
>>                       goto error;
>>                     __skb_fill_page_desc(skb, i, pfrag->page,
>> -                             pfrag->offset, 0);
>> +                             pfrag->offset, copy);
>>                   skb_shinfo(skb)->nr_frags = ++i;
>> -                get_page(pfrag->page);
>> +                page_frag_commit(nc, pfrag, copy);
>> +            } else {
>> +                skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1],
>> +                          copy);
>> +                page_frag_commit_noref(nc, pfrag, copy);
>>               }
>> -            copy = min_t(int, copy, pfrag->size - pfrag->offset);
>> -            if (getfrag(from,
>> -                    page_address(pfrag->page) + pfrag->offset,
>> -                    offset, copy, skb->len, skb) < 0)
>> +
>> +            if (getfrag(from, va, offset, copy, skb->len, skb) < 0)
>>                   goto error_efault;
> 
> Should the 'commit' happen only when 'getfrag' is successful?
> 
> Similar question in the ipv6 code.

Good question.
First of all, even it fails, the 'goto' will handle it correctly as the
skb_shinfo(skb)->nr_frags is setup correctly.
And then 'getfrag' being failure is an unlikely case, right?

I thought about moving it when coding, but decided not to mainly get_page()
is also called before 'getfrag' as above, and I guess 'getfrag' might
involve memcpy'ing causing the cache eviction for the above data, so it
might make sense to do the likely case before 'getfrag'.

> 
> Thanks,
> 
> Paolo
> 
> 

