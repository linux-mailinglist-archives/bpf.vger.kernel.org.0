Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE965F92F
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 02:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjAFBhA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 20:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjAFBgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 20:36:53 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842F1B1F4;
        Thu,  5 Jan 2023 17:36:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Np5Xt04M7z4f3p1g;
        Fri,  6 Jan 2023 09:36:46 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP1 (Coremail) with SMTP id cCh0CgDHNC8ve7djmUtpBA--.44504S2;
        Fri, 06 Jan 2023 09:36:48 +0800 (CST)
Message-ID: <22c7dad7-1cda-fbdd-95e8-11a470f09fec@huaweicloud.com>
Date:   Fri, 6 Jan 2023 09:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH RESEND bpf-next 4/4] riscv, bpf: Add bpf trampoline
 support for RV64
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
 <20221220021319.1655871-5-pulehui@huaweicloud.com>
 <87y1qjpgy4.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87y1qjpgy4.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHNC8ve7djmUtpBA--.44504S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CFWUCF4DAr1fZFWDurWUXFb_yoWkXr4kpF
        yDGF4fAFy8XF1YqFyvqF4UXF4avr4ktFnFkFyrtF95ArZ0vr4fK34rKF4Y9ry5Crn5Ar48
        ZF4qywnIk3WUGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
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
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/1/4 3:16, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> BPF trampoline is the critical infrastructure of the bpf
>> subsystem, acting as a mediator between kernel functions
>> and BPF programs. Numerous important features, such as
>> using ebpf program for zero overhead kernel introspection,
>> rely on this key component. We can't wait to support bpf
>> trampoline on RV64. The implementation of bpf trampoline
>> was closely to x86 and arm64 for future development. The
>> related tests have passed, as well as the test_verifier
>> with no new failure ceses.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 322 ++++++++++++++++++++++++++++++++
>>   1 file changed, 322 insertions(+)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index fa8b03c52463..11c001782e7b 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -738,6 +738,328 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>>   	       bpf_text_poke_jump(ip, old_addr, new_addr);
>>   }
>>   
>> +static void store_args(int nregs, int args_off, struct rv_jit_context *ctx)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < nregs; i++) {
>> +		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
>> +		args_off -= 8;
>> +	}
>> +}
>> +
>> +static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < nregs; i++) {
>> +		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
>> +		args_off -= 8;
>> +	}
>> +}
>> +
>> +static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
>> +			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
>> +{
>> +	u32 insn;
>> +	int ret, branch_off, offset;
>> +	struct bpf_prog *p = l->link.prog;
>> +	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>> +
>> +	if (l->cookie) {
>> +		emit_imm(RV_REG_T1, l->cookie, ctx);
>> +		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
>> +	} else {
>> +		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
>> +	}
>> +
>> +	/* arg1: prog */
>> +	emit_imm(RV_REG_A0, (const s64)p, ctx);
>> +	/* arg2: &run_ctx */
>> +	emit_addi(RV_REG_A1, RV_REG_FP, -run_ctx_off, ctx);
>> +	ret = emit_call((const u64)bpf_trampoline_enter(p), true, ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* if (__bpf_prog_enter(prog) == 0)
>> +	 *	goto skip_exec_of_prog;
>> +	 */
>> +	branch_off = ctx->ninsns;
>> +	/* nop reserved for conditional jump */
>> +	emit(rv_nop(), ctx);
>> +
>> +	/* store prog start time */
>> +	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
>> +
>> +	/* arg1: &args_off */
>> +	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
>> +	if (!p->jited)
>> +		/* arg2: progs[i]->insnsi for interpreter */
>> +		emit_imm(RV_REG_A1, (const s64)p->insnsi, ctx);
>> +	ret = emit_call((const u64)p->bpf_func, true, ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (save_ret)
>> +		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
>> +
>> +	/* update branch with beqz */
>> +	offset = ninsns_rvoff(ctx->ninsns - branch_off);
>> +	insn = rv_beq(RV_REG_A0, RV_REG_ZERO, offset >> 1);
>> +	*(u32 *)(ctx->insns + branch_off) = insn;
>> +
>> +	/* arg1: prog */
>> +	emit_imm(RV_REG_A0, (const s64)p, ctx);
>> +	/* arg2: prog start time */
>> +	emit_mv(RV_REG_A1, RV_REG_S1, ctx);
>> +	/* arg3: &run_ctx */
>> +	emit_addi(RV_REG_A2, RV_REG_FP, -run_ctx_off, ctx);
>> +	ret = emit_call((const u64)bpf_trampoline_exit(p), true, ctx);
>> +
>> +	return ret;
>> +}
>> +
>> +static int invoke_bpf_mod_ret(struct bpf_tramp_links *tl, int args_off, int retval_off,
>> +			      int run_ctx_off, int *branches_off, struct rv_jit_context *ctx)
>> +{
>> +	int i, ret;
>> +
>> +	/* cleanup to avoid garbage return value confusion */
>> +	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
>> +	for (i = 0; i < tl->nr_links; i++) {
>> +		ret = invoke_bpf_prog(tl->links[i], args_off, retval_off,
>> +				run_ctx_off, true, ctx);
>> +		if (ret)
>> +			return ret;
>> +		emit_ld(RV_REG_T1, -retval_off, RV_REG_FP, ctx);
>> +		branches_off[i] = ctx->ninsns;
>> +		/* nop reserved for conditional jump */
>> +		emit(rv_nop(), ctx);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>> +					 const struct btf_func_model *m,
>> +					 struct bpf_tramp_links *tlinks,
>> +					 void *func_addr, u32 flags,
>> +					 struct rv_jit_context *ctx)
>> +{
>> +	int i, ret, offset;
>> +	int *branches_off = NULL;
>> +	int stack_size = 0, nregs = m->nr_args;
>> +	int retaddr_off, fp_off, retval_off, args_off;
>> +	int nregs_off, ip_off, run_ctx_off, sreg_off;
>> +	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>> +	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>> +	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>> +	void *orig_call = func_addr;
>> +	bool save_ret;
>> +	u32 insn;
>> +
>> +	/* Generated trampoline stack layout:
>> +	 *
>> +	 * FP - 8	    [ RA of parent func	] return address of parent
>> +	 *					  function
>> +	 * FP - retaddr_off [ RA of traced func	] return address of traced
>> +	 *					  function
>> +	 * FP - fp_off	    [ FP of parent func ]
>> +	 *
>> +	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
>> +	 *					  BPF_TRAMP_F_RET_FENTRY_RET
>> +	 *                  [ argN              ]
>> +	 *                  [ ...               ]
>> +	 * FP - args_off    [ arg1              ]
>> +	 *
>> +	 * FP - nregs_off   [ regs count        ]
>> +	 *
>> +	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
>> +	 *
>> +	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
>> +	 *
>> +	 * FP - sreg_off    [ callee saved reg	]
>> +	 *
>> +	 *		    [ pads              ] pads for 16 bytes alignment
>> +	 */
>> +
>> +	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
>> +		return -ENOTSUPP;
>> +
>> +	/* extra regiters for struct arguments */
>> +	for (i = 0; i < m->nr_args; i++)
>> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>> +			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
>> +
>> +	/* 8 arguments passed by registers */
>> +	if (nregs > 8)
>> +		return -ENOTSUPP;
>> +
>> +	/* room for parent function return address */
>> +	stack_size += 8;
>> +
>> +	stack_size += 8;
>> +	retaddr_off = stack_size;
>> +
>> +	stack_size += 8;
>> +	fp_off = stack_size;
>> +
>> +	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>> +	if (save_ret) {
>> +		stack_size += 8;
>> +		retval_off = stack_size;
>> +	}
>> +
>> +	stack_size += nregs * 8;
>> +	args_off = stack_size;
>> +
>> +	stack_size += 8;
>> +	nregs_off = stack_size;
>> +
>> +	if (flags & BPF_TRAMP_F_IP_ARG) {
>> +		stack_size += 8;
>> +		ip_off = stack_size;
>> +	}
>> +
>> +	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
>> +	run_ctx_off = stack_size;
>> +
>> +	stack_size += 8;
>> +	sreg_off = stack_size;
>> +
>> +	stack_size = round_up(stack_size, 16);
>> +
>> +	emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
>> +
>> +	emit_sd(RV_REG_SP, stack_size - retaddr_off, RV_REG_RA, ctx);
>> +	emit_sd(RV_REG_SP, stack_size - fp_off, RV_REG_FP, ctx);
>> +
>> +	emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
>> +
>> +	/* callee saved register S1 to pass start time */
>> +	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
>> +
>> +	/* store ip address of the traced function */
>> +	if (flags & BPF_TRAMP_F_IP_ARG) {
>> +		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
>> +		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
>> +	}
>> +
>> +	emit_li(RV_REG_T1, nregs, ctx);
>> +	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
>> +
>> +	store_args(nregs, args_off, ctx);
>> +
>> +	/* skip to actual body of traced function */
>> +	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>> +		orig_call += 16;
>> +
>> +	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> +		emit_imm(RV_REG_A0, (const s64)im, ctx);
>> +		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	for (i = 0; i < fentry->nr_links; i++) {
>> +		ret = invoke_bpf_prog(fentry->links[i], args_off, retval_off, run_ctx_off,
>> +				      flags & BPF_TRAMP_F_RET_FENTRY_RET, ctx);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (fmod_ret->nr_links) {
>> +		branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
>> +		if (!branches_off)
>> +			return -ENOMEM;
>> +
>> +		ret = invoke_bpf_mod_ret(fmod_ret, args_off, retval_off, run_ctx_off,
>> +					 branches_off, ctx);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> +		restore_args(nregs, args_off, ctx);
>> +		ret = emit_call((const u64)orig_call, true, ctx);
>> +		if (ret)
>> +			return ret;
>> +		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
>> +		/* nop reserved for bpf_tramp_image_put */
>> +		im->ip_after_call = ctx->insns + ctx->ninsns;
>> +		emit(rv_nop(), ctx);
>> +	}
>> +
>> +	/* update branches saved in invoke_bpf_mod_ret with bnez */
>> +	for (i = 0; i < fmod_ret->nr_links; i++) {
>> +		offset = ninsns_rvoff(ctx->ninsns - branches_off[i]);
>> +		insn = rv_bne(RV_REG_T1, RV_REG_ZERO, offset >> 1);
>> +		*(u32 *)(ctx->insns + branches_off[i]) = insn;
>> +	}
>> +
>> +	for (i = 0; i < fexit->nr_links; i++) {
>> +		ret = invoke_bpf_prog(fexit->links[i], args_off, retval_off,
>> +				      run_ctx_off, false, ctx);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> +		im->ip_epilogue = ctx->insns + ctx->ninsns;
>> +		emit_imm(RV_REG_A0, (const s64)im, ctx);
>> +		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>> +		restore_args(nregs, args_off, ctx);
>> +
>> +	if (save_ret)
>> +		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>> +
>> +	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>> +
>> +	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>> +		/* return address of parent function */
>> +		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
>> +	else
>> +		/* return address of traced function */
>> +		emit_ld(RV_REG_RA, stack_size - retaddr_off, RV_REG_SP, ctx);
>> +
>> +	emit_ld(RV_REG_FP, stack_size - fp_off, RV_REG_SP, ctx);
>> +	emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
>> +
>> +	emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
>> +
>> +	bpf_flush_icache(ctx->insns, ctx->insns + ctx->ninsns);
>> +
>> +	kfree(branches_off);
>> +
>> +	return ctx->ninsns;
>> +
>> +}
>> +
>> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>> +				void *image_end, const struct btf_func_model *m,
>> +				u32 flags, struct bpf_tramp_links *tlinks,
>> +				void *func_addr)
>> +{
>> +	int ret;
>> +	struct rv_jit_context ctx;
>> +
>> +	ctx.ninsns = 0;
>> +	ctx.insns = image;
>> +	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (ninsns_rvoff(ret) > (long)image_end - (long)image)
>> +		return -EFBIG;
> 
> This looks risky! First you generate the image, and here you realize
> that you already wrote in all the wrong places?!
> 

Oops, this will probably lead to OOB. Will fix in the next.

>> +
>> +	return ninsns_rvoff(ret);
> 
> Ok, this was a bit subtle to me. The return value of the this function
> is used in kernel/bpf/bpf_struct_ops.c. Now I know! :-)
> 
> 
> Thanks!
> Björn

