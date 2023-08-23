Return-Path: <bpf+bounces-8339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB0784FAB
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 06:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767CD1C20C56
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 04:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C117D4;
	Wed, 23 Aug 2023 04:39:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639487E1
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 04:39:48 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5230CE57
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:39:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVtmF2GxXz4f3lV5
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 12:39:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAH3J6KjeVkkI57BQ--.52546S2;
	Wed, 23 Aug 2023 12:39:42 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Enable preemption after
 irq_work_raise() in unit_alloc()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com>
 <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com>
 <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com>
Date: Wed, 23 Aug 2023 12:39:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAH3J6KjeVkkI57BQ--.52546S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15Kw1DGw48Xr4UJr17Awb_yoWrKrWkpF
	43tFy0ya1UXa42vw12gw1rJryFvw4UKry8XrWYqryfu390vr92grs2kry5uryfursrGFWI
	yr4ktayS9FWFvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/23/2023 9:57 AM, Alexei Starovoitov wrote:
> On Tue, Aug 22, 2023 at 5:51 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 8/23/2023 8:05 AM, Alexei Starovoitov wrote:
>>> On Tue, Aug 22, 2023 at 6:06 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> When doing stress test for qp-trie, bpf_mem_alloc() returned NULL
>>>> unexpectedly because all qp-trie operations were initiated from
>>>> bpf syscalls and there was still available free memory. bpf_obj_new()
>>>> has the same problem as shown by the following selftest.
>>>>
>>>> The failure is due to the preemption. irq_work_raise() will invoke
>>>> irq_work_claim() first to mark the irq work as pending and then inovke
>>>> __irq_work_queue_local() to raise an IPI. So when the current task
>>>> which is invoking irq_work_raise() is preempted by other task,
>>>> unit_alloc() may return NULL for preemptive task as shown below:
>>>>
>>>> task A         task B
>>>>
>>>> unit_alloc()
>>>>   // low_watermark = 32
>>>>   // free_cnt = 31 after alloc
>>>>   irq_work_raise()
>>>>     // mark irq work as IRQ_WORK_PENDING
>>>>     irq_work_claim()
>>>>
>>>>                // task B preempts task A
>>>>                unit_alloc()
>>>>                  // free_cnt = 30 after alloc
>>>>                  // irq work is already PENDING,
>>>>                  // so just return
>>>>                  irq_work_raise()
>>>>                // does unit_alloc() 30-times
>>>>                ......
>>>>                unit_alloc()
>>>>                  // free_cnt = 0 before alloc
>>>>                  return NULL
>>>>
>>>> Fix it by invoking preempt_disable_notrace() before allocation and
>>>> invoking preempt_enable_notrace() to enable preemption after
>>>> irq_work_raise() completes. An alternative fix is to move
>>>> local_irq_restore() after the invocation of irq_work_raise(), but it
>>>> will enlarge the irq-disabled region. Another feasible fix is to only
>>>> disable preemption before invoking irq_work_queue() and enable
>>>> preemption after the invocation in irq_work_raise(), but it can't
>>>> handle the case when c->low_watermark is 1.
>>>>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  kernel/bpf/memalloc.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>>> index 9c49ae53deaf..83f8913ebb0a 100644
>>>> --- a/kernel/bpf/memalloc.c
>>>> +++ b/kernel/bpf/memalloc.c
>>>> @@ -6,6 +6,7 @@
>>>>  #include <linux/irq_work.h>
>>>>  #include <linux/bpf_mem_alloc.h>
>>>>  #include <linux/memcontrol.h>
>>>> +#include <linux/preempt.h>
>>>>  #include <asm/local.h>
>>>>
>>>>  /* Any context (including NMI) BPF specific memory allocator.
>>>> @@ -725,6 +726,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>>>>          * Use per-cpu 'active' counter to order free_list access between
>>>>          * unit_alloc/unit_free/bpf_mem_refill.
>>>>          */
>>>> +       preempt_disable_notrace();
>>>>         local_irq_save(flags);
>>>>         if (local_inc_return(&c->active) == 1) {
>>>>                 llnode = __llist_del_first(&c->free_llist);
>>>> @@ -740,6 +742,12 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>>>>
>>>>         if (cnt < c->low_watermark)
>>>>                  (c);
>>>> +       /* Enable preemption after the enqueue of irq work completes,
>>>> +        * so free_llist may be refilled by irq work before other task
>>>> +        * preempts current task.
>>>> +        */
>>>> +       preempt_enable_notrace();
>>> So this helps qp-trie init, since it's doing bpf_mem_alloc from
>>> syscall context and helps bpf_obj_new from bpf prog, since prog is
>>> non-migrateable, but preemptable. It's not an issue for htab doing
>>> during map_update, since
>>> it's under htab bucket lock.
>>> Let's introduce minimal:
>>> /* big comment here explaining the reason of extra preempt disable */
>>> static void bpf_memalloc_irq_work_raise(...)
>>> {
>>>   preempt_disable_notrace();
>>>   irq_work_raise();
>>>   preempt_enable_notrace();
>>> }
>>>
>>> it will have the same effect, right?
>>> .
>> No. As I said in commit message, when c->low_watermark is 1, the above
>> fix doesn't work as shown below:
> Yes. I got mark=1 part. I just don't think it's worth the complexity.

Just find out that for bpf_obj_new() the minimal low_watermark is 2
instead of 1 (unit_size= 4096 instead of 4096 + 8). But even with
low_watermark as 2, the above fix may don't work when there are nested
preemption: task A (free_cnt = 1 after alloc) -> preempted by task B
(free_cnt = 0 after alloc) -> preempted by task C (fail to do
allocation). And in my naive understanding of bpf memory allocate, these
fixes are simple. Why do you think it will introduce extra complexity ?
Do you mean preempt_disable_notrace() could be used to trigger the
running of bpf program ? If it is the problem, I think we should fix it
instead.


