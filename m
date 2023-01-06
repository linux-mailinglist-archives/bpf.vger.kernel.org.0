Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7565FA87
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 04:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAFD7d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 22:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAFD7c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 22:59:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95C6B59A;
        Thu,  5 Jan 2023 19:59:31 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Np8gr2DzdznTlx;
        Fri,  6 Jan 2023 11:58:00 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 11:59:27 +0800
Message-ID: <b2d4c8d9-8852-ddfe-f83b-dd5cedf05ca4@huawei.com>
Date:   Fri, 6 Jan 2023 11:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH RESEND bpf-next 3/4] riscv, bpf: Add
 bpf_arch_text_poke support for RV64
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
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
        Albert Ou <aou@eecs.berkeley.edu>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <20221220021319.1655871-4-pulehui@huaweicloud.com>
 <871qobqyh9.fsf@all.your.base.are.belong.to.us>
 <755a5b80-f916-7383-6746-3e202224dfcc@huaweicloud.com>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <755a5b80-f916-7383-6746-3e202224dfcc@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/1/6 9:57, Pu Lehui wrote:
> 
> 
> On 2023/1/4 2:12, Björn Töpel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Implement bpf_arch_text_poke for RV64. For call scenario,
>>> ftrace framework reserve 4 nops for RV64 kernel function
>>> as function entry, and use auipc+jalr instructions to call
>>> kernel or module functions. However, since the auipc+jalr
>>> call instructions is non-atomic operation, we need to use
>>> stop-machine to make sure instruction patching in atomic
>>> context. As for jump scenario, since we only jump inside
>>> the trampoline, a jal instruction is sufficient.
>>
>> Hmm, is that really true? More below!
>>
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>>   arch/riscv/net/bpf_jit.h        |   5 ++
>>>   arch/riscv/net/bpf_jit_comp64.c | 131 +++++++++++++++++++++++++++++++-
>>>   2 files changed, 134 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>> index d926e0f7ef57..bf9802a63061 100644
>>> --- a/arch/riscv/net/bpf_jit.h
>>> +++ b/arch/riscv/net/bpf_jit.h
>>> @@ -573,6 +573,11 @@ static inline u32 rv_fence(u8 pred, u8 succ)
>>>       return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
>>>   }
>>> +static inline u32 rv_nop(void)
>>> +{
>>> +    return rv_i_insn(0, 0, 0, 0, 0x13);
>>> +}
>>> +
>>>   /* RVC instrutions. */
>>>   static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c 
>>> b/arch/riscv/net/bpf_jit_comp64.c
>>> index bf4721a99a09..fa8b03c52463 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>> @@ -8,6 +8,8 @@
>>>   #include <linux/bitfield.h>
>>>   #include <linux/bpf.h>
>>>   #include <linux/filter.h>
>>> +#include <linux/memory.h>
>>> +#include <linux/stop_machine.h>
>>>   #include "bpf_jit.h"
>>>   #define RV_REG_TCC RV_REG_A6
>>> @@ -238,7 +240,7 @@ static void __build_epilogue(bool is_tail_call, 
>>> struct rv_jit_context *ctx)
>>>       if (!is_tail_call)
>>>           emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>>>       emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
>>> -          is_tail_call ? 4 : 0, /* skip TCC init */
>>> +          is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
>>>             ctx);
>>>   }
>>> @@ -615,6 +617,127 @@ static int add_exception_handler(const struct 
>>> bpf_insn *insn,
>>>       return 0;
>>>   }
>>> +struct text_poke_args {
>>> +    void *addr;
>>> +    const void *insns;
>>> +    size_t len;
>>> +    atomic_t cpu_count;
>>> +};
>>> +
>>> +static int do_text_poke(void *data)
>>> +{
>>> +    int ret = 0;
>>> +    struct text_poke_args *patch = data;
>>> +
>>> +    if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>>> +        ret = patch_text_nosync(patch->addr, patch->insns, patch->len);
>>> +        atomic_inc(&patch->cpu_count);
>>> +    } else {
>>> +        while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>>> +            cpu_relax();
>>> +        smp_mb();
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int bpf_text_poke_stop_machine(void *addr, const void *insns, 
>>> size_t len)
>>> +{
>>> +    struct text_poke_args patch = {
>>> +        .addr = addr,
>>> +        .insns = insns,
>>> +        .len = len,
>>> +        .cpu_count = ATOMIC_INIT(0),
>>> +    };
>>> +
>>> +    return stop_machine(do_text_poke, &patch, cpu_online_mask);
>>> +}
>>> +
>>> +static int gen_call_or_nops(void *target, void *ip, u32 *insns)
>>> +{
>>> +    int i, ret;
>>> +    s64 rvoff;
>>> +    struct rv_jit_context ctx;
>>> +
>>> +    ctx.ninsns = 0;
>>> +    ctx.insns = (u16 *)insns;
>>> +
>>> +    if (!target) {
>>> +        for (i = 0; i < 4; i++)
>>> +            emit(rv_nop(), &ctx);
>>> +        return 0;
>>> +    }
>>> +
>>> +    rvoff = (s64)(target - ip);
>>> +    emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
>>> +    ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
>>> +    if (ret)
>>> +        return ret;
>>> +    emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
>>> +
>>> +    return 0;
>>> +
>>> +}
>>> +
>>> +static int bpf_text_poke_call(void *ip, void *old_addr, void *new_addr)
>>> +{
>>> +    int ret;
>>> +    u32 old_insns[4], new_insns[4];
>>> +
>>> +    ret = gen_call_or_nops(old_addr, ip + 4, old_insns);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = gen_call_or_nops(new_addr, ip + 4, new_insns);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    mutex_lock(&text_mutex);
>>> +    if (memcmp(ip, old_insns, sizeof(old_insns))) {
>>> +        ret = -EFAULT;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (memcmp(ip, new_insns, sizeof(new_insns)))
>>> +        ret = bpf_text_poke_stop_machine(ip, new_insns,
>>> sizeof(new_insns));
>>
>> I'd rather see that you added a patch_text variant to
>> arch/riscv/kernel/patch.c (something like your
>> bpf_text_poke_stop_machine()), and use that here. Might be other users
>> of that as well -- Andy's ftrace patch maybe? :-)
>>
> 
> Good idea.
> 
>>> +out:
>>> +    mutex_unlock(&text_mutex);
>>> +    return ret;
>>> +}
>>> +
>>> +static int bpf_text_poke_jump(void *ip, void *old_addr, void *new_addr)
>>> +{
>>> +    int ret;
>>> +    u32 old_insn, new_insn;
>>> +
>>> +    old_insn = old_addr ? rv_jal(RV_REG_ZERO, (s64)(old_addr - ip) 
>>> >> 1) : rv_nop();
>>> +    new_insn = new_addr ? rv_jal(RV_REG_ZERO, (s64)(new_addr - ip) 
>>> >> 1) : rv_nop();
>>> +
>>> +    mutex_lock(&text_mutex);
>>> +    if (memcmp(ip, &old_insn, sizeof(old_insn))) {
>>> +        ret = -EFAULT;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (memcmp(ip, &new_insn, sizeof(new_insn)))
>>> +        ret = patch_text_nosync(ip, &new_insn, sizeof(new_insn));
>>> +out:
>>> +    mutex_unlock(&text_mutex);
>>> +    return ret;
>>> +}
>>> +
>>> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>>> +               void *old_addr, void *new_addr)
>>
>> AFAIU there's nothing in the bpf_arch_text_poke() API that say that
>> BPF_MOD_JUMP is jumps within the trampoline. That is one usage, but not
>> the only one. In general, the jal might not have enough reach.
>>
>> I believe that this needs to be an auipc/jalr pair similar to
>> BPF_MOD_CALL (w/o linked register).
>>
> 
> The initial idea was that currently BPF_MOD_JUMP only serves for

small nit，the current riscv BPF_MOD_JUMP

> bpf_tramp_image_put, and jal, which range is +/- 1MB, is sufficient for 
> the distance between im->ip_after_call and im->ip_epilogue, and try to 
> not use not-atomic auipc/jalr pair. But take deep consideration, this 
> might be extended to other uses, such as tailcall optimization. So agree 
> with your suggestion.
> 
>>
>> And again, thanks for working on the RV trampoline!
>> Björn
> 
