Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB6740D31
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjF1JiY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 05:38:24 -0400
Received: from dggsgout11.his.huawei.com ([45.249.212.51]:7590 "EHLO
        dggsgout11.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjF1IJV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 04:09:21 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrZ3x11gQz4f468f;
        Wed, 28 Jun 2023 16:09:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDXt9Wq6ptkXUONMg--.704S2;
        Wed, 28 Jun 2023 16:09:17 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To:     Alexei Starovoitov <ast@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-10-alexei.starovoitov@gmail.com>
 <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
 <CAADnVQJViJh47Cze186XCS0_jeQMb1wu6BfVZiQL6982a_hhfg@mail.gmail.com>
 <417e4d9c-7b69-0b9a-07e3-9af4b3b3299f@huaweicloud.com>
 <2bf11b56-7494-c0a9-09d4-c9e41aaba850@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <957dd5cd-0855-1197-7045-4cb1590bd753@huaweicloud.com>
Date:   Wed, 28 Jun 2023 16:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2bf11b56-7494-c0a9-09d4-c9e41aaba850@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDXt9Wq6ptkXUONMg--.704S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr18uF4ruF17urWUXw13Jwb_yoW5AryDpr
        48tFy5GryUJrWIyr1DKr1UGFyUtr48J3WDX3yUXFyftr15XFn0gF1xWrWjgr13Aw48Gry7
        tr4kXryxZr15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUzAwIDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 6/28/2023 8:59 AM, Alexei Starovoitov wrote:
> On 6/26/23 12:16 AM, Hou Tao wrote:
>> Hi,
>>
>> On 6/26/2023 12:42 PM, Alexei Starovoitov wrote:
>>> On Sun, Jun 25, 2023 at 8:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hi,
>>>>
>>>> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>>
>>>>> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
>>>>> Let it reuse from waiting_for_gp_ttrace as well to avoid
>>>>> unnecessary kmalloc().
>>>>>
>>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>>>> ---
>>>>>   kernel/bpf/memalloc.c | 9 +++++++++
>>>>>   1 file changed, 9 insertions(+)
>>>>>
SNIP
>>        // free A (from c1), ..., last free X (allocated from c0)
>>      P3: unit_free(c1)
>>          // the last freed element X is from c0
>>          c1->tgt = c0
>>          c1->free_llist->first -> X -> Y -> ... -> A
>>      P3: free_bulk(c1)
>>          enque_to_free(c0)
>>              c0->free_by_rcu_ttrace->first -> A -> ... -> Y -> X
>>          __llist_add_batch(c0->waiting_for_gp_ttrace)
>>              c0->waiting_for_gp_ttrace = A -> ... -> Y -> X
>
> In theory that's possible, but for this to happen one cpu needs
> to be thousand times slower than all others and since there is no
> preemption in llist_del_first I don't think we need to worry about it.

Not sure whether or not such case will be possible in a VM, after all,
the CPU X is just a thread in host and it may be preempted in any time
and with any duration.
> Also with removal of _tail optimization the above
> llist_add_batch(waiting_for_gp_ttrace)
> will become a loop, so reused element will be at the very end
> instead of top, so one cpu to million times slower which is not
> realistic.

It is still possible A will be added back as
waiting_for_gp_ttrace->first after switching to llist_add() as shown
below. My questions is how much is the benefit for reusing from
waiting_for_gp_ttrace ?

    // free A (from c1), ..., last free X (allocated from c0) 
    P3: unit_free(c1)
        // the last freed element X is allocated from c0
        c1->tgt = c0
        c1->free_llist->first -> A -> ... -> Y
        c1->free_llist_extra -> X

    P3: free_bulk(c1)
        enque_to_free(c0) 
            c0->free_by_rcu_ttrace->first -> Y -> ... A
            c0->free_by_rcu_ttrace->first -> X -> Y -> ... A

        llist_add(c0->waiting_for_gp_ttrace)
            c0->waiting_for_gp_ttrace = A -> .. -> Y -> X

>
>> P1:
>>      // A is added back as first again
>>      // but llist_del_first() didn't know
>>      try_cmpxhg(&c0->waiting_for_gp_ttrace->first, A, B)
>>      // c0->waiting_for_gp_trrace is corrupted
>>      c0->waiting_for_gp_ttrace->first = B
>>

