Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932BF65F954
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 02:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAFB54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 20:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAFB54 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 20:57:56 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE318682;
        Thu,  5 Jan 2023 17:57:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Np6182CN7z4f3wY5;
        Fri,  6 Jan 2023 09:57:48 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP4 (Coremail) with SMTP id gCh0CgAnj7IdgLdjuwi5BA--.25658S2;
        Fri, 06 Jan 2023 09:57:50 +0800 (CST)
Message-ID: <755a5b80-f916-7383-6746-3e202224dfcc@huaweicloud.com>
Date:   Fri, 6 Jan 2023 09:57:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH RESEND bpf-next 3/4] riscv, bpf: Add
 bpf_arch_text_poke support for RV64
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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
 <20221220021319.1655871-4-pulehui@huaweicloud.com>
 <871qobqyh9.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <871qobqyh9.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnj7IdgLdjuwi5BA--.25658S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWDWr13CF1xJFyxJFWUJwb_yoWxJw13pF
        WUKrZ8AFWkXF1xJFy2qa1DXr4ayrs5WF9FkrWUtayFyFnF9r97Cw1rK3yakr95Cr48CF10
        vF4jvrn3uan0yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2023/1/4 2:12, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
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
> 
> Hmm, is that really true? More below!
> 
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit.h        |   5 ++
>>   arch/riscv/net/bpf_jit_comp64.c | 131 +++++++++++++++++++++++++++++++-
>>   2 files changed, 134 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index d926e0f7ef57..bf9802a63061 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -573,6 +573,11 @@ static inline u32 rv_fence(u8 pred, u8 succ)
>>   	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
>>   }
>>   
>> +static inline u32 rv_nop(void)
>> +{
>> +	return rv_i_insn(0, 0, 0, 0, 0x13);
>> +}
>> +
>>   /* RVC instrutions. */
>>   
>>   static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index bf4721a99a09..fa8b03c52463 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bpf.h>
>>   #include <linux/filter.h>
>> +#include <linux/memory.h>
>> +#include <linux/stop_machine.h>
>>   #include "bpf_jit.h"
>>   
>>   #define RV_REG_TCC RV_REG_A6
>> @@ -238,7 +240,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>>   	if (!is_tail_call)
>>   		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>>   	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
>> -		  is_tail_call ? 4 : 0, /* skip TCC init */
>> +		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
>>   		  ctx);
>>   }
>>   
>> @@ -615,6 +617,127 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   	return 0;
>>   }
>>   
>> +struct text_poke_args {
>> +	void *addr;
>> +	const void *insns;
>> +	size_t len;
>> +	atomic_t cpu_count;
>> +};
>> +
>> +static int do_text_poke(void *data)
>> +{
>> +	int ret = 0;
>> +	struct text_poke_args *patch = data;
>> +
>> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>> +		ret = patch_text_nosync(patch->addr, patch->insns, patch->len);
>> +		atomic_inc(&patch->cpu_count);
>> +	} else {
>> +		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>> +			cpu_relax();
>> +		smp_mb();
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int bpf_text_poke_stop_machine(void *addr, const void *insns, size_t len)
>> +{
>> +	struct text_poke_args patch = {
>> +		.addr = addr,
>> +		.insns = insns,
>> +		.len = len,
>> +		.cpu_count = ATOMIC_INIT(0),
>> +	};
>> +
>> +	return stop_machine(do_text_poke, &patch, cpu_online_mask);
>> +}
>> +
>> +static int gen_call_or_nops(void *target, void *ip, u32 *insns)
>> +{
>> +	int i, ret;
>> +	s64 rvoff;
>> +	struct rv_jit_context ctx;
>> +
>> +	ctx.ninsns = 0;
>> +	ctx.insns = (u16 *)insns;
>> +
>> +	if (!target) {
>> +		for (i = 0; i < 4; i++)
>> +			emit(rv_nop(), &ctx);
>> +		return 0;
>> +	}
>> +
>> +	rvoff = (s64)(target - ip);
>> +	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
>> +	ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
>> +	if (ret)
>> +		return ret;
>> +	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
>> +
>> +	return 0;
>> +
>> +}
>> +
>> +static int bpf_text_poke_call(void *ip, void *old_addr, void *new_addr)
>> +{
>> +	int ret;
>> +	u32 old_insns[4], new_insns[4];
>> +
>> +	ret = gen_call_or_nops(old_addr, ip + 4, old_insns);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = gen_call_or_nops(new_addr, ip + 4, new_insns);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&text_mutex);
>> +	if (memcmp(ip, old_insns, sizeof(old_insns))) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	if (memcmp(ip, new_insns, sizeof(new_insns)))
>> +		ret = bpf_text_poke_stop_machine(ip, new_insns,
>> sizeof(new_insns));
> 
> I'd rather see that you added a patch_text variant to
> arch/riscv/kernel/patch.c (something like your
> bpf_text_poke_stop_machine()), and use that here. Might be other users
> of that as well -- Andy's ftrace patch maybe? :-)
> 

Good idea.

>> +out:
>> +	mutex_unlock(&text_mutex);
>> +	return ret;
>> +}
>> +
>> +static int bpf_text_poke_jump(void *ip, void *old_addr, void *new_addr)
>> +{
>> +	int ret;
>> +	u32 old_insn, new_insn;
>> +
>> +	old_insn = old_addr ? rv_jal(RV_REG_ZERO, (s64)(old_addr - ip) >> 1) : rv_nop();
>> +	new_insn = new_addr ? rv_jal(RV_REG_ZERO, (s64)(new_addr - ip) >> 1) : rv_nop();
>> +
>> +	mutex_lock(&text_mutex);
>> +	if (memcmp(ip, &old_insn, sizeof(old_insn))) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	if (memcmp(ip, &new_insn, sizeof(new_insn)))
>> +		ret = patch_text_nosync(ip, &new_insn, sizeof(new_insn));
>> +out:
>> +	mutex_unlock(&text_mutex);
>> +	return ret;
>> +}
>> +
>> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>> +		       void *old_addr, void *new_addr)
> 
> AFAIU there's nothing in the bpf_arch_text_poke() API that say that
> BPF_MOD_JUMP is jumps within the trampoline. That is one usage, but not
> the only one. In general, the jal might not have enough reach.
> 
> I believe that this needs to be an auipc/jalr pair similar to
> BPF_MOD_CALL (w/o linked register).
> 

The initial idea was that currently BPF_MOD_JUMP only serves for 
bpf_tramp_image_put, and jal, which range is +/- 1MB, is sufficient for 
the distance between im->ip_after_call and im->ip_epilogue, and try to 
not use not-atomic auipc/jalr pair. But take deep consideration, this 
might be extended to other uses, such as tailcall optimization. So agree 
with your suggestion.

> 
> And again, thanks for working on the RV trampoline!
> Björn

