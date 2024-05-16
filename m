Return-Path: <bpf+bounces-29816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978DF8C6F95
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 02:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192371F212FA
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120515C9;
	Thu, 16 May 2024 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHWr8YLX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9C1862;
	Thu, 16 May 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819743; cv=none; b=hPdKlkDY6K9TQeWBibCbnE+wsNIl3AoZqfVKaNKANaVOyqclg46foJAUUVDYzuIowNpjWgoa9MWhcfwQzlfl+syT8ZxdfQ0nDf5VUf5NygyaVSdtp4yzgqDwHKQtwrc2XXgN/6BngwfnFt4OjglHUgOaT4DStvyIqhnrVqSdDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819743; c=relaxed/simple;
	bh=ZWfKqP/2efsIurLUhD2StJW68SNl9QbilmZBG5+JJAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZECQ+PpgkzZTYwQAGvQKcfPnTI8OK4oG8U1pz0y9EFsaL51Ly2msb9TwS6iPKIichlrCeZyDcumpPT5daV52O1+2e6oHatBIfoWVOaERIECB4KkPJ9T+bJQyNSC76LBOHgWm3gEmWiJGTIAmckb76o4QV1buIplAdSEHwYnx5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHWr8YLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CD7C32789;
	Thu, 16 May 2024 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715819743;
	bh=ZWfKqP/2efsIurLUhD2StJW68SNl9QbilmZBG5+JJAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHWr8YLXbpo/115+Klwtv/suGHF61Q7q1xkdlvAZIQf2kK/z5M0sA4fYN7oh6pbfR
	 AbU/2k9xtXMGSbKhc6CF2laRkGA+12ccDS/Mi22Mgwce7Gbgk3AFVHfdTBqsWuro+h
	 yDsTcHpumj/sSCfFJWysZM23OAm3i9EGOe1o5kIcUqxdTMknqn+PBJP5k6Sn8M+/11
	 tMBg7brCeEXa1Wz2xr66/xwLYSGlMyzKPR9fXBL0gX9H0k7IEpqiCqV5mIgb9GxAp3
	 kXxWcM6NKrjihMVcEQvcUVgUMwIi0a3CW1sxncWEq1594mQltmIu8boONFEcUTHtUA
	 vAoSRsfW5NoDA==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	andrii@kernel.org,
	keescook@chromium.org,
	daniel@iogearbox.net,
	renauld@google.com,
	revest@chromium.org,
	song@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v12 4/5] security: Update non standard hooks to use static calls
Date: Thu, 16 May 2024 02:35:23 +0200
Message-ID: <20240516003524.143243-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240516003524.143243-1-kpsingh@kernel.org>
References: <20240516003524.143243-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some LSM hooks which do not use the common pattern followed
by other LSM hooks and thus cannot use call_{int, void}_hook macros and
instead use lsm_for_each_hook macro which still results in indirect
call.

There is one additional generalizable pattern where a hook matching an
lsmid is called and the indirect calls for these are addressed with the
newly added call_hook_with_lsmid macro which internally uses an
implementation similar to call_int_hook but has an additional check that
matches the lsmid.

For the generic case the lsm_for_each_hook macro is updated to accept
logic before and after the invocation of the LSM hook (static call) in
the unrolled loop.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 security/security.c | 248 +++++++++++++++++++++++++-------------------
 1 file changed, 144 insertions(+), 104 deletions(-)

diff --git a/security/security.c b/security/security.c
index 39ffe949e509..9654ca074aed 100644
--- a/security/security.c
+++ b/security/security.c
@@ -945,10 +945,48 @@ out:									\
 	RC;								\
 })
 
-#define lsm_for_each_hook(scall, NAME)					\
-	for (scall = static_calls_table.NAME;				\
-	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
-		if (static_key_enabled(&scall->active->key))
+/*
+ * Can be used in the context passed to lsm_for_each_hook to get the lsmid of the
+ * current hook
+ */
+#define current_lsmid() _hook_lsmid
+
+#define __CALL_HOOK(NUM, HOOK, RC, BLOCK_BEFORE, BLOCK_AFTER, ...)	     \
+do {									     \
+	int __maybe_unused _hook_lsmid;					     \
+									     \
+	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
+		_hook_lsmid = static_calls_table.HOOK[NUM].hl->lsmid->id;    \
+		BLOCK_BEFORE						     \
+		RC = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);   \
+		BLOCK_AFTER						     \
+	}								     \
+} while (0);
+
+#define lsm_for_each_hook(HOOK, RC, BLOCK_AFTER, ...)	\
+	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, ;, BLOCK_AFTER, __VA_ARGS__)
+
+#define call_hook_with_lsmid(HOOK, LSMID, ...)				\
+({									\
+	__label__ out;							\
+	int RC = LSM_RET_DEFAULT(HOOK);					\
+									\
+	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC,				\
+	/* BLOCK BEFORE INVOCATION */					\
+	{								\
+		if (current_lsmid() != LSMID)				\
+			continue;					\
+	},								\
+	/* END BLOCK BEFORE INVOCATION */				\
+	/* BLOCK AFTER INVOCATION */					\
+	{								\
+		goto out;						\
+	},								\
+	/* END BLOCK AFTER INVOCATION */				\
+	__VA_ARGS__);							\
+out:									\
+	RC;								\
+})
 
 /* Security operations */
 
@@ -1184,7 +1222,6 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct lsm_static_call *scall;
 	int cap_sys_admin = 1;
 	int rc;
 
@@ -1195,13 +1232,20 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	lsm_for_each_hook(scall, vm_enough_memory) {
-		rc = scall->hl->hook.vm_enough_memory(mm, pages);
-		if (rc <= 0) {
-			cap_sys_admin = 0;
-			break;
-		}
-	}
+
+	lsm_for_each_hook(
+		vm_enough_memory, rc,
+		/* BLOCK AFTER INVOCATION */
+		{
+			if (rc <= 0) {
+				cap_sys_admin = 0;
+				goto out;
+			}
+		},
+		/* END BLOCK AFTER INVOCATION */
+		mm, pages);
+
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1343,17 +1387,21 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 int security_fs_context_parse_param(struct fs_context *fc,
 				    struct fs_parameter *param)
 {
-	struct lsm_static_call *scall;
-	int trc;
+	int trc = LSM_RET_DEFAULT(fs_context_parse_param);
 	int rc = -ENOPARAM;
 
-	lsm_for_each_hook(scall, fs_context_parse_param) {
-		trc = scall->hl->hook.fs_context_parse_param(fc, param);
-		if (trc == 0)
-			rc = 0;
-		else if (trc != -ENOPARAM)
-			return trc;
-	}
+	lsm_for_each_hook(
+		fs_context_parse_param, trc,
+		/* BLOCK AFTER INVOCATION */
+		{
+			if (trc == 0)
+				rc = 0;
+			else if (trc != -ENOPARAM)
+				return trc;
+		},
+		/* END BLOCK AFTER INVOCATION */
+		fc, param);
+
 	return rc;
 }
 
@@ -1578,15 +1626,19 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 			     unsigned long kern_flags,
 			     unsigned long *set_kern_flags)
 {
-	struct lsm_static_call *scall;
 	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
 
-	lsm_for_each_hook(scall, sb_set_mnt_opts) {
-		rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
-					      set_kern_flags);
-		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
-			break;
-	}
+	lsm_for_each_hook(
+		sb_set_mnt_opts, rc,
+		/* BLOCK AFTER INVOCATION */
+		{
+			if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
+				goto out;
+		},
+		/* END BLOCK AFTER INVOCATION */
+		sb, mnt_opts, kern_flags, set_kern_flags);
+
+out:
 	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
@@ -1777,7 +1829,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
@@ -1795,18 +1846,21 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 			return -ENOMEM;
 	}
 
-	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
-		if (ret && ret != -EOPNOTSUPP)
-			goto out;
+	lsm_for_each_hook(
+		inode_init_security, ret,
+		/* BLOCK AFTER INVOCATION */
+		{
 		/*
 		 * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
 		 * means that the LSM is not willing to provide an xattr, not
 		 * that it wants to signal an error. Thus, continue to invoke
 		 * the remaining LSMs.
 		 */
-	}
+			if (ret && ret != -EOPNOTSUPP)
+				goto out;
+		},
+		/* END BLOCK AFTER INVOCATION */
+		inode, dir, qstr, new_xattrs, &xattr_count);
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
 	if (!xattr_count)
@@ -3601,16 +3655,21 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 {
 	int thisrc;
 	int rc = LSM_RET_DEFAULT(task_prctl);
-	struct lsm_static_call *scall;
-
-	lsm_for_each_hook(scall, task_prctl) {
-		thisrc = scall->hl->hook.task_prctl(option, arg2, arg3, arg4, arg5);
-		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
-			rc = thisrc;
-			if (thisrc != 0)
-				break;
-		}
-	}
+
+	lsm_for_each_hook(
+		task_prctl, thisrc,
+		/* BLOCK AFTER INVOCATION */
+		{
+			if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
+				rc = thisrc;
+				if (thisrc != 0)
+					goto out;
+			}
+		},
+		/* END BLOCK AFTER INVOCATION */
+		option, arg2, arg3, arg4, arg5);
+
+out:
 	return rc;
 }
 
@@ -4010,7 +4069,6 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 __user *size, u32 flags)
 {
-	struct lsm_static_call *scall;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
 	u32 entrysize;
@@ -4048,31 +4106,42 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 	 * In the usual case gather all the data from the LSMs.
 	 * In the single case only get the data from the LSM specified.
 	 */
-	lsm_for_each_hook(scall, getselfattr) {
-		if (single && lctx.id != scall->hl->lsmid->id)
-			continue;
-		entrysize = left;
-		if (base)
-			uctx = (struct lsm_ctx __user *)(base + total);
-		rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
-		if (rc == -EOPNOTSUPP) {
-			rc = 0;
-			continue;
-		}
-		if (rc == -E2BIG) {
-			rc = 0;
-			left = 0;
-			toobig = true;
-		} else if (rc < 0)
-			return rc;
-		else
-			left -= entrysize;
+	LSM_LOOP_UNROLL(
+		__CALL_HOOK, getselfattr, rc,
+		/* BLOCK BEFORE INVOCATION */
+		{
+			if (single && lctx.id != current_lsmid())
+				continue;
+			entrysize = left;
+			if (base)
+				uctx = (struct lsm_ctx __user *)(base + total);
+		},
+		/* END BLOCK BEFORE INVOCATION */
+		/* BLOCK AFTER INVOCATION */
+		{
+			if (rc == -EOPNOTSUPP) {
+				rc = 0;
+			} else {
+				if (rc == -E2BIG) {
+					rc = 0;
+					left = 0;
+					toobig = true;
+				} else if (rc < 0)
+					return rc;
+				else
+					left -= entrysize;
+
+				total += entrysize;
+				count += rc;
+				if (single)
+					goto out;
+			}
+		},
+		/* END BLOCK AFTER INVOCATION */
+		attr, uctx, &entrysize, flags);
+
+out:
 
-		total += entrysize;
-		count += rc;
-		if (single)
-			break;
-	}
 	if (put_user(total, size))
 		return -EFAULT;
 	if (toobig)
@@ -4103,9 +4172,8 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 size, u32 flags)
 {
-	struct lsm_static_call *scall;
 	struct lsm_ctx *lctx;
-	int rc = LSM_RET_DEFAULT(setselfattr);
+	int rc;
 	u64 required_len;
 
 	if (flags)
@@ -4126,11 +4194,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 		goto free_out;
 	}
 
-	lsm_for_each_hook(scall, setselfattr)
-		if ((scall->hl->lsmid->id) == lctx->id) {
-			rc = scall->hl->hook.setselfattr(attr, lctx, size, flags);
-			break;
-		}
+	rc = call_hook_with_lsmid(setselfattr, lctx->id, attr, lctx, size, flags);
 
 free_out:
 	kfree(lctx);
@@ -4151,14 +4215,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value)
 {
-	struct lsm_static_call *scall;
-
-	lsm_for_each_hook(scall, getprocattr) {
-		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
-			continue;
-		return scall->hl->hook.getprocattr(p, name, value);
-	}
-	return LSM_RET_DEFAULT(getprocattr);
+	return call_hook_with_lsmid(getprocattr, lsmid, p, name, value);
 }
 
 /**
@@ -4175,14 +4232,7 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
  */
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 {
-	struct lsm_static_call *scall;
-
-	lsm_for_each_hook(scall, setprocattr) {
-		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
-			continue;
-		return scall->hl->hook.setprocattr(name, value, size);
-	}
-	return LSM_RET_DEFAULT(setprocattr);
+	return call_hook_with_lsmid(setprocattr, lsmid, name, value, size);
 }
 
 /**
@@ -5267,23 +5317,13 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic)
 {
-	struct lsm_static_call *scall;
-	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
-
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
 	 * becomes difficult if multiple LSMs supply this call. Fortunately,
 	 * we can use the first LSM's judgment because currently only SELinux
 	 * supplies this call.
-	 *
-	 * For speed optimization, we explicitly break the loop rather than
-	 * using the macro
 	 */
-	lsm_for_each_hook(scall, xfrm_state_pol_flow_match) {
-		rc = scall->hl->hook.xfrm_state_pol_flow_match(x, xp, flic);
-		break;
-	}
-	return rc;
+	return call_int_hook(xfrm_state_pol_flow_match, x, xp, flic);
 }
 
 /**
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


