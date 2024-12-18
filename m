Return-Path: <bpf+bounces-47190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7F9F5DEE
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A2165144
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385A154BE2;
	Wed, 18 Dec 2024 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7DFk9Y7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213391547F3;
	Wed, 18 Dec 2024 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497280; cv=none; b=gUTTHL96IyOBuBBz/GCuchWTra41Pax/57OCs5UhYRG9UyWSHjM5ILYeCSwnnhQOe088R3DvdibD+/he1H26YU9Ek+V6cRLDFQi7zi8Fctcvw/6U2DanqaIwnrwmwRcgMWulcMPGuiq9l2/U1RmUJRyL5RZntqt1nUbB8/mUgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497280; c=relaxed/simple;
	bh=PcdmMy7e01X6Zb9qsMrWqkwbB/hX7LWGxj07SI3L57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/iNlyLo/NS6xUk/q3YFnPI9kgFhXdViTvdQd/nq+6ORitoAGBUDv11OMXvHav/m+H5++YqvoOu0UV+cQahw15mpgCKpnK4/MhOZIw/oEfG4jj2s+2WrShsbVSBiC6mOElFXsjVv321iAvAOrjPdnvNfUDPHF9TL2uYSxcxQyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7DFk9Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31D0C4CECE;
	Wed, 18 Dec 2024 04:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734497279;
	bh=PcdmMy7e01X6Zb9qsMrWqkwbB/hX7LWGxj07SI3L57U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7DFk9Y7mXiAOwvvszdv7pOOiaoA6XS+54MOjL3/0PEfPIinepsbpc2GpjgU1YDkj
	 R7NXYWj7yE+gZSGyttLAymm/8Jocj22zsP/edCXC3KUdVoOwWn3yB98YqiK6syJ37g
	 3wEXs8l0s/wvImGTClflddQMYOnYCyaOgdmvD7DYyGDIMx4oxnKhknxg9qRs4RSELQ
	 Wz2pqqD2ePPGAn1wq6YYb50YzjOlHoY4V+chGcAeEf6EwHmn2RzQ21y/t+0q+XCUXL
	 ZcmAfWlcvwz7L4nQTBYITZ33gcpZeEmQh18puy37maE93N4JEyicrpTjF/ulXPiLFD
	 2D2R4DtSk/2Ag==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
Date: Tue, 17 Dec 2024 20:47:10 -0800
Message-ID: <20241218044711.1723221-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218044711.1723221-1-song@kernel.org>
References: <20241218044711.1723221-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following kfuncs to set and remove xattrs from BPF programs:

  bpf_set_dentry_xattr
  bpf_remove_dentry_xattr
  bpf_set_dentry_xattr_locked
  bpf_remove_dentry_xattr_locked

The _locked version of these kfuncs are called from hooks where
dentry->d_inode is already locked. Instead of requiring the user
to know which version of the kfuncs to use, the verifier will pick
the proper kfunc based on the calling hook.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c      | 195 ++++++++++++++++++++++++++++++++++++++++
 include/linux/bpf_lsm.h |   8 ++
 kernel/bpf/verifier.c   |  55 +++++++++++-
 3 files changed, 256 insertions(+), 2 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 8a65184c8c2c..b3cc6330ab69 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -2,10 +2,12 @@
 /* Copyright (c) 2024 Google LLC. */
 
 #include <linux/bpf.h>
+#include <linux/bpf_lsm.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/dcache.h>
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
@@ -161,6 +163,164 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+static int bpf_xattr_write_permission(const char *name, struct inode *inode)
+{
+	if (WARN_ON(!inode))
+		return -EINVAL;
+
+	/* Only allow setting and removing security.bpf. xattrs */
+	if (!match_security_bpf_prefix(name))
+		return -EPERM;
+
+	return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
+}
+
+static int __bpf_set_dentry_xattr(struct dentry *dentry, const char *name,
+				  const struct bpf_dynptr *value_p, int flags, bool lock_inode)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	struct inode *inode = d_inode(dentry);
+	const void *value;
+	u32 value_len;
+	int ret;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	if (lock_inode)
+		inode_lock(inode);
+
+	ret = bpf_xattr_write_permission(name, inode);
+	if (ret)
+		goto out;
+
+	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name,
+			     value, value_len, flags);
+	if (!ret) {
+		fsnotify_xattr(dentry);
+
+		/* This xattr is set by BPF LSM, so we do not call
+		 * security_inode_post_setxattr. This is the same as
+		 * security_inode_setsecurity().
+		 */
+	}
+out:
+	if (lock_inode)
+		inode_unlock(inode);
+	return ret;
+}
+
+/**
+ * bpf_set_dentry_xattr - set a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: xattr value
+ * @flags: flags to pass into filesystem operations
+ *
+ * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller has not locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     const struct bpf_dynptr *value_p, int flags)
+{
+	return __bpf_set_dentry_xattr(dentry, name__str, value_p, flags, true);
+}
+
+/**
+ * bpf_set_dentry_xattr_locked - set a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: xattr value
+ * @flags: flags to pass into filesystem operations
+ *
+ * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller already locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
+					    const struct bpf_dynptr *value_p, int flags)
+{
+	return __bpf_set_dentry_xattr(dentry, name__str, value_p, flags, false);
+}
+
+static int __bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     bool lock_inode)
+{
+	struct inode *inode = d_inode(dentry);
+	int ret;
+
+	if (lock_inode)
+		inode_lock(inode);
+
+	ret = bpf_xattr_write_permission(name__str, inode);
+	if (ret)
+		goto out;
+
+	ret = __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
+	if (!ret) {
+		fsnotify_xattr(dentry);
+
+		/* This xattr is removed by BPF LSM, so we do not call
+		 * security_inode_post_removexattr.
+		 */
+	}
+out:
+	if (lock_inode)
+		inode_unlock(inode);
+	return ret;
+}
+
+/**
+ * bpf_remove_dentry_xattr - remove a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ *
+ * Rmove xattr *name__str* of *dentry*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller has not locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str)
+{
+	return __bpf_remove_dentry_xattr(dentry, name__str, true);
+}
+
+/**
+ * bpf_remove_dentry_xattr_locked - remove a xattr of a dentry
+ * @dentry: dentry to get xattr from
+ * @name__str: name of the xattr
+ *
+ * Rmove xattr *name__str* of *dentry*.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf."
+ * is allowed.
+ *
+ * The caller already locked dentry->d_inode.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
+{
+	return __bpf_remove_dentry_xattr(dentry, name__str, false);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -170,6 +330,10 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
@@ -186,6 +350,37 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.filter = bpf_fs_kfuncs_filter,
 };
 
+/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
+ * KF_SLEEPABLE, so they are only available to sleepable hooks with
+ * dentry arguments.
+ *
+ * Setting and removing xattr requires exclusive lock on dentry->d_inode.
+ * Some hooks already locked d_inode, while some hooks have not locked
+ * d_inode. Therefore, we need different kfuncs for different hooks.
+ * Specifically, hooks in the following list (d_inode_locked_hooks)
+ * should call bpf_[set|remove]_dentry_xattr_locked; while other hooks
+ * should call bpf_[set|remove]_dentry_xattr.
+ */
+BTF_SET_START(d_inode_locked_hooks)
+BTF_ID(func, bpf_lsm_inode_post_removexattr)
+BTF_ID(func, bpf_lsm_inode_post_setattr)
+BTF_ID(func, bpf_lsm_inode_post_setxattr)
+BTF_ID(func, bpf_lsm_inode_removexattr)
+BTF_ID(func, bpf_lsm_inode_rmdir)
+BTF_ID(func, bpf_lsm_inode_setattr)
+BTF_ID(func, bpf_lsm_inode_setxattr)
+BTF_ID(func, bpf_lsm_inode_unlink)
+#ifdef CONFIG_SECURITY_PATH
+BTF_ID(func, bpf_lsm_path_unlink)
+BTF_ID(func, bpf_lsm_path_rmdir)
+#endif /* CONFIG_SECURITY_PATH */
+BTF_SET_END(d_inode_locked_hooks)
+
+bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
+{
+	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
+}
+
 static int __init bpf_fs_kfuncs_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aefcd6564251..5147b10e16a2 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -48,6 +48,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
 
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 			     struct bpf_retval_range *range);
+
+bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -86,6 +89,11 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
+{
+	return false;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e5..f0d240d46e54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr);
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static void remap_kfunc_locked_func_id(struct bpf_verifier_env *env, struct bpf_insn *insn);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -3224,10 +3225,12 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 			return -EPERM;
 		}
 
-		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
+		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
 			ret = add_subprog(env, i + insn->imm + 1);
-		else
+		} else {
+			remap_kfunc_locked_func_id(env, insn);
 			ret = add_kfunc_call(env, insn->imm, insn->off);
+		}
 
 		if (ret < 0)
 			return ret;
@@ -11690,6 +11693,10 @@ enum special_kfunc_type {
 	KF_bpf_get_kmem_cache,
 	KF_bpf_local_irq_save,
 	KF_bpf_local_irq_restore,
+	KF_bpf_set_dentry_xattr,
+	KF_bpf_remove_dentry_xattr,
+	KF_bpf_set_dentry_xattr_locked,
+	KF_bpf_remove_dentry_xattr_locked,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11719,6 +11726,12 @@ BTF_ID(func, bpf_wq_set_callback_impl)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+#ifdef CONFIG_BPF_LSM
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+BTF_ID(func, bpf_set_dentry_xattr_locked)
+BTF_ID(func, bpf_remove_dentry_xattr_locked)
+#endif
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11762,6 +11775,44 @@ BTF_ID_UNUSED
 BTF_ID(func, bpf_get_kmem_cache)
 BTF_ID(func, bpf_local_irq_save)
 BTF_ID(func, bpf_local_irq_restore)
+#ifdef CONFIG_BPF_LSM
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+BTF_ID(func, bpf_set_dentry_xattr_locked)
+BTF_ID(func, bpf_remove_dentry_xattr_locked)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
+
+/* Sometimes, we need slightly different verions of a kfunc for different
+ * contexts/hooks, for example, bpf_set_dentry_xattr vs.
+ * bpf_set_dentry_xattr_locked. The former kfunc need to lock the inode
+ * rwsem, while the latter is called with the inode rwsem held (by the
+ * caller).
+ *
+ * To avoid burden on the users, we allow either version of the kfunc in
+ * either context. Then the verifier will remap the kfunc to the proper
+ * version based the context.
+ */
+static void remap_kfunc_locked_func_id(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	u32 func_id = insn->imm;
+
+	if (bpf_lsm_has_d_inode_locked(env->prog)) {
+		if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr])
+			insn->imm =  special_kfunc_list[KF_bpf_set_dentry_xattr_locked];
+		else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr])
+			insn->imm = special_kfunc_list[KF_bpf_remove_dentry_xattr_locked];
+	} else {
+		if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr_locked])
+			insn->imm =  special_kfunc_list[KF_bpf_set_dentry_xattr];
+		else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr_locked])
+			insn->imm = special_kfunc_list[KF_bpf_remove_dentry_xattr];
+	}
+}
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
-- 
2.43.5


