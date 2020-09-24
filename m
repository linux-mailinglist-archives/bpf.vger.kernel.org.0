Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE42771A3
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIXMoy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgIXMor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:44:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF90C0613D3;
        Thu, 24 Sep 2020 05:44:47 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y74so3060852iof.12;
        Thu, 24 Sep 2020 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/USLdYHm6D95gd7gNJM0h++23w7RB4ijC+a8OVv2IY=;
        b=Q3T2AejocKcdiQgWLyH7AtdDOAw26oqxNCYfgXKgz/ucabcwAiAiNPsuDXpTAz0TvR
         FF1zN4xXop5zkI4fbdGS3m7cHVhuQT9iKp7UVeDdcN0eBEPdC/bNrfZtSY8N2qC+HbW3
         g24tm1XZ05EB8br94vTrH3HSCc5tJ3dnEMJWN980xIGp2803vBTQVJbbJ9gBP9qgBLPd
         7Jtsu52R7l2DKsS+1cP3DitdinNc/3rcXPQ/YRJhbu0zoiNxfKR+lti1tZFKgDNF+I+f
         YHEz2famdYx0qabOKsaeJCQ4ltAi/25JdC+P2oHW8lxhy2GQW7ocwXfdCTtlblIwON0N
         TRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/USLdYHm6D95gd7gNJM0h++23w7RB4ijC+a8OVv2IY=;
        b=sQ+hwayfVlVHfL5M7vAB398HQRgxri4x5JTGFz9M/7uTYPz33kmyO4QZaRLeSaCckq
         w5TEzdRJDj9yT7kBSu89BHHlrfKCl01HjFwSqZyehFVRejwPPazh0rSqXuYAk8cazA4I
         O1oT4vQc1Sm/ByxLiA/KZGEfNjfD0+qb730yjXYI+tWnzTFckuI+O5M+FnR2l7/+5SG0
         v1YIZSAI4opxFTmegttG4/dw//bJmkGAvs/DXq4iPMhnCYOJHVLpTs9SxjioxxZWT10z
         HEAwO71ZV5oMkmAKG3unix6GgsLelrQ8WpSOE2VXvq4j/aYqtke+9bhF9ID5f4bNlkta
         3Daw==
X-Gm-Message-State: AOAM5313LvGPVlkxNjXsrFlBJh5429wETvzg1zCQlWoz++zYMzg7qQun
        pH/Knnd8CYINqsUEui0x0zA=
X-Google-Smtp-Source: ABdhPJx02j71v3xJKtuqCYqHk5i+Cg/qFJ3jCgEibAwl0YmV2MhmzsBLwTbmAmQTQPYVZ/4uCqRjJg==
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr3587948jaj.115.1600951486478;
        Thu, 24 Sep 2020 05:44:46 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id p5sm1575175ilg.32.2020.09.24.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:44:45 -0700 (PDT)
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
Subject: [PATCH v2 seccomp 6/6] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
Date:   Thu, 24 Sep 2020 07:44:21 -0500
Message-Id: <b11ebe533838af7829a5e7381a7914bca27cb621.1600951211.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600951211.git.yifeifz2@illinois.edu>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
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
index ac0266b6d18a..d97ec1876b4e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2293,3 +2293,29 @@ static int __init seccomp_sysctl_init(void)
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

