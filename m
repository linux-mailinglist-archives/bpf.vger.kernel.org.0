Return-Path: <bpf+bounces-14863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D97E8988
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 07:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE0F2811DB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631163D7;
	Sat, 11 Nov 2023 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGM1TIjP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71F7474
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 06:32:14 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5327646A8
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 22:32:12 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso4369282a12.3
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 22:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699684331; x=1700289131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZBxbyNZgO4DUP0OZFiDVGnr2UdUfNW/mM/4HCRrM48=;
        b=OGM1TIjPAkFdAXNlo6th5Iy8uw5Pj+U7lNwrlzVS6/WhAlEXV6nz8IU/gns0kjyEhm
         FhONut6LI9WNgIc638zvqyp7PaBIKsmBbKEZziAPkFHtcMVGlPtN0YYXqL993yux2X/R
         1tV4AsWPGx8JHAunrNfkvGW9vfmn6j36Gfaxd12dqHw/mmVw9W436SgOb92Ft3zjmTqN
         j0z2mHDZbga1lHh5ksEe3W75vb4jhhyfFia1tzrtWToojEY1qnRt+qZc7YJiPeOG+vOe
         rSnGIcWIQaeY44O5f63DKEanpyBrNZg2c8bF+Jnu5HfL1QDBPydqcxKyqIYkZOYF4Zba
         nGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699684331; x=1700289131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZBxbyNZgO4DUP0OZFiDVGnr2UdUfNW/mM/4HCRrM48=;
        b=rfrS7XTvYLv8hEcorDKP23HG7G5Or0ADnjd9B5Jvcyog2e821bcC9wj6U4FQSv35kj
         S0njPRkVM0QP3caeqNjsRKFq1JDvuZdfWFjQ/cWKpwZUlAODCj6QROb5uioPKnfei19L
         PWRMnGMOgKcx/JaFluj63aAjTgv1+VpwsDY3b0mnQQ5HiLQ+x11Lxbpw49YTBfECukaT
         CCU/gCeqyIC8fUk+YADr8QjRU9+ORdqBKUhmlhbI151OTHNddp6Ew0R/fqN2Gn6P87vM
         pvaG2s/JSaPM/6sqn5MgfwQTxP1Zm4PeZs9tKjcX3gbSRtXp7Tn105XhBISLTBbTWY9O
         5hHQ==
X-Gm-Message-State: AOJu0Yzp8nKXcbpoWopiobscd585e5NgpOvl0W+QO0N383Wa1mVunSEH
	hon1FYsOJlAMD+KkkUab1iCW3lsF3hOcGgegGb4=
X-Google-Smtp-Source: AGHT+IHdOJW4vqW80b+RkuWvrIzo85bDdAdn5vq4Yq+qkDTevoD9cYQEbx0YSH25BjIOALq4XqRPL+G6XUtjxhcFyJ0=
X-Received: by 2002:aa7:c045:0:b0:543:5f3:c92 with SMTP id k5-20020aa7c045000000b0054305f30c92mr731901edo.36.1699684330541;
 Fri, 10 Nov 2023 22:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110161057.1943534-1-andrii@kernel.org> <20231110161057.1943534-8-andrii@kernel.org>
 <8506722472c49aafc5842ee3d39ddae3230882b7.camel@gmail.com>
In-Reply-To: <8506722472c49aafc5842ee3d39ddae3230882b7.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 22:31:59 -0800
Message-ID: <CAEf4BzYzRWJN_YVNWBuK8RXmzdYU_cEBteNacAFD93KwYOr4PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] bpf: smarter verifier log number printing logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 4:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-10 at 08:10 -0800, Andrii Nakryiko wrote:
> > Instead of always printing numbers as either decimals (and in some
> > cases, like for "imm=3D%llx", in hexadecimals), decide the form based o=
n
> > actual values. For numbers in a reasonably small range (currently,
> > [0, U16_MAX] for unsigned values, and [S16_MIN, S16_MAX] for signed one=
s),
> > emit them as decimals. In all other cases, even for signed values,
> > emit them in hexadecimals.
> >
> > For large values hex form is often times way more useful: it's easier t=
o
> > see an exact difference between 0xffffffff80000000 and 0xffffffff7fffff=
ff,
> > than between 18446744071562067966 and 18446744071562067967, as one
> > particular example.
> >
> > Small values representing small pointer offsets or application
> > constants, on the other hand, are way more useful to be represented in
> > decimal notation.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
> > @@ -576,14 +627,14 @@ static void print_reg_state(struct bpf_verifier_e=
nv *env, const struct bpf_reg_s
> >           tnum_is_const(reg->var_off)) {
> >               /* reg->off should be 0 for SCALAR_VALUE */
> >               verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_=
str(env, t));
> > -             verbose(env, "%lld", reg->var_off.value + reg->off);
> > +             verbose_snum(env, reg->var_off.value + reg->off);
> >               return;
> >       }
> >  /*
> >   * _a stands for append, was shortened to avoid multiline statements b=
elow.
> >   * This macro is used to output a comma separated list of attributes.
> >   */
> > -#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__=
); sep =3D ","; })
> > +#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, ##__VA_ARGS=
__); sep =3D ","; })
> >
> >       verbose(env, "%s", reg_type_str(env, t));
> >       if (base_type(t) =3D=3D PTR_TO_BTF_ID)
> > @@ -608,8 +659,10 @@ static void print_reg_state(struct bpf_verifier_en=
v *env, const struct bpf_reg_s
> >               verbose_a("r=3D%d", reg->range);
> >       if (tnum_is_const(reg->var_off)) {
> >               /* a pointer register with fixed offset */
> > -             if (reg->var_off.value)
> > -                     verbose_a("imm=3D%llx", reg->var_off.value);
> > +             if (reg->var_off.value) {
> > +                     verbose_a("imm=3D");
> > +                     verbose_snum(env, reg->var_off.value);
> > +             }
>
> Maybe use same verbose_{u,s}num() for reg->off and reg->range in this
> function?

sure, will do!

