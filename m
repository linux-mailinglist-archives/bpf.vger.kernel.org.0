Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20183127FA9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLTPmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32912 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfLTPmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so9886707wrq.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUDtwe+tHTdIyYF0y1BKJlXUkUXphA4Xluv5daGuYQ8=;
        b=HAUV7SFTG23CnfApTAreWQAGw7ScReF/JhZiD0u3UJQJmZ5ahVx3v9kxWNIN6NlAeP
         fT65LiBfj5m6ncaMyYHIiq7IJ0s2K7vQGX07wls4XSGTGxB/i3cos5OR7jkf4gAaC7e9
         7YLI7XKX2hA96BvUS+0vEAtbRwdLcYLAuO290=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUDtwe+tHTdIyYF0y1BKJlXUkUXphA4Xluv5daGuYQ8=;
        b=TVWTLq7UG6jyXKBUiBLx29AMqsC7u9H7ueIrTaxrrQHVMWm1xshVzwkfIK50i9rwJl
         XaifnsCNiahe/C3bttMGAQ+CgosMFygJRBmjJ8J3H3GgMVsK1DeAm4VoafVz2FmLtjal
         +q29ScaiamTN8bED9x+J/2ilHHtpsIlEtr88dL7yQ9Kxvpz2xMgw875h1okGJ2q8nBXJ
         uT3ekpFtt9OqESBtXRCzmA8GlHg0iChCxtHD5BCu4h3sjquN450azCDK4zGHFsrzx/N/
         gP+r31Fuf+/5clnJF/A0wbMEaeEQgbdx+owJvexOt4ona8WY5MFmRJMxfCmZvjNZXagv
         ZWEA==
X-Gm-Message-State: APjAAAW3KUXQ6fnpG88iR5J/THy1mdLSQfEI8/V6pLTxrTTZWZ3lF5U1
        e3zNB+do/XQgj6k1WTl2M4F4Cw==
X-Google-Smtp-Source: APXvYqyOFDfCVjajx8LYp+W4yrW50EsoTdd4rxixqncktY/UISuqbWd4kn+bmYsDPqMKh/fYdjF/PQ==
X-Received: by 2002:adf:b648:: with SMTP id i8mr16207783wre.91.1576856531012;
        Fri, 20 Dec 2019 07:42:11 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:10 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files in securityfs
Date:   Fri, 20 Dec 2019 16:42:01 +0100
Message-Id: <20191220154208.15895-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The LSM creates files in securityfs for each hook registered with the
LSM.

    /sys/kernel/security/bpf/<h_name>

The list of LSM hooks are maintained in an internal header "hooks.h"
Eventually, this list should either be defined collectively in
include/linux/lsm_hooks.h or auto-generated from it.

* Creation of a file for the hook in the securityfs.
* Allocation of a bpf_lsm_hook data structure which stores
  a pointer to the dentry of the newly created file in securityfs.
* Creation of a typedef for the hook so that BTF information
  can be generated for the LSM hooks to:

  - Make them "Compile Once, Run Everywhere".
  - Pass the right arguments when the attached programs are run.
  - Verify the accesses made by the program by using the BTF
    information.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h        |   12 +
 security/bpf/Makefile          |    4 +-
 security/bpf/include/bpf_lsm.h |   63 ++
 security/bpf/include/fs.h      |   23 +
 security/bpf/include/hooks.h   | 1015 ++++++++++++++++++++++++++++++++
 security/bpf/lsm.c             |  138 ++++-
 security/bpf/lsm_fs.c          |   82 +++
 7 files changed, 1333 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 security/bpf/include/bpf_lsm.h
 create mode 100644 security/bpf/include/fs.h
 create mode 100644 security/bpf/include/hooks.h
 create mode 100644 security/bpf/lsm_fs.c

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..76f81e642dc2
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_BPF_LSM_H
+#define _LINUX_BPF_LSM_H
+
+#include <linux/bpf.h>
+
+#ifdef CONFIG_SECURITY_BPF
+extern int bpf_lsm_fs_initialized;
+#endif /* CONFIG_SECURITY_BPF */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index c78a8a056e7e..8bb5bfc936ee 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -2,4 +2,6 @@
 #
 # Copyright 2019 Google LLC.
 
-obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
+obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o lsm_fs.o
+
+ccflags-y := -I$(srctree)/security/bpf -I$(srctree)/security/bpf/include
diff --git a/security/bpf/include/bpf_lsm.h b/security/bpf/include/bpf_lsm.h
new file mode 100644
index 000000000000..f2409d75d932
--- /dev/null
+++ b/security/bpf/include/bpf_lsm.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_LSM_H
+#define _BPF_LSM_H
+
+#include <linux/bpf_event.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include "fs.h"
+
+/*
+ * This enum indexes one of the LSM hooks defined in hooks.h.
+ * Each value of the enum is defined as <hook>_type.
+ */
+enum lsm_hook_type {
+	#define BPF_LSM_HOOK(hook, ...) hook##_type,
+	#include "hooks.h"
+	#undef BPF_LSM_HOOK
+	__MAX_LSM_HOOK_TYPE,
+};
+
+/*
+ * This data structure contains all the information required by the LSM for a
+ * a hook.
+ */
+struct bpf_lsm_hook {
+	/*
+	 * The name of the security hook, a file with this name will be created
+	 * in the securityfs.
+	 */
+	const char *name;
+	/*
+	 * The type of the LSM hook, the LSM uses this to index the list of the
+	 * hooks to run the eBPF programs that may have been attached.
+	 */
+	enum lsm_hook_type h_type;
+	/*
+	 * The dentry of the file created in securityfs.
+	 */
+	struct dentry *h_dentry;
+	/*
+	 * The mutex must be held when updating the progs attached to the hook.
+	 */
+	struct mutex mutex;
+	/*
+	 * The eBPF programs that are attached to this hook.
+	 */
+	struct bpf_prog_array __rcu *progs;
+	/*
+	 * The actual implementation of the hook. This also ensures that
+	 * BTF information is generated for the hook.
+	 */
+	void *btf_hook_func;
+};
+
+extern struct bpf_lsm_hook bpf_lsm_hooks_list[];
+
+#define lsm_for_each_hook(hook) \
+	for ((hook) = &bpf_lsm_hooks_list[0]; \
+	     (hook) < &bpf_lsm_hooks_list[__MAX_LSM_HOOK_TYPE]; \
+	     (hook)++)
+
+#endif /* _BPF_LSM_H */
diff --git a/security/bpf/include/fs.h b/security/bpf/include/fs.h
new file mode 100644
index 000000000000..9d87a0b2bf41
--- /dev/null
+++ b/security/bpf/include/fs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#ifndef _BPF_LSM_FS_H
+#define _BPF_LSM_FS_H
+
+#include <linux/bpf.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+
+bool is_bpf_lsm_hook_file(struct file *f);
+
+/*
+ * The name of the directory created in securityfs
+ *
+ *	/sys/kernel/security/<dir_name>
+ */
+#define BPF_LSM_SFS_NAME "bpf"
+
+#endif /* _BPF_LSM_FS_H */
diff --git a/security/bpf/include/hooks.h b/security/bpf/include/hooks.h
new file mode 100644
index 000000000000..c91c6fae8058
--- /dev/null
+++ b/security/bpf/include/hooks.h
@@ -0,0 +1,1015 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2019 Google LLC.
+ *
+ * The hooks for the KRSI LSM are declared in this file.
+ *
+ * This header MUST NOT be included directly and is included inline
+ * for generating various data structurs for the hooks using the
+ * following pattern:
+ *
+ * #define BPF_LSM_HOOK RET NAME(PROTO);
+ * #include "hooks.h"
+ * #undef BPF_LSM_HOOK
+ *
+ * Format:
+ *
+ *	BPF_LSM_HOOK(NAME, RET, PROTO, ARGS)
+ *
+ */
+#define BPF_LSM_ARGS(args...) args
+
+BPF_LSM_HOOK(binder_set_context_mgr,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *mgr),
+	     BPF_LSM_ARGS(mgr))
+BPF_LSM_HOOK(binder_transaction,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *from, struct task_struct *to),
+	     BPF_LSM_ARGS(from, to))
+BPF_LSM_HOOK(binder_transfer_binder,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *from, struct task_struct *to),
+	     BPF_LSM_ARGS(from, to))
+BPF_LSM_HOOK(binder_transfer_file,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *from, struct task_struct *to,
+			  struct file *file),
+	     BPF_LSM_ARGS(from, to, file))
+BPF_LSM_HOOK(ptrace_access_check,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *child, unsigned int mode),
+	     BPF_LSM_ARGS(child, mode))
+BPF_LSM_HOOK(ptrace_traceme,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *parent),
+	     BPF_LSM_ARGS(parent))
+BPF_LSM_HOOK(capget,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *target, kernel_cap_t *effective,
+		     kernel_cap_t *inheritable, kernel_cap_t *permitted),
+	     BPF_LSM_ARGS(target, effective, inheritable, permitted))
+BPF_LSM_HOOK(capset,
+	 int,
+	 BPF_LSM_ARGS(struct cred *new, const struct cred *old,
+		     const kernel_cap_t *effective,
+		     const kernel_cap_t *inheritable,
+		     const kernel_cap_t *permitted),
+	 BPF_LSM_ARGS(new, old, effective, inheritable, permitted))
+BPF_LSM_HOOK(capable,
+	     int,
+	     BPF_LSM_ARGS(const struct cred *cred, struct user_namespace *ns,
+	      int cap, unsigned int opts),
+	     BPF_LSM_ARGS(cred, ns, cap, opts))
+BPF_LSM_HOOK(quotactl,
+	     int,
+	     BPF_LSM_ARGS(int cmds, int type, int id, struct super_block *sb),
+	     BPF_LSM_ARGS(cmds, type, id, sb))
+BPF_LSM_HOOK(quota_on,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry),
+	     BPF_LSM_ARGS(dentry))
+BPF_LSM_HOOK(syslog,
+	     int,
+	     BPF_LSM_ARGS(int type),
+	     BPF_LSM_ARGS(type))
+BPF_LSM_HOOK(settime,
+	     int,
+	     BPF_LSM_ARGS(const struct timespec64 *ts,
+			  const struct timezone *tz),
+	     BPF_LSM_ARGS(ts, tz))
+BPF_LSM_HOOK(vm_enough_memory,
+	     int,
+	     BPF_LSM_ARGS(struct mm_struct *mm, long pages),
+	     BPF_LSM_ARGS(mm, pages))
+BPF_LSM_HOOK(bprm_set_creds,
+	     int,
+	     BPF_LSM_ARGS(struct linux_binprm *bprm),
+	     BPF_LSM_ARGS(bprm))
+BPF_LSM_HOOK(bprm_check_security,
+	     int,
+	     BPF_LSM_ARGS(struct linux_binprm *bprm),
+	     BPF_LSM_ARGS(bprm))
+BPF_LSM_HOOK(bprm_committing_creds,
+	     void,
+	     BPF_LSM_ARGS(struct linux_binprm *bprm),
+	     BPF_LSM_ARGS(bprm))
+BPF_LSM_HOOK(bprm_committed_creds,
+	     void,
+	     BPF_LSM_ARGS(struct linux_binprm *bprm),
+	     BPF_LSM_ARGS(bprm))
+BPF_LSM_HOOK(fs_context_dup,
+	     int,
+	     BPF_LSM_ARGS(struct fs_context *fc, struct fs_context *src_sc),
+	     BPF_LSM_ARGS(fc, src_sc))
+BPF_LSM_HOOK(fs_context_parse_param,
+	     int,
+	     BPF_LSM_ARGS(struct fs_context *fc, struct fs_parameter *param),
+	     BPF_LSM_ARGS(fc, param))
+BPF_LSM_HOOK(sb_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct super_block *sb),
+	     BPF_LSM_ARGS(sb))
+BPF_LSM_HOOK(sb_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct super_block *sb),
+	     BPF_LSM_ARGS(sb))
+BPF_LSM_HOOK(sb_free_mnt_opts,
+	     void,
+	     BPF_LSM_ARGS(void *mnt_opts),
+	     BPF_LSM_ARGS(mnt_opts))
+BPF_LSM_HOOK(sb_eat_lsm_opts,
+	     int,
+	     BPF_LSM_ARGS(char *orig, void **mnt_opts),
+	     BPF_LSM_ARGS(orig, mnt_opts))
+BPF_LSM_HOOK(sb_remount,
+	     int,
+	     BPF_LSM_ARGS(struct super_block *sb, void *mnt_opts),
+	     BPF_LSM_ARGS(sb, mnt_opts))
+BPF_LSM_HOOK(sb_kern_mount,
+	     int,
+	     BPF_LSM_ARGS(struct super_block *sb),
+	     BPF_LSM_ARGS(sb))
+BPF_LSM_HOOK(sb_show_options,
+	     int,
+	     BPF_LSM_ARGS(struct seq_file *m, struct super_block *sb),
+	     BPF_LSM_ARGS(m, sb))
+BPF_LSM_HOOK(sb_statfs,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry),
+	     BPF_LSM_ARGS(dentry))
+BPF_LSM_HOOK(sb_mount,
+	     int,
+	     BPF_LSM_ARGS(const char *dev_name, const struct path *path,
+		      const char *type, unsigned long flags, void *data),
+	     BPF_LSM_ARGS(dev_name, path, type, flags, data))
+BPF_LSM_HOOK(sb_umount,
+	     int,
+	     BPF_LSM_ARGS(struct vfsmount *mnt, int flags),
+	     BPF_LSM_ARGS(mnt, flags))
+BPF_LSM_HOOK(sb_pivotroot,
+	     int,
+	     BPF_LSM_ARGS(const struct path *old_path,
+			  const struct path *new_path),
+	     BPF_LSM_ARGS(old_path, new_path))
+BPF_LSM_HOOK(sb_set_mnt_opts,
+	     int,
+	     BPF_LSM_ARGS(struct super_block *sb, void *mnt_opts,
+		     unsigned long kern_flags, unsigned long *set_kern_flags),
+	     BPF_LSM_ARGS(sb, mnt_opts, kern_flags, set_kern_flags))
+BPF_LSM_HOOK(sb_clone_mnt_opts,
+	     int,
+	     BPF_LSM_ARGS(const struct super_block *oldsb,
+			  struct super_block *newsb, unsigned long kern_flags,
+			  unsigned long *set_kern_flags),
+	     BPF_LSM_ARGS(oldsb, newsb, kern_flags, set_kern_flags))
+BPF_LSM_HOOK(sb_add_mnt_opt,
+	     int,
+	     BPF_LSM_ARGS(const char *option, const char *val, int len,
+		     void **mnt_opts),
+	     BPF_LSM_ARGS(option, val, len, mnt_opts))
+BPF_LSM_HOOK(move_mount,
+	     int,
+	     BPF_LSM_ARGS(const struct path *from_path,
+			  const struct path *to_path),
+	     BPF_LSM_ARGS(from_path, to_path))
+BPF_LSM_HOOK(dentry_init_security,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, int mode,
+			  const struct qstr *name,
+		     void **ctx, u32 *ctxlen),
+	     BPF_LSM_ARGS(dentry, mode, name, ctx, ctxlen))
+BPF_LSM_HOOK(dentry_create_files_as,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, int mode, struct qstr *name,
+		     const struct cred *old, struct cred *new),
+	     BPF_LSM_ARGS(dentry, mode, name, old, new))
+
+#ifdef CONFIG_SECURITY_PATH
+BPF_LSM_HOOK(path_unlink,
+	     int,
+	     BPF_LSM_ARGS(const struct path *dir, struct dentry *dentry),
+	     BPF_LSM_ARGS(dir, dentry))
+BPF_LSM_HOOK(path_mkdir,
+	     int,
+	     BPF_LSM_ARGS(const struct path *dir, struct dentry *dentry,
+		     umode_t mode),
+	     BPF_LSM_ARGS(dir, dentry, mode))
+BPF_LSM_HOOK(path_rmdir,
+	     int,
+	     BPF_LSM_ARGS(const struct path *dir, struct dentry *dentry),
+	     BPF_LSM_ARGS(dir, dentry))
+BPF_LSM_HOOK(path_mknod,
+	     int,
+	     BPF_LSM_ARGS(const struct path *dir, struct dentry *dentry,
+			  umode_t mode,
+		     unsigned int dev),
+	     BPF_LSM_ARGS(dir, dentry, mode, dev))
+BPF_LSM_HOOK(path_truncate,
+	     int,
+	     BPF_LSM_ARGS(const struct path *path),
+	     BPF_LSM_ARGS(path))
+BPF_LSM_HOOK(path_symlink,
+	     int,
+	     BPF_LSM_ARGS(const struct path *dir, struct dentry *dentry,
+		     const char *old_name),
+	     BPF_LSM_ARGS(dir, dentry, old_name))
+BPF_LSM_HOOK(path_link,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *old_dentry, const struct path *new_dir,
+		     struct dentry *new_dentry),
+	     BPF_LSM_ARGS(old_dentry, new_dir, new_dentry))
+BPF_LSM_HOOK(path_rename,
+	     int,
+	     BPF_LSM_ARGS(const struct path *old_dir, struct dentry *old_dentry,
+		     const struct path *new_dir, struct dentry *new_dentry),
+	     BPF_LSM_ARGS(old_dir, old_dentry, new_dir, new_dentry))
+BPF_LSM_HOOK(path_chmod,
+	     int,
+	     BPF_LSM_ARGS(const struct path *path, umode_t mode),
+	     BPF_LSM_ARGS(path, mode))
+BPF_LSM_HOOK(path_chown,
+	     int,
+	     BPF_LSM_ARGS(const struct path *path, kuid_t uid, kgid_t gid),
+	     BPF_LSM_ARGS(path, uid, gid))
+BPF_LSM_HOOK(path_chroot,
+	     int,
+	     BPF_LSM_ARGS(const struct path *path),
+	     BPF_LSM_ARGS(path))
+#endif /* CONFIG_SECURITY_PATH */
+
+BPF_LSM_HOOK(path_notify,
+	     int,
+	     BPF_LSM_ARGS(const struct path *path, u64 mask,
+			  unsigned int obj_type),
+	     BPF_LSM_ARGS(path, mask, obj_type))
+BPF_LSM_HOOK(inode_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode),
+	     BPF_LSM_ARGS(inode))
+BPF_LSM_HOOK(inode_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct inode *inode),
+	     BPF_LSM_ARGS(inode))
+BPF_LSM_HOOK(inode_init_security,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, struct inode *dir,
+		     const struct qstr *qstr, const char **name, void **value,
+		     size_t *len),
+	     BPF_LSM_ARGS(inode, dir, qstr, name, value, len))
+BPF_LSM_HOOK(inode_create,
+	     int,
+	     BPF_LSM_ARGS(struct inode *dir, struct dentry *dentry,
+			  umode_t mode),
+	     BPF_LSM_ARGS(dir, dentry, mode))
+BPF_LSM_HOOK(inode_link,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *new_dentry),
+	     BPF_LSM_ARGS(old_dentry, dir, new_dentry))
+BPF_LSM_HOOK(inode_unlink,
+	     int,
+	     BPF_LSM_ARGS(struct inode *dir, struct dentry *dentry),
+	     BPF_LSM_ARGS(dir, dentry))
+BPF_LSM_HOOK(inode_symlink,
+	     int,
+	     BPF_LSM_ARGS(struct inode *dir, struct dentry *dentry,
+		     const char *old_name),
+	     BPF_LSM_ARGS(dir, dentry, old_name))
+BPF_LSM_HOOK(inode_mkdir,
+	     int,
+	     BPF_LSM_ARGS(struct inode *dir, struct dentry *dentry,
+			  umode_t mode),
+	     BPF_LSM_ARGS(dir, dentry, mode))
+BPF_LSM_HOOK(inode_rmdir,
+	     int,
+	     BPF_LSM_ARGS(struct inode *dir, struct dentry *dentry),
+	     BPF_LSM_ARGS(dir, dentry))
+BPF_LSM_HOOK(inode_mknod,
+	     int,
+	     BPF_LSM_ARGS(struct inode *dir, struct dentry *dentry,
+			  umode_t mode,
+		     dev_t dev),
+	     BPF_LSM_ARGS(dir, dentry, mode, dev))
+BPF_LSM_HOOK(inode_rename,
+	     int,
+	     BPF_LSM_ARGS(struct inode *old_dir, struct dentry *old_dentry,
+		     struct inode *new_dir, struct dentry *new_dentry),
+	     BPF_LSM_ARGS(old_dir, old_dentry, new_dir, new_dentry))
+BPF_LSM_HOOK(inode_readlink,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry),
+	     BPF_LSM_ARGS(dentry))
+BPF_LSM_HOOK(inode_follow_link,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, struct inode *inode, bool rcu),
+	     BPF_LSM_ARGS(dentry, inode, rcu))
+BPF_LSM_HOOK(inode_permission,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, int mask),
+	     BPF_LSM_ARGS(inode, mask))
+BPF_LSM_HOOK(inode_setattr,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, struct iattr *attr),
+	     BPF_LSM_ARGS(dentry, attr))
+BPF_LSM_HOOK(inode_getattr,
+	     int,
+	     BPF_LSM_ARGS(const struct path *path),
+	     BPF_LSM_ARGS(path))
+BPF_LSM_HOOK(inode_setxattr,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, const char *name,
+			  const void *value,
+		     size_t size, int flags),
+	     BPF_LSM_ARGS(dentry, name, value, size, flags))
+BPF_LSM_HOOK(inode_post_setxattr,
+	     void,
+	     BPF_LSM_ARGS(struct dentry *dentry, const char *name,
+			  const void *value,
+		     size_t size, int flags),
+	     BPF_LSM_ARGS(dentry, name, value, size, flags))
+BPF_LSM_HOOK(inode_getxattr,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, const char *name),
+	     BPF_LSM_ARGS(dentry, name))
+BPF_LSM_HOOK(inode_listxattr,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry),
+	     BPF_LSM_ARGS(dentry))
+BPF_LSM_HOOK(inode_removexattr,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, const char *name),
+	     BPF_LSM_ARGS(dentry, name))
+BPF_LSM_HOOK(inode_need_killpriv,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry),
+	     BPF_LSM_ARGS(dentry))
+BPF_LSM_HOOK(inode_killpriv,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry),
+	     BPF_LSM_ARGS(dentry))
+BPF_LSM_HOOK(inode_getsecurity,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, const char *name, void **buffer,
+		     bool alloc),
+	     BPF_LSM_ARGS(inode, name, buffer, alloc))
+BPF_LSM_HOOK(inode_setsecurity,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, const char *name,
+			  const void *value,
+		     size_t size, int flags),
+	     BPF_LSM_ARGS(inode, name, value, size, flags))
+BPF_LSM_HOOK(inode_listsecurity,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, char *buffer,
+			  size_t buffer_size),
+	     BPF_LSM_ARGS(inode, buffer, buffer_size))
+BPF_LSM_HOOK(inode_getsecid,
+	     void,
+	     BPF_LSM_ARGS(struct inode *inode, u32 *secid),
+	     BPF_LSM_ARGS(inode, secid))
+BPF_LSM_HOOK(inode_copy_up,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *src, struct cred **new),
+	     BPF_LSM_ARGS(src, new))
+BPF_LSM_HOOK(inode_copy_up_xattr,
+	     int,
+	     BPF_LSM_ARGS(const char *name),
+	     BPF_LSM_ARGS(name))
+BPF_LSM_HOOK(kernfs_init_security,
+	     int,
+	     BPF_LSM_ARGS(struct kernfs_node *kn_dir, struct kernfs_node *kn),
+	     BPF_LSM_ARGS(kn_dir, kn))
+BPF_LSM_HOOK(file_permission,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, int mask),
+	     BPF_LSM_ARGS(file, mask))
+BPF_LSM_HOOK(file_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct file *file),
+	     BPF_LSM_ARGS(file))
+BPF_LSM_HOOK(file_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct file *file),
+	     BPF_LSM_ARGS(file))
+BPF_LSM_HOOK(file_ioctl,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, unsigned int cmd,
+			  unsigned long arg),
+	     BPF_LSM_ARGS(file, cmd, arg))
+BPF_LSM_HOOK(mmap_addr,
+	     int,
+	     BPF_LSM_ARGS(unsigned long addr),
+	     BPF_LSM_ARGS(addr))
+BPF_LSM_HOOK(mmap_file,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, unsigned long reqprot,
+		     unsigned long prot, unsigned long flags),
+	     BPF_LSM_ARGS(file, reqprot, prot, flags))
+BPF_LSM_HOOK(file_mprotect,
+	     int,
+	     BPF_LSM_ARGS(struct vm_area_struct *vma, unsigned long reqprot,
+		     unsigned long prot),
+	     BPF_LSM_ARGS(vma, reqprot, prot))
+BPF_LSM_HOOK(file_lock,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, unsigned int cmd),
+	     BPF_LSM_ARGS(file, cmd))
+BPF_LSM_HOOK(file_fcntl,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, unsigned int cmd,
+			  unsigned long arg),
+	     BPF_LSM_ARGS(file, cmd, arg))
+BPF_LSM_HOOK(file_set_fowner,
+	     void,
+	     BPF_LSM_ARGS(struct file *file),
+	     BPF_LSM_ARGS(file))
+BPF_LSM_HOOK(file_send_sigiotask,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *tsk, struct fown_struct *fown,
+			  int sig),
+	     BPF_LSM_ARGS(tsk, fown, sig))
+BPF_LSM_HOOK(file_receive,
+	     int,
+	     BPF_LSM_ARGS(struct file *file),
+	     BPF_LSM_ARGS(file))
+BPF_LSM_HOOK(file_open,
+	     int,
+	     BPF_LSM_ARGS(struct file *file),
+	     BPF_LSM_ARGS(file))
+BPF_LSM_HOOK(task_alloc,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *task, unsigned long clone_flags),
+	     BPF_LSM_ARGS(task, clone_flags))
+BPF_LSM_HOOK(task_free,
+	     void,
+	     BPF_LSM_ARGS(struct task_struct *task),
+	     BPF_LSM_ARGS(task))
+BPF_LSM_HOOK(cred_alloc_blank,
+	     int,
+	     BPF_LSM_ARGS(struct cred *cred, gfp_t gfp),
+	     BPF_LSM_ARGS(cred, gfp))
+BPF_LSM_HOOK(cred_free,
+	     void,
+	     BPF_LSM_ARGS(struct cred *cred),
+	     BPF_LSM_ARGS(cred))
+BPF_LSM_HOOK(cred_prepare,
+	     int,
+	     BPF_LSM_ARGS(struct cred *new, const struct cred *old, gfp_t gfp),
+	     BPF_LSM_ARGS(new, old, gfp))
+BPF_LSM_HOOK(cred_transfer,
+	     void,
+	     BPF_LSM_ARGS(struct cred *new, const struct cred *old),
+	     BPF_LSM_ARGS(new, old))
+BPF_LSM_HOOK(cred_getsecid,
+	     void,
+	     BPF_LSM_ARGS(const struct cred *c, u32 *secid),
+	     BPF_LSM_ARGS(c, secid))
+BPF_LSM_HOOK(kernel_act_as,
+	     int,
+	     BPF_LSM_ARGS(struct cred *new, u32 secid),
+	     BPF_LSM_ARGS(new, secid))
+BPF_LSM_HOOK(kernel_create_files_as,
+	     int,
+	     BPF_LSM_ARGS(struct cred *new, struct inode *inode),
+	     BPF_LSM_ARGS(new, inode))
+BPF_LSM_HOOK(kernel_module_request,
+	     int,
+	     BPF_LSM_ARGS(char *kmod_name),
+	     BPF_LSM_ARGS(kmod_name))
+BPF_LSM_HOOK(kernel_load_data,
+	     int,
+	     BPF_LSM_ARGS(enum kernel_load_data_id id),
+	     BPF_LSM_ARGS(id))
+BPF_LSM_HOOK(kernel_read_file,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, enum kernel_read_file_id id),
+	     BPF_LSM_ARGS(file, id))
+BPF_LSM_HOOK(kernel_post_read_file,
+	     int,
+	     BPF_LSM_ARGS(struct file *file, char *buf, loff_t size,
+		     enum kernel_read_file_id id),
+	     BPF_LSM_ARGS(file, buf, size, id))
+BPF_LSM_HOOK(task_fix_setuid,
+	     int,
+	     BPF_LSM_ARGS(struct cred *new, const struct cred *old, int flags),
+	     BPF_LSM_ARGS(new, old, flags))
+BPF_LSM_HOOK(task_setpgid,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p, pid_t pgid),
+	     BPF_LSM_ARGS(p, pgid))
+BPF_LSM_HOOK(task_getpgid,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p),
+	     BPF_LSM_ARGS(p))
+BPF_LSM_HOOK(task_getsid,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p),
+	     BPF_LSM_ARGS(p))
+BPF_LSM_HOOK(task_getsecid,
+	     void,
+	     BPF_LSM_ARGS(struct task_struct *p, u32 *secid),
+	     BPF_LSM_ARGS(p, secid))
+BPF_LSM_HOOK(task_setnice,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p, int nice),
+	     BPF_LSM_ARGS(p, nice))
+BPF_LSM_HOOK(task_setioprio,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p, int ioprio),
+	     BPF_LSM_ARGS(p, ioprio))
+BPF_LSM_HOOK(task_getioprio,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p),
+	     BPF_LSM_ARGS(p))
+BPF_LSM_HOOK(task_prlimit,
+	     int,
+	     BPF_LSM_ARGS(const struct cred *cred, const struct cred *tcred,
+		     unsigned int flags),
+	     BPF_LSM_ARGS(cred, tcred, flags))
+BPF_LSM_HOOK(task_setrlimit,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p, unsigned int resource,
+		     struct rlimit *new_rlim),
+	     BPF_LSM_ARGS(p, resource, new_rlim))
+BPF_LSM_HOOK(task_setscheduler,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p),
+	     BPF_LSM_ARGS(p))
+BPF_LSM_HOOK(task_getscheduler,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p),
+	     BPF_LSM_ARGS(p))
+BPF_LSM_HOOK(task_movememory,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p),
+	     BPF_LSM_ARGS(p))
+BPF_LSM_HOOK(task_kill,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p, struct kernel_siginfo *info,
+			  int sig,
+		     const struct cred *cred),
+	     BPF_LSM_ARGS(p, info, sig, cred))
+BPF_LSM_HOOK(task_prctl,
+	     int,
+	     BPF_LSM_ARGS(int option, unsigned long arg2, unsigned long arg3,
+		     unsigned long arg4, unsigned long arg5),
+	     BPF_LSM_ARGS(option, arg2, arg3, arg4, arg5))
+BPF_LSM_HOOK(task_to_inode,
+	     void,
+	     BPF_LSM_ARGS(struct task_struct *p, struct inode *inode),
+	     BPF_LSM_ARGS(p, inode))
+BPF_LSM_HOOK(ipc_permission,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *ipcp, short flag),
+	     BPF_LSM_ARGS(ipcp, flag))
+BPF_LSM_HOOK(ipc_getsecid,
+	     void,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *ipcp, u32 *secid),
+	     BPF_LSM_ARGS(ipcp, secid))
+BPF_LSM_HOOK(msg_msg_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct msg_msg *msg),
+	     BPF_LSM_ARGS(msg))
+BPF_LSM_HOOK(msg_msg_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct msg_msg *msg),
+	     BPF_LSM_ARGS(msg))
+BPF_LSM_HOOK(msg_queue_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm),
+	     BPF_LSM_ARGS(perm))
+BPF_LSM_HOOK(msg_queue_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm),
+	     BPF_LSM_ARGS(perm))
+BPF_LSM_HOOK(msg_queue_associate,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, int msqflg),
+	     BPF_LSM_ARGS(perm, msqflg))
+BPF_LSM_HOOK(msg_queue_msgctl,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, int cmd),
+	     BPF_LSM_ARGS(perm, cmd))
+BPF_LSM_HOOK(msg_queue_msgsnd,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, struct msg_msg *msg,
+			  int msqflg),
+	     BPF_LSM_ARGS(perm, msg, msqflg))
+BPF_LSM_HOOK(msg_queue_msgrcv,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, struct msg_msg *msg,
+		     struct task_struct *target, long type, int mode),
+	     BPF_LSM_ARGS(perm, msg, target, type, mode))
+BPF_LSM_HOOK(shm_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm),
+	     BPF_LSM_ARGS(perm))
+BPF_LSM_HOOK(shm_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm),
+	     BPF_LSM_ARGS(perm))
+BPF_LSM_HOOK(shm_associate,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, int shmflg),
+	     BPF_LSM_ARGS(perm, shmflg))
+BPF_LSM_HOOK(shm_shmctl,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, int cmd),
+	     BPF_LSM_ARGS(perm, cmd))
+BPF_LSM_HOOK(shm_shmat,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, char __user *shmaddr,
+		     int shmflg),
+	     BPF_LSM_ARGS(perm, shmaddr, shmflg))
+BPF_LSM_HOOK(sem_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm),
+	     BPF_LSM_ARGS(perm))
+BPF_LSM_HOOK(sem_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm),
+	     BPF_LSM_ARGS(perm))
+BPF_LSM_HOOK(sem_associate,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, int semflg),
+	     BPF_LSM_ARGS(perm, semflg))
+BPF_LSM_HOOK(sem_semctl,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, int cmd),
+	     BPF_LSM_ARGS(perm, cmd))
+BPF_LSM_HOOK(sem_semop,
+	     int,
+	     BPF_LSM_ARGS(struct kern_ipc_perm *perm, struct sembuf *sops,
+		     unsigned nsops, int alter),
+	     BPF_LSM_ARGS(perm, sops, nsops, alter))
+BPF_LSM_HOOK(netlink_send,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sk, struct sk_buff *skb),
+	     BPF_LSM_ARGS(sk, skb))
+BPF_LSM_HOOK(d_instantiate,
+	     void,
+	     BPF_LSM_ARGS(struct dentry *dentry, struct inode *inode),
+	     BPF_LSM_ARGS(dentry, inode))
+BPF_LSM_HOOK(getprocattr,
+	     int,
+	     BPF_LSM_ARGS(struct task_struct *p, char *name, char **value),
+	     BPF_LSM_ARGS(p, name, value))
+BPF_LSM_HOOK(setprocattr,
+	     int,
+	     BPF_LSM_ARGS(const char *name, void *value, size_t size),
+	     BPF_LSM_ARGS(name, value, size))
+BPF_LSM_HOOK(ismaclabel,
+	     int,
+	     BPF_LSM_ARGS(const char *name),
+	     BPF_LSM_ARGS(name))
+BPF_LSM_HOOK(secid_to_secctx,
+	     int,
+	     BPF_LSM_ARGS(u32 secid, char **secdata, u32 *seclen),
+	     BPF_LSM_ARGS(secid, secdata, seclen))
+BPF_LSM_HOOK(secctx_to_secid,
+	     int,
+	     BPF_LSM_ARGS(const char *secdata, u32 seclen, u32 *secid),
+	     BPF_LSM_ARGS(secdata, seclen, secid))
+BPF_LSM_HOOK(release_secctx,
+	     void,
+	     BPF_LSM_ARGS(char *secdata, u32 seclen),
+	     BPF_LSM_ARGS(secdata, seclen))
+BPF_LSM_HOOK(inode_invalidate_secctx,
+	     void,
+	     BPF_LSM_ARGS(struct inode *inode),
+	     BPF_LSM_ARGS(inode))
+BPF_LSM_HOOK(inode_notifysecctx,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, void *ctx, u32 ctxlen),
+	     BPF_LSM_ARGS(inode, ctx, ctxlen))
+BPF_LSM_HOOK(inode_setsecctx,
+	     int,
+	     BPF_LSM_ARGS(struct dentry *dentry, void *ctx, u32 ctxlen),
+	     BPF_LSM_ARGS(dentry, ctx, ctxlen))
+BPF_LSM_HOOK(inode_getsecctx,
+	     int,
+	     BPF_LSM_ARGS(struct inode *inode, void **ctx, u32 *ctxlen),
+	     BPF_LSM_ARGS(inode, ctx, ctxlen))
+
+#ifdef CONFIG_SECURITY_NETWORK
+BPF_LSM_HOOK(unix_stream_connect,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sock, struct sock *other,
+			  struct sock *newsk),
+	     BPF_LSM_ARGS(sock, other, newsk))
+BPF_LSM_HOOK(unix_may_send,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct socket *other),
+	     BPF_LSM_ARGS(sock, other))
+BPF_LSM_HOOK(socket_create,
+	     int,
+	     BPF_LSM_ARGS(int family, int type, int protocol, int kern),
+	     BPF_LSM_ARGS(family, type, protocol, kern))
+BPF_LSM_HOOK(socket_post_create,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, int family, int type,
+			  int protocol,
+		     int kern),
+	     BPF_LSM_ARGS(sock, family, type, protocol, kern))
+BPF_LSM_HOOK(socket_socketpair,
+	     int,
+	     BPF_LSM_ARGS(struct socket *socka, struct socket *sockb),
+	     BPF_LSM_ARGS(socka, sockb))
+BPF_LSM_HOOK(socket_bind,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct sockaddr *address,
+			  int addrlen),
+	     BPF_LSM_ARGS(sock, address, addrlen))
+BPF_LSM_HOOK(socket_connect,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct sockaddr *address,
+			  int addrlen),
+	     BPF_LSM_ARGS(sock, address, addrlen))
+BPF_LSM_HOOK(socket_listen,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, int backlog),
+	     BPF_LSM_ARGS(sock, backlog))
+BPF_LSM_HOOK(socket_accept,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct socket *newsock),
+	     BPF_LSM_ARGS(sock, newsock))
+BPF_LSM_HOOK(socket_sendmsg,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct msghdr *msg, int size),
+	     BPF_LSM_ARGS(sock, msg, size))
+BPF_LSM_HOOK(socket_recvmsg,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct msghdr *msg, int size,
+		     int flags),
+	     BPF_LSM_ARGS(sock, msg, size, flags))
+BPF_LSM_HOOK(socket_getsockname,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock),
+	     BPF_LSM_ARGS(sock))
+BPF_LSM_HOOK(socket_getpeername,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock),
+	     BPF_LSM_ARGS(sock))
+BPF_LSM_HOOK(socket_getsockopt,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, int level, int optname),
+	     BPF_LSM_ARGS(sock, level, optname))
+BPF_LSM_HOOK(socket_setsockopt,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, int level, int optname),
+	     BPF_LSM_ARGS(sock, level, optname))
+BPF_LSM_HOOK(socket_shutdown,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, int how),
+	     BPF_LSM_ARGS(sock, how))
+BPF_LSM_HOOK(socket_sock_rcv_skb,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sk, struct sk_buff *skb),
+	     BPF_LSM_ARGS(sk, skb))
+BPF_LSM_HOOK(socket_getpeersec_stream,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, char __user *optval,
+		     int __user *optlen, unsigned len),
+	     BPF_LSM_ARGS(sock, optval, optlen, len))
+BPF_LSM_HOOK(socket_getpeersec_dgram,
+	     int,
+	     BPF_LSM_ARGS(struct socket *sock, struct sk_buff *skb, u32 *secid),
+	     BPF_LSM_ARGS(sock, skb, secid))
+BPF_LSM_HOOK(sk_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sk, int family, gfp_t priority),
+	     BPF_LSM_ARGS(sk, family, priority))
+BPF_LSM_HOOK(sk_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct sock *sk),
+	     BPF_LSM_ARGS(sk))
+BPF_LSM_HOOK(sk_clone_security,
+	     void,
+	     BPF_LSM_ARGS(const struct sock *sk, struct sock *newsk),
+	     BPF_LSM_ARGS(sk, newsk))
+BPF_LSM_HOOK(sk_getsecid,
+	     void,
+	     BPF_LSM_ARGS(struct sock *sk, u32 *secid),
+	     BPF_LSM_ARGS(sk, secid))
+BPF_LSM_HOOK(sock_graft,
+	     void,
+	     BPF_LSM_ARGS(struct sock *sk, struct socket *parent),
+	     BPF_LSM_ARGS(sk, parent))
+BPF_LSM_HOOK(inet_conn_request,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sk, struct sk_buff *skb,
+		     struct request_sock *req),
+	     BPF_LSM_ARGS(sk, skb, req))
+BPF_LSM_HOOK(inet_csk_clone,
+	     void,
+	     BPF_LSM_ARGS(struct sock *newsk, const struct request_sock *req),
+	     BPF_LSM_ARGS(newsk, req))
+BPF_LSM_HOOK(inet_conn_established,
+	     void,
+	     BPF_LSM_ARGS(struct sock *sk, struct sk_buff *skb),
+	     BPF_LSM_ARGS(sk, skb))
+BPF_LSM_HOOK(secmark_relabel_packet,
+	     int,
+	     BPF_LSM_ARGS(u32 secid),
+	     BPF_LSM_ARGS(secid))
+BPF_LSM_HOOK(secmark_refcount_inc,
+	     void,
+	     BPF_LSM_ARGS(void),
+	     BPF_LSM_ARGS())
+BPF_LSM_HOOK(secmark_refcount_dec,
+	     void,
+	     BPF_LSM_ARGS(void),
+	     BPF_LSM_ARGS())
+BPF_LSM_HOOK(req_classify_flow,
+	     void,
+	     BPF_LSM_ARGS(const struct request_sock *req, struct flowi *fl),
+	     BPF_LSM_ARGS(req, fl))
+BPF_LSM_HOOK(tun_dev_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(void **security),
+	     BPF_LSM_ARGS(security))
+BPF_LSM_HOOK(tun_dev_free_security,
+	     void,
+	     BPF_LSM_ARGS(void *security),
+	     BPF_LSM_ARGS(security))
+BPF_LSM_HOOK(tun_dev_create,
+	     int,
+	     BPF_LSM_ARGS(void),
+	     BPF_LSM_ARGS())
+BPF_LSM_HOOK(tun_dev_attach_queue,
+	     int,
+	     BPF_LSM_ARGS(void *security),
+	     BPF_LSM_ARGS(security))
+BPF_LSM_HOOK(tun_dev_attach,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sk, void *security),
+	     BPF_LSM_ARGS(sk, security))
+BPF_LSM_HOOK(tun_dev_open,
+	     int,
+	     BPF_LSM_ARGS(void *security),
+	     BPF_LSM_ARGS(security))
+BPF_LSM_HOOK(sctp_assoc_request,
+	     int,
+	     BPF_LSM_ARGS(struct sctp_endpoint *ep, struct sk_buff *skb),
+	     BPF_LSM_ARGS(ep, skb))
+BPF_LSM_HOOK(sctp_bind_connect,
+	     int,
+	     BPF_LSM_ARGS(struct sock *sk, int optname,
+			  struct sockaddr *address,
+		     int addrlen),
+	     BPF_LSM_ARGS(sk, optname, address, addrlen))
+BPF_LSM_HOOK(sctp_sk_clone,
+	     void,
+	     BPF_LSM_ARGS(struct sctp_endpoint *ep, struct sock *sk,
+			  struct sock *newsk),
+	     BPF_LSM_ARGS(ep, sk, newsk))
+#endif	/* CONFIG_SECURITY_NETWORK */
+
+#ifdef CONFIG_SECURITY_INFINIBAND
+BPF_LSM_HOOK(ib_pkey_access,
+	     int,
+	     BPF_LSM_ARGS(void *sec, u64 subnet_prefix, u16 pkey),
+	     BPF_LSM_ARGS(sec, subnet_prefix, pkey))
+BPF_LSM_HOOK(ib_endport_manage_subnet,
+	     int,
+	     BPF_LSM_ARGS(void *sec, const char *dev_name, u8 port_num),
+	     BPF_LSM_ARGS(sec, dev_name, port_num))
+BPF_LSM_HOOK(ib_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(void **sec),
+	     BPF_LSM_ARGS(sec))
+BPF_LSM_HOOK(ib_free_security,
+	     void,
+	     BPF_LSM_ARGS(void *sec),
+	     BPF_LSM_ARGS(sec))
+#endif	/* CONFIG_SECURITY_INFINIBAND */
+
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+BPF_LSM_HOOK(xfrm_policy_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_sec_ctx **ctxp,
+		     struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp),
+	     BPF_LSM_ARGS(ctxp, sec_ctx, gfp))
+BPF_LSM_HOOK(xfrm_policy_clone_security,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_sec_ctx *old_ctx,
+			  struct xfrm_sec_ctx **new_ctx),
+	     BPF_LSM_ARGS(old_ctx, new_ctx))
+BPF_LSM_HOOK(xfrm_policy_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct xfrm_sec_ctx *ctx),
+	     BPF_LSM_ARGS(ctx))
+BPF_LSM_HOOK(xfrm_policy_delete_security,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_sec_ctx *ctx),
+	     BPF_LSM_ARGS(ctx))
+BPF_LSM_HOOK(xfrm_state_alloc,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_state *x,
+			  struct xfrm_user_sec_ctx *sec_ctx),
+	     BPF_LSM_ARGS(x, sec_ctx))
+BPF_LSM_HOOK(xfrm_state_alloc_acquire,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_state *x, struct xfrm_sec_ctx *polsec,
+		     u32 secid),
+	     BPF_LSM_ARGS(x, polsec, secid))
+BPF_LSM_HOOK(xfrm_state_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct xfrm_state *x),
+	     BPF_LSM_ARGS(x))
+BPF_LSM_HOOK(xfrm_state_delete_security,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_state *x),
+	     BPF_LSM_ARGS(x))
+BPF_LSM_HOOK(xfrm_policy_lookup,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir),
+	     BPF_LSM_ARGS(ctx, fl_secid, dir))
+BPF_LSM_HOOK(xfrm_state_pol_flow_match,
+	     int,
+	     BPF_LSM_ARGS(struct xfrm_state *x, struct xfrm_policy *xp,
+		     const struct flowi *fl),
+	     BPF_LSM_ARGS(x, xp, fl))
+BPF_LSM_HOOK(xfrm_decode_session,
+	     int,
+	     BPF_LSM_ARGS(struct sk_buff *skb, u32 *secid, int ckall),
+	     BPF_LSM_ARGS(skb, secid, ckall))
+#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
+
+#ifdef CONFIG_KEYS
+BPF_LSM_HOOK(key_alloc,
+	     int,
+	     BPF_LSM_ARGS(struct key *key, const struct cred *cred,
+		     unsigned long flags),
+	     BPF_LSM_ARGS(key, cred, flags))
+BPF_LSM_HOOK(key_free,
+	     void,
+	     BPF_LSM_ARGS(struct key *key),
+	     BPF_LSM_ARGS(key))
+BPF_LSM_HOOK(key_permission,
+	     int,
+	     BPF_LSM_ARGS(key_ref_t key_ref, const struct cred *cred,
+			  unsigned perm),
+	     BPF_LSM_ARGS(key_ref, cred, perm))
+BPF_LSM_HOOK(key_getsecurity,
+	     int,
+	     BPF_LSM_ARGS(struct key *key, char **_buffer),
+	     BPF_LSM_ARGS(key, _buffer))
+#endif	/* CONFIG_KEYS */
+
+#ifdef CONFIG_AUDIT
+BPF_LSM_HOOK(audit_rule_init,
+	     int,
+	     BPF_LSM_ARGS(u32 field, u32 op, char *rulestr, void **lsmrule),
+	     BPF_LSM_ARGS(field, op, rulestr, lsmrule))
+BPF_LSM_HOOK(audit_rule_known,
+	     int,
+	     BPF_LSM_ARGS(struct audit_krule *krule),
+	     BPF_LSM_ARGS(krule))
+BPF_LSM_HOOK(audit_rule_match,
+	     int,
+	     BPF_LSM_ARGS(u32 secid, u32 field, u32 op, void *lsmrule),
+	     BPF_LSM_ARGS(secid, field, op, lsmrule))
+BPF_LSM_HOOK(audit_rule_free,
+	     void,
+	     BPF_LSM_ARGS(void *lsmrule),
+	     BPF_LSM_ARGS(lsmrule))
+#endif /* CONFIG_AUDIT */
+
+#ifdef CONFIG_BPF_SYSCALL
+BPF_LSM_HOOK(bpf,
+	     int,
+	     BPF_LSM_ARGS(int cmd, union bpf_attr *attr, unsigned int size),
+	     BPF_LSM_ARGS(cmd, attr, size))
+BPF_LSM_HOOK(bpf_map,
+	     int,
+	     BPF_LSM_ARGS(struct bpf_map *map, fmode_t fmode),
+	     BPF_LSM_ARGS(map, fmode))
+BPF_LSM_HOOK(bpf_prog,
+	     int,
+	     BPF_LSM_ARGS(struct bpf_prog *prog),
+	     BPF_LSM_ARGS(prog))
+BPF_LSM_HOOK(bpf_map_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct bpf_map *map),
+	     BPF_LSM_ARGS(map))
+BPF_LSM_HOOK(bpf_map_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct bpf_map *map),
+	     BPF_LSM_ARGS(map))
+BPF_LSM_HOOK(bpf_prog_alloc_security,
+	     int,
+	     BPF_LSM_ARGS(struct bpf_prog_aux *aux),
+	     BPF_LSM_ARGS(aux))
+BPF_LSM_HOOK(bpf_prog_free_security,
+	     void,
+	     BPF_LSM_ARGS(struct bpf_prog_aux *aux),
+	     BPF_LSM_ARGS(aux))
+#endif /* CONFIG_BPF_SYSCALL */
+
+BPF_LSM_HOOK(locked_down,
+	     int,
+	     BPF_LSM_ARGS(enum lockdown_reason what),
+	     BPF_LSM_ARGS(what))
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
index fe5c65bbdd45..8586ddfe8cda 100644
--- a/security/bpf/lsm.c
+++ b/security/bpf/lsm.c
@@ -5,14 +5,146 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
 
-static int process_execution(struct linux_binprm *bprm)
+#include "bpf_lsm.h"
+
+/*
+ * Run the eBPF programs of the hook indexed by the type t with the arguments
+ * packed into an array of u64 integers as the context.
+ */
+static inline int __run_progs(enum lsm_hook_type t, u64 *args)
 {
-	return 0;
+	struct bpf_lsm_hook *h = &bpf_lsm_hooks_list[t];
+	struct bpf_prog_array_item *item;
+	struct bpf_prog_array *array;
+	int ret, retval = 0;
+
+	/*
+	 * Some hooks might get called before the securityFS is initialized,
+	 * this will result in a NULL pointer exception.
+	 */
+	if (!bpf_lsm_fs_initialized)
+		return 0;
+
+	preempt_disable();
+	rcu_read_lock();
+
+	array = rcu_dereference(h->progs);
+	if (!array)
+		goto out;
+
+	for (item = array->items; item->prog; item++) {
+		ret = BPF_PROG_RUN(item->prog, args);
+		if (ret < 0) {
+			retval = ret;
+			break;
+		}
+	}
+out:
+	rcu_read_unlock();
+	preempt_enable();
+	return IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? retval : 0;
+}
+
+/*
+ * This macro creates a bpf_lsm_run_progs_<x> function which accepts a known
+ * number of arguments and packs them into an array of u64 integers. The array
+ * is used as a context to run the BPF programs attached to the hook.
+ */
+#define DEFINE_LSM_RUN_PROGS_x(x)					\
+	static int bpf_lsm_run_progs##x(enum lsm_hook_type t,		\
+				 REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
+	{								\
+		u64 args[x];						\
+		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
+		return __run_progs(t, args);				\
+	}
+
+/*
+ * There are some hooks that have no arguments, so there's nothing to pack and
+ * the attached BPF programs get a NULL context.
+ */
+int bpf_lsm_run_progs0(enum lsm_hook_type t, u64 args)
+{
+	return __run_progs(t, NULL);
+}
+
+/*
+ * The largest number of args accepted by an LSM hook is currently 6. Define
+ * bpf_lsm_run_progs_1 to bpf_lsm_run_progs_6.
+ */
+DEFINE_LSM_RUN_PROGS_x(1);
+DEFINE_LSM_RUN_PROGS_x(2);
+DEFINE_LSM_RUN_PROGS_x(3);
+DEFINE_LSM_RUN_PROGS_x(4);
+DEFINE_LSM_RUN_PROGS_x(5);
+DEFINE_LSM_RUN_PROGS_x(6);
+
+/*
+ * This macro calls one of the bpf_lsm_args_<x> functions based on the number of
+ * arguments of the variadic macro. Each argument is casted to a u64 bit integer
+ * as expected by BTF.
+ */
+#define LSM_RUN_PROGS(T, args...) \
+	CONCATENATE(bpf_lsm_run_progs, COUNT_ARGS(args))(T, CAST_TO_U64(args))
+
+/*
+ * The hooks can have an int or void return type, these macros allow having a
+ * single implementation of DEFINE_LSM_HOOK irrespective of the return type.
+ */
+#define LSM_HOOK_RET(ret, x) LSM_HOOK_RET_##ret(x)
+#define LSM_HOOK_RET_int(x) x
+#define LSM_HOOK_RET_void(x)
+
+/*
+ * This macro defines the body of a LSM hook which runs the eBPF programs that
+ * are attached to the hook and returns the error code from the eBPF programs if
+ * the return type of the hook is int.
+ */
+#define DEFINE_LSM_HOOK(hook, ret, proto, args)				\
+typedef ret (*lsm_btf_##hook)(proto);					\
+static ret bpf_lsm_##hook(proto)					\
+{									\
+	return LSM_HOOK_RET(ret, LSM_RUN_PROGS(hook##_type, args));	\
 }
 
+/*
+ * Define the body of each of the LSM hooks defined in hooks.h.
+ */
+#define BPF_LSM_HOOK(hook, ret, args, proto) \
+	DEFINE_LSM_HOOK(hook, ret, BPF_LSM_ARGS(args), BPF_LSM_ARGS(proto))
+#include "hooks.h"
+#undef BPF_LSM_HOOK
+#undef DEFINE_LSM_HOOK
+
+/*
+ * Initialize the bpf_lsm_hooks_list for each of the hooks defined in hooks.h.
+ * The list contains information for each of the hook and can be indexed by the
+ * its type to initialize security FS, attach, detach and execute eBPF programs
+ * for the hook.
+ */
+struct bpf_lsm_hook bpf_lsm_hooks_list[] = {
+	#define BPF_LSM_HOOK(h, ...)					\
+		[h##_type] = {						\
+			.h_type = h##_type,				\
+			.mutex = __MUTEX_INITIALIZER(			\
+				bpf_lsm_hooks_list[h##_type].mutex),	\
+			.name = #h,					\
+			.btf_hook_func =				\
+				(void *)(lsm_btf_##h)(bpf_lsm_##h),	\
+		},
+	#include "hooks.h"
+	#undef BPF_LSM_HOOK
+};
+
+/*
+ * Initialize the bpf_lsm_hooks_list for each of the hooks defined in hooks.h.
+ */
 static struct security_hook_list lsm_hooks[] __lsm_ro_after_init = {
-	LSM_HOOK_INIT(bprm_check_security, process_execution),
+	#define BPF_LSM_HOOK(h, ...) LSM_HOOK_INIT(h, bpf_lsm_##h),
+	#include "hooks.h"
+	#undef BPF_LSM_HOOK
 };
 
 static int __init lsm_init(void)
diff --git a/security/bpf/lsm_fs.c b/security/bpf/lsm_fs.c
new file mode 100644
index 000000000000..49165394ef7d
--- /dev/null
+++ b/security/bpf/lsm_fs.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/security.h>
+#include <linux/bpf_lsm.h>
+
+#include "fs.h"
+#include "bpf_lsm.h"
+
+static struct dentry *bpf_lsm_dir;
+
+static const struct file_operations hook_ops = {};
+
+int bpf_lsm_fs_initialized;
+
+bool is_bpf_lsm_hook_file(struct file *f)
+{
+	return f->f_op == &hook_ops;
+}
+
+static void __init free_hook(struct bpf_lsm_hook *h)
+{
+	securityfs_remove(h->h_dentry);
+	h->h_dentry = NULL;
+}
+
+static int __init init_hook(struct bpf_lsm_hook *h, struct dentry *parent)
+{
+	struct dentry *h_dentry;
+
+	h_dentry = securityfs_create_file(h->name, 0600, parent,
+			NULL, &hook_ops);
+	if (IS_ERR(h_dentry))
+		return PTR_ERR(h_dentry);
+
+	h_dentry->d_fsdata = h;
+	h->h_dentry = h_dentry;
+	return 0;
+}
+
+static int __init bpf_lsm_fs_init(void)
+{
+	struct bpf_lsm_hook *hook;
+	int ret;
+
+	bpf_lsm_dir = securityfs_create_dir(BPF_LSM_SFS_NAME, NULL);
+	if (IS_ERR(bpf_lsm_dir)) {
+		ret = PTR_ERR(bpf_lsm_dir);
+		pr_err("BPF LSM: Unable to create sysfs dir: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * If there is an error in initializing a hook, the initialization
+	 * logic makes sure that it has been freed, but this means that
+	 * cleanup should be called for all the other hooks. The cleanup
+	 * logic handles uninitialized data.
+	 */
+	lsm_for_each_hook(hook) {
+		ret = init_hook(hook, bpf_lsm_dir);
+		if (ret < 0)
+			goto error;
+	}
+
+	bpf_lsm_fs_initialized = 1;
+	return 0;
+error:
+	lsm_for_each_hook(hook)
+		free_hook(hook);
+	securityfs_remove(bpf_lsm_dir);
+	return ret;
+}
+
+late_initcall(bpf_lsm_fs_init);
-- 
2.20.1

