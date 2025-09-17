Return-Path: <bpf+bounces-68709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3A0B81D89
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52651C24553
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE81277C8B;
	Wed, 17 Sep 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mor+XBOY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A82D0C6C
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142819; cv=none; b=ieLRKeGuJHbAxUhY2gSirQPwgqhomNli4UU6F70XOFnFxjyzvlkFvxfR3guPdS1eRZMbrnnoQ8i8WQqOXCNAbxQIdtHW8q9kgtnBEaY2Yn+OKavzOSQJk+1g+eeepLYxKjYlsmrfoiUleEWLqb3J7MX31e48uX3UVymwgBMgUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142819; c=relaxed/simple;
	bh=zfNwRSC2hr7WCZH/kgeNDGErdjsYMrY6wYew19pfj/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY8v43aweKiMRy5/ESaWHnsAmzLwCIJ33cYjkbmamTlItmIMM9X78kDrgKbKGIOCuwIc3TvcTPaRq+uaaETV/gbwUhfj1xOlgryLZXwbtXXIfccL6S6MW7tsN0CbQuSxZLrMeDE6+HD3O6kIgDyDWIahx/ChYAKHRw6uQXq32SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mor+XBOY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32e34f4735eso191904a91.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758142816; x=1758747616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INe0qCQ3tlR6kgjMSNcBEMbA+zEE3o+6uOpu7E7tB7A=;
        b=Mor+XBOY9ptXGAQYQ69WKjP5lE61BTq6w4HiJOTu4SAIgI/DrtBu2CYSJvbjjaJsEy
         fbUkSYLhJBwP0IiHmSB9WDJ4IySD3M6ZSp+OrfceZZNmFHtLyuJKNCFSzaOPnWdwfKgp
         UejpEJVkqqRc4tmXXPnawkDbbirUAT0vuRz3Jq8rap6gvCPdA/HiAACac73nQ7ktcHoQ
         Pn6mJrF9xye5Aa8yk3z06fUkWXcBVi5ZVw/hrNNF6csCsy5DiIE/cgpugQxb+pzcJcsq
         Pa+Zx2CKBKN58pYej6FaC6gvV12HBrBqaN+zTKl212F1AHnVqHNA5y3YXX/tPrHMYDr2
         /Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142816; x=1758747616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INe0qCQ3tlR6kgjMSNcBEMbA+zEE3o+6uOpu7E7tB7A=;
        b=VTjqm1vf6wq5BvE7YhI4jy9c5XapgyTuhBhEx19LdhPVSFNbkSB1lrWURauoeOKBAb
         x2/KCG/iNAu+IKIxDjh9mK13AUvIjcC2Jl0gDuCbXCHUA1nbVGWCIZZbURYVWc9gNRIn
         b5PMiscFToO9+VFaF/M2RDEYh24szvBd09BUTDkCZEylXUKResTyMiyYaeD1bHv1qkUg
         CcZlAl3Rqki7NHVB8rSnFO5WvXSct9Et1lJfOg2KLn1lyZ63vGQaz6Eb1o+yCJdhsjaC
         bluF++Qk8Lk8LiOGGXrCVJjgWBw8/Jjei3DTMkiLk/I/s8IF96IOcf3pczjJMiQp3gTv
         7c5g==
X-Forwarded-Encrypted: i=1; AJvYcCWVRahnyNo0dB2UIc2qbjOti1vgTaziipusRZT9GGKHzRjT4QHKbgRGJaTsvp7+lA32EFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8uX3QcwO/9RPQG4RoCFCh58aPhN0mj9cfTf8NOSovzJGddYF
	aMqQ3lPk2G9eRlpcA3Kaeqd+dIUPjr1whtq22+02Dfl1VL+S0uIyKZVV8kU0gyAj9Qd1ARO7lfn
	F03pBlUla/d5baaYwTpskNKru5nf3u1s=
X-Gm-Gg: ASbGnctp4q4CJqK6sDP+ziJgKGZj1A9DBh2P3FmgtbgrwPqTQhjprn1mBrvRWk8J5pI
	bwcIeouvp1UKh0+gY5sCb/PXa4+QuOCt8iwKb7kAGa1Ul3FBVhCFD2MALzJeSeJbUfRAWmNY+kR
	tDEzrquP/WDdT9vQK2XfRQkJEWmr8hOVxuEMkSMvelo8DYrNHQ5IFA2GLZ7cAnffyWksn2h7Bv1
	RjV6U4Q7zt1mBdBJ9FlmoHeZa8QVtWfOA==
X-Google-Smtp-Source: AGHT+IFxq1VQtFeyA1l57OVybXGRuDi6kUk+l9dv55Nhpk548RUa508nI9pnyps23QBuJ7V4FJmn8X0y7r+Cqs2vcks=
X-Received: by 2002:a17:90b:2787:b0:32e:749d:fcc3 with SMTP id
 98e67ed59e1d1-32ee3ec58bdmr3963627a91.1.1758142816375; Wed, 17 Sep 2025
 14:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917034732.1185429-1-chen.dylane@linux.dev>
 <20250917034732.1185429-2-chen.dylane@linux.dev> <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
In-Reply-To: <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 14:00:04 -0700
X-Gm-Features: AS18NWCB_PJ_0Rz6o0xAh3-HjaWH7SpgF3ns55lingyjoH0ZWTa0WmVtZ8959vk
Message-ID: <CAEf4BzY3CiVLce-pB9yevsUqFZexbno+AX1j4mGYN1G+JVO+pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Fix UAF in get_delegate_value
To: Quentin Monnet <qmo@kernel.org>
Cc: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:30=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2025-09-17 11:47 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> > The return value ret pointer is pointing opts_copy, but opts_copy
> > gets freed in get_delegate_value before return, fix this by free
> > the mntent->mnt_opts strdup memory after show delegate value.
> >
> > Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  tools/bpf/bpftool/token.c | 75 +++++++++++++++++----------------------
> >  1 file changed, 33 insertions(+), 42 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> > index 82b829e44c8..05bc76c7276 100644
> > --- a/tools/bpf/bpftool/token.c
> > +++ b/tools/bpf/bpftool/token.c
> > @@ -28,15 +28,14 @@ static bool has_delegate_options(const char *mnt_op=
s)
> >              strstr(mnt_ops, "delegate_attachs");
> >  }
> >
> > -static char *get_delegate_value(const char *opts, const char *key)
> > +static char *get_delegate_value(char *opts, const char *key)
> >  {
> >       char *token, *rest, *ret =3D NULL;
> > -     char *opts_copy =3D strdup(opts);
> >
> > -     if (!opts_copy)
> > +     if (!opts)
> >               return NULL;
> >
> > -     for (token =3D strtok_r(opts_copy, ",", &rest); token;
> > +     for (token =3D strtok_r(opts, ",", &rest); token;
> >                       token =3D strtok_r(NULL, ",", &rest)) {
> >               if (strncmp(token, key, strlen(key)) =3D=3D 0 &&
> >                   token[strlen(key)] =3D=3D '=3D') {
> > @@ -44,24 +43,19 @@ static char *get_delegate_value(const char *opts, c=
onst char *key)
> >                       break;
> >               }
> >       }
> > -     free(opts_copy);
> >
> >       return ret;
> >  }
> >
> > -static void print_items_per_line(const char *input, int items_per_line=
)
> > +static void print_items_per_line(char *input, int items_per_line)
> >  {
> > -     char *str, *rest, *strs;
> > +     char *str, *rest;
> >       int cnt =3D 0;
> >
> >       if (!input)
> >               return;
> >
> > -     strs =3D strdup(input);
> > -     if (!strs)
> > -             return;
> > -
> > -     for (str =3D strtok_r(strs, ":", &rest); str;
> > +     for (str =3D strtok_r(input, ":", &rest); str;
> >                       str =3D strtok_r(NULL, ":", &rest)) {
> >               if (cnt % items_per_line =3D=3D 0)
> >                       printf("\n\t  ");
> > @@ -69,38 +63,39 @@ static void print_items_per_line(const char *input,=
 int items_per_line)
> >               printf("%-20s", str);
> >               cnt++;
> >       }
> > -
> > -     free(strs);
> >  }
> >
> > +#define PRINT_DELEGATE_OPT(opt_name) do {            \
> > +     char *opts, *value;                             \
> > +     opts =3D strdup(mntent->mnt_opts);                \
> > +     value =3D get_delegate_value(opts, opt_name);     \
> > +     print_items_per_line(value, ITEMS_PER_LINE);    \
> > +     free(opts);                                     \
> > +} while (0)
>
>
> Thanks! The fix looks OK to me, but why do you need to have
> PRINT_DELEGATE_OPT*() as macros? Can't you just use functions instead?

right, function or just a loop, that will allow to also avoid
repeating jsonw_name or printf calls:

struct { const char *header, key; } sets =3D {
    {"allowed_cmds", "delegate_cmds"},
    {"allowed_maps", "delegate_maps"},
    ...
};

for (i =3D 0; i < ARRAY_SIZE(sets); i++) {
    ... use sets[i].header and sets[i].key ...
}

pw-bot: cr

>
> Quentin

