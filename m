Return-Path: <bpf+bounces-22028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84307855463
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 21:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E358B233FC
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB413A264;
	Wed, 14 Feb 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpkVotA7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47531128370
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944037; cv=none; b=JEiw+pkEoifGZfZz0q33OB76XqCdD0tN/p1O2lIKlnbCK05N3aaUXCjMgjApiyL26sVuF8mNtgylRMHAKUI8P/UKAFXjrB4CffFpbwqpElLEz+JrF3XVvq6oafYiQ3T5fCTWFv7VK3xZJqimIAIsLk9QXvcg/aB8ymFcji+J/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944037; c=relaxed/simple;
	bh=PivSf0FYd6Ne0NbzrTKkYgT5Nh1hREVA1zFjagHiHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXWVLkkQuwMMgcgnv7zy25zyu0zPBGMmJf2jB42ILNggpbyLPM9l5BU72U/CjILG9IGWvvXT12V8+E/sMR6y5Rll1HEX2g9A15iWjwbwaeLRGzUnmFuI56btQBQ0/yC+mwdG1UopResLSsbEy/DNRIUXYneEMp8uq4GtRWYkKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpkVotA7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ce55ab993so63939f8f.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707944034; x=1708548834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe2hn34Lmye40DJleY6hu+u5gVtFILc8D1dIEuP6Oeg=;
        b=PpkVotA7cVwZ30vdDN5ht3ckwlkdNzx0xWnC6an8Co92JbbzEkZoaMlKeoeQMMyCQx
         BhocmrJPW0H1tUR+IRoQT899ioxSFGXtSoQ56fWtvVciudUnwHvNP383y4oNkeCPbdWs
         9zTcba6nhYjtv+rCkEEGVM56Bb0nHPxsYjq3HSFEj1yUIWWMaQIbx1w1nN3qaOE3wB62
         uOvHhHvXEu7sFowoJl5dxo8fFpMk1aNEwO43/xcki3Z8rWoaVaplaTR8q6UDVcLjud6W
         MkjL8xVgUAdGl0/rIHohARb1vgTjc6NaWjmzOzBgcjB3gv4Ok5dBzMeyAH0YSWc143VV
         ou3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944034; x=1708548834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe2hn34Lmye40DJleY6hu+u5gVtFILc8D1dIEuP6Oeg=;
        b=MHgpZJQlK5dUWCPAxRE4R33CvK6hg5HPBreAbpINcUwBwS+1WUaZnNGLpXW5ciCtGO
         TF4TTKI9GKYRRgdFXC5SAjzOEIEPZ71Of18X+ODuG55ccEF0FN5rJ0ZgrtskpBsbmZyN
         6AV3QDP/L29IofIG3fNTKS7f6wbRukg+7EjodrHwN0Edy5u2LMMLkdx4hBwpQftFGtMu
         l+lHVtGyvdECRSm5wLIuRPpmRI7MbLjxzfp9oH1d8GDroi6ran+590nX7c9U+1HBhGx+
         CItUBiKfndDM4M27hRc39QlbfAItp3Tnl/Wq5e9M2nJg2Y9mYIxAmhyWGIK9MVYbfVlp
         wrCg==
X-Gm-Message-State: AOJu0YxQz6CPtA5t5f2KCYbxRXhtt1nff9NQn1UxwXS6oaWQYnL7zleH
	SkDebOOiv3BX8cWcZF1ktoXsmuqQCZjqtY2KdXd8ljU+SScY5P14B4xenphuK1aSHIixEhISKcR
	o8ZyzP2vB6VguSNH8AAhRgmihts4=
X-Google-Smtp-Source: AGHT+IGjrO30IfUr6L1g726G/SOGM5XgYh8KeFxxWlfBhOTn1VUg6r/0IWN2orJ8xTjz3YsZdJM7fl+XzzP3bvJi4CM=
X-Received: by 2002:a05:6000:118b:b0:33b:794a:8a79 with SMTP id
 g11-20020a056000118b00b0033b794a8a79mr2543650wrx.47.1707944034238; Wed, 14
 Feb 2024 12:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com> <Zcx7lXfPxCEtNjDC@infradead.org>
In-Reply-To: <Zcx7lXfPxCEtNjDC@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Feb 2024 12:53:42 -0800
Message-ID: <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:36=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> NAK.  Please

What is the alternative?
Remember, maintainers cannot tell developers "go away".
They must suggest a different path.

> On Thu, Feb 08, 2024 at 08:05:52PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > BPF would like to use the vmap API to implement a lazily-populated
> > memory space which can be shared by multiple userspace threads.
> > The vmap API is generally public and has functions to request and
>
> What is "the vmap API"?

I mean an API that manages kernel virtual address space:

. get_vm_area - external
. free_vm_area - EXPORT_SYMBOL_GPL
. vunmap_range - external
. vmalloc_to_page - EXPORT_SYMBOL
. apply_to_page_range - EXPORT_SYMBOL_GPL

and the last one is pretty much equivalent to vmap_pages_range,
hence I'm surprised by push back to make vmap_pages_range available to bpf.

> > For example, there is the public ioremap_page_range(), which is used
> > to map device memory into addressable kernel space.
>
> It's not really public.  It's a helper for the ioremap implementation
> which really should not be arch specific to start with and are in
> the process of beeing consolidatd into common code.

Any link to such consolidation of ioremap ? I couldn't find one.
I surely don't want bpf_arena to cause headaches to mm folks.

Anyway, ioremap_page_range() was just an example.
I could have used vmap() as an equivalent example.
vmap is EXPORT_SYMBOL, btw.

What bpf_arena needs is pretty much vmap(), but instead of
allocating all pages in advance, allocate them and insert on demand.

As you saw in the next patch bpf_arena does:
get_vm_area(4Gbyte, VM_MAP | VM_USERMAP);
and then alloc_page + vmap_pages_range into this region on demand.
Nothing fancy.

> > The new BPF code needs the functionality of vmap_pages_range() in
> > order to incrementally map privately managed arrays of pages into its
> > vmap area. Indeed this function used to be public, but became private
> > when usecases other than vmalloc happened to disappear.
>
> Yes, for a freaking good reason.  The vmap area is not for general abuse
> by random callers.  We have a few of those left, but we need to get rid
> of that and not add more.

What do you mean by "vmap area" ? The vmalloc virtual region ?
Are you suggesting that bpf_arena should reserve its own virtual region of
kernel memory instead of vmalloc region ?
That's doable, but I don't quite see the point.
Instead of VMALLOC_START/END we can carve a bpf specific region and
do __get_vm_area_node() from there, but why?
vmalloc region fits the best.
bpf_arena's mm manipulations don't interfere with kasan either.

Or you meant vm_map_ram() ? Don't care about those. bpf_arena doesn't
touch that.

