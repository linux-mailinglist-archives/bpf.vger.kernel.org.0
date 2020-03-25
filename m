Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75A1933BB
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 23:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYWZs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 18:25:48 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:45246
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727395AbgCYWZs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Mar 2020 18:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585175142; bh=PtKGbGyc7QdbZ4O1vWmbFhhCh3tFxMEQ1jCww/OOnm8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Kr9gTO5qDb889KcG3Cgbx5AiH5LY8DErfJhDKKVhLkdeIxuDGcI7Cswtx+e8NmQYCb9dvLkLsw+g3ff0v87H2K8Wl9wnNCPEYAx9eAk/bHP4F4doQ5pNPsBtyoKDtRKjXUjbz/NiUTmItab6JarDvkhrXUmAM6MTkbCLhk688NMO/PiTPp9tWXuwXW0mU6S3a+056YFxoBuhSP8XKJ3oeXOMezEyvCaivligij96iZJRGlKsLOGgRo6z586Jmfbzwcco1VU7julStt13xZpugbPbIjtRccC779oIGw7Mtq1IPe9Am2qtuCmCfLgVWKCJlrMVxgFxGscoUQa/P6PFlw==
X-YMail-OSG: gJl8QyUVM1mvX2JOMHIBcLoaNRJHblHo_0oWtuhcSGQ8vgTiYezNbgBsnj0BoKj
 jnfp7i4dBXoFhXDGU_a5mQwnYqq17ombHUf9zd0LKmZv7Kb2Jw943.zB7_kMDvZzUPdLIk6OW1Ty
 hT_a_rCLoGDV0PoULv8X4XngSgBwge043idwLUtM.Wmo3Sg8k7qe0FLNdlJ4Ps7ZxP2HaudL.brY
 7GmuThE.y.Ghb0qu7vWrk8lNb5Is9lYiBUA4efEV16qwObxnmKSOvHI7WyIfX_3Cd69thdKI0GLR
 BYpvyO9dFZS3zCe0dzJScS_j8ZvhB9xdvCLyjSmsfoX0KXO0cKkMvwTU4zt1q0G9TLkqpg_S1tXf
 AEF_cCV2KEjjGTjwb5WzW.r5qB2tNRMIzBFkt2qn9TFU0rwrgG2tF4lsGGe64QaaNkSEBclTmkZz
 oLcVrKa5rqty5Dpm73dHWtZaaA1rMwQ79If_HmbQItVFvA_t2daXi3FhNbmYlCeQQG9FZ1eltDNi
 FCYcvxOXADoQsPiPRrRWk0tnNCE0c3pLjmcClES5ca0jZSDogkQRtEECrN7E6APftauKwl8yUjWs
 wkTDFCibmsiGmmXmtUEPAFu_bQOqwUswEStmsEyGdvL9N5yRfz3A2ry8kkaGzn2wJwRG4yOAxY33
 6syKyuQYWnCkFMhl8x2Omw6EdRf0y7c4XAsdx10qi20nzrIvVJd9vUYCmROsnD5JZTBPSCnTIqxa
 BiBbFEYwPpkXI53f16lhmPIuJ6nMQkOQDOdONOg280YQKtYtjI5cruy1DPJOJAJd7Di39RpdSR3g
 mlNktSDxv7tm.2wpyfAdVZqEK3ueMvpjuoiSC3ngjOw0mV2nExJhNriZDQf3X07dm4tSRigrRHd8
 XrnEwDgRKQN.w8hs1XvTcLtB7Y2Mfb5nVbr0yN2I1SbEyZfM_ZwOIYoi1y2c8.SLZq3dk37.mNjx
 8b4O6bG53WL41WhVEj.P81csmvG5BC_g06ElLsVrE9YJ085bkJEGkJ2uJW7LC8ASRGb2vgVA0TvC
 Nh5QbsM8_GrUA5sYRi9Cr7amQYswrDxiRTDWkRH230v6KYlgIn5CSB4wFsigsGCr3P0e4Qax6WxJ
 MCjpsGgtp3VrFqT2_ML0Y5J62f.h2uyvQYqMuMC35ma4_T6ky0kJP6xO8ikeVe608ndykx3PPo8T
 HQXpFaMbHjKcUN3JD_w_ZZht8cW7u3KvFy7AT1I9D1K.YEfFF1PLHkwa2FL.QM5x3k2eqyrx8SW5
 TBU0YjXaz8HKiG3Axj5cf.dm6G04AiCuM67hP5fs.sZnc07YZOq8X4g_Y79YBgCeUjyFb1sgWMU.
 9NRjpNJKPJ_lCrfqbyFdHMLSxa5SbI2ZDtZpDxEFJdwzM92i2f123G1IGY.khl.zqSimQzi28YCZ
 RKE4cMTXOmLJzRU_O4fe2FIIQyPbi6gUVr4zsi0HvQ1MJGwz0.A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Mar 2020 22:25:42 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1f5b1295e67e1d6a039ebc3689c7ada0;
          Wed, 25 Mar 2020 22:25:37 +0000 (UTC)
Subject: Re: [PATCH bpf-next v6 2/8] security: Refactor declaration of LSM
 hooks
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-3-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d22ebc0e-6e71-f1c5-b448-93dd04e56ca0@schaufler-ca.com>
Date:   Wed, 25 Mar 2020 15:25:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325152629.6904-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/25/2020 8:26 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> The information about the different types of LSM hooks is scattered
> in two locations i.e. union security_list_options and
> struct security_hook_heads. Rather than duplicating this information
> even further for BPF_PROG_TYPE_LSM, define all the hooks with the
> LSM_HOOK macro in lsm_hook_defs.h which is then used to generate all
> the data structures required by the LSM framework.
>
> The LSM hooks are defined as:
>
>   LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
>
> with <default_value> acccessible in security.c as:
>
>   LSM_RET_DEFAULT(<hook_name>)
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

If you fix the comment style issues below you can add my

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hook_defs.h | 380 +++++++++++++++++++++
>  include/linux/lsm_hooks.h     | 627 +---------------------------------=

>  security/security.c           |  40 ++-
>  3 files changed, 420 insertions(+), 627 deletions(-)
>  create mode 100644 include/linux/lsm_hook_defs.h
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> new file mode 100644
> index 000000000000..d79be7305852
> --- /dev/null
> +++ b/include/linux/lsm_hook_defs.h
> @@ -0,0 +1,380 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Linux Security Module Hook declarations.
> + *
> + * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
> + * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
> + * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@na=
i.com>
> + * Copyright (C) 2001 James Morris <jmorris@intercode.com.au>
> + * Copyright (C) 2001 Silicon Graphics, Inc. (Trust Technology Group)
> + * Copyright (C) 2015 Intel Corporation.
> + * Copyright (C) 2015 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2016 Mellanox Techonologies
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +/* The macro LSM_HOOK is used to define the data structures required b=
y the
> + * the LSM framework using the pattern:
> + *
> + *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> + *
> + * struct security_hook_heads {
> + *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;=

> + *   #include <linux/lsm_hook_defs.h>
> + *   #undef LSM_HOOK
> + * };
> + */
> +LSM_HOOK(int, 0, binder_set_context_mgr, struct task_struct *mgr)
> +LSM_HOOK(int, 0, binder_transaction, struct task_struct *from,
> +	 struct task_struct *to)
> +LSM_HOOK(int, 0, binder_transfer_binder, struct task_struct *from,
> +	 struct task_struct *to)
> +LSM_HOOK(int, 0, binder_transfer_file, struct task_struct *from,
> +	 struct task_struct *to, struct file *file)
> +LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
> +	 unsigned int mode)
> +LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> +LSM_HOOK(int, 0, capget, struct task_struct *target, kernel_cap_t *eff=
ective,
> +	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
> +LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> +	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
> +	 const kernel_cap_t *permitted)
> +LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespa=
ce *ns,
> +	 int cap, unsigned int opts)
> +LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, struct super_bl=
ock *sb)
> +LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
> +LSM_HOOK(int, 0, syslog, int type)
> +LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
> +	 const struct timezone *tz)
> +LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
> +LSM_HOOK(int, 0, bprm_set_creds, struct linux_binprm *bprm)
> +LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> +LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binpr=
m *bprm)
> +LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm=
 *bprm)
> +LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
> +	 struct fs_context *src_sc)
> +LSM_HOOK(int, 0, fs_context_parse_param, struct fs_context *fc,
> +	 struct fs_parameter *param)
> +LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
> +LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)=

> +LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
> +LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> +LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
> +LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
> +LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_blo=
ck *sb)
> +LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
> +LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *pa=
th,
> +	 const char *type, unsigned long flags, void *data)
> +LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
> +LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
> +	 const struct path *new_path)
> +LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_op=
ts,
> +	 unsigned long kern_flags, unsigned long *set_kern_flags)
> +LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
> +	 struct super_block *newsb, unsigned long kern_flags,
> +	 unsigned long *set_kern_flags)
> +LSM_HOOK(int, 0, sb_add_mnt_opt, const char *option, const char *val,
> +	 int len, void **mnt_opts)
> +LSM_HOOK(int, 0, move_mount, const struct path *from_path,
> +	 const struct path *to_path)
> +LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
> +	 int mode, const struct qstr *name, void **ctx, u32 *ctxlen)
> +LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mo=
de,
> +	 struct qstr *name, const struct cred *old, struct cred *new)
> +
> +#ifdef CONFIG_SECURITY_PATH
> +LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *d=
entry)
> +LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *de=
ntry,
> +	 umode_t mode)
> +LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *de=
ntry)
> +LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *de=
ntry,
> +	 umode_t mode, unsigned int dev)
> +LSM_HOOK(int, 0, path_truncate, const struct path *path)
> +LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *=
dentry,
> +	 const char *old_name)
> +LSM_HOOK(int, 0, path_link, struct dentry *old_dentry,
> +	 const struct path *new_dir, struct dentry *new_dentry)
> +LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
> +	 struct dentry *old_dentry, const struct path *new_dir,
> +	 struct dentry *new_dentry)
> +LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
> +LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid=
_t gid)
> +LSM_HOOK(int, 0, path_chroot, const struct path *path)
> +#endif /* CONFIG_SECURITY_PATH */
> +
> +/* Needed for inode based security check */
> +LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> +	 unsigned int obj_type)
> +LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)=

> +LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> +	 struct inode *dir, const struct qstr *qstr, const char **name,
> +	 void **value, size_t *len)
> +LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentr=
y,
> +	 umode_t mode)
> +LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *=
dir,
> +	 struct dentry *new_dentry)
> +LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentr=
y)
> +LSM_HOOK(int, 0, inode_symlink, struct inode *dir, struct dentry *dent=
ry,
> +	 const char *old_name)
> +LSM_HOOK(int, 0, inode_mkdir, struct inode *dir, struct dentry *dentry=
,
> +	 umode_t mode)
> +LSM_HOOK(int, 0, inode_rmdir, struct inode *dir, struct dentry *dentry=
)
> +LSM_HOOK(int, 0, inode_mknod, struct inode *dir, struct dentry *dentry=
,
> +	 umode_t mode, dev_t dev)
> +LSM_HOOK(int, 0, inode_rename, struct inode *old_dir, struct dentry *o=
ld_dentry,
> +	 struct inode *new_dir, struct dentry *new_dentry)
> +LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
> +LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inod=
e *inode,
> +	 bool rcu)
> +LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
> +LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *a=
ttr)
> +LSM_HOOK(int, 0, inode_getattr, const struct path *path)
> +LSM_HOOK(int, 0, inode_setxattr, struct dentry *dentry, const char *na=
me,
> +	 const void *value, size_t size, int flags)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentr=
y,
> +	 const char *name, const void *value, size_t size, int flags)
> +LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *na=
me)
> +LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> +LSM_HOOK(int, 0, inode_removexattr, struct dentry *dentry, const char =
*name)
> +LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
> +LSM_HOOK(int, 0, inode_killpriv, struct dentry *dentry)
> +LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
> +	 const char *name, void **buffer, bool alloc)
> +LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
> +	 const char *name, const void *value, size_t size, int flags)
> +LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer=
,
> +	 size_t buffer_size)
> +LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 =
*secid)
> +LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)=

> +LSM_HOOK(int, 0, inode_copy_up_xattr, const char *name)
> +LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
> +	 struct kernfs_node *kn)
> +LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
> +LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> +LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
> +LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
> +	 unsigned long arg)
> +LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
> +LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
> +	 unsigned long prot, unsigned long flags)
> +LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
> +	 unsigned long reqprot, unsigned long prot)
> +LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
> +LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
> +	 unsigned long arg)
> +LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
> +LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
> +	 struct fown_struct *fown, int sig)
> +LSM_HOOK(int, 0, file_receive, struct file *file)
> +LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
> +	 unsigned long clone_flags)
> +LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
> +LSM_HOOK(int, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
> +LSM_HOOK(void, LSM_RET_VOID, cred_free, struct cred *cred)
> +LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *ol=
d,
> +	 gfp_t gfp)
> +LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
> +	 const struct cred *old)
> +LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 =
*secid)
> +LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
> +LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inod=
e *inode)
> +LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
> +LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id)
> +LSM_HOOK(int, 0, kernel_read_file, struct file *file,
> +	 enum kernel_read_file_id id)
> +LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
> +	 loff_t size, enum kernel_read_file_id id)
> +LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred =
*old,
> +	 int flags)
> +LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
> +LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
> +LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
> +LSM_HOOK(void, LSM_RET_VOID, task_getsecid, struct task_struct *p, u32=
 *secid)
> +LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
> +LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
> +LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
> +LSM_HOOK(int, 0, task_prlimit, const struct cred *cred,
> +	 const struct cred *tcred, unsigned int flags)
> +LSM_HOOK(int, 0, task_setrlimit, struct task_struct *p, unsigned int r=
esource,
> +	 struct rlimit *new_rlim)
> +LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p)
> +LSM_HOOK(int, 0, task_getscheduler, struct task_struct *p)
> +LSM_HOOK(int, 0, task_movememory, struct task_struct *p)
> +LSM_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_sigin=
fo *info,
> +	 int sig, const struct cred *cred)
> +LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
> +	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
> +LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
> +	 struct inode *inode)
> +LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short fla=
g)
> +LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,=

> +	 u32 *secid)
> +LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
> +LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *ms=
g)
> +LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)=

> +LSM_HOOK(void, LSM_RET_VOID, msg_queue_free_security,
> +	 struct kern_ipc_perm *perm)
> +LSM_HOOK(int, 0, msg_queue_associate, struct kern_ipc_perm *perm, int =
msqflg)
> +LSM_HOOK(int, 0, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd=
)
> +LSM_HOOK(int, 0, msg_queue_msgsnd, struct kern_ipc_perm *perm,
> +	 struct msg_msg *msg, int msqflg)
> +LSM_HOOK(int, 0, msg_queue_msgrcv, struct kern_ipc_perm *perm,
> +	 struct msg_msg *msg, struct task_struct *target, long type, int mode=
)
> +LSM_HOOK(int, 0, shm_alloc_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(void, LSM_RET_VOID, shm_free_security, struct kern_ipc_perm *=
perm)
> +LSM_HOOK(int, 0, shm_associate, struct kern_ipc_perm *perm, int shmflg=
)
> +LSM_HOOK(int, 0, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
> +LSM_HOOK(int, 0, shm_shmat, struct kern_ipc_perm *perm, char __user *s=
hmaddr,
> +	 int shmflg)
> +LSM_HOOK(int, 0, sem_alloc_security, struct kern_ipc_perm *perm)
> +LSM_HOOK(void, LSM_RET_VOID, sem_free_security, struct kern_ipc_perm *=
perm)
> +LSM_HOOK(int, 0, sem_associate, struct kern_ipc_perm *perm, int semflg=
)
> +LSM_HOOK(int, 0, sem_semctl, struct kern_ipc_perm *perm, int cmd)
> +LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf =
*sops,
> +	 unsigned nsops, int alter)
> +LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
> +LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
> +	 struct inode *inode)
> +LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, char *name,=

> +	 char **value)
> +LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, siz=
e_t size)
> +LSM_HOOK(int, 0, ismaclabel, const char *name)
> +LSM_HOOK(int, 0, secid_to_secctx, u32 secid, char **secdata,
> +	 u32 *seclen)
> +LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32=
 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen=
)
> +LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *in=
ode)
> +LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u=
32 ctxlen)
> +LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u3=
2 ctxlen)
> +LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
> +	 u32 *ctxlen)
> +
> +#ifdef CONFIG_SECURITY_NETWORK
> +LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *=
other,
> +	 struct sock *newsk)
> +LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *ot=
her)
> +LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, in=
t kern)
> +LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, =
int type,
> +	 int protocol, int kern)
> +LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socke=
t *sockb)
> +LSM_HOOK(int, 0, socket_bind, struct socket *sock, struct sockaddr *ad=
dress,
> +	 int addrlen)
> +LSM_HOOK(int, 0, socket_connect, struct socket *sock, struct sockaddr =
*address,
> +	 int addrlen)
> +LSM_HOOK(int, 0, socket_listen, struct socket *sock, int backlog)
> +LSM_HOOK(int, 0, socket_accept, struct socket *sock, struct socket *ne=
wsock)
> +LSM_HOOK(int, 0, socket_sendmsg, struct socket *sock, struct msghdr *m=
sg,
> +	 int size)
> +LSM_HOOK(int, 0, socket_recvmsg, struct socket *sock, struct msghdr *m=
sg,
> +	 int size, int flags)
> +LSM_HOOK(int, 0, socket_getsockname, struct socket *sock)
> +LSM_HOOK(int, 0, socket_getpeername, struct socket *sock)
> +LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, in=
t optname)
> +LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, in=
t optname)
> +LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
> +LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff =
*skb)
> +LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
> +	 char __user *optval, int __user *optlen, unsigned len)
> +LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
> +	 struct sk_buff *skb, u32 *secid)
> +LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t=
 priority)
> +LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
> +LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk,=

> +	 struct sock *newsk)
> +LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, struct sock *sk, u32 *secid)=

> +LSM_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socke=
t *parent)
> +LSM_HOOK(int, 0, inet_conn_request, struct sock *sk, struct sk_buff *s=
kb,
> +	 struct request_sock *req)
> +LSM_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk,
> +	 const struct request_sock *req)
> +LSM_HOOK(void, LSM_RET_VOID, inet_conn_established, struct sock *sk,
> +	 struct sk_buff *skb)
> +LSM_HOOK(int, 0, secmark_relabel_packet, u32 secid)
> +LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
> +LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
> +LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_s=
ock *req,
> +	 struct flowi *fl)
> +LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
> +LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
> +LSM_HOOK(int, 0, tun_dev_create, void)
> +LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
> +LSM_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
> +LSM_HOOK(int, 0, tun_dev_open, void *security)
> +LSM_HOOK(int, 0, sctp_assoc_request, struct sctp_endpoint *ep,
> +	 struct sk_buff *skb)
> +LSM_HOOK(int, 0, sctp_bind_connect, struct sock *sk, int optname,
> +	 struct sockaddr *address, int addrlen)
> +LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_endpoint *ep,
> +	 struct sock *sk, struct sock *newsk)
> +#endif /* CONFIG_SECURITY_NETWORK */
> +
> +#ifdef CONFIG_SECURITY_INFINIBAND
> +LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pke=
y)
> +LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_=
name,
> +	 u8 port_num)
> +LSM_HOOK(int, 0, ib_alloc_security, void **sec)
> +LSM_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
> +#endif /* CONFIG_SECURITY_INFINIBAND */
> +
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +LSM_HOOK(int, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctx=
p,
> +	 struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp)
> +LSM_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_=
ctx,
> +	 struct xfrm_sec_ctx **new_ctx)
> +LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
> +	 struct xfrm_sec_ctx *ctx)
> +LSM_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx=
)
> +LSM_HOOK(int, 0, xfrm_state_alloc, struct xfrm_state *x,
> +	 struct xfrm_user_sec_ctx *sec_ctx)
> +LSM_HOOK(int, 0, xfrm_state_alloc_acquire, struct xfrm_state *x,
> +	 struct xfrm_sec_ctx *polsec, u32 secid)
> +LSM_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_sta=
te *x)
> +LSM_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
> +LSM_HOOK(int, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_=
secid,
> +	 u8 dir)
> +LSM_HOOK(int, 1, xfrm_state_pol_flow_match, struct xfrm_state *x,
> +	 struct xfrm_policy *xp, const struct flowi *fl)
> +LSM_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,=

> +	 int ckall)
> +#endif /* CONFIG_SECURITY_NETWORK_XFRM */
> +
> +/* key management security hooks */
> +#ifdef CONFIG_KEYS
> +LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
> +	 unsigned long flags)
> +LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
> +LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred =
*cred,
> +	 unsigned perm)
> +LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
> +#endif /* CONFIG_KEYS */
> +
> +#ifdef CONFIG_AUDIT
> +LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
> +	 void **lsmrule)
> +LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
> +LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void =
*lsmrule)
> +LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
> +#endif /* CONFIG_AUDIT */
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size=
)
> +LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
> +LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
> +LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
> +LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *ma=
p)
> +LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
> +LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_a=
ux *aux)
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
> +
> +#ifdef CONFIG_PERF_EVENTS
> +LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int ty=
pe)
> +LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
> +LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event=
)
> +LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
> +LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
> +#endif /* CONFIG_PERF_EVENTS */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..327603814b31 100644
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
> -	int (*settime)(const struct timespec64 *ts, const struct timezone *tz=
);
> -	int (*vm_enough_memory)(struct mm_struct *mm, long pages);
> -
> -	int (*bprm_set_creds)(struct linux_binprm *bprm);
> -	int (*bprm_check_security)(struct linux_binprm *bprm);
> -	void (*bprm_committing_creds)(struct linux_binprm *bprm);
> -	void (*bprm_committed_creds)(struct linux_binprm *bprm);
> -
> -	int (*fs_context_dup)(struct fs_context *fc, struct fs_context *src_s=
c);
> -	int (*fs_context_parse_param)(struct fs_context *fc, struct fs_parame=
ter *param);
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
> -	int (*sb_pivotroot)(const struct path *old_path, const struct path *n=
ew_path);
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
> -	int (*move_mount)(const struct path *from_path, const struct path *to=
_path);
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
> -	int (*path_link)(struct dentry *old_dentry, const struct path *new_di=
r,
> -				struct dentry *new_dentry);
> -	int (*path_rename)(const struct path *old_dir, struct dentry *old_den=
try,
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
> -	int (*inode_rename)(struct inode *old_dir, struct dentry *old_dentry,=

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
> -	int (*file_mprotect)(struct vm_area_struct *vma, unsigned long reqpro=
t,
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
> -	int (*task_alloc)(struct task_struct *task, unsigned long clone_flags=
);
> -	void (*task_free)(struct task_struct *task);
> -	int (*cred_alloc_blank)(struct cred *cred, gfp_t gfp);
> -	void (*cred_free)(struct cred *cred);
> -	int (*cred_prepare)(struct cred *new, const struct cred *old,
> -				gfp_t gfp);
> -	void (*cred_transfer)(struct cred *new, const struct cred *old);
> -	void (*cred_getsecid)(const struct cred *c, u32 *secid);
> -	int (*kernel_act_as)(struct cred *new, u32 secid);
> -	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);=

> -	int (*kernel_module_request)(char *kmod_name);
> -	int (*kernel_load_data)(enum kernel_load_data_id id);
> -	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id i=
d);
> -	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t siz=
e,
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
> -	int (*task_prlimit)(const struct cred *cred, const struct cred *tcred=
,
> -			    unsigned int flags);
> -	int (*task_setrlimit)(struct task_struct *p, unsigned int resource,
> -				struct rlimit *new_rlim);
> -	int (*task_setscheduler)(struct task_struct *p);
> -	int (*task_getscheduler)(struct task_struct *p);
> -	int (*task_movememory)(struct task_struct *p);
> -	int (*task_kill)(struct task_struct *p, struct kernel_siginfo *info,
> -				int sig, const struct cred *cred);
> -	int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,=

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
> -	int (*msg_queue_msgsnd)(struct kern_ipc_perm *perm, struct msg_msg *m=
sg,
> -				int msqflg);
> -	int (*msg_queue_msgrcv)(struct kern_ipc_perm *perm, struct msg_msg *m=
sg,
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
> -	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen)=
;
> -	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);=

> -	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);=

> -
> -#ifdef CONFIG_SECURITY_NETWORK
> -	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
> -					struct sock *newsk);
> -	int (*unix_may_send)(struct socket *sock, struct socket *other);
> -
> -	int (*socket_create)(int family, int type, int protocol, int kern);
> -	int (*socket_post_create)(struct socket *sock, int family, int type,
> -					int protocol, int kern);
> -	int (*socket_socketpair)(struct socket *socka, struct socket *sockb);=

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
> -	int (*socket_getsockopt)(struct socket *sock, int level, int optname)=
;
> -	int (*socket_setsockopt)(struct socket *sock, int level, int optname)=
;
> -	int (*socket_shutdown)(struct socket *sock, int how);
> -	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
> -	int (*socket_getpeersec_stream)(struct socket *sock,
> -					char __user *optval,
> -					int __user *optlen, unsigned len);
> -	int (*socket_getpeersec_dgram)(struct socket *sock,
> -					struct sk_buff *skb, u32 *secid);
> -	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority)=
;
> -	void (*sk_free_security)(struct sock *sk);
> -	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);=

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
> -	int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall=
);
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
> -	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule);=

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
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
> +	#include "lsm_hook_defs.h"
> +	#undef LSM_HOOK
>  };
> =20
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
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> +	#include "lsm_hook_defs.h"
> +	#undef LSM_HOOK
>  } __randomize_layout;
> =20
>  /*
> @@ -2100,6 +1490,11 @@ struct lsm_blob_sizes {
>  	int	lbs_task;
>  };
> =20
> +/* LSM_RET_VOID is used as the default value in LSM_HOOK definitions f=
or void

Nit picking - lsm_hooks.h uses

	/*
	 * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for=
 void
=C2=A0

> + * LSM hooks (in include/linux/lsm_hook_defs.h).
> + */
> +#define LSM_RET_VOID ((void) 0)
> +
>  /*
>   * Initializing a security_hook_list structure takes
>   * up a lot of space in a source file. This macro takes
> diff --git a/security/security.c b/security/security.c
> index 565bc9b67276..19d9f2921be3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -668,6 +668,24 @@ static void __init lsm_early_task(struct task_stru=
ct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
> =20
> +/* The default value of the LSM hook is defined in linux/lsm_hook_defs=
=2Eh and

Same comment style issue as above.

> + * can be accessed with:
> + *
> + *	LSM_RET_DEFAULT(<hook_name>)
> + *
> + * The macros below define static constants for the default value of e=
ach
> + * LSM hook.
> + */
> +#define LSM_RET_DEFAULT(NAME) (NAME##_default)
> +#define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
> +#define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
> +	static const int LSM_RET_DEFAULT(NAME) =3D (DEFAULT);
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +	DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
> +
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +
>  /*
>   * Hook list operation macros.
>   *
> @@ -1338,16 +1356,16 @@ int security_inode_getsecurity(struct inode *in=
ode, const char *name, void **buf
>  	int rc;
> =20
>  	if (unlikely(IS_PRIVATE(inode)))
> -		return -EOPNOTSUPP;
> +		return LSM_RET_DEFAULT(inode_getsecurity);
>  	/*
>  	 * Only one module will provide an attribute with a given name.
>  	 */
>  	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list=
) {
>  		rc =3D hp->hook.inode_getsecurity(inode, name, buffer, alloc);
> -		if (rc !=3D -EOPNOTSUPP)
> +		if (rc !=3D LSM_RET_DEFAULT(inode_getsecurity))
>  			return rc;
>  	}
> -	return -EOPNOTSUPP;
> +	return LSM_RET_DEFAULT(inode_getsecurity);
>  }
> =20
>  int security_inode_setsecurity(struct inode *inode, const char *name, =
const void *value, size_t size, int flags)
> @@ -1356,17 +1374,17 @@ int security_inode_setsecurity(struct inode *in=
ode, const char *name, const void
>  	int rc;
> =20
>  	if (unlikely(IS_PRIVATE(inode)))
> -		return -EOPNOTSUPP;
> +		return LSM_RET_DEFAULT(inode_setsecurity);
>  	/*
>  	 * Only one module will provide an attribute with a given name.
>  	 */
>  	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list=
) {
>  		rc =3D hp->hook.inode_setsecurity(inode, name, value, size,
>  								flags);
> -		if (rc !=3D -EOPNOTSUPP)
> +		if (rc !=3D LSM_RET_DEFAULT(inode_setsecurity))
>  			return rc;
>  	}
> -	return -EOPNOTSUPP;
> +	return LSM_RET_DEFAULT(inode_setsecurity);
>  }
> =20
>  int security_inode_listsecurity(struct inode *inode, char *buffer, siz=
e_t buffer_size)
> @@ -1740,12 +1758,12 @@ int security_task_prctl(int option, unsigned lo=
ng arg2, unsigned long arg3,
>  			 unsigned long arg4, unsigned long arg5)
>  {
>  	int thisrc;
> -	int rc =3D -ENOSYS;
> +	int rc =3D LSM_RET_DEFAULT(task_prctl);
>  	struct security_hook_list *hp;
> =20
>  	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
>  		thisrc =3D hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
> -		if (thisrc !=3D -ENOSYS) {
> +		if (thisrc !=3D LSM_RET_DEFAULT(task_prctl)) {
>  			rc =3D thisrc;
>  			if (thisrc !=3D 0)
>  				break;
> @@ -1917,7 +1935,7 @@ int security_getprocattr(struct task_struct *p, c=
onst char *lsm, char *name,
>  			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
> -	return -EINVAL;
> +	return LSM_RET_DEFAULT(getprocattr);
>  }
> =20
>  int security_setprocattr(const char *lsm, const char *name, void *valu=
e,
> @@ -1930,7 +1948,7 @@ int security_setprocattr(const char *lsm, const c=
har *name, void *value,
>  			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
> -	return -EINVAL;
> +	return LSM_RET_DEFAULT(setprocattr);
>  }
> =20
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb)
> @@ -2315,7 +2333,7 @@ int security_xfrm_state_pol_flow_match(struct xfr=
m_state *x,
>  				       const struct flowi *fl)
>  {
>  	struct security_hook_list *hp;
> -	int rc =3D 1;
> +	int rc =3D LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
> =20
>  	/*
>  	 * Since this function is expected to return 0 or 1, the judgment

