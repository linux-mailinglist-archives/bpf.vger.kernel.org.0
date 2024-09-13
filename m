Return-Path: <bpf+bounces-39843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27639786B1
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE2E1C20A73
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDB8060A;
	Fri, 13 Sep 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js+of/IV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106E84A21
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248396; cv=none; b=fW3R2NwE558exnk0pmKxqoOLw8W5HsMps71WnBqBV9XU0WIsdsGeMMhF1mkqj9E8R3hE3GK/UVxf4QR7+3qJW2AspVK0emqk+vnVRIm1D+ySxBpg51FV817wjqXk28orP3BPeZSPVdxG+bVqsxmQYOOTe59rZX+whVLS41WfFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248396; c=relaxed/simple;
	bh=Ym4B66Ibd2k2SOb1LnAO9/4AVWVjggc18Q3EKMzo2JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otk4BaL+otVhzviEBuSOn4+NjI05Kyq9uxDIyEvWPuEu/eny4rGlMWOwsrTvqX0sWRuX67lkZsaZoHHZ0Umx4R01kWslG0re9DzVHEiKOdny33nEWrqdM9fDk580gQsIy02kb/o/mdBnjJUh1HdLD2nGasiAcOlp3l2GiAjuf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js+of/IV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db299608e7so822051a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726248394; x=1726853194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T35MROx7VfJin8Vg2tVHtPnOqtDzBj/Afe2D61RUEBQ=;
        b=Js+of/IV6aTK8t4sIy6nD0SMyjUwGG64ZwQq697QiyXKKkitA2Th8QkPcI2GNq6B7W
         +m24dIKB07OR6Rt1KH3rtbqpBCVhBdtck3OnST+KPKFv2/Ykph3UQL4ly5LzpMFuL6Ne
         IgoEJ+PwW88+PmuvtlJOhtKqHSuGZUc5N0kA9EBtUi/+qishhTjqNtLjyppnh0rzJukG
         cfmx4nnyBDiiZ318nma6U6au1XfHrF04uOBURB3yBIwHCNYtFOSt1tExPG4m+OVWjEm5
         RBtoeXL8BqmOFnq4XPl+22lfp5abKP9Kmlgw51GdBV4xByDU6kBS9xJwGJU2eu3sZatT
         Fd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726248394; x=1726853194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T35MROx7VfJin8Vg2tVHtPnOqtDzBj/Afe2D61RUEBQ=;
        b=kCbgY/igQPiY9e7Mw/PcqRbKbc1iLgzch6DgUlMda+pfSRbg7fAVo5Lk3A+NJWRRnf
         RJZ0LwXZDS2SdoDvtOiPD4aSyqLSPrsXYGrhZEtKrVrHJVB7Beu/Ojvc1q+wCWEmIHcf
         xnUtQbFQpf/RvFWDE9jAj34kHMzT+yFRKaDS7cH5OCEPnH9zL2CSm/8zfrPrPCVd3k80
         KtO/MQXiO0a4hABtG3UavyZIsx9A0CqSUXpuUfuwLIEAq6kBw6mk5JRc0ri8r6V/cqvJ
         k22rhCXF0DjYxmVwh8K9PL/fLeHZM6qagdmw38WdYEtt4ysvOwB4PSEFpn9NIt1lF86L
         mCgQ==
X-Gm-Message-State: AOJu0YwFZKHJ+PHItO6GRKe0msNFAo6Obv1Gc/XiHwolLQjn3jjTgUMm
	78/hlaESPh7+LIXYng78Y0apV6BIsUhTf6ecLGIsasvJa1fc16DObEdIEbukcviVgTphoWJNyDo
	jOH2grynWSXFpDxpao9tqOH31r60=
X-Google-Smtp-Source: AGHT+IEaMYvZRAksUB4AR6Pb6uyNQ+iF1nVzLjOtWJ4xpewf615VTf8wT4OEi0Oy0c8vIw36XAE/ChWBY/vaKrHw+Z4=
X-Received: by 2002:a17:90b:278b:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2dbb9dbd720mr4545595a91.1.1726248393967; Fri, 13 Sep 2024
 10:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913150326.1187788-1-yonghong.song@linux.dev>
In-Reply-To: <20240913150326.1187788-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 10:26:21 -0700
Message-ID: <CAEf4BzYV=bRJGO_R2PS=mdcHh9U0O-tYMRSY2bS6bioYwNUESQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:03=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
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
> produced results aligned with above arm64 result. The below are pseudo
> codes to handle sdiv/smod exceptions including both divisor -1 and diviso=
r 0
> and the divisor is stored in a register.
>
> sdiv:
>       tmp =3D rX
>       tmp +=3D 1 /* [-1, 0] -> [0, 1]
>       if tmp >(unsigned) 1 goto L2
>       if tmp =3D=3D 0 goto L1
>       rY =3D 0
>   L1:
>       rY =3D -rY;
>       goto L3
>   L2:
>       rY /=3D rX
>   L3:
>
> smod:
>       tmp =3D rX
>       tmp +=3D 1 /* [-1, 0] -> [0, 1]
>       if tmp >(unsigned) 1 goto L1
>       if tmp =3D=3D 1 (is64 ? goto L2 : goto L3)
>       rY =3D 0;
>       goto L2
>   L1:
>       rY %=3D rX
>   L2:
>       goto L4  // only when !is64
>   L3:
>       wY =3D wY  // only when !is64
>   L4:
>
>   [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZp=
AaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@pro=
tonmail.com/
>
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 93 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 4 deletions(-)
>
> Changelogs:
>   v2 -> v3:
>     - Change sdiv/smod (r/r, r%r) patched insn to be more efficient
>       for default case.
>   v1 -> v2:
>     - Handle more crash cases like 32bit operation and modules.
>     - Add more tests to test new cases.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f35b80c16cda..69b8d91f5136 100644
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
> +                       struct bpf_insn chk_and_sdiv[] =3D {
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_NEG) | BPF_K, ins=
n->dst_reg,
> +                                            0, 0, 0),
> +                       };
> +                       struct bpf_insn chk_and_smod[] =3D {
> +                               BPF_MOV32_IMM(insn->dst_reg, 0),
> +                       };
> +
> +                       patchlet =3D isdiv ? chk_and_sdiv : chk_and_smod;
> +                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_=
SIZE(chk_and_smod);
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
> @@ -20525,10 +20558,62 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                                 BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>                                 BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
>                         };
> +                       struct bpf_insn chk_and_sdiv[] =3D {
> +                               /* [R,W]x sdiv 0 -> 0
> +                                * LLONG_MIN sdiv -1 -> LLONG_MIN
> +                                * INT_MIN sdiv -1 -> INT_MIN
> +                                */
> +                               BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_ADD) | BPF_K, BPF=
_REG_AX,
> +                                            0, 0, 1),
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JGT | BPF_K, BPF_REG_AX,
> +                                            0, 4, 1),
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JEQ | BPF_K, BPF_REG_AX,
> +                                            0, 1, 0),
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_MOV) | BPF_K, ins=
n->dst_reg,
> +                                            0, 0, 0),
> +                               /* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN =
=3D=3D LLONG_MIN */
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_NEG) | BPF_K, ins=
n->dst_reg,
> +                                            0, 0, 0),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +                               *insn,
> +                       };
> +                       struct bpf_insn chk_and_smod[] =3D {
> +                               /* [R,W]x mod 0 -> [R,W]x */
> +                               /* [R,W]x mod -1 -> 0 */
> +                               BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_ADD) | BPF_K, BPF=
_REG_AX,
> +                                            0, 0, 1),
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JGT | BPF_K, BPF_REG_AX,
> +                                            0, 3, 1),
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JEQ | BPF_K, BPF_REG_AX,
> +                                            0, 3 + (is64 ? 0 : 1), 1),
> +                               BPF_MOV32_IMM(insn->dst_reg, 0),
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +                               *insn,
> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +                               BPF_MOV32_REG(insn->dst_reg, insn->dst_re=
g),
> +                       };
>
> -                       patchlet =3D isdiv ? chk_and_div : chk_and_mod;
> -                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> -                                     ARRAY_SIZE(chk_and_mod) - (is64 ? 2=
 : 0);
> +                       if (is_sdiv) {
> +                               patchlet =3D chk_and_sdiv;
> +                               cnt =3D ARRAY_SIZE(chk_and_sdiv);
> +                       } else if (is_smod) {
> +                               patchlet =3D chk_and_smod;
> +                               cnt =3D ARRAY_SIZE(chk_and_smod) - (is64 =
? 2 : 0);
> +                       } else {
> +                               patchlet =3D isdiv ? chk_and_div : chk_an=
d_mod;
> +                               cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> +                                             ARRAY_SIZE(chk_and_mod) - (=
is64 ? 2 : 0);
> +                       }

looking at how much isdiv vs ismod specific logic we have, it seems
like it would be cleaner (and would use less stack as well) to have
sdiv vs smod cases handled separately.

But the logic looks good to me, so

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
patchlet, cnt);
>                         if (!new_prog)
> --
> 2.43.5
>

