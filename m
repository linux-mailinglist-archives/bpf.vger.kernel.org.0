Return-Path: <bpf+bounces-35220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF308938C7A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF26284874
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F86173340;
	Mon, 22 Jul 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="XQ/KhuxY"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6EE16630A
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641507; cv=none; b=T9G9SjuPvshkcCIK9Aqc6987l1bEVuV8mWNcoadnIj+I0xznGr9rlSJeBD1xhnh3+kLifO3NOGF+rosZMD5bbRAYXoM9Kf/Yp3llRDXTGOPPTCOepieayTKvwb2Yg48WrrkYI39Ie8832YJEFPhO/phn39W0K4aAbtLwkmqCqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641507; c=relaxed/simple;
	bh=RfEbXUvXuwb0hpvBSZAdbFO4zfrCKl+D0or1hBndqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eU/MHkjVh7tTt0YDfVGDVUzjYVGn/9q71iuI5IHseQuHIWzHC/yDNUaJE+OHBpa+n9OteNVuWxvJ14bMUX8R+sGr1H7Pxq8Jz9ev4Xs5PUbSd0pLQoDxKFzmmrJXpqYnSEIn8Ozz/4LgTffm3t6hmagAFGQXcniXdP7XuwFjgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=XQ/KhuxY; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id DC5A680B130
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 11:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641402;
	bh=RfEbXUvXuwb0hpvBSZAdbFO4zfrCKl+D0or1hBndqNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQ/KhuxYXwzbDvq4tHjEA1mxkKWps+AStEZPhjSoRnA7aeZ5AlOFExcjBo5IoVfYE
	 1fJ96+tiWjMCtVlALImjzOVYPt5paUxUG80qo5siefeO+b/2SZ60rm/jkImNVdIfMO
	 q+MpLaPtv1/z8IStYGnRyX4lw06oZ1cbpToeOFeI=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id B1CD780AF41; Mon, 22 Jul 2024 11:43:22 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 2608F80B126; Mon, 22 Jul
 2024 11:43:22 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id D9DEB40317; Mon, 22 Jul
 2024 11:43:21 +0200 (CEST)
X-Secumail-id: <ae8f.669e29ba.23ddc.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Jules Maselbas <jmaselbas@zdiv.net>, Marc =?utf-8?b?UG91bGhpw6hz?=
 <dkm@kataplop.net>, Marius Gligor <mgligor@kalrayinc.com>, Samuel Jones
 <sjones@kalrayinc.com>, Vincent Chardon <vincent.chardon@elsys-design.com>,
 bpf@vger.kernel.org
Subject: [RFC PATCH v3 13/37] kvx: Add build infrastructure
Date: Mon, 22 Jul 2024 11:41:24 +0200
Message-ID: <20240722094226.21602-14-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add Kbuild, Makefile, Kconfig and link script for kvx build infrastructure.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Jonathan Borne <jborne@kalrayinc.com>
Signed-off-by: Jonathan Borne <jborne@kalrayinc.com>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Co-developed-by: Samuel Jones <sjones@kalrayinc.com>
Signed-off-by: Samuel Jones <sjones@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2:
- typos and formatting fixes, removed int from PGTABLE_LEVELS
- renamed default_defconfig to defconfig in arch/kvx/Makefile
- fix clean target raising an error from gcc (LIBGCC)

V2 -> V3:
- use generic entry framework
- add smem in kernel direct map
- remove DEBUG_EXCEPTION_STACK
- use global addresses for smem
- now boot from PE (KALRAY_BOOT_BY_PE)
- do not link with libgcc anymore
---
 arch/kvx/Kconfig                 | 226 +++++++++++++++++++++++++++++++
 arch/kvx/Kconfig.debug           |  60 ++++++++
 arch/kvx/Makefile                |  47 +++++++
 arch/kvx/include/asm/Kbuild      |  20 +++
 arch/kvx/include/uapi/asm/Kbuild |   1 +
 arch/kvx/kernel/Makefile         |  15 ++
 arch/kvx/kernel/kvx_ksyms.c      |  18 +++
 arch/kvx/kernel/vmlinux.lds.S    | 150 ++++++++++++++++++++
 arch/kvx/lib/Makefile            |   6 +
 arch/kvx/mm/Makefile             |   8 ++
 10 files changed, 551 insertions(+)
 create mode 100644 arch/kvx/Kconfig
 create mode 100644 arch/kvx/Kconfig.debug
 create mode 100644 arch/kvx/Makefile
 create mode 100644 arch/kvx/include/asm/Kbuild
 create mode 100644 arch/kvx/include/uapi/asm/Kbuild
 create mode 100644 arch/kvx/kernel/Makefile
 create mode 100644 arch/kvx/kernel/kvx_ksyms.c
 create mode 100644 arch/kvx/kernel/vmlinux.lds.S
 create mode 100644 arch/kvx/lib/Makefile
 create mode 100644 arch/kvx/mm/Makefile

diff --git a/arch/kvx/Kconfig b/arch/kvx/Kconfig
new file mode 100644
index 0000000000000..a98c1fbd8131d
--- /dev/null
+++ b/arch/kvx/Kconfig
@@ -0,0 +1,226 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+config 64BIT
+	def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config FIX_EARLYCON_MEM
+	def_bool y
+
+config MMU
+	def_bool y
+
+config KALLSYMS_BASE_RELATIVE
+	def_bool n
+
+config GENERIC_CSUM
+	def_bool y
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config ARCH_MMAP_RND_BITS_MAX
+	default 24
+
+config ARCH_MMAP_RND_BITS_MIN
+	default 18
+
+config STACKTRACE_SUPPORT
+	def_bool y
+
+config LOCKDEP_SUPPORT
+	def_bool y
+
+config GENERIC_BUG
+	def_bool y
+	depends on BUG
+
+config KVX_4K_PAGES
+	def_bool y
+
+config KVX
+	def_bool y
+	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_DMA_ADDR_T_64BIT
+	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_DMA_OPS if IOMMU_SUPPORT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
+	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANT_FRAME_POINTERS
+	select CLKSRC_OF
+	select COMMON_CLK
+	select DMA_DIRECT_REMAP
+	select GENERIC_ALLOCATOR
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CPU_DEVICES
+	select GENERIC_ENTRY
+	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
+	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_SCHED_CLOCK
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ASM_MODVERSIONS
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_IOREMAP_PROT
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_PCI
+	select HAVE_STACKPROTECTOR
+	select HAVE_SYSCALL_TRACEPOINTS
+	select IOMMU_DMA if IOMMU_SUPPORT
+	select KVX_IPI_CTRL if SMP
+	select KVX_APIC_GIC
+	select KVX_APIC_MAILBOX
+	select KVX_CORE_INTC
+	select KVX_ITGEN
+	select KVX_WATCHDOG
+	select MODULES_USE_ELF_RELA
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
+	select PCI_DOMAINS_GENERIC if PCI
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
+	select TIMER_OF
+	select TRACE_IRQFLAGS_SUPPORT
+	select WATCHDOG
+	select ZONE_DMA32
+
+config PGTABLE_LEVELS
+	default 3
+
+config HAVE_KPROBES
+	def_bool n
+
+menu "System setup"
+
+config POISON_INITMEM
+	bool "Enable to poison freed initmem"
+	default y
+	help
+	  In order to debug initmem, using poison allows to verify if some
+	  data/code is still using it. Enable this for debug purposes.
+
+config KVX_PHYS_OFFSET
+	hex "RAM address of memory base"
+	default 0x0
+
+config KVX_PAGE_OFFSET
+	hex "kernel virtual address of memory base"
+	default 0xFFFFFF8000000000
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool ARCH_SPARSEMEM_ENABLE
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool ARCH_SPARSEMEM_ENABLE
+
+config STACK_MAX_DEPTH_TO_PRINT
+	int "Maximum depth of stack to print"
+	range 1 128
+	default "24"
+
+config SECURE_DAME_HANDLING
+	bool "Secure DAME handling"
+	default y
+	help
+	  In order to securely handle Data Asynchronous Memory Errors, we need
+	  to do a barrier upon kernel entry when coming from userspace. This
+	  barrier guarantees us that any pending DAME will be serviced right
+	  away. We also need to do a barrier when returning from kernel to user.
+	  This way, if the kernel or the user triggered a DAME, it will be
+	  serviced by knowing we are coming from kernel or user and avoid
+	  pulling the wrong lever (panic for kernel or sigfault for user).
+	  This can be costly but ensures that user cannot interfere with kernel.
+	  /!\ Do not disable unless you want to open a giant breach between
+	  user and kernel /!\
+
+config CACHECTL_UNSAFE_PHYS_OPERATIONS
+	bool "Enable cachectl syscall unsafe physical operations"
+	default n
+	help
+	  Enable the cachectl syscall to allow writing back/invalidating memory
+	  ranges based on physical addresses. These operations require the
+	  CAP_SYS_ADMIN capability.
+
+config ENABLE_TCA
+	bool "Enable TCA coprocessor support"
+	default y
+	help
+	  This option enables TCA coprocessor support. It allows the user to
+	  use the coprocessor and save registers on context switch if used.
+	  Registers content will also be cleared when switching.
+
+config SMP
+	bool "Symmetric multi-processing support"
+	default n
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IRQ_IPI
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
+	help
+	  This enables support for systems with more than one CPU. If you have
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
+
+	  If you say N here, the kernel will run on uni- and multiprocessor
+	  machines, but will use only one CPU of a multiprocessor machine. If
+	  you say Y here, the kernel will run on many, but not all,
+	  uniprocessor machines. On a uniprocessor machine, the kernel
+	  will run faster if you say N here.
+
+config NR_CPUS
+	int "Maximum number of CPUs"
+	range 1 16
+	default "16"
+	depends on SMP
+	help
+	  Kalray support can handle a maximum of 16 CPUs.
+
+config KVX_PAGE_SHIFT
+	int
+	default 12
+
+config CMDLINE
+	string "Default kernel command string"
+	default ""
+	help
+	  On some architectures there is currently no way for the boot loader
+	  to pass arguments to the kernel. For these architectures, you should
+	  supply some command-line options at build time by entering them
+	  here.
+
+endmenu
+
+menu "Kernel Features"
+source "kernel/Kconfig.hz"
+endmenu
diff --git a/arch/kvx/Kconfig.debug b/arch/kvx/Kconfig.debug
new file mode 100644
index 0000000000000..0d526802e9221
--- /dev/null
+++ b/arch/kvx/Kconfig.debug
@@ -0,0 +1,60 @@
+menu "KVX debugging"
+
+config KVX_DEBUG_ASN
+	bool "Check ASN before writing TLB entry"
+	default n
+	help
+	  This option allows to check if the ASN of the current
+	  process matches the ASN found in MMC. If it is not the
+	  case an error will be printed.
+
+config KVX_DEBUG_TLB_WRITE
+	bool "Enable TLBs write checks"
+	default n
+	help
+	  Enabling this option will enable TLB access checks. This is
+	  particularly helpful when modifying the assembly code responsible
+	  for TLB refill. If set, mmc.e will be checked each time the TLB are
+	  written and a panic will be thrown on error.
+
+config KVX_DEBUG_TLB_ACCESS
+	bool "Enable TLBs accesses logging"
+	default n
+	help
+	  Enabling this option will enable TLB entry manipulation logging.
+	  Each time an entry is added to the TLBs, it is logged in an array
+	  readable via gdb scripts. This can be useful to understand strange
+	  crashes related to suspicious virtual/physical addresses.
+
+config KVX_DEBUG_TLB_ACCESS_BITS
+	int "Number of bits used as index of entries in log table"
+	default 12
+	depends on KVX_DEBUG_TLB_ACCESS
+	help
+	  Set the number of bits used as index of entries that will be logged
+	  in a ring buffer called kvx_tlb_access. One entry in the table
+	  contains registers TEL, TEH and MMC. It also logs the type of the
+	  operations (0:read, 1:write, 2:probe). Buffer is per CPU. For one
+	  entry 24 bytes are used. So by default it uses 96KB of memory per
+	  CPU to store 2^12 (4096) entries.
+
+config KVX_MMU_STATS
+	bool "Register MMU stats debugfs entries"
+	default n
+	depends on DEBUG_FS
+	help
+	  Enable debugfs attribute which will allow inspecting various metrics
+	  regarding MMU:
+	  - Number of nomapping traps handled
+	  - avg/min/max time for nomapping refill (user/kernel)
+
+config DEBUG_SFR_SET_MASK
+	bool "Enable SFR set_mask debugging"
+	default n
+	help
+	  Verify that values written using kvx_sfr_set_mask match the mask.
+	  This ensure that no extra bits of SFR will be overridden by some
+	  incorrectly truncated values. This can lead to huge problems by
+	  modifying important bits in system registers.
+
+endmenu
diff --git a/arch/kvx/Makefile b/arch/kvx/Makefile
new file mode 100644
index 0000000000000..305fa1d5d8692
--- /dev/null
+++ b/arch/kvx/Makefile
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2018-2024 Kalray Inc.
+
+ifeq ($(CROSS_COMPILE),)
+CROSS_COMPILE := kvx-mbr-
+endif
+
+KBUILD_DEFCONFIG := defconfig
+
+LDFLAGS_vmlinux := -X
+OBJCOPYFLAGS := -O binary -R .comment -R .note -R .bootloader -S
+
+DEFAULT_OPTS := -nostdlib -fno-builtin -march=kv3-1
+KBUILD_CFLAGS += $(DEFAULT_OPTS)
+KBUILD_AFLAGS += $(DEFAULT_OPTS)
+KBUILD_CFLAGS_MODULE += -mfarcall
+
+KBUILD_LDFLAGS += -m elf64kvx
+
+head-y	:= arch/kvx/kernel/head.o
+libs-y  += arch/kvx/lib/
+core-y += arch/kvx/kernel/ \
+          arch/kvx/mm/
+# Final targets
+all: vmlinux
+
+BOOT_TARGETS = bImage bImage.bin bImage.bz2 bImage.gz bImage.lzma bImage.lzo
+
+$(BOOT_TARGETS): vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
+
+define archhelp
+  echo  '* bImage         - Alias to selected kernel format (bImage.gz by default)'
+  echo  '  bImage.bin     - Uncompressed Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.bin)'
+  echo  '  bImage.bz2     - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.bz2)'
+  echo  '* bImage.gz      - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.gz)'
+  echo  '  bImage.lzma    - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.lzma)'
+  echo  '  bImage.lzo     - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.lzo)'
+  echo  '  install        - Install kernel using'
+  echo  '                     (your) ~/bin/$(INSTALLKERNEL) or'
+  echo  '                     (distribution) PATH: $(INSTALLKERNEL) or'
+  echo  '                     install to $$(INSTALL_PATH)'
+endef
diff --git a/arch/kvx/include/asm/Kbuild b/arch/kvx/include/asm/Kbuild
new file mode 100644
index 0000000000000..ea73552faa103
--- /dev/null
+++ b/arch/kvx/include/asm/Kbuild
@@ -0,0 +1,20 @@
+generic-y += asm-offsets.h
+generic-y += clkdev.h
+generic-y += auxvec.h
+generic-y += bpf_perf_event.h
+generic-y += cmpxchg-local.h
+generic-y += errno.h
+generic-y += extable.h
+generic-y += export.h
+generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
+generic-y += mman.h
+generic-y += param.h
+generic-y += qrwlock.h
+generic-y += qspinlock.h
+generic-y += rwsem.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += ucontext.h
+generic-y += user.h
diff --git a/arch/kvx/include/uapi/asm/Kbuild b/arch/kvx/include/uapi/asm/Kbuild
new file mode 100644
index 0000000000000..8b137891791fe
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/Kbuild
@@ -0,0 +1 @@
+
diff --git a/arch/kvx/kernel/Makefile b/arch/kvx/kernel/Makefile
new file mode 100644
index 0000000000000..a57309bbdbefd
--- /dev/null
+++ b/arch/kvx/kernel/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2024 Kalray Inc.
+#
+
+obj-y	:= head.o setup.o process.o traps.o common.o time.o prom.o kvx_ksyms.o \
+	   irq.o cpuinfo.o entry.o ptrace.o syscall_table.o signal.o sys_kvx.o \
+	   stacktrace.o dame_handler.o vdso.o debug.o break_hook.o \
+	   reset.o io.o cpu.o
+
+obj-$(CONFIG_SMP) 			+= smp.o smpboot.o
+obj-$(CONFIG_MODULES)			+= module.o
+CFLAGS_module.o				+= -Wstrict-overflow -fstrict-overflow
+
+extra-y					+= vmlinux.lds
diff --git a/arch/kvx/kernel/kvx_ksyms.c b/arch/kvx/kernel/kvx_ksyms.c
new file mode 100644
index 0000000000000..6a24ade5be3d9
--- /dev/null
+++ b/arch/kvx/kernel/kvx_ksyms.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/nios2/kernel/nios2_ksyms.c
+ *
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+
+#define DECLARE_EXPORT(name)	extern void name(void); EXPORT_SYMBOL(name)
+
+DECLARE_EXPORT(clear_page);
+DECLARE_EXPORT(copy_page);
+DECLARE_EXPORT(memset);
+DECLARE_EXPORT(asm_clear_user);
diff --git a/arch/kvx/kernel/vmlinux.lds.S b/arch/kvx/kernel/vmlinux.lds.S
new file mode 100644
index 0000000000000..6e064e8867b82
--- /dev/null
+++ b/arch/kvx/kernel/vmlinux.lds.S
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ *            Marc Poulhiès
+ *            Yann Sionneau
+ */
+
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+#include <asm/sys_arch.h>
+#include <asm/cache.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+
+/* Entry is linked at smem global address */
+#define BOOT_ENTRY		(16 * 1024 * 1024)
+#define DTB_DEFAULT_SIZE	(64 * 1024)
+
+#define LOAD_OFFSET  (DDR_VIRT_OFFSET - DDR_PHYS_OFFSET)
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT("elf64-kvx")
+ENTRY(kvx_start)
+
+#define HANDLER_SECTION(__sec, __name) \
+	__sec ## _ ## __name ## _start = .; \
+	KEEP(*(.##__sec ##.## __name)); \
+	. = __sec ## _ ##__name ## _start + EXCEPTION_STRIDE;
+
+/**
+ * Generate correct section positioning for exception handling
+ * Since we need it twice for early exception handler and normal
+ * exception handler, factorize it here.
+ */
+#define EXCEPTION_SECTIONS(__sec) \
+	__ ## __sec ## _start = ABSOLUTE(.); \
+	HANDLER_SECTION(__sec,debug) \
+	HANDLER_SECTION(__sec,trap) \
+	HANDLER_SECTION(__sec,interrupt) \
+	HANDLER_SECTION(__sec,syscall)
+
+jiffies = jiffies_64;
+KALRAY_BOOT_BY_PE = 0;
+SECTIONS
+{
+	. = BOOT_ENTRY;
+	.boot :
+	{
+		__kernel_smem_code_start = .;
+		KEEP(*(.boot.startup));
+		KEEP(*(.boot.*));
+		__kernel_smem_code_end = .;
+	}
+
+	. = DDR_VIRT_OFFSET;
+	_start = .;
+
+	_stext = .;
+	__init_begin = .;
+	__inittext_start = .;
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET)
+	{
+		EXIT_TEXT
+	}
+
+	.early_exception ALIGN(EXCEPTION_ALIGNMENT) :
+				AT(ADDR(.early_exception) - LOAD_OFFSET)
+	{
+		EXCEPTION_SECTIONS(early_exception)
+	}
+
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	. = ALIGN(PAGE_SIZE);
+	__inittext_end = .;
+	__initdata_start = .;
+	INIT_DATA_SECTION(16)
+
+	/* we have to discard exit text and such at runtime, not link time */
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET)
+	{
+		EXIT_DATA
+	}
+
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	. = ALIGN(PAGE_SIZE);
+	__initdata_end = .;
+	__init_end = .;
+
+	/* Everything below this point will be mapped RO EXEC up to _etext */
+	.text ALIGN(PAGE_SIZE) : AT(ADDR(.text) - LOAD_OFFSET)
+	{
+		_text = .;
+		EXCEPTION_SECTIONS(exception)
+		*(.exception.text)
+		. = ALIGN(PAGE_SIZE);
+		__exception_end = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		ENTRY_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+		*(.fixup)
+	}
+	. = ALIGN(PAGE_SIZE);
+	_etext = .;
+
+	/* Everything below this point will be mapped RO NOEXEC up to _sdata */
+	__rodata_start = .;
+	RO_DATA(PAGE_SIZE)
+	EXCEPTION_TABLE(8)
+	. = ALIGN(32);
+	.dtb : AT(ADDR(.dtb) - LOAD_OFFSET)
+	{
+		__dtb_start = .;
+		. += DTB_DEFAULT_SIZE;
+		__dtb_end = .;
+	}
+	. = ALIGN(PAGE_SIZE);
+	__rodata_end = .;
+
+	/* Everything below this point will be mapped RW NOEXEC up to _end */
+	_sdata = .;
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	_edata = .;
+
+	BSS_SECTION(32, 32, 32)
+	. = ALIGN(PAGE_SIZE);
+	_end = .;
+
+	/* This page will be mapped using a FIXMAP */
+	.gdb_page ALIGN(PAGE_SIZE) : AT(ADDR(.gdb_page) - LOAD_OFFSET)
+	{
+		_debug_start = ADDR(.gdb_page) - LOAD_OFFSET;
+		. += PAGE_SIZE;
+	}
+	_debug_start_lma = ASM_FIX_TO_VIRT(FIX_GDB_MEM_BASE_IDX);
+
+	/* Debugging sections */
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	/* Sections to be discarded -- must be last */
+	DISCARDS
+}
diff --git a/arch/kvx/lib/Makefile b/arch/kvx/lib/Makefile
new file mode 100644
index 0000000000000..3e9904d1f6f9c
--- /dev/null
+++ b/arch/kvx/lib/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2017-2024 Kalray Inc.
+#
+
+lib-y := usercopy.o clear_page.o copy_page.o memcpy.o memset.o strlen.o delay.o div.o
diff --git a/arch/kvx/mm/Makefile b/arch/kvx/mm/Makefile
new file mode 100644
index 0000000000000..a96a3764aae4a
--- /dev/null
+++ b/arch/kvx/mm/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2017-2024 Kalray Inc.
+#
+
+obj-y := init.o mmu.o fault.o tlb.o extable.o dma-mapping.o cacheflush.o
+obj-$(CONFIG_KVX_MMU_STATS) += mmu_stats.o
+obj-$(CONFIG_STRICT_DEVMEM) += mmap.o
-- 
2.45.2






