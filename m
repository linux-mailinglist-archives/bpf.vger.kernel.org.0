Return-Path: <bpf+bounces-16645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C880414A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766FD1F212C5
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23839FFC;
	Mon,  4 Dec 2023 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEPwZ+1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0617189
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 14:05:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1975fe7befso529566866b.2
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701727548; x=1702332348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDEK0V5tqlrmP9wTLYaiV5yLVMZcaOnLxHEVgLYnK3c=;
        b=jEPwZ+1Ffu2jj2oDBBdswoT3WyGoJzBhIi4B6vTOPWUXNNzGX10uFavjp782xka8zU
         1jpgy5ZKAxYv5BITZFUanHwfIeShYoz7IygAcbGtHx49xN9EpoUd3jJA8ev1iXpThuC1
         zjG8rZDqIOn9JUz9+8/nUnj0qOza+j8RivvHXb0BAVSPQr+DX77A+R08EghQzLCrrBcd
         oZmQKL7WQwII2Bfzg8sXuf6HSnkELEbpX16oHqawJkXS6fMwMKqwjGfw9P7P9kSYpC5v
         nao8WnUe1W4dbKtQi3MliQfTxhp9TdH7eMNUJLldz3N5gdK+CwytoB6Wqo+2zk3IAPPY
         sssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727548; x=1702332348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDEK0V5tqlrmP9wTLYaiV5yLVMZcaOnLxHEVgLYnK3c=;
        b=ihYkoR+FztmClINNuGtHQJ5QKwCPEhEljk5X2gG9IpZRUYpa2DzjBmmd/H1fkkKPTQ
         Gd7bzFZrjUzLeLg3WSKQF1lKJXh1S0haS6pxptROnG3oEwBie5VWK/CZlYedo6VZpoiJ
         SbSzfCTevvh4KN2o/ndW7SqbGRMGPepWGkCy2IRIHCrJAZL6wmPv0b0Hd2X3pMvUnnB7
         ymSUYGKNuUPcB29msc7XuzxbggCYUhrUYXdGMOr8XPs9ZMk9B8mWEyUpuTRpefGGlxPB
         8+wRP+/JJKvllAxNuYmwkXcPWAbpPc/UOI70roV4jOryi1k7yZoPi6ppGW8cZSN8nmvb
         ObvQ==
X-Gm-Message-State: AOJu0Yw6DgpFmoIVphtEoBfuWkV/wF6/0FS2TNhWjdN+1xY17YUmSTqX
	g4j4NlcBkmjswy9VUyXt2HISCFpKvZHBjv5eTUA=
X-Google-Smtp-Source: AGHT+IGaZO0Q/ZxVYdC/TF1TO4pUR043ZyzH8p4o1gruDNPhhDPvNeam+OfXbgA9PxZozXtwGs7Bzx7DrLNl+iKDWK8=
X-Received: by 2002:a17:906:204:b0:a19:720c:ed66 with SMTP id
 4-20020a170906020400b00a19720ced66mr2976136ejd.23.1701727547818; Mon, 04 Dec
 2023 14:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com> <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
In-Reply-To: <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 14:05:34 -0800
Message-ID: <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:52=E2=80=AFAM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> [...]
>
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index af2819d5c8ee..b646bdde09cd 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6816,10 +6816,9 @@ static int check_stack_access_within_bounds(
> > >                         return -EACCES;
> > >                 }
> > >                 min_off =3D reg->smin_value + off;
> > > +               max_off =3D reg->smax_value + off;
> > >                 if (access_size > 0)
> > > -                       max_off =3D reg->smax_value + off + access_si=
ze - 1;
> > > -               else
> > > -                       max_off =3D min_off;
> > > +                       max_off +=3D access_size - 1;
> >
> > this special casing of access_size =3D=3D 0 feels wrong (and I mean bef=
ore
> > your patch as well).
> >
> > Looking at the code, we only really calculate max_off to check that we
> > don't go to a non-negative stack offset, e.g., r10+0 or r10+1 (and
> > beyond).
> >
> > So given that, I propose to calculate max_off as an exclusive bound,
> > and instead of doing a mostly useless check_stack_slot_within_bounds()
> > call for it, just check that max_off is <=3D 0.
> >
> > Something like this:
> >
> > min_off =3D reg->smin_value + off;
> > max_off =3D reg->smax_value + off + access_size;
> > err =3D check_stack_slot_within_bounds(min_off, state, type);
> > if (!err && max_off > 0)
> >     err =3D -EINVAL; /* out of stack access into non-negative offsets *=
/
>
> Dealing with access_size =3D=3D 0 indeed feels dubious to me, but I'm not=
 entirely
> sure that your suggested code is better. min_off being inclusive and
> max_off being
> exclusive seems surprising. I'll do it if you want, I don't care too much=
.
> We could keep max_off exclusive, and still not call
> check_stack_slot_within_bounds() for it:
>
>  min_off =3D reg->smin_value + off;
>  max_off =3D reg->smax_value + off + access_size - 1;
>  err =3D check_stack_slot_within_bounds(min_off, state, type);
>  if (!err && max_off >=3D 0)
>      err =3D -EINVAL; /* out of stack access into non-negative offsets */
>

Yeah, we can do that. The reason I go for max_off being exclusive is
because using half-opened ranges is very convenient [start, end) (end
exclusive) is much more uniform and natural to handle compared to
closed [start, end] (end inclusive), in all sorts of checks, including
handling empty ranges. The math just works out better and more
naturally. And it's not like this will be the first time where in BPF
we have half-open ranges.

> But now max_off can be below min_off, which again seems confusing.

That's ok, the point here is to validate that we don't access stack
out of bounds.

>
> What I'd really like to know is whether this whole zero access_size busin=
ess
> deserves to exist. Do you know what the point of verifying a zero-sized a=
ccess
> is exactly / could we turn 0-byte access into 1-byte accesses and
> verify that instead?
> Because then there'd be no more special case to consider.
>


I think zero is a natural case that can come up, at least with
helpers. As we have ARG_CONST_SIZE_OR_ZERO. So yeah, I wouldn't treat
zero-sized access as 1-byte access, that seems to be more confusing
and potentially broken.

> >
> >
> > Now, one more issue that jumped out at me is that we calculate min/max
> > off as a sum of smin/smax values (which are checked to be within
> > +/-1<<29, all good so far) *and* insn->off, which can be a full s32,
> > it seems. So we are running into overflow/underflow territory with
> > using int for min_off/max_off.
> >
> > While you are at it, can you please use s64 for all these calculations?=
 Thanks!
> >
> >
> > >         }
> > >
> > >         err =3D check_stack_slot_within_bounds(min_off, state, type);
>
> Will do.

