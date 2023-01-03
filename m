Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72E65C46C
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjACRAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 12:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjACRAN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:13 -0500
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 09:00:06 PST
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB313CEC
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 09:00:05 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 5CBC430F6A1
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764272;
        bh=YH3j4lWcqVGB+XxPClom/0YJ4GyVdH+efLxL7eCca3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=3PJmcNqwIRl8f2wIVNLtfnxKI7t6tGcEUSJAUZCpjdilhakpARWt9BCavW55boZcm
         C2MxSGa0VqK4gzyWBxnk+b7X8WhRFVACRwlhbg3GusBfVmVF7pmtOacJcMGQ3BRjr8
         xgo6d2hWcKDjxkdBYryuSLtO9+1h9MV8LQ/7/LGs=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 1B7D430F74B; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 5CD2030F6FC; Tue,  3 Jan
 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 2AB0727E03FA; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 0588E27E03FF; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 PDNQOglGLXJP; Tue,  3 Jan 2023 17:44:30 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id C381227E03FA; Tue,  3 Jan 2023
 17:44:30 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <78c5.63b45b6f.58f2a.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0588E27E03FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764271;
 bh=e2NwdngYjT0DrUiqwADFLZTxSeB26H5545unsz7UyUE=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=hXPe9V3YBdSTymCZXUQ5IMi134fTMq+DEFTCuERnSR9MtNbt0dcwg7PsNfOznBnsS
 Zp8ZjmBD+2S8U7zSMBy53SXT4z6fNccBGQCTPzdbNArnQSYviodKp9/As2btCKe3ST
 KrQVPlh7sQ9XqpuQg9jSxtKLSecglgkYkXD7sl/Q=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH 03/25] kvx: Add build infrastructure
Date:   Tue,  3 Jan 2023 17:43:37 +0100
Message-ID: <20230103164359.24347-4-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add Kbuild, Makefile, Kconfig and link script for kvx build infrastructure.

CC: linux-kernel@vger.kernel.org
CC: bpf@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jonathan Borne <jborne@kalray.eu>
Signed-off-by: Jonathan Borne <jborne@kalray.eu>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Samuel Jones <sjones@kalray.eu>
Signed-off-by: Samuel Jones <sjones@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/Kconfig                 | 249 +++++++++++++++++++++++++++++++
 arch/kvx/Kconfig.debug           |  70 +++++++++
 arch/kvx/Makefile                |  52 +++++++
 arch/kvx/include/asm/Kbuild      |  20 +++
 arch/kvx/include/uapi/asm/Kbuild |   1 +
 arch/kvx/kernel/Makefile         |  27 ++++
 arch/kvx/kernel/kvx_ksyms.c      |  24 +++
 arch/kvx/kernel/vmlinux.lds.S    | 173 +++++++++++++++++++++
 arch/kvx/lib/Makefile            |   6 +
 arch/kvx/mm/Makefile             |  10 ++
 arch/kvx/platform/Makefile       |   7 +
 11 files changed, 639 insertions(+)
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
 create mode 100644 arch/kvx/platform/Makefile

diff --git a/arch/kvx/Kconfig b/arch/kvx/Kconfig
new file mode 100644
index 000000000000..8e8820c5c860
--- /dev/null
+++ b/arch/kvx/Kconfig
@@ -0,0 +1,249 @@
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
+	select ARCH_HAS_STRICT_KERNEL_RWX
+	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
+	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
+	select ARCH_SUPPORTS_HUGETLBFS
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
+	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
+	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_SCHED_CLOCK
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ASM_MODVERSIONS
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DYNAMIC_FTRACE
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_HW_BREAKPOINT
+	select HAVE_IOREMAP_PROT
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_PCI
+	select HAVE_PERF_EVENTS
+	select HAVE_STACKPROTECTOR
+	select HAVE_SYSCALL_TRACEPOINTS
+	select IOMMU_DMA if IOMMU_SUPPORT
+	select KVX_APIC_GIC
+	select KVX_APIC_MAILBOX
+	select KVX_CORE_INTC
+	select KVX_ITGEN
+	select KVX_WATCHDOG
+	select MODULES_USE_ELF_RELA
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
+	select PERF_EVENTS
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
+	int
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
+	  In order to debug initmem, using poison allows to verify if
+	  some data/code is stille using them. Enable this for debug
+	  purposes
+
+config KVX_PHYS_OFFSET
+	hex "RAM address of memory base"
+	default 0x100000000
+
+config KVX_PAGE_OFFSET
+	hex "kernel virtual address of memory base"
+	default 0xFFFFFF8000000000
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
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
+config L2_CACHE
+	bool "Enable l2 cache driver"
+	default y
+	help
+	  Enable L2 cache driver in order to handle it. This driver can be
+	  disabled to eliminate any overhead related to L2 cache
+	  inval/writeback. Note that L2 cache is mandatory for SMP in order
+	  to maintain coherency on DDR between all PEs.
+
+config SECURE_DAME_HANDLING
+	bool "Secure DAME handling"
+	default y
+	help
+	  In order to securely handle Data Asynchronous Memory Errors, we need
+	  to do a barrier upon kernel entry when coming from userspace. This
+	  barrier guarantee us that any pending DAME will be serviced right
+	  away. We also need to do a barrier when returning from kernel to user.
+	  This way, if the kernel or the user triggered a DAME, it will be
+	  serviced by knowing we are coming from kernel or user and avoid
+	  pulling the wrong lever (panic for kernel or sigfault for user).
+	  This can be costly but ensure that user cannot interfere with kernel.
+	  /!\ Do not disable unless you want to open a giant breach between
+	  user and kernel /!\
+
+config CACHECTL_UNSAFE_PHYS_OPERATIONS
+	bool "Enable cachectl syscall unsafe physical operations"
+	default n
+	help
+	  Enable cachectl syscall to allow writebacking/invalidating ranges
+	  based on physical addresses. These operations requires the
+	  CAP_SYS_ADMIN capability
+
+config ENABLE_TCA
+	bool "Enable TCA coprocessor support"
+	default y
+	help
+	  This option enables TCA coprocessor support. It will allow the user to
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
+	select L2_CACHE
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
index 000000000000..027e919a1e14
--- /dev/null
+++ b/arch/kvx/Kconfig.debug
@@ -0,0 +1,70 @@
+menu "KVX debugging"
+
+config KVX_DEBUG_ASN
+	bool "Check ASN before writing TLB entry"
+	default n
+	help
+	  This option allows to check if the ASN of the current
+	  process is matching the ASN found in MMC. If it is not the
+	  case an error will be printed.
+
+config KVX_DEBUG_TLB_WRITE
+	bool "Enable TLBs write checks"
+	default n
+	help
+	  Enabling this option will enable TLB access checks. This is
+	  particularly helpful when modifying the assembly code responsible
+	  of TLB refill. If set, mmc.e will be checked each time the tlb are
+	  written and a panic will be thrown on error.
+
+config KVX_DEBUG_TLB_ACCESS
+	bool "Enable TLBs accesses logging"
+	default n
+	help
+	  Enabling this option will enable TLB entry manipulation logging.
+	  Each time an entry will be added to the TLBs, it will be logged in
+	  an array readable via gdb scripts. This can be useful to understand
+	  strange crashes related to suspicious virtual/physical addresses.
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
+	  entry 24 bytes are used. So by default it uses 96Ko of memory per
+	  CPU to store 2^12 (4096) entries.
+
+config KVX_MMU_STATS
+	bool "Register mmu stats debugfs entries"
+	default n
+	select DEBUG_FS
+	help
+	  Enable debugfs attribute which will allow inspecting various metric
+	  regarding MMU:
+	  - Number of nomapping traps handled
+	  - avg/min/max time for nomapping refill (user/kernel)
+
+config DEBUG_EXCEPTION_STACK
+	bool "Enable exception stack debugging"
+	default n
+	help
+	  Enable stack check debugging when entering/exiting
+	  exception handlers.
+	  This can be particularly helpful after modifying stack
+	  handling to see if stack when exiting is the same as the one
+	  when entering exception handler.
+
+config DEBUG_SFR_SET_MASK
+	bool "Enable sfr set_mask debugging"
+	default n
+	help
+	  Verify that values written using kvx_sfr_set_mask are matching the
+	  mask. This ensure that no extra bits of sfr will be overridden by some
+	  incorrectly truncated values. This can lead to huge problems by
+	  modifying important bits in system registers.
+
+endmenu
diff --git a/arch/kvx/Makefile b/arch/kvx/Makefile
new file mode 100644
index 000000000000..b9da5017cf2a
--- /dev/null
+++ b/arch/kvx/Makefile
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2018-2023 Kalray Inc.
+
+ifeq ($(CROSS_COMPILE),)
+CROSS_COMPILE := kvx-elf-
+endif
+
+KBUILD_DEFCONFIG := default_defconfig
+
+LDFLAGS_vmlinux := -X
+OBJCOPYFLAGS := -O binary -R .comment -R .note -R .bootloader -S
+
+# Link with libgcc to get __div* builtins.
+LIBGCC	:= $(shell $(CC) $(KBUILD_CFLAGS) --print-libgcc-file-name)
+
+DEFAULT_OPTS := -nostdlib -fno-builtin -march=kv3-1
+KBUILD_CFLAGS += $(DEFAULT_OPTS)
+KBUILD_AFLAGS += $(DEFAULT_OPTS)
+KBUILD_CFLAGS_MODULE += -mfarcall
+
+KBUILD_LDFLAGS += -m elf64kvx
+
+head-y	:= arch/kvx/kernel/head.o
+libs-y 	+= $(LIBGCC)
+libs-y  += arch/kvx/lib/
+core-y += arch/kvx/kernel/ \
+          arch/kvx/mm/ \
+          arch/kvx/platform/
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
index 000000000000..ea73552faa10
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
index 000000000000..8b137891791f
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/Kbuild
@@ -0,0 +1 @@
+
diff --git a/arch/kvx/kernel/Makefile b/arch/kvx/kernel/Makefile
new file mode 100644
index 000000000000..d155fef62614
--- /dev/null
+++ b/arch/kvx/kernel/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2023 Kalray Inc.
+#
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_insns.o = $(CC_FLAGS_FTRACE)
+endif
+
+CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
+
+obj-y	:= head.o setup.o process.o traps.o common.o time.o prom.o kvx_ksyms.o \
+	   irq.o cpuinfo.o ptrace.o entry.o syscall_table.o signal.o sys_kvx.o \
+	   stacktrace.o dame_handler.o vdso.o perf_event.o return_address.o \
+	   insns.o break_hook.o reset.o io.o debug.o
+
+obj-$(CONFIG_JUMP_LABEL) 		+= jump_label.o
+obj-$(CONFIG_SMP) 			+= smp.o smpboot.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
+obj-$(CONFIG_MODULES)			+= module.o
+obj-$(CONFIG_KGDB)			+= kgdb.o
+CFLAGS_module.o				+= -Wstrict-overflow -fstrict-overflow
+obj-$(CONFIG_L2_CACHE)			+= l2_cache.o
+obj-$(CONFIG_FUNCTION_TRACER)		+= mcount.o ftrace.o
+
+extra-y					+= vmlinux.lds
diff --git a/arch/kvx/kernel/kvx_ksyms.c b/arch/kvx/kernel/kvx_ksyms.c
new file mode 100644
index 000000000000..18990aaf259f
--- /dev/null
+++ b/arch/kvx/kernel/kvx_ksyms.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/nios2/kernel/nios2_ksyms.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+
+/*
+ * libgcc functions - functions that are used internally by the
+ * compiler...  (prototypes are not correct though, but that
+ * doesn't really matter since they're not versioned).
+ */
+#define DECLARE_EXPORT(name)	extern void name(void); EXPORT_SYMBOL(name)
+
+DECLARE_EXPORT(__moddi3);
+DECLARE_EXPORT(__umoddi3);
+DECLARE_EXPORT(__divdi3);
+DECLARE_EXPORT(__udivdi3);
+DECLARE_EXPORT(__multi3);
diff --git a/arch/kvx/kernel/vmlinux.lds.S b/arch/kvx/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..74013771ff40
--- /dev/null
+++ b/arch/kvx/kernel/vmlinux.lds.S
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
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
+#include <asm/rm_fw.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+
+#define BOOT_ENTRY		0x0
+#define DTB_DEFAULT_SIZE	(64 * 1024)
+#define RM_FIRMWARE_SIZE	(64 * 1024)
+#define RM_FIRMWARE_ADDRESS	(64 * 1024)
+
+#define LOAD_OFFSET  (PAGE_OFFSET - PHYS_OFFSET)
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
+	/**
+	 * Special section to patch rm_firmware binary after compiling
+	 * the kernel.
+	 */
+	. = RM_FIRMWARE_ADDRESS;
+	.rm_firmware :
+	{
+		__rm_firmware_start = .;
+		KEEP(*(.rm_firmware.default));
+		/* Force minimum size */
+		. = __rm_firmware_start + RM_FIRMWARE_SIZE;
+		__rm_firmware_end = .;
+
+		/* Registers for RM firmware */
+		. = ALIGN(PAGE_SIZE);
+		__rm_firmware_regs_start = .;
+		/* Force minimum size */
+		. = __rm_firmware_regs_start + RM_FIRMWARE_REGS_SIZE;
+		__rm_firmware_regs_end = .;
+	}
+
+	. = PAGE_OFFSET;
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
+		CPUIDLE_TEXT
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
index 000000000000..ddb666c244e1
--- /dev/null
+++ b/arch/kvx/lib/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2017-2023 Kalray Inc.
+#
+
+lib-y := usercopy.o clear_page.o copy_page.o memcpy.o memset.o strlen.o delay.o
diff --git a/arch/kvx/mm/Makefile b/arch/kvx/mm/Makefile
new file mode 100644
index 000000000000..d97ab0e94a6f
--- /dev/null
+++ b/arch/kvx/mm/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2017-2023 Kalray Inc.
+#
+
+obj-y := init.o mmu.o fault.o tlb.o extable.o dma-mapping.o cacheflush.o
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+obj-$(CONFIG_KVX_MMU_STATS) += mmu_stats.o
+obj-$(CONFIG_STRICT_KERNEL_RWX) += kernel_rwx.o
+obj-$(CONFIG_STRICT_DEVMEM) += mmap.o
diff --git a/arch/kvx/platform/Makefile b/arch/kvx/platform/Makefile
new file mode 100644
index 000000000000..27f0914e0de5
--- /dev/null
+++ b/arch/kvx/platform/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2018-2023 Kalray Inc.
+#
+
+obj-$(CONFIG_SMP) += pwr_ctrl.o
+obj-$(CONFIG_SMP) += ipi.o
-- 
2.37.2





