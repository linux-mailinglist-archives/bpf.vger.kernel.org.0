Return-Path: <bpf+bounces-49656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41637A1B249
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06FA3A17C5
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D961DB372;
	Fri, 24 Jan 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE4VcR7E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8051ADC91;
	Fri, 24 Jan 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709522; cv=none; b=MPE1oyyyDP/fUsk5CV2/knqZHEGZn16rTqHS4YuFjDomlwVCrhHJP4fxx+yuWmdgUPhw/kE6hCDNU117M5f3/PAXWNXp0U5JEZyudxd3e04iYLS5syEL1pHOT/ziNsVf3II0q1LY0BcmPo5+EgMP+Q9Md45C0LCn8mAl2SXK4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709522; c=relaxed/simple;
	bh=1i6BHZkog9i31oXayy/7iTP1WgizWXFaRDMdDI5Stjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK34uz9Aszg8nmdbfXtnPAyibNWgsmhaVF93ESifruCeW7UMf4lui23Cz6tsel9nV7++s9czT4LYCFLCaX2yvFxiSYAxOSNmHcXf3wQ/IJmL7swxNZyQejeXlGDECHwU5dqB5+zEG5oHIyfHg1Vs5RlyQgPCkEyQ0P3P7M9ffLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE4VcR7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35852C4CED2;
	Fri, 24 Jan 2025 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737709521;
	bh=1i6BHZkog9i31oXayy/7iTP1WgizWXFaRDMdDI5Stjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE4VcR7ERMAkchg2Q4lq3LTeXYRecZJCxUucizHzvtyz8JwIt8re6m/B4zAv7pYXE
	 WHr7zeei7UMa0gIsG9QS0oRvdiW76zt3J+HdPCaGBH3+EoXp4aWkrJPTtPZPl58Raz
	 kMoaJOzvgIVz9bBLOb+jdvuAywDepHfaEXIY4QUrwSlDQkcHe34x0ohCie9EjtAGS+
	 ubDA4fniqY4Db0z2N5hhCaJ1M9NMxJ0DknpkNNnnpQhFD3J2PBwQn07ABMGTXLQueS
	 nourOFq8CludYqtQILnSm7bdt+lTozT+d7+1st5fa5d0YpNvDgl4X4uynvbUDj0f85
	 Pg1d3AykrvWZA==
Date: Fri, 24 Jan 2025 10:05:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kpsingh@kernel.org, 
	mattbobrowski@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	memxor@gmail.com
Subject: Re: [PATCH v9 bpf-next 6/7] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Message-ID: <20250124-luxus-vorsah-5a7a827680ab@brauner>
References: <20250110011342.2965136-1-song@kernel.org>
 <20250110011342.2965136-7-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110011342.2965136-7-song@kernel.org>

On Thu, Jan 09, 2025 at 05:13:41PM -0800, Song Liu wrote:
> Add the following kfuncs to set and remove xattrs from BPF programs:
> 
>   bpf_set_dentry_xattr
>   bpf_remove_dentry_xattr
>   bpf_set_dentry_xattr_locked
>   bpf_remove_dentry_xattr_locked
> 
> The _locked version of these kfuncs are called from hooks where
> dentry->d_inode is already locked. Instead of requiring the user
> to know which version of the kfuncs to use, the verifier will pick
> the proper kfunc based on the calling hook.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c      | 227 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/bpf_lsm.h |   2 +
>  2 files changed, 227 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 8a65184c8c2c..f68c83bfb93f 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -2,10 +2,12 @@
>  /* Copyright (c) 2024 Google LLC. */
>  
>  #include <linux/bpf.h>
> +#include <linux/bpf_lsm.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/dcache.h>
>  #include <linux/fs.h>
> +#include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
> @@ -161,6 +163,164 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  	return bpf_get_dentry_xattr(dentry, name__str, value_p);
>  }
>  
> +static int bpf_xattr_write_permission(const char *name, struct inode *inode)
> +{
> +	if (WARN_ON(!inode))
> +		return -EINVAL;
> +
> +	/* Only allow setting and removing security.bpf. xattrs */
> +	if (!match_security_bpf_prefix(name))
> +		return -EPERM;
> +
> +	return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
> +}
> +
> +static int __bpf_set_dentry_xattr(struct dentry *dentry, const char *name,
> +				  const struct bpf_dynptr *value_p, int flags, bool lock_inode)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	struct inode *inode = d_inode(dentry);
> +	const void *value;
> +	u32 value_len;
> +	int ret;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	if (lock_inode)
> +		inode_lock(inode);
> +
> +	ret = bpf_xattr_write_permission(name, inode);
> +	if (ret)
> +		goto out;
> +
> +	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name,
> +			     value, value_len, flags);
> +	if (!ret) {
> +		fsnotify_xattr(dentry);
> +
> +		/* This xattr is set by BPF LSM, so we do not call
> +		 * security_inode_post_setxattr. This is the same as
> +		 * security_inode_setsecurity().
> +		 */

If you did you would risk deadlocks as you could end up calling yourself
again afaict.

> +	}
> +out:
> +	if (lock_inode)
> +		inode_unlock(inode);
> +	return ret;
> +}
> +
> +/**
> + * bpf_set_dentry_xattr - set a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: xattr value
> + * @flags: flags to pass into filesystem operations
> + *
> + * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller has not locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
> +				     const struct bpf_dynptr *value_p, int flags)
> +{
> +	return __bpf_set_dentry_xattr(dentry, name__str, value_p, flags, true);
> +}
> +
> +/**
> + * bpf_set_dentry_xattr_locked - set a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: xattr value
> + * @flags: flags to pass into filesystem operations
> + *
> + * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller already locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> +					    const struct bpf_dynptr *value_p, int flags)
> +{
> +	return __bpf_set_dentry_xattr(dentry, name__str, value_p, flags, false);

That boolean argument is not needed if you pull

value_len = __bpf_dynptr_size(value_ptr);
value = __bpf_dynptr_data(value_ptr, value_len);
if (!value)
	return -EINVAL;

into the two functions and then put:

inode_lock()
bpf_set_dentry_xattr_unlocked();
inode_unlock()

for the locked variant. Similar comment applied to the remove functions.


> +}
> +
> +static int __bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str,
> +				     bool lock_inode)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	int ret;
> +
> +	if (lock_inode)
> +		inode_lock(inode);
> +
> +	ret = bpf_xattr_write_permission(name__str, inode);
> +	if (ret)
> +		goto out;
> +
> +	ret = __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
> +	if (!ret) {
> +		fsnotify_xattr(dentry);
> +
> +		/* This xattr is removed by BPF LSM, so we do not call
> +		 * security_inode_post_removexattr.
> +		 */
> +	}
> +out:
> +	if (lock_inode)
> +		inode_unlock(inode);
> +	return ret;
> +}
> +
> +/**
> + * bpf_remove_dentry_xattr - remove a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + *
> + * Rmove xattr *name__str* of *dentry*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller has not locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str)
> +{
> +	return __bpf_remove_dentry_xattr(dentry, name__str, true);
> +}
> +
> +/**
> + * bpf_remove_dentry_xattr_locked - remove a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + *
> + * Rmove xattr *name__str* of *dentry*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller already locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
> +{
> +	return __bpf_remove_dentry_xattr(dentry, name__str, false);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -170,20 +330,83 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  
> +BTF_HIDDEN_KFUNCS_START(bpf_fs_kfunc_hidden_set_ids)
> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_fs_kfunc_hidden_set_ids)
> +
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> -	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -	    prog->type == BPF_PROG_TYPE_LSM)
> +	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) &&
> +	    !btf_id_set8_contains(&bpf_fs_kfunc_hidden_set_ids, kfunc_id))
> +		return 0;
> +	if (prog->type == BPF_PROG_TYPE_LSM)
>  		return 0;
>  	return -EACCES;
>  }
>  
> +/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
> + * KF_SLEEPABLE, so they are only available to sleepable hooks with
> + * dentry arguments.
> + *
> + * Setting and removing xattr requires exclusive lock on dentry->d_inode.
> + * Some hooks already locked d_inode, while some hooks have not locked
> + * d_inode. Therefore, we need different kfuncs for different hooks.
> + * Specifically, hooks in the following list (d_inode_locked_hooks)
> + * should call bpf_[set|remove]_dentry_xattr_locked; while other hooks
> + * should call bpf_[set|remove]_dentry_xattr.
> + */
> +BTF_SET_START(d_inode_locked_hooks)
> +BTF_ID(func, bpf_lsm_inode_post_removexattr)
> +BTF_ID(func, bpf_lsm_inode_post_setattr)
> +BTF_ID(func, bpf_lsm_inode_post_setxattr)
> +BTF_ID(func, bpf_lsm_inode_removexattr)
> +BTF_ID(func, bpf_lsm_inode_rmdir)
> +BTF_ID(func, bpf_lsm_inode_setattr)
> +BTF_ID(func, bpf_lsm_inode_setxattr)
> +BTF_ID(func, bpf_lsm_inode_unlink)
> +#ifdef CONFIG_SECURITY_PATH
> +BTF_ID(func, bpf_lsm_path_unlink)
> +BTF_ID(func, bpf_lsm_path_rmdir)
> +#endif /* CONFIG_SECURITY_PATH */
> +BTF_SET_END(d_inode_locked_hooks)
> +
> +static bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> +{
> +	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
> +}
> +
> +BTF_ID_LIST(not_locked_fs_kfuncs)
> +BTF_ID(func, bpf_set_dentry_xattr)
> +BTF_ID(func, bpf_remove_dentry_xattr)
> +
> +BTF_ID_LIST(locked_fs_kfuncs)
> +BTF_ID(func, bpf_set_dentry_xattr_locked)
> +BTF_ID(func, bpf_remove_dentry_xattr_locked)
> +
> +static u32 bpf_fs_kfunc_remap(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!bpf_lsm_has_d_inode_locked(prog))
> +		return 0;
> +
> +	if (kfunc_id == not_locked_fs_kfuncs[0])
> +		return locked_fs_kfuncs[0];
> +	if (kfunc_id == not_locked_fs_kfuncs[1])
> +		return locked_fs_kfuncs[1];
> +
> +	return 0;
> +}
> +
>  static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
>  	.owner = THIS_MODULE,
>  	.set = &bpf_fs_kfunc_set_ids,
> +	.hidden_set = &bpf_fs_kfunc_hidden_set_ids,
>  	.filter = bpf_fs_kfuncs_filter,
> +	.remap = bpf_fs_kfunc_remap,
>  };
>  
>  static int __init bpf_fs_kfuncs_init(void)
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index aefcd6564251..f4ab0dc1df69 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -48,6 +48,7 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>  
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  			     struct bpf_retval_range *range);
> +
>  #else /* !CONFIG_BPF_LSM */
>  
>  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> @@ -86,6 +87,7 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> -- 
> 2.43.5
> 

