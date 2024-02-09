Return-Path: <bpf+bounces-21653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979684FDC1
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC171C21092
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAF79D1;
	Fri,  9 Feb 2024 20:36:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905653A7
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511001; cv=none; b=DFeZlYP93JMTJHg7iXp1r8rOgD2QDFvZFVW/lLMFwXVSEQS1Y9HTERQgeWBBOJNdeJ4StFoh3oD47lXrP5MDypwNIVNmcnIMbUDwdpKIPTAaT57PhdYyexO7NIO/ke6mY3Pd5mxoUOAvi4sq6UtPxyrHO6S70w6sJuZW/s1Qjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511001; c=relaxed/simple;
	bh=SJMv9csnSqkH88TP2YPFdXWgDU0jBEX6sPCllpIZUXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpxDQD5axzWfeg8kLeK3INJRJYy1mD6kIfxG7q3G137v0LuO3ww4Zwwv3cW1aUhmuzj3/NNV3fy87mMI6bpbsxgjdm5PcWKiV1tEabfZ7bj2ATqMNErA2u3xd1FqLifJozMzyKhEWj/4P9QauDV39vcD7QKnQN+i9oXecc4w8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a8a398cb2so7689921cf.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 12:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510998; x=1708115798;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jluSRt/f1D/0+I+Uw2bcsgBWxg8n/0EIYcHpRnoCCKc=;
        b=nZD9n/AkZtalr7NTNm2KTaOOQozBrxxx0Mb9v2MOqYN8iWRRu/cHuSglWh3N1BqSpE
         xR3K13Qf+YiNdhcacyUX2PpII1yN+slovdfLqimDXpbrBKcf9UHp9gU0D/qTW2zRu2/Q
         1KDHP05tTNPMFxiXMgsR4NqA9wAh2VUwugwqLm9jGQRzMFUjZH+hEXibRZU4gWUUjVcb
         gpv/UBWWFC7Jcm54Lh9AQL2Cwt6hqXUggsZOxkL9IPOOuuIpf5AdtBfpTmqLmETFwXns
         dieHNYiNn2M5DeTNhmm2WbefLtSSXIBnG27VlyHvjJ0prM2rYfovvtvuK/EpKbSG4gEP
         4FPw==
X-Gm-Message-State: AOJu0YxUjyzBhJCyxQBlfRkdapHox0zt9fauglmEb2LYhi+D4H8ozfg+
	DG9bY2ShHpvr63mv7zFpvYP1pIld2KjQ5rCwedq6I4EYxhtS0Es3OY54+ezLVZikhQ==
X-Google-Smtp-Source: AGHT+IFqRQ6SFdKUD14DR/0st4naqw097fobvvV/SN/REPo/VCY564aaHYXk8M+rXdX9bhW9TpuwOw==
X-Received: by 2002:a05:622a:102:b0:42c:5c5b:2687 with SMTP id u2-20020a05622a010200b0042c5c5b2687mr553178qtw.0.1707510998011;
        Fri, 09 Feb 2024 12:36:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXllFrwslcdlIHpXjT16i2fpE8LGdGVx+OX9jSgurlL0rwNm/wuvEDuS/Ra+XYG1GVWZNozS/GpeoxTqlzsP6ImkGyF3QLRAYGVEonz2D4A+4yk2TS7QpemfzmfKOuXI5/WYSZGz2YkVf5m06bqn1xzJ2aGP4Bss06DfyqnWxZBx54ndoJc6LFOpGxGaVo9tFFM5zT05jyKptXdJmCZYARQEKDQ2+CVEBUK92mi1giohfv/hpmZe+etsWo3jdPXWs1W3HH5ctfQnEA7l5F9pThljTX9zDclym7Vzt9YLRFXnRu9allPOXoEa0HIZGzdjLhpKsHqWxXnFSbyc4cKnLIrjF9LciMpCf2c9HACj5f1w8Pifmp34YV8UWJudiBjwY3ixrBA9OIruzVgGrI=
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id y15-20020ac85f4f000000b0042c54560aa0sm986101qta.87.2024.02.09.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:36:37 -0800 (PST)
Date: Fri, 9 Feb 2024 14:36:34 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com,
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org,
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
Message-ID: <20240209203634.GA3615691@maniforge.lan>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t/uozX60iKL6uX1o"
Content-Disposition: inline
In-Reply-To: <20240209040608.98927-6-alexei.starovoitov@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--t/uozX60iKL6uX1o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 08:05:53PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Introduce bpf_arena, which is a sparse shared memory region between the b=
pf
> program and user space.
>=20
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
>=20
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
>=20
> bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pag=
es
> either at a specific address within the arena or allocates a range with t=
he
> maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees =
pages
> and removes the range from the kernel vm_area and from user process vmas.
>=20
> bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of =
bpf
> program is more important than ease of sharing with user space. This is u=
se
> case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended. It wi=
ll
> tell the verifier to treat the rX =3D bpf_arena_cast_user(rY) instruction=
 as a
> 32-bit move wX =3D wY, which will improve bpf prog performance. Otherwise,
> bpf_arena_cast_user is translated by JIT to conditionally add the upper 3=
2 bits
> of user vm_start (if the pointer is not NULL) to arena pointers before th=
ey are
> stored into memory. This way, user space sees them as valid 64-bit pointe=
rs.
>=20
> Diff https://github.com/llvm/llvm-project/pull/79902 taught LLVM BPF back=
end to
> generate the bpf_cast_kern() instruction before dereference of the arena
> pointer and the bpf_cast_user() instruction when the arena pointer is for=
med.
> In a typical bpf program there will be very few bpf_cast_user().
>=20
> From LLVM's point of view, arena pointers are tagged as
> __attribute__((address_space(1))). Hence, clang provides helpful diagnost=
ics
> when pointers cross address space. Libbpf and the kernel support only
> address_space =3D=3D 1. All other address space identifiers are reserved.
>=20
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
>=20
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
>=20
> After such conversion, the pointer becomes a valid user pointer within
> bpf_arena range. The user process can access data structures created in
> bpf_arena without any additional computations. For example, a linked list=
 built
> by a bpf program can be walked natively by user space.
>=20
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
>=20
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
>  			struct bpf_spin_lock *spin_lock);
>  void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>  		      struct bpf_spin_lock *spin_lock);
> -
> -
> +u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
> +u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
>  int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
> =20
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
> =20
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d96708380e52..f6648851eae6 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -983,6 +983,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_BLOOM_FILTER,
>  	BPF_MAP_TYPE_USER_RINGBUF,
>  	BPF_MAP_TYPE_CGRP_STORAGE,
> +	BPF_MAP_TYPE_ARENA,
>  	__MAX_BPF_MAP_TYPE
>  };
> =20
> @@ -1370,6 +1371,12 @@ enum {
> =20
>  /* BPF token FD is passed in a corresponding command's token_fd field */
>  	BPF_F_TOKEN_FD          =3D (1U << 16),
> +
> +/* When user space page faults in bpf_arena send SIGSEGV instead of inse=
rting new page */
> +	BPF_F_SEGV_ON_FAULT	=3D (1U << 17),
> +
> +/* Do not translate kernel bpf_arena pointers to user pointers */
> +	BPF_F_NO_USER_CONV	=3D (1U << 18),
>  };
> =20
>  /* Flags for BPF_PROG_QUERY. */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 4ce95acfcaa7..368c5d86b5b7 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -15,6 +15,9 @@ obj-${CONFIG_BPF_LSM}	  +=3D bpf_inode_storage.o
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
> +/* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
> +#define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)
> +#define KERN_VM_SZ ((1ull << 32) + GUARD_SZ)
> +
> +struct bpf_arena {
> +	struct bpf_map map;
> +	u64 user_vm_start;
> +	u64 user_vm_end;
> +	struct vm_struct *kern_vm;
> +	struct maple_tree mt;
> +	struct list_head vma_list;
> +	struct mutex lock;
> +};
> +
> +u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> +{
> +	return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 : 0;
> +}
> +
> +u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> +{
> +	return arena ? arena->user_vm_start : 0;
> +}
> +
> +static long arena_map_peek_elem(struct bpf_map *map, void *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static long arena_map_push_elem(struct bpf_map *map, void *value, u64 fl=
ags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static long arena_map_pop_elem(struct bpf_map *map, void *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static long arena_map_delete_elem(struct bpf_map *map, void *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int arena_map_get_next_key(struct bpf_map *map, void *key, void *=
next_key)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static long compute_pgoff(struct bpf_arena *arena, long uaddr)
> +{
> +	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> +}
> +
> +static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
> +{
> +	struct vm_struct *kern_vm;
> +	int numa_node =3D bpf_map_attr_numa_node(attr);
> +	struct bpf_arena *arena;
> +	u64 vm_range;
> +	int err =3D -ENOMEM;
> +
> +	if (attr->key_size || attr->value_size || attr->max_entries =3D=3D 0 ||
> +	    /* BPF_F_MMAPABLE must be set */
> +	    !(attr->map_flags & BPF_F_MMAPABLE) ||
> +	    /* No unsupported flags present */
> +	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | BPF_F_N=
O_USER_CONV)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (attr->map_extra & ~PAGE_MASK)
> +		/* If non-zero the map_extra is an expected user VMA start address */
> +		return ERR_PTR(-EINVAL);

So I haven't done a thorough review of this patch, beyond trying to
understand the semantics of bpf arenas. On that note, could you please
document the semantics of map_extra with arena maps where map_extra is
defined in [0]?

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/=
include/uapi/linux/bpf.h#n1439

--t/uozX60iKL6uX1o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcaM0gAKCRBZ5LhpZcTz
ZNJPAQDiW0eSrUFZnhusBbNKoid3U4ElfaExrM9mKlWHtC86swEA8W6gOvFTQ5i+
wNp3GFoM6o8++2lEBRLXcGByJf7qwAo=
=3tVq
-----END PGP SIGNATURE-----

--t/uozX60iKL6uX1o--

