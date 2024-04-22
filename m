Return-Path: <bpf+bounces-27381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8588AC93B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 11:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677D328338C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B513BC23;
	Mon, 22 Apr 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq9oZW8S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C064A98;
	Mon, 22 Apr 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779096; cv=none; b=SqluZylL7KIZUHBIUQ5uMUeu5UVr81FPaXF4vteaky0scnC7DPKFnuWiGyEN9zz24Fk0bIDpCe8TwB2/5viaPuZb3R5af6IUOlXB9axEVHDVEvy1mcAEoTd/ouWFcA9P2EYOQZtWx2JpQjsjhrHnd5gECeeRYpoobFFDEmpl2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779096; c=relaxed/simple;
	bh=uCqbzvPZq288hG4XoIWQdXz6usWeZU9rInsRoxq3uRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CYwl4CDrtEVa8D+6XQfLKmk42ujtL9gcUOfFREU27u3Dw4FYSRJj4zDz96JPoRWAtCwmvmWMlThlquDVjO3+EZTLP9TM3I9f46ZssAX9s7KkamQ1UuF+5PAjFNqICel7Ec/1tAOgbnla75q1x25ZiQ0yxllkQcGweEIThG7bY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq9oZW8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46DFC113CC;
	Mon, 22 Apr 2024 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779096;
	bh=uCqbzvPZq288hG4XoIWQdXz6usWeZU9rInsRoxq3uRE=;
	h=From:To:Cc:Subject:Date:From;
	b=Wq9oZW8SV9WNeOAfK+Bh9tajEqJOu7XpQA9boPfE5CRhIfkMQ5hO3YWZqmNj+NRVy
	 G/P1Hy7NQVOdzE1TMQkWDs+WOvNOCfW1dYE9EKGmQE0GnfBfUDoaUYBsOfSx+oSBMV
	 lUKKjGabFq9nF+/RdR6r8ca/l8SpGRk/3NZl1XJxyaTzd/iIiY1XCeC+//4NRsLe6Q
	 ALa8oxjXZUzOccZxS5fSVZKHaQGdavNvCnHSZJTEfZKu5hdYr3XxUB28TNrzWeoRJs
	 xM4oY/OhGCkl5R+tw93mxLtZeazebNVE41NA1xXhf61OrXooP6l5uOFGUdFmWOc/Sj
	 viOaUM46QxrWw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 00/15] mm: jit/text allocator
Date: Mon, 22 Apr 2024 12:44:21 +0300
Message-ID: <20240422094436.3625171-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

(something went wrong with the prevois posting, sorry for the noise)

Hi,

Since v3 I looked into making execmem more of an utility toolbox, as we
discussed at LPC with Mark Rutland, but it was getting more hairier than
having a struct describing architecture constraints and a type identifying
the consumer of execmem.

And I do think that having the description of architecture constraints for
allocations of executable memory in a single place is better than having it
spread all over the place.

The patches available via git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/v5

v5 changes:
* rebase on v6.9-rc4 to avoid a conflict in kprobes
* add copyrights to mm/execmem.c (Luis)
* fix spelling (Ingo)
* define MODULES_VADDDR for sparc (Sam)
* consistently initialize struct execmem_info (Peter)
* reduce #ifdefs in function bodies in kprobes (Masami) 

v4: https://lore.kernel.org/all/20240411160051.2093261-1-rppt@kernel.org
* rebase on v6.9-rc2
* rename execmem_params to execmem_info and execmem_arch_params() to
  execmem_arch_setup()
* use single execmem_alloc() API instead of execmem_{text,data}_alloc() (Song)
* avoid extra copy of execmem parameters (Rick)
* run execmem_init() as core_initcall() except for the architectures that
  may allocated text really early (currently only x86) (Will)
* add acks for some of arm64 and riscv changes, thanks Will and Alexandre
* new commits:
  - drop call to kasan_alloc_module_shadow() on arm64 because it's not
    needed anymore
  - rename MODULE_START to MODULES_VADDR on MIPS
  - use CONFIG_EXECMEM instead of CONFIG_MODULES on powerpc as per Christophe:
    https://lore.kernel.org/all/79062fa3-3402-47b3-8920-9231ad05e964@csgroup.eu/

v3: https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel.org
* add type parameter to execmem allocation APIs
* remove BPF dependency on modules

v2: https://lore.kernel.org/all/20230616085038.4121892-1-rppt@kernel.org
* Separate "module" and "others" allocations with execmem_text_alloc()
and jit_text_alloc()
* Drop ROX entailment on x86
* Add ack for nios2 changes, thanks Dinh Nguyen

v1: https://lore.kernel.org/all/20230601101257.530867-1-rppt@kernel.org

= Cover letter from v1 (sligtly updated) =

module_alloc() is used everywhere as a mean to allocate memory for code.

Beside being semantically wrong, this unnecessarily ties all subsystmes
that need to allocate code, such as ftrace, kprobes and BPF to modules and
puts the burden of code allocation to the modules code.

Several architectures override module_alloc() because of various
constraints where the executable memory can be located and this causes
additional obstacles for improvements of code allocation.

A centralized infrastructure for code allocation allows allocations of
executable memory as ROX, and future optimizations such as caching large
pages for better iTLB performance and providing sub-page allocations for
users that only need small jit code snippets.

Rick Edgecombe proposed perm_alloc extension to vmalloc [1] and Song Liu
proposed execmem_alloc [2], but both these approaches were targeting BPF
allocations and lacked the ground work to abstract executable allocations
and split them from the modules core.

Thomas Gleixner suggested to express module allocation restrictions and
requirements as struct mod_alloc_type_params [3] that would define ranges,
protections and other parameters for different types of allocations used by
modules and following that suggestion Song separated allocations of
different types in modules (commit ac3b43283923 ("module: replace
module_layout with module_memory")) and posted "Type aware module
allocator" set [4].

I liked the idea of parametrising code allocation requirements as a
structure, but I believe the original proposal and Song's module allocator
was too module centric, so I came up with these patches.

This set splits code allocation from modules by introducing execmem_alloc()
and and execmem_free(), APIs, replaces call sites of module_alloc() and
module_memfree() with the new APIs and implements core text and related
allocations in a central place.

Instead of architecture specific overrides for module_alloc(), the
architectures that require non-default behaviour for text allocation must
fill execmem_info structure and implement execmem_arch_setup() that returns
a pointer to that structure. If an architecture does not implement
execmem_arch_setup(), the defaults compatible with the current
modules::module_alloc() are used.

Since architectures define different restrictions on placement,
permissions, alignment and other parameters for memory that can be used by
different subsystems that allocate executable memory, execmem APIs
take a type argument, that will be used to identify the calling subsystem
and to allow architectures to define parameters for ranges suitable for that
subsystem.

The new infrastructure allows decoupling of BPF, kprobes and ftrace from
modules, and most importantly it paves the way for ROX allocations for
executable memory.

[1] https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
[3] https://lore.kernel.org/all/87v8mndy3y.ffs@tglx/
[4] https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel.org


Mike Rapoport (IBM) (15):
  arm64: module: remove unneeded call to kasan_alloc_module_shadow()
  mips: module: rename MODULE_START to MODULES_VADDR
  nios2: define virtual address space for modules
  sparc: simplify module_alloc()
  module: make module_memory_{alloc,free} more self-contained
  mm: introduce execmem_alloc() and execmem_free()
  mm/execmem, arch: convert simple overrides of module_alloc to execmem
  mm/execmem, arch: convert remaining overrides of module_alloc to
    execmem
  riscv: extend execmem_params for generated code allocations
  powerpc: extend execmem_params for kprobes allocations
  arch: make execmem setup available regardless of CONFIG_MODULES
  x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
  powerpc: use CONFIG_EXECMEM instead of CONFIG_MODULES where
    appropriate
  kprobes: remove dependency on CONFIG_MODULES
  bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of

 arch/Kconfig                         |   8 +-
 arch/arm/kernel/module.c             |  34 -------
 arch/arm/mm/init.c                   |  45 +++++++++
 arch/arm64/kernel/module.c           | 126 -----------------------
 arch/arm64/kernel/probes/kprobes.c   |   7 --
 arch/arm64/mm/init.c                 | 140 ++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c        |  11 --
 arch/loongarch/kernel/module.c       |   6 --
 arch/loongarch/mm/init.c             |  21 ++++
 arch/mips/include/asm/pgtable-64.h   |   4 +-
 arch/mips/kernel/module.c            |  10 --
 arch/mips/mm/fault.c                 |   4 +-
 arch/mips/mm/init.c                  |  23 +++++
 arch/nios2/include/asm/pgtable.h     |   5 +-
 arch/nios2/kernel/module.c           |  20 ----
 arch/nios2/mm/init.c                 |  21 ++++
 arch/parisc/kernel/module.c          |  12 ---
 arch/parisc/mm/init.c                |  23 ++++-
 arch/powerpc/Kconfig                 |   2 +-
 arch/powerpc/include/asm/kasan.h     |   2 +-
 arch/powerpc/kernel/head_8xx.S       |   4 +-
 arch/powerpc/kernel/head_book3s_32.S |   6 +-
 arch/powerpc/kernel/kprobes.c        |  22 +---
 arch/powerpc/kernel/module.c         |  38 -------
 arch/powerpc/lib/code-patching.c     |   2 +-
 arch/powerpc/mm/book3s32/mmu.c       |   2 +-
 arch/powerpc/mm/mem.c                |  64 ++++++++++++
 arch/riscv/kernel/module.c           |  12 ---
 arch/riscv/kernel/probes/kprobes.c   |  10 --
 arch/riscv/mm/init.c                 |  45 +++++++++
 arch/riscv/net/bpf_jit_core.c        |  13 ---
 arch/s390/kernel/ftrace.c            |   4 +-
 arch/s390/kernel/kprobes.c           |   4 +-
 arch/s390/kernel/module.c            |  42 +-------
 arch/s390/mm/init.c                  |  30 ++++++
 arch/sparc/include/asm/pgtable_32.h  |   2 +
 arch/sparc/kernel/module.c           |  30 ------
 arch/sparc/mm/Makefile               |   2 +
 arch/sparc/mm/execmem.c              |  21 ++++
 arch/sparc/net/bpf_jit_comp_32.c     |   8 +-
 arch/x86/Kconfig                     |   2 +
 arch/x86/kernel/ftrace.c             |  16 +--
 arch/x86/kernel/kprobes/core.c       |   4 +-
 arch/x86/kernel/module.c             |  51 ----------
 arch/x86/mm/init.c                   |  29 ++++++
 include/linux/execmem.h              | 132 ++++++++++++++++++++++++
 include/linux/module.h               |   9 ++
 include/linux/moduleloader.h         |  15 ---
 kernel/bpf/Kconfig                   |   2 +-
 kernel/bpf/core.c                    |   6 +-
 kernel/kprobes.c                     |  63 +++++++-----
 kernel/module/Kconfig                |   1 +
 kernel/module/main.c                 | 105 +++++++++----------
 kernel/trace/trace_kprobe.c          |  20 +++-
 mm/Kconfig                           |   3 +
 mm/Makefile                          |   1 +
 mm/execmem.c                         | 145 +++++++++++++++++++++++++++
 mm/mm_init.c                         |   2 +
 58 files changed, 910 insertions(+), 581 deletions(-)
 create mode 100644 arch/sparc/mm/execmem.c
 create mode 100644 include/linux/execmem.h
 create mode 100644 mm/execmem.c


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
-- 
2.43.0


