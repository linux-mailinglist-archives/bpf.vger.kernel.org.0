Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E64A6688
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiBAUzn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiBAUzm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:42 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816ECC06173B
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:55:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z37-20020a056a001da500b004c74e3fd644so9760353pfw.1
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rThEDZn+lvseNJpmwu5NYRqQrzaWHFfOZgkrNvBxioY=;
        b=RsSjfhezq9hddP0+USmpiXrTisgiTKiRvti5DwTuxApn72KC6nEKeVjvD7k59IaZXA
         D5WnvZe6afi0RlFEwfMdlUaawBfEqeJngrfSYNkD14l9UX59UU+MwyZE9iyOu3y3rzo9
         oiOI0xx/Foga/eJvY6XxI99tr7aT+Lpuo/7ZRjPAJbAxopJ8R2HzDInAmmkBV/U0bA1s
         BgP3xFSYParQKG7UVkYYYet/BlGBqZ094D28/H0s1VSGE6Hlx6yR68nFUKpP+RehXrpS
         n0Gd4edV9rAKLOUEzMx5mzLSC79IfApdjezjcDupD6o68MLv/37ov11L8R3IRTZ6r1tM
         xPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rThEDZn+lvseNJpmwu5NYRqQrzaWHFfOZgkrNvBxioY=;
        b=eO8rywMxE1VrM6yMucG5u+MMXvJMvVGJ/mEDL4vcH8JcWNaUzMJLbpuIzK1VTJMkUE
         k3W7vdkfBlNYsOGBw+zJmi97s8kXp0aDl8FWowjSfLbmMWcUcmIDyb/lUcuLeMc9etL8
         23K84a+fXgi+XxdXSEui10Kj4d4f9CMMN75tWMcRK6nDdNGwwi/PoHbAF31QjQNVKRBv
         1IQSHuyzcHu+Mwow7Rx011bfAnac80WZtdX5luiP5qcTn4V2/5SKu4LREkE9KYP9iSTS
         UG1f1Er/0DUO+lXXVh57d0EYL+9trGOVP4Z2mcg6J0iGpr/AVzdmPVdyVrjgBmv6q10l
         Ke2w==
X-Gm-Message-State: AOAM530RAAU0YSsC21dxfEJeb8wAlPqsQ9/G5+Us4aHlReb7jIU1XYCc
        UuJSrWjK9mtyzYlEIRWinzt0JkKarjY=
X-Google-Smtp-Source: ABdhPJwdx6TAzMTb2rN2WINjSTvZbX5HKheIlI6PnxkT52N5BF3kbH+rc/Q9S5LU731La6cVfP7bs8vltJs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a17:90b:1bc3:: with SMTP id
 oa3mr4406017pjb.172.1643748941970; Tue, 01 Feb 2022 12:55:41 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:30 -0800
In-Reply-To: <20220201205534.1962784-1-haoluo@google.com>
Message-Id: <20220201205534.1962784-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 1/5] bpf: Bpffs directory tag
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a tag structure for directories in bpffs. A tag carries
special information about a directory. For example, a BPF_DIR_KERNFS_REP
tag denotes that a directory is a replicate of a kernfs hierarchy.

At mkdir, if the parent directory has a tag, the child directory also
gets tag. For KERNFS_REP directories, the tag references a kernfs node.
The KERNFS_REP hierarchy mirrors the hierarchy in kernfs. Userspace is
responsible for sync'ing two hierarchies.

The initial tag can be created by pinning a certain type of bpf objects.
The following patches will introduce such objects and the tagged
directory will mirror the cgroup hierarchy.

Tags are destroyed at rmdir.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/inode.c | 80 +++++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/inode.h | 22 +++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/inode.h

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5a8d9f7467bf..ecc357009df5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -16,11 +16,13 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/kernfs.h>
 #include <linux/kdev_t.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include "preload/bpf_preload.h"
+#include "inode.h"
 
 enum bpf_type {
 	BPF_TYPE_UNSPEC	= 0,
@@ -142,6 +144,52 @@ static int bpf_inode_type(const struct inode *inode, enum bpf_type *type)
 	return 0;
 }
 
+static struct bpf_dir_tag *inode_tag(const struct inode *inode)
+{
+	if (unlikely(!S_ISDIR(inode->i_mode)))
+		return NULL;
+
+	return inode->i_private;
+}
+
+/* tag_dir_inode - tag a newly created directory.
+ * @tag: tag of parent directory
+ * @dentry: dentry of the new directory
+ * @inode: inode of the new directory
+ *
+ * Called from bpf_mkdir.
+ */
+static int tag_dir_inode(const struct bpf_dir_tag *tag,
+			 const struct dentry *dentry, struct inode *inode)
+{
+	struct bpf_dir_tag *t;
+	struct kernfs_node *kn;
+
+	WARN_ON(tag->type != BPF_DIR_KERNFS_REP);
+
+	/* kn is put at tag deallocation. */
+	kn = kernfs_find_and_get_ns(tag->private, dentry->d_name.name, NULL);
+	if (unlikely(!kn))
+		return -ENOENT;
+
+	if (unlikely(kernfs_type(kn) != KERNFS_DIR)) {
+		kernfs_put(kn);
+		return -EPERM;
+	}
+
+	t = kzalloc(sizeof(struct bpf_dir_tag), GFP_KERNEL | __GFP_NOWARN);
+	if (unlikely(!t)) {
+		kernfs_put(kn);
+		return -ENOMEM;
+	}
+
+	t->type = tag->type;
+	t->private = kn;
+
+	inode->i_private = t;
+	return 0;
+}
+
 static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 				struct inode *dir)
 {
@@ -156,6 +204,8 @@ static int bpf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
+	struct bpf_dir_tag *tag;
+	int err;
 
 	inode = bpf_get_inode(dir->i_sb, dir, mode | S_IFDIR);
 	if (IS_ERR(inode))
@@ -164,6 +214,15 @@ static int bpf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_op = &bpf_dir_iops;
 	inode->i_fop = &simple_dir_operations;
 
+	tag = inode_tag(dir);
+	if (tag) {
+		err = tag_dir_inode(tag, dentry, inode);
+		if (err) {
+			iput(inode);
+			return err;
+		}
+	}
+
 	inc_nlink(inode);
 	inc_nlink(dir);
 
@@ -404,11 +463,30 @@ static int bpf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	return 0;
 }
 
+static void untag_dir_inode(struct inode *dir)
+{
+	struct bpf_dir_tag *tag = inode_tag(dir);
+
+	WARN_ON(tag->type != BPF_DIR_KERNFS_REP);
+
+	dir->i_private = NULL;
+	kernfs_put(tag->private);
+	kfree(tag);
+}
+
+static int bpf_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	if (inode_tag(dir))
+		untag_dir_inode(dir);
+
+	return simple_rmdir(dir, dentry);
+}
+
 static const struct inode_operations bpf_dir_iops = {
 	.lookup		= bpf_lookup,
 	.mkdir		= bpf_mkdir,
 	.symlink	= bpf_symlink,
-	.rmdir		= simple_rmdir,
+	.rmdir		= bpf_rmdir,
 	.rename		= simple_rename,
 	.link		= simple_link,
 	.unlink		= simple_unlink,
diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
new file mode 100644
index 000000000000..2cfeef39e861
--- /dev/null
+++ b/kernel/bpf/inode.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2022 Google
+ */
+#ifndef __BPF_INODE_H_
+#define __BPF_INODE_H_
+
+enum tag_type {
+	/* The directory is a replicate of a kernfs directory hierarchy. */
+	BPF_DIR_KERNFS_REP = 0,
+};
+
+/* A tag for bpffs directories. It carries special information about a
+ * directory. For example, BPF_DIR_KERNFS_REP denotes that the directory is
+ * a replicate of a kernfs hierarchy. Pinning a certain type of objects tags
+ * a directory and the tag will be removed at rmdir.
+ */
+struct bpf_dir_tag {
+	enum tag_type type;
+	void *private;  /* tag private data */
+};
+
+#endif
-- 
2.35.0.rc2.247.g8bbb082509-goog

