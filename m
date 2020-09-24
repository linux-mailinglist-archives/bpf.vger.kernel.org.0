Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5236727717E
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgIXMo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgIXMom (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:44:42 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845FC0613CE;
        Thu, 24 Sep 2020 05:44:41 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y9so3000468ilq.2;
        Thu, 24 Sep 2020 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVtc8/AttZR1MSjVTJ8WZqoJcQR03mZ2toS3D2ZBVEk=;
        b=huGLx8jnPeXPwAmSiZJC/PDdBoEYKEeFSpdPi29lSu27OsG7ZKHDRyVsYp7rRF9FVT
         mNNTEmLzj3ot4DDDPvJUH4ICNxWABUeWuMWg0/kIDcpB4JPAGwH+UOLhSPFWf4aj5QqZ
         L3F5hxQV7hH1Uzc6ReFzah8wsfghgFOIsf/DhsJ7tTKJAnZFkbNCHy2H0Qro/9Th9f0W
         9H3lmToDju6YUFNgEpZPReEeFNzwGXDIKnFlyzN9DaacEmn+5yQN9cClMA0erv2enzbw
         v/KPObn4kFRjEBtgpPHAAnRxOh0tgyT7ouMFH9Cjv+K1KtavqbOPsQ8yQN1SxDCIdagi
         bIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVtc8/AttZR1MSjVTJ8WZqoJcQR03mZ2toS3D2ZBVEk=;
        b=eytcsUN1enp4ZdOF/t6UZ5Ur5ePjX8JAA2NDumNr1QL7DKi7sh8HFhQYlOkrJqOGR7
         PZc43Yxi9DxxEIS8FbXQ+Dhf7Y9rytFaz5RaSUkyBQclCsk5d4DLRDHk9XcRPXPXWh+v
         7pU7nHd75fAQxw2iMuBeasP7GLi4+fbuXg1AIM1P7ncVDITbZFPJ1uXkCp63rPddSWmo
         bODDnMM5T8XlBDESMDzpLA0YOwoRjOZjQFKFPTWauJBnBg/fDgGJf+zlu9T6ZZry3Ain
         rSknFvycSxMTdDoVHOCidEaT5vlyA7zx2t6Wcr0R9UpzutL12/iSwk82Sqien6wL5Nag
         5Ndw==
X-Gm-Message-State: AOAM530K9jFRnC/Q/XFqEStIoC3s/Riv2LhS3cneDiSWx/JAU3SL+0vV
        DaQroARZVt4yfXjTKD8rIdc=
X-Google-Smtp-Source: ABdhPJxk4rxIcx4yaqiheHLP6mT9NyhqvmeaoBIf5C5aaIbvfOsvvq7HzsGxLeybpP+X5DC6f6jwOQ==
X-Received: by 2002:a92:5f06:: with SMTP id t6mr4049813ilb.168.1600951480857;
        Thu, 24 Sep 2020 05:44:40 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id p5sm1575175ilg.32.2020.09.24.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:44:40 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH v2 seccomp 1/6] seccomp: Move config option SECCOMP to arch/Kconfig
Date:   Thu, 24 Sep 2020 07:44:16 -0500
Message-Id: <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600951211.git.yifeifz2@illinois.edu>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

In order to make adding configurable features into seccomp
easier, it's better to have the options at one single location,
considering easpecially that the bulk of seccomp code is
arch-independent. An quick look also show that many SECCOMP
descriptions are outdated; they talk about /proc rather than
prctl.

As a result of moving the config option and keeping it default
on, architectures arm, arm64, csky, riscv, sh, and xtensa
did not have SECCOMP on by default prior to this and SECCOMP will
be default in this change.

Architectures microblaze, mips, powerpc, s390, sh, and sparc
have an outdated depend on PROC_FS and this dependency is removed
in this change.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/lkml/CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com/
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/Kconfig            | 21 +++++++++++++++++++++
 arch/arm/Kconfig        | 15 +--------------
 arch/arm64/Kconfig      | 13 -------------
 arch/csky/Kconfig       | 13 -------------
 arch/microblaze/Kconfig | 18 +-----------------
 arch/mips/Kconfig       | 17 -----------------
 arch/parisc/Kconfig     | 16 ----------------
 arch/powerpc/Kconfig    | 17 -----------------
 arch/riscv/Kconfig      | 13 -------------
 arch/s390/Kconfig       | 17 -----------------
 arch/sh/Kconfig         | 16 ----------------
 arch/sparc/Kconfig      | 18 +-----------------
 arch/um/Kconfig         | 16 ----------------
 arch/x86/Kconfig        | 16 ----------------
 arch/xtensa/Kconfig     | 14 --------------
 15 files changed, 24 insertions(+), 216 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..6dfc5673215d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -444,8 +444,12 @@ config ARCH_WANT_OLD_COMPAT_IPC
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	bool
 
+config HAVE_ARCH_SECCOMP
+	bool
+
 config HAVE_ARCH_SECCOMP_FILTER
 	bool
+	select HAVE_ARCH_SECCOMP
 	help
 	  An arch should select this symbol if it provides all of these things:
 	  - syscall_get_arch()
@@ -458,6 +462,23 @@ config HAVE_ARCH_SECCOMP_FILTER
 	    results in the system call being skipped immediately.
 	  - seccomp syscall wired up
 
+config SECCOMP
+	def_bool y
+	depends on HAVE_ARCH_SECCOMP
+	prompt "Enable seccomp to safely compute untrusted bytecode"
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
 config SECCOMP_FILTER
 	def_bool y
 	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658..e26c19a16284 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -67,6 +67,7 @@ config ARM
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
@@ -1617,20 +1618,6 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
-config SECCOMP
-	bool
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..98c4e34cbec1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1033,19 +1033,6 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 config CC_HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	help
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3d5afb5f5685..7f424c85772c 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -309,16 +309,3 @@ endmenu
 source "arch/csky/Kconfig.platforms"
 
 source "kernel/Kconfig.hz"
-
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d262ac0c8714..37bd6a5f38fb 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -26,6 +26,7 @@ config MICROBLAZE
 	select GENERIC_SCHED_CLOCK
 	select HAVE_ARCH_HASH
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_SECCOMP
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
@@ -120,23 +121,6 @@ config CMDLINE_FORCE
 	  Set this to have arguments from the default kernel command string
 	  override those passed by the boot loader.
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 endmenu
 
 menu "Kernel features"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c95fa3a2484c..5f88a8fc11fc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3004,23 +3004,6 @@ config PHYSICAL_START
 	  specified in the "crashkernel=YM@XM" command line boot parameter
 	  passed to the panic-ed kernel).
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 config MIPS_O32_FP64_SUPPORT
 	bool "Support for O32 binaries using 64-bit FP" if !CPU_MIPSR6
 	depends on 32BIT || MIPS32_O32
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 3b0f53dd70bc..cd4afe1e7a6c 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -378,19 +378,3 @@ endmenu
 
 
 source "drivers/parisc/Kconfig"
-
-config SECCOMP
-	def_bool y
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1f48bbfb3ce9..136fe860caef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -934,23 +934,6 @@ config ARCH_WANTS_FREEZER_CONTROL
 
 source "kernel/power/Kconfig"
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 config PPC_MEM_KEYS
 	prompt "PowerPC Memory Protection Keys"
 	def_bool y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df18372861d8..c456b558fab9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -333,19 +333,6 @@ menu "Kernel features"
 
 source "kernel/Kconfig.hz"
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
 config RISCV_SBI_V01
 	bool "SBI v0.1 support"
 	default y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3d86e12e8e3c..7f7b40ec699e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -791,23 +791,6 @@ config CRASH_DUMP
 
 endmenu
 
-config SECCOMP
-	def_bool y
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y.
-
 config CCW
 	def_bool y
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d20927128fce..18278152c91c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -600,22 +600,6 @@ config PHYSICAL_START
 	  where the fail safe kernel needs to run at a different address
 	  than the panic-ed kernel.
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl, it cannot be disabled and the task is only
-	  allowed to execute a few safe syscalls defined by each seccomp
-	  mode.
-
-	  If unsure, say N.
-
 config SMP
 	bool "Symmetric multi-processing support"
 	depends on SYS_SUPPORTS_SMP
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index efeff2c896a5..d62ce83cf009 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -23,6 +23,7 @@ config SPARC
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_SECCOMP if SPARC64
 	select HAVE_EXIT_THREAD
 	select HAVE_PCI
 	select SYSCTL_EXCEPTION_TRACE
@@ -226,23 +227,6 @@ config EARLYFB
 	help
 	  Say Y here to enable a faster early framebuffer boot console.
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on SPARC64 && PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SPARC64 && SMP
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index eb51fec75948..d49f471b02e3 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -173,22 +173,6 @@ config PGTABLE_LEVELS
 	default 3 if 3_LEVEL_PGTABLES
 	default 2
 
-config SECCOMP
-	def_bool y
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y.
-
 config UML_TIME_TRAVEL_SUPPORT
 	bool
 	prompt "Support time-travel mode (e.g. for test execution)"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..1ab22869a765 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1968,22 +1968,6 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
-config SECCOMP
-	def_bool y
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 source "kernel/Kconfig.hz"
 
 config KEXEC
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index e997e0119c02..d8a29dc5a284 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -217,20 +217,6 @@ config HOTPLUG_CPU
 
 	  Say N if you want to disable CPU hotplug.
 
-config SECCOMP
-	bool
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
 config FAST_SYSCALL_XTENSA
 	bool "Enable fast atomic syscalls"
 	default n
-- 
2.28.0

