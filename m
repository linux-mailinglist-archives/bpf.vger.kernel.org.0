Return-Path: <bpf+bounces-46102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A529E43DC
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3340283416
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AD1C3BE7;
	Wed,  4 Dec 2024 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEa92Y2F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF891A8F9A
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338576; cv=none; b=q9CQedCvNImsH633N0D2EGFVz7r0grUff4myou21BqnrxYTQukN7a0IcSDJLcGdnJlLux9F4SKYP9iSbHtVpKkUSYvpoMdC4+F3K88WetphFl6MavNbJQlo3e+DZ9BXuGoAcgyZCgMV5YdhUfHVXqyMGV2j1hqsw1y6XPUv9Xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338576; c=relaxed/simple;
	bh=FdKT/fmFYEe8C7K3p99YGxo4Z/QznZ9OrekCpLu9NtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewWLFT2MZrD6qa7Q7My1cl1CziZwooxK2qEtYNpqz9Vx81qQeKMwvaJT2Q8/FjxPHEfi+hLHu+X+VCUiH8ZMjvEb0TwZgEIjjYCHGyZHMKndtlFb6JS3ilIbhpQMfErja6w79tPo5x8QvCvpUBt6/nOnuPGSevZAvM/kl1moXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEa92Y2F; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso68147a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733338573; x=1733943373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3cCSVv0PFTaz1+xxk6dCPJtLrPNqKgW8j0trZy2PWc=;
        b=ZEa92Y2FHaIfdDVjQ3rACpjOQcEnhOAV+TWdG4YaKnvQdxdnP0zovTiePgFMp/YqWS
         17AsvEkhVeiJTrd22FXFhLj46zgQ3Jn7uKxYIV7qz+JORtnrjhI/z7hCVNwR//5KMw5a
         KYy6asLOSDcyVWnkprXyc1hgXRfVdeccf5Hva5ITh7uV5hiSJKH71FStFwEbhyh74ktl
         DjMM/KdP1yYtxtjWaEujo1Wicgg45zOZ5I50g4gTn713AEI2mfOEdl/obRssacK4Tx8U
         s45ZjjubKsQ7IZgwuIRBOByHuS9GKfRchC2lgQhXXl810kOZU+2zG4X69o2uxOHpCs4K
         IsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338573; x=1733943373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3cCSVv0PFTaz1+xxk6dCPJtLrPNqKgW8j0trZy2PWc=;
        b=rTdaLAQekvu2orghjXMfk9U5gAFZNtIA+v20o5T+t84bcs7VLGINX1zoq/D8KfHs9z
         3Jf1HX+1JtpzNReuAh/ewWiwbxulnUuKSVowUJGV+Vv6OXdNFPlt7Ik9ZJrm8h9qtcaG
         WtTOpfsgwEoZ5Pf1XVcZ4OBch5jInt/oxxRdahZdWHdlUQSdhtMPwU6cnMCeIuPLcZrV
         xCP7lSJZHSq90qpMQ2Vz+gtvRXONCu5D1S88eD3AqItqYP3pyghXOUR4Xu51yl2tQxab
         XBmJENyhOiF7TP8IDfhO6CKM6MPm4LRCuJB4/T8NVsxcPP/dspHkWYAk4b4fKWsI/fk4
         duRA==
X-Gm-Message-State: AOJu0YwOMYrCqP4kGseIJ0i3HjpPkFly+fkSrAWSqGeHgtAo5DONI7xf
	RDGcYUnbBGPZyl1u/mnIZzILOGnnSk3T89on9r4St5aHBFOP287OmmS4mVoauhLiEng++bA7CKf
	w6tXGnWpl4Duje4jOP3ZdvwUuazcwa4dcUIc=
X-Gm-Gg: ASbGncvW3IzuxZITz1Q17YlNhEn6ByOX2qMAmoPxwmU4Esxh4PZVJPw8R7umdKMd6VB
	A+1L/ruu86cSbkBgfqZevn7s2hrPC37Flm9+QKWtLaFHnV85wZ82Siep4vXE3Oqm8
X-Google-Smtp-Source: AGHT+IGSVAOt4v5Q9UrIzXPrb4q0YahJoMoWU6IYy+uf4gV03cYrl1ECOZIiegEG0SbHhyR1bR//hhjw6akZ7LQ9H2I=
X-Received: by 2002:a05:6402:2787:b0:5d0:bdc1:75df with SMTP id
 4fb4d7f45d1cf-5d10cb805ecmr6045606a12.24.1733338572626; Wed, 04 Dec 2024
 10:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-2-memxor@gmail.com>
 <CAADnVQJpV2+b54q9zcpOg+zJedv8xpA6Csn_6ksTzpcgztmfwQ@mail.gmail.com>
In-Reply-To: <CAADnVQJpV2+b54q9zcpOg+zJedv8xpA6Csn_6ksTzpcgztmfwQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 4 Dec 2024 19:55:35 +0100
Message-ID: <CAP01T74-ST0+ouiNkBqR2JodSwpFj44PBKJezpuNfCdzab92kg@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Suppress warning for non-zero off raw_tp
 arg NULL check
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Manu Bretelle <chantra@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 at 17:37, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 3, 2024 at 6:42=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > The fixed commit began marking raw_tp arguments as PTR_MAYBE_NULL to
> > avoid dead code elimination in the verifier, since raw_tp arguments
> > may actually be NULL at runtime. However, to preserve compatibility,
> > it simulated the raw_tp accesses as if the NULL marking was not present=
.
> >
> > One of the behaviors permitted by this simulation is offset modificatio=
n
> > for NULL pointers. Typically, this pattern is rejected by the verifier,
> > and users make workarounds to prevent the compiler from producing such
> > patterns. However, now that it is allowed, when the compiler emits such
> > code, the offset modification is allowed and a PTR_MAYBE_NULL raw_tp ar=
g
> > with non-zero off can be formed.
> >
> > The failing example program had the following pseudo-code:
> >
> > r0 =3D 1024;
> > r1 =3D ...; // r1 =3D trusted_or_null_(id=3D1)
> > r3 =3D r1;  // r3 =3D trusted_or_null_(id=3D1) r1 =3D trusted_or_null_(=
id=3D1)
> > r3 +=3D r0; // r3 =3D trusted_or_null_(id=3D1, off=3D1024)
> > if r1 =3D=3D 0 goto pc+X;
> >
> > At this point, while mark_ptr_or_null_reg will see PTR_MAYBE_NULL and
> > off =3D=3D 0 for r1, it will notice non-zero off for r3, and the
> > WARN_ON_ONCE will fire, as the condition checks excluding register type=
s
> > do not include raw_tp argument type.
> >
> > This is a pattern produced by LLVM, therefore it is hard to suppress it
> > everywhere in BPF programs.
> >
> > The right "generic" fix for this issue in general, will be permitting
> > offset modification for PTR_MAYBE_NULL pointers everywhere, and
> > enforcing that the instruction operand of a conditional jump has the
> > offset as zero. It's other copies may still have non-zero offset, and
> > that is fine. But this is more involved and will take longer to
> > integrate.
> >
> > Hence, for now, when we notice raw_tp args with off !=3D 0 when unmarki=
ng
> > NULL modifier, simply allocate such pointer a fresh id and remove them
> > from the "id" set being currently operated on, and leave them as is
> > without removing PTR_MAYBE_NULL marking.
> >
> > Dereferencing such pointers will still work as the fixed commit allowed
> > it for raw_tp args.
> >
> > This will mean that still, all registers with a given id and off =3D 0
> > will be unmarked, even if a register with off !=3D 0 is NULL checked, b=
ut
> > this shouldn't introducing any incorrectness. Just that any register
> > with off !=3D 0 excludes itself from the marking exercise by reassignin=
g
> > itself a new id.
> >
> > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > Reported-by: Manu Bretelle <chantra@meta.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 39 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1c4ebb326785..37504095a0bc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15335,7 +15335,8 @@ static int reg_set_min_max(struct bpf_verifier_=
env *env,
> >         return err;
> >  }
> >
> > -static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> > +static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
> > +                                struct bpf_func_state *state,
> >                                  struct bpf_reg_state *reg, u32 id,
> >                                  bool is_null)
> >  {
> > @@ -15352,6 +15353,38 @@ static void mark_ptr_or_null_reg(struct bpf_fu=
nc_state *state,
> >                  */
> >                 if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || =
!tnum_equals_const(reg->var_off, 0)))
> >                         return;
> > +               /* Unlike the MEM_ALLOC and NON_OWN_REF cases explicitl=
y tested
> > +                * below, where verifier will set off !=3D 0, we allow =
users to
> > +                * modify offset of PTR_MAYBE_NULL raw_tp args to prese=
rve
> > +                * compatibility since they were not marked NULL in old=
er
> > +                * kernels. This however means we may see a non-zero of=
fset
> > +                * register when marking them non-NULL in verifier stat=
e.
> > +                * This can happen for the operand of the instruction:
> > +                *
> > +                * r1 =3D trusted_or_null_(id=3D1);
> > +                * if r1 =3D=3D 0 goto X;
> > +                *
> > +                * or a copy when LLVM produces code like below:
> > +                *
> > +                * r1 =3D trusted_or_null_(id=3D1);
> > +                * r3 =3D r1; // r3 =3D trusted_or_null(id=3D1)
> > +                * r3 +=3D K; // r3 =3D trusted_or_null_(id=3D1, off=3D=
K)
> > +                * if r1 =3D=3D 0 goto X; // see r3.off !=3D 0 when unm=
arking _or_null
> > +                *
> > +                * The right fix would be more generic: lift the restri=
ction on
> > +                * modifying reg->off for PTR_MAYBE_NULL pointers, and =
only
> > +                * enforce it for the instruction operand of a NULL che=
ck, while
> > +                * allowing non-zero off for other registers, but this =
is future
> > +                * work.
> > +                */
>
> I think the comment is too verbose.
> Especially considering that we're going to remove this hack in bpf-next.
>
> I can trim it to bare minimum while applying if you're ok ?

No objections.

