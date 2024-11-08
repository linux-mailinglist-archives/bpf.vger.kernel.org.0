Return-Path: <bpf+bounces-44327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7545D9C15EB
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 06:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BF5283733
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 05:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E911B373A;
	Fri,  8 Nov 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRq5ChlT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713A80C0C
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042762; cv=none; b=Uq4VRvywhnmzOXofoN4SfsQlVOT4Mod9B2ttRUfAYsAXV5Ksi0+Ln0YfETLJ1dNDOal0ecwCjZZmydDXBjWFI9USsrUt0gwhzng6jd08PpW7q6ulqvwYz2hzirupbZQV95c4unv/PUU2bzqt4qs0u0kdlm9/d4WF39NntazjH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042762; c=relaxed/simple;
	bh=mxfDRBLdV3zPHQF5VGaBfeVrQqPdFnhUuuu3weWdsJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFYfWfLKJ50UVv5AeAiaOQNcvJlANF0caxeSp3PHJD4+wH46Bg0D7cE9Bc2yJ4jjTwogROHhot3ywGb3q7cuT+FJhlDGGZr1hf/CKftwIvioJFqoEts2vAmeTriAk60oY2xxgH0pVBoke8DHKDDRNbgUUagcKPvnMjnBTdtlIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRq5ChlT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so974526f8f.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 21:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731042758; x=1731647558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZnUXHqhbTmfFiyU1Qk7rBZrbTlQIX0L46yX/d/HjnQ=;
        b=hRq5ChlTtx16yRlIlLWUgXiRPtc1h2aubb8533m/7PE90mZk16cUAwZGTpAI/P/HT0
         pEsrqBIhCFdLaXCXZOj9KVsVAz8oStsP0EPhzCVCzLQzJR7RaOWd/FLwv8+06Wr5Ibqz
         a6yQP235Sms2gp8uTIB+TMQ060okVCxpXkSoNUER+j93jESN4bY763hfn7naDoykDaP/
         b8cv8gI7cDbULA7hQdgzuPIyQepX5NHY1/VPY5NihJQzQ7P7irrrN1fpWDJF3gk0CV2j
         06KytvZYSvILQzoA22gK5BaqHLix1LC2jjVQwK54cq3wlBWqkgXGZxBldQP+Tgyv/2Zp
         oXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042758; x=1731647558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZnUXHqhbTmfFiyU1Qk7rBZrbTlQIX0L46yX/d/HjnQ=;
        b=Q3tHsW7a3ZzwNfZoifMJ7Y9q7fv3dKxEAzVmt5kDrKS5l7Ha1yJzukMovsKPaAyHfD
         KBSTmlPgGaJ1NRC+KJgh+r6oQvnMHSOR4zJLzljkvakgUpL74ZFHkf8q5EP+xu7ZNs2S
         3jMCTJj/c+jHN5tGNCceDgXayfd89Ho0F4+q9OUeaX//TOWc9a7VBj8uW6aoz1tsntqV
         Y2W+KMv6YTn3stH/sSyp4ajCK8Dd+t1VgahJF8U/hsenzYs61Xk4WDtbgP6pU+NUAmJc
         koTbHPCnTzlJetNYdUYOgGFFTSLYFFsSd2oZyDFb4XMw2nSNInMDsc/oeRl5PDJ/AZDD
         ipuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpxNurat+9SbFm95eF/HetZFT8dxNMPWY34okefr8GBHuZAcXVtBsvzUo2q/mFx44v0PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfrrmnnoy/jLkjmOIOz2eVOeb5LJvqbQJGKVsCA45H67FzROZ
	f8kSSPVrw9Ap4lxa0vkhrCBk1DkMO4BdyY9WIfnNgsSNlBpr1Po2JSqsTf4k/9wDKn2D/4qleWz
	w2jOBi7mbFAtLL8XoJ4Ycd9jQbfChCQ==
X-Google-Smtp-Source: AGHT+IEBKUVzzoxpHHAqLN1fUvDY6txkbwPyPooLFI40z+nDR0iUVLbqF+5cDb8Gn8bX5fIBQzhAyKyBIePnqdL/9OU=
X-Received: by 2002:a05:6000:144f:b0:37c:d23a:1e4 with SMTP id
 ffacd0b85a97d-381f1834d2amr1241110f8f.30.1731042758073; Thu, 07 Nov 2024
 21:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104171959.2938862-1-memxor@gmail.com> <20241104171959.2938862-2-memxor@gmail.com>
 <CAEf4BzYxjWY-YCaCMQ73joU_O96KhKBRXm6KgvENJk1TbeCD_w@mail.gmail.com> <CAP01T751Cbx3PBDPYnO4+gjkDXpGRd=i5VHmz7VT-y7XhP3hEg@mail.gmail.com>
In-Reply-To: <CAP01T751Cbx3PBDPYnO4+gjkDXpGRd=i5VHmz7VT-y7XhP3hEg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Nov 2024 21:12:26 -0800
Message-ID: <CAADnVQJ0pgeqQ7t7Toa-p8hp=w--E9cUTK1KY4thorMZg=TS8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Jiri Olsa <jolsa@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:58=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Wed, 6 Nov 2024 at 16:32, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Mon, Nov 4, 2024 at 9:20=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > Arguments to a raw tracepoint are tagged as trusted, which carries th=
e
> > > semantics that the pointer will be non-NULL.  However, in certain cas=
es,
> > > a raw tracepoint argument may end up being NULL. More context about t=
his
> > > issue is available in [0].
> > >
> > > Thus, there is a discrepancy between the reality, that raw_tp argumen=
ts
> > > can actually be NULL, and the verifier's knowledge, that they are nev=
er
> > > NULL, causing explicit NULL checks to be deleted, and accesses to suc=
h
> > > pointers potentially crashing the kernel.
> > >
> > > To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then specia=
l
> > > case the dereference and pointer arithmetic to permit it, and allow
> > > passing them into helpers/kfuncs; these exceptions are made for raw_t=
p
> > > programs only. Ensure that we don't do this when ref_obj_id > 0, as i=
n
> > > that case this is an acquired object and doesn't need such adjustment=
.
> > >
> > > The reason we do mask_raw_tp_trusted_reg logic is because other will
> > > recheck in places whether the register is a trusted_reg, and then
> > > consider our register as untrusted when detecting the presence of the
> > > PTR_MAYBE_NULL flag.
> > >
> > > To allow safe dereference, we enable PROBE_MEM marking when we see lo=
ads
> > > into trusted pointers with PTR_MAYBE_NULL.
> > >
> > > While trusted raw_tp arguments can also be passed into helpers or kfu=
ncs
> > > where such broken assumption may cause issues, a future patch set wil=
l
> > > tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) =
can
> > > already be passed into helpers and causes similar problems. Thus, the=
y
> > > are left alone for now.
> > >
> > > It is possible that these checks also permit passing non-raw_tp args
> > > that are trusted PTR_TO_BTF_ID with null marking. In such a case,
> > > allowing dereference when pointer is NULL expands allowed behavior, s=
o
> > > won't regress existing programs, and the case of passing these into
> > > helpers is the same as above and will be dealt with later.
> > >
> > > Also update the failure case in tp_btf_nullable selftest to capture t=
he
> > > new behavior, as the verifier will no longer cause an error when
> > > directly dereference a raw tracepoint argument marked as __nullable.
> > >
> > >   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt1=
4gen4.remote.csb
> > >
> > > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> > > Reported-by: Juri Lelli <juri.lelli@redhat.com>
> > > Tested-by: Juri Lelli <juri.lelli@redhat.com>
> > > Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_=
TRUSTED_ARGS kfuncs")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h                           |  6 ++
> > >  kernel/bpf/btf.c                              |  5 +-
> > >  kernel/bpf/verifier.c                         | 79 +++++++++++++++++=
--
> > >  .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
> > >  4 files changed, 87 insertions(+), 9 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -12065,12 +12109,15 @@ static int check_kfunc_args(struct bpf_veri=
fier_env *env, struct bpf_kfunc_call_
> > >                         return -EINVAL;
> > >                 }
> > >
> > > +               mask =3D mask_raw_tp_reg(env, reg);
> > >                 if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta=
)) &&
> > >                     (register_is_null(reg) || type_may_be_null(reg->t=
ype)) &&
> > >                         !is_kfunc_arg_nullable(meta->btf, &args[i])) =
{
> > >                         verbose(env, "Possibly NULL pointer passed to=
 trusted arg%d\n", i);
> > > +                       unmask_raw_tp_reg(reg, mask);
> >
> > Kumar,
> >
> > Do we really need this unmask? We are already erroring out, restoring
> > reg->type is probably not very important at this point?
> >
>
> Hello Andrii,
> The reason I undid the masking was to ensure if the register type is
> printed for some reason,
> it stays consistent and the masking isn't visible, but I guess the
> verifier state is printed _before_ an instruction is symbolically
> executed so it's not helping with anything.
>
> I can send a follow up to remove the additional unmasking steps.

After sleeping on it I think I prefer to keep the code as-is.
Removing unmask() in few error path will make it asymmetrical
and harder to reason about.
Right now it's a straightforward hack mask and unmask.
Optional unmask just begs the question... why?
Maybe something will print regs in error path...
Maybe not now, but tomorrow.

So keep it as-is. No need for follow up.

