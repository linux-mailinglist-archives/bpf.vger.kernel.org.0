Return-Path: <bpf+bounces-76391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CCCB20E0
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C54A303D9F0
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67030F922;
	Wed, 10 Dec 2025 06:17:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCB2236EE;
	Wed, 10 Dec 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765347429; cv=none; b=GPsuipgIk+9avClsBsz3xVY+8enAb7tPHXLej0Dy9KxPdXr3ZIIgGRfqbNQ9Fzu6Ec66n9CrU8lRvBVA/FDpH6A80OW2kutgzh76QMknafKcNI0+OYSwfdA3bGqK0YkcDXsb2zg4jwasEFdFLK961MkrYmY9+j/QD0Of4pD5tOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765347429; c=relaxed/simple;
	bh=9ZRs8Lm/tKnpuiFL+drt2KQF5MqZL5pNE7w7BIsLeuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7PjX1XklTMOhN+jmwbgcRlayo2/yPAQz2JPZCesRIxHQ0ZlH7YUVMHCBC+qt9dQlyBj7DQRE3+VNDM1OvpuI4g87xXKlSqh9WF58dk6fDjJi4N7JRreV5dtG1e64H09xEkaXO4Nt5W4HyUKy70Dj26krmoZK0r75js/LRxWrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d30f280cd58f11f0a38c85956e01ac42-20251210
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1891a32a-2673-4345-b8cb-ce06194efe15,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:a6d3704e4094d38e4be376f119ae45c2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|850|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d30f280cd58f11f0a38c85956e01ac42-20251210
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1862478082; Wed, 10 Dec 2025 14:16:54 +0800
Date: Wed, 10 Dec 2025 14:16:52 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name,
	zhangtianyang@loongson.cn, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v1 1/2] LoongArch: Modify the jump logic of the trampoline
Message-ID: <20251210061652.GC691118@chenghao-pc>
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
 <20251209093405.1309253-2-duanchenghao@kylinos.cn>
 <CAEyhmHThf_i3xLcm4m7ZYo168tH5j5pCtC26cz4HKbwxh-1vuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHThf_i3xLcm4m7ZYo168tH5j5pCtC26cz4HKbwxh-1vuA@mail.gmail.com>

On Wed, Dec 10, 2025 at 12:15:28PM +0800, Hengqi Chen wrote:
> On Tue, Dec 9, 2025 at 5:34 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > There are two methods to jump into the trampoline code for execution:
> > 1. ftrace-managed.
> > 2. Direct call.
> >
> > Whether ftrace-managed or direct jump, ensure before trampoline entry:
> > t0=parent func return addr, ra=traced func return addr.
> > When managed by ftrace, the trampoline code execution flow utilizes
> > ftrace direct call, and it is required to ensure that the original
> > data in registers t0 and ra is not modification.
> >
> > samples/ftrace/ftrace-direct_xxxx.c: update test code for ftrace direct
> > call (modify together).
> >
> > Trampoline: adjust jump logic to use t0 (parent func return addr) and
> > ra (traced func return addr) as jump targets for respective scenarios
> >
> > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> 
> Please add a Fixes tag.

I believe this is an issue introduced by the combination of trampoline and
ftrace. Prior to this, ftrace direct call had not been used by other
technologies. If a fix point is to be selected, it would be the initial
commit of the ftrace direct call technology.

Fixes: 9cdc3b6a299c (LoongArch: ftrace: Add direct call support)

> 
> > ---
> >  arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
> >  arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
> >  samples/ftrace/ftrace-direct-modify.c       |  8 ++---
> >  samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
> >  samples/ftrace/ftrace-direct-multi.c        |  4 +--
> >  samples/ftrace/ftrace-direct-too.c          |  4 +--
> >  samples/ftrace/ftrace-direct.c              |  4 +--
> >  7 files changed, 50 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
> > index d6b474ad1d5e..5729c20e5b8b 100644
> > --- a/arch/loongarch/kernel/mcount_dyn.S
> > +++ b/arch/loongarch/kernel/mcount_dyn.S
> > @@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
> >   * at the callsite, so there is no need to restore the T series regs.
> >   */
> >  ftrace_common_return:
> > -       PTR_L           ra, sp, PT_R1
> >         PTR_L           a0, sp, PT_R4
> >         PTR_L           a1, sp, PT_R5
> >         PTR_L           a2, sp, PT_R6
> > @@ -104,12 +103,17 @@ ftrace_common_return:
> >         PTR_L           a6, sp, PT_R10
> >         PTR_L           a7, sp, PT_R11
> >         PTR_L           fp, sp, PT_R22
> > -       PTR_L           t0, sp, PT_ERA
> >         PTR_L           t1, sp, PT_R13
> > -       PTR_ADDI        sp, sp, PT_SIZE
> >         bnez            t1, .Ldirect
> > +
> > +       PTR_L           ra, sp, PT_R1
> > +       PTR_L           t0, sp, PT_ERA
> > +       PTR_ADDI        sp, sp, PT_SIZE
> >         jr              t0
> >  .Ldirect:
> > +       PTR_L           t0, sp, PT_R1
> > +       PTR_L           ra, sp, PT_ERA
> > +       PTR_ADDI        sp, sp, PT_SIZE
> >         jr              t1
> >  SYM_CODE_END(ftrace_common)
> >
> > @@ -161,6 +165,8 @@ SYM_CODE_END(return_to_handler)
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  SYM_CODE_START(ftrace_stub_direct_tramp)
> >         UNWIND_HINT_UNDEFINED
> > -       jr              t0
> > +       move            t1, ra
> > +       move            ra, t0
> > +       jr              t1
> >  SYM_CODE_END(ftrace_stub_direct_tramp)
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index 8dc58781b8eb..d1f5fd5ae847 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -139,6 +139,7 @@ static void build_prologue(struct jit_ctx *ctx)
> >         stack_adjust = round_up(stack_adjust, 16);
> >         stack_adjust += bpf_stack_adjust;
> >
> > +       move_reg(ctx, LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
> >         /* Reserve space for the move_imm + jirl instruction */
> >         for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
> >                 emit_insn(ctx, nop);
> > @@ -238,7 +239,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
> >                  * Call the next bpf prog and skip the first instruction
> >                  * of TCC initialization.
> >                  */
> > -               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 6);
> > +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 7);
> >         }
> >  }
> >
> > @@ -1265,7 +1266,7 @@ static int emit_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
> >                 return 0;
> >         }
> >
> > -       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO, (u64)target);
> > +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_RA : LOONGARCH_GPR_ZERO, (u64)target);
> >  }
> >
> >  static int emit_call(struct jit_ctx *ctx, u64 addr)
> > @@ -1289,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
> >                        void *new_addr)
> >  {
> >         int ret;
> > +       unsigned long size = 0;
> > +       unsigned long offset = 0;
> > +       char namebuf[KSYM_NAME_LEN];
> > +       void *image = NULL;
> >         bool is_call;
> >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> > @@ -1296,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
> >         /* Only poking bpf text is supported. Since kernel function entry
> >          * is set up by ftrace, we rely on ftrace to poke kernel functions.
> >          */
> > -       if (!is_bpf_text_address((unsigned long)ip))
> > +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
> >                 return -ENOTSUPP;
> >
> > +       image = ip - offset;
> > +       /* zero offset means we're poking bpf prog entry */
> > +       if (offset == 0)
> > +               /* skip to the nop instruction in bpf prog entry:
> > +                * move t0, ra
> > +                * nop
> > +                */
> > +               ip = image + LOONGARCH_INSN_SIZE;
> > +
> >         is_call = old_t == BPF_MOD_CALL;
> >         ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> >         if (ret)
> > @@ -1622,14 +1636,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
> >
> >         /* To traced function */
> >         /* Ftrace jump skips 2 NOP instructions */
> > -       if (is_kernel_text((unsigned long)orig_call))
> > +       if (is_kernel_text((unsigned long)orig_call) || is_module_text_address((unsigned long)orig_call))
> >                 orig_call += LOONGARCH_FENTRY_NBYTES;
> >         /* Direct jump skips 5 NOP instructions */
> >         else if (is_bpf_text_address((unsigned long)orig_call))
> >                 orig_call += LOONGARCH_BPF_FENTRY_NBYTES;
> > -       /* Module tracing not supported - cause kernel lockups */
> > -       else if (is_module_text_address((unsigned long)orig_call))
> > -               return -ENOTSUPP;
> >
> >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> >                 move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
> > @@ -1722,12 +1733,16 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
> >                 emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> >                 emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> >
> > -               if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > +               if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> >                         /* return to parent function */
> > -                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
> > -               else
> > -                       /* return to traced function */
> > +                       move_reg(ctx, LOONGARCH_GPR_RA, LOONGARCH_GPR_T0);
> >                         emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
> > +               } else {
> > +                       /* return to traced function */
> > +                       move_reg(ctx, LOONGARCH_GPR_T1, LOONGARCH_GPR_RA);
> > +                       move_reg(ctx, LOONGARCH_GPR_RA, LOONGARCH_GPR_T0);
> > +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T1, 0);
> > +               }
> >         }
> >
> >         ret = ctx->idx;
> > diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> > index da3a9f2091f5..1ba1927b548e 100644
> > --- a/samples/ftrace/ftrace-direct-modify.c
> > +++ b/samples/ftrace/ftrace-direct-modify.c
> > @@ -176,8 +176,8 @@ asm (
> >  "      st.d    $t0, $sp, 0\n"
> >  "      st.d    $ra, $sp, 8\n"
> >  "      bl      my_direct_func1\n"
> > -"      ld.d    $t0, $sp, 0\n"
> > -"      ld.d    $ra, $sp, 8\n"
> > +"      ld.d    $ra, $sp, 0\n"
> > +"      ld.d    $t0, $sp, 8\n"
> >  "      addi.d  $sp, $sp, 16\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp1, .-my_tramp1\n"
> > @@ -189,8 +189,8 @@ asm (
> >  "      st.d    $t0, $sp, 0\n"
> >  "      st.d    $ra, $sp, 8\n"
> >  "      bl      my_direct_func2\n"
> > -"      ld.d    $t0, $sp, 0\n"
> > -"      ld.d    $ra, $sp, 8\n"
> > +"      ld.d    $ra, $sp, 0\n"
> > +"      ld.d    $t0, $sp, 8\n"
> >  "      addi.d  $sp, $sp, 16\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp2, .-my_tramp2\n"
> > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> > index 8f7986d698d8..7a7822dfeb50 100644
> > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > @@ -199,8 +199,8 @@ asm (
> >  "      move    $a0, $t0\n"
> >  "      bl      my_direct_func1\n"
> >  "      ld.d    $a0, $sp, 0\n"
> > -"      ld.d    $t0, $sp, 8\n"
> > -"      ld.d    $ra, $sp, 16\n"
> > +"      ld.d    $ra, $sp, 8\n"
> > +"      ld.d    $t0, $sp, 16\n"
> >  "      addi.d  $sp, $sp, 32\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp1, .-my_tramp1\n"
> > @@ -215,8 +215,8 @@ asm (
> >  "      move    $a0, $t0\n"
> >  "      bl      my_direct_func2\n"
> >  "      ld.d    $a0, $sp, 0\n"
> > -"      ld.d    $t0, $sp, 8\n"
> > -"      ld.d    $ra, $sp, 16\n"
> > +"      ld.d    $ra, $sp, 8\n"
> > +"      ld.d    $t0, $sp, 16\n"
> >  "      addi.d  $sp, $sp, 32\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp2, .-my_tramp2\n"
> > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> > index db326c81a27d..3fe6ddaf0b69 100644
> > --- a/samples/ftrace/ftrace-direct-multi.c
> > +++ b/samples/ftrace/ftrace-direct-multi.c
> > @@ -131,8 +131,8 @@ asm (
> >  "      move    $a0, $t0\n"
> >  "      bl      my_direct_func\n"
> >  "      ld.d    $a0, $sp, 0\n"
> > -"      ld.d    $t0, $sp, 8\n"
> > -"      ld.d    $ra, $sp, 16\n"
> > +"      ld.d    $ra, $sp, 8\n"
> > +"      ld.d    $t0, $sp, 16\n"
> >  "      addi.d  $sp, $sp, 32\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp, .-my_tramp\n"
> > diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> > index 3d0fa260332d..bf2411aa6fd7 100644
> > --- a/samples/ftrace/ftrace-direct-too.c
> > +++ b/samples/ftrace/ftrace-direct-too.c
> > @@ -143,8 +143,8 @@ asm (
> >  "      ld.d    $a0, $sp, 0\n"
> >  "      ld.d    $a1, $sp, 8\n"
> >  "      ld.d    $a2, $sp, 16\n"
> > -"      ld.d    $t0, $sp, 24\n"
> > -"      ld.d    $ra, $sp, 32\n"
> > +"      ld.d    $ra, $sp, 24\n"
> > +"      ld.d    $t0, $sp, 32\n"
> >  "      addi.d  $sp, $sp, 48\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp, .-my_tramp\n"
> > diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> > index 956834b0d19a..5368c8c39cbb 100644
> > --- a/samples/ftrace/ftrace-direct.c
> > +++ b/samples/ftrace/ftrace-direct.c
> > @@ -124,8 +124,8 @@ asm (
> >  "      st.d    $ra, $sp, 16\n"
> >  "      bl      my_direct_func\n"
> >  "      ld.d    $a0, $sp, 0\n"
> > -"      ld.d    $t0, $sp, 8\n"
> > -"      ld.d    $ra, $sp, 16\n"
> > +"      ld.d    $ra, $sp, 8\n"
> > +"      ld.d    $t0, $sp, 16\n"
> >  "      addi.d  $sp, $sp, 32\n"
> >  "      jr      $t0\n"
> >  "      .size           my_tramp, .-my_tramp\n"
> > --
> > 2.25.1
> >

