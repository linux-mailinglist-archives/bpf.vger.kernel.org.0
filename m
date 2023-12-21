Return-Path: <bpf+bounces-18563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378081C0E5
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD85283E7F
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC1677F38;
	Thu, 21 Dec 2023 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oi1kv71E"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B077F18
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdee34ac-f193-4481-b6ce-3f933a86afec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703197154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHBV/GCJUU5+YbTEpSGoF/px6XCo1bxI4jgFlUp4ktQ=;
	b=oi1kv71Elpk8lxdKJc7ZkZQRZOCxXei5ysbrvvvvh0hhvyZkHUUU7WRlP2FfODUw9mdGHl
	RSZ8vaCZbBWZci0L7PnGQXk3RGBdbrtmPMr1bOA2SXXQabmknFDL+lki6hKzWiXUKLAS8x
	xOc/htg9HZk7CMMc9xhuhF51Rvb63+Y=
Date: Thu, 21 Dec 2023 14:19:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>, netdev@vger.kernel.org,
 kernel-team@meta.com, Aditi Ghag <aditi.ghag@isovalent.com>,
 bpf@vger.kernel.org
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
 <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
 <8787f5c0-fed0-b8fa-997b-4d17d9966f13@iogearbox.net>
 <639b1f3f-cb53-4058-8426-14bd50f2b78f@linux.dev>
 <fb4068fd-6f69-845f-813f-d8691a966010@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fb4068fd-6f69-845f-813f-d8691a966010@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/21/23 12:27 PM, Daniel Borkmann wrote:
> On 12/21/23 3:58 PM, Martin KaFai Lau wrote:
>> On 12/21/23 5:21 AM, Daniel Borkmann wrote:
>>> On 12/21/23 5:45 AM, Martin KaFai Lau wrote:
>>>> On 12/20/23 11:10 AM, Martin KaFai Lau wrote:
>>>>> Good catch. It will unnecessary skip in the following batch/bucket if there 
>>>>> is changes in the current batch/bucket.
>>>>>
>>>>>  From looking at the loop again, I think it is better not to change the 
>>>>> iter->offset during the for loop. Only update iter->offset after the for 
>>>>> loop has concluded.
>>>>>
>>>>> The non-zero iter->offset is only useful for the first bucket, so does a 
>>>>> test on the first bucket (state->bucket == bucket) before skipping sockets. 
>>>>> Something like this:
>>>>>
>>>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>>>> index 89e5a806b82e..a993f364d6ae 100644
>>>>> --- a/net/ipv4/udp.c
>>>>> +++ b/net/ipv4/udp.c
>>>>> @@ -3139,6 +3139,7 @@ static struct sock *bpf_iter_udp_batch(struct 
>>>>> seq_file *seq)
>>>>>       struct net *net = seq_file_net(seq);
>>>>>       struct udp_table *udptable;
>>>>>       unsigned int batch_sks = 0;
>>>>> +    int bucket, bucket_offset;
>>>>>       bool resized = false;
>>>>>       struct sock *sk;
>>>>>
>>>>> @@ -3162,14 +3163,14 @@ static struct sock *bpf_iter_udp_batch(struct 
>>>>> seq_file *seq)
>>>>>       iter->end_sk = 0;
>>>>>       iter->st_bucket_done = false;
>>>>>       batch_sks = 0;
>>>>> +    bucket = state->bucket;
>>>>> +    bucket_offset = 0;
>>>>>
>>>>>       for (; state->bucket <= udptable->mask; state->bucket++) {
>>>>>           struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
>>>>>
>>>>> -        if (hlist_empty(&hslot2->head)) {
>>>>> -            iter->offset = 0;
>>>>> +        if (hlist_empty(&hslot2->head))
>>>>>               continue;
>>>>> -        }
>>>>>
>>>>>           spin_lock_bh(&hslot2->lock);
>>>>>           udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>>>> @@ -3177,8 +3178,9 @@ static struct sock *bpf_iter_udp_batch(struct 
>>>>> seq_file *seq)
>>>>>                   /* Resume from the last iterated socket at the
>>>>>                    * offset in the bucket before iterator was stopped.
>>>>>                    */
>>>>> -                if (iter->offset) {
>>>>> -                    --iter->offset;
>>>>> +                if (state->bucket == bucket &&
>>>>> +                    bucket_offset < iter->offset) {
>>>>> +                    ++bucket_offset;
>>>>>                       continue;
>>>>>                   }
>>>>>                   if (iter->end_sk < iter->max_sk) {
>>>>> @@ -3192,10 +3194,10 @@ static struct sock *bpf_iter_udp_batch(struct 
>>>>> seq_file *seq)
>>>>>
>>>>>           if (iter->end_sk)
>>>>>               break;
>>>>> +    }
>>>>>
>>>>> -        /* Reset the current bucket's offset before moving to the next 
>>>>> bucket. */
>>>>> +    if (state->bucket != bucket)
>>>>>           iter->offset = 0;
>>>>> -    }
>>>>>
>>>>>       /* All done: no batch made. */
>>>>>       if (!iter->end_sk)
>>>>
>>>> I think I found another bug in the current bpf_iter_udp_batch(). The 
>>>> "state->bucket--;" at the end of the batch() function is wrong also. It does 
>>>> not need to go back to the previous bucket. After realloc with a larger 
>>>> batch array, it should retry on the "state->bucket" as is. I tried to force 
>>>> the bind() to use bucket 0 and bind a larger so_reuseport set (24 sockets). 
>>>> WARN_ON(state->bucket < 0) triggered.
>>>>
>>>> Going back to this bug (backward progress on --iter->offset), I think it is 
>>>> a bit cleaner to always reset iter->offset to 0 and advance iter->offset to 
>>>> the resume_offset only when needed. Something like this:
>>>
>>> Hm, my assumption was.. why not do something like the below, and fully start 
>>> over?
>>>
>>> I'm mostly puzzled about the side-effects here, in particular, if for the 
>>> rerun the sockets
>>> in the bucket could already have changed.. maybe I'm still missing something 
>>> - what do
>>> we need to deal with exactly worst case when we need to go and retry 
>>> everything, and what
>>> guarantees do we have?
>>>
>>> (only compile tested)
>>>
>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>> index 89e5a806b82e..ca62a4bb7bec 100644
>>> --- a/net/ipv4/udp.c
>>> +++ b/net/ipv4/udp.c
>>> @@ -3138,7 +3138,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
>>> *seq)
>>>       struct udp_iter_state *state = &iter->state;
>>>       struct net *net = seq_file_net(seq);
>>>       struct udp_table *udptable;
>>> -    unsigned int batch_sks = 0;
>>> +    int orig_bucket, orig_offset;
>>> +    unsigned int i, batch_sks = 0;
>>>       bool resized = false;
>>>       struct sock *sk;
>>>
>>> @@ -3149,7 +3150,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
>>> *seq)
>>>       }
>>>
>>>       udptable = udp_get_table_seq(seq, net);
>>> -
>>> +    orig_bucket = state->bucket;
>>> +    orig_offset = iter->offset;
>>>   again:
>>>       /* New batch for the next bucket.
>>>        * Iterate over the hash table to find a bucket with sockets matching
>>> @@ -3211,9 +3213,15 @@ static struct sock *bpf_iter_udp_batch(struct seq_file 
>>> *seq)
>>>       if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
>>>           resized = true;
>>>           /* After allocating a larger batch, retry one more time to grab
>>> -         * the whole bucket.
>>> +         * the whole bucket. Drop the current refs since for the next
>>> +         * attempt the composition could have changed, thus start over.
>>>            */
>>> -        state->bucket--;
>>> +        for (i = 0; i < iter->end_sk; i++) {
>>> +            sock_put(iter->batch[i]);
>>> +            iter->batch[i] = NULL;
>>> +        }
>>> +        state->bucket = orig_bucket;
>>> +        iter->offset = orig_offset;
>>
>> It does not need to start over from the orig_bucket. Once it advanced to the 
>> next bucket (state->bucket++), the orig_bucket is done. Otherwise, it may need 
>> to make backward progress here on the state->bucket. The batch size too small 
>> happens on the current state->bucket, so it should retry with the same 
>> state->bucket after realloc_batch(). If the state->bucket happens to be the 
>> orig_bucket (mean it has not advanced), it will skip the same orig_offset.
>>
>> If the orig_bucket had changed (e.g. having more sockets than the last time it 
>> was batched) after state->bucket++, it is arguably fine because it was added 
>> after the orig_bucket was completely captured in a batch before. The same goes 
>> for (orig_bucket-1) that could have changed during the whole udp_table iteration.
> 
> Fair, I was thinking in relation to the above to avoid such inconsistency, hence 
> the drop of the refs. 
Ah, for the ref drop, the bpf_iter_udp_realloc_batch() earlier did the sock_put 
on the iter->batch[]. It is done in the bpf_iter_udp_put_batch(). When it 
retries with a larger iter->batch[] array, it does retry from the very first 
udp_sk of the state->bucket again. Thus, the intention is to do the best effort 
to capture the whole bucket under the "spin_lock_bh(&hslot2->lock)".

> I think it's probably fine to argue either way on how semantics
> should be as long as the code doesn't get overly complex for covering this corner
> case.
> 
> Thanks,
> Daniel


