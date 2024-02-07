Return-Path: <bpf+bounces-21431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FC84D34B
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC01B266F8
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA0200AE;
	Wed,  7 Feb 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFZ8K1dp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC52127B45
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339330; cv=none; b=RQyDBiAX/DiK5PmlFPyLKklpgI4GKm4UCZB5Y67LrEM7YtCAaQ1bYhYMLgmqlzSb5LpBPo3D2in8zfFMKSCrJZEE3zTtFmbBksazIFuiM4JJ+6/JYTP6Cw9fiQYH+0doZGW/HrDeyHCeNcyfSK/sp9eIwQSA/KOMxAjiwkb3fAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339330; c=relaxed/simple;
	bh=bJAyT6Bz/cJt3OWmdNQ8p83/diZ27TMSVUFaBgoCgDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojYTVUzrg7lwq48lYCqDKuy/tJYEK5c8rDqk/zCToTJbZlBYAw88JZZD949+hJGXANlKGcle1RB/MByP6cekCBKfN3VuxLQlCWf7sOJSxufVXqj8ZX9bXx1o0Wto9gwIqNwNt+5LWmEtUAFxlnTm4xnMhLgfkYTPAM47+wLAmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFZ8K1dp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4101eb5a115so6753085e9.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707339326; x=1707944126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6nVMRuzMF22aVX0g3o+SOHdNqS+k1RkkC5MAuoh9ZY=;
        b=gFZ8K1dp2qI2ctI4lYNMU68eFp/bGaQJf9oKs7qIr2wSTIaFVuC85pl2BtM+BELR1/
         XMs+pd9mAQFFW2AcQY1nWOhW+yXQvS5uo6e37JkqRywHpG9GvgPTTzIQWH8DO3361wlm
         ZfLEmb1pEGUWO+bn03FrZ7b7+YQnrooW8QNEIAMLLMdvR98WUs68DQIpdp4dGXn0Ub5I
         ixhfVyZYRykzAzbOhS3yzOsKnRI8MDjmTy1Tb05p/P6TqG+NAKQT7NoQrXiY4+PZZufF
         0xGu/xidT3/TfUu0i6g9S+93r2JJOIFJJuMqM0QRfbjf58zoKcKFzLPI8iRrnH5wsSzp
         dqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339326; x=1707944126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6nVMRuzMF22aVX0g3o+SOHdNqS+k1RkkC5MAuoh9ZY=;
        b=T1OzRG5BDVzEZfrwqkCySeNTML+wzuVm6g/syBHWyLPXbpsBwFCEs7nTvNX0sbUuDW
         cAxOb978aEAvrIsfzaatvDxVyMi4o9iIB9YMuiTLrJHyGuHzW+tx02sGDLKRAhplqHpT
         UHX1kQ5v3hmIcbNjfYSUA9j2AWK6LNRCumnsHMedXxUVvrH2rqEmbm2shVA7Y3UnPg3U
         5H2Fo/couvvlSwqv46jvZ2oJoNmaao4jpkX1Q1l3N4oO80uyEMGdU/9W184dh7LwD4PK
         369/iFBytzUPlM6W6ArcMeVpIOG81BxaSa494/xji+1pzUgzyg2J2ZYshjq0HR4P7XzX
         l42g==
X-Gm-Message-State: AOJu0Yzfap8enU7fVBZeFiMmres9NsDmSMoZPUCY4IgTpARqVkZRpyly
	fg16Gyy0dCf9n5CTTXWRpg4tTCQa9oloG9Cbk2LZilHCuqmFOIv4a0uCV4dO64PQnFS6CuGjVo9
	AX6ebRsWD/J4wt/lWw+bX4qGuZjY=
X-Google-Smtp-Source: AGHT+IHM2Fuh92yENoVeozw8n+ZALBxKEi4UovvwrehmZa0ABEDmUsNmPJeP+/T0gbWZa37Tgq6Z1Q/uWNRgVzAj2Ys=
X-Received: by 2002:a5d:5082:0:b0:33a:f3b1:6019 with SMTP id
 a2-20020a5d5082000000b0033af3b16019mr4262802wrt.24.1707339325731; Wed, 07 Feb
 2024 12:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com> <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
In-Reply-To: <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 12:55:14 -0800
Message-ID: <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> On 2/6/24 17:04, Alexei Starovoitov wrote:
> > +
> > +static long compute_pgoff(struct bpf_arena *arena, long uaddr)
> > +{
> > +     return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> > +}
> > +
> > +#define MT_ENTRY ((void *)&arena_map_ops) /* unused. has to be valid p=
ointer */
> > +
> > +/*
> > + * Reserve a "zero page", so that bpf prog and user space never see
> > + * a pointer to arena with lower 32 bits being zero.
> > + * bpf_cast_user() promotes it to full 64-bit NULL.
> > + */
> > +static int reserve_zero_page(struct bpf_arena *arena)
> > +{
> > +     long pgoff =3D compute_pgoff(arena, 0);
> > +
> > +     return mtree_insert(&arena->mt, pgoff, MT_ENTRY, GFP_KERNEL);
> > +}
> > +
>
> this is pretty tricky, and i think i didn't understand it at first.
>
> you're punching a hole in the arena, such that BPF won't allocate it via
> arena_alloc_pages().  thus BPF won't 'produce' an object with a pointer
> ending in 0x00000000.
>
> depending on where userspace mmaps the arena, that hole may or may not
> be the first page in the array.  if userspace mmaps it to a 4GB aligned
> virtual address, it'll be page 0.  but it could be at some arbitrary
> offset within the 4GB arena.
>
> that arbitrariness makes it harder for a BPF program to do its own
> allocations within the arena.  i'm planning on carving up the 4GB arena
> for my own purposes, managed by BPF, with the expectation that i'll be
> able to allocate any 'virtual address' within the arena.  but there's a
> magic page that won't be usable.
>
> i can certainly live with this.  just mmap userspace to a 4GB aligned
> address + PGSIZE, so that the last page in the arena is page 0.  but
> it's a little weird.

Agree. I made the same conclusion while adding global variables to the aren=
a.
From the compiler point of view all such global vars start at offset zero
and there is no way to just "move them up by a page".
For example in C code it will look like:
int __arena var1;
int __arena var2;

&var1 =3D=3D user_vm_start
&var2 =3D=3D user_vm_start + 4

If __ulong(map_extra,...) was used or mmap(addr, MAP_FIXED)
and was 4Gb aligned the lower 32-bits of &var1 address will be zero
and there is not much we can do about it.
We can tell LLVM to emit extra 8 byte padding to the arena section,
but it will be useless pad if the arena is not aligned to 4Gb.

Anyway, in the v2 I will remove this reserve_zero_page() logic.
It's causing more harm than good.

>
> though i think we'll have more serious issues if anyone accidentally
> tries to use that zero page.  BPF would get an EEXIST if they try to
> allocate it directly, but then page fault and die if they touched it,
> since there's no page.  i can live with that, if we force it to be the
> last page in the arena.
>
> however, i think you need to add something to the fault handler (below)
> in case userspace touches that page:
>
> [snip]
> > +static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
> > +{
> > +     struct bpf_map *map =3D vmf->vma->vm_file->private_data;
> > +     struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> > +     struct page *page;
> > +     long kbase, kaddr;
> > +     int ret;
> > +
> > +     kbase =3D bpf_arena_get_kern_vm_start(arena);
> > +     kaddr =3D kbase + (u32)(vmf->address & PAGE_MASK);
> > +
> > +     guard(mutex)(&arena->lock);
> > +     page =3D vmalloc_to_page((void *)kaddr);
> > +     if (page)
> > +             /* already have a page vmap-ed */
> > +             goto out;
> > +
> > +     if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> > +             /* User space requested to segfault when page is not allo=
cated by bpf prog */
> > +             return VM_FAULT_SIGSEGV;
> > +
> > +     ret =3D mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL=
);
> > +     if (ret =3D=3D -EEXIST)
> > +             return VM_FAULT_RETRY;
>
> say this was the zero page.  vmalloc_to_page() failed, so we tried to
> insert.  we get EEXIST, since the slot is reserved.  we retry, since we
> were expecting the case where "no page, yet slot reserved" meant that
> BPF was in the middle of filling this page.

Yes. Great catch! I hit that too while playing with global vars.

>
> though i think you can fix this by just treating this as a SIGSEGV
> instead of RETRY.

Agree.

> when i made the original suggestion of making this a
> retry (in an email off list), that was before you had the arena mutex.
> now that you have the mutex, you shouldn't have the scenario where two
> threads are concurrently trying to fill a page.  i.e. mtree_insert +
> page_alloc + vmap are all atomic w.r.t. the mutex.

yes. mutex part makes sense.

> > +
> > +     if (!arena->user_vm_start) {
> > +             arena->user_vm_start =3D vma->vm_start;
> > +             err =3D reserve_zero_page(arena);
> > +             if (err)
> > +                     return err;
> > +     }
> > +     arena->user_vm_end =3D vma->vm_end;
> > +     /*
> > +      * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
> > +      * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
> > +      * potential change of user_vm_start.
> > +      */
> > +     vm_flags_set(vma, VM_DONTEXPAND);
> > +     vma->vm_ops =3D &arena_vm_ops;
> > +     return 0;
> > +}
>
> i think this whole function needs to be protected by the mutex, or at
> least all the stuff relate to user_vm_{start,end}.  if you have to
> threads mmapping the region for the first time, you'll race on the
> values of user_vm_*.

yes. will add a mutex guard.

>
> [snip]
>
> > +/*
> > + * Allocate pages and vmap them into kernel vmalloc area.
> > + * Later the pages will be mmaped into user space vma.
> > + */
> > +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, lon=
g page_cnt, int node_id)
>
> instead of uaddr, can you change this to take an address relative to the
> arena ("arena virtual address"?)?  the caller of this is in BPF, and
> they don't easily know the user virtual address.  maybe even just pgoff
> directly.

I thought about it, but it doesn't quite make sense.
bpf prog only sees user addresses.
All load/store returns them. If it bpf_printk-s an address it will be
user address.
bpf_arena_alloc_pages() also returns a user address.

Kernel addresses are not seen by bpf prog at all.
kern_vm_base is completely hidden.
Only at JIT time, it's added to pointers.
So passing uaddr to arena_alloc_pages() matches mmap style.

uaddr =3D bpf_arena_alloc_pages(... uaddr ...)
uaddr =3D mmap(uaddr, ...MAP_FIXED)

Passing pgoff would be weird.
Also note that there is no extra flag for bpf_arena_alloc_pages().
uaddr =3D=3D full 64-bit of zeros is not a valid addr to use.

> additionally, you won't need to call compute_pgoff().  as it is now, i'm
> not sure what would happen if BPF did an arena_alloc with a uaddr and
> user_vm_start wasn't set yet.

That's impossible. bpf prog won't load, if the arena map is not created
either with fixed map_extra =3D=3D user_vm_start or map is created
with map_extra =3D=3D 0 and mmaped.
Only then bpf prog that uses that arena can be loaded.

>
> > +{
> > +     long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
>
> any time you compute_pgoff() or look at user_vm_{start,end}, maybe
> either hold the mutex, or only do it from mmap faults (where we know
> user_vm_start is already set).  o/w there might be subtle races where
> some other thread is mmapping the arena for the first time.

That's unnecessary, since user_vm_start is fixed for the lifetime of
bpf prog.
But you spotted a bug. I need to set user_vm_end in arena_map_alloc()
when map_extra is specified.
Otherwise after arena create and before mmap bpf prog will see different
page_cnt_max. user_vm_start will be the same, of course.

> > +
> > +     kaddr =3D kern_vm_start + (u32)(arena->user_vm_start + pgoff * PA=
GE_SIZE);
>
> adding user_vm_start here is pretty subtle.
>
> so far i've been thinking that the mtree is the "address space" of the
> arena, in units of pages instead of bytes.  and pgoff is an address
> within the arena.  so mtree slot 0 is the 0th page of the 4GB region.
> and that "arena address space" is mapped at a kernel virtual address and
> a user virtual address (the same for all processes).
>
> to convert user addresses (uaddr et al.) to arena addresses, we subtract
> user_vm_start, which makes sense.  that's what compute_pgoff() does.
>
> i was expecting kaddr =3D kern_vm_start + pgoff * PGSIZE, essentially
> converting from arena address space to kernel virtual address.
>
> instead, by adding user_vm_start and casting to u32, you're converting
> or shifting arena addresses to *another* arena address (user address,
> truncated to 4GB to keep it in the arena), and that is the one that the
> kernel will use.
>
> is that correct?

Pretty much. kern and user have to see lower 32-bit exactly the same.
From user pov allocation starts at pgoff=3D0 which is the first page
after user_vm_start. Which is normal mmap behavior and in-kernel
vma convention.
Hence in arena_alloc_pages() does the same pgoff=3D0 is the first
page from user vma pov.
The math to compute kernel address gets complicated because two
bases need to be added. Both kernel and user bases are different
64-bit bases and may not be aligned to 4G.

> my one concern is that there's some subtle wrap-around going on, and due
> to the shifting, kaddr can be very close to the end of the arena and
> page_cnt can be big enough to go outside the 4GB range.  we'd want it to

page_cnt cannot go outside of 4gb range.
page_cnt is a number of pages in arena->user_vm_end - arena->user_vm_start
and during mmap we check that it's <=3D 4gb.

> wrap around.  e.g.
>
> user_start_va =3D 0x1,fffff000
> user_end_va =3D   0x2,fffff000
> page_cnt_max =3D 0x100000 or whatever.  full 4GB range.
>
> say we want to alloc at pgoff=3D0 (uaddr 0x1,fffff000), page_cnt =3D X.  =
you
> can get this pgoff either by doing mtree_insert_range or
> mtree_alloc_range on an arena with no allocations.
>
> kaddr =3D kern_vm_start + 0xfffff000
>
> the size of the vm area is 4GB + guard stuff, and we're right up against
> the end of it.
>
> if page_cnt > the guard size, vmap_pages_range() would be called on
> something outside the vm area we reserved, which seems bad.  and even if
> it wasn't, what we want is for later page maps to start at the beginning
> of kern_vm_start.
>
> the fix might be to just only map a page at a time - maybe a loop.  or
> detect when we're close to the edge and break it into two vmaps.  i feel
> like the loop would be easier to understand, but maybe less efficient.

Oops. You're correct. Great catch.
In earlier versions I had it as a loop, but then I decided that doing
all mapping ops page at a time is not efficient.
Oh well. Will fix.

Thanks a lot for the review!

