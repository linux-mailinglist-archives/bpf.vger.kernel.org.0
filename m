Return-Path: <bpf+bounces-55092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE82A781C0
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACDF18878C1
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65F20E704;
	Tue,  1 Apr 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt/XCq46"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE02040A4;
	Tue,  1 Apr 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530176; cv=none; b=co3WmLfthnPaioYk0Pfz6YzqiBlJ93I7UFdPS2yaeXcaH37t/SxpT30e5zvR4a/UDdzPzow8823VtJeYrXmX93hWDjNBgOB0/zIINdzZZH9jzYLHWJfQG9UzV7X1/9KXtFK9TTIm2rTwHthjFX2a4wMOfNwDMYC30bP3BLiBdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530176; c=relaxed/simple;
	bh=kEFZ0qL+4WbXdu8Z39Yov3/kFwVnqQgH05OqDzYvmc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDgjrdUQAb+t0m7RagTnVOZ9xklYFfiFq5FzboIP/42h6fDbI/eH/IGNsuf1uokHAH/GLe/M6QM/uizW8sJSp+XjHwh/BowdUneNUgoQ9RHgGpmX4pE69kXMzlNuDroIZssnsiBqoL73vWIhj60hIIVXPER5FS8Rb6yioubmKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt/XCq46; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913b539aabso3441051f8f.2;
        Tue, 01 Apr 2025 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743530173; x=1744134973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnZjQeYj2LLXe/FrVuXN/KbBh9xE11zWRiQKWx4CyHE=;
        b=jt/XCq46Y1VGaNePJCAz8i6Rr2rKZYwFXs6d6u6Hk6MMEvFAX2s2zvV1YdXom1gHnW
         3/kcZpRyF9fDMb2UqrgCHvSwszLEVI53fE2xKQ73zjJ+zMMYGA/G9hfbbk2z8PjQww7E
         eCptStZYxUmHw0TvRGSfyntwLaBPe4rHwEMl1GUYi9F8OcN3WKmcAk7VomLQwvNKLtrZ
         45ykLmVlgUQfMAhnds1071GIjhD28LdDD7Xiy9egkfjNqPK2rsdGAuzzb0caxQPCAmKI
         ikEMF+btxaynCMEmJrrMU0Z/33vOTqEyg6kLNn8R+stnXpW8XNG1GAoPxe55UmlF7i3Y
         QlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743530173; x=1744134973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnZjQeYj2LLXe/FrVuXN/KbBh9xE11zWRiQKWx4CyHE=;
        b=Y6UXPINn3oEPtVMnMo7zAReEZSev81D+n2NSwVIZAoLX0NjPEiRZuDlHrL5aEPH32O
         wou9aGfuAQ/JfksRldZ/Vpf5afNdsu+cYrSPkWOlqvI1cwjtdvEXhDdcJ2Ozhr8tXa+S
         9wcQ5+yMKGjsOyGbdHOaspBZTzcZHFCei2vTtGZAd1Tn/Qexb0/9nHo7+JUT10sLe67a
         DXhPIHg088xSpZh3QMdqFUnHW3peZe2ZcNGWqELCoO+i6TmCq0WSF2i7eVINCHvZ/71a
         6rDN57wDUTNOtl84L9kasbM6dIisa4QUxFq+ey8qP9j06yAFWJHsKVQ+m6bkFychE/ix
         x2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVRRAHE5TeGxGuyVRANMTreq+elfByW1J1R9zcDyGBzKmuEcdGrFJFCyq/9YVG+gHfrMrZ3nusDHGLV2sX+@vger.kernel.org, AJvYcCXUWJkFS0VgkgdQ8+UU72WAZTXE0FR0clb8rlLqLsk3e/tO4hdDo/Ut/PZPAa9gJNTZWEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqbYt2OCTGXsiS9JzMe0dc8Lbij4BkEx61dGJcymgt93KMXib
	2eZsWL3hHg/8sRbRPr7Tj/v12IQhw9pERIBQU/Ahzoiuce0VYeQQC+qfvmiFcmdjSuKJ2Z8s8fE
	KTyl1I4CzMgNL6LZQ37c77jNaL4U=
X-Gm-Gg: ASbGncum3FIpqInZmBshBOSOypNXXQKm4yylJrK0BA0kj33ehj9zFefyOrBXKQsRbtQ
	l/b6Pr5IAAmkIfGzFNGwi4C7+2/bS/ILVYBG9n6FzqbHdyxiyn/UuZkCm5ELo2tjUdODtZJxREP
	Ujenj8xbRr6vwZIvQGAY8Uh1mrYeNIrk9G9+j+uXo4HQ==
X-Google-Smtp-Source: AGHT+IFzfUSEb75OsKQYHv7fgivDskA5ZsjPwpoHrgBTWYRxdn2mQeWDAIpd7Au+TQQ7SWEMu/IKY+qgtaRQWPCIvrs=
X-Received: by 2002:a05:6000:402b:b0:390:f0ff:2c1c with SMTP id
 ffacd0b85a97d-39c120db3e9mr11031750f8f.18.1743530173239; Tue, 01 Apr 2025
 10:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401032336.39657-1-alexei.starovoitov@gmail.com> <ac5d6544-32cb-4ae1-a62a-7720b67b4042@suse.cz>
In-Reply-To: <ac5d6544-32cb-4ae1-a62a-7720b67b4042@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Apr 2025 10:56:02 -0700
X-Gm-Features: AQ5f1Jq-kAcgv3xIHuOMI8hzI-DQEU0M8qCQ7379ddqZEo2RjuAZytHtwhm1jSo
Message-ID: <CAADnVQ+V_RAMfM9GLfMq4pyAM6xaSnUQ2sqS0oisDZmaWvC5Uw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Fix try_alloc_pages
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 12:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 4/1/25 05:23, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Fix an obvious bug. try_alloc_pages() should set_page_refcounted.
> >
> > Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportun=
istic page allocation")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Vlastimil BAbka <vbabka@suse.cz>
>
> > ---
> >
> > As soon as I fast forwarded and rerun the tests the bug was
> > seen immediately.
> > I'm completely baffled how I managed to lose this hunk.
>
> I think the earlier versions were done on older base than v6.14-rc1 which
> acquired efabfe1420f5 ("mm/page_alloc: move set_page_refcounted() to call=
ers
> of get_page_from_freelist()")

ohh. Thanks.
Still, I have no excuse for not doing full integration testing.
I will learn this hard lesson.

> > I'm pretty sure I manually tested various code paths of
> > trylock logic with CONFIG_DEBUG_VM=3Dy.
> > Pure incompetence :(
> > Shame.
> > ---
> >  mm/page_alloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index ffbb5678bc2f..c0bcfe9d0dd9 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7248,6 +7248,9 @@ struct page *try_alloc_pages_noprof(int nid, unsi=
gned int order)
> >
> >       /* Unlike regular alloc_pages() there is no __alloc_pages_slowpat=
h(). */
> >
> > +     if (page)
> > +             set_page_refcounted(page);
>
> Note for the later try-kmalloc integration, slab uses frozen pages now, s=
o
> we'll need to split out a frozen variant of this API.

Thanks for the heads up.

> But this is ok as a bugfix for now.
>
> > +
> >       if (memcg_kmem_online() && page &&
> >           unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) !=
=3D 0)) {
> >               free_pages_nolock(page, order);
>

