Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76A59B743
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiHVB1f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 21:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHVB1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 21:27:35 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1322126F
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 18:27:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M9vnf4mHZzKy7C
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 09:25:58 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDn0b1_2wJj03O1Ag--.64785S2;
        Mon, 22 Aug 2022 09:27:31 +0800 (CST)
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
 <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
Date:   Mon, 22 Aug 2022 09:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDn0b1_2wJj03O1Ag--.64785S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw45Gr4xGF1xGryfWw4xtFb_yoWrCry7pF
        W8GFWFkF48XF9a939Fqr1Iqr4Yyw47K3yIy3ykKa43ZrWDZr1fur1xtF1SvF1vvrnrAr1S
        vr4IqayYk348AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
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

Hi,

On 8/22/2022 12:42 AM, Hao Luo wrote:
> Hi Hou Tao,
>
> On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
>> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
>> Make migrate_disable/enable() independent of RT"), migrations_disable()
>> is also preemptible under !PREEMPT_RT case, so now map_locked also
>> disallows concurrent updates from normal contexts (e.g. userspace
>> processes) unexpectedly as shown below:
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
>> so still use migrate_disable() for spin-lock case.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
> IIUC, this patch enlarges the scope of preemption disable to cover inc
> map_locked. But I don't think the change is meaningful.
Before 74d862b682f51 ("sched: Make migrate_disable/enable() independent of
RT"),  the preemption is disabled before increasing map_locked for !PREEMPT_RT
case, so I don't think that the change is meaningless.
>
> This patch only affects the case when raw lock is used. In the case of
> raw lock, irq is disabled for b->raw_lock protected critical section.
> A raw spin lock itself doesn't block in both RT and non-RT. So, my
> understanding about this patch is, it just makes sure preemption
> doesn't happen on the exact __this_cpu_inc_return. But the window is
> so small that it should be really unlikely to happen.
No, it can be easily reproduced by running multiple htab update processes in the
same CPU. Will add selftest to demonstrate that.
>
>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 6c530a5e560a..ad09da139589 100644
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

