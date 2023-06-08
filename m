Return-Path: <bpf+bounces-2092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C360472761D
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 06:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AE228162F
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 04:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129CD628;
	Thu,  8 Jun 2023 04:30:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0971396
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 04:30:25 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B02680;
	Wed,  7 Jun 2023 21:30:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QcB8T6qLWz4f3lwH;
	Thu,  8 Jun 2023 12:30:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDXxBJXWYFk2TVpKQ--.56114S2;
	Thu, 08 Jun 2023 12:30:19 +0800 (CST)
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
 <a12008e9-f3f7-5050-e461-344d9d86e48f@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0f49315e-7d66-66aa-36b0-46dbea276433@huaweicloud.com>
Date: Thu, 8 Jun 2023 12:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a12008e9-f3f7-5050-e461-344d9d86e48f@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDXxBJXWYFk2TVpKQ--.56114S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5Kr47uFWfAryrXFWUArb_yoWxWrWkpF
	Wrtr1UAryUJr48Cr1UAr1UXryUJw18tw1UJr18XFyUZr1UJr1jqr1UWr4jgF15Jr4kJw4U
	Xr4UJw1UZryUJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/8/2023 11:35 AM, Hou Tao wrote:
> Hi,
>
> On 6/8/2023 8:34 AM, Alexei Starovoitov wrote:
>> On Wed, Jun 7, 2023 at 5:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>> On Wed, Jun 07, 2023 at 04:50:35PM -0700, Alexei Starovoitov wrote:
>>>> On Wed, Jun 7, 2023 at 4:30 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
SNIP
>
> By comparing the implementation of v3 and v4, I just find one hack which
> could reduce the memory usage of v4 (with per-cpu reusabe list)
> significantly and memory usage will be similar between v3 and v4. If we
> queue a empty work before calling irq_work_raise() as shown below, the
> calling latency of reuse_rcu (a normal RCU callback) will decreased from
> ~150ms to ~10 ms. I think the reason is that the duration of normal RCU
> grace period is decreased a lot, but I don't know why did it happen.
> Hope to get some help from Paul. Because Paul doesn't have enough
> context, so I will try to explain the context of the weird problem
> below. And Alexei, could you please also try the hack below for your
> multiple-rcu-cbs version ?
An update for the queue_work() hack. It works for both CONFIG_PREEMPT=y
and CONFIG_PREEMPT=n cases. I will try to enable RCU trace to check
whether or not there is any difference.
>
> Hi Paul,
>
> I just found out the time between the calling of call_rcu(..,
> reuse_rcub) and the calling of RCU callback (namely resue_cb()) will
> decrease a lot (from ~150ms to ~10ms) if I queued a empty kworker
> periodically as shown in the diff below. Before the diff below applied,
> the benchmark process will do the following things on a VM with 8 CPUs:
>
> 1) create a pthread htab_mem_producer on each CPU and pinned the thread
> on the specific CPU
> 2) htab_mem_producer will call syscall(__NR_getpgid) repeatedly in a
> dead-loop
> 3) the calling of getpgid() will trigger the invocation of a bpf program
> attached on getpgid() syscall
> 4) the bpf program will overwrite 2048 elements in a bpf hash map
> 5) during the overwrite, it will free the existed element firstly
> 6) the free will call unit_free(), unit_free() will trigger a irq-work
> batchly after 96-element were freed
> 7) in the irq_work, it will allocate a new struct to save the freed
> elements and the rcu_head and do call_rcu(..., reuse_rcu)
> 8) in reuse_rcu() it just moves these freed elements into a per-cpu
> reuse list
> 9) After the free completes, the overwrite will allocate a new element
> 10) the allocation may also trigger a irq-work batchly after the
> preallocated elements were exhausted
> 11) in the irq-work, it will try to fetch elements from per-cpu reuse
> list and if it is empty, it will do kmalloc()
>
> For the procedure describe above, the calling latency between the call
> of call_rcu() and the call of reuse_rcu is about ~150ms or larger. I
> have also checked the calling latency of syscall(__NR_getpgid) and all
> latency is less than 1ms. But after do queueing a empty kwork in step
> 6), the calling latency will decreased from ~150ms to ~10ms and I
> suspect that is because the RCU grace period is decreased a lot, but I
> don't know how to debug that (e.g., to debug why the RCU grace period is
> so long), so I hope to get some help.
>
> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks + queue_empty_work):
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> | --                 | --        | --                  | --               |
> | overwrite          | 13.85     | 17.89               | 21.49            |
> | batch_add_batch_del| 10.22     | 16.65               | 19.07            |
> | add_del_on_diff_cpu| 3.82      | 21.36               | 33.05            |
>
>
> +static void bpf_ma_prepare_reuse_work(struct work_struct *work)
> +{
> +       udelay(100);
> +}
> +
>  /* When size != 0 bpf_mem_cache for each cpu.
>   * This is typical bpf hash map use case when all elements have equal size.
>   *
> @@ -547,6 +559,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int
> size, bool percpu)
>                         c->cpu = cpu;
>                         c->objcg = objcg;
>                         c->percpu_size = percpu_size;
> +                       INIT_WORK(&c->reuse_work,
> bpf_ma_prepare_reuse_work);
>                         raw_spin_lock_init(&c->lock);
>                         c->reuse.percpu = percpu;
>                         c->reuse.cpu = cpu;
> @@ -574,6 +587,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int
> size, bool percpu)
>                         c->unit_size = sizes[i];
>                         c->cpu = cpu
>                         c->objcg = objcg;
> +                       INIT_WORK(&c->reuse_work,
> bpf_ma_prepare_reuse_work);
>                         raw_spin_lock_init(&c->lock);
>                         c->reuse.percpu = percpu;
>                         c->reuse.lock = &c->lock;
> @@ -793,6 +807,8 @@ static void notrace unit_free(struct bpf_mem_cache
> *c, void *ptr)
>                         c->prepare_reuse_tail = llnode;
>                 __llist_add(llnode, &c->prepare_reuse_head);
>                 cnt = ++c->prepare_reuse_cnt;
> +               if (cnt > c->high_watermark &&
> !work_pending(&c->reuse_work))
> +                       queue_work(bpf_ma_wq, &c->reuse_work);
>         } else {
>                 /* unit_free() cannot fail. Therefore add an object to
> atomic
>                  * llist. reuse_bulk() will drain it. Though
> free_llist_extra is
> @@ -901,3 +917,11 @@ void notrace *bpf_mem_cache_alloc_flags(struct
> bpf_mem_alloc *ma, gfp_t flags)
>
>         return !ret ? NULL : ret + LLIST_NODE_SZ;
>  }
> +
> +static int __init bpf_ma_init(void)
> +{
> +       bpf_ma_wq = alloc_workqueue("bpf_ma", WQ_MEM_RECLAIM, 0);
> +       BUG_ON(!bpf_ma_wq);
> +       return 0;
> +}
> +late_initcall(bpf_ma_init);
>
>
>
>> Could you point me to a code in RCU where it's doing callback batching?
> .


