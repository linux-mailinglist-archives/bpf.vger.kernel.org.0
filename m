Return-Path: <bpf+bounces-36722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4894C618
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8031F21135
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8D15A84D;
	Thu,  8 Aug 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8ox80gK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91F8827
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150706; cv=none; b=av2X+NA56AXQ9dy7QKZZdt54CL2uGUSBFgU8uBFbjNKgZZJSxM8JZ2kcfVMWEBN9WmjKZ+1wb/f1TP/33Pw9fA2CovdiVqqVLbxz44Pm/grVz87/pdmllqrq4jf++mWmWNpRMsyGqqwXw41nu9pXchavDRCMOzMRMmkVHDZqB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150706; c=relaxed/simple;
	bh=IUpufb0nCT/oeTrgUx+1wfw7YZlmp0rRNgT99tf/McA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjdc1MddPdtjZZdI0D+qAg1pBk8B6Xk4QFZsYjqMmViC9F3X0RMH5P1F4jCERURO+FzHeyOMoacJ0yr71qyvpgdpgK25DBiF+VVr59VByAFLiaBbzkGkdf4CXrpltRydQmO8ohcsEPCgNhVj9TxAW9+XZmF5vaz7mIRdXQ8HmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8ox80gK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so3840a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723150703; x=1723755503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pegms3PnshsXX1UPyKLgluxFEHdbFiIeTyjYj44EsqA=;
        b=F8ox80gKZ6GhlbhooBIa1k29MWpPULA0pcrwwrZyecgEkqNQMFCSWonLttxF4Gb/k8
         9CGZ4/3VHB8Ab26AXKMCUxl8z6GKCgMWxUyHccKeb8N7Nt8jDKdPcIhF27BFCODJJwxQ
         YbaxQtE1OGp0/rebLNp5oL6T0b4XMJMXb8fHxF3gv5fB0oER26j63aeKN82KDX0AqxqS
         dGfaRQZReRsexxQB8jbshgVOpIl/rxhVa/tcGFwbWHzh+izM9kK7GGB7c8aLNSAQz0LM
         RKhmm3Ghc/Kt2bYqlsOoWBTuEL7uwjc/oLO1Bx++NuxZrjMejod0Nq8xW3kvElSyKpLN
         /tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150703; x=1723755503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegms3PnshsXX1UPyKLgluxFEHdbFiIeTyjYj44EsqA=;
        b=WlG7hFbsbPvg51wccJxLZssyboUzgRgJjF0ar7yQDZmwpXGZ9pLSpm++WvmjPhOrRV
         PkZlznHB2ZMy3LGfSo74sF+VJsVQ+DX2kngvvUu94oUUlC7AsiWt8coxRnDAwAiFJU5G
         5JvNUF4lGzj+5AWZRPtcrfnJUFx2K5FHNLtEvbuuv1DzeOBZf/tJCNeosmPpmd0rtSSQ
         90XxoRgVZDdqfep71VOY/tmXZH5f9qm0291KtBbZDJ69E5p097QAm1rlUHwepUpUCnsC
         IKUEnHA3u9DTUD1yX+GTXLjcdou893on80E3fmKjstixYT9KOF0VxIMcgNkloOB3oFAQ
         pUDg==
X-Forwarded-Encrypted: i=1; AJvYcCUkT/1mpA9B8i85hWPq+aocnaTIwRQFJ3cPbKmAtu4zljGoPO4Djt/T2GrSZVBDWSRvGpD1nL8GWKZDHkFDzFLl39VL
X-Gm-Message-State: AOJu0YxVIkbnANDt3Xw+Isay25QKNTcxEhD668KBVdrua+76TIT1Skqs
	EKctc2R90eQzGXo6doN8zEkR6vMhITpLiGiSN9DvZdDpmmppJi2x2SNXgKBcLG213ND+LRsfqk+
	1Iu0plnyTcAh8+y9yU1cZpobIbH0POcQYrWlW
X-Google-Smtp-Source: AGHT+IH8aF37EKz07qcuHYbuMvchUS9oPhD+wlLA9h7t5l//hLbBFSnsHQZjKvgmKTW7NxWgePGWOkwaJt1Vy/kNbxk=
X-Received: by 2002:a05:6402:2550:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5bc4b3fd4f9mr10721a12.1.1723150702346; Thu, 08 Aug 2024
 13:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-7-andrii@kernel.org>
 <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3> <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Aug 2024 22:57:43 +0200
Message-ID: <CAG48ez1SkqF7q+FydGcUunYMriG+rt8eWyJuSH8meaDAUJbECw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Aug 8, 2024 at 11:40=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Wed, Aug 07, 2024 at 04:40:25PM GMT, Andrii Nakryiko wrote:
> > > Extend freader with a flag specifying whether it's OK to cause page
> > > fault to fetch file data that is not already physically present in
> > > memory. With this, it's now easy to wait for data if the caller is
> > > running in sleepable (faultable) context.
> > >
> > > We utilize read_cache_folio() to bring the desired folio into page
> > > cache, after which the rest of the logic works just the same at folio=
 level.
> > >
> > > Suggested-by: Omar Sandoval <osandov@fb.com>
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  lib/buildid.c | 44 ++++++++++++++++++++++++++++----------------
> > >  1 file changed, 28 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/lib/buildid.c b/lib/buildid.c
> > > index 5e6f842f56f0..e1c01b23efd8 100644
> > > --- a/lib/buildid.c
> > > +++ b/lib/buildid.c
> > > @@ -20,6 +20,7 @@ struct freader {
> > >                       struct folio *folio;
> > >                       void *addr;
> > >                       loff_t folio_off;
> > > +                     bool may_fault;
> > >               };
> > >               struct {
> > >                       const char *data;
> > > @@ -29,12 +30,13 @@ struct freader {
> > >  };
> > >
> > >  static void freader_init_from_file(struct freader *r, void *buf, u32=
 buf_sz,
> > > -                                struct address_space *mapping)
> > > +                                struct address_space *mapping, bool =
may_fault)
> > >  {
> > >       memset(r, 0, sizeof(*r));
> > >       r->buf =3D buf;
> > >       r->buf_sz =3D buf_sz;
> > >       r->mapping =3D mapping;
> > > +     r->may_fault =3D may_fault;
> > >  }
> > >
> > >  static void freader_init_from_mem(struct freader *r, const char *dat=
a, u64 data_sz)
> > > @@ -63,6 +65,11 @@ static int freader_get_folio(struct freader *r, lo=
ff_t file_off)
> > >       freader_put_folio(r);
> > >
> > >       r->folio =3D filemap_get_folio(r->mapping, file_off >> PAGE_SHI=
FT);
> > > +
> > > +     /* if sleeping is allowed, wait for the page, if necessary */
> > > +     if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r=
->folio)))
> > > +             r->folio =3D read_cache_folio(r->mapping, file_off >> P=
AGE_SHIFT, NULL, NULL);
> >
> > Willy's network fs comment is bugging me. If we pass NULL for filler,
> > the kernel will going to use fs's read_folio() callback. I have checked
> > read_folio() for fuse and nfs and it seems like for at least these two
> > filesystems the callback is accessing file->private_data. So, if the el=
f
> > file is on these filesystems, we might see null accesses.
> >
>
> Isn't that just a huge problem with the read_cache_folio() interface
> then? That file is optional, in general, but for some specific FS
> types it's not. How generic code is supposed to know this?

I think you have to think about it the other way around. The file is
required, unless you know the filler function that will be used
doesn't use the file. Which you don't know when you're coming from
generic code, so generic code has to pass in a file.

As far as I can tell, most of the callers of read_cache_folio() (via
read_mapping_folio()) are inside filesystem implementations, not
generic code, so they know what the filler function will do. You're
generic code, so I think you have to pass in a file.

> Or maybe it's a bug with the nfs_read_folio() and fuse_read_folio()
> implementation that they can't handle NULL file argument?
> netfs_read_folio(), for example, seems to be working with file =3D=3D NUL=
L
> just fine.
>
> Matthew, can you please advise what's the right approach here? I can,
> of course, always get file refcount, but most of the time it will be
> just an unnecessary overhead, so ideally I'd like to avoid that. But
> if I have to check each read_folio callback implementation to know
> whether it's required or not, then that's not great...

Why would you need to increment the file refcount? As far as I can
tell, all your accesses to the file would happen under
__build_id_parse(), which is borrowing the refcounted reference from
vma->vm_file; the file can't go away as long as your caller is holding
the mmap lock.

