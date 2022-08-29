Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3146E5A4093
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 03:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH2BQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 21:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiH2BQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 21:16:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6E240BD
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 18:16:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGCCj73SNzKGGp
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 09:14:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDXWy9yEwxjtIRFAA--.25879S2;
        Mon, 29 Aug 2022 09:16:36 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Disable preemption when increasing
 per-cpu map_locked
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220827100134.1621137-1-houtao@huaweicloud.com>
 <CACYkzJ779M1q4ffgJ01zMrTKJVqd9qGhc-CBT_aB=Pj9HONVXw@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <bd60ef93-1c6a-2db2-557d-b09b92ad22bd@huaweicloud.com>
Date:   Mon, 29 Aug 2022 09:16:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACYkzJ779M1q4ffgJ01zMrTKJVqd9qGhc-CBT_aB=Pj9HONVXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDXWy9yEwxjtIRFAA--.25879S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4fZr1UZF4kZr4xur4rXwb_yoWrCF43pF
        48GFWFkF4UXFyv939Fqr4Iqr15tw47K3yIy3ykGFW3ZrZ8Xrn3ur1xtF1SvF10vrnIyr4S
        vF42qw4Yyr18AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/2022 6:39 AM, KP Singh wrote:
> On Sat, Aug 27, 2022 at 11:43 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
>> from both NMI and non-NMI contexts. But since commit 74d862b682f5
>> ("sched: Make migrate_disable/enable() independent of RT"),
>> migrations_disable() is also preemptible under CONFIG_PREEMPT case,
> nit: migrate_disable
Will fix in v3.
>
>> so now map_locked also disallows concurrent updates from normal contexts
>> (e.g. userspace processes) unexpectedly as shown below:
>>
>> process A                      process B
>>
>> htab_map_update_elem()
>>   htab_lock_bucket()
>>     migrate_disable()
>>     /* return 1 */
>>     __this_cpu_inc_return()
>>     /* preempted by B */
>>
>>                                htab_map_update_elem()
>>                                  /* the same bucket as A */
>>                                  htab_lock_bucket()
>>                                    migrate_disable()
>>                                    /* return 2, so lock fails */
>>                                    __this_cpu_inc_return()
>>                                    return -EBUSY
>>
>> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
>> only checking the value of map_locked for nmi context. But it will
>> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
>> through non-tracing program (e.g. fentry program).
>>
>> So fixing it by using disable_preempt() instead of migrate_disable() when
>> increasing htab->map_locked. However when htab_use_raw_lock() is false,
>> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
>> so still use migrate_disable() for spin-lock case and leave the
>> concurrent map updates problem to BPF memory allocator patchset in which
>> !htab_use_raw_lock() case will be removed.
> I think the description needs a bit more clarity and I think you mean
> preempt_disable() instead of  disable_preempt
>
> Suggestion:
>
> One cannot use preempt_disable() to fix this issue as htab_use_raw_lock
> being false causes the bucket lock to be a spin lock which can sleep and
> does not work with preempt_disable().
>
> Therefore, use migrate_disable() when using the spinlock instead of
> preempt_disable() and defer fixing concurrent updates to when the kernel
> has its own BPF memory allocator.
Will update the commit message in v3 and thanks for the suggestion.
>
>> Reviewed-by: Hao Luo <haoluo@google.com>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Fixes tag here please?
Will add "Fixes: 74d862b682f5 ("sched: Make migrate_disable/enable() independent
of RT")" in v3.
>
>
>> ---
>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index b301a63afa2f..6fb3b7fd1622 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>>                                    unsigned long *pflags)
>>  {
>>         unsigned long flags;
>> +       bool use_raw_lock;
>>
>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>>
>> -       migrate_disable();
>> +       use_raw_lock = htab_use_raw_lock(htab);
>> +       if (use_raw_lock)
>> +               preempt_disable();
>> +       else
>> +               migrate_disable();
>>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
>>                 __this_cpu_dec(*(htab->map_locked[hash]));
>> -               migrate_enable();
>> +               if (use_raw_lock)
>> +                       preempt_enable();
>> +               else
>> +                       migrate_enable();
>>                 return -EBUSY;
>>         }
>>
>> -       if (htab_use_raw_lock(htab))
>> +       if (use_raw_lock)
>>                 raw_spin_lock_irqsave(&b->raw_lock, flags);
>>         else
>>                 spin_lock_irqsave(&b->lock, flags);
>> @@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>>                                       struct bucket *b, u32 hash,
>>                                       unsigned long flags)
>>  {
>> +       bool use_raw_lock = htab_use_raw_lock(htab);
>> +
>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>> -       if (htab_use_raw_lock(htab))
>> +       if (use_raw_lock)
>>                 raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>>         else
>>                 spin_unlock_irqrestore(&b->lock, flags);
>>         __this_cpu_dec(*(htab->map_locked[hash]));
>> -       migrate_enable();
>> +       if (use_raw_lock)
>> +               preempt_enable();
>> +       else
>> +               migrate_enable();
>>  }
>>
>>  static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
>> --
>> 2.29.2
>>
> .

