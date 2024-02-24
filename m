Return-Path: <bpf+bounces-22628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F688620E1
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 01:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BA21C22BF8
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1B1B943;
	Sat, 24 Feb 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5xUdsUU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77C2208E
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732826; cv=none; b=lKhbzZko+D3t7j09OiI5+DvmV1H0yz3UIDYzcYTXP/GrCxbmmVyHbSQ6/WeZpF0xuQ18CfhaiJVNAU7rSLNWttht/FQEFQzVfkAnVOmVbVoDbFP4IPHb7JiGsVkuZV11MWxOj6J7LXOO0E1uVTmlo01qCpWSowREqeYs4K3e/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732826; c=relaxed/simple;
	bh=CedyO4qTxjui0CvlBtcat+crnvBaFE7tlTuKVKpuxBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMEm2eT4CbjmuyIRok6P/wvRtNVeswODNGU4gSc22hA7w646+av+Kg4/0n9mano57r/0C8W9NrcVeNC8FHeizRT4SmoTgSfRVQXDtF0QyaqSNie98RWFe5yxCN6jGjXKcs9rzPifMOKydML1cbjcUG/yizYZGR+cjGdtPPu9yFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5xUdsUU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33da6f289cfso595208f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732823; x=1709337623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiH/ihU5kJ28qnwGKZlb7XOE+rqx3GPdjJ0oq03/PCg=;
        b=D5xUdsUUX7Lty4O5t5zJ8RWOTi9rMKwOvJ0ehHShD88zT83mjR19tcAWVZjHOwPsrF
         f/rP9SqnPPfGsLGrS6uUqOGf2IHuJEnkw9ZHf9v9DcDmjLInuqka1fT/pJhH3sTgFKRH
         u5N6Fy+2wvwE0ETdQXCoDv7W66pLwActsfN9VTFgUgTzqGk3wyS8TztUMKjAxg+Ftzco
         cr0s1tcFJtY8WqwfKqUrx9S23pGggHcg7Qd7QrxVkRG5T02HSFtC9i2tV6hm5MUiim00
         4aalcDSvJi/kY+Q3fOqgfKsJIjrEqW98eOaChptU63sWu8e3lkN+T4X3sBHPlmJn6Qzo
         abCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732823; x=1709337623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiH/ihU5kJ28qnwGKZlb7XOE+rqx3GPdjJ0oq03/PCg=;
        b=tw3w1hzTjoq2GDisRGSBV+FlEaqsU2FlrzdIKYHIHeTUC25BGbqCoZaI8Prqimoae8
         39aCqP96UxEPXMVkCan0VF8TEWaMjCic0KSBkkGa5YbS90G2UMEvM5BelGo6/kenxZvO
         0fSi/S3Xd2d8nM7nQOgH98611rQw0iJQfBc2y5HRsuRdhfKqf85AQ2SG6TjANve9mSwN
         /9csYcj/STk0T47sy0lOmD5KP2Td2Wz29harB3lS2CB4+X9fwoWFmcQMPoqLasFLGwwr
         PmogzJpieRfwxA8MPwUFnMuiAjs+oXwXXFzJsehGBCnSjO/dj+Zb6uit2UQr0OLWSW5F
         efkw==
X-Gm-Message-State: AOJu0YwCSMy1JV3mp3iNL/Ie64ARsF6GsxkmvzLygn+svp50+lP/8OgB
	ksGV+WFQMfbFiuG/lsews0+zaFvqrZqB4O4OB9IiRseSNhwKZ1m8IwumZUTfWaYpSFiuJs3AHMj
	reesi5IQZ5BUpxqB2kGB2QxuDhYU=
X-Google-Smtp-Source: AGHT+IH699flScwkheJ3wEzd2dyMtC9M3LPD8Oi75txvNVSFcIXgutW1JFu5ook/d/KJrmFht6YchTZZZUySbo2elKo=
X-Received: by 2002:adf:f783:0:b0:33d:23a6:56ba with SMTP id
 q3-20020adff783000000b0033d23a656bamr678786wrp.42.1708732822639; Fri, 23 Feb
 2024 16:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
 <ZdWPjmwi8D0n01HP@infradead.org> <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
 <CAADnVQKmLnqA5W=kt8UL=z_H2nHDGjAq+w30XrU8r5Nt6ZrbQg@mail.gmail.com>
In-Reply-To: <CAADnVQKmLnqA5W=kt8UL=z_H2nHDGjAq+w30XrU8r5Nt6ZrbQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Feb 2024 16:00:11 -0800
Message-ID: <CAADnVQKEehARpXE78CFq8M7iP-QjwPs+81EvtuGjG3VvHnf0xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 3:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> >
> > I can give it a shot.
> >
> > The ugly part is bpf_map_get_memcg() would need to be passed in somehow=
.
> >
> > Another bpf specific bit is the guard pages before and after 4G range
> > and such vm_area_alloc_pages() would need to skip them.
>
> I've looked at this approach more.
> The somewhat generic-ish api for mm/vmalloc.c may look like:
> struct vm_sparse_struct *area;
>
> area =3D get_sparse_vm_area(vm_area_size, guard_size,
>                           pgoff_offset, max_pages, memcg, ...);
>
> vm_area_size is what get_vm_area() will reserve out of the kernel
> vmalloc region. For bpf_arena case it will be 4gb+64k.
> guard_size is the size of the guard area. 64k for bpf_arena.
> pgoff_offset is the offset where pages would need to start allocating
> after the guard area.
> For any normal vma the pgoff=3D=3D0 is the first page after vma->vm_start=
.
> bpf_arena is bpf/user shared sparse region and it needs to keep lower 32-=
bit
> from the address that user space received from mmap().
> So that the first allocated page with pgoff=3D0 will be the first
> page for _user_ vma->vm_start.
> Hence for kernel vmalloc range the page allocator needs that
> pgoff_offset.
> max_pages is easy. It's the max number of pages that
> this sparse_vm_area is allowed to allocate.
> It's also driven by user space. When user does
> mmap(NULL, bpf_arena_size, ..., bpf_arena_map_fd)
> it gets an address and that address determines pgoff_offset
> and arena_size determines the max_pages.
> That arena_size can be 1 page or 1000 pages. Always less than 4Gb.
> But vm_area_size will be 4gb+64k regardless.
>
> vm_area_alloc_pages(struct vm_sparse_struct *area, ulong addr,
>                     int page_cnt, int numa_id);
> is semantically similar to user's mmap().
> If addr =3D=3D 0 the kernel will find a free range after pgoff_offset
> and will allocate page_cnt pages from there and vmap to
> kernel's vm_sparse_struct area.
> If addr is specified it would have to be >=3D pgoff_offset
> and page_cnt <=3D max_pages.
> All pages are accounted into memcg specified at vm_sparse_struct
> creation time.
> And it will use maple tree to track all these range allocation
> within vm_sparse_struct.
>
> So far it looks like the bigger half of kernel/bpf/arena.c
> will migrate to mm/vmalloc.c and will be very bpf specific.
>
> So I don't particularly like this direction. Feels like a burden
> for mm and bpf folks.
>
> btw LWN just posted a nice article describing the motivation
> https://lwn.net/Articles/961941/
>
> So far doing:
>
> +#define VM_BPF                 0x00000800      /* bpf_arena pages */
> or VM_SPARSE ?
>
> and enforcing that flag where appropriate in mm/vmalloc.c
> is the easiest for everyone.
> We probably should add
> #define VM_XEN 0x00001000
> and use it in xen use cases to differentiate
> vmalloc vs vmap vs ioremap vs bpf vs xen users.

Here is what I had in mind:
https://lore.kernel.org/bpf/20240223235728.13981-1-alexei.starovoitov@gmail=
.com/

