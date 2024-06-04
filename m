Return-Path: <bpf+bounces-31369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E628FBBB2
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF8528768E
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CF14A4F4;
	Tue,  4 Jun 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR5+SsQd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D81179AF
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525779; cv=none; b=pp/sUB4vOpGTMcqCWszB8buwHfx3InbyUYu3MI+1e4nhi3X91Ygf4WAmNanQ+dvoILHgBLekf8VUbUKb13vQrKvgopp97Kaj23ARipNmaFQYB6j3lUU2QHFwISs7sHNy6K/czC4/ThgTnO1JjGt4KYrJtR44PTEeLtRDrNJMIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525779; c=relaxed/simple;
	bh=9JHcomIygCAp3fuBHDpGVVADDD+e2wN1g8NTw+N3jhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbUVCe/vbZQLUYfZzca1FrbEfXH6uOGCdL9Z33BQGuXCCBCcVnOzLVLH1ZqWMhau7WFQaF2WVrp1uTUQwxkHO4U9SfCaptMSSPMF24ZART1gsstyqQLmLJP2KaXhBDVnQO/eXiG//v49FZIHiuJvRirnpOZV81hpgS7lq9nEAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR5+SsQd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so4555008a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717525778; x=1718130578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulpfzC23w1A4yHKyZGdeZxTk3s5xWHHsR79zPIw+fWw=;
        b=cR5+SsQdplazaVWBMHcAhxSW5Wb1W0xTB3ghtd+Jwaw8vIyxoqzgRYlAT1Qgp1aODR
         PNhEpdcvgMgknzyIoKfE1RrCaDU0anjgwM1yuCIWLfF9F/Xm+W7iHaC13b3uwesY3LkZ
         djlmXzZEsWUJLKJ3Ghu1iBtlpAn2Eua6FZZvHOZGyd9bGkYcNwZVMjaVo+6TgS49iR9E
         ukjC3QlXDGWF0yKyVqdunFEJZpYNgHRuhx8GifcUZ4t9O6p2fwerZqoXZlBDBSrQjs2n
         kFh6INvjb4xlUpDwgZiDVSZX82Q9pMk93glX2E8wJVmSnEZ/b0u3r0zI71iXj2HHBD06
         U0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717525778; x=1718130578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulpfzC23w1A4yHKyZGdeZxTk3s5xWHHsR79zPIw+fWw=;
        b=GhgmP4xndiefCGqcngqhc5FReJDLqL/c6gt4Wpx3oqfa57JsnN9u5dqq9optDHyHlH
         qwzAbEIon9g+GMuIDYsIeEkhy8pddQ/IhkhLdq3JrlWtT+dBPOG7Iv1Y9KE9uIQPzlf7
         ENGcBRA/vcpKLx9olEDsXhv/eiwma1HaFFb9Nl80M7OHapvmjT4ulChuxf2cHiz+A3zq
         MXrIdAF0HXVWaJOGOiVEPnc19gCtP5USXOSjnqDw8JCfVDhfu0y8YIXZ11H0hIkJRRrk
         U4LVlMuFYNSlLONqafY9p+zqVSc0eIhIFmVIEBwWQmA8+iid1gOmLPGzZcUDFR+m3XTY
         yM6w==
X-Forwarded-Encrypted: i=1; AJvYcCXoKzhlPROSHunQUGR6lj7uuIGcRXLz/8n2BbeIkwbemfoWeCug6R5iRioF+VbUiV3tfxEa49LGQjpp32MhdxwTQtYm
X-Gm-Message-State: AOJu0YxlqE1aNANThww76R5ACcucMg7CDXKnB6b8mbaxYwicB0qKBoBH
	2MJtQEFKwDPVQafc/DHjlVh4TPmqE8R2b4OvJYxVXPNhHFq3vRHRaFbXrAe+sRYBS6MR53NGyVg
	xgoleoAeC7y/5DsEYa9G7S7cuQlc=
X-Google-Smtp-Source: AGHT+IGq7publDOH79Qg8fFrcXhUssOzbQ5TKkobVKuh4+A+YB+HIYdXNmlnpYzprrY69iXEEi0o9orP/Fxt7/WTpBY=
X-Received: by 2002:a17:90a:5d90:b0:2bd:4498:e503 with SMTP id
 98e67ed59e1d1-2c27db55ee4mr281057a91.31.1717525777728; Tue, 04 Jun 2024
 11:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603231720.1893487-1-andrii@kernel.org> <20240603231720.1893487-3-andrii@kernel.org>
 <Zl70W3wstHhF-6zo@krava>
In-Reply-To: <Zl70W3wstHhF-6zo@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 11:29:25 -0700
Message-ID: <CAEf4Bzby1Tn4fD=GStZcSdjQwSqH7Vkn8nnCsmLOtu1vOqGFPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: make use of BTF field iterator in
 BPF linker code
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, alan.maguire@oracle.com, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:02=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jun 03, 2024 at 04:17:16PM -0700, Andrii Nakryiko wrote:
> > Switch all BPF linker code dealing with iterating BTF type ID and strin=
g
> > offset fields to new btf_field_iter facilities.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/linker.c | 60 ++++++++++++++++++++++++++----------------
> >  1 file changed, 38 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 0d4be829551b..be6539e59cf6 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -957,19 +957,35 @@ static int check_btf_str_off(__u32 *str_off, void=
 *ctx)
> >  static int linker_sanity_check_btf(struct src_obj *obj)
> >  {
> >       struct btf_type *t;
> > -     int i, n, err =3D 0;
> > +     int i, n, err;
> >
> >       if (!obj->btf)
> >               return 0;
> >
> >       n =3D btf__type_cnt(obj->btf);
> >       for (i =3D 1; i < n; i++) {
> > +             struct btf_field_iter it;
> > +             __u32 *type_id, *str_off;
> > +             const char *s;
> > +
> >               t =3D btf_type_by_id(obj->btf, i);
> >
> > -             err =3D err ?: btf_type_visit_type_ids(t, check_btf_type_=
id, obj->btf);
> > -             err =3D err ?: btf_type_visit_str_offs(t, check_btf_str_o=
ff, obj->btf);
> > +             err =3D btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> >               if (err)
> >                       return err;
> > +             while ((type_id =3D btf_field_iter_next(&it))) {
> > +                     if (*type_id >=3D n)
> > +                             return -EINVAL;
> > +             }
> > +
> > +             err =3D btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
> > +             if (err)
> > +                     return err;
> > +             while ((str_off =3D btf_field_iter_next(&it))) {
> > +                     s =3D btf__str_by_offset(obj->btf, *str_off);
> > +                     if (!s)
> > +                             return -EINVAL;
>
> nit, we could drop 's' and just do (!btf__str_by_offset(obj->btf, *str_of=
f))
>

yep, we could, but I probably won't resubmit just for this. So if
something else comes up I'll clean this up, but it can go in as is
just as well, IMO.

>
> otherwise the patchset lgtm
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks for taking a look!

>
> jirka
>
> > +             }
> >       }
> >
> >       return 0;
> > @@ -2234,26 +2250,10 @@ static int linker_fixup_btf(struct src_obj *obj=
)
> >       return 0;
> >  }
>
> SNIP

