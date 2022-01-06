Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6281486CBB
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiAFVvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiAFVvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:51:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43394C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 13:51:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so7582374ybf.18
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LRC0uuW3m4fIg7GXmCy19/8orrmcRboRMIkgNo7+8QE=;
        b=HmM85kO+xTE6HSDQcm/5HKxWh7QsrN/GGFnsxJRXnMb3kbpvthruFtSThpSjshzPHx
         xXbUabjuij1gyeGpXL4DiuayOXo9A7IFCDlZjEQKrNwET9XaeU4FZwQtVgKH8aaoIA40
         ahNwD9o0ArcywGF8v8fu0rSE+dxmqxur67NMcPbBDCITDzhfb910DXTJ3JCSOcwk0FYx
         bKzYlOvvoI3enE5m+iuHXLLEBRohJoulhZh3DVs7b59dYg4F1Xy3HCBgOWRFFFa3Lnqx
         Xex3oTMo9gfdoekA3o2Sv+cpsbuGEu3aEt9fvDzB4pXtvCO0FhJjjtfPMRn1oXodOzMP
         86vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LRC0uuW3m4fIg7GXmCy19/8orrmcRboRMIkgNo7+8QE=;
        b=7BwWYvAIVfXuEyj7NI9OTA7Bwtw4qNu9gq5KmstHHGgjDo9TFFU5Dcknd4I4z8lnrt
         dYf93xGEPiuDiQ/g6KfD41rhqyZ3VlL0aC954L+H4zthNPs8J1DsTBXwQGrtahkS0Qor
         PFOObvpmSRrmf+ikVKYKfS+1Dh20MzD1FPifeDNj7r5bjwkvczwtAkss5WfoDZqc6APX
         3l0gaM5LVK7pJZlCUwL3Dv8DvTgMgAhYgq5nQSxJd+ecdoK1hZ39dMuSQXduqySyN1ml
         3UY5gFITx7LftVuuef0ILyDgRiUA+Kj6Iz5ogsfDdhHGhRlDa5ISovxG6bLPejJftqWs
         f4xQ==
X-Gm-Message-State: AOAM531xX5Ssn9I3LdiUkmuWvS7v7ed7l/dwDiQNIh1ZzR56zgsRpywb
        94TqDgFBcJFpwIZTi+OtE3RJ1rGxOIg=
X-Google-Smtp-Source: ABdhPJz0M9IYJr07yja3yPBJjA/FUHIKiPeb1jhQgkQahr34sgfNLVqmax/jYifC3xmh3mVIkqmu0uvtZaw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:3a2:a76c:b77f:b671])
 (user=haoluo job=sendgmr) by 2002:a25:db83:: with SMTP id g125mr53227597ybf.658.1641505876504;
 Thu, 06 Jan 2022 13:51:16 -0800 (PST)
Date:   Thu,  6 Jan 2022 13:50:54 -0800
In-Reply-To: <20220106215059.2308931-1-haoluo@google.com>
Message-Id: <20220106215059.2308931-4-haoluo@google.com>
Mime-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH RFC bpf-next v1 3/8] bpf: Expose bpf object in kernfs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch extends bpf_obj_do_pin() to allow creating a new entry in
kernfs which references a bpf object. Different from pinning objects
in bpffs, the created kernfs node does not hold an extra reference to
the object, because kernfs by itself doesn't have a notification
mechanism to put the object when the kernfs node is gone. Therefore
this patch is not "pinning" the object, but rather "exposing" the
object in kernfs. The lifetime of the created kernfs node depends on
the lifetime of the bpf object, not the other way around.

More specifically, we allow a bpf object to be exposed to kernfs only
after it becomes "persistent" by pinning in bpffs. So the lifetime of
the created kernfs node is tied to the bpffs inode. When the object
is unpinned from bpffs, the kernfs nodes exposing the bpf object will
be removed automatically. It uses the bpf_watch_inode() interface
introduced in the previous patches. Because the kernfs nodes do not
hold extra references to the object, we can remove the nodes at any
time without worrying about reference leak.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/Makefile      |  2 +-
 kernel/bpf/inode.c       | 43 +++++++++++++-------
 kernel/bpf/inode.h       | 11 ++++-
 kernel/bpf/kernfs_node.c | 87 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 17 deletions(-)
 create mode 100644 kernel/bpf/kernfs_node.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1a9be6a4b9f..b1abf0d94b5b 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o kernfs_node.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9ba10912cbf8..7e93e477b57c 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -580,6 +580,21 @@ static bool dentry_is_bpf_dir(struct dentry *dentry)
 	return d_inode(dentry)->i_op == &bpf_dir_iops;
 }
 
+static int bpf_obj_do_pin_generic(struct dentry *dentry, umode_t mode,
+				  void *obj, enum bpf_type type)
+{
+	switch (type) {
+	case BPF_TYPE_PROG:
+		return vfs_mkobj(dentry, mode, bpf_mkprog, obj);
+	case BPF_TYPE_MAP:
+		return vfs_mkobj(dentry, mode, bpf_mkmap, obj);
+	case BPF_TYPE_LINK:
+		return vfs_mkobj(dentry, mode, bpf_mklink, obj);
+	default:
+		return -EPERM;
+	}
+}
+
 static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 			  enum bpf_type type)
 {
@@ -598,22 +613,20 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 	if (ret)
 		goto out;
 
-	if (!dentry_is_bpf_dir(path.dentry)) {
-		ret = -EPERM;
-		goto out;
-	}
+	if (dentry_is_kernfs_dir(path.dentry)) {
+		ret = bpf_obj_do_pin_kernfs(dentry, mode, raw, type);
 
-	switch (type) {
-	case BPF_TYPE_PROG:
-		ret = vfs_mkobj(dentry, mode, bpf_mkprog, raw);
-		break;
-	case BPF_TYPE_MAP:
-		ret = vfs_mkobj(dentry, mode, bpf_mkmap, raw);
-		break;
-	case BPF_TYPE_LINK:
-		ret = vfs_mkobj(dentry, mode, bpf_mklink, raw);
-		break;
-	default:
+		/* Match bpf_fd_probe_obj(). bpf objects exposed to kernfs
+		 * do not hold an active reference. The lifetime of the
+		 * created kernfs node is tied to an inode in bpffs. So the
+		 * kernfs node gets destroyed automatically when the object
+		 * is unpinned from bpffs.
+		 */
+		if (ret == 0)
+			bpf_any_put(raw, type);
+	} else if (dentry_is_bpf_dir(path.dentry)) {
+		ret = bpf_obj_do_pin_generic(dentry, mode, raw, type);
+	} else {
 		ret = -EPERM;
 	}
 out:
diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
index e7fe8137be80..c12d385a3e2a 100644
--- a/kernel/bpf/inode.h
+++ b/kernel/bpf/inode.h
@@ -4,8 +4,10 @@
 #ifndef __BPF_INODE_H_
 #define __BPF_INODE_H_
 
+#include <linux/fs.h>
+
 enum bpf_type {
-	BPF_TYPE_UNSPEC = 0,
+	BPF_TYPE_UNSPEC	= 0,
 	BPF_TYPE_PROG,
 	BPF_TYPE_MAP,
 	BPF_TYPE_LINK,
@@ -39,4 +41,11 @@ int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops,
  */
 struct inode *get_backing_inode(void *obj, enum bpf_type);
 
+/* Test whether a given dentry is a kernfs entry. */
+bool dentry_is_kernfs_dir(struct dentry *dentry);
+
+/* Expose bpf object to kernfs. Requires dentry to be in kernfs. */
+int bpf_obj_do_pin_kernfs(struct dentry *dentry, umode_t mode, void *obj,
+			  enum bpf_type type);
+
 #endif  // __BPF_INODE_H_
diff --git a/kernel/bpf/kernfs_node.c b/kernel/bpf/kernfs_node.c
new file mode 100644
index 000000000000..c1c45f7b948b
--- /dev/null
+++ b/kernel/bpf/kernfs_node.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Expose eBPF objects in kernfs file system.
+ */
+
+#include <linux/fs.h>
+#include <linux/kernfs.h>
+#include "inode.h"
+
+/* file_operations for kernfs file system */
+
+/* Handler when the watched inode is freed. */
+static void kn_watch_free_inode(void *obj, enum bpf_type type, void *kn)
+{
+	kernfs_remove(kn);
+
+	/* match get in bpf_obj_do_pin_kernfs */
+	kernfs_put(kn);
+}
+
+static const struct notify_ops notify_ops = {
+	.free_inode = kn_watch_free_inode,
+};
+
+/* Kernfs file operations for bpf created files. */
+static const struct kernfs_ops bpf_generic_ops = {
+};
+
+/* Test whether a given dentry is a kernfs entry. */
+bool dentry_is_kernfs_dir(struct dentry *dentry)
+{
+	return kernfs_node_from_dentry(dentry) != NULL;
+}
+
+/* Expose bpf object to kernfs. Requires dentry to exist in kernfs. */
+int bpf_obj_do_pin_kernfs(struct dentry *dentry, umode_t mode, void *obj,
+			  enum bpf_type type)
+{
+	struct dentry *parent_dentry;
+	struct super_block *sb;
+	struct kernfs_node *parent_kn, *kn;
+	struct kernfs_root *root;
+	const struct kernfs_ops *ops;
+	struct inode *inode;
+	int ret;
+
+	sb = dentry->d_sb;
+	root = kernfs_root_from_sb(sb);
+	if (!root) /* Not a kernfs file system. */
+		return -EPERM;
+
+	parent_dentry = dentry->d_parent;
+	parent_kn = kernfs_node_from_dentry(parent_dentry);
+	if (WARN_ON(!parent_kn))
+		return -EPERM;
+
+	inode = get_backing_inode(obj, type);
+	if (!inode)
+		return -ENXIO;
+
+	ops = &bpf_generic_ops;
+	kn = __kernfs_create_file(parent_kn, dentry->d_iname, mode,
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  0, ops, inode, NULL, NULL);
+	if (IS_ERR(kn)) {
+		iput(inode);
+		return PTR_ERR(kn);
+	}
+
+	/* hold an active kn by bpffs inode. */
+	kernfs_get(kn);
+
+	/* Watch the backing inode of the object in bpffs. When the backing
+	 * inode is freed, the created kernfs entry will be removed as well.
+	 */
+	ret = bpf_watch_inode(inode, &notify_ops, kn);
+	if (ret) {
+		kernfs_put(kn);
+		kernfs_remove(kn);
+		iput(inode);
+		return ret;
+	}
+
+	kernfs_activate(kn);
+	iput(inode);
+	return 0;
+}
-- 
2.34.1.448.ga2b2bfdf31-goog

