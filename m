Return-Path: <bpf+bounces-76386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6AFCB1E30
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 05:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3213041987
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 04:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C060280336;
	Wed, 10 Dec 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzA6kY38"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA6173
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765340143; cv=none; b=hsm4tOXQkmac4Tqqj3/32VII0t7LDpLZhRCoTGAYAUyFN2FJTdb7A20V0ADd04KDXH7f+JAYSRoss/cQaGFdxyBhyOmSDuafG/ITK2u5Q+OREb+jWUY8Da5URq1jMvbDUfkclTuwuJKU9EO814fRrRtxUVyzsC9I2P53mQaaTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765340143; c=relaxed/simple;
	bh=5EPaIR2R7g4CAggpBpfR1mSfB7/jXW4i2bsziBGLHYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKn7sgCF0v1w1+K3vUNHIuTQusaAhI6fyIeo26yUPCkc0j+1Oq2JbYiZ/BwVp5GEaRSSBi73ENPBfnowuB7blrV9R2CUKXSno44JSVcUNPpQo3Hf642beJ6A3m7PCozcjoXZ2eiZLojO4xwY9duJCMujGxgf2TS4+dth4NUVNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzA6kY38; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45391956bfcso3642601b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 20:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765340139; x=1765944939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWvYemQmhncpEstG64l2sph/tNcUMcoJJBDBaG46h/M=;
        b=PzA6kY38WZfRcBctdcZh2NcAez1klaD9W9zokyIag5f+DqI0F1fL7zJ6MoUkR9HIhl
         Hjhsf1FtjmD9GYKU5iRRkr4btZoSgORYkZUMz8jN2Ij6zxkTVUEuH4z9Rv+blnO502DK
         74HfmcrvV6hNg/+Nbw+Q5pvWDalKv02xk6p0TgFzrU3nqskPZrh5xzFqdZhpb92fUOqc
         LLRO2PO4UY21leY9WKcu0jaDBJG1gDTRAoQ8uGjbyCEv4yNaxLoAF2JbSmd9in5Uq0kS
         y6D5XtzPWmOHTPZRjeYx3W71GGOgAkGfOfR79avygNRtn8sCnDGWcCwWoSSj0+cWfNRr
         5Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765340139; x=1765944939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWvYemQmhncpEstG64l2sph/tNcUMcoJJBDBaG46h/M=;
        b=enRudeYa5qk/bh6s8ERnIDf40+XMyY6HUhBu3WG6abfncv6JhQRjpNNtT7aaI1L+t6
         nM/aLamZS91NmL7j8+RDXBKPX8D1zoJAVI7a76DMeLbjm7IJvQktGqEMXvyeyIAP6DKd
         eESo6NnZ2Kl6E9Fj70rDTDwFA5+ZjmvAwNxlpvHsO9skObKlHghmrH0r1zR1DeG/15xH
         3IT7ulPH2s4r8Cfknzhc49vQH9yvhb2tgSHLbwAq8WUqvpi4pofkp755l2sLKyEy87Zd
         p9qDBraoSvl+8CkBQy82Hack5UeKFUp6+qCXDNuCCOIROcCIDLIzeAfDlddbNa422c84
         E6SA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YvCY6yM6/N9W9FSc2jxQGx9xgI+1S6KUW1PM8GPLKp/KdkKMfTIsSr7PWiNJLNT+sj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOm7I0yNSb21WMzBTlqptq4axX2NUnx6gktf8vgGsKBIkNoBl8
	+PkyLkTC17UL7NXlDPbjfs6/TwYTNtSvMU5BYjoIo10PwWMW8Y7UxILEPIY/2kSu2HWnJPIrdO+
	FgX/DXXKZUHN6nb6H6LhuGejLPwAlX7Y=
X-Gm-Gg: ASbGncs2kLThGwO0E1bRTw0QWHZs+AlZCF7rjAJzU2bLYcLdebqm2izc5Updej/BbRB
	0x6c5PHhX7SLmXxAoOhiSJmZrYFYIyYudF/wmu9RkiSVaF+2y7ZByqJ4szS9QLOFnCVFRmvQdx2
	pKAGDhRRa7qHGLFDobVesEek5/FFsxI55DcZ/1+gKWC4QstzCU0I56nGdGUz2eVdygn/wBpddES
	71QB6yPjQ++Y3F7MDRpKXQTea7doeOcm8JAlxWzmNwbkLpWpTsiCVqgpdPHGAXPNHKdFJ0=
X-Google-Smtp-Source: AGHT+IG9shwNGkCIPXbqnZ3hLxQXnM0fPOmE8ueIuhwP/BGqCHypJxaZs1+1irYu36EjoHFu20/Hw8px6n/4kjrMlJU=
X-Received: by 2002:a05:6808:1981:b0:450:c5db:32bf with SMTP id
 5614622812f47-455863d289amr756333b6e.23.1765340139444; Tue, 09 Dec 2025
 20:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn> <20251209093405.1309253-2-duanchenghao@kylinos.cn>
In-Reply-To: <20251209093405.1309253-2-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 10 Dec 2025 12:15:28 +0800
X-Gm-Features: AQt7F2oWZxvj2sd35sJSbyXY3cHMEkhh5lB1jMgUyEaGOWlfRRufyuX8QpS69Z8
Message-ID: <CAEyhmHThf_i3xLcm4m7ZYo168tH5j5pCtC26cz4HKbwxh-1vuA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: Modify the jump logic of the trampoline
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, guodongtai@kylinos.cn, 
	youling.tang@linux.dev, jianghaoran@kylinos.cn, vincent.mc.li@gmail.com, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 5:34=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> There are two methods to jump into the trampoline code for execution:
> 1. ftrace-managed.
> 2. Direct call.
>
> Whether ftrace-managed or direct jump, ensure before trampoline entry:
> t0=3Dparent func return addr, ra=3Dtraced func return addr.
> When managed by ftrace, the trampoline code execution flow utilizes
> ftrace direct call, and it is required to ensure that the original
> data in registers t0 and ra is not modification.
>
> samples/ftrace/ftrace-direct_xxxx.c: update test code for ftrace direct
> call (modify together).
>
> Trampoline: adjust jump logic to use t0 (parent func return addr) and
> ra (traced func return addr) as jump targets for respective scenarios
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>

Please add a Fixes tag.

> ---
>  arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
>  arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
>  samples/ftrace/ftrace-direct-modify.c       |  8 ++---
>  samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
>  samples/ftrace/ftrace-direct-multi.c        |  4 +--
>  samples/ftrace/ftrace-direct-too.c          |  4 +--
>  samples/ftrace/ftrace-direct.c              |  4 +--
>  7 files changed, 50 insertions(+), 29 deletions(-)
>
> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/m=
count_dyn.S
> index d6b474ad1d5e..5729c20e5b8b 100644
> --- a/arch/loongarch/kernel/mcount_dyn.S
> +++ b/arch/loongarch/kernel/mcount_dyn.S
> @@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
>   * at the callsite, so there is no need to restore the T series regs.
>   */
>  ftrace_common_return:
> -       PTR_L           ra, sp, PT_R1
>         PTR_L           a0, sp, PT_R4
>         PTR_L           a1, sp, PT_R5
>         PTR_L           a2, sp, PT_R6
> @@ -104,12 +103,17 @@ ftrace_common_return:
>         PTR_L           a6, sp, PT_R10
>         PTR_L           a7, sp, PT_R11
>         PTR_L           fp, sp, PT_R22
> -       PTR_L           t0, sp, PT_ERA
>         PTR_L           t1, sp, PT_R13
> -       PTR_ADDI        sp, sp, PT_SIZE
>         bnez            t1, .Ldirect
> +
> +       PTR_L           ra, sp, PT_R1
> +       PTR_L           t0, sp, PT_ERA
> +       PTR_ADDI        sp, sp, PT_SIZE
>         jr              t0
>  .Ldirect:
> +       PTR_L           t0, sp, PT_R1
> +       PTR_L           ra, sp, PT_ERA
> +       PTR_ADDI        sp, sp, PT_SIZE
>         jr              t1
>  SYM_CODE_END(ftrace_common)
>
> @@ -161,6 +165,8 @@ SYM_CODE_END(return_to_handler)
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  SYM_CODE_START(ftrace_stub_direct_tramp)
>         UNWIND_HINT_UNDEFINED
> -       jr              t0
> +       move            t1, ra
> +       move            ra, t0
> +       jr              t1
>  SYM_CODE_END(ftrace_stub_direct_tramp)
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 8dc58781b8eb..d1f5fd5ae847 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -139,6 +139,7 @@ static void build_prologue(struct jit_ctx *ctx)
>         stack_adjust =3D round_up(stack_adjust, 16);
>         stack_adjust +=3D bpf_stack_adjust;
>
> +       move_reg(ctx, LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
>         /* Reserve space for the move_imm + jirl instruction */
>         for (i =3D 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
>                 emit_insn(ctx, nop);
> @@ -238,7 +239,7 @@ static void __build_epilogue(struct jit_ctx *ctx, boo=
l is_tail_call)
>                  * Call the next bpf prog and skip the first instruction
>                  * of TCC initialization.
>                  */
> -               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3=
, 6);
> +               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3=
, 7);
>         }
>  }
>
> @@ -1265,7 +1266,7 @@ static int emit_jump_or_nops(void *target, void *ip=
, u32 *insns, bool is_call)
>                 return 0;
>         }
>
> -       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOON=
GARCH_GPR_ZERO, (u64)target);
> +       return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_RA : LOON=
GARCH_GPR_ZERO, (u64)target);
>  }
>
>  static int emit_call(struct jit_ctx *ctx, u64 addr)
> @@ -1289,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type old_t,
>                        void *new_addr)
>  {
>         int ret;
> +       unsigned long size =3D 0;
> +       unsigned long offset =3D 0;
> +       char namebuf[KSYM_NAME_LEN];
> +       void *image =3D NULL;
>         bool is_call;
>         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
>         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
> @@ -1296,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type old_t,
>         /* Only poking bpf text is supported. Since kernel function entry
>          * is set up by ftrace, we rely on ftrace to poke kernel function=
s.
>          */
> -       if (!is_bpf_text_address((unsigned long)ip))
> +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, name=
buf))
>                 return -ENOTSUPP;
>
> +       image =3D ip - offset;
> +       /* zero offset means we're poking bpf prog entry */
> +       if (offset =3D=3D 0)
> +               /* skip to the nop instruction in bpf prog entry:
> +                * move t0, ra
> +                * nop
> +                */
> +               ip =3D image + LOONGARCH_INSN_SIZE;
> +
>         is_call =3D old_t =3D=3D BPF_MOD_CALL;
>         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
>         if (ret)
> @@ -1622,14 +1636,11 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
>
>         /* To traced function */
>         /* Ftrace jump skips 2 NOP instructions */
> -       if (is_kernel_text((unsigned long)orig_call))
> +       if (is_kernel_text((unsigned long)orig_call) || is_module_text_ad=
dress((unsigned long)orig_call))
>                 orig_call +=3D LOONGARCH_FENTRY_NBYTES;
>         /* Direct jump skips 5 NOP instructions */
>         else if (is_bpf_text_address((unsigned long)orig_call))
>                 orig_call +=3D LOONGARCH_BPF_FENTRY_NBYTES;
> -       /* Module tracing not supported - cause kernel lockups */
> -       else if (is_module_text_address((unsigned long)orig_call))
> -               return -ENOTSUPP;
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
>                 move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
> @@ -1722,12 +1733,16 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
>                 emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0=
);
>                 emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,=
 16);
>
> -               if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +               if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>                         /* return to parent function */
> -                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARC=
H_GPR_RA, 0);
> -               else
> -                       /* return to traced function */
> +                       move_reg(ctx, LOONGARCH_GPR_RA, LOONGARCH_GPR_T0)=
;
>                         emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARC=
H_GPR_T0, 0);
> +               } else {
> +                       /* return to traced function */
> +                       move_reg(ctx, LOONGARCH_GPR_T1, LOONGARCH_GPR_RA)=
;
> +                       move_reg(ctx, LOONGARCH_GPR_RA, LOONGARCH_GPR_T0)=
;
> +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARC=
H_GPR_T1, 0);
> +               }
>         }
>
>         ret =3D ctx->idx;
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrac=
e-direct-modify.c
> index da3a9f2091f5..1ba1927b548e 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -176,8 +176,8 @@ asm (
>  "      st.d    $t0, $sp, 0\n"
>  "      st.d    $ra, $sp, 8\n"
>  "      bl      my_direct_func1\n"
> -"      ld.d    $t0, $sp, 0\n"
> -"      ld.d    $ra, $sp, 8\n"
> +"      ld.d    $ra, $sp, 0\n"
> +"      ld.d    $t0, $sp, 8\n"
>  "      addi.d  $sp, $sp, 16\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp1, .-my_tramp1\n"
> @@ -189,8 +189,8 @@ asm (
>  "      st.d    $t0, $sp, 0\n"
>  "      st.d    $ra, $sp, 8\n"
>  "      bl      my_direct_func2\n"
> -"      ld.d    $t0, $sp, 0\n"
> -"      ld.d    $ra, $sp, 8\n"
> +"      ld.d    $ra, $sp, 0\n"
> +"      ld.d    $t0, $sp, 8\n"
>  "      addi.d  $sp, $sp, 16\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp2, .-my_tramp2\n"
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace=
/ftrace-direct-multi-modify.c
> index 8f7986d698d8..7a7822dfeb50 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -199,8 +199,8 @@ asm (
>  "      move    $a0, $t0\n"
>  "      bl      my_direct_func1\n"
>  "      ld.d    $a0, $sp, 0\n"
> -"      ld.d    $t0, $sp, 8\n"
> -"      ld.d    $ra, $sp, 16\n"
> +"      ld.d    $ra, $sp, 8\n"
> +"      ld.d    $t0, $sp, 16\n"
>  "      addi.d  $sp, $sp, 32\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp1, .-my_tramp1\n"
> @@ -215,8 +215,8 @@ asm (
>  "      move    $a0, $t0\n"
>  "      bl      my_direct_func2\n"
>  "      ld.d    $a0, $sp, 0\n"
> -"      ld.d    $t0, $sp, 8\n"
> -"      ld.d    $ra, $sp, 16\n"
> +"      ld.d    $ra, $sp, 8\n"
> +"      ld.d    $t0, $sp, 16\n"
>  "      addi.d  $sp, $sp, 32\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp2, .-my_tramp2\n"
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace=
-direct-multi.c
> index db326c81a27d..3fe6ddaf0b69 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -131,8 +131,8 @@ asm (
>  "      move    $a0, $t0\n"
>  "      bl      my_direct_func\n"
>  "      ld.d    $a0, $sp, 0\n"
> -"      ld.d    $t0, $sp, 8\n"
> -"      ld.d    $ra, $sp, 16\n"
> +"      ld.d    $ra, $sp, 8\n"
> +"      ld.d    $t0, $sp, 16\n"
>  "      addi.d  $sp, $sp, 32\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp, .-my_tramp\n"
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-d=
irect-too.c
> index 3d0fa260332d..bf2411aa6fd7 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -143,8 +143,8 @@ asm (
>  "      ld.d    $a0, $sp, 0\n"
>  "      ld.d    $a1, $sp, 8\n"
>  "      ld.d    $a2, $sp, 16\n"
> -"      ld.d    $t0, $sp, 24\n"
> -"      ld.d    $ra, $sp, 32\n"
> +"      ld.d    $ra, $sp, 24\n"
> +"      ld.d    $t0, $sp, 32\n"
>  "      addi.d  $sp, $sp, 48\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp, .-my_tramp\n"
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direc=
t.c
> index 956834b0d19a..5368c8c39cbb 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -124,8 +124,8 @@ asm (
>  "      st.d    $ra, $sp, 16\n"
>  "      bl      my_direct_func\n"
>  "      ld.d    $a0, $sp, 0\n"
> -"      ld.d    $t0, $sp, 8\n"
> -"      ld.d    $ra, $sp, 16\n"
> +"      ld.d    $ra, $sp, 8\n"
> +"      ld.d    $t0, $sp, 16\n"
>  "      addi.d  $sp, $sp, 32\n"
>  "      jr      $t0\n"
>  "      .size           my_tramp, .-my_tramp\n"
> --
> 2.25.1
>

