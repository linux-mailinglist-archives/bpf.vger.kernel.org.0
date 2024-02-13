Return-Path: <bpf+bounces-21907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A642853FDB
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BC1C28994
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E1262A09;
	Tue, 13 Feb 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8Iu/P+l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F863409
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866094; cv=none; b=tZ3yzwNWgwckQoPEhlpUONDPSywlWkyIqto1ywBv0ZrTxypIvj685INx8C1bDGJSKOWlyOTX5kHFKywGbk4u/UxVsHu8OzpDZE5I2RK3NJ/tdT5AHWvX5mOWwLlVT2/1Ipa90XHA7HdgCjyFETxtTQlEh3Op49kVCL1WR4tLmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866094; c=relaxed/simple;
	bh=AjkCWm7EBHB3mptNAZxRtST7gFXbo1ylSah+WPiXQbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2KQUkdfrCqeNp+ZsLlIe/sFR8ov9xqYxiebaEVnu8gW5rMg7piUrC31/Poj7N004EB62+ZqkXadsVnZkVfSAuFa0HEAsbwniS3qOYJ+G7UpX9Zfu3LMuhUBpQWxibUxS60qxlMryhTDsoWP4+HKP1VYZQev/r/ZFKn06cYsj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8Iu/P+l; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dc816e4affso1170849a12.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866092; x=1708470892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzhKZjkjJwlLses3QNHWy7dnYflIuFvfnHY2hMvM0sw=;
        b=i8Iu/P+luP+8L9GQipMGA0vMmJWd5eUz9YHGMZqMW4g2F9e7yHJQabXnnNeDAAVcz1
         m9M/6IznvbAu6yo/6lazEOQFq3Nt/WibDNiiICyW+NooM//nah4/uxjUA2O9E7qxmbhX
         2+0N1FiWf6RRtuMKyJE7HppKiWcJtsL70DljYG8Dr990C8vPoel+cW+lKlzAnkq5Z3Dx
         iYiwMO0sqSIqyAQFAWaw3AsxMN4Guypbi2lpStiMUqHEuZOKHMgi72oBrZZA1x1JjpmA
         MMTxMfTRFHO/mwCwsfQNVy16QCaK3P+MRB3MLKyQZIfyiaK8Je4lE4LNQANSt+yR1f/b
         wv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866092; x=1708470892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzhKZjkjJwlLses3QNHWy7dnYflIuFvfnHY2hMvM0sw=;
        b=muT9HvOEGF02L1CVWgoek57KQAYzRFmJYRFCxeasY5NOyLrVrcrMDqeELqlJq6Hdr6
         E4iBpli3BU097UtMetjamk+nwbDCllbwUjqWKrv8U/QVqwyR1YHJwc0fTAmn+oBHlY+a
         Kj/rAX2vRvS8NTuIcr2oBFRSnAaKb8Ka+TsotwncjdCsQufVvR7KUPzKig8MAzGItaPe
         iw83dLP+wv6uTNojqAehNl0oVXizj0SFnhZxLeuxpp5+WwFVrl4Z9bgQH3hYRJtiLLx2
         Hww60gCfZmNqkZfjwgS6U/9d5uO+RcG+r2IlicuAYrLv8EZx4B9/D1/7xb7RL0EuUUL1
         ShAg==
X-Gm-Message-State: AOJu0YxnLdkPAN+AFFG/oOJ4a5ZFvTKxEHLHYQc/+WnWxKRPDbn84jAj
	QW7TlaiT/hbw/ZAtPxadh/UO1FSPsjneP4l6CQvFh9lgcBbSmrYW1Jivxar2f/3CmvMlP2OywQY
	g2HiFBP2BbwSBvJtmJFJQQdYsscvrxFvD
X-Google-Smtp-Source: AGHT+IEruXVjdP6C9Nb928ocqjjzOPTZRpH518XKJs2T+Edzm67SB6ag4zu50oDnQlT4g3g8XRWBBboCsh4HzTPpEaE=
X-Received: by 2002:a05:6a20:9c8f:b0:19e:caf3:87e4 with SMTP id
 mj15-20020a056a209c8f00b0019ecaf387e4mr851798pzb.6.1707866091909; Tue, 13 Feb
 2024 15:14:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-6-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:14:39 -0800
Message-ID: <CAEf4BzaGT3cSVo=XsD6d4bgR-8JVx8z=Pgi9RkdHseui9MPMvw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_arena, which is a sparse shared memory region between the b=
pf
> program and user space.
>
> Use cases:
> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anony=
mous
>    region, like memcached or any key/value storage. The bpf program imple=
ments an
>    in-kernel accelerator. XDP prog can search for a key in bpf_arena and =
return a
>    value without going to user space.
> 2. The bpf program builds arbitrary data structures in bpf_arena (hash ta=
bles,
>    rb-trees, sparse arrays), while user space consumes it.
> 3. bpf_arena is a "heap" of memory from the bpf program's point of view.
>    The user space may mmap it, but bpf program will not convert pointers
>    to user base at run-time to improve bpf program speed.
>
> Initially, the kernel vm_area and user vma are not populated. User space =
can
> fault in pages within the range. While servicing a page fault, bpf_arena =
logic
> will insert a new page into the kernel and user vmas. The bpf program can
> allocate pages from that region via bpf_arena_alloc_pages(). This kernel
> function will insert pages into the kernel vm_area. The subsequent fault-=
in
> from user space will populate that page into the user vma. The
> BPF_F_SEGV_ON_FAULT flag at arena creation time can be used to prevent fa=
ult-in
> from user space. In such a case, if a page is not allocated by the bpf pr=
ogram
> and not present in the kernel vm_area, the user process will segfault. Th=
is is
> useful for use cases 2 and 3 above.
>
> bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pag=
es
> either at a specific address within the arena or allocates a range with t=
he
> maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees =
pages
> and removes the range from the kernel vm_area and from user process vmas.
>
> bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of =
bpf
> program is more important than ease of sharing with user space. This is u=
se
> case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended. It wi=
ll
> tell the verifier to treat the rX =3D bpf_arena_cast_user(rY) instruction=
 as a
> 32-bit move wX =3D wY, which will improve bpf prog performance. Otherwise=
,
> bpf_arena_cast_user is translated by JIT to conditionally add the upper 3=
2 bits
> of user vm_start (if the pointer is not NULL) to arena pointers before th=
ey are
> stored into memory. This way, user space sees them as valid 64-bit pointe=
rs.
>
> Diff https://github.com/llvm/llvm-project/pull/79902 taught LLVM BPF back=
end to
> generate the bpf_cast_kern() instruction before dereference of the arena
> pointer and the bpf_cast_user() instruction when the arena pointer is for=
med.
> In a typical bpf program there will be very few bpf_cast_user().
>
> From LLVM's point of view, arena pointers are tagged as
> __attribute__((address_space(1))). Hence, clang provides helpful diagnost=
ics
> when pointers cross address space. Libbpf and the kernel support only
> address_space =3D=3D 1. All other address space identifiers are reserved.
>
> rX =3D bpf_cast_kern(rY, addr_space) tells the verifier that
> rX->type =3D PTR_TO_ARENA. Any further operations on PTR_TO_ARENA registe=
r have
> to be in the 32-bit domain. The verifier will mark load/store through
> PTR_TO_ARENA with PROBE_MEM32. JIT will generate them as
> kern_vm_start + 32bit_addr memory accesses. The behavior is similar to
> copy_from_kernel_nofault() except that no address checks are necessary. T=
he
> address is guaranteed to be in the 4GB range. If the page is not present,=
 the
> destination register is zeroed on read, and the operation is ignored on w=
rite.
>
> rX =3D bpf_cast_user(rY, addr_space) tells the verifier that
> rX->type =3D unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV s=
et, then
> the verifier converts cast_user to mov32. Otherwise, JIT will emit native=
 code
> equivalent to:
> rX =3D (u32)rY;
> if (rY)
>   rX |=3D clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits in =
rX */
>
> After such conversion, the pointer becomes a valid user pointer within
> bpf_arena range. The user process can access data structures created in
> bpf_arena without any additional computations. For example, a linked list=
 built
> by a bpf program can be walked natively by user space.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h            |   5 +-
>  include/linux/bpf_types.h      |   1 +
>  include/uapi/linux/bpf.h       |   7 +
>  kernel/bpf/Makefile            |   3 +
>  kernel/bpf/arena.c             | 557 +++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  11 +
>  kernel/bpf/syscall.c           |   3 +
>  kernel/bpf/verifier.c          |   1 +
>  tools/include/uapi/linux/bpf.h |   7 +
>  9 files changed, 593 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/bpf/arena.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8b0dcb66eb33..de557c6c42e0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -37,6 +37,7 @@ struct perf_event;
>  struct bpf_prog;
>  struct bpf_prog_aux;
>  struct bpf_map;
> +struct bpf_arena;
>  struct sock;
>  struct seq_file;
>  struct btf;
> @@ -534,8 +535,8 @@ void bpf_list_head_free(const struct btf_field *field=
, void *list_head,
>                         struct bpf_spin_lock *spin_lock);
>  void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>                       struct bpf_spin_lock *spin_lock);
> -
> -
> +u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
> +u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
>  int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
>
>  struct bpf_offload_dev;
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 94baced5a1ad..9f2a6b83b49e 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -132,6 +132,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_=
map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
>
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d96708380e52..f6648851eae6 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -983,6 +983,7 @@ enum bpf_map_type {
>         BPF_MAP_TYPE_BLOOM_FILTER,
>         BPF_MAP_TYPE_USER_RINGBUF,
>         BPF_MAP_TYPE_CGRP_STORAGE,
> +       BPF_MAP_TYPE_ARENA,
>         __MAX_BPF_MAP_TYPE
>  };
>
> @@ -1370,6 +1371,12 @@ enum {
>
>  /* BPF token FD is passed in a corresponding command's token_fd field */
>         BPF_F_TOKEN_FD          =3D (1U << 16),
> +
> +/* When user space page faults in bpf_arena send SIGSEGV instead of inse=
rting new page */
> +       BPF_F_SEGV_ON_FAULT     =3D (1U << 17),
> +
> +/* Do not translate kernel bpf_arena pointers to user pointers */
> +       BPF_F_NO_USER_CONV      =3D (1U << 18),
>  };
>
>  /* Flags for BPF_PROG_QUERY. */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 4ce95acfcaa7..368c5d86b5b7 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -15,6 +15,9 @@ obj-${CONFIG_BPF_LSM}   +=3D bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o mprog.o
>  obj-$(CONFIG_BPF_JIT) +=3D trampoline.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf.o memalloc.o
> +ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
> +obj-$(CONFIG_BPF_SYSCALL) +=3D arena.o
> +endif
>  obj-$(CONFIG_BPF_JIT) +=3D dispatcher.o
>  ifeq ($(CONFIG_NET),y)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D devmap.o
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> new file mode 100644
> index 000000000000..5c1014471740
> --- /dev/null
> +++ b/kernel/bpf/arena.c
> @@ -0,0 +1,557 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/err.h>
> +#include <linux/btf_ids.h>
> +#include <linux/vmalloc.h>
> +#include <linux/pagemap.h>
> +
> +/*
> + * bpf_arena is a sparsely populated shared memory region between bpf pr=
ogram and
> + * user space process.
> + *
> + * For example on x86-64 the values could be:
> + * user_vm_start 7f7d26200000     // picked by mmap()
> + * kern_vm_start ffffc90001e69000 // picked by get_vm_area()
> + * For user space all pointers within the arena are normal 8-byte addres=
ses.
> + * In this example 7f7d26200000 is the address of the first page (pgoff=
=3D0).
> + * The bpf program will access it as: kern_vm_start + lower_32bit_of_use=
r_ptr
> + * (u32)7f7d26200000 -> 26200000
> + * hence
> + * ffffc90001e69000 + 26200000 =3D=3D ffffc90028069000 is "pgoff=3D0" wi=
thin 4Gb
> + * kernel memory region.
> + *
> + * BPF JITs generate the following code to access arena:
> + *   mov eax, eax  // eax has lower 32-bit of user pointer
> + *   mov word ptr [rax + r12 + off], bx
> + * where r12 =3D=3D kern_vm_start and off is s16.
> + * Hence allocate 4Gb + GUARD_SZ/2 on each side.
> + *
> + * Initially kernel vm_area and user vma are not populated.
> + * User space can fault-in any address which will insert the page
> + * into kernel and user vma.
> + * bpf program can allocate a page via bpf_arena_alloc_pages() kfunc
> + * which will insert it into kernel vm_area.
> + * The later fault-in from user space will populate that page into user =
vma.
> + */
> +
> +/* number of bytes addressable by LDX/STX insn with 16-bit 'off' field *=
/
> +#define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)
> +#define KERN_VM_SZ ((1ull << 32) + GUARD_SZ)

I feel like we need another named constant for those 4GB limits here,
something like:

#define MAX_ARENA_SZ (1ull << 32)
#define KERN_VM_SZ (MAX_ARENA_SZ + GUARD_SZ)

see below why

> +
> +struct bpf_arena {
> +       struct bpf_map map;
> +       u64 user_vm_start;
> +       u64 user_vm_end;
> +       struct vm_struct *kern_vm;
> +       struct maple_tree mt;
> +       struct list_head vma_list;
> +       struct mutex lock;
> +};
> +

[...]

> +static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
> +{
> +       struct vm_struct *kern_vm;
> +       int numa_node =3D bpf_map_attr_numa_node(attr);
> +       struct bpf_arena *arena;
> +       u64 vm_range;
> +       int err =3D -ENOMEM;
> +
> +       if (attr->key_size || attr->value_size || attr->max_entries =3D=
=3D 0 ||
> +           /* BPF_F_MMAPABLE must be set */
> +           !(attr->map_flags & BPF_F_MMAPABLE) ||
> +           /* No unsupported flags present */
> +           (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | B=
PF_F_NO_USER_CONV)))
> +               return ERR_PTR(-EINVAL);
> +
> +       if (attr->map_extra & ~PAGE_MASK)
> +               /* If non-zero the map_extra is an expected user VMA star=
t address */
> +               return ERR_PTR(-EINVAL);
> +
> +       vm_range =3D (u64)attr->max_entries * PAGE_SIZE;
> +       if (vm_range > (1ull << 32))

here we can then use MAX_ARENA_SZ

> +               return ERR_PTR(-E2BIG);
> +
> +       if ((attr->map_extra >> 32) !=3D ((attr->map_extra + vm_range - 1=
) >> 32))
> +               /* user vma must not cross 32-bit boundary */
> +               return ERR_PTR(-ERANGE);
> +
> +       kern_vm =3D get_vm_area(KERN_VM_SZ, VM_MAP | VM_USERMAP);
> +       if (!kern_vm)
> +               return ERR_PTR(-ENOMEM);
> +
> +       arena =3D bpf_map_area_alloc(sizeof(*arena), numa_node);
> +       if (!arena)
> +               goto err;
> +
> +       arena->kern_vm =3D kern_vm;
> +       arena->user_vm_start =3D attr->map_extra;
> +       if (arena->user_vm_start)
> +               arena->user_vm_end =3D arena->user_vm_start + vm_range;
> +
> +       INIT_LIST_HEAD(&arena->vma_list);
> +       bpf_map_init_from_attr(&arena->map, attr);
> +       mt_init_flags(&arena->mt, MT_FLAGS_ALLOC_RANGE);
> +       mutex_init(&arena->lock);
> +
> +       return &arena->map;
> +err:
> +       free_vm_area(kern_vm);
> +       return ERR_PTR(err);
> +}
> +
> +static int for_each_pte(pte_t *ptep, unsigned long addr, void *data)
> +{
> +       struct page *page;
> +       pte_t pte;
> +
> +       pte =3D ptep_get(ptep);
> +       if (!pte_present(pte))
> +               return 0;
> +       page =3D pte_page(pte);
> +       /*
> +        * We do not update pte here:
> +        * 1. Nobody should be accessing bpf_arena's range outside of a k=
ernel bug
> +        * 2. TLB flushing is batched or deferred. Even if we clear pte,
> +        * the TLB entries can stick around and continue to permit access=
 to
> +        * the freed page. So it all relies on 1.
> +        */
> +       __free_page(page);
> +       return 0;
> +}
> +
> +static void arena_map_free(struct bpf_map *map)
> +{
> +       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +
> +       /*
> +        * Check that user vma-s are not around when bpf map is freed.
> +        * mmap() holds vm_file which holds bpf_map refcnt.
> +        * munmap() must have happened on vma followed by arena_vm_close(=
)
> +        * which would clear arena->vma_list.
> +        */
> +       if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
> +               return;
> +
> +       /*
> +        * free_vm_area() calls remove_vm_area() that calls free_unmap_vm=
ap_area().
> +        * It unmaps everything from vmalloc area and clears pgtables.
> +        * Call apply_to_existing_page_range() first to find populated pt=
es and
> +        * free those pages.
> +        */
> +       apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_star=
t(arena),
> +                                    KERN_VM_SZ - GUARD_SZ / 2, for_each_=
pte, NULL);

I'm still reading the rest (so it might become obvious), but this
KERN_VM_SZ - GUARD_SZ / 2 is a bit surprising. I understand that
kern_vm_start is shifted by GUARD_SZ/2, but is the intent here is to
actually go beyond maximum 4GB by GUARD_SZ/2, or the intent was to
unmap 4GB (MAX_ARENA_SZ)?

> +       free_vm_area(arena->kern_vm);
> +       mtree_destroy(&arena->mt);
> +       bpf_map_area_free(arena);
> +}
> +

[...]

> +static unsigned long arena_get_unmapped_area(struct file *filp, unsigned=
 long addr,
> +                                            unsigned long len, unsigned =
long pgoff,
> +                                            unsigned long flags)
> +{
> +       struct bpf_map *map =3D filp->private_data;
> +       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +       long ret;
> +
> +       if (pgoff)
> +               return -EINVAL;
> +       if (len > (1ull << 32))

MAX_ARENA_SZ ?

> +               return -E2BIG;
> +
> +       /* if user_vm_start was specified at arena creation time */
> +       if (arena->user_vm_start) {
> +               if (len > arena->user_vm_end - arena->user_vm_start)
> +                       return -E2BIG;
> +               if (len !=3D arena->user_vm_end - arena->user_vm_start)
> +                       return -EINVAL;
> +               if (addr !=3D arena->user_vm_start)
> +                       return -EINVAL;
> +       }
> +
> +       ret =3D current->mm->get_unmapped_area(filp, addr, len * 2, 0, fl=
ags);
> +       if (IS_ERR_VALUE(ret))
> +                return 0;

Can you leave a comment why we are swallowing errors, if this is intentiona=
l?

> +       if ((ret >> 32) =3D=3D ((ret + len - 1) >> 32))
> +               return ret;
> +       if (WARN_ON_ONCE(arena->user_vm_start))
> +               /* checks at map creation time should prevent this */
> +               return -EFAULT;
> +       return round_up(ret, 1ull << 32);

this is still probably MAX_ARENA_SZ, no?

> +}
> +
> +static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vm=
a)
> +{
> +       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +
> +       guard(mutex)(&arena->lock);
> +       if (arena->user_vm_start && arena->user_vm_start !=3D vma->vm_sta=
rt)
> +               /*
> +                * If map_extra was not specified at arena creation time =
then
> +                * 1st user process can do mmap(NULL, ...) to pick user_v=
m_start
> +                * 2nd user process must pass the same addr to mmap(addr,=
 MAP_FIXED..);
> +                *   or
> +                * specify addr in map_extra and
> +                * use the same addr later with mmap(addr, MAP_FIXED..);
> +                */
> +               return -EBUSY;
> +
> +       if (arena->user_vm_end && arena->user_vm_end !=3D vma->vm_end)
> +               /* all user processes must have the same size of mmap-ed =
region */
> +               return -EBUSY;
> +
> +       /* Earlier checks should prevent this */
> +       if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > (1ull << 32) || vm=
a->vm_pgoff))

MAX_ARENA_SZ ?

> +               return -EFAULT;
> +
> +       if (remember_vma(arena, vma))
> +               return -ENOMEM;
> +
> +       arena->user_vm_start =3D vma->vm_start;
> +       arena->user_vm_end =3D vma->vm_end;
> +       /*
> +        * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
> +        * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
> +        * potential change of user_vm_start.
> +        */
> +       vm_flags_set(vma, VM_DONTEXPAND);
> +       vma->vm_ops =3D &arena_vm_ops;
> +       return 0;
> +}
> +

[...]

