Return-Path: <bpf+bounces-2091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF47275DF
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 05:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936232815D1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B61C35;
	Thu,  8 Jun 2023 03:44:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDDA57
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:44:04 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D626AA;
	Wed,  7 Jun 2023 20:44:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qc96z2Ghkz4f3nx3;
	Thu,  8 Jun 2023 11:43:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgD33gx6ToFk4dJmKQ--.44784S2;
	Thu, 08 Jun 2023 11:43:57 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
To: paulmck@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
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
 <1441a69a-a015-8e3c-4c14-a6af767849e3@huaweicloud.com>
 <1154ba5a-49b2-45c4-8b88-60f1abed6cbf@paulmck-laptop>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f4418d9d-857b-eb96-cbec-ab1652291556@huaweicloud.com>
Date: Thu, 8 Jun 2023 11:43:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1154ba5a-49b2-45c4-8b88-60f1abed6cbf@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgD33gx6ToFk4dJmKQ--.44784S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW3ZrWDtr1DtFWxWr1fCrg_yoW7AFy8pF
	WfK3Z0kr4kt34fAwn2vr1xXFyYyayrG3s8XFy5try7Cr90gr1SqrWSvr4Y9FyUXrs7Cw1a
	9F4DXry7Zw1jqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paul,

On 6/8/2023 10:55 AM, Paul E. McKenney wrote:
> On Thu, Jun 08, 2023 at 09:51:27AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 6/8/2023 4:50 AM, Alexei Starovoitov wrote:
>>> On Wed, Jun 7, 2023 at 10:52 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
>>>>> As said in the commit message, the command line for test is
>>>>> "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
>>>>> using default max_entries and the number of CPUs is greater than 15,
>>>>> use_percpu_counter will be false.
>>>> Right. percpu or not depends on number of cpus.
SNIP
>>>>  known, because I had just proposed it in the email yesterday.
>>> Also noticed that the overhead of shared reuse_ready list
>>> comes both from the contended lock and from cache misses
>>> when one cpu pushes to the list after RCU GP and another
>>> cpu removes.
>>>
>>> Also low/batch/high watermark are all wrong in patch 3.
>>> low=32 and high=96 makes no sense when it's not a single list.
>>> I'm experimenting with 32 for all three heuristics.
>>>
>>> Another thing I noticed that per-cpu prepare_reuse and free_by_rcu
>>> are redundant.
>>> unit_free() can push into free_by_rcu directly
>>> then reuse_bulk() can fill it up with free_llist_extra and
>>> move them into waiting_for_gp.
>> Yes. Indeed missing that.
>>> All these _tail optimizations are obscuring the code and make it hard
>>> to notice these issues.
>>>
>>>> For now I still prefer to see v5 with per-bpf-ma and no _tail optimization.
>>>>
>>>> Answering your other email:
>>>>
>>>>> I see your point. I will continue to debug the memory usage difference
>>>>> between v3 and v4.
>>>> imo it's a waste of time to continue analyzing performance based on bench in patch 2.
>> Don't agree with that. I still think the potential memory usage of v4 is
>> a problem and the difference memory usage between v3 and v4 reveals that
>> there is some peculiarity in RCU subsystem, because the difference comes
>> from the duration of RCU grace period. We need to find out why and fix
>> or workaround that.
> A tight loop in the kernel can extend RCU grace periods, especially
> for kernels built with CONFIG_PREEPTION=n.  Placing things like
> cond_resched() in such loops can help.  Of course, if you are in an
> RCU read-side critical section (or holding a spinlock), you will need
> to exit, cond_resched(), then re-enter.  Taking care to ensure that the
> state upon re-entry is valid.  After all, having exited either type of
> critical section, anything might happen.

As said in the help-wanted email just send out, it was weird that the
RCU grace period was extended a lot, up to ~150ms or more. But queue a
dummy kworker periodically which does nothing will help to reduce the
grace period to ~10ms. I have explained the context of the problem in
that email. And hope that we could get some help from you and the RCU
experts in the community.

Regards,
Tao
>
> 							Thanx, Paul
>
>>>>> I don't think so. Let's considering the per-cpu list first. Assume the
>>>>> normal RCU grace period is about 30ms and we are tracing the IO latency
>>>>> of a normal SSD. The iops is about 176K per seconds, so before one RCU
>>>>> GP is passed, we will need to allocate about 176 * 30 = 5.2K elements.
>>>>> For the per-ma list, when the number of CPUs increased, it is easy to
>>>>> make the list contain thousands of elements.
>>>> That would be true only if there were no scheduling events in all of 176K ops.
>>>> Which is not the case.
>>>> I'm not sure why you're saying that RCU GP is 30ms.
>> Because these freed elements will be freed after one RCU GP and in v4
>> there is only one RCU callback per-cpu, so before one RCU GP is expired,
>> these freed elements will be accumulated on the list.
>>>> In CONFIG_PREEMPT_NONE rcu_read_lock/unlock are true nops.
>>>> Every sched event is sort-of implicit rcu_read_lock/unlock.
>>>> Network and block IO doesn't process 176K packets without resched.
>>>> Don't know how block does it, but in networking NAPI will process 64 packets and will yield softirq.
>>>>
>>>> For small size buckets low_watermark=32 and high=96.
>>>> We typically move 32 elements at a time from one list to another.
>>>> A bunch of elements maybe sitting in free_by_rcu and moving them to waiting_for_gp
>>>> is not instant, but once __free_rcu_tasks_trace is called we need to take
>>>> elements from waiting_for_gp one at a time and kfree it one at a time.
>>>> So optimizing the move from free_by_rcu into waiting_for_gp is not worth the code complexity.
>>>>
>>>>> Before I post v5, I want to know the reason why per-bpf-ma list is
>>>>> introduced. Previously, I though it was used to handle the case in which
>>>>> allocation and freeing are done on different CPUs.
>>>> Correct. per-bpf-ma list is necessary to avoid OOM-ing due to slow rcu_tasks_trace GP.
>>>>
>>>>> And as we can see
>>>>> from the benchmark result above and in v3, the performance and the
>>>>> memory usage of v4 for add_del_on_diff_cpu is better than v3.
>>>> bench from patch 2 is invalid. Hence no conclusion can be made.
>>>>
>>>> So far the only bench we can trust and analyze is map_perf_test.
>>>> Please make bench in patch 2 yield the cpu after few updates.
>>>> Earlier I suggested to stick to 10, but since NAPI can do 64 at a time.
>>>> 64 updates is realistic too. A thousand is not.
>> Will do that.
>>


