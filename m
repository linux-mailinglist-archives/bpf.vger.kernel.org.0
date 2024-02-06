Return-Path: <bpf+bounces-21365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177684BFB0
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1451F23175
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470C1BC26;
	Tue,  6 Feb 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIArN2Op"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D091BC27
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257088; cv=none; b=I0AztidMXblGXY6yxgu3HOMMqf4cfSQIwGn0NLlnHko09/MDl47ZR0+Icg2hz1AwIzO055kuJT1Nz28MkB7XKZnc9zXhd09N92mpEDyKQPZG8X0CdgHwuZ3mWC507XnCr7D+eztJX507QFYX99SGSxMiYymHQSCRFLF0mwLiLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257088; c=relaxed/simple;
	bh=A+Ru66Tw7gMDRbB297+NKrwbxGCQNJ8MZ7+fbsAOhN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8PwzsGL9ayZXLeOC7Xy0HMPSCFXJDHO7nZK8Ce07amu7I7z8kVQs/p5YWKwfthCzVR3vxxIoC4WnPWPayCiiPg6MSVHbFfALg1f3FZMhhzk3XkIa3rq6YWL7ZdA7t6vuRy5DNH5XS2ASN8bPeT/cgu8UdAelByxfkVzypWnrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIArN2Op; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bc32b04dc9so231807839f.2
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257086; x=1707861886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wgrJzzaBt4YVHJ/ppmhbd4uaNfq8OCIuwnfxSX7DKU=;
        b=cIArN2Opi0BXH3dUc/mvpa5gts6tyRskPd9NKmm+SdPkCwMkNuT11bcverJCGblekp
         bL8TamIAId//5dZxZP3KAcqF1OyRTy5hToaakDYQo7tJ3L2fpNle3oT8lMoLykY6bi8H
         mz66ALBHSE/jzD84fLmTALIc/HAeXYckTLVk7aE4iqmQBPMdNy3Vy5yTvawui2P0tEsw
         f+iXKZ3gOmRRDsAhC8+m5lW5DvadYBPHh+f5TS+fOYVniHnR+je/TEYtQtsQjhjIEyp3
         vqZJicfjXH5eXBU3JU620Tfe+SfbLutNr7HT0DthbWopTRRJqfmnTHnANDcXrHhDHxu3
         iuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257086; x=1707861886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wgrJzzaBt4YVHJ/ppmhbd4uaNfq8OCIuwnfxSX7DKU=;
        b=jerDXFE6xoz2YJ3sTUTmdhlV/8+GbI1IvRKMQeGDOkQBp/u/w00+toExlPI8LARhuO
         6xsznNMczBvnX2q6SnoaAKtamHy5FLPuBsKSJhzLD4u4k/ERWlp8T/1jujV4hhp9rhE8
         cwrJUbWrGDYiO8BsSlcdlk7wwb5LvllJGVaWzy3UWxiXALQjYHo4ynLJjOgiFu0hVptq
         jEn3iOo43HElzAdWfavVQybYsHvTmBkJ2YjC1Rdcn8nBoTl21Zdgfj77Vau9TUAdAar/
         NtN7cH+Sp5OOl8FhEmcCzmuhBlWjGDrkl/cpyQawllYxOK4xbpPB3LlfRPKYtrOTDXzR
         tHqg==
X-Gm-Message-State: AOJu0Yy0q+6iwGKVPgXcQfEvRTHMwLHFGCl3aSUpXSfXdCLmGHlyNTKg
	2/VvmvcM4RRXyKsR5JSDA+IKSxfbsvDfc7CHzpqbNz5nbscTj7KNpKm8cyOd
X-Google-Smtp-Source: AGHT+IH8zcUGY4rUvmQTuorDIPqrba0mMoNRSrSR8ogIMZKligjeO+xAUhIwfsg8DCbc2/gg0XIEyw==
X-Received: by 2002:a6b:4e16:0:b0:7c3:f0db:585e with SMTP id c22-20020a6b4e16000000b007c3f0db585emr3392204iob.9.1707257085454;
        Tue, 06 Feb 2024 14:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUYWJNGrYJDntZ1Lva2ck2OXgpMu3lmdpxaBFjppjMxMg4BqZZI9FmCeGLe7AHfySa+3bi5Ayo/yKpa/36Fu7WTCEDjfJxIKab2SdEvncx08dUwzlq8k4o4PqANWhS7t6zo594jzvlUHCaCO0rlw/DALVUDQD0/j3zdgjU16RpqJXXIXYFJzaM1oEkYNABiy+K8QUoIucWCW447c6DsNejknGyPMwSOiHOngswZfcsNU/EpqA7qG6vScbgTpGPvmT8vTeVcpdBHBlu6WI+ot/QfyazebDs8B8j3
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id 13-20020a63020d000000b005d64d09acffsm2707484pgc.72.2024.02.06.14.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:04:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 00/16] bpf: Introduce BPF arena.
Date: Tue,  6 Feb 2024 14:04:25 -0800
Message-Id: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf programs have multiple options to communicate with user space:
- Various ring buffers (perf, ftrace, bpf): The data is streamed
  unidirectionally from bpf to user space.
- Hash map: The bpf program populates elements, and user space consumes them
  via bpf syscall.
- mmap()-ed array map: Libbpf creates an array map that is directly accessed by
  the bpf program and mmap-ed to user space. It's the fastest way. Its
  disadvantage is that memory for the whole array is reserved at the start.

These patches introduce bpf_arena, which is a sparse shared memory region
between the bpf program and user space.

Use cases:
1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
   region, like memcached or any key/value storage. The bpf program implements an
   in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
   value without going to user space.
2. The bpf program builds arbitrary data structures in bpf_arena (hash tables,
   rb-trees, sparse arrays), while user space occasionally consumes it. 
3. bpf_arena is a "heap" of memory from the bpf program's point of view. It is
   not shared with user space.

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

bpf_arena can be used as a bpf program "heap" of up to 4GB. The memory is not
shared with user space. This is use case 3. In such a case, the
BPF_F_NO_USER_CONV flag is recommended. It will tell the verifier to treat the
rX = bpf_arena_cast_user(rY) instruction as a 32-bit move wX = wY, which will
improve bpf prog performance. Otherwise, bpf_arena_cast_user is translated by
JIT to conditionally add the upper 32 bits of user vm_start (if the pointer is
not NULL) to arena pointers before they are stored into memory. This way, user
space sees them as valid 64-bit pointers.

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
if (rX)
  rX |= arena->user_vm_start & ~(u64)~0U;

After such conversion, the pointer becomes a valid user pointer within
bpf_arena range. The user process can access data structures created in
bpf_arena without any additional computations. For example, a linked list built
by a bpf program can be walked natively by user space. The last two patches
demonstrate how algorithms in the C language can be compiled as a bpf program
and as native code.

Followup patches are planned:
. selftests in asm
. support arena variables in global data. Example:
  void __arena * ptr; // works
  int __arena var; // supported by llvm, but not by kernel and libbpf yet
. support bpf_spin_lock in arena
  bpf programs running on different CPUs can synchronize access to the arena via
  existing bpf_spin_lock mechanisms (spin_locks in bpf_array or in bpf hash map).
  It will be more convenient to allow spin_locks inside the arena too.

Patch set overview:
- patch 1,2: minor verifier enhancements to enable bpf_arena kfuncs
- patch 3: export vmap_pages_range() to be used out side of mm directory
- patch 4: main patch that introduces bpf_arena map type. See commit log
- patch 6: probe_mem32 support in x86 JIT
- patch 7: bpf_cast_user support in x86 JIT
- patch 8: main verifier patch to support bpf_arena
- patch 9: __arg_arena to tag arena pointers in bpf globla functions
- patch 11: libbpf support for arena
- patch 12: __ulong() macro to pass 64-bit constants in BTF
- patch 13: export PAGE_SIZE constant into vmlinux BTF to be used from bpf programs
- patch 14: bpf_arena_cast instruction as inline asm for setups with old LLVM
- patch 15,16: testcases in C

Alexei Starovoitov (16):
  bpf: Allow kfuncs return 'void *'
  bpf: Recognize '__map' suffix in kfunc arguments
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
  bpf: Tell bpf programs kernel's PAGE_SIZE
  bpf: Add helper macro bpf_arena_cast()
  selftests/bpf: Add bpf_arena_list test.
  selftests/bpf: Add bpf_arena_htab test.

 arch/x86/net/bpf_jit_comp.c                   | 222 +++++++-
 include/linux/bpf.h                           |   8 +-
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   4 +
 include/linux/vmalloc.h                       |   2 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/arena.c                            | 518 ++++++++++++++++++
 kernel/bpf/btf.c                              |  19 +-
 kernel/bpf/core.c                             |  23 +-
 kernel/bpf/disasm.c                           |  11 +
 kernel/bpf/log.c                              |   3 +
 kernel/bpf/syscall.c                          |   3 +
 kernel/bpf/verifier.c                         | 127 ++++-
 mm/vmalloc.c                                  |   4 +-
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 tools/lib/bpf/libbpf.c                        |  62 ++-
 tools/lib/bpf/libbpf_probes.c                 |   6 +
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h |  58 ++
 .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++
 tools/testing/selftests/bpf/bpf_arena_list.h  |  95 ++++
 .../testing/selftests/bpf/bpf_experimental.h  |  41 ++
 .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++
 .../selftests/bpf/prog_tests/arena_list.c     |  65 +++
 .../testing/selftests/bpf/progs/arena_htab.c  |  48 ++
 .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
 .../testing/selftests/bpf/progs/arena_list.c  |  75 +++
 32 files changed, 1669 insertions(+), 21 deletions(-)
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

-- 
2.34.1


