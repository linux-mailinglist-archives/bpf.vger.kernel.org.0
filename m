Return-Path: <bpf+bounces-11436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140577B9D4D
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 63397281D57
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098EC1B295;
	Thu,  5 Oct 2023 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO+9Z7sl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0F125A3
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5856C4AF69
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696512380;
	bh=6mUgLSnm4Kc6OY+sFrERl85k6Jk4/7QG8hihF86ti4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UO+9Z7sl0+ubzgtjMC6tXjlhn7kW41BUU+O2FIehewxPZryW3RdQfV0Ri9zecskQc
	 RazCP8sTGYJl7howu808n9kw4yOdXFVsZFzywTl7QMtCMvIzT7pehx8FEey4erPIDp
	 guMbQ2zF1ZusUvg/tSXoGSY28UhiCRRioLCRl/l47EL7RzH1byrkwuVfV4/iXFiXcT
	 jPRPH3vmU+EV771R2yBzSxY35PDVcD0MiNGGrkFzL9NSD+qigEKEFIFhL2XHh2Gk2s
	 aS8cSrAb60bW1nW3A/QaXAwBoif67NkNFr0cZzLMZCYyjESp5OBYgzizaamPz0lUEw
	 hEcrbg2+/TEBg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so1710854a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 06:26:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YyruqNc7sAgxhPxJUHHV5AZN6IO3JzIz7i129qArAOg+dyS8geN
	Cq95aQlxGN5C6KBT6+u9u2VQEtCnVips0yZG6T6ayA==
X-Google-Smtp-Source: AGHT+IGjEoiN5sIey9XlvsLiGVpcrzObalyvIGnXglMXvNE6FLnE02Xn7KXKfKtdJpJoQEp9dBTg8bLESCIN87KN+xM=
X-Received: by 2002:a05:6402:134f:b0:532:bb18:7986 with SMTP id
 y15-20020a056402134f00b00532bb187986mr5067221edw.39.1696512379251; Thu, 05
 Oct 2023 06:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava>
In-Reply-To: <ZR5vSyyNGBb8TvNH@krava>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 5 Oct 2023 15:26:08 +0200
X-Gmail-Original-Message-ID: <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
Message-ID: <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 10:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:
>
> SNIP
>
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index e97aeda3a86b..df9699bce372 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/delay.h>
> > +#include <linux/bpf_lsm.h>
> >
> >  /* dummy _ops. The verifier will operate on target program's ops. */
> >  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> > @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tr=
amp_link *link, struct bpf_tr
> >  {
> >       enum bpf_tramp_prog_type kind;
> >       struct bpf_tramp_link *link_exiting;
> > -     int err =3D 0;
> > +     int err =3D 0, num_lsm_progs =3D 0;
> >       int cnt =3D 0, i;
> >
> >       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_t=
ramp_link *link, struct bpf_tr
> >                       continue;
> >               /* prog already linked */
> >               return -EBUSY;
> > +
> > +             if (link_exiting->link.prog->type =3D=3D BPF_PROG_TYPE_LS=
M)
> > +                     num_lsm_progs++;
>
> this looks wrong, it's never reached.. seems like we should add separate
> hlist_for_each_entry loop over trampoline's links for this check/init of
> num_lsm_progs ?
>
> jirka

Good catch, I missed this during my rebase, after
https://lore.kernel.org/bpf/20220510205923.3206889-2-kuifeng@fb.com/
this condition is basically never reached. I will do a general loop
over to count LSM programs and toggle the hook to true (and same for
unlink).

- KP

[...]

