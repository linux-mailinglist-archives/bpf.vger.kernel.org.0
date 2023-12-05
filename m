Return-Path: <bpf+bounces-16677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA91804384
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8691F2132E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F60A5A;
	Tue,  5 Dec 2023 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xek+BOTh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC44FF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 16:43:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332f90a375eso4057976f8f.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701737036; x=1702341836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqWRoxsftjff2G4mxcHnijDSL4Cqw4VYdaTsuQn9N6o=;
        b=Xek+BOThDsPe7NR5bZqkiXjutx6uYNwJwf2HWegL3PGNIF6TixbEOZkMqUvmitV6B1
         UvSu8apcku308vy/vwapR9DMobkWihQgLmVhPlIfQ53ywTzfYavD7NnAYI7mPByVDEbW
         RFBlzQPU7m84qS1NZ7sGZzSj7tYO1kSqElTrm7VIXt2tUbdl2OEbh534mH/hIE2iFgh6
         r4WXl3/jHnZr6q6XyQHYfR9qKLq4h70AdnayXdDqs3MZ9czdHG4xEFg2+1WLmporVn8Z
         CxrE/OJMUhhAn1SpyH4wGcyb+irNuF6ncunf2sB+7V6AcOxNtl/55uKul1dEtqQrTfSL
         PCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701737036; x=1702341836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqWRoxsftjff2G4mxcHnijDSL4Cqw4VYdaTsuQn9N6o=;
        b=B8HpvRp0PctNW8bjP2+XML1Hz66Jw4H8LtJe60N1NpW7BG7XVCezh/jyBfS7udNGqC
         L8Xd7xGjtKZsi5h/JN6aoIfEhyX9M11kva57AvjRnIKzSmLpDZrsfeAaG2vFFyq+NAOX
         vKfSjR37J+Olsu/RPi14ivupyiI4rHAWU/ZpS3qxOoWMIzXKN2iXqQgwxSogC11TJA73
         py1qyLwf/37JPuAr13sTxDeNJYPxqJWAQF5hO9Q9tAgyMj46Xu0OXpRSswEIacqcLJaH
         99gsTAMc4ujwzpLQ1gkb4rVIXB7IPgidWEe/ImEjEEqov9V0eaCBvYhR4u4QJqpQEFu6
         bk/g==
X-Gm-Message-State: AOJu0Yy/hjMwbwfVFvJJaiXKlrVmNvTG2Zqx2tpMAXN7D37fVgfIfXc6
	+RDcARlxiM24bEmB6Ynw29OONY3a0ordgcbbrwgm96ro
X-Google-Smtp-Source: AGHT+IEpAnY766nwKHkUg7j//RFkVcJfgOCWo7Dpi+irEUMaETn2JDDpuxaZFl9IPkThHy9DzYZghzV8pAqB07gV/M0=
X-Received: by 2002:a5d:4dca:0:b0:333:1faa:181d with SMTP id
 f10-20020a5d4dca000000b003331faa181dmr3323030wru.0.1701737036530; Mon, 04 Dec
 2023 16:43:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
 <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
 <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
 <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com> <CABWLsesLHdMx65nq37ExsRuxjxfiJe3CHYFBxavmjCFr9KUdnQ@mail.gmail.com>
In-Reply-To: <CABWLsesLHdMx65nq37ExsRuxjxfiJe3CHYFBxavmjCFr9KUdnQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 16:43:44 -0800
Message-ID: <CAEf4BzYmfc2WbjHeFFO1J-DgTDwKG-2XPnOhc3-XFs2pDVqaRw@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:38=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> On Mon, Dec 4, 2023 at 6:59=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Dec 4, 2023 at 3:28=E2=80=AFPM Andrei Matei <andreimatei1@gmail=
.com> wrote:
> > >
> > > On Mon, Dec 4, 2023 at 5:05=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 4, 2023 at 11:52=E2=80=AFAM Andrei Matei <andreimatei1@=
gmail.com> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > >
> > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > index af2819d5c8ee..b646bdde09cd 100644
> > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_b=
ounds(
> > > > > > >                         return -EACCES;
> > > > > > >                 }
> > > > > > >                 min_off =3D reg->smin_value + off;
> > > > > > > +               max_off =3D reg->smax_value + off;
> > > > > > >                 if (access_size > 0)
> > > > > > > -                       max_off =3D reg->smax_value + off + a=
ccess_size - 1;
> > > > > > > -               else
> > > > > > > -                       max_off =3D min_off;
> > > > > > > +                       max_off +=3D access_size - 1;
> > > > > >
> > > > > > this special casing of access_size =3D=3D 0 feels wrong (and I =
mean before
> > > > > > your patch as well).
> > > > > >
> > > > > > Looking at the code, we only really calculate max_off to check =
that we
> > > > > > don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (=
and
> > > > > > beyond).
> > > > > >
> > > > > > So given that, I propose to calculate max_off as an exclusive b=
ound,
> > > > > > and instead of doing a mostly useless check_stack_slot_within_b=
ounds()
> > > > > > call for it, just check that max_off is <=3D 0.
> > > > > >
> > > > > > Something like this:
> > > > > >
> > > > > > min_off =3D reg->smin_value + off;
> > > > > > max_off =3D reg->smax_value + off + access_size;
> > > > > > err =3D check_stack_slot_within_bounds(min_off, state, type);
> > > > > > if (!err && max_off > 0)
> > > > > >     err =3D -EINVAL; /* out of stack access into non-negative o=
ffsets */
> > > > >
> > > > > Dealing with access_size =3D=3D 0 indeed feels dubious to me, but=
 I'm not entirely
> > > > > sure that your suggested code is better. min_off being inclusive =
and
> > > > > max_off being
> > > > > exclusive seems surprising. I'll do it if you want, I don't care =
too much.
> > > > > We could keep max_off exclusive, and still not call
> > > > > check_stack_slot_within_bounds() for it:
> > > > >
> > > > >  min_off =3D reg->smin_value + off;
> > > > >  max_off =3D reg->smax_value + off + access_size - 1;
> > > > >  err =3D check_stack_slot_within_bounds(min_off, state, type);
> > > > >  if (!err && max_off >=3D 0)
> > > > >      err =3D -EINVAL; /* out of stack access into non-negative of=
fsets */
> > > > >
> > > >
> > > > Yeah, we can do that. The reason I go for max_off being exclusive i=
s
> > > > because using half-opened ranges is very convenient [start, end) (e=
nd
> > > > exclusive) is much more uniform and natural to handle compared to
> > > > closed [start, end] (end inclusive), in all sorts of checks, includ=
ing
> > > > handling empty ranges. The math just works out better and more
> > > > naturally. And it's not like this will be the first time where in B=
PF
> > > > we have half-open ranges.
> > >
> > > Yeah, after hitting send, I was also thinking that half-open is the m=
ore common
> > > interval representation; it just wasn't how this code right here was =
written.
> > > Will do.
> > >
> > > >
> > > > > But now max_off can be below min_off, which again seems confusing=
.
> > > >
> > > > That's ok, the point here is to validate that we don't access stack
> > > > out of bounds.
> > > >
> > > > >
> > > > > What I'd really like to know is whether this whole zero access_si=
ze business
> > > > > deserves to exist. Do you know what the point of verifying a zero=
-sized access
> > > > > is exactly / could we turn 0-byte access into 1-byte accesses and
> > > > > verify that instead?
> > > > > Because then there'd be no more special case to consider.
> > > > >
> > > >
> > > >
> > > > I think zero is a natural case that can come up, at least with
> > > > helpers. As we have ARG_CONST_SIZE_OR_ZERO. So yeah, I wouldn't tre=
at
> > > > zero-sized access as 1-byte access, that seems to be more confusing
> > > > and potentially broken.
> > >
> > > Ack. Still, if you don't mind entertaining me further, two more quest=
ions:
> > >
> > > 1. What do you make of the code in check_mem_size_reg() [1] where we =
do
> > >
> > > if (reg->umin_value =3D=3D 0) {
> > >   err =3D check_helper_mem_access(env, regno - 1, 0,
> > >         zero_size_allowed,
> > >         meta);
> > >
> > > followed by
> > >
> > > err =3D check_helper_mem_access(env, regno - 1,
> > >       reg->umax_value,
> > >       zero_size_allowed, meta);
> > >
> > > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c0=
40fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> > >
> > > What's the point of the first check_helper_mem_access() call - the
> > > zero-sized one
> > > (given that we also have the second, broader, check)? Could it be
> > > simply replaced by a
> > >
> > > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> > >     err =3D no_bueno;
> > >
> >
> > Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exactly
> > this, and kind of similar to the min_off/max_off discussion we had. So
> > yes, I suspect the above simple and straightforward check would be
> > much more meaningful and targeted.
> >
> > I gotta say that the reg->smin_value < 0 check is confusing, though,
> > I'm not sure why we are mixing smin and umin/umax in this change...
> >
> > > ?
> > >
> > > 2. I believe you're saying that, if we were to verify zero-sized
> > > accesses as 1-byte-sized accesses, we
> > > might refuse some accesses that we permit today, and that wouldn't be
> > > good. But what about
> > > permitting zero-sized accesses with no further checks - i.e.
> > > considering *any* pointer value to
> > > be ok when the access_size =3D=3D 0 ? Would that be bad? The question=
 is,
> > > morally, what checks are
> > > important (if any) when the size of access is zero?
> > > Or to phrase another way - when a helper is called with a zero access
> > > size, do we expect the helper
> > > to do anything with that pointer, or do we expect the helper to be a =
no-op?
> >
> > Helper itself might not be a no-op, but it should not write back to
> > that pointer for sure. But I'd hate to have more special casing for
> > zero-size read/write than necessary. So if we can structure the logic
> > in a way that zero is a natural extension, I'd do that.
>
> Well but the thing is, the way I see it, we *currently* have a lot of
> special casing for
> zero access_size - we carry this zero_sized_allowed argument to a
> bunch of places.
> So I was thinking that maybe we could get rid of all that by terminating
> the verification of zero sized access in check_helper_mem_access() --
> if access_size =3D=3D 0, either return an error if !zero_sized_allowed,
> otherwise return
> success with no further verification.
>

Maybe, but let's do it one step at a time. Let's fix the current
issue, supporting max_off with zero seems easy, let's do that for now?
We can have a separate patch/patch set to simplify zero size
arguments.


> >
> > >
> > > Thank you!
> > >
> > >
> > > >
> > > > > >
> > > > > >
> > > > > > Now, one more issue that jumped out at me is that we calculate =
min/max
> > > > > > off as a sum of smin/smax values (which are checked to be withi=
n
> > > > > > +/-1<<29, all good so far) *and* insn->off, which can be a full=
 s32,
> > > > > > it seems. So we are running into overflow/underflow territory w=
ith
> > > > > > using int for min_off/max_off.
> > > > > >
> > > > > > While you are at it, can you please use s64 for all these calcu=
lations? Thanks!
> > > > > >
> > > > > >
> > > > > > >         }
> > > > > > >
> > > > > > >         err =3D check_stack_slot_within_bounds(min_off, state=
, type);
> > > > >
> > > > > Will do.

