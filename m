Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284D6F62F4
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 04:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEDCal (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 22:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 22:30:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF0E49;
        Wed,  3 May 2023 19:30:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBd8V423Xz4f3vfV;
        Thu,  4 May 2023 10:30:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDnUCvHGFNkYTHIIA--.62942S2;
        Thu, 04 May 2023 10:30:35 +0800 (CST)
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <986216a3-437a-5219-fd9a-341786e9264b@huaweicloud.com>
 <20230504020051.xga5y5dj3rxobmea@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <d3169329-1453-e87a-fbb0-e1435f0741dc@huaweicloud.com>
Date:   Thu, 4 May 2023 10:30:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230504020051.xga5y5dj3rxobmea@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDnUCvHGFNkYTHIIA--.62942S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1xXF13uFWDArWUJw45trb_yoW7AFy8pF
        Wfta4Ykrs8Jr4Yv3s2qw1xu34Sy398Kr15XFyFq34DCr98Wr9IqFZ7tFy5uF93ur48Ca1a
        yryDta43ArZ8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 5/4/2023 10:00 AM, Alexei Starovoitov wrote:
> On Thu, May 04, 2023 at 09:35:17AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 5/4/2023 2:48 AM, Alexei Starovoitov wrote:
>>> On Sat, Apr 29, 2023 at 06:12:12PM +0800, Hou Tao wrote:
SNIP
>>> +			/* Already queued */
>>> +			if (!queue_work(bpf_ma_wq, &c->reuse_work))
>>> As Martin pointed out queue_work() is not safe here.
>>> The raw_spin_lock(&c->reuse_lock); earlier is not safe either.
>> I see. Didn't recognize these problems.
>>> For the next version please drop workers and spin_lock from unit_free/alloc paths.
>>> If lock has to be taken it should be done from irq_work.
>>> Under no circumstances we can use alloc_workqueue(). No new kthreads.
>> Is there any reason to prohibit the use of new kthread in irq_work ?
> Because:
> 1. there is a workable solution without kthreads.
> 2. if there was no solution we would have to come up with one.
> kthread is not an answer. It's hard to reason about a setup when kthreads
> are in critical path due to scheduler. Assume the system is 100% cpu loaded.
> kthreads delays and behavior is unpredictable. We cannot subject memory alloc/free to it.
I see. Thanks for the explanation.
>
>>> We can avoid adding new flag to bpf_mem_alloc to reduce the complexity
>>> and do roughly equivalent of REUSE_AFTER_RCU_GP unconditionally in the following way:
>>>
>>> - alloc_bulk() won't be trying to steal from c->free_by_rcu.
>>>
>>> - do_call_rcu() does call_rcu(&c->rcu, __free_rcu) instead of task-trace version.
>> No sure whether or not one inflight RCU callback is enough. Will check.
>> If one is not enough, I may use kmalloc(__GFP_NOWAIT) in irq work to
>> allocate multiple RCU callbacks.
> Pls dont. Just assume it will work, implement the proposal (if you agree),
> come back with the numbers and then we will discuss again.
> We cannot keep arguing about merits of complicated patch set that was done on partial data.
OK. Will do.
> Just like the whole thing with kthreads.
> I requested early on: "pls no kthreads" and weeks later we're still arguing.
Sorry about missing that part.
>
>>> - rcu_trace_implies_rcu_gp() is never used.
>>>
>>> - after RCU_GP __free_rcu() moves all waiting_for_gp elements into 
>>>   a size specific link list per bpf_mem_alloc (not per bpf_mem_cache which is per-cpu)
>>>   and does call_rcu_tasks_trace
>>>
>>> - Let's call this list ma->free_by_rcu_tasks_trace
>>>   (only one list for bpf_mem_alloc with known size or NUM_CACHES such lists when size == 0 at init)
>>>
>>> - any cpu alloc_bulk() can steal from size specific ma->free_by_rcu_tasks_trace list that
>>>   is protected by ma->spin_lock (1 or NUM_CACHES such locks)
>> To reduce the lock contention, alloc_bulk() can steal from the global
>> list in batch. 
> Pls no special batches. The simplest implementation possible.
> alloc_bulk() has 'int cnt' argument. It will try to steal 'cnt' from ma->free_by_rcu_tasks_trace.
I see. Will do.
>
>> Had tried the global list before but I didn't do the
>> concurrent freeing, I think it could reduce the risk of OOM for
>> add_del_on_diff_cpu.
> Maybe you've tried, but we didn't see the patches and we cannot take for granted
> anyone saying: "I've tried *foo*. It didn't work. That's why I'm doing *bar* here".
> Everything mm is tricky. Little details matter a lot.
OK. I think it will work. The reason I didn't post it is that I was
obsessed with lock-less bpf ma at that moment.
> It's also questionable whether we should make any design decisions based on this benchmark
> and in particular based on add_del_on_diff_cpu part of it.
> I'm not saying we shouldn't consider it, but all numbers have a "decision weight"
> associated with them.
I see. The reason for add_del_on_diff_cpu is just to complement the
possible use cases of bpf memory allocator.
> For example: there is existing samples/bpf/map_perf_test benchmark.
> So far we haven't seen the numbers from it.
> Is it more important than your new bench? Yes and no. All numbers matter.
Will post the benchmark result for map_perf_test in v4. Had planned to
migrate map_perf_test to selftests/bpf/benchs, but couldn't find enough
time to do that.
>
>>> - ma->waiting_for_gp_tasks_trace will be freeing elements into slab
>>>
>>> What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
>>> Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
>>> (while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)
>>>
>>> After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
>>> Probably usage of bpf_mem_alloc in local storage can be simplified as well.
>>> Martin wdyt?
>>>
>>> I think this approach adds minimal complexity to bpf_mem_alloc while solving all existing pain points
>>> including needs of qp-trie.
>> Thanks for these great suggestions. Will try to do it in v4.
> Thanks.
> Also for benchmark, pls don't hack htab and benchmark as 'non-landable patches' (as in this series).
> Construct the patch series as:
> - prep patches
> - benchmark
> - unconditional convert of bpf_ma to REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace
>   with numbers from bench(s) before and after this patch.
Thanks again for the suggestion. Will do in v4.

