Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD166379C
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 04:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjAJDD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 22:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjAJDDn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 22:03:43 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D264261B
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 19:03:35 -0800 (PST)
Message-ID: <b3a0f609-1da6-55e5-da6c-58921f91b43f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673319814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78Y16Otyk5IqB4Cy8fjcM9gW9Ku5ChEI8tva5ZbUDC0=;
        b=c5o6/JXDgXqVGPEacnr9tMGddsR3d+xEb7wYFa60ZhjQFIyi4fQ7m2ooBb9jBqSDWv0rP1
        H+W06i3yC7Vj5okQisC7ORpI20UTsnWdlXT9eKll97yOvKWvZ64lBlVdYesCmT8BHolNPm
        pdv1OHz/II9/lwrbKu3Lg0yuKxnH0Sc=
Date:   Mon, 9 Jan 2023 19:03:29 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v4 1/2] bpf: hash map, avoid deadlock with suitable
 hash mask
Content-Language: en-US
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20230105092637.35069-1-tong@infragraf.org>
 <28f6d8e5-f01d-d63b-a326-aa4e63b5c804@linux.dev>
 <22C7F5C2-073C-4692-B847-C090F7E69B79@infragraf.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <22C7F5C2-073C-4692-B847-C090F7E69B79@infragraf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/9/23 6:25 PM, Tonghao Zhang wrote:
> 
> 
>> On Jan 10, 2023, at 9:52 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/5/23 1:26 AM, tong@infragraf.org wrote:
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 5aa2b5525f79..974f104f47a0 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>>>   {
>>>   	unsigned long flags;
>>>   -	hash = hash & HASHTAB_MAP_LOCK_MASK;
>>> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>>>     	preempt_disable();
>>>   	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
>>> @@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>>>   				      struct bucket *b, u32 hash,
>>>   				      unsigned long flags)
>>>   {
>>> -	hash = hash & HASHTAB_MAP_LOCK_MASK;
>>> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>>
>> Please run checkpatch.pl.  patchwork also reports the same thing:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20230105092637.35069-1-tong@infragraf.org/
>>
>> CHECK: spaces preferred around that '-' (ctx:WxV)
>> #46: FILE: kernel/bpf/hashtab.c:155:
>> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>> 	                                                                ^
>>
>> CHECK: spaces preferred around that '-' (ctx:WxV)
>> #55: FILE: kernel/bpf/hashtab.c:174:
>> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>>
>> btw, instead of doing this min_t and -1 repeatedly, ensuring n_buckets is at least HASHTAB_MAP_LOCK_COUNT during map_alloc should be as good?  htab having 2 or 4 max_entries should be pretty uncommon.
>>
> I think we should not limit the max_entries, while it’s not common use case. But for performance, we can introduce htab->n_buckets_mask = HASHTAB_MAP_LOCK_COUNT & (htab->n_buckets -1) ?

To be clear, I didn't mean limiting max_entries... I meant lower bound the 
n_buckets to HASHTAB_MAP_LOCK_COUNT.

imo, adding another n_buckets_mask to htab is even worse for this uncommon case. 
eg. the future code needs to be more careful when to use which one.

It was a suggestion, if you insist on min_t during htab_(un)lock_bucket is fine.
