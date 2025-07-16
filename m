Return-Path: <bpf+bounces-63393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796CB06B2A
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 03:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553C77AC162
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB724293F;
	Wed, 16 Jul 2025 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgKpP9QA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30A2F50
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629497; cv=none; b=rg4SqXm42EmzItdSps9LzzNhLD+/Y7NyS6uZY0wD3LtJKu+3MeEg5gkB+PA770iSL85ReFxBtlgzWSVDFChju0kKHmqs67T6zvOsELWyyGj+ohw2tvsFWbN89a4fvhqgZ9dAOO8C1b0dkffkFtvB5QnIciTkDT6excnItt8DKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629497; c=relaxed/simple;
	bh=L9CyshifxKcUZVuTjUaa7cOrnfH0zavz0cWcKU5YwyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm8dEkYjXxYRu4E9kBj0odUQVRHAte4T9Gj6N2ZlKuFUsUpZCJIDg2hywv0/6piJTEgnAg4AmWxCHcRlIPy6Rqktnv/B3Aj8oGSEAH8pjkB2GeLxHBzkJ+QCr3e6YCH9qdIIjRT2aZH2cQMwbd7WIIC5tgf759FZB2rBV9f76Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgKpP9QA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40a4bf1eb0dso2864408b6e.3
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752629494; x=1753234294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYpwja3WwHsWmhojkvFP4doj/3QR1BsUPWZRmwJKMLY=;
        b=lgKpP9QAdDH1a5KRclvJH4HOXYS2/wZwot7bS7fe6N7g3XiCZHbpRY8wzavVkcqOyb
         uZ41EcOAx8PNp5z0GyN0nM+qbo2YQy7X1Py5I4KFpwq44b4WnAHthW/J9LGLE+WZdhVA
         XrS/v++vro/EMe82Gb0uB5PoJVRMw03gAGWu7RGshe1kw5iWprun98rom1MVQjbOT3sU
         jnkoswtvOgduKDZBF6yP/u0jc5hRt4/pg+XsyHXOxt/X9eQ22byh3Zeigoc+fduWoVYY
         IECHVBOHueuppjZlJ6RZmjIvFxDBdliMeWfk838lPsLJh9O06r3CTor8VbIlsQusdxL4
         gCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752629494; x=1753234294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYpwja3WwHsWmhojkvFP4doj/3QR1BsUPWZRmwJKMLY=;
        b=GGC6ziT4ks2HqoaR31jM0yM4IXN+6w4tOJMr/E5MeZEr8V40OFyHqg3dCm9t9anf3z
         t1NWr+svCQB5IjeDqj7WS7utjR0LNbQ0ggMQCx+6QErQbCjucW/VmyrGWKd8qjSqW+PO
         GpSvYTOSpLSqNgSm8qCpx6qfy468RGLdsefAInKwLFO9RFH4P66HpHJHqDyBq3x6MXgO
         CZJEoLDQTGjSeEHw8wILdfzeeyBiXsg0NkVEAv5UCyUVfdWwOhzUI1CfFTNB+0vwNfM0
         bRo4T+OnpqDhAw7OIE8R0VecY7iZY+0yoKHk74Y/1wFtV/ipGXuo2K0PFrho8tjFkO2U
         xb5w==
X-Forwarded-Encrypted: i=1; AJvYcCWDW5fI6kFYXNK4P5/Ylj4G3cLiD9H2GMlOVe80GKS9JoAosK4a43RQi/xO74p8jB70UHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGH3qz66oxhPmpTeEL+2PDK3WufR0bNhTdA1u58Y2KmiYKUjrL
	lOpjwXAcPbjUQt6nlnbbqu9tmJkU6ox6uMTGrOAzND1LlacO/tRHBzln4rkMWeuJNH3ddTi/KaC
	nu2tIpMDLTa4vd+sWnO9dF8RM/hwC+Lw=
X-Gm-Gg: ASbGnctrXJ47XtwL+X3ga3NVGirGTcKP8qIeRze8mkGCqmbM5xeYZ6Tu0YW5vpSK5SV
	NsdwfIViX9bGaWD1/w9qVMwfuZb/ERrFXU4+CULp0OInHyRbpv6C75cmRpBWViDhJMVxZ5Sf9jo
	Pz5F+VHJwqX/zRpY4pEc19HwoxeLPAhC4BWQ5OWwqah/bp0lRrwYQte+Fw9WfKsO6pCyOmambaZ
	YTFU3M=
X-Google-Smtp-Source: AGHT+IFRBzfjG6GQRuYdwCYZd1NMmF5LIK7Fi8P22lPDUB0inlgKR8YIdvZaHWi43hFuqgUE6TldPhGSc9S/EdM9Jo0=
X-Received: by 2002:a05:6808:3505:b0:40a:52e5:37df with SMTP id
 5614622812f47-41d0594ca9amr751322b6e.39.1752629494067; Tue, 15 Jul 2025
 18:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708071840.556686-1-jianghaoran@kylinos.cn> <20250708071840.556686-2-jianghaoran@kylinos.cn>
In-Reply-To: <20250708071840.556686-2-jianghaoran@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 16 Jul 2025 09:31:23 +0800
X-Gm-Features: Ac12FXwrv6G51Jw3sJaR8S9iwxsghpyl4WQWLSb7nWsG9OLEVGEIK9Hn524VnVY
Message-ID: <CAEyhmHRUQV5JROOO+PyuZoLuFRrVJ-eeYH5hMf9gtVXW18aa8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] LoongArch: BPF: Optimize the calculation method of
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

On Tue, Jul 8, 2025 at 3:19=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.cn=
> wrote:
>
> The extra pass of bpf_int_jit_compile() skips JIT context initialization
> which essentially skips offset calculation leaving out_offset =3D -1,
> the jmp_offset in emit_bpf_tail_call is calculated
> by #define jmp_offset (out_offset - (cur_offset)) is a negative number,
> which does not meet expectations.The final generated assembly as follow.
>

"does not meet expectations" ? Simply "is wrong" ?

The subject line should be something like:
  Fix jump offset calculation in tailcall

It's a fix, not optimization.

Other than that, feel free to add:
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>

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
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4aa3e..5061bfc978f2 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -208,9 +208,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
>         return true;
>  }
>
> -/* initialized on the first pass of build_body() */
> -static int out_offset =3D -1;
> -static int emit_bpf_tail_call(struct jit_ctx *ctx)
> +static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
>  {
>         int off;
>         u8 tcc =3D tail_call_reg(ctx);
> @@ -220,9 +218,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>         u8 t2 =3D LOONGARCH_GPR_T2;
>         u8 t3 =3D LOONGARCH_GPR_T3;
>         const int idx0 =3D ctx->idx;
> +       int tc_ninsn =3D 0;
>
>  #define cur_offset (ctx->idx - idx0)
> -#define jmp_offset (out_offset - (cur_offset))
> +#define jmp_offset (tc_ninsn - (cur_offset))
>
>         /*
>          * a0: &ctx
> @@ -232,6 +231,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>          * if (index >=3D array->map.max_entries)
>          *       goto out;
>          */
> +       tc_ninsn =3D insn ? ctx->offset[insn+1] - ctx->offset[insn] :
> +               ctx->offset[0];
>         off =3D offsetof(struct bpf_array, map.max_entries);
>         emit_insn(ctx, ldwu, t1, a1, off);
>         /* bgeu $a2, $t1, jmp_offset */
> @@ -263,15 +264,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
> @@ -916,7 +908,7 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>         /* tail call */
>         case BPF_JMP | BPF_TAIL_CALL:
>                 mark_tail_call(ctx);
> -               if (emit_bpf_tail_call(ctx) < 0)
> +               if (emit_bpf_tail_call(ctx, i) < 0)
>                         return -EINVAL;
>                 break;
>
> @@ -1342,7 +1334,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
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
>

