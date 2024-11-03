Return-Path: <bpf+bounces-43838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F39BA6CB
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C4028211C
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAF176AAD;
	Sun,  3 Nov 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR7KgHgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E404D8A3
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653294; cv=none; b=PZgAKnwS5gIBIO011cI3UAWBU7Z9iaW0KyWRD3g5hMNMlLp27kwTYogI9Ohe2ppo4NbtE8n9PVrStPD4+ku2OgrHyN59I3CLcBO3IVhRN7y0SpvHXseLc3FOtikfELie/ZlXrTfCoIX2YKji1UIFX7hi28JPCKE3Tr5gTtn63p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653294; c=relaxed/simple;
	bh=BLK5e+UoBBl6sLEOYPUC2ZRpeasUTO1YL2+/pgZeH0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy3BLKXjrGVonznvpD2M/fSLtWKLSPz+qbC8eHiNp/LCvi+2BBqgF47htTfQOduJY+NmRjD8Y0QpcK+ij4qPEOS+0Y8FLPaNY+R+RMo6EcTbeJUJjEw+3zKNnbr07+xjtx410dW9w7u7TegJLJbDnePA5UBgPJtRtWrvYvag2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR7KgHgA; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso438088966b.3
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730653290; x=1731258090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0Hz0Y3wo2aD4SiodIqJEtgXRyv0o2/oJCukwH/Yd1w=;
        b=OR7KgHgAPqqHgp9ObfBGMYDm0ce8NG04UyNuOQn99EhgBm7xt+nY9U7G1GdftSQdTH
         DmHAAYhRDwAxEU18v/O3tf48ieM8GfbHlr32eLFrWX86gvIbwyLvlV92cWxfn0DDbrpp
         xJX8CiHYa1lvABjjn76v2CugQtCDyeAPa1ENX7hooYaAgNsU3xYZfnwEP/5KbZVWdiGq
         0GJCOxW8QVe78vYIAEdzFeim8t73PW4Txx0TaEeGy95d5UYoELECH9kpJ3od8bjW6hz0
         hKE6VVuqums1ArUJ4naevB7/gihkmDAPOLiCjJ21Udm7EtkXQ8yPKiH2ckUX94L2XB1s
         Mo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730653290; x=1731258090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Hz0Y3wo2aD4SiodIqJEtgXRyv0o2/oJCukwH/Yd1w=;
        b=tnYtAHYvwEHk6l6u/UQrjzb0BdseqEBZ8HJ8VSWMZCa0gw0bcb+0Laz3kXOvFK16tQ
         ZeixjRfCYdhyvme93BPebN01qnxGqstlygkmQSzeeF+484rCOKXcLrQeg8ZIavmNIsYV
         DFt4bKMWUgQtqUODTeIc2c4R5EplhS2X3hhxixxfdaVcVQ0Y8GIo3Bd+ALeInK2bs1bA
         p/AkEMy0wMuQjCZnlqTbUOq6Zksu2YNepETiGXZrfmZHnxahELjUmJqStHz5QEyInSZn
         EmJtFMSBrwTq5BbQGPZSzfUkgTZhC4PxsHJex8xz0um0jF4BbOfdv4HY08FInCOgeM3W
         9D4g==
X-Forwarded-Encrypted: i=1; AJvYcCVq586geO97z6ddMwpJk+1j74P8okXWGQwxnAlZFDcLyaY4Ae74rNqRQEZG+97b2nN4YXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQCsV1pVhSfjJzNgTnWf7lMmTcr5hZl3gPo+inn/migVXGu/w
	ynGiB9qjcgO6GVaTGW/AiuwHXlYsj+JwlPbzwhOraVXhMC4M0dkju/0AB9c2CO0EZW1nURObdOi
	i1321+ruSRtQnY1Yuho1oD4clHaM=
X-Google-Smtp-Source: AGHT+IGqTogeMAjVsmqhH0w3mHdWzZ26KL8m4F+16Zhqe74fWX+xWLDFs5ni8QECot0qaP7nyncc5NRz3H928OIzp+Y=
X-Received: by 2002:a17:907:7e8f:b0:a99:da6c:f607 with SMTP id
 a640c23a62f3a-a9e50b57169mr1175380866b.44.1730653290121; Sun, 03 Nov 2024
 09:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-2-memxor@gmail.com>
 <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com>
 <CAADnVQL0DHb5Qev9X09w87URJabX44YpH5L-XE9+V-h9ge7KwA@mail.gmail.com>
 <CAP01T77ApXof=LV6Dk=SvV7mN6Cc_1V=ntB-FB8BH2Y4VrV8QQ@mail.gmail.com> <CAP01T74S=4xbPRj=RskbysaRbE1cuOEA0sng4oaCET69GhirEg@mail.gmail.com>
In-Reply-To: <CAP01T74S=4xbPRj=RskbysaRbE1cuOEA0sng4oaCET69GhirEg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 11:00:53 -0600
Message-ID: <CAP01T77xwpAhGd03Wfk4tpoaTsoDyyN5bQ6btGUi0_xPgDY4yQ@mail.gmail.com>
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

On Sun, 3 Nov 2024 at 10:40, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Sun, 3 Nov 2024 at 10:16, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
> >
> > On Fri, 1 Nov 2024 at 17:56, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Nov 1, 2024 at 12:16=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct =
bpf_verifier_env *env,
> > > > >
> > > > >         if (ret < 0)
> > > > >                 return ret;
> > > > > -
> > > > > +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_NU=
LL
> > > > > +        * trusted PTR_TO_BTF_ID, these are the ones that are pos=
sibly
> > > > > +        * arguments to the raw_tp. Since internal checks in for =
trusted
> > > > > +        * reg in check_ptr_to_btf_access would consider PTR_MAYB=
E_NULL
> > > > > +        * modifier as problematic, mask it out temporarily for t=
he
> > > > > +        * check. Don't apply this to pointers with ref_obj_id > =
0, as
> > > > > +        * those won't be raw_tp args.
> > > > > +        *
> > > > > +        * We may end up applying this relaxation to other truste=
d
> > > > > +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> > > > > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs nor=
mal
> > > > > +        * tagging, but that should expand allowed behavior, and =
not
> > > > > +        * cause regression for existing behavior.
> > > > > +        */
> > > >
> > > > Yeah, I'm not sure why this has to be raw tp-specific?.. What's wro=
ng
> > > > with the same behavior for BPF iterator programs, for example?
> > > >
> > > > It seems nicer if we can avoid this temporary masking and instead
> > > > support this as a generic functionality? Or are there complications=
?
> > > >
> >
> > We _can_ do this for all programs. The thought process here was to
> > leave existing raw_tp programs unbroken if possible if we're marking
> > their arguments as PTR_MAYBE_NULL, since most of them won't be
> > performing any NULL checks at all.
> >
> > > > > +       mask =3D mask_raw_tp_reg(env, reg);
> > > > >         if (ret !=3D PTR_TO_BTF_ID) {
> > > > >                 /* just mark; */
> > > > >
> > > > > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct =
bpf_verifier_env *env,
> > > > >                 clear_trusted_flags(&flag);
> > > > >         }
> > > > >
> > > > > -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> > > > > +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> > > > >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg-=
>btf, btf_id, flag);
> > > > > +               /* We've assigned a new type to regno, so don't u=
ndo masking. */
> > > > > +               if (regno =3D=3D value_regno)
> > > > > +                       mask =3D false;
> > > > > +       }
> > > > > +       unmask_raw_tp_reg(reg, mask);
> > >
> > > Kumar,
> > >
> > > I chatted with Andrii offline. All other cases of mask/unmask
> > > should probably stay raw_tp specific, but it seems we can make
> > > this particular case to be generic.
> > > Something like the following:
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 797cf3ed32e0..bbd4c03460e3 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6703,7 +6703,11 @@ static int check_ptr_to_btf_access(struct
> > > bpf_verifier_env *env,
> > >                  */
> > >                 flag =3D PTR_UNTRUSTED;
> > >
> > > +       } else if (reg->type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED |
> > > PTR_MAYBE_NULL)) {
> > > +                       flag |=3D PTR_MAYBE_NULL;
> > > +                       goto trusted;
> > >         } else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
> > > +trusted:
> > >
> > > With the idea that trusted_or_null stays that way for all prog
> > > types and bpf_iter__task->task deref stays trusted_or_null
> > > instead of being downgraded to ptr_to_btf_id without any flags.
> > > So progs can do few less !=3D null checks.
> > > Need to think it through.
> >
> > Ok. But don't allow passing such pointers into helpers, right?
> > We do that for raw_tp to preserve compat, but it would just exacerbate
> > the issue if we start doing it everywhere.
> > So it's just that dereferencing a _or_null pointer becomes an ok thing =
to do?
> > Let me mull over this for a bit.
> >
> > I'm not sure whether not doing the NULL check is better or worse
> > though. On one hand everything will work without checking for NULL, on
> > the other hand people may also assume the verifier isn't complaining
> > because the pointer is valid, and then they read data from the pointer
> > which always ends up being zero, meaning different things for
> > different kinds of fields.
> >
> > Just thinking out loud, but one of the other concerns would be that
> > we're encouraging people not to do these NULL checks, which means a
> > potential page fault penalty everytime that pointer _is_ NULL, instead
> > of a simple branch, which would certainly be a bit expensive. If this
> > becomes the common case, I think the prog execution latency penalty
> > will be big. It is something to consider.
>
> Ah, no, my bad, this won't be a problem now, as the JIT does emit a
> branch to check for kernel addresses, but it probably will be if
> https://lore.kernel.org/bpf/20240619092216.1780946-1-memxor@gmail.com/
> gets accepted.

I applied this and tried to find out the time it takes to dereference
a NULL pointer using bpf_ktime_get_ns
With the patch above: time=3D3345 ns
Without (bpf-next right now): time=3D170 ns

So I guess that means I should probably drop the patch above if we
decide to allow dereferencing NULL for all programs.

