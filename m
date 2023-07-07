Return-Path: <bpf+bounces-4400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5DC74A9F9
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9211C20EAE
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9B1FCA;
	Fri,  7 Jul 2023 04:37:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27161EA0;
	Fri,  7 Jul 2023 04:37:45 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C41BD2;
	Thu,  6 Jul 2023 21:37:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qy0xZ06Ggz4f3khH;
	Fri,  7 Jul 2023 12:37:38 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCH8iyQlqdkl4WvMg--.65529S2;
	Fri, 07 Jul 2023 12:37:40 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com>
 <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
 <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
 <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
 <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com>
Date: Fri, 7 Jul 2023 12:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCH8iyQlqdkl4WvMg--.65529S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1UCF4ruF4DurWxAw15twb_yoW5XF15pF
	WrCF98WF1UAF4Sy3Wvqr48Gws2vrsIy347tay5GFnakr15W3s0qFW7Kry5CFn5Cws7Aasx
	tryq9a4xJF1Yv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
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

On 7/7/2023 12:16 PM, Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 8:39 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 7/7/2023 10:12 AM, Alexei Starovoitov wrote:
>>> On Thu, Jul 6, 2023 at 7:07 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hi,
>>>>
>>>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
>>>>
SNIP
>>> and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is similar.
>> I think free_by_rcu_ttrace is different, because the reuse is only
>> possible after one tasks trace RCU grace period as shown below, and the
>> concurrent llist_del_first() must have been completed when the head is
>> reused and re-added into free_by_rcu_ttrace again.
>>
>> // c0->free_by_rcu_ttrace
>> A -> B -> C -> nil
>>
>> P1:
>> alloc_bulk()
>>     llist_del_first(&c->free_by_rcu_ttrace)
>>         entry = A
>>         next = B
>>
>> P2:
>> do_call_rcu_ttrace()
>>     // c->free_by_rcu_ttrace->first = NULL
>>     llist_del_all(&c->free_by_rcu_ttrace)
>>         move to c->waiting_for_gp_ttrace
>>
>> P1:
>> llist_del_first()
>>     return NULL
>>
>> // A is only reusable after one task trace RCU grace
>> // llist_del_first() must have been completed
> "must have been completed" ?
>
> I guess you're assuming that alloc_bulk() from irq_work
> is running within rcu_tasks_trace critical section,
> so __free_rcu_tasks_trace() callback will execute after
> irq work completed?
> I don't think that's the case.

Yes. The following is my original thoughts. Correct me if I was wrong:

1. llist_del_first() must be running concurrently with llist_del_all().
If llist_del_first() runs after llist_del_all(), it will return NULL
directly.
2. call_rcu_tasks_trace() must happen after llist_del_all(), else the
elements in free_by_rcu_ttrace will not be freed back to slab.
3. call_rcu_tasks_trace() will wait for one tasks trace RCU grace period
to call __free_rcu_tasks_trace()
4. llist_del_first() in running in an context with irq-disabled, so the
tasks trace RCU grace period will wait for the end of llist_del_first()

It seems you thought step 4) is not true, right ?
> In vCPU P1 is stopped for looong time by host,
> P2 can execute __free_rcu_tasks_trace (or P3, since
> tasks trace callbacks execute in a kthread that is not bound
> to any cpu).
> __free_rcu_tasks_trace() will free it into slab.
> Then kmalloc the same obj and eventually put it back into
> free_by_rcu_ttrace.
>
> Since you believe that waiting_for_gp_ttrace ABA is possible
> here it's the same probability. imo both lower than a bit flip due
> to cosmic rays which is actually observable in practice.
>
>> __free_rcu_tasks_trace
>>     free_all(llist_del_all(&c->waiting_for_gp_ttrace))
>>
>>
> .


