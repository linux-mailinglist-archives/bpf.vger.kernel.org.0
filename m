Return-Path: <bpf+bounces-39760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3B97703A
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7351C23658
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2711BE84E;
	Thu, 12 Sep 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EorjzkAV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06113156F44
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165201; cv=none; b=C/Yw5XVtc4QAlSfkpafxk1tngp6iPW05Kn/E5JcgLfUwCHHiyLv31E0taXU0JLCsG5I5X8aM+kjqsZiLO4KS6nuvx/InIo6t+dmB6cz/cf7CDrdIJ1LtOGThMjmaiKBsjOTzBaDYhJOHkVZX3kAn738INHkMarrkz7aM/GIn4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165201; c=relaxed/simple;
	bh=brPtw6rkzY6QYGlDE+dpRXfxRy4Eb+nid6sr11CZpkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XebQQ/RQYPgqraSB7xbJjs+NPSCA36DWa9fp8IZ5UaHsUMDKhsBMLKjBAPUrdVVgTgOjSWEAE9I1qauxFcPbSUpufKjuS8daajdGwtexWf1uwNTZvncMV50Vh40eBY911xDyqCZnCnsPNCIuiUPayN5D5KCdr9uhUk+fJGeqp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EorjzkAV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d88690837eso1071346a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165199; x=1726769999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqAaXtlKOHyunuCeuo9mlWeOYihOePDInKKYOvhIGgQ=;
        b=EorjzkAV2vfJQZlQxu2MnfZP3LUNmwsnLyXok3fCrqAAmLxvGVbHI3cstYA1NVjybc
         FYHi/B4910ILQVgKI4rzxAPPjWCvyxpphydXbGeQCVJ94i13lwudHXeWPFwEVxeW+jNy
         SNFMfzFi03VanftudS5EZ70Upt6RZMW4OoxK/Gt+cFfO2jwQzxAAZiMV5YNwZjCsgy7R
         ZAGDJy2qLXBivWYreG0ycdQipKuTU9dJP/l84eV67TBbIhe+5jntYj1U2W/UqgUp5976
         Q28Hrf6HU1wVBUhJpEAYeWBwjE+u6ofiw7RiQsp2G7wASwLBAbOrAzFnQZRUVqP1BY7G
         BmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165199; x=1726769999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqAaXtlKOHyunuCeuo9mlWeOYihOePDInKKYOvhIGgQ=;
        b=jECyzIN0ZQkmY8j76XWWgxDBeqiM/Yb9HOBIlCmBcQFzzhoFm/niNIhyiNynH0D2oG
         R3x6Bd7jvS5dC/WruUpqKTISsJgK3qKvHmichFvdHW7ESWxvySkLs5nQzETqjFPI2QAz
         njSekCw1m3TjHRMn8vwEzr8fJCy4tVgwi5gQLEZFm+vJeSB+lOlqCQIOELr4OZdv4uON
         AimmVKXZR2G5OD2QGWNG8RrBVBAnAzw1ft0RZjIWDrP1AI7N0VmEQ6cn6ca3O4nBqGxY
         8P2rAWJiZ6Kmm9LhzEjIs4WCjASz4KxnXoZEbGMtV0iP5bXmBUpBV7VHiK0ryBQAz2Il
         3/fg==
X-Gm-Message-State: AOJu0YzeM+uhPUVF55kUvXckd4IS9r+OM41pTFX0mggj1htGx/dHmpan
	4SWxPro8YWXaK3St/BdKb/FWc6Mki+9hDBrwvq4JHSbAZJZD6F9ZI4jofPb5Ybvu6JJO1ME+hum
	lGSXbh2V0LB3/0OwE78VnacJkWIQ=
X-Google-Smtp-Source: AGHT+IFHgkaQnphu11q3gRmLmpDtbWq54Q72udNIciNi0zAxtBuwDObxdSfehsWuln4FIynmlPZrqM1EKlvFTJr5MXQ=
X-Received: by 2002:a17:90a:68c7:b0:2d3:c638:ec67 with SMTP id
 98e67ed59e1d1-2db9feb24femr4443433a91.0.1726165199177; Thu, 12 Sep 2024
 11:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912035945.667426-1-yonghong.song@linux.dev> <CAEf4BzYzqG7GYp773Fzmtkbe6EV9TwoYFL2n=OJhzL-=90Jo_w@mail.gmail.com>
In-Reply-To: <CAEf4BzYzqG7GYp773Fzmtkbe6EV9TwoYFL2n=OJhzL-=90Jo_w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 11:19:46 -0700
Message-ID: <CAEf4BzaBoTVATZgf+CALFH=kOiSLHtKEYO=2WL-ZYzO2HCzS8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:17=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 11, 2024 at 9:00=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > Zac Ecob reported a problem where a bpf program may cause kernel crash =
due
> > to the following error:
> >   Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> >
> > The failure is due to the below signed divide:
> >   LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> > LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,77=
5,808,
> > but it is impossible since for 64-bit system, the maximum positive
> > number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> > cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> > LLONG_MIN.
> >
> > Further investigation found all the following sdiv/smod cases may trigg=
er
> > an exception when bpf program is running on x86_64 platform:
> >   - LLONG_MIN/-1 for 64bit operation
> >   - INT_MIN/-1 for 32bit operation
> >   - LLONG_MIN%-1 for 64bit operation
> >   - INT_MIN%-1 for 32bit operation
> > where -1 can be an immediate or in a register.
> >
> > On arm64, there are no exceptions:
> >   - LLONG_MIN/-1 =3D LLONG_MIN
> >   - INT_MIN/-1 =3D INT_MIN
> >   - LLONG_MIN%-1 =3D 0
> >   - INT_MIN%-1 =3D 0
> > where -1 can be an immediate or in a register.
> >
> > Insn patching is needed to handle the above cases and the patched codes
> > produced results aligned with above arm64 result.
> >
> >   [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2ia=
ZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@p=
rotonmail.com/
> >
> > Reported-by: Zac Ecob <zacecob@protonmail.com>
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 80 insertions(+), 4 deletions(-)
> >
> > Changelogs:
> >   v1 -> v2:
> >     - Handle more crash cases like 32bit operation and modules.
> >     - Add more tests to test new cases.
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f35b80c16cda..ad7f51302c70 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20499,13 +20499,46 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
> >                         /* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU=
64 to 32-bit ALU */
> >                         insn->code =3D BPF_ALU | BPF_OP(insn->code) | B=
PF_SRC(insn->code);
> >
> > -               /* Make divide-by-zero exceptions impossible. */
> > +               /* Make sdiv/smod divide-by-minus-one exceptions imposs=
ible. */
> > +               if ((insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_K) ||
> > +                    insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_K) ||
> > +                    insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_K) ||
> > +                    insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_K)) &&
> > +                   insn->off =3D=3D 1 && insn->imm =3D=3D -1) {
> > +                       bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_=
ALU64;
> > +                       bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DI=
V;
> > +                       struct bpf_insn *patchlet;
> > +                       struct bpf_insn chk_and_div[] =3D {
> > +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_AL=
U) |
> > +                                            BPF_OP(BPF_NEG) | BPF_K, i=
nsn->dst_reg,
> > +                                            0, 0, 0),
> > +                       };
> > +                       struct bpf_insn chk_and_mod[] =3D {
> > +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, i=
nsn->dst_reg),
> > +                       };
> > +
> > +                       patchlet =3D isdiv ? chk_and_div : chk_and_mod;
>
> nit: "chk_and_" part in the name is misleading, it's more like
> "safe_div" and "safe_mod". Oh, and it's "sdiv" and "smod" specific, so
> probably not a bad idea to have that in the name as well.
>
> > +                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) : ARRAY=
_SIZE(chk_and_mod);
> > +
> > +                       new_prog =3D bpf_patch_insn_data(env, i + delta=
, patchlet, cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +
> > +                       delta    +=3D cnt - 1;
> > +                       env->prog =3D prog =3D new_prog;
> > +                       insn      =3D new_prog->insnsi + i + delta;
> > +                       goto next_insn;
> > +               }
> > +
> > +               /* Make divide-by-zero and divide-by-minus-one exceptio=
ns impossible. */
> >                 if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) ||
> >                     insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_X) ||
> >                     insn->code =3D=3D (BPF_ALU | BPF_MOD | BPF_X) ||
> >                     insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
> >                         bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_=
ALU64;
> >                         bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DI=
V;
> > +                       bool is_sdiv =3D isdiv && insn->off =3D=3D 1;
> > +                       bool is_smod =3D !isdiv && insn->off =3D=3D 1;
> >                         struct bpf_insn *patchlet;
> >                         struct bpf_insn chk_and_div[] =3D {
> >                                 /* [R,W]x div 0 -> 0 */
> > @@ -20525,10 +20558,53 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
> >                                 BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> >                                 BPF_MOV32_REG(insn->dst_reg, insn->dst_=
reg),
> >                         };
> > +                       struct bpf_insn chk_and_sdiv[] =3D {
> > +                               /* [R,W]x sdiv 0 -> 0 */
> > +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP3=
2) |
> > +                                            BPF_JNE | BPF_K, insn->src=
_reg,
> > +                                            0, 2, 0),
> > +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, i=
nsn->dst_reg),
> > +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
> > +                               /* LLONG_MIN sdiv -1 -> LLONG_MIN
> > +                                * INT_MIN sdiv -1 -> INT_MIN
> > +                                */
> > +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP3=
2) |
> > +                                            BPF_JNE | BPF_K, insn->src=
_reg,
> > +                                            0, 2, -1),
> > +                               /* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN=
 =3D=3D LLONG_MIN */
> > +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_AL=
U) |
> > +                                            BPF_OP(BPF_NEG) | BPF_K, i=
nsn->dst_reg,
> > +                                            0, 0, 0),
> > +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>
> I don't know how much it actually matters, but it feels like common
> safe case should be as straight-line-executed as possible, no?
>
> So maybe it's better to rearrange to roughly this (where rX is the
> divisor register):
>
>     if rX =3D=3D 0 goto L1
>     if rX =3D=3D -1 goto L2
>     rY /=3D rX
>     goto L3
> L1: /* zero case */
>     rY =3D 0 /* fallthrough, negation doesn't hurt, but less jumping */
> L2: /* negative one case (or zero) */
>     rY =3D -rY
> L3:
>     ... the rest of the program code ...
>
>
> Those two branches for common case are still annoyingly inefficient, I
> wonder if we should do
>
>     rX +=3D 1 /* [-1, 0] -> [0, 1]
>     if rX <=3D(unsigned) 1 goto L1
>     rX -=3D 1 /* restore original divisor */
>     rY /=3D rX /* common case */
>     goto L3
> L1:
>     if rX =3D=3D 0 goto L2 /* jump if originally -1 */
>     rY =3D 0 /* division by zero case */
> L2: /* fallthrough */
>     rY =3D -rY
>     rX -=3D 1 /* restore original divisor */
> L3:
>     ... continue with the rest ...

hmm.. just in case rX is the same register as rY, probably best to
restore rX early right at L1: label (and adjust `if rX =3D=3D 0 goto L2`
into `if rX !=3D 0 goto L2`).

>
>
> It's a bit trickier to follow, but should be faster in a common case.
>
> WDYT? Too much too far?
>
>
> > +                               *insn,
> > +                       };
> > +                       struct bpf_insn chk_and_smod[] =3D {
> > +                               /* [R,W]x mod 0 -> [R,W]x */
> > +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP3=
2) |
> > +                                            BPF_JNE | BPF_K, insn->src=
_reg,
> > +                                            0, 2, 0),
> > +                               BPF_MOV32_REG(insn->dst_reg, insn->dst_=
reg),
> > +                               BPF_JMP_IMM(BPF_JA, 0, 0, 4),
> > +                               /* [R,W]x mod -1 -> 0 */
> > +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP3=
2) |
> > +                                            BPF_JNE | BPF_K, insn->src=
_reg,
> > +                                            0, 2, -1),
> > +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, i=
nsn->dst_reg),
> > +                               BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> > +                               *insn,
> > +                       };
> >
>
> Same idea here, keep the common case as straight as possible.
>
> > -                       patchlet =3D isdiv ? chk_and_div : chk_and_mod;
> > -                       cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
> > -                                     ARRAY_SIZE(chk_and_mod) - (is64 ?=
 2 : 0);
> > +                       if (is_sdiv) {
> > +                               patchlet =3D chk_and_sdiv;
> > +                               cnt =3D ARRAY_SIZE(chk_and_sdiv);
> > +                       } else if (is_smod) {
> > +                               patchlet =3D chk_and_smod;
> > +                               cnt =3D ARRAY_SIZE(chk_and_smod);
> > +                       } else {
> > +                               patchlet =3D isdiv ? chk_and_div : chk_=
and_mod;
> > +                               cnt =3D isdiv ? ARRAY_SIZE(chk_and_div)=
 :
> > +                                             ARRAY_SIZE(chk_and_mod) -=
 (is64 ? 2 : 0);
> > +                       }
> >
> >                         new_prog =3D bpf_patch_insn_data(env, i + delta=
, patchlet, cnt);
> >                         if (!new_prog)
> > --
> > 2.43.5
> >

