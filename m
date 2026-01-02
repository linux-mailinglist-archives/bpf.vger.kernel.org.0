Return-Path: <bpf+bounces-77719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5436CEF684
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A562D3015A9E
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622C2D0C94;
	Fri,  2 Jan 2026 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFzhEzpT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D755217F53
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767392124; cv=none; b=ESkdjxHcznGUj8iaPgtJ88T442B8/BEJwZoBEysLCUNlzCAG7KklAUdmWLG8vUto4viq1n+MsvFBsoZZF2DL96XMhQkBBi37lMMGGJX777qhiUdNeJY2oFGHghVE6B1TQS1ubE61b3ZhIO+LDQKiVoTCpUIRR+ohuiEIfrh+Q7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767392124; c=relaxed/simple;
	bh=s/SUJFy+QZoO/AWFtsFXN8mHNUyQ4B2rLeb/BZFAjx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ne/Cfo/+Tx8g42scFmb+R6KEi0TM8B/md0AgGSI0OSZAM0vM7eH1gazRhgUhHW2jNyCZOWk1GusPTlTiScSF7l0oe7SpPQnibZ55lqNLuAqBcEE0XBiQsA/MupzpgjHVCvG7jEDo9iupYbxZ4shagGLii3yUGbExCu7WujmLw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFzhEzpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA12DC116B1;
	Fri,  2 Jan 2026 22:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767392124;
	bh=s/SUJFy+QZoO/AWFtsFXN8mHNUyQ4B2rLeb/BZFAjx0=;
	h=From:To:Cc:Subject:Date:From;
	b=CFzhEzpTqDkYYnGOA4xP2zmve47dopLcPF51iYeC3e6xPT+CKBcdq8BiIp9OcHRZw
	 XDLE5gfyHktObgFGV+cVJ3y/S7xVGw/bbvhtDrwjBvBYqRuTxnsod4QGYXpk1n4b/K
	 CUsrJ8Y7KriJ92Uhf+NmHpWuFEb5P5dUzFFgIqMJ5KWkHuwJxYo7Cr/HaXxGOFE1s1
	 QgHQU8ia6gHGaxXDw3S0XwzV7JA24pr7+T1kBrqUTwtl/9q8M6UGtCpVCBYv/SY2EE
	 SkbKIYTCxOge8c44DxTgWziwS067qSVnxweqVzmlyZ0MmPZXBJqHW5gewtKpH5RdtU
	 4NJyc0JEc/jPw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] bpf: Replace __opt annotation with __nullable for kfuncs
Date: Fri,  2 Jan 2026 14:15:12 -0800
Message-ID: <20260102221513.1961781-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __opt annotation was originally introduced specifically for
buffer/size argument pairs in bpf_dynptr_slice() and
bpf_dynptr_slice_rdwr(), allowing the buffer pointer to be NULL while
still validating the size as a constant.  The __nullable annotation
serves the same purpose but is more general and is already used
throughout the BPF subsystem for raw tracepoints, struct_ops, and other
kfuncs.

This patch unifies the two annotations by replacing __opt with
__nullable.  The key change is in the verifier's
get_kfunc_ptr_arg_type() function, where mem/size pair detection is now
performed before the nullable check.  This ensures that buffer/size
pairs are correctly classified as KF_ARG_PTR_TO_MEM_SIZE even when the
buffer is nullable, while adding an !arg_mem_size condition to the
nullable check prevents interference with mem/size pair handling.

When processing KF_ARG_PTR_TO_MEM_SIZE arguments, the verifier now uses
is_kfunc_arg_nullable() instead of the removed is_kfunc_arg_optional()
to determine whether to skip size validation for NULL buffers.

This is the first documentation added for the __nullable annotation,
which has been in use since it was introduced but was previously
undocumented.

No functional changes to verifier behavior - nullable buffer/size pairs
continue to work exactly as before.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

v1: https://lore.kernel.org/all/20251231232623.2713255-1-puranjay@kernel.org/
Changes in v1->v2:
- Rebase on bpf-next/master

---
 Documentation/bpf/kfuncs.rst | 31 ++++++++++++++++++++-----------
 include/linux/bpf.h          |  2 +-
 kernel/bpf/helpers.c         | 28 ++++++++++++++--------------
 kernel/bpf/verifier.c        | 23 +++++++++--------------
 4 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 6cb6857bfa6f..3eb59a8f9f34 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -178,25 +178,34 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
-2.3.4 __opt Annotation
--------------------------
+2.3.4 __nullable Annotation
+---------------------------
 
-This annotation is used to indicate that the buffer associated with an __sz or __szk
-argument may be null. If the function is passed a nullptr in place of the buffer,
-the verifier will not check that length is appropriate for the buffer. The kfunc is
-responsible for checking if this buffer is null before using it.
+This annotation is used to indicate that the pointer argument may be NULL.
+The verifier will allow passing NULL for such arguments.
 
 An example is given below::
 
-        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__opt, u32 buffer__szk)
+        __bpf_kfunc void bpf_task_release(struct task_struct *task__nullable)
         {
         ...
         }
 
-Here, the buffer may be null. If buffer is not null, it at least of size buffer_szk.
-Either way, the returned buffer is either NULL, or of size buffer_szk. Without this
-annotation, the verifier will reject the program if a null pointer is passed in with
-a nonzero size.
+Here, the task pointer may be NULL. The kfunc is responsible for checking if
+the pointer is NULL before dereferencing it.
+
+The __nullable annotation can be combined with other annotations. For example,
+when used with __sz or __szk annotations for memory and size pairs, the
+verifier will skip size validation when a NULL pointer is passed, but will
+still process the size argument to extract constant size information when
+needed::
+
+        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__nullable,
+                                           u32 buffer__szk)
+
+Here, the buffer may be NULL. If the buffer is not NULL, it must be at least
+buffer__szk bytes in size. The kfunc is responsible for checking if the buffer
+is NULL before using it.
 
 2.3.5 __str Annotation
 ----------------------------
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9efb2ddf331c..c14de549131d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1434,7 +1434,7 @@ bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset,
 		       void *src, u64 len, u64 flags);
 void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
-			    void *buffer__opt, u64 buffer__szk);
+			    void *buffer__nullable, u64 buffer__szk);
 
 static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u64 offset, u64 len)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2c15f77c74db..9eaa4185e0a7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2709,14 +2709,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
+ * @buffer__nullable: User-provided buffer to copy contents into.  May be NULL
  * @buffer__szk: Size (in bytes) of the buffer if present. This is the
  *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
- *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *  If buffer__nullable is NULL, the call will fail if buffer_opt was needed.
  *
  * If the intention is to write to the data slice, please use
  * bpf_dynptr_slice_rdwr.
@@ -2734,7 +2734,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
-				   void *buffer__opt, u64 buffer__szk)
+				   void *buffer__nullable, u64 buffer__szk)
 {
 	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	enum bpf_dynptr_type type;
@@ -2755,8 +2755,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		if (buffer__opt)
-			return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
+		if (buffer__nullable)
+			return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__nullable);
 		else
 			return skb_pointer_if_linear(ptr->data, ptr->offset + offset, len);
 	case BPF_DYNPTR_TYPE_XDP:
@@ -2765,16 +2765,16 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 		if (!IS_ERR_OR_NULL(xdp_ptr))
 			return xdp_ptr;
 
-		if (!buffer__opt)
+		if (!buffer__nullable)
 			return NULL;
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
-		return buffer__opt;
+		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__nullable, len, false);
+		return buffer__nullable;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_FILE:
-		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__opt, buffer__szk);
-		return err ? NULL : buffer__opt;
+		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__nullable, buffer__szk);
+		return err ? NULL : buffer__nullable;
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
@@ -2785,14 +2785,14 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer__opt: User-provided buffer to copy contents into. May be NULL
+ * @buffer__nullable: User-provided buffer to copy contents into. May be NULL
  * @buffer__szk: Size (in bytes) of the buffer if present. This is the
  *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
- * If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ * If buffer__nullable is NULL, the call will fail if buffer_opt was needed.
  *
  * The returned pointer is writable and may point to either directly the dynptr
  * data at the requested offset or to the buffer if unable to obtain a direct
@@ -2824,7 +2824,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
-					void *buffer__opt, u64 buffer__szk)
+					void *buffer__nullable, u64 buffer__szk)
 {
 	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
@@ -2853,7 +2853,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(p, offset, buffer__opt, buffer__szk);
+	return bpf_dynptr_slice(p, offset, buffer__nullable, buffer__szk);
 }
 
 __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9da70dd3e72..9394b0de2ef0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12086,11 +12086,6 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return btf_param_match_suffix(btf, arg, "__szk");
 }
 
-static bool is_kfunc_arg_optional(const struct btf *btf, const struct btf_param *arg)
-{
-	return btf_param_match_suffix(btf, arg, "__opt");
-}
-
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__k");
@@ -12510,6 +12505,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
 		return KF_ARG_PTR_TO_CTX;
 
+	if (argno + 1 < nargs &&
+	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
+		arg_mem_size = true;
+
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -12518,7 +12518,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
-	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg) &&
+	    !arg_mem_size)
 		return KF_ARG_PTR_TO_NULL;
 
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
@@ -12575,11 +12576,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
-	if (argno + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
-		arg_mem_size = true;
-
 	/* This is the catch all argument type of register types supported by
 	 * check_helper_mem_access. However, we only allow when argument type is
 	 * pointer to scalar, or struct composed (recursively) of scalars. When
@@ -13249,8 +13245,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
-		    !is_kfunc_arg_nullable(meta->btf, &args[i]) &&
-		    !is_kfunc_arg_optional(meta->btf, &args[i])) {
+		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -13566,7 +13561,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			struct bpf_reg_state *size_reg = &regs[regno + 1];
 			const struct btf_param *size_arg = &args[i + 1];
 
-			if (!register_is_null(buff_reg) || !is_kfunc_arg_optional(meta->btf, buff_arg)) {
+			if (!register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
 				ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
 				if (ret < 0) {
 					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);

base-commit: e40030a46acc07bb956068e59c614f1a17459a18
-- 
2.47.3


