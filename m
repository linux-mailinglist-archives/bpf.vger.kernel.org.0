Return-Path: <bpf+bounces-31469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190898FDA66
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD511C21607
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688216FF2E;
	Wed,  5 Jun 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1c7TElA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BD168C0A
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629761; cv=none; b=QUMvijQ/dOa7vz3+a+T0HxiwnmWwsegxVZYjESuzikJ9tQZsfUPylIzuGjLT4gulb6SRtpNuGm/U1Le18lW+JwA2fp/41CI7rUcuQEDYyte37DFmOx+ikqcGQPLBTNaMXNxH//Ei4Twi/H4LCXFNKNQ+6Xa9C1FEaAzVi9bvh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629761; c=relaxed/simple;
	bh=VjQzXI18+qQG7Z7bgYqIEkcpDbiT6kmJveAjRT/fKpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=M3G8dReTxk6OnpUOE28ss0WdHitG4XAu4jdgZzEWYez+5xdHl3GsMzr0Vy4uUPdlWhM4oxH41h5bs84AJZbZIzcy+UGrLDQgVeRJqUOHaw+AXrUudVIBjqs8XL78N3boSiWyRv4/WbB4N0zYpQLPlUvVI+eciJK0Ze5d2EbFYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1c7TElA; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so421716276.1
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629759; x=1718234559; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw47IidnP2/eaju7UvZBzqOetg82MP8FWmgrm1mdRb4=;
        b=H1c7TElAkkGFLa3whvtNbDeJeqiBUThK8nY5g0i8VtX0dWJGjjcCuQGDBA7xtaK9iq
         Nse+ktQtaBMw9Y+5F47l1v3+Hvjp+PS9DS81QT8/kZ9DwHZo+RTwu7/dI2fB8UnapyLl
         qT+JwDSyc1k7DTRwN/Yd4BqRu0keo2cj4Mx2OEiE6leeXrv9s560m8eQIo3B691qgJeP
         ezoLKGXBcqMl6NfW/IWJ8mvMux0xvszx2BYG1g0DmV1tnij321Ua/b+tDbzkRE17eIo/
         YwBlWyh+pSjF6NAJvjjvPtTYsz8s6B0xKW6/JTND7iSnZ7i9fuIwKmVrhT/fSXHHipsx
         uR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629759; x=1718234559;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw47IidnP2/eaju7UvZBzqOetg82MP8FWmgrm1mdRb4=;
        b=nkSVKU7b9aKh1S/KTYLnMuESGaVqtUnXsHV+ZRtItEVkxvpAZyFckrEXXnWk9/g6dl
         02xaLlHGiRjKk9HmHhA81+Unu2CpQl2bgDEg870iL2/YVahEbdMEXALaTKsmZKFx376s
         W+mk52W9QlODkQZH6hbv/r2XyYUnuoG6b5EVtY0tBY5Jtq8GUM2v0OSX9yG+XgksSj1R
         QB01mVj12li2+CHM47WqCN0MvquK9KTXzdQfzmxU+Fn2TrXtIDk7Boc10Bw/yJC0bZIM
         LFBwNdkz379n+7XDKvZmlLBJz8KIpMpPUxBDlrdXrQcyehxS8AX8VmwcaD8eJL2VBbYj
         BA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5P6VtghQgRqn4xr8YLJI3Xz5H1vPGKQpYDPG593PsWAWoS5zvTWvYI7oGS4mNXQyDR916on8K5nUmyTXPsMsPcMYX
X-Gm-Message-State: AOJu0YwPSUOaFDOzy8jQ3MRoEI1Wa70Q0iJD/wXmQ3jU5AoHXOspZ5+d
	U14/w4koNzW3EuuyJFvqaUT6rPnPxNqleegf/KMbvhem9RQAgio9CxtAw3ghVejv5Bh02u2rPP0
	CKDqdDQESxuglDEMS/KSTIULXGjXfYhb/GprT
X-Google-Smtp-Source: AGHT+IHrmFvJ9bp9T7DdePm64tfrOr9ZbqYnpVOs/J0OmO5DpmHefsY4GHCM70DHHhs4RMyXVR80eW0h81Jh5Fi+/5A=
X-Received: by 2002:a05:6902:1793:b0:df7:923f:f2a4 with SMTP id
 3f1490d57ef6-dfacab2c208mr4276890276.7.1717629758331; Wed, 05 Jun 2024
 16:22:38 -0700 (PDT)
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
 <CAEf4Bzbzj55LfgTom9KiM1Xe8pfXvpWBd6ETjXQCh7M===G5aw@mail.gmail.com> <5fmylram4hhrrdl7vf6odyvuxcrvhipsx2ij5z4dsfciuzf4on@qwk7qzze6gbt>
In-Reply-To: <5fmylram4hhrrdl7vf6odyvuxcrvhipsx2ij5z4dsfciuzf4on@qwk7qzze6gbt>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Jun 2024 16:22:27 -0700
Message-ID: <CAJuCfpER9qUSGbWBcHhT1=ssH41Xv8--XVA5BEPCM7uf=z_GLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:03=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240605 12:27]:
> > On Wed, Jun 5, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Jun 5, 2024 at 9:13=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Howlet=
t@oracle.com> wrote:
> > > > >
> > > > > * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > > > > > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote=
:
> > > > > > > +/*
> > > > > > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a giv=
en address, or the
> > > > > > > + * next VMA. Search is done under RCU protection, without ta=
king or assuming
> > > > > > > + * mmap_lock. Returned VMA is guaranteed to be stable and no=
t isolated.
> > > > > >
> > > > > > You know this is supposed to be the _short_ description, right?
> > > > > > Three lines is way too long.  The full description goes between=
 the
> > > > > > arguments and the Return: line.
> > > >
> > > > Sure, I'll adjust.
> > > >
> > > > > >
> > > > > > > + * @mm: The mm_struct to check
> > > > > > > + * @addr: The address
> > > > > > > + *
> > > > > > > + * Returns: The VMA associated with addr, or the next VMA.
> > > > > > > + * May return %NULL in the case of no VMA at addr or above.
> > > > > > > + * If the VMA is being modified and can't be locked, -EBUSY =
is returned.
> > > > > > > + */
> > > > > > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struc=
t *mm,
> > > > > > > +                                        unsigned long addres=
s)
> > > > > > > +{
> > > > > > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > > > > > +   struct vm_area_struct *vma;
> > > > > > > +   int err;
> > > > > > > +
> > > > > > > +   rcu_read_lock();
> > > > > > > +retry:
> > > > > > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > > > > > +   if (!vma) {
> > > > > > > +           err =3D 0; /* no VMA, return NULL */
> > > > > > > +           goto inval;
> > > > > > > +   }
> > > > > > > +
> > > > > > > +   if (!vma_start_read(vma)) {
> > > > > > > +           err =3D -EBUSY;
> > > > > > > +           goto inval;
> > > > > > > +   }
> > > > > > > +
> > > > > > > +   /*
> > > > > > > +    * Check since vm_start/vm_end might change before we loc=
k the VMA.
> > > > > > > +    * Note, unlike lock_vma_under_rcu() we are searching for=
 VMA covering
> > > > > > > +    * address or the next one, so we only make sure VMA wasn=
't updated to
> > > > > > > +    * end before the address.
> > > > > > > +    */
> > > > > > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > > > > > +           err =3D -EBUSY;
> > > > > > > +           goto inval_end_read;
> > > > > > > +   }
> > > > > > > +
> > > > > > > +   /* Check if the VMA got isolated after we found it */
> > > > > > > +   if (vma->detached) {
> > > > > > > +           vma_end_read(vma);
> > > > > > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > > > > +           /* The area was replaced with another one */
> > > > > >
> > > > > > Surely you need to mas_reset() before you goto retry?
> > > > >
> > > > > Probably more than that.  We've found and may have adjusted the
> > > > > index/last; we should reconfigure the maple state.  You should pr=
obably
> > > > > use mas_set(), which will reset the maple state and set the index=
 and
> > > > > long to address.
> > > >
> > > > Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
> > > > address)` case, I presume we want to do the same, right? Basically,=
 on
> > > > each retry start from the `address` unconditionally, no matter what=
's
> > > > the reason for retry.
> > >
> > > ah, never mind, we don't retry in that situation, I'll just put
> > > `mas_set(&mas, address);` right before `goto retry;`. Unless we shoul=
d
> > > actually retry in the case when VMA got moved before the requested
> > > address, not sure, let me know what you think. Presumably retrying
> > > will allow us to get the correct VMA without the need to fall back to
> > > mmap_lock?
> >
> > sorry, one more question as I look some more around this (unfamiliar
> > to me) piece of code. I see that lock_vma_under_rcu counts
> > VMA_LOCK_MISS on retry, but I see that there is actually a
> > VMA_LOCK_RETRY stat as well. Any reason it's a MISS instead of RETRY?
> > Should I use MISS as well, or actually count a RETRY?
> >
>
> VMA_LOCK_MISS is used here because we missed the VMA due to a write
> happening to move the vma (rather rare).  The VMA_LOCK missed the vma.
>
> VMA_LOCK_RETRY is used to indicate we need to retry under the mmap lock.
> A retry is needed after the VMA_LOCK did not work under rcu locking.

Originally lock_vma_under_rcu() was used only inside page fault path,
so these counters helped us quantify how effective VMA locking is when
handling page faults. With more users of that function these counters
will be affected by other paths as well. I'm not sure but I think it
makes sense to use them only inside page fault path, IOW we should
probably move count_vm_vma_lock_event() calls outside of
lock_vma_under_rcu() and add them only when handling page faults.

>
> Thanks,
> Liam

