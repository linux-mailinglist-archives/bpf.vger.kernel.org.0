Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462152770B4
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgIXMGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgIXMGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:06:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A4C0613CE;
        Thu, 24 Sep 2020 05:06:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z25so2958682iol.10;
        Thu, 24 Sep 2020 05:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RSGrlZ39dx9fbbfSmGna9gzY/hFO6HuX2v4KEa1nHI=;
        b=CF4wFarj+aodyYkYvSqDkppqgdL/wcA7KUpKVUZpT8MifYgSHfOl1hchZ/fW2ZrgQo
         tJSmSgwa6VwLyaWRchb2sSPJmB3GWkbpReka4VwgJSXtObcKXaf112VmfOClbQvThEoW
         ByM/gRZeoWua5/cRCaATortRc4p906CxRfBU0okpcpOtj44QuD8qcjWNTEJGkzDRq43f
         a2lHyMuIsfVNOgjoP6b+7dHH+UczhPv0+UnZ3Gja+brjh7G1PC9Y4iRoXBLorrfEGEkL
         LUnmo9euAZBjgrcnM63pgpgGP1e8/WUeFtdhOhEFLWEYw08He0lJ7mGS3ZQPAAYldGlH
         Gzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RSGrlZ39dx9fbbfSmGna9gzY/hFO6HuX2v4KEa1nHI=;
        b=F5q9GO+JeLds6y4vt9lb/JmppB98EqyK+ye9e7f1rGHI+joT9u3if52/nAa8zznNu1
         nkTWAiAx8lMzDaLEf73fX9uyWLIrrzNAx6ecpdeKOUJvRn7m1tNWje+nuCGwuV457flv
         9SjBnG7HEBdOcY60ollM4peb6c2K3kSj1cumSQM7eHBF5GgciQX5wTGZej7/nKdjBkwn
         SklB486E/Sk0chkRMBAOGQrJWzng3osEoDerrckrd3nU91pqTRxOkezTXeHsYVtm3LH0
         K+8hW9FEVhUchAAeYm9IRDQ+opw2EYmMw3a33WNTwoC4brBr7a+LgnP4wgz3t+NQXaGS
         eftQ==
X-Gm-Message-State: AOAM5316ImQbBueeogegJNc2RN6Wkj6O1bz8Ep8Bvt2YPuomdad21Chb
        PMIGkH+sOE/6BhkaJXNLSmQ=
X-Google-Smtp-Source: ABdhPJyBZ/ibo9RFPCARSIBxN5aV+1y3RUMlNheZdFVDU6uTBbBdT6DsCNQktitPy9/MzNXe9rF/ZA==
X-Received: by 2002:a6b:ee10:: with SMTP id i16mr3015788ioh.112.1600949212676;
        Thu, 24 Sep 2020 05:06:52 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id a23sm1259435ioc.54.2020.09.24.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:06:52 -0700 (PDT)
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
Subject: [PATCH seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Date:   Thu, 24 Sep 2020 07:06:42 -0500
Message-Id: <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600946701.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600946701.git.yifeifz2@illinois.edu>
References: <cover.1600946701.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

Seccomp cache emulator needs to know all the architecture numbers
that syscall_get_arch() could return for the kernel build in order
to generate a cache for all of them.

The array is declared in header as static __maybe_unused const
to maximize compiler optimiation opportunities such as loop
unrolling.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/alpha/include/asm/syscall.h      |  4 ++++
 arch/arc/include/asm/syscall.h        | 24 +++++++++++++++++++-----
 arch/arm/include/asm/syscall.h        |  4 ++++
 arch/arm64/include/asm/syscall.h      |  4 ++++
 arch/c6x/include/asm/syscall.h        | 13 +++++++++++--
 arch/csky/include/asm/syscall.h       |  4 ++++
 arch/h8300/include/asm/syscall.h      |  4 ++++
 arch/hexagon/include/asm/syscall.h    |  4 ++++
 arch/ia64/include/asm/syscall.h       |  4 ++++
 arch/m68k/include/asm/syscall.h       |  4 ++++
 arch/microblaze/include/asm/syscall.h |  4 ++++
 arch/mips/include/asm/syscall.h       | 16 ++++++++++++++++
 arch/nds32/include/asm/syscall.h      | 13 +++++++++++--
 arch/nios2/include/asm/syscall.h      |  4 ++++
 arch/openrisc/include/asm/syscall.h   |  4 ++++
 arch/parisc/include/asm/syscall.h     |  7 +++++++
 arch/powerpc/include/asm/syscall.h    | 14 ++++++++++++++
 arch/riscv/include/asm/syscall.h      | 14 ++++++++++----
 arch/s390/include/asm/syscall.h       |  7 +++++++
 arch/sh/include/asm/syscall_32.h      | 17 +++++++++++------
 arch/sparc/include/asm/syscall.h      |  9 +++++++++
 arch/x86/include/asm/syscall.h        | 11 +++++++++++
 arch/x86/um/asm/syscall.h             | 14 ++++++++++----
 arch/xtensa/include/asm/syscall.h     |  4 ++++
 24 files changed, 184 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/include/asm/syscall.h b/arch/alpha/include/asm/syscall.h
index 11c688c1d7ec..625ac9b23f37 100644
--- a/arch/alpha/include/asm/syscall.h
+++ b/arch/alpha/include/asm/syscall.h
@@ -4,6 +4,10 @@
 
 #include <uapi/linux/audit.h>
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_ALPHA
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_ALPHA;
diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscall.h
index 94529e89dff0..899c13cbf5cc 100644
--- a/arch/arc/include/asm/syscall.h
+++ b/arch/arc/include/asm/syscall.h
@@ -65,14 +65,28 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+#ifdef CONFIG_ISA_ARCOMPACT
+# ifdef CONFIG_CPU_BIG_ENDIAN
+#  define SYSCALL_ARCH AUDIT_ARCH_ARCOMPACTBE
+# else
+#  define SYSCALL_ARCH AUDIT_ARCH_ARCOMPACT
+# endif /* CONFIG_CPU_BIG_ENDIAN */
+#else
+# ifdef CONFIG_CPU_BIG_ENDIAN
+#  define SYSCALL_ARCH AUDIT_ARCH_ARCV2BE
+# else
+#  define SYSCALL_ARCH AUDIT_ARCH_ARCV2
+# endif /* CONFIG_CPU_BIG_ENDIAN */
+#endif /* CONFIG_ISA_ARCOMPACT */
+
+static __maybe_unused const int syscall_arches[] = {
+	SYSCALL_ARCH
+};
+
 static inline int
 syscall_get_arch(struct task_struct *task)
 {
-	return IS_ENABLED(CONFIG_ISA_ARCOMPACT)
-		? (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
-			? AUDIT_ARCH_ARCOMPACTBE : AUDIT_ARCH_ARCOMPACT)
-		: (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
-			? AUDIT_ARCH_ARCV2BE : AUDIT_ARCH_ARCV2);
+	return SYSCALL_ARCH;
 }
 
 #endif
diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index fd02761ba06c..33ade26e3956 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -73,6 +73,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->ARM_r0 + 1, args, 5 * sizeof(args[0]));
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_ARM
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* ARM tasks don't change audit architectures on the fly. */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..77f3d300e7a0 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -82,6 +82,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->regs[1], args, 5 * sizeof(args[0]));
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_ARM, AUDIT_ARCH_AARCH64
+};
+
 /*
  * We don't care about endianness (__AUDIT_ARCH_LE bit) here because
  * AArch64 has the same system calls both on little- and big- endian.
diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
index 38f3e2284ecd..0d78c67ee1fc 100644
--- a/arch/c6x/include/asm/syscall.h
+++ b/arch/c6x/include/asm/syscall.h
@@ -66,10 +66,19 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	regs->a9 = *args;
 }
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define SYSCALL_ARCH AUDIT_ARCH_C6XBE
+#else
+#define SYSCALL_ARCH AUDIT_ARCH_C6X
+#endif
+
+static __maybe_unused const int syscall_arches[] = {
+	SYSCALL_ARCH
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
-	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
-		? AUDIT_ARCH_C6XBE : AUDIT_ARCH_C6X;
+	return SYSCALL_ARCH;
 }
 
 #endif /* __ASM_C6X_SYSCALLS_H */
diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index f624fa3bbc22..86242d2850d7 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -68,6 +68,10 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(&regs->a1, args, 5 * sizeof(regs->a1));
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_CSKY
+};
+
 static inline int
 syscall_get_arch(struct task_struct *task)
 {
diff --git a/arch/h8300/include/asm/syscall.h b/arch/h8300/include/asm/syscall.h
index 01666b8bb263..775f6ac8fde3 100644
--- a/arch/h8300/include/asm/syscall.h
+++ b/arch/h8300/include/asm/syscall.h
@@ -28,6 +28,10 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	*args   = regs->er6;
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_H8300
+};
+
 static inline int
 syscall_get_arch(struct task_struct *task)
 {
diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index f6e454f18038..6ee21a76f6a3 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -45,6 +45,10 @@ static inline long syscall_get_return_value(struct task_struct *task,
 	return regs->r00;
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_HEXAGON
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_HEXAGON;
diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
index 6c6f16e409a8..19456125c89a 100644
--- a/arch/ia64/include/asm/syscall.h
+++ b/arch/ia64/include/asm/syscall.h
@@ -71,6 +71,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	ia64_syscall_get_set_arguments(task, regs, args, 1);
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_IA64
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_IA64;
diff --git a/arch/m68k/include/asm/syscall.h b/arch/m68k/include/asm/syscall.h
index 465ac039be09..031b051f9026 100644
--- a/arch/m68k/include/asm/syscall.h
+++ b/arch/m68k/include/asm/syscall.h
@@ -4,6 +4,10 @@
 
 #include <uapi/linux/audit.h>
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_M68K
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_M68K;
diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
index 3a6924f3cbde..28cde14056d1 100644
--- a/arch/microblaze/include/asm/syscall.h
+++ b/arch/microblaze/include/asm/syscall.h
@@ -105,6 +105,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs);
 asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_MICROBLAZE
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_MICROBLAZE;
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 25fa651c937d..29e4c1c47c54 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -140,6 +140,22 @@ extern const unsigned long sys_call_table[];
 extern const unsigned long sys32_call_table[];
 extern const unsigned long sysn32_call_table[];
 
+static __maybe_unused const int syscall_arches[] = {
+#ifdef __LITTLE_ENDIAN
+	AUDIT_ARCH_MIPSEL,
+# ifdef CONFIG_64BIT
+	AUDIT_ARCH_MIPSEL64,
+	AUDIT_ARCH_MIPSEL64N32,
+# endif /* CONFIG_64BIT */
+#else
+	AUDIT_ARCH_MIPS,
+# ifdef CONFIG_64BIT
+	AUDIT_ARCH_MIPS64,
+	AUDIT_ARCH_MIPS64N32,
+# endif /* CONFIG_64BIT */
+#endif /* __LITTLE_ENDIAN */
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_MIPS;
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index 7b5180d78e20..2dd5e33bcfcb 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -154,11 +154,20 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(&regs->uregs[0] + 1, args, 5 * sizeof(args[0]));
 }
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define SYSCALL_ARCH AUDIT_ARCH_NDS32BE
+#else
+#define SYSCALL_ARCH AUDIT_ARCH_NDS32
+#endif
+
+static __maybe_unused const int syscall_arches[] = {
+	SYSCALL_ARCH
+};
+
 static inline int
 syscall_get_arch(struct task_struct *task)
 {
-	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
-		? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
+	return SYSCALL_ARCH;
 }
 
 #endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 526449edd768..8fa2716cac5a 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -69,6 +69,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	regs->r9 = *args;
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_NIOS2
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_NIOS2;
diff --git a/arch/openrisc/include/asm/syscall.h b/arch/openrisc/include/asm/syscall.h
index e6383be2a195..4eb28ad08042 100644
--- a/arch/openrisc/include/asm/syscall.h
+++ b/arch/openrisc/include/asm/syscall.h
@@ -64,6 +64,10 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(&regs->gpr[3], args, 6 * sizeof(args[0]));
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_OPENRISC
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_OPENRISC;
diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index 00b127a5e09b..2915f140c9fd 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -55,6 +55,13 @@ static inline void syscall_rollback(struct task_struct *task,
 	/* do nothing */
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_PARISC,
+#ifdef CONFIG_64BIT
+	AUDIT_ARCH_PARISC64,
+#endif
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_PARISC;
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index fd1b518eed17..781deb211e3d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -104,6 +104,20 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	regs->orig_gpr3 = args[0];
 }
 
+static __maybe_unused const int syscall_arches[] = {
+#ifdef __LITTLE_ENDIAN__
+	AUDIT_ARCH_PPC | __AUDIT_ARCH_LE,
+# ifdef CONFIG_PPC64
+	AUDIT_ARCH_PPC64LE,
+# endif /* CONFIG_PPC64 */
+#else
+	AUDIT_ARCH_PPC,
+# ifdef CONFIG_PPC64
+	AUDIT_ARCH_PPC64,
+# endif /* CONFIG_PPC64 */
+#endif /* __LITTLE_ENDIAN__ */
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch;
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 49350c8bd7b0..4b36d358243e 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -73,13 +73,19 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->a1, args, 5 * sizeof(regs->a1));
 }
 
-static inline int syscall_get_arch(struct task_struct *task)
-{
 #ifdef CONFIG_64BIT
-	return AUDIT_ARCH_RISCV64;
+#define SYSCALL_ARCH AUDIT_ARCH_RISCV64
 #else
-	return AUDIT_ARCH_RISCV32;
+#define SYSCALL_ARCH AUDIT_ARCH_RISCV32
 #endif
+
+static __maybe_unused const int syscall_arches[] = {
+	SYSCALL_ARCH
+};
+
+static inline int syscall_get_arch(struct task_struct *task)
+{
+	return SYSCALL_ARCH;
 }
 
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index d9d5de0f67ff..4cb9da36610a 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -89,6 +89,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	regs->orig_gpr2 = args[0];
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_S390X,
+#ifdef CONFIG_COMPAT
+	AUDIT_ARCH_S390,
+#endif
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_COMPAT
diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index cb51a7528384..4780f2339c72 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -69,13 +69,18 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	regs->regs[4] = args[0];
 }
 
-static inline int syscall_get_arch(struct task_struct *task)
-{
-	int arch = AUDIT_ARCH_SH;
-
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	arch |= __AUDIT_ARCH_LE;
+#define SYSCALL_ARCH AUDIT_ARCH_SHEL
+#else
+#define SYSCALL_ARCH AUDIT_ARCH_SH
 #endif
-	return arch;
+
+static __maybe_unused const int syscall_arches[] = {
+	SYSCALL_ARCH
+};
+
+static inline int syscall_get_arch(struct task_struct *task)
+{
+	return SYSCALL_ARCH;
 }
 #endif /* __ASM_SH_SYSCALL_32_H */
diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index 62a5a78804c4..a458992cdcfe 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -127,6 +127,15 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		regs->u_regs[UREG_I0 + i] = args[i];
 }
 
+static __maybe_unused const int syscall_arches[] = {
+#ifdef CONFIG_SPARC64
+	AUDIT_ARCH_SPARC64,
+#endif
+#if !defined(CONFIG_SPARC64) || defined(CONFIG_COMPAT)
+	AUDIT_ARCH_SPARC,
+#endif
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #if defined(CONFIG_SPARC64) && defined(CONFIG_COMPAT)
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7cbf733d11af..e13bb2a65b6f 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -97,6 +97,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->bx + i, args, n * sizeof(args[0]));
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_I386
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_I386;
@@ -152,6 +156,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_X86_64,
+#ifdef CONFIG_IA32_EMULATION
+	AUDIT_ARCH_I386,
+#endif
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* x32 tasks should be considered AUDIT_ARCH_X86_64. */
diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index 56a2f0913e3c..590a31e22b99 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -9,13 +9,19 @@ typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
 
-static inline int syscall_get_arch(struct task_struct *task)
-{
 #ifdef CONFIG_X86_32
-	return AUDIT_ARCH_I386;
+#define SYSCALL_ARCH AUDIT_ARCH_I386
 #else
-	return AUDIT_ARCH_X86_64;
+#define SYSCALL_ARCH AUDIT_ARCH_X86_64
 #endif
+
+static __maybe_unused const int syscall_arches[] = {
+	SYSCALL_ARCH
+};
+
+static inline int syscall_get_arch(struct task_struct *task)
+{
+	return SYSCALL_ARCH;
 }
 
 #endif /* __UM_ASM_SYSCALL_H */
diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index f9a671cbf933..3d334fb0d329 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -14,6 +14,10 @@
 #include <asm/ptrace.h>
 #include <uapi/linux/audit.h>
 
+static __maybe_unused const int syscall_arches[] = {
+	AUDIT_ARCH_XTENSA
+};
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_XTENSA;
-- 
2.28.0

