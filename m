Return-Path: <bpf+bounces-2087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3527275D1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 05:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F77D281630
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A9111A;
	Thu,  8 Jun 2023 03:36:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FA10EF
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:36:18 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DF26A2;
	Wed,  7 Jun 2023 20:36:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qc8xs4kZnz4f3jqB;
	Thu,  8 Jun 2023 11:36:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgD3xayeTIFk3xfKLA--.52396S2;
	Thu, 08 Jun 2023 11:36:02 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
To: "Paul E. McKenney" <paulmck@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
 <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
 <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>
 <55f5e64d-9d9e-4c65-8d1b-8fd4684ee9a3@paulmck-laptop>
 <CAADnVQLps=4CjVbZN6wfFWS9VnPE=1b4Gqmw-uPeH5=hGn_xwQ@mail.gmail.com>
 <3bddb902-de45-47d9-b9a2-495508133522@paulmck-laptop>
 <CAADnVQLhuBggNQxipbRM+E9fQ4wScYmg7-NWjfqAZyA5asw3JQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a12008e9-f3f7-5050-e461-344d9d86e48f@huaweicloud.com>
Date: Thu, 8 Jun 2023 11:35:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLhuBggNQxipbRM+E9fQ4wScYmg7-NWjfqAZyA5asw3JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgD3xayeTIFk3xfKLA--.52396S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGw45CryDWFyxuw4fZw4rAFb_yoWDtry7pr
	WfKF1UJryDJrWIkr12vr1UXry5tws5t34UJr1rXFyUCr15Gr1Yvr17Wr4j9F15Gr4kJw4j
	qr4UJ34UZr15J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/8/2023 8:34 AM, Alexei Starovoitov wrote:
> On Wed, Jun 7, 2023 at 5:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> On Wed, Jun 07, 2023 at 04:50:35PM -0700, Alexei Starovoitov wrote:
>>> On Wed, Jun 7, 2023 at 4:30 PM Paul E. McKenney <paulmck@kernel.org> wrote:
SNIP
>>>> An update..
>>>>
>>>> I tweaked patch 3 to do per-cpu reuse_ready and it addressed
>>>> the lock contention, but cache miss on
>>>> __llist_del_first(&c->reuse_ready_head);
>>>> was still very high and performance was still at 450k as
>>>> with a simple hack above.
>>>>
>>>> Then I removed some of the _tail optimizations and added counters
>>>> to these llists.
>>>> To my surprise
>>>> map_perf_test 4 1 16348 1000000
>>>> was showing ~200k on average in waiting_for_gp when reuse_rcu() is called
>>>> and ~400k sitting in reuse_ready_head.
>>>>
>>>> Then noticed that we should be doing:
>>>> call_rcu_hurry(&c->rcu, reuse_rcu);
>>>> instead of call_rcu(),
>>>> but my config didn't have RCU_LAZY, so that didn't help.
>>>> Obviously we cannot allow such a huge number of elements to sit
>>>> in these link lists.
>>>> The whole "reuse-after-rcu-gp" idea for bpf_mem_alloc may not work.
>>>> To unblock qp-trie work I suggest to add rcu_head to each inner node
>>>> and do call_rcu() on them before free-ing them to bpf_mem_alloc.
>>>> Explicit call_rcu would disqualify qp-tree from tracing programs though :(
>>>> I am sure that you guys have already considered and discarded this one,
>>>> but I cannot help but suggest SLAB_TYPESAFE_BY_RCU.
Thanks for the suggestion. SLAB_TYPESAFE_BY_RCU needs to modify the
logic of reader to check whether or not the found element is still
valid. If the reader finds the found element is invalid, it needs to retry.
And for different cache, the way to check the validity is also
different. In bpf we don't want to let the reader to take care of the
reuse and do the retry logic, and we want to do it atomatically in the
bpf memory allocator.
>>> SLAB_TYPESAFE_BY_RCU is what bpf_mem_alloc is doing right now.
>>> We want to add an option to make it not do it and instead observe RCU GP
>>> for every element freed via bpf_mem_free().
>>> In other words, make bpf_mem_free() behave like kfree_rcu.
>>> I just tried to use rcu_expedite_gp() before bpf prog runs
>>> and it helps a bit.
>> OK, got it, so you guys have considered, implemented, and are now trying
>> to discard SLAB_TYPESAFE_BY_RCU.  ;-)
>>
>> Given that you are using call_rcu() / call_rcu_hurry(), I am a bit
>> surprised that rcu_expedite_gp() makes any difference.
>>
>> We do some expediting if there are huge numbers of callbacks or if one
>> of RCU's shrinker notifiers is invoked.  If the concern is only memory
>> footprint, it is possible to make the shrinkers more aggressive.  I am
>> not sure whether making them unconditionally more aggressive is a good
>> idea, however if memory footprint is the only concern and if shrink-time
>> expediting would suffice, it is certainly worth some investigation.
> Right. I don't think it's a good idea to tweak RCU for this use case.
> RCU parameters have to be optimized for all. Instead the bpf side needs
> to understand how RCU heuristics/watermarks work and play that game.
> For example, Hou's patch 3 has one pending call_rcu per-cpu.
> As soon as one call_rcu_hurry is done all future freed elements gets
> queued into llist and for the next call_rcu_hurry() that list will
> contain 100k elements.
> I believe from RCU pov one pending call_rcu cb is not a reason to
> act right away. It's trying to batch multiple cb-s.
> Right now I'm experimenting with multiple call_rcu calls from the bpf side,
> so that RCU sees multiple pending cb-s and has to act.
> It seems to work much better. Memory footprint is now reasonable.
Could you please share the memory usage of the original v4 and the
version with reasonable memory by using htab-mem-benchmark ?

v3 already uses multiple RCU cbs for reuse to accelerate the reuse of
freed objects. I also did the experiment for v4 as I replied the day
before yesterday, so I just quota it:

htab-mem-benchmark (reuse-after-RCU-GP):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1159.18   | 0.99                | 0.99             |
| overwrite          | 11.00     | 2288                | 4109             |
| batch_add_batch_del| 8.86      | 1558                | 2763             |
| add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |

For 1), after using kmalloc() in irq_work to allocate multiple inflight
RCU callbacks (namely reuse_rcu()), the memory usage decreases a bit,
but is not enough:

htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1247.00   | 0.97                | 1.00             |
| overwrite          | 16.56     | 490.18              | 557.17           |
| batch_add_batch_del| 11.31     | 276.32              | 360.89           |
| add_del_on_diff_cpu| 4.00      | 24.76               | 42.58            |


By comparing the implementation of v3 and v4, I just find one hack which
could reduce the memory usage of v4 (with per-cpu reusabe list)
significantly and memory usage will be similar between v3 and v4. If we
queue a empty work before calling irq_work_raise() as shown below, the
calling latency of reuse_rcu (a normal RCU callback) will decreased from
~150ms to ~10 ms. I think the reason is that the duration of normal RCU
grace period is decreased a lot, but I don't know why did it happen.
Hope to get some help from Paul. Because Paul doesn't have enough
context, so I will try to explain the context of the weird problem
below. And Alexei, could you please also try the hack below for your
multiple-rcu-cbs version ?

Hi Paul,

I just found out the time between the calling of call_rcu(..,
reuse_rcub) and the calling of RCU callback (namely resue_cb()) will
decrease a lot (from ~150ms to ~10ms) if I queued a empty kworker
periodically as shown in the diff below. Before the diff below applied,
the benchmark process will do the following things on a VM with 8 CPUs:

1) create a pthread htab_mem_producer on each CPU and pinned the thread
on the specific CPU
2) htab_mem_producer will call syscall(__NR_getpgid) repeatedly in a
dead-loop
3) the calling of getpgid() will trigger the invocation of a bpf program
attached on getpgid() syscall
4) the bpf program will overwrite 2048 elements in a bpf hash map
5) during the overwrite, it will free the existed element firstly
6) the free will call unit_free(), unit_free() will trigger a irq-work
batchly after 96-element were freed
7) in the irq_work, it will allocate a new struct to save the freed
elements and the rcu_head and do call_rcu(..., reuse_rcu)
8) in reuse_rcu() it just moves these freed elements into a per-cpu
reuse list
9) After the free completes, the overwrite will allocate a new element
10) the allocation may also trigger a irq-work batchly after the
preallocated elements were exhausted
11) in the irq-work, it will try to fetch elements from per-cpu reuse
list and if it is empty, it will do kmalloc()

For the procedure describe above, the calling latency between the call
of call_rcu() and the call of reuse_rcu is about ~150ms or larger. I
have also checked the calling latency of syscall(__NR_getpgid) and all
latency is less than 1ms. But after do queueing a empty kwork in step
6), the calling latency will decreased from ~150ms to ~10ms and I
suspect that is because the RCU grace period is decreased a lot, but I
don't know how to debug that (e.g., to debug why the RCU grace period is
so long), so I hope to get some help.

htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks + queue_empty_work):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| overwrite          | 13.85     | 17.89               | 21.49            |
| batch_add_batch_del| 10.22     | 16.65               | 19.07            |
| add_del_on_diff_cpu| 3.82      | 21.36               | 33.05            |


+static void bpf_ma_prepare_reuse_work(struct work_struct *work)
+{
+       udelay(100);
+}
+
 /* When size != 0 bpf_mem_cache for each cpu.
  * This is typical bpf hash map use case when all elements have equal size.
  *
@@ -547,6 +559,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int
size, bool percpu)
                        c->cpu = cpu;
                        c->objcg = objcg;
                        c->percpu_size = percpu_size;
+                       INIT_WORK(&c->reuse_work,
bpf_ma_prepare_reuse_work);
                        raw_spin_lock_init(&c->lock);
                        c->reuse.percpu = percpu;
                        c->reuse.cpu = cpu;
@@ -574,6 +587,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int
size, bool percpu)
                        c->unit_size = sizes[i];
                        c->cpu = cpu
                        c->objcg = objcg;
+                       INIT_WORK(&c->reuse_work,
bpf_ma_prepare_reuse_work);
                        raw_spin_lock_init(&c->lock);
                        c->reuse.percpu = percpu;
                        c->reuse.lock = &c->lock;
@@ -793,6 +807,8 @@ static void notrace unit_free(struct bpf_mem_cache
*c, void *ptr)
                        c->prepare_reuse_tail = llnode;
                __llist_add(llnode, &c->prepare_reuse_head);
                cnt = ++c->prepare_reuse_cnt;
+               if (cnt > c->high_watermark &&
!work_pending(&c->reuse_work))
+                       queue_work(bpf_ma_wq, &c->reuse_work);
        } else {
                /* unit_free() cannot fail. Therefore add an object to
atomic
                 * llist. reuse_bulk() will drain it. Though
free_llist_extra is
@@ -901,3 +917,11 @@ void notrace *bpf_mem_cache_alloc_flags(struct
bpf_mem_alloc *ma, gfp_t flags)

        return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
+
+static int __init bpf_ma_init(void)
+{
+       bpf_ma_wq = alloc_workqueue("bpf_ma", WQ_MEM_RECLAIM, 0);
+       BUG_ON(!bpf_ma_wq);
+       return 0;
+}
+late_initcall(bpf_ma_init);



> Could you point me to a code in RCU where it's doing callback batching?


