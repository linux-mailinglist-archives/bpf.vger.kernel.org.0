Return-Path: <bpf+bounces-39786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495EF9776AB
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99B51F25020
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 02:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945242A92;
	Fri, 13 Sep 2024 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo2h6MDs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85E6BB4B
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192819; cv=none; b=EVMqIQGbk2vZbIolxz8ks+5MxNHBrr/CUImQ2klCYqwU16l+FAldiL27QJAsVk811YBADg4DCo0POq/oYKxu7Is7GUuyjO+cqnmJ0NnzGA7e8quXSv+s3zgXeMU+txs9aXFmuzak2PSPKqH0QVKRSibqlQx14ItmzkXEFmXR+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192819; c=relaxed/simple;
	bh=I92mTVK9RDLvK3oDRK0XhDnVw1/BZvyp0/R8+LxT4MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq3nUiPyzL+mgFGprHYgJdlgxBnwYAkrfIQAAB2BeinGkOwxxkVwZBWqTovXpwYMQQBKaEi76UHkVQ18xQCCIYfljjThA/GrDHuxTszJ/s4k3BRDJcB7k4grjvhR3fon90dUX7W1fP02HPuJ64gZIh64wFZJY8EINzIP0wx7W4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo2h6MDs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so366244a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 19:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726192817; x=1726797617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ445DZ32bGZWGAa8jz2/Hc8apdx5VQLchCkmVeARFI=;
        b=bo2h6MDsT2LEwaO9TetKE6cZAdipxB+pwJ9pD257aTskHozLknqNt9bC9N40CjAu4q
         fgcBCRa+MoSno/H8+0M+H68aLcefCjB+JrrKeck7+373y6SAJYeddf4v4OpmVI5duCYd
         J7wiUwv4b3x67nwEkrEBNceGvAgqvcV4+oKJZQ6eIUFF+8OWfBwZV+XDjW1cD+VgyE9P
         lV9DrO4l9yxo8l2hqRI012lETlxB3BhGG3YKpIPZK++RuUCuybvyBnogHiypoc0TaWkO
         +HnPKlluJkjontYkCR7GxzuWrtZlqib9anUkudBERQeSZZjSC8/0JaREciHk366T8aFB
         SyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192817; x=1726797617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ445DZ32bGZWGAa8jz2/Hc8apdx5VQLchCkmVeARFI=;
        b=CG8594YdoHC+U/DMtQxa4CdesF12FuzY2LAqFs9qYfvfKybSE/mSlvKniUKX65WoUD
         Vw8ms0UpCCbJR+El+yCZXACGLYVAc6Wm6p5AoEtlUr7RqR6oOyQGT/o0G3sBbBBMYtxN
         Li2POtUx+E/vMJ2xfQNyeQt0GRiusO53FghmVpXfEDrcfw0oSIGa54h7keXhzAwXCxdv
         6uBy/U2YYp7fQj3ancJsqvfEzkV9oDjA59b/u/Gk/MqzAIZnoy/25KzS88FHapDFMri/
         VCgM/NnZ1r+ByAf9Z26NWdWIqE8ohfG3S0kNVbOP0/Jx9ncpK/p10AkiOSZBOF1986b6
         MoDA==
X-Gm-Message-State: AOJu0YwBXLhE4ZAzGh6SPYnJF7ITV2augvJKeHGJcf2EmN93NUJWBvlj
	GDCQvrxvB1con9irPsMkA3ZQQSdJLdqShiLYLPMG29T1MVxW5CvJ21vHdlHoC76NPVtncGazY77
	1cT9xEeNcP7/cZ1ktY3Hl2u4WvNI=
X-Google-Smtp-Source: AGHT+IFH/+HVacH4PerCU1w6r97SxvwmOrycuGZYBMk+56RHsmsLnLPiHDCHD430lht8mTecZM02eYpObwKd9hY3Ros=
X-Received: by 2002:a17:90b:1c88:b0:2d8:9a0c:36c0 with SMTP id
 98e67ed59e1d1-2dbb9dc0f39mr1642439a91.8.1726192815954; Thu, 12 Sep 2024
 19:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912035945.667426-1-yonghong.song@linux.dev>
 <CAEf4BzYzqG7GYp773Fzmtkbe6EV9TwoYFL2n=OJhzL-=90Jo_w@mail.gmail.com> <3386e2fc-5c4a-4576-b761-8b4b60f6c195@linux.dev>
In-Reply-To: <3386e2fc-5c4a-4576-b761-8b4b60f6c195@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 19:00:04 -0700
Message-ID: <CAEf4BzZzWK8Po=S6FOUVwCmzJV4cVWCOd-7c_N7Vu_vPFuJwaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 9/12/24 11:17 AM, Andrii Nakryiko wrote:
> > On Wed, Sep 11, 2024 at 9:00=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Zac Ecob reported a problem where a bpf program may cause kernel crash=
 due
> >> to the following error:
> >>    Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> >>
> >> The failure is due to the below signed divide:
> >>    LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> >> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,7=
75,808,
> >> but it is impossible since for 64-bit system, the maximum positive
> >> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> >> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> >> LLONG_MIN.
> >>
> >> Further investigation found all the following sdiv/smod cases may trig=
ger
> >> an exception when bpf program is running on x86_64 platform:
> >>    - LLONG_MIN/-1 for 64bit operation
> >>    - INT_MIN/-1 for 32bit operation
> >>    - LLONG_MIN%-1 for 64bit operation
> >>    - INT_MIN%-1 for 32bit operation
> >> where -1 can be an immediate or in a register.
> >>
> >> On arm64, there are no exceptions:
> >>    - LLONG_MIN/-1 =3D LLONG_MIN
> >>    - INT_MIN/-1 =3D INT_MIN
> >>    - LLONG_MIN%-1 =3D 0
> >>    - INT_MIN%-1 =3D 0
> >> where -1 can be an immediate or in a register.
> >>
> >> Insn patching is needed to handle the above cases and the patched code=
s
> >> produced results aligned with above arm64 result.
> >>
> >>    [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2=
iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D=
@protonmail.com/
> >>
> >> Reported-by: Zac Ecob <zacecob@protonmail.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++++++++++++++++++-=
--
> >>   1 file changed, 80 insertions(+), 4 deletions(-)
> >>
> >> Changelogs:
> >>    v1 -> v2:
> >>      - Handle more crash cases like 32bit operation and modules.
> >>      - Add more tests to test new cases.
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index f35b80c16cda..ad7f51302c70 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -20499,13 +20499,46 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> >>                          /* Convert BPF_CLASS(insn->code) =3D=3D BPF_A=
LU64 to 32-bit ALU */
> >>                          insn->code =3D BPF_ALU | BPF_OP(insn->code) |=
 BPF_SRC(insn->code);
> >>
> >> -               /* Make divide-by-zero exceptions impossible. */
> >> +               /* Make sdiv/smod divide-by-minus-one exceptions impos=
sible. */
> >> +               if ((insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_K) |=
|
> >> +                    insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_K) |=
|
> >> +                    insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_K) ||
> >> +                    insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_K)) &&
> >> +                   insn->off =3D=3D 1 && insn->imm =3D=3D -1) {
> >> +                       bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF=
_ALU64;
> >> +                       bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_D=
IV;
> >> +                       struct bpf_insn *patchlet;
> >> +                       struct bpf_insn chk_and_div[] =3D {
> >> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_A=
LU) |
> >> +                                            BPF_OP(BPF_NEG) | BPF_K, =
insn->dst_reg,
> >> +                                            0, 0, 0),
> >> +                       };
> >> +                       struct bpf_insn chk_and_mod[] =3D {
> >> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, =
insn->dst_reg),
> >> +                       };
> >> +
> >> +                       patchlet =3D isdiv ? chk_and_div : chk_and_mod=
;
> > nit: "chk_and_" part in the name is misleading, it's more like
> > "safe_div" and "safe_mod". Oh, and it's "sdiv" and "smod" specific, so
> > probably not a bad idea to have that in the name as well.
>
> good idea. Will use chk_and_sdiv and chk_and_smod.
>
> >
> >> +                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) : ARRA=
Y_SIZE(chk_and_mod);
> >> +
> >> +                       new_prog =3D bpf_patch_insn_data(env, i + delt=
a, patchlet, cnt);
> >> +                       if (!new_prog)
> >> +                               return -ENOMEM;
> >> +
> >> +                       delta    +=3D cnt - 1;
> >> +                       env->prog =3D prog =3D new_prog;
> >> +                       insn      =3D new_prog->insnsi + i + delta;
> >> +                       goto next_insn;
> >> +               }
> >> +
> >> +               /* Make divide-by-zero and divide-by-minus-one excepti=
ons impossible. */
> >>                  if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) |=
|
> >>                      insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_X) |=
|
> >>                      insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_X) ||
> >>                      insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
> >>                          bool is64 =3D BPF_CLASS(insn->code) =3D=3D BP=
F_ALU64;
> >>                          bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_=
DIV;
> >> +                       bool is_sdiv =3D isdiv && insn->off =3D=3D 1;
> >> +                       bool is_smod =3D !isdiv && insn->off =3D=3D 1;
> >>                          struct bpf_insn *patchlet;
> >>                          struct bpf_insn chk_and_div[] =3D {
> >>                                  /* [R,W]x div 0 -> 0 */
> >> @@ -20525,10 +20558,53 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> >>                                  BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> >>                                  BPF_MOV32_REG(insn->dst_reg, insn->ds=
t_reg),
> >>                          };
> >> +                       struct bpf_insn chk_and_sdiv[] =3D {
> >> +                               /* [R,W]x sdiv 0 -> 0 */
> >> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP=
32) |
> >> +                                            BPF_JNE | BPF_K, insn->sr=
c_reg,
> >> +                                            0, 2, 0),
> >> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, =
insn->dst_reg),
> >> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
> >> +                               /* LLONG_MIN sdiv -1 -> LLONG_MIN
> >> +                                * INT_MIN sdiv -1 -> INT_MIN
> >> +                                */
> >> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP=
32) |
> >> +                                            BPF_JNE | BPF_K, insn->sr=
c_reg,
> >> +                                            0, 2, -1),
> >> +                               /* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MI=
N =3D=3D LLONG_MIN */
> >> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_A=
LU) |
> >> +                                            BPF_OP(BPF_NEG) | BPF_K, =
insn->dst_reg,
> >> +                                            0, 0, 0),
> >> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> > I don't know how much it actually matters, but it feels like common
> > safe case should be as straight-line-executed as possible, no?
> >
> > So maybe it's better to rearrange to roughly this (where rX is the
> > divisor register):
> >
> >      if rX =3D=3D 0 goto L1
> >      if rX =3D=3D -1 goto L2
> >      rY /=3D rX
> >      goto L3
> > L1: /* zero case */
> >      rY =3D 0 /* fallthrough, negation doesn't hurt, but less jumping *=
/
> > L2: /* negative one case (or zero) */
> >      rY =3D -rY
> > L3:
> >      ... the rest of the program code ...
>
> My previous patched insn try to clearly separate rX =3D=3D 0 and
> rX =3D=3D -1 case. It has 2 insns including 2 cond jmps, 2 uncond jmps an=
d
> one 3 alu operations. The above one removed one uncond jmp, which
> is indeed better.
>
> >
> >
> > Those two branches for common case are still annoyingly inefficient, I
> > wonder if we should do
> >
> >      rX +=3D 1 /* [-1, 0] -> [0, 1]
> >      if rX <=3D(unsigned) 1 goto L1
> >      rX -=3D 1 /* restore original divisor */
> >      rY /=3D rX /* common case */
> >      goto L3
> > L1:
> >      if rX =3D=3D 0 goto L2 /* jump if originally -1 */
> >      rY =3D 0 /* division by zero case */
> > L2: /* fallthrough */
> >      rY =3D -rY
> >      rX -=3D 1 /* restore original divisor */
> > L3:
> >      ... continue with the rest ...
> >
> >
> > It's a bit trickier to follow, but should be faster in a common case.
> >
> > WDYT? Too much too far?
>
> This is even better. The above rX -=3D 1 can be removed if we use
> BPF_REG_AX as the temporary register. For example,
>
>      tmp =3D rX
>      tmp +=3D 1 /* [-1, 0] -> [0, 1]
>      if tmp <=3D(unsigned) 1 goto L1
>      rY /=3D rX /* common case */
>      goto L3
> L1:
>      if tmp =3D=3D 0 goto L2 /* jump if originally -1 */
>      rY =3D 0 /* division by zero case */
> L2: /* fallthrough */
>      rY =3D -rY
> L3:
>      ... continue with the rest ...
>
> Maybe we can do even better
>
>      tmp =3D rX
>      tmp +=3D 1 /* [-1, 0] -> [0, 1]
>      if tmp >(unsigned) 1 goto L2
>      if tmp =3D=3D 0 goto L1
>      rY =3D 0
> L1:
>      rY =3D -rY;
>      goto L3
> L2:
>      rY /=3D rX
> L3:
>
> Could this be even better by reducing one uncond jmp in the fast path?

Yep, makes sense to me. Go for it (as far as I'm concerned).

>
> >
> >
> >> +                               *insn,
> >> +                       };
> >> +                       struct bpf_insn chk_and_smod[] =3D {
> >> +                               /* [R,W]x mod 0 -> [R,W]x */
> >> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP=
32) |
> >> +                                            BPF_JNE | BPF_K, insn->sr=
c_reg,
> >> +                                            0, 2, 0),
> >> +                               BPF_MOV32_REG(insn->dst_reg, insn->dst=
_reg),
> >> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
> >> +                               /* [R,W]x mod -1 -> 0 */
> >> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP=
32) |
> >> +                                            BPF_JNE | BPF_K, insn->sr=
c_reg,
> >> +                                            0, 2, -1),
> >> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, =
insn->dst_reg),
> >> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> >> +                               *insn,
> >> +                       };
> >>
> > Same idea here, keep the common case as straight as possible.
>
> Sure. Will do.
>
> >
> >> -                       patchlet =3D isdiv ? chk_and_div : chk_and_mod=
;
> >> -                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> >> -                                     ARRAY_SIZE(chk_and_mod) - (is64 =
? 2 : 0);
> >> +                       if (is_sdiv) {
> >> +                               patchlet =3D chk_and_sdiv;
> >> +                               cnt =3D ARRAY_SIZE(chk_and_sdiv);
> >> +                       } else if (is_smod) {
> >> +                               patchlet =3D chk_and_smod;
> >> +                               cnt =3D ARRAY_SIZE(chk_and_smod);
> >> +                       } else {
> >> +                               patchlet =3D isdiv ? chk_and_div : chk=
_and_mod;
> >> +                               cnt =3D isdiv ? ARRAY_SIZE(chk_and_div=
) :
> >> +                                             ARRAY_SIZE(chk_and_mod) =
- (is64 ? 2 : 0);
> >> +                       }
> >>
> >>                          new_prog =3D bpf_patch_insn_data(env, i + del=
ta, patchlet, cnt);
> >>                          if (!new_prog)
> >> --
> >> 2.43.5
> >>

