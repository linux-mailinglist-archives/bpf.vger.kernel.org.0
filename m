Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F64A668A
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiBAUzt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiBAUzp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98FC06173B
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:55:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e130-20020a255088000000b006126feb051eso35548323ybb.18
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zPUB3NCEXXiz6+mubQFrvt3pkt+Hiu6v49aq+5qNgdA=;
        b=nG2n54JlmG3+OOeTvBCYp5mh4jCaq3qOEY+zPFz6IXJegkVJgfuonqSpBZGtMzingX
         yTVHeIhvqQA/FTsbVjtbDL0QTZAKpJsOURMN4I9KfajdtTGBq7iJ4tHi+/P6ql3ctOez
         shL0NIZaY8GB4DTeo5YH0ZuKZVBFHI5qU61ICzxLJ67nJh06c4lRWGVhYwB+jRI9B1y8
         hiSDf90S8zMxkLelqfRgF81OaPW2GFcGfIYmAlTdwoUfEWKjg2kpmVLQkamLXfpP+hp/
         c6lxssgkd0eZE+4bz68vPp4EQedKA8jRElaKZzK+Tto1VoudK57mtTzCM/svm7+Y8MsN
         GRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zPUB3NCEXXiz6+mubQFrvt3pkt+Hiu6v49aq+5qNgdA=;
        b=BDT4M3fffCHySWvZzilp0FI0HSKUbT8yTnTtxcYyTTN/i4M8li9WZehKUxuxD7P9bD
         tTT3OiMjENdNjo826Ow5EyzR8r2CAn7cKz6PAAymmHx9LQGN+oSOcvYeOS1HnlLAZsTR
         DnAtp/NcDYiToxMNtL5ndk2lrGn/FnqLgX2RgmQAI4MC21U49bR/Qw86mLAeVsA0umYU
         tNGbm1y3+crVmOiBHKIhpaa3nOZEG+9K1yRVE7ZkbEsw0spAVDSWbmaX6N6ENzX7jwXH
         xM90Ol/OzPzERev4WWdz8wqndR2qUA7lqz8keuSzil8CNIrC3TG1Bf4jP6da5k/OSbhp
         OGFA==
X-Gm-Message-State: AOAM531Y/PlNIZiwCE853kUq2dqmR6CQtKnNXfcT2n1h27r9+4UTO30D
        RWp3QkX2EaQqxHibg0ZitkTdjmsbuSQ=
X-Google-Smtp-Source: ABdhPJze7Krj8ejwFo366WPCbYzzm4Q3Mfn9Q5H6bxPKSCgnl/JbAbBlyieQcUP4BCeZgDYjNJPloFr1RKI=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a25:557:: with SMTP id 84mr38786815ybf.637.1643748944511;
 Tue, 01 Feb 2022 12:55:44 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:31 -0800
In-Reply-To: <20220201205534.1962784-1-haoluo@google.com>
Message-Id: <20220201205534.1962784-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 2/5] bpf: Introduce inherit list for dir tag.
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

Embed a list of bpf objects in a directory's tag. This list is
shared by all the directories in the tagged hierarchy.

When a new tagged directory is created, it will be prepopulated
with the objects in the inherit list. When the directory is
removed, the inherited objects will be removed automatically.

Because the whole tagged hierarchy share the same list, all the
directories in the hierarchy have the same set of objects to be
prepopulated.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/inode.c | 110 +++++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/inode.h |  33 ++++++++++++++
 2 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index ecc357009df5..9ae17a2bf779 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -24,13 +24,6 @@
 #include "preload/bpf_preload.h"
 #include "inode.h"
 
-enum bpf_type {
-	BPF_TYPE_UNSPEC	= 0,
-	BPF_TYPE_PROG,
-	BPF_TYPE_MAP,
-	BPF_TYPE_LINK,
-};
-
 static void *bpf_any_get(void *raw, enum bpf_type type)
 {
 	switch (type) {
@@ -69,6 +62,20 @@ static void bpf_any_put(void *raw, enum bpf_type type)
 	}
 }
 
+static void free_obj_list(struct kref *kref)
+{
+	struct obj_list *list;
+	struct bpf_inherit_entry *e;
+
+	list = container_of(kref, struct obj_list, refcnt);
+	list_for_each_entry(e, &list->list, list) {
+		list_del_rcu(&e->list);
+		bpf_any_put(e->obj, e->type);
+		kfree(e);
+	}
+	kfree(list);
+}
+
 static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *type)
 {
 	void *raw;
@@ -100,6 +107,10 @@ static const struct inode_operations bpf_prog_iops = { };
 static const struct inode_operations bpf_map_iops  = { };
 static const struct inode_operations bpf_link_iops  = { };
 
+static int bpf_mkprog(struct dentry *dentry, umode_t mode, void *arg);
+static int bpf_mkmap(struct dentry *dentry, umode_t mode, void *arg);
+static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg);
+
 static struct inode *bpf_get_inode(struct super_block *sb,
 				   const struct inode *dir,
 				   umode_t mode)
@@ -184,12 +195,62 @@ static int tag_dir_inode(const struct bpf_dir_tag *tag,
 	}
 
 	t->type = tag->type;
+	t->inherit_objects = tag->inherit_objects;
+	kref_get(&t->inherit_objects->refcnt);
 	t->private = kn;
 
 	inode->i_private = t;
 	return 0;
 }
 
+/* populate_dir - populate directory with bpf objects in a tag's
+ * inherit_objects.
+ * @dir: dentry of the directory.
+ * @inode: inode of the direcotry.
+ *
+ * Called from mkdir. Must be called after dentry has been finalized.
+ */
+static int populate_dir(struct dentry *dir, struct inode *inode)
+{
+	struct bpf_dir_tag *tag = inode_tag(inode);
+	struct bpf_inherit_entry *e;
+	struct dentry *child;
+	int ret;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &tag->inherit_objects->list, list) {
+		child = lookup_one_len_unlocked(e->name.name, dir,
+						strlen(e->name.name));
+		if (unlikely(IS_ERR(child))) {
+			ret = PTR_ERR(child);
+			break;
+		}
+
+		switch (e->type) {
+		case BPF_TYPE_PROG:
+			ret = bpf_mkprog(child, e->mode, e->obj);
+			break;
+		case BPF_TYPE_MAP:
+			ret = bpf_mkmap(child, e->mode, e->obj);
+			break;
+		case BPF_TYPE_LINK:
+			ret = bpf_mklink(child, e->mode, e->obj);
+			break;
+		default:
+			ret = -EPERM;
+			break;
+		}
+		dput(child);
+		if (ret)
+			break;
+
+		/* To match bpf_any_put in bpf_free_inode. */
+		bpf_any_get(e->obj, e->type);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 				struct inode *dir)
 {
@@ -227,6 +288,12 @@ static int bpf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	inc_nlink(dir);
 
 	bpf_dentry_finalize(dentry, inode, dir);
+
+	if (tag) {
+		err = populate_dir(dentry, inode);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
@@ -463,6 +530,30 @@ static int bpf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	return 0;
 }
 
+/* unpopulate_dir - remove pre-populated entries from directory.
+ * @dentry: dentry of directory
+ * @inode: inode of directory
+ *
+ * Called from rmdir.
+ */
+static void unpopulate_dir(struct dentry *dentry, struct inode *inode)
+{
+	struct bpf_dir_tag *tag = inode_tag(inode);
+	struct bpf_inherit_entry *e;
+	struct dentry *child;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &tag->inherit_objects->list, list) {
+		child = d_hash_and_lookup(dentry, &e->name);
+		if (unlikely(IS_ERR(child)))
+			continue;
+
+		simple_unlink(inode, child);
+		dput(child);
+	}
+	rcu_read_unlock();
+}
+
 static void untag_dir_inode(struct inode *dir)
 {
 	struct bpf_dir_tag *tag = inode_tag(dir);
@@ -471,13 +562,16 @@ static void untag_dir_inode(struct inode *dir)
 
 	dir->i_private = NULL;
 	kernfs_put(tag->private);
+	kref_put(&tag->inherit_objects->refcnt, free_obj_list);
 	kfree(tag);
 }
 
 static int bpf_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (inode_tag(dir))
+	if (inode_tag(dir)) {
+		unpopulate_dir(dentry, dir);
 		untag_dir_inode(dir);
+	}
 
 	return simple_rmdir(dir, dentry);
 }
diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
index 2cfeef39e861..a8207122643d 100644
--- a/kernel/bpf/inode.h
+++ b/kernel/bpf/inode.h
@@ -4,11 +4,42 @@
 #ifndef __BPF_INODE_H_
 #define __BPF_INODE_H_
 
+#include <linux/bpf.h>
+#include <linux/fs.h>
+
+enum bpf_type {
+	BPF_TYPE_UNSPEC	= 0,
+	BPF_TYPE_PROG,
+	BPF_TYPE_MAP,
+	BPF_TYPE_LINK,
+};
+
 enum tag_type {
 	/* The directory is a replicate of a kernfs directory hierarchy. */
 	BPF_DIR_KERNFS_REP = 0,
 };
 
+/* Entry for bpf_dir_tag->inherit_objects.
+ *
+ * When a new directory is created from a tagged directory, the new directory
+ * will be populated with bpf objects in the tag's inherit_objects list. Each
+ * entry holds a reference of a bpf object and the information needed to
+ * recreate the object's entry in the new directory.
+ */
+struct bpf_inherit_entry {
+	struct list_head list;
+	void *obj; /* bpf object to inherit. */
+	enum bpf_type type; /* type of the object (prog, map or link). */
+	struct qstr name;  /* name of the entry. */
+	umode_t mode;  /* access mode of the entry. */
+};
+
+struct obj_list {
+	struct list_head list;
+	struct kref refcnt;
+	struct inode *root;
+};
+
 /* A tag for bpffs directories. It carries special information about a
  * directory. For example, BPF_DIR_KERNFS_REP denotes that the directory is
  * a replicate of a kernfs hierarchy. Pinning a certain type of objects tags
@@ -16,6 +47,8 @@ enum tag_type {
  */
 struct bpf_dir_tag {
 	enum tag_type type;
+	/* list of bpf objects that a directory inherits from its parent. */
+	struct obj_list *inherit_objects;
 	void *private;  /* tag private data */
 };
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

