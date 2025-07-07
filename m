Return-Path: <bpf+bounces-62492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925EEAFB347
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236441AA1657
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05A29ACC6;
	Mon,  7 Jul 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7CVL/tG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C01292B22
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891368; cv=none; b=mPFN2vYmvAfvnvzcXc2vH7r7zKCpYU9t4otB/QWvlkc3r+06sdSR3zuVx1KnyMMzTfEZl+aMY2a6SOE0cOqrlAvxiwJ6Dj+bP/H8+NcV0Yj8tIOYEqOoK6Yz0clTvNLC8Kpcx6qvx3gOWS4bGgOEpbUSxTsYf0vUtom0SFKaUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891368; c=relaxed/simple;
	bh=WYSDGwcHg8OIX9RqBrjunz46B6TPjO4W/Djpib6fDDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avwT9OvCyZL0hqMBJsef/BQuMS0hAVu/4BL+4S1tq1VDHNXIyxCOenSQpp5iDY4FVgNfCKeXb3/xIVND8fflhNnoXzmp3BqaUFwVuN09Am12xr3XvP1F1przjB75PRgOz2TkL1vsX/HbcekQWTmpRqZ9jdgKiv+iwORfPgCV9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7CVL/tG; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2edec6c5511so802332fac.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751891365; x=1752496165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig/s/402eBoi7g31vR2xi+h6kTIDzXfOUp6ly6hWS6k=;
        b=I7CVL/tGYculjYbkLC3/c/1ZF8MdyMzNZpcEEnq+WpMylmYpi4TTk89mSFbeF7+nv6
         w80NTnGUFz0meg3CaQ0yMwCVnmMsBtRj5KhLyZYUWgyVCEHJ9w+xhcw7AC91D7YdqsxO
         Qw4+q6U/rSqRcWC+3k6oN4+nQdUneul5znLUGDuJxr/ONTDPCNMN2nCeIOiS7b/JVlki
         3LF5n3D5rQxQ9Ssq3L7WD+48FCQ073V2Ar+xmN9mzQOo1OvBDlx6Cu+tzMnNcDyIpX6K
         lWPLuwoWQ95Rdfbo7eQdZ1wg4lGw8xEe7HEb9E/3bebu02HHqKXF47nnQWr6NSemse61
         3nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751891365; x=1752496165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig/s/402eBoi7g31vR2xi+h6kTIDzXfOUp6ly6hWS6k=;
        b=Y8EkJELja8h89FI1s5gaRGmkSGN/7BI/WWRgD+37azD/WQZod2JfHiZWl+Nn0D6E4v
         GEEs7L3hQ1vn7gf3Cgq6nqfDYBZD39jmiNrdxBjhWY2vMvafPep48IQv/UMqB/tXtYxq
         aydxBVR5y+ut0jo2gCWNNjcviyzTxIteCz+ntawb5UkC+BuQYgecAB0veKc2Q2fD909g
         fTd4A0HJrzHBIu25RU8Qhn/v/c7DaH+mPLpdNlhzwoxKEvTLpe9ZmMmaBG06p+CS1+Rn
         T6DLELeNutJBDZW+0tfKNjgt026KL+TFcw5H5z0vVlyYJBhCB3uZurmuUqhLX2amOjPO
         zoBA==
X-Forwarded-Encrypted: i=1; AJvYcCXXElR+GJunJ6akhgO6TraKPXfYze8W2ijQAtl1HMYx+eMCQO5Qqm0eOc9SlATVQerWkPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxzu29NIxlUPwwk6hxrgPT1hIHeVh0zqIfTZGOEXxJUy/0kJb
	PZHzQcdjYLYyiTnmeBUPaxk7XB3uTqQe7WnWz3c8UjSkORc7c/WWai7jmT+GVlwigfhBMFxuu4E
	mLfQkZ4fxRBaUjrrZEgBGfZpRjy8aXPY=
X-Gm-Gg: ASbGncuv/ywTyP9WQ772SjEUWtj37/ZjaByUXZKcwsGwEUQ/129VisWc6jyPV/0kX1d
	NIxUmAT/+aDCpxWjnYX49ILX2UJ4LWxlWqbuKo6g+wvvSdHuZxdo6/LFuqNwdMLIHqHOgs3TLkG
	SpmQMCjzJbAheF9zxQyc6sKJiiHXu/EoUU76lgWeZZSD4ZC9LuUscWjw==
X-Google-Smtp-Source: AGHT+IGjfbQXlcJdq6AfiTlJ2NtKQiElCO5wah47zgCs/xYCdc0Zw/03owgiiwuBoYblryFIg18K7zcqobSt34X01/Q=
X-Received: by 2002:a05:6808:6f88:b0:3fa:daa:dd8e with SMTP id
 5614622812f47-40d2da09d3dmr7539597b6e.35.1751891364669; Mon, 07 Jul 2025
 05:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701074110.525363-1-jianghaoran@kylinos.cn> <20250701074110.525363-2-jianghaoran@kylinos.cn>
In-Reply-To: <20250701074110.525363-2-jianghaoran@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 7 Jul 2025 20:29:13 +0800
X-Gm-Features: Ac12FXwPd8kVr1FDuARL12nl8c9dis4nb2dsaGqxOiCMrdxxHqaLk974QGA6lb0
Message-ID: <CAEyhmHSambz-UR8Aa1jRz+EuF8kH6=46HW18b56pAZTB7MoZVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: BPF: Optimize the calculation method of
 jmp_offset in the emit_bpf_tail_call function
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haoran,

On Tue, Jul 1, 2025 at 3:41=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.cn=
> wrote:
>
> For a ebpf subprog JIT=EF=BC=8Cthe last call bpf_int_jit_compile function=
 will
> directly enter the skip_init_ctx process. At this point, out_offset =3D -=
1,
> the jmp_offset in emit_bpf_tail_call is calculated
> by #define jmp_offset (out_offset - (cur_offset)) is a negative number,
> which does not meet expectations.The final generated assembly as follow.
>

OK, so this can be rephrased as:
The extra pass of bpf_int_jit_compile() skips JIT context initialization wh=
ich
essentially skips offset calculation leaving out_offset =3D -1 ...

> 54:     bgeu            $a2, $t1, -8        # 0x0000004c
> 58:     addi.d          $a6, $s5, -1
> 5c:     bltz            $a6, -16            # 0x0000004c
> 60:     alsl.d          $t2, $a2, $a1, 0x3
> 64:     ld.d            $t2, $t2, 264
> 68:     beq             $t2, $zero, -28     # 0x0000004c
>
> Before apply this patch, the follow test case will reveal soft lock issue=
s.
>
> cd tools/testing/selftests/bpf/
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_1
>
> dmesg:
> watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_progs:25056]
>

Add a Fixes tag.

> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4aa3e..d85490e7de89 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -208,9 +208,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
>         return true;
>  }
>
> -/* initialized on the first pass of build_body() */
> -static int out_offset =3D -1;
> -static int emit_bpf_tail_call(struct jit_ctx *ctx)
> +static int emit_bpf_tail_call(int insn, struct jit_ctx *ctx)
>  {

Make ctx the first argument ?

>         int off;
>         u8 tcc =3D tail_call_reg(ctx);
> @@ -220,9 +218,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>         u8 t2 =3D LOONGARCH_GPR_T2;
>         u8 t3 =3D LOONGARCH_GPR_T3;
>         const int idx0 =3D ctx->idx;
> -
> -#define cur_offset (ctx->idx - idx0)
> -#define jmp_offset (out_offset - (cur_offset))

Reuse this jmp_offset macro, so that you don't have to repeat it 3
times below, WDYT ?

> +       int tc_ninsn =3D 0;
> +       int jmp_offset =3D 0;
>
>         /*
>          * a0: &ctx
> @@ -232,8 +229,11 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>          * if (index >=3D array->map.max_entries)
>          *       goto out;
>          */
> +       tc_ninsn =3D insn ? ctx->offset[insn+1] - ctx->offset[insn] :
> +               ctx->offset[0];
>         off =3D offsetof(struct bpf_array, map.max_entries);
>         emit_insn(ctx, ldwu, t1, a1, off);
> +       jmp_offset =3D tc_ninsn - (ctx->idx - idx0);
>         /* bgeu $a2, $t1, jmp_offset */
>         if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
>                 goto toofar;
> @@ -243,6 +243,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>          *       goto out;
>          */
>         emit_insn(ctx, addid, REG_TCC, tcc, -1);
> +       jmp_offset =3D tc_ninsn - (ctx->idx - idx0);
>         if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO,=
 jmp_offset) < 0)
>                 goto toofar;
>
> @@ -254,6 +255,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>         emit_insn(ctx, alsld, t2, a2, a1, 2);
>         off =3D offsetof(struct bpf_array, ptrs);
>         emit_insn(ctx, ldd, t2, t2, off);
> +       jmp_offset =3D tc_ninsn - (ctx->idx - idx0);
>         /* beq $t2, $zero, jmp_offset */
>         if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_o=
ffset) < 0)
>                 goto toofar;
> @@ -263,22 +265,11 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>         emit_insn(ctx, ldd, t3, t2, off);
>         __build_epilogue(ctx, true);
>
> -       /* out: */
> -       if (out_offset =3D=3D -1)
> -               out_offset =3D cur_offset;
> -       if (cur_offset !=3D out_offset) {
> -               pr_err_once("tail_call out_offset =3D %d, expected %d!\n"=
,
> -                           cur_offset, out_offset);
> -               return -1;
> -       }
> -
>         return 0;
>
>  toofar:
>         pr_info_once("tail_call: jump too far\n");
>         return -1;
> -#undef cur_offset
> -#undef jmp_offset
>  }
>
>  static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx=
)
> @@ -916,7 +907,7 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>         /* tail call */
>         case BPF_JMP | BPF_TAIL_CALL:
>                 mark_tail_call(ctx);
> -               if (emit_bpf_tail_call(ctx) < 0)
> +               if (emit_bpf_tail_call(i, ctx) < 0)
>                         return -EINVAL;
>                 break;
>
> @@ -1342,7 +1333,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
>         if (tmp_blinded)
>                 bpf_jit_prog_release_other(prog, prog =3D=3D orig_prog ? =
tmp : orig_prog);
>
> -       out_offset =3D -1;
>
>         return prog;
>
> --
> 2.43.0
>

Cheers,
---
Hengqi

