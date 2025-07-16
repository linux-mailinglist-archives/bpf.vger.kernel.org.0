Return-Path: <bpf+bounces-63396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC4B06BAC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625CF188891B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD19274B34;
	Wed, 16 Jul 2025 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMXflEoa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043002741D4
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632931; cv=none; b=RPeU2+cDI+Zgjn1aykLCTwqYVgX4LdJeEljQnTcdiXL1MQeICNsgiXHYM8xIh2Hjpt46pJ8wOelnfooqjr3p+/7LMYroQz3zp8Aqd8giprAFS/xbTNtNUN1+ah64Lg4wRwrxnj4zhWpyT46NjdCB2HmRW3CMUUhmHCa0gY1YHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632931; c=relaxed/simple;
	bh=AWfwmjnHvLE+MpT8hMlVet+rFcUn+f08eOzcek6CPYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s89CjX+2+tswwfjMq74SECc+jwnSlQuV08zvYCNTGXLr5J/gUi1OsShPHVJ7VDVX+9N9TJzLZROTgT+HBvfkiCnNxP+ObbMMmVc0AWSybj+SF5Up2+u3HhEbUZrkfcPx+0jspYj0FOZu9svdkz2LPOexAgWcRh4TEZ1a8BIa/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMXflEoa; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-41b309ce799so1448118b6e.2
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752632929; x=1753237729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Clf/r36wco3qYSSxwYtd6w4WQgNVaLyCiWy+Ub5pxb0=;
        b=dMXflEoabbI60LrvSQ1JRdAqM69No6ql3bT7qyrARmFa6aQXq5Ho0nAKqHGFcs5Q0i
         PpSDfp6IVj8t4Z7GqjsJl07i/fpA4WKnTl82aJ/vvkzzEBInuUbof1OrNcC3SAocpjC+
         EflxyXy6nHQMnTACiTLJRcC3u5x+9cKmimp7WMdRt3MyuetYibbw0sHQPoS+SfWab5cB
         ioAG5mbJhLLVeuQY9D4i0qzP+5b8jU6SwoJfa2zhjexYXsYunlGefCr62V2aZmq8yV76
         tsP3L0mBGYk/iRIuVwxGAInWaq+ixIbQK0p84LBImiEXbftsJRrxFAgDVW0TYHJb71Kh
         MV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752632929; x=1753237729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Clf/r36wco3qYSSxwYtd6w4WQgNVaLyCiWy+Ub5pxb0=;
        b=IM3wV8rfncJqFc2+X+YGHcT6XC4gLV4p+wQ7UfuIeCms+Ch5q4nWZwftyDlOXQJJ1/
         LMkmOgu0+zVnoS4iDGDxhLabREU9W/LNHwl7RerRpv2K3wOl897WIXhv2UnZEoryP1Yg
         Norgc4NZ0rZNJGzIcxzcsI9n3c7j5o3YOuPg2duqcKPcEYaI1dvWD5UhRK58zs5eFvMi
         2H+7jtOP5YCehCVifekGCcEMO7dSM29n17AubnKhJK0O85TpKKdMt+Xo+/HYxShfDM88
         RJzwVkArFAEODJ0QLiZLcJWmGr8DJ0EuVzzX2nVg8jlv2j+93XwmVxyL7nbRj6U2qb6g
         xgXw==
X-Forwarded-Encrypted: i=1; AJvYcCWViDNNeOaOqqE4aFeiq3bZnlj4v3XDZDpAKgL5bu1ZiuGsmUCEabgOU874+/J5AydRRjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVgcZz47a36TuTlotfFQts7X1ehor9Dg5TsXnACFIQeuNCYoO
	uo8NCxHvcq8ppUjcolTlclJ/SmIeYyaNSN5IhH7jWmnIyoZas0md7Gi+CRwFjQJOTuotC3E/Hyy
	ptzZJdqiUwbG0SuxFoA+o+GDQK+tmNn8=
X-Gm-Gg: ASbGncu3wOB3uLGlEeOCin4FcK1BVvW6ZN+CQ5YGbS53LhXomAOtYBVlXE5uym08/XQ
	3FnZTbPxl8BHhwmNDIIIC8H32ZGz9QujKYHNoKmSHTLpnqBsgQkUKRizsa6nAz+dV/FZWzTdFnk
	0OoNolaOGXUbzdWT2wwoII3kTuWjAOUuuQhsOdSOZTgx0tfDZ2et7FPfqaMK03bVby5czJmDdMw
	l81eNo=
X-Google-Smtp-Source: AGHT+IFyHxeOWTqCoEZ7KsNuV0shRCjm/SggPFjouaNpDZNZjriJdpzqvaTwJvg0DRqNrOprmg5ThrtaZ1/nnNlTuCQ=
X-Received: by 2002:a05:6808:4f20:b0:406:794b:462 with SMTP id
 5614622812f47-41d006ed00bmr900738b6e.0.1752632928757; Tue, 15 Jul 2025
 19:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708071840.556686-1-jianghaoran@kylinos.cn> <20250708071840.556686-3-jianghaoran@kylinos.cn>
In-Reply-To: <20250708071840.556686-3-jianghaoran@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 16 Jul 2025 10:28:37 +0800
X-Gm-Features: Ac12FXysx7IqDDtECjqpg_t7a4pnzmEAh9SieM_kyWBiVLmrKiIFMBGxXkqKeQY
Message-ID: <CAEyhmHTSw-DKj+TLOwfKuSvvTq2cXRackaRCZDiK7ymh-jvpog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LoongArch: BPF: Fix tailcall hierarchy
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 3:19=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.cn=
> wrote:
>
> In specific use cases combining tailcalls and BPF-to-BPF calls=EF=BC=8C
> MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
> back-propagation from callee to caller=E3=80=82This patch fixes this
> tailcall issue caused by abusing the tailcall in bpf2bpf feature
> on LoongArch like the way of "bpf, x64: Fix tailcall hierarchy".
>
> push tail_call_cnt_ptr and tail_call_cnt into the stack,
> tail_call_cnt_ptr is passed between tailcall and bpf2bpf,
> uses tail_call_cnt_ptr to increment tail_call_cnt.
>
> Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcall=
s")
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 112 +++++++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 44 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 5061bfc978f2..45f804b7c556 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -7,10 +7,9 @@
>  #include "bpf_jit.h"
>
>  #define REG_TCC                LOONGARCH_GPR_A6
> -#define TCC_SAVED      LOONGARCH_GPR_S5
>
> -#define SAVE_RA                BIT(0)
> -#define SAVE_TCC       BIT(1)
> +#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80=
)
> +
>
>  static const int regmap[] =3D {
>         /* return value from in-kernel function, and exit value for eBPF =
program */
> @@ -32,32 +31,37 @@ static const int regmap[] =3D {
>         [BPF_REG_AX] =3D LOONGARCH_GPR_T0,
>  };
>
> -static void mark_call(struct jit_ctx *ctx)
> +static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_of=
fset)

Consider adding more comments(e.g. pseudocode) for prepare_bpf_tail_call_cn=
t().
Assembly is hard to read. (At least for me :))

>  {
> -       ctx->flags |=3D SAVE_RA;
> -}
> +       const struct bpf_prog *prog =3D ctx->prog;
> +       const bool is_main_prog =3D !bpf_is_subprog(prog);
>
> -static void mark_tail_call(struct jit_ctx *ctx)
> -{
> -       ctx->flags |=3D SAVE_TCC;
> -}
> +       if (is_main_prog) {
> +               emit_insn(ctx, addid, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZER=
O, MAX_TAIL_CALL_CNT);
> +               *store_offset -=3D sizeof(long);
>
> -static bool seen_call(struct jit_ctx *ctx)
> -{
> -       return (ctx->flags & SAVE_RA);
> -}
> +               emit_tailcall_jmp(ctx, BPF_JGT, REG_TCC, LOONGARCH_GPR_T3=
, 4);

Why emit_tailcall_jmp() here ? Shouldn't this be emit_cond_jmp() ?

>
> -static bool seen_tail_call(struct jit_ctx *ctx)
> -{
> -       return (ctx->flags & SAVE_TCC);
> -}
> +               /* If REG_TCC < MAX_TAIL_CALL_CNT, push REG_TCC into stac=
k */
> +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_off=
set);
>
> -static u8 tail_call_reg(struct jit_ctx *ctx)
> -{
> -       if (seen_call(ctx))
> -               return TCC_SAVED;
> +               /* Calculate the pointer to REG_TCC in the stack and assi=
gn it to REG_TCC */
> +               emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_SP, *store_o=
ffset);
> +
> +               emit_uncond_jmp(ctx, 2);
> +
> +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_off=
set);
>
> -       return REG_TCC;
> +               *store_offset -=3D sizeof(long);
> +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_off=
set);
> +
> +       } else {
> +               *store_offset -=3D sizeof(long);
> +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_off=
set);
> +
> +               *store_offset -=3D sizeof(long);
> +               emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_off=
set);
> +       }
>  }
>
>  /*
> @@ -80,6 +84,10 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
>   *                            |           $s4           |
>   *                            +-------------------------+
>   *                            |           $s5           |
> + *                            +-------------------------+
> + *                            |          reg_tcc        |
> + *                            +-------------------------+
> + *                            |          reg_tcc_ptr    |
>   *                            +-------------------------+ <--BPF_REG_FP
>   *                            |  prog->aux->stack_depth |
>   *                            |        (optional)       |
> @@ -89,21 +97,24 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
>  static void build_prologue(struct jit_ctx *ctx)
>  {
>         int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> +       const struct bpf_prog *prog =3D ctx->prog;
> +       const bool is_main_prog =3D !bpf_is_subprog(prog);
>
>         bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, 16);
>
> -       /* To store ra, fp, s0, s1, s2, s3, s4 and s5. */
> -       stack_adjust +=3D sizeof(long) * 8;
> +       /* To store ra, fp, s0, s1, s2, s3, s4, s5, reg_tcc and reg_tcc_p=
tr */
> +       stack_adjust +=3D sizeof(long) * 10;
>
>         stack_adjust =3D round_up(stack_adjust, 16);
>         stack_adjust +=3D bpf_stack_adjust;
>
>         /*
> -        * First instruction initializes the tail call count (TCC).
> -        * On tail call we skip this instruction, and the TCC is
> +        * First instruction initializes the tail call count (TCC) regist=
er
> +        * to zero. On tail call we skip this instruction, and the TCC is
>          * passed in REG_TCC from the caller.
>          */
> -       emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_=
CNT);
> +       if (is_main_prog)
> +               emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
>
>         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_=
adjust);
>
> @@ -131,20 +142,13 @@ static void build_prologue(struct jit_ctx *ctx)
>         store_offset -=3D sizeof(long);
>         emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_off=
set);
>
> +       prepare_bpf_tail_call_cnt(ctx, &store_offset);
> +
>         emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_a=
djust);
>
>         if (bpf_stack_adjust)
>                 emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_S=
P, bpf_stack_adjust);
>
> -       /*
> -        * Program contains calls and tail calls, so REG_TCC need
> -        * to be saved across calls.
> -        */
> -       if (seen_tail_call(ctx) && seen_call(ctx))
> -               move_reg(ctx, TCC_SAVED, REG_TCC);
> -       else
> -               emit_insn(ctx, nop);
> -
>         ctx->stack_size =3D stack_adjust;
>  }
>
> @@ -177,6 +181,17 @@ static void __build_epilogue(struct jit_ctx *ctx, bo=
ol is_tail_call)
>         load_offset -=3D sizeof(long);
>         emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offs=
et);
>
> +       /*
> +        *  When push into the stack, follow the order of tcc then tcc_pt=
r.
> +        *  When pop from the stack, first pop tcc_ptr followed by tcc
> +        */
> +       load_offset -=3D 2*sizeof(long);
> +       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> +
> +       /* pop tcc_ptr to REG_TCC */
> +       load_offset +=3D sizeof(long);
> +       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> +
>         emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_a=
djust);
>
>         if (!is_tail_call) {
> @@ -211,7 +226,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
>  static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
>  {
>         int off;
> -       u8 tcc =3D tail_call_reg(ctx);
> +       int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_si=
ze);
>         u8 a1 =3D LOONGARCH_GPR_A1;
>         u8 a2 =3D LOONGARCH_GPR_A2;
>         u8 t1 =3D LOONGARCH_GPR_T1;
> @@ -240,11 +255,15 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, =
int insn)
>                 goto toofar;
>
>         /*
> -        * if (--TCC < 0)
> -        *       goto out;
> +        * if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
> +        *      goto out;
>          */
> -       emit_insn(ctx, addid, REG_TCC, tcc, -1);
> -       if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO,=
 jmp_offset) < 0)
> +       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
> +       emit_insn(ctx, ldd, t3, REG_TCC, 0);
> +       emit_insn(ctx, addid, t3, t3, 1);
> +       emit_insn(ctx, std, t3, REG_TCC, 0);
> +       emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> +       if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) < 0)
>                 goto toofar;
>
>         /*
> @@ -465,6 +484,7 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>         const s16 off =3D insn->off;
>         const s32 imm =3D insn->imm;
>         const bool is32 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU || BPF_C=
LASS(insn->code) =3D=3D BPF_JMP32;
> +       int tcc_ptr_off;
>
>         switch (code) {
>         /* dst =3D src */
> @@ -891,12 +911,17 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>
>         /* function call */
>         case BPF_JMP | BPF_CALL:
> -               mark_call(ctx);
>                 ret =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass=
,
>                                             &func_addr, &func_addr_fixed)=
;
>                 if (ret < 0)
>                         return ret;
>
> +               if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
> +                       tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(c=
tx->stack_size);
> +                       emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tc=
c_ptr_off);
> +               }
> +
> +
>                 move_addr(ctx, t1, func_addr);
>                 emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
>
> @@ -907,7 +932,6 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>
>         /* tail call */
>         case BPF_JMP | BPF_TAIL_CALL:
> -               mark_tail_call(ctx);
>                 if (emit_bpf_tail_call(ctx, i) < 0)
>                         return -EINVAL;
>                 break;
> --
> 2.43.0
>

