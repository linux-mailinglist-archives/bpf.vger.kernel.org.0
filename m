Return-Path: <bpf+bounces-13735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA357DD571
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0F92818F0
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01A20B17;
	Tue, 31 Oct 2023 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv0PkfCr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E2208CF
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:50:45 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27512E4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:50:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso413613566b.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698774642; x=1699379442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVg2AG+Lwariw1WKiPyqulp7+oiL9WnhpqDPVfhFT8A=;
        b=bv0PkfCrztHn23xbO49NEuWJDQrTa57oPUU1UIaYNIdF1hnBocAuvyijusLfLC2Xb2
         YgCEicjORGd/GTHys8i3pcwHmLU2vB3jVNNcBDyYlRtq9xq00tGGTceh6sR5ElaaCw0Z
         GxZY5irQ48GIxFWLUp7KmHumQtbHX9Ni84DQbpl4xGRzQie3h2Jd5J4681SbaX6/8zs5
         A64SNh3Z/uJ+IoWx+o0iJbPzWsnVCNLtC8pUcomig1qO09l7PTqTdfCm/3Xqi0oByusf
         cXY7YkO2Y1tidVKcaYOgNRKm+9ja9iC2GexKEFF+E5SDJdl9zPLG3qNSKwLY5TuZRIhu
         YiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774642; x=1699379442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVg2AG+Lwariw1WKiPyqulp7+oiL9WnhpqDPVfhFT8A=;
        b=fU7gKqMvXfOoZdV1MtEpuHYGS9fcvual2BpvjQtksMYHvgJ2x2LdypE9cZFvRn//w+
         jU4Dx9p1xlmKFolMoQT2lPnXRPWjxAQwDbC9Jhh+57cisPKrhHZ6DsAoaA11LD9wfH5Z
         qlyAO8VfQ4FM7uGOVIlZLIHQuHIA93KIUpWXRLRbu/vKpswj3Dg2VDYAHApl9vazkoWy
         5Rj1t5wnSIQaEvdAfnASDePr4vQySqEjTtBV09RmeSyXhJc4vSz7gHCJKR0nt/XK4vUq
         Spu7TN20OCgwnKrIcQkVr4hdLi2/52/Cllz3aV0bfpJI6/DgyxhfWyDQx99G6WIQNjCQ
         G+KA==
X-Gm-Message-State: AOJu0YwT1CyhLCHJBiu2qCnCvJP5rvaKKr7VNeGihVMLgLkvW61IgDer
	nODPWlLuJWresxYIPqVs88vpuanWES0hHwV34RQ=
X-Google-Smtp-Source: AGHT+IHPWPUOX3gkQZm69APGM6L9oxcsUZZ5NYTtCriNTYFgHPM4AGmbPAO0tuTUyl1nr0ktXrMpeo0C0D57hC9eQkA=
X-Received: by 2002:a17:907:7f15:b0:9bd:a75a:5644 with SMTP id
 qf21-20020a1709077f1500b009bda75a5644mr74357ejc.16.1698774642102; Tue, 31 Oct
 2023 10:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-18-andrii@kernel.org>
 <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local> <CAEf4BzbZT11cYbinnGaqGZPiX2Mq5Taksx=VWOMhpuKEj8cXcA@mail.gmail.com>
 <CAADnVQLADK67wpesGfn=9EoAnXcHV8inBqOt79hjpSdvNS=yiQ@mail.gmail.com>
In-Reply-To: <CAADnVQLADK67wpesGfn=9EoAnXcHV8inBqOt79hjpSdvNS=yiQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 10:50:30 -0700
Message-ID: <CAEf4BzbTc9wv=QU_ziG+TGcpHkLoQe_0NicKZF83KXgiCfqJFQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 9:24=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 11:03=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 7:02=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 11:13:40AM -0700, Andrii Nakryiko wrote:
> > > >  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> > > > +                         struct bpf_reg_state *true_reg2,
> > > >                           struct bpf_reg_state *false_reg1,
> > > > -                         u64 val, u32 val32,
> > > > +                         struct bpf_reg_state *false_reg2,
> > > >                           u8 opcode, bool is_jmp32)
> > > >  {
> > > > -     struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
> > > > -     struct tnum false_64off =3D false_reg1->var_off;
> > > > -     struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
> > > > -     struct tnum true_64off =3D true_reg1->var_off;
> > > > -     s64 sval =3D (s64)val;
> > > > -     s32 sval32 =3D (s32)val32;
> > > > -
> > > > -     /* If the dst_reg is a pointer, we can't learn anything about=
 its
> > > > -      * variable offset from the compare (unless src_reg were a po=
inter into
> > > > -      * the same object, but we don't bother with that.
> > > > -      * Since false_reg1 and true_reg1 have the same type by const=
ruction, we
> > > > -      * only need to check one of them for pointerness.
> > > > +     struct tnum false_32off, false_64off;
> > > > +     struct tnum true_32off, true_64off;
> > > > +     u64 val;
> > > > +     u32 val32;
> > > > +     s64 sval;
> > > > +     s32 sval32;
> > > > +
> > > > +     /* If either register is a pointer, we can't learn anything a=
bout its
> > > > +      * variable offset from the compare (unless they were a point=
er into
> > > > +      * the same object, but we don't bother with that).
> > > >        */
> > > > -     if (__is_pointer_value(false, false_reg1))
> > >
> > > The removal of the above check, but not the comment was surprising an=
d concerning,
> > > so I did a bit of git-archaeology.
> > > It was added in commit f1174f77b50c ("bpf/verifier: rework value trac=
king")
> > > back in 2017 !
> > > and in that commit reg_set_min_max() was always called with reg =3D=
=3D scalar.
> > > It looked like premature check. Then I spotted a comment in that comm=
it:
> > >   * this is only legit if both are scalars (or pointers to the same
> > >   * object, I suppose, but we don't support that right now), because
> > >   * otherwise the different base pointers mean the offsets aren't
> > >   * comparable.
> > > so the intent back then was to generalize reg_set_min_max() to be use=
d with pointers too,
> > > but we never got around to do that and the comment now reads:
> >
> > Yeah, it shouldn't be too hard to "generalize" to pointer vs pointer,
> > if we ensure they point to exactly the same thing (I haven't thought
> > much about how), because beyond that it's still basically SCALAR
> > offsets. But I figured it's out of scope for these changes :)
> >
> > >   * this is only legit if both are scalars (or pointers to the same
> > >   * object, I suppose, see the PTR_MAYBE_NULL related if block below)=
,
> > >   * because otherwise the different base pointers mean the offsets ar=
en't
> > >   * comparable.
> > >
> > > So please remove is_pointer check and remove the comment,
> >
> > So I'm a bit confused. I did remove __is_pointer_value() check, but I
> > still need to guard against having pointers, which is why I have:
> >
> > if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE).
> >     return;
> >
> > I think I need this check, because reg_set_min_max() can be called
> > from check_cond_jmp_op() with pointer regs, and we shouldn't try to
> > adjust them. Or am I missing something? And the comment I have here
> > now:
>
> I don't see a code path where reg_set_min_max() is called
> with pointers. At least not in the current code base.
> Are you saying somewhere in your later patch it happens?
>

Hm.. no, it's all in this patch. Check check_cond_jmp_op(). We at
least allow `(reg_is_pkt_pointer_any(dst_reg) &&
reg_is_pkt_pointer_any(src_reg)` case to get into is_branch_taken(),
which, btw, does handle pointer x pointer, pointer x scalar, and
scalar x scalar cases. Then, we go straight to reg_set_min_max(), both
for BPF_X and BPF_K cases. So reg_set_min_max() has to guard itself
against pointers.


> Then the question is whether to do this is_scalar check inside
> reg_set_min_max() or outside. Both options are probably fine.

Given we have two separate calls to reg_set_min_max(), BPF_X and
BPF_K, it seems cleaner to do it once at the beginning of
reg_set_min_max(). And if in the future we do support pointer
variants, I'd handle them inside reg_set_min_max(), just like
is_branch_taken() handles different situations in one place
transparently to the caller.

>
> >
> > +       /* If either register is a pointer, we can't learn anything abo=
ut its
> > +        * variable offset from the compare (unless they were a pointer=
 into
> > +        * the same object, but we don't bother with that).
> >          */
> >
> > is trying to explain that we don't really adjust two pointers.
> >
> > > and fixup the comment in check_cond_jmp_op() where reg_set_min_max().
> >
> > I have this locally for now, please let me know if this is fine or you
> > had something else in mind:
> >
> > -/* Adjusts the register min/max values in the case that the dst_reg is=
 the
> > - * variable register that we are working on, and src_reg is a constant=
 or we're
> > - * simply doing a BPF_K check.
> > - * In JEQ/JNE cases we also adjust the var_off values.
> > +/* Adjusts the register min/max values in the case that the dst_reg an=
d
> > + * src_reg are both SCALAR_VALUE registers (or we are simply doing a B=
PF_K
> > + * check, in which case we havea fake SCALAR_VALUE representing insn->=
imm).
> > + * Technically we can do similar adjustments for pointers to the same =
object,
> > + * but we don't support that right now.
>
> Looks fine. I'm trying to say that we had such comment forever and
> it never lead to actually doing the work.
> So I'd just remove the last sentence about pointers ...

Ah, ok, yep, sure.

>
> >   */
> >  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> >                             struct bpf_reg_state *true_reg2,
> > @@ -14884,13 +14885,6 @@ static int check_cond_jmp_op(struct
> > bpf_verifier_env *env,
> >                 return -EFAULT;
> >         other_branch_regs =3D other_branch->frame[other_branch->curfram=
e]->regs;
> >
> > -       /* detect if we are comparing against a constant value so we ca=
n adjust
> > -        * our min/max values for our dst register.
> > -        * this is only legit if both are scalars (or pointers to the s=
ame
> > -        * object, I suppose, see the PTR_MAYBE_NULL related if block b=
elow),
> > -        * because otherwise the different base pointers mean the offse=
ts aren't
> > -        * comparable.
> > -        */
>
> ... and removing this comment is good thing too.
> In general the comments should be in front of the function body
> (as you're doing) instead of the callsite.

yep, sounds good

