Return-Path: <bpf+bounces-44443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA449C2FDC
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35651F21A0A
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902B1A08DC;
	Sat,  9 Nov 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjzKxmir"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB042069
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192852; cv=none; b=CzYG0N16aNbzT4OdB0H8r8MjSEtCsc3pyYBgmpe3kaANmjctD36InhlyofS7vd0cGF2YhHKJnWeA4+dGwhSx3DgR/54Vm7bnd+y/PmEmIimQ2IbJpZ7SnKRGNQcAJziH5gHoFM+vRoIwDKa9/dl03H+OA7AY2r+RRiOTfmQq7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192852; c=relaxed/simple;
	bh=L0hzHBAE7mBdhe8fN68id+ffo4lX3BBa0r2ZXNfxI3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kphnznmopi5deMRNuwiSKxCRs3PlsJLVQTBMjPj87i9uJ3j1yVQ4uRVyuK8wN+FUjC3U1PiI2Y+UxAYzp+pr2IfEMW593LMPqtJqvhLSqrhyEAc+384UIldV9f0I9fNBpVgFBPH/nTVY1cKJi7n/6rLAlnmwkLiDAn6QcPVZrO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjzKxmir; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso4175830a12.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731192848; x=1731797648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpe63MIZEV3KspiAOd2Bna8hKT66CW5qH/KIt32VRjw=;
        b=CjzKxmir09MO9WDSvIC/+C5+duBfqxXIkoqZINklKZJhWUcT+Jy6F+b7zvqurADdxA
         bt12JOS0vN7L66SbXmXPn9gzzSni+YmG4bZcLVbOdRU2PKf7J4/NiLIXdbPdSs5np6Wh
         0y9V6vEhIhaFUnKT+lxEOF0ZYbOIsoCo0ugX9Cu4Ds0ypWlV+MLMg6/sv0OdDILRXS3b
         LwyGGycNCiPVWsiNT9MkOiHf1VvQIBUrlKPJyCIx+JwmEpoIg6RRBNahDsRHPaU++Gba
         O/NKGg1put7+xZlmpSmRhpgQZggZtyBVN2BcfiTuxedPVygHRfBRFa+UobHlJmsq3JWM
         V4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731192848; x=1731797648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpe63MIZEV3KspiAOd2Bna8hKT66CW5qH/KIt32VRjw=;
        b=Z5H85Z7CSnBGb9ntcsgKz2zLXUrJJ1/729hlajm68l+XPuFEelxicTxV8aycJmYIVV
         QIFtdPSh3CFlCB+eMHlvpxvpGGDD4dhNP433U45siUFvvkCTboCVwqQ6v09TIndv07eX
         HDScAG/9sROkXtpyPleh7xDADBFpuJtIK6BaAwDRUW0qOLd9DXmZokUNf/KOY4jPMJkR
         FDZlt/TD3R12mxu6Ng8/JO8pVbJ7WVumsUIf6QVtf3gI2YB3Jl4/py6ZJlMDmgR2WPNF
         CueNR/lg9gMbGqndRE/E74Z4oAUVf+Qcp41yZmEdrYOf4Y9XL97qkuqFsS1RxVzIHrXb
         cIDQ==
X-Gm-Message-State: AOJu0YywNMJsEVschIlR+QyT0LB+fn+nVbeyPiqpWhAdSLXSiG3X0kft
	uXfVwWg0BMw/kSnwvvSNZOKix3IPoa/SO9Fl7NL1Kc+8gIJ7e31iLBdeltH5Zy5N06afmjHVCJe
	vuTDCy015XQG14zUWGPE7byUzD0imb4buOys=
X-Google-Smtp-Source: AGHT+IFZ1en5VvvShH3cuHfB5SW3lJRiKfCrAh2osf8FEOKhEjRaVUVx1J88Uccgnf/tp3eWxhdeWaXxahNkj8AuwSo=
X-Received: by 2002:aa7:cb07:0:b0:5ce:dfe7:97c8 with SMTP id
 4fb4d7f45d1cf-5cf0a4465f8mr4824916a12.31.1731192848534; Sat, 09 Nov 2024
 14:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109074347.1434011-1-memxor@gmail.com> <CAADnVQKnYwooCPe5uku5yE1_VXxFiKrH=UW45SRUzRUb5TwmXg@mail.gmail.com>
 <CAP01T74MkwO9TA1zU1RzrFR+LYnd+1oyNEidWm0HU1e88LpJNQ@mail.gmail.com> <CAADnVQKxgE7=WhjNckvMDTZ5GZujPuT3Dqd+sY=pW8CWoaF9FA@mail.gmail.com>
In-Reply-To: <CAADnVQKxgE7=WhjNckvMDTZ5GZujPuT3Dqd+sY=pW8CWoaF9FA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 9 Nov 2024 23:53:32 +0100
Message-ID: <CAP01T7524qjYZ_+xKC5_Xn8B2CJXf3FRZ39Xas68y=z31Vzkfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Refactor active lock management
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Nov 2024 at 23:02, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 9, 2024 at 1:38=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Sat, 9 Nov 2024 at 22:30, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Nov 8, 2024 at 11:43=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >  struct bpf_retval_range {
> > > > @@ -434,7 +431,7 @@ struct bpf_verifier_state {
> > > >         u32 insn_idx;
> > > >         u32 curframe;
> > > >
> > > > -       struct bpf_active_lock active_lock;
> > > > +       int active_lock;
> > >
> > > What about this comment from v3:
> > > > +       bool active_lock;
> > >
> > > In the next patch it becomes 'int',
> > > so let's make it 'int' right away and move it to bpf_func_state
> > > next to:
> > >         int acquired_refs;
> > >         struct bpf_reference_state *refs;
> > >
> > > ?
> >
> > Ah, sorry, I somehow missed this part of the comment (twice). Mea culpa=
.
> >
> > >
> > > wouldn't it be cleaner to keep the count of locks in bpf_func_state
> > > next to refs
> > >
> > > acquire_lock_state() would increment it and release will dec it.
> > >
> > > check_resource_leak() will
> > > instead of:
> > > env->cur_state->active_lock
> > > do:
> > > cur_func(env)->active_lock
> > >
> > > so behavior is the same, but counting of locks is clean.
> > >
> > > Since in this patch it's kinda counting locks across all frames
> > > which is a bit odd.
> >
> > It would work, but we'd need to copy it over to a new frame's
> > bpf_func_state and copy it back on exit.
> > None of that would matter currently as only one lock can be held, but
> > it would become relevant later.
> >
> > It's the same situation with reference states. It is inherited from
> > the parent frame for every new frame, and then possibly changed, and
> > then copied back to parent frame.
>
> Exactly, but since we're unifying held locks as references
> would it make sense to treat them the same way everywhere?
> active_lock is just a count of held locks in ref state.
> For refs we do:
> if (!exception_exit && state->in_callback_fn &&
> state->refs[i].callback_ref !=3D state->frameno)
>
> so that
>   task =3D task_acquire().
>   bpf_loop(cb)
>   task_release(task)
> doesn't trip.
>
> Wouldn't we want the same for locks eventually ?
>

This prompted me to dig into why (I) added that check. Turns out it
would no longer be necessary after Eduard fixed callback verification
some time ago.
It was a stop gap to prevent certain bad patterns since verifier
simulated a callback once. So preventing addition of references from
callback, and release of parent references prevented unsafe behavior
when callback actually ran N times. Now that's no longer necessary, so
I went ahead and dropped all of that cruft from the verifier, and the
selftests added back then still failed correctly.

Anyhow, all of it makes sense, so I went ahead and put active_locks as
part of bpf_func_state.



> Just if (env->cur_state->active_lock) will change obviously.
> We may even need two counters for regular and resilient locks ?
> And in that case two counters in bpf_verifier_state looks even more odd.
> While two counters in bpf_func_state feels more logical.
>
> Just trying to anticipate the future changes...

