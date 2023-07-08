Return-Path: <bpf+bounces-4506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5774BC74
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF94281992
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C61FAD;
	Sat,  8 Jul 2023 07:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D615BF;
	Sat,  8 Jul 2023 07:00:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F62105;
	Sat,  8 Jul 2023 00:00:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qyh3w3rJLz4f3k66;
	Sat,  8 Jul 2023 15:00:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAHYhyJCalkrlYCMw--.44986S2;
	Sat, 08 Jul 2023 15:00:29 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 12/14] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
From: Hou Tao <houtao@huaweicloud.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-13-alexei.starovoitov@gmail.com>
 <2c09b7d7-b91c-c561-3fd6-b8483aab01dc@huaweicloud.com>
 <CAADnVQKea47Q1WPtmVrHEZijb=Ms8QzufVj8eds5HmNXGxSRug@mail.gmail.com>
 <205ac9e9-ef8c-2b39-8d76-a937d6fc72d5@huaweicloud.com>
Message-ID: <c96bb80d-2e4e-213e-b9e8-d54d4a8a6f4a@huaweicloud.com>
Date: Sat, 8 Jul 2023 15:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <205ac9e9-ef8c-2b39-8d76-a937d6fc72d5@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAHYhyJCalkrlYCMw--.44986S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4rJF13tFyrGrWfCr4xCrg_yoW5tw13pF
	WftFWxKrWDJ3y0ywsIyw13WF9Fq3yfWw1DW34Fqa13ur4jvF1aqF4xWF4Ygrn8Wr4kCF1I
	ywnFyr1ag34UXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/7/2023 12:05 PM, Hou Tao wrote:
> Hi,
>
> On 7/7/2023 10:10 AM, Alexei Starovoitov wrote:
>> On Thu, Jul 6, 2023 at 6:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>
>>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>
>>>> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
>>>> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
>>>> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
>>>> objects into free_by_rcu_ttrace list where they are waiting for RCU
>>>> task trace grace period to be freed into slab.
>>>>
>>>> The life cycle of objects:
>>>> alloc: dequeue free_llist
>>>> free: enqeueu free_llist
>>>> free_rcu: enqueue free_by_rcu -> waiting_for_gp
>>>> free_llist above high watermark -> free_by_rcu_ttrace
>>>> after RCU GP waiting_for_gp -> free_by_rcu_ttrace
>>>> free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
>>>>
>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>> Acked-by: Hou Tao <houtao1@huawei.com>
>> Thank you very much for code reviews and feedback.
> You are welcome. I also learn a lot from this great patch set.
>
>> btw I still believe that ABA is a non issue and prefer to keep the code as-is,
>> but for the sake of experiment I've converted it to spin_lock
>> (see attached patch which I think uglifies the code)
>> and performance across bench htab-mem and map_perf_test
>> seems to be about the same.
>> Which was a bit surprising to me.
>> Could you please benchmark it on your system?
> Will do that later. It seems if there is no cross-CPU allocation and
> free, the only possible contention is between __free_rcu() on CPU x and
> alloc_bulk()/free_bulk() on a different CPU.
>
For my local VM setup, the spin-lock also doesn't make much different
under both htab-mem and map_perf_test as shown below.

without spin-lock

normal bpf ma
=============
overwrite            per-prod-op: 54.16 ± 0.79k/s, avg mem: 159.99 ±
40.80MiB, peak mem: 251.41MiB
batch_add_batch_del  per-prod-op: 83.87 ± 0.86k/s, avg mem: 70.52 ±
22.73MiB, peak mem: 121.31MiB
add_del_on_diff_cpu  per-prod-op: 25.98 ± 0.13k/s, avg mem: 17.88 ±
1.84MiB, peak mem: 22.86MiB

./map_perf_test 4 8 16384
0:hash_map_perf kmalloc 361532 events per sec
2:hash_map_perf kmalloc 352594 events per sec
6:hash_map_perf kmalloc 356007 events per sec
5:hash_map_perf kmalloc 354184 events per sec
3:hash_map_perf kmalloc 348720 events per sec
1:hash_map_perf kmalloc 346332 events per sec
7:hash_map_perf kmalloc 352126 events per sec
4:hash_map_perf kmalloc 339459 events per sec

with spin-lock

normal bpf ma
=============
overwrite            per-prod-op: 54.72 ± 0.96k/s, avg mem: 133.99 ±
34.04MiB, peak mem: 221.60MiB
batch_add_batch_del  per-prod-op: 82.90 ± 1.86k/s, avg mem: 55.91 ±
11.05MiB, peak mem: 103.82MiB
add_del_on_diff_cpu  per-prod-op: 26.75 ± 0.10k/s, avg mem: 18.55 ±
1.24MiB, peak mem: 23.11MiB

./map_perf_test 4 8 16384
1:hash_map_perf kmalloc 361750 events per sec
2:hash_map_perf kmalloc 360976 events per sec
6:hash_map_perf kmalloc 361745 events per sec
0:hash_map_perf kmalloc 350349 events per sec
7:hash_map_perf kmalloc 359125 events per sec
3:hash_map_perf kmalloc 352683 events per sec
5:hash_map_perf kmalloc 350897 events per sec
4:hash_map_perf kmalloc 331215 events per sec


