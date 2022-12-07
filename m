Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283F06451ED
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLGCUo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLGCUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:20:33 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A354376
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:20:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NRgx23nMJz4f3v5L
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:20:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgC32tdl+I9jB5coBw--.43022S2;
        Wed, 07 Dec 2022 10:20:25 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/2] bpf: Reuse freed element in free_by_rcu
 during allocation
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-2-houtao@huaweicloud.com>
 <05d1f326-55cc-d327-9e0a-e93add2a29cf@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <86fd4485-a016-d6f6-c31b-3aa76c261e91@huaweicloud.com>
Date:   Wed, 7 Dec 2022 10:20:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <05d1f326-55cc-d327-9e0a-e93add2a29cf@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgC32tdl+I9jB5coBw--.43022S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47WF1rJFW3ZF15tFy7ZFb_yoWrXFyUpr
        s5Gry5GFWUAF1fA3WUJr18Gry3uw48JwnrJFy8XF1Utr43Xr1jgr1F9r1qgFy5Ar48A3WU
        Jr1qqrnrZr45XFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 12/7/2022 9:52 AM, Yonghong Song wrote:
>
>
> On 12/5/22 8:29 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When there are batched freeing operations on a specific CPU, part of
>> the freed elements ((high_watermark - lower_watermark) / 2 + 1) will
>> be moved to waiting_for_gp list and the remaining part will be left in
>> free_by_rcu list and waits for the expiration of RCU-tasks-trace grace
>> period and the next invocation of free_bulk().
>
> The change below LGTM. However, the above description seems not precise.
> IIUC, free_by_rcu list => waiting_for_gp is controlled by whether
> call_rcu_in_progress is true or not. If it is true, free_by_rcu list
> will remain intact and not moving into waiting_for_gp list.
> So it is not 'the remaining part will be left in free_by_rcu'.
> It is all elements in free_by_rcu to waiting_for_gp or none.
Thanks for the review and the suggestions. I tried to say that moving from
free_by_rcu to waiting_for_gp is slow, and there can be many free elements being
stacked on free_by_rcu list. So how about the following rephrasing or do you
still prefer "It is all elements in free_by_rcu to waiting_for_gp or none."  ?

When there are batched freeing operations on a specific CPU, part of the freed
elements ((high_watermark - lower_watermark) / 2 + 1) will be moved to
waiting_for_gp list  and the remaining part will be left in free_by_rcu list.
These elements in free_by_rcu list will be moved into waiting_for_gp list after
one RCU-tasks-trace grace period and another invocation of free_bulk(), so there
may be many free elements being stacked on free_by_rcu_list.

>>
>> So instead of invoking __alloc_percpu_gfp() or kmalloc_node() to
>> allocate a new object, in alloc_bulk() just check whether or not there
>> is freed element in free_by_rcu and reuse it if available.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> LGTM except the above suggestions.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
>> ---
>>   kernel/bpf/memalloc.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 8f0d65f2474a..7daf147bc8f6 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -171,9 +171,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt,
>> int node)
>>       memcg = get_memcg(c);
>>       old_memcg = set_active_memcg(memcg);
>>       for (i = 0; i < cnt; i++) {
>> -        obj = __alloc(c, node);
>> -        if (!obj)
>> -            break;
>> +        /*
>> +         * free_by_rcu is only manipulated by irq work refill_work().
>> +         * IRQ works on the same CPU are called sequentially, so it is
>> +         * safe to use __llist_del_first() here. If alloc_bulk() is
>> +         * invoked by the initial prefill, there will be no running
>> +         * irq work, so __llist_del_first() is fine as well.
>> +         *
>> +         * In most cases, objects on free_by_rcu are from the same CPU.
>> +         * If some objects come from other CPUs, it doesn't incur any
>> +         * harm because NUMA_NO_NODE means the preference for current
>> +         * numa node and it is not a guarantee.
>> +         */
>> +        obj = __llist_del_first(&c->free_by_rcu);
>> +        if (!obj) {
>> +            obj = __alloc(c, node);
>> +            if (!obj)
>> +                break;
>> +        }
>>           if (IS_ENABLED(CONFIG_PREEMPT_RT))
>>               /* In RT irq_work runs in per-cpu kthread, so disable
>>                * interrupts to avoid preemption and interrupts and
>
> .

