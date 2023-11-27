Return-Path: <bpf+bounces-15874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5F7F9723
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 02:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99826B20A71
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455BEC4;
	Mon, 27 Nov 2023 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAAE10F
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 17:25:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SdnvB0M3Fz4f3l13
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:24:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 72B521A0273
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:24:58 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCnS0rk72NlEERrCA--.10212S2;
	Mon, 27 Nov 2023 09:24:56 +0800 (CST)
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231124113033.503338-1-houtao@huaweicloud.com>
 <20231124113033.503338-5-houtao@huaweicloud.com>
 <03909d48-646d-4d71-b7bd-0b7510b0bd4f@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e17eb2fc-9678-9d5f-bdca-eb2322304900@huaweicloud.com>
Date: Mon, 27 Nov 2023 09:24:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <03909d48-646d-4d71-b7bd-0b7510b0bd4f@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCnS0rk72NlEERrCA--.10212S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWkXw1kXry7Gr4UWFW8tFb_yoW3WryfpF
	4kKrWUGrWUXr1kJryUJw1UXFyUJw4rJ3WDG3W8Xa4UAr4UGryjqr1UWFWqgrn8Jr4kJr4j
	yr1jqry7u347ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Yonghong,

On 11/26/2023 3:13 PM, Yonghong Song wrote:
>
> On 11/24/23 6:30 AM, Hou Tao wrote:
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
>> ---
>>   include/linux/bpf.h     |  8 +++++++-
>>   kernel/bpf/map_in_map.c | 19 ++++++++++++++-----
>>   kernel/bpf/syscall.c    | 15 +++++++++++++--
>>   kernel/bpf/verifier.c   |  4 ++++
>>   4 files changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 15a6bb951b70..c5b549f352d7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -245,6 +245,11 @@ struct bpf_list_node_kern {
>>       void *owner;
>>   } __attribute__((aligned(8)));
>>   +enum {
>> +    BPF_MAP_RCU_GP = BIT(0),
>> +    BPF_MAP_RCU_TT_GP = BIT(1),
>> +};
>> +
>>   struct bpf_map {
>>       /* The first two cachelines with read-mostly members of which some
>>        * are also accessed in fast-path (e.g. ops, max_entries).
>> @@ -296,7 +301,8 @@ struct bpf_map {
>>       } owner;
>>       bool bypass_spec_v1;
>>       bool frozen; /* write-once; write-protected by freeze_mutex */
>> -    bool free_after_mult_rcu_gp;
>> +    atomic_t used_in_rcu_gp;
>> +    atomic_t free_by_rcu_gp;
>>       s64 __percpu *elem_count;
>>   };
>>   diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
>> index cf3363065566..d044ee677107 100644
>> --- a/kernel/bpf/map_in_map.c
>> +++ b/kernel/bpf/map_in_map.c
>> @@ -131,12 +131,21 @@ void bpf_map_fd_put_ptr(struct bpf_map *map,
>> void *ptr, bool deferred)
>>   {
>>       struct bpf_map *inner_map = ptr;
>>   -    /* The inner map may still be used by both non-sleepable and
>> sleepable
>> -     * bpf program, so free it after one RCU grace period and one tasks
>> -     * trace RCU grace period.
>> +    /* Defer the freeing of inner map according to the attribute of bpf
>> +     * program which owns the outer map, so unnecessary multiple RCU GP
>> +     * waitings can be avoided.
>>        */
>> -    if (deferred)
>> -        WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
>> +    if (deferred) {
>> +        /* used_in_rcu_gp may be updated concurrently by new bpf
>> +         * program, so add smp_mb() to guarantee the order between
>> +         * used_in_rcu_gp and lookup/deletion operation of inner map.
>> +         * If a new bpf program finds the inner map before it is
>> +         * removed from outer map, reading used_in_rcu_gp below will
>> +         * return the newly-set bit set by the new bpf program.
>> +         */
>> +        smp_mb();
>
> smp_mb__before_atomic()?

The memory barrier is used for atomic_read() instead of atomic_or(), so
I think smp_mb() is appropriate.

>> +        atomic_or(atomic_read(&map->used_in_rcu_gp),
>> &inner_map->free_by_rcu_gp);
>> +    }
>>       bpf_map_put(inner_map);
>>   }
>>   diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 88882cb58121..014a8cd55a41 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -734,7 +734,10 @@ static void bpf_map_free_rcu_gp(struct rcu_head
>> *rcu)
>>     static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
>>   {
>> -    if (rcu_trace_implies_rcu_gp())
>> +    struct bpf_map *map = container_of(rcu, struct bpf_map, rcu);
>> +
>> +    if (!(atomic_read(&map->free_by_rcu_gp) & BPF_MAP_RCU_GP) ||
>> +        rcu_trace_implies_rcu_gp())
>>           bpf_map_free_rcu_gp(rcu);
>>       else
>>           call_rcu(rcu, bpf_map_free_rcu_gp);
>> @@ -746,11 +749,16 @@ static void bpf_map_free_mult_rcu_gp(struct
>> rcu_head *rcu)
>>   void bpf_map_put(struct bpf_map *map)
>>   {
>>       if (atomic64_dec_and_test(&map->refcnt)) {
>> +        int free_by_rcu_gp;
>> +
>>           /* bpf_map_free_id() must be called first */
>>           bpf_map_free_id(map);
>>           btf_put(map->btf);
>>   -        if (READ_ONCE(map->free_after_mult_rcu_gp))
>> +        free_by_rcu_gp = atomic_read(&map->free_by_rcu_gp);
>> +        if (free_by_rcu_gp == BPF_MAP_RCU_GP)
>> +            call_rcu(&map->rcu, bpf_map_free_rcu_gp);
>> +        else if (free_by_rcu_gp)
>>               call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
>>           else
>>               bpf_map_free_in_work(map);
>> @@ -5343,6 +5351,9 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>>           goto out_unlock;
>>       }
>>   +    /* No need to update used_in_rcu_gp, because the bpf program
>> doesn't
>> +     * access the map.
>> +     */
>>       memcpy(used_maps_new, used_maps_old,
>>              sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
>>       used_maps_new[prog->aux->used_map_cnt] = map;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6da370a047fe..3b86c02077f1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18051,6 +18051,10 @@ static int resolve_pseudo_ldimm64(struct
>> bpf_verifier_env *env)
>>                   return -E2BIG;
>>               }
>>   +            atomic_or(env->prog->aux->sleepable ?
>> BPF_MAP_RCU_TT_GP : BPF_MAP_RCU_GP,
>> +                  &map->used_in_rcu_gp);
>> +            /* Pairs with smp_mb() in bpf_map_fd_put_ptr() */
>> +            smp_mb__before_atomic();
>
> smp_mb__after_atomic()?

smp_mb__after_atomic() is better because it doesn't depend on the
implementation of bpf_map_inc() below. Will use it in next version.
>
> Just curious, are two smp_mb*() memory barriers in this patch truely
> necessary or just
> want to be cautious?

Martin had asked me the same question in [1]. The reason for these two
memory barrier is just want to be cautious.

[1]:
https://lore.kernel.org/bpf/467cd7b0-9b41-4db5-9646-9b044db14bf0@linux.dev/
>
>>               /* hold the map. If the program is rejected by verifier,
>>                * the map will be released by release_maps() or it
>>                * will be used by the valid program until it's unloaded


