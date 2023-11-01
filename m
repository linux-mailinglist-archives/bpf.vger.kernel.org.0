Return-Path: <bpf+bounces-13809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3487DE4A4
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C9F1C20DDE
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732D12B83;
	Wed,  1 Nov 2023 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxIl8TJa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DCF79F8
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 16:35:32 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E248811B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 09:35:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso11031368a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698856527; x=1699461327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emwmy90JiFjuKO6N3mAtVZsA6E6j/msvdqPOOJN/8us=;
        b=mxIl8TJa69pDRGsyodvLHycFhBh3jTQ4VG1DHtuuHy7lQSDE/nvm0OSNO6NbG4GADE
         h4pkmQraw8vmu3Fh8wd0odQ8WVrQ2NFGzSnwUxGHlJAtT0akTcM4J4QkgdOgKorbcF7k
         IYQ3YQUwRom+1/wS/3H/UCHc8PPEfCuVPr3vL1+sMbpfuqyOL2IAGd8704ZSLACOJ2B4
         gcIgnDXhx0Xsi4LMAt3ltjDo0BZs9eSmG6RIA/bzGkFRPETMPUC7CTcQly3VredM6PME
         zU21UohsKvgnusZWdZNPHr+CJYl6PxMkc069nMsuacfoicYd19dJHqzoCZHw13w6sFkf
         rNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856527; x=1699461327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emwmy90JiFjuKO6N3mAtVZsA6E6j/msvdqPOOJN/8us=;
        b=nVlgwpnBWohtTVCJXQgXxp37hBxwtKm84qcsgj+RPegCjCzp07aCUwyIPXsXGnZdyj
         icTo1Jc4Prm45FkRry++4whZ3qks6muO8wUdi2htU629PPd+veAyZzbDriBVrUm1ctF+
         MllQEm9dASc0PyCHYGDOfjmp4nnixmcFqZUd/SBhA6Y4XaGIuE0eGSyQ7IQX+DRgeN92
         KYzswGgowBcwMQC0uh71UvgdAyWmkn8XSGW1t11bCwPzqiaWLADRNhRX+sNkChbf3Z8v
         pLGHTNz0a+7WwJwEHa7EUnCtuxaB1pxGvCP4snZ86q0rTIsm3iDU3FuiiXxVziY37VhG
         sCXA==
X-Gm-Message-State: AOJu0YwOYV3VKQP7tmqqq5PgzkTrlAyNvU28I9eImVFFlZETO+by3dN0
	qKnbHfg8qYbi5DiDY9CPjMobq+cQMFcpvl09cp8=
X-Google-Smtp-Source: AGHT+IGrTmZI+ojWynjdI7BcTerMKJWrCLvUj8ihIf6EvwTuniGNIRVX0wLNMIyfCh4yyo0A3cpbAUOtGZqJ7fQiLOY=
X-Received: by 2002:a17:907:2683:b0:9d3:ccd1:b98c with SMTP id
 bn3-20020a170907268300b009d3ccd1b98cmr2535228ejc.40.1698856526888; Wed, 01
 Nov 2023 09:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-19-andrii@kernel.org>
 <2b4d9d4728b77bd5781cd1bd7110c12af2aefc35.camel@gmail.com>
In-Reply-To: <2b4d9d4728b77bd5781cd1bd7110c12af2aefc35.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 09:35:15 -0700
Message-ID: <CAEf4BzYgipydujRq43avXfSHixCjK4NEOc_pzgpUVjbC88Q0-A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 18/23] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 4:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Generalize bounds adjustment logic of reg_set_min_max() to handle not
> > just register vs constant case, but in general any register vs any
> > register cases. For most of the operations it's trivial extension based
> > on range vs range comparison logic, we just need to properly pick
> > min/max of a range to compare against min/max of the other range.
> >
> > For BPF_JSET we keep the original capabilities, just make sure JSET is
> > integrated in the common framework. This is manifested in the
> > internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
> > uniform rev_opcode() handling. See the code for details. This allows to
> > reuse the same code exactly both for TRUE and FALSE branches without
> > explicitly handling both conditions with custom code.
> >
> > Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> > case none of the registers are constants. This is now just a normal
> > generic case handled by reg_set_min_max().
> >
> > To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> > that's a common operator when dealing with 32-bit subregister bounds.
> > This keeps the overall logic much less noisy when it comes to tnums.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/tnum.h  |   4 +
> >  kernel/bpf/tnum.c     |   7 +-
> >  kernel/bpf/verifier.c | 321 +++++++++++++++++++-----------------------
> >  3 files changed, 157 insertions(+), 175 deletions(-)
> >
> > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > index 1c3948a1d6ad..3c13240077b8 100644
> > --- a/include/linux/tnum.h
> > +++ b/include/linux/tnum.h
> > @@ -106,6 +106,10 @@ int tnum_sbin(char *str, size_t size, struct tnum =
a);
> >  struct tnum tnum_subreg(struct tnum a);
> >  /* Returns the tnum with the lower 32-bit subreg cleared */
> >  struct tnum tnum_clear_subreg(struct tnum a);
> > +/* Returns the tnum with the lower 32-bit subreg in *reg* set to the l=
ower
> > + * 32-bit subreg in *subreg*
> > + */
> > +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg);
> >  /* Returns the tnum with the lower 32-bit subreg set to value */
> >  struct tnum tnum_const_subreg(struct tnum a, u32 value);
> >  /* Returns true if 32-bit subreg @a is a known constant*/
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index 3d7127f439a1..f4c91c9b27d7 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -208,7 +208,12 @@ struct tnum tnum_clear_subreg(struct tnum a)
> >       return tnum_lshift(tnum_rshift(a, 32), 32);
> >  }
> >
> > +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
> > +{
> > +     return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
> > +}
> > +
> >  struct tnum tnum_const_subreg(struct tnum a, u32 value)
> >  {
> > -     return tnum_or(tnum_clear_subreg(a), tnum_const(value));
> > +     return tnum_with_subreg(a, tnum_const(value));
> >  }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 522566699fbe..4c974296127b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14381,217 +14381,201 @@ static int is_branch_taken(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state *reg
> >       return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
> >  }
> >
> > -/* Adjusts the register min/max values in the case that the dst_reg is=
 the
> > - * variable register that we are working on, and src_reg is a constant=
 or we're
> > - * simply doing a BPF_K check.
> > - * In JEQ/JNE cases we also adjust the var_off values.
> > +/* Opcode that corresponds to a *false* branch condition.
> > + * E.g., if r1 < r2, then reverse (false) condition is r1 >=3D r2
> >   */
> > -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > -                         struct bpf_reg_state *true_reg2,
> > -                         struct bpf_reg_state *false_reg1,
> > -                         struct bpf_reg_state *false_reg2,
> > -                         u8 opcode, bool is_jmp32)
> > +static u8 rev_opcode(u8 opcode)
>
> Note: this duplicates flip_opcode() (modulo BPF_JSET).

Not at all! flip_opcode() is for swapping argument order, so JEQ stays
JEQ, but <=3D becomes >=3D. While rev_opcode() is for the true/false
branch. So JEQ in the true branch becomes JNE in the false branch, <
is true is complemented by >=3D in the false branch.

>
> >  {
> > -     struct tnum false_32off, false_64off;
> > -     struct tnum true_32off, true_64off;
> > -     u64 val;
> > -     u32 val32;
> > -     s64 sval;
> > -     s32 sval32;
> > -

[...]

> > +             /* we don't derive any new information for inequality yet=
 */
> > +             break;
> > +     case BPF_JSET:
> > +     case BPF_JSET | BPF_X: { /* BPF_JSET and its reverse, see rev_opc=
ode() */
> > +             u64 val;
> > +
> > +             if (!is_reg_const(reg2, is_jmp32))
> > +                     swap(reg1, reg2);
> > +             if (!is_reg_const(reg2, is_jmp32))
> > +                     break;
> > +
> > +             val =3D reg_const_value(reg2, is_jmp32);
> > +             /* BPF_JSET requires single bit to learn something useful=
 */
> > +             if (!(opcode & BPF_X) && !is_power_of_2(val))
>
> Could you please extend comment a bit, e.g. as follows:
>
>                 /* For BPF_JSET true branch (!(opcode & BPF_X)) a single =
bit
>          * is needed to learn something useful.
>          */
>
> For some reason it took me a while to understand this condition :(

ok, sure

>
> > +                     break;
> > +

[...]

> > -     case BPF_JGE:
> >       case BPF_JGT:
> > -     {
> >               if (is_jmp32) {
> > -                     u32 false_umax =3D opcode =3D=3D BPF_JGT ? val32 =
 : val32 - 1;
> > -                     u32 true_umin =3D opcode =3D=3D BPF_JGT ? val32 +=
 1 : val32;
> > -
> > -                     false_reg1->u32_max_value =3D min(false_reg1->u32=
_max_value,
> > -                                                    false_umax);
> > -                     true_reg1->u32_min_value =3D max(true_reg1->u32_m=
in_value,
> > -                                                   true_umin);
> > +                     reg1->u32_min_value =3D max(reg1->u32_min_value, =
reg2->u32_min_value + 1);
>
> Question: This branch means that reg1 > reg2, right?
>           If so, why not use reg2->u32_MAX_value, e.g.:
>
>                         reg1->u32_min_value =3D max(reg1->u32_min_value, =
reg2->u32_max_value + 1);
>
>           Do I miss something?

Let's say reg1 can be anything in [10, 20], while reg2 is in [15, 30].
if reg1 > reg2, then we can only guarantee that reg1 can be [16, 20],
because worst case reg2 =3D 15, not 30, right?

>
> > +                     reg2->u32_max_value =3D min(reg1->u32_max_value -=
 1, reg2->u32_max_value);
> >               } else {
> > -                     u64 false_umax =3D opcode =3D=3D BPF_JGT ? val   =
 : val - 1;
> > -                     u64 true_umin =3D opcode =3D=3D BPF_JGT ? val + 1=
 : val;
> > -
> > -                     false_reg1->umax_value =3D min(false_reg1->umax_v=
alue, false_umax);
> > -                     true_reg1->umin_value =3D max(true_reg1->umin_val=
ue, true_umin);
> > +                     reg1->umin_value =3D max(reg1->umin_value, reg2->=
umin_value + 1);
> > +                     reg2->umax_value =3D min(reg1->umax_value - 1, re=
g2->umax_value);
> >               }
> >               break;

[...]

