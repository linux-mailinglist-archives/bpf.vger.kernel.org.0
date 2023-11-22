Return-Path: <bpf+bounces-15621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059307F3B88
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A341F2350C
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3281B613B;
	Wed, 22 Nov 2023 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE365193
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:54:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZknC6JCXz4f3lWG
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:54:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 214521A07B6
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:54:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXu0k+X11l4k6OBg--.59777S2;
	Wed, 22 Nov 2023 09:54:09 +0800 (CST)
Subject: Re: [PATCH bpf v2 4/5] bpf: Optimize the free of inner map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231113123324.3914612-1-houtao@huaweicloud.com>
 <20231113123324.3914612-5-houtao@huaweicloud.com>
 <20231121051917.lbp6luone7pxqkvw@macbook-pro-49.dhcp.thefacebook.com>
 <96e07186-d497-8e41-edcd-a106bf87a548@huaweicloud.com>
 <CAADnVQK=tJRhQY1zfLK2n7_tPA5+vN8+KqWmSLqjubUuh6UFAw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <eff0ae47-5619-7515-eb64-74dcf25f6876@huaweicloud.com>
Date: Wed, 22 Nov 2023 09:54:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK=tJRhQY1zfLK2n7_tPA5+vN8+KqWmSLqjubUuh6UFAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXu0k+X11l4k6OBg--.59777S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWkXw48XF47Zw1DJw4ktFb_yoWxCry3pF
	Z5Ja4UKr4Dtr42k39aqw47Za4Iyrs8X345JwnYyryrZr9xWr97ur4IgFW5CFy5Zrs7t3y0
	qryjyryfJFyUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

On 11/22/2023 1:49 AM, Alexei Starovoitov wrote:
> On Mon, Nov 20, 2023 at 10:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Alexei,
>>
>> On 11/21/2023 1:19 PM, Alexei Starovoitov wrote:
>>> On Mon, Nov 13, 2023 at 08:33:23PM +0800, Hou Tao wrote:
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index e2d2701ce2c45..5a7906f2b027e 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -694,12 +694,20 @@ static void bpf_map_free_deferred(struct work_struct *work)
>>>>  {
>>>>      struct bpf_map *map = container_of(work, struct bpf_map, work);
>>>>      struct btf_record *rec = map->record;
>>>> +    int acc_ctx;
>>>>
>>>>      security_bpf_map_free(map);
>>>>      bpf_map_release_memcg(map);
>>>>
>>>> -    if (READ_ONCE(map->free_after_mult_rcu_gp))
>>>> -            synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
>>> The previous patch 3 is doing too much.
>>> There is maybe_wait_bpf_programs() that will do synchronize_rcu()
>>> when necessary.
>>> The patch 3 could do synchronize_rcu_tasks_trace() only and it will solve the issue.
>> I didn't follow how synchronize_rcu() in maybe_wait_bpf_programs() will
>> help bpf_map_free_deferred() to defer the free of inner map. Could you
>> please elaborate on that ? In my understanding, bpf_map_update_value()
>> invokes maybe_wait_bpf_programs() after the deletion of old inner map
>> from outer map completes. If the ref-count of inner map in the outer map
>> is the last one, bpf_map_free_deferred() will be called when the
>> deletion completes, so maybe_wait_bpf_programs() will run concurrently
>> with bpf_map_free_deferred().
> The code was quite different back then.
> See commit 1ae80cf31938 ("bpf: wait for running BPF programs when
> updating map-in-map")
> that was added to specifically address the case where bpf prog is
> looking at the old inner map.
> The commit log talks about a little bit of a different issue,
> but the end result was the same. It prevented UAF since map free
> logic was waiting for normal RCU GP back then.
> See this comment:
> void bpf_map_fd_put_ptr(void *ptr)
> {
>         /* ptr->ops->map_free() has to go through one
>          * rcu grace period by itself.
>          */
>         bpf_map_put(ptr);
> }
>
> that code was added when map-in-map was introduced.

I see. Thanks for the explanation. If there is still synchronize_rcu in
.map_free(), using synchronize_rcu_tasks_trace in bpf_map_free_deferred
will be enough.
>
> Also see this commit:
> https://lore.kernel.org/bpf/20220218181801.2971275-1-eric.dumazet@gmail.com/
>
> In cases of batched updates (when multiple inner maps are deleted from
> outer map) we should not call sync_rcu for every element being
> deleted.
> The introduced latency can be bad.
>
> I guess maybe_wait_bpf_programs() was too much brute force.
> It would call sync_rcu() regardless whether refcnt dropped to zero.
> It mainly cares about user space assumptions.
> This patch 3 and 4 will wait for sync_rcu only when refcnt==0,
> so it should be ok.
>
> Now we don't have 'wait for rcu gp' in map_free, so
> maybe_wait_bpf_programs() is racy as you pointed out.
> bpf_map_put() will drop refcnt of inner map and it might proceed into
> bpf_map_free_deferred()->*_map_free() while bpf prog is still observing
> a pointer to that map.
>
> We need to adjust a comment in maybe_wait_bpf_programs() to say
> it will only wait for non-sleepable bpf progs.
> Sleepable might still see 'old' inner map after syscall map_delete
> returns to user space.

Could we make update/deletion operation from bpf_syscall_bpf helper
being a special case and don't call synchronize_rcu_tasks_trace() in
maybe_wait_bpf_programs(), but does synchronize_rcu_tasks_trace() for
all other cases ?
>
>
>>>> +    acc_ctx = atomic_read(&map->may_be_accessed_prog_ctx) & BPF_MAP_ACC_PROG_CTX_MASK;
>>>> +    if (acc_ctx) {
>>>> +            if (acc_ctx == BPF_MAP_ACC_NORMAL_PROG_CTX)
>>>> +                    synchronize_rcu();
>>>> +            else if (acc_ctx == BPF_MAP_ACC_SLEEPABLE_PROG_CTX)
>>>> +                    synchronize_rcu_tasks_trace();
>>>> +            else
>>>> +                    synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
>>> and this patch 4 goes to far.
>>> Could you add sleepable_refcnt in addition to existing refcnt that is incremented
>>> in outer map when it's used by sleepable prog and when sleepable_refcnt > 0
>>> the caller of bpf_map_free_deferred sets free_after_mult_rcu_gp.
>>> (which should be renamed to free_after_tasks_rcu_gp).
>>> Patch 3 is simpler and patch 4 is simple too.
>>> No need for atomic_or games.
>>>
>>> In addition I'd like to see an extra patch that demonstrates this UAF
>>> when update/delete is done by syscall bpf prog type.
>>> The test case in patch 5 is doing update/delete from user space.
>> Do you mean update/delete operations on outer map, right ? Because in
>> patch 5, inner map is updated from bpf program instead of user space.
> patch 5 does:
> bpf_map_update_elem(inner_map,...
>
> That's only to trigger UAF.
> We need a test that does bpf_map_update_elem(outer_map,...
> from sleepable bpf prog to make sure we do _not_ have a code in
> the kernel that synchronously waits for RCU tasks trace GP at that time.

I think we already have such test case in prog_tests/map_ptr.c. In
map_ptr.c, it will use light skeleton to setup the map-in-map defined in
progs/map_ptr_kern.c. I got the dead-lock when trying to do
synchronize_rcu_tasks_trace() in bpf_map_fd_put_ptr(). But I could add a
explicit one.
> So, you're correct, maybe_wait_bpf_programs() is not sufficient any more,
> but we cannot delete it, since it addresses user space assumptions
> on what bpf progs see when the inner map is replaced.
>
> I still don't like atomic_or() logic and masks.
> Why not to have sleepable_refcnt and
> if (sleepable_refcnt > 0)
>   synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
> else
>   synchronize_rcu();

I think the main reason is that there is four possible case for the free
of inner map:
(1) neither call synchronize_rcu() nor synchronize_rcu_tasks_trace()
It is true when the outer map is only being accessed in user space.
(2) only call synchronize_rcu()
the outer map is only being accessed by non-sleepable bpf program
(3) only call synchronize_rcu_tasks_trace
the outer map is only being accessed by sleepable bpf program
(4) call both synchronize_rcu() and synchronize_rcu_tasks_trace()

Only using sleepable_refcnt can not express 4 possible cases and we also
need to atomically copy the states from outer map to inner map, because
one inner map may be used concurrently by multiple outer map, so atomic
or mask are chosen.



