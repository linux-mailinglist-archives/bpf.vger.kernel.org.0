Return-Path: <bpf+bounces-44152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A69BF7D9
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7497728353A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD761DFE27;
	Wed,  6 Nov 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnpWIUr6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F21DAC9D
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924238; cv=none; b=koeJUyEFSRpHqIY8B6q8w230GfJkQqdvjg2lX5yYv43iAL0No9RotdoIp340DDEDYhf07U4cWax8QqQdNQsfgPMGvSZxlm+E2Nf5wxCS6LSFe51Ip4dQTKKP363CDIA+J2KaDXPsDKncaaO8GrLDUMarVJcTamvMVr5MptOVbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924238; c=relaxed/simple;
	bh=B7Me626O7yoQZkU9ldDuGFtdFaYXvWxO1Y7f3F7rpWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E32Oe7NHctbOOF9U6Fp5HlwNjXlXyj7EUmdo0iTn0Bfg726BTWb1qdlGfy9IugfHuP2PbXBBFYT2ACcGV2WOS+CKSoHFmxicphdIoGjBwTW2t2JRQt0PW65I6iEELC+lgmNA8tnM1bErvIm+G5Pgp1pNRyeHdF7Izxe6HAogjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnpWIUr6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso209815a12.3
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 12:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730924236; x=1731529036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETQjYbuAXOzbs/uS2B03Rybn/3rAxQKxuWnraHijRoY=;
        b=QnpWIUr6vrFsrvpjjflk6QUgDmULxga5BWQfFfMbHUPvLqC0+H0RAeekk4ieTg3QwQ
         YLbCtBgjBMH+TDX1o0bV6DvikB74pTEeWgrDJkcbqXwPDGvw5ir1MSSZOi1pg2EX0nKB
         6kW2+FPXKQZKXxFf5IvVBJNPszWBf8eVYt+QhlbgtZ9PlGk6aggeaOh3+UPxRtSgSWke
         lI1Ll2LPeA2Z+PEe4uSMK6oQT26y+MwAxlfeNTvBLqevraAkE05DewYvOkppjyOnsQX5
         u+afkcz1aqjULU/GE/t5Dy+hbfsPo7VaqCoEf73EsvL8ivV3tgx91ZqWhMY+s0K+7vlu
         kLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924236; x=1731529036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETQjYbuAXOzbs/uS2B03Rybn/3rAxQKxuWnraHijRoY=;
        b=EtnXHfv9MhSQr2ZPVLuPbKCmIu+IeVFzCdgElh40S31EuvjzH5DvJsFYNBv4IbXnam
         gHdtYgB69y9oqN2wSmEw6qmqDRBrr8W7Dy20VMzT+UEkUw54kA2qVcBL3OaGQjXu6G/3
         Ek/kiRqzirXBk7asdlh5K5E/xCHidxVj4pwTO6ir41XsLc6UbANkZOLB5wKkXm4a0uQq
         Nuxg3KRtiapzLRkhb0JW/nHBDN3ZemDSRuw3SKZ8rzXKPnLiNyPiAdwgaf06Za4eD8NG
         uPREcL3KIkPd7wnR4gnRYMcRoD5YVXtnDaUNchhuw2r3C5dGhJKD8bWV1ASo8hIMHbxo
         sLEg==
X-Forwarded-Encrypted: i=1; AJvYcCVFQH3iOut66bxMUSzSAIR42t0qRO9BDLHg3gZjwSnRQHfzdNqHIcm43bwN8Um5kAQx2d8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZwP06NDbTIVnrOw0Swh6S3MEy2WbBYlWSXnyxGuwEC8c0yxE
	99eF0kcy2Yd7JgGg0kVI1D+WCGhyUtqWHvxzkMKJcPVBGLp84cfZYVM7TLkrqv6xKQ8j9Et4fbo
	Ehj0n38+HTwvLtdmPZAoYwc+Ngjw=
X-Google-Smtp-Source: AGHT+IHL64Q1RY73jYczK92CsyUUYI8st++yREoibZWp7BFXqgn8i2R81/Knbz/AJ8VVMfTXpSq7b8GVdK2Os5aCvrg=
X-Received: by 2002:a17:90a:c090:b0:2e2:e743:74f7 with SMTP id
 98e67ed59e1d1-2e8f104a53cmr44788933a91.2.1730924236114; Wed, 06 Nov 2024
 12:17:16 -0800 (PST)
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
 <CAP01T74S=4xbPRj=RskbysaRbE1cuOEA0sng4oaCET69GhirEg@mail.gmail.com>
 <CAP01T77xwpAhGd03Wfk4tpoaTsoDyyN5bQ6btGUi0_xPgDY4yQ@mail.gmail.com> <CAADnVQKgTMZgLmtveku+D3PgNMM=cgcXb4z+hGnN-DL=Mws_6Q@mail.gmail.com>
In-Reply-To: <CAADnVQKgTMZgLmtveku+D3PgNMM=cgcXb4z+hGnN-DL=Mws_6Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 12:17:04 -0800
Message-ID: <CAEf4BzbZM40JZGVGN1AGfTyNDYMfsZYd6cKC3nTdYELJajca8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Juri Lelli <juri.lelli@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 9:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 3, 2024 at 9:01=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Sun, 3 Nov 2024 at 10:40, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
> > >
> > > On Sun, 3 Nov 2024 at 10:16, Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> > > >
> > > > On Fri, 1 Nov 2024 at 17:56, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 1, 2024 at 12:16=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(str=
uct bpf_verifier_env *env,
> > > > > > >
> > > > > > >         if (ret < 0)
> > > > > > >                 return ret;
> > > > > > > -
> > > > > > > +       /* For raw_tp progs, we allow dereference of PTR_MAYB=
E_NULL
> > > > > > > +        * trusted PTR_TO_BTF_ID, these are the ones that are=
 possibly
> > > > > > > +        * arguments to the raw_tp. Since internal checks in =
for trusted
> > > > > > > +        * reg in check_ptr_to_btf_access would consider PTR_=
MAYBE_NULL
> > > > > > > +        * modifier as problematic, mask it out temporarily f=
or the
> > > > > > > +        * check. Don't apply this to pointers with ref_obj_i=
d > 0, as
> > > > > > > +        * those won't be raw_tp args.
> > > > > > > +        *
> > > > > > > +        * We may end up applying this relaxation to other tr=
usted
> > > > > > > +        * PTR_TO_BTF_ID with maybe null flag, since we canno=
t
> > > > > > > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs=
 normal
> > > > > > > +        * tagging, but that should expand allowed behavior, =
and not
> > > > > > > +        * cause regression for existing behavior.
> > > > > > > +        */
> > > > > >
> > > > > > Yeah, I'm not sure why this has to be raw tp-specific?.. What's=
 wrong
> > > > > > with the same behavior for BPF iterator programs, for example?
> > > > > >
> > > > > > It seems nicer if we can avoid this temporary masking and inste=
ad
> > > > > > support this as a generic functionality? Or are there complicat=
ions?
> > > > > >
> > > >
> > > > We _can_ do this for all programs. The thought process here was to
> > > > leave existing raw_tp programs unbroken if possible if we're markin=
g
> > > > their arguments as PTR_MAYBE_NULL, since most of them won't be
> > > > performing any NULL checks at all.
> > > >
> > > > > > > +       mask =3D mask_raw_tp_reg(env, reg);
> > > > > > >         if (ret !=3D PTR_TO_BTF_ID) {
> > > > > > >                 /* just mark; */
> > > > > > >
> > > > > > > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(str=
uct bpf_verifier_env *env,
> > > > > > >                 clear_trusted_flags(&flag);
> > > > > > >         }
> > > > > > >
> > > > > > > -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> > > > > > > +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> > > > > > >                 mark_btf_ld_reg(env, regs, value_regno, ret, =
reg->btf, btf_id, flag);
> > > > > > > +               /* We've assigned a new type to regno, so don=
't undo masking. */
> > > > > > > +               if (regno =3D=3D value_regno)
> > > > > > > +                       mask =3D false;
> > > > > > > +       }
> > > > > > > +       unmask_raw_tp_reg(reg, mask);
> > > > >
> > > > > Kumar,
> > > > >
> > > > > I chatted with Andrii offline. All other cases of mask/unmask
> > > > > should probably stay raw_tp specific, but it seems we can make
> > > > > this particular case to be generic.
> > > > > Something like the following:
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 797cf3ed32e0..bbd4c03460e3 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -6703,7 +6703,11 @@ static int check_ptr_to_btf_access(struct
> > > > > bpf_verifier_env *env,
> > > > >                  */
> > > > >                 flag =3D PTR_UNTRUSTED;
> > > > >
> > > > > +       } else if (reg->type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED =
|
> > > > > PTR_MAYBE_NULL)) {
> > > > > +                       flag |=3D PTR_MAYBE_NULL;
> > > > > +                       goto trusted;
> > > > >         } else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
> > > > > +trusted:
> > > > >
> > > > > With the idea that trusted_or_null stays that way for all prog
> > > > > types and bpf_iter__task->task deref stays trusted_or_null
> > > > > instead of being downgraded to ptr_to_btf_id without any flags.
> > > > > So progs can do few less !=3D null checks.
> > > > > Need to think it through.
> > > >
> > > > Ok. But don't allow passing such pointers into helpers, right?
> > > > We do that for raw_tp to preserve compat, but it would just exacerb=
ate
> > > > the issue if we start doing it everywhere.
> > > > So it's just that dereferencing a _or_null pointer becomes an ok th=
ing to do?
> > > > Let me mull over this for a bit.
> > > >
> > > > I'm not sure whether not doing the NULL check is better or worse
> > > > though. On one hand everything will work without checking for NULL,=
 on
> > > > the other hand people may also assume the verifier isn't complainin=
g
> > > > because the pointer is valid, and then they read data from the poin=
ter
> > > > which always ends up being zero, meaning different things for
> > > > different kinds of fields.
> > > >
> > > > Just thinking out loud, but one of the other concerns would be that
> > > > we're encouraging people not to do these NULL checks, which means a
> > > > potential page fault penalty everytime that pointer _is_ NULL, inst=
ead
> > > > of a simple branch, which would certainly be a bit expensive. If th=
is
> > > > becomes the common case, I think the prog execution latency penalty
> > > > will be big. It is something to consider.
> > >
> > > Ah, no, my bad, this won't be a problem now, as the JIT does emit a
> > > branch to check for kernel addresses, but it probably will be if
> > > https://lore.kernel.org/bpf/20240619092216.1780946-1-memxor@gmail.com=
/
> > > gets accepted.
> >
> > I applied this and tried to find out the time it takes to dereference
> > a NULL pointer using bpf_ktime_get_ns
> > With the patch above: time=3D3345 ns
> > Without (bpf-next right now): time=3D170 ns
> >
> > So I guess that means I should probably drop the patch above if we
> > decide to allow dereferencing NULL for all programs.
>
> Your concerns are valid.
> Accepting deref of trusted_or_null generically will cause these issues
> long term. It's indeed better to make programmers add explicit !=3DNULL
> to their programs.

Agreed. Not a huge fan of mutating reg->type in place with
mask/unmask, but it's fine overall. I think we could have removed half
of unmasks because they are done in error cases, at which point it
doesn't matter, but that's a minor complaint.

> So scratch my earlier suggestion. Let's keep this patch as-is with specia=
l
> hack for raw_tp only that we will hopefully resolve later
> either with __nullable suffix or compiler detection of nullability.
> The latter we discussed briefly with Eduard.
> It's doable to teach llvm to emit btf_tag to aid the verifier.
> gcc may catch up eventually.

