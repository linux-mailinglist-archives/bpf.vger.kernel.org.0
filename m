Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DD18FDBD
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgCWTdH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:33:07 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40160 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgCWTdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 15:33:07 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so296913pjb.5
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SvvwV2y6DcvkSkz7PffViBg02iuDSYtkRhPdCvspXO0=;
        b=EMg5vwzAexOVoOFeUB9blxW+uLe0F5sKU7X2z1AIvaoMrNSsY7j668Z9mhjmjVrqSW
         ANxas1MWw6bzIyumKvWyn0LnW6Px4H8VqYOz09FJcJv60xRkQry4gChcURyGsm8tUvDe
         RPS+R0giRlbzazpMcyPke3oTEqym72aHWEkig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SvvwV2y6DcvkSkz7PffViBg02iuDSYtkRhPdCvspXO0=;
        b=SZMcb7gdnbLOT7sSRc53BJgj9CqHB2j4Xz0rmFbiu4X4S73WlXCl9TMz8+GGoKC4eL
         /34VVUT3WyvJmNDBCPXVN9ylFeI0aEyEIZqA1Ra5USpXqhOPwsz/Px+WzwKLC5/KhHOR
         +pbPjyAWh/zIF3fk96RnShIxWGsCVLTI4Nk4vbTaiYqWstaam3qfcT8lh3lxuOLliZ09
         NYlnSxN4FEGliAEJGOvgnhYvU342ZLU6Aq67Plm+zA5pb7n4aGASHvywlLjsInb62ZOv
         5AJXMW5aV+4uIq0uNCcsfzV413TiWnrkXjT9fa7Ib+pbT8+zryImhjBtt71yuvtjhJzc
         flQQ==
X-Gm-Message-State: ANhLgQ0J1zS80g7LMzpK1LV+Yn0logetENM5xVlq7SVG8UI/nISDxCxB
        JlPaTI4cttM8t+AOEtmSozfBWQ==
X-Google-Smtp-Source: ADFU+vunnjLhJQui+NXuZc2yakn4L/QtX7Y6whSb+hgJ7KgL7+9LUcZJC88gC0vexjEreL95cTQpug==
X-Received: by 2002:a17:90b:370c:: with SMTP id mg12mr949659pjb.96.1584991983778;
        Mon, 23 Mar 2020 12:33:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l17sm12648575pgi.71.2020.03.23.12.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:33:02 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:33:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 2/7] security: Refactor declaration of LSM
 hooks
Message-ID: <202003231232.5895269B@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-3-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323164415.12943-3-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 05:44:10PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The information about the different types of LSM hooks is scattered
> in two locations i.e. union security_list_options and
> struct security_hook_heads. Rather than duplicating this information
> even further for BPF_PROG_TYPE_LSM, define all the hooks with the
> LSM_HOOK macro in lsm_hook_names.h which is then used to generate all
> the data structures required by the LSM framework.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

The duplicate code removal provided here is alone worth landing this
patch. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  include/linux/lsm_hook_names.h | 354 +++++++++++++++++++
>  include/linux/lsm_hooks.h      | 622 +--------------------------------
>  2 files changed, 360 insertions(+), 616 deletions(-)
>  create mode 100644 include/linux/lsm_hook_names.h
> 
> diff --git a/include/linux/lsm_hook_names.h b/include/linux/lsm_hook_names.h
> new file mode 100644
> index 000000000000..412e4ca24c9b
> --- /dev/null
> +++ b/include/linux/lsm_hook_names.h
> @@ -0,0 +1,354 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Linux Security Module Hook declarations.
> + *
> + * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
> + * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
> + * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
> + * Copyright (C) 2001 James Morris <jmorris@intercode.com.au>
> + * Copyright (C) 2001 Silicon Graphics, Inc. (Trust Technology Group)
> + * Copyright (C) 2015 Intel Corporation.
> + * Copyright (C) 2015 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2016 Mellanox Techonologies
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +/* The macro LSM_HOOK is used to define the data structures required by the
> + * the LSM framework using the pattern:
> + *
> + * struct security_hook_heads {
> + *   #define LSM_HOOK(RET, NAME, ...) struct hlist_head NAME;
> + *   #include <linux/lsm_hook_names.h>
> + *   #undef LSM_HOOK
> + * };
> + */
> +LSM_HOOK(int, binder_set_context_mgr, struct task_struct *mgr)
> +LSM_HOOK(int, binder_transaction, struct task_struct *from,
> +	 struct task_struct *to)
> +LSM_HOOK(int, binder_transfer_binder, struct task_struct *from,
> +	 struct task_struct *to)
> +LSM_HOOK(int, binder_transfer_file, struct task_struct *from,
> +	 struct task_struct *to, struct file *file)
> +LSM_HOOK(int, ptrace_access_check, struct task_struct *child, unsigned int mode)
> +LSM_HOOK(int, ptrace_traceme, struct task_struct *parent)
> +LSM_HOOK(int, capget, struct task_struct *target, kernel_cap_t *effective,
> +	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
> +LSM_HOOK(int, capset, struct cred *new, const struct cred *old,
> +	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
> +	 const kernel_cap_t *permitted)
> +LSM_HOOK(int, capable, const struct cred *cred, struct user_namespace *ns,
> +	 int cap, unsigned int opts)
> +LSM_HOOK(int, quotactl, int cmds, int type, int id, struct super_block *sb)
> +LSM_HOOK(int, quota_on, struct dentry *dentry)
> +LSM_HOOK(int, syslog, int type)
> +LSM_HOOK(int, settime, const struct timespec64 *ts, const struct timezone *tz)
> +LSM_HOOK(int, vm_enough_memory, struct mm_struct *mm, long pages)
> +LSM_HOOK(int, bprm_set_creds, struct linux_binprm *bprm)
> +LSM_HOOK(int, bprm_check_security, struct linux_binprm *bprm)
> +LSM_HOOK(void, bprm_committing_creds, struct linux_binprm *bprm)
> +LSM_HOOK(void, bprm_committed_creds, struct linux_binprm *bprm)
> +LSM_HOOK(int, fs_context_dup, struct fs_context *fc, struct fs_context *src_sc)
> +LSM_HOOK(int, fs_context_parse_param, struct fs_context *fc,
> +	 struct fs_parameter *param)
> +LSM_HOOK(int, sb_alloc_security, struct super_block *sb)
> +LSM_HOOK(void, sb_free_security, struct super_block *sb)
> +LSM_HOOK(void, sb_free_mnt_opts, void *mnt_opts)
> +LSM_HOOK(int, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> +LSM_HOOK(int, sb_remount, struct super_block *sb, void *mnt_opts)
> +LSM_HOOK(int, sb_kern_mount, struct super_block *sb)
> +LSM_HOOK(int, sb_show_options, struct seq_file *m, struct super_block *sb)
> +LSM_HOOK(int, sb_statfs, struct dentry *dentry)
> +LSM_HOOK(int, sb_mount, const char *dev_name, const struct path *path,
> +	 const char *type, unsigned long flags, void *data)
> +LSM_HOOK(int, sb_umount, struct vfsmount *mnt, int flags)
> +LSM_HOOK(int, sb_pivotroot, const struct path *old_path,
> +	 const struct path *new_path)
> +LSM_HOOK(int, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
> +	 unsigned long kern_flags, unsigned long *set_kern_flags)
> +LSM_HOOK(int, sb_clone_mnt_opts, const struct super_block *oldsb,
> +	 struct super_block *newsb, unsigned long kern_flags,
> +	 unsigned long *set_kern_flags)
> +LSM_HOOK(int, sb_add_mnt_opt, const char *option, const char *val, int len,
> +	 void **mnt_opts)
> +LSM_HOOK(int, move_mount, const struct path *from_path,
> +	 const struct path *to_path)
> +LSM_HOOK(int, dentry_init_security, struct dentry *dentry, int mode,
> +	 const struct qstr *name, void **ctx, u32 *ctxlen)
> +LSM_HOOK(int, dentry_create_files_as, struct dentry *dentry, int mode,
> +	 struct qstr *name, const struct cred *old, struct cred *new)
> +#ifdef CONFIG_SECURITY_PATH
> +LSM_HOOK(int, path_unlink, const struct path *dir, struct dentry *dentry)
> +LSM_HOOK(int, path_mkdir, const struct path *dir, struct dentry *dentry,
> +	 umode_t mode)
> +LSM_HOOK(int, path_rmdir, const struct path *dir, struct dentry *dentry)
> +LSM_HOOK(int, path_mknod, const struct path *dir, struct dentry *dentry,
> +	 umode_t mode, unsigned int dev)
> +LSM_HOOK(int, path_truncate, const struct path *path)
> +LSM_HOOK(int, path_symlink, const struct path *dir, struct dentry *dentry,
> +	 const char *old_name)
> +LSM_HOOK(int, path_link, struct dentry *old_dentry, const struct path *new_dir,
> +	 struct dentry *new_dentry)
> +LSM_HOOK(int, path_rename, const struct path *old_dir,
> +	 struct dentry *old_dentry, const struct path *new_dir,
> +	 struct dentry *new_dentry)
> +LSM_HOOK(int, path_chmod, const struct path *path, umode_t mode)
> +LSM_HOOK(int, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
> +LSM_HOOK(int, path_chroot, const struct path *path)
> +#endif
> +
> +/* Needed for inode based security check */
> +LSM_HOOK(int, path_notify, const struct path *path, u64 mask,
> +	 unsigned int obj_type)
> +LSM_HOOK(int, inode_alloc_security, struct inode *inode)
> +LSM_HOOK(void, inode_free_security, struct inode *inode)
> +LSM_HOOK(int, inode_init_security, struct inode *inode, struct inode *dir,
> +	 const struct qstr *qstr, const char **name, void **value, size_t *len)
> +LSM_HOOK(int, inode_create, struct inode *dir, struct dentry *dentry,
> +	 umode_t mode)
> +LSM_HOOK(int, inode_link, struct dentry *old_dentry, struct inode *dir,
> +	 struct dentry *new_dentry)
> +LSM_HOOK(int, inode_unlink, struct inode *dir, struct dentry *dentry)
> +LSM_HOOK(int, inode_symlink, struct inode *dir, struct dentry *dentry,
> +	 const char *old_name)
> +LSM_HOOK(int, inode_mkdir, struct inode *dir, struct dentry *dentry,
> +	 umode_t mode)
> +LSM_HOOK(int, inode_rmdir, struct inode *dir, struct dentry *dentry)
> +LSM_HOOK(int, inode_mknod, struct inode *dir, struct dentry *dentry,
> +	 umode_t mode, dev_t dev)
> +LSM_HOOK(int, inode_rename, struct inode *old_dir, struct dentry *old_dentry,
> +	 struct inode *new_dir, struct dentry *new_dentry)
> +LSM_HOOK(int, inode_readlink, struct dentry *dentry)
> +LSM_HOOK(int, inode_follow_link, struct dentry *dentry, struct inode *inode,
> +	 bool rcu)
> +LSM_HOOK(int, inode_permission, struct inode *inode, int mask)
> +LSM_HOOK(int, inode_setattr, struct dentry *dentry, struct iattr *attr)
> +LSM_HOOK(int, inode_getattr, const struct path *path)
> +LSM_HOOK(int, inode_setxattr, struct dentry *dentry, const char *name,
> +	 const void *value, size_t size, int flags)
> +LSM_HOOK(void, inode_post_setxattr, struct dentry *dentry, const char *name,
> +	 const void *value, size_t size, int flags)
> +LSM_HOOK(int, inode_getxattr, struct dentry *dentry, const char *name)
> +LSM_HOOK(int, inode_listxattr, struct dentry *dentry)
> +LSM_HOOK(int, inode_removexattr, struct dentry *dentry, const char *name)
> +LSM_HOOK(int, inode_need_killpriv, struct dentry *dentry)
> +LSM_HOOK(int, inode_killpriv, struct dentry *dentry)
> +LSM_HOOK(int, inode_getsecurity, struct inode *inode, const char *name,
> +	 void **buffer, bool alloc)
> +LSM_HOOK(int, inode_setsecurity, struct inode *inode, const char *name,
> +	 const void *value, size_t size, int flags)
> +LSM_HOOK(int, inode_listsecurity, struct inode *inode, char *buffer,
> +	 size_t buffer_size)
> +LSM_HOOK(void, inode_getsecid, struct inode *inode, u32 *secid)
> +LSM_HOOK(int, inode_copy_up, struct dentry *src, struct cred **new)
> +LSM_HOOK(int, inode_copy_up_xattr, const char *name)
> +LSM_HOOK(int, kernfs_init_security, struct kernfs_node *kn_dir,
> +	 struct kernfs_node *kn)
> +LSM_HOOK(int, file_permission, struct file *file, int mask)
> +LSM_HOOK(int, file_alloc_security, struct file *file)
> +LSM_HOOK(void, file_free_security, struct file *file)
> +LSM_HOOK(int, file_ioctl, struct file *file, unsigned int cmd,
> +	 unsigned long arg)
> +LSM_HOOK(int, mmap_addr, unsigned long addr)
> +LSM_HOOK(int, mmap_file, struct file *file, unsigned long reqprot,
> +	 unsigned long prot, unsigned long flags)
> +LSM_HOOK(int, file_mprotect, struct vm_area_struct *vma, unsigned long reqprot,
> +	 unsigned long prot)
> +LSM_HOOK(int, file_lock, struct file *file, unsigned int cmd)
> +LSM_HOOK(int, file_fcntl, struct file *file, unsigned int cmd,
> +	 unsigned long arg)
> +LSM_HOOK(void, file_set_fowner, struct file *file)
> +LSM_HOOK(int, file_send_sigiotask, struct task_struct *tsk,
> +	 struct fown_struct *fown, int sig)
> +LSM_HOOK(int, file_receive, struct file *file)
> +LSM_HOOK(int, file_open, struct file *file)
> +LSM_HOOK(int, task_alloc, struct task_struct *task, unsigned long clone_flags)
> +LSM_HOOK(void, task_free, struct task_struct *task)
> +LSM_HOOK(int, cred_alloc_blank, struct cred *cred, gfp_t gfp)
> +LSM_HOOK(void, cred_free, struct cred *cred)
> +LSM_HOOK(int, cred_prepare, struct cred *new, const struct cred *old, gfp_t gfp)
> +LSM_HOOK(void, cred_transfer, struct cred *new, const struct cred *old)
> +LSM_HOOK(void, cred_getsecid, const struct cred *c, u32 *secid)
> +LSM_HOOK(int, kernel_act_as, struct cred *new, u32 secid)
> +LSM_HOOK(int, kernel_create_files_as, struct cred *new, struct inode *inode)
> +LSM_HOOK(int, kernel_module_request, char *kmod_name)
> +LSM_HOOK(int, kernel_load_data, enum kernel_load_data_id id)
> +LSM_HOOK(int, kernel_read_file, struct file *file, enum kernel_read_file_id id)
> +LSM_HOOK(int, kernel_post_read_file, struct file *file, char *buf, loff_t size,
> +	 enum kernel_read_file_id id)
> +LSM_HOOK(int, task_fix_setuid, struct cred *new, const struct cred *old,
> +	 int flags)
> +LSM_HOOK(int, task_setpgid, struct task_struct *p, pid_t pgid)
> +LSM_HOOK(int, task_getpgid, struct task_struct *p)
> +LSM_HOOK(int, task_getsid, struct task_struct *p)
> +LSM_HOOK(void, task_getsecid, struct task_struct *p, u32 *secid)
> +LSM_HOOK(int, task_setnice, struct task_struct *p, int nice)
> +LSM_HOOK(int, task_setioprio, struct task_struct *p, int ioprio)
> +LSM_HOOK(int, task_getioprio, struct task_struct *p)
> +LSM_HOOK(int, task_prlimit, const struct cred *cred, const struct cred *tcred,
> +	 unsigned int flags)
> +LSM_HOOK(int, task_setrlimit, struct task_struct *p, unsigned int resource,
> +	 struct rlimit *new_rlim)
> +LSM_HOOK(int, task_setscheduler, struct task_struct *p)
> +LSM_HOOK(int, task_getscheduler, struct task_struct *p)
> +LSM_HOOK(int, task_movememory, struct task_struct *p)
> +LSM_HOOK(int, task_kill, struct task_struct *p, struct kernel_siginfo *info,
> +	 int sig, const struct cred *cred)
> +LSM_HOOK(int, task_prctl, int option, unsigned long arg2, unsigned long arg3,
> +	 unsigned long arg4, unsigned long arg5)
> +LSM_HOOK(void, task_to_inode, struct task_struct *p, struct inode *inode)
> +LSM_HOOK(int, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> +LSM_HOOK(void, ipc_getsecid, struct kern_ipc_perm *ipcp, u32 *secid)
> +LSM_HOOK(int, msg_msg_alloc_security, struct msg_msg *msg)
> +LSM_HOOK(void, msg_msg_free_security, struct msg_msg *msg)
> +LSM_HOOK(int, msg_queue_alloc_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(void, msg_queue_free_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(int, msg_queue_associate, struct kern_ipc_perm *perm, int msqflg)
> +LSM_HOOK(int, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
> +LSM_HOOK(int, msg_queue_msgsnd, struct kern_ipc_perm *perm, struct msg_msg *msg,
> +	 int msqflg)
> +LSM_HOOK(int, msg_queue_msgrcv, struct kern_ipc_perm *perm, struct msg_msg *msg,
> +	 struct task_struct *target, long type, int mode)
> +LSM_HOOK(int, shm_alloc_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(void, shm_free_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(int, shm_associate, struct kern_ipc_perm *perm, int shmflg)
> +LSM_HOOK(int, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
> +LSM_HOOK(int, shm_shmat, struct kern_ipc_perm *perm, char __user *shmaddr,
> +	 int shmflg)
> +LSM_HOOK(int, sem_alloc_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(void, sem_free_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(int, sem_associate, struct kern_ipc_perm *perm, int semflg)
> +LSM_HOOK(int, sem_semctl, struct kern_ipc_perm *perm, int cmd)
> +LSM_HOOK(int, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
> +	 unsigned nsops, int alter)
> +LSM_HOOK(int, netlink_send, struct sock *sk, struct sk_buff *skb)
> +LSM_HOOK(void, d_instantiate, struct dentry *dentry, struct inode *inode)
> +LSM_HOOK(int, getprocattr, struct task_struct *p, char *name, char **value)
> +LSM_HOOK(int, setprocattr, const char *name, void *value, size_t size)
> +LSM_HOOK(int, ismaclabel, const char *name)
> +LSM_HOOK(int, secid_to_secctx, u32 secid, char **secdata, u32 *seclen)
> +LSM_HOOK(int, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
> +LSM_HOOK(void, release_secctx, char *secdata, u32 seclen)
> +LSM_HOOK(void, inode_invalidate_secctx, struct inode *inode)
> +LSM_HOOK(int, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
> +LSM_HOOK(int, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
> +LSM_HOOK(int, inode_getsecctx, struct inode *inode, void **ctx, u32 *ctxlen)
> +#ifdef CONFIG_SECURITY_NETWORK
> +LSM_HOOK(int, unix_stream_connect, struct sock *sock, struct sock *other,
> +	 struct sock *newsk)
> +LSM_HOOK(int, unix_may_send, struct socket *sock, struct socket *other)
> +LSM_HOOK(int, socket_create, int family, int type, int protocol, int kern)
> +LSM_HOOK(int, socket_post_create, struct socket *sock, int family, int type,
> +	 int protocol, int kern)
> +LSM_HOOK(int, socket_socketpair, struct socket *socka, struct socket *sockb)
> +LSM_HOOK(int, socket_bind, struct socket *sock, struct sockaddr *address,
> +	 int addrlen)
> +LSM_HOOK(int, socket_connect, struct socket *sock, struct sockaddr *address,
> +	 int addrlen)
> +LSM_HOOK(int, socket_listen, struct socket *sock, int backlog)
> +LSM_HOOK(int, socket_accept, struct socket *sock, struct socket *newsock)
> +LSM_HOOK(int, socket_sendmsg, struct socket *sock, struct msghdr *msg, int size)
> +LSM_HOOK(int, socket_recvmsg, struct socket *sock, struct msghdr *msg, int size,
> +	 int flags)
> +LSM_HOOK(int, socket_getsockname, struct socket *sock)
> +LSM_HOOK(int, socket_getpeername, struct socket *sock)
> +LSM_HOOK(int, socket_getsockopt, struct socket *sock, int level, int optname)
> +LSM_HOOK(int, socket_setsockopt, struct socket *sock, int level, int optname)
> +LSM_HOOK(int, socket_shutdown, struct socket *sock, int how)
> +LSM_HOOK(int, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
> +LSM_HOOK(int, socket_getpeersec_stream, struct socket *sock,
> +	 char __user *optval, int __user *optlen, unsigned len)
> +LSM_HOOK(int, socket_getpeersec_dgram, struct socket *sock, struct sk_buff *skb,
> +	 u32 *secid)
> +LSM_HOOK(int, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
> +LSM_HOOK(void, sk_free_security, struct sock *sk)
> +LSM_HOOK(void, sk_clone_security, const struct sock *sk, struct sock *newsk)
> +LSM_HOOK(void, sk_getsecid, struct sock *sk, u32 *secid)
> +LSM_HOOK(void, sock_graft, struct sock *sk, struct socket *parent)
> +LSM_HOOK(int, inet_conn_request, struct sock *sk, struct sk_buff *skb,
> +	 struct request_sock *req)
> +LSM_HOOK(void, inet_csk_clone, struct sock *newsk,
> +	 const struct request_sock *req)
> +LSM_HOOK(void, inet_conn_established, struct sock *sk, struct sk_buff *skb)
> +LSM_HOOK(int, secmark_relabel_packet, u32 secid)
> +LSM_HOOK(void, secmark_refcount_inc, void)
> +LSM_HOOK(void, secmark_refcount_dec, void)
> +LSM_HOOK(void, req_classify_flow, const struct request_sock *req,
> +	 struct flowi *fl)
> +LSM_HOOK(int, tun_dev_alloc_security, void **security)
> +LSM_HOOK(void, tun_dev_free_security, void *security)
> +LSM_HOOK(int, tun_dev_create, void)
> +LSM_HOOK(int, tun_dev_attach_queue, void *security)
> +LSM_HOOK(int, tun_dev_attach, struct sock *sk, void *security)
> +LSM_HOOK(int, tun_dev_open, void *security)
> +LSM_HOOK(int, sctp_assoc_request, struct sctp_endpoint *ep, struct sk_buff *skb)
> +LSM_HOOK(int, sctp_bind_connect, struct sock *sk, int optname,
> +	 struct sockaddr *address, int addrlen)
> +LSM_HOOK(void, sctp_sk_clone, struct sctp_endpoint *ep, struct sock *sk,
> +	 struct sock *newsk)
> +#endif /* CONFIG_SECURITY_NETWORK */
> +
> +#ifdef CONFIG_SECURITY_INFINIBAND
> +LSM_HOOK(int, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
> +LSM_HOOK(int, ib_endport_manage_subnet, void *sec, const char *dev_name,
> +	 u8 port_num)
> +LSM_HOOK(int, ib_alloc_security, void **sec)
> +LSM_HOOK(void, ib_free_security, void *sec)
> +#endif /* CONFIG_SECURITY_INFINIBAND */
> +
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +LSM_HOOK(int, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
> +	 struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp)
> +LSM_HOOK(int, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
> +	 struct xfrm_sec_ctx **new_ctx)
> +LSM_HOOK(void, xfrm_policy_free_security, struct xfrm_sec_ctx *ctx)
> +LSM_HOOK(int, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
> +LSM_HOOK(int, xfrm_state_alloc, struct xfrm_state *x,
> +	 struct xfrm_user_sec_ctx *sec_ctx)
> +LSM_HOOK(int, xfrm_state_alloc_acquire, struct xfrm_state *x,
> +	 struct xfrm_sec_ctx *polsec, u32 secid)
> +LSM_HOOK(void, xfrm_state_free_security, struct xfrm_state *x)
> +LSM_HOOK(int, xfrm_state_delete_security, struct xfrm_state *x)
> +LSM_HOOK(int, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid,
> +	 u8 dir)
> +LSM_HOOK(int, xfrm_state_pol_flow_match, struct xfrm_state *x,
> +	 struct xfrm_policy *xp, const struct flowi *fl)
> +LSM_HOOK(int, xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
> +#endif /* CONFIG_SECURITY_NETWORK_XFRM */
> +
> +/* key management security hooks */
> +#ifdef CONFIG_KEYS
> +LSM_HOOK(int, key_alloc, struct key *key, const struct cred *cred,
> +	 unsigned long flags)
> +LSM_HOOK(void, key_free, struct key *key)
> +LSM_HOOK(int, key_permission, key_ref_t key_ref, const struct cred *cred,
> +	 unsigned perm)
> +LSM_HOOK(int, key_getsecurity, struct key *key, char **_buffer)
> +#endif /* CONFIG_KEYS */
> +
> +#ifdef CONFIG_AUDIT
> +LSM_HOOK(int, audit_rule_init, u32 field, u32 op, char *rulestr, void **lsmrule)
> +LSM_HOOK(int, audit_rule_known, struct audit_krule *krule)
> +LSM_HOOK(int, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
> +LSM_HOOK(void, audit_rule_free, void *lsmrule)
> +#endif /* CONFIG_AUDIT */
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +LSM_HOOK(int, bpf, int cmd, union bpf_attr *attr, unsigned int size)
> +LSM_HOOK(int, bpf_map, struct bpf_map *map, fmode_t fmode)
> +LSM_HOOK(int, bpf_prog, struct bpf_prog *prog)
> +LSM_HOOK(int, bpf_map_alloc_security, struct bpf_map *map)
> +LSM_HOOK(void, bpf_map_free_security, struct bpf_map *map)
> +LSM_HOOK(int, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
> +LSM_HOOK(void, bpf_prog_free_security, struct bpf_prog_aux *aux)
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +LSM_HOOK(int, locked_down, enum lockdown_reason what)
> +
> +#ifdef CONFIG_PERF_EVENTS
> +LSM_HOOK(int, perf_event_open, struct perf_event_attr *attr, int type)
> +LSM_HOOK(int, perf_event_alloc, struct perf_event *event)
> +LSM_HOOK(void, perf_event_free, struct perf_event *event)
> +LSM_HOOK(int, perf_event_read, struct perf_event *event)
> +LSM_HOOK(int, perf_event_write, struct perf_event *event)
> +#endif
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..905954c650ff 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1456,625 +1456,15 @@
>   *     @what: kernel feature being accessed
>   */
>  union security_list_options {
> -	int (*binder_set_context_mgr)(struct task_struct *mgr);
> -	int (*binder_transaction)(struct task_struct *from,
> -					struct task_struct *to);
> -	int (*binder_transfer_binder)(struct task_struct *from,
> -					struct task_struct *to);
> -	int (*binder_transfer_file)(struct task_struct *from,
> -					struct task_struct *to,
> -					struct file *file);
> -
> -	int (*ptrace_access_check)(struct task_struct *child,
> -					unsigned int mode);
> -	int (*ptrace_traceme)(struct task_struct *parent);
> -	int (*capget)(struct task_struct *target, kernel_cap_t *effective,
> -			kernel_cap_t *inheritable, kernel_cap_t *permitted);
> -	int (*capset)(struct cred *new, const struct cred *old,
> -			const kernel_cap_t *effective,
> -			const kernel_cap_t *inheritable,
> -			const kernel_cap_t *permitted);
> -	int (*capable)(const struct cred *cred,
> -			struct user_namespace *ns,
> -			int cap,
> -			unsigned int opts);
> -	int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
> -	int (*quota_on)(struct dentry *dentry);
> -	int (*syslog)(int type);
> -	int (*settime)(const struct timespec64 *ts, const struct timezone *tz);
> -	int (*vm_enough_memory)(struct mm_struct *mm, long pages);
> -
> -	int (*bprm_set_creds)(struct linux_binprm *bprm);
> -	int (*bprm_check_security)(struct linux_binprm *bprm);
> -	void (*bprm_committing_creds)(struct linux_binprm *bprm);
> -	void (*bprm_committed_creds)(struct linux_binprm *bprm);
> -
> -	int (*fs_context_dup)(struct fs_context *fc, struct fs_context *src_sc);
> -	int (*fs_context_parse_param)(struct fs_context *fc, struct fs_parameter *param);
> -
> -	int (*sb_alloc_security)(struct super_block *sb);
> -	void (*sb_free_security)(struct super_block *sb);
> -	void (*sb_free_mnt_opts)(void *mnt_opts);
> -	int (*sb_eat_lsm_opts)(char *orig, void **mnt_opts);
> -	int (*sb_remount)(struct super_block *sb, void *mnt_opts);
> -	int (*sb_kern_mount)(struct super_block *sb);
> -	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
> -	int (*sb_statfs)(struct dentry *dentry);
> -	int (*sb_mount)(const char *dev_name, const struct path *path,
> -			const char *type, unsigned long flags, void *data);
> -	int (*sb_umount)(struct vfsmount *mnt, int flags);
> -	int (*sb_pivotroot)(const struct path *old_path, const struct path *new_path);
> -	int (*sb_set_mnt_opts)(struct super_block *sb,
> -				void *mnt_opts,
> -				unsigned long kern_flags,
> -				unsigned long *set_kern_flags);
> -	int (*sb_clone_mnt_opts)(const struct super_block *oldsb,
> -					struct super_block *newsb,
> -					unsigned long kern_flags,
> -					unsigned long *set_kern_flags);
> -	int (*sb_add_mnt_opt)(const char *option, const char *val, int len,
> -			      void **mnt_opts);
> -	int (*move_mount)(const struct path *from_path, const struct path *to_path);
> -	int (*dentry_init_security)(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen);
> -	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
> -					struct qstr *name,
> -					const struct cred *old,
> -					struct cred *new);
> -
> -
> -#ifdef CONFIG_SECURITY_PATH
> -	int (*path_unlink)(const struct path *dir, struct dentry *dentry);
> -	int (*path_mkdir)(const struct path *dir, struct dentry *dentry,
> -				umode_t mode);
> -	int (*path_rmdir)(const struct path *dir, struct dentry *dentry);
> -	int (*path_mknod)(const struct path *dir, struct dentry *dentry,
> -				umode_t mode, unsigned int dev);
> -	int (*path_truncate)(const struct path *path);
> -	int (*path_symlink)(const struct path *dir, struct dentry *dentry,
> -				const char *old_name);
> -	int (*path_link)(struct dentry *old_dentry, const struct path *new_dir,
> -				struct dentry *new_dentry);
> -	int (*path_rename)(const struct path *old_dir, struct dentry *old_dentry,
> -				const struct path *new_dir,
> -				struct dentry *new_dentry);
> -	int (*path_chmod)(const struct path *path, umode_t mode);
> -	int (*path_chown)(const struct path *path, kuid_t uid, kgid_t gid);
> -	int (*path_chroot)(const struct path *path);
> -#endif
> -	/* Needed for inode based security check */
> -	int (*path_notify)(const struct path *path, u64 mask,
> -				unsigned int obj_type);
> -	int (*inode_alloc_security)(struct inode *inode);
> -	void (*inode_free_security)(struct inode *inode);
> -	int (*inode_init_security)(struct inode *inode, struct inode *dir,
> -					const struct qstr *qstr,
> -					const char **name, void **value,
> -					size_t *len);
> -	int (*inode_create)(struct inode *dir, struct dentry *dentry,
> -				umode_t mode);
> -	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
> -				struct dentry *new_dentry);
> -	int (*inode_unlink)(struct inode *dir, struct dentry *dentry);
> -	int (*inode_symlink)(struct inode *dir, struct dentry *dentry,
> -				const char *old_name);
> -	int (*inode_mkdir)(struct inode *dir, struct dentry *dentry,
> -				umode_t mode);
> -	int (*inode_rmdir)(struct inode *dir, struct dentry *dentry);
> -	int (*inode_mknod)(struct inode *dir, struct dentry *dentry,
> -				umode_t mode, dev_t dev);
> -	int (*inode_rename)(struct inode *old_dir, struct dentry *old_dentry,
> -				struct inode *new_dir,
> -				struct dentry *new_dentry);
> -	int (*inode_readlink)(struct dentry *dentry);
> -	int (*inode_follow_link)(struct dentry *dentry, struct inode *inode,
> -				 bool rcu);
> -	int (*inode_permission)(struct inode *inode, int mask);
> -	int (*inode_setattr)(struct dentry *dentry, struct iattr *attr);
> -	int (*inode_getattr)(const struct path *path);
> -	int (*inode_setxattr)(struct dentry *dentry, const char *name,
> -				const void *value, size_t size, int flags);
> -	void (*inode_post_setxattr)(struct dentry *dentry, const char *name,
> -					const void *value, size_t size,
> -					int flags);
> -	int (*inode_getxattr)(struct dentry *dentry, const char *name);
> -	int (*inode_listxattr)(struct dentry *dentry);
> -	int (*inode_removexattr)(struct dentry *dentry, const char *name);
> -	int (*inode_need_killpriv)(struct dentry *dentry);
> -	int (*inode_killpriv)(struct dentry *dentry);
> -	int (*inode_getsecurity)(struct inode *inode, const char *name,
> -					void **buffer, bool alloc);
> -	int (*inode_setsecurity)(struct inode *inode, const char *name,
> -					const void *value, size_t size,
> -					int flags);
> -	int (*inode_listsecurity)(struct inode *inode, char *buffer,
> -					size_t buffer_size);
> -	void (*inode_getsecid)(struct inode *inode, u32 *secid);
> -	int (*inode_copy_up)(struct dentry *src, struct cred **new);
> -	int (*inode_copy_up_xattr)(const char *name);
> -
> -	int (*kernfs_init_security)(struct kernfs_node *kn_dir,
> -				    struct kernfs_node *kn);
> -
> -	int (*file_permission)(struct file *file, int mask);
> -	int (*file_alloc_security)(struct file *file);
> -	void (*file_free_security)(struct file *file);
> -	int (*file_ioctl)(struct file *file, unsigned int cmd,
> -				unsigned long arg);
> -	int (*mmap_addr)(unsigned long addr);
> -	int (*mmap_file)(struct file *file, unsigned long reqprot,
> -				unsigned long prot, unsigned long flags);
> -	int (*file_mprotect)(struct vm_area_struct *vma, unsigned long reqprot,
> -				unsigned long prot);
> -	int (*file_lock)(struct file *file, unsigned int cmd);
> -	int (*file_fcntl)(struct file *file, unsigned int cmd,
> -				unsigned long arg);
> -	void (*file_set_fowner)(struct file *file);
> -	int (*file_send_sigiotask)(struct task_struct *tsk,
> -					struct fown_struct *fown, int sig);
> -	int (*file_receive)(struct file *file);
> -	int (*file_open)(struct file *file);
> -
> -	int (*task_alloc)(struct task_struct *task, unsigned long clone_flags);
> -	void (*task_free)(struct task_struct *task);
> -	int (*cred_alloc_blank)(struct cred *cred, gfp_t gfp);
> -	void (*cred_free)(struct cred *cred);
> -	int (*cred_prepare)(struct cred *new, const struct cred *old,
> -				gfp_t gfp);
> -	void (*cred_transfer)(struct cred *new, const struct cred *old);
> -	void (*cred_getsecid)(const struct cred *c, u32 *secid);
> -	int (*kernel_act_as)(struct cred *new, u32 secid);
> -	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
> -	int (*kernel_module_request)(char *kmod_name);
> -	int (*kernel_load_data)(enum kernel_load_data_id id);
> -	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
> -	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
> -				     enum kernel_read_file_id id);
> -	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
> -				int flags);
> -	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
> -	int (*task_getpgid)(struct task_struct *p);
> -	int (*task_getsid)(struct task_struct *p);
> -	void (*task_getsecid)(struct task_struct *p, u32 *secid);
> -	int (*task_setnice)(struct task_struct *p, int nice);
> -	int (*task_setioprio)(struct task_struct *p, int ioprio);
> -	int (*task_getioprio)(struct task_struct *p);
> -	int (*task_prlimit)(const struct cred *cred, const struct cred *tcred,
> -			    unsigned int flags);
> -	int (*task_setrlimit)(struct task_struct *p, unsigned int resource,
> -				struct rlimit *new_rlim);
> -	int (*task_setscheduler)(struct task_struct *p);
> -	int (*task_getscheduler)(struct task_struct *p);
> -	int (*task_movememory)(struct task_struct *p);
> -	int (*task_kill)(struct task_struct *p, struct kernel_siginfo *info,
> -				int sig, const struct cred *cred);
> -	int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,
> -				unsigned long arg4, unsigned long arg5);
> -	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
> -
> -	int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
> -	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
> -
> -	int (*msg_msg_alloc_security)(struct msg_msg *msg);
> -	void (*msg_msg_free_security)(struct msg_msg *msg);
> -
> -	int (*msg_queue_alloc_security)(struct kern_ipc_perm *perm);
> -	void (*msg_queue_free_security)(struct kern_ipc_perm *perm);
> -	int (*msg_queue_associate)(struct kern_ipc_perm *perm, int msqflg);
> -	int (*msg_queue_msgctl)(struct kern_ipc_perm *perm, int cmd);
> -	int (*msg_queue_msgsnd)(struct kern_ipc_perm *perm, struct msg_msg *msg,
> -				int msqflg);
> -	int (*msg_queue_msgrcv)(struct kern_ipc_perm *perm, struct msg_msg *msg,
> -				struct task_struct *target, long type,
> -				int mode);
> -
> -	int (*shm_alloc_security)(struct kern_ipc_perm *perm);
> -	void (*shm_free_security)(struct kern_ipc_perm *perm);
> -	int (*shm_associate)(struct kern_ipc_perm *perm, int shmflg);
> -	int (*shm_shmctl)(struct kern_ipc_perm *perm, int cmd);
> -	int (*shm_shmat)(struct kern_ipc_perm *perm, char __user *shmaddr,
> -				int shmflg);
> -
> -	int (*sem_alloc_security)(struct kern_ipc_perm *perm);
> -	void (*sem_free_security)(struct kern_ipc_perm *perm);
> -	int (*sem_associate)(struct kern_ipc_perm *perm, int semflg);
> -	int (*sem_semctl)(struct kern_ipc_perm *perm, int cmd);
> -	int (*sem_semop)(struct kern_ipc_perm *perm, struct sembuf *sops,
> -				unsigned nsops, int alter);
> -
> -	int (*netlink_send)(struct sock *sk, struct sk_buff *skb);
> -
> -	void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
> -
> -	int (*getprocattr)(struct task_struct *p, char *name, char **value);
> -	int (*setprocattr)(const char *name, void *value, size_t size);
> -	int (*ismaclabel)(const char *name);
> -	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
> -	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
> -	void (*release_secctx)(char *secdata, u32 seclen);
> -
> -	void (*inode_invalidate_secctx)(struct inode *inode);
> -	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
> -	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
> -	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
> -
> -#ifdef CONFIG_SECURITY_NETWORK
> -	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
> -					struct sock *newsk);
> -	int (*unix_may_send)(struct socket *sock, struct socket *other);
> -
> -	int (*socket_create)(int family, int type, int protocol, int kern);
> -	int (*socket_post_create)(struct socket *sock, int family, int type,
> -					int protocol, int kern);
> -	int (*socket_socketpair)(struct socket *socka, struct socket *sockb);
> -	int (*socket_bind)(struct socket *sock, struct sockaddr *address,
> -				int addrlen);
> -	int (*socket_connect)(struct socket *sock, struct sockaddr *address,
> -				int addrlen);
> -	int (*socket_listen)(struct socket *sock, int backlog);
> -	int (*socket_accept)(struct socket *sock, struct socket *newsock);
> -	int (*socket_sendmsg)(struct socket *sock, struct msghdr *msg,
> -				int size);
> -	int (*socket_recvmsg)(struct socket *sock, struct msghdr *msg,
> -				int size, int flags);
> -	int (*socket_getsockname)(struct socket *sock);
> -	int (*socket_getpeername)(struct socket *sock);
> -	int (*socket_getsockopt)(struct socket *sock, int level, int optname);
> -	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
> -	int (*socket_shutdown)(struct socket *sock, int how);
> -	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
> -	int (*socket_getpeersec_stream)(struct socket *sock,
> -					char __user *optval,
> -					int __user *optlen, unsigned len);
> -	int (*socket_getpeersec_dgram)(struct socket *sock,
> -					struct sk_buff *skb, u32 *secid);
> -	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
> -	void (*sk_free_security)(struct sock *sk);
> -	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
> -	void (*sk_getsecid)(struct sock *sk, u32 *secid);
> -	void (*sock_graft)(struct sock *sk, struct socket *parent);
> -	int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
> -					struct request_sock *req);
> -	void (*inet_csk_clone)(struct sock *newsk,
> -				const struct request_sock *req);
> -	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
> -	int (*secmark_relabel_packet)(u32 secid);
> -	void (*secmark_refcount_inc)(void);
> -	void (*secmark_refcount_dec)(void);
> -	void (*req_classify_flow)(const struct request_sock *req,
> -					struct flowi *fl);
> -	int (*tun_dev_alloc_security)(void **security);
> -	void (*tun_dev_free_security)(void *security);
> -	int (*tun_dev_create)(void);
> -	int (*tun_dev_attach_queue)(void *security);
> -	int (*tun_dev_attach)(struct sock *sk, void *security);
> -	int (*tun_dev_open)(void *security);
> -	int (*sctp_assoc_request)(struct sctp_endpoint *ep,
> -				  struct sk_buff *skb);
> -	int (*sctp_bind_connect)(struct sock *sk, int optname,
> -				 struct sockaddr *address, int addrlen);
> -	void (*sctp_sk_clone)(struct sctp_endpoint *ep, struct sock *sk,
> -			      struct sock *newsk);
> -#endif	/* CONFIG_SECURITY_NETWORK */
> -
> -#ifdef CONFIG_SECURITY_INFINIBAND
> -	int (*ib_pkey_access)(void *sec, u64 subnet_prefix, u16 pkey);
> -	int (*ib_endport_manage_subnet)(void *sec, const char *dev_name,
> -					u8 port_num);
> -	int (*ib_alloc_security)(void **sec);
> -	void (*ib_free_security)(void *sec);
> -#endif	/* CONFIG_SECURITY_INFINIBAND */
> -
> -#ifdef CONFIG_SECURITY_NETWORK_XFRM
> -	int (*xfrm_policy_alloc_security)(struct xfrm_sec_ctx **ctxp,
> -					  struct xfrm_user_sec_ctx *sec_ctx,
> -						gfp_t gfp);
> -	int (*xfrm_policy_clone_security)(struct xfrm_sec_ctx *old_ctx,
> -						struct xfrm_sec_ctx **new_ctx);
> -	void (*xfrm_policy_free_security)(struct xfrm_sec_ctx *ctx);
> -	int (*xfrm_policy_delete_security)(struct xfrm_sec_ctx *ctx);
> -	int (*xfrm_state_alloc)(struct xfrm_state *x,
> -				struct xfrm_user_sec_ctx *sec_ctx);
> -	int (*xfrm_state_alloc_acquire)(struct xfrm_state *x,
> -					struct xfrm_sec_ctx *polsec,
> -					u32 secid);
> -	void (*xfrm_state_free_security)(struct xfrm_state *x);
> -	int (*xfrm_state_delete_security)(struct xfrm_state *x);
> -	int (*xfrm_policy_lookup)(struct xfrm_sec_ctx *ctx, u32 fl_secid,
> -					u8 dir);
> -	int (*xfrm_state_pol_flow_match)(struct xfrm_state *x,
> -						struct xfrm_policy *xp,
> -						const struct flowi *fl);
> -	int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall);
> -#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
> -
> -	/* key management security hooks */
> -#ifdef CONFIG_KEYS
> -	int (*key_alloc)(struct key *key, const struct cred *cred,
> -				unsigned long flags);
> -	void (*key_free)(struct key *key);
> -	int (*key_permission)(key_ref_t key_ref, const struct cred *cred,
> -				unsigned perm);
> -	int (*key_getsecurity)(struct key *key, char **_buffer);
> -#endif	/* CONFIG_KEYS */
> -
> -#ifdef CONFIG_AUDIT
> -	int (*audit_rule_init)(u32 field, u32 op, char *rulestr,
> -				void **lsmrule);
> -	int (*audit_rule_known)(struct audit_krule *krule);
> -	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule);
> -	void (*audit_rule_free)(void *lsmrule);
> -#endif /* CONFIG_AUDIT */
> -
> -#ifdef CONFIG_BPF_SYSCALL
> -	int (*bpf)(int cmd, union bpf_attr *attr,
> -				 unsigned int size);
> -	int (*bpf_map)(struct bpf_map *map, fmode_t fmode);
> -	int (*bpf_prog)(struct bpf_prog *prog);
> -	int (*bpf_map_alloc_security)(struct bpf_map *map);
> -	void (*bpf_map_free_security)(struct bpf_map *map);
> -	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
> -	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
> -#endif /* CONFIG_BPF_SYSCALL */
> -	int (*locked_down)(enum lockdown_reason what);
> -#ifdef CONFIG_PERF_EVENTS
> -	int (*perf_event_open)(struct perf_event_attr *attr, int type);
> -	int (*perf_event_alloc)(struct perf_event *event);
> -	void (*perf_event_free)(struct perf_event *event);
> -	int (*perf_event_read)(struct perf_event *event);
> -	int (*perf_event_write)(struct perf_event *event);
> -
> -#endif
> +	#define LSM_HOOK(RET, NAME, ...) RET (*NAME)(__VA_ARGS__);
> +	#include "lsm_hook_names.h"
> +	#undef LSM_HOOK
>  };
>  
>  struct security_hook_heads {
> -	struct hlist_head binder_set_context_mgr;
> -	struct hlist_head binder_transaction;
> -	struct hlist_head binder_transfer_binder;
> -	struct hlist_head binder_transfer_file;
> -	struct hlist_head ptrace_access_check;
> -	struct hlist_head ptrace_traceme;
> -	struct hlist_head capget;
> -	struct hlist_head capset;
> -	struct hlist_head capable;
> -	struct hlist_head quotactl;
> -	struct hlist_head quota_on;
> -	struct hlist_head syslog;
> -	struct hlist_head settime;
> -	struct hlist_head vm_enough_memory;
> -	struct hlist_head bprm_set_creds;
> -	struct hlist_head bprm_check_security;
> -	struct hlist_head bprm_committing_creds;
> -	struct hlist_head bprm_committed_creds;
> -	struct hlist_head fs_context_dup;
> -	struct hlist_head fs_context_parse_param;
> -	struct hlist_head sb_alloc_security;
> -	struct hlist_head sb_free_security;
> -	struct hlist_head sb_free_mnt_opts;
> -	struct hlist_head sb_eat_lsm_opts;
> -	struct hlist_head sb_remount;
> -	struct hlist_head sb_kern_mount;
> -	struct hlist_head sb_show_options;
> -	struct hlist_head sb_statfs;
> -	struct hlist_head sb_mount;
> -	struct hlist_head sb_umount;
> -	struct hlist_head sb_pivotroot;
> -	struct hlist_head sb_set_mnt_opts;
> -	struct hlist_head sb_clone_mnt_opts;
> -	struct hlist_head sb_add_mnt_opt;
> -	struct hlist_head move_mount;
> -	struct hlist_head dentry_init_security;
> -	struct hlist_head dentry_create_files_as;
> -#ifdef CONFIG_SECURITY_PATH
> -	struct hlist_head path_unlink;
> -	struct hlist_head path_mkdir;
> -	struct hlist_head path_rmdir;
> -	struct hlist_head path_mknod;
> -	struct hlist_head path_truncate;
> -	struct hlist_head path_symlink;
> -	struct hlist_head path_link;
> -	struct hlist_head path_rename;
> -	struct hlist_head path_chmod;
> -	struct hlist_head path_chown;
> -	struct hlist_head path_chroot;
> -#endif
> -	/* Needed for inode based modules as well */
> -	struct hlist_head path_notify;
> -	struct hlist_head inode_alloc_security;
> -	struct hlist_head inode_free_security;
> -	struct hlist_head inode_init_security;
> -	struct hlist_head inode_create;
> -	struct hlist_head inode_link;
> -	struct hlist_head inode_unlink;
> -	struct hlist_head inode_symlink;
> -	struct hlist_head inode_mkdir;
> -	struct hlist_head inode_rmdir;
> -	struct hlist_head inode_mknod;
> -	struct hlist_head inode_rename;
> -	struct hlist_head inode_readlink;
> -	struct hlist_head inode_follow_link;
> -	struct hlist_head inode_permission;
> -	struct hlist_head inode_setattr;
> -	struct hlist_head inode_getattr;
> -	struct hlist_head inode_setxattr;
> -	struct hlist_head inode_post_setxattr;
> -	struct hlist_head inode_getxattr;
> -	struct hlist_head inode_listxattr;
> -	struct hlist_head inode_removexattr;
> -	struct hlist_head inode_need_killpriv;
> -	struct hlist_head inode_killpriv;
> -	struct hlist_head inode_getsecurity;
> -	struct hlist_head inode_setsecurity;
> -	struct hlist_head inode_listsecurity;
> -	struct hlist_head inode_getsecid;
> -	struct hlist_head inode_copy_up;
> -	struct hlist_head inode_copy_up_xattr;
> -	struct hlist_head kernfs_init_security;
> -	struct hlist_head file_permission;
> -	struct hlist_head file_alloc_security;
> -	struct hlist_head file_free_security;
> -	struct hlist_head file_ioctl;
> -	struct hlist_head mmap_addr;
> -	struct hlist_head mmap_file;
> -	struct hlist_head file_mprotect;
> -	struct hlist_head file_lock;
> -	struct hlist_head file_fcntl;
> -	struct hlist_head file_set_fowner;
> -	struct hlist_head file_send_sigiotask;
> -	struct hlist_head file_receive;
> -	struct hlist_head file_open;
> -	struct hlist_head task_alloc;
> -	struct hlist_head task_free;
> -	struct hlist_head cred_alloc_blank;
> -	struct hlist_head cred_free;
> -	struct hlist_head cred_prepare;
> -	struct hlist_head cred_transfer;
> -	struct hlist_head cred_getsecid;
> -	struct hlist_head kernel_act_as;
> -	struct hlist_head kernel_create_files_as;
> -	struct hlist_head kernel_load_data;
> -	struct hlist_head kernel_read_file;
> -	struct hlist_head kernel_post_read_file;
> -	struct hlist_head kernel_module_request;
> -	struct hlist_head task_fix_setuid;
> -	struct hlist_head task_setpgid;
> -	struct hlist_head task_getpgid;
> -	struct hlist_head task_getsid;
> -	struct hlist_head task_getsecid;
> -	struct hlist_head task_setnice;
> -	struct hlist_head task_setioprio;
> -	struct hlist_head task_getioprio;
> -	struct hlist_head task_prlimit;
> -	struct hlist_head task_setrlimit;
> -	struct hlist_head task_setscheduler;
> -	struct hlist_head task_getscheduler;
> -	struct hlist_head task_movememory;
> -	struct hlist_head task_kill;
> -	struct hlist_head task_prctl;
> -	struct hlist_head task_to_inode;
> -	struct hlist_head ipc_permission;
> -	struct hlist_head ipc_getsecid;
> -	struct hlist_head msg_msg_alloc_security;
> -	struct hlist_head msg_msg_free_security;
> -	struct hlist_head msg_queue_alloc_security;
> -	struct hlist_head msg_queue_free_security;
> -	struct hlist_head msg_queue_associate;
> -	struct hlist_head msg_queue_msgctl;
> -	struct hlist_head msg_queue_msgsnd;
> -	struct hlist_head msg_queue_msgrcv;
> -	struct hlist_head shm_alloc_security;
> -	struct hlist_head shm_free_security;
> -	struct hlist_head shm_associate;
> -	struct hlist_head shm_shmctl;
> -	struct hlist_head shm_shmat;
> -	struct hlist_head sem_alloc_security;
> -	struct hlist_head sem_free_security;
> -	struct hlist_head sem_associate;
> -	struct hlist_head sem_semctl;
> -	struct hlist_head sem_semop;
> -	struct hlist_head netlink_send;
> -	struct hlist_head d_instantiate;
> -	struct hlist_head getprocattr;
> -	struct hlist_head setprocattr;
> -	struct hlist_head ismaclabel;
> -	struct hlist_head secid_to_secctx;
> -	struct hlist_head secctx_to_secid;
> -	struct hlist_head release_secctx;
> -	struct hlist_head inode_invalidate_secctx;
> -	struct hlist_head inode_notifysecctx;
> -	struct hlist_head inode_setsecctx;
> -	struct hlist_head inode_getsecctx;
> -#ifdef CONFIG_SECURITY_NETWORK
> -	struct hlist_head unix_stream_connect;
> -	struct hlist_head unix_may_send;
> -	struct hlist_head socket_create;
> -	struct hlist_head socket_post_create;
> -	struct hlist_head socket_socketpair;
> -	struct hlist_head socket_bind;
> -	struct hlist_head socket_connect;
> -	struct hlist_head socket_listen;
> -	struct hlist_head socket_accept;
> -	struct hlist_head socket_sendmsg;
> -	struct hlist_head socket_recvmsg;
> -	struct hlist_head socket_getsockname;
> -	struct hlist_head socket_getpeername;
> -	struct hlist_head socket_getsockopt;
> -	struct hlist_head socket_setsockopt;
> -	struct hlist_head socket_shutdown;
> -	struct hlist_head socket_sock_rcv_skb;
> -	struct hlist_head socket_getpeersec_stream;
> -	struct hlist_head socket_getpeersec_dgram;
> -	struct hlist_head sk_alloc_security;
> -	struct hlist_head sk_free_security;
> -	struct hlist_head sk_clone_security;
> -	struct hlist_head sk_getsecid;
> -	struct hlist_head sock_graft;
> -	struct hlist_head inet_conn_request;
> -	struct hlist_head inet_csk_clone;
> -	struct hlist_head inet_conn_established;
> -	struct hlist_head secmark_relabel_packet;
> -	struct hlist_head secmark_refcount_inc;
> -	struct hlist_head secmark_refcount_dec;
> -	struct hlist_head req_classify_flow;
> -	struct hlist_head tun_dev_alloc_security;
> -	struct hlist_head tun_dev_free_security;
> -	struct hlist_head tun_dev_create;
> -	struct hlist_head tun_dev_attach_queue;
> -	struct hlist_head tun_dev_attach;
> -	struct hlist_head tun_dev_open;
> -	struct hlist_head sctp_assoc_request;
> -	struct hlist_head sctp_bind_connect;
> -	struct hlist_head sctp_sk_clone;
> -#endif	/* CONFIG_SECURITY_NETWORK */
> -#ifdef CONFIG_SECURITY_INFINIBAND
> -	struct hlist_head ib_pkey_access;
> -	struct hlist_head ib_endport_manage_subnet;
> -	struct hlist_head ib_alloc_security;
> -	struct hlist_head ib_free_security;
> -#endif	/* CONFIG_SECURITY_INFINIBAND */
> -#ifdef CONFIG_SECURITY_NETWORK_XFRM
> -	struct hlist_head xfrm_policy_alloc_security;
> -	struct hlist_head xfrm_policy_clone_security;
> -	struct hlist_head xfrm_policy_free_security;
> -	struct hlist_head xfrm_policy_delete_security;
> -	struct hlist_head xfrm_state_alloc;
> -	struct hlist_head xfrm_state_alloc_acquire;
> -	struct hlist_head xfrm_state_free_security;
> -	struct hlist_head xfrm_state_delete_security;
> -	struct hlist_head xfrm_policy_lookup;
> -	struct hlist_head xfrm_state_pol_flow_match;
> -	struct hlist_head xfrm_decode_session;
> -#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
> -#ifdef CONFIG_KEYS
> -	struct hlist_head key_alloc;
> -	struct hlist_head key_free;
> -	struct hlist_head key_permission;
> -	struct hlist_head key_getsecurity;
> -#endif	/* CONFIG_KEYS */
> -#ifdef CONFIG_AUDIT
> -	struct hlist_head audit_rule_init;
> -	struct hlist_head audit_rule_known;
> -	struct hlist_head audit_rule_match;
> -	struct hlist_head audit_rule_free;
> -#endif /* CONFIG_AUDIT */
> -#ifdef CONFIG_BPF_SYSCALL
> -	struct hlist_head bpf;
> -	struct hlist_head bpf_map;
> -	struct hlist_head bpf_prog;
> -	struct hlist_head bpf_map_alloc_security;
> -	struct hlist_head bpf_map_free_security;
> -	struct hlist_head bpf_prog_alloc_security;
> -	struct hlist_head bpf_prog_free_security;
> -#endif /* CONFIG_BPF_SYSCALL */
> -	struct hlist_head locked_down;
> -#ifdef CONFIG_PERF_EVENTS
> -	struct hlist_head perf_event_open;
> -	struct hlist_head perf_event_alloc;
> -	struct hlist_head perf_event_free;
> -	struct hlist_head perf_event_read;
> -	struct hlist_head perf_event_write;
> -#endif
> +	#define LSM_HOOK(RET, NAME, ...) struct hlist_head NAME;
> +	#include "lsm_hook_names.h"
> +	#undef LSM_HOOK
>  } __randomize_layout;
>  
>  /*
> -- 
> 2.20.1
> 

-- 
Kees Cook
