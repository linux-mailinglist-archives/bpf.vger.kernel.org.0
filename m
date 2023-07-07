Return-Path: <bpf+bounces-4387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F174A966
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 05:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9B828160D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BCE1FA7;
	Fri,  7 Jul 2023 03:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81B1309D;
	Fri,  7 Jul 2023 03:39:01 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47E1FC9;
	Thu,  6 Jul 2023 20:38:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qxzdq542zz4f4NVR;
	Fri,  7 Jul 2023 11:38:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3Z6vMiKdkRJSONQ--.29906S2;
	Fri, 07 Jul 2023 11:38:56 +0800 (CST)
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
Date: Fri, 7 Jul 2023 11:38:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3Z6vMiKdkRJSONQ--.29906S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5Xw4fAr43Kr45Zr48tFb_yoW8tw17pF
	4fJFy5XFyUZF4Sy342qr48Gasavw47t347KayUWasIkr15Xrn0gryfWry5urn5A397A34a
	yr1v9rySya1Y937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
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

On 7/7/2023 10:12 AM, Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 7:07 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
>>> Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>> ---
>>>  kernel/bpf/memalloc.c | 16 ++++++++++------
>>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index 9986c6b7df4d..e5a87f6cf2cc 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>>> @@ -212,6 +212,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>>>       if (i >= cnt)
>>>               return;
>>>
>>> +     for (; i < cnt; i++) {
>>> +             obj = llist_del_first(&c->waiting_for_gp_ttrace);
>>> +             if (!obj)
>>> +                     break;
>>> +             add_obj_to_free_list(c, obj);
>>> +     }
>>> +     if (i >= cnt)
>>> +             return;
>> I still think using llist_del_first() here is not safe as reported in
>> [1]. Not sure whether or not invoking enque_to_free() firstly for
>> free_llist_extra will close the race completely. Will check later.
> lol. see my reply a second ago in the other thread.
>
> and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is similar.

I think free_by_rcu_ttrace is different, because the reuse is only
possible after one tasks trace RCU grace period as shown below, and the
concurrent llist_del_first() must have been completed when the head is
reused and re-added into free_by_rcu_ttrace again.

// c0->free_by_rcu_ttrace
A -> B -> C -> nil
   
P1:
alloc_bulk()
    llist_del_first(&c->free_by_rcu_ttrace)
        entry = A
        next = B

P2:
do_call_rcu_ttrace()
    // c->free_by_rcu_ttrace->first = NULL
    llist_del_all(&c->free_by_rcu_ttrace)
        move to c->waiting_for_gp_ttrace

P1:
llist_del_first()
    return NULL

// A is only reusable after one task trace RCU grace
// llist_del_first() must have been completed
__free_rcu_tasks_trace
    free_all(llist_del_all(&c->waiting_for_gp_ttrace))


