Return-Path: <bpf+bounces-4507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90174BC7A
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 09:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7734D2819DF
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD41FAE;
	Sat,  8 Jul 2023 07:03:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214010E5;
	Sat,  8 Jul 2023 07:03:48 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE2118;
	Sat,  8 Jul 2023 00:03:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qyh7c5kZ1z4f3kFH;
	Sat,  8 Jul 2023 15:03:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCH4RtMCqlkHYECMw--.9860S2;
	Sat, 08 Jul 2023 15:03:43 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: paulmck@kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com>
 <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
 <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
 <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
 <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
 <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com>
 <CAADnVQL5O5uzy=sewNJ=NFSGV7JTb3ONHR=V2kWiT1YdN=ax8g@mail.gmail.com>
 <3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop>
Message-ID: <bdfc76dc-459a-7c23-bb23-854742fbd0c3@huaweicloud.com>
Date: Sat, 8 Jul 2023 15:03:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCH4RtMCqlkHYECMw--.9860S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfuF45Kw4rtF4kKr47XFb_yoWrJr4xpr
	WkuFyDKr4UZr1Fv3Z2vw48Ww13ArW5AFy3tFyrGrW5CryYyr1Dtr4ft3yF9FyFkrWkJa42
	q3s0gw13A3Z0va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/8/2023 1:47 AM, Paul E. McKenney wrote:
> On Fri, Jul 07, 2023 at 09:11:22AM -0700, Alexei Starovoitov wrote:
>> On Thu, Jul 6, 2023 at 9:37 PM Hou Tao <houtao@huaweicloud.com> wrote:
SNIP
>>> I guess you're assuming that alloc_bulk() from irq_work
>>> is running within rcu_tasks_trace critical section,
>>> so __free_rcu_tasks_trace() callback will execute after
>>> irq work completed?
>>> I don't think that's the case.
>>> Yes. The following is my original thoughts. Correct me if I was wrong:
>>>
>>> 1. llist_del_first() must be running concurrently with llist_del_all().
>>> If llist_del_first() runs after llist_del_all(), it will return NULL
>>> directly.
>>> 2. call_rcu_tasks_trace() must happen after llist_del_all(), else the
>>> elements in free_by_rcu_ttrace will not be freed back to slab.
>>> 3. call_rcu_tasks_trace() will wait for one tasks trace RCU grace period
>>> to call __free_rcu_tasks_trace()
>>> 4. llist_del_first() in running in an context with irq-disabled, so the
>>> tasks trace RCU grace period will wait for the end of llist_del_first()
>>>
>>> It seems you thought step 4) is not true, right ?
>> Yes. I think so. For two reasons:
>>
>> 1.
>> I believe irq disabled region isn't considered equivalent
>> to rcu_read_lock_trace() region.
>>
>> Paul,
>> could you clarify ?
> You are correct, Alexei.  Unlike vanilla RCU, RCU Tasks Trace does not
> count irq-disabled regions of code as readers.

I see. But I still have one question: considering that in current
implementation one Tasks Trace RCU grace period implies one vanilla RCU
grace period (aka rcu_trace_implies_rcu_gp), so in my naive
understanding of RCU, does that mean __free_rcu_tasks_trace() will be
invoked after the expiration of current Task Trace RCU grace period,
right ? And does it also mean __free_rcu_tasks_trace() will be invoked
after the expiration of current vanilla RCU grace period, right ? If
these two conditions above are true, does it mean
__free_rcu_tasks_trace() will wait for the irq-disabled code reigion ?
> But why not just put an rcu_read_lock_trace() and a matching
> rcu_read_unlock_trace() within that irq-disabled region of code?
>
> For completeness, if it were not for CONFIG_TASKS_TRACE_RCU_READ_MB,
> Hou Tao would be correct from a strict current-implementation
> viewpoint.  The reason is that, given the current implementation in
> CONFIG_TASKS_TRACE_RCU_READ_MB=n kernels, a task must either block or
> take an IPI in order for the grace-period machinery to realize that this
> task is done with all prior readers.

Thanks for the detailed explanation.
> However, we need to account for the possibility of IPI-free
> implementations, for example, if the real-time guys decide to start
> making heavy use of BPF sleepable programs.  They would then insist on
> getting rid of those IPIs for CONFIG_PREEMPT_RT=y kernels.  At which
> point, irq-disabled regions of code will absolutely not act as
> RCU tasks trace readers.
>
> Again, why not just put an rcu_read_lock_trace() and a matching
> rcu_read_unlock_trace() within that irq-disabled region of code?
>
> Or maybe there is a better workaround.

Yes. I think we could use rcu_read_{lock,unlock}_trace to fix the ABA
problem for free_by_rcu_ttrace.
>
>> 2.
>> Even if 1 is incorrect, in RT llist_del_first() from alloc_bulk()
>> runs "in a per-CPU thread in preemptible context."
>> See irq_work_run_list.
> Agreed, under RT, "interrupt handlers" often run in task context.

Yes, I missed that. I misread alloc_bulk(), and it seems it only does
inc_active() for c->free_llist.
> 						Thanx, Paul


