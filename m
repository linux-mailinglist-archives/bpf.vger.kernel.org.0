Return-Path: <bpf+bounces-13811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1417DE51B
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 18:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA4D1C20DFC
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE515E9E;
	Wed,  1 Nov 2023 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFF2u9AT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D115E8E
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:12:35 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EB8FD
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 10:12:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso63661951fa.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858751; x=1699463551; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7quWN7BM03R98ZppZlDmzG02ua0+gEzvej/LffNKXxo=;
        b=DFF2u9AT/QJ4BvHO4+5KCPWoPizZdv7RNa9iXxXP6AOQE2VTNQoae8wK7U34qZNtgK
         R1PQmDCChBNDQn1S+3JHyx654mR6S7qJjcpr3/CQdc5l4BzR850zzHnRPGpdIOeOIeqj
         M3X0ihIhdOgPWFAsnpgR6/tre/xGIfWPVJ+o+Oro4N4w3nxzcjvt8mujvmgNI2v1LBdk
         kknqf/lzP2OqAUhxyM5RvOEIXp+bQIRyqlVmvxQmHWNW++oGwGXiajlXuUWJ+Cs9yZbY
         rI3oGIXXd1tqs5Ljy3XM1ynqX9TdxdfKG++ZB6px7eYQJ97CvCA0yrjIYQuT3RbN2Ubt
         +0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858751; x=1699463551;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7quWN7BM03R98ZppZlDmzG02ua0+gEzvej/LffNKXxo=;
        b=dDAdcOs2sTSk3n/xHflQRbvm3y3qTgTU9s5j6EyiujiNtEdpEHpKCcKeuzNiSaQxH8
         eofRomT20nKubD09zx0HVpbWYMJrxU/eoSwxzGvJTrfVMkDArw+4uP7pXgtnZYFICsUH
         nM4767Bto3VYtIJ5vTMFyPRa6KzfLdzqmkALP2ijfrW+7UHouAiTo3RTmcZSKztBNxL2
         CyxLcLVqRBqco1BfVetPLA6XeMzsFV+R+1GSkJRalItN9R7qMQY4fHjWCVS78xNXYAvS
         4d6zhHgu7LAG6rYPpwwmkahTgKKAxMxg9q1FCsK6oRWdZjQ0952YNkZ+Jg8BxkwgH8gq
         6MGA==
X-Gm-Message-State: AOJu0YxnMxK6roIwO1w0HuDY2MBzwrEXYlMyXxqcUUvn5tHu1b8acV8h
	LjdgMWtKI+L0hfqjHHyYrIc=
X-Google-Smtp-Source: AGHT+IFoipMCEJ3awFiLn4aozQbzlguNHRPZi+PJD3NFAPKFhMbQsvlQsL1esPlqfTEAYvENQDOFbw==
X-Received: by 2002:a2e:8055:0:b0:2c5:ab3b:d676 with SMTP id p21-20020a2e8055000000b002c5ab3bd676mr13962057ljg.9.1698858750403;
        Wed, 01 Nov 2023 10:12:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g8-20020a2ea4a8000000b002b9b90474c7sm243243ljm.129.2023.11.01.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:12:29 -0700 (PDT)
Message-ID: <974fa4a2b943815af1e0b9df0f63a54395514be4.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 18/23] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 01 Nov 2023 19:12:28 +0200
In-Reply-To: <CAEf4BzYgipydujRq43avXfSHixCjK4NEOc_pzgpUVjbC88Q0-A@mail.gmail.com>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-19-andrii@kernel.org>
	 <2b4d9d4728b77bd5781cd1bd7110c12af2aefc35.camel@gmail.com>
	 <CAEf4BzYgipydujRq43avXfSHixCjK4NEOc_pzgpUVjbC88Q0-A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-01 at 09:35 -0700, Andrii Nakryiko wrote:
> On Tue, Oct 31, 2023 at 4:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > > Generalize bounds adjustment logic of reg_set_min_max() to handle not
> > > just register vs constant case, but in general any register vs any
> > > register cases. For most of the operations it's trivial extension bas=
ed
> > > on range vs range comparison logic, we just need to properly pick
> > > min/max of a range to compare against min/max of the other range.
> > >=20
> > > For BPF_JSET we keep the original capabilities, just make sure JSET i=
s
> > > integrated in the common framework. This is manifested in the
> > > internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
> > > uniform rev_opcode() handling. See the code for details. This allows =
to
> > > reuse the same code exactly both for TRUE and FALSE branches without
> > > explicitly handling both conditions with custom code.
> > >=20
> > > Note also that now we don't need a special handling of BPF_JEQ/BPF_JN=
E
> > > case none of the registers are constants. This is now just a normal
> > > generic case handled by reg_set_min_max().
> > >=20
> > > To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> > > that's a common operator when dealing with 32-bit subregister bounds.
> > > This keeps the overall logic much less noisy when it comes to tnums.
> > >=20
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/tnum.h  |   4 +
> > >  kernel/bpf/tnum.c     |   7 +-
> > >  kernel/bpf/verifier.c | 321 +++++++++++++++++++---------------------=
--
> > >  3 files changed, 157 insertions(+), 175 deletions(-)
> > >=20
> > > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > > index 1c3948a1d6ad..3c13240077b8 100644
> > > --- a/include/linux/tnum.h
> > > +++ b/include/linux/tnum.h
> > > @@ -106,6 +106,10 @@ int tnum_sbin(char *str, size_t size, struct tnu=
m a);
> > >  struct tnum tnum_subreg(struct tnum a);
> > >  /* Returns the tnum with the lower 32-bit subreg cleared */
> > >  struct tnum tnum_clear_subreg(struct tnum a);
> > > +/* Returns the tnum with the lower 32-bit subreg in *reg* set to the=
 lower
> > > + * 32-bit subreg in *subreg*
> > > + */
> > > +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg);
> > >  /* Returns the tnum with the lower 32-bit subreg set to value */
> > >  struct tnum tnum_const_subreg(struct tnum a, u32 value);
> > >  /* Returns true if 32-bit subreg @a is a known constant*/
> > > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > > index 3d7127f439a1..f4c91c9b27d7 100644
> > > --- a/kernel/bpf/tnum.c
> > > +++ b/kernel/bpf/tnum.c
> > > @@ -208,7 +208,12 @@ struct tnum tnum_clear_subreg(struct tnum a)
> > >       return tnum_lshift(tnum_rshift(a, 32), 32);
> > >  }
> > >=20
> > > +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
> > > +{
> > > +     return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
> > > +}
> > > +
> > >  struct tnum tnum_const_subreg(struct tnum a, u32 value)
> > >  {
> > > -     return tnum_or(tnum_clear_subreg(a), tnum_const(value));
> > > +     return tnum_with_subreg(a, tnum_const(value));
> > >  }
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 522566699fbe..4c974296127b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -14381,217 +14381,201 @@ static int is_branch_taken(struct bpf_reg=
_state *reg1, struct bpf_reg_state *reg
> > >       return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
> > >  }
> > >=20
> > > -/* Adjusts the register min/max values in the case that the dst_reg =
is the
> > > - * variable register that we are working on, and src_reg is a consta=
nt or we're
> > > - * simply doing a BPF_K check.
> > > - * In JEQ/JNE cases we also adjust the var_off values.
> > > +/* Opcode that corresponds to a *false* branch condition.
> > > + * E.g., if r1 < r2, then reverse (false) condition is r1 >=3D r2
> > >   */
> > > -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > > -                         struct bpf_reg_state *true_reg2,
> > > -                         struct bpf_reg_state *false_reg1,
> > > -                         struct bpf_reg_state *false_reg2,
> > > -                         u8 opcode, bool is_jmp32)
> > > +static u8 rev_opcode(u8 opcode)
> >=20
> > Note: this duplicates flip_opcode() (modulo BPF_JSET).
>=20
> Not at all! flip_opcode() is for swapping argument order, so JEQ stays
> JEQ, but <=3D becomes >=3D. While rev_opcode() is for the true/false
> branch. So JEQ in the true branch becomes JNE in the false branch, <
> is true is complemented by >=3D in the false branch.

Right, my bad, sorry.

>=20
> >=20
> > >  {
> > > -     struct tnum false_32off, false_64off;
> > > -     struct tnum true_32off, true_64off;
> > > -     u64 val;
> > > -     u32 val32;
> > > -     s64 sval;
> > > -     s32 sval32;
> > > -
>=20
> [...]
>=20
> > > +             /* we don't derive any new information for inequality y=
et */
> > > +             break;
> > > +     case BPF_JSET:
> > > +     case BPF_JSET | BPF_X: { /* BPF_JSET and its reverse, see rev_o=
pcode() */
> > > +             u64 val;
> > > +
> > > +             if (!is_reg_const(reg2, is_jmp32))
> > > +                     swap(reg1, reg2);
> > > +             if (!is_reg_const(reg2, is_jmp32))
> > > +                     break;
> > > +
> > > +             val =3D reg_const_value(reg2, is_jmp32);
> > > +             /* BPF_JSET requires single bit to learn something usef=
ul */
> > > +             if (!(opcode & BPF_X) && !is_power_of_2(val))
> >=20
> > Could you please extend comment a bit, e.g. as follows:
> >=20
> >                 /* For BPF_JSET true branch (!(opcode & BPF_X)) a singl=
e bit
> >          * is needed to learn something useful.
> >          */
> >=20
> > For some reason it took me a while to understand this condition :(
>=20
> ok, sure
>=20
> >=20
> > > +                     break;
> > > +
>=20
> [...]
>=20
> > > -     case BPF_JGE:
> > >       case BPF_JGT:
> > > -     {
> > >               if (is_jmp32) {
> > > -                     u32 false_umax =3D opcode =3D=3D BPF_JGT ? val3=
2  : val32 - 1;
> > > -                     u32 true_umin =3D opcode =3D=3D BPF_JGT ? val32=
 + 1 : val32;
> > > -
> > > -                     false_reg1->u32_max_value =3D min(false_reg1->u=
32_max_value,
> > > -                                                    false_umax);
> > > -                     true_reg1->u32_min_value =3D max(true_reg1->u32=
_min_value,
> > > -                                                   true_umin);
> > > +                     reg1->u32_min_value =3D max(reg1->u32_min_value=
, reg2->u32_min_value + 1);
> >=20
> > Question: This branch means that reg1 > reg2, right?
> >           If so, why not use reg2->u32_MAX_value, e.g.:
> >=20
> >                         reg1->u32_min_value =3D max(reg1->u32_min_value=
, reg2->u32_max_value + 1);
> >=20
> >           Do I miss something?
>=20
> Let's say reg1 can be anything in [10, 20], while reg2 is in [15, 30].
> if reg1 > reg2, then we can only guarantee that reg1 can be [16, 20],
> because worst case reg2 =3D 15, not 30, right?

Right, thank you.
I should probably refrain from sending comments after midnight.

>=20
> >=20
> > > +                     reg2->u32_max_value =3D min(reg1->u32_max_value=
 - 1, reg2->u32_max_value);
> > >               } else {
> > > -                     u64 false_umax =3D opcode =3D=3D BPF_JGT ? val =
   : val - 1;
> > > -                     u64 true_umin =3D opcode =3D=3D BPF_JGT ? val +=
 1 : val;
> > > -
> > > -                     false_reg1->umax_value =3D min(false_reg1->umax=
_value, false_umax);
> > > -                     true_reg1->umin_value =3D max(true_reg1->umin_v=
alue, true_umin);
> > > +                     reg1->umin_value =3D max(reg1->umin_value, reg2=
->umin_value + 1);
> > > +                     reg2->umax_value =3D min(reg1->umax_value - 1, =
reg2->umax_value);
> > >               }
> > >               break;
>=20
> [...]


