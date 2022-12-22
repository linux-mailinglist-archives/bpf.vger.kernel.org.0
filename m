Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF827653ADA
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLVDCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVDCG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 22:02:06 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422121266;
        Wed, 21 Dec 2022 19:02:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ncw851Zcvz4f3k6l;
        Thu, 22 Dec 2022 11:01:57 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP1 (Coremail) with SMTP id cCh0CgB35C6kyKNjHbIbAQ--.54629S2;
        Thu, 22 Dec 2022 11:01:58 +0800 (CST)
Message-ID: <403085d2-48c9-7691-1bdc-b2307521c0d7@huaweicloud.com>
Date:   Thu, 22 Dec 2022 11:01:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [RFC PATCH RESEND bpf-next 3/4] riscv, bpf: Add
 bpf_arch_text_poke support for RV64
To:     Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
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
 <20221220021319.1655871-4-pulehui@huaweicloud.com>
 <27a7b2ff-c0db-7fa0-2da0-8d76899f94f8@huawei.com>
Content-Language: en-US
In-Reply-To: <27a7b2ff-c0db-7fa0-2da0-8d76899f94f8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB35C6kyKNjHbIbAQ--.54629S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryxurWxAr1rAry7AryfCrg_yoWfJF1UpF
        1kKrW5GrWUXrn3Jr17tr4UXFyYyr4kX3WDJr18Xa18JFsFvr1vgr1jgrsIgrn8Cr48Gr1j
        vr1jgrnrurnrJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/12/20 11:00, Xu Kuohai wrote:
> On 12/20/2022 10:13 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Implement bpf_arch_text_poke for RV64. For call scenario,
>> ftrace framework reserve 4 nops for RV64 kernel function
>> as function entry, and use auipc+jalr instructions to call
>> kernel or module functions. However, since the auipc+jalr
>> call instructions is non-atomic operation, we need to use
>> stop-machine to make sure instruction patching in atomic
>> context. As for jump scenario, since we only jump inside
>> the trampoline, a jal instruction is sufficient.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit.h        |   5 ++
>>   arch/riscv/net/bpf_jit_comp64.c | 131 +++++++++++++++++++++++++++++++-
>>   2 files changed, 134 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index d926e0f7ef57..bf9802a63061 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -573,6 +573,11 @@ static inline u32 rv_fence(u8 pred, u8 succ)
>>       return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
>>   }
>> +static inline u32 rv_nop(void)
>> +{
>> +    return rv_i_insn(0, 0, 0, 0, 0x13);
>> +}
>> +
>>   /* RVC instrutions. */
>>   static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c 
>> b/arch/riscv/net/bpf_jit_comp64.c
>> index bf4721a99a09..fa8b03c52463 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bpf.h>
>>   #include <linux/filter.h>
>> +#include <linux/memory.h>
>> +#include <linux/stop_machine.h>
>>   #include "bpf_jit.h"
>>   #define RV_REG_TCC RV_REG_A6
>> @@ -238,7 +240,7 @@ static void __build_epilogue(bool is_tail_call, 
>> struct rv_jit_context *ctx)
>>       if (!is_tail_call)
>>           emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>>       emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
>> -          is_tail_call ? 4 : 0, /* skip TCC init */
>> +          is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
>>             ctx);
>>   }
>> @@ -615,6 +617,127 @@ static int add_exception_handler(const struct 
>> bpf_insn *insn,
>>       return 0;
>>   }
>> +struct text_poke_args {
>> +    void *addr;
>> +    const void *insns;
>> +    size_t len;
>> +    atomic_t cpu_count;
>> +};
>> +
>> +static int do_text_poke(void *data)
>> +{
>> +    int ret = 0;
>> +    struct text_poke_args *patch = data;
>> +
>> +    if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
> 
> seems this sync is not needed, why not calling stop machine like this:
> 
> stop_machine(do_text_poke, &patch, NULL);
> 

I think both version should be ok. While the NULL version uses first cpu 
as master to patch_text and the others touch nmi watchdog, this version 
attempts to let other cpus enter cpu_relax to calm down, and let master 
cpu owns system resources as possible.

>> +        ret = patch_text_nosync(patch->addr, patch->insns, patch->len);
>> +        atomic_inc(&patch->cpu_count);
>> +    } else {
>> +        while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>> +            cpu_relax();
>> +        smp_mb();
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int bpf_text_poke_stop_machine(void *addr, const void *insns, 
>> size_t len)
>> +{
>> +    struct text_poke_args patch = {
>> +        .addr = addr,
>> +        .insns = insns,
>> +        .len = len,
>> +        .cpu_count = ATOMIC_INIT(0),
>> +    };
>> +
>> +    return stop_machine(do_text_poke, &patch, cpu_online_mask);
>> +}
>> +
>> +static int gen_call_or_nops(void *target, void *ip, u32 *insns)
>> +{
>> +    int i, ret;
>> +    s64 rvoff;
>> +    struct rv_jit_context ctx;
>> +
>> +    ctx.ninsns = 0;
>> +    ctx.insns = (u16 *)insns;
>> +
>> +    if (!target) {
>> +        for (i = 0; i < 4; i++)
>> +            emit(rv_nop(), &ctx);
>> +        return 0;
>> +    }
>> +
>> +    rvoff = (s64)(target - ip);
>> +    emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
>> +    ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
>> +    if (ret)
>> +        return ret;
>> +    emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
>> +
>> +    return 0;
>> +
>> +}
>> +
>> +static int bpf_text_poke_call(void *ip, void *old_addr, void *new_addr)
>> +{
>> +    int ret;
>> +    u32 old_insns[4], new_insns[4];
>> +
>> +    ret = gen_call_or_nops(old_addr, ip + 4, old_insns);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = gen_call_or_nops(new_addr, ip + 4, new_insns);
>> +    if (ret)
>> +        return ret;
>> +
>> +    mutex_lock(&text_mutex);
>> +    if (memcmp(ip, old_insns, sizeof(old_insns))) {
>> +        ret = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    if (memcmp(ip, new_insns, sizeof(new_insns)))
>> +        ret = bpf_text_poke_stop_machine(ip, new_insns, 
>> sizeof(new_insns));
> 
> since there are 4 instructions being replaced, it is possible that
> serveral old instructions were already executed before stop machine.
> 

Yes, there are unpredictable problems after stop machine in that 
situation. In addition, probing stop machine sub-functions may lead to 
loop nesting problems. And this is the current problem with riscv ftrace.

But the surprise was that Andy's work [1] was about to solve these 
problems. We can synchronize changes in the future.

[1] 
https://lore.kernel.org/linux-riscv/20220913094252.3555240-1-andy.chiu@sifive.com

>> +out:
>> +    mutex_unlock(&text_mutex);
>> +    return ret;
>> +}
>> +
>> +static int bpf_text_poke_jump(void *ip, void *old_addr, void *new_addr)
>> +{
>> +    int ret;
>> +    u32 old_insn, new_insn;
>> +
>> +    old_insn = old_addr ? rv_jal(RV_REG_ZERO, (s64)(old_addr - ip) >> 
>> 1) : rv_nop();
>> +    new_insn = new_addr ? rv_jal(RV_REG_ZERO, (s64)(new_addr - ip) >> 
>> 1) : rv_nop();
>> +
>> +    mutex_lock(&text_mutex);
>> +    if (memcmp(ip, &old_insn, sizeof(old_insn))) {
>> +        ret = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    if (memcmp(ip, &new_insn, sizeof(new_insn)))
>> +        ret = patch_text_nosync(ip, &new_insn, sizeof(new_insn));
>> +out:
>> +    mutex_unlock(&text_mutex);
>> +    return ret;
>> +}
>> +
>> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>> +               void *old_addr, void *new_addr)
>> +{
>> +    if (!is_kernel_text((unsigned long)ip) &&
>> +        !is_bpf_text_address((unsigned long)ip))
>> +        return -ENOTSUPP;
>> +
>> +    return poke_type == BPF_MOD_CALL ?
>> +           bpf_text_poke_call(ip, old_addr, new_addr) :
>> +           bpf_text_poke_jump(ip, old_addr, new_addr);
>> +}
>> +
>>   int bpf_jit_emit_insn(const struct bpf_insn *insn, struct 
>> rv_jit_context *ctx,
>>                 bool extra_pass)
>>   {
>> @@ -1266,7 +1389,7 @@ int bpf_jit_emit_insn(const struct bpf_insn 
>> *insn, struct rv_jit_context *ctx,
>>   void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>   {
>> -    int stack_adjust = 0, store_offset, bpf_stack_adjust;
>> +    int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
>>       bool is_main_prog = ctx->prog->aux->func_idx == 0;
>>       bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
>> @@ -1294,6 +1417,10 @@ void bpf_jit_build_prologue(struct 
>> rv_jit_context *ctx)
>>       store_offset = stack_adjust - 8;
>> +    /* reserve 4 nop insns */
>> +    for (i = 0; i < 4; i++)
>> +        emit(rv_nop(), ctx);
>> +
>>       /* First instruction is always setting the tail-call-counter
>>        * (TCC) register. This instruction is skipped for tail calls.
>>        * Force using a 4-byte (non-compressed) instruction.

