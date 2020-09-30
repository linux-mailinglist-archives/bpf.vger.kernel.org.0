Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C427EC8F
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgI3PUo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgI3PUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 11:20:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A852C061755;
        Wed, 30 Sep 2020 08:20:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so2201287ioj.7;
        Wed, 30 Sep 2020 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jREIpX4zm+bXQV4GY7erFrXt82ePUSIl6wMoQiJQey4=;
        b=h9ZjX4eGPqcJOpfWYc3rRkbc0/uIBIA0z208Muoytgd2Zkc4s/wN8o1um7Vh0YsWAR
         +2Y/YgZE292Y9q3TXdoGRaaHanr4WAnFP5uFMmQ+45q1ordQI0w/+irOShjPxp/4/V7/
         +XoFy0al9TGWw+kzoT352r4cmnvjksJMI83BvANTNQR0N8NkSTa41JWyylb5b7CtkpkA
         pJmWTT1mSTk5V/y7CyHIrkwOEXOqmuAVJphlBeMaBGYW5N09gtmFrw/ZI6MkLy8Dnvai
         YvrUK8uvDZiPouOAaZaO1FLE2/42ujQDkI4hfPyKpRRDUyD7Kz2MB2pvSHPudFbVWiHE
         ps6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jREIpX4zm+bXQV4GY7erFrXt82ePUSIl6wMoQiJQey4=;
        b=tkae90etAn/gB/TnpvVaGPIwMAwaZ4ynFYFnop3rpYp1RQotmJ3svwNni/x1pgdziO
         DfjmPUr259IBNVIBBXq6rIyJEoNJv47QGNFst0P9TSPPuhO3pBalclUZmo0xvOwR4mIx
         C6yHi7kTMGfpagORFwLs9AY3ICp2z4k9hNqAb3poai5mVEuRQ+708RYWn3ZuHFwAjQhb
         9w9xhlcIgKldl/ZF/aA+v7CWl6Bg07fPYYng2XPBiEtgiMyEgX+wJDS+JrG5BPA5v/y0
         +Io/B2ieakrKWfpZlMIfZDPVPxYF3+kCOOHeGxbSoCAij2IqWlOoB6P/ORzjbCl//LIP
         +IQQ==
X-Gm-Message-State: AOAM530HwKY8VkW/BtZ5dL2cWazCzIEIVyRlpViXxXoklRi7KLdqAMoE
        xUgquBpxZfwUd5VBDPq+3Iw=
X-Google-Smtp-Source: ABdhPJwUId5jwICkoihvxugKENCdWV2ugU3LmdKq2serskfp9gUu2bmLJhqPV/YGR57wE3HQ4IzBBw==
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr2066435ior.154.1601479238534;
        Wed, 30 Sep 2020 08:20:38 -0700 (PDT)
Received: from localhost.localdomain (ip-99-203-15-156.pools.cgn.spcsdns.net. [99.203.15.156])
        by smtp.gmail.com with ESMTPSA id t10sm770788iog.49.2020.09.30.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:20:37 -0700 (PDT)
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
Subject: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
Date:   Wed, 30 Sep 2020 10:19:16 -0500
Message-Id: <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601478774.git.yifeifz2@illinois.edu>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
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

This file is guarded by CONFIG_DEBUG_SECCOMP_CACHE with a default
of N because I think certain users of seccomp might not want the
application to know which syscalls are definitely usable. For
the same reason, it is also guarded by CAP_SYS_ADMIN.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/Kconfig                   | 15 +++++++++++
 arch/x86/include/asm/seccomp.h |  3 +++
 fs/proc/base.c                 |  3 +++
 include/linux/seccomp.h        |  5 ++++
 kernel/seccomp.c               | 46 ++++++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ca867b2a5d71..b840cadcc882 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -478,6 +478,7 @@ config HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
 	  - all the requirements for HAVE_ARCH_SECCOMP_FILTER
 	  - SECCOMP_ARCH_DEFAULT
 	  - SECCOMP_ARCH_DEFAULT_NR
+	  - SECCOMP_ARCH_DEFAULT_NAME
 
 config SECCOMP
 	prompt "Enable seccomp to safely execute untrusted bytecode"
@@ -532,6 +533,20 @@ config SECCOMP_CACHE_NR_ONLY
 
 endchoice
 
+config DEBUG_SECCOMP_CACHE
+	bool "Show seccomp filter cache status in /proc/pid/seccomp_cache"
+	depends on SECCOMP_CACHE_NR_ONLY
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
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 7b3a58271656..33ccc074be7a 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -19,13 +19,16 @@
 #ifdef CONFIG_X86_64
 # define SECCOMP_ARCH_DEFAULT			AUDIT_ARCH_X86_64
 # define SECCOMP_ARCH_DEFAULT_NR		NR_syscalls
+# define SECCOMP_ARCH_DEFAULT_NAME		"x86_64"
 # ifdef CONFIG_COMPAT
 #  define SECCOMP_ARCH_COMPAT			AUDIT_ARCH_I386
 #  define SECCOMP_ARCH_COMPAT_NR		IA32_NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME		"x86_32"
 # endif
 #else /* !CONFIG_X86_64 */
 # define SECCOMP_ARCH_DEFAULT		AUDIT_ARCH_I386
 # define SECCOMP_ARCH_DEFAULT_NR	NR_syscalls
+# define SECCOMP_ARCH_COMPAT_NAME		"x86_32"
 #endif
 
 #include <asm-generic/seccomp.h>
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0faa0..c60c5fce70fa 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3258,6 +3258,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
 #endif
+#ifdef CONFIG_DEBUG_SECCOMP_CACHE
+	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..c35430f5f553 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -121,4 +121,9 @@ static inline long seccomp_get_metadata(struct task_struct *task,
 	return -EINVAL;
 }
 #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
+
+#ifdef CONFIG_DEBUG_SECCOMP_CACHE
+int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
+			   struct pid *pid, struct task_struct *task);
+#endif
 #endif /* _LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index bed3b2a7f6c8..c5ca5e30281b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2297,3 +2297,49 @@ static int __init seccomp_sysctl_init(void)
 device_initcall(seccomp_sysctl_init)
 
 #endif /* CONFIG_SYSCTL */
+
+#ifdef CONFIG_DEBUG_SECCOMP_CACHE
+/* Currently CONFIG_DEBUG_SECCOMP_CACHE implies CONFIG_SECCOMP_CACHE_NR_ONLY */
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
+
+	/*
+	 * We don't want some sandboxed process know what their seccomp
+	 * filters consist of.
+	 */
+	if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
+		return -EACCES;
+
+	f = READ_ONCE(task->seccomp.filter);
+	if (!f)
+		return 0;
+
+#ifdef SECCOMP_ARCH_DEFAULT
+	proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_DEFAULT_NAME,
+				    f->cache.syscall_allow_default,
+				    SECCOMP_ARCH_DEFAULT_NR);
+#endif /* SECCOMP_ARCH_DEFAULT */
+
+#ifdef SECCOMP_ARCH_COMPAT
+	proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_COMPAT_NAME,
+				    f->cache.syscall_allow_compat,
+				    SECCOMP_ARCH_COMPAT_NR);
+#endif /* SECCOMP_ARCH_COMPAT */
+	return 0;
+}
+#endif /* CONFIG_DEBUG_SECCOMP_CACHE */
-- 
2.28.0

