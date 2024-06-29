Return-Path: <bpf+bounces-33413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154191CBBB
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 10:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E061C214E6
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922C3BBC5;
	Sat, 29 Jun 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is5EiPUw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F009445;
	Sat, 29 Jun 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719650628; cv=none; b=IB+kZJeCNGgPhYCzQ9JfllAKliNv4C1/ZUXpyV19wbPVgtu4OPZbzH4hqeqNffFeQ8SeMKTjScSYddwvXk4qsV72/w2ElydzgkoIrqfXm+R9WsztDkYrnduLfd25fppS1OwI7bOyTJ0JhR6v6ruwEbtM9NhCBvtNDxLV44bH//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719650628; c=relaxed/simple;
	bh=pwcXDjEq8pvG0SPA04i4k1/2ElHxWg2WtlzmNwQUUsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNCiU9XR9KZlGoYAfFPnjqk+7Gc10OR+yRlTplV2zH8odbUEFJd/xTOqJ+SLvLFmlvKSjfKktr0FuCrq4sOy6SIgZGmO83JnWWW2N1eZtrf7VwfCELqcW2zaTuY9ldltZ0t+wfLkb/3KGqokCzRvOUe40eFF2OD9pT4MrDzwM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is5EiPUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53029C2BBFC;
	Sat, 29 Jun 2024 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719650628;
	bh=pwcXDjEq8pvG0SPA04i4k1/2ElHxWg2WtlzmNwQUUsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Is5EiPUwM4avUUOXdN9akagXYkRCRfmtfO9extIAx3dm3u8xlhcrtB8Xjju9sNdSg
	 RpGtCsMCfqERaxGn2Nwfec9m0LlfJmbxzDvrPyrFfoUproleFA5thqH9Z+gz8Nf3HI
	 hALygzzggYxR3Z25xaqRkumHgs6ZHAFNVXB+H9/AZgkpcxxAV71W7gHAoD0kOq5w2A
	 zqvroPV40GUV3vNBNpjrzROUBN2OO0FHDZXlWxYlpRL9iO8cYVMleBBhKr2DXEmeyb
	 XRoP8ciXECY6EIQU6tOYZFdKjTqTdqYDBY/x1js1KPVL+XdPpnU4ANU10i3PN9Uicq
	 DQBF9v/csEkJg==
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
Subject: [PATCH v13 4/5] security: Update non standard hooks to use static calls
Date: Sat, 29 Jun 2024 10:43:30 +0200
Message-ID: <20240629084331.3807368-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240629084331.3807368-1-kpsingh@kernel.org>
References: <20240629084331.3807368-1-kpsingh@kernel.org>
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
index e0ec185cf125..4f0f35857217 100644
--- a/security/security.c
+++ b/security/security.c
@@ -948,10 +948,48 @@ out:									\
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
 
@@ -1187,7 +1225,6 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct lsm_static_call *scall;
 	int cap_sys_admin = 1;
 	int rc;
 
@@ -1198,13 +1235,20 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
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
 
@@ -1346,17 +1390,21 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
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
 
@@ -1581,15 +1629,19 @@ int security_sb_set_mnt_opts(struct super_block *sb,
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
@@ -1780,7 +1832,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
@@ -1798,18 +1849,21 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
@@ -3631,16 +3685,21 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
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
 
@@ -4040,7 +4099,6 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 __user *size, u32 flags)
 {
-	struct lsm_static_call *scall;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
 	u32 entrysize;
@@ -4078,31 +4136,42 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4133,9 +4202,8 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 size, u32 flags)
 {
-	struct lsm_static_call *scall;
 	struct lsm_ctx *lctx;
-	int rc = LSM_RET_DEFAULT(setselfattr);
+	int rc;
 	u64 required_len;
 
 	if (flags)
@@ -4156,11 +4224,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4181,14 +4245,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4205,14 +4262,7 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
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
@@ -5328,23 +5378,13 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
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
2.45.2.803.g4e1b14247a-goog


