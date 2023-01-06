Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630B465F998
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAFCgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 21:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFCgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 21:36:07 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3D1147D;
        Thu,  5 Jan 2023 18:36:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Np6s95nHBz4f3wYG;
        Fri,  6 Jan 2023 10:35:57 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP3 (Coremail) with SMTP id _Ch0CgA3MR8Nibdj+7tMBA--.38173S2;
        Fri, 06 Jan 2023 10:35:58 +0800 (CST)
Message-ID: <1c35ce46-27ff-f311-44f5-b3add388c045@huaweicloud.com>
Date:   Fri, 6 Jan 2023 10:35:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH RESEND bpf-next 1/4] bpf: Rollback to text_poke when
 arch not supported ftrace direct call
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <20221220021319.1655871-2-pulehui@huaweicloud.com>
 <a2bf7ed9-4977-608c-d5a5-8ee6a520cf52@huawei.com>
 <0039743b-5837-c0d3-7574-7719698f9dc1@huaweicloud.com>
 <87k023u8kp.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87k023u8kp.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA3MR8Nibdj+7tMBA--.38173S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15ZF43ZrWrJF17CryrCrg_yoW5ur1fpF
        WrC3W5u3yUXr1kWFnFq3W8XFyjy3ykJ34DGr4UJa4rWa9agr9FgF4jqr1Fgryvyrs5WFy2
        yF1Yqr9IvFyDZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/1/3 20:05, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> On 2022/12/20 10:32, Xu Kuohai wrote:
>>> On 12/20/2022 10:13 AM, Pu Lehui wrote:
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> The current bpf trampoline attach to kernel functions via ftrace direct
>>>> call API, while text_poke is applied for bpf2bpf attach and tail call
>>>> optimization. For architectures that do not support ftrace direct call,
>>>> text_poke is still able to attach bpf trampoline to kernel functions.
>>>> Let's relax it by rollback to text_poke when architecture not supported.
>>>>
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>> ---
>>>>    kernel/bpf/trampoline.c | 8 ++------
>>>>    1 file changed, 2 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>>>> index d6395215b849..386197a7952c 100644
>>>> --- a/kernel/bpf/trampoline.c
>>>> +++ b/kernel/bpf/trampoline.c
>>>> @@ -228,15 +228,11 @@ static int modify_fentry(struct bpf_trampoline
>>>> *tr, void *old_addr, void *new_ad
>>>>    static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>>>>    {
>>>>        void *ip = tr->func.addr;
>>>> -    unsigned long faddr;
>>>>        int ret;
>>>> -    faddr = ftrace_location((unsigned long)ip);
>>>> -    if (faddr) {
>>>> -        if (!tr->fops)
>>>> -            return -ENOTSUPP;
>>>> +    if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) &&
>>>> +        !!ftrace_location((unsigned long)ip))
>>>>            tr->func.ftrace_managed = true;
>>>> -    }
>>>>
>>>
>>> After this patch, a kernel function with true trace_location will be
>>> patched
>>> by bpf when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is disabled, which
>>> means
>>> that a kernel function may be patched by both bpf and ftrace in a mutually
>>> unaware way. This will cause ftrace and bpf_arch_text_poke to fail in a
>>> somewhat random way if the function to be patched was already patched
>>> by the other.
>>
>> Thanks for your review. And yes, this is a backward compatible solution
>> for architectures that not support DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> 
> It's not "backward compatible". Reiterating what Kuohai said; The BPF
> trampoline must be aware of ftrace's state -- with this patch, the
> trampoline can't blindly poke the text managed my ftrace.
> 
> I'd recommend to remove this patch from the series.
> 

After deep consideration, Kuohai's catching is much more reasonable. 
Will remove it in the next.

In the meantime, I found that song and guoren have worked on supporting 
riscv ftrace with direct call [0], so we can concentrate on making 
bpf_arch_text_poke specifically for the bpf context.

However, riscv ftrace base framework will change because [0] uses t0 as 
the link register of traced function. We should consider the generality 
of riscv bpf trampoline for kernel function and bpf context. It's not 
clear if [0] will be upstreamed, so maybe we should wait for it?

[0] 
https://lore.kernel.org/linux-riscv/20221208091244.203407-7-guoren@kernel.org

Anyway, thanks both of you for the review.

> 
> Björn

