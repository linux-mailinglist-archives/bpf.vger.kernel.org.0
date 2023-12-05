Return-Path: <bpf+bounces-16675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9B80437E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D27A1F2137A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6EEA3;
	Tue,  5 Dec 2023 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkD53KvI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2A3AC
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 16:38:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b5155e154so53862305e9.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701736701; x=1702341501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkq+xBfiu8RobWaYKeSKpzAMU3GGQnBSqiJlY5WXGDs=;
        b=CkD53KvIyy+HRIYGogXwBNCGeHDEtD/wSsoGCXf7pqeAlA9PpV9dWDZ9RULOANzX5w
         xoEl7XUfsFhsmeJWxMamErLtZ8Ee09LDkBF21Bvh46UndVMHU+BEOc4mrcEu/orCXrhM
         8BOPP3RqqAJbJQXVJO3+9mEI66z2/vt8461LdJFPl2GgQPJ20dtOg7KW49guLf+isLvB
         CkAv3MJIdPvq/u7niyz+I2zkwxSnyIZnHSibb3egoIVYYoxuUDH3CZM0JhxEaB3dbtWn
         D/m21V7U9iGgdhI5tVq1maBiMRfMJeUwLJ3VmqoAJ6JE/Ix3UMXh0QasxJtC3MSkBIs+
         yNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701736701; x=1702341501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkq+xBfiu8RobWaYKeSKpzAMU3GGQnBSqiJlY5WXGDs=;
        b=N9TVjryOGTew0lgxpUGy/uMpgJiWtTzBb7eTtHhrjR8Ti6P7Cg6ajvD6BJ95KGVPm9
         0nL6rSM/hdWdnpJE2qmOBPHG/0gtiTqoicL3XCD3AQfFdRNcFMftcgRkMRnaeT0y3owU
         WuHiVDg5QzjeWUGL/pVtB5Gc3O0KGSYM/T2lTU4GSGGzgUTVxYcjsVpdE1cWwDU1npjR
         n8SL2rzmk8bgpd9PzlBpa4HRcY+xYB8bn2WQpGBkbixWdaUKfAtxRbYaPVLdTMBtBAFW
         J7EFFZDOt2jBJ2al7yP4ACcS6I+H6gvdK+UgCCFc3lflN2uhjwAeJSFzEcjxQkJItlPV
         K72w==
X-Gm-Message-State: AOJu0YyogdqsMiORO9RkeGxrxx2H1YpXSbViQJVKwC639sn6yFneVdUI
	0AhZPX6NWYmlT+56a/83P+IfdJ6GhYjRLDBYbjg=
X-Google-Smtp-Source: AGHT+IGlh+XOuu8tISj63QCwk/Y9bmjsMjCIemnJe8VPURNqpSpC4PV7RqPDt2UWjE5CZVdaaZ8Rpx+Bz76JNJIDEcs=
X-Received: by 2002:a05:600c:2215:b0:40c:873:c93f with SMTP id
 z21-20020a05600c221500b0040c0873c93fmr1487873wml.167.1701736700333; Mon, 04
 Dec 2023 16:38:20 -0800 (PST)
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
 <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com> <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 4 Dec 2023 19:38:08 -0500
Message-ID: <CABWLsesLHdMx65nq37ExsRuxjxfiJe3CHYFBxavmjCFr9KUdnQ@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 6:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 3:28=E2=80=AFPM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
> >
> > On Mon, Dec 4, 2023 at 5:05=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Dec 4, 2023 at 11:52=E2=80=AFAM Andrei Matei <andreimatei1@gm=
ail.com> wrote:
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index af2819d5c8ee..b646bdde09cd 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bou=
nds(
> > > > > >                         return -EACCES;
> > > > > >                 }
> > > > > >                 min_off =3D reg->smin_value + off;
> > > > > > +               max_off =3D reg->smax_value + off;
> > > > > >                 if (access_size > 0)
> > > > > > -                       max_off =3D reg->smax_value + off + acc=
ess_size - 1;
> > > > > > -               else
> > > > > > -                       max_off =3D min_off;
> > > > > > +                       max_off +=3D access_size - 1;
> > > > >
> > > > > this special casing of access_size =3D=3D 0 feels wrong (and I me=
an before
> > > > > your patch as well).
> > > > >
> > > > > Looking at the code, we only really calculate max_off to check th=
at we
> > > > > don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (an=
d
> > > > > beyond).
> > > > >
> > > > > So given that, I propose to calculate max_off as an exclusive bou=
nd,
> > > > > and instead of doing a mostly useless check_stack_slot_within_bou=
nds()
> > > > > call for it, just check that max_off is <=3D 0.
> > > > >
> > > > > Something like this:
> > > > >
> > > > > min_off =3D reg->smin_value + off;
> > > > > max_off =3D reg->smax_value + off + access_size;
> > > > > err =3D check_stack_slot_within_bounds(min_off, state, type);
> > > > > if (!err && max_off > 0)
> > > > >     err =3D -EINVAL; /* out of stack access into non-negative off=
sets */
> > > >
> > > > Dealing with access_size =3D=3D 0 indeed feels dubious to me, but I=
'm not entirely
> > > > sure that your suggested code is better. min_off being inclusive an=
d
> > > > max_off being
> > > > exclusive seems surprising. I'll do it if you want, I don't care to=
o much.
> > > > We could keep max_off exclusive, and still not call
> > > > check_stack_slot_within_bounds() for it:
> > > >
> > > >  min_off =3D reg->smin_value + off;
> > > >  max_off =3D reg->smax_value + off + access_size - 1;
> > > >  err =3D check_stack_slot_within_bounds(min_off, state, type);
> > > >  if (!err && max_off >=3D 0)
> > > >      err =3D -EINVAL; /* out of stack access into non-negative offs=
ets */
> > > >
> > >
> > > Yeah, we can do that. The reason I go for max_off being exclusive is
> > > because using half-opened ranges is very convenient [start, end) (end
> > > exclusive) is much more uniform and natural to handle compared to
> > > closed [start, end] (end inclusive), in all sorts of checks, includin=
g
> > > handling empty ranges. The math just works out better and more
> > > naturally. And it's not like this will be the first time where in BPF
> > > we have half-open ranges.
> >
> > Yeah, after hitting send, I was also thinking that half-open is the mor=
e common
> > interval representation; it just wasn't how this code right here was wr=
itten.
> > Will do.
> >
> > >
> > > > But now max_off can be below min_off, which again seems confusing.
> > >
> > > That's ok, the point here is to validate that we don't access stack
> > > out of bounds.
> > >
> > > >
> > > > What I'd really like to know is whether this whole zero access_size=
 business
> > > > deserves to exist. Do you know what the point of verifying a zero-s=
ized access
> > > > is exactly / could we turn 0-byte access into 1-byte accesses and
> > > > verify that instead?
> > > > Because then there'd be no more special case to consider.
> > > >
> > >
> > >
> > > I think zero is a natural case that can come up, at least with
> > > helpers. As we have ARG_CONST_SIZE_OR_ZERO. So yeah, I wouldn't treat
> > > zero-sized access as 1-byte access, that seems to be more confusing
> > > and potentially broken.
> >
> > Ack. Still, if you don't mind entertaining me further, two more questio=
ns:
> >
> > 1. What do you make of the code in check_mem_size_reg() [1] where we do
> >
> > if (reg->umin_value =3D=3D 0) {
> >   err =3D check_helper_mem_access(env, regno - 1, 0,
> >         zero_size_allowed,
> >         meta);
> >
> > followed by
> >
> > err =3D check_helper_mem_access(env, regno - 1,
> >       reg->umax_value,
> >       zero_size_allowed, meta);
> >
> > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c040=
fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> >
> > What's the point of the first check_helper_mem_access() call - the
> > zero-sized one
> > (given that we also have the second, broader, check)? Could it be
> > simply replaced by a
> >
> > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> >     err =3D no_bueno;
> >
>
> Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exactly
> this, and kind of similar to the min_off/max_off discussion we had. So
> yes, I suspect the above simple and straightforward check would be
> much more meaningful and targeted.
>
> I gotta say that the reg->smin_value < 0 check is confusing, though,
> I'm not sure why we are mixing smin and umin/umax in this change...
>
> > ?
> >
> > 2. I believe you're saying that, if we were to verify zero-sized
> > accesses as 1-byte-sized accesses, we
> > might refuse some accesses that we permit today, and that wouldn't be
> > good. But what about
> > permitting zero-sized accesses with no further checks - i.e.
> > considering *any* pointer value to
> > be ok when the access_size =3D=3D 0 ? Would that be bad? The question i=
s,
> > morally, what checks are
> > important (if any) when the size of access is zero?
> > Or to phrase another way - when a helper is called with a zero access
> > size, do we expect the helper
> > to do anything with that pointer, or do we expect the helper to be a no=
-op?
>
> Helper itself might not be a no-op, but it should not write back to
> that pointer for sure. But I'd hate to have more special casing for
> zero-size read/write than necessary. So if we can structure the logic
> in a way that zero is a natural extension, I'd do that.

Well but the thing is, the way I see it, we *currently* have a lot of
special casing for
zero access_size - we carry this zero_sized_allowed argument to a
bunch of places.
So I was thinking that maybe we could get rid of all that by terminating
the verification of zero sized access in check_helper_mem_access() --
if access_size =3D=3D 0, either return an error if !zero_sized_allowed,
otherwise return
success with no further verification.

>
> >
> > Thank you!
> >
> >
> > >
> > > > >
> > > > >
> > > > > Now, one more issue that jumped out at me is that we calculate mi=
n/max
> > > > > off as a sum of smin/smax values (which are checked to be within
> > > > > +/-1<<29, all good so far) *and* insn->off, which can be a full s=
32,
> > > > > it seems. So we are running into overflow/underflow territory wit=
h
> > > > > using int for min_off/max_off.
> > > > >
> > > > > While you are at it, can you please use s64 for all these calcula=
tions? Thanks!
> > > > >
> > > > >
> > > > > >         }
> > > > > >
> > > > > >         err =3D check_stack_slot_within_bounds(min_off, state, =
type);
> > > >
> > > > Will do.

