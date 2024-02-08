Return-Path: <bpf+bounces-21565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C91384EE14
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A41C23A94
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28E5026E;
	Thu,  8 Feb 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHFyiEAF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080C4F1EE
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436545; cv=none; b=nztTom0atIJFSfGBYHZ2XF6UbDuO1dDMTz8UCe/3t77H/iL+GbmvX1pAst10Sum+8fopsjhVafNc7JrPKZEeTM/nhL7kahT4rcSlrkMd2+/5qdPcDCEDfy/TRsfDN6gLQr5EHRmKFiDln6kI+AfUddItG16pV+hsj3oSihDLEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436545; c=relaxed/simple;
	bh=cOwD9fsxjkKCfa1uqxYbAiELsTdDI2nsWm37wiJ3YbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+K6zzUYPCnbHH/RDI4Vver0aRTldIhsxS+qOwE8Zpf/bgiQVCeZzbnyMFms0exmJPNLAz9SaP5ObEjj8XiQTeSMjhKNvZRBMUDDkwjXiFGf4yhjAtidTIt8kjtkcnjd2WeSIv9By1Sjmai2OF5+akxd963p00rt+DHPHjx6sZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHFyiEAF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so172791f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707436542; x=1708041342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOwD9fsxjkKCfa1uqxYbAiELsTdDI2nsWm37wiJ3YbE=;
        b=lHFyiEAFNeFWdNkfXGGrZuWuKWYCPUxZ2OtbEG4KK862ksyN4TfAmk3tr/qSiLLtmZ
         v0JUQhcBKjTFx4tFgHW/r5apt5MVBW6bcSN98FwWZHQyX1J5ZDVyDRezHMX5X68JZj57
         EMk3SlRv+vkn3NJD/uxjs3M5D8UjvZAu3ppOGdfWVjUBzE6yT9cQ7HSKMtmK7dHGjQJc
         W5Zw1V3PQg784HYMa0pxuL+sx0Mhgosio5Hqe01t6IIybmVLZHE+U6pj1Xrvg7honiJl
         DiZeUzxavILotAQDzr2SfqFoG9cGlyIRyb9rlC+C4pClQgWlLqe4uu9GdcDV2lE+wIaF
         fFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707436542; x=1708041342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOwD9fsxjkKCfa1uqxYbAiELsTdDI2nsWm37wiJ3YbE=;
        b=wibAxEOus2lQlb7vWjXgaqY2TqcLs7+OPzPrJTW1MiN7r7vdJqWYhQdagBaFn8jZWv
         HPbvIRALAbFdH6fp/1LMKRIBjfu+FmZXITsXOP6ykRtglBZpCx6MZW4jx/tWjnKwpiqp
         7CNF80vyulKUBr9zi5WLetRTZgB90PiMb4GcNgJGhz39vf4hed3z2rmCBwGzliG652s7
         jxSQg8NpUH/5GWgnZkDEqGjdUweFMipWTfTxIS4oHZ6L8V/59wSRAFOJmPZRrhOFOCCD
         RSLkzG91jnvke/LV3jjfmOvemFvK/e0eDVQ6zOlt2J0ib7et4Vs5ezyqcg3aAS5NzM08
         o7LA==
X-Forwarded-Encrypted: i=1; AJvYcCWtMAy9bLxlF2y4adtDDZZxv2BLLvu9iSHWNwCssoJ0/l42jUECq5mrKfNVdmyv5YYgI1tQgwSBY3ADVmwic15lYzbc
X-Gm-Message-State: AOJu0YylkltVNMjj9bZHblgchwdguTuwQfGIKEEFncNujNHR7piU80V7
	2saNWDd8y2HKX6UxHAf7RaKwPiKZCXsGgU7Pn4fRIXgnHnAhWG6CUI3tC+1sdGgwUzg6xiGujPB
	Q8eAvRSK+4oJlpp1itUEgS7KXAhg=
X-Google-Smtp-Source: AGHT+IH2ozbJe/5f/985gljgNrdsyqP2YJhO0Zsg4x1ggNQll0eahn1s6qo42LHHos5gUtcpiRJJdjC4iTZP+mOX4NQ=
X-Received: by 2002:a5d:4a8d:0:b0:33b:2332:75af with SMTP id
 o13-20020a5d4a8d000000b0033b233275afmr611606wrq.36.1707436542072; Thu, 08 Feb
 2024 15:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-4-alexei.starovoitov@gmail.com> <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
 <20240208054435.GD185687@cmpxchg.org>
In-Reply-To: <20240208054435.GD185687@cmpxchg.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 15:55:30 -0800
Message-ID: <CAADnVQ+HtCsvCt8EyW7TVP0Chai-EBEdDzogqNJ2nzNrN88S7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest
 of the kernel.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:44=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Feb 07, 2024 at 09:07:51PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Feb 06, 2024 at 02:04:28PM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > The next commit will introduce bpf_arena which is a sparsely populate=
d shared
> > > memory region between bpf program and user space process.
> > > It will function similar to vmalloc()/vm_map_ram():
> > > - get_vm_area()
> > > - alloc_pages()
> > > - vmap_pages_range()
> >
> > This tells me absolutely nothing about why it is justified to expose th=
is
> > internal interface. You need to put more explanation here along the lin=
es
> > of 'we had no other means of achieving what we needed from vmalloc beca=
use
> > X, Y, Z and are absolutely convinced it poses no risk of breaking anyth=
ing'.
>
> How about this:
>
> ---
>
> BPF would like to use the vmap API to implement a lazily-populated
> memory space which can be shared by multiple userspace threads.
>
> The vmap API is generally public and has functions to request and
> release areas of kernel address space, as well as functions to map
> various types of backing memory into that space.
>
> For example, there is the public ioremap_page_range(), which is used
> to map device memory into addressable kernel space.
>
> The new BPF code needs the functionality of vmap_pages_range() in
> order to incrementally map privately managed arrays of pages into its
> vmap area. Indeed this function used to be public, but became private
> when usecases other than vmalloc happened to disappear.
>
> Make it public again for the new external user.

Thank you Johannes!
You've said it better than I ever could.
I'll replace my cryptic commit log with the above in v2.

>
> ---
>
> > I mean I see a lot of checks in vmap() that aren't in vmap_pages_range(=
)
> > for instance. We good to expose that, not only for you but for any othe=
r
> > core kernel users?
>
> Those are applicable only to the higher-level vmap/vmalloc usecases:
> controlling the implied call to get_vm_area; managing the area with
> vfree(). They're not relevant for mapping privately-managed pages into
> an existing vm area. It's the same pattern and layer of abstraction as
> ioremap_pages_range(), which doesn't have any of those checks either.

