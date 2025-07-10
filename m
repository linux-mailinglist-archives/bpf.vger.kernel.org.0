Return-Path: <bpf+bounces-62885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E7AFFA38
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FE75A177E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38BE28751A;
	Thu, 10 Jul 2025 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8u36C6y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B37DDC1;
	Thu, 10 Jul 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130420; cv=none; b=u8JeImKeR5iq5nivq9JlP2eyZXPX1JMZbgKrTrYqh/Mi8I7bpxVQJBSt0K6AutxlnXh1ptHzBLUU4MBHeDnQpWcRikpYxCCmBzQUOslkDD2/tvikalIiVnDqHG19/fOHrNo3aIxiIslDuvIZC5zqFHtT6pmeieo67sQMuJOJY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130420; c=relaxed/simple;
	bh=5SxhaD6+ArJydlUaXYe93i7AbdjbLk3EREabMOXqgqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iogyl5yfgCW9drlJftdX0iXNwOmaNoKI4rpIaytaEOPjIcEvezrqGnbStf3q0EUu7XK6ljZdCziT26neWzhTrbln73aSVoasS3HpxRHOyExeNrxFLnsbDDum/hCqZM9TG8kaS6aYodCSmccvT5XXCSiSJ17J95/mobO0n4alUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8u36C6y; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e82314f9a51so547117276.0;
        Wed, 09 Jul 2025 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752130415; x=1752735215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY8CNPC3H5Bl29GqAOYedT4rum3sI914JuwR0zVdzW0=;
        b=m8u36C6y2v5Y5ph7jIvbY+T6yfJNEMRFd84K6d3UVPG9++YykWGlH/Qyi5jR/jR4j5
         X2ovYF7QCVE62UPmn3nv7Fi/WKm7nAgk8sFODbdTHUWReBL/T3R4jOB27ONZv0hpbylU
         CfK5SKepj3oEJdLRt8PuFjit9apkfCrxAIhbLs0n3PUg9Qx3Eaw3BtZthN4R8HDyyIqp
         IxD9IMV+zJ5Qxz0kXddqAyTAvAU2b8e+SSnrDcP7BcQTY+CD3muf3mXnn9j4eyCApY2e
         drllcF3vCWCQ6SAhGklZxsbOed6U9FtPqRuV80jslxNArm4ZSVZ7H3uEsyZXM1GH4TxU
         zdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752130415; x=1752735215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY8CNPC3H5Bl29GqAOYedT4rum3sI914JuwR0zVdzW0=;
        b=Dr7X8Nf3mztr+OtqoluzwxuVqwWaTfOkzKhrfExNFt5lGFdEfh9iUcZHr/SPkYjvst
         CJVqA43xve7L1vXLcbXWklSelPAa2VANeLPx++MQ0OwslzeltYeBCChGOvF9uds3OjPa
         Tbi8OoohcAVw69LW8VfbFYA8ghlkeB7sEEBWS+heK/2C4IOpxmgPtKbtiMso7igSrhBy
         0Qj3RTsIfh/DvbcZ3HtCgyna/K9DQRq0icMMR/Lc1DAM8R6FaQpIV0H58+egeai3VY20
         vuXwarUT/IR8OD2TLtGY1Fmz0TFuM6zKhfNvcbMe5V73WH8n4flmhV23UPNcZA611Way
         sQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5t97Syb8zwh/zRY7hRwtHExop0AcJzKZ4jAKnl+ieZ4dgNX68c3v7nbKGiWw2RI48yw5S1LlCiDm1FKV@vger.kernel.org, AJvYcCWWbpqsdn4pRUYg/3l/uk3ga+G4q9sax851HfjjXfDrf/KxXUGI827om5s6aWiULCATNC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojPQ1vxfPse21r7BPjmem7OLP3gIofKg9eWGtLctZbqzEXJXc
	HuMSvZQWpwlu9xDCShPMaBQ1WZ1+8WmRjLUDmp6w1oC7ja+2Sl7UMTVCZLKM5fUl4x7lIhiUukm
	Rq4W0yAqAP/zJj6cSyQI3pkTPaqZwRN0=
X-Gm-Gg: ASbGncsXQllUzt5QWrKiXnZnKJduJ2MZ7Thv8swRQMZQ98ZMR7dO589rLhvE9u1bdba
	TZ96dM9kQlinoq3Y2pmhKv+ZHRJdTQJExUA1F7ac13/j98VIUGYb77BSRtumUdoZiUNI9zK82DW
	KHG9L8t3yCW1U6iXQVpmqbXKio044lOtyQXLvZTgOV7As=
X-Google-Smtp-Source: AGHT+IEXJ7doEd7Luh8VoIG22XG9bybWCz5eKUzAILwKaFIJmnTaFpum+OaUrol6bKn+R5PjN383MqEnG9MFnqWytfY=
X-Received: by 2002:a05:690c:87:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-717b198ef8emr81715927b3.24.1752130415308; Wed, 09 Jul 2025
 23:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708072140.945296-1-dongml2@chinatelecom.cn>
 <aG4roiqyzNFOvu2R@krava> <CADxym3adDgLaoQcQZLW=-fwELDi2-HTJ6tvA+HdF97+mKDErsQ@mail.gmail.com>
 <aG5hzvaqXi7uI4GL@krava>
In-Reply-To: <aG5hzvaqXi7uI4GL@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 10 Jul 2025 14:52:33 +0800
X-Gm-Features: Ac12FXzLaOLvYbdklTvlibX5ofPdPJclR92RmCiUsSkLbmUn9xaMqTfDPTdGMLU
Message-ID: <CADxym3acrDaVsNZKFHszCUa97EHZjwg=vvd8gnNm7SEiHFD=Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: make the attach target more accurate
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Ihor Solodrai <ihor.solodrai@pm.me>, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:34=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jul 09, 2025 at 06:33:08PM +0800, Menglong Dong wrote:
> > On Wed, Jul 9, 2025 at 4:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Jul 08, 2025 at 03:21:40PM +0800, Menglong Dong wrote:
> > > > For now, we lookup the address of the attach target in
> > > > bpf_check_attach_target() with find_kallsyms_symbol_value or
> > > > kallsyms_lookup_name, which is not accurate in some cases.
> > > >
> > > > For example, we want to attach to the target "t_next", but there ar=
e
> > > > multiple symbols with the name "t_next" exist in the kallsyms. The =
one
> > > > that kallsyms_lookup_name() returned may have no ftrace record, whi=
ch
> > > > makes the attach target not available. So we want the one that has =
ftrace
> > > > record to be returned.
> > > >
> > > > Meanwhile, there may be multiple symbols with the name "t_next" in =
ftrace
> > > > record. In this case, the attach target is ambiguous, so the attach=
 should
> > > > fail.
> > >
> > > could you reproduce this somehow (bpftrace/selftest) for some symbol?
> > > I'd think pahole now filters all such symbols out of BTF and you need
> > > BTF func record to load the program in the first place
> >
> > Hi, what's the version of pahole that does such filtering? I have
> > compiled the latest pahole, and such symbols exist. The version
> > of the pahole is v1.30
> >
> > pahole --version
> > v1.30
> >
> > It can be reproduced easily, just try to attach to the symbol t_next.
> > The "t_next" has multiple definition:
> >
> > bpftrace -e 'fentry:t_next {printf("1");}'
> > Attaching 1 probe...
> > ERROR: Error attaching probe: fentry:vmlinux:t_next
> >
> > This is the symbol information of t_next:
> >
> > cat /proc/kallsyms | grep ' t_next'
> > ffffffff8142d9c0 t t_next
> > ffffffff81440e80 t t_next
> > ffffffff8144f1f0 t t_next
> > ffffffff8145ae90 t t_next
> > ffffffff81735b30 t t_next
> >
> > cat /tracing/available_filter_functions | grep '^t_next'
> > t_next
> >
> > The related patch is here:
> > https://lore.kernel.org/bpf/CADxym3Y-Jbzp0FupUgBDJB99GhsbDHyuV71Q6m9xyT=
pFze4ESg@mail.gmail.com/
> >
> > (I just distclean and rebuild the kernel, the problem still exists)
> >
>
> ah right.. I guess they all have same prototype, so the current pahole
> filter won't trigger
>
> I wonder pahole could filter out functions that have multiple instances
> with different address, because those can't be resolved properly in
> trampoline attachment
>
> or we could mitigate that in runtime with your change

Anyway, I'm going to send the V3, as this version has
problem. Then, let's see how it goes :/

>
> Alan, Ihor, any idea?
>
> thanks,
> jirka
>
>
> > Thanks!
> > Menglong Dong
> >
> > >
> > > jirka
> > >
> > >
> > > >
> > > > Introduce the function bpf_lookup_attach_addr() to do the address l=
ookup,
> > > > which is able to solve this problem.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > > v2:
> > > > - Lookup both vmlinux and modules symbols when mod is NULL, just li=
ke
> > > >   kallsyms_lookup_name().
> > > >
> > > >   If the btf is not a modules, shouldn't we lookup on the vmlinux o=
nly?
> > > >   I'm not sure if we should keep the same logic with
> > > >   kallsyms_lookup_name().
> > > >
> > > > - Return the kernel symbol that don't have ftrace location if the s=
ymbols
> > > >   with ftrace location are not available
> > > > ---
> > > >  kernel/bpf/verifier.c | 77 +++++++++++++++++++++++++++++++++++++++=
+---
> > > >  1 file changed, 72 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 53007182b46b..4bacd0abf207 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -23476,6 +23476,73 @@ static int check_non_sleepable_error_injec=
t(u32 btf_id)
> > > >       return btf_id_set_contains(&btf_non_sleepable_error_inject, b=
tf_id);
> > > >  }
> > > >
> > > > +struct symbol_lookup_ctx {
> > > > +     const char *name;
> > > > +     unsigned long addr;
> > > > +     bool ftrace_addr;
> > > > +};
> > > > +
> > > > +static int symbol_callback(void *data, unsigned long addr)
> > > > +{
> > > > +     struct symbol_lookup_ctx *ctx =3D data;
> > > > +
> > > > +     ctx->addr =3D addr;
> > > > +     if (!ftrace_location(addr))
> > > > +             return 0;
> > > > +
> > > > +     if (ctx->ftrace_addr)
> > > > +             return -EADDRNOTAVAIL;
> > > > +     ctx->ftrace_addr =3D true;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int symbol_mod_callback(void *data, const char *name, unsig=
ned long addr)
> > > > +{
> > > > +     if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) !=
=3D 0)
> > > > +             return 0;
> > > > +
> > > > +     return symbol_callback(data, addr);
> > > > +}
> > > > +
> > > > +/**
> > > > + * bpf_lookup_attach_addr: Lookup address for a symbol
> > > > + *
> > > > + * @mod: kernel module to lookup the symbol, NULL means to lookup =
both vmlinux
> > > > + * and modules symbols
> > > > + * @sym: the symbol to resolve
> > > > + * @addr: pointer to store the result
> > > > + *
> > > > + * Lookup the address of the symbol @sym. If multiple symbols with=
 the name
> > > > + * @sym exist, the one that has ftrace location is preferred. If m=
ore
> > > > + * than 1 has ftrace location, -EADDRNOTAVAIL will be returned.
> > > > + *
> > > > + * Returns: 0 on success, -errno otherwise.
> > > > + */
> > > > +static int bpf_lookup_attach_addr(const struct module *mod, const =
char *sym,
> > > > +                               unsigned long *addr)
> > > > +{
> > > > +     struct symbol_lookup_ctx ctx =3D { .addr =3D 0, .name =3D sym=
 };
> > > > +     const char *mod_name =3D NULL;
> > > > +     int err =3D 0;
> > > > +
> > > > +#ifdef CONFIG_MODULES
> > > > +     mod_name =3D mod ? mod->name : NULL;
> > > > +#endif
> > > > +     if (!mod_name)
> > > > +             err =3D kallsyms_on_each_match_symbol(symbol_callback=
, sym, &ctx);
> > > > +
> > > > +     if (!err && !ctx.addr)
> > > > +             err =3D module_kallsyms_on_each_symbol(mod_name, symb=
ol_mod_callback,
> > > > +                                                  &ctx);
> > > > +
> > > > +     if (!ctx.addr)
> > > > +             err =3D -ENOENT;
> > > > +     *addr =3D err ? 0 : ctx.addr;
> > > > +
> > > > +     return err;
> > > > +}
> > > > +
> > > >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > >                           const struct bpf_prog *prog,
> > > >                           const struct bpf_prog *tgt_prog,
> > > > @@ -23729,18 +23796,18 @@ int bpf_check_attach_target(struct bpf_ve=
rifier_log *log,
> > > >                       if (btf_is_module(btf)) {
> > > >                               mod =3D btf_try_get_module(btf);
> > > >                               if (mod)
> > > > -                                     addr =3D find_kallsyms_symbol=
_value(mod, tname);
> > > > +                                     ret =3D bpf_lookup_attach_add=
r(mod, tname, &addr);
> > > >                               else
> > > > -                                     addr =3D 0;
> > > > +                                     ret =3D -ENOENT;
> > > >                       } else {
> > > > -                             addr =3D kallsyms_lookup_name(tname);
> > > > +                             ret =3D bpf_lookup_attach_addr(NULL, =
tname, &addr);
> > > >                       }
> > > > -                     if (!addr) {
> > > > +                     if (ret) {
> > > >                               module_put(mod);
> > > >                               bpf_log(log,
> > > >                                       "The address of function %s c=
annot be found\n",
> > > >                                       tname);
> > > > -                             return -ENOENT;
> > > > +                             return ret;
> > > >                       }
> > > >               }
> > > >
> > > > --
> > > > 2.39.5
> > > >

