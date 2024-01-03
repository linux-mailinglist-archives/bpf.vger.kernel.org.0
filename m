Return-Path: <bpf+bounces-18958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014EE823904
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D261C241A1
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6981EB3A;
	Wed,  3 Jan 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZqim8QR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13912B67
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so140710441fa.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704323449; x=1704928249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zt9kO5EkFC99n58KHq6VavOc30WwfyWcR1keo9cXi0=;
        b=QZqim8QR1RAZgKR8o9UGwE+6z5N0dAfbkiGtwE3d6ZYSXSSY73MdZ6iLlP/z6v64WV
         pQS3CfrurwY5atEI5mQplMmTfKGYGYozmX7TqCebRqIRfjkBFV39T2YZDGqCgT+cmXjz
         dUYz+SnjUOv3z+BH1zRwwwjdr29FrYW3e6Mj/0fyiwYLesZa9HDJuy9B2FwOQ/p40OV/
         cOV6F6Pd00jrgDLU5/HCAyocEW9hoJnShrM9ji0kkzNPW6ZZZVeo7m7Tkk6rRF3v4zJB
         WlZYjdVwfGfbn3miuAkMMEDrrFbdKFkKmdh7ZxxzW8vcW2wBjjYzkzSkB0qX6Ne2Olm5
         l9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323449; x=1704928249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zt9kO5EkFC99n58KHq6VavOc30WwfyWcR1keo9cXi0=;
        b=Yv/GPwNxhxeKMqQzcrlA/5HiQXUJZE/I5b7/6b5DVlPbTVJ4dIALQB9V+O7nLNeujP
         kglKMJisVKyOP52almi8+pBlS1TXvE8yjLpkkQIqvI7TZoSh2ly62+cfPR+PAN/Om6ku
         l0RcJRns/FgAgWILpEtg3IVwse+XrmxZ3QzVV2XO9YZ/e2g8jrAlG5mKt0WyPa4nev8Z
         xICgbGAhIHBGPfuVFyeGpATySr2OzSKnkJGtn2JiYVVWemFld7g1NAyw0vL3CijkCXGG
         wE7gJa6hruGHtvp2VT057A0KB0Jxtft21IptOxUC82n6Yzbj2pyLR1NYPXy8kuUfSooo
         jxEQ==
X-Gm-Message-State: AOJu0Yxn9bQlOz9/YWEy9ys6ZRcDB+K30ZKXcTZczruojTjmevEBzDWu
	VeILgbKIrxLOsR4t14QLNRfP2ia2+n8cJCnMMqQ=
X-Google-Smtp-Source: AGHT+IF0TgKCRsF3DURyjI29R0PyGNwpmtEIqUyZZajo2COQ3LtcBES29h/rqkGdGJxT9Yy3dvOE8jh9k6xAOiPyMZI=
X-Received: by 2002:a05:651c:1a10:b0:2cc:cbc3:9de4 with SMTP id
 by16-20020a05651c1a1000b002cccbc39de4mr8447300ljb.50.1704323449145; Wed, 03
 Jan 2024 15:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-9-andrii@kernel.org>
 <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
In-Reply-To: <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 15:10:36 -0800
Message-ID: <CAEf4BzaB_dOz8QmG9kGM7ViD=iM7P-a1GsMAMyyJhdf1W2Kwng@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: implement __arg_ctx fallback logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-01-02 at 11:00 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > +static int clone_func_btf_info(struct btf *btf, int orig_fn_id, struct=
 bpf_program *prog)
> > +{
>
> [...]
>
> > +     /* clone FUNC first, btf__add_func() enforces
> > +      * non-empty name, so use entry program's name as
> > +      * a placeholder, which we replace immediately
> > +      */
> > +     fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage(fn_t), =
fn_t->type);
>
> Nit: Why not call this function near the end, when fn_proto_id is availab=
le?
>      Thus avoiding need to "guess" fn_t->type.
>

I think I did it to not have to remember btf_func_linkage(fn_t)
(because fn_t will be invalidated) and because name_off will be reused
for parameters. Neither is a big deal, I'll adjust to your suggestion.

But note, we are not guessing ID, it's guaranteed to be +1, it's an
API contract of btf__add_xxx() APIs.

> [...]
>
> > +static int bpf_program_fixup_func_info(struct bpf_object *obj, struct =
bpf_program *prog)
> > +{
>
> [...]
>
> > +     for (i =3D 1, n =3D btf__type_cnt(btf); i < n; i++) {
>
> [...]
>
> > +
> > +             /* clone fn/fn_proto, unless we already did it for anothe=
r arg */
> > +             if (func_rec->type_id =3D=3D orig_fn_id) {
> > +                     int fn_id;
> > +
> > +                     fn_id =3D clone_func_btf_info(btf, orig_fn_id, pr=
og);
> > +                     if (fn_id < 0) {
> > +                             err =3D fn_id;
> > +                             goto err_out;
> > +                     }
> > +
> > +                     /* point func_info record to a cloned FUNC type *=
/
> > +                     func_rec->type_id =3D fn_id;
>
> Would it be helpful to add a log here, saying that BTF for function
> so and so is changed before load?

Would it? We don't have global subprog's name readily available, it
seems. So I'd need to refetch it by fn_id, then btf__str_by_offset()
just to emit cryptic (for most users) notifications that something
about some func info was adjusted. And then the user would get this
same message for the same subprog but in the context of a different
entry program. Just confusing, tbh.

Unless you insist, I'd leave it as is. This logic is supposed to be
bullet-proof, so I'm not worried about debugging regressions with it
(but maybe I'm delusional).

>
> > +             }
> > +
> > +             /* create PTR -> STRUCT type chain to mark PTR_TO_CTX arg=
ument;
> > +              * we do it just once per main BPF program, as all global
> > +              * funcs share the same program type, so need only PTR ->
> > +              * STRUCT type chain
> > +              */
> > +             if (ptr_id =3D=3D 0) {
> > +                     struct_id =3D btf__add_struct(btf, ctx_name, 0);
>
> Nit: Maybe try looking up existing id for type ctx_name first?

It didn't feel important and I didn't want to do another linear BTF
search for each such argument. It's trivial to look it up, but I still
feel like that's a waste... I tried to avoid many linear searches,
which is why I structured the logic to do one pass over BTF to find
all decl_tags instead of going over each function and arg and
searching for decl_tag.

Let's keep it as is, if there are any reasons to try to reuse struct
(if it is at all present, which for kprobe, for example, is quite
unlikely due to fancy bpf_user_pt_regs_t name), then we can easily add
it with no regressions.

>
> > +                     ptr_id =3D btf__add_ptr(btf, struct_id);
> > +                     if (ptr_id < 0 || struct_id < 0) {
> > +                             err =3D -EINVAL;
> > +                             goto err_out;
> > +                     }
> > +             }
> > +
>
> [...]
>
>

