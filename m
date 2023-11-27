Return-Path: <bpf+bounces-15881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5C7F979C
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2479B20AA3
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9917E3;
	Mon, 27 Nov 2023 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B6E3
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 18:47:45 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sdqkg72xFz4f3l6f
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:47:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CD8901A0C36
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:47:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCn9gxJA2RlzsAuCA--.5476S2;
	Mon, 27 Nov 2023 10:47:41 +0800 (CST)
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231124113033.503338-1-houtao@huaweicloud.com>
 <20231124113033.503338-5-houtao@huaweicloud.com>
 <CAADnVQJ8_QcisYsRVD1cz8PDHvDHzrtdHwmG21jCWogvaBQ9Lw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8609c9fc-5ca6-7884-2444-52a2d2650d74@huaweicloud.com>
Date: Mon, 27 Nov 2023 10:47:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ8_QcisYsRVD1cz8PDHvDHzrtdHwmG21jCWogvaBQ9Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCn9gxJA2RlzsAuCA--.5476S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWkuF17Jry5CFyrJFW7CFg_yoW7Cr1xpF
	W8KryUGryDJr10yw1DJw17Xry8Jr45J34UJF1rGFyUAr15Gryjqr10qFWj9ry5Jr4kJw4j
	qr15JryUZF1DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Alexei,

On 11/27/2023 9:49 AM, Alexei Starovoitov wrote:
> On Fri, Nov 24, 2023 at 3:29 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When removing the inner map from the outer map, the inner map will be
>> freed after one RCU grace period and one RCU tasks trace grace
>> period, so it is certain that the bpf program, which may access the
>> inner map, has exited before the inner map is freed.
>>
>> However there is unnecessary to wait for any RCU grace period, one RCU
>> grace period or one RCU tasks trace grace period if the outer map is
>> only accessed by userspace, sleepable program or non-sleepable program.
>> So recording the sleepable attributes of the owned bpf programs when
>> adding the outer map into env->used_maps, copying the recorded
>> attributes to inner map atomically when removing inner map from the
>> outer map and using the recorded attributes in the inner map to decide
>> which, and how many, RCU grace periods are needed when freeing the
>> inner map.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>
>> +       if (deferred) {
>> +               /* used_in_rcu_gp may be updated concurrently by new bpf
>> +                * program, so add smp_mb() to guarantee the order between
>> +                * used_in_rcu_gp and lookup/deletion operation of inner map.
>> +                * If a new bpf program finds the inner map before it is
>> +                * removed from outer map, reading used_in_rcu_gp below will
>> +                * return the newly-set bit set by the new bpf program.
>> +                */
>> +               smp_mb();
>> +               atomic_or(atomic_read(&map->used_in_rcu_gp), &inner_map->free_by_rcu_gp);
> You resent the patches before I had time to reply to the previous thread...

I didn't receive the reply from last Thursday,  so I though there is no
new suggestions from you and sent out v3 which incorporate suggestions
from Martin. I will ping next time before sending out new version if
there is still pending discussion about the posted patch-set.
>
>> I think the main reason is that there is four possible case for the free
>> of inner map:
>> (1) neither call synchronize_rcu() nor synchronize_rcu_tasks_trace()
>> It is true when the outer map is only being accessed in user space.
>> (2) only call synchronize_rcu()
>> the outer map is only being accessed by non-sleepable bpf program
>> (3) only call synchronize_rcu_tasks_trace
>> the outer map is only being accessed by sleepable bpf program
>> (4) call both synchronize_rcu() and synchronize_rcu_tasks_trace()
>>
>> Only using sleepable_refcnt can not express 4 possible cases and we also
>> need to atomically copy the states from outer map to inner map, because
>> one inner map may be used concurrently by multiple outer map, so atomic
>> or mask are chosen.
> We don't care about optimizing 1, since it's rare case.
> We also don't care about optimizing 3, since sync_rcu time is negligible
> when we need to wait for sync_rcu_tasks_trace and also
> because rcu_trace_implies_rcu_gp() for foreseeable future.

I see.
>
>> need to atomically
> we do NOT have such need.

Here the atomicity means that multiple updates to
inner_map->free_in_rcu_gp should not overwrite each other and it has
nothing to do with the memory barrier. And using spin_lock will serve
the same purpose.
> There is zero need to do this atomic games and barries "just want to
> be cautious". The code should not have any code at all "to be
> cautious".
> Every barrier has to be a real reason behind it.
> Please remove them.

Will remove the memory barrier. I think we can add it later if it is needed.
> The concurent access to refcnt and sleepable_refcnt can be serialized
> with simple spin_lock.

OK.
>
> I also don't like
>> +       BPF_MAP_RCU_GP = BIT(0),
>> +       BPF_MAP_RCU_TT_GP = BIT(1),
> the names should not describe what action should be taken.
> The names should describe what the bits do.

Understood.
> I still think sleepable_refcnt and refcnt is more than enough to
> optimize patch 3.

Before posting v4,  do the following code-snippets match your suggestions ?

resolve_pseudo_ldimm64()
                        if (env->prog->aux->sleepable)
                               /* The max number of program is INT_MAX -
1, so atomic_t will be enough */
                                atomic_inc(&map->sleepable_refcnt);

bpf_map_fd_put_ptr()
        if (deferred) {
                if (atomic_read(&map->sleepable_refcnt))
                        WRITE_ONCE(map->free_after_tt_rcu_gp, true);
                else
                        WRITE_ONCE(map->free_after_rcu_gp, true);
        }

bpf_map_put()
                if (READ_ONCE(map->free_after_tt_rcu_gp))
                        call_rcu_tasks_trace(&map->rcu,
bpf_map_free_mult_rcu_gp);
                else if (READ_ONCE(map->free_after_rcu_gp))
                        call_rcu(&map->rcu, bpf_map_free_rcu_gp);
                else
                        bpf_map_free_in_work(map);

And are you OK with using call_rcu()/call_rcu_tasks_trace() instead of
synchronize_rcu()/synchronize_rcu_mult() ?


