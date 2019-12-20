Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10E5127FA6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLTPmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfLTPmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so9886752wrq.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26xnb3yuodzvJ1GOX80TL/NTUMzeN/hcWJWSUPgYjvU=;
        b=ILIcn9J79FlT8818+aNbXNhk50sYcbV+kGDqSyLUn+qVfFlVVl4PbEomsmB8G+mSOJ
         7HVcdPU/TXhyZcHGoOX6W2RZ4hja6cYG9ROG263qp7cyp1k9AYr73jLeSyWEASdUXLPy
         iTZH4ChZT//wxRl1PTQHmS8vt7ZfFK3rRalgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26xnb3yuodzvJ1GOX80TL/NTUMzeN/hcWJWSUPgYjvU=;
        b=tqNZHopVM3EbHgwVuWdVhSNPMGq4NrQyaWezU4sAe4BQK+gr5CN9I1jG0WrR2Mquvf
         bgB4d6dnZtf8Mj2QcFMtx5NA1xQGbEhNhXtw4z8zh7KjZQCYATYykCSobASzYR6C85Ul
         pIe55TxsOC3VDP3FMhyFcuwnonEETU4hB11/iINIp6oLyLQORR/oozFJ5xgducGGdUQm
         +VxiAI4ghESdcFi5DvXiqLQhwH9vI57OGgXfmCM0zPe8hy9GXZT17Ke+nstlBqqrVsft
         lpWGAgreKuJDEJMPyIX5zDNJa4GL/c7WPVVYkM6IGE2hhzgPcrp2SfP8cuL+b7d4Gw5y
         4dnQ==
X-Gm-Message-State: APjAAAUY7Av1Dep1Qu1I8aZdVE+T1sd25C9vHoixBqsJTQD/NUyZIV6z
        uzdi4jlTsWnJlh7lW9ZavixOFQ==
X-Google-Smtp-Source: APXvYqx0SCWAGTWBEvQnNAPV9/Z+sh+xziw7OolJOaozCJhZq+TwINckqp4msLHVrwe7MrC50G83Uw==
X-Received: by 2002:adf:de84:: with SMTP id w4mr15240542wrl.97.1576856532603;
        Fri, 20 Dec 2019 07:42:12 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:11 -0800 (PST)
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
Subject: [PATCH bpf-next v1 07/13] bpf: lsm: Implement attach, detach and execution.
Date:   Fri, 20 Dec 2019 16:42:02 +0100
Message-Id: <20191220154208.15895-8-kpsingh@chromium.org>
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

A user space program can attach an eBPF program by:

  hook_fd = open("/sys/kernel/security/bpf/bprm_check_security",
		 O_RDWR|O_CLOEXEC)
  prog_fd = bpf(BPF_PROG_LOAD, ...)
  bpf(BPF_PROG_ATTACH, hook_fd, prog_fd)

The following permissions are required to attach a program to a hook:

- CAP_SYS_ADMIN to load eBPF programs
- CAP_MAC_ADMIN (to update the policy of an LSM)
- The securityfs file being a valid hook and writable (O_RDWR)

When such an attach call is received, the attachment logic looks up the
dentry and appends the program to the bpf_prog_array.

The BPF programs are stored in a bpf_prog_array and writes to the array
are guarded by a mutex. The eBPF programs are executed as a part of the
LSM hook they are attached to. If any of the eBPF programs return
an error (-ENOPERM) the action represented by the hook is denied.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS             |   1 +
 include/linux/bpf_lsm.h |  13 ++++
 kernel/bpf/syscall.c    |   5 +-
 security/bpf/lsm_fs.c   |  19 +++++-
 security/bpf/ops.c      | 134 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b82d8ff21fb..681ae39bb2f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3181,6 +3181,7 @@ L:	linux-security-module@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	security/bpf/
+F:	include/linux/bpf_lsm.h
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 76f81e642dc2..c029f2b8d6fd 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -7,6 +7,19 @@
 
 #ifdef CONFIG_SECURITY_BPF
 extern int bpf_lsm_fs_initialized;
+int bpf_lsm_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_lsm_detach(const union bpf_attr *attr);
+#else
+static inline int bpf_lsm_attach(const union bpf_attr *attr,
+				 struct bpf_prog *prog)
+{
+	return -EINVAL;
+}
+
+static inline int bpf_lsm_detach(const union bpf_attr *attr)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_SECURITY_BPF */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4fcaf6042c07..8897b774973f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
+#include <linux/bpf_lsm.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
@@ -2132,7 +2133,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 		ret = lirc_prog_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_LSM:
-		ret = -EINVAL;
+		ret = bpf_lsm_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
@@ -2200,6 +2201,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_CGROUP_SETSOCKOPT:
 		ptype = BPF_PROG_TYPE_CGROUP_SOCKOPT;
 		break;
+	case BPF_LSM_MAC:
+		return bpf_lsm_detach(attr);
 	default:
 		return -EINVAL;
 	}
diff --git a/security/bpf/lsm_fs.c b/security/bpf/lsm_fs.c
index 49165394ef7d..b271e9582d0f 100644
--- a/security/bpf/lsm_fs.c
+++ b/security/bpf/lsm_fs.c
@@ -9,6 +9,8 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/types.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
 #include <linux/security.h>
 #include <linux/bpf_lsm.h>
 
@@ -28,6 +30,19 @@ bool is_bpf_lsm_hook_file(struct file *f)
 
 static void __init free_hook(struct bpf_lsm_hook *h)
 {
+	struct bpf_prog_array_item *item;
+	/*
+	 * This function is __init so we are guaranteed that there will be
+	 * no concurrent access.
+	 */
+	struct bpf_prog_array *progs = rcu_dereference_raw(h->progs);
+
+	if (progs) {
+		for (item = progs->items; item->prog; item++)
+			bpf_prog_put(item->prog);
+		bpf_prog_array_free(progs);
+	}
+
 	securityfs_remove(h->h_dentry);
 	h->h_dentry = NULL;
 }
@@ -36,8 +51,8 @@ static int __init init_hook(struct bpf_lsm_hook *h, struct dentry *parent)
 {
 	struct dentry *h_dentry;
 
-	h_dentry = securityfs_create_file(h->name, 0600, parent,
-			NULL, &hook_ops);
+	h_dentry = securityfs_create_file(h->name, 0600,
+					  parent, NULL, &hook_ops);
 	if (IS_ERR(h_dentry))
 		return PTR_ERR(h_dentry);
 
diff --git a/security/bpf/ops.c b/security/bpf/ops.c
index 2fa3ebdf598d..eb8a8db28109 100644
--- a/security/bpf/ops.c
+++ b/security/bpf/ops.c
@@ -4,11 +4,145 @@
  * Copyright 2019 Google LLC.
  */
 
+#include <linux/err.h>
+#include <linux/types.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/security.h>
+#include <linux/bpf_lsm.h>
+
+#include "bpf_lsm.h"
+#include "fs.h"
+
+static struct bpf_lsm_hook *get_hook_from_fd(int fd)
+{
+	struct bpf_lsm_hook *h;
+	struct fd f;
+	int ret;
+
+	/*
+	 * Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
+	 */
+	if (!capable(CAP_MAC_ADMIN))
+		return ERR_PTR(-EPERM);
+
+
+	f = fdget(fd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+
+	if (!is_bpf_lsm_hook_file(f.file)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/*
+	 * It's wrong to attach the program to the hook if the file is not
+	 * opened for a writing. Note that, this is an EBADF and not an EPERM
+	 * because the file has been opened with an incorrect mode.
+	 */
+	if (!(f.file->f_mode & FMODE_WRITE)) {
+		ret = -EBADF;
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
+int bpf_lsm_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_prog_array *old_array;
+	struct bpf_prog_array *new_array;
+	struct bpf_lsm_hook *h;
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
+	if (ret < 0)
+		goto unlock;
+
+	rcu_assign_pointer(h->progs, new_array);
+	bpf_prog_array_free(old_array);
+
+unlock:
+	mutex_unlock(&h->mutex);
+	return ret;
+}
+
+int bpf_lsm_detach(const union bpf_attr *attr)
+{
+	struct bpf_prog_array *old_array, *new_array;
+	struct bpf_prog *prog;
+	struct bpf_lsm_hook *h;
+	int ret = 0;
+
+	if (attr->attach_flags)
+		return -EINVAL;
+
+	h = get_hook_from_fd(attr->target_fd);
+	if (IS_ERR(h))
+		return PTR_ERR(h);
+
+	prog = bpf_prog_get_type(attr->attach_bpf_fd,
+				 BPF_PROG_TYPE_LSM);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	mutex_lock(&h->mutex);
+	old_array = rcu_dereference_protected(h->progs,
+					      lockdep_is_held(&h->mutex));
+
+	ret = bpf_prog_array_copy(old_array, prog, NULL, &new_array);
+	if (ret)
+		goto unlock;
+
+	rcu_assign_pointer(h->progs, new_array);
+	bpf_prog_array_free(old_array);
+unlock:
+	bpf_prog_put(prog);
+	mutex_unlock(&h->mutex);
+	return ret;
+}
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
+static const struct bpf_func_proto *get_bpf_func_proto(enum bpf_func_id
+		func_id, const struct bpf_prog *prog)
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
 const struct bpf_verifier_ops lsm_verifier_ops = {
+	.get_func_proto = get_bpf_func_proto,
+	.is_valid_access = btf_ctx_access,
 };
-- 
2.20.1

