Return-Path: <bpf+bounces-16523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9817801F20
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 23:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5687B1F20FAB
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A32230A;
	Sat,  2 Dec 2023 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyTLbmqS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C012119
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 14:41:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so32008635e9.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 14:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701556899; x=1702161699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/gFp8SEAClB/80TnkI9sWvoYozXNlykr/a9i8domd0=;
        b=hyTLbmqSPGJUsGVwdGBAlcsxNaHp+ASSZiMjFrbp5N+9luArP7KYRjKch1ZPeczEep
         6FV4nnQzEI0du+z+n+F6YlwzFUg7+8hohlpEtrCdEumZ0V8kwlEmm65HghPufApV/bst
         jf+ceK+D8Uv4aXUIUyyK61wtK+C/9Ko7uj4uClmJeMmaoNsD0wxdJexWG4cWgida9NNY
         4BKcBhMK0utXsLVMy9ZhNZLJtmKt5xs3qBavAOSIebV949JV+Voz2iHDI4huB/2QudJd
         3kasgtRap2k0tOVh1SZ7m3tVO7vPlRijdXvOqxIjJriQmOsRpR2mn8RaKwzKFJKucEm6
         NEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701556899; x=1702161699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/gFp8SEAClB/80TnkI9sWvoYozXNlykr/a9i8domd0=;
        b=HRpSaiTQEn3zbqZhysadauSf+89GiUZqSoFYdPRI9WzrOjxn1WvJWzMYB7ZIjxswto
         3dZFlTcGgfP40u5P7CG/ziqPIixJnRyptQ4kourx0Mx8nlP5BhuEKaOgnNkGdVRbCZZG
         jGyPMc0zk7Ijn4C4blwC6wFtZF4PW9JqgNFj1x5KMbLwuXkAaZZRcW/D4f1jpq/dAvD+
         zr9Vr5X1r0h81ugT6RZShOzXnu/qnqc1JGWwfjHNGt6xsSHaqnaGDEhx0hFOZZJPivOY
         ESdU4Kt27/5l4sBtDZG8zYrttayZOAclAppbhm0M/tUK2dJJ7zhnGkM7FZkK77M49CG4
         F+Sg==
X-Gm-Message-State: AOJu0Yy+C0Qx9QHN7vUIrYggTQPIAThKBkCZJInLypZknukbd9yTns4E
	bKcgNKgurffCCYCO32ScUPGXMCok23GvcgJ9DtVCxGXKIiw7jQ==
X-Google-Smtp-Source: AGHT+IFliR6pW/NvpUBLiK4CE/A2cOxbzMnGdmp3lPRFPDGEab/Dpd+2ZD/1tnMTOWx0bOJfLWjiYO0GJyOmPRylT9k=
X-Received: by 2002:adf:f6c3:0:b0:333:2fd2:8170 with SMTP id
 y3-20020adff6c3000000b003332fd28170mr1868293wrp.141.1701556898359; Sat, 02
 Dec 2023 14:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
 <20231126015045.1092826-2-andreimatei1@gmail.com> <CAEf4BzacRRwzdQH8LuQkV695=rm65jnv1bX2n9gks6G+wGAw6w@mail.gmail.com>
 <CABWLses9f6izTmODQf_hKwhvH54-vpWrzWHP_KRG=n8gRWpp-w@mail.gmail.com> <CAEf4BzZuf1XHe7=Am1c3Crv9CMrz8TjDKczKQaih=guAVi0wpA@mail.gmail.com>
In-Reply-To: <CAEf4BzZuf1XHe7=Am1c3Crv9CMrz8TjDKczKQaih=guAVi0wpA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sat, 2 Dec 2023 17:41:27 -0500
Message-ID: <CABWLsetitXf6ttjFuMK=7b7zOk5EAgJ0BDzMo6r7r2VHhV1Q4g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 29, 2023 at 8:48=E2=80=AFAM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > [...]
> >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index af2819d5c8ee..f9546dd73f3c 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -1685,10 +1685,12 @@ static int resize_reference_state(struct bp=
f_func_state *state, size_t n)
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int grow_stack_state(struct bpf_func_state *state, int size=
)
> > > > +/* Possibly update state->allocated_stack to be at least size byte=
s. Also
> > > > + * possibly update the function's high-water mark in its bpf_subpr=
og_info.
> > > > + */
> > > > +static int grow_stack_state(struct bpf_verifier_env *env, struct b=
pf_func_state *state, int size)
> > > >  {
> > > >         size_t old_n =3D state->allocated_stack / BPF_REG_SIZE, n =
=3D size / BPF_REG_SIZE;
> > >
> > > shouldn't this be rounding up? (size + BPF_REG_SIZE - 1) / BPF_REG_SI=
ZE?
> >
> > You're saying this was always broken, regardless of the current patch, =
right? I
>
> I think so, yes...

I believe that this code was OK after all because all the callers to
grow_stack_state() do the rounding. This seems fragile though; I'll include=
 a
patch to push the rounding inside grow_stack_state() if it's OK to you.

While reading the code around how the stack is accessed, something else cau=
ght
my eye. I'm not sure if there's a problem or not; perhaps you could take a
look. Around here in check_stack_write_fixed_off() [1], the code that deals
with register spills has a couple of cases, including:

[1] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10=
235fe3e9/kernel/bpf/verifier.c#L4733-L4744
} else if (reg && is_spillable_regtype(reg->type)) {
  /* register containing pointer is being spilled into stack */
  if (size !=3D BPF_REG_SIZE) {
    verbose_linfo(env, insn_idx, "; ");
    verbose(env, "invalid size of register spill\n");
    return -EACCES;
  }
  if (state !=3D cur && reg->type =3D=3D PTR_TO_STACK) {
    verbose(env, "cannot spill pointers to stack into stack frame of
the caller\n");
    return -EINVAL;
  }
  save_register_state(state, spi, reg, size);
}


This branch, as opposed to all the others, calls save_register_state() with=
out
checking that `!(off % BPF_REG_SIZE)`. I believe save_register_spill()
implicitly assumes that the access is aligned, so it'd be bad if `off` was =
not
aligned. Is it possible for the offset to not be aligned? I'm not sure... T=
he
higher-level check_mem_access() starts with a check_ptr_alignment(), which =
I
think does the required check at least on the code paths that I've tried. B=
ut
then why do all the other branches in check_stack_write_fixed_off() check f=
or
the alignment explicitly? FWIW, the branch in question also has a
is_spillable_regtype() check which is perhaps relevant.

Would an assertion that off is indeed aligned in the branch I'm talking abo=
ut
(or elsewhere around) be welcomed?

Apologies if I'm paranoid for no reason.


>
> > think you're right, but that seems like a bug that should have been
> > caught somehow; I'm surprised no programs crashed the verifier. Perhaps=
 in
> > practice all stack accesses are 8-byte aligned, so the rounding doesn't=
 matter?
> >
> > I'll spend a bit of time reading code and come back.
>
> Thanks!
>
> >
> > [...]

