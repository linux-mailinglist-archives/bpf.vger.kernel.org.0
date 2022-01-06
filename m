Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11D486CB9
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiAFVvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbiAFVvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:51:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBD0C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 13:51:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso7686797ybb.1
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XfvrIOiHNbk7sHm262Jen6JEO4ueUlQOWGJuAR4JJ6g=;
        b=QjGuhAir6rqlPoJLK1yYFC65x5Q8mFf23h4/pRuJrPbEhr9W2YZo9wQ0reC8oOHAka
         OlbKeq8BmMilr/ZKSPQueNqs2OkYkiQU0foogtFqe81E/J075a+6igS4w4f+NZtMsapf
         B01GcB6OWnDlMliuG66qk6b7+gCHc1m1+incERNWCi9q6pS1N0C5rY7dNaw8qCxCHC+9
         BCLpza7IVVAYGUkWiBfAfDuCNAYriq75XPsFXXLPtnqZYrGSlAA/1GBG/+vMOiQzQ0Mr
         fRt3z1Vgcknp22w38Nfo6s45TOrTf5trTxeCr0fKMpHjL2gHc2KJ0qC83WGY9sIAuzSu
         jO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XfvrIOiHNbk7sHm262Jen6JEO4ueUlQOWGJuAR4JJ6g=;
        b=q0IFQNbKQgltqFOdxFv2LXAAtMGYbVDYjnCmE3Ae/K/swr++9Xtl1gW6/73gSq5YgQ
         pODfS6+MrD/VgAkHFBwd592Cpx+cxbW8BO3qBdlzOFp6rg09J0OkkB1+7kLzVkMtGEft
         t57FisjHwxnqJtjJwIo/VuMQG+kMyox+VLVCaDBDHooOxHMcGKOhqezsB85toC9aR5Qz
         MFoFBa4H6Vqbx9HlE6sijvFi/6E8pLehluq9c8VnpVuagjDWWIa/34apXjJM8pA2RRxK
         h+039ZALe27ioK1/wX/akS08pC/aWFrCWRtLT2o6R0SGLiVyhJx+U2D6iD+v3xdkvmbg
         lmSw==
X-Gm-Message-State: AOAM533cr4PSitFdS2eN0BLm3UWRIt8oMOyjL3itM604oP3gX19D6dac
        51Sc2oLd40ytpbkw6DwJ92RoBFOTEzY=
X-Google-Smtp-Source: ABdhPJy+BbO/mFlD7os94sdsGTqQuF3pFk/uL/yRJLDu4CN79rGSxCKHf/LHnu3c5RfcHLK7MB5epmUTwGU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:3a2:a76c:b77f:b671])
 (user=haoluo job=sendgmr) by 2002:a25:5c6:: with SMTP id 189mr70119943ybf.595.1641505871244;
 Thu, 06 Jan 2022 13:51:11 -0800 (PST)
Date:   Thu,  6 Jan 2022 13:50:52 -0800
In-Reply-To: <20220106215059.2308931-1-haoluo@google.com>
Message-Id: <20220106215059.2308931-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH RFC bpf-next v1 1/8] bpf: Support pinning in non-bpf file system.
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

