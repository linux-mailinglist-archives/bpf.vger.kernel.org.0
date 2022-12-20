Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6377651935
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 04:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLTDBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 22:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLTDBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 22:01:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E301262B;
        Mon, 19 Dec 2022 19:01:01 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbhBd2DjHzmWjK;
        Tue, 20 Dec 2022 10:59:53 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 11:00:58 +0800
Message-ID: <27a7b2ff-c0db-7fa0-2da0-8d76899f94f8@huawei.com>
Date:   Tue, 20 Dec 2022 11:00:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH RESEND bpf-next 3/4] riscv, bpf: Add
 bpf_arch_text_poke support for RV64
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20221220021319.1655871-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/2022 10:13 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Implement bpf_arch_text_poke for RV64. For call scenario,
> ftrace framework reserve 4 nops for RV64 kernel function
> as function entry, and use auipc+jalr instructions to call
> kernel or module functions. However, since the auipc+jalr
> call instructions is non-atomic operation, we need to use
> stop-machine to make sure instruction patching in atomic
> context. As for jump scenario, since we only jump inside
> the trampoline, a jal instruction is sufficient.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/net/bpf_jit.h        |   5 ++
>   arch/riscv/net/bpf_jit_comp64.c | 131 +++++++++++++++++++++++++++++++-
>   2 files changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index d926e0f7ef57..bf9802a63061 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -573,6 +573,11 @@ static inline u32 rv_fence(u8 pred, u8 succ)
>   	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
>   }
>   
> +static inline u32 rv_nop(void)
> +{
> +	return rv_i_insn(0, 0, 0, 0, 0x13);
> +}
> +
>   /* RVC instrutions. */
>   
>   static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index bf4721a99a09..fa8b03c52463 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -8,6 +8,8 @@
>   #include <linux/bitfield.h>
>   #include <linux/bpf.h>
>   #include <linux/filter.h>
> +#include <linux/memory.h>
> +#include <linux/stop_machine.h>
>   #include "bpf_jit.h"
>   
>   #define RV_REG_TCC RV_REG_A6
> @@ -238,7 +240,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>   	if (!is_tail_call)
>   		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>   	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
> -		  is_tail_call ? 4 : 0, /* skip TCC init */
> +		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
>   		  ctx);
>   }
>   
> @@ -615,6 +617,127 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   	return 0;
>   }
>   
> +struct text_poke_args {
> +	void *addr;
> +	const void *insns;
> +	size_t len;
> +	atomic_t cpu_count;
> +};
> +
> +static int do_text_poke(void *data)
> +{
> +	int ret = 0;
> +	struct text_poke_args *patch = data;
> +
> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {

seems this sync is not needed, why not calling stop machine like this:

stop_machine(do_text_poke, &patch, NULL);

> +		ret = patch_text_nosync(patch->addr, patch->insns, patch->len);
> +		atomic_inc(&patch->cpu_count);
> +	} else {
> +		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
> +			cpu_relax();
> +		smp_mb();
> +	}
> +
> +	return ret;
> +}
> +
> +static int bpf_text_poke_stop_machine(void *addr, const void *insns, size_t len)
> +{
> +	struct text_poke_args patch = {
> +		.addr = addr,
> +		.insns = insns,
> +		.len = len,
> +		.cpu_count = ATOMIC_INIT(0),
> +	};
> +
> +	return stop_machine(do_text_poke, &patch, cpu_online_mask);
> +}
> +
> +static int gen_call_or_nops(void *target, void *ip, u32 *insns)
> +{
> +	int i, ret;
> +	s64 rvoff;
> +	struct rv_jit_context ctx;
> +
> +	ctx.ninsns = 0;
> +	ctx.insns = (u16 *)insns;
> +
> +	if (!target) {
> +		for (i = 0; i < 4; i++)
> +			emit(rv_nop(), &ctx);
> +		return 0;
> +	}
> +
> +	rvoff = (s64)(target - ip);
> +	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
> +	ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
> +	if (ret)
> +		return ret;
> +	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
> +
> +	return 0;
> +
> +}
> +
> +static int bpf_text_poke_call(void *ip, void *old_addr, void *new_addr)
> +{
> +	int ret;
> +	u32 old_insns[4], new_insns[4];
> +
> +	ret = gen_call_or_nops(old_addr, ip + 4, old_insns);
> +	if (ret)
> +		return ret;
> +
> +	ret = gen_call_or_nops(new_addr, ip + 4, new_insns);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&text_mutex);
> +	if (memcmp(ip, old_insns, sizeof(old_insns))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (memcmp(ip, new_insns, sizeof(new_insns)))
> +		ret = bpf_text_poke_stop_machine(ip, new_insns, sizeof(new_insns));

since there are 4 instructions being replaced, it is possible that
serveral old instructions were already executed before stop machine.

> +out:
> +	mutex_unlock(&text_mutex);
> +	return ret;
> +}
> +
> +static int bpf_text_poke_jump(void *ip, void *old_addr, void *new_addr)
> +{
> +	int ret;
> +	u32 old_insn, new_insn;
> +
> +	old_insn = old_addr ? rv_jal(RV_REG_ZERO, (s64)(old_addr - ip) >> 1) : rv_nop();
> +	new_insn = new_addr ? rv_jal(RV_REG_ZERO, (s64)(new_addr - ip) >> 1) : rv_nop();
> +
> +	mutex_lock(&text_mutex);
> +	if (memcmp(ip, &old_insn, sizeof(old_insn))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (memcmp(ip, &new_insn, sizeof(new_insn)))
> +		ret = patch_text_nosync(ip, &new_insn, sizeof(new_insn));
> +out:
> +	mutex_unlock(&text_mutex);
> +	return ret;
> +}
> +
> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> +		       void *old_addr, void *new_addr)
> +{
> +	if (!is_kernel_text((unsigned long)ip) &&
> +	    !is_bpf_text_address((unsigned long)ip))
> +		return -ENOTSUPP;
> +
> +	return poke_type == BPF_MOD_CALL ?
> +	       bpf_text_poke_call(ip, old_addr, new_addr) :
> +	       bpf_text_poke_jump(ip, old_addr, new_addr);
> +}
> +
>   int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		      bool extra_pass)
>   {
> @@ -1266,7 +1389,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   
>   void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   {
> -	int stack_adjust = 0, store_offset, bpf_stack_adjust;
> +	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
>   	bool is_main_prog = ctx->prog->aux->func_idx == 0;
>   
>   	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> @@ -1294,6 +1417,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   
>   	store_offset = stack_adjust - 8;
>   
> +	/* reserve 4 nop insns */
> +	for (i = 0; i < 4; i++)
> +		emit(rv_nop(), ctx);
> +
>   	/* First instruction is always setting the tail-call-counter
>   	 * (TCC) register. This instruction is skipped for tail calls.
>   	 * Force using a 4-byte (non-compressed) instruction.

