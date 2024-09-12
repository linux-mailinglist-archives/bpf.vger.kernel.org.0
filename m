Return-Path: <bpf+bounces-39759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60026977037
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 20:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26101F2185F
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133FB1BE25C;
	Thu, 12 Sep 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8FCxjUP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F713D530
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165084; cv=none; b=nidm91YbMaTcx9ZGJC5/1Vst9YNrnBaXjnyyNicseLBAuDTcjGx0wdWNKhoX6d+SYGDEVJdLQ54IrSJWg+8nYm0Mb/qWk2wU2yXAb0l/iEqPLJK6pyI1Vib45S+x9E/C8s2ypyvmvO87mH9o4QP6Hbbl4LIc1VdKjEdfA7JD1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165084; c=relaxed/simple;
	bh=AJOWOTayaT4FL4jGkyN7egvc2immyOhbnePxZuE5/tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTxZyz6qRusjszBPwuIR/XQJmWAUABQPKrTulXcvdrGQ7Q/NW9hBm3wC9Z8IH3K39IhWwvYPQtPbzjluiYlt7l9CRrMSt+qH1I/y28TTla455fhEEHPcnQqSqp92dWe4ZO5g/eJPsfjvGZ6/o9CqJtPDa3l0ot5puCf+ouR8Ixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8FCxjUP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso118933a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165082; x=1726769882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXEnao80VxBRHDM0j9S4zrJ1CKbsAe/urvBOdz9DvNs=;
        b=f8FCxjUPVVtMWnwdj62kxsEZVrphpyMHch6t8PL7VofsONsV0StQKp+PT1zf5Q7evP
         ZhTsV23GPl1DShDw8wW01V/2BegZJIjIUx7guJqIl1rayNK/A2weFq58E/tF0CGzTMHq
         5mlgftT821VkTRLqNK4+Mna+Cmjo+KWcLPP1OknKxWKVRafdKVB27uCqANCp5pmLHkoY
         6kMXHbvb9yaBZr53XP7G95v8Crwl2eT5Bi7PWorlkNNt6XhLIzlRLQiOhclK/KFTWSZK
         i5EaFw1PZ+NaRZER8tCm9rAhyDH7rA4Ho0qtIP7reMFKuFBJVVVMPGhugSrWeueQvhWo
         Zh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165082; x=1726769882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXEnao80VxBRHDM0j9S4zrJ1CKbsAe/urvBOdz9DvNs=;
        b=wizLXPRMhgniTSyXIYEiRFGnX+iTQiOWIbo9QuPqj6IXlANESPmdbQYUmUn2d8w0xw
         cPTMw7C7of0p6vxM0tDj95gCSsLLEK67iu6r/h9a9vjQNKhkk9bv+hEIJIP1Llu+hj6I
         f/wLaaUR5xt2CWr3kN5p/WB+9pln64NI3xrSezoqXq1SvRxIonWonWVXmerun1IPtfYh
         h4TAlaUf4ZAeQ5mSj5RYgt86g4LHXFQYVMD37ckq9MO+1y91CTUZMyXaaoMB/+3MvooZ
         8NsMT7I1O+FZb+DGxo4L4zcG8HbMoDUTufSf2t1z4RZ8lErFXRFCjaRvnHdRtXFLqhQ7
         ixGg==
X-Gm-Message-State: AOJu0Yxy914VNir/6afQMcUv99QXFwfR8z/YiBM1mSfE8enrRyVH2p7l
	TRl/SNPy/8TqyHz5buwvUkCGZWY1j7iKhsGvGva1xqbVRXWSC/L+TJO2omloKFg4QYrqVWGI56H
	kDzEXll4cB294cFO45jD+4II9BPU=
X-Google-Smtp-Source: AGHT+IFC4RuaLi60i1gGLkGjtk4HbTjIcvPrzvjEl+jHOnXVuKIP/8IC2GONH9KYWAzsnd7kozwxiyNgVcqvrcAve4o=
X-Received: by 2002:a17:90a:7446:b0:2d8:8ce3:1e9d with SMTP id
 98e67ed59e1d1-2db9ffa3869mr3644471a91.3.1726165082178; Thu, 12 Sep 2024
 11:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912035945.667426-1-yonghong.song@linux.dev>
In-Reply-To: <20240912035945.667426-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 11:17:50 -0700
Message-ID: <CAEf4BzYzqG7GYp773Fzmtkbe6EV9TwoYFL2n=OJhzL-=90Jo_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 9:00=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Zac Ecob reported a problem where a bpf program may cause kernel crash du=
e
> to the following error:
>   Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>
> The failure is due to the below signed divide:
>   LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,=
808,
> but it is impossible since for 64-bit system, the maximum positive
> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> LLONG_MIN.
>
> Further investigation found all the following sdiv/smod cases may trigger
> an exception when bpf program is running on x86_64 platform:
>   - LLONG_MIN/-1 for 64bit operation
>   - INT_MIN/-1 for 32bit operation
>   - LLONG_MIN%-1 for 64bit operation
>   - INT_MIN%-1 for 32bit operation
> where -1 can be an immediate or in a register.
>
> On arm64, there are no exceptions:
>   - LLONG_MIN/-1 =3D LLONG_MIN
>   - INT_MIN/-1 =3D INT_MIN
>   - LLONG_MIN%-1 =3D 0
>   - INT_MIN%-1 =3D 0
> where -1 can be an immediate or in a register.
>
> Insn patching is needed to handle the above cases and the patched codes
> produced results aligned with above arm64 result.
>
>   [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZp=
AaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@pro=
tonmail.com/
>
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 4 deletions(-)
>
> Changelogs:
>   v1 -> v2:
>     - Handle more crash cases like 32bit operation and modules.
>     - Add more tests to test new cases.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f35b80c16cda..ad7f51302c70 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20499,13 +20499,46 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                         /* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU64=
 to 32-bit ALU */
>                         insn->code =3D BPF_ALU | BPF_OP(insn->code) | BPF=
_SRC(insn->code);
>
> -               /* Make divide-by-zero exceptions impossible. */
> +               /* Make sdiv/smod divide-by-minus-one exceptions impossib=
le. */
> +               if ((insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_K) ||
> +                    insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_K) ||
> +                    insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_K) ||
> +                    insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_K)) &&
> +                   insn->off =3D=3D 1 && insn->imm =3D=3D -1) {
> +                       bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_AL=
U64;
> +                       bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
> +                       struct bpf_insn *patchlet;
> +                       struct bpf_insn chk_and_div[] =3D {
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_NEG) | BPF_K, ins=
n->dst_reg,
> +                                            0, 0, 0),
> +                       };
> +                       struct bpf_insn chk_and_mod[] =3D {
> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, ins=
n->dst_reg),
> +                       };
> +
> +                       patchlet =3D isdiv ? chk_and_div : chk_and_mod;

nit: "chk_and_" part in the name is misleading, it's more like
"safe_div" and "safe_mod". Oh, and it's "sdiv" and "smod" specific, so
probably not a bad idea to have that in the name as well.

> +                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) : ARRAY_S=
IZE(chk_and_mod);
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
patchlet, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       goto next_insn;
> +               }
> +
> +               /* Make divide-by-zero and divide-by-minus-one exceptions=
 impossible. */
>                 if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) ||
>                     insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_X) ||
>                     insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_X) ||
>                     insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
>                         bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_AL=
U64;
>                         bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
> +                       bool is_sdiv =3D isdiv && insn->off =3D=3D 1;
> +                       bool is_smod =3D !isdiv && insn->off =3D=3D 1;
>                         struct bpf_insn *patchlet;
>                         struct bpf_insn chk_and_div[] =3D {
>                                 /* [R,W]x div 0 -> 0 */
> @@ -20525,10 +20558,53 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                                 BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>                                 BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
>                         };
> +                       struct bpf_insn chk_and_sdiv[] =3D {
> +                               /* [R,W]x sdiv 0 -> 0 */
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JNE | BPF_K, insn->src_r=
eg,
> +                                            0, 2, 0),
> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, ins=
n->dst_reg),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
> +                               /* LLONG_MIN sdiv -1 -> LLONG_MIN
> +                                * INT_MIN sdiv -1 -> INT_MIN
> +                                */
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JNE | BPF_K, insn->src_r=
eg,
> +                                            0, 2, -1),
> +                               /* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN =
=3D=3D LLONG_MIN */
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_NEG) | BPF_K, ins=
n->dst_reg,
> +                                            0, 0, 0),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),

I don't know how much it actually matters, but it feels like common
safe case should be as straight-line-executed as possible, no?

So maybe it's better to rearrange to roughly this (where rX is the
divisor register):

    if rX =3D=3D 0 goto L1
    if rX =3D=3D -1 goto L2
    rY /=3D rX
    goto L3
L1: /* zero case */
    rY =3D 0 /* fallthrough, negation doesn't hurt, but less jumping */
L2: /* negative one case (or zero) */
    rY =3D -rY
L3:
    ... the rest of the program code ...


Those two branches for common case are still annoyingly inefficient, I
wonder if we should do

    rX +=3D 1 /* [-1, 0] -> [0, 1]
    if rX <=3D(unsigned) 1 goto L1
    rX -=3D 1 /* restore original divisor */
    rY /=3D rX /* common case */
    goto L3
L1:
    if rX =3D=3D 0 goto L2 /* jump if originally -1 */
    rY =3D 0 /* division by zero case */
L2: /* fallthrough */
    rY =3D -rY
    rX -=3D 1 /* restore original divisor */
L3:
    ... continue with the rest ...


It's a bit trickier to follow, but should be faster in a common case.

WDYT? Too much too far?


> +                               *insn,
> +                       };
> +                       struct bpf_insn chk_and_smod[] =3D {
> +                               /* [R,W]x mod 0 -> [R,W]x */
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JNE | BPF_K, insn->src_r=
eg,
> +                                            0, 2, 0),
> +                               BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
> +                               /* [R,W]x mod -1 -> 0 */
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JNE | BPF_K, insn->src_r=
eg,
> +                                            0, 2, -1),
> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, ins=
n->dst_reg),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +                               *insn,
> +                       };
>

Same idea here, keep the common case as straight as possible.

> -                       patchlet =3D isdiv ? chk_and_div : chk_and_mod;
> -                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> -                                     ARRAY_SIZE(chk_and_mod) - (is64 ? 2=
 : 0);
> +                       if (is_sdiv) {
> +                               patchlet =3D chk_and_sdiv;
> +                               cnt =3D ARRAY_SIZE(chk_and_sdiv);
> +                       } else if (is_smod) {
> +                               patchlet =3D chk_and_smod;
> +                               cnt =3D ARRAY_SIZE(chk_and_smod);
> +                       } else {
> +                               patchlet =3D isdiv ? chk_and_div : chk_an=
d_mod;
> +                               cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> +                                             ARRAY_SIZE(chk_and_mod) - (=
is64 ? 2 : 0);
> +                       }
>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
patchlet, cnt);
>                         if (!new_prog)
> --
> 2.43.5
>

