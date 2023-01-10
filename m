Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2A663951
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 07:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjAJG1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 01:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjAJG1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 01:27:01 -0500
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84587114D
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 22:27:00 -0800 (PST)
Message-ID: <476f705b-8501-dfd8-d62e-30d00b4a7d64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673332018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxQSz7qll9s1RwS980AxHIIlWHG2TPtImp3aWtwJLZU=;
        b=OW2Ufmw2dye7Hpz8fWp8W+2WwbWeV1UiFYPmOdOnzKMsciD3N8cu0zq2c/JB7EwFT9Amv0
        7Hxd9MS9lxpgonMp7nx7Ah+I1vDwaYjToznM876ol12bBeUQNi/7FOfoPmG/IktMNLxGES
        DRKj+xOtng2AQfTAQrIsO4jW+u/dQV0=
Date:   Mon, 9 Jan 2023 22:26:53 -0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <2f875cf9-88ac-1406-4ad0-f7647fb92883@huaweicloud.com>
 <CAADnVQ+z-Y6Yv2i-icAUy=Uyh9yiN4S1AOrLd=K8mu32TXORkw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+z-Y6Yv2i-icAUy=Uyh9yiN4S1AOrLd=K8mu32TXORkw@mail.gmail.com>
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

On 1/3/23 11:38 AM, Alexei Starovoitov wrote:
> On Tue, Jan 3, 2023 at 5:40 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> On 1/1/2023 9:26 AM, Alexei Starovoitov wrote:
>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Hi,
>>>>
>>>> The patchset tries to fix the problems found when checking how htab map
>>>> handles element reuse in bpf memory allocator. The immediate reuse of
>>>> freed elements may lead to two problems in htab map:
>>>>
>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>>>      htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>>>      flag which acquires bpf-spin-lock during value copying. The
>>>>      corruption of bpf-spin-lock may result in hard lock-up.
>>>> (2) lookup procedure may get incorrect map value if the found element is
>>>>      freed and then reused.
>>>>
>>>> Because the type of htab map elements are the same, so problem #1 can be
>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>>>> these special fields in map element only when the map element is newly
>>>> allocated. If it is just a reused element, there will be no
>>>> reinitialization.
>>> Instead of adding the overhead of ctor callback let's just
>>> add __GFP_ZERO to flags in __alloc().
>>> That will address the issue 1 and will make bpf_mem_alloc behave just
>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
>>> will behave the same way.
>> Use __GPF_ZERO will be simpler, but the overhead of memset() for every allocated
>> object may be bigger than ctor callback when the size of allocated object is
>> large. And it also introduces unnecessary memory zeroing if there is no special
>> field in the map value.
> 
> Small memset is often faster than an indirect call.
> I doubt that adding GFP_ZERO will have a measurable perf difference
> in map_perf_test and other benchmarks.
> 
>>>> Problem #2 exists for both non-preallocated and preallocated htab map.
>>>> By adding seq in htab element, doing reuse check and retrying the
>>>> lookup procedure may be a feasible solution, but it will make the
>>>> lookup API being hard to use, because the user needs to check whether
>>>> the found element is reused or not and repeat the lookup procedure if it
>>>> is reused. A simpler solution would be just disabling freed elements
>>>> reuse and freeing these elements after lookup procedure ends.
>>> You've proposed this 'solution' twice already in qptrie thread and both
>>> times the answer was 'no, we cannot do this' with reasons explained.
>>> The 3rd time the answer is still the same.
>> This time a workable demo which calls call_rcu_task_trace() in batch is provided
>> :) Also because I can not find a better solution for the reuse problem. But you
>> are right, although don't reuse the freed element will make the implementation
>> of map simpler, the potential OOM problem is hard to solve specially when RCU
>> tasks trace grace period is slow. Hope Paul can provide some insight about the
>> problem.
> 
> OOM is exactly the reason why we cannot do this delaying logic
> in the general case. We don't control what progs do and rcu tasks trace
> may take a long time.

I haven't looked at the details of this patch yet. Since Hou was asking in
https://lore.kernel.org/bpf/6e4ec7a4-9ac9-417c-c11a-de59e72a6e42@huawei.com/ for 
the local storage use case (thanks!), so continue the discussion in this thread.

Some of my current thoughts, the local storage map is a little different from 
the more generic bpf map (eg htab). The common use case in local storage map is 
less demanding on the alloc/free path. The storage is usually allocated once and 
then stays for the whole lifetime with its owner (sk, task, cgrp, or inode). 
There is no update helper, so it encourages a get() and then followed by an 
in-place modification. Beside, the current local storage is also freed after 
going through a rcu tasks trace gp.

That said, I am checking to see if the common local storage use case can be 
modified to safely reuse without waiting the gp. It will then be an improvement 
on the existing implementation. The bottom line is not slowing down the current 
get (ie lookup) performance. Not 100% sure yet if it is doable.

The delete() helper likely still need to go through gp. Being able to avoid 
immediate reuse in bpf_mem_alloc will at least be needed for the local storage 
delete() code path.

> 
>>> This 'issue 2' existed in hashmap since very beginning for many years.
>>> It's a known quirk. There is nothing to fix really.
>> Do we need to document the unexpected behavior somewhere, because I really don't
>> know nothing about the quirk ?
> 
> Yeah. It's not documented in Documentation/bpf/map_hash.rst.
> Please send a patch to add it.
> 
>>>
>>> The graph apis (aka new gen data structs) with link list and rbtree are
>>> in active development. Soon bpf progs will be able to implement their own
>>> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
>>> be making the trade off between performance and lookup/delete race.
>> It seems these new gen data struct also need to solve the reuse problem because
>> a global bpf memory allocator is used.
> 
> Currently the graph api is single owner and kptr_xchg is used to allow
> single cpu at a time to observe the object.
> In the future we will add bpf_refcount and multi owner.
> Then multiple cpus will be able to access the same object concurrently.
> They will race to read/write the fields and it will be prog decision
> to arbitrate the access.
> In other words the bpf prog needs to have mechanisms to deal with reuse.

