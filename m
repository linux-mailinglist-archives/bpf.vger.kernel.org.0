Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063C763331F
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiKVCTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiKVCSM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:18:12 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E02E223E
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:16:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3a15bec5d25so43106217b3.19
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZCLjcJ4R3eU9/lQk3QpcBgc0zLovUHl4lozHOuR1ro=;
        b=Onag8LXKUEYkNQDXASyE2XfkV9WriZxyqN3f46RXUNf+xJTp5wc9/Ps0FZY4IkN/So
         AbmMbh0t8c0JnZvIieoFSE1EBshobKjZxKzNu97r2WkhJB1X/Ia6lpQBhufU7YzfmkAv
         YDjy4vUmCdmgGRkRHuzn1To8UaEOwRZ6WUtH7P8oqZpARoArEyNJrPPn+4HH4pmP+F1c
         d+CZeBxp97d6qmi6opkagbdWjO+WAhv/lud28ORlHNp68nkXZc+2xBT0Tpc9iMS6lhWa
         0NWCnjXNlGUVxaYC99FCDe6hQ6b17FEytdtdSgwGyJeul8NCakUZyFsIDAsf540osdoG
         0f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZCLjcJ4R3eU9/lQk3QpcBgc0zLovUHl4lozHOuR1ro=;
        b=lRcfdk3KaIBV2fsS63dw7KOPtVYkv5Va6HN/dTNz/qIDjd704kkIfG5pugRd0z+lGS
         +I1sHkITy4glnx9ftYUDgYGkmZDqoDa8BV3bovsR4qn4zi/YcEpW4znFHVryFjv8Sp7v
         ApB4vk1KJooX0qpqE4JYgRM5ATBYPAogT7UCXYfYhOfWCGthEluOc+JvrSpCmzratcEO
         Lu+CNYzGFOFwBvG/Z/yQmWL1FAQDK6f1Xe1GmwVda8lgzFSYEiCYndfqGvj3JCU/pwZb
         8zijh9tWD/vOISYVnc8n91Ue0qFmD2tWFXbHzbOLm3kItw/0t3LCGM/Mga4PE/9wQz92
         zPAw==
X-Gm-Message-State: ANoB5pn7z9jjmQBiKqffD7qYmJlw8OO4AKrptHyWj3wEO2x+YbzUkj2u
        JXMEaVVA4yZZMrJdIJKA4AtybAebgoc=
X-Google-Smtp-Source: AA0mqf6bOX01h/HY8m5g2/RqyJvAEQUaFiNQzJkxznyZMuDkIxQAJ34RzPLeCX9TjkXsyVZO4lIS883KTcc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a0d:ebcd:0:b0:39b:9c96:b6b7 with SMTP id
 u196-20020a0debcd000000b0039b9c96b6b7mr3ywe.450.1669083390850; Mon, 21 Nov
 2022 18:16:30 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:31 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-17-drosen@google.com>
Subject: [RFC PATCH v2 16/21] fuse-bpf: Add Rename support
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   7 ++
 fs/fuse/fuse_i.h  |  18 ++++
 3 files changed, 235 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 719292e03b18..333181d6ad73 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1677,6 +1677,216 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+static int fuse_rename_backing_common(struct inode *olddir,
+				      struct dentry *oldent,
+				      struct inode *newdir,
+				      struct dentry *newent, unsigned int flags)
+{
+	int err = 0;
+	struct path old_backing_path;
+	struct path new_backing_path;
+	struct dentry *old_backing_dir_dentry;
+	struct dentry *old_backing_dentry;
+	struct dentry *new_backing_dir_dentry;
+	struct dentry *new_backing_dentry;
+	struct dentry *trap = NULL;
+	struct inode *target_inode;
+	struct renamedata rd;
+
+	//TODO Actually deal with changing anything that isn't a flag
+	get_fuse_backing_path(oldent, &old_backing_path);
+	if (!old_backing_path.dentry)
+		return -EBADF;
+	get_fuse_backing_path(newent, &new_backing_path);
+	if (!new_backing_path.dentry) {
+		/*
+		 * TODO A file being moved from a backing path to another
+		 * backing path which is not yet instrumented with FUSE-BPF.
+		 * This may be slow and should be substituted with something
+		 * more clever.
+		 */
+		err = -EXDEV;
+		goto put_old_path;
+	}
+	if (new_backing_path.mnt != old_backing_path.mnt) {
+		err = -EXDEV;
+		goto put_new_path;
+	}
+	old_backing_dentry = old_backing_path.dentry;
+	new_backing_dentry = new_backing_path.dentry;
+	old_backing_dir_dentry = dget_parent(old_backing_dentry);
+	new_backing_dir_dentry = dget_parent(new_backing_dentry);
+	target_inode = d_inode(newent);
+
+	trap = lock_rename(old_backing_dir_dentry, new_backing_dir_dentry);
+	if (trap == old_backing_dentry) {
+		err = -EINVAL;
+		goto put_parents;
+	}
+	if (trap == new_backing_dentry) {
+		err = -ENOTEMPTY;
+		goto put_parents;
+	}
+
+	rd = (struct renamedata) {
+		.old_mnt_userns = &init_user_ns,
+		.old_dir = d_inode(old_backing_dir_dentry),
+		.old_dentry = old_backing_dentry,
+		.new_mnt_userns = &init_user_ns,
+		.new_dir = d_inode(new_backing_dir_dentry),
+		.new_dentry = new_backing_dentry,
+		.flags = flags,
+	};
+	err = vfs_rename(&rd);
+	if (err)
+		goto unlock;
+	if (target_inode)
+		fsstack_copy_attr_all(target_inode,
+				get_fuse_inode(target_inode)->backing_inode);
+	fsstack_copy_attr_all(d_inode(oldent), d_inode(old_backing_dentry));
+unlock:
+	unlock_rename(old_backing_dir_dentry, new_backing_dir_dentry);
+put_parents:
+	dput(new_backing_dir_dentry);
+	dput(old_backing_dir_dentry);
+put_new_path:
+	path_put(&new_backing_path);
+put_old_path:
+	path_put(&old_backing_path);
+	return err;
+}
+
+static int fuse_rename2_initialize_in(struct fuse_args *fa, struct fuse_rename2_in *fri,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent,
+				      unsigned int flags)
+{
+	*fri = (struct fuse_rename2_in) {
+		.newdir = get_node_id(newdir),
+		.flags = flags,
+	};
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(olddir),
+		.opcode = FUSE_RENAME2,
+		.in_numargs = 3,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(*fri),
+			.value = fri,
+		},
+		.in_args[1] = (struct fuse_in_arg) {
+			.size = oldent->d_name.len + 1,
+			.value =  (void *) oldent->d_name.name,
+		},
+		.in_args[2] = (struct fuse_in_arg) {
+			.size = newent->d_name.len + 1,
+			.value =  (void *) newent->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rename2_initialize_out(struct fuse_args *fa, struct fuse_rename2_in *fri,
+				       struct inode *olddir, struct dentry *oldent,
+				       struct inode *newdir, struct dentry *newent,
+				       unsigned int flags)
+{
+	return 0;
+}
+
+static int fuse_rename2_backing(struct fuse_args *fa, int *out,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent,
+				unsigned int flags)
+{
+	const struct fuse_rename2_in *fri = fa->in_args[0].value;
+
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent,
+					  fri->flags);
+	return *out;
+}
+
+static int fuse_rename2_finalize(struct fuse_args *fa, int *out,
+				 struct inode *olddir, struct dentry *oldent,
+				 struct inode *newdir, struct dentry *newent,
+				 unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+		     struct inode *newdir, struct dentry *newent,
+		     unsigned int flags)
+{
+	return fuse_bpf_backing(olddir, struct fuse_rename2_in, out,
+				fuse_rename2_initialize_in,
+				fuse_rename2_initialize_out, fuse_rename2_backing,
+				fuse_rename2_finalize,
+				olddir, oldent, newdir, newent, flags);
+}
+
+static int fuse_rename_initialize_in(struct fuse_args *fa, struct fuse_rename_in *fri,
+				     struct inode *olddir, struct dentry *oldent,
+				     struct inode *newdir, struct dentry *newent)
+{
+	*fri = (struct fuse_rename_in) {
+		.newdir = get_node_id(newdir),
+	};
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(olddir),
+		.opcode = FUSE_RENAME,
+		.in_numargs = 3,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(*fri),
+			.value = fri,
+		},
+		.in_args[1] = (struct fuse_in_arg) {
+			.size = oldent->d_name.len + 1,
+			.value =  (void *) oldent->d_name.name,
+		},
+		.in_args[2] = (struct fuse_in_arg) {
+			.size = newent->d_name.len + 1,
+			.value =  (void *) newent->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rename_initialize_out(struct fuse_args *fa, struct fuse_rename_in *fri,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+static int fuse_rename_backing(struct fuse_args *fa, int *out,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent)
+{
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent, 0);
+	return *out;
+}
+
+static int fuse_rename_finalize(struct fuse_args *fa, int *out,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+		    struct inode *newdir, struct dentry *newent)
+{
+	return fuse_bpf_backing(olddir, struct fuse_rename_in, out,
+				fuse_rename_initialize_in,
+				fuse_rename_initialize_out, fuse_rename_backing,
+				fuse_rename_finalize,
+				olddir, oldent, newdir, newent);
+}
+
 static int fuse_unlink_initialize_in(struct fuse_args *fa, struct fuse_unused_io *unused,
 				     struct inode *dir, struct dentry *entry)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 55ed3fb9d4a3..6ad0eb92de3b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1116,6 +1116,10 @@ static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
 		return -EINVAL;
 
 	if (flags) {
+		if (fuse_bpf_rename2(&err, olddir, oldent, newdir, newent, flags))
+			return err;
+
+		/* TODO: how should this go with bpfs involved? */
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
@@ -1127,6 +1131,9 @@ static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
+		if (fuse_bpf_rename(&err, olddir, oldent, newdir, newent))
+			return err;
+
 		err = fuse_rename_common(olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cb087364e9bb..3338ac84d083 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1406,6 +1406,11 @@ int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
 int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode);
 int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+		     struct inode *newdir, struct dentry *newent,
+		     unsigned int flags);
+int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+		    struct inode *newdir, struct dentry *newent);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
@@ -1448,6 +1453,19 @@ static inline int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *ent
 	return 0;
 }
 
+static inline int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+				   struct inode *newdir, struct dentry *newent,
+				   unsigned int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+				  struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 {
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

