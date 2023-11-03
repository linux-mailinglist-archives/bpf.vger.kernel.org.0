Return-Path: <bpf+bounces-14121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092CE7E0A7F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08A3281FC9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45F20B22;
	Fri,  3 Nov 2023 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGTts+dT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A21D695
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 20:48:48 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262AD64
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 13:48:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so4251519a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044523; x=1699649323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS3Cr3MiMxTfIWPG4sN2LxHaj7yiyU8eAsPlGBNNwoc=;
        b=nGTts+dTUUpMffhsrX0vlErTOTkRYbDuLD6OomHlX3IyGcUeKeatouXNd1L0LNRJ01
         +GI4pWnvV4xXd+ITVApvqO8VmZt6WDOytdyj/0L1S1tIV69ElQV0mER+etQMmL4oFzGQ
         gXyzCfWVlQyz4WbVaeXW8/JwvwrbXu9WW7hIGtgKrWKKtGS3snn86hoftfqMvNxIZI5q
         jS4TddV5Nw4jqm03ZKNobcbJ8j9npKsMJaRn9+MznrssDtUeBrCqOmFs6qnvntuJUtAQ
         fKD6MALRafgoFC/273+eM0kj/+HudWDbAwbtPdFQ8U09g0tkqVH5UN7UzEvhLV5vRzXU
         WDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044523; x=1699649323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS3Cr3MiMxTfIWPG4sN2LxHaj7yiyU8eAsPlGBNNwoc=;
        b=LuEdT43kT6sOPpSDrP5D44t5fQDgwIHG8MqIVUZ6cJpBXppE5FkaHF446HjiP4c+FF
         uw9rG8vSSvYyJEOX1T2O0ixAfAB+Thhltyb250jMECQ2C+0ZBISa+Xb1hdg0qpvlKG8r
         ibBa9lsFM7uaSdw1G1Pl2b5+i9bW45G9MEanBj0TQPhR4f+zRzwFNktwP6OexviysI8K
         3lFt4nXkR9wvOaUcaaCbVqBIvOcVszkZ50Rd5r7cbeq2lV1UUfNX+U+TAoczm4/qlVjH
         DxgEgAfNZcNBRxlz2+GdSimJDPq51QYoghSwEBAbeHyG7E4ozSv0AzdOnixcrr7QUoEL
         C79A==
X-Gm-Message-State: AOJu0YyJuXZ4khEnn1iLu1NYf4HdsdpYYisxNfqGJI9j/USAWxr+DU9J
	OSqYpFztLhX7xqY2zpJZd0Tp86ViCKXjD7xYW6CxVGT0
X-Google-Smtp-Source: AGHT+IHJl8Pk+Md9rus5kePZXdkWB/i7A7a5wDW93D/vTgNbuyCKmKsr82GGKOlSF3/GlCeC0YPA08ktE2vDPvNuLgw=
X-Received: by 2002:a17:907:7291:b0:9c7:59d1:b2cc with SMTP id
 dt17-20020a170907729100b009c759d1b2ccmr7915201ejc.0.1699044523230; Fri, 03
 Nov 2023 13:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-2-andrii@kernel.org>
 <ZUSmxI9EoWjUyO_t@u94a> <CAEf4BzbLGn0eNmrZSTWGJsnVLFxfccTg3sjot8KXLeXhRFboGw@mail.gmail.com>
In-Reply-To: <CAEf4BzbLGn0eNmrZSTWGJsnVLFxfccTg3sjot8KXLeXhRFboGw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 13:48:32 -0700
Message-ID: <CAEf4Bzad0wKa5bvRu64Ybvgve-JVZvHPm2Ypvm9QJFW22Q3Sjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/13] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 1:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 12:52=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.c=
om> wrote:
> >
> > On Thu, Nov 02, 2023 at 05:08:10PM -0700, Andrii Nakryiko wrote:
> > > Generalize bounds adjustment logic of reg_set_min_max() to handle not
> > > just register vs constant case, but in general any register vs any
> > > register cases. For most of the operations it's trivial extension bas=
ed
> > > on range vs range comparison logic, we just need to properly pick
> > > min/max of a range to compare against min/max of the other range.
> > >
> > > For BPF_JSET we keep the original capabilities, just make sure JSET i=
s
> > > integrated in the common framework. This is manifested in the
> > > internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
> >                     ^ typo?
> >
> > Two more comments below
> >
> > > uniform rev_opcode() handling. See the code for details. This allows =
to
> > > reuse the same code exactly both for TRUE and FALSE branches without
> > > explicitly handling both conditions with custom code.
> > >
> > > Note also that now we don't need a special handling of BPF_JEQ/BPF_JN=
E
> > > case none of the registers are constants. This is now just a normal
> > > generic case handled by reg_set_min_max().
> > >
> > > To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> > > that's a common operator when dealing with 32-bit subregister bounds.
> > > This keeps the overall logic much less noisy when it comes to tnums.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/tnum.h  |   4 +
> > >  kernel/bpf/tnum.c     |   7 +-
> > >  kernel/bpf/verifier.c | 327 ++++++++++++++++++++--------------------=
--
> > >  3 files changed, 165 insertions(+), 173 deletions(-)
> > >
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
> > >
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
> > > index 2197385d91dc..52934080042c 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -14379,218 +14379,211 @@ static int is_branch_taken(struct bpf_reg=
_state *reg1, struct bpf_reg_state *reg
> > >       return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
> > >  }
> > >
> > > -/* Adjusts the register min/max values in the case that the dst_reg =
and
> > > - * src_reg are both SCALAR_VALUE registers (or we are simply doing a=
 BPF_K
> > > - * check, in which case we havea fake SCALAR_VALUE representing insn=
->imm).
> > > - * Technically we can do similar adjustments for pointers to the sam=
e object,
> > > - * but we don't support that right now.
> > > +/* Opcode that corresponds to a *false* branch condition.
> > > + * E.g., if r1 < r2, then reverse (false) condition is r1 >=3D r2
> > >   */
> > > -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > > -                         struct bpf_reg_state *true_reg2,
> > > -                         struct bpf_reg_state *false_reg1,
> > > -                         struct bpf_reg_state *false_reg2,
> > > -                         u8 opcode, bool is_jmp32)
> > > +static u8 rev_opcode(u8 opcode)
> >
> > Nit: rev_opcode and flip_opcode seems like a possible source of confusi=
ng
> > down the line. Flip and reverse are often interchangable, i.e. "flip th=
e
> > order" and "reverse the order" is the same thing.
> >
> > Maybe "neg_opcode" or "neg_cond_opcode"?
>
> neg has too strong connotation with BPF_NEG, so not really happy with
> this one. In selftest I used "complement_op", but it's also quite
> arbitrary.
>
> >
> > Or do it the otherway around, keep rev_opcode but rename flip_opcode.
>
> how about flip_opcode -> swap_opcode? and then keep reg_opcode as is?

nah, swap_opcode sounds wrong as well. I guess I'll just leave it as is for=
 now.

>
> >
> > One more comment about BPF_JSET below
> >
>
> please trim big chunks of code you are not commenting on to keep
> emails a bit shorter
>
> [...]
>
>
> > >               if (is_jmp32) {
> > > -                     __mark_reg32_known(false_reg1, uval32);
> > > -                     false_32off =3D tnum_subreg(false_reg1->var_off=
);
> > > +                     if (opcode & BPF_X)
> > > +                             t =3D tnum_and(tnum_subreg(reg1->var_of=
f), tnum_const(~val));
> > > +                     else
> > > +                             t =3D tnum_or(tnum_subreg(reg1->var_off=
), tnum_const(val));
> > > +                     reg1->var_off =3D tnum_with_subreg(reg1->var_of=
f, t);
> > >               } else {
> > > -                     ___mark_reg_known(false_reg1, uval);
> > > -                     false_64off =3D false_reg1->var_off;
> > > +                     if (opcode & BPF_X)
> > > +                             reg1->var_off =3D tnum_and(reg1->var_of=
f, tnum_const(~val));
> > > +                     else
> > > +                             reg1->var_off =3D tnum_or(reg1->var_off=
, tnum_const(val));
> > >               }
> > >               break;
> >
> > Since you're already adding a tnum helper, I think we can add one more
> > for BPF_JSET here
> >
> >         struct tnum tnum_neg(struct tnum a)
> >         {
> >                 return TNUM(~a.value, a.mask);
> >         }
> >
>
> I'm not sure what tnum_neg() does (even if the correct
> implementation), but either way I'd like to minimize touching tnum
> stuff, it's too tricky :) we can address that as a separate patch if
> you'd like
>
>
> > So instead of getting a value out of tnum then putting the value back
> > into tnum again
> >
> >     u64 val;
> >     val =3D reg_const_value(reg2, is_jmp32);
> >     tnum_ops(..., tnum_const(val or ~val);
> >
> > Keep the value in tnum and process it as-is if possible
> >
> >     tnum_ops(..., reg2->var_off or tnum_neg(reg2->var_off));
>
> >
> > And with that hopefully make this fragment short enough that we don't
> > mind duplicate a bit of code to seperate the BPF_JSET case from the
> > BPF_JSET | BPF_X case. IMO a conditional is_power_of_2 check followed b=
y
> > two level of branching is a bit too much to follow, it is better to hav=
e
> > them seperated just like how you're doing it for the others already.
>
> I can split those two cases without any new tnum helpers, the
> duplicated part is just const checking, basically, no big deal
>
> >
> > I.e. something like the follow
> >
> >         case BPF_JSET: {
> >                 if (!is_reg_const(reg2, is_jmp32))
> >                         swap(reg1, reg2);
> >                 if (!is_reg_const(reg2, is_jmp32))
> >                         break;
> >                 /* comment */
> >                 if (!is_power_of_2(reg_const_value(reg2, is_jmp32))
> >                         break;
> >
> >                 if (is_jmp32) {
> >                         t =3D tnum_or(tnum_subreg(reg1->var_off), tnum_=
subreg(reg2->var_off));
> >                         reg1->var_off =3D tnum_with_subreg(reg1->var_of=
f, t);
> >                 } else {
> >                         reg1->var_off =3D tnum_or(reg1->var_off, reg2->=
var_off);
> >                 }
> >                 break;
> >         }
> >         case BPF_JSET | BPF_X: {
> >                 if (!is_reg_const(reg2, is_jmp32))
> >                         swap(reg1, reg2);
> >                 if (!is_reg_const(reg2, is_jmp32))
> >                         break;
> >
> >                 if (is_jmp32) {
> >                         /* a slightly long line ... */
> >                         t =3D tnum_and(tnum_subreg(reg1->var_off), tnum=
_neg(tnum_subreg(reg2->var_off)));
> >                         reg1->var_off =3D tnum_with_subreg(reg1->var_of=
f, t);
> >                 } else {
> >                         reg1->var_off =3D tnum_and(reg1->var_off, tnum_=
neg(reg2->var_off));
> >                 }
> >                 break;
> >         }
> >
> > > ...

