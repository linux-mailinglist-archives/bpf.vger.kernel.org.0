Return-Path: <bpf+bounces-1972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB9725174
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 03:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4444C28114B
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 01:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A41632;
	Wed,  7 Jun 2023 01:19:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACC7C
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 01:19:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2AE6B;
	Tue,  6 Jun 2023 18:19:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbTyr2RhXz4f3tP1;
	Wed,  7 Jun 2023 09:19:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAnDgwh239kMlwUKQ--.34777S2;
	Wed, 07 Jun 2023 09:19:33 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0bbf258f-668b-a691-e425-a4c1c6bfcc91@huaweicloud.com>
Date: Wed, 7 Jun 2023 09:19:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnDgwh239kMlwUKQ--.34777S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF47XryDGrWxKF18Gr15Jwb_yoWxZw1rpr
	WSgF43Jr4DAr9I9ws2vwn2q34UAws3Xr45XFyFkryDCwn8Xr9IvFZ2vFWYvFyUWryDC3yj
	qrWkJ3yxZas5C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/7/2023 5:04 AM, Alexei Starovoitov wrote:
> On Tue, Jun 06, 2023 at 08:30:58PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 6/6/2023 11:53 AM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Hi,
>>>
>>> The implementation of v4 is mainly based on suggestions from Alexi [0].
>>> There are still pending problems for the current implementation as shown
>>> in the benchmark result in patch #3, but there was a long time from the
>>> posting of v3, so posting v4 here for further disscussions and more
>>> suggestions.
>>>
>>> The first problem is the huge memory usage compared with bpf memory
>>> allocator which does immediate reuse:
>>>
>>> htab-mem-benchmark (reuse-after-RCU-GP):
>>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>>> | --                 | --        | --                  | --               |
>>> | no_op              | 1159.18   | 0.99                | 0.99             |
>>> | overwrite          | 11.00     | 2288                | 4109             |
>>> | batch_add_batch_del| 8.86      | 1558                | 2763             |
>>> | add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |
>>>
>>> htab-mem-benchmark (immediate-reuse):
>>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>>> | --                 | --        | --                  | --               |
>>> | no_op              | 1160.66   | 0.99                | 1.00             |
>>> | overwrite          | 28.52     | 2.46                | 2.73             |
>>> | batch_add_batch_del| 11.50     | 2.69                | 2.95             |
>>> | add_del_on_diff_cpu| 3.75      | 15.85               | 24.24            |
>>>
>>> It seems the direct reason is the slow RCU grace period. During
>>> benchmark, the elapsed time when reuse_rcu() callback is called is about
>>> 100ms or even more (e.g., 2 seconds). I suspect the global per-bpf-ma
>>> spin-lock and the irq-work running in the contex of freeing process will
>>> increase the running overhead of bpf program, the running time of
>>> getpgid() is increased, the contex switch is slowed down and the RCU
>>> grace period increases [1], but I am still diggin into it.
>> For reuse-after-RCU-GP flavor, by removing per-bpf-ma reusable list
>> (namely bpf_mem_shared_cache) and using per-cpu reusable list (like v3
>> did) instead, the memory usage of htab-mem-benchmark will decrease a lot:
>>
>> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list):
>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>> | --                 | --        | --                  | --               |
>> | no_op              | 1165.38   | 0.97                | 1.00             |
>> | overwrite          | 17.25     | 626.41              | 781.82           |
>> | batch_add_batch_del| 11.51     | 398.56              | 500.29           |
>> | add_del_on_diff_cpu| 4.21      | 31.06               | 48.84            |
>>
>> But the memory usage is still large compared with v3 and the elapsed
>> time of reuse_rcu() callback is about 90~200ms. Compared with v3, there
>> are still two differences:
>> 1) v3 uses kmalloc() to allocate multiple inflight RCU callbacks to
>> accelerate the reuse of freed objects.
>> 2) v3 uses kworker instead of irq_work for free procedure.
>>
>> For 1), after using kmalloc() in irq_work to allocate multiple inflight
>> RCU callbacks (namely reuse_rcu()), the memory usage decreases a bit,
>> but is not enough:
>>
>> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks):
>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>> | --                 | --        | --                  | --               |
>> | no_op              | 1247.00   | 0.97                | 1.00             |
>> | overwrite          | 16.56     | 490.18              | 557.17           |
>> | batch_add_batch_del| 11.31     | 276.32              | 360.89           |
>> | add_del_on_diff_cpu| 4.00      | 24.76               | 42.58            |
>>
>> So it seems the large memory usage is due to irq_work (reuse_bulk) used
>> for free procedure. However after increasing the threshold for invoking
>> irq_work reuse_bulk (e.g., use 10 * c->high_watermark), but there is no
>> big difference in the memory usage and the delayed time for RCU
>> callbacks. Perhaps the reason is that although the number of  reuse_bulk
>> irq_work calls is reduced but the time of alloc_bulk() irq_work calls is
>> increased because there are no reusable objects.
> The large memory usage is because the benchmark in patch 2 is abusing it.
> It's doing one bpf_loop() over 16k elements (in case of 1 producer)
> and 16k/8 loops for --producers=8.
> That's 2k memory allocations that have to wait for RCU GP.
> Of course that's a ton of memory.
I don't agree that. Because in v3, the benchmark is the same, but both
the performance and the memory usage are better than v4. Even compared
with  "htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list +
multiple reuse_rcu() callbacks)" above, the memory usage in v3 is still
much smaller as shown below. If the large memory usage is due to the
abuse in benchmark, how do you explain the memory usage in v3 ?

htab-mem-benchmark (reuse-after-rcu-gp v3)

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1199.16    | 0.97                 | 0.99              |
| overwrite           | 16.37      | 24.01                | 31.76             |
| batch_add_batch_del | 9.61       | 16.71                | 19.95             |
| add_del_on_diff_cpu | 3.62       | 22.93                | 37.02             |

>
> As far as implementation in patch 3 please respin it asap and remove *_tail optimization.
> It makes the code hard to read and doesn't buy us anything.
The reason I added tail for each list is that there could be thousands
even ten thousands elements in these lists and there is no need to spend
CPU time to traversal these list one by one. It maybe a premature
optimization. So let me remove tails from these list first and I will
try to add these tails back later and check whether or not there is any
performance improvement.
> Other than that the algorithm looks fine.
>
>>> Another problem is the performance degradation compared with immediate
>>> reuse and the output from perf report shown the per-bpf-ma spin-lock is a
>>> top-one hotspot:
> That's not what I see.
> Hot spin_lock is in generic htab code. Not it ma.
> I still believe per-bpf-ma spin-lock is fine.
> The bench in patch 2 is measuring something that no real bpf prog cares about.
>
> See how map_perf_test is doing:
>         for (i = 0; i < 10; i++) {
>                 bpf_map_update_elem(&hash_map_alloc, &key, &init_val, BPF_ANY);
>
> Even 10 map updates for the same map in a single bpf prog invocation is not realistic.
> 16k/8 is beyond any normal scenario.
> There is no reason to optimize bpf_ma for the case of htab abuse.
I have a different view for the benchmark. Firstly htab is not the only
user of bpf memory allocator, secondly we can't predict the exact
behavior of bpf programs, so I think to stress bpf memory allocator for
various kinds of use case is good for its broad usage.
>
>>> map_perf_test (reuse-after-RCU-GP)
>>> 0:hash_map_perf kmalloc 194677 events per sec
>>>
>>> map_perf_test (immediate reuse)
>>> 2:hash_map_perf kmalloc 384527 events per sec
> For some reason I cannot reproduce the slow down with map_perf_test 4 8.
> I see the same perf with/without patch 3.
I will double check my local setup and test results.
>
> I've applied patch 1.
> Please respin with patch 2 doing no more than 10 map_updates under rcu lock
> and remove *_tail optimization from patch 3.
> Just do llist_for_each_safe() when you move elements from one list to another.
> And let's brainstorm further.
> Please do not delay.
> .


