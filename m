Return-Path: <bpf+bounces-29155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007838C08E9
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 03:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE522839CE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85DC13A3F0;
	Thu,  9 May 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z4Up2mBj"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DB3C482
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217081; cv=none; b=jm/DbGkNHTuihLPBN6vWd7UFks++DjS3FKePIK8bkybGaIaO3fWmF1XPYKdH4FyBtwKOZI/mQxvJr5OqVr/Rv48y1rOclf69upRGwEuHraEGI0PLjHEwaCHilZeRhTL3cKUuCUuIUS76OpnTH9lHaHJ02hqU3quEMDd6PqMpq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217081; c=relaxed/simple;
	bh=UwEZSQM3niBNxY7aZPq+blxbStmqtZ9rzCRmPUNbaeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9TnpmC5uZxxE2ZEDeqk/E5eQi+WodWH1dwu9MzFM0YpO56kmlaC1ak7X0E1ifaT0iKYqC8V5epjmcp7dueSgJp/TitvQUQCPd8fOJqgjDUKdjcDZ/AQUxM9HEP1HF8U3UzTVzwqQv7DeFDEYecqJQu/aTz7urnbtsr439vQ+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z4Up2mBj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715217076; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BKCDXWVhwcBboopblbpWtGkFD/ChzakRDpvtvp2T2N8=;
	b=Z4Up2mBjLb5zIiLlW6h3cT6Ro/7gRAN0MI24rZGjsXsDfAZ0ub602QICfq2GpqBAuCp6dyTa3LNvkQ8t+faQrdgi4ieWya7pvBYBa8J9twrf27/LqW95sH0wbvPkkisj9HzJNUbCwrsZaWfMDgYBcdbQ69QHfhGVthvqyE+V9QY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0W64zi4G_1715217073;
Received: from 30.221.128.110(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W64zi4G_1715217073)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 09:11:15 +0800
Message-ID: <b8afd57d-1167-4821-91e3-8e3e34cf94c4@linux.alibaba.com>
Date: Thu, 9 May 2024 09:11:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_dynptr_from_skb() for tp_btf
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Daniel Rosenberg <drosen@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, bpf <bpf@vger.kernel.org>
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-2-lulie@linux.alibaba.com>
 <5d4f681a-6636-4c98-9b1e-5c5170b79f7c@linux.dev>
 <CAADnVQJ1tycykaGEkD1ubi-kjFapKJBhffYePNsgQH7qh_9ivw@mail.gmail.com>
 <07ea0e86-ca28-42e9-9e8f-a4188aef1096@linux.dev>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <07ea0e86-ca28-42e9-9e8f-a4188aef1096@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/9 08:24, Martin KaFai Lau wrote:
> On 5/6/24 4:29 PM, Alexei Starovoitov wrote:
>> On Mon, May 6, 2024 at 2:39 PM Martin KaFai Lau <martin.lau@linux.dev> 
>> wrote:
>>>
>>> On 4/30/24 5:18 AM, Philo Lu wrote:
>>>> Making tp_btf able to use bpf_dynptr_from_skb(), which is useful for 
>>>> skb
>>>> parsing, especially for non-linear paged skb data. This is achieved by
>>>> adding KF_TRUSTED_ARGS flag to bpf_dynptr_from_skb and registering it
>>>> for TRACING progs. With KF_TRUSTED_ARGS, args from fentry/fexit are
>>>> excluded, so that unsafe progs like fexit/__kfree_skb are not allowed.
>>>>
>>>> We also need the skb dynptr to be read-only in tp_btf. Because
>>>> may_access_direct_pkt_data() returns false by default when checking
>>>> bpf_dynptr_from_skb, there is no need to add BPF_PROG_TYPE_TRACING 
>>>> to it
>>>> explicitly.
>>>>
>>>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>>>> ---
>>>>    net/core/filter.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index 786d792ac816..399492970b8c 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>> @@ -11990,7 +11990,7 @@ int bpf_dynptr_from_skb_rdonly(struct 
>>>> sk_buff *skb, u64 flags,
>>>>    }
>>>>
>>>>    BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>>>> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
>>>> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>>>
>>> I can see the usefulness of having the same way parsing the header as 
>>> the
>>> tc-bpf. However, it implicitly means the skb->data and skb_shinfo are 
>>> trusted
>>> also. afaik, it should be as long as skb is not NULL.
>>>
>>>   From looking at include/trace/events, there is case that skb is 
>>> NULL. e.g.
>>> tcp_send_reset. It is not something new though, e.g. using skb->sk in 
>>> the tp_btf
>>> could be bad already. This should be addressed before allowing more 
>>> kfunc/helper.
>>
>> Good catch.
>> We need to fix this part first:
>>          if (prog_args_trusted(prog))
>>                  info->reg_type |= PTR_TRUSTED;
>>
>> Brute force fix by adding PTR_MAYBE_NULL is probably overkill.
>> I suspect passing NULL into tracepoint is more of an exception than 
>> the rule.
>> Maybe we can use kfunc's "__" suffix approach for tracepoint args?
>> [43947] FUNC_PROTO '(anon)' ret_type_id=0 vlen=4
>>          '__data' type_id=10
>>          'sk' type_id=3434
>>          'skb' type_id=2386
>>          'reason' type_id=39860
>> [43948] FUNC '__bpf_trace_tcp_send_reset' type_id=43947 linkage=static
>>
>> Then do:
>> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
>> index 49b5ee091cf6..325e8a31729a 100644
>> --- a/include/trace/events/tcp.h
>> +++ b/include/trace/events/tcp.h
>> @@ -91,7 +91,7 @@ DEFINE_RST_REASON(FN, FN)
>>   TRACE_EVENT(tcp_send_reset,
>>
>>          TP_PROTO(const struct sock *sk,
>> -                const struct sk_buff *skb,
>> +                const struct sk_buff *skb__nullable,
>>
>> and detect it in btf_ctx_access().
> 
> +1. It is a neat solution. Thanks for the suggestion.
> 
> Philo, can you give it a try to fix this in the next re-spin?

Glad to do that. I'll try to implement a "__nullable" suffix for tracepoint.

Thanks.

