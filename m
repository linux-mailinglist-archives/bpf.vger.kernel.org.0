Return-Path: <bpf+bounces-21739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F685188D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83D7B215FD
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7D3D0A7;
	Mon, 12 Feb 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOe6IW5i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF73C47A
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753414; cv=none; b=upfriZxwFioYDQDjU3KBkcgKf6dM6a/IhkrlEL0FGFzEhnntTvcFyGGz0SqNMh7u7biStrZd3InGO9kIHNZ/EoEx/69NNVFbqv5g6tCW5Q/9OqfKjqDVbMu3bJzXWHitf1J9itytAh35LnfXSSsORHMfaqUCLOv/Yf4ZesSL+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753414; c=relaxed/simple;
	bh=/dZnSQnLGDApIrfh3eutXqtFjzTStkWd61aT9GldFVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDiwXGL6uY7N+uIty0GPy6dyXxd+AyqsS3ePNZSRQsX6fjPlJ0VYUeFuSf54N1Z/UTceOKX+U8ayhmg1yzyewzFateyE/mv0Ti2ELpAX782Tu96b0Z6iqzpEjthY+vWlJgb/s02lohexvmXif2/otdA37m5lUeVg7oAirPW8TSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOe6IW5i; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42aa4a9d984so16182331cf.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707753410; x=1708358210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdsQjYj4/omQfhdY2F6jTqurhCXm8hG9I0+DDP8CZsc=;
        b=KOe6IW5iwJ9cu8mDofwm8/9hUGERmDq3bxH7nUZhGrEE4btNg6dhh5e5oorKIlxisc
         O8mKRvy+PuE3AGD1N7WLKE73DtlSPM0O2HVCvriMqFBcfYeknbSJhcRpqiRw5EDANLol
         66GFfue/JZVynBM2qH4fQCp5O8JEsDG8/p9RiyblOf3U7Sunspm14uyvAvWW+jt/zy/x
         uX26Rn+8krnLM8E8UMV1/DFC8GbZJrzIGNkG6q9TVj1n0WO/fOBnPzJU08HKriFHB5fT
         2w4/HM64ZOoc13b0n08rP0mjX58aNya9DW3jr90+xOg21/cMXT6rNcEEzQTrmnFLuGkK
         NcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753410; x=1708358210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdsQjYj4/omQfhdY2F6jTqurhCXm8hG9I0+DDP8CZsc=;
        b=rwtN2UtkFvgOU1KP09MkJFOYl/9pZXl8TnKefK5UvenSmHkBkXJ27wxNwn65HC15RZ
         3mSZh676uFag2NmqvGnD8M6gD7lBw1MU1+DTP3QBypQyUJ4FOp/SXmUmAT768LxSuxyd
         aH1def5VG2wgJkUsqYdRl4AZS0RWetmFAyrIkgBJ4Squko4bjwCJc73WMT6ysU96QegG
         gQU42xvrqFlvhqPOnnzxoHktKzFrwjOrR4RMfghmUx3pmqiAztSruNUPZgeTPOxOGwSQ
         GZ64LILnAItRFNwQCoM0knRnJ5T6DVIWndLJU9BbJNcLavBgT3JD7g4lGDd6fncU565X
         KRRw==
X-Gm-Message-State: AOJu0YxMIKjt+d97accWSJIquM33T8ZhHWzQozdF9cz0wIqH/EnmQuEm
	AyQCSd+1WN9nIOhL3Z34VJ5vULM1boNG6vKrx+X/xFhO1KRHDLg6g7GB6pXFo+ct+7yA+NM+bxG
	dWyoj654=
X-Google-Smtp-Source: AGHT+IEDiLFSRhVJLljtaBHLsK0vLS4KdRV1Ej1VFYkQra9HKLV8/plL0GH7Bpe8Tz6wP6bPMF20UA==
X-Received: by 2002:ac8:5708:0:b0:42c:515e:ecc7 with SMTP id 8-20020ac85708000000b0042c515eecc7mr8748572qtw.28.1707753409923;
        Mon, 12 Feb 2024 07:56:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUr/7WkPMUXcQ6oyA7w+bYWPZfdXT4IvJhOA8T7Znt0XN8kGz036oDO5pa8IjFrUwAvzjeFNchQu031AL+NqMRWGm51++kPEgvSVm+w5Hg+HGysFgP5mQC8k239Y0rEB7SKkUynFv5BVemFcoLy7feofLQvdfliLvGFEfIZIQsADT/PjaQWRIsV3tU5Do8lIEgUaW6BFFKrDUBfB7ahKplUlqQ66F0t72jVad/O2rSPZzX4vQXmmpbvOuGpdkR+LllRAElzOePN/SIz/sCzhjZqeoEOWpskEOzoXwUHKL+EhyKVTGiXJydhaRcv5L9nNg94ctB+GbF44o6xfaxPs6Ia7suOPwpkOp22KOmTOOZOcVZIyP+kHucPAj/S
Received: from [192.168.1.31] (d-24-233-113-151.nh.cpe.atlanticbb.net. [24.233.113.151])
        by smtp.gmail.com with ESMTPSA id f15-20020ac859cf000000b0042c21364cd6sm251763qtf.78.2024.02.12.07.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:56:49 -0800 (PST)
Message-ID: <4ac1bea6-f1b0-4f9e-8b46-c181ce9413a9@google.com>
Date: Mon, 12 Feb 2024 10:56:48 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, hannes@cmpxchg.org,
 lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <20240209040608.98927-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 23:05, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce bpf_arena, which is a sparse shared memory region between the bpf
> program and user space.


one last check - did you have a diff for the verifier to enforce 
user_vm_{start,end} somewhere?  didn't see it in the patchset, but also 
highly likely that i just skimmed past it.  =)

Reviewed-by: Barret Rhoden <brho@google.com>


thanks,

barret



> 
> Use cases:
> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
>     region, like memcached or any key/value storage. The bpf program implements an
>     in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
>     value without going to user space.
> 2. The bpf program builds arbitrary data structures in bpf_arena (hash tables,
>     rb-trees, sparse arrays), while user space consumes it.
> 3. bpf_arena is a "heap" of memory from the bpf program's point of view.
>     The user space may mmap it, but bpf program will not convert pointers
>     to user base at run-time to improve bpf program speed.
> 
> Initially, the kernel vm_area and user vma are not populated. User space can
> fault in pages within the range. While servicing a page fault, bpf_arena logic
> will insert a new page into the kernel and user vmas. The bpf program can
> allocate pages from that region via bpf_arena_alloc_pages(). This kernel
> function will insert pages into the kernel vm_area. The subsequent fault-in
> from user space will populate that page into the user vma. The
> BPF_F_SEGV_ON_FAULT flag at arena creation time can be used to prevent fault-in
> from user space. In such a case, if a page is not allocated by the bpf program
> and not present in the kernel vm_area, the user process will segfault. This is
> useful for use cases 2 and 3 above.
> 
> bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pages
> either at a specific address within the arena or allocates a range with the
> maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees pages
> and removes the range from the kernel vm_area and from user process vmas.
> 
> bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of bpf
> program is more important than ease of sharing with user space. This is use
> case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended. It will
> tell the verifier to treat the rX = bpf_arena_cast_user(rY) instruction as a
> 32-bit move wX = wY, which will improve bpf prog performance. Otherwise,
> bpf_arena_cast_user is translated by JIT to conditionally add the upper 32 bits
> of user vm_start (if the pointer is not NULL) to arena pointers before they are
> stored into memory. This way, user space sees them as valid 64-bit pointers.
> 
> Diff https://github.com/llvm/llvm-project/pull/79902 taught LLVM BPF backend to
> generate the bpf_cast_kern() instruction before dereference of the arena
> pointer and the bpf_cast_user() instruction when the arena pointer is formed.
> In a typical bpf program there will be very few bpf_cast_user().
> 
>  From LLVM's point of view, arena pointers are tagged as
> __attribute__((address_space(1))). Hence, clang provides helpful diagnostics
> when pointers cross address space. Libbpf and the kernel support only
> address_space == 1. All other address space identifiers are reserved.
> 
> rX = bpf_cast_kern(rY, addr_space) tells the verifier that
> rX->type = PTR_TO_ARENA. Any further operations on PTR_TO_ARENA register have
> to be in the 32-bit domain. The verifier will mark load/store through
> PTR_TO_ARENA with PROBE_MEM32. JIT will generate them as
> kern_vm_start + 32bit_addr memory accesses. The behavior is similar to
> copy_from_kernel_nofault() except that no address checks are necessary. The
> address is guaranteed to be in the 4GB range. If the page is not present, the
> destination register is zeroed on read, and the operation is ignored on write.
> 
> rX = bpf_cast_user(rY, addr_space) tells the verifier that
> rX->type = unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV set, then
> the verifier converts cast_user to mov32. Otherwise, JIT will emit native code
> equivalent to:
> rX = (u32)rY;
> if (rY)
>    rX |= clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits in rX */
> 
> After such conversion, the pointer becomes a valid user pointer within
> bpf_arena range. The user process can access data structures created in
> bpf_arena without any additional computations. For example, a linked list built
> by a bpf program can be walked natively by user space.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   include/linux/bpf.h            |   5 +-
>   include/linux/bpf_types.h      |   1 +
>   include/uapi/linux/bpf.h       |   7 +
>   kernel/bpf/Makefile            |   3 +
>   kernel/bpf/arena.c             | 557 +++++++++++++++++++++++++++++++++
>   kernel/bpf/core.c              |  11 +
>   kernel/bpf/syscall.c           |   3 +
>   kernel/bpf/verifier.c          |   1 +
>   tools/include/uapi/linux/bpf.h |   7 +
>   9 files changed, 593 insertions(+), 2 deletions(-)
>   create mode 100644 kernel/bpf/arena.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8b0dcb66eb33..de557c6c42e0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -37,6 +37,7 @@ struct perf_event;
>   struct bpf_prog;
>   struct bpf_prog_aux;
>   struct bpf_map;
> +struct bpf_arena;
>   struct sock;
>   struct seq_file;
>   struct btf;
> @@ -534,8 +535,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>   			struct bpf_spin_lock *spin_lock);
>   void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>   		      struct bpf_spin_lock *spin_lock);
> -
> -
> +u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
> +u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
>   int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
>   
>   struct bpf_offload_dev;
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 94baced5a1ad..9f2a6b83b49e 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -132,6 +132,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>   BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>   BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>   BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
>   
>   BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>   BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d96708380e52..f6648851eae6 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -983,6 +983,7 @@ enum bpf_map_type {
>   	BPF_MAP_TYPE_BLOOM_FILTER,
>   	BPF_MAP_TYPE_USER_RINGBUF,
>   	BPF_MAP_TYPE_CGRP_STORAGE,
> +	BPF_MAP_TYPE_ARENA,
>   	__MAX_BPF_MAP_TYPE
>   };
>   
> @@ -1370,6 +1371,12 @@ enum {
>   
>   /* BPF token FD is passed in a corresponding command's token_fd field */
>   	BPF_F_TOKEN_FD          = (1U << 16),
> +
> +/* When user space page faults in bpf_arena send SIGSEGV instead of inserting new page */
> +	BPF_F_SEGV_ON_FAULT	= (1U << 17),
> +
> +/* Do not translate kernel bpf_arena pointers to user pointers */
> +	BPF_F_NO_USER_CONV	= (1U << 18),
>   };
>   
>   /* Flags for BPF_PROG_QUERY. */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 4ce95acfcaa7..368c5d86b5b7 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -15,6 +15,9 @@ obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
>   obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
>   obj-$(CONFIG_BPF_JIT) += trampoline.o
>   obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
> +ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
> +obj-$(CONFIG_BPF_SYSCALL) += arena.o
> +endif
>   obj-$(CONFIG_BPF_JIT) += dispatcher.o
>   ifeq ($(CONFIG_NET),y)
>   obj-$(CONFIG_BPF_SYSCALL) += devmap.o
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
> + * bpf_arena is a sparsely populated shared memory region between bpf program and
> + * user space process.
> + *
> + * For example on x86-64 the values could be:
> + * user_vm_start 7f7d26200000     // picked by mmap()
> + * kern_vm_start ffffc90001e69000 // picked by get_vm_area()
> + * For user space all pointers within the arena are normal 8-byte addresses.
> + * In this example 7f7d26200000 is the address of the first page (pgoff=0).
> + * The bpf program will access it as: kern_vm_start + lower_32bit_of_user_ptr
> + * (u32)7f7d26200000 -> 26200000
> + * hence
> + * ffffc90001e69000 + 26200000 == ffffc90028069000 is "pgoff=0" within 4Gb
> + * kernel memory region.
> + *
> + * BPF JITs generate the following code to access arena:
> + *   mov eax, eax  // eax has lower 32-bit of user pointer
> + *   mov word ptr [rax + r12 + off], bx
> + * where r12 == kern_vm_start and off is s16.
> + * Hence allocate 4Gb + GUARD_SZ/2 on each side.
> + *
> + * Initially kernel vm_area and user vma are not populated.
> + * User space can fault-in any address which will insert the page
> + * into kernel and user vma.
> + * bpf program can allocate a page via bpf_arena_alloc_pages() kfunc
> + * which will insert it into kernel vm_area.
> + * The later fault-in from user space will populate that page into user vma.
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
> +static long arena_map_push_elem(struct bpf_map *map, void *value, u64 flags)
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
> +static int arena_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
> +	int numa_node = bpf_map_attr_numa_node(attr);
> +	struct bpf_arena *arena;
> +	u64 vm_range;
> +	int err = -ENOMEM;
> +
> +	if (attr->key_size || attr->value_size || attr->max_entries == 0 ||
> +	    /* BPF_F_MMAPABLE must be set */
> +	    !(attr->map_flags & BPF_F_MMAPABLE) ||
> +	    /* No unsupported flags present */
> +	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | BPF_F_NO_USER_CONV)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (attr->map_extra & ~PAGE_MASK)
> +		/* If non-zero the map_extra is an expected user VMA start address */
> +		return ERR_PTR(-EINVAL);
> +
> +	vm_range = (u64)attr->max_entries * PAGE_SIZE;
> +	if (vm_range > (1ull << 32))
> +		return ERR_PTR(-E2BIG);
> +
> +	if ((attr->map_extra >> 32) != ((attr->map_extra + vm_range - 1) >> 32))
> +		/* user vma must not cross 32-bit boundary */
> +		return ERR_PTR(-ERANGE);
> +
> +	kern_vm = get_vm_area(KERN_VM_SZ, VM_MAP | VM_USERMAP);
> +	if (!kern_vm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	arena = bpf_map_area_alloc(sizeof(*arena), numa_node);
> +	if (!arena)
> +		goto err;
> +
> +	arena->kern_vm = kern_vm;
> +	arena->user_vm_start = attr->map_extra;
> +	if (arena->user_vm_start)
> +		arena->user_vm_end = arena->user_vm_start + vm_range;
> +
> +	INIT_LIST_HEAD(&arena->vma_list);
> +	bpf_map_init_from_attr(&arena->map, attr);
> +	mt_init_flags(&arena->mt, MT_FLAGS_ALLOC_RANGE);
> +	mutex_init(&arena->lock);
> +
> +	return &arena->map;
> +err:
> +	free_vm_area(kern_vm);
> +	return ERR_PTR(err);
> +}
> +
> +static int for_each_pte(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	struct page *page;
> +	pte_t pte;
> +
> +	pte = ptep_get(ptep);
> +	if (!pte_present(pte))
> +		return 0;
> +	page = pte_page(pte);
> +	/*
> +	 * We do not update pte here:
> +	 * 1. Nobody should be accessing bpf_arena's range outside of a kernel bug
> +	 * 2. TLB flushing is batched or deferred. Even if we clear pte,
> +	 * the TLB entries can stick around and continue to permit access to
> +	 * the freed page. So it all relies on 1.
> +	 */
> +	__free_page(page);
> +	return 0;
> +}
> +
> +static void arena_map_free(struct bpf_map *map)
> +{
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	/*
> +	 * Check that user vma-s are not around when bpf map is freed.
> +	 * mmap() holds vm_file which holds bpf_map refcnt.
> +	 * munmap() must have happened on vma followed by arena_vm_close()
> +	 * which would clear arena->vma_list.
> +	 */
> +	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
> +		return;
> +
> +	/*
> +	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
> +	 * It unmaps everything from vmalloc area and clears pgtables.
> +	 * Call apply_to_existing_page_range() first to find populated ptes and
> +	 * free those pages.
> +	 */
> +	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
> +				     KERN_VM_SZ - GUARD_SZ / 2, for_each_pte, NULL);
> +	free_vm_area(arena->kern_vm);
> +	mtree_destroy(&arena->mt);
> +	bpf_map_area_free(arena);
> +}
> +
> +static void *arena_map_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static long arena_map_update_elem(struct bpf_map *map, void *key,
> +				  void *value, u64 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int arena_map_check_btf(const struct bpf_map *map, const struct btf *btf,
> +			       const struct btf_type *key_type, const struct btf_type *value_type)
> +{
> +	return 0;
> +}
> +
> +static u64 arena_map_mem_usage(const struct bpf_map *map)
> +{
> +	return 0;
> +}
> +
> +struct vma_list {
> +	struct vm_area_struct *vma;
> +	struct list_head head;
> +};
> +
> +static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
> +{
> +	struct vma_list *vml;
> +
> +	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
> +	if (!vml)
> +		return -ENOMEM;
> +	vma->vm_private_data = vml;
> +	vml->vma = vma;
> +	list_add(&vml->head, &arena->vma_list);
> +	return 0;
> +}
> +
> +static void arena_vm_close(struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	struct vma_list *vml;
> +
> +	guard(mutex)(&arena->lock);
> +	vml = vma->vm_private_data;
> +	list_del(&vml->head);
> +	vma->vm_private_data = NULL;
> +	kfree(vml);
> +}
> +
> +#define MT_ENTRY ((void *)&arena_map_ops) /* unused. has to be valid pointer */
> +
> +static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
> +{
> +	struct bpf_map *map = vmf->vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	struct page *page;
> +	long kbase, kaddr;
> +	int ret;
> +
> +	kbase = bpf_arena_get_kern_vm_start(arena);
> +	kaddr = kbase + (u32)(vmf->address & PAGE_MASK);
> +
> +	guard(mutex)(&arena->lock);
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (page)
> +		/* already have a page vmap-ed */
> +		goto out;
> +
> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> +		/* User space requested to segfault when page is not allocated by bpf prog */
> +		return VM_FAULT_SIGSEGV;
> +
> +	ret = mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL);
> +	if (ret)
> +		return VM_FAULT_SIGSEGV;
> +
> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!page) {
> +		mtree_erase(&arena->mt, vmf->pgoff);
> +		return VM_FAULT_SIGSEGV;
> +	}
> +
> +	ret = vmap_pages_range(kaddr, kaddr + PAGE_SIZE, PAGE_KERNEL, &page, PAGE_SHIFT);
> +	if (ret) {
> +		mtree_erase(&arena->mt, vmf->pgoff);
> +		__free_page(page);
> +		return VM_FAULT_SIGSEGV;
> +	}
> +out:
> +	page_ref_add(page, 1);
> +	vmf->page = page;
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct arena_vm_ops = {
> +	.close		= arena_vm_close,
> +	.fault          = arena_vm_fault,
> +};
> +
> +static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long addr,
> +					     unsigned long len, unsigned long pgoff,
> +					     unsigned long flags)
> +{
> +	struct bpf_map *map = filp->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	long ret;
> +
> +	if (pgoff)
> +		return -EINVAL;
> +	if (len > (1ull << 32))
> +		return -E2BIG;
> +
> +	/* if user_vm_start was specified at arena creation time */
> +	if (arena->user_vm_start) {
> +		if (len > arena->user_vm_end - arena->user_vm_start)
> +			return -E2BIG;
> +		if (len != arena->user_vm_end - arena->user_vm_start)
> +			return -EINVAL;
> +		if (addr != arena->user_vm_start)
> +			return -EINVAL;
> +	}
> +
> +	ret = current->mm->get_unmapped_area(filp, addr, len * 2, 0, flags);
> +	if (IS_ERR_VALUE(ret))
> +                return 0;
> +	if ((ret >> 32) == ((ret + len - 1) >> 32))
> +		return ret;
> +	if (WARN_ON_ONCE(arena->user_vm_start))
> +		/* checks at map creation time should prevent this */
> +		return -EFAULT;
> +	return round_up(ret, 1ull << 32);
> +}
> +
> +static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
> +{
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	guard(mutex)(&arena->lock);
> +	if (arena->user_vm_start && arena->user_vm_start != vma->vm_start)
> +		/*
> +		 * If map_extra was not specified at arena creation time then
> +		 * 1st user process can do mmap(NULL, ...) to pick user_vm_start
> +		 * 2nd user process must pass the same addr to mmap(addr, MAP_FIXED..);
> +		 *   or
> +		 * specify addr in map_extra and
> +		 * use the same addr later with mmap(addr, MAP_FIXED..);
> +		 */
> +		return -EBUSY;
> +
> +	if (arena->user_vm_end && arena->user_vm_end != vma->vm_end)
> +		/* all user processes must have the same size of mmap-ed region */
> +		return -EBUSY;
> +
> +	/* Earlier checks should prevent this */
> +	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > (1ull << 32) || vma->vm_pgoff))
> +		return -EFAULT;
> +
> +	if (remember_vma(arena, vma))
> +		return -ENOMEM;
> +
> +	arena->user_vm_start = vma->vm_start;
> +	arena->user_vm_end = vma->vm_end;
> +	/*
> +	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
> +	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
> +	 * potential change of user_vm_start.
> +	 */
> +	vm_flags_set(vma, VM_DONTEXPAND);
> +	vma->vm_ops = &arena_vm_ops;
> +	return 0;
> +}
> +
> +static int arena_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
> +{
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
> +		return -ERANGE;
> +	*imm = (unsigned long)arena->user_vm_start;
> +	return 0;
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_arena_map_btf_ids, struct, bpf_arena)
> +const struct bpf_map_ops arena_map_ops = {
> +	.map_meta_equal = bpf_map_meta_equal,
> +	.map_alloc = arena_map_alloc,
> +	.map_free = arena_map_free,
> +	.map_direct_value_addr = arena_map_direct_value_addr,
> +	.map_mmap = arena_map_mmap,
> +	.map_get_unmapped_area = arena_get_unmapped_area,
> +	.map_get_next_key = arena_map_get_next_key,
> +	.map_push_elem = arena_map_push_elem,
> +	.map_peek_elem = arena_map_peek_elem,
> +	.map_pop_elem = arena_map_pop_elem,
> +	.map_lookup_elem = arena_map_lookup_elem,
> +	.map_update_elem = arena_map_update_elem,
> +	.map_delete_elem = arena_map_delete_elem,
> +	.map_check_btf = arena_map_check_btf,
> +	.map_mem_usage = arena_map_mem_usage,
> +	.map_btf_id = &bpf_arena_map_btf_ids[0],
> +};
> +
> +static u64 clear_lo32(u64 val)
> +{
> +	return val & ~(u64)~0U;
> +}
> +
> +/*
> + * Allocate pages and vmap them into kernel vmalloc area.
> + * Later the pages will be mmaped into user space vma.
> + */
> +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id)
> +{
> +	/* user_vm_end/start are fixed before bpf prog runs */
> +	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
> +	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
> +	long pgoff = 0, nr_pages = 0;
> +	struct page **pages;
> +	u32 uaddr32;
> +	int ret, i;
> +
> +	if (page_cnt > page_cnt_max)
> +		return 0;
> +
> +	if (uaddr) {
> +		if (uaddr & ~PAGE_MASK)
> +			return 0;
> +		pgoff = compute_pgoff(arena, uaddr);
> +		if (pgoff + page_cnt > page_cnt_max)
> +			/* requested address will be outside of user VMA */
> +			return 0;
> +	}
> +
> +	/* zeroing is needed, since alloc_pages_bulk_array() only fills in non-zero entries */
> +	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return 0;
> +
> +	guard(mutex)(&arena->lock);
> +
> +	if (uaddr)
> +		ret = mtree_insert_range(&arena->mt, pgoff, pgoff + page_cnt - 1,
> +					 MT_ENTRY, GFP_KERNEL);
> +	else
> +		ret = mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
> +					page_cnt, 0, page_cnt_max - 1, GFP_KERNEL);
> +	if (ret)
> +		goto out_free_pages;
> +
> +	nr_pages = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_ZERO, node_id, page_cnt, pages);
> +	if (nr_pages != page_cnt)
> +		goto out;
> +
> +	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> +	/* Earlier checks make sure that uaddr32 + page_cnt * PAGE_SIZE will not overflow 32-bit */
> +	ret = vmap_pages_range(kern_vm_start + uaddr32,
> +			       kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE,
> +			       PAGE_KERNEL, pages, PAGE_SHIFT);
> +	if (ret)
> +		goto out;
> +	kvfree(pages);
> +	return clear_lo32(arena->user_vm_start) + uaddr32;
> +out:
> +	mtree_erase(&arena->mt, pgoff);
> +out_free_pages:
> +	if (pages)
> +		for (i = 0; i < nr_pages; i++)
> +			__free_page(pages[i]);
> +	kvfree(pages);
> +	return 0;
> +}
> +
> +/*
> + * If page is present in vmalloc area, unmap it from vmalloc area,
> + * unmap it from all user space vma-s,
> + * and free it.
> + */
> +static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> +{
> +	struct vma_list *vml;
> +
> +	list_for_each_entry(vml, &arena->vma_list, head)
> +		zap_page_range_single(vml->vma, uaddr,
> +				      PAGE_SIZE * page_cnt, NULL);
> +}
> +
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> +{
> +	u64 full_uaddr, uaddr_end;
> +	long kaddr, pgoff, i;
> +	struct page *page;
> +
> +	/* only aligned lower 32-bit are relevant */
> +	uaddr = (u32)uaddr;
> +	uaddr &= PAGE_MASK;
> +	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
> +	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
> +	if (full_uaddr >= uaddr_end)
> +		return;
> +
> +	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> +
> +	guard(mutex)(&arena->lock);
> +
> +	pgoff = compute_pgoff(arena, uaddr);
> +	/* clear range */
> +	mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt - 1, NULL, GFP_KERNEL);
> +
> +	if (page_cnt > 1)
> +		/* bulk zap if multiple pages being freed */
> +		zap_pages(arena, full_uaddr, page_cnt);
> +
> +	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
> +	for (i = 0; i < page_cnt; i++, kaddr += PAGE_SIZE, full_uaddr += PAGE_SIZE) {
> +		page = vmalloc_to_page((void *)kaddr);
> +		if (!page)
> +			continue;
> +		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
> +			zap_pages(arena, full_uaddr, 1);
> +		vunmap_range(kaddr, kaddr + PAGE_SIZE);
> +		__free_page(page);
> +	}
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
> +					int node_id, u64 flags)
> +{
> +	struct bpf_map *map = p__map;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
> +		return NULL;
> +
> +	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id);
> +}
> +
> +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
> +{
> +	struct bpf_map *map = p__map;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> +		return;
> +	arena_free_pages(arena, (long)ptr__ign, page_cnt);
> +}
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(arena_kfuncs)
> +BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
> +BTF_KFUNCS_END(arena_kfuncs)
> +
> +static const struct btf_kfunc_id_set common_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &arena_kfuncs,
> +};
> +
> +static int __init kfunc_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
> +}
> +late_initcall(kfunc_init);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 71c459a51d9e..2539d9bfe369 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2970,6 +2970,17 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
>   {
>   }
>   
> +/* for configs without MMU or 32-bit */
> +__weak const struct bpf_map_ops arena_map_ops;
> +__weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> +{
> +	return 0;
> +}
> +__weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> +{
> +	return 0;
> +}
> +
>   #ifdef CONFIG_BPF_SYSCALL
>   static int __init bpf_global_ma_init(void)
>   {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8dd9814a0e14..6b9efb3f79dd 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -164,6 +164,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>   	if (bpf_map_is_offloaded(map)) {
>   		return bpf_map_offload_update_elem(map, key, value, flags);
>   	} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
> +		   map->map_type == BPF_MAP_TYPE_ARENA ||
>   		   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
>   		return map->ops->map_update_elem(map, key, value, flags);
>   	} else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
> @@ -1172,6 +1173,7 @@ static int map_create(union bpf_attr *attr)
>   	}
>   
>   	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
> +	    attr->map_type != BPF_MAP_TYPE_ARENA &&
>   	    attr->map_extra != 0)
>   		return -EINVAL;
>   
> @@ -1261,6 +1263,7 @@ static int map_create(union bpf_attr *attr)
>   	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
>   	case BPF_MAP_TYPE_STRUCT_OPS:
>   	case BPF_MAP_TYPE_CPUMAP:
> +	case BPF_MAP_TYPE_ARENA:
>   		if (!bpf_token_capable(token, CAP_BPF))
>   			goto put_token;
>   		break;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db569ce89fb1..3c77a3ab1192 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18047,6 +18047,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>   		case BPF_MAP_TYPE_SK_STORAGE:
>   		case BPF_MAP_TYPE_TASK_STORAGE:
>   		case BPF_MAP_TYPE_CGRP_STORAGE:
> +		case BPF_MAP_TYPE_ARENA:
>   			break;
>   		default:
>   			verbose(env,
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d96708380e52..f6648851eae6 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -983,6 +983,7 @@ enum bpf_map_type {
>   	BPF_MAP_TYPE_BLOOM_FILTER,
>   	BPF_MAP_TYPE_USER_RINGBUF,
>   	BPF_MAP_TYPE_CGRP_STORAGE,
> +	BPF_MAP_TYPE_ARENA,
>   	__MAX_BPF_MAP_TYPE
>   };
>   
> @@ -1370,6 +1371,12 @@ enum {
>   
>   /* BPF token FD is passed in a corresponding command's token_fd field */
>   	BPF_F_TOKEN_FD          = (1U << 16),
> +
> +/* When user space page faults in bpf_arena send SIGSEGV instead of inserting new page */
> +	BPF_F_SEGV_ON_FAULT	= (1U << 17),
> +
> +/* Do not translate kernel bpf_arena pointers to user pointers */
> +	BPF_F_NO_USER_CONV	= (1U << 18),
>   };
>   
>   /* Flags for BPF_PROG_QUERY. */


