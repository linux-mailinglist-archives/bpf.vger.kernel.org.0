Return-Path: <bpf+bounces-21797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A9852291
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96222B21759
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512E4F896;
	Mon, 12 Feb 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU1Gingn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DA3A8C2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780747; cv=none; b=lY4GSnq+9COHgcSvAznLRgh6cejYAOCmY7OjDITNHj3xlmVH/+PKkDQIu9VsVlUDDMofBdWc+SGBrfFpP7EjZruejcQsiKEGkKQTnVKrIhiMRNQuj1YM3NQr9DZlZyZRhAriWxouU5PvaBuR1b+6DZhJrj28Vom8OziJt5IVnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780747; c=relaxed/simple;
	bh=ihcAai2OdKzaL/m+OGN1eDSJXOKdauw6wDzofwDqAWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=th2uzH/zI15en8ztdnp+V9vCs0B2mm8gY7t54Rd0s0UAiT24o31xjkAjVV8tZpn6dwXsgaT65lBAAau8L8MTumXZTGs1RV0ZCYzkp4/YF/xMBLZa45c7QpYrbLulB0ekYFnUBJjfht3qHv5wYPHDXx2RFAqrjw/Qaw67miH3jOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU1Gingn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26579C433F1;
	Mon, 12 Feb 2024 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780747;
	bh=ihcAai2OdKzaL/m+OGN1eDSJXOKdauw6wDzofwDqAWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OU1Gingnnq5eZqfVjWeJWBTy3NHeUrqDN9+JcnZrA4Z1yqI8rKFhjmAttTOAGhznK
	 Pi7FqPRcixkwPm86LVIzenRIISwKarIyZkQ+mldLAuOXMlfPdpbIAnfjwAv6CZuw5W
	 gO7u6kjuhGzmumfpQZUQdOLMmeZmX9fbO9bTQ0zWhLpjV2nUvWnbVZZ4qnMtT2gYgr
	 5zx6ib1e7Qr9rOum0qUVO90CHIqXhRAYPPuMcIGFWbto7v17f1LEdz4UbEbexT0Clo
	 0e1DGpZgbCgTjjrIWOnVdyQ3tkYFR9dkkA5enV61PhMGaGrvlnehHwhVfJ7isbt2oX
	 QxEDZTEKexLfg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/4] bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
Date: Mon, 12 Feb 2024 15:32:18 -0800
Message-Id: <20240212233221.2575350-2-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>
References: <20240212233221.2575350-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return result of btf_get_prog_ctx_type() is never used and callers only
check NULL vs non-NULL case to determine if given type matches expected
PTR_TO_CTX type. So rename function to `btf_is_prog_ctx_type()` and
return a simple true/false. We'll use this simpler interface to handle
kprobe program type's special typedef case in the next patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/btf.h   | 17 ++++++++---------
 kernel/bpf/btf.c      | 27 +++++++++++++--------------
 kernel/bpf/verifier.c |  2 +-
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1ee8977b8c95..7cfccd7a851d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -525,10 +525,9 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
-const struct btf_type *
-btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, enum bpf_prog_type prog_type,
-		      int arg);
+bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+			   const struct btf_type *t, enum bpf_prog_type prog_type,
+			   int arg);
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
@@ -568,12 +567,12 @@ static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf
 {
 	return NULL;
 }
-static inline const struct btf_member *
-btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, enum bpf_prog_type prog_type,
-		      int arg)
+static inline bool
+btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+		     const struct btf_type *t, enum bpf_prog_type prog_type,
+		     int arg)
 {
-	return NULL;
+	return false;
 }
 static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
 				      enum bpf_prog_type prog_type) {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8e06d29961f1..f0ce384aa73e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5687,10 +5687,9 @@ static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
 	return ctx_type->type;
 }
 
-const struct btf_type *
-btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, enum bpf_prog_type prog_type,
-		      int arg)
+bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
+			  const struct btf_type *t, enum bpf_prog_type prog_type,
+			  int arg)
 {
 	const struct btf_type *ctx_type;
 	const char *tname, *ctx_tname;
@@ -5704,26 +5703,26 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		 * is not supported yet.
 		 * BPF_PROG_TYPE_RAW_TRACEPOINT is fine.
 		 */
-		return NULL;
+		return false;
 	}
 	tname = btf_name_by_offset(btf, t->name_off);
 	if (!tname) {
 		bpf_log(log, "arg#%d struct doesn't have a name\n", arg);
-		return NULL;
+		return false;
 	}
 
 	ctx_type = find_canonical_prog_ctx_type(prog_type);
 	if (!ctx_type) {
 		bpf_log(log, "btf_vmlinux is malformed\n");
 		/* should not happen */
-		return NULL;
+		return false;
 	}
 again:
 	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
 	if (!ctx_tname) {
 		/* should not happen */
 		bpf_log(log, "Please fix kernel include/linux/bpf_types.h\n");
-		return NULL;
+		return false;
 	}
 	/* only compare that prog's ctx type name is the same as
 	 * kernel expects. No need to compare field by field.
@@ -5733,20 +5732,20 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	 * { // no fields of skb are ever used }
 	 */
 	if (strcmp(ctx_tname, "__sk_buff") == 0 && strcmp(tname, "sk_buff") == 0)
-		return ctx_type;
+		return true;
 	if (strcmp(ctx_tname, "xdp_md") == 0 && strcmp(tname, "xdp_buff") == 0)
-		return ctx_type;
+		return true;
 	if (strcmp(ctx_tname, tname)) {
 		/* bpf_user_pt_regs_t is a typedef, so resolve it to
 		 * underlying struct and check name again
 		 */
 		if (!btf_type_is_modifier(ctx_type))
-			return NULL;
+			return false;
 		while (btf_type_is_modifier(ctx_type))
 			ctx_type = btf_type_by_id(btf_vmlinux, ctx_type->type);
 		goto again;
 	}
-	return ctx_type;
+	return true;
 }
 
 /* forward declarations for arch-specific underlying types of
@@ -5898,7 +5897,7 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 				     enum bpf_prog_type prog_type,
 				     int arg)
 {
-	if (!btf_get_prog_ctx_type(log, btf, t, prog_type, arg))
+	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg))
 		return -ENOENT;
 	return find_kern_ctx_type_id(prog_type);
 }
@@ -7184,7 +7183,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		if (!btf_type_is_ptr(t))
 			goto skip_pointer;
 
-		if ((tags & ARG_TAG_CTX) || btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i)) {
 			if (tags & ~ARG_TAG_CTX) {
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddaf09db1175..0a6e047e4ee4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11033,7 +11033,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
+	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
-- 
2.39.3


