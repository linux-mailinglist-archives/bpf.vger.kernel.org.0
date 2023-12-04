Return-Path: <bpf+bounces-16671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F38042FD
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C452E2813A8
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785F3B7A8;
	Mon,  4 Dec 2023 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfOOk2/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5A129
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:59:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a184d717de1so688925066b.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701734343; x=1702339143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPgou9vD0tKvAxW1dRyorH2kvaOsLo7T8wI0brMMyPg=;
        b=LfOOk2/+Z/6An9MxSGYv1VtWGgWzGg5+B1X/oSyhuxoRDIIFxlzMyAIzTmtpl1KJXl
         /35lQJOg0RmXoDzo+PvsiLZgePaFkIfl4Pd1vTGIWDC1mp+GP9+fGcj+Umyl680r5LF5
         I+lYU5yxA8kL2/F605YbcvYcSamgDHG0tc4sLnR8C8218ZzPvq8Bi7G4pYoKukYhAloQ
         EqMv701ccw0pOXWaLN6E20q4t+Cl6L9BChlPzaoNFqPR/str7BxHwkYIrSUUntYXJh7E
         GDU71SXDIyrjcIQxZVV560/MS58Y7t8lVYwOLfLY8xA4lnMXR5HvZwwoaj8EtXK6Tx3Z
         1lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734343; x=1702339143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPgou9vD0tKvAxW1dRyorH2kvaOsLo7T8wI0brMMyPg=;
        b=MIsxojrTPZNZNH/E3GbvhjnweF4KeSkXCLjH+FHayHGvIIx+9UVXFreDiQLN44jbF5
         W7S5QUMhLbZlplzV6OODB8ZujDMR8phWCHgJB318W9RCx9KlR96HO5qmsAkHzuxLqph1
         iy0Ye/WyPaZ9HoN31yCiBt8jvB8A7LjRRx6NVcv1lutElgMdiH45zKUyAa6+xptyL6Ud
         ZbD9Mp/sjP+0LxUovkj6G7CUHzOtyYyOMjdsMapr1iKMNZgmXFdWYphxoTjyzW4X94X3
         qmJYXbJJkm+WQ9F5jd0k9sq1wnTdVIkVfGJxH1TadK5d8X6n9LR6JYYZptYHm0M7+PFe
         RqtA==
X-Gm-Message-State: AOJu0YzdlpgDXxHG+fyDMDRL3ZE9W9P/cMHrLhJOlq3tz2tM/pGaVan1
	R6/JlO4IKUhWe4S37mAyRcyl2Nobx/nd8vSdjKtVvOYKrWA=
X-Google-Smtp-Source: AGHT+IECVmEysWl3mGZdWNhCZ0kf7SNhN9EyEKa0hZjTYd1o0QqjzXjjo7fcLShReZn09rp5NFGnM2ktOe4MsQ7vgUA=
X-Received: by 2002:a17:906:378a:b0:a19:a19b:4235 with SMTP id
 n10-20020a170906378a00b00a19a19b4235mr2383143ejc.160.1701734342498; Mon, 04
 Dec 2023 15:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
 <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com> <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
In-Reply-To: <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 15:58:50 -0800
Message-ID: <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:28=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> On Mon, Dec 4, 2023 at 5:05=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Dec 4, 2023 at 11:52=E2=80=AFAM Andrei Matei <andreimatei1@gmai=
l.com> wrote:
> > >
> > > [...]
> > >
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index af2819d5c8ee..b646bdde09cd 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bound=
s(
> > > > >                         return -EACCES;
> > > > >                 }
> > > > >                 min_off =3D reg->smin_value + off;
> > > > > +               max_off =3D reg->smax_value + off;
> > > > >                 if (access_size > 0)
> > > > > -                       max_off =3D reg->smax_value + off + acces=
s_size - 1;
> > > > > -               else
> > > > > -                       max_off =3D min_off;
> > > > > +                       max_off +=3D access_size - 1;
> > > >
> > > > this special casing of access_size =3D=3D 0 feels wrong (and I mean=
 before
> > > > your patch as well).
> > > >
> > > > Looking at the code, we only really calculate max_off to check that=
 we
> > > > don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (and
> > > > beyond).
> > > >
> > > > So given that, I propose to calculate max_off as an exclusive bound=
,
> > > > and instead of doing a mostly useless check_stack_slot_within_bound=
s()
> > > > call for it, just check that max_off is <=3D 0.
> > > >
> > > > Something like this:
> > > >
> > > > min_off =3D reg->smin_value + off;
> > > > max_off =3D reg->smax_value + off + access_size;
> > > > err =3D check_stack_slot_within_bounds(min_off, state, type);
> > > > if (!err && max_off > 0)
> > > >     err =3D -EINVAL; /* out of stack access into non-negative offse=
ts */
> > >
> > > Dealing with access_size =3D=3D 0 indeed feels dubious to me, but I'm=
 not entirely
> > > sure that your suggested code is better. min_off being inclusive and
> > > max_off being
> > > exclusive seems surprising. I'll do it if you want, I don't care too =
much.
> > > We could keep max_off exclusive, and still not call
> > > check_stack_slot_within_bounds() for it:
> > >
> > >  min_off =3D reg->smin_value + off;
> > >  max_off =3D reg->smax_value + off + access_size - 1;
> > >  err =3D check_stack_slot_within_bounds(min_off, state, type);
> > >  if (!err && max_off >=3D 0)
> > >      err =3D -EINVAL; /* out of stack access into non-negative offset=
s */
> > >
> >
> > Yeah, we can do that. The reason I go for max_off being exclusive is
> > because using half-opened ranges is very convenient [start, end) (end
> > exclusive) is much more uniform and natural to handle compared to
> > closed [start, end] (end inclusive), in all sorts of checks, including
> > handling empty ranges. The math just works out better and more
> > naturally. And it's not like this will be the first time where in BPF
> > we have half-open ranges.
>
> Yeah, after hitting send, I was also thinking that half-open is the more =
common
> interval representation; it just wasn't how this code right here was writ=
ten.
> Will do.
>
> >
> > > But now max_off can be below min_off, which again seems confusing.
> >
> > That's ok, the point here is to validate that we don't access stack
> > out of bounds.
> >
> > >
> > > What I'd really like to know is whether this whole zero access_size b=
usiness
> > > deserves to exist. Do you know what the point of verifying a zero-siz=
ed access
> > > is exactly / could we turn 0-byte access into 1-byte accesses and
> > > verify that instead?
> > > Because then there'd be no more special case to consider.
> > >
> >
> >
> > I think zero is a natural case that can come up, at least with
> > helpers. As we have ARG_CONST_SIZE_OR_ZERO. So yeah, I wouldn't treat
> > zero-sized access as 1-byte access, that seems to be more confusing
> > and potentially broken.
>
> Ack. Still, if you don't mind entertaining me further, two more questions=
:
>
> 1. What do you make of the code in check_mem_size_reg() [1] where we do
>
> if (reg->umin_value =3D=3D 0) {
>   err =3D check_helper_mem_access(env, regno - 1, 0,
>         zero_size_allowed,
>         meta);
>
> followed by
>
> err =3D check_helper_mem_access(env, regno - 1,
>       reg->umax_value,
>       zero_size_allowed, meta);
>
> [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c040fc=
c36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
>
> What's the point of the first check_helper_mem_access() call - the
> zero-sized one
> (given that we also have the second, broader, check)? Could it be
> simply replaced by a
>
> if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
>     err =3D no_bueno;
>

Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exactly
this, and kind of similar to the min_off/max_off discussion we had. So
yes, I suspect the above simple and straightforward check would be
much more meaningful and targeted.

I gotta say that the reg->smin_value < 0 check is confusing, though,
I'm not sure why we are mixing smin and umin/umax in this change...

> ?
>
> 2. I believe you're saying that, if we were to verify zero-sized
> accesses as 1-byte-sized accesses, we
> might refuse some accesses that we permit today, and that wouldn't be
> good. But what about
> permitting zero-sized accesses with no further checks - i.e.
> considering *any* pointer value to
> be ok when the access_size =3D=3D 0 ? Would that be bad? The question is,
> morally, what checks are
> important (if any) when the size of access is zero?
> Or to phrase another way - when a helper is called with a zero access
> size, do we expect the helper
> to do anything with that pointer, or do we expect the helper to be a no-o=
p?

Helper itself might not be a no-op, but it should not write back to
that pointer for sure. But I'd hate to have more special casing for
zero-size read/write than necessary. So if we can structure the logic
in a way that zero is a natural extension, I'd do that.

>
> Thank you!
>
>
> >
> > > >
> > > >
> > > > Now, one more issue that jumped out at me is that we calculate min/=
max
> > > > off as a sum of smin/smax values (which are checked to be within
> > > > +/-1<<29, all good so far) *and* insn->off, which can be a full s32=
,
> > > > it seems. So we are running into overflow/underflow territory with
> > > > using int for min_off/max_off.
> > > >
> > > > While you are at it, can you please use s64 for all these calculati=
ons? Thanks!
> > > >
> > > >
> > > > >         }
> > > > >
> > > > >         err =3D check_stack_slot_within_bounds(min_off, state, ty=
pe);
> > >
> > > Will do.

