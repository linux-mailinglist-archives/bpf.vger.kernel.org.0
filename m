Return-Path: <bpf+bounces-15357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B377F1469
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD631F24677
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108CF1A723;
	Mon, 20 Nov 2023 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5584D2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:29:53 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3AKDTqDp046220;
	Mon, 20 Nov 2023 22:29:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Mon, 20 Nov 2023 22:29:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3AKDRaAM045731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Nov 2023 22:29:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d9777279-4840-4cb7-a94b-a108e61e0aa7@I-love.SAKURA.ne.jp>
Date: Mon, 20 Nov 2023 22:29:47 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] LSM: Break LSM_HOOK() macro into 6 macros.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
In-Reply-To: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These macros are used for deduplicating typical functions in
security/security.c and security/mod_lsm.c (which is added by
the next patch).

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_hook_defs.h | 780 ++++++++++++++++++----------------
 1 file changed, 424 insertions(+), 356 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 3febbe4ef87c..4fdb13373fe2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -25,398 +25,466 @@
  *   #include <linux/lsm_hook_defs.h>
  * };
  */
-LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
-LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
-	 const struct cred *to)
-LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
-	 const struct cred *to)
-LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
-	 const struct cred *to, const struct file *file)
-LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
-	 unsigned int mode)
-LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
-LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
-	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
-LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
-	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
-	 const kernel_cap_t *permitted)
-LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
-	 int cap, unsigned int opts)
-LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
-LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
-LSM_HOOK(int, 0, syslog, int type)
-LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
-	 const struct timezone *tz)
-LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
-LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
-LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
-LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
-LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
-LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
-LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
-	 struct fs_context *src_sc)
-LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
-	 struct fs_parameter *param)
-LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
-LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
-LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
-LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
-LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
-LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
-	 const char *type, unsigned long flags, void *data)
-LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
-LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
-	 const struct path *new_path)
-LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
-	 unsigned long kern_flags, unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
-	 struct super_block *newsb, unsigned long kern_flags,
-	 unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, move_mount, const struct path *from_path,
-	 const struct path *to_path)
-LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
-	 int mode, const struct qstr *name, const char **xattr_name,
-	 void **ctx, u32 *ctxlen)
-LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
-	 struct qstr *name, const struct cred *old, struct cred *new)
+
+/*
+ * The macro LSM_PLAIN_INT_HOOK can be used to automatically define a callback
+ * function that returns int and the loop can continue as long as the default
+ * return value is returned by callback functions in that loop.
+ * LSM_HOOK is used if this macro is not defined.
+ */
+#ifndef LSM_PLAIN_INT_HOOK
+#define LSM_PLAIN_INT_HOOK LSM_HOOK
+#endif
+
+/*
+ * The macro LSM_CUSTOM_INT_HOOK can be used to define a callback function that
+ * returns int and the loop can continue as long as the default return value is
+ * returned by callback functions in that loop, but that callback function has
+ * something to do before and/or after the loop.
+ * LSM_HOOK is used if this macro is not defined.
+ */
+#ifndef LSM_CUSTOM_INT_HOOK
+#define LSM_CUSTOM_INT_HOOK LSM_HOOK
+#endif
+
+/*
+ * The macro LSM_SPECIAL_INT_HOOK can be used to suppess automatically defining
+ * a callback function that returns int because that callback has something to
+ * do before and/or after calling callback functions in that loop.
+ * LSM_HOOK is used if this macro is not defined.
+ */
+#ifndef LSM_SPECIAL_INT_HOOK
+#define LSM_SPECIAL_INT_HOOK LSM_HOOK
+#endif
+
+/*
+ * The macro LSM_PLAIN_VOID_HOOK can be used to automatically define a callback
+ * function that does not return a value.
+ * LSM_HOOK is used if this macro is not defined.
+ */
+#ifndef LSM_PLAIN_VOID_HOOK
+#define LSM_PLAIN_VOID_HOOK LSM_HOOK
+#endif
+
+/*
+ * The macro LSM_CUSTOM_VOID_HOOK can be used to suppress automatically
+ * defining a callback function that does not return a value because that
+ * callback function has something to do before and/or after the loop.
+ * LSM_HOOK is used if this macro is not defined.
+ */
+#ifndef LSM_CUSTOM_VOID_HOOK
+#define LSM_CUSTOM_VOID_HOOK LSM_HOOK
+#endif
+
+/*
+ * The macro LSM_SPECIAL_VOID_HOOK can be used to suppess automatically defining
+ * a callback function that does not return a value because that callback has
+ * something to do before and/or after calling callback functions in that loop.
+ * LSM_HOOK is used if this macro is not defined.
+ */
+#ifndef LSM_SPECIAL_VOID_HOOK
+#define LSM_SPECIAL_VOID_HOOK LSM_HOOK
+#endif
+
+LSM_PLAIN_INT_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
+LSM_PLAIN_INT_HOOK(int, 0, binder_transaction, const struct cred *from,
+		   const struct cred *to)
+LSM_PLAIN_INT_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
+		   const struct cred *to)
+LSM_PLAIN_INT_HOOK(int, 0, binder_transfer_file, const struct cred *from,
+		   const struct cred *to, const struct file *file)
+LSM_PLAIN_INT_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
+		   unsigned int mode)
+LSM_PLAIN_INT_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
+LSM_PLAIN_INT_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
+		   kernel_cap_t *inheritable, kernel_cap_t *permitted)
+LSM_PLAIN_INT_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
+		   const kernel_cap_t *effective, const kernel_cap_t *inheritable,
+		   const kernel_cap_t *permitted)
+LSM_PLAIN_INT_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
+		   int cap, unsigned int opts)
+LSM_PLAIN_INT_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
+LSM_PLAIN_INT_HOOK(int, 0, quota_on, struct dentry *dentry)
+LSM_PLAIN_INT_HOOK(int, 0, syslog, int type)
+LSM_SPECIAL_INT_HOOK(int, 0, settime, const struct timespec64 *ts,
+		     const struct timezone *tz)
+LSM_SPECIAL_INT_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_PLAIN_INT_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
+LSM_PLAIN_INT_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
+LSM_PLAIN_INT_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
+LSM_PLAIN_INT_HOOK(int, 0, fs_context_submount, struct fs_context *fc,
+		   struct super_block *reference)
+LSM_PLAIN_INT_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
+		   struct fs_context *src_sc)
+LSM_SPECIAL_INT_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
+		     struct fs_parameter *param)
+LSM_PLAIN_INT_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
+LSM_PLAIN_INT_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
+LSM_PLAIN_INT_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
+LSM_PLAIN_INT_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
+LSM_PLAIN_INT_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
+LSM_PLAIN_INT_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
+LSM_PLAIN_INT_HOOK(int, 0, sb_statfs, struct dentry *dentry)
+LSM_PLAIN_INT_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
+		   const char *type, unsigned long flags, void *data)
+LSM_PLAIN_INT_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
+LSM_PLAIN_INT_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
+		   const struct path *new_path)
+LSM_CUSTOM_INT_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
+		    unsigned long kern_flags, unsigned long *set_kern_flags)
+LSM_PLAIN_INT_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
+		   struct super_block *newsb, unsigned long kern_flags,
+		   unsigned long *set_kern_flags)
+LSM_PLAIN_INT_HOOK(int, 0, move_mount, const struct path *from_path,
+		   const struct path *to_path)
+LSM_PLAIN_INT_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
+		   int mode, const struct qstr *name, const char **xattr_name,
+		   void **ctx, u32 *ctxlen)
+LSM_PLAIN_INT_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
+		   struct qstr *name, const struct cred *old, struct cred *new)
 
 #ifdef CONFIG_SECURITY_PATH
-LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
-	 umode_t mode)
-LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
-	 umode_t mode, unsigned int dev)
-LSM_HOOK(int, 0, path_truncate, const struct path *path)
-LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
-	 const char *old_name)
-LSM_HOOK(int, 0, path_link, struct dentry *old_dentry,
-	 const struct path *new_dir, struct dentry *new_dentry)
-LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
-	 struct dentry *old_dentry, const struct path *new_dir,
-	 struct dentry *new_dentry, unsigned int flags)
-LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
-LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
-LSM_HOOK(int, 0, path_chroot, const struct path *path)
+LSM_CUSTOM_INT_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
+		    umode_t mode)
+LSM_CUSTOM_INT_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
+		    umode_t mode, unsigned int dev)
+LSM_CUSTOM_INT_HOOK(int, 0, path_truncate, const struct path *path)
+LSM_CUSTOM_INT_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
+		    const char *old_name)
+LSM_CUSTOM_INT_HOOK(int, 0, path_link, struct dentry *old_dentry,
+		    const struct path *new_dir, struct dentry *new_dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, path_rename, const struct path *old_dir,
+		    struct dentry *old_dentry, const struct path *new_dir,
+		    struct dentry *new_dentry, unsigned int flags)
+LSM_CUSTOM_INT_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
+LSM_CUSTOM_INT_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
+LSM_PLAIN_INT_HOOK(int, 0, path_chroot, const struct path *path)
 #endif /* CONFIG_SECURITY_PATH */
 
 /* Needed for inode based security check */
-LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
-	 unsigned int obj_type)
-LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
-LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
-LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
-	 const struct qstr *name, const struct inode *context_inode)
-LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
-	 umode_t mode)
-LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
-	 struct dentry *new_dentry)
-LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_symlink, struct inode *dir, struct dentry *dentry,
-	 const char *old_name)
-LSM_HOOK(int, 0, inode_mkdir, struct inode *dir, struct dentry *dentry,
-	 umode_t mode)
-LSM_HOOK(int, 0, inode_rmdir, struct inode *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_mknod, struct inode *dir, struct dentry *dentry,
-	 umode_t mode, dev_t dev)
-LSM_HOOK(int, 0, inode_rename, struct inode *old_dir, struct dentry *old_dentry,
-	 struct inode *new_dir, struct dentry *new_dentry)
-LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
-	 bool rcu)
-LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
-LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
-LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *name, const void *value,
-	 size_t size, int flags)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
-	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
-LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *name)
-LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
-LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
-	 struct dentry *dentry)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
-	 struct inode *inode, const char *name, void **buffer, bool alloc)
-LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
-	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
-	 size_t buffer_size)
-LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
-LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
-LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
-LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
-	 struct kernfs_node *kn)
-LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
-LSM_HOOK(int, 0, file_alloc_security, struct file *file)
-LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
-LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
-	 unsigned long arg)
-LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
-LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
-	 unsigned long prot, unsigned long flags)
-LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
-	 unsigned long reqprot, unsigned long prot)
-LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
-LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
-	 unsigned long arg)
-LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
-LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
-	 struct fown_struct *fown, int sig)
-LSM_HOOK(int, 0, file_receive, struct file *file)
-LSM_HOOK(int, 0, file_open, struct file *file)
-LSM_HOOK(int, 0, file_truncate, struct file *file)
-LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
-	 unsigned long clone_flags)
-LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
-LSM_HOOK(int, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
-LSM_HOOK(void, LSM_RET_VOID, cred_free, struct cred *cred)
-LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
-	 gfp_t gfp)
-LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
-	 const struct cred *old)
-LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
-LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
-LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
-LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
-LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
-LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
-	 enum kernel_load_data_id id, char *description)
-LSM_HOOK(int, 0, kernel_read_file, struct file *file,
-	 enum kernel_read_file_id id, bool contents)
-LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
-	 loff_t size, enum kernel_read_file_id id)
-LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
-	 int flags)
-LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
-	 int flags)
-LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
-LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
-LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
-LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
-	 struct task_struct *p, u32 *secid)
-LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
-LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
-LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
-LSM_HOOK(int, 0, task_prlimit, const struct cred *cred,
-	 const struct cred *tcred, unsigned int flags)
-LSM_HOOK(int, 0, task_setrlimit, struct task_struct *p, unsigned int resource,
-	 struct rlimit *new_rlim)
-LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p)
-LSM_HOOK(int, 0, task_getscheduler, struct task_struct *p)
-LSM_HOOK(int, 0, task_movememory, struct task_struct *p)
-LSM_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_siginfo *info,
-	 int sig, const struct cred *cred)
-LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
-	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
-LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
-	 struct inode *inode)
-LSM_HOOK(int, 0, userns_create, const struct cred *cred)
-LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
-	 u32 *secid)
-LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
-LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
-LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, msg_queue_free_security,
-	 struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, msg_queue_associate, struct kern_ipc_perm *perm, int msqflg)
-LSM_HOOK(int, 0, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, msg_queue_msgsnd, struct kern_ipc_perm *perm,
-	 struct msg_msg *msg, int msqflg)
-LSM_HOOK(int, 0, msg_queue_msgrcv, struct kern_ipc_perm *perm,
-	 struct msg_msg *msg, struct task_struct *target, long type, int mode)
-LSM_HOOK(int, 0, shm_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, shm_free_security, struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, shm_associate, struct kern_ipc_perm *perm, int shmflg)
-LSM_HOOK(int, 0, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, shm_shmat, struct kern_ipc_perm *perm, char __user *shmaddr,
-	 int shmflg)
-LSM_HOOK(int, 0, sem_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, sem_free_security, struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, sem_associate, struct kern_ipc_perm *perm, int semflg)
-LSM_HOOK(int, 0, sem_semctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
-	 unsigned nsops, int alter)
-LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
-	 struct inode *inode)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
-	 char **value)
-LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
-LSM_HOOK(int, 0, ismaclabel, const char *name)
-LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
-	 u32 *seclen)
-LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
-LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
-LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
-	 u32 *ctxlen)
+LSM_PLAIN_INT_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
+		   unsigned int obj_type)
+LSM_PLAIN_INT_HOOK(int, 0, inode_alloc_security, struct inode *inode)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
+LSM_SPECIAL_INT_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
+		     struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
+		     int *xattr_count)
+LSM_PLAIN_INT_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
+		   const struct qstr *name, const struct inode *context_inode)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
+		    umode_t mode)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
+		    struct dentry *new_dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_symlink, struct inode *dir, struct dentry *dentry,
+		    const char *old_name)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_mkdir, struct inode *dir, struct dentry *dentry,
+		    umode_t mode)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_rmdir, struct inode *dir, struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_mknod, struct inode *dir, struct dentry *dentry,
+		    umode_t mode, dev_t dev)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+		    struct inode *new_dir, struct dentry *new_dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_readlink, struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
+		    bool rcu)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_getattr, const struct path *path)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
+		    struct dentry *dentry, const char *name, const void *value,
+		    size_t size, int flags)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
+		     const char *name, const void *value, size_t size, int flags)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
+		    struct dentry *dentry, const char *name)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
+		    struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
+		    struct dentry *dentry, const char *acl_name)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
+		    struct dentry *dentry, const char *acl_name)
+LSM_PLAIN_INT_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
+LSM_PLAIN_INT_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
+		   struct dentry *dentry)
+LSM_CUSTOM_INT_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
+		    struct inode *inode, const char *name, void **buffer, bool alloc)
+LSM_CUSTOM_INT_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
+		    const char *name, const void *value, size_t size, int flags)
+LSM_CUSTOM_INT_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
+		    size_t buffer_size)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
+LSM_PLAIN_INT_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
+LSM_CUSTOM_INT_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
+LSM_PLAIN_INT_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
+		   struct kernfs_node *kn)
+LSM_CUSTOM_INT_HOOK(int, 0, file_permission, struct file *file, int mask)
+LSM_PLAIN_INT_HOOK(int, 0, file_alloc_security, struct file *file)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
+LSM_PLAIN_INT_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
+		   unsigned long arg)
+LSM_PLAIN_INT_HOOK(int, 0, mmap_addr, unsigned long addr)
+LSM_CUSTOM_INT_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
+		    unsigned long prot, unsigned long flags)
+LSM_CUSTOM_INT_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
+		    unsigned long reqprot, unsigned long prot)
+LSM_PLAIN_INT_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
+LSM_PLAIN_INT_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
+		   unsigned long arg)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
+LSM_PLAIN_INT_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
+		   struct fown_struct *fown, int sig)
+LSM_PLAIN_INT_HOOK(int, 0, file_receive, struct file *file)
+LSM_CUSTOM_INT_HOOK(int, 0, file_open, struct file *file)
+LSM_PLAIN_INT_HOOK(int, 0, file_truncate, struct file *file)
+LSM_CUSTOM_INT_HOOK(int, 0, task_alloc, struct task_struct *task,
+		    unsigned long clone_flags)
+LSM_SPECIAL_VOID_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
+LSM_CUSTOM_INT_HOOK(int, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, cred_free, struct cred *cred)
+LSM_PLAIN_INT_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
+		   gfp_t gfp)
+LSM_SPECIAL_VOID_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
+		      const struct cred *old)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
+LSM_PLAIN_INT_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
+LSM_PLAIN_INT_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
+LSM_CUSTOM_INT_HOOK(int, 0, kernel_module_request, char *kmod_name)
+LSM_CUSTOM_INT_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
+LSM_CUSTOM_INT_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
+		    enum kernel_load_data_id id, char *description)
+LSM_CUSTOM_INT_HOOK(int, 0, kernel_read_file, struct file *file,
+		    enum kernel_read_file_id id, bool contents)
+LSM_CUSTOM_INT_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
+		    loff_t size, enum kernel_read_file_id id)
+LSM_PLAIN_INT_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
+		   int flags)
+LSM_PLAIN_INT_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred *old,
+		   int flags)
+LSM_PLAIN_INT_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred *old)
+LSM_PLAIN_INT_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
+LSM_PLAIN_INT_HOOK(int, 0, task_getpgid, struct task_struct *p)
+LSM_PLAIN_INT_HOOK(int, 0, task_getsid, struct task_struct *p)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
+		     struct task_struct *p, u32 *secid)
+LSM_PLAIN_INT_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
+LSM_PLAIN_INT_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
+LSM_PLAIN_INT_HOOK(int, 0, task_getioprio, struct task_struct *p)
+LSM_PLAIN_INT_HOOK(int, 0, task_prlimit, const struct cred *cred,
+		   const struct cred *tcred, unsigned int flags)
+LSM_PLAIN_INT_HOOK(int, 0, task_setrlimit, struct task_struct *p, unsigned int resource,
+		   struct rlimit *new_rlim)
+LSM_PLAIN_INT_HOOK(int, 0, task_setscheduler, struct task_struct *p)
+LSM_PLAIN_INT_HOOK(int, 0, task_getscheduler, struct task_struct *p)
+LSM_PLAIN_INT_HOOK(int, 0, task_movememory, struct task_struct *p)
+LSM_PLAIN_INT_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_siginfo *info,
+		   int sig, const struct cred *cred)
+LSM_SPECIAL_INT_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
+		     unsigned long arg3, unsigned long arg4, unsigned long arg5)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
+		    struct inode *inode)
+LSM_SPECIAL_INT_HOOK(int, 0, userns_create, const struct cred *cred)
+LSM_PLAIN_INT_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
+		     u32 *secid)
+LSM_PLAIN_INT_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
+LSM_PLAIN_INT_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, msg_queue_free_security,
+		    struct kern_ipc_perm *perm)
+LSM_PLAIN_INT_HOOK(int, 0, msg_queue_associate, struct kern_ipc_perm *perm, int msqflg)
+LSM_PLAIN_INT_HOOK(int, 0, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
+LSM_PLAIN_INT_HOOK(int, 0, msg_queue_msgsnd, struct kern_ipc_perm *perm,
+		   struct msg_msg *msg, int msqflg)
+LSM_PLAIN_INT_HOOK(int, 0, msg_queue_msgrcv, struct kern_ipc_perm *perm,
+		   struct msg_msg *msg, struct task_struct *target, long type, int mode)
+LSM_PLAIN_INT_HOOK(int, 0, shm_alloc_security, struct kern_ipc_perm *perm)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, shm_free_security, struct kern_ipc_perm *perm)
+LSM_PLAIN_INT_HOOK(int, 0, shm_associate, struct kern_ipc_perm *perm, int shmflg)
+LSM_PLAIN_INT_HOOK(int, 0, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
+LSM_PLAIN_INT_HOOK(int, 0, shm_shmat, struct kern_ipc_perm *perm, char __user *shmaddr,
+		   int shmflg)
+LSM_PLAIN_INT_HOOK(int, 0, sem_alloc_security, struct kern_ipc_perm *perm)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sem_free_security, struct kern_ipc_perm *perm)
+LSM_PLAIN_INT_HOOK(int, 0, sem_associate, struct kern_ipc_perm *perm, int semflg)
+LSM_PLAIN_INT_HOOK(int, 0, sem_semctl, struct kern_ipc_perm *perm, int cmd)
+LSM_PLAIN_INT_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
+		   unsigned int nsops, int alter)
+LSM_PLAIN_INT_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
+		     struct inode *inode)
+LSM_SPECIAL_INT_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
+		     char **value)
+LSM_SPECIAL_INT_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
+LSM_PLAIN_INT_HOOK(int, 0, ismaclabel, const char *name)
+LSM_PLAIN_INT_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
+		   u32 *seclen)
+LSM_CUSTOM_INT_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
+LSM_CUSTOM_VOID_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
+LSM_PLAIN_INT_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
+LSM_PLAIN_INT_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
+LSM_SPECIAL_INT_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
+		     u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
-LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
-	 const struct cred *cred, struct watch_notification *n)
+LSM_PLAIN_INT_HOOK(int, 0, post_notification, const struct cred *w_cred,
+		   const struct cred *cred, struct watch_notification *n)
 #endif /* CONFIG_SECURITY && CONFIG_WATCH_QUEUE */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
-LSM_HOOK(int, 0, watch_key, struct key *key)
+LSM_PLAIN_INT_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
-LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
-	 struct sock *newsk)
-LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
-LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
-LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
-	 int protocol, int kern)
-LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
-LSM_HOOK(int, 0, socket_bind, struct socket *sock, struct sockaddr *address,
-	 int addrlen)
-LSM_HOOK(int, 0, socket_connect, struct socket *sock, struct sockaddr *address,
-	 int addrlen)
-LSM_HOOK(int, 0, socket_listen, struct socket *sock, int backlog)
-LSM_HOOK(int, 0, socket_accept, struct socket *sock, struct socket *newsock)
-LSM_HOOK(int, 0, socket_sendmsg, struct socket *sock, struct msghdr *msg,
-	 int size)
-LSM_HOOK(int, 0, socket_recvmsg, struct socket *sock, struct msghdr *msg,
-	 int size, int flags)
-LSM_HOOK(int, 0, socket_getsockname, struct socket *sock)
-LSM_HOOK(int, 0, socket_getpeername, struct socket *sock)
-LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
-LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
-LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
-LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
-	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
-	 struct sk_buff *skb, u32 *secid)
-LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
-LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
-LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk,
-	 struct sock *newsk)
-LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, const struct sock *sk, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socket *parent)
-LSM_HOOK(int, 0, inet_conn_request, const struct sock *sk, struct sk_buff *skb,
-	 struct request_sock *req)
-LSM_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk,
-	 const struct request_sock *req)
-LSM_HOOK(void, LSM_RET_VOID, inet_conn_established, struct sock *sk,
-	 struct sk_buff *skb)
-LSM_HOOK(int, 0, secmark_relabel_packet, u32 secid)
-LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
-LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
-LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
-	 struct flowi_common *flic)
-LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
-LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
-LSM_HOOK(int, 0, tun_dev_create, void)
-LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
-LSM_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
-LSM_HOOK(int, 0, tun_dev_open, void *security)
-LSM_HOOK(int, 0, sctp_assoc_request, struct sctp_association *asoc,
-	 struct sk_buff *skb)
-LSM_HOOK(int, 0, sctp_bind_connect, struct sock *sk, int optname,
-	 struct sockaddr *address, int addrlen)
-LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_association *asoc,
-	 struct sock *sk, struct sock *newsk)
-LSM_HOOK(int, 0, sctp_assoc_established, struct sctp_association *asoc,
-	 struct sk_buff *skb)
-LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
+LSM_PLAIN_INT_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
+		   struct sock *newsk)
+LSM_PLAIN_INT_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
+LSM_PLAIN_INT_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
+LSM_PLAIN_INT_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
+		   int protocol, int kern)
+LSM_PLAIN_INT_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
+LSM_PLAIN_INT_HOOK(int, 0, socket_bind, struct socket *sock, struct sockaddr *address,
+		   int addrlen)
+LSM_PLAIN_INT_HOOK(int, 0, socket_connect, struct socket *sock, struct sockaddr *address,
+		   int addrlen)
+LSM_PLAIN_INT_HOOK(int, 0, socket_listen, struct socket *sock, int backlog)
+LSM_PLAIN_INT_HOOK(int, 0, socket_accept, struct socket *sock, struct socket *newsock)
+LSM_PLAIN_INT_HOOK(int, 0, socket_sendmsg, struct socket *sock, struct msghdr *msg,
+		   int size)
+LSM_PLAIN_INT_HOOK(int, 0, socket_recvmsg, struct socket *sock, struct msghdr *msg,
+		   int size, int flags)
+LSM_PLAIN_INT_HOOK(int, 0, socket_getsockname, struct socket *sock)
+LSM_PLAIN_INT_HOOK(int, 0, socket_getpeername, struct socket *sock)
+LSM_PLAIN_INT_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
+LSM_PLAIN_INT_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
+LSM_PLAIN_INT_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
+LSM_SPECIAL_INT_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
+LSM_SPECIAL_INT_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
+		     sockptr_t optval, sockptr_t optlen, unsigned int len)
+LSM_SPECIAL_INT_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
+		     struct sk_buff *skb, u32 *secid)
+LSM_SPECIAL_INT_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
+LSM_SPECIAL_VOID_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
+LSM_SPECIAL_VOID_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk,
+		      struct sock *newsk)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sk_getsecid, const struct sock *sk, u32 *secid)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socket *parent)
+LSM_PLAIN_INT_HOOK(int, 0, inet_conn_request, const struct sock *sk, struct sk_buff *skb,
+		   struct request_sock *req)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk,
+		    const struct request_sock *req)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, inet_conn_established, struct sock *sk,
+		    struct sk_buff *skb)
+LSM_PLAIN_INT_HOOK(int, 0, secmark_relabel_packet, u32 secid)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
+		    struct flowi_common *flic)
+LSM_PLAIN_INT_HOOK(int, 0, tun_dev_alloc_security, void **security)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
+LSM_PLAIN_INT_HOOK(int, 0, tun_dev_create, void)
+LSM_PLAIN_INT_HOOK(int, 0, tun_dev_attach_queue, void *security)
+LSM_PLAIN_INT_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
+LSM_PLAIN_INT_HOOK(int, 0, tun_dev_open, void *security)
+LSM_PLAIN_INT_HOOK(int, 0, sctp_assoc_request, struct sctp_association *asoc,
+		   struct sk_buff *skb)
+LSM_PLAIN_INT_HOOK(int, 0, sctp_bind_connect, struct sock *sk, int optname,
+		   struct sockaddr *address, int addrlen)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_association *asoc,
+		    struct sock *sk, struct sock *newsk)
+LSM_PLAIN_INT_HOOK(int, 0, sctp_assoc_established, struct sctp_association *asoc,
+		   struct sk_buff *skb)
+LSM_PLAIN_INT_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
-LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
-	 u8 port_num)
-LSM_HOOK(int, 0, ib_alloc_security, void **sec)
-LSM_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
+LSM_PLAIN_INT_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
+LSM_PLAIN_INT_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
+		   u8 port_num)
+LSM_PLAIN_INT_HOOK(int, 0, ib_alloc_security, void **sec)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
 #endif /* CONFIG_SECURITY_INFINIBAND */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-LSM_HOOK(int, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
-	 struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp)
-LSM_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
-	 struct xfrm_sec_ctx **new_ctx)
-LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
-	 struct xfrm_sec_ctx *ctx)
-LSM_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
-LSM_HOOK(int, 0, xfrm_state_alloc, struct xfrm_state *x,
-	 struct xfrm_user_sec_ctx *sec_ctx)
-LSM_HOOK(int, 0, xfrm_state_alloc_acquire, struct xfrm_state *x,
-	 struct xfrm_sec_ctx *polsec, u32 secid)
-LSM_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_state *x)
-LSM_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
-LSM_HOOK(int, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid)
-LSM_HOOK(int, 1, xfrm_state_pol_flow_match, struct xfrm_state *x,
-	 struct xfrm_policy *xp, const struct flowi_common *flic)
-LSM_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
-	 int ckall)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
+		   struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
+		   struct xfrm_sec_ctx **new_ctx)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
+		    struct xfrm_sec_ctx *ctx)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_state_alloc, struct xfrm_state *x,
+		   struct xfrm_user_sec_ctx *sec_ctx)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_state_alloc_acquire, struct xfrm_state *x,
+		   struct xfrm_sec_ctx *polsec, u32 secid)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_state *x)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid)
+LSM_SPECIAL_INT_HOOK(int, 1, xfrm_state_pol_flow_match, struct xfrm_state *x,
+		     struct xfrm_policy *xp, const struct flowi_common *flic)
+LSM_PLAIN_INT_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
+		   int ckall)
 #endif /* CONFIG_SECURITY_NETWORK_XFRM */
 
 /* key management security hooks */
 #ifdef CONFIG_KEYS
-LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
-	 unsigned long flags)
-LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
-LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
-	 enum key_need_perm need_perm)
-LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
+LSM_PLAIN_INT_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
+		   unsigned long flags)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
+LSM_PLAIN_INT_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
+		   enum key_need_perm need_perm)
+LSM_CUSTOM_INT_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
-	 void **lsmrule)
-LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
-LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
+LSM_PLAIN_INT_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
+		   void **lsmrule)
+LSM_PLAIN_INT_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
+LSM_PLAIN_INT_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
-LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
-LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
-LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
-LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
-LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
-LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
+LSM_PLAIN_INT_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
+LSM_PLAIN_INT_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
+LSM_PLAIN_INT_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
+LSM_PLAIN_INT_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
+LSM_PLAIN_INT_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
 #endif /* CONFIG_BPF_SYSCALL */
 
-LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
+LSM_PLAIN_INT_HOOK(int, 0, locked_down, enum lockdown_reason what)
 
 #ifdef CONFIG_PERF_EVENTS
-LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
-LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
-LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
-LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
-LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
+LSM_PLAIN_INT_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
+LSM_PLAIN_INT_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
+LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
+LSM_PLAIN_INT_HOOK(int, 0, perf_event_read, struct perf_event *event)
+LSM_PLAIN_INT_HOOK(int, 0, perf_event_write, struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
 
 #ifdef CONFIG_IO_URING
-LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
-LSM_HOOK(int, 0, uring_sqpoll, void)
-LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
+LSM_PLAIN_INT_HOOK(int, 0, uring_override_creds, const struct cred *new)
+LSM_PLAIN_INT_HOOK(int, 0, uring_sqpoll, void)
+LSM_PLAIN_INT_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
 
+#undef LSM_SPECIAL_INT_HOOK
+#undef LSM_CUSTOM_INT_HOOK
+#undef LSM_PLAIN_INT_HOOK
+#undef LSM_SPECIAL_VOID_HOOK
+#undef LSM_CUSTOM_VOID_HOOK
+#undef LSM_PLAIN_VOID_HOOK
 #undef LSM_HOOK
-- 
2.34.1


