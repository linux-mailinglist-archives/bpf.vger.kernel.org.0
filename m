Return-Path: <bpf+bounces-21400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779784CAC1
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81208B2271C
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A25A4CC;
	Wed,  7 Feb 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/tE1Plp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AB76035
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309277; cv=none; b=aLYa4Ell5DS7nBeYxSspzgVxHOjmiy9ThE/d79K7e6H+WsKPUn8RO8XQiT7lkMvUPErawAYzKF+bUaTW6ZfQw5wh4AkR+bDaUB77pflPH7sBWsgmk36s0DqHVxJVlNoZhgplVDOqDJ37mwkHuD1WZf7GaMEBaMbJE7tcGeWNXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309277; c=relaxed/simple;
	bh=D38rePpLi69MR7HOnQsl81D8EVjUw2bY1e7jhJ4iIYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=d6AoXfE6SrO3np/EveDKECEwYhlQcgBKEK9Vg3vCffEPKeWunEKYfi1gfPhwTrIDQVsA7WLOG8E+c0unNww8fzxGrX3EusEU1WV/IhV5IETzPMEHB9QRdm1WJu1ZHsu4NFtc1GPA3Yli9Mum/uSqP/iPTTIos7ula/HE8OmLaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/tE1Plp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so4859415e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 04:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707309274; x=1707914074; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1uTmNcfzAF+gjMkYf3jUIsxGBz4Fag6C6Y+rI0n2lw=;
        b=f/tE1PlpsnAp542e73EWpkGa9i6T+ShLbzuExMjVx9QMU+suBAlBvBR1uitzesKqRm
         ksieVttEJJPXTBV+izxEGxbxUNAFBFz1D6OFn8BdqO0uZrAZtiR/xI9PhnpJxwj4rfqK
         f+udOUIw4myES4RyQZy0lUJMA8IifXIogVxrwgMfAvEJL6h9h6IhWS4hamT/PRbZ5Dwr
         +rg5iSrHMzcGu06xsKEn193vGMyf0z+Zxduv/VxdVRBchJlS/OfFvkbqpv9G6BW1uQ2Y
         WPAgzz4oroNLIdrw+pMTrj+Ns1oxe2ZRufzHZbyvKwK9hlmQMzvtI/kEi554bZn8br6j
         OFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707309274; x=1707914074;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1uTmNcfzAF+gjMkYf3jUIsxGBz4Fag6C6Y+rI0n2lw=;
        b=tJUsMIo8A6Cwej/7kkiQXe8CzgRHLfImHxzC6xdkPlqSxkAYQ2ch2yY4al3IbLSFEw
         F4tVluAMgVzXs3wMHYa8SOKJlTTEktnMenVJwQ9L86Ej/xdteC7XJZQ0ZdLwtpVG6bOr
         n7UToivpn+29Mz05ThX46akmA/1KPKH42oCSSmZjXaDi7scqTIRiAEnkRTZFvqWKkUbb
         1zqfGWIi6dCBeSwmPA/pefA4EQYA0Wt7eJYwBMhVKZ7P9/IEggNd1DEe2HAjQoWbedPi
         D4e2QSx04AK/RY6LOlIxWX23jPn/6QsqUASNvpA0xAqJWf4ow8LTq82UzApbzFy7PdmT
         i+rw==
X-Gm-Message-State: AOJu0YxZYr3QKskjW6pBmc2Oo8mDsnrG+1abFg6aajffnyhLoc+r92AI
	SxwVtK8s/5QR4ueKnYz1qfaGYG1W08O4Op/R0PfSPn7nU+muz4ey
X-Google-Smtp-Source: AGHT+IGCsAw8odCoP29oj1hnRNZMPgqODjRWhpkst93KCCIeq1kfcR8I6TPaPv+wW7bZxZjVG0vIHQ==
X-Received: by 2002:a05:600c:3b9a:b0:40f:dde7:b882 with SMTP id n26-20020a05600c3b9a00b0040fdde7b882mr4784240wms.31.1707309273409;
        Wed, 07 Feb 2024 04:34:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSf7uVbfvhfwegQVjIjTIdbtYJDcSyBgnMbIEaqgw5QoWIDEK5qpnI/keNw0xaLlv8MK/k2FkN1tcTwC8UzPNjlMx/6iN4a9aPbrEMq5mzi5XfRcr07DPBF4NLBHZdKTIR6f5YR2VCiIVTvHJQDz5UvVcEji2u2dv6OCs0hyxMkK3X9xtejlve21wdDLSkNZh+Fx3910MGlUUVAcn6pjWVXqfbyB8NmC3n/ZzUKvVzb31WLsDptWG0LQBEsTk2bnTtU9zKKlcAC1/dWWlKUD/AmrfXjTs8j4ogPmW94kOune8VV0Uq8w6XQt8eLsh4mQ==
Received: from imac ([2a02:8010:60a0:0:2495:3ca9:a061:eea4])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b0040ffd94cd27sm2766097wmq.45.2024.02.07.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:34:32 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org,  daniel@iogearbox.net,  andrii@kernel.org,
  martin.lau@kernel.org,  memxor@gmail.com,  eddyz87@gmail.com,
  tj@kernel.org,  brho@google.com,  hannes@cmpxchg.org,
  linux-mm@kvack.org,  kernel-team@fb.com
Subject: Re: [PATCH bpf-next 00/16] bpf: Introduce BPF arena.
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com> (Alexei
	Starovoitov's message of "Tue, 6 Feb 2024 14:04:25 -0800")
Date: Wed, 07 Feb 2024 12:34:20 +0000
Message-ID: <m2h6iktpv7.fsf@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> From: Alexei Starovoitov <ast@kernel.org>
>
> bpf programs have multiple options to communicate with user space:
> - Various ring buffers (perf, ftrace, bpf): The data is streamed
>   unidirectionally from bpf to user space.
> - Hash map: The bpf program populates elements, and user space consumes them
>   via bpf syscall.
> - mmap()-ed array map: Libbpf creates an array map that is directly accessed by
>   the bpf program and mmap-ed to user space. It's the fastest way. Its
>   disadvantage is that memory for the whole array is reserved at the start.
>
> These patches introduce bpf_arena, which is a sparse shared memory region
> between the bpf program and user space.

This will need to be documented, probably in a new file at
Documentation/bpf/map_arena.rst since it's cosplaying as a BPF map.

Why is it a map, when it doesn't have map semantics as evidenced by the
-EOPNOTSUPP map accessors? Is it the only way you can reuse the kernel /
userspace plumbing?

> Use cases:
> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
>    region, like memcached or any key/value storage. The bpf program implements an
>    in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
>    value without going to user space.
> 2. The bpf program builds arbitrary data structures in bpf_arena (hash tables,
>    rb-trees, sparse arrays), while user space occasionally consumes it. 
> 3. bpf_arena is a "heap" of memory from the bpf program's point of view. It is
>    not shared with user space.
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
> bpf_arena can be used as a bpf program "heap" of up to 4GB. The memory is not
> shared with user space. This is use case 3. In such a case, the
> BPF_F_NO_USER_CONV flag is recommended. It will tell the verifier to treat the

I can see _what_ this flag does but it's not clear what the consequences
of this flag are. Perhaps it would be better named BPF_F_NO_USER_ACCESS?

> rX = bpf_arena_cast_user(rY) instruction as a 32-bit move wX = wY, which will
> improve bpf prog performance. Otherwise, bpf_arena_cast_user is translated by
> JIT to conditionally add the upper 32 bits of user vm_start (if the pointer is
> not NULL) to arena pointers before they are stored into memory. This way, user
> space sees them as valid 64-bit pointers.
>
> Diff https://github.com/llvm/llvm-project/pull/79902 taught LLVM BPF backend to
> generate the bpf_cast_kern() instruction before dereference of the arena
> pointer and the bpf_cast_user() instruction when the arena pointer is formed.
> In a typical bpf program there will be very few bpf_cast_user().
>
> From LLVM's point of view, arena pointers are tagged as
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
> if (rX)
>   rX |= arena->user_vm_start & ~(u64)~0U;
>
> After such conversion, the pointer becomes a valid user pointer within
> bpf_arena range. The user process can access data structures created in
> bpf_arena without any additional computations. For example, a linked list built
> by a bpf program can be walked natively by user space. The last two patches
> demonstrate how algorithms in the C language can be compiled as a bpf program
> and as native code.
>
> Followup patches are planned:
> . selftests in asm
> . support arena variables in global data. Example:
>   void __arena * ptr; // works
>   int __arena var; // supported by llvm, but not by kernel and libbpf yet
> . support bpf_spin_lock in arena
>   bpf programs running on different CPUs can synchronize access to the arena via
>   existing bpf_spin_lock mechanisms (spin_locks in bpf_array or in bpf hash map).
>   It will be more convenient to allow spin_locks inside the arena too.
>
> Patch set overview:
> - patch 1,2: minor verifier enhancements to enable bpf_arena kfuncs
> - patch 3: export vmap_pages_range() to be used out side of mm directory
> - patch 4: main patch that introduces bpf_arena map type. See commit log
> - patch 6: probe_mem32 support in x86 JIT
> - patch 7: bpf_cast_user support in x86 JIT
> - patch 8: main verifier patch to support bpf_arena
> - patch 9: __arg_arena to tag arena pointers in bpf globla functions
> - patch 11: libbpf support for arena
> - patch 12: __ulong() macro to pass 64-bit constants in BTF
> - patch 13: export PAGE_SIZE constant into vmlinux BTF to be used from bpf programs
> - patch 14: bpf_arena_cast instruction as inline asm for setups with old LLVM
> - patch 15,16: testcases in C
>
> Alexei Starovoitov (16):
>   bpf: Allow kfuncs return 'void *'
>   bpf: Recognize '__map' suffix in kfunc arguments
>   mm: Expose vmap_pages_range() to the rest of the kernel.
>   bpf: Introduce bpf_arena.
>   bpf: Disasm support for cast_kern/user instructions.
>   bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
>   bpf: Add x86-64 JIT support for bpf_cast_user instruction.
>   bpf: Recognize cast_kern/user instructions in the verifier.
>   bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
>   libbpf: Add __arg_arena to bpf_helpers.h
>   libbpf: Add support for bpf_arena.
>   libbpf: Allow specifying 64-bit integers in map BTF.
>   bpf: Tell bpf programs kernel's PAGE_SIZE
>   bpf: Add helper macro bpf_arena_cast()
>   selftests/bpf: Add bpf_arena_list test.
>   selftests/bpf: Add bpf_arena_htab test.
>
>  arch/x86/net/bpf_jit_comp.c                   | 222 +++++++-
>  include/linux/bpf.h                           |   8 +-
>  include/linux/bpf_types.h                     |   1 +
>  include/linux/bpf_verifier.h                  |   1 +
>  include/linux/filter.h                        |   4 +
>  include/linux/vmalloc.h                       |   2 +
>  include/uapi/linux/bpf.h                      |  12 +
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/arena.c                            | 518 ++++++++++++++++++
>  kernel/bpf/btf.c                              |  19 +-
>  kernel/bpf/core.c                             |  23 +-
>  kernel/bpf/disasm.c                           |  11 +
>  kernel/bpf/log.c                              |   3 +
>  kernel/bpf/syscall.c                          |   3 +
>  kernel/bpf/verifier.c                         | 127 ++++-
>  mm/vmalloc.c                                  |   4 +-
>  tools/include/uapi/linux/bpf.h                |  12 +
>  tools/lib/bpf/bpf_helpers.h                   |   2 +
>  tools/lib/bpf/libbpf.c                        |  62 ++-
>  tools/lib/bpf/libbpf_probes.c                 |   6 +
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  tools/testing/selftests/bpf/bpf_arena_alloc.h |  58 ++
>  .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++
>  tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++
>  tools/testing/selftests/bpf/bpf_arena_list.h  |  95 ++++
>  .../testing/selftests/bpf/bpf_experimental.h  |  41 ++
>  .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++
>  .../selftests/bpf/prog_tests/arena_list.c     |  65 +++
>  .../testing/selftests/bpf/progs/arena_htab.c  |  48 ++
>  .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
>  .../testing/selftests/bpf/progs/arena_list.c  |  75 +++
>  32 files changed, 1669 insertions(+), 21 deletions(-)
>  create mode 100644 kernel/bpf/arena.c
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c

