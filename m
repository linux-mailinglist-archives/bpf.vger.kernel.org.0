Return-Path: <bpf+bounces-21584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CF84EF82
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C49E1F21EDB
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF1522A;
	Fri,  9 Feb 2024 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYKugHeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78E5224
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451576; cv=none; b=tEDhwqchpPK6tC0nm/ezqe7DszlARQRLPLmS3UYxsKybqKNpnwKvCzWxYw+oc21QqVwuRQyVFaXCs+aQmO7gpNShayHSYOL7L/cy7vAUhIw01+2zDGTGhw8IwOxzS8kSu2kRcTtB0oOL7YnyzwINH4IrKJPtmbthvzFjJFQd36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451576; c=relaxed/simple;
	bh=yidDh/CAAM+4r43qkoOlB9Xj3JtUC+Yz4OSBhI2yKJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXiIqkzjIannKcHO+/b+YcLyGIArWx1ryDurSsU4de18V6BCLAtICS1WTGAXKrg5q8edeqjC7JMJAMyRYT4gU8SSEFWh8DOWWCSfeJPV1JAxtH/uHmSsBfqnhHvwAiGYd39t5AkMCBaU/l7eEYwfH7PtDLScozP3zr7u5pOtGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYKugHeI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e06d2180b0so441616b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451573; x=1708056373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEkkqCA203eDpu5hFhuFOhVB44CDrteH7OTjO7Ka5i0=;
        b=nYKugHeIrq1Z4kN5uOLKNUjg4iRJ+QcgOgZVGMJkSZd+cpvD3dmZKcJMnjQE8gpKUy
         T/iQj6Fh4x3mVwrFzEXjiEH4+VZTeiB8bVnMqpVDmewouC6IEx0CwSreM9cZqLwwTsZu
         THWyz83J1y4/v7OAimTOHovv2vG7N8k76PLDI8shf0JYclDEc+DGvhu6SSq3ArxBMIV5
         j8xfb9CXR+DU5BcQiPNoj7neG6FPlJ6sB9S/fTJniroUOwcoX5X14t7HMKTk8V5g88sa
         dYbGsmMVlC3HE63U+DxrDDZVbLjsoHYy8Ph9wY5Fu8B2fEAJdJBULGOKCzFysZ4BZjn3
         0TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451573; x=1708056373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEkkqCA203eDpu5hFhuFOhVB44CDrteH7OTjO7Ka5i0=;
        b=QPKsX4UEZFDc2e/edEB2z6Zk2keNnFO7aGITagRcsVtm2Qu1WnwuRqMhCa11m6Kp0A
         8TvaSnginOZyPKuWKNjqk8eysj8G+IDU7FGmGXLhGcDfOc/7UVnrklIRmXqb+0m1KcLK
         wQfO17tsna1TI8+CeIkz3T6jVCmw1YsdfVRKyUjTDNzSqDE5G1WuLheazt1NsRLYEMlT
         g+bglCSvP8aYfdWRX0rdIxhsjlhf3zP7IcAavvEYWTsBUea/HycA6CZM7I36Yzm8e4dS
         R2CwOmADEHM4XBKG0Gvrt6MuYUlhbK1AKATAZxz6gcClAYN0xGVXBXT9c0KVwdPVVwy8
         5lbg==
X-Gm-Message-State: AOJu0YxLSEjsxtkP6gYWnm1ZB5WmrbjrpNAP94Fb8pZsgqWK/4niGhvE
	uz6oxu/qvMvJwv4ZoXFlk2nHKktaJ6BILCL44ZjGVeRQ7fTW/tzzHMqzYMz6
X-Google-Smtp-Source: AGHT+IFvcQsVrVG6+SGe1INK5B7SoWZ5sJrALhybapLaBNn1EcSUIMtEW0BDkqrCzlBMT6007/jHfw==
X-Received: by 2002:a05:6a20:2d21:b0:19e:9b1d:574d with SMTP id g33-20020a056a202d2100b0019e9b1d574dmr907083pzl.18.1707451573213;
        Thu, 08 Feb 2024 20:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/ssESUSmVBd+T6j9iMIRQ9733sIBYkBIdme5EBUSmrbzmGOwLVEX6Yi0jGuAKp1O1B0KdPubWfNOqB+JEqH8kMi0ejAfW+ZBA7I4my9DHIQOhvdrS4lBL9T6s/yN8fFyD5XpuayRq8KZGC390eXqCDHcHzCTK9LUDFS674CTkPSj15XzPQGWqOT6PI3UllpORDlyF7hxSxGGWLUxtAf+HDyTd3owbb5Xe/Je1AYtExcBzNZdzN7s8fVtREsRgrSMbf6LGF5Q4UCQhThhOH6l2quBB6Pg/M3moM1PEaGKh5yQwmmjobEUBLwMG9SiPEZwFtWnef6ZnLW9QBYpzGjymFue/8jywyfpcGm8fCqHR+gc0QqIESA==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id sm6-20020a17090b2e4600b002963e682f6fsm633878pjb.57.2024.02.08.20.06.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 00/20] bpf: Introduce BPF arena.
Date: Thu,  8 Feb 2024 20:05:48 -0800
Message-Id: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- Improved commit log with reasons for using vmap_pages_range() in bpf_arena.
  Thanks to Johannes
- Added support for __arena global variables in bpf programs
- Fixed race conditions spotted by Barret
- Fixed wrap32 issue spotted by Barret
- Fixed bpf_map_mmap_sz() the way Andrii suggested

The work on bpf_arena was inspired by Barret's work:
https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
that implements queues, lists and AVL trees completely as bpf programs
using giant bpf array map and integer indices instead of pointers.
bpf_arena is a sparse array that allows to use normal C pointers to
build such data structures. Last few patches implement page_frag
allocator, link list and hash table as bpf programs.

v1:
bpf programs have multiple options to communicate with user space:
- Various ring buffers (perf, ftrace, bpf): The data is streamed
  unidirectionally from bpf to user space.
- Hash map: The bpf program populates elements, and user space consumes them
  via bpf syscall.
- mmap()-ed array map: Libbpf creates an array map that is directly accessed by
  the bpf program and mmap-ed to user space. It's the fastest way. Its
  disadvantage is that memory for the whole array is reserved at the start.

Introduce bpf_arena, which is a sparse shared memory region between the bpf
program and user space.

Use cases:
1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
   region, like memcached or any key/value storage. The bpf program implements an
   in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
   value without going to user space.
2. The bpf program builds arbitrary data structures in bpf_arena (hash tables,
   rb-trees, sparse arrays), while user space consumes it.
3. bpf_arena is a "heap" of memory from the bpf program's point of view.
   The user space may mmap it, but bpf program will not convert pointers
   to user base at run-time to improve bpf program speed.

Initially, the kernel vm_area and user vma are not populated. User space can
fault in pages within the range. While servicing a page fault, bpf_arena logic
will insert a new page into the kernel and user vmas. The bpf program can
allocate pages from that region via bpf_arena_alloc_pages(). This kernel
function will insert pages into the kernel vm_area. The subsequent fault-in
from user space will populate that page into the user vma. The
BPF_F_SEGV_ON_FAULT flag at arena creation time can be used to prevent fault-in
from user space. In such a case, if a page is not allocated by the bpf program
and not present in the kernel vm_area, the user process will segfault. This is
useful for use cases 2 and 3 above.

bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pages
either at a specific address within the arena or allocates a range with the
maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees pages
and removes the range from the kernel vm_area and from user process vmas.

bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of bpf
program is more important than ease of sharing with user space. This is use
case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended. It will
tell the verifier to treat the rX = bpf_arena_cast_user(rY) instruction as a
32-bit move wX = wY, which will improve bpf prog performance. Otherwise,
bpf_arena_cast_user is translated by JIT to conditionally add the upper 32 bits
of user vm_start (if the pointer is not NULL) to arena pointers before they are
stored into memory. This way, user space sees them as valid 64-bit pointers.

Diff https://github.com/llvm/llvm-project/pull/79902 taught LLVM BPF backend to
generate the bpf_cast_kern() instruction before dereference of the arena
pointer and the bpf_cast_user() instruction when the arena pointer is formed.
In a typical bpf program there will be very few bpf_cast_user().

From LLVM's point of view, arena pointers are tagged as
__attribute__((address_space(1))). Hence, clang provides helpful diagnostics
when pointers cross address space. Libbpf and the kernel support only
address_space == 1. All other address space identifiers are reserved.

rX = bpf_cast_kern(rY, addr_space) tells the verifier that
rX->type = PTR_TO_ARENA. Any further operations on PTR_TO_ARENA register have
to be in the 32-bit domain. The verifier will mark load/store through
PTR_TO_ARENA with PROBE_MEM32. JIT will generate them as
kern_vm_start + 32bit_addr memory accesses. The behavior is similar to
copy_from_kernel_nofault() except that no address checks are necessary. The
address is guaranteed to be in the 4GB range. If the page is not present, the
destination register is zeroed on read, and the operation is ignored on write.

rX = bpf_cast_user(rY, addr_space) tells the verifier that
rX->type = unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV set, then
the verifier converts cast_user to mov32. Otherwise, JIT will emit native code
equivalent to:
rX = (u32)rY;
if (rY)
  rX |= clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits in rX */

After such conversion, the pointer becomes a valid user pointer within
bpf_arena range. The user process can access data structures created in
bpf_arena without any additional computations. For example, a linked list built
by a bpf program can be walked natively by user space. The last two patches
demonstrate how algorithms in the C language can be compiled as a bpf program
and as native code.

Followup patches are planned:
. support bpf_spin_lock in arena
  bpf programs running on different CPUs can synchronize access to the arena via
  existing bpf_spin_lock mechanisms (spin_locks in bpf_array or in bpf hash map).
  It will be more convenient to allow spin_locks inside the arena too.

Patch set overview:
..
- patch 4: export vmap_pages_range() to be used outside of mm directory
- patch 5: main patch that introduces bpf_arena map type. See commit log
..
- patch 9: main verifier patch to support bpf_arena
..
- patch 11-14: libbpf support for arena
..
- patch 17-20: tests

Alexei Starovoitov (20):
  bpf: Allow kfuncs return 'void *'
  bpf: Recognize '__map' suffix in kfunc arguments
  bpf: Plumb get_unmapped_area() callback into bpf_map_ops
  mm: Expose vmap_pages_range() to the rest of the kernel.
  bpf: Introduce bpf_arena.
  bpf: Disasm support for cast_kern/user instructions.
  bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
  bpf: Add x86-64 JIT support for bpf_cast_user instruction.
  bpf: Recognize cast_kern/user instructions in the verifier.
  bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
  libbpf: Add __arg_arena to bpf_helpers.h
  libbpf: Add support for bpf_arena.
  libbpf: Allow specifying 64-bit integers in map BTF.
  libbpf: Recognize __arena global varaibles.
  bpf: Tell bpf programs kernel's PAGE_SIZE
  bpf: Add helper macro bpf_arena_cast()
  selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
  selftests/bpf: Add bpf_arena_list test.
  selftests/bpf: Add bpf_arena_htab test.
  selftests/bpf: Convert simple page_frag allocator to per-cpu.

 arch/x86/net/bpf_jit_comp.c                   | 222 ++++++-
 include/linux/bpf.h                           |  11 +-
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   4 +
 include/linux/vmalloc.h                       |   2 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/arena.c                            | 557 ++++++++++++++++++
 kernel/bpf/btf.c                              |  19 +-
 kernel/bpf/core.c                             |  23 +-
 kernel/bpf/disasm.c                           |  11 +
 kernel/bpf/log.c                              |   3 +
 kernel/bpf/syscall.c                          |  15 +
 kernel/bpf/verifier.c                         | 135 ++++-
 mm/vmalloc.c                                  |   4 +-
 tools/bpf/bpftool/gen.c                       |  13 +-
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   6 +
 tools/lib/bpf/libbpf.c                        | 189 +++++-
 tools/lib/bpf/libbpf_probes.c                 |   7 +
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   2 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h |  67 +++
 .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++
 tools/testing/selftests/bpf/bpf_arena_list.h  |  95 +++
 .../testing/selftests/bpf/bpf_experimental.h  |  41 ++
 .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++
 .../selftests/bpf/prog_tests/arena_list.c     |  68 +++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../testing/selftests/bpf/progs/arena_htab.c  |  46 ++
 .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
 .../testing/selftests/bpf/progs/arena_list.c  |  76 +++
 .../selftests/bpf/progs/verifier_arena.c      |  91 +++
 tools/testing/selftests/bpf/test_loader.c     |   9 +-
 36 files changed, 1969 insertions(+), 43 deletions(-)
 create mode 100644 kernel/bpf/arena.c
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c

-- 
2.34.1


