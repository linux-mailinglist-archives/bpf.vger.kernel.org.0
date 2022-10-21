Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA8606CD5
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJUBGS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUBGR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:06:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C574230ABF
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:06:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MtmSN1qZhzKJqB
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:03:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgA3SlyA8FFjs8YzAg--.16179S2;
        Fri, 21 Oct 2022 09:06:12 +0800 (CST)
Subject: Re: [PATCH bpf 1/2] bpf: Wait for busy refill_work when destorying
 bpf memory allocator
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221019115539.983394-1-houtao@huaweicloud.com>
 <20221019115539.983394-2-houtao@huaweicloud.com>
 <Y1BENCpam1I+anXF@google.com>
 <381c1d2e-a87a-c143-dc4a-4e3210d5d3f0@huaweicloud.com>
 <CAKH8qBunP1LR4jCWV5Ye0YZS4sYZ0fnHkG5=o7BoCMP=n2_UDQ@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <24992eb0-f9f9-2107-bd7c-279d176f5f9f@huaweicloud.com>
Date:   Fri, 21 Oct 2022 09:06:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAKH8qBunP1LR4jCWV5Ye0YZS4sYZ0fnHkG5=o7BoCMP=n2_UDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgA3SlyA8FFjs8YzAg--.16179S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xtw1kJFykXw4fKF4DArb_yoWrGFW7pF
        WfKFW5Ars8XFsrXw1I9w1xXas2k34xKw13Gw45J34Svrn8tF1UG397KFyjgFyY9rs5Kw42
        vrsFkFWrZFy5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/21/2022 1:49 AM, Stanislav Fomichev wrote:
> On Wed, Oct 19, 2022 at 6:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 10/20/2022 2:38 AM, sdf@google.com wrote:
>>> On 10/19, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
SNIP
>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>>> index 94f0f63443a6..48e606aaacf0 100644
>>>> --- a/kernel/bpf/memalloc.c
>>>> +++ b/kernel/bpf/memalloc.c
>>>> @@ -497,6 +497,16 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>>>>           rcu_in_progress = 0;
>>>>           for_each_possible_cpu(cpu) {
>>>>               c = per_cpu_ptr(ma->cache, cpu);
>>>> +            /*
>>>> +             * refill_work may be unfinished for PREEMPT_RT kernel
>>>> +             * in which irq work is invoked in a per-CPU RT thread.
>>>> +             * It is also possible for kernel with
>>>> +             * arch_irq_work_has_interrupt() being false and irq
>>>> +             * work is inovked in timer interrupt. So wait for the
>>>> +             * completion of irq work to ease the handling of
>>>> +             * concurrency.
>>>> +             */
>>>> +            irq_work_sync(&c->refill_work);
>>> Does it make sense to guard these with "IS_ENABLED(CONFIG_PREEMPT_RT)" ?
>>> We do have a bunch of them sprinkled already to run alloc/free with
>>> irqs disabled.
>> No. As said in the commit message and the comments, irq_work_sync() is needed
>> for both PREEMPT_RT kernel and kernel with arch_irq_work_has_interrupt() being
>> false. And for other kernels, irq_work_sync() doesn't incur any overhead,
>> because it is  just a simple memory read through irq_work_is_busy() and nothing
>> else. The reason is the irq work must have been completed when invoking
>> bpf_mem_alloc_destroy() for these kernels.
>>
>> void irq_work_sync(struct irq_work *work)
>> {
>>        /* Remove code snippet for PREEMPT_RT and arch_irq_work_has_interrupt() */
>>         /* irq wor*/
>>         while (irq_work_is_busy(work))
>>                 cpu_relax();
>> }
> I see, thanks for clarifying! I was so carried away with that
> PREEMPT_RT that I missed the fact that arch_irq_work_has_interrupt is
> a separate thing. Agreed that doing irq_work_sync won't hurt in a
> non-preempt/non-has_interrupt case.
>
> In this case, can you still do a respin and fix the spelling issue in
> the comment? You can slap my acked-by for the v2:
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> s/work is inovked in timer interrupt. So wait for the/... invoked .../
Thanks. Will update the commit message and the comments in v2 to fix the typos
and add notes about the fact that there is no overhead under non-PREEMPT_RT and
arch_irq_work_hash_interrupt() kernel.
>
>>> I was also trying to see if adding local_irq_save inside drain_mem_cache
>>> to pair with the ones from refill might work, but waiting for irq to
>>> finish seems easier...
>> Disabling hard irq works, but irq_work_sync() is still needed to ensure it is
>> completed before freeing its memory.
>>> Maybe also move both of these in some new "static void irq_work_wait"
>>> to make it clear that the PREEMT_RT comment applies to both of them?
>>>
>>> Or maybe that helper should do 'for_each_possible_cpu(cpu)
>>> irq_work_sync(&c->refill_work);'
>>> in the PREEMPT_RT case so we don't have to call it twice?
>> drain_mem_cache() is also time consuming somethings, so I think it is better to
>> interleave irq_work_sync() and drain_mem_cache() to reduce waiting time.
>>
>>>>               drain_mem_cache(c);
>>>>               rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>>>>           }
>>>> @@ -511,6 +521,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>>>>               cc = per_cpu_ptr(ma->caches, cpu);
>>>>               for (i = 0; i < NUM_CACHES; i++) {
>>>>                   c = &cc->cache[i];
>>>> +                irq_work_sync(&c->refill_work);
>>>>                   drain_mem_cache(c);
>>>>                   rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>>>>               }
>>>> --
>>>> 2.29.2
>>> .
> .

