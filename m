Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED648CBD0
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiALTZy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiALTZx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:25:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CEC06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:25:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso3089908ybp.23
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XfvrIOiHNbk7sHm262Jen6JEO4ueUlQOWGJuAR4JJ6g=;
        b=BpGGHxCNjsjfxj+LWSId8tSqHJeUJNR4TF3w1wU9fZYnoFLi/zV2VEamgGffGHQoNi
         ZjqsDcYPUHVCPJYmQfkf8ymz0kwqN0MH7IaG4kniTfxwhWy6C+Asdt0Q/DGRQMBO7NP5
         H6055Gt8NOzOtbWN3M/p/y7WqE26cloLI/gZjzOUbNup/fnVmC2kNvfcajV6E6MtdlSY
         0o+bfp9a1wxet08J7x/wkAl0AiRjbqczzMHC9sg523txMx3gVPbfYmr1AXi0ly80QopQ
         3xqlrGj1u8VM1IfMflWJMHJnHRPWBk2TioFZhQrrHZBpb/qE0JTAwU+9iK9YNFGsD5Cu
         64Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XfvrIOiHNbk7sHm262Jen6JEO4ueUlQOWGJuAR4JJ6g=;
        b=VYcCukJ4+CW+1THe3X/vKgcn5Aj6PTPLSV6KIiPC8neSKLJrWvhz+TmtTE/fiFRXtQ
         QWbacn/osyt6GxSg3RoNsgmknq0HnFKqan4DWPeBHFoYyk7KZgyBogdCF3PvGBi7Lmvc
         TEXstqP73kkBTIhrNJNwpzvUIEKubdc4np3lsytEHZct44XbJhWj49YmHp53p5vgRi04
         qYBdROAy8Wo16fOKE9uEec34h/rjSiVi75HfYCRkbUuyhsvOOeEPSvg6JzdwNKjTdoYZ
         VCV36cQxH2/1cmZS9NoWc0jBWXSatHK9gi2GkVks6FbeZ9qCmNZjKazMpFrBu2va6x7g
         DCqQ==
X-Gm-Message-State: AOAM532LhnTyZlzd1FwzX7WKMbjA7ghEP2MHOH49z1ysJ1u0U4YDZn6S
        PtTRwa1+qkjjtVp4WaEH9rZv0T/3BMo=
X-Google-Smtp-Source: ABdhPJz86scxJ+AvkKMvPVkmkCpbPPw8niBdO3dU6BUotXtFY+cJv17D3xQZlutDj1uKtNW31JLV8KXQc90=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a05:6902:152:: with SMTP id
 p18mr1503182ybh.85.1642015552792; Wed, 12 Jan 2022 11:25:52 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:25:40 -0800
In-Reply-To: <20220112192547.3054575-1-haoluo@google.com>
Message-Id: <20220112192547.3054575-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220112192547.3054575-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 1/8] bpf: Support pinning in non-bpf
 file system.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, Joe@google.com,
        Burton@google.com, jevburton.kernel@gmail.com,
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

