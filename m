Return-Path: <bpf+bounces-43839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91949BA744
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18345B2162E
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7C188708;
	Sun,  3 Nov 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5GOHPq7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A913049E
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730655458; cv=none; b=RSbx3XeTtTTsMOJgdqiTfkmNzfoapJduOley1LeGrVeGkIehYEQcvA/4ckkJip11lSwLgwAIMAz/g0+x/aCBwmwvazbBwOedFWDGAbAifStwrJ5GmaqwPRC/5+3RlBKmvNXIlMiAE9LR2/pPdF+9XpVbSsIxLga5mGRUeYis1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730655458; c=relaxed/simple;
	bh=MbbOEK1QrWD1lTHQnp3W+7fm6TwQzor2XKDzB6PXiCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaNMFOVPdb1ZSKFvbns3ukeShFRDEQttlPmGfMxgOKcs1ldZ7zDpN/dqm56ed4LmbV/TMPHQfmp67UPsW3QaV3TJXAvMytGg/6GOttW+Osdjs2gHSEUMf4gcl79EzX/3pVYh30RVQiuJ4h4Piqc6/EdWSBrkwYv6ajgWa5c9Uws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5GOHPq7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so30387155e9.3
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730655455; x=1731260255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD7Z29ikWR5Yqtl+LmRWmU7eC9/tWXVZgBY86ODxqRE=;
        b=h5GOHPq79wJhYj/oDp6T4v6SUclwFLdQPZ0nfguziF6kPGHP8XOPRZng3DUHdrDy0h
         E/EEFiiuIab+XnXo+ZmcKwEeyVrYICCVNE5RtT7/fwQCBYsirZYFl0nNMdQsKVm0C1J4
         ofk+aLBOFsI7yuaGS22bkWxga8lCg3v/70nnN3Vc0LUBZzpmu5Z3CgLztKy3D5cPNc39
         FXCcyKEprXn6tS3QDOVmymIPqRKPOBleH6gzdjr0nPHe/+dHwcEQEwJZ2Mzw3W6zxLAP
         JGgivPPcth0mbG5evsof5g04FW3eGEmYIU2WkfK5KasuBEDCxt4WZ6gQ7tzv8NQ/nSvA
         A4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730655455; x=1731260255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD7Z29ikWR5Yqtl+LmRWmU7eC9/tWXVZgBY86ODxqRE=;
        b=FnMCsQrQk81xBwsDkJ+v/4Ya06obd2xZIOFyJhTetRfW2AqrroLdQhbyBefZ5zMFxu
         mxYOozch0qCUorp9hOWYeZBeMjVEdcRnA4U0wE8SoHaLi9+sbgwIYESEzDJko2alq70X
         mPcA1JKRwkZKiI9xSZRTqDQHeVrOmGUwpDaNkZs+tcY7/xgJ4RB9ig5AIZyCTCzYnKq3
         8xJQzPEPBy60oOj6X+X/BE6rTHlRKRoav5yIIFYaAu0Bu5NrjOtuS3YtuP0LzRCQ6az8
         RCJgXtSkOC46gEjuh26VuemKLkHmcNt2IhTuNczgPV+BFWihfc2VZ5L6+GztbplU+E15
         IIsg==
X-Forwarded-Encrypted: i=1; AJvYcCWRuEp4Wg58rGidD+vsp4QQWVs4hj2/YeBF0fKwqNwt9teWqHzNrWC5zvZvwV/5+//yMaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gG3F1Eh7Lr3wEzcW+7tZ2GHu4+zx0taK8+zm+aXeyYTzVN51
	SZ8Nt5yvwMdpczmZhg9Seli8PHL9uqBQDdENHdDig5UnQW4xK2KALTZW1azNb95U0zZAnqgzlYm
	qRmw3h2ALtEZDLEsiLlpV0bgn3g0=
X-Google-Smtp-Source: AGHT+IGdLcWhMKyx3ADavyfOJSBj45JqmXH0+W1Lo/YsEuoD5JuLREEd+/pKJ58vhkIYT1RPaeysilIh872siVT9fMU=
X-Received: by 2002:a05:600c:458e:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-4328250f211mr104305765e9.12.1730655454319; Sun, 03 Nov 2024
 09:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-2-memxor@gmail.com>
 <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com>
 <CAADnVQL0DHb5Qev9X09w87URJabX44YpH5L-XE9+V-h9ge7KwA@mail.gmail.com>
 <CAP01T77ApXof=LV6Dk=SvV7mN6Cc_1V=ntB-FB8BH2Y4VrV8QQ@mail.gmail.com>
 <CAP01T74S=4xbPRj=RskbysaRbE1cuOEA0sng4oaCET69GhirEg@mail.gmail.com> <CAP01T77xwpAhGd03Wfk4tpoaTsoDyyN5bQ6btGUi0_xPgDY4yQ@mail.gmail.com>
In-Reply-To: <CAP01T77xwpAhGd03Wfk4tpoaTsoDyyN5bQ6btGUi0_xPgDY4yQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 Nov 2024 09:37:23 -0800
Message-ID: <CAADnVQKgTMZgLmtveku+D3PgNMM=cgcXb4z+hGnN-DL=Mws_6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Juri Lelli <juri.lelli@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 9:01=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Sun, 3 Nov 2024 at 10:40, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
> >
> > On Sun, 3 Nov 2024 at 10:16, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
> > >
> > > On Fri, 1 Nov 2024 at 17:56, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 1, 2024 at 12:16=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struc=
t bpf_verifier_env *env,
> > > > > >
> > > > > >         if (ret < 0)
> > > > > >                 return ret;
> > > > > > -
> > > > > > +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_=
NULL
> > > > > > +        * trusted PTR_TO_BTF_ID, these are the ones that are p=
ossibly
> > > > > > +        * arguments to the raw_tp. Since internal checks in fo=
r trusted
> > > > > > +        * reg in check_ptr_to_btf_access would consider PTR_MA=
YBE_NULL
> > > > > > +        * modifier as problematic, mask it out temporarily for=
 the
> > > > > > +        * check. Don't apply this to pointers with ref_obj_id =
> 0, as
> > > > > > +        * those won't be raw_tp args.
> > > > > > +        *
> > > > > > +        * We may end up applying this relaxation to other trus=
ted
> > > > > > +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> > > > > > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs n=
ormal
> > > > > > +        * tagging, but that should expand allowed behavior, an=
d not
> > > > > > +        * cause regression for existing behavior.
> > > > > > +        */
> > > > >
> > > > > Yeah, I'm not sure why this has to be raw tp-specific?.. What's w=
rong
> > > > > with the same behavior for BPF iterator programs, for example?
> > > > >
> > > > > It seems nicer if we can avoid this temporary masking and instead
> > > > > support this as a generic functionality? Or are there complicatio=
ns?
> > > > >
> > >
> > > We _can_ do this for all programs. The thought process here was to
> > > leave existing raw_tp programs unbroken if possible if we're marking
> > > their arguments as PTR_MAYBE_NULL, since most of them won't be
> > > performing any NULL checks at all.
> > >
> > > > > > +       mask =3D mask_raw_tp_reg(env, reg);
> > > > > >         if (ret !=3D PTR_TO_BTF_ID) {
> > > > > >                 /* just mark; */
> > > > > >
> > > > > > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struc=
t bpf_verifier_env *env,
> > > > > >                 clear_trusted_flags(&flag);
> > > > > >         }
> > > > > >
> > > > > > -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> > > > > > +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> > > > > >                 mark_btf_ld_reg(env, regs, value_regno, ret, re=
g->btf, btf_id, flag);
> > > > > > +               /* We've assigned a new type to regno, so don't=
 undo masking. */
> > > > > > +               if (regno =3D=3D value_regno)
> > > > > > +                       mask =3D false;
> > > > > > +       }
> > > > > > +       unmask_raw_tp_reg(reg, mask);
> > > >
> > > > Kumar,
> > > >
> > > > I chatted with Andrii offline. All other cases of mask/unmask
> > > > should probably stay raw_tp specific, but it seems we can make
> > > > this particular case to be generic.
> > > > Something like the following:
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 797cf3ed32e0..bbd4c03460e3 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -6703,7 +6703,11 @@ static int check_ptr_to_btf_access(struct
> > > > bpf_verifier_env *env,
> > > >                  */
> > > >                 flag =3D PTR_UNTRUSTED;
> > > >
> > > > +       } else if (reg->type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED |
> > > > PTR_MAYBE_NULL)) {
> > > > +                       flag |=3D PTR_MAYBE_NULL;
> > > > +                       goto trusted;
> > > >         } else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
> > > > +trusted:
> > > >
> > > > With the idea that trusted_or_null stays that way for all prog
> > > > types and bpf_iter__task->task deref stays trusted_or_null
> > > > instead of being downgraded to ptr_to_btf_id without any flags.
> > > > So progs can do few less !=3D null checks.
> > > > Need to think it through.
> > >
> > > Ok. But don't allow passing such pointers into helpers, right?
> > > We do that for raw_tp to preserve compat, but it would just exacerbat=
e
> > > the issue if we start doing it everywhere.
> > > So it's just that dereferencing a _or_null pointer becomes an ok thin=
g to do?
> > > Let me mull over this for a bit.
> > >
> > > I'm not sure whether not doing the NULL check is better or worse
> > > though. On one hand everything will work without checking for NULL, o=
n
> > > the other hand people may also assume the verifier isn't complaining
> > > because the pointer is valid, and then they read data from the pointe=
r
> > > which always ends up being zero, meaning different things for
> > > different kinds of fields.
> > >
> > > Just thinking out loud, but one of the other concerns would be that
> > > we're encouraging people not to do these NULL checks, which means a
> > > potential page fault penalty everytime that pointer _is_ NULL, instea=
d
> > > of a simple branch, which would certainly be a bit expensive. If this
> > > becomes the common case, I think the prog execution latency penalty
> > > will be big. It is something to consider.
> >
> > Ah, no, my bad, this won't be a problem now, as the JIT does emit a
> > branch to check for kernel addresses, but it probably will be if
> > https://lore.kernel.org/bpf/20240619092216.1780946-1-memxor@gmail.com/
> > gets accepted.
>
> I applied this and tried to find out the time it takes to dereference
> a NULL pointer using bpf_ktime_get_ns
> With the patch above: time=3D3345 ns
> Without (bpf-next right now): time=3D170 ns
>
> So I guess that means I should probably drop the patch above if we
> decide to allow dereferencing NULL for all programs.

Your concerns are valid.
Accepting deref of trusted_or_null generically will cause these issues
long term. It's indeed better to make programmers add explicit !=3DNULL
to their programs.
So scratch my earlier suggestion. Let's keep this patch as-is with special
hack for raw_tp only that we will hopefully resolve later
either with __nullable suffix or compiler detection of nullability.
The latter we discussed briefly with Eduard.
It's doable to teach llvm to emit btf_tag to aid the verifier.
gcc may catch up eventually.

