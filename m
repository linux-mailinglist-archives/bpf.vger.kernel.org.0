Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66734C5222
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiBYXoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiBYXoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF617C426
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k10-20020a056902070a00b0062469b00335so4888372ybt.14
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1qljGvi/baSUFDY4mqKz3QQQFwbltSyykW/yjXYd2yM=;
        b=mE7MUbyagfjgIsftf4aBMAUfxEHMroR905idQD8siRRfqQwgOnpPHWSclHIFB9jW+r
         a+nayfIt30kJIiVu6bCSgXXcyRI5Xd9jG0sREse3WUJ0C/ONMYIt3EeQHsTsA5MQrmVJ
         /hCXLXZBtDnlLwleHB47K4FvJ8jsO/cPPvlUDvNX8bjVgpgFxvC+T/ezP2SDUjwkH46n
         RIcvqawbZ1Zz86BR6A0N5zzclJzoyJLnllwd+ITPJBGk4vHIy4h4bX8vVFqa2YTPNKPv
         SFfGbGLpqnKm7G+mg0UJYsGpfNUQTgqSb69KHzW8qVGm21ZClX8CwB3gnUEtFtm0oaan
         SFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1qljGvi/baSUFDY4mqKz3QQQFwbltSyykW/yjXYd2yM=;
        b=VEob5LqZj+xC4coNbxTDrcnm5GB07gXJ6ymV4zqr1tm/t79sphFJhbi7UZ3mmD0olS
         MMNLu84ZKpwT/J0EgJUOWldhg4+WiZPyyGrFODJhoPVpmtZ/gyQK3+ooviq1BuEVF+DO
         3Psp3oZ6J6m0v9qw2+fzOtvwc5UDROZC6nwPH2WaEobwJQcGUk89Yvxf9Gq+DjZwju2e
         L5neU9QYDFjDD4GpWAUTcwCHguR1b5ZVnImn8rgU7fIUfN/W8sKqSlQy0sXhO/oY+qFy
         ZQQxqx6wrANpzTzwcx/OM1xGIeZoJhHxrufFe2/ece6OvlKV98Oi9N2pVuGu8IpyUrX+
         eXHQ==
X-Gm-Message-State: AOAM530hYMFs9tjnclbN08XF2TkRsUL9YfTFD+Fbu/5FXjkeLFA5TLEf
        abAUzP7hjkfCc3RTkoYE6x+GbQKTf+s=
X-Google-Smtp-Source: ABdhPJxEUyC7gY+QotGZ9BkZFQFS4jfSmgc0ZR7kFVOJiEUIskrlPPI1dFQi2UIKQgsaT8xhZrfCOW46s28=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:b004:0:b0:621:f386:f10a with SMTP id
 q4-20020a25b004000000b00621f386f10amr9229547ybf.314.1645832626177; Fri, 25
 Feb 2022 15:43:46 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:31 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls for prog_bpf_syscall
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows bpf_syscall prog to perform some basic filesystem
operations: create, remove directories and unlink files. Three bpf
helpers are added for this purpose. When combined with the following
patches that allow pinning and getting bpf objects from bpf prog,
this feature can be used to create directory hierarchy in bpffs that
help manage bpf objects purely using bpf progs.

The added helpers subject to the same permission checks as their syscall
version. For example, one can not write to a read-only file system;
The identity of the current process is checked to see whether it has
sufficient permission to perform the operations.

Only directories and files in bpffs can be created or removed by these
helpers. But it won't be too hard to allow these helpers to operate
on files in other filesystems, if we want.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h            |   1 +
 include/uapi/linux/bpf.h       |  26 +++++
 kernel/bpf/inode.c             |   9 +-
 kernel/bpf/syscall.c           | 177 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  26 +++++
 5 files changed, 236 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f19abc59b6cd..fce5e26179f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1584,6 +1584,7 @@ int bpf_link_new_fd(struct bpf_link *link);
 struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 
+bool bpf_path_is_bpf_dir(const struct path *path);
 int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
 int bpf_obj_get_user(const char __user *pathname, int flags);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index afe3d0d7f5f2..a5dbc794403d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5086,6 +5086,29 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure. On error
  *		*dst* buffer is zeroed out.
+ *
+ * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
+ *	Description
+ *		Attempts to create a directory name *pathname*. The argument
+ *		*pathname_sz* specifies the length of the string *pathname*.
+ *		The argument *mode* specifies the mode for the new directory. It
+ *		is modified by the process's umask. It has the same semantic as
+ *		the syscall mkdir(2).
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_rmdir(const char *pathname, int pathname_sz)
+ *	Description
+ *		Deletes a directory, which must be empty.
+ *	Return
+ *		0 on sucess, or a negative error in case of failure.
+ *
+ * long bpf_unlink(const char *pathname, int pathname_sz)
+ *	Description
+ *		Deletes a name and possibly the file it refers to. It has the
+ *		same semantic as the syscall unlink(2).
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5280,6 +5303,9 @@ union bpf_attr {
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
+	FN(mkdir),			\
+	FN(rmdir),			\
+	FN(unlink),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4f841e16779e..3aca00e9e950 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -414,6 +414,11 @@ static const struct inode_operations bpf_dir_iops = {
 	.unlink		= simple_unlink,
 };
 
+bool bpf_path_is_bpf_dir(const struct path *path)
+{
+	return d_inode(path->dentry)->i_op == &bpf_dir_iops;
+}
+
 /* pin iterator link into bpffs */
 static int bpf_iter_link_pin_kernel(struct dentry *parent,
 				    const char *name, struct bpf_link *link)
@@ -439,7 +444,6 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 			  enum bpf_type type)
 {
 	struct dentry *dentry;
-	struct inode *dir;
 	struct path path;
 	umode_t mode;
 	int ret;
@@ -454,8 +458,7 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 	if (ret)
 		goto out;
 
-	dir = d_inode(path.dentry);
-	if (dir->i_op != &bpf_dir_iops) {
+	if (!bpf_path_is_bpf_dir(&path)) {
 		ret = -EPERM;
 		goto out;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index db402ebc5570..07683b791733 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -12,6 +12,7 @@
 #include <linux/sched/signal.h>
 #include <linux/vmalloc.h>
 #include <linux/mmzone.h>
+#include <linux/namei.h>
 #include <linux/anon_inodes.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
@@ -4867,6 +4868,176 @@ const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg4_type	= ARG_PTR_TO_LONG,
 };
 
+BPF_CALL_3(bpf_mkdir, const char *, pathname, int, pathname_sz, u32, raw_mode)
+{
+	struct user_namespace *mnt_userns;
+	struct dentry *dentry;
+	struct path path;
+	umode_t mode;
+	int err;
+
+	if (pathname_sz <= 1 || pathname[pathname_sz - 1])
+		return -EINVAL;
+
+	dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	if (!bpf_path_is_bpf_dir(&path)) {
+		err = -EPERM;
+		goto err_exit;
+	}
+
+	mode = raw_mode;
+	if (!IS_POSIXACL(path.dentry->d_inode))
+		mode &= ~current_umask();
+	err = security_path_mkdir(&path, dentry, mode);
+	if (err)
+		goto err_exit;
+
+	mnt_userns = mnt_user_ns(path.mnt);
+	err = vfs_mkdir(mnt_userns, d_inode(path.dentry), dentry, mode);
+
+err_exit:
+	done_path_create(&path, dentry);
+	return err;
+}
+
+const struct bpf_func_proto bpf_mkdir_proto = {
+	.func		= bpf_mkdir,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_rmdir, const char *, pathname, int, pathname_sz)
+{
+	struct user_namespace *mnt_userns;
+	struct path parent;
+	struct dentry *dentry;
+	int err;
+
+	if (pathname_sz <= 1 || pathname[pathname_sz - 1])
+		return -EINVAL;
+
+	err = kern_path(pathname, 0, &parent);
+	if (err)
+		return err;
+
+	if (!bpf_path_is_bpf_dir(&parent)) {
+		err = -EPERM;
+		goto exit1;
+	}
+
+	err = mnt_want_write(parent.mnt);
+	if (err)
+		goto exit1;
+
+	dentry = kern_path_locked(pathname, &parent);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto exit2;
+	}
+
+	if (d_really_is_negative(dentry)) {
+		err = -ENOENT;
+		goto exit3;
+	}
+
+	err = security_path_rmdir(&parent, dentry);
+	if (err)
+		goto exit3;
+
+	mnt_userns = mnt_user_ns(parent.mnt);
+	err = vfs_rmdir(mnt_userns, d_inode(parent.dentry), dentry);
+exit3:
+	dput(dentry);
+	inode_unlock(d_inode(parent.dentry));
+exit2:
+	mnt_drop_write(parent.mnt);
+exit1:
+	path_put(&parent);
+	return err;
+}
+
+const struct bpf_func_proto bpf_rmdir_proto = {
+	.func		= bpf_rmdir,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
+BPF_CALL_2(bpf_unlink, const char *, pathname, int, pathname_sz)
+{
+	struct user_namespace *mnt_userns;
+	struct path parent;
+	struct dentry *dentry;
+	struct inode *inode = NULL;
+	int err;
+
+	if (pathname_sz <= 1 || pathname[pathname_sz - 1])
+		return -EINVAL;
+
+	err = kern_path(pathname, 0, &parent);
+	if (err)
+		return err;
+
+	err = mnt_want_write(parent.mnt);
+	if (err)
+		goto exit1;
+
+	dentry = kern_path_locked(pathname, &parent);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto exit2;
+	}
+
+	if (!bpf_path_is_bpf_dir(&parent)) {
+		err = -EPERM;
+		goto exit3;
+	}
+
+	if (d_is_negative(dentry)) {
+		err = -ENOENT;
+		goto exit3;
+	}
+
+	if (d_is_dir(dentry)) {
+		err = -EISDIR;
+		goto exit3;
+	}
+
+	inode = dentry->d_inode;
+	ihold(inode);
+	err = security_path_unlink(&parent, dentry);
+	if (err)
+		goto exit3;
+
+	mnt_userns = mnt_user_ns(parent.mnt);
+	err = vfs_unlink(mnt_userns, d_inode(parent.dentry), dentry, NULL);
+exit3:
+	dput(dentry);
+	inode_unlock(d_inode(parent.dentry));
+	if (inode)
+		iput(inode);
+exit2:
+	mnt_drop_write(parent.mnt);
+exit1:
+	path_put(&parent);
+	return err;
+}
+
+const struct bpf_func_proto bpf_unlink_proto = {
+	.func		= bpf_unlink,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
 static const struct bpf_func_proto *
 syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4879,6 +5050,12 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sys_close_proto;
 	case BPF_FUNC_kallsyms_lookup_name:
 		return &bpf_kallsyms_lookup_name_proto;
+	case BPF_FUNC_mkdir:
+		return &bpf_mkdir_proto;
+	case BPF_FUNC_rmdir:
+		return &bpf_rmdir_proto;
+	case BPF_FUNC_unlink:
+		return &bpf_unlink_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index afe3d0d7f5f2..a5dbc794403d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5086,6 +5086,29 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure. On error
  *		*dst* buffer is zeroed out.
+ *
+ * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
+ *	Description
+ *		Attempts to create a directory name *pathname*. The argument
+ *		*pathname_sz* specifies the length of the string *pathname*.
+ *		The argument *mode* specifies the mode for the new directory. It
+ *		is modified by the process's umask. It has the same semantic as
+ *		the syscall mkdir(2).
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_rmdir(const char *pathname, int pathname_sz)
+ *	Description
+ *		Deletes a directory, which must be empty.
+ *	Return
+ *		0 on sucess, or a negative error in case of failure.
+ *
+ * long bpf_unlink(const char *pathname, int pathname_sz)
+ *	Description
+ *		Deletes a name and possibly the file it refers to. It has the
+ *		same semantic as the syscall unlink(2).
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5280,6 +5303,9 @@ union bpf_attr {
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
+	FN(mkdir),			\
+	FN(rmdir),			\
+	FN(unlink),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.35.1.574.g5d30c73bfb-goog

