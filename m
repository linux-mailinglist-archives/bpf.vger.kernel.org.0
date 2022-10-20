Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30F6054AC
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 03:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJTBHy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 21:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTBHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 21:07:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6A1757AE
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:07:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mt8Y60dgLzl0vM
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:05:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgCnqzFgn1Bj2MqBAA--.40555S2;
        Thu, 20 Oct 2022 09:07:47 +0800 (CST)
Subject: Re: [PATCH bpf 1/2] bpf: Wait for busy refill_work when destorying
 bpf memory allocator
To:     sdf@google.com
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <381c1d2e-a87a-c143-dc4a-4e3210d5d3f0@huaweicloud.com>
Date:   Thu, 20 Oct 2022 09:07:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y1BENCpam1I+anXF@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCnqzFgn1Bj2MqBAA--.40555S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr47Gw17CFykWF4fGFyrCrg_yoWxJryxpr
        s5tryUJrWrZFn3Xw18Gw17Jryvyr18J3WUJw18JFyxZr45Gr1jqr17Wr1jgF1UXr4xJw17
        Jr1qqrW0vr15Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
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

On 10/20/2022 2:38 AM, sdf@google.com wrote:
> On 10/19, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>
>> A busy irq work is an unfinished irq work and it can be either in the
>> pending state or in the running state. When destroying bpf memory
>> allocator, refill_work may be busy for PREEMPT_RT kernel in which irq
>> work is invoked in a per-CPU RT-kthread. It is also possible for kernel
>> with arch_irq_work_has_interrupt() being false (e.g. 1-cpu arm32 host)
>> and irq work is inovked in timer interrupt.
>
>> The busy refill_work leads to various issues. The obvious one is that
>> there will be concurrent operations on free_by_rcu and free_list between
>> irq work and memory draining. Another one is call_rcu_in_progress will
>> not be reliable for the checking of pending RCU callback because
>> do_call_rcu() may has not been invoked by irq work. The other is there
>> will be use-after-free if irq work is freed before the callback of
>> irq work is invoked as shown below:
>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   #PF: supervisor instruction fetch in kernel mode
>>   #PF: error_code(0x0010) - not-present page
>>   PGD 12ab94067 P4D 12ab94067 PUD 1796b4067 PMD 0
>>   Oops: 0010 [#1] PREEMPT_RT SMP
>>   CPU: 5 PID: 64 Comm: irq_work/5 Not tainted 6.0.0-rt11+ #1
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>>   RIP: 0010:0x0
>>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>>   RSP: 0018:ffffadc080293e78 EFLAGS: 00010286
>>   RAX: 0000000000000000 RBX: ffffcdc07fb6a388 RCX: ffffa05000a2e000
>>   RDX: ffffa05000a2e000 RSI: ffffffff96cc9827 RDI: ffffcdc07fb6a388
>>   ......
>>   Call Trace:
>>    <TASK>
>>    irq_work_single+0x24/0x60
>>    irq_work_run_list+0x24/0x30
>>    run_irq_workd+0x23/0x30
>>    smpboot_thread_fn+0x203/0x300
>>    kthread+0x126/0x150
>>    ret_from_fork+0x1f/0x30
>>    </TASK>
>
>> Considering the ease of concurrency handling and the short wait time
>> used for irq_work_sync() under PREEMPT_RT (When running two test_maps on
>> PREEMPT_RT kernel and 72-cpus host, the max wait time is about 8ms and
>> the 99th percentile is 10us), just waiting for busy refill_work to
>> complete before memory draining and memory freeing.
>
>> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory
>> allocator.")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   kernel/bpf/memalloc.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 94f0f63443a6..48e606aaacf0 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -497,6 +497,16 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>>           rcu_in_progress = 0;
>>           for_each_possible_cpu(cpu) {
>>               c = per_cpu_ptr(ma->cache, cpu);
>> +            /*
>> +             * refill_work may be unfinished for PREEMPT_RT kernel
>> +             * in which irq work is invoked in a per-CPU RT thread.
>> +             * It is also possible for kernel with
>> +             * arch_irq_work_has_interrupt() being false and irq
>> +             * work is inovked in timer interrupt. So wait for the
>> +             * completion of irq work to ease the handling of
>> +             * concurrency.
>> +             */
>> +            irq_work_sync(&c->refill_work);
>
> Does it make sense to guard these with "IS_ENABLED(CONFIG_PREEMPT_RT)" ?
> We do have a bunch of them sprinkled already to run alloc/free with
> irqs disabled.
No. As said in the commit message and the comments, irq_work_sync() is needed
for both PREEMPT_RT kernel and kernel with arch_irq_work_has_interrupt() being
false. And for other kernels, irq_work_sync() doesn't incur any overhead,
because it is  just a simple memory read through irq_work_is_busy() and nothing
else. The reason is the irq work must have been completed when invoking
bpf_mem_alloc_destroy() for these kernels.

void irq_work_sync(struct irq_work *work)
{
       /* Remove code snippet for PREEMPT_RT and arch_irq_work_has_interrupt() */
        /* irq wor*/
        while (irq_work_is_busy(work))
                cpu_relax();
}

>
> I was also trying to see if adding local_irq_save inside drain_mem_cache
> to pair with the ones from refill might work, but waiting for irq to
> finish seems easier...
Disabling hard irq works, but irq_work_sync() is still needed to ensure it is
completed before freeing its memory.
>
> Maybe also move both of these in some new "static void irq_work_wait"
> to make it clear that the PREEMT_RT comment applies to both of them?
>
> Or maybe that helper should do 'for_each_possible_cpu(cpu)
> irq_work_sync(&c->refill_work);'
> in the PREEMPT_RT case so we don't have to call it twice?
drain_mem_cache() is also time consuming somethings, so I think it is better to
interleave irq_work_sync() and drain_mem_cache() to reduce waiting time.

>
>>               drain_mem_cache(c);
>>               rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>>           }
>> @@ -511,6 +521,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>>               cc = per_cpu_ptr(ma->caches, cpu);
>>               for (i = 0; i < NUM_CACHES; i++) {
>>                   c = &cc->cache[i];
>> +                irq_work_sync(&c->refill_work);
>>                   drain_mem_cache(c);
>>                   rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>>               }
>> -- 
>> 2.29.2
>
> .

