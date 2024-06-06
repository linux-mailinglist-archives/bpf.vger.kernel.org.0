Return-Path: <bpf+bounces-31521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CF8FF370
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F6E1F21D48
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085F1990CC;
	Thu,  6 Jun 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfHKPHd8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EEB198E7D
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694047; cv=none; b=OqEClCLFpbuvIwFEiLEQT6xfYJk9ZuSi3VAn5Q5l5wpztBl3XvP69gs9JhxaR16OdBaKqK4V/w1p/n9uLRqkt+LugruE9AgQMVw5juWLG3DujbVuWyx/zw7Naeyjsyqa1JfjyTn35zbTvuhhUrsouN+45I2Zbdummu3wB6ccyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694047; c=relaxed/simple;
	bh=3PcZbTSvMIet1KvRH/3UIizXiqdHfZwbn62ekU7BeTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKA6+rBRYeZ4R9uAtYj9669aQmX11JtcL1RgjjIwPUek38mxREU0mPb2rF/JQqw1nHHi/ncDOKj0yJ7u6YIBnmCXvP3Pj2D9LGe8SLYD9j6MsPM+4+8s4+9BIjsc/lLzsf/vWmVzkfF4P1O6fUZgQo0+1ICAs+Vs0GKRt5TQ67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfHKPHd8; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627ecda47d0so12472067b3.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717694045; x=1718298845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRK/mnhg9puUTTzwI/wwQsIKXT3wkOFAvZtn/HKANeU=;
        b=ZfHKPHd88/pQdXDhSx7rj+OQOYhlJT8Ziy+oVtQGDenFjzFnp1lY1uDONjpIbY6C6L
         T0SbIYjboXx1e02tAi3c3ZD3Gq+G2goZHggWjMm33l5djEuEPgfApdzrTlQsVSUKx1NT
         STiUjeurb7q9QslwoKoU9kU6oYDOqZkkXO+LgaFSf6sv3L/fTb5ekW0oqxuv34FoqNxA
         T5PcV+YIq8Lh/fwjRYzWA/oIS3a3kfdo+pTp/iOWhEUJXrhxNxbjCaYVw3m+oPnMl0pm
         qbpCxk7rC7UMkgI24mawWB4sAvdATgJ0ztfcCGzylZuwZLWS+CzpSmGIURkswJap463h
         4b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694045; x=1718298845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRK/mnhg9puUTTzwI/wwQsIKXT3wkOFAvZtn/HKANeU=;
        b=udLkkC3xXrLi7UTUVAACAjQvIgTYcnhcNktcOZ0hjLG1+9U8q0g1oXx6JhciDoFT23
         gZMg7hqbunDQIpHTQANpnCFrVrAjmid9vWDPrpcyvvuq7kBOCcWjnW8z/f0o/igzFGif
         XiUvDw4Qayij9UM0lYcjjIN+h7bP38xBNe/Z6m4Zp6Obdr5duPe//aZyt3J9k41JNyOt
         ra4P1j5hl9K2dDjr1+kLU0/Ct7K5ZB/IvkjyM5QpzJh+THKKk4yC+GzEFzSoV/64/8fY
         48l+tP94Tv563o3QjbFah7FogoqNrh+xslqMksSwha7k1wHneZli+7/CZdwCW3s5gp1u
         bOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3qeO2kigayIwLPm4viZdLFVnKdAWPUavfMzFeIn+kxeoONKqF+c/3VZY+oEfFAys+hQC4u+tOxEd42N28NzpGFntb
X-Gm-Message-State: AOJu0YxmKw4YB429lP6TpVzQKcFY8HSB988DCey2fTwg6DbKs2s3Bxv/
	yFtNfx6PWdfj+6UAUJmutls8pQVK3VpoHCWNiE/lXD9nzGiUM/7JSmSKjThoBvkiLvC+ZYOxrbe
	EnGds4mz4Cep+PKcMmnkspY5n3cNPum3goMZE
X-Google-Smtp-Source: AGHT+IE6g1Qt1a0uWEMeEkhuX3E8E0Aujra9U26A4am4FT81CMUGmJmJOs73aDziKCtCgxpH2azFXeJj7iJZZjlkoqQ=
X-Received: by 2002:a0d:d709:0:b0:615:1a0:78ea with SMTP id
 00721157ae682-62cbff3b0eamr45661767b3.34.1717694044790; Thu, 06 Jun 2024
 10:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org> <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
 <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com>
 <CAEf4BzYDhtkYt=qn2YgrnRkZ0tpa3EPAiCUcBkdUa-9DKN22dQ@mail.gmail.com>
 <CAEf4Bzbzj55LfgTom9KiM1Xe8pfXvpWBd6ETjXQCh7M===G5aw@mail.gmail.com>
 <5fmylram4hhrrdl7vf6odyvuxcrvhipsx2ij5z4dsfciuzf4on@qwk7qzze6gbt>
 <CAJuCfpER9qUSGbWBcHhT1=ssH41Xv8--XVA5BEPCM7uf=z_GLw@mail.gmail.com> <CAEf4Bzax2E1JS=MUm=sBJvcMb+CyWaPdxmr2mDuODs2cc3_mTg@mail.gmail.com>
In-Reply-To: <CAEf4Bzax2E1JS=MUm=sBJvcMb+CyWaPdxmr2mDuODs2cc3_mTg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Jun 2024 10:13:52 -0700
Message-ID: <CAJuCfpFKA9KChaunoYo-yH4GipvGjRpKqyneOhwi-E6n3Lfq3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 5, 2024 at 4:22=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Wed, Jun 5, 2024 at 10:03=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240605 12:27]:
> > > > On Wed, Jun 5, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jun 5, 2024 at 9:13=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Ho=
wlett@oracle.com> wrote:
> > > > > > >
> > > > > > > * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > > > > > > > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko w=
rote:
> > > > > > > > > +/*
> > > > > > > > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a=
 given address, or the
> > > > > > > > > + * next VMA. Search is done under RCU protection, withou=
t taking or assuming
> > > > > > > > > + * mmap_lock. Returned VMA is guaranteed to be stable an=
d not isolated.
> > > > > > > >
> > > > > > > > You know this is supposed to be the _short_ description, ri=
ght?
> > > > > > > > Three lines is way too long.  The full description goes bet=
ween the
> > > > > > > > arguments and the Return: line.
> > > > > >
> > > > > > Sure, I'll adjust.
> > > > > >
> > > > > > > >
> > > > > > > > > + * @mm: The mm_struct to check
> > > > > > > > > + * @addr: The address
> > > > > > > > > + *
> > > > > > > > > + * Returns: The VMA associated with addr, or the next VM=
A.
> > > > > > > > > + * May return %NULL in the case of no VMA at addr or abo=
ve.
> > > > > > > > > + * If the VMA is being modified and can't be locked, -EB=
USY is returned.
> > > > > > > > > + */
> > > > > > > > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_s=
truct *mm,
> > > > > > > > > +                                        unsigned long ad=
dress)
> > > > > > > > > +{
> > > > > > > > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > > > > > > > +   struct vm_area_struct *vma;
> > > > > > > > > +   int err;
> > > > > > > > > +
> > > > > > > > > +   rcu_read_lock();
> > > > > > > > > +retry:
> > > > > > > > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > > > > > > > +   if (!vma) {
> > > > > > > > > +           err =3D 0; /* no VMA, return NULL */
> > > > > > > > > +           goto inval;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   if (!vma_start_read(vma)) {
> > > > > > > > > +           err =3D -EBUSY;
> > > > > > > > > +           goto inval;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   /*
> > > > > > > > > +    * Check since vm_start/vm_end might change before we=
 lock the VMA.
> > > > > > > > > +    * Note, unlike lock_vma_under_rcu() we are searching=
 for VMA covering
> > > > > > > > > +    * address or the next one, so we only make sure VMA =
wasn't updated to
> > > > > > > > > +    * end before the address.
> > > > > > > > > +    */
> > > > > > > > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > > > > > > > +           err =3D -EBUSY;
> > > > > > > > > +           goto inval_end_read;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   /* Check if the VMA got isolated after we found it */
> > > > > > > > > +   if (vma->detached) {
> > > > > > > > > +           vma_end_read(vma);
> > > > > > > > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > > > > > > +           /* The area was replaced with another one */
> > > > > > > >
> > > > > > > > Surely you need to mas_reset() before you goto retry?
> > > > > > >
> > > > > > > Probably more than that.  We've found and may have adjusted t=
he
> > > > > > > index/last; we should reconfigure the maple state.  You shoul=
d probably
> > > > > > > use mas_set(), which will reset the maple state and set the i=
ndex and
> > > > > > > long to address.
> > > > > >
> > > > > > Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
> > > > > > address)` case, I presume we want to do the same, right? Basica=
lly, on
> > > > > > each retry start from the `address` unconditionally, no matter =
what's
> > > > > > the reason for retry.
> > > > >
> > > > > ah, never mind, we don't retry in that situation, I'll just put
> > > > > `mas_set(&mas, address);` right before `goto retry;`. Unless we s=
hould
> > > > > actually retry in the case when VMA got moved before the requeste=
d
> > > > > address, not sure, let me know what you think. Presumably retryin=
g
> > > > > will allow us to get the correct VMA without the need to fall bac=
k to
> > > > > mmap_lock?
> > > >
> > > > sorry, one more question as I look some more around this (unfamilia=
r
> > > > to me) piece of code. I see that lock_vma_under_rcu counts
> > > > VMA_LOCK_MISS on retry, but I see that there is actually a
> > > > VMA_LOCK_RETRY stat as well. Any reason it's a MISS instead of RETR=
Y?
> > > > Should I use MISS as well, or actually count a RETRY?
> > > >
> > >
> > > VMA_LOCK_MISS is used here because we missed the VMA due to a write
> > > happening to move the vma (rather rare).  The VMA_LOCK missed the vma=
.
> > >
> > > VMA_LOCK_RETRY is used to indicate we need to retry under the mmap lo=
ck.
> > > A retry is needed after the VMA_LOCK did not work under rcu locking.
> >
> > Originally lock_vma_under_rcu() was used only inside page fault path,
> > so these counters helped us quantify how effective VMA locking is when
> > handling page faults. With more users of that function these counters
> > will be affected by other paths as well. I'm not sure but I think it
> > makes sense to use them only inside page fault path, IOW we should
> > probably move count_vm_vma_lock_event() calls outside of
> > lock_vma_under_rcu() and add them only when handling page faults.
>
> Alright, seems like I should then just drop count_vm_vma_lock_event()
> from the API I'm adding.

That would be my preference but as I said, I'm not 100% sure about
this direction.

>
> >
> > >
> > > Thanks,
> > > Liam

