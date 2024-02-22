Return-Path: <bpf+bounces-22538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54138606F2
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 00:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF211C23410
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229621A06;
	Thu, 22 Feb 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4yL4kGS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F21C680
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644340; cv=none; b=u8Ey2a5MU+dVJsEhdwvtesLrWdziqc/Fll4IzLp80FdHvjDMApU5KpNTDFx3zWLYAf2u5uYTYA5QPMGYgJBcuZI7aP+AJaoHewTD28USerMyGyAurweHjQITtnMqVyjGUNETJOuPxEef9oUNtLBlXCY82lztsYvhIb/oc4C8U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644340; c=relaxed/simple;
	bh=LgVDPESHHMVPG1egMCScsh2tERZKPPjam84/FKQQAHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEu5Fiwt1GXcEKC17jbChV89ZG4EdYcuhkN/fCtqZR+3+sb/uvGnI8rmOd4ELbN7jOzBBxAnW4Pj8VzTSSz8JpKt3lZayE1TUOm3eqHcmh2PO5mJsEwGBHO27cBrUIn7DpdTNOBJTx/KdYiRtLn6yTXTcToOxCZigRO6NBHCEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4yL4kGS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412730c6228so2201575e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708644337; x=1709249137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTnT6Ri/VO+YLhq9bpz5XsPmPtihKEI64RnnmcAnKno=;
        b=i4yL4kGSpZ4C5pYVf+6nL8ew0lI6wGj5m3eAkwweKDvpURnLUPtSFpPsyDF68CLkPv
         NVH4KXuHwIZQJe6MM87DvHUPQXZCYS0/NKDkD+1B1m+csSTaqXc/YoIB5QixsD3Quzgw
         T2cMt0yQ5ZByP+JaD1WNwoPhD1mxw0IoVG9KKKt7oYPpyrkD28ljk6WxJ/giFlqQI+0A
         q1X7zgXwziuxC2XJzNAAxVlv9scZSHyR7n6JjN7joBQPhujA81XcMF7kEJukz14TDYEg
         C9j6bCOHaACz5L4XeU2unK4hisg+D4gxWq466UZAGVosepCMihOdYRnASUOoENlUeALV
         d80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708644337; x=1709249137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTnT6Ri/VO+YLhq9bpz5XsPmPtihKEI64RnnmcAnKno=;
        b=B8iETP1AXXAVryg4jKyOzuqajbzhcCH+77OvjzCYKxIao83zKJEBvaqEsu6WPSzv6b
         lLRCp2mctD8ClBAJU2PPLK6cqphbHUE3EHH3ApndsGXux8xy2SDDUTkNzXPgEMfF6c16
         iHWcxrvIGlUbKkzTUl7WpIM/5TQhhyFS09qqEOl9W6H49LX1pZwLwI52WhSU758oKzGz
         TzvqUzdJzYkNQ9hgBMd0uNfShKMMzrmuZz3UaaYx3OktA+r6I8D18w+oRGa8RIGHelht
         i906eLRhxN1lBeSvpU+j4iOL1HPM4kWVIkKL6qTmgG803qTWXB22EPddBC7+FOBETZQC
         /9rQ==
X-Gm-Message-State: AOJu0Yx+xf/C1k7PlatzcReYO4ctVz5rAZVx+PmurHxCefT13npCIJN7
	IJj2J5V3HPZiE/v73tTFkjffpgrhLW0hkN/SVrbx6CXirsy7Z11tDNXRwI1GvZVFQbj8+SlWCkz
	LIbVwkYx8wS9+obdaBkwwOAali00=
X-Google-Smtp-Source: AGHT+IHu9zkmPBePtbZyJ3jZfNepFYeSlseu8Bqm8yP2Lr+/xqzeg8ZtCOi4jmRA0Wg31Gf89YOYFVtLVkIv6qHHPaw=
X-Received: by 2002:a5d:6346:0:b0:33d:3a0e:9168 with SMTP id
 b6-20020a5d6346000000b0033d3a0e9168mr328625wrw.3.1708644336979; Thu, 22 Feb
 2024 15:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
 <ZdWPjmwi8D0n01HP@infradead.org> <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
In-Reply-To: <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 15:25:25 -0800
Message-ID: <CAADnVQKmLnqA5W=kt8UL=z_H2nHDGjAq+w30XrU8r5Nt6ZrbQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 20, 2024 at 9:52=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Tue, Feb 20, 2024 at 11:26:13AM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > vmap() API is used to map a set of pages into contiguous kernel virtu=
al space.
> > >
> > > BPF would like to extend the vmap API to implement a lazily-populated
> > > contiguous kernel virtual space which size and start address is fixed=
 early.
> > >
> > > The vmap API has functions to request and release areas of kernel add=
ress space:
> > > get_vm_area() and free_vm_area().
> >
> > As said before I really hate growing more get_vm_area and
> > free_vm_area outside the core vmalloc code.  We have a few of those
> > mostly due to ioremap (which is beeing consolidate) and executable code
> > allocation (which there have been various attempts at consolidation,
> > and hopefully one finally succeeds..).  So let's take a step back and
> > think how we can do that without it.
>
> There are also xen grant tables that grab the range with get_vm_area(),
> but manage it on their own. It's not an ioremap case.
> It looks to me the vmalloc address range has different kinds of areas
> already: vmalloc, vmap, ioremap, xen.
>
> Maybe we can do:
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 7d112cc5f2a3..633c7b643daa 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -28,6 +28,7 @@ struct iov_iter;              /* in uio.h */
>  #define VM_MAP_PUT_PAGES       0x00000200      /* put pages and free
> array in vfree */
>  #define VM_ALLOW_HUGE_VMAP     0x00000400      /* Allow for huge
> pages on archs with HAVE_ARCH_HUGE_VMALLOC */
> +#define VM_BPF                 0x00000800      /* bpf_arena pages */
>
> +static inline struct vm_struct *get_bpf_vm_area(unsigned long size)
> +{
> +       return get_vm_area(size, VM_BPF);
> +}
>
> and enforce that flag in vm_area_[un]map_pages() ?
>
> vmallocinfo can display it or skip it.
> Things like find_vm_area() can do something different with such an area
> (if that was the concern).
>
> > For the dynamically growing part do you need a special allocator or
> > can we just go straight to the page allocator and implement this
> > in common code?
>
> It's a bit special allocator that is using maple tree to manage
> range within 4G region and
> alloc_pages_node(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT)
> to grab pages.
> With extra dance:
>         memcg =3D bpf_map_get_memcg(map);
>         old_memcg =3D set_active_memcg(memcg);
> to make sure memcg accounting is done the common way for all bpf maps.
>
> The tricky bpf specific part is a computation of pgoff,
> since it's a shared memory region between user space and bpf prog.
> The lower 32-bits of the pointer have to be the same for user space and b=
pf.
>
> Not much changed in the patch since the earlier thread.
> Either find it in your email or here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=3Da=
rena&id=3D364c9b5d233d775728ec2bf3b4168fa6909e58d1
>
> Are you suggesting the api like:
>
> struct vm_struct *area =3D get_sparse_vm_area(size);
> vm_area_alloc_pages(struct vm_struct *area, ulong addr, int page_cnt,
> int numa_id);
>
> and vm_area_alloc_pages() will allocate pages and vmap_pages_range()
> them while all code in mm/vmalloc.c ?
>
> I can give it a shot.
>
> The ugly part is bpf_map_get_memcg() would need to be passed in somehow.
>
> Another bpf specific bit is the guard pages before and after 4G range
> and such vm_area_alloc_pages() would need to skip them.

I've looked at this approach more.
The somewhat generic-ish api for mm/vmalloc.c may look like:
struct vm_sparse_struct *area;

area =3D get_sparse_vm_area(vm_area_size, guard_size,
                          pgoff_offset, max_pages, memcg, ...);

vm_area_size is what get_vm_area() will reserve out of the kernel
vmalloc region. For bpf_arena case it will be 4gb+64k.
guard_size is the size of the guard area. 64k for bpf_arena.
pgoff_offset is the offset where pages would need to start allocating
after the guard area.
For any normal vma the pgoff=3D=3D0 is the first page after vma->vm_start.
bpf_arena is bpf/user shared sparse region and it needs to keep lower 32-bi=
t
from the address that user space received from mmap().
So that the first allocated page with pgoff=3D0 will be the first
page for _user_ vma->vm_start.
Hence for kernel vmalloc range the page allocator needs that
pgoff_offset.
max_pages is easy. It's the max number of pages that
this sparse_vm_area is allowed to allocate.
It's also driven by user space. When user does
mmap(NULL, bpf_arena_size, ..., bpf_arena_map_fd)
it gets an address and that address determines pgoff_offset
and arena_size determines the max_pages.
That arena_size can be 1 page or 1000 pages. Always less than 4Gb.
But vm_area_size will be 4gb+64k regardless.

vm_area_alloc_pages(struct vm_sparse_struct *area, ulong addr,
                    int page_cnt, int numa_id);
is semantically similar to user's mmap().
If addr =3D=3D 0 the kernel will find a free range after pgoff_offset
and will allocate page_cnt pages from there and vmap to
kernel's vm_sparse_struct area.
If addr is specified it would have to be >=3D pgoff_offset
and page_cnt <=3D max_pages.
All pages are accounted into memcg specified at vm_sparse_struct
creation time.
And it will use maple tree to track all these range allocation
within vm_sparse_struct.

So far it looks like the bigger half of kernel/bpf/arena.c
will migrate to mm/vmalloc.c and will be very bpf specific.

So I don't particularly like this direction. Feels like a burden
for mm and bpf folks.

btw LWN just posted a nice article describing the motivation
https://lwn.net/Articles/961941/

So far doing:

+#define VM_BPF                 0x00000800      /* bpf_arena pages */
or VM_SPARSE ?

+static inline struct vm_struct *get_bpf_vm_area(unsigned long size)
+{
+       return get_vm_area(size, VM_BPF);
+}
and enforcing that flag where appropriate in mm/vmalloc.c
is the easiest for everyone.
We probably should add
#define VM_XEN 0x00001000
and use it in xen use cases to differentiate
vmalloc vs vmap vs ioremap vs bpf vs xen users.

Please share your opinions.

