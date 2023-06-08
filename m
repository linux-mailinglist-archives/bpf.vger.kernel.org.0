Return-Path: <bpf+bounces-2082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682027274A8
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 03:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228AC2815D7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D07ECF;
	Thu,  8 Jun 2023 01:58:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306010FE
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 01:58:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223A26A9;
	Wed,  7 Jun 2023 18:57:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qc6mf3pP1z4f3lXG;
	Thu,  8 Jun 2023 09:57:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAXBROgNYFkMllhKQ--.42844S2;
	Thu, 08 Jun 2023 09:57:55 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
 <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
 <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2bbdb592-706e-19b8-b968-71d3a74b5c8a@huaweicloud.com>
Date: Thu, 8 Jun 2023 09:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAXBROgNYFkMllhKQ--.42844S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw47Kr48Gr1UCF1xZFy7Jrb_yoW7CF47pa
	yrGFyDKF1kZrWakwsavr4kXF1Fq3yag3yUX34Yqry2krn0grnIqFW8KF4UWFn8ur40kw42
	v3WDJw1xCwsFvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/8/2023 7:23 AM, Alexei Starovoitov wrote:
> On Wed, Jun 7, 2023 at 1:50 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Jun 7, 2023 at 10:52 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
>>>> As said in the commit message, the command line for test is
>>>> "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
>>>> using default max_entries and the number of CPUs is greater than 15,
>>>> use_percpu_counter will be false.
>>> Right. percpu or not depends on number of cpus.
>>>
>>>> I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
>>>> test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
>>>> there are obvious performance degradation.
>>> ...
>>>> [root@hello bpf]# ./map_perf_test 4 8 16384
>>>> 2:hash_map_perf kmalloc 359201 events per sec
>>> ..
>>>> [root@hello bpf]# ./map_perf_test 4 8 16384
>>>> 4:hash_map_perf kmalloc 203983 events per sec
>>> this is indeed a degration in a VM.
>>>
>>>> I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
>>>> performances for "./map_perf_test 4 8" are similar, but there is obvious
>>>> performance degradation for "./map_perf_test 4 8 16384"
>>> but... a degradation?
>>>
>>>> Before reuse-after-rcu-gp:
>>>>
>>>> [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
>>>> 1:hash_map_perf kmalloc 388088 events per sec
>>> ...
>>>> After reuse-after-rcu-gp:
>>>> [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
>>>> 5:hash_map_perf kmalloc 655628 events per sec
>>> This is a big improvement :) Not a degration.
>>> You always have to double check the numbers with perf report.
>>>
>>>> So could you please double check your setup and rerun map_perf_test ? If
>>>> there is no performance degradation, could you please share your setup
>>>> and your kernel configure file ?
>>> I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=1000
>>> Playing with it a bit more I found something interesting:
>>> map_perf_test 4 8 16348
>>> before/after has too much noise to be conclusive.
>>>
>>> So I did
>>> map_perf_test 4 8 16348 1000000
>>>
>>> and now I see significant degration from patch 3.
>>> It drops from 800k to 200k.
>>> And perf report confirms that heavy contention on sc->reuse_lock is the culprit.
>>> The following hack addresses most of the perf degradtion:
>>>
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index fea1cb0c78bb..eeadc9359097 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>>> @@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
>>>         alloc = 0;
>>>         head = NULL;
>>>         tail = NULL;
>>> -       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
>>> +       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
>>>         while (alloc < cnt) {
>>>                 obj = __llist_del_first(&sc->reuse_ready_head);
>>>                 if (obj) {
>>> @@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
>>>                 alloc++;
>>>         }
>>>         raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>>> +       }
>>>
>>>         if (alloc) {
>>>                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
>>> @@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c)
>>>                 sc->reuse_ready_tail = NULL;
>>>                 WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
>>>                 __llist_add_batch(head, tail, &sc->wait_for_free);
>>> +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>>>                 call_rcu_tasks_trace(&sc->rcu, free_rcu);
>>> +       } else {
>>> +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>>>         }
>>> -       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>>>  }
>>>
>>> It now drops from 800k to 450k.
>>> And perf report shows that both reuse is happening and slab is working hard to satisfy kmalloc/kfree.
>>> So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waiting_for_rcu_task_trace_gp lists.
>> Sorry. per-cpu waiting_for_rcu_gp is what patch 3 does already.
>> I meant per-cpu reuse_ready and per-bpf-ma waiting_for_rcu_task_trace_gp.
> An update..
>
> I tweaked patch 3 to do per-cpu reuse_ready and it addressed
> the lock contention, but cache miss on
> __llist_del_first(&c->reuse_ready_head);
> was still very high and performance was still at 450k as
> with a simple hack above.
>
> Then I removed some of the _tail optimizations and added counters
> to these llists.
> To my surprise
> map_perf_test 4 1 16348 1000000
> was showing ~200k on average in waiting_for_gp when reuse_rcu() is called
> and ~400k sitting in reuse_ready_head.
Yep. If you use htab-mem-bechmark in patch #2, you will find the same
results, the same long single lists and the same huge memory usage.
>
> Then noticed that we should be doing:
> call_rcu_hurry(&c->rcu, reuse_rcu);
> instead of call_rcu(),
> but my config didn't have RCU_LAZY, so that didn't help.
> Obviously we cannot allow such a huge number of elements to sit
> in these link lists.
> The whole "reuse-after-rcu-gp" idea for bpf_mem_alloc may not work.
I think the main blocker is the huge memory usage (it is the same thing
as the long wait_for_reuse and wait_for_free list), right ?
> To unblock qp-trie work I suggest to add rcu_head to each inner node
> and do call_rcu() on them before free-ing them to bpf_mem_alloc.
> Explicit call_rcu would disqualify qp-tree from tracing programs though :(


