Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE717277097
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgIXMG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgIXMG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:06:58 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC641C0613CE;
        Thu, 24 Sep 2020 05:06:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y9so2891875ilq.2;
        Thu, 24 Sep 2020 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77aOM0dEGnPSSFeqHdvW9i0OufGkWG1x6ZJwSCuKRpU=;
        b=ATR49onqN+95MxJ40+wvBsqqkbmpyiOgoQ6j9JFFOKDH4W5b0sxW52ukXhJ4r3dcPV
         PL+8QtblR4qQannlwEjlNW27XIhGXCpHcRlcG36hjxzqvR27ofj0c6esrjc+4LPQDphP
         P2sXR8GElcazn9W5MDTRDQyO9B0z9IuGXrED1QWR6HyMo10FGLUoy0QdTQV+4pcF+uct
         Ob/PqVpAKCkUMKSkx7yIlwE0ZW2BqlwTtGwjJLGB3L0Mg2j6klgZ4dF4E3SLosBHf67h
         59qpRuFSp01A6pUFxd33CcJK7Px/TTtXdgP8tokovnCZbgIZlltw+USiZQdv/FtIWAT+
         geJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77aOM0dEGnPSSFeqHdvW9i0OufGkWG1x6ZJwSCuKRpU=;
        b=AoRmlQE2gZ+XLP3wEfCX79nnE8zpKe+h1fDujM5jqnvBzruOYzBdalnJAKxccE56jd
         ziDFELTSJ17mKZ02tdlZEerQAu4gBNpUkc4PVufpLIgcwwse3cORjaOAqJTn2wDx1KbX
         unocevse6GZrvA+rvIYT+Re1s5pYjktWrF9gfyRxRMXMeI6/J18L5dokTavID1Bdw+fj
         MJRPFNJfNeLD4KLWPpr3Vbc58K36vcWi39F3dzguyW6pzII4FChn3vGSDXz7g0T2ichg
         L9sMl1E0lJchWRK1l2jqwt+whvGmxusWdMHhMpfAft/C7yCYUeiKiflqgWIpAuBwEWCd
         p3UQ==
X-Gm-Message-State: AOAM530vtBMxP97TCnulncrZEFkGoxvnHkLyHaxQn2YUaXPb+5BXTAR7
        rl6Z+8fnfCsOJhvYJE7kj0I=
X-Google-Smtp-Source: ABdhPJzEJ83GyLMjD3RB/741NrbDxkhsRIVB42PFUNQhJ3J8fKzwBhuulvzVuqU9o2EdCApr5X63Rw==
X-Received: by 2002:a92:9f91:: with SMTP id z17mr3547272ilk.36.1600949217203;
        Thu, 24 Sep 2020 05:06:57 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id a23sm1259435ioc.54.2020.09.24.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:06:56 -0700 (PDT)
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
Subject: [PATCH seccomp 6/6] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
Date:   Thu, 24 Sep 2020 07:06:46 -0500
Message-Id: <163d194f6363a527568cd99c8cc1137498a16ce5.1600946701.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600946701.git.yifeifz2@illinois.edu>
References: <cover.1600946701.git.yifeifz2@illinois.edu>
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
<hex arch number> <decimal syscall number> <ALLOW | FILTER>
where ALLOW means the cache is guaranteed to allow the syscall,
and filter means the cache will pass the syscall to the BPF filter.

For the docker default profile on x86_64 it looks like:
c000003e 0 ALLOW
c000003e 1 ALLOW
c000003e 2 ALLOW
c000003e 3 ALLOW
[...]
c000003e 132 ALLOW
c000003e 133 ALLOW
c000003e 134 FILTER
c000003e 135 FILTER
c000003e 136 FILTER
c000003e 137 ALLOW
c000003e 138 ALLOW
c000003e 139 FILTER
c000003e 140 ALLOW
c000003e 141 ALLOW
[...]

This file is guarded by CONFIG_PROC_SECCOMP_CACHE with a default
of N because I think certain users of seecomp might not want the
application to know which syscalls are definitely usable.

I'm not sure if adding all the "human readable names" is worthwhile,
considering it can be easily done in userspace.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/Kconfig            | 10 ++++++++++
 fs/proc/base.c          |  7 +++++--
 include/linux/seccomp.h |  5 +++++
 kernel/seccomp.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc3dc87f253..dbfd897e5dc0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -514,6 +514,16 @@ config SECCOMP_CACHE_NR_ONLY
 
 endchoice
 
+config PROC_SECCOMP_CACHE
+	bool "Show seccomp filter cache status in /proc/pid/seccomp_cache"
+	depends on SECCOMP_CACHE_NR_ONLY
+	depends on PROC_FS
+	help
+	  This is enables /proc/pid/seccomp_cache interface to monitor
+	  seccomp cache data. The file format is subject to change.
+
+	  If unsure, say N.
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0faa0..2af626f69fa1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2615,7 +2615,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static struct dentry *proc_pident_lookup(struct inode *dir, 
+static struct dentry *proc_pident_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 const struct pid_entry *p,
 					 const struct pid_entry *end)
@@ -2815,7 +2815,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
 {
-	return proc_pident_readdir(file, ctx, 
+	return proc_pident_readdir(file, ctx,
 				   attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
 }
 
@@ -3258,6 +3258,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
 #endif
+#ifdef CONFIG_PROC_SECCOMP_CACHE
+	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..3cedec824365 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -121,4 +121,9 @@ static inline long seccomp_get_metadata(struct task_struct *task,
 	return -EINVAL;
 }
 #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
+
+#ifdef CONFIG_PROC_SECCOMP_CACHE
+int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
+			   struct pid *pid, struct task_struct *task);
+#endif
 #endif /* _LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 5b1bd8329e9c..c5697d9483ae 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2295,3 +2295,29 @@ static int __init seccomp_sysctl_init(void)
 device_initcall(seccomp_sysctl_init)
 
 #endif /* CONFIG_SYSCTL */
+
+#ifdef CONFIG_PROC_SECCOMP_CACHE
+/* Currently CONFIG_PROC_SECCOMP_CACHE implies CONFIG_SECCOMP_CACHE_NR_ONLY */
+int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
+			   struct pid *pid, struct task_struct *task)
+{
+	struct seccomp_filter *f = READ_ONCE(task->seccomp.filter);
+	int arch, nr;
+
+	if (!f)
+		return 0;
+
+	for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
+		for (nr = 0; nr < NR_syscalls; nr++) {
+			bool cached = test_bit(nr, f->cache.syscall_ok[arch]);
+			char *status = cached ? "ALLOW" : "FILTER";
+
+			seq_printf(m, "%08x %d %s\n", syscall_arches[arch],
+				   nr, status
+			);
+		}
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PROC_SECCOMP_CACHE */
-- 
2.28.0

