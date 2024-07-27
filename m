Return-Path: <bpf+bounces-35785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CE93DC8C
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FAF1F254EE
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADEC631;
	Sat, 27 Jul 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy0KpGF+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A217C
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722040027; cv=none; b=c77MlxF+krY6VCFCFmQfaPKNFNG1ge3YNd65+CiZJO0Je2Wy16mXnvbeCkcx1NBRpqflEHgEe9RPfrAj/92rJ49LBGeSBE76Bov4j4LKOijjETxhxAEulGt74acnR3UHu/SF3qnMotokFQzHawvOpgJb+ys3EuQWYF9UJ6F12F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722040027; c=relaxed/simple;
	bh=b2oI0bxDk8oDvLLuswqnuNjlZleNHevMbJlN8UZMjwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuHdLWnvu8BJ70Nt0bV7P57Qsk3RQj2kzCXMnHrVrP2gel6zLdxXPCPq0K8q9ND9Yd72QD5y2lDvG1J7m/pB/oy9+6TwlcALg8LiML7+PkppnlKubkfmPla69Iep2Z2we8JteVYq8aoYWcKpYiEumiJcoAOIDAqXSdA5Zisd1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy0KpGF+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cf78366187so381870a91.3
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 17:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722040026; x=1722644826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZVslHgRxr7Sb6YbmQOE3deeooZdwAiUr6jjd3nDqzY=;
        b=Vy0KpGF+Y6wguAdZs2iLvPq0KxK35mHqS2vZoTDk8mpDlLAFtcQU+xEBwTlUjjZ5NH
         n6lg8mHBQpmA1Wa1QPHfiOwmPHMu9UBLBjj2lf0WPIYifztltwqoRvXfmxGHJ0UPMygX
         psGCcOOoG76IxwDvJkggskxq+B3Sn4k0eMbyhv1PHJfAKLgP/H0yCOPH5PN+fE4iJw4C
         iLiC1u9u1G8gqSwViGBeQtO8E9SgUc9zFSWBRXrCAwTwqzvmdJA4kNmD2sjGQNXGUd8w
         iS8dPkExcyGofCKG1jJH87lbrHN+017zL51Hwb1uG1gNvqXx4PR/J+cuRU2mje5s/243
         jsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722040026; x=1722644826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZVslHgRxr7Sb6YbmQOE3deeooZdwAiUr6jjd3nDqzY=;
        b=JXQk8l12gjvo0/4VIn1u/TUlyqEYdSHHCzOdpNvnmM1HjWRlVK/MkLfkNJ4YyVQl6c
         A5ksn1x6zMlrM5TUQLaPolB7L+RJkADGjdvxq2ou4BtCEUXPDRiQFxTlwSevHZfQ7psf
         kwQFohC77NQkUl1HgSaQGYGo14e5+CQnuOv3xLuH5ewC5Xb4UKFH18H72d7lbbgHiuRE
         18B7mxeozTy2/JwOs5oN5a97pPQWDWeDAJ+qhHW70RVP/vFF5WPoqXaHVOpPHQb7cCRQ
         JPjui0gAkiyNBCvxR8avvaix1/4cZJyNiqZ/9qrNpEfAQzk+KnrWL/fiE/Kw0qem40EX
         skSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5RC2G6PxzgrbsyRzDYo27cd1r9vxO5HnBOzBaB1e1XPA7Sxd1hSQmPfuEEuMLC/XmpaXtQmu966IMnnJsW/xBq8Yv
X-Gm-Message-State: AOJu0YyXcgq/uUow3YxBVOo/Bh80OsMPGI81umymSO6po+HDPrjwrPqb
	mru3FafW7Tl4ZAXbU6u8Ij1cm2F9CTx1tyu0NVYe0ZR2o7AKmxJs4Rq6e4OwO+prqlH46Ow2x//
	2QG4GFysknQd3Bdt9WbYBhnWvjAg=
X-Google-Smtp-Source: AGHT+IEXbjNqCNF7Bv80FXmv140egJ8Ffiv94t8Z5VNaD0IjPZ8LIqbGGwPriclEvhNzBvbwdKH8yrWU9FzenFjQzqs=
X-Received: by 2002:a17:90a:134b:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2cf7e2167b1mr1318753a91.20.1722040025720; Fri, 26 Jul 2024
 17:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-2-andrii@kernel.org>
 <ZqLU_wQ41RI5syVY@tassilo>
In-Reply-To: <ZqLU_wQ41RI5syVY@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:26:53 -0700
Message-ID: <CAEf4BzavsRnj01PcFe4ez56h6yAerYfDyu=1JwqQnbMDuFQ1JA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/10] lib/buildid: add single page-based file
 reader abstraction
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:43=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > +static int freader_get_page(struct freader *r, u64 file_off)
> > +{
> > +     pgoff_t pg_off =3D file_off >> PAGE_SHIFT;
> > +
> > +     freader_put_page(r);
> > +
> > +     r->page =3D find_get_page(r->mapping, pg_off);
> > +     if (!r->page)
> > +             return -EFAULT; /* page not mapped */
> > +
> > +     r->page_addr =3D kmap_local_page(r->page);
>
> kmaps are a limited resource on true highmem systems
> (something like 16-32)
> Can you guarantee that you don't overrun them?

Sorry, what does "overrun" mean in this case? Note, my code doesn't
change anything about kmap_local_page() usage. We used to map one page
at a time, and my changes preserve this property. We never access many
pages at the same time.

>
> Some of the callers below seem to be in a loop.
>

Note how freader_get_page() will always call freader_put_page() first,
unmapping previously mapped page. So only one page at a time will be
mapped.

> You probably won't see any failures unless you test with real highmem.
> Given it's a obscure configuration these days, but with some of the
> attempts to unmap the page cache by default it might be back in
> mainstream.
>
> Also true highmem disables preemption, I assume you took that
> into account. If the worst case run time is long enough would
> need preemption points.

I don't think I did because I'm not sure what the above means, care to
elaborate? But I'll reiterate, fundamentally my changes don't change
any behavior for all the existing cases. And for sleepable mode we
only have a read_cache_folio() call which will bring the page into
page cache, and after that the rest of the logic is exactly the same
as in non-faultable mode.

>
> -Andi

