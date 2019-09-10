Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76525AE9B0
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfIJL4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 07:56:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45273 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbfIJL4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l16so19551078wrv.12
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khTLae9RCwkUqy9+7uO8vTkotEuqqfm01bDE7aGuRNw=;
        b=PnzCgXjNvnuPNnTWHRjmLY/R+M3PqGR3Yjz+BOo6oYQ/vgpY2KdtwLmOY34jos2X0H
         X3rOTwaix0gt/O6HYjtB2s8QAbKS5Tpe2mzz7c305PYW4/zqsnVcjd1V6fP+pL3S0Yri
         w/9zPw+SNOhM23ea/k4eAC3E1R2AUiDZNF0r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khTLae9RCwkUqy9+7uO8vTkotEuqqfm01bDE7aGuRNw=;
        b=Dzym25SuisUmTGmBL5+Qo7EXxieZUj39uEHO+1HVxBpMOmlbO/gsWDCLj0VvvsRqmK
         FrhsOkbyanGNLahXxglpFQIHbf7z5LcQU2RAXvxi4pIbDWaFEVce7IGC2adKxNTRGen2
         +ZyFwUuNEp9A3WoD//SKKZi6vO4LLUGnIwIUyuyoZs+EQhHChrZdSG1UcUeCgEgR9E6S
         wuDZ+Myxe75S7Nhbmeu5hKlrHlC3lDXuqT7AAHolZO6g/CttFawypypQEbevFRWvIAlg
         LpcQT8oaSaH+0I4xy0Zbzzk3cP7kc/4hjr1yI+VbcE8gK15RimTtTGtJlwprZU8ddo6E
         WnXw==
X-Gm-Message-State: APjAAAXs0V0DWRVYV5ocebnHLrDMvKU5ZKeKLDFew4xG2RqxK/FyoGby
        D3zAbNPHOanSiaSANTdDh9ArSQ==
X-Google-Smtp-Source: APXvYqxOn37aSDhqXLhP48ScKpNZDRSV1bh9pheAfKkJ1p3R44n3jR0uNlENRSQPjhBnLLFHHeyaFA==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr22300305wrn.47.1568116592680;
        Tue, 10 Sep 2019 04:56:32 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:32 -0700 (PDT)
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
Subject: [RFC v1 06/14] krsi: Implement eBPF operations, attachment and execution
Date:   Tue, 10 Sep 2019 13:55:19 +0200
Message-Id: <20190910115527.5235-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

A user space program can attach an eBPF program by:

  hook_fd = open("/sys/kernel/security/krsi/process_execution", O_RDWR)
  prog_fd = bpf(BPF_PROG_LOAD, ...)
  bpf(BPF_PROG_ATTACH, hook_fd, prog_fd)

When such an attach call is received, the attachment logic looks up the
dentry and appends the program to the bpf_prog_array.

The BPF programs are stored in a bpf_prog_array and writes to the array
are guarded by a mutex. The eBPF programs are executed as a part of the
LSM hook they are attached to. If any of the eBPF programs return
an error (-ENOPERM) the action represented by the hook is denied.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/krsi.h              |  18 ++++++
 kernel/bpf/syscall.c              |   3 +-
 security/krsi/include/krsi_init.h |  51 +++++++++++++++
 security/krsi/krsi.c              |  13 +++-
 security/krsi/krsi_fs.c           |  28 ++++++++
 security/krsi/ops.c               | 102 ++++++++++++++++++++++++++++++
 6 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/krsi.h

diff --git a/include/linux/krsi.h b/include/linux/krsi.h
new file mode 100644
index 000000000000..c7d1790d0c1f
--- /dev/null
+++ b/include/linux/krsi.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KRSI_H
+#define _KRSI_H
+
+#include <linux/bpf.h>
+
+#ifdef CONFIG_SECURITY_KRSI
+int krsi_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+#else
+static inline int krsi_prog_attach(const union bpf_attr *attr,
+				   struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_SECURITY_KRSI */
+
+#endif /* _KRSI_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f38a539f7e67..ab063ed84258 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
+#include <linux/krsi.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
@@ -1950,7 +1951,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 		ret = lirc_prog_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_KRSI:
-		ret = -EINVAL;
+		ret = krsi_prog_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
diff --git a/security/krsi/include/krsi_init.h b/security/krsi/include/krsi_init.h
index 68755182a031..4e17ecacd4ed 100644
--- a/security/krsi/include/krsi_init.h
+++ b/security/krsi/include/krsi_init.h
@@ -5,12 +5,29 @@
 
 #include "krsi_fs.h"
 
+#include <linux/binfmts.h>
+
 enum krsi_hook_type {
 	PROCESS_EXECUTION,
 	__MAX_KRSI_HOOK_TYPE, /* delimiter */
 };
 
 extern int krsi_fs_initialized;
+
+struct krsi_bprm_ctx {
+	struct linux_binprm *bprm;
+};
+
+/*
+ * krsi_ctx is the context that is passed to all KRSI eBPF
+ * programs.
+ */
+struct krsi_ctx {
+	union {
+		struct krsi_bprm_ctx bprm_ctx;
+	};
+};
+
 /*
  * The LSM creates one file per hook.
  *
@@ -33,10 +50,44 @@ struct krsi_hook {
 	 * The dentry of the file created in securityfs.
 	 */
 	struct dentry *h_dentry;
+	/*
+	 * The mutex must be held when updating the progs attached to the hook.
+	 */
+	struct mutex mutex;
+	/*
+	 * The eBPF programs that are attached to this hook.
+	 */
+	struct bpf_prog_array __rcu	*progs;
 };
 
 extern struct krsi_hook krsi_hooks_list[];
 
+static inline int krsi_run_progs(enum krsi_hook_type t, struct krsi_ctx *ctx)
+{
+	struct bpf_prog_array_item *item;
+	struct bpf_prog *prog;
+	struct krsi_hook *h = &krsi_hooks_list[t];
+	int ret, retval = 0;
+
+	preempt_disable();
+	rcu_read_lock();
+
+	item = rcu_dereference(h->progs)->items;
+	while ((prog = READ_ONCE(item->prog))) {
+		ret = BPF_PROG_RUN(prog, ctx);
+		if (ret < 0) {
+			retval = ret;
+			goto out;
+		}
+		item++;
+	}
+
+out:
+	rcu_read_unlock();
+	preempt_enable();
+	return IS_ENABLED(CONFIG_SECURITY_KRSI_ENFORCE) ? retval : 0;
+}
+
 #define krsi_for_each_hook(hook) \
 	for ((hook) = &krsi_hooks_list[0]; \
 	     (hook) < &krsi_hooks_list[__MAX_KRSI_HOOK_TYPE]; \
diff --git a/security/krsi/krsi.c b/security/krsi/krsi.c
index 77d7e2f91172..d3a4a361c192 100644
--- a/security/krsi/krsi.c
+++ b/security/krsi/krsi.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/lsm_hooks.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/binfmts.h>
 
 #include "krsi_init.h"
 
@@ -16,7 +19,15 @@ struct krsi_hook krsi_hooks_list[] = {
 
 static int krsi_process_execution(struct linux_binprm *bprm)
 {
-	return 0;
+	int ret;
+	struct krsi_ctx ctx;
+
+	ctx.bprm_ctx = (struct krsi_bprm_ctx) {
+		.bprm = bprm,
+	};
+
+	ret = krsi_run_progs(PROCESS_EXECUTION, &ctx);
+	return ret;
 }
 
 static struct security_hook_list krsi_hooks[] __lsm_ro_after_init = {
diff --git a/security/krsi/krsi_fs.c b/security/krsi/krsi_fs.c
index 604f826cee5c..3ba18b52ce85 100644
--- a/security/krsi/krsi_fs.c
+++ b/security/krsi/krsi_fs.c
@@ -5,6 +5,8 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/types.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
 #include <linux/security.h>
 
 #include "krsi_fs.h"
@@ -27,12 +29,29 @@ bool is_krsi_hook_file(struct file *f)
 
 static void __init krsi_free_hook(struct krsi_hook *h)
 {
+	struct bpf_prog_array_item *item;
+	/*
+	 * This function is __init so we are guarranteed that there will be
+	 * no concurrent access.
+	 */
+	struct bpf_prog_array *progs = rcu_dereference_raw(h->progs);
+
+	if (progs) {
+		item = progs->items;
+		while (item->prog) {
+			bpf_prog_put(item->prog);
+			item++;
+		}
+		bpf_prog_array_free(progs);
+	}
+
 	securityfs_remove(h->h_dentry);
 	h->h_dentry = NULL;
 }
 
 static int __init krsi_init_hook(struct krsi_hook *h, struct dentry *parent)
 {
+	struct bpf_prog_array __rcu     *progs;
 	struct dentry *h_dentry;
 	int ret;
 
@@ -41,6 +60,15 @@ static int __init krsi_init_hook(struct krsi_hook *h, struct dentry *parent)
 
 	if (IS_ERR(h_dentry))
 		return PTR_ERR(h_dentry);
+
+	mutex_init(&h->mutex);
+	progs = bpf_prog_array_alloc(0, GFP_KERNEL);
+	if (!progs) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	RCU_INIT_POINTER(h->progs, progs);
 	h_dentry->d_fsdata = h;
 	h->h_dentry = h_dentry;
 	return 0;
diff --git a/security/krsi/ops.c b/security/krsi/ops.c
index f2de3bd9621e..cf4d06189aa1 100644
--- a/security/krsi/ops.c
+++ b/security/krsi/ops.c
@@ -1,10 +1,112 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/err.h>
+#include <linux/types.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/security.h>
+#include <linux/krsi.h>
+
+#include "krsi_init.h"
+#include "krsi_fs.h"
+
+extern struct krsi_hook krsi_hooks_list[];
+
+static struct krsi_hook *get_hook_from_fd(int fd)
+{
+	struct fd f = fdget(fd);
+	struct krsi_hook *h;
+	int ret;
+
+	if (!f.file) {
+		ret = -EBADF;
+		goto error;
+	}
+
+	if (!is_krsi_hook_file(f.file)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/*
+	 * The securityfs dentry never disappears, so we don't need to take a
+	 * reference to it.
+	 */
+	h = file_dentry(f.file)->d_fsdata;
+	if (WARN_ON(!h)) {
+		ret = -EINVAL;
+		goto error;
+	}
+	fdput(f);
+	return h;
+
+error:
+	fdput(f);
+	return ERR_PTR(ret);
+}
+
+int krsi_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_prog_array *old_array;
+	struct bpf_prog_array *new_array;
+	struct krsi_hook *h;
+	int ret = 0;
+
+	h = get_hook_from_fd(attr->target_fd);
+	if (IS_ERR(h))
+		return PTR_ERR(h);
+
+	mutex_lock(&h->mutex);
+	old_array = rcu_dereference_protected(h->progs,
+					      lockdep_is_held(&h->mutex));
+
+	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	rcu_assign_pointer(h->progs, new_array);
+	bpf_prog_array_free(old_array);
+
+unlock:
+	mutex_unlock(&h->mutex);
+	return ret;
+}
 
 const struct bpf_prog_ops krsi_prog_ops = {
 };
 
+static bool krsi_prog_is_valid_access(int off, int size,
+				      enum bpf_access_type type,
+				      const struct bpf_prog *prog,
+				      struct bpf_insn_access_aux *info)
+{
+	/*
+	 * KRSI is conservative about any direct access in eBPF to
+	 * prevent the users from depending on the internals of the kernel and
+	 * aims at providing a rich eco-system of safe eBPF helpers as an API
+	 * for accessing relevant information from the context.
+	 */
+	return false;
+}
+
+static const struct bpf_func_proto *krsi_prog_func_proto(enum bpf_func_id
+							 func_id,
+							 const struct bpf_prog
+							 *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_map_lookup_elem:
+		return &bpf_map_lookup_elem_proto;
+	case BPF_FUNC_get_current_pid_tgid:
+		return &bpf_get_current_pid_tgid_proto;
+	default:
+		return NULL;
+	}
+}
+
 const struct bpf_verifier_ops krsi_verifier_ops = {
+	.get_func_proto = krsi_prog_func_proto,
+	.is_valid_access = krsi_prog_is_valid_access,
 };
-- 
2.20.1

