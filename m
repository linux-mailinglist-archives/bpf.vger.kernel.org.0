Return-Path: <bpf+bounces-46306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83429E7807
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719151886230
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA21FFC67;
	Fri,  6 Dec 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYETEUup"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442F194120
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509497; cv=none; b=MzMkkqEh03QgMMRgBjOwjXemVkDeiGH0UOsN37Mg3NeKaXMu5+8CyIXLXt2Ty7l/JwEidy6ubjgmYDd1TeUf2cbhbb6VM5avDTkAWMKHMoGHFUaEvTrt81gBOT67G6XVOCNrDcJvXfYhS6K9zVsvlV/2tvwuJttStX1I4bswEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509497; c=relaxed/simple;
	bh=giSRTSgkvkGukZa8huXkniW9YZgZeL3cxIf9ou9m0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZKXxU1kxMF7apQ6xFl+t21mGydfm+Xi3bcgF0y3pdqN9WBBjlwZhaOJG3dRfVzc7rqxosDKvHMbGB6b2oDtD1qQptcNjl/3oSMmjbKWJb17TlcMHr9r3zBDDHsaL0W5OwEwDsBpsHtLnhKoN31t3Bp5z0KoTpIc1wCDMYJm6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYETEUup; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso25254061fa.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509493; x=1734114293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLMu2otS8Leowm/uJYjqs45pKop2vNjc0mBKpIQOfXs=;
        b=TYETEUupiMJqG8ugmLP/lb0E/AWSM1vUgd0IfCwb+zweVIibtkMNMa3Oz5smSYNvlF
         xkvUMeaC7j5oAETxEYHPUwLeGXjR2iS9yRmCQBL8JEo7wvRaqv5s+PgM/44Yjf7wHFN4
         XaBn85f+V4+iB7gmqg1aP0KmlzeZFeJiYvcckItZv/IokiZF9i4Yykdcxg/OQQCpET1W
         vxi1MC9zIGRW33TDBwrg87cA9ckmGnD/ry9jKhEzuO/96S+pu2JPWlb2hRQ8v5dozavE
         zNbEmwn62/hksTXQmP/F5uQD5G4uJCr9CdMQxPZJ1UOvQIOQ9irhjX2WfJKGAuMDTaTE
         5uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509493; x=1734114293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLMu2otS8Leowm/uJYjqs45pKop2vNjc0mBKpIQOfXs=;
        b=XQeAl+qxjH8nw8kxHNqiK1Wo8iHC4P+TMqcgaMUZK6ipyszTNKblmMHRSw4YERoQah
         l19mYTjhTcnHOb+rOlBXG89wnHNRSwi21/jSskpVgBvFjeHLMWDgOhLWcPl1JTA6AfKH
         CYU9sObZZ040IMOK+F9gxG0sSnG9F8yHEqIxUoedjktEakwlp8FEYl4l7abv2FFuPg9Q
         gzcRGBSqma8IdiDNsDfR66dCqjJaUgZdcnabvc1rdgpTXne5rtD3TXfIh7q2l1zXCHKc
         ueNWZxJ0g3M+Q7xlvJagsRSI0Rpr7zi7ppOVMD/Z4NTUUF2qU72MiGTIwHyeUoTss656
         2KTg==
X-Forwarded-Encrypted: i=1; AJvYcCX80VxQMUUFB3NkZOP//WQV7LTjVQqBAVcx9q3XlGWiau8sMT562H3nv7sRgodAVWFNL4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpiNTGmttkcLM/rx5PpDjnsNipGVNZwTmSDh6ViWnerHEKJoY
	p8UzALP6x3WfybSfLvKkSLqupQAc7BCj0BheDMyK/n342MaGCBtuoSjXbAS6BJavqnFuHoDpdCi
	i10WSaJNIrTZa1i8dMiu3IIILzpI=
X-Gm-Gg: ASbGncsAGCyluQy6bMeLyAX1QgbvP8qXnFRSQYCzXGa4P8+2sExawNHXuWJXfClkQ9b
	VsTsva0IJNjb8sU2KcdchxNgW3qeARFVlV+dL1DOEh6BViXboCGOqlaBR1xiGj1Ow
X-Google-Smtp-Source: AGHT+IGhZM6rSmInZVNx4cDYsKBYVL1ATYVx199oSl6jGqLsSf/mqoQJJgYvjvSSnoWgiw7IltjET9CnC5EL8uR6ylE=
X-Received: by 2002:a05:651c:502:b0:2ff:d81f:7bbe with SMTP id
 38308e7fff4ca-3002f8e73d7mr21813901fa.15.1733509493233; Fri, 06 Dec 2024
 10:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com> <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com>
In-Reply-To: <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 19:24:16 +0100
Message-ID: <CAP01T76V_xobHtcUNjZgoZruGH474b1ZcUc-g3SYwExmYwGHYA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, kkd@meta.com, Manu Bretelle <chantra@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 19:15, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2024-12-06 at 09:59 -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > An implication of this fix, which follows from the way the raw_tp fix=
es
> > > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID ar=
e
> > > engulfed by these checks, and PROBE_MEM will apply to all of them, in=
cl.
> > > those coming from helpers with KF_ACQUIRE returning maybe null truste=
d
> > > pointers. This NULL tagging after this commit will be sticky. Compare=
d
> > > to a solution which only specially tagged raw_tp args with a differen=
t
> > > special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> > > overloading PTR_MAYBE_NULL with this meaning.
> > >
> > > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"=
)
> > > Reported-by: Manu Bretelle <chantra@meta.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 82f40d63ad7b..556fb609d4a4 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_=
verifier_env *env,
> > >                         return;
> > >
> > >                 if (is_null) {
> > > +                       /* We never mark a raw_tp trusted pointer as =
scalar, to
> > > +                        * preserve backwards compatibility, instead =
just leave
> > > +                        * it as is.
> > > +                        */
> > > +                       if (mask_raw_tp_reg_cond(env, reg))
> > > +                               return;
> >
> > The blast radius is getting too big.
> > Patch 1 is ok, but here we're doubling down on
> > the hack in commit
> > cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> >
> > I think we need to revert the raw_tp masking hack and
> > go with denylist the way Jiri proposed:
> > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
> >
> > denylist is certainly less safer and it's a whack-a-mole
> > comparing to allowlist, but it's much much shorter
> > according to Jiri's analysis:
> > https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/
> >
> > Eduard had an idea how to auto generate such allow/denylist
> > during the build.
> > That could be a follow up.
>
> If the sole goal is to avoid dead code elimination for tracepoint
> parameter null check, there might be another hack. Not sure if it was
> discussed:
> - don't add PTR_MAYBE_NULL (but maybe add a new tag, PTR_SOFT_NULL
>   from Kumar's original RFC);
> - in is_branch_taken() don't predict anything when tracepoint
>   parameters are compared;
> - in mark_ptr_or_null_regs() don't propagate null for pointers to
>   tracepoint parameters (as in this patch).

That was pretty much the first attempt with a soft null tag, it was a
special tag indicating provenance of the argument, so it only applied
to raw_tp args. I was trying to warn when being passed into helpers
and kfuncs too, but that needs a more complete fix anyway (with
PTR_TO_BTF_ID...) so we decided to address it later.

But at this point I think we'll keep digging ourselves into a deeper
hole the more we try to address it this way.
I think the various issues, breakage, and corner cases are evidence
this is probably not a good approach to take.

Longer term we have to do explicit annotations and know when it is
NULL and not NULL, so it is probably better to bite the bullet now and
do it explicitly.
Once we denylist or handle the ones Jiri found, we can keep discussing
how to keep the list up to date.


>
> Seems pretty confined but can't catch nullable tracepoint parameters
> being passed to kfuncs.
>

