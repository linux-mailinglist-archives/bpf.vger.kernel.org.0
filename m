Return-Path: <bpf+bounces-10249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A287A4257
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B45A1C20C21
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA879C2;
	Mon, 18 Sep 2023 07:30:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0C3C2C;
	Mon, 18 Sep 2023 07:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF90C433C7;
	Mon, 18 Sep 2023 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695022214;
	bh=FqY2R7Jtz2z1dS35nfgqn/BnUCyRu2xGf4mJU4r0njM=;
	h=From:To:Cc:Subject:Date:From;
	b=XNmM3/b0JFbkgOm/zfpoekf5cae26/g6XLPaphd0+yZhWzNrdc4u19ycIPTWNFm6m
	 9Celv2Wb3Q5nRFcdMvHFJ4GRqO2qyDDZz1jP7wIEZ3Y8JHy68r3oUsQ4IEO0Vtjd5l
	 MWP6ADW37I33+ugGA7YfuegWUH+Gn366DxorgNUDiJ4JU0hFytzxH6zJ4ahVC4OF7o
	 i2CGqshElLIQD67W0Y/co2EvMmfkgVCBMPR9hHDUkZjT/Awusm1X0DUINdeDGtq7ce
	 deuuDA2yx7KoWsRzJZri3bCH7lilJOu6sbE4PTUNL0yHtV0Ghtcx/Pg5zFymPEenhw
	 p/MI2wjlDBs5Q==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
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
Subject: [PATCH v3 00/13]  mm: jit/text allocator
Date: Mon, 18 Sep 2023 10:29:42 +0300
Message-Id: <20230918072955.2507221-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

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

This set splits code allocation from modules by introducing
execmem_text_alloc(), execmem_data_alloc() and execmem_free(), APIs,
replaces call sites of module_alloc() and module_memfree() with the new
APIs and implements core text and related allocations in a central place.

Instead of architecture specific overrides for module_alloc(), the
architectures that require non-default behaviour for text allocation must
fill execmem_alloc_params structure and implement execmem_arch_params()
that returns a pointer to that structure. If an architecture does not
implement execmem_arch_params(), the defaults compatible with the current
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

v3 changes:
* add type parameter to execmem allocation APIs
* remove BPF dependency on modules

v2: https://lore.kernel.org/all/20230616085038.4121892-1-rppt@kernel.org
* Separate "module" and "others" allocations with execmem_text_alloc()
and jit_text_alloc()
* Drop ROX entablement on x86
* Add ack for nios2 changes, thanks Dinh Nguyen

v1: https://lore.kernel.org/all/20230601101257.530867-1-rppt@kernel.org

Mike Rapoport (IBM) (13):
  nios2: define virtual address space for modules
  mm: introduce execmem_text_alloc() and execmem_free()
  mm/execmem, arch: convert simple overrides of module_alloc to execmem
  mm/execmem, arch: convert remaining overrides of module_alloc to
    execmem
  modules, execmem: drop module_alloc
  mm/execmem: introduce execmem_data_alloc()
  arm64, execmem: extend execmem_params for generated code allocations
  riscv: extend execmem_params for generated code allocations
  powerpc: extend execmem_params for kprobes allocations
  arch: make execmem setup available regardless of CONFIG_MODULES
  x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
  kprobes: remove dependency on CONFIG_MODULES
  bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of

 arch/Kconfig                       |   2 +-
 arch/arm/kernel/module.c           |  32 -------
 arch/arm/mm/init.c                 |  38 ++++++++
 arch/arm64/kernel/module.c         | 124 -------------------------
 arch/arm64/kernel/probes/kprobes.c |   7 --
 arch/arm64/mm/init.c               | 132 +++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c      |  11 ---
 arch/loongarch/kernel/module.c     |   6 --
 arch/loongarch/mm/init.c           |  20 ++++
 arch/mips/kernel/module.c          |  10 +-
 arch/mips/mm/init.c                |  20 ++++
 arch/nios2/include/asm/pgtable.h   |   5 +-
 arch/nios2/kernel/module.c         |  28 +++---
 arch/parisc/kernel/module.c        |  12 +--
 arch/parisc/mm/init.c              |  22 ++++-
 arch/powerpc/kernel/kprobes.c      |  16 +---
 arch/powerpc/kernel/module.c       |  37 --------
 arch/powerpc/mm/mem.c              |  62 +++++++++++++
 arch/riscv/kernel/module.c         |  10 --
 arch/riscv/kernel/probes/kprobes.c |  10 --
 arch/riscv/mm/init.c               |  39 ++++++++
 arch/riscv/net/bpf_jit_core.c      |  13 ---
 arch/s390/kernel/ftrace.c          |   4 +-
 arch/s390/kernel/kprobes.c         |   4 +-
 arch/s390/kernel/module.c          |  42 +--------
 arch/s390/mm/init.c                |  28 ++++++
 arch/sparc/kernel/module.c         |  33 +------
 arch/sparc/mm/Makefile             |   2 +
 arch/sparc/mm/execmem.c            |  25 +++++
 arch/sparc/net/bpf_jit_comp_32.c   |   8 +-
 arch/x86/Kconfig                   |   1 +
 arch/x86/kernel/ftrace.c           |  16 +---
 arch/x86/kernel/kprobes/core.c     |   4 +-
 arch/x86/kernel/module.c           |  51 -----------
 arch/x86/mm/init.c                 |  29 ++++++
 include/linux/execmem.h            | 141 ++++++++++++++++++++++++++++
 include/linux/moduleloader.h       |  15 ---
 kernel/bpf/Kconfig                 |   2 +-
 kernel/bpf/core.c                  |   6 +-
 kernel/kprobes.c                   |  51 ++++++-----
 kernel/module/Kconfig              |   1 +
 kernel/module/main.c               |  45 ++-------
 kernel/trace/trace_kprobe.c        |  11 +++
 mm/Kconfig                         |   3 +
 mm/Makefile                        |   1 +
 mm/execmem.c                       | 142 +++++++++++++++++++++++++++++
 mm/mm_init.c                       |   2 +
 47 files changed, 801 insertions(+), 522 deletions(-)
 create mode 100644 arch/sparc/mm/execmem.c
 create mode 100644 include/linux/execmem.h
 create mode 100644 mm/execmem.c


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.39.2


