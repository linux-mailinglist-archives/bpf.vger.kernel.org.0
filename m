Return-Path: <bpf+bounces-43837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16E9BA6AF
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867BD1F22133
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043E187872;
	Sun,  3 Nov 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgJ/6B5/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580AAD2D
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730652057; cv=none; b=q4B8Y2Oia9WJVsQWY6TmpFhIBj+BAPx9VieZ4gc7Zp9dlK+RBFq4FfRsSh9A68XaT0yrWliSonLjBQ5wfHsyVfX8BjH3PLOuJSIAp7iWuNRdv0hCESCTzcUDeTQ7Pgk8sMYXlG1GkVEYsVgZhtHJ23ue7RGnvGL9IUJ17WvrRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730652057; c=relaxed/simple;
	bh=o+j1uzwAx7hgx9PixphrlG65czPjILkZu3f6Kuh9gq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJkFJTDEH1SMr9WYRWenqu0NWGHMh0d2i+dt0+wvqC/GEbfY55Vh5YVPnjur57CEvj6CXCHWt1lDCd8MVj8+ZyeUoxwiSPhnYADnhdKo9+MKWSH68o7FoH4uiXo6ZI8TISU/AxbmmT6oSjawEqzS/TI0ngZVXfddR/hhXVsZn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgJ/6B5/; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a9aa8895facso611037666b.2
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730652054; x=1731256854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h+YIQoAR0ru2mKaBK9egSvEF/SD97HBI2PaLLzYSEY=;
        b=SgJ/6B5/xKMeDyUOtY3M+aatuPInVV7+jwbE9xjn9PTcTbXLoL90JQ27jV7+ubixmW
         XRDHDOyn9LcZglQZq5XHlgP7XjxU//rZsUDz8ATvIZQ1IpRRsw/xmguR4kdCA2j1GP4v
         owhWyVF5UtDHYmjLIAfZIThPpnz7IbbdobK4aEoGgn9B8QpVtG2Sdm5jnM+Q3mdhT8s1
         bKKbctOu/Ck3p9RtbO9dKtSC5o15Y8IptBrdgYWLhxLPC+LU3gO+9ZnENJt7Pf5t2cVb
         +EJQBy+65F7TCnAw6YNkqyiF4n/nH3G30kilbecCvbEOwmw2iIxRyHf057ao4DEqJnr+
         cp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730652054; x=1731256854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h+YIQoAR0ru2mKaBK9egSvEF/SD97HBI2PaLLzYSEY=;
        b=nzcb52Zdhbr8h7FKhhQNf7Uz3vN73dZZZiVWuUKGRsOuV4gHafI5efBGB1jdtEgkVp
         yo4EQ+Q5uf4idbx7TvK5MtXS1Wi3No/9MR3f1P+rr8P4rg4k1XydLc0NioFBE6z46Xog
         uZRMP4Ferpk/OftXt0fZPBknRvn+9iWCV1+YL+5EXMD/ucwRy3Ks7Ub0l7g96ljQkKvV
         6WLDrzGfAJ0axi0dr84ZxT/4y02Hvm99yrUw9P+z9Fzk6GmRGoGtOu43fIvjzbyIDpqW
         KZh8zCR4+sRjqn+RcOcHaOT0pZYYcBMOvtsXSrUhzM93OBWcpRrSJoi4L9DCDL8XyAbu
         dsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI17m2IUiYAmZyKp2zmyoQb2sYQcHTd8QDiThksII30Y+f/t7CNKKxy0bgrXhz1hcD4h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4OZOwiujThNQ5Yim0j9tFLiR+bZO7XFP7R+z4J2iGZ2F/N3T1
	mhVMbx523EWvnhpQG1eGqRsq5Tj0FUAbF8M+Ezfehy6FmIJOnSJndBmMwsomhIX1ivSHWU8oi/S
	n7ybT79QqnvYpgYTKLME4SbLZR9tZer7Dqhk=
X-Google-Smtp-Source: AGHT+IGjFeZXEgkpotg2q3bPMAz0CxuPYO4LRSfwrjdx4lx75yhtQeZajvhY9+gOeye6IOBMBbPA0dRaKAwRJ78l18g=
X-Received: by 2002:a17:907:7e8b:b0:a8d:2faf:d33d with SMTP id
 a640c23a62f3a-a9de5d6f1ecmr2998209666b.9.1730652053481; Sun, 03 Nov 2024
 08:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-2-memxor@gmail.com>
 <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com>
 <CAADnVQL0DHb5Qev9X09w87URJabX44YpH5L-XE9+V-h9ge7KwA@mail.gmail.com> <CAP01T77ApXof=LV6Dk=SvV7mN6Cc_1V=ntB-FB8BH2Y4VrV8QQ@mail.gmail.com>
In-Reply-To: <CAP01T77ApXof=LV6Dk=SvV7mN6Cc_1V=ntB-FB8BH2Y4VrV8QQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 10:40:17 -0600
Message-ID: <CAP01T74S=4xbPRj=RskbysaRbE1cuOEA0sng4oaCET69GhirEg@mail.gmail.com>
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

On Sun, 3 Nov 2024 at 10:16, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Fri, 1 Nov 2024 at 17:56, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 1, 2024 at 12:16=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct bp=
f_verifier_env *env,
> > > >
> > > >         if (ret < 0)
> > > >                 return ret;
> > > > -
> > > > +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
> > > > +        * trusted PTR_TO_BTF_ID, these are the ones that are possi=
bly
> > > > +        * arguments to the raw_tp. Since internal checks in for tr=
usted
> > > > +        * reg in check_ptr_to_btf_access would consider PTR_MAYBE_=
NULL
> > > > +        * modifier as problematic, mask it out temporarily for the
> > > > +        * check. Don't apply this to pointers with ref_obj_id > 0,=
 as
> > > > +        * those won't be raw_tp args.
> > > > +        *
> > > > +        * We may end up applying this relaxation to other trusted
> > > > +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> > > > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs norma=
l
> > > > +        * tagging, but that should expand allowed behavior, and no=
t
> > > > +        * cause regression for existing behavior.
> > > > +        */
> > >
> > > Yeah, I'm not sure why this has to be raw tp-specific?.. What's wrong
> > > with the same behavior for BPF iterator programs, for example?
> > >
> > > It seems nicer if we can avoid this temporary masking and instead
> > > support this as a generic functionality? Or are there complications?
> > >
>
> We _can_ do this for all programs. The thought process here was to
> leave existing raw_tp programs unbroken if possible if we're marking
> their arguments as PTR_MAYBE_NULL, since most of them won't be
> performing any NULL checks at all.
>
> > > > +       mask =3D mask_raw_tp_reg(env, reg);
> > > >         if (ret !=3D PTR_TO_BTF_ID) {
> > > >                 /* just mark; */
> > > >
> > > > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct bp=
f_verifier_env *env,
> > > >                 clear_trusted_flags(&flag);
> > > >         }
> > > >
> > > > -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> > > > +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> > > >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->b=
tf, btf_id, flag);
> > > > +               /* We've assigned a new type to regno, so don't und=
o masking. */
> > > > +               if (regno =3D=3D value_regno)
> > > > +                       mask =3D false;
> > > > +       }
> > > > +       unmask_raw_tp_reg(reg, mask);
> >
> > Kumar,
> >
> > I chatted with Andrii offline. All other cases of mask/unmask
> > should probably stay raw_tp specific, but it seems we can make
> > this particular case to be generic.
> > Something like the following:
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 797cf3ed32e0..bbd4c03460e3 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6703,7 +6703,11 @@ static int check_ptr_to_btf_access(struct
> > bpf_verifier_env *env,
> >                  */
> >                 flag =3D PTR_UNTRUSTED;
> >
> > +       } else if (reg->type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED |
> > PTR_MAYBE_NULL)) {
> > +                       flag |=3D PTR_MAYBE_NULL;
> > +                       goto trusted;
> >         } else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
> > +trusted:
> >
> > With the idea that trusted_or_null stays that way for all prog
> > types and bpf_iter__task->task deref stays trusted_or_null
> > instead of being downgraded to ptr_to_btf_id without any flags.
> > So progs can do few less !=3D null checks.
> > Need to think it through.
>
> Ok. But don't allow passing such pointers into helpers, right?
> We do that for raw_tp to preserve compat, but it would just exacerbate
> the issue if we start doing it everywhere.
> So it's just that dereferencing a _or_null pointer becomes an ok thing to=
 do?
> Let me mull over this for a bit.
>
> I'm not sure whether not doing the NULL check is better or worse
> though. On one hand everything will work without checking for NULL, on
> the other hand people may also assume the verifier isn't complaining
> because the pointer is valid, and then they read data from the pointer
> which always ends up being zero, meaning different things for
> different kinds of fields.
>
> Just thinking out loud, but one of the other concerns would be that
> we're encouraging people not to do these NULL checks, which means a
> potential page fault penalty everytime that pointer _is_ NULL, instead
> of a simple branch, which would certainly be a bit expensive. If this
> becomes the common case, I think the prog execution latency penalty
> will be big. It is something to consider.

Ah, no, my bad, this won't be a problem now, as the JIT does emit a
branch to check for kernel addresses, but it probably will be if
https://lore.kernel.org/bpf/20240619092216.1780946-1-memxor@gmail.com/
gets accepted.

