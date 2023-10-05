Return-Path: <bpf+bounces-11437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FE7B9D4E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 99C9E281D5B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68601B297;
	Thu,  5 Oct 2023 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX91+hxH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5B125A3
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88F7C4AF69
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696512467;
	bh=N1dE7AmjrUZ47G8HQruxm76EJR2/5jXU4d/2bgOQyD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RX91+hxHDnfAAc5JnJjtmLsXaBeaTfXs/YUeCrPgTf4rAIo1sjr/h/E6XJlq//yje
	 po8V3DDCBmjT+BZWX7BR7U1LDI3FsVSryPNucgjYQMwKZbZWGmbxAhEDxofAWop0ys
	 pD9N0E2FfXWlkmwb5UkTqrzhIcnI5wzZVVjY2tS59LbydSsnTI+AaI0haTWn13U9wR
	 GiN3LUj+Sdr+H8zvYkv7WTYhjmALEUH6LVSZVJvVOWSBTpnLEAEQEmb2ohDDfNKUgc
	 RfRHaZSSoRZSSlaUahAJobZtlEay1s5puFPuPCvOtRFTY7Mt570OGocDcTh+xw/auH
	 K5fyvD7EUlv0g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso1749508a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 06:27:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtDbzep3KLGJ99eK5tDGIb6Qoz/zmZmA4jgYS1yBWK47THaOMK
	n3rKKaKuJ0ZWJox5MeXrOoGMzxHUE8U+m/2BoLi1Wg==
X-Google-Smtp-Source: AGHT+IHFOywWEnxWs29vHFV4gq5qgGxjrrUvMtfRCD2Ccr7MKURyA9Sy2tPKeI1YA+BoW/dGxflH4GTeRjKC/Q0IIX8=
X-Received: by 2002:aa7:d588:0:b0:523:33d7:e324 with SMTP id
 r8-20020aa7d588000000b0052333d7e324mr4669372edq.38.1696512466159; Thu, 05 Oct
 2023 06:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava> <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
In-Reply-To: <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 5 Oct 2023 15:27:35 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
Message-ID: <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 3:26=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Oct 5, 2023 at 10:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:
> >
> > SNIP
> >
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index e97aeda3a86b..df9699bce372 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/bpf_verifier.h>
> > >  #include <linux/bpf_lsm.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/bpf_lsm.h>
> > >
> > >  /* dummy _ops. The verifier will operate on target program's ops. */
> > >  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> > > @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_=
tramp_link *link, struct bpf_tr
> > >  {
> > >       enum bpf_tramp_prog_type kind;
> > >       struct bpf_tramp_link *link_exiting;

I think this is a typo here. It should be existing, no?

> > > -     int err =3D 0;
> > > +     int err =3D 0, num_lsm_progs =3D 0;
> > >       int cnt =3D 0, i;
> > >
> > >       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > > @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf=
_tramp_link *link, struct bpf_tr
> > >                       continue;
> > >               /* prog already linked */
> > >               return -EBUSY;
> > > +
> > > +             if (link_exiting->link.prog->type =3D=3D BPF_PROG_TYPE_=
LSM)
> > > +                     num_lsm_progs++;
> >
> > this looks wrong, it's never reached.. seems like we should add separat=
e
> > hlist_for_each_entry loop over trampoline's links for this check/init o=
f
> > num_lsm_progs ?
> >
> > jirka
>
> Good catch, I missed this during my rebase, after
> https://lore.kernel.org/bpf/20220510205923.3206889-2-kuifeng@fb.com/
> this condition is basically never reached. I will do a general loop
> over to count LSM programs and toggle the hook to true (and same for
> unlink).
>
> - KP
>
> [...]

