Return-Path: <bpf+bounces-18971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE35823965
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230B0B2115B
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C61F959;
	Wed,  3 Jan 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK6rcOg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2521F93C
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so4520a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704326383; x=1704931183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H6uQhTmuebLrHAqwC8OKvj5mlZ9t53s2toubBKOhF4=;
        b=WK6rcOg4/woj1AeJlpgH+sM1BMxPwa7YK/hYZXeXs80w0A+/n0vJpgLZm2b1uiHsfZ
         L6zh6E6KxUvXzKDWYNzI8KbHSaK20T0JWM2GoFVAEr42EI+Jt0Za6LMcIcjKR5fH1ghZ
         WtrZ29ONqe9M/+Y5aqv1Cpc/5oE5uGDGd2rfLZnyO8npH2AqfV99ehROzsCmq7fo4BXg
         77MXj3YyRgpBUKemSD7DCXeht47pi6qwZVyHcRdlTnLIJEfxo/mjeWWz98/61HyUSs5p
         VS2V4VAiye2PLqtySp1Oi7ekrrktwYF7GhJj32P5lCOtcU4+ZXQKrDGVojeg/pOjMxHD
         yE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704326383; x=1704931183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H6uQhTmuebLrHAqwC8OKvj5mlZ9t53s2toubBKOhF4=;
        b=t00wtS0CWrdVFQvl6skYNfyPMKdIEkwLcUbeW10HjxNuzczNnb8GIZ+9J7OHYaNDGB
         Ry0ek85zMmUERl4acQdeolW9BaLRIjaci3lWszbWmjh55PqeFmvmMnl9CDhNpsaH/v9k
         YltMNjfruXwA6tDLiCNEOWDG2uyUaytX3fZsQ3GPb0cVNe3WTMqCTjpyaxoZchoYsrft
         3DT3gPUGS56fJgBfhgyrxdRM/+u47fAu2KEI57uu/NrJAsQw6HJrC3Ek+OUg0l3DtYUJ
         nCd6+L2acGiJfo93FIYo9oarFFsyOb+D/cc7roSad3A5PCN9oeQWU0t6auJv12z1v02y
         bYjQ==
X-Gm-Message-State: AOJu0Yxg41nWirGhCwr30s+nlFo4vcVkLSepfUSx2AXHmbo1Tgmk49jn
	/jRILJQwGpDHbjYDnUhRp1nUbPs0gMjfrUboRl4=
X-Google-Smtp-Source: AGHT+IERD34uyaVM+pBo10uPhP8Bhdgf0JdrURy/C14pWSSSkIwyv325RcZ5KPKsMeoycTYpH4aM+M7wVXDVJcYBgwM=
X-Received: by 2002:a50:d011:0:b0:556:2dc7:aab4 with SMTP id
 j17-20020a50d011000000b005562dc7aab4mr1988857edf.41.1704326382638; Wed, 03
 Jan 2024 15:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-9-andrii@kernel.org>
 <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
 <CAEf4BzaB_dOz8QmG9kGM7ViD=iM7P-a1GsMAMyyJhdf1W2Kwng@mail.gmail.com> <7746c6fa67e655b288e069b0c1d6393dc8c46502.camel@gmail.com>
In-Reply-To: <7746c6fa67e655b288e069b0c1d6393dc8c46502.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 15:59:30 -0800
Message-ID: <CAEf4BzaPhbRVEJ9o3UqP0q6Ot63BYdxw4UO8J94bQk2Waij+Zw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: implement __arg_ctx fallback logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-01-03 at 15:10 -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 3, 2024 at 12:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2024-01-02 at 11:00 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > +static int clone_func_btf_info(struct btf *btf, int orig_fn_id, st=
ruct bpf_program *prog)
> > > > +{
> > >
> > > [...]
> > >
> > > > +     /* clone FUNC first, btf__add_func() enforces
> > > > +      * non-empty name, so use entry program's name as
> > > > +      * a placeholder, which we replace immediately
> > > > +      */
> > > > +     fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage(fn_=
t), fn_t->type);
> > >
> > > Nit: Why not call this function near the end, when fn_proto_id is ava=
ilable?
> > >      Thus avoiding need to "guess" fn_t->type.
> > >
> >
> > I think I did it to not have to remember btf_func_linkage(fn_t)
> > (because fn_t will be invalidated) and because name_off will be reused
> > for parameters. Neither is a big deal, I'll adjust to your suggestion.
> >
> > But note, we are not guessing ID, it's guaranteed to be +1, it's an
> > API contract of btf__add_xxx() APIs.
>
> Noted, well, maybe just skip this nit in such a case.
>

I already did the change locally, as I said it's a small change, so no prob=
lem.


> > > [...]
> > >
> > > > +static int bpf_program_fixup_func_info(struct bpf_object *obj, str=
uct bpf_program *prog)
> > > > +{
> > >
> > > [...]
> > >
> > > > +     for (i =3D 1, n =3D btf__type_cnt(btf); i < n; i++) {
> > >
> > > [...]
> > >
> > > > +
> > > > +             /* clone fn/fn_proto, unless we already did it for an=
other arg */
> > > > +             if (func_rec->type_id =3D=3D orig_fn_id) {
> > > > +                     int fn_id;
> > > > +
> > > > +                     fn_id =3D clone_func_btf_info(btf, orig_fn_id=
, prog);
> > > > +                     if (fn_id < 0) {
> > > > +                             err =3D fn_id;
> > > > +                             goto err_out;
> > > > +                     }
> > > > +
> > > > +                     /* point func_info record to a cloned FUNC ty=
pe */
> > > > +                     func_rec->type_id =3D fn_id;
> > >
> > > Would it be helpful to add a log here, saying that BTF for function
> > > so and so is changed before load?
> >
> > Would it? We don't have global subprog's name readily available, it
> > seems. So I'd need to refetch it by fn_id, then btf__str_by_offset()
> > just to emit cryptic (for most users) notifications that something
> > about some func info was adjusted. And then the user would get this
> > same message for the same subprog but in the context of a different
> > entry program. Just confusing, tbh.
> >
> > Unless you insist, I'd leave it as is. This logic is supposed to be
> > bullet-proof, so I'm not worried about debugging regressions with it
> > (but maybe I'm delusional).
>
> I was thinking about someone finding out that actual in-kernel BTF
> is different from that in the program object file, while debugging
> something. Might be a bit surprising. I'm not insisting on this, though.

Note the "/* check if existing parameter already matches verifier
expectations */", if program is using correct types, we don't touch
BTF for that subprog. If there was `void *ctx`, we don't really lose
any information.

If they use `struct pt_regs *ctx __arg_ctx`, then yeah, it will be
updated to `struct bpf_user_pt_regs_t *ctx __arg_ctx`, but even then,
original BTF has original FUNC -> FUNC_PROTO definition. You'd need to
fetch func_info and follow BTF IDs (I'm not sure if bpftool even shows
this today).

In short, I don't see why this would be a problem, but perhaps I
should just bite a bullet and do feature detector for this support.

>
> > > > +             }
> > > > +
> > > > +             /* create PTR -> STRUCT type chain to mark PTR_TO_CTX=
 argument;
> > > > +              * we do it just once per main BPF program, as all gl=
obal
> > > > +              * funcs share the same program type, so need only PT=
R ->
> > > > +              * STRUCT type chain
> > > > +              */
> > > > +             if (ptr_id =3D=3D 0) {
> > > > +                     struct_id =3D btf__add_struct(btf, ctx_name, =
0);
> > >
> > > Nit: Maybe try looking up existing id for type ctx_name first?
> >
> > It didn't feel important and I didn't want to do another linear BTF
> > search for each such argument. It's trivial to look it up, but I still
> > feel like that's a waste... I tried to avoid many linear searches,
> > which is why I structured the logic to do one pass over BTF to find
> > all decl_tags instead of going over each function and arg and
> > searching for decl_tag.
> >
> > Let's keep it as is, if there are any reasons to try to reuse struct
> > (if it is at all present, which for kprobe, for example, is quite
> > unlikely due to fancy bpf_user_pt_regs_t name), then we can easily add
> > it with no regressions.
>
> I was thinking about possible interaction with btf_struct_access(),
> but that is not used to verify context access at the moment.
> So, probably not important.

Right, and kernel can't trust user-provided BTF info, it will have to
find a match for kernel-side BTF info. I actually add this logic in a
patch set (pending locally for now) that adds support for
PTR_TO_BTF_ID arguments for global funcs.

