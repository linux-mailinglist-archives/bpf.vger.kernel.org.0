Return-Path: <bpf+bounces-35122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C7937DE2
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 00:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E486B2108E
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5F146A76;
	Fri, 19 Jul 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCPg4gWJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BE282F1
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721429224; cv=none; b=gJ912Nf85q4ppcsPu1+PXdlz+OjAlAfvK6/zv7OaRCoZHS/AGvWL2z3iOpc6MgeUg0OIeUaF5CAKWLO+cGDQKDZb3FGAunBmwhwBPZRidMjedQ3RUh7C62nCGXG/IZkE0ETpUoA3dqnEU52FfduuQrJ5qkzLOT8XZHorWuJutsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721429224; c=relaxed/simple;
	bh=wqLMoKyLXg4mUJkZTr3BV4l8bUo22aU0RzpVB9KgUFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTaTG6kHWY9/EVsGVBieaMfoMRnLIHa8sG5sp4QkR8X4bEuZQDPknfgwwdc4TAu3iCl6mCv2O2N1gpBQfmMFFshd9Dcbjvmsnza8Db4CwNzyhY68jl4hCdj3rYQ3nTbZBeO0L65ZR4hHc7dPn+YB3Vy5E2/wByG/jlvHEU2uuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCPg4gWJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-78512d44a17so1607863a12.3
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721429222; x=1722034022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyHFUlMBPAE35lZefZRuCmPKt260FBDZbKKpZ7iZesE=;
        b=iCPg4gWJdUzS7HmFkbBAZzh50KXfPVPfJMlVZQp1i27dEmtyxAWgbuWEyAIK5DzSEg
         IL1D6VwAREj3yT9nJX6i2hss/koX5t4qgVpoNuBsrydvLhcNbl8E/rb2wLSieemvX0ml
         Q5MtR1Lo0XgFo+r7WywlOu2+fDSeHYJhZeqfVq9o/yvouWOuNpeTTti3MqhVQzyAD0qq
         9INOv26UfwXUZweeAeXkrDO3eypF8VTgDsZvqUjRWDM4Gr+VUDVoZs4WlHnBB8ZdigGp
         s/cl9xCQ7bCohaBreXkmLUS0ckr9PYeNL0h/rXWZS0nguemSw0OIAdW8ZkOynsGfvTqw
         ADfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721429222; x=1722034022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyHFUlMBPAE35lZefZRuCmPKt260FBDZbKKpZ7iZesE=;
        b=kRGzZbMbPDZQd0vH/IHDwD9iBU3ZqMwzUjPRi6K2GdYxZLAjZqnkCyeV5NH5uFaSil
         GvWjDRDExxF5e5jd00X0mlMg0uUn4ph2uUmwjlCpcNjzgQLkxEIsjyc8O9HoekOKvHuW
         E6KGGFbqgIAOGvaU4J609UbTo6wyNQWCqWlF7IVTqiQxjL7X540OlzW8NIRFHzLaUVF8
         GKJeV8/4xdhU3sj6TYll8XasuVqiga9vt3pIK+wwBLHiSudNDL+DpPtwMo8prwpjR6di
         FhptV7cwvuztiQszaT94Mp7Q3vY/Rx6IG/U50GaYy/KSg08Pthl0F29OH4MMWjiwnYO8
         yY6w==
X-Gm-Message-State: AOJu0YwH3wg+qOvrKiblv9AuqTd8HI/lP3BTrXH3x2KGZxz62rrz4lHX
	aateZfjDUn9RWIAM26c8dTck4l/w4VrhuBIIeW8o58TIni3k2qUWBqyg/ZBy6Su8AEasj3wZjWi
	8bbft7aXqWdorPGHiL3TTWdwEfHs=
X-Google-Smtp-Source: AGHT+IHHnGq8C4ocag/UXVnHztGfm3eBlTsyASuvd+fDpwbuMsdFYrlR36Hp+hM/QjiPXJa1hcZRJqikz2xsLs89qcc=
X-Received: by 2002:a05:6a20:d524:b0:1c2:9554:fd07 with SMTP id
 adf61e73a8af0-1c3fdcc0004mr10902841637.1.1721429221862; Fri, 19 Jul 2024
 15:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
In-Reply-To: <20240718052821.3753486-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 15:46:49 -0700
Message-ID: <CAEf4BzYazgarMJNVqt33grWxYEcNWy_L=OCXwg9tw5wHYc+2iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Get better reg range with ldsx and
 32bit compare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:28=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> With latest llvm19, the selftest iters/iter_arr_with_actual_elem_count
> failed with -mcpu=3Dv4.
>
> The following are the details:
>   0: R1=3Dctx() R10=3Dfp0
>   ; int iter_arr_with_actual_elem_count(const void *ctx) @ iters.c:1420
>   0: (b4) w7 =3D 0                        ; R7_w=3D0
>   ; int i, n =3D loop_data.n, sum =3D 0; @ iters.c:1422
>   1: (18) r1 =3D 0xffffc90000191478       ; R1_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144)
>   3: (61) r6 =3D *(u32 *)(r1 +128)        ; R1_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xfff=
fffff,var_off=3D(0x0; 0xffffffff))
>   ; if (n > ARRAY_SIZE(loop_data.data)) @ iters.c:1424
>   4: (26) if w6 > 0x20 goto pc+27       ; R6_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))
>   5: (bf) r8 =3D r10                      ; R8_w=3Dfp0 R10=3Dfp0
>   6: (07) r8 +=3D -8                      ; R8_w=3Dfp-8
>   ; bpf_for(i, 0, n) { @ iters.c:1427
>   7: (bf) r1 =3D r8                       ; R1_w=3Dfp-8 R8_w=3Dfp-8
>   8: (b4) w2 =3D 0                        ; R2_w=3D0
>   9: (bc) w3 =3D w6                       ; R3_w=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R6_w=3D=
scalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=
=3D(0x0; 0x3f))
>   10: (85) call bpf_iter_num_new#45179          ; R0=3Dscalar() fp-8=3Dit=
er_num(ref_id=3D2,state=3Dactive,depth=3D0) refs=3D2
>   11: (bf) r1 =3D r8                      ; R1=3Dfp-8 R8=3Dfp-8 refs=3D2
>   12: (85) call bpf_iter_num_next#45181 13: R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=
=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Dite=
r_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
>   ; bpf_for(i, 0, n) { @ iters.c:1427
>   13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,ref_=
obj_id=3D2,sz=3D4) refs=3D2
>   14: (81) r1 =3D *(s32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)=
 refs=3D2
>   15: (ae) if w1 < w6 goto pc+4 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2=
,sz=3D4) R1=3Dscalar(smin=3D0xffffffff80000000,smax=3Dsmax32=3Dumax32=3D31,=
umax=3D0xffffffff0000001f,smin32=3D0,var_off=3D(0x0; 0xffffffff0000001f)) R=
6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3D=
umax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Diter_n=
um(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
>   ; sum +=3D loop_data.data[i]; @ iters.c:1429
>   20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smax=3D0x7fffff=
fc0000007c,umax=3D0xfffffffc0000007c,smin32=3D0,smax32=3Dumax32=3D124,var_o=
ff=3D(0x0; 0xfffffffc0000007c)) refs=3D2
>   21: (18) r2 =3D 0xffffc90000191478      ; R2_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
>   23: (0f) r2 +=3D r1
>   math between map_value pointer and register with unbounded min value is=
 not allowed
>
> The source code:
>   int iter_arr_with_actual_elem_count(const void *ctx)
>   {
>         int i, n =3D loop_data.n, sum =3D 0;
>
>         if (n > ARRAY_SIZE(loop_data.data))
>                 return 0;
>
>         bpf_for(i, 0, n) {
>                 /* no rechecking of i against ARRAY_SIZE(loop_data.n) */
>                 sum +=3D loop_data.data[i];
>         }
>
>         return sum;
>   }
>
> The insn #14 is a sign-extenstion load which is related to 'int i'.
> The insn #15 did a subreg comparision. Note that smin=3D0xffffffff8000000=
0 and this caused later
> insn #23 failed verification due to unbounded min value.
>
> Actually insn #15 R1 smin range can be better. Before insn #15, we have
>   R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> With the above range, we know for R1, upper 32bit can only be 0xffffffff =
or 0.
> Otherwise, the value range for R1 could be beyond [smin=3D0xffffffff80000=
000,smax=3D0x7fffffff].
>
> After insn #15, for the true patch, we know smin32=3D0 and smax32=3D32. W=
ith the upper 32bit 0xffffffff,
> then the corresponding value is [0xffffffff00000000, 0xffffffff00000020].=
 The range is
> obviously beyond the original range [smin=3D0xffffffff80000000,smax=3D0x7=
fffffff] and the
> range is not possible. So the upper 32bit must be 0, which implies smin =
=3D smin32 and
> smax =3D smax32.
>
> This patch fixed the issue by adding additional register deduction after =
32-bit compare

__reg_deduce_mixed_bounds() is called from reg_bounds_sync() pretty
much after every arithmetic operation or any comparison. Is the above
logic true universally or only after signed comparison? If the latter,
then we can't just do it unconditionally inside
__reg_deduce_mixed_bounds().

> insn. If the signed 32-bit register range is non-negative then 64-bit smi=
n is
> in range of [S32_MIN, S32_MAX], then the actual 64-bit smin/smax should b=
e the same
> as 32-bit smin32/smax32.
>
> With this patch, iters/iter_arr_with_actual_elem_count succeeded with bet=
ter register range:
>
> from 15 to 20: R0=3Drdonly_mem(id=3D7,ref_obj_id=3D2,sz=3D4) R1_w=3Dscala=
r(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f=
)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax3=
2=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3Dscalar(id=3D9,smin=3D0,smax=3Du=
max=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R8=3Dscalar(id=3D9,smin=3D0,s=
max=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0 fp-8=3Diter_=
num(ref_id=3D2,state=3Dactive,depth=3D3) refs=3D2
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8da132a1ef28..46532437c4bb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2182,6 +2182,42 @@ static void __reg_deduce_mixed_bounds(struct bpf_r=
eg_state *reg)
>                 reg->smin_value =3D max_t(s64, reg->smin_value, new_smin)=
;
>                 reg->smax_value =3D min_t(s64, reg->smax_value, new_smax)=
;
>         }
> +
> +       /* Here we would like to handle a special case after sign extendi=
ng load,
> +        * when upper bits for a 64-bit range are all 1s or all 0s.
> +        *
> +        * Upper bits are all 1s when register is in a range:
> +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
> +        * Upper bits are all 0s when register is in a range:
> +        *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
> +        * Together this forms are continuous range:
> +        *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
> +        *
> +        * Now, suppose that register range is in fact tighter:
> +        *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> +        * Also suppose that it's 32-bit range is positive,
> +        * meaning that lower 32-bits of the full 64-bit register
> +        * are in the range:
> +        *   [0x0000_0000, 0x7fff_ffff] (W)
> +        *
> +        * If this happens, then any value in a range:
> +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
> +        * is smaller than a lowest bound of the range (R):
> +        *   0xffff_ffff_8000_0000
> +        * which means that upper bits of the full 64-bit register
> +        * can't be all 1s, when lower bits are in range (W).
> +        *
> +        * Note that:
> +        *  - 0xffff_ffff_8000_0000 =3D=3D (s64)S32_MIN
> +        *  - 0x0000_0000_ffff_ffff =3D=3D (s64)S32_MAX

?? S32_MAX =3D 0x7fffffff, so should the right part be U32_MAX or the
left part should be 0x0000_0000_7fff_ffff ?

> +        * These relations are used in the conditions below.
> +        */
> +       if (reg->s32_min_value >=3D 0 && reg->smin_value >=3D S32_MIN && =
reg->smax_value <=3D S32_MAX) {
> +               reg->smin_value =3D reg->umin_value =3D reg->s32_min_valu=
e;
> +               reg->smax_value =3D reg->umax_value =3D reg->s32_max_valu=
e;

let's please not mix signed and unsigned 32 -> 64 bit conversions,
they are confusing and tricky enough in each domain individually,
there is no point in mixing them

> +               reg->var_off =3D tnum_intersect(reg->var_off,
> +                                             tnum_range(reg->smin_value,=
 reg->smax_value));
> +       }
>  }
>
>  static void __reg_deduce_bounds(struct bpf_reg_state *reg)
> --
> 2.43.0
>

