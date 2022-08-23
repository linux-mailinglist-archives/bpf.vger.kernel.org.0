Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847159CECF
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 04:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiHWCy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 22:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiHWCy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 22:54:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBF5A820
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 19:54:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MBYgg7379zlkTv
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 10:53:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgDnOvhcQQRjjTXQAg--.53049S2;
        Tue, 23 Aug 2022 10:54:23 +0800 (CST)
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
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
 <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
 <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com>
 <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
 <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <fe3a8011-0aa6-86b9-768e-5f7be3de04de@huaweicloud.com>
Date:   Tue, 23 Aug 2022 10:54:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgDnOvhcQQRjjTXQAg--.53049S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWkGr4DZr1xZFyUZF43ZFb_yoW7CF13pr
        W8GFW0ya1UXFyj9w42qr10qr98tw17KryIqr1DG3yUAryDtw1xAr1xtF15ur10vr13Jr1I
        qr4UtrWakry8AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 8/23/2022 8:56 AM, Hao Luo wrote:
> On Mon, Aug 22, 2022 at 11:01 AM Hao Luo <haoluo@google.com> wrote:
>> On Mon, Aug 22, 2022 at 5:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 8/22/2022 11:21 AM, Hao Luo wrote:
>>>> Hi, Hou Tao
>>>>
>>>> On Sun, Aug 21, 2022 at 6:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On 8/22/2022 12:42 AM, Hao Luo wrote:
>>>>>> Hi Hou Tao,
>>>>>>
>>>>>> On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>>
>>>>>>> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
>>>>>>> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
>>>>>>> Make migrate_disable/enable() independent of RT"), migrations_disable()
>>>>>>> is also preemptible under !PREEMPT_RT case, so now map_locked also
>>>>>>> disallows concurrent updates from normal contexts (e.g. userspace
>>>>>>> processes) unexpectedly as shown below:
>>>>>>>
>>>>>>> process A                      process B
>>>>>>>
SNIP
>>>>>>> First please enable CONFIG_PREEMPT for the running kernel and then run the
>>>>>>> following test program as shown below.
>>>>>>>
>> Ah, fully preemptive kernel. It's worth mentioning that in the commit
>> message. Then it seems promoting migrate_disable to preempt_disable
>> may be the best way to solve the problem you described.
Sorry, i missed that. Will add in v2.
>>
>>> # sudo taskset -c 2 ./update.bin
>>> thread nr 2
>>> wait for error
>>> update error -16
>>> all threads exit
>>>
>>> If there is no "update error -16", you can try to create more map update
>>> threads. For example running 16 update threads:
>>>
>>> # sudo taskset -c 2 ./update.bin 16
>>> thread nr 16
>>> wait for error
>>> update error -16
>>> update error -16
>>> update error -16
>>> update error -16
>>> update error -16
>>> update error -16
>>> update error -16
>>> update error -16
>>> all threads exit
SNIP
> Tao, thanks very much for the test. I played it a bit and I can
> confirm that map_update failures are seen under CONFIG_PREEMPT. The
> failures are not present under CONFIG_PREEMPT_NONE or
> CONFIG_PREEMPT_VOLUNTARY. I experimented with a few alternatives I was
> thinking of and they didn't work. It looks like Hou Tao's idea,
> promoting migrate_disable to preempt_disable, is probably the best we
> can do for the non-RT case. So
>
> Reviewed-by: Hao Luo <haoluo@google.com>
>
> But, I am not sure if we want to get rid of preemption-caused batch
> map updates on preemptive kernels, or if there are better solutions to
> address [0].
Thanks for your review.
Under preemptive kernel, if the preemption is disabled during batch map lookup
or update, htab_lock_bucket() from userspace will not fail, so I think it is OK
for now.
>
> Tao, could you mention CONFIG_PREEMPT in your commit message? Thanks.
Will do.
>>>> Here is my theory, but please correct me if I'm wrong, I haven't
>>>> tested yet. In non-RT, I doubt preemptions are likely to happen after
>>>> migrate_disable. That is because very soon after migrate_disable, we
>>>> enter the critical section of b->raw_lock with irq disabled. In RT,
>>>> preemptions can happen on acquiring b->lock, that is certainly
>>>> possible, but this is the !use_raw_lock path, which isn't side-stepped
>>>> by this patch.
>>>>
>>>>>>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>>>>>>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>>>> index 6c530a5e560a..ad09da139589 100644
>>>>>>> --- a/kernel/bpf/hashtab.c
>>>>>>> +++ b/kernel/bpf/hashtab.c
>>>>>>> @@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>>>>>>>                                    unsigned long *pflags)
>>>>>>>  {
>>>>>>>         unsigned long flags;
>>>>>>> +       bool use_raw_lock;
>>>>>>>
>>>>>>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>>>>>>>
>>>>>>> -       migrate_disable();
>>>>>>> +       use_raw_lock = htab_use_raw_lock(htab);
>>>>>>> +       if (use_raw_lock)
>>>>>>> +               preempt_disable();
>>>>>>> +       else
>>>>>>> +               migrate_disable();
>>>>>>>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
>>>>>>>                 __this_cpu_dec(*(htab->map_locked[hash]));
>>>>>>> -               migrate_enable();
>>>>>>> +               if (use_raw_lock)
>>>>>>> +                       preempt_enable();
>>>>>>> +               else
>>>>>>> +                       migrate_enable();
>>>>>>>                 return -EBUSY;
>>>>>>>         }
>>>>>>>
>>>>>>> -       if (htab_use_raw_lock(htab))
>>>>>>> +       if (use_raw_lock)
>>>>>>>                 raw_spin_lock_irqsave(&b->raw_lock, flags);
>>>>>>>         else
>>>>>>>                 spin_lock_irqsave(&b->lock, flags);
>>>>>>> @@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>>>>>>>                                       struct bucket *b, u32 hash,
>>>>>>>                                       unsigned long flags)
>>>>>>>  {
>>>>>>> +       bool use_raw_lock = htab_use_raw_lock(htab);
>>>>>>> +
>>>>>>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>>>>>>> -       if (htab_use_raw_lock(htab))
>>>>>>> +       if (use_raw_lock)
>>>>>>>                 raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>>>>>>>         else
>>>>>>>                 spin_unlock_irqrestore(&b->lock, flags);
>>>>>>>         __this_cpu_dec(*(htab->map_locked[hash]));
>>>>>>> -       migrate_enable();
>>>>>>> +       if (use_raw_lock)
>>>>>>> +               preempt_enable();
>>>>>>> +       else
>>>>>>> +               migrate_enable();
>>>>>>>  }
>>>>>>>
>>>>>>>  static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
>>>>>>> --
>>>>>>> 2.29.2
>>>>>>>
>>>>>> .
>>>> .

