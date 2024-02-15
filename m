Return-Path: <bpf+bounces-22104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B07856EE4
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9CB2421F
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84813B2A9;
	Thu, 15 Feb 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVjnTr4Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4023D0
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030271; cv=none; b=b0RkUIlkH4uezhqPQQaXMGtZrT7MKW29Y4wtPEOdifq2BHL/GRPS+mRCU47+k8vzXtRJzYah2+exVf2j5xZdKhW5QDBw8H1MEJ7bNbQa/X5BQf8f9NDf3BC5TAW8r23nVgF2eff8MHvawksr7Q9zszn1EeoYn5HgCchei2VZl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030271; c=relaxed/simple;
	bh=CN3QDZcmK6IUQcx4HF1P7zaLuLQMU8OLCTs+h9oxVuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSqVjbDMA8J9dWoNUUhLmXWqaTdBPUhKV2pDIGgHDir3xBT6DNJVRtq0dq/7ztZ5QciwEwsjQoRrpawEEpYS/IsGsLg9nFUxq5FyOVLH3XF4+YkZCafguIHM4g6dvNcPmVLqmPC9vv/EBlKg+TBDAW4ylOBD3/JPB0NiMfPfaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVjnTr4Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-410e820a4feso13892985e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708030268; x=1708635068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCQCkGfwLZq3s4Iau/1AjCFP8ny+xskYknnBBlXlkxY=;
        b=hVjnTr4ZS2TEqw01XH+XTBjK7oPkrgdqVzIKkiJnU2Xq1r1+jMP9B/30Oxjjxf9nve
         GcbqiwD8NzRT12RBbdMQ6hJDGzZkiXL6xeJV7rXYW0pikvAMZ2FYhzU/9QXTgVW3kzUJ
         1LI/V2VeeSzpfr3gdVJEXsIjS8ROhhmWyJTvZFvmsQVrVOFgG/sr9Zdc4AMezAIM0qvd
         sJYLSB0eLjLZggtuyGkknwYIadScfoDo5YKWfi692cRWLHhb5B0WghZx8puyb8lfd9xo
         AlApNNCgWVY/F4llRKoiN0Mozl6e4i6HNctgy3IkLezMM1nvR+Wtx8Hi6j6u00oXSLSr
         MVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030268; x=1708635068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCQCkGfwLZq3s4Iau/1AjCFP8ny+xskYknnBBlXlkxY=;
        b=jc9/GXU+XVBZQthrxxl4qCgn2r4QaQnWd2417nMrVZgUw7A1nTmY+VBWNzYuCtw8rG
         LMjVOs7XpzHq9cm/ZXPpiw3bo3qs8AV7s0euGD3v8FLV1KuDNMpHLdIvjXNQTwHgXwp9
         HXq6THZ4hpW+Gjp1EbyEyvFZO9NB9IEbrq7NTyuFHr3ckmlIdab75mpoXwfeGc6myjhq
         rCU0PWUPaQPsBDcNwHOovojpINe/p4JMMKNJd7C+Z2e4gUqsZdQL1JoezU4QFxsOfJme
         da3AqEjIXbPFN3eNm1Iy1+sntW9oTafpnxNBuV4yprGOzPP4fXdJFVZ31fEBZxOeBYJb
         gMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnMXobF5Q5rxP8oq/7YxanP26alfWcY36eTcq6m/mQ1bzAK4BXb6rLXqFiMi9sjttA+bxx3hTCo6rpc/5H1YXZalbw
X-Gm-Message-State: AOJu0YxLuXFHNjlYfcuvIiWqonOc/KpxYeYDL8X203Km32X64PNqw7Lz
	NswSf0eJA25XxZ62Ic6ACadyfiDg7nBvzlayxx/nPTpswtO1/w2QntSqzrxGklxgH3ljm7PD8mb
	1eSgSgTizm11tkEgNIlL88CNlnUg=
X-Google-Smtp-Source: AGHT+IEPnGsvbr1tJTG+gyyqiI3Y8G+EwvxKkP5fkOEAuVU78C4KIW2X18viQCnsXyibS/aviqAE7uV5AWjleP3wzIE=
X-Received: by 2002:a5d:544f:0:b0:33b:69ef:dfb with SMTP id
 w15-20020a5d544f000000b0033b69ef0dfbmr2478786wrv.14.1708030267421; Thu, 15
 Feb 2024 12:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com> <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com> <Zc22DluhMNk5_Zfn@infradead.org>
In-Reply-To: <Zc22DluhMNk5_Zfn@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Feb 2024 12:50:55 -0800
Message-ID: <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:58=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Wed, Feb 14, 2024 at 12:53:42PM -0800, Alexei Starovoitov wrote:
> > On Wed, Feb 14, 2024 at 12:36=E2=80=AFAM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> > >
> > > NAK.  Please
> >
> > What is the alternative?
> > Remember, maintainers cannot tell developers "go away".
> > They must suggest a different path.
>
> That criteria is something you've made up.

I didn't invent it. I internalized it based on the feedback received.

> Telling that something
> is not ok is the most important job of not just maintainers but all
> developers.

I'm not saying that maintainers should not say "no",
I'm saying that maintainers should say "no", understand the problem
being solved, and suggest an alternative.

> Maybe start with a description of the problem you're
> solving and why you think it matters and needs different APIs.

bpf_arena doesn't need a different api. These 5 api-s below are enough.
I'm saying that vmap_pages_range() is equivalent to apply_to_page_range()
for all practical purposes.
So, since apply_to_page_range() is available to the kernel
(xen, gpu, kasan, etc) then I see no reason why
vmap_pages_range() shouldn't be available as well, since:

struct vmap_ctx {
     struct page **pages;
     int idx;
};

static int __for_each_pte(pte_t *ptep, unsigned long addr, void *data)
{
     struct vmap_ctx *ctx =3D data;
     struct page *page =3D ctx->pages[ctx->idx++];

     /* TODO: sanity checks here */
     set_pte_at(&init_mm, addr, ptep, mk_pte(page, PAGE_KERNEL));
     return 0;
}

static int vmap_pages_range_hack(unsigned long addr, unsigned long end,
                                 struct page **pages)
{
    struct vmap_ctx ctx =3D { .pages =3D pages };

    return apply_to_page_range(&init_mm, addr, end - addr,
__for_each_pte, &ctx);
}

Anything I miss?

> > . get_vm_area - external
> > . free_vm_area - EXPORT_SYMBOL_GPL
> > . vunmap_range - external
> > . vmalloc_to_page - EXPORT_SYMBOL
> > . apply_to_page_range - EXPORT_SYMBOL_GPL
> >
> > and the last one is pretty much equivalent to vmap_pages_range,
> > hence I'm surprised by push back to make vmap_pages_range available to =
bpf.
>
> And the last we've been trying to get rid of by ages because we don't
> want random modules to

Get rid of EXPORT_SYMBOL from it? Fine by me.
Or you're saying that you have a plan to replace apply_to_page_range()
with something else ? With what ?

> > > > For example, there is the public ioremap_page_range(), which is use=
d
> > > > to map device memory into addressable kernel space.
> > >
> > > It's not really public.  It's a helper for the ioremap implementation
> > > which really should not be arch specific to start with and are in
> > > the process of beeing consolidatd into common code.
> >
> > Any link to such consolidation of ioremap ? I couldn't find one.
>
> Second hit on google:
>
> https://lore.kernel.org/lkml/20230609075528.9390-1-bhe@redhat.com/T/

Thanks.
It sounded like you were referring to some future work.
The series that landed was a good cleanup.
No questions about it.

> > I surely don't want bpf_arena to cause headaches to mm folks.
> >
> > Anyway, ioremap_page_range() was just an example.
> > I could have used vmap() as an equivalent example.
> > vmap is EXPORT_SYMBOL, btw.
>
> vmap is a good well defined API.  vmap_pages_range is not.

since vmap() is nothing but get_vm_area() + vmap_pages_range()
and few checks... I'm missing the point.
Pls elaborate.

> > What bpf_arena needs is pretty much vmap(), but instead of
> > allocating all pages in advance, allocate them and insert on demand.
>
> So propose an API that does that instead of exposing random low-level
> details.

The generic_ioremap_prot() and vmap() APIs make sense for the cases
when phys memory exists with known size. It needs to vmap-ed and
not touched after.
bpf_arena use case is similar to kasan which
reserves a giant virtual memory region, and then
does apply_to_page_range() to populate certain pte-s with pages in that reg=
ion,
and later apply_to_existing_page_range() to free pages in kasan's region.

bpf_arena is very similar, except it currently calls get_vm_area()
to get a 4Gb+guard_pages region, and then vmap_pages_range() to
populate a page in it, and vunmap_range() to remove a page.

These existing api-s work, so not sure what you're requesting.
I can guess many different things, but pls clarify to reduce
this back and forth.
Are you worried about range checking? That vmap_pages_range()
can accidently hit an unintended range?

btw the cover letter and patch 5 explain the higher level motivation
from bpf pov in detail.
There was a bunch of feedback on that patch, which was addressed,
and the latest version is here:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=3Dare=
na&id=3Da752b4122071adb5307d7ab3ae6736a9a0e45317

