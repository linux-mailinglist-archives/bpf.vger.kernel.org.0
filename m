Return-Path: <bpf+bounces-5323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D47598C1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4432A281925
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8414286;
	Wed, 19 Jul 2023 14:45:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EA11CB4;
	Wed, 19 Jul 2023 14:45:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68FE1726;
	Wed, 19 Jul 2023 07:44:52 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5dmm4yMJzNm5t;
	Wed, 19 Jul 2023 22:41:28 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 22:44:47 +0800
Message-ID: <63986ef9-10a4-bcef-369d-0bad28b192d1@huawei.com>
Date: Wed, 19 Jul 2023 22:44:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf] riscv, bpf: Adapt bpf trampoline to optimized riscv
 ftrace framework
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui
	<pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>, Song Shuai
	<suagrfillet@gmail.com>
References: <20230715090137.2141358-1-pulehui@huaweicloud.com>
 <87lefdougi.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
In-Reply-To: <87lefdougi.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/19 4:06, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
>> half") optimizes the detour code size of kernel functions to half with
>> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
>> is based on this optimization, we need to adapt riscv bpf trampoline
>> based on this. One thing to do is to reduce detour code size of bpf
>> programs, and the second is to deal with the return address after the
>> execution of bpf trampoline. Meanwhile, add more comments and rename
>> some variables to make more sense. The related tests have passed.
>>
>> This adaptation needs to be merged before the upcoming
>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv, otherwise it will crash due
>> to a mismatch in the return address. So we target this modification to
>> bpf tree and add fixes tag for locating.
> 
> Thank you for working on this!
> 
>> Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half")
> 
> This is not a fix. Nothing is broken. Only that this patch much come
> before or as part of the ftrace series.

Yep, it's really not a fix. I have no idea whether this patch target to 
bpf-next tree can be ahead of the ftrace series of riscv tree?

>  >> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 110 ++++++++++++++------------------
>>   1 file changed, 47 insertions(+), 63 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index c648864c8cd1..ffc9aa42f918 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -241,7 +241,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>>   	if (!is_tail_call)
>>   		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>>   	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
>> -		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
>> +		  is_tail_call ? 12 : 0, /* skip reserved nops and TCC init */
> 
> Maybe be explicit, and use the "DETOUR_INSNS" from below (and convert to
> bytes)?
> 
>>   		  ctx);
>>   }
>>   
>> @@ -618,32 +618,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   	return 0;
>>   }
>>   
>> -static int gen_call_or_nops(void *target, void *ip, u32 *insns)
>> -{
>> -	s64 rvoff;
>> -	int i, ret;
>> -	struct rv_jit_context ctx;
>> -
>> -	ctx.ninsns = 0;
>> -	ctx.insns = (u16 *)insns;
>> -
>> -	if (!target) {
>> -		for (i = 0; i < 4; i++)
>> -			emit(rv_nop(), &ctx);
>> -		return 0;
>> -	}
>> -
>> -	rvoff = (s64)(target - (ip + 4));
>> -	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
>> -	ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
>> -	if (ret)
>> -		return ret;
>> -	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
>> -
>> -	return 0;
>> -}
>> -
>> -static int gen_jump_or_nops(void *target, void *ip, u32 *insns)
>> +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
>>   {
>>   	s64 rvoff;
>>   	struct rv_jit_context ctx;
>> @@ -658,38 +633,38 @@ static int gen_jump_or_nops(void *target, void *ip, u32 *insns)
>>   	}
>>   
>>   	rvoff = (s64)(target - ip);
>> -	return emit_jump_and_link(RV_REG_ZERO, rvoff, false, &ctx);
>> +	return emit_jump_and_link(is_call ? RV_REG_T0 : RV_REG_ZERO,
>> +				  rvoff, false, &ctx);
> 
> Nit: Please use the full 100 char width.
> 
>>   }
>>   
>> +#define DETOUR_NINSNS	2
> 
> Better name? Maybe call this patchable function entry something? Also,

How about RV_FENTRY_NINSNS?

> to catch future breaks like this -- would it make sense to have a
> static_assert() combined with something tied to
> -fpatchable-function-entry= from arch/riscv/Makefile?

It is very necessary, but it doesn't seem to be easy. I try to find GCC 
related functions, something like __builtin_xxx, but I can't find it so 
far. Also try to make it as a CONFIG_PATCHABLE_FUNCTION_ENTRY=4 in 
Makefile and then static_assert, but obviously it shouldn't be done. 
Maybe we can deal with this later when we have a solution?

> 
>> +
>>   int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>>   		       void *old_addr, void *new_addr)
>>   {
>> -	u32 old_insns[4], new_insns[4];
>> +	u32 old_insns[DETOUR_NINSNS], new_insns[DETOUR_NINSNS];
>>   	bool is_call = poke_type == BPF_MOD_CALL;
>> -	int (*gen_insns)(void *target, void *ip, u32 *insns);
>> -	int ninsns = is_call ? 4 : 2;
>>   	int ret;
>>   
>> -	if (!is_bpf_text_address((unsigned long)ip))
>> +	if (!is_kernel_text((unsigned long)ip) &&
>> +	    !is_bpf_text_address((unsigned long)ip))
>>   		return -ENOTSUPP;
>>   
>> -	gen_insns = is_call ? gen_call_or_nops : gen_jump_or_nops;
>> -
>> -	ret = gen_insns(old_addr, ip, old_insns);
>> +	ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (memcmp(ip, old_insns, ninsns * 4))
>> +	if (memcmp(ip, old_insns, DETOUR_NINSNS * 4))
>>   		return -EFAULT;
>>   
>> -	ret = gen_insns(new_addr, ip, new_insns);
>> +	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
>>   	if (ret)
>>   		return ret;
>>   
>>   	cpus_read_lock();
>>   	mutex_lock(&text_mutex);
>> -	if (memcmp(ip, new_insns, ninsns * 4))
>> -		ret = patch_text(ip, new_insns, ninsns);
>> +	if (memcmp(ip, new_insns, DETOUR_NINSNS * 4))
>> +		ret = patch_text(ip, new_insns, DETOUR_NINSNS);
>>   	mutex_unlock(&text_mutex);
>>   	cpus_read_unlock();
>>   
>> @@ -717,7 +692,7 @@ static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
>>   }
>>   
>>   static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
>> -			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
>> +			   int run_ctx_off, bool save_retval, struct rv_jit_context *ctx)
> 
> Why the save_retval name change? This churn is not needed IMO
> (especially since you keep using the _ret name below). Please keep the
> old name. >
>>   {
>>   	int ret, branch_off;
>>   	struct bpf_prog *p = l->link.prog;
>> @@ -757,7 +732,7 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (save_ret)
>> +	if (save_retval)
>>   		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
>>   
>>   	/* update branch with beqz */
>> @@ -787,20 +762,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	int i, ret, offset;
>>   	int *branches_off = NULL;
>>   	int stack_size = 0, nregs = m->nr_args;
>> -	int retaddr_off, fp_off, retval_off, args_off;
>> -	int nregs_off, ip_off, run_ctx_off, sreg_off;
>> +	int fp_off, retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
>>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>>   	void *orig_call = func_addr;
>> -	bool save_ret;
>> +	bool save_retval, traced_ret;
>>   	u32 insn;
>>   
>>   	/* Generated trampoline stack layout:
>>   	 *
>>   	 * FP - 8	    [ RA of parent func	] return address of parent
>>   	 *					  function
>> -	 * FP - retaddr_off [ RA of traced func	] return address of traced
>> +	 * FP - 16	    [ RA of traced func	] return address of
>>   	traced
> 
> BPF code uses frame pointers. Shouldn't the trampoline frame look like a
> regular frame [1], i.e. start with return address followed by previous
> frame pointer?
> 

oops, will fix it. Also we need to consider two types of trampoline 
stack layout, that is:

* 1. trampoline called from function entry
* --------------------------------------
* FP + 8           [ RA of parent func ] return address of parent
*                                        function
* FP + 0           [ FP                ]
*
* FP - 8           [ RA of traced func ] return address of traced
*                                        function
* FP - 16          [ FP                ]
* --------------------------------------
*
* 2. trampoline called directly
* --------------------------------------
* FP - 8           [ RA of caller func ] return address of caller
*                                        function
* FP - 16          [ FP                ]
* --------------------------------------

>>   	 *					  function
>>   	 * FP - fp_off	    [ FP of parent func ]
>>   	 *
>> @@ -833,17 +807,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	if (nregs > 8)
>>   		return -ENOTSUPP;
>>   
>> -	/* room for parent function return address */
>> +	/* room for return address of parent function */
>>   	stack_size += 8;
>>   
>> -	stack_size += 8;
>> -	retaddr_off = stack_size;
>> +	/* whether return to return address of traced function after bpf trampoline */
>> +	traced_ret = func_addr && !(flags & BPF_TRAMP_F_SKIP_FRAME);
>> +	/* room for return address of traced function */
>> +	if (traced_ret)
>> +		stack_size += 8;
>>   
>>   	stack_size += 8;
>>   	fp_off = stack_size;
>>   
>> -	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>> -	if (save_ret) {
>> +	save_retval = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>> +	if (save_retval) {
>>   		stack_size += 8;
>>   		retval_off = stack_size;
>>   	}
>> @@ -869,7 +846,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   
>>   	emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
>>   
>> -	emit_sd(RV_REG_SP, stack_size - retaddr_off, RV_REG_RA, ctx);
>> +	/* store return address of parent function */
>> +	emit_sd(RV_REG_SP, stack_size - 8, RV_REG_RA, ctx);
>> +	/* store return address of traced function */
>> +	if (traced_ret)
>> +		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_T0, ctx);
>>   	emit_sd(RV_REG_SP, stack_size - fp_off, RV_REG_FP, ctx);
>>   
>>   	emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
>> @@ -890,7 +871,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   
>>   	/* skip to actual body of traced function */
>>   	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>> -		orig_call += 16;
>> +		orig_call += 8;
> 
> Use the define above so it's obvious what you're skipping.
> 
>>   
>>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>>   		emit_imm(RV_REG_A0, (const s64)im, ctx);
>> @@ -962,22 +943,25 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>>   		restore_args(nregs, args_off, ctx);
>>   
>> -	if (save_ret)
>> +	if (save_retval)
>>   		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>>   
>>   	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>>   
>> -	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>> -		/* return address of parent function */
>> +	if (traced_ret) {
>> +		/* restore return address of parent function */
>>   		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
>> -	else
>> -		/* return address of traced function */
>> -		emit_ld(RV_REG_RA, stack_size - retaddr_off, RV_REG_SP, ctx);
>> +		/* restore return address of traced function */
>> +		emit_ld(RV_REG_T0, stack_size - 16, RV_REG_SP, ctx);
>> +	} else {
>> +		/* restore return address of parent function */
>> +		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
>> +	}
>>   
>>   	emit_ld(RV_REG_FP, stack_size - fp_off, RV_REG_SP, ctx);
>>   	emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
>>   
>> -	emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
>> +	emit_jalr(RV_REG_ZERO, RV_REG_T0, 0, ctx);
>>   
>>   	ret = ctx->ninsns;
>>   out:
>> @@ -1664,7 +1648,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   
>>   void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>   {
>> -	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
>> +	int stack_adjust = 0, store_offset, bpf_stack_adjust;
>>   
>>   	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
>>   	if (bpf_stack_adjust)
>> @@ -1691,9 +1675,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>   
>>   	store_offset = stack_adjust - 8;
>>   
>> -	/* reserve 4 nop insns */
>> -	for (i = 0; i < 4; i++)
>> -		emit(rv_nop(), ctx);
>> +	/* 2 nops reserved for auipc+jalr pair */
>> +	emit(rv_nop(), ctx);
>> +	emit(rv_nop(), ctx);
> 
> Use the define above, instead of hardcoding two nops.
> 
> 
> Thanks,
> Björn
> 
> [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc#frame-pointer-convention

