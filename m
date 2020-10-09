Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE328902B
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgJIRQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732898AbgJIRPk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:15:40 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCECC0613D2;
        Fri,  9 Oct 2020 10:15:39 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o18so9828202ill.2;
        Fri, 09 Oct 2020 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EyJ7IZKon/D0w6vOc5Cj9B1U+3aN4px6AxhT0P+zOw=;
        b=PKtExl62LofXNm6pJVdPVZwFgi3+chh9iPWCAVuOymwzn4czSzaiiTiAMrtIjB70Dk
         pDSw9pslrc/WEuw0afcdnUKwEZCScTlG315F82FEfTHRvLADjQqK/jUpOuCMlTY6EiBb
         Z3tlhmalns7HThG57z0vhRZoxB61BxCmiwB5k1WfSoArWhYj5cpDYnBaKbnkbSZNLaN1
         kqHSHgTcLnzjm9h5cMNqDOzZgpxf+kz5anKMVzXAbQRTodM6Y9vHWEqO/9+sCD9DiEbC
         1E97U7PJY/m5pfu0ZRNHDElviIfVpF8bQzZCSQ3BJ49K/mKh36RH+u9jR0EgZkk7ESbR
         mImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EyJ7IZKon/D0w6vOc5Cj9B1U+3aN4px6AxhT0P+zOw=;
        b=UuSnwXnwFRwQunPTVR77yRf9FQUUm3npX/n+NQAZnbW507rhCp+fco27XcGeitrKVn
         l7CYJ7NqQ5CpiIyMdbhmtE99UPSc2VLK6WB1LYfvX3zDWusiW/5i5QJudU8XjnuFBZYP
         3ysh8flIDmauRMgsBfAHUl/6axgEAAhfg7RZm2K8bldx9cer/XPgiIPLTwx9Fei3Wi84
         rX0vIPa3lgEc4JtjQwoXLjDhbDIj1rah9NjTgdgagE8KNEf6I8nCgN5nib2wtvRTXeQg
         zpPdjQ8P4fMlozg4jCrOc/6wYvdCZtlWxsx1ms4vKM217tWOcIzf+ICclIctlS8c3i1Z
         bEEQ==
X-Gm-Message-State: AOAM532LlY/51OTe8B1oRmsD2ZupeOdt3jD02hK8e2Iz92e7SB6acOLl
        NBU43bhQ8Ndt0w9p3OBP/Zg=
X-Google-Smtp-Source: ABdhPJxC3XDLh+JSZnUh0Z4lr02UEB1fvKeGlRx77I+YH0RaP5DenMdqfSWrkA8007Mx19L/Skww3A==
X-Received: by 2002:a92:9859:: with SMTP id l86mr11975537ili.167.1602263738394;
        Fri, 09 Oct 2020 10:15:38 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id c2sm3762830iot.52.2020.10.09.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:15:37 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
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
Subject: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
Date:   Fri,  9 Oct 2020 12:14:33 -0500
Message-Id: <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602263422.git.yifeifz2@illinois.edu>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

Currently the kernel does not provide an infrastructure to translate
architecture numbers to a human-readable name. Translating syscall
numbers to syscall names is possible through FTRACE_SYSCALL
infrastructure but it does not provide support for compat syscalls.

This will create a file for each PID as /proc/pid/seccomp_cache.
The file will be empty when no seccomp filters are loaded, or be
in the format of:
<arch name> <decimal syscall number> <ALLOW | FILTER>
where ALLOW means the cache is guaranteed to allow the syscall,
and filter means the cache will pass the syscall to the BPF filter.

For the docker default profile on x86_64 it looks like:
x86_64 0 ALLOW
x86_64 1 ALLOW
x86_64 2 ALLOW
x86_64 3 ALLOW
[...]
x86_64 132 ALLOW
x86_64 133 ALLOW
x86_64 134 FILTER
x86_64 135 FILTER
x86_64 136 FILTER
x86_64 137 ALLOW
x86_64 138 ALLOW
x86_64 139 FILTER
x86_64 140 ALLOW
x86_64 141 ALLOW
[...]

This file is guarded by CONFIG_SECCOMP_CACHE_DEBUG with a default
of N because I think certain users of seccomp might not want the
application to know which syscalls are definitely usable. For
the same reason, it is also guarded by CAP_SYS_ADMIN.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/Kconfig                   | 24 ++++++++++++++
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/seccomp.h |  3 ++
 fs/proc/base.c                 |  6 ++++
 include/linux/seccomp.h        |  5 +++
 kernel/seccomp.c               | 59 ++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 21a3675a7a3a..85239a974f04 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -471,6 +471,15 @@ config HAVE_ARCH_SECCOMP_FILTER
 	    results in the system call being skipped immediately.
 	  - seccomp syscall wired up
 
+config HAVE_ARCH_SECCOMP_CACHE
+	bool
+	help
+	  An arch should select this symbol if it provides all of these things:
+	  - all the requirements for HAVE_ARCH_SECCOMP_FILTER
+	  - SECCOMP_ARCH_NATIVE
+	  - SECCOMP_ARCH_NATIVE_NR
+	  - SECCOMP_ARCH_NATIVE_NAME
+
 config SECCOMP
 	prompt "Enable seccomp to safely execute untrusted bytecode"
 	def_bool y
@@ -498,6 +507,21 @@ config SECCOMP_FILTER
 
 	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
+config SECCOMP_CACHE_DEBUG
+	bool "Show seccomp filter cache status in /proc/pid/seccomp_cache"
+	depends on SECCOMP
+	depends on SECCOMP_FILTER
+	depends on PROC_FS
+	help
+	  This is enables /proc/pid/seccomp_cache interface to monitor
+	  seccomp cache data. The file format is subject to change. Reading
+	  the file requires CAP_SYS_ADMIN.
+
+	  This option is for debugging only. Enabling present the risk that
+	  an adversary may be able to infer the seccomp filter logic.
+
+	  If unsure, say N.
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1ab22869a765..1a807f89ac77 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -150,6 +150,7 @@ config X86
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SECCOMP_CACHE
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 03365af6165d..cd57c3eabab5 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -19,13 +19,16 @@
 #ifdef CONFIG_X86_64
 # define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_X86_64
 # define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"x86_64"
 # ifdef CONFIG_COMPAT
 #  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_I386
 #  define SECCOMP_ARCH_COMPAT_NR	IA32_NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"ia32"
 # endif
 #else /* !CONFIG_X86_64 */
 # define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_I386
 # define SECCOMP_ARCH_NATIVE_NR	        NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"ia32"
 #endif
 
 #include <asm-generic/seccomp.h>
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0faa0..a4990410ff05 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3258,6 +3258,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
 #endif
+#ifdef CONFIG_SECCOMP_CACHE_DEBUG
+	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3587,6 +3590,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
 #endif
+#ifdef CONFIG_SECCOMP_CACHE_DEBUG
+	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..1f028d55142a 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -121,4 +121,9 @@ static inline long seccomp_get_metadata(struct task_struct *task,
 	return -EINVAL;
 }
 #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
+
+#ifdef CONFIG_SECCOMP_CACHE_DEBUG
+int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
+			   struct pid *pid, struct task_struct *task);
+#endif
 #endif /* _LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 51032b41fe59..a75746d259a5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -548,6 +548,9 @@ void seccomp_filter_release(struct task_struct *tsk)
 {
 	struct seccomp_filter *orig = tsk->seccomp.filter;
 
+	/* We are effectively holding the siglock by not having any sighand. */
+	WARN_ON(tsk->sighand != NULL);
+
 	/* Detach task from its filter tree. */
 	tsk->seccomp.filter = NULL;
 	__seccomp_filter_release(orig);
@@ -2308,3 +2311,59 @@ static int __init seccomp_sysctl_init(void)
 device_initcall(seccomp_sysctl_init)
 
 #endif /* CONFIG_SYSCTL */
+
+#ifdef CONFIG_SECCOMP_CACHE_DEBUG
+/* Currently CONFIG_SECCOMP_CACHE_DEBUG implies SECCOMP_ARCH_NATIVE */
+static void proc_pid_seccomp_cache_arch(struct seq_file *m, const char *name,
+					const void *bitmap, size_t bitmap_size)
+{
+	int nr;
+
+	for (nr = 0; nr < bitmap_size; nr++) {
+		bool cached = test_bit(nr, bitmap);
+		char *status = cached ? "ALLOW" : "FILTER";
+
+		seq_printf(m, "%s %d %s\n", name, nr, status);
+	}
+}
+
+int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
+			   struct pid *pid, struct task_struct *task)
+{
+	struct seccomp_filter *f;
+	unsigned long flags;
+
+	/*
+	 * We don't want some sandboxed process know what their seccomp
+	 * filters consist of.
+	 */
+	if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (!lock_task_sighand(task, &flags))
+		return 0;
+
+	f = READ_ONCE(task->seccomp.filter);
+	if (!f) {
+		unlock_task_sighand(task, &flags);
+		return 0;
+	}
+
+	/* prevent filter from being freed while we are printing it */
+	__get_seccomp_filter(f);
+	unlock_task_sighand(task, &flags);
+
+	proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_NATIVE_NAME,
+				    f->cache.allow_native,
+				    SECCOMP_ARCH_NATIVE_NR);
+
+#ifdef SECCOMP_ARCH_COMPAT
+	proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_COMPAT_NAME,
+				    f->cache.allow_compat,
+				    SECCOMP_ARCH_COMPAT_NR);
+#endif /* SECCOMP_ARCH_COMPAT */
+
+	__put_seccomp_filter(f);
+	return 0;
+}
+#endif /* CONFIG_SECCOMP_CACHE_DEBUG */
-- 
2.28.0

