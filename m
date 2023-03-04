Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0EB6AAB11
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 17:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCDQRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 11:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCDQRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 11:17:22 -0500
Received: from out-6.mta1.migadu.com (out-6.mta1.migadu.com [IPv6:2001:41d0:203:375::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198581EFE9
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 08:17:13 -0800 (PST)
Message-ID: <f67021ee-21d9-bfae-6134-4ca542fab843@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677946632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/rAQBxzRQNATwOK0rc1KqadFJf0o1S0zwkZqSbQf9k=;
        b=g8srgkLFyATrRXugRNIH73+VQ1N5316HVZgB7iPJkpB18UbFb6sk2Bh11V4zIu3f6y8FFP
        /wibMnfXZ5AEF1G1knL5hrpOHmayZmubXgN8R1hap6B3Fk/K1C+qcZl1SkH/MhFDBFAqOz
        TtC/r0WVUcQJWjNnaxx+j3hJ+cNqOcM=
Date:   Sat, 4 Mar 2023 08:17:07 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Support kptrs in local storage maps
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org
References: <20230225154010.391965-1-memxor@gmail.com>
 <20230225154010.391965-3-memxor@gmail.com>
 <2c4ba6a2-3225-9ffa-c537-f606c01b00e4@linux.dev>
 <CAP01T746zBF+sz3zfkGgmQ1NCQT2sXmKenN7F-09QKtLpjoiTg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAP01T746zBF+sz3zfkGgmQ1NCQT2sXmKenN7F-09QKtLpjoiTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/4/23 7:34 AM, Kumar Kartikeya Dwivedi wrote:
>>> @@ -113,10 +114,25 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
>>>        struct bpf_local_storage_elem *selem;
>>>
>>>        selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
>>> +     /* The can_use_smap bool is set whenever we need to free additional
>>> +      * fields in selem data before freeing selem. bpf_local_storage_map_free
>>> +      * only executes rcu_barrier to wait for RCU callbacks when it has
>>> +      * special fields, hence we can only conditionally dereference smap, as
>>> +      * by this time the map might have already been freed without waiting
>>> +      * for our call_rcu callback if it did not have any special fields.
>>> +      */
>>> +     if (selem->can_use_smap)
>>> +             bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
>>> +     kfree(selem);
>>> +}
>>> +
>>> +static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
>>> +{
>>> +     /* Free directly if Tasks Trace RCU GP also implies RCU GP */
>>>        if (rcu_trace_implies_rcu_gp())
>>> -             kfree(selem);
>>> +             bpf_selem_free_rcu(rcu);
>>>        else
>>> -             kfree_rcu(selem, rcu);
>>> +             call_rcu(rcu, bpf_selem_free_rcu);
>>>    }
>>>
>>>    /* local_storage->lock must be held and selem->local_storage == local_storage.
>>> @@ -170,9 +186,9 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
>>>                RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
>>>
>>>        if (use_trace_rcu)
>>> -             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
>>> +             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
>>>        else
>>> -             kfree_rcu(selem, rcu);
>>> +             call_rcu(&selem->rcu, bpf_selem_free_rcu);
>> After another thought, bpf_obj_free_fields() does not need to go through the rcu
>> gp, right?
>>
>> bpf_obj_free_fields() can be done just before the call_rcu_tasks_trace() and the
>> call_rcu() here. In hashtab, bpf_obj_free_fields() is also done just before
>> bpf_mem_cache_free().
> Perhaps not. But the original code for hashtab prior to conversion to
> use bpf_mem_cache actually freed timers and kptrs after waiting for a
> complete RCU grace period for the kmalloc case. My main idea was to
> try to delay it until the last point, where memory is returned for
> reuse. Now that does not include a RCU grace period for hashtab
> anymore because memory can be reused as soon as it is returned to
> bpf_mem_cache. Same for array maps where update does the freeing.
> 
> bpf_obj_free_fields can possibly do a lot of work, try to acquire the
> bpf_spin_lock in map value, etc. Even moreso now that we have lists
> and rbtree that could be in map values, where they have to drain all
> elements (which might have fields of their own). Not doing that in the
> context of the program calling update or delete is usually better if
> we have a choice, since it might introduce unexpected delays. Here we
> are doing an RCU callback in all cases, so I think it's better to
> delay freeing the fields and do it in RCU callback, since we are doing
> call_rcu anyway.

The delete_elem for local storage is not the common use case. The usage is 
usually to have the storage stay with its owner lifetime until the bpf storage 
is destroyed by bpf_{sk,task,inode,cgrp}_storage_free. The userspace does not 
need to track the lifetime of its owner which could be fragile.

More importantly, I am moving local storage to bpf_mem_cache_alloc/free because 
of potential deadlock during the kmalloc time: 
https://lore.kernel.org/bpf/dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev/
Thus, bpf_obj_free_fields() needs to be done before freeing the selem. I have 
already made this change in my set and will post shortly.

Thanks for the prompt reply!
