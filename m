Return-Path: <bpf+bounces-9476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A0797FEA
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 02:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112A21C20C0C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 00:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267CA10EE;
	Fri,  8 Sep 2023 00:56:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE46628;
	Fri,  8 Sep 2023 00:56:56 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C51BD3;
	Thu,  7 Sep 2023 17:56:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rhd3g4RDsz4f3lgK;
	Fri,  8 Sep 2023 08:56:47 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAHcmZPcfpkSBNtCg--.51986S2;
	Fri, 08 Sep 2023 08:56:49 +0800 (CST)
Subject: Re: Possible deadlock in bpf queue map
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Hsin-Wei Hung <hsinweih@uci.edu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
 <87o7ienuss.fsf@toke.dk>
 <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
 <87fs3qnnh4.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <71a03505-6ec4-8f1d-09c6-fff78f4880d0@huaweicloud.com>
Date: Fri, 8 Sep 2023 08:56:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87fs3qnnh4.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAHcmZPcfpkSBNtCg--.51986S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyfXrWUWFyxXry3ArWfGrg_yoW3uw1UpF
	ZxJa97CF40qrWjqrWYgw45XF17Kws0g347uFZ5Ka48AF9FqrnrXr18tFWI9rWF9r1kAanr
	AF4jqrZ3u3y8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/7/2023 9:04 PM, Toke Høiland-Jørgensen wrote:
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
>> On Thu, 7 Sept 2023 at 12:26, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
>>> +Arnaldo
>>>
>>>> Hi,
>>>>
>>>> Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning in
>>>> the bpf queue map in v5.15. Since queue_stack_maps.c has no major changes
>>>> since v5.15, we think this should still exist in the latest kernel.
>>>> The bug can be occasionally triggered, and we suspect one of the
>>>> eBPF programs involved to be the following one. We also attached the lockdep
>>>> warning at the end.
>>>>
>>>> #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
>>>> TypeOfValue, MaxEntries) \
>>>>         struct {                                                        \
>>>>             __uint(type, TypeOfMap);                                    \
>>>>             __uint(map_flags, (MapFlags));                              \
>>>>             __uint(max_entries, (MaxEntries));                          \
>>>>             __type(value, TypeOfValue);                                 \
>>>>         } the_map SEC(".maps");
>>>>
>>>> DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
>>>> struct_0, 162);
>>>> SEC("perf_event")
>>>> int func(struct bpf_perf_event_data *ctx) {
>>>>         char v0[96] = {};
>>>>         uint64_t v1 = 0;
>>>>         v1 = bpf_map_pop_elem(&map_0, v0);
>>>>         return 163819661;
>>>> }
>>>>
>>>>
>>>> The program is attached to the following perf event.
>>>>
>>>> struct perf_event_attr attr_type_hw = {
>>>>         .type = PERF_TYPE_HARDWARE,
>>>>         .config = PERF_COUNT_HW_CPU_CYCLES,
>>>>         .sample_freq = 50,
>>>>         .inherit = 1,
>>>>         .freq = 1,
>>>> };
>>>>
>>>> ================================WARNING: inconsistent lock state
>>>> 5.15.26+ #2 Not tainted
>>>> --------------------------------
>>>> inconsistent {INITIAL USE} -> {IN-NMI} usage.
>>>> syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
>>>> ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/0x250
>>>> {INITIAL USE} state was registered at:
>>>>   lock_acquire+0x1a3/0x4b0
>>>>   _raw_spin_lock_irqsave+0x48/0x60
>>>>   __queue_map_get+0x31/0x250
>>>>   bpf_prog_577904e86c81dead_func+0x12/0x4b4
>>>>   trace_call_bpf+0x262/0x5d0
>>>>   perf_trace_run_bpf_submit+0x91/0x1c0
>>>>   perf_trace_sched_switch+0x46c/0x700
>>>>   __schedule+0x11b5/0x24a0
>>>>   schedule+0xd4/0x270
>>>>   futex_wait_queue_me+0x25f/0x520
>>>>   futex_wait+0x1e0/0x5f0
>>>>   do_futex+0x395/0x1890
>>>>   __x64_sys_futex+0x1cb/0x480
>>>>   do_syscall_64+0x3b/0xc0
>>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> irq event stamp: 13640
>>>> hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
>>>> _raw_spin_unlock_irq+0x24/0x40
>>>> hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
>>>> _raw_spin_lock_irqsave+0x5d/0x60
>>>> softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0x3e15/0x4e80
>>>> softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0x3dd3/0x4e80
>>>>
>>>> other info that might help us debug this:
>>>>  Possible unsafe locking scenario:
>>>>
>>>>        CPU0
>>>>        ----
>>>>   lock(&qs->lock);
>>>>   <Interrupt>
>>>>     lock(&qs->lock);
>>> Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* be
>>> disabling interrupts entirely for the critical section. But I guess a
>>> Perf hardware event can still trigger? Which seems like it would
>>> potentially wreak havoc with lots of things, not just this queue map
>>> function?
>>>
>>> No idea how to protect against this, though. Hoping Arnaldo knows? :)
>>>

It seems my reply from last night was dropped by mail-list.

>> The locking should probably be protected by a percpu integer counter,
>> incremented and decremented before and after the lock is taken,
>> respectively. If it is already non-zero, then -EBUSY should be
>> returned. It is similar to what htab_lock_bucket protects against in
>> hashtab.c.
> Ah, neat! Okay, seems straight-forward enough to replicate. Hsin, could
> you please check if the patch below gets rid of the splat?

The fixes could fix the potential dead-lock, but I think the lockdep
warning will be there, because lockdep thinks it is only safe to call
try_lock under NMI-contex. So using raw_spin_trylock() for NMI context
will both fix the potential dead-lock and the lockdep splat.

>
> -Toke
>
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index 8d2ddcb7566b..f96945311eec 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -16,6 +16,7 @@
>  struct bpf_queue_stack {
>  	struct bpf_map map;
>  	raw_spinlock_t lock;
> +	int __percpu *map_locked;
>  	u32 head, tail;
>  	u32 size; /* max_entries + 1 */
>  
> @@ -66,6 +67,7 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
>  	int numa_node = bpf_map_attr_numa_node(attr);
>  	struct bpf_queue_stack *qs;
>  	u64 size, queue_size;
> +	int err = -ENOMEM;
>  
>  	size = (u64) attr->max_entries + 1;
>  	queue_size = sizeof(*qs) + size * attr->value_size;
> @@ -80,7 +82,18 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
>  
>  	raw_spin_lock_init(&qs->lock);
>  
> +	qs->map_locked = bpf_map_alloc_percpu(&qs->map,
> +					      sizeof(*qs->map_locked),
> +					      sizeof(*qs->map_locked),
> +					      GFP_USER);
> +	if (!qs->map_locked)
> +		goto free_map;
> +
>  	return &qs->map;
> +
> +free_map:
> +	bpf_map_area_free(qs);
> +	return ERR_PTR(err);
>  }
>  
>  /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
> @@ -88,9 +101,37 @@ static void queue_stack_map_free(struct bpf_map *map)
>  {
>  	struct bpf_queue_stack *qs = bpf_queue_stack(map);
>  
> +	free_percpu(qs->map_locked);
>  	bpf_map_area_free(qs);
>  }
>  
> +static inline int queue_stack_map_lock(struct bpf_queue_stack *qs,
> +				       unsigned long *pflags)
> +{
> +	unsigned long flags;
> +
> +	preempt_disable();
> +	if (unlikely(__this_cpu_inc_return(*qs->map_locked) != 1)) {
> +		__this_cpu_dec(*qs->map_locked);
> +		preempt_enable();
> +		return -EBUSY;
> +	}
> +
> +	raw_spin_lock_irqsave(&qs->lock, flags);
> +	*pflags = flags;
> +
> +	return 0;
> +}
> +
> +
> +static inline void queue_stack_map_unlock(struct bpf_queue_stack *qs,
> +					  unsigned long flags)
> +{
> +	raw_spin_unlock_irqrestore(&qs->lock, flags);
> +	__this_cpu_dec(*qs->map_locked);
> +	preempt_enable();
> +}
> +
>  static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>  {
>  	struct bpf_queue_stack *qs = bpf_queue_stack(map);
> @@ -98,7 +139,9 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>  	int err = 0;
>  	void *ptr;
>  
> -	raw_spin_lock_irqsave(&qs->lock, flags);
> +	err = queue_stack_map_lock(qs, &flags);
> +	if (err)
> +		return err;
>  
>  	if (queue_stack_map_is_empty(qs)) {
>  		memset(value, 0, qs->map.value_size);
> @@ -115,7 +158,7 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>  	}
>  
>  out:
> -	raw_spin_unlock_irqrestore(&qs->lock, flags);
> +	queue_stack_map_unlock(qs, flags);
>  	return err;
>  }
>  
> @@ -128,7 +171,9 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
>  	void *ptr;
>  	u32 index;
>  
> -	raw_spin_lock_irqsave(&qs->lock, flags);
> +	err = queue_stack_map_lock(qs, &flags);
> +	if (err)
> +		return err;
>  
>  	if (queue_stack_map_is_empty(qs)) {
>  		memset(value, 0, qs->map.value_size);
> @@ -147,7 +192,7 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
>  		qs->head = index;
>  
>  out:
> -	raw_spin_unlock_irqrestore(&qs->lock, flags);
> +	queue_stack_map_unlock(qs, flags);
>  	return err;
>  }
>  
> @@ -193,7 +238,9 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
>  	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
>  		return -EINVAL;
>  
> -	raw_spin_lock_irqsave(&qs->lock, irq_flags);
> +	err = queue_stack_map_lock(qs, &irq_flags);
> +	if (err)
> +		return err;
>  
>  	if (queue_stack_map_is_full(qs)) {
>  		if (!replace) {
> @@ -212,7 +259,7 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
>  		qs->head = 0;
>  
>  out:
> -	raw_spin_unlock_irqrestore(&qs->lock, irq_flags);
> +	queue_stack_map_unlock(qs, irq_flags);
>  	return err;
>  }
>  
>
> .


