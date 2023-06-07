Return-Path: <bpf+bounces-1982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB3B725698
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E5E28105B
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0C747A;
	Wed,  7 Jun 2023 07:56:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A251C3A
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 07:56:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DF10C6;
	Wed,  7 Jun 2023 00:56:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qbfmh0SlPz4f3kp2;
	Wed,  7 Jun 2023 15:56:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB34iwhOIBkSMYKKg--.5055S2;
	Wed, 07 Jun 2023 15:56:21 +0800 (CST)
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
 <0bbf258f-668b-a691-e425-a4c1c6bfcc91@huaweicloud.com>
 <CAADnVQL9OmzUEajiVN7DMHcpOUya6O-JvwU1zkPwxZ0D2XsPWg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <32ad756b-46f8-f239-bdb9-297c9de980d6@huaweicloud.com>
Date: Wed, 7 Jun 2023 15:56:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQL9OmzUEajiVN7DMHcpOUya6O-JvwU1zkPwxZ0D2XsPWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB34iwhOIBkSMYKKg--.5055S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWDCFW5tr45tr4DKF4kWFg_yoW3AF1fpr
	WfKay3tr4kJryay392yr4Iq34jyws3Jr15WF1rCr98Cwn0qr1fuFZ2vrWY9Fy5CryDC3yj
	qrWDJ347ZFyrua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/7/2023 9:39 AM, Alexei Starovoitov wrote:
> On Tue, Jun 6, 2023 at 6:19 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 6/7/2023 5:04 AM, Alexei Starovoitov wrote:
>>> On Tue, Jun 06, 2023 at 08:30:58PM +0800, Hou Tao wrote:
>>>> Hi,
>>>>
>>>> On 6/6/2023 11:53 AM, Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> The implementation of v4 is mainly based on suggestions from Alexi [0].
>>>>> There are still pending problems for the current implementation as shown
>>>>> in the benchmark result in patch #3, but there was a long time from the
>>>>> posting of v3, so posting v4 here for further disscussions and more
>>>>> suggestions.
>>>>>
>>>>> The first problem is the huge memory usage compared with bpf memory
>>>>> allocator which does immediate reuse:
>>>>>
>>>>> htab-mem-benchmark (reuse-after-RCU-GP):
>>>>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>>>>> | --                 | --        | --                  | --               |
>>>>> | no_op              | 1159.18   | 0.99                | 0.99             |
>>>>> | overwrite          | 11.00     | 2288                | 4109             |
>>>>> | batch_add_batch_del| 8.86      | 1558                | 2763             |
>>>>> | add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |
>>>>>
>>>>> htab-mem-benchmark (immediate-reuse):
>>>>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>>>>> | --                 | --        | --                  | --               |
>>>>> | no_op              | 1160.66   | 0.99                | 1.00             |
>>>>> | overwrite          | 28.52     | 2.46                | 2.73             |
>>>>> | batch_add_batch_del| 11.50     | 2.69                | 2.95             |
>>>>> | add_del_on_diff_cpu| 3.75      | 15.85               | 24.24            |
>>>>>
>>>>> It seems the direct reason is the slow RCU grace period. During
>>>>> benchmark, the elapsed time when reuse_rcu() callback is called is about
>>>>> 100ms or even more (e.g., 2 seconds). I suspect the global per-bpf-ma
>>>>> spin-lock and the irq-work running in the contex of freeing process will
>>>>> increase the running overhead of bpf program, the running time of
>>>>> getpgid() is increased, the contex switch is slowed down and the RCU
>>>>> grace period increases [1], but I am still diggin into it.
>>>> For reuse-after-RCU-GP flavor, by removing per-bpf-ma reusable list
>>>> (namely bpf_mem_shared_cache) and using per-cpu reusable list (like v3
>>>> did) instead, the memory usage of htab-mem-benchmark will decrease a lot:
>>>>
>>>> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list):
>>>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>>>> | --                 | --        | --                  | --               |
>>>> | no_op              | 1165.38   | 0.97                | 1.00             |
>>>> | overwrite          | 17.25     | 626.41              | 781.82           |
>>>> | batch_add_batch_del| 11.51     | 398.56              | 500.29           |
>>>> | add_del_on_diff_cpu| 4.21      | 31.06               | 48.84            |
>>>>
>>>> But the memory usage is still large compared with v3 and the elapsed
>>>> time of reuse_rcu() callback is about 90~200ms. Compared with v3, there
>>>> are still two differences:
>>>> 1) v3 uses kmalloc() to allocate multiple inflight RCU callbacks to
>>>> accelerate the reuse of freed objects.
>>>> 2) v3 uses kworker instead of irq_work for free procedure.
>>>>
>>>> For 1), after using kmalloc() in irq_work to allocate multiple inflight
>>>> RCU callbacks (namely reuse_rcu()), the memory usage decreases a bit,
>>>> but is not enough:
>>>>
>>>> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks):
>>>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>>>> | --                 | --        | --                  | --               |
>>>> | no_op              | 1247.00   | 0.97                | 1.00             |
>>>> | overwrite          | 16.56     | 490.18              | 557.17           |
>>>> | batch_add_batch_del| 11.31     | 276.32              | 360.89           |
>>>> | add_del_on_diff_cpu| 4.00      | 24.76               | 42.58            |
>>>>
>>>> So it seems the large memory usage is due to irq_work (reuse_bulk) used
>>>> for free procedure. However after increasing the threshold for invoking
>>>> irq_work reuse_bulk (e.g., use 10 * c->high_watermark), but there is no
>>>> big difference in the memory usage and the delayed time for RCU
>>>> callbacks. Perhaps the reason is that although the number of  reuse_bulk
>>>> irq_work calls is reduced but the time of alloc_bulk() irq_work calls is
>>>> increased because there are no reusable objects.
>>> The large memory usage is because the benchmark in patch 2 is abusing it.
>>> It's doing one bpf_loop() over 16k elements (in case of 1 producer)
>>> and 16k/8 loops for --producers=8.
>>> That's 2k memory allocations that have to wait for RCU GP.
>>> Of course that's a ton of memory.
>> I don't agree that. Because in v3, the benchmark is the same, but both
>> the performance and the memory usage are better than v4. Even compared
>> with  "htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list +
>> multiple reuse_rcu() callbacks)" above, the memory usage in v3 is still
>> much smaller as shown below. If the large memory usage is due to the
>> abuse in benchmark, how do you explain the memory usage in v3 ?
> There could have been implementation bugs or whatever else.
> The main point is the bench test is not realistic and should not be
> used to make design decisions.
I see your point. I will continue to debug the memory usage difference
between v3 and v4.
>
>> The reason I added tail for each list is that there could be thousands
>> even ten thousands elements in these lists and there is no need to spend
>> CPU time to traversal these list one by one. It maybe a premature
>> optimization. So let me remove tails from these list first and I will
>> try to add these tails back later and check whether or not there is any
>> performance improvement.
> There will be thousands of elements only because the bench test is wrong.
> It's doing something no real prog would do.
I don't think so. Let's considering the per-cpu list first. Assume the
normal RCU grace period is about 30ms and we are tracing the IO latency
of a normal SSD. The iops is about 176K per seconds, so before one RCU
GP is passed, we will need to allocate about 176 * 30 = 5.2K elements.
For the per-ma list, when the number of CPUs increased, it is easy to
make the list contain thousands of elements.
>
>> I have a different view for the benchmark. Firstly htab is not the only
>> user of bpf memory allocator, secondly we can't predict the exact
>> behavior of bpf programs, so I think to stress bpf memory allocator for
>> various kinds of use case is good for its broad usage.
> It is not a stress test. It's an abuse.
> A stress test would be something that can happen in practice.
> Doing thousands map_updates in a forever loop is not something
> useful code would do.
> For example call_rcu_tasks_trace is not design to be called millions
> times a second. It's an anti-pattern and rcu core won't be optimized to do so.
> rcu, srcu, rcu_task_trace have different usage patterns.
> The programmer has to correctly pick one depending on the use case.
> Same with bpf htab. If somebody has a real need to do thousands
> updates under rcu lock they should be using preallocated map and deal
> with immediate reuse.
Before I post v5, I want to know the reason why per-bpf-ma list is
introduced. Previously, I though it was used to handle the case in which
allocation and freeing are done on different CPUs. And as we can see
from the benchmark result above and in v3, the performance and the
memory usage of v4 for add_del_on_diff_cpu is better than v3. But now I
am not sure, because as you mentioned above, it is used to reduce the
calling frequency of call_rcu_task_trace(). So could you tell me the
main reason for the per-bpf-ma list ? As shown in the above benchmark
performance, using per-cpu-reuse-list (namely htab-mem-benchmark
(reuse-after-RCU-GP + per-cpu reusable list)) have better performance
and memory usage compared with per-ma-list (htab-mem-benchmark
(reuse-after-RCU-GP)). If we just want to reduce the calling frequency
of call_rcu_task_trace(), we could make
bpf_mem_shared_cache->reuse_ready_head being per-cpu and leave
wait_for_free being per-bpf-ma.


