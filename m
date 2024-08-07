Return-Path: <bpf+bounces-36639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18194B3D3
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3451C20FEF
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358BD155CA0;
	Wed,  7 Aug 2024 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScTqb9DT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724E146000
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074248; cv=none; b=r1aL5tj1zir1odiqEE8OJFZ+yYZVRHWo4hsZEI4mDUjago91fevwIf9qCqb2CVOkBaUQFeYPTe5RbJylRxu2rsZ1OCPl5zB19UU/+84XPVI6RBcmh8LefGSQwZOsARptHxHPqbJX8jMpzrEGFS4rAX71V0DQDSRjYZAgb1DZ3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074248; c=relaxed/simple;
	bh=J8QJ3x9sZasWBcCHrKyM6zKKHohRdQkxVKF+pTsi+fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnf5Xo0D0WdD7Xkgmgu+PjehceMZRe38FCb7atapSUtQ8AIn31TPLImDEZeD0s58TybN6vXK4W0oqb1pppv6N1qGMr7JRq3dVJKGFiBq0fXPdsnT5MH8R82Lw5NoEdtTAImb6lnJQ7Wn6k9/qcz6sSsHL/sperG8JbW5rXr6tPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScTqb9DT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so1093279a91.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723074246; x=1723679046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f+dtfw+7i5jhoszsY0akrqamOWUNCouxC0/QrMKOvU=;
        b=ScTqb9DTqPFRz1LXVsX7x7v4Et/xLh8gNbgr0NPiG+s046RhiqScTFFmiOIUGE5Asp
         x55Jk7+8WboCAFfaTWzGPncxUwJCOkwTTqVoiorh031YcKG2+ObbcyJl1fpt9o+gfH+B
         xxDZh5Jo8kyi/HjEGosoCVUNT1FO+8TMmeEt2BoSyCdWe08qAha0R4pSCeqNQM6x/ZnZ
         8D2lCRjYrjZhFeouTBPK6c7Ofvdcqjns0BCe/JOZSfqM7Jt4geeyrDYjFD2phjHNvbO3
         ohA49h7VpjIPcAShHxoTcLkl37KyKF3OC+My52IgZi4hD0fVpm9IMb/dDu5DpTPp0xdD
         ZmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723074246; x=1723679046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f+dtfw+7i5jhoszsY0akrqamOWUNCouxC0/QrMKOvU=;
        b=uDuB2S4EZLiW3OW50CSTgidZnHNC7OKjaq1voeYScfp181WFGTRE3LLaA3Nvmw5AA4
         gafRlxIZHITKxIyLXoMle4xL3VjIlqBYK8PUR0t7u6eOtSQMsg/BaCLSNwgy9QDO9E1Q
         JqWflKTAxbuYdNWfURXhJ+yDBEMGZIt/hL4yr9gCFs4+DsllrSvcqAvQL39gpiuudFv9
         bvLj2gTY70x/mQUltem+5NJSFeZS+AlmMJdlLbKiqEg9577F1w9KdQ95lS6UNEtQjk/h
         e/Dsp6RwdoyjgIjlRMRKNzU3L+8U0/aMG7SvIok9azbKMfeQ570GUTgtzV71yN30MeLu
         5PoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUczyZz3F9abEXqvs7Sb0+l56st6XX0QuFvJZzqq/jj5ZifteIEsxKT8XL6tOMgEw+CT5an0yj/TELU5ghhFTjkod4l
X-Gm-Message-State: AOJu0YwsywH1gzNPlxcDTRR3EJQz1OkiXlBtEk6s02N8CF/kIzisTNVO
	wATfdi2FTYajJGfL1jkrF5bill7eVHhNaaWCm9HnOgaAMX5H0BYYNVHDiQ3ri8O4KI4znAE/kAl
	4I/UUNSEZ1ZU+NoXARlbZnysd4cQ=
X-Google-Smtp-Source: AGHT+IGh+vkiO3soiUFietbjFLXa8O10nOdNCjjspsiJ/8Do8wZixe1neHcNazjvuFEGnYaHXdzTjR9kcv2D7nM7wls=
X-Received: by 2002:a17:90a:718c:b0:2c9:7f8b:f7d8 with SMTP id
 98e67ed59e1d1-2d1c37b56e3mr201470a91.6.1723074246572; Wed, 07 Aug 2024
 16:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730203914.1182569-1-andrii@kernel.org> <20240730203914.1182569-3-andrii@kernel.org>
 <ZrOStYOrlFr21jRc@casper.infradead.org> <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>
 <ZrOy2GFv5KDmFlZt@casper.infradead.org> <n2y5rk74ynongpvbpbsnjzghskmw337bexf2ftcf2fnrgk3knn@3u322cnvwpcm>
 <66tqr5zljbeeaz2dcdkzlgndfzx6cyklee4kydve6ktwckt25f@gx54qvvtubn7>
In-Reply-To: <66tqr5zljbeeaz2dcdkzlgndfzx6cyklee4kydve6ktwckt25f@gx54qvvtubn7>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 16:43:54 -0700
Message-ID: <CAEf4BzZ41kL65urDVUGR9t3dT6DjPvQCqsrYerNRRLGK6rbC8A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based file
 reader abstraction
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:53=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Wed, Aug 07, 2024 at 10:54:08AM GMT, Shakeel Butt wrote:
> > On Wed, Aug 07, 2024 at 06:46:00PM GMT, Matthew Wilcox wrote:
> > > On Wed, Aug 07, 2024 at 10:19:11AM -0700, Shakeel Butt wrote:
> > > > On Wed, Aug 07, 2024 at 04:28:53PM GMT, Matthew Wilcox wrote:
> > > > > On Tue, Jul 30, 2024 at 01:39:06PM -0700, Andrii Nakryiko wrote:
> > > > > > +     union {
> > > > > > +             struct {
> > > > > > +                     struct address_space *mapping;
> > > > > > +                     struct page *page;
> > > > >
> > > > > NAK.  All the page-based interfaces are deprecated.  Only we can'=
t mark
> > > > > them as deprecated because our tooling is a pile of crap.
> > > > >
> > > > > > +                     void *page_addr;
> > > > > > +                     u64 file_off;
> > > > >
> > > > > loff_t pos.
> > > > >
> > > > > > +     r->page =3D find_get_page(r->mapping, pg_off);
> > > > >
> > > > > r->folio =3D read_mapping_folio(r->mapping, r->pos / PAGE_SIZE, .=
..)
> > > > >
> > > > > OK, for network filesystems, you're going to need to retain the s=
truct
> > > > > file that's used to access them.  So maybe this becomes
> > > > >         read_mapping_folio(r->file->f_mapping, r->pos, r->file)
> > > >
> > > > This code path can be called from non-sleepable context. What would=
 be
> > > > the appropriate way to get the folio in that case?
> > >
> > > There isn't.  If there's no folio, or the folio isn't uptodate, we ne=
ed
> > > to sleep to wait for I/O.  We can't busy-wait for I/O.
> > >
> >
> > Failure is fine if there is no folio or the folio is not uptodate. I
> > assume we can do:
> >
> >       folio =3D __filemap_get_folio(r->mapping, pg_off, 0, 0);
> >       if (!folio || !folio_test_uptodate(folio))
> >               return -EFAULT;
>
> And a folio_put(folio) if we return due to !folio_test_uptodate().
>

Ok, did the conversion, thanks Shakeel and Matthew for the help. Sent v4.

> >
> > Is this appropriate here?

