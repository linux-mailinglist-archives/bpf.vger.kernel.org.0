Return-Path: <bpf+bounces-28977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB48BEFAE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31AB2852C0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD016D4C4;
	Tue,  7 May 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ4lRNen"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A634CDD;
	Tue,  7 May 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119869; cv=none; b=dKQzBAHvgW7srZYYoo6a1VMT+/NGQfvVzSx9f7NX1+nw9rbDJe5HK+J8VDemxCcg/toHIVSVRWYtLeUskgJ8fZ7QKVGNHJDR7GUJgQh49UDOmI+4Y43vJgpqABduMxkz1ervnTUjSpKOMcB48tXb0s+5mA5Ndd8jANNFtgkMucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119869; c=relaxed/simple;
	bh=RmGZ4Nhho8EH/kORnh8BkfNw7rK0lsda3iXOSObazZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+815G+ge+ja4hvrg/XWEhRhAuR1NEzZDk0nLjFlTptgqf10d64hQLsxs2Zmermx0KkEZ2H5KCWLaimsLA63o+sQA72aDavFv7Yc2yyyhdOrrsCRwN4gKMIKIXMRkJRQMKILb7WQKAe4YIYCjTZxvW0XaoIFtVO074sN9xECbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ4lRNen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE13C4AF68;
	Tue,  7 May 2024 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715119869;
	bh=RmGZ4Nhho8EH/kORnh8BkfNw7rK0lsda3iXOSObazZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZ4lRNenODtpXmYmnfHTfMNQlDcTwAbFOS1xnqbG0iTtkG/XOXeePg8xaoUPtpNRN
	 Yrkh7joYahH38MbfrNF7ZTWq9OWy4jNvUZrOt/ITZ46QMoioqs/OobEVHnDvhwf/Ef
	 b8YwsRyi4XFKO5TsuMfk4V0sfyfwamu+DpIn0QRvrmeBwl2HPR2UyP8T6o0pA8ZFIm
	 D/SG/2nD7vHkZ335mA8bAIsSY2UpHO5d/1QM2H6FbLTUUdFD5aOg/xuGCFV+hw/xTc
	 QLS0Kqt6HmF3A9mKzsK2HDsxgmQRsU7dUp3wakNpCEt5AF7DGPE6vToVsMVOYnsrxN
	 6rln9Pu1l7H+Q==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	jackmanb@google.com,
	renauld@google.com,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	song@kernel.org,
	revest@chromium.org,
	keescook@chromium.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v10 4/5] security: Update non standard hooks to use static calls
Date: Wed,  8 May 2024 00:10:44 +0200
Message-ID: <20240507221045.551537-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240507221045.551537-1-kpsingh@kernel.org>
References: <20240507221045.551537-1-kpsingh@kernel.org>
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

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 security/security.c | 229 ++++++++++++++++++++++++--------------------
 1 file changed, 125 insertions(+), 104 deletions(-)

diff --git a/security/security.c b/security/security.c
index 39ffe949e509..491b807a8a63 100644
--- a/security/security.c
+++ b/security/security.c
@@ -945,10 +945,41 @@ out:									\
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
+#define __CALL_HOOK(NUM, HOOK, RC, BODY_BEFORE, BODY_AFTER, ...)	     \
+do {									     \
+	int __maybe_unused _hook_lsmid;					     \
+									     \
+	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
+		_hook_lsmid = static_calls_table.HOOK[NUM].hl->lsmid->id;    \
+		BODY_BEFORE						     \
+		RC = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);   \
+		BODY_AFTER						     \
+	}								     \
+} while (0);
+
+#define lsm_for_each_hook(HOOK, RC, BODY, ...)	\
+	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, ;, BODY, __VA_ARGS__)
+
+#define call_hook_with_lsmid(HOOK, LSMID, ...)				\
+({									\
+	__label__ out;							\
+	int RC = LSM_RET_DEFAULT(HOOK);					\
+									\
+	LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, {			\
+		if (current_lsmid() != LSMID)				\
+			continue;					\
+	}, {								\
+		goto out;						\
+	}, __VA_ARGS__);						\
+out:									\
+	RC;								\
+})
 
 /* Security operations */
 
@@ -1184,7 +1215,6 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct lsm_static_call *scall;
 	int cap_sys_admin = 1;
 	int rc;
 
@@ -1195,13 +1225,18 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
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
+		{
+			if (rc <= 0) {
+				cap_sys_admin = 0;
+				goto out;
+			}
+		},
+		mm, pages);
+
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1343,17 +1378,19 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
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
+		{
+			if (trc == 0)
+				rc = 0;
+			else if (trc != -ENOPARAM)
+				return trc;
+		},
+		fc, param);
+
 	return rc;
 }
 
@@ -1578,15 +1615,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
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
+		{
+			if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
+				goto out;
+		},
+		sb, mnt_opts, kern_flags, set_kern_flags);
+
+out:
 	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
@@ -1777,7 +1816,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
@@ -1795,18 +1833,19 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 			return -ENOMEM;
 	}
 
-	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
-		if (ret && ret != -EOPNOTSUPP)
-			goto out;
+	lsm_for_each_hook(
+		inode_init_security, ret,
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
+		inode, dir, qstr, new_xattrs, &xattr_count);
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
 	if (!xattr_count)
@@ -3601,16 +3640,19 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
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
+		{
+			if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
+				rc = thisrc;
+				if (thisrc != 0)
+					goto out;
+			}
+		},
+		option, arg2, arg3, arg4, arg5);
+
+out:
 	return rc;
 }
 
@@ -4010,7 +4052,6 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 __user *size, u32 flags)
 {
-	struct lsm_static_call *scall;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
 	u32 entrysize;
@@ -4048,31 +4089,40 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
+		/* BODY_BEFORE */
+		{
+			if (single && lctx.id != current_lsmid())
+				continue;
+			entrysize = left;
+			if (base)
+				uctx = (struct lsm_ctx __user *)(base + total);
+		},
+		/* BODY_AFTER */
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
@@ -4103,9 +4153,8 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 size, u32 flags)
 {
-	struct lsm_static_call *scall;
 	struct lsm_ctx *lctx;
-	int rc = LSM_RET_DEFAULT(setselfattr);
+	int rc;
 	u64 required_len;
 
 	if (flags)
@@ -4126,11 +4175,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4151,14 +4196,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4175,14 +4213,7 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
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
@@ -5267,23 +5298,13 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
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


