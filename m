Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3502965C751
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbjACTTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbjACTSr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 14:18:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D08914013;
        Tue,  3 Jan 2023 11:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A58FB80EC2;
        Tue,  3 Jan 2023 19:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FF3C433EF;
        Tue,  3 Jan 2023 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672773365;
        bh=HhMs3t/zIdqnxX2JbM4RqMDeRaqtKPlBFU+vbiniQjA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fwbAR0oPzL30Dh0H8GJfSnj3RE0ev+CQvMjIehePCPwHnCSalXNpw/SxiP+uXlzc5
         XDWrdnGzn59pxf7nbgT9jtcc8yXmadUf1sG3dJugfb/2SWUxin1SSmvW2Mufy1uZzF
         /qqx2bTbHmYvlpFWzusikla01if1xn1UWZnL4WKWPwh6eHvslre0bIMJZyvFc+Bv7+
         AZEuosVusw+qJUtc8L2HyBZLpK2s2yhJE0mEny6e/7+ipUMlVx92TRREcvKYjmepQa
         W6yp6Fr4mXqJHOgvNUxdlU0O55CaFvuydBrrB8gtuJ7KSd3WkjrDFVPAS5/uXXCUNx
         X8VjkV5a9EO7w==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
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
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [RFC PATCH RESEND bpf-next 4/4] riscv, bpf: Add bpf trampoline
 support for RV64
In-Reply-To: <20221220021319.1655871-5-pulehui@huaweicloud.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <20221220021319.1655871-5-pulehui@huaweicloud.com>
Date:   Tue, 03 Jan 2023 20:16:03 +0100
Message-ID: <87y1qjpgy4.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> BPF trampoline is the critical infrastructure of the bpf
> subsystem, acting as a mediator between kernel functions
> and BPF programs. Numerous important features, such as
> using ebpf program for zero overhead kernel introspection,
> rely on this key component. We can't wait to support bpf
> trampoline on RV64. The implementation of bpf trampoline
> was closely to x86 and arm64 for future development. The
> related tests have passed, as well as the test_verifier
> with no new failure ceses.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 322 ++++++++++++++++++++++++++++++++
>  1 file changed, 322 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index fa8b03c52463..11c001782e7b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -738,6 +738,328 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke=
_type poke_type,
>  	       bpf_text_poke_jump(ip, old_addr, new_addr);
>  }
>=20=20
> +static void store_args(int nregs, int args_off, struct rv_jit_context *c=
tx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nregs; i++) {
> +		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> +		args_off -=3D 8;
> +	}
> +}
> +
> +static void restore_args(int nregs, int args_off, struct rv_jit_context =
*ctx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nregs; i++) {
> +		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
> +		args_off -=3D 8;
> +	}
> +}
> +
> +static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int r=
etval_off,
> +			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> +{
> +	u32 insn;
> +	int ret, branch_off, offset;
> +	struct bpf_prog *p =3D l->link.prog;
> +	int cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
> +
> +	if (l->cookie) {
> +		emit_imm(RV_REG_T1, l->cookie, ctx);
> +		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
> +	} else {
> +		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
> +	}
> +
> +	/* arg1: prog */
> +	emit_imm(RV_REG_A0, (const s64)p, ctx);
> +	/* arg2: &run_ctx */
> +	emit_addi(RV_REG_A1, RV_REG_FP, -run_ctx_off, ctx);
> +	ret =3D emit_call((const u64)bpf_trampoline_enter(p), true, ctx);
> +	if (ret)
> +		return ret;
> +
> +	/* if (__bpf_prog_enter(prog) =3D=3D 0)
> +	 *	goto skip_exec_of_prog;
> +	 */
> +	branch_off =3D ctx->ninsns;
> +	/* nop reserved for conditional jump */
> +	emit(rv_nop(), ctx);
> +
> +	/* store prog start time */
> +	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
> +
> +	/* arg1: &args_off */
> +	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
> +	if (!p->jited)
> +		/* arg2: progs[i]->insnsi for interpreter */
> +		emit_imm(RV_REG_A1, (const s64)p->insnsi, ctx);
> +	ret =3D emit_call((const u64)p->bpf_func, true, ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (save_ret)
> +		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
> +
> +	/* update branch with beqz */
> +	offset =3D ninsns_rvoff(ctx->ninsns - branch_off);
> +	insn =3D rv_beq(RV_REG_A0, RV_REG_ZERO, offset >> 1);
> +	*(u32 *)(ctx->insns + branch_off) =3D insn;
> +
> +	/* arg1: prog */
> +	emit_imm(RV_REG_A0, (const s64)p, ctx);
> +	/* arg2: prog start time */
> +	emit_mv(RV_REG_A1, RV_REG_S1, ctx);
> +	/* arg3: &run_ctx */
> +	emit_addi(RV_REG_A2, RV_REG_FP, -run_ctx_off, ctx);
> +	ret =3D emit_call((const u64)bpf_trampoline_exit(p), true, ctx);
> +
> +	return ret;
> +}
> +
> +static int invoke_bpf_mod_ret(struct bpf_tramp_links *tl, int args_off, =
int retval_off,
> +			      int run_ctx_off, int *branches_off, struct rv_jit_context *ctx)
> +{
> +	int i, ret;
> +
> +	/* cleanup to avoid garbage return value confusion */
> +	emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
> +	for (i =3D 0; i < tl->nr_links; i++) {
> +		ret =3D invoke_bpf_prog(tl->links[i], args_off, retval_off,
> +				run_ctx_off, true, ctx);
> +		if (ret)
> +			return ret;
> +		emit_ld(RV_REG_T1, -retval_off, RV_REG_FP, ctx);
> +		branches_off[i] =3D ctx->ninsns;
> +		/* nop reserved for conditional jump */
> +		emit(rv_nop(), ctx);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> +					 const struct btf_func_model *m,
> +					 struct bpf_tramp_links *tlinks,
> +					 void *func_addr, u32 flags,
> +					 struct rv_jit_context *ctx)
> +{
> +	int i, ret, offset;
> +	int *branches_off =3D NULL;
> +	int stack_size =3D 0, nregs =3D m->nr_args;
> +	int retaddr_off, fp_off, retval_off, args_off;
> +	int nregs_off, ip_off, run_ctx_off, sreg_off;
> +	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> +	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> +	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
> +	void *orig_call =3D func_addr;
> +	bool save_ret;
> +	u32 insn;
> +
> +	/* Generated trampoline stack layout:
> +	 *
> +	 * FP - 8	    [ RA of parent func	] return address of parent
> +	 *					  function
> +	 * FP - retaddr_off [ RA of traced func	] return address of traced
> +	 *					  function
> +	 * FP - fp_off	    [ FP of parent func ]
> +	 *
> +	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
> +	 *					  BPF_TRAMP_F_RET_FENTRY_RET
> +	 *                  [ argN              ]
> +	 *                  [ ...               ]
> +	 * FP - args_off    [ arg1              ]
> +	 *
> +	 * FP - nregs_off   [ regs count        ]
> +	 *
> +	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
> +	 *
> +	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
> +	 *
> +	 * FP - sreg_off    [ callee saved reg	]
> +	 *
> +	 *		    [ pads              ] pads for 16 bytes alignment
> +	 */
> +
> +	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
> +		return -ENOTSUPP;
> +
> +	/* extra regiters for struct arguments */
> +	for (i =3D 0; i < m->nr_args; i++)
> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> +			nregs +=3D round_up(m->arg_size[i], 8) / 8 - 1;
> +
> +	/* 8 arguments passed by registers */
> +	if (nregs > 8)
> +		return -ENOTSUPP;
> +
> +	/* room for parent function return address */
> +	stack_size +=3D 8;
> +
> +	stack_size +=3D 8;
> +	retaddr_off =3D stack_size;
> +
> +	stack_size +=3D 8;
> +	fp_off =3D stack_size;
> +
> +	save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RE=
T);
> +	if (save_ret) {
> +		stack_size +=3D 8;
> +		retval_off =3D stack_size;
> +	}
> +
> +	stack_size +=3D nregs * 8;
> +	args_off =3D stack_size;
> +
> +	stack_size +=3D 8;
> +	nregs_off =3D stack_size;
> +
> +	if (flags & BPF_TRAMP_F_IP_ARG) {
> +		stack_size +=3D 8;
> +		ip_off =3D stack_size;
> +	}
> +
> +	stack_size +=3D round_up(sizeof(struct bpf_tramp_run_ctx), 8);
> +	run_ctx_off =3D stack_size;
> +
> +	stack_size +=3D 8;
> +	sreg_off =3D stack_size;
> +
> +	stack_size =3D round_up(stack_size, 16);
> +
> +	emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
> +
> +	emit_sd(RV_REG_SP, stack_size - retaddr_off, RV_REG_RA, ctx);
> +	emit_sd(RV_REG_SP, stack_size - fp_off, RV_REG_FP, ctx);
> +
> +	emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
> +
> +	/* callee saved register S1 to pass start time */
> +	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
> +
> +	/* store ip address of the traced function */
> +	if (flags & BPF_TRAMP_F_IP_ARG) {
> +		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
> +		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
> +	}
> +
> +	emit_li(RV_REG_T1, nregs, ctx);
> +	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
> +
> +	store_args(nregs, args_off, ctx);
> +
> +	/* skip to actual body of traced function */
> +	if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +		orig_call +=3D 16;
> +
> +	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +		emit_imm(RV_REG_A0, (const s64)im, ctx);
> +		ret =3D emit_call((const u64)__bpf_tramp_enter, true, ctx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < fentry->nr_links; i++) {
> +		ret =3D invoke_bpf_prog(fentry->links[i], args_off, retval_off, run_ct=
x_off,
> +				      flags & BPF_TRAMP_F_RET_FENTRY_RET, ctx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (fmod_ret->nr_links) {
> +		branches_off =3D kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
> +		if (!branches_off)
> +			return -ENOMEM;
> +
> +		ret =3D invoke_bpf_mod_ret(fmod_ret, args_off, retval_off, run_ctx_off,
> +					 branches_off, ctx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +		restore_args(nregs, args_off, ctx);
> +		ret =3D emit_call((const u64)orig_call, true, ctx);
> +		if (ret)
> +			return ret;
> +		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
> +		/* nop reserved for bpf_tramp_image_put */
> +		im->ip_after_call =3D ctx->insns + ctx->ninsns;
> +		emit(rv_nop(), ctx);
> +	}
> +
> +	/* update branches saved in invoke_bpf_mod_ret with bnez */
> +	for (i =3D 0; i < fmod_ret->nr_links; i++) {
> +		offset =3D ninsns_rvoff(ctx->ninsns - branches_off[i]);
> +		insn =3D rv_bne(RV_REG_T1, RV_REG_ZERO, offset >> 1);
> +		*(u32 *)(ctx->insns + branches_off[i]) =3D insn;
> +	}
> +
> +	for (i =3D 0; i < fexit->nr_links; i++) {
> +		ret =3D invoke_bpf_prog(fexit->links[i], args_off, retval_off,
> +				      run_ctx_off, false, ctx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +		im->ip_epilogue =3D ctx->insns + ctx->ninsns;
> +		emit_imm(RV_REG_A0, (const s64)im, ctx);
> +		ret =3D emit_call((const u64)__bpf_tramp_exit, true, ctx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> +		restore_args(nregs, args_off, ctx);
> +
> +	if (save_ret)
> +		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
> +
> +	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
> +
> +	if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +		/* return address of parent function */
> +		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
> +	else
> +		/* return address of traced function */
> +		emit_ld(RV_REG_RA, stack_size - retaddr_off, RV_REG_SP, ctx);
> +
> +	emit_ld(RV_REG_FP, stack_size - fp_off, RV_REG_SP, ctx);
> +	emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
> +
> +	emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
> +
> +	bpf_flush_icache(ctx->insns, ctx->insns + ctx->ninsns);
> +
> +	kfree(branches_off);
> +
> +	return ctx->ninsns;
> +
> +}
> +
> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
> +				void *image_end, const struct btf_func_model *m,
> +				u32 flags, struct bpf_tramp_links *tlinks,
> +				void *func_addr)
> +{
> +	int ret;
> +	struct rv_jit_context ctx;
> +
> +	ctx.ninsns =3D 0;
> +	ctx.insns =3D image;
> +	ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, =
&ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ninsns_rvoff(ret) > (long)image_end - (long)image)
> +		return -EFBIG;

This looks risky! First you generate the image, and here you realize
that you already wrote in all the wrong places?!

> +
> +	return ninsns_rvoff(ret);

Ok, this was a bit subtle to me. The return value of the this function
is used in kernel/bpf/bpf_struct_ops.c. Now I know! :-)


Thanks!
Bj=C3=B6rn
