Return-Path: <bpf+bounces-35662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D815693C93D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CD21F21854
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 19:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677736F2EA;
	Thu, 25 Jul 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvQ88ZhD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578B770E2
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937558; cv=none; b=Lgpvv97HuVPAgLJuN1Bt5Zi1O8s29qOH3x2dxuQoqzP62B7iMikkFeDk6YrUJwFcuxruBeAn7DY/V77hs7/ziHRH5sXNlvHGL9kawUpFBOXKtdekY5ERrHA4q2lzNnnGkjeSiER/JvKLSeO6uADGYh6ZuDtWyRh0QnL3asLph78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937558; c=relaxed/simple;
	bh=PJ3tiBdI9lomoLnjL8bvUrBKgjHsfXSID7kVYkc9djE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu4SPKG4ivnadPJwmyhDicSfcpniIcjiFeZsH2ec1jDZW1zUcrCuPJHNcVyqNYst7O27utr2n5CORs8Q6JNkLnLQkcU91a/6MHTAHbVDLZzBpKPAatGgQDhfEgoQyxEHhuGx7aRHRKEFLveqzWu9ozBYzPKL1kaF3DclJlAFK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvQ88ZhD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso202146a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721937556; x=1722542356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ3tvD8Nb8fNSpovx5H8fGMVhMUJOvDNuyECpxv81jg=;
        b=cvQ88ZhDwlMrxcCt17MMyj11IsGusKlyAuhDkiWihaLkW8FkhrX4O3ZvcMzZMPgjGH
         xxcXuJMPnTJpFKvXLAZduoUGeqW/fUbexFD/0FHyq9qUM9wZH5u/RaOC1xTIWcvnveqB
         hwxCeLdhoHQg52rKIwc9rXDYdNQudvew/WBsPYxlYun4zU2EKxoGfdEgP5F0lPB9nnHp
         stX+167tsUlzC6Pu/vPn4Iz60ByKiDMtGPP/imHwL0OHg23B4T6nYcVqgCLpWm406hSr
         PrjHnIkIKglktM0gePHG9h5VD0yQgX+jblAxcVj2LB2i+JMaQcazYklcAHb0R4OVSXOO
         LnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937556; x=1722542356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ3tvD8Nb8fNSpovx5H8fGMVhMUJOvDNuyECpxv81jg=;
        b=K9hhZc10Opc3LCvIld9evrQazbTymOHBQ+DijPgU1cui610wdjjjENYAetHYj2vWYn
         3BdPS5C7R8Vuk4Uind7SIrQSnsG10geQuBe1dK5iDKW4G+t8Ddpjyw+jiUxeD9kvxO+1
         Ereu0bUTU/cgJZNXBl+CZ6mRCD4GoX4g7GiU7O/Gyu/0bNxYzwfDmnRVJqEDBn+aqBVQ
         ENiM6OZb5WmLmSpHjbphgmvteS3O0RaTTyfy6m4id28mzSjwwUahA5PluFsh4snE9Xgb
         m65Xa3AbPVv8knyVmD+ewkmJfpXUXxBxFOcGWcPXKbd17aTP6Cjaoul7BLwA19LjFYE7
         qPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz+QdYOkYS5HxYCCVNwIbGE420jrpw36sjAjkbTjABSXIawofXY6lXS7KOUbGsMHVhkKn45E9oOMYoWCUalEcJbgiR
X-Gm-Message-State: AOJu0YzK4f0XF3y9sqypBKkWZ9jIMRVjU7gkO7Qf82iravT83xTlTnyd
	TG39MlFidI9PeK+0gODo17VbJ2E7jk9Vrox4pJVpF/9i9Uo40Pr37N1/sOMWz6lyFDlpjeNbDDd
	VMO/XhyYKRvRlByaqG/WWEXiRNWU=
X-Google-Smtp-Source: AGHT+IH+fPJMw6P/FCDHkAW0fTmIC2nOPhUKibo8QSBSkNSZq8AjiBXXdneNoZidydWm9Wvn81AJQJlVxMC9jsnWJ6M=
X-Received: by 2002:a17:90b:314d:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2cf2eb8440bmr3272362a91.26.1721937555850; Thu, 25 Jul 2024
 12:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-3-andrii@kernel.org>
 <ZqI_KQl_Gq1Ego4-@krava>
In-Reply-To: <ZqI_KQl_Gq1Ego4-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 12:59:02 -0700
Message-ID: <CAEf4BzbaeL_j8+nqvdoGpnU54aPbf8em3=4hWNuwOf28pqRRGw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] lib/buildid: take into account e_phoff
 when fetching program headers
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Jul 24, 2024 at 03:52:02PM -0700, Andrii Nakryiko wrote:
> > Current code assumption is that program (segment) headers are following
> > ELF header immediately. This is a common case, but is not guaranteed. S=
o
> > take into account e_phoff field of the ELF header when accessing progra=
m
> > headers.
> >
> > Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> looks like this one never got in right?
>   https://lore.kernel.org/bpf/CAEf4BzaAKAwO=3D-=3D0qZQfkHhBodN0MQUHpL-RY7=
tCHdcFidjv-Q@mail.gmail.com/
>
> I couldn't find the place where you remove that check ;-)
>

yeah, I don't think that landed. And this patch set will supersede
that change with a proper support.

> jirka
>
> > ---
> >  lib/buildid.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 1442a2483a8b..ce48ffab4111 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -206,7 +206,7 @@ static int get_build_id_32(struct freader *r, unsig=
ned char *build_id, __u32 *si
> >  {
> >       const Elf32_Ehdr *ehdr;
> >       const Elf32_Phdr *phdr;
> > -     __u32 phnum, i;
> > +     __u32 phnum, phoff, i;
> >
> >       ehdr =3D freader_fetch(r, 0, sizeof(Elf32_Ehdr));
> >       if (!ehdr)
> > @@ -214,13 +214,14 @@ static int get_build_id_32(struct freader *r, uns=
igned char *build_id, __u32 *si
> >
> >       /* subsequent freader_fetch() calls invalidate pointers, so remem=
ber locally */
> >       phnum =3D ehdr->e_phnum;
> > +     phoff =3D READ_ONCE(ehdr->e_phoff);
> >
> >       /* only supports phdr that fits in one page */
> >       if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr)=
)
> >               return -EINVAL;
> >
> >       for (i =3D 0; i < phnum; ++i) {
> > -             phdr =3D freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(=
Elf32_Phdr));
> > +             phdr =3D freader_fetch(r, phoff + i * sizeof(Elf32_Phdr),=
 sizeof(Elf32_Phdr));
> >               if (!phdr)
> >                       return r->err;
> >
> > @@ -237,6 +238,7 @@ static int get_build_id_64(struct freader *r, unsig=
ned char *build_id, __u32 *si
> >       const Elf64_Ehdr *ehdr;
> >       const Elf64_Phdr *phdr;
> >       __u32 phnum, i;
> > +     __u64 phoff;
> >
> >       ehdr =3D freader_fetch(r, 0, sizeof(Elf64_Ehdr));
> >       if (!ehdr)
> > @@ -244,13 +246,14 @@ static int get_build_id_64(struct freader *r, uns=
igned char *build_id, __u32 *si
> >
> >       /* subsequent freader_fetch() calls invalidate pointers, so remem=
ber locally */
> >       phnum =3D ehdr->e_phnum;
> > +     phoff =3D READ_ONCE(ehdr->e_phoff);
> >
> >       /* only supports phdr that fits in one page */
> >       if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr)=
)
> >               return -EINVAL;
> >
> >       for (i =3D 0; i < phnum; ++i) {
> > -             phdr =3D freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(=
Elf64_Phdr));
> > +             phdr =3D freader_fetch(r, phoff + i * sizeof(Elf64_Phdr),=
 sizeof(Elf64_Phdr));
> >               if (!phdr)
> >                       return r->err;
> >
> > --
> > 2.43.0
> >
> >

