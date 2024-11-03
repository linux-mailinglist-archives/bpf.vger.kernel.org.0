Return-Path: <bpf+bounces-43836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543B9BA698
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A71F1C20E9E
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C854166F1B;
	Sun,  3 Nov 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+3VlOh3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC422FC52
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650603; cv=none; b=q5KkGW8SGGdiy+Bxv/JCIQYrHtNjIHP2/whgp0h3lh+oWjVylliEY08FXxqUXutP3Lqhjg4vJm3uhW7grkI+f2L0OWSFEhtOopRnXcpIXixxcGLPFEn146jEAQMea57OuppeDfDHoKW2tDr5NPPsl+NMlS65CalRVRO0jwFIBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650603; c=relaxed/simple;
	bh=Ua/Xf6jleO7Wpp4S2Z8xm4I+rvznmHLV+VUNePZT99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIlEIxrP4p8ttf6ZRUUh5elYzU/s3A3HT+9sJppdHdvfSSL2ERcB1LETes0Hu8Y1QY+xmO0WhYqUz9C3XKSsrsa5+1YhFEzP265xtGmQYiqxXMPgGnMlk/pSy7owoyBvlnaHdG/2JSwBDMi0c+sz6PN6rvz+Qwk+bZ0iKQ+zMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+3VlOh3; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so4054103a12.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730650600; x=1731255400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRKsGet8Qe8sQhKFX11241zBtb3vXISDnm3B06q91gk=;
        b=c+3VlOh38NzW2RIso7S/a/DYg1HFPNM3bK5DTl4GlGd3WlfTEveBL8zA1/4XggTwNT
         4KFrkLxfL4PUH147En/+hT5sgS5+kBWy5SUPU8KuOw4/i+uF/zb8ON0yK5d2dVtaHfJq
         X21leESgkFqLd/crER+utS3EmTye2SFXy0+egnZfPKgegmTG62mlQS4X3avjcMnAlP/G
         nObEPg2qb+q2VrEvMwX8GIjZNrGZJuidfKVwGwQjtoo2UiEja6M3U8RxW6SAdCd7LD7l
         aT1qNfivULYBsEGrgWKCgIFWinXoFQ4SCAcwMp7wscwc0WWyh/oFRokeFncSgjcN7A4S
         KD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730650600; x=1731255400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRKsGet8Qe8sQhKFX11241zBtb3vXISDnm3B06q91gk=;
        b=lJc0PZV8kCdaWOi5Jp/5OlAAex73VclamIJkR8Xgu3HwX+v1UEZZQrru6LejjhD295
         29gn4Mp5cE86FF4WeGGT4+o0h+dfWMEcHDw7FP9R3ygc4eHWr07HiMyhQ5h+g8D3sS8x
         OJq9nYHNRqE6Gap+jn2tx/C5hUSRtaCn5x6jVuV4eRP78+f7dRuWMnDsNJ8zVN6EBkNB
         /9OSbVBuyDCa8m5lm9NFU2KfCLklEKGx4p3a5FbY631OKY9T1IuqdMSDra7eVxckR5+q
         GiEUQsqzf3YnwxGx61w+qX7wBZ4xHgxY66U9APHDU7pjr7VN2XCz7cnQ/2WtP58ctLSt
         EnZw==
X-Forwarded-Encrypted: i=1; AJvYcCWBHAZ/gSXTCzlumfA9JDlebJzMYgJMzwCp4YXhKjq/AzTlqdhqMrMgF9pgubGmj96fTww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8JdqHCV4qPqbsm8QJ0TY94nMRykAIsHPYIRz3Ot+aFpMBxgS
	ozP1/zLX+5Qjd5Xht7+2GywSCteQuk1dFpdcZqnrKWRNJb8cca1ldTHn0oa9clFYQEGvM5UzB7i
	U76n765o6q8+N9qLNrCaF/4k3+iY=
X-Google-Smtp-Source: AGHT+IELkCc6JKlb4kXxm4Qmvokme++ERsy/NjbKeTnUr73hUyhfN+lwTM9/MMraZz6lcijxyDKPnfloTYGwpllQoiA=
X-Received: by 2002:a05:6402:1d4c:b0:5ce:bddc:e7ed with SMTP id
 4fb4d7f45d1cf-5cebddceab6mr5329190a12.11.1730650600129; Sun, 03 Nov 2024
 08:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-2-memxor@gmail.com>
 <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com> <CAADnVQL0DHb5Qev9X09w87URJabX44YpH5L-XE9+V-h9ge7KwA@mail.gmail.com>
In-Reply-To: <CAADnVQL0DHb5Qev9X09w87URJabX44YpH5L-XE9+V-h9ge7KwA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 10:16:03 -0600
Message-ID: <CAP01T77ApXof=LV6Dk=SvV7mN6Cc_1V=ntB-FB8BH2Y4VrV8QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Juri Lelli <juri.lelli@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Nov 2024 at 17:56, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 1, 2024 at 12:16=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct bpf_=
verifier_env *env,
> > >
> > >         if (ret < 0)
> > >                 return ret;
> > > -
> > > +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
> > > +        * trusted PTR_TO_BTF_ID, these are the ones that are possibl=
y
> > > +        * arguments to the raw_tp. Since internal checks in for trus=
ted
> > > +        * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NU=
LL
> > > +        * modifier as problematic, mask it out temporarily for the
> > > +        * check. Don't apply this to pointers with ref_obj_id > 0, a=
s
> > > +        * those won't be raw_tp args.
> > > +        *
> > > +        * We may end up applying this relaxation to other trusted
> > > +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> > > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
> > > +        * tagging, but that should expand allowed behavior, and not
> > > +        * cause regression for existing behavior.
> > > +        */
> >
> > Yeah, I'm not sure why this has to be raw tp-specific?.. What's wrong
> > with the same behavior for BPF iterator programs, for example?
> >
> > It seems nicer if we can avoid this temporary masking and instead
> > support this as a generic functionality? Or are there complications?
> >

We _can_ do this for all programs. The thought process here was to
leave existing raw_tp programs unbroken if possible if we're marking
their arguments as PTR_MAYBE_NULL, since most of them won't be
performing any NULL checks at all.

> > > +       mask =3D mask_raw_tp_reg(env, reg);
> > >         if (ret !=3D PTR_TO_BTF_ID) {
> > >                 /* just mark; */
> > >
> > > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct bpf_=
verifier_env *env,
> > >                 clear_trusted_flags(&flag);
> > >         }
> > >
> > > -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> > > +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> > >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf=
, btf_id, flag);
> > > +               /* We've assigned a new type to regno, so don't undo =
masking. */
> > > +               if (regno =3D=3D value_regno)
> > > +                       mask =3D false;
> > > +       }
> > > +       unmask_raw_tp_reg(reg, mask);
>
> Kumar,
>
> I chatted with Andrii offline. All other cases of mask/unmask
> should probably stay raw_tp specific, but it seems we can make
> this particular case to be generic.
> Something like the following:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 797cf3ed32e0..bbd4c03460e3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6703,7 +6703,11 @@ static int check_ptr_to_btf_access(struct
> bpf_verifier_env *env,
>                  */
>                 flag =3D PTR_UNTRUSTED;
>
> +       } else if (reg->type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED |
> PTR_MAYBE_NULL)) {
> +                       flag |=3D PTR_MAYBE_NULL;
> +                       goto trusted;
>         } else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
> +trusted:
>
> With the idea that trusted_or_null stays that way for all prog
> types and bpf_iter__task->task deref stays trusted_or_null
> instead of being downgraded to ptr_to_btf_id without any flags.
> So progs can do few less !=3D null checks.
> Need to think it through.

Ok. But don't allow passing such pointers into helpers, right?
We do that for raw_tp to preserve compat, but it would just exacerbate
the issue if we start doing it everywhere.
So it's just that dereferencing a _or_null pointer becomes an ok thing to d=
o?
Let me mull over this for a bit.

I'm not sure whether not doing the NULL check is better or worse
though. On one hand everything will work without checking for NULL, on
the other hand people may also assume the verifier isn't complaining
because the pointer is valid, and then they read data from the pointer
which always ends up being zero, meaning different things for
different kinds of fields.

Just thinking out loud, but one of the other concerns would be that
we're encouraging people not to do these NULL checks, which means a
potential page fault penalty everytime that pointer _is_ NULL, instead
of a simple branch, which would certainly be a bit expensive. If this
becomes the common case, I think the prog execution latency penalty
will be big. It is something to consider.

