Return-Path: <bpf+bounces-62781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3DAFE5D1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD72F1C2229C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575B2594BE;
	Wed,  9 Jul 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjCN1jQJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4E2586CA;
	Wed,  9 Jul 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057251; cv=none; b=iF8rPMBlDeQuFdsMq0YJtZGzyepMQbkyii8J5gvFXwhz6sTSC/N+4xriJDV/7l2TApNBJasHdM7SEGDladxxrfjsd1oG68T4/NQnX6CoUWEMov5b7eL3VFeYC3X+b/HR3tA/akEyi0iiDv5gHePByF3T6IVYGI1G1cykRYhEO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057251; c=relaxed/simple;
	bh=iu8AEwwQ0mU5i+YUYU3nNZ5mLZqYbTBteoJTA9ENneQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFbAya+EdORwNZHv41ufzjxQRWhCxRjmWuD7Ku4EnsyCJTJRX9k5Ug80yviZrBH9hEyrfPLCSMdR5/Y0/z0JRTgUVw/fYw4/YoDNRa90UiCDypO4d0uFpLPtbQ5lmMqhoxIvYB0bs8fwnb6qwtT+hFQ71nqhwKQZgh7uac8wZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjCN1jQJ; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71173646662so49676717b3.2;
        Wed, 09 Jul 2025 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752057249; x=1752662049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCe2QUgCon9e2/AePLSeDzOaD9jl19LJ8Lyl2+ePa9U=;
        b=EjCN1jQJGcZPnM5MIuYJCqCXu5CqFxDBsXXOZlL5G1BtVUoBUIWEUuRT5FvpaQGI2Z
         xgY0PWtykTThxhP4LZ8fEvF8iB8BUcllfYp09bPnrcm970R5aKxgefMG4zbyNyrOu01G
         BrcKHP8F2Ot9FG3683Vqz2NF/TD7N5+a0HjYq6qJYumMKxeKEFOizLSOROcsYi08RKu6
         IMGpk4i1JtD3z8Q1TdDnK9L8/WZ/97rdnM6unt+ed5YShEigNpvNwj4/FRfZQBbUhD6U
         fZ9HaCU3CGQYp+ubgzAmnVQkczbIolNU7uIXU1z9bNzjXm7k8HIxrhEdW3/FeHRQ7s/b
         Pq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752057249; x=1752662049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCe2QUgCon9e2/AePLSeDzOaD9jl19LJ8Lyl2+ePa9U=;
        b=byPPJIj67I5CXog346IynpVoTOTzXlgkT3bp3FBkvMWic7IQ/L9nHnAOEY2O2YgAle
         GK2jgl1lzM3ol5K5wTTB6Sb19VY0E8V+HOFKBQwiYPa6aj/5bNNjoo86ylw3QKPAunOZ
         vSVJXAQrJNRrBSZGPuaB6yb3jGTLNS2uAPRpSrAvO+ntPIT9RrtFtWeiQegG0Q8qHpAi
         MXCHn2UiU49GuaQfbessnQewY0H5QREL67gyUsEj25ObwBCaANQIgAxx34JPuZj473ob
         7SAdpWw6o510tI6khhrLEweRg2MuXDeEUhyLhHV0bgE5GonmPnA4Lxcx8ZcTLS+7vyv3
         wojQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcQ5iPT0YNkw4yrSguC2hA95ZZPOGTAVvGVnPVm3Vvrd19mbcwbcMOGTP0if6+G30i/gke2ef+SO5e6l+k@vger.kernel.org, AJvYcCWHNS++Ly7cpuAtGDJhvGbgQ7AKvrYvye2nam61EWHnpw1e3ngNmYqCxjYDgovUp3OYo7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/56qQmVkCMiBOS38U4DKa1MkZpEAbwSzOJ8FC67pfdFpEHlH
	N3/z0RPrc+7PZnju9NwzwA/6MBwWWfQBhPtaiG6qM0sVX8BXxE+FuXWpieyajqkYAipy6mWclZi
	w2x327PCHnoxyLS96Hny8tXip6ag6q3g=
X-Gm-Gg: ASbGncs6jimaCXXlJKveSdwiZ2/cHJliX2kiSPZ/nHWDXk6hc6bxWrJxi1wsInXu3LG
	Ak5pfayZJQViyD8arI0ZwTZQxedBi7bnFcXYsAoPLCEQGZBd9XZDDHT+0CDjjTKWwe5p6sh8CyF
	PPkC0rH8qse7kpkmLlSGSYv51LcCTuWH5whHZtjOdFc5g=
X-Google-Smtp-Source: AGHT+IHFW5XuHhG/WhOqvdeh3fDryVvUriKLJIWGi1AG0u3pQ569upJ9CNxrC7HEYQN/1axABbsA9+1fX5ej9mBja1I=
X-Received: by 2002:a05:690c:9985:b0:714:4e0:ba42 with SMTP id
 00721157ae682-717b166b8c9mr30808007b3.1.1752057248466; Wed, 09 Jul 2025
 03:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708072140.945296-1-dongml2@chinatelecom.cn> <aG4roiqyzNFOvu2R@krava>
In-Reply-To: <aG4roiqyzNFOvu2R@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 9 Jul 2025 18:33:08 +0800
X-Gm-Features: Ac12FXweCJh6Yf5L8XBePbK8xs4dfYHbXwjbIc31PAQUXElQ4EdNmqMu0hs5DzE
Message-ID: <CADxym3adDgLaoQcQZLW=-fwELDi2-HTJ6tvA+HdF97+mKDErsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: make the attach target more accurate
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Jul 08, 2025 at 03:21:40PM +0800, Menglong Dong wrote:
> > For now, we lookup the address of the attach target in
> > bpf_check_attach_target() with find_kallsyms_symbol_value or
> > kallsyms_lookup_name, which is not accurate in some cases.
> >
> > For example, we want to attach to the target "t_next", but there are
> > multiple symbols with the name "t_next" exist in the kallsyms. The one
> > that kallsyms_lookup_name() returned may have no ftrace record, which
> > makes the attach target not available. So we want the one that has ftra=
ce
> > record to be returned.
> >
> > Meanwhile, there may be multiple symbols with the name "t_next" in ftra=
ce
> > record. In this case, the attach target is ambiguous, so the attach sho=
uld
> > fail.
>
> could you reproduce this somehow (bpftrace/selftest) for some symbol?
> I'd think pahole now filters all such symbols out of BTF and you need
> BTF func record to load the program in the first place

Hi, what's the version of pahole that does such filtering? I have
compiled the latest pahole, and such symbols exist. The version
of the pahole is v1.30

pahole --version
v1.30

It can be reproduced easily, just try to attach to the symbol t_next.
The "t_next" has multiple definition:

bpftrace -e 'fentry:t_next {printf("1");}'
Attaching 1 probe...
ERROR: Error attaching probe: fentry:vmlinux:t_next

This is the symbol information of t_next:

cat /proc/kallsyms | grep ' t_next'
ffffffff8142d9c0 t t_next
ffffffff81440e80 t t_next
ffffffff8144f1f0 t t_next
ffffffff8145ae90 t t_next
ffffffff81735b30 t t_next

cat /tracing/available_filter_functions | grep '^t_next'
t_next

The related patch is here:
https://lore.kernel.org/bpf/CADxym3Y-Jbzp0FupUgBDJB99GhsbDHyuV71Q6m9xyTpFze=
4ESg@mail.gmail.com/

(I just distclean and rebuild the kernel, the problem still exists)

Thanks!
Menglong Dong

>
> jirka
>
>
> >
> > Introduce the function bpf_lookup_attach_addr() to do the address looku=
p,
> > which is able to solve this problem.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - Lookup both vmlinux and modules symbols when mod is NULL, just like
> >   kallsyms_lookup_name().
> >
> >   If the btf is not a modules, shouldn't we lookup on the vmlinux only?
> >   I'm not sure if we should keep the same logic with
> >   kallsyms_lookup_name().
> >
> > - Return the kernel symbol that don't have ftrace location if the symbo=
ls
> >   with ftrace location are not available
> > ---
> >  kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 72 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53007182b46b..4bacd0abf207 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23476,6 +23476,73 @@ static int check_non_sleepable_error_inject(u3=
2 btf_id)
> >       return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_i=
d);
> >  }
> >
> > +struct symbol_lookup_ctx {
> > +     const char *name;
> > +     unsigned long addr;
> > +     bool ftrace_addr;
> > +};
> > +
> > +static int symbol_callback(void *data, unsigned long addr)
> > +{
> > +     struct symbol_lookup_ctx *ctx =3D data;
> > +
> > +     ctx->addr =3D addr;
> > +     if (!ftrace_location(addr))
> > +             return 0;
> > +
> > +     if (ctx->ftrace_addr)
> > +             return -EADDRNOTAVAIL;
> > +     ctx->ftrace_addr =3D true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int symbol_mod_callback(void *data, const char *name, unsigned =
long addr)
> > +{
> > +     if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) !=3D 0=
)
> > +             return 0;
> > +
> > +     return symbol_callback(data, addr);
> > +}
> > +
> > +/**
> > + * bpf_lookup_attach_addr: Lookup address for a symbol
> > + *
> > + * @mod: kernel module to lookup the symbol, NULL means to lookup both=
 vmlinux
> > + * and modules symbols
> > + * @sym: the symbol to resolve
> > + * @addr: pointer to store the result
> > + *
> > + * Lookup the address of the symbol @sym. If multiple symbols with the=
 name
> > + * @sym exist, the one that has ftrace location is preferred. If more
> > + * than 1 has ftrace location, -EADDRNOTAVAIL will be returned.
> > + *
> > + * Returns: 0 on success, -errno otherwise.
> > + */
> > +static int bpf_lookup_attach_addr(const struct module *mod, const char=
 *sym,
> > +                               unsigned long *addr)
> > +{
> > +     struct symbol_lookup_ctx ctx =3D { .addr =3D 0, .name =3D sym };
> > +     const char *mod_name =3D NULL;
> > +     int err =3D 0;
> > +
> > +#ifdef CONFIG_MODULES
> > +     mod_name =3D mod ? mod->name : NULL;
> > +#endif
> > +     if (!mod_name)
> > +             err =3D kallsyms_on_each_match_symbol(symbol_callback, sy=
m, &ctx);
> > +
> > +     if (!err && !ctx.addr)
> > +             err =3D module_kallsyms_on_each_symbol(mod_name, symbol_m=
od_callback,
> > +                                                  &ctx);
> > +
> > +     if (!ctx.addr)
> > +             err =3D -ENOENT;
> > +     *addr =3D err ? 0 : ctx.addr;
> > +
> > +     return err;
> > +}
> > +
> >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                           const struct bpf_prog *prog,
> >                           const struct bpf_prog *tgt_prog,
> > @@ -23729,18 +23796,18 @@ int bpf_check_attach_target(struct bpf_verifi=
er_log *log,
> >                       if (btf_is_module(btf)) {
> >                               mod =3D btf_try_get_module(btf);
> >                               if (mod)
> > -                                     addr =3D find_kallsyms_symbol_val=
ue(mod, tname);
> > +                                     ret =3D bpf_lookup_attach_addr(mo=
d, tname, &addr);
> >                               else
> > -                                     addr =3D 0;
> > +                                     ret =3D -ENOENT;
> >                       } else {
> > -                             addr =3D kallsyms_lookup_name(tname);
> > +                             ret =3D bpf_lookup_attach_addr(NULL, tnam=
e, &addr);
> >                       }
> > -                     if (!addr) {
> > +                     if (ret) {
> >                               module_put(mod);
> >                               bpf_log(log,
> >                                       "The address of function %s canno=
t be found\n",
> >                                       tname);
> > -                             return -ENOENT;
> > +                             return ret;
> >                       }
> >               }
> >
> > --
> > 2.39.5
> >

