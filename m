Return-Path: <bpf+bounces-44182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC789BF989
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14334283AF0
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2DD20CCF0;
	Wed,  6 Nov 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvxAzU0P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B72EAE0
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933920; cv=none; b=U4SdqYurZWtJ0jrfrYbVX59biZPYHMDinIdoeeemMSz9XSJduAvL+eE1oUauhp8WnC3zdIy4Ny/CqP1ho1rB/qAW776Z+TMQ95iFRSvWLzzBouy/xkp2s38H4IuzOg35QTSw0eqEn0+3AJbzIeI1pF//8aQENEAA6FtQm/ujSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933920; c=relaxed/simple;
	bh=r/NqYipL5/D7sjkW3zWii9tv0E3QyyG3O2MyWyGYXNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNi95gsaFp7URDtVznuTVVKv437BEF0JKALJKuM8sqHc2f/cIR4tzFlnhQS4Y4fN796lyhSaTEKCO9MfpF7zN8kCWeMNJXY2B/uIwGrhKbs5DLnIXoFJMHIexIZ08OrkTf7mqDxWcqyY904gAuqQUiq2Ktm21sfTHMYUMo6RgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvxAzU0P; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso368092a12.2
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730933917; x=1731538717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obEUuw2hvCl1gUoDN15zWrJLlx3PgcYozpmH+dnW5TU=;
        b=QvxAzU0PFyEmFK9U0ndD9E2ySur/+2vfZG9eFwRM2TZTEMT6k5QKmjkCV/MRLUs0rc
         TLCpBo2smrQUnNn/rJg8lyPCHLoVee8F5v/uo7f5iHp0g3TwKqEsf5o8rorwkwtEyY4D
         ZaLneQJJo45H2E/Gi9hZEbWQ61/xL+TSqUih9dYMZeyVE3/ScKfCwc0ZC4YLcC3b1PKg
         rImcVJgGJfm5a6/GQZ623hHmT/uEfSpixS1mlWetUeh36eaaS0vOwgeJJT6TlfKej4FR
         7/DmWy2LPvNibOO3JIP/pu9/C48n5T3M/Ymso9b1oHJoGJzREoV8bAO1dhNTRn7cUbZE
         1wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730933917; x=1731538717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obEUuw2hvCl1gUoDN15zWrJLlx3PgcYozpmH+dnW5TU=;
        b=fozRhEWP4SpZYvvHz2fmt4feAwA41IDzF//tEGbwr8ss3vND1lFWNEA68CEPOFuqN9
         RoGGq/br/Ule9iHdyze0AimqWLcSj6L0FfsB7MIBYtFlxhaJnEaw1k0F3ARvwXw1flan
         Abw4qMd5ZQ1qlYGIUE/fEuRhp2fKBs/2LTG2EcZqehOM7t2Zz66bn/hjOcsfA05GhPVU
         DWKMga8rLDUNj0af2L7xFXUcSMw6kw4O2QJgRW2jfaYqc4qKRH7gd3OPZ+BTTazcDPIa
         setMvrPOTleIqWiLT52sRf3U5Q4BhquIi+ZMrnMqT5tl6L1rO5TZb70hMbCcv3zMWhww
         3qsQ==
X-Gm-Message-State: AOJu0YwaQ4gvKLvwB1ODLt8cAZEHr/hnUEZdRUJ7vY/fT+LGYSoPaMOI
	5CHh/2nrxPy9IqcVHqpQ7HVs6bj4XpIQHM3joBxC34D9dhd7o+PL7Mo5Tnqg4+25o1aJ4PWm24v
	hgwUe7hSz7oqQBUkfstSUxrKVW3M=
X-Google-Smtp-Source: AGHT+IG6NfiBI2kcXCAAi27E3ZxZjAGBf7LozIfYhEMjtqQlGO8TyTP5RnrEC91KYiFDPpgBzweQu8ymCrGPT+Fgh98=
X-Received: by 2002:a05:6402:278b:b0:5ce:de17:4174 with SMTP id
 4fb4d7f45d1cf-5cede17418bmr7798332a12.0.1730933916988; Wed, 06 Nov 2024
 14:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104171959.2938862-1-memxor@gmail.com> <20241104171959.2938862-2-memxor@gmail.com>
 <CAEf4BzYxjWY-YCaCMQ73joU_O96KhKBRXm6KgvENJk1TbeCD_w@mail.gmail.com>
In-Reply-To: <CAEf4BzYxjWY-YCaCMQ73joU_O96KhKBRXm6KgvENJk1TbeCD_w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 6 Nov 2024 16:58:00 -0600
Message-ID: <CAP01T751Cbx3PBDPYnO4+gjkDXpGRd=i5VHmz7VT-y7XhP3hEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Jiri Olsa <jolsa@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 16:32, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Mon, Nov 4, 2024 at 9:20=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Arguments to a raw tracepoint are tagged as trusted, which carries the
> > semantics that the pointer will be non-NULL.  However, in certain cases=
,
> > a raw tracepoint argument may end up being NULL. More context about thi=
s
> > issue is available in [0].
> >
> > Thus, there is a discrepancy between the reality, that raw_tp arguments
> > can actually be NULL, and the verifier's knowledge, that they are never
> > NULL, causing explicit NULL checks to be deleted, and accesses to such
> > pointers potentially crashing the kernel.
> >
> > To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then special
> > case the dereference and pointer arithmetic to permit it, and allow
> > passing them into helpers/kfuncs; these exceptions are made for raw_tp
> > programs only. Ensure that we don't do this when ref_obj_id > 0, as in
> > that case this is an acquired object and doesn't need such adjustment.
> >
> > The reason we do mask_raw_tp_trusted_reg logic is because other will
> > recheck in places whether the register is a trusted_reg, and then
> > consider our register as untrusted when detecting the presence of the
> > PTR_MAYBE_NULL flag.
> >
> > To allow safe dereference, we enable PROBE_MEM marking when we see load=
s
> > into trusted pointers with PTR_MAYBE_NULL.
> >
> > While trusted raw_tp arguments can also be passed into helpers or kfunc=
s
> > where such broken assumption may cause issues, a future patch set will
> > tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) ca=
n
> > already be passed into helpers and causes similar problems. Thus, they
> > are left alone for now.
> >
> > It is possible that these checks also permit passing non-raw_tp args
> > that are trusted PTR_TO_BTF_ID with null marking. In such a case,
> > allowing dereference when pointer is NULL expands allowed behavior, so
> > won't regress existing programs, and the case of passing these into
> > helpers is the same as above and will be dealt with later.
> >
> > Also update the failure case in tp_btf_nullable selftest to capture the
> > new behavior, as the verifier will no longer cause an error when
> > directly dereference a raw tracepoint argument marked as __nullable.
> >
> >   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14g=
en4.remote.csb
> >
> > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> > Reported-by: Juri Lelli <juri.lelli@redhat.com>
> > Tested-by: Juri Lelli <juri.lelli@redhat.com>
> > Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TR=
USTED_ARGS kfuncs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h                           |  6 ++
> >  kernel/bpf/btf.c                              |  5 +-
> >  kernel/bpf/verifier.c                         | 79 +++++++++++++++++--
> >  .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
> >  4 files changed, 87 insertions(+), 9 deletions(-)
> >
>
> [...]
>
> > @@ -12065,12 +12109,15 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                         return -EINVAL;
> >                 }
> >
> > +               mask =3D mask_raw_tp_reg(env, reg);
> >                 if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta))=
 &&
> >                     (register_is_null(reg) || type_may_be_null(reg->typ=
e)) &&
> >                         !is_kfunc_arg_nullable(meta->btf, &args[i])) {
> >                         verbose(env, "Possibly NULL pointer passed to t=
rusted arg%d\n", i);
> > +                       unmask_raw_tp_reg(reg, mask);
>
> Kumar,
>
> Do we really need this unmask? We are already erroring out, restoring
> reg->type is probably not very important at this point?
>

Hello Andrii,
The reason I undid the masking was to ensure if the register type is
printed for some reason,
it stays consistent and the masking isn't visible, but I guess the
verifier state is printed _before_ an instruction is symbolically
executed so it's not helping with anything.

I can send a follow up to remove the additional unmasking steps.

> [...]

