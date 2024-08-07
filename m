Return-Path: <bpf+bounces-36581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C155294AC97
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF69B25148
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A484A3F;
	Wed,  7 Aug 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0EY+Li6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AB52F62
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043845; cv=none; b=g+adt9o/MD850F7uSsabzlyfnRIhD+tXqqODu3XeEnbb3iWk+4vhD/NO28D4+qCK64PMkizGMWDI2ZGpT5mvs/VzKuR7xspEki1inP/sx8SMFDUSre5/ZzGSVDe58in61EfcwgEkXDMGj8Dc9UKsceWwuk+wseACnLlzj7V1Eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043845; c=relaxed/simple;
	bh=x0Ad+XhZEhWD3J/beOH52wZ6RFoTFutDLE5eK6GNdgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPlwb0cp+VmE/wyF490l2FVPoNCJCJJsOht2nCoAO4vJUjNLW0Hpfkl5V+WazrCSikeBcqWJiqHccnG5kossGsEYRvDW50ufsi+4TaTit/Nq8a07usiiXfi/nkSVmLyNHQ3VwygGOFFhTYQrFaUHK+Oodqpz3SZx9b3OY/9sjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0EY+Li6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7bd16405aa7so843375a12.3
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723043844; x=1723648644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPXsr7wgbmEqkcgSaa/o6rT3cXl1QiUnFFeQ/JJjN60=;
        b=A0EY+Li6QLKFhM8+o+uOuCYJvNi0Fq16ISnu5FjuB5KPUs8QYmBtv+N9Okv0X8V/aW
         Rt77w06B7JYNaaa5afev5y8UblJ1mBmClRpZfaqdHDT11mDCHzfn1SGY9ioB//GKn1PA
         w1/V/Hq1LAyF4wDykYHMJDn0XXP2JAiJioPY3xEAu2LCOsh43m7dSyZNEUjsBFX0ym40
         QJC0gkWeiXhnkzO3GRdt61RYCHBt8wpCGuWlUfqXm2N6YoymzsGUpgsv3hlQhoKJXrAD
         ABE5p77Xx0AvHhtqfgv4tXYiTEKCwTSv54ocNOLv4XksWD7w784Rynciya4OPBi8Zw5U
         Mrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723043844; x=1723648644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPXsr7wgbmEqkcgSaa/o6rT3cXl1QiUnFFeQ/JJjN60=;
        b=ZG1lD+VVOjECEJxsmxuSpUJ8UXB0TLP4EmS3IvFWeB/cj4lmHLapjwrzMFXuEp8fdK
         CLtQqYNKkLFBsLqR0s5aeCReZ4lSjgD3NCHut2TlMeB9XjoGNy010VwAg08dWQ1NWFC3
         mewfG16D++N+S4m4Opz/9S/3HaYmw3hgu8VTQG5UYRN6ElbTotL6jGaZ+y95tef/fiLr
         rZBig4KDDePJnS7xQ2g+4YybqxKO3aHNOrW4uOMsDkF4U0CFGnUttCnHvR3xguuEh6M3
         UTSSZEGsTl3jo71+UkgW8cIO2WthgqZo3JFJOxnzcN1l99HhD/6pi29i33wTRoj2hp67
         WXmA==
X-Forwarded-Encrypted: i=1; AJvYcCXWc27w1NGqNNencoBrLTAAZXkaXiK+WiY15XbhRANs/XZpAycJVP53C/kAwO+1q1oJ6JDinIGdIdJYS/ThjELj4Yp5
X-Gm-Message-State: AOJu0YxwoV07mNu6rJobzHyN0jN6W5eKHJUeXVC/y6IoxgLBQBe2qUUz
	i/ZgAY2ERfBYaNidunV/ZcCJS1YYQYk9OO0DE8UH+9mtvanhWF5VxBUz1IPQgy48O2JC/jkqB8p
	cToRg+N4Eugq8pTiS6uz9l2RgAs8sSA==
X-Google-Smtp-Source: AGHT+IEo3NA46piNiTLR1MrB1mP3i7ITbMIuvVSYGwU5ZPxCIjubVAxJSnR686vkjWZFOgLJAaia/J/wuWcIcyzYDhU=
X-Received: by 2002:a17:90a:898b:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cff93c8ebbmr18490722a91.6.1723043843626; Wed, 07 Aug 2024
 08:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806230319.869734-1-andrii@kernel.org> <ZrM5ZKXwjKiWjRk9@krava>
In-Reply-To: <ZrM5ZKXwjKiWjRk9@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 08:17:11 -0700
Message-ID: <CAEf4BzZb_-Rw9miDyb8+ABT9siK7eUeigiKaLqch9DDz0EBSbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl
 if available
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Aug 06, 2024 at 04:03:19PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> >  ssize_t get_uprobe_offset(const void *addr)
> >  {
> > -     size_t start, end, base;
> > -     char buf[256];
> > -     bool found =3D false;
> > +     size_t start, base, end;
> >       FILE *f;
> > +     char buf[256];
> > +     int err, flags;
> >
> >       f =3D fopen("/proc/self/maps", "r");
> >       if (!f)
> >               return -errno;
> >
> > -     while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &=
base) =3D=3D 4) {
> > -             if (buf[2] =3D=3D 'x' && (uintptr_t)addr >=3D start && (u=
intptr_t)addr < end) {
> > -                     found =3D true;
> > -                     break;
> > +     /* requested executable VMA only */
> > +     err =3D procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTAB=
LE, &start, &base, &flags);
> > +     if (err =3D=3D -EOPNOTSUPP) {
> > +             bool found =3D false;
> > +
> > +             while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end=
, buf, &base) =3D=3D 4) {
> > +                     if (buf[2] =3D=3D 'x' && (uintptr_t)addr >=3D sta=
rt && (uintptr_t)addr < end) {
> > +                             found =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +             if (!found) {
> > +                     fclose(f);
> > +                     return -ESRCH;
> >               }
> > +     } else if (err) {
> > +             fclose(f);
> > +             return err;
>
> I feel like I commented on this before, so feel free to ignore me,
> but this seems similar to the code below, could be in one function

Do you mean get_rel_offset()? That one is for data symbols (USDT
semaphores), so it a) doesn't do arch-specific adjustments and b)
doesn't filter by executable flag. So while the logic of parsing and
finding VMA is similar, conditions and adjustments are different. It
feels not worth combining them, tbh.

>
> anyway it's good for follow up
>
> there was another selftest in the original patchset adding benchmark
> for the procfs query interface, is it coming in as well?

I didn't plan to send it, given it's not really a test. But I can put
it on Github somewhere, probably, if it's useful.

>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
> >       }
> > -
> >       fclose(f);
> >
> > -     if (!found)
> > -             return -ESRCH;
> > -
> >  #if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF =3D=3D 2
> >
> >  #define OP_RT_RA_MASK   0xffff0000UL
> > @@ -307,15 +371,25 @@ ssize_t get_rel_offset(uintptr_t addr)
> >       size_t start, end, offset;
> >       char buf[256];
> >       FILE *f;
> > +     int err, flags;
> >
> >       f =3D fopen("/proc/self/maps", "r");
> >       if (!f)
> >               return -errno;
> >
> > -     while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &=
offset) =3D=3D 4) {
> > -             if (addr >=3D start && addr < end) {
> > -                     fclose(f);
> > -                     return (size_t)addr - start + offset;
> > +     err =3D procmap_query(fileno(f), (const void *)addr, 0, &start, &=
offset, &flags);
> > +     if (err =3D=3D 0) {
> > +             fclose(f);
> > +             return (size_t)addr - start + offset;
> > +     } else if (err !=3D -EOPNOTSUPP) {
> > +             fclose(f);
> > +             return err;
> > +     } else if (err) {
> > +             while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end=
, buf, &offset) =3D=3D 4) {
> > +                     if (addr >=3D start && addr < end) {
> > +                             fclose(f);
> > +                             return (size_t)addr - start + offset;
> > +                     }
> >               }
> >       }
> >
> > --
> > 2.43.5
> >
> >

