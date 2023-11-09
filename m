Return-Path: <bpf+bounces-14654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4C07E7518
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05C81C20BDF
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9AB38DF2;
	Thu,  9 Nov 2023 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcw4OfE4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3920B07
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 23:25:45 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D011B420F
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:25:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c41e95efcbso241032866b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 15:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699572343; x=1700177143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm+VNSMyhJoP6Uikt/78J3pKCxL/7P/JvKjQxVtP2gw=;
        b=Lcw4OfE4hkDsn7029paITsssXX/BbK/mRn6fh1TByzefTr8//BEFbnjknL/2PXccKL
         akukrLX6avsaBcO263FOIfjIqB0IVgIdLlqXrtY10dWgAY4MPlVe6hObNNYionm1HxPm
         SdJG0g6fsgcorx10S+Gj7mINQ1lqzeKAQTd6Ctz3k4jsfhnADvdjY0rEk+tCZgZHHcGA
         cI1HFw0Gg2xQSGUBOItvPlcYE81FXwY8/C2Fd+ch++dxF7k3lh/k5ptD+Ra++4Y2kzBi
         slEkTxKg2equ588agJn1ASkGNY0/AcxYD7dlLmxCcRBsNmNJf/s4VKMUUFY1BXXLlrFC
         3x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572343; x=1700177143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm+VNSMyhJoP6Uikt/78J3pKCxL/7P/JvKjQxVtP2gw=;
        b=pBfyYaBTFufyVfXgSBF9yTd/LdHEQu01t8CspPlloU8G0FqCgOuGCV6RlGogdDDpJH
         1IkRkUGJ62ONW++jHb59Ne9xbogKPdgcs4fXCWxomjv3Dsy18fUD46Z8d+I9iDGiOqmV
         Dd+sfGsl+hKABKlOoF5pzvyczE8W5LCmoi2X5ZROTT11oYM5c7OhHrmnH1U+LSDhWslW
         B0P2BDyriZqZnSwYYWkwJd8DPSjHw6by5zQVSTxnyGN5J6ltktSPwJlFJ406dN0AkcBq
         ZpNG+3EMaXlPcyPMlNRDve+8qVIz744YV928FoGOyxR9ICdEhBuE/vaNEhOfJI5keNtP
         C4LQ==
X-Gm-Message-State: AOJu0Yx//eSyOLzPC7WY8vM+z6wlf05RYApAtzk+xWtdvGCQpzyLwCWX
	zWmN29Gdix4FssSHunK4b0JWD/4bKe0mkT2eIuYYGHx9
X-Google-Smtp-Source: AGHT+IHRyqPsreJeMm4kaR6vPC8t/urKQCq7vlxCLIREYXIz5TeaGw6LbZqUdGst3kriL4Bt+cVT36rEso0r6NMk8MU=
X-Received: by 2002:a17:907:9343:b0:9ae:52fb:2202 with SMTP id
 bv3-20020a170907934300b009ae52fb2202mr4954959ejc.40.1699572343166; Thu, 09
 Nov 2023 15:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-4-andrii@kernel.org>
 <9f8030ae333daaf50ae975e192103f236270eb55.camel@gmail.com>
In-Reply-To: <9f8030ae333daaf50ae975e192103f236270eb55.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 15:25:31 -0800
Message-ID: <CAEf4BzbsXy-aNcPKRM4RQEtgKPRhFj4cyjNEBfEXN1Ky3rTW7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 2:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> (given that I understood check in push_insn correctly).
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edca7f1ad335..35065cae98b7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15433,8 +15433,9 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno)
>
> Nitpick: there is a comment right above this enum which has to be
>          updated after changes to the enum.

yep, I also mentioned conditional bits. Now it's 0x12 or 0x13 for
FALLTHROUGH case, and 0x14 and 0x15 for BRANCH.

>
> >  enum {
> >       DISCOVERED =3D 0x10,
> >       EXPLORED =3D 0x20,
> > -     FALLTHROUGH =3D 1,
> > -     BRANCH =3D 2,
> > +     CONDITIONAL =3D 0x01,
> > +     FALLTHROUGH =3D 0x02,
> > +     BRANCH =3D 0x04,
> >  };
> >
> >  static void mark_prune_point(struct bpf_verifier_env *env, int idx)
> > @@ -15468,16 +15469,15 @@ enum {
> >   * w - next instruction
> >   * e - edge
> >   */
> > -static int push_insn(int t, int w, int e, struct bpf_verifier_env *env=
,
> > -                  bool loop_ok)
> > +static int push_insn(int t, int w, int e, struct bpf_verifier_env *env=
)
> >  {
> >       int *insn_stack =3D env->cfg.insn_stack;
> >       int *insn_state =3D env->cfg.insn_state;
> >
> > -     if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FALL=
THROUGH))
> > +     if ((e & FALLTHROUGH) && insn_state[t] >=3D (DISCOVERED | FALLTHR=
OUGH))
> >               return DONE_EXPLORING;
>
> This not related to your changes, but '>=3D' here is so confusing.

Agreed. It's a real head-scratcher, how check_cfg() is implemented.

> The intent is to check:
>   ((insn_state[t] & (DISCOVERED | FALLTHROUGH)) =3D=3D (DISCOVERED | FALL=
THROUGH))
> i.e. DONE_EXPLORING if fall-through branch of 't' had been explored alrea=
dy,
> right?

I think the intent is to distinguish pure DISCOVERED vs (DISCOVERED |
e) (where e is either FALLTHROUGH or BRANCH). Pure DISCOVERED means
that node is enqueued (in a stack, enstacked ;), but hasn't been
processed yet, while FALLTHROUGH|BRANCH means we are processing it
(but it's not yet fully EXPLORED).

CONDITIONAL is oblivious to FALLTHROUGH|BRANCH, so I put it as 1 so
that this >=3D check ignores it.



>
> [...]

