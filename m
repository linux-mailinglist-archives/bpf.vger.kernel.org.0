Return-Path: <bpf+bounces-1983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB272582D
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510131C20E3D
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14368C0A;
	Wed,  7 Jun 2023 08:42:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C479E1
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 08:42:30 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C121BFF;
	Wed,  7 Jun 2023 01:42:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qbgnf6cpQz4f3jJ0;
	Wed,  7 Jun 2023 16:42:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgA3RebjQoBkUjkxLA--.14340S2;
	Wed, 07 Jun 2023 16:42:15 +0800 (CST)
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
Message-ID: <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
Date: Wed, 7 Jun 2023 16:42:11 +0800
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
X-CM-TRANSID:Syh0CgA3RebjQoBkUjkxLA--.14340S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF47XryDArWDWFyDuw1xKrg_yoWxZr47pa
	1fAFW5Kr1Dt398ZwsIyw15WF9Fq34Sgr4DXw1Fqw45uryDZF1aqFs7WF40krn8Cr4rGF10
	k3Zayr1fK347Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
SNIP
> The large memory usage is because the benchmark in patch 2 is abusing it.
> It's doing one bpf_loop() over 16k elements (in case of 1 producer)
> and 16k/8 loops for --producers=8.
> That's 2k memory allocations that have to wait for RCU GP.
> Of course that's a ton of memory.
>
> As far as implementation in patch 3 please respin it asap and remove *_tail optimization.
> It makes the code hard to read and doesn't buy us anything.
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
>
>>> map_perf_test (reuse-after-RCU-GP)
>>> 0:hash_map_perf kmalloc 194677 events per sec
>>>
>>> map_perf_test (immediate reuse)
>>> 2:hash_map_perf kmalloc 384527 events per sec
> For some reason I cannot reproduce the slow down with map_perf_test 4 8.
> I see the same perf with/without patch 3.
As said in the commit message, the command line for test is
"./map_perf_test 4 8 16384", because the default max_entries is 1000. If
using default max_entries and the number of CPUs is greater than 15,
use_percpu_counter will be false.

I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
there are obvious performance degradation.

Before reuse-after-rcu-gp:
[root@hello bpf]# ./map_perf_test 4 8
5:hash_map_perf kmalloc 358498 events per sec
4:hash_map_perf kmalloc 306351 events per sec
1:hash_map_perf kmalloc 299175 events per sec
3:hash_map_perf kmalloc 297689 events per sec
6:hash_map_perf kmalloc 299839 events per sec
2:hash_map_perf kmalloc 292286 events per sec
7:hash_map_perf kmalloc 278138 events per sec
0:hash_map_perf kmalloc 265031 events per sec

[root@hello bpf]# ./map_perf_test 4 8 16384
2:hash_map_perf kmalloc 359201 events per sec
6:hash_map_perf kmalloc 302475 events per sec
3:hash_map_perf kmalloc 298583 events per sec
7:hash_map_perf kmalloc 301594 events per sec
0:hash_map_perf kmalloc 295210 events per sec
4:hash_map_perf kmalloc 230496 events per sec
5:hash_map_perf kmalloc 163530 events per sec
1:hash_map_perf kmalloc 153520 events per sec

After reuse-after-rcu-gp:
[root@hello bpf]# ./map_perf_test 4 8
1:hash_map_perf kmalloc 203252 events per sec
2:hash_map_perf kmalloc 181777 events per sec
6:hash_map_perf kmalloc 183467 events per sec
4:hash_map_perf kmalloc 182590 events per sec
0:hash_map_perf kmalloc 180840 events per sec
3:hash_map_perf kmalloc 179875 events per sec
5:hash_map_perf kmalloc 152250 events per sec
7:hash_map_perf kmalloc 137500 events per sec

[root@hello bpf]# ./map_perf_test 4 8 16384
4:hash_map_perf kmalloc 203983 events per sec
5:hash_map_perf kmalloc 197902 events per sec
2:hash_map_perf kmalloc 184693 events per sec
3:hash_map_perf kmalloc 185341 events per sec
1:hash_map_perf kmalloc 183064 events per sec
7:hash_map_perf kmalloc 181148 events per sec
0:hash_map_perf kmalloc 178520 events per sec
6:hash_map_perf kmalloc 179340 events per sec

I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
performances for "./map_perf_test 4 8" are similar, but there is obvious
performance degradation for "./map_perf_test 4 8 16384"

Before reuse-after-rcu-gp:

[houtao@fedora bpf]$ sudo ./map_perf_test 4 8
1:hash_map_perf kmalloc 41711 events per sec
3:hash_map_perf kmalloc 41352 events per sec
4:hash_map_perf kmalloc 41352 events per sec
0:hash_map_perf kmalloc 41008 events per sec
7:hash_map_perf kmalloc 41086 events per sec
5:hash_map_perf kmalloc 41038 events per sec
2:hash_map_perf kmalloc 40971 events per sec
6:hash_map_perf kmalloc 41008 events per sec

[houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
1:hash_map_perf kmalloc 388088 events per sec
7:hash_map_perf kmalloc 391843 events per sec
6:hash_map_perf kmalloc 387901 events per sec
3:hash_map_perf kmalloc 356096 events per sec
4:hash_map_perf kmalloc 356836 events per sec
2:hash_map_perf kmalloc 349728 events per sec
0:hash_map_perf kmalloc 345792 events per sec
5:hash_map_perf kmalloc 346742 events per sec

After reuse-after-rcu-gp:

[houtao@fedora bpf]$ sudo ./map_perf_test 4 8
4:hash_map_perf kmalloc 42667 events per sec
1:hash_map_perf kmalloc 42206 events per sec
5:hash_map_perf kmalloc 42264 events per sec
6:hash_map_perf kmalloc 42196 events per sec
7:hash_map_perf kmalloc 42142 events per sec
2:hash_map_perf kmalloc 42028 events per sec
0:hash_map_perf kmalloc 41933 events per sec
3:hash_map_perf kmalloc 41986 events per sec

[houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
5:hash_map_perf kmalloc 655628 events per sec
7:hash_map_perf kmalloc 650691 events per sec
2:hash_map_perf kmalloc 624384 events per sec
1:hash_map_perf kmalloc 615011 events per sec
3:hash_map_perf kmalloc 618335 events per sec
4:hash_map_perf kmalloc 624072 events per sec
6:hash_map_perf kmalloc 628559 events per sec
0:hash_map_perf kmalloc 585384 events per sec

So could you please double check your setup and rerun map_perf_test ? If
there is no performance degradation, could you please share your setup
and your kernel configure file ?
>
> I've applied patch 1.
> Please respin with patch 2 doing no more than 10 map_updates under rcu lock
> and remove *_tail optimization from patch 3.
> Just do llist_for_each_safe() when you move elements from one list to another.
> And let's brainstorm further.
> Please do not delay.


