Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367D5A73C2
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 04:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiHaCFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiHaCFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 22:05:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EC13F8C
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 19:05:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MHSBc1Xp4z6S3h1
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:03:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgAX5SjHwQ5jXt2dAA--.55238S2;
        Wed, 31 Aug 2022 10:04:59 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Use this_cpu_{inc|dec|inc_return} for
 bpf_task_storage_busy
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220829142752.330094-1-houtao@huaweicloud.com>
 <20220829142752.330094-2-houtao@huaweicloud.com>
 <20220830005228.xc7nhufvx4oetel3@kafai-mbp.dhcp.thefacebook.com>
 <a0e8ef04-fb9c-1245-9aff-c5aa8520add8@huaweicloud.com>
 <20220831004155.u2ek3edpdwls6o2w@kafai-mbp.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <da8cd984-d14e-55c2-8499-53366a3ad735@huaweicloud.com>
Date:   Wed, 31 Aug 2022 10:04:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220831004155.u2ek3edpdwls6o2w@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgAX5SjHwQ5jXt2dAA--.55238S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw18WFy3KFWkXF1fJF4fKrg_yoW5Gr4Upr
        WxKFWUJryDGwnayr1Dtr48Zry5tw4DG34xX395tFy8Aa1DJFy2vr1Iq3s09ryfZr4Fqa4f
        ZF4qqa43ur1xXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/31/2022 8:41 AM, Martin KaFai Lau wrote:
> On Tue, Aug 30, 2022 at 10:21:30AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 8/30/2022 8:52 AM, Martin KaFai Lau wrote:
>>> On Mon, Aug 29, 2022 at 10:27:50PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Now migrate_disable() does not disable preemption and under some
>>>> architecture (e.g. arm64) __this_cpu_{inc|dec|inc_return} are neither
>>>> preemption-safe nor IRQ-safe, so the concurrent lookups or updates on
>>>> the same task local storage and the same CPU may make
>>>> bpf_task_storage_busy be imbalanced, and bpf_task_storage_trylock()
>>>> will always fail.
>>>>
>>>> Fixing it by using this_cpu_{inc|dec|inc_return} when manipulating
>>>> bpf_task_storage_busy.
>> SNIP
>>>>  static bool bpf_task_storage_trylock(void)
>>>>  {
>>>>  	migrate_disable();
>>>> -	if (unlikely(__this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
>>>> -		__this_cpu_dec(bpf_task_storage_busy);
>>>> +	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
>>>> +		this_cpu_dec(bpf_task_storage_busy);
>>> This change is only needed here but not in the htab fix [0]
>>> or you are planning to address it separately ?
>>>
>>> [0]: https://lore.kernel.org/bpf/20220829023709.1958204-2-houtao@huaweicloud.com/
>>> .
>> For htab_lock_bucket() in hash-table, in theory there will be problem as shown
>> below, but I can not reproduce it on ARM64 host:
>>
>> *p = 0
>>
>> // process A
>> r0 = *p
>> r0 += 1
>>             // process B
>>             r1 = *p
>> // *p = 1
>> *p = r0
>>             r1 += 1
>>             // *p = 1
>>             *p = r1
>>
>> // r0 = 1
>> r0 = *p
>>             // r1 = 1
>>             r1 = *p
>>
>> In hash table fixes, migrate_disable() in htab_lock_bucket()  is replaced by
>> preempt_disable(), so the above case will be impossible. And if process A is
>> preempted by IRQ, __this_cpu_inc_return will be OK.
> hmm... iiuc, it is fine for the preempted by IRQ case because the
> operations won't be interleaved as the process A/B example above?
> That should also be true for the task-storage case here,
> meaning only CONFIG_PREEMPT can reproduce it?  If that is the
> case, please also mention that in the commit message.
> .
Yes. There will be no interleave if it is preempted by IRQ and it is also true
for task-storage case. CONFIG_PREEMPT can reproduce and in theory
CONFIG_PREEMPT_RT is also possible. Will add that in commit message.


