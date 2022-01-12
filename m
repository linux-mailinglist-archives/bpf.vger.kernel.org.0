Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5048CC0A
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiALTeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiALTe0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869DC061748
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a84-20020a251a57000000b0061171f19f8dso6412012yba.13
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XfvrIOiHNbk7sHm262Jen6JEO4ueUlQOWGJuAR4JJ6g=;
        b=DrRx3v7DZzu+LzM5Y+tAamL+LNuXv1AlONpL/opTcPG6PAMVMzVsfx+1CvOovcVRT1
         DyB8ShvHx25aQ0ddn2dB+HvuWaVY1jRo7vNnWQovP7Aiuh4G8mWPHOwKvZHICmBNUJds
         Mg9JcmBAE165xnTfcbBkIfk1ircCDB+uaqctVgmqt2qXIOXi/avxyerhW7J/7FQ10dmU
         swo5x1BSo8/ij+q4yn0k4w7gyPV1JqTw8s2ErmkcZ3NRpFg3UgyVFdTwexx6m5/fyArN
         aVFKKbQS8hSjY5t2HZJrPIYYHVjfqa+pb+fGpXmf1dDfk1Rz4mdnygLknoS5Rgs3+wwL
         8J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XfvrIOiHNbk7sHm262Jen6JEO4ueUlQOWGJuAR4JJ6g=;
        b=N6w2bcjfAoKCggayly9bsB499cgin7SFtdAIiTQOcu+vFVnhQCawZSpZg+FjT/3yMQ
         TN1lYNpJNV7n5yF5VM5YCISFDfYNB0WwXZT+2V7dXxtJn9D22jOXqqms70T7oxpP0EOC
         6WntDJfiwgoWeA0TUbCYg5X6hhz9t9m/cZHchbyUxXGvRJ++ipg7iwEiciGvEpsUclEA
         QpcOKMMGn68OgXO52B76d85ILD7Q+Ppur0BoWUC+DJeQzzBsSdtsxChWO31G6e3c7FdU
         EOklFkD8L/97qZf7HcDNPC2+S7YDwUtRpj7dIdVPhg8CAxbEGVHet5gWrnT4j7uamP/E
         YxfA==
X-Gm-Message-State: AOAM530okmr4cIutm+2a/haYyXUvtBW4kUX4+hu+zG/scQXFItOulUuM
        EVto2uUzGqW2LW6DGN5k8ZYvFweAYnk=
X-Google-Smtp-Source: ABdhPJy6X3YecTlBP6ShH6Wv+JTOar+K+DuCij0wC3zpCgxRjnoY3eQ5Wv+B4NcS5gM62JT2npD37Ub5RNg=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a05:6902:8f:: with SMTP id
 h15mr1431854ybs.95.1642016065767; Wed, 12 Jan 2022 11:34:25 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:31:45 -0800
In-Reply-To: <20220112193152.3058718-1-haoluo@google.com>
Message-Id: <20220112193152.3058718-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220112193152.3058718-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 1/8] bpf: Support pinning in non-bpf
 file system.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new API called bpf_watch_inode() to watch the destruction of
an inode and calls a registered callback function. With the help of this
new API, one can implement pinning bpf objects in a non-bpf file system
such as sockfs. The ability of pinning bpf objects in an external file
system has potential uses: for example, allow using bpf programs to
customize file behaviors, as we can see in the following patches.

Extending the pinning logic in bpf_obj_do_pin() to associate bpf objects
to inodes of another file system is relatively straightforward. The
challenge is how to notify the bpf object when the associated inode is
gone so that the object's refcnt can be decremented at that time. Bpffs
uses .free_inode() callback in super_operations to drop object's refcnt.
But not every file system implements .free_inode() and inserting bpf
notification to every target file system can be too instrusive.

Thanks to fsnotify, there is a generic callback in VFS that can be
used to notify the events of an inode. bpf_watch_inode() implements on
top of that. bpf_watch_inode() allows the caller to pass in a callback
(for example, decrementing an object's refcnt), which will be called
when the inode is about to be freed. So typically, one can implement
exposing bpf objects to other file systems in the following steps:

 1. extend bpf_obj_do_pin() to create a new entry in the target file
    system.
 2. call bpf_watch_inode() to register bpf object put operation at
    the destruction of the newly created inode.

Of course, on a system with no fsnotify support, pinning bpf object in
non-bpf file system will not be available.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/inode.c | 118 ++++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/inode.h |  33 +++++++++++++
 2 files changed, 140 insertions(+), 11 deletions(-)
 create mode 100644 kernel/bpf/inode.h

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 80da1db47c68..b4066dd986a8 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -16,18 +16,13 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsnotify_backend.h>
 #include <linux/kdev_t.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include "preload/bpf_preload.h"
-
-enum bpf_type {
-	BPF_TYPE_UNSPEC	= 0,
-	BPF_TYPE_PROG,
-	BPF_TYPE_MAP,
-	BPF_TYPE_LINK,
-};
+#include "inode.h"
 
 static void *bpf_any_get(void *raw, enum bpf_type type)
 {
@@ -67,6 +62,95 @@ static void bpf_any_put(void *raw, enum bpf_type type)
 	}
 }
 
+#ifdef CONFIG_FSNOTIFY
+/* Notification mechanism based on fsnotify, used in bpf to watch the
+ * destruction of an inode. This inode could an inode in bpffs or any
+ * other file system.
+ */
+
+struct notify_mark {
+	struct fsnotify_mark fsn_mark;
+	const struct notify_ops *ops;
+	void *object;
+	enum bpf_type type;
+	void *priv;
+};
+
+struct fsnotify_group *bpf_notify_group;
+struct kmem_cache *bpf_notify_mark_cachep __read_mostly;
+
+/* Handler for any inode event. */
+int handle_inode_event(struct fsnotify_mark *mark, u32 mask,
+		       struct inode *inode, struct inode *dir,
+		       const struct qstr *file_name, u32 cookie)
+{
+	return 0;
+}
+
+/* Handler for freeing marks. This is called when the watched inode is being
+ * freed.
+ */
+static void notify_freeing_mark(struct fsnotify_mark *mark, struct fsnotify_group *group)
+{
+	struct notify_mark *b_mark;
+
+	b_mark = container_of(mark, struct notify_mark, fsn_mark);
+
+	if (b_mark->ops && b_mark->ops->free_inode)
+		b_mark->ops->free_inode(b_mark->object, b_mark->type, b_mark->priv);
+}
+
+static void notify_free_mark(struct fsnotify_mark *mark)
+{
+	struct notify_mark *b_mark;
+
+	b_mark = container_of(mark, struct notify_mark, fsn_mark);
+
+	kmem_cache_free(bpf_notify_mark_cachep, b_mark);
+}
+
+struct fsnotify_ops bpf_notify_ops = {
+	.handle_inode_event = handle_inode_event,
+	.freeing_mark = notify_freeing_mark,
+	.free_mark = notify_free_mark,
+};
+
+static int bpf_inode_type(const struct inode *inode, enum bpf_type *type);
+
+/* Watch the destruction of an inode and calls the callbacks in the given
+ * notify_ops.
+ */
+int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops, void *priv)
+{
+	enum bpf_type type;
+	struct notify_mark *b_mark;
+	int ret;
+
+	if (IS_ERR(bpf_notify_group) || unlikely(!bpf_notify_mark_cachep))
+		return -ENOMEM;
+
+	b_mark = kmem_cache_alloc(bpf_notify_mark_cachep, GFP_KERNEL_ACCOUNT);
+	if (unlikely(!b_mark))
+		return -ENOMEM;
+
+	fsnotify_init_mark(&b_mark->fsn_mark, bpf_notify_group);
+	b_mark->ops = ops;
+	b_mark->priv = priv;
+	b_mark->object = inode->i_private;
+	bpf_inode_type(inode, &type);
+	b_mark->type = type;
+
+	ret = fsnotify_add_inode_mark(&b_mark->fsn_mark, inode,
+				      /*allow_dups=*/1);
+
+	fsnotify_put_mark(&b_mark->fsn_mark); /* match get in fsnotify_init_mark */
+
+	return ret;
+}
+#endif
+
+/* bpffs */
+
 static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *type)
 {
 	void *raw;
@@ -435,11 +519,15 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	return ret;
 }
 
+static bool dentry_is_bpf_dir(struct dentry *dentry)
+{
+	return d_inode(dentry)->i_op == &bpf_dir_iops;
+}
+
 static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 			  enum bpf_type type)
 {
 	struct dentry *dentry;
-	struct inode *dir;
 	struct path path;
 	umode_t mode;
 	int ret;
@@ -454,8 +542,7 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 	if (ret)
 		goto out;
 
-	dir = d_inode(path.dentry);
-	if (dir->i_op != &bpf_dir_iops) {
+	if (!dentry_is_bpf_dir(path.dentry)) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -821,8 +908,17 @@ static int __init bpf_init(void)
 		return ret;
 
 	ret = register_filesystem(&bpf_fs_type);
-	if (ret)
+	if (ret) {
 		sysfs_remove_mount_point(fs_kobj, "bpf");
+		return ret;
+	}
+
+#ifdef CONFIG_FSNOTIFY
+	bpf_notify_mark_cachep = KMEM_CACHE(notify_mark, 0);
+	bpf_notify_group = fsnotify_alloc_group(&bpf_notify_ops);
+	if (IS_ERR(bpf_notify_group) || !bpf_notify_mark_cachep)
+		pr_warn("Failed to initialize bpf_notify system, user can not pin objects outside bpffs.\n");
+#endif
 
 	return ret;
 }
diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
new file mode 100644
index 000000000000..3f53a4542028
--- /dev/null
+++ b/kernel/bpf/inode.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2022 Google
+ */
+#ifndef __BPF_INODE_H_
+#define __BPF_INODE_H_
+
+enum bpf_type {
+	BPF_TYPE_UNSPEC = 0,
+	BPF_TYPE_PROG,
+	BPF_TYPE_MAP,
+	BPF_TYPE_LINK,
+};
+
+struct notify_ops {
+	void (*free_inode)(void *object, enum bpf_type type, void *priv);
+};
+
+#ifdef CONFIG_FSNOTIFY
+/* Watch the destruction of an inode and calls the callbacks in the given
+ * notify_ops.
+ */
+int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops,
+		    void *priv);
+#else
+static inline
+int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops,
+		    void *priv)
+{
+	return -EPERM;
+}
+#endif  // CONFIG_FSNOTIFY
+
+#endif  // __BPF_INODE_H_
-- 
2.34.1.448.ga2b2bfdf31-goog

