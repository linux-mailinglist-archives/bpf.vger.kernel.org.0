Return-Path: <bpf+bounces-20346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A322C83CDDE
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C0CB24AE3
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFDE1386D0;
	Thu, 25 Jan 2024 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTlgxWli"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575991386C2
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216126; cv=none; b=qmUgDpbVQqfc1rkvdaa82SPvp5qkzZQRDOuDWoyZ/gnlwvI350m/r1uDBFWTLQuzahDrThBQI8BH+SyHp5LRnfdeqw8HqAQWGNO+eRrhuHbpfQ78uMfqRruk7PnyhNWnvt3hz1e7kJGlCBKy9prNprrAHu57tWS0sofveex07Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216126; c=relaxed/simple;
	bh=1KpCuPIovSJOqd5RRcAkrNIn8q5KGLZOddwoys4XIs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTW3l+YzSa28JzPP9EhDJ2n3N4Cce47dsMywpxaEeztrCF3f5AUNUBo4aT0Hd3U8Pap8Md93gn88/e3b5zONSeXh14AcB272/0Mnr6zAwYLTv7QaYcxBj98IsHZoK/jif3TvmTnI8OvGmL0VDTXZ+DHfLQqq94XsbZDE311rrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTlgxWli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B9DC433C7;
	Thu, 25 Jan 2024 20:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216125;
	bh=1KpCuPIovSJOqd5RRcAkrNIn8q5KGLZOddwoys4XIs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTlgxWliiMHitD0UkYINR591nEBmuEdgv5AqAMLAEAYcZjzZnI6xFIetLp5ZFKDuW
	 FTwt+WZWTdEo4C6/eEq1IItYAf+3RnCW7y27F6/BKtkL4FVl4W23euaLB+7vgJBLWs
	 VmNGfmTp9HxENrRbJDVQZsG1jzUza8mACvXh7KZwkVNCQuNsGPRhPAIKyXNhteJUGu
	 0c8fKcGfYyHPcr3eVv2u0cW19AvFB4LRPWrCruRtE8jlUKMd/rzc0tAtPu61rShf9e
	 QtsGPOuugrjYtjlJyWDIluUqEWYFdIZb0aN15g/MQKrHgmxrGFFKJIel32LGFOFrgJ
	 nvE4DqDxAL7Rg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 4/7] bpf: add __arg_trusted global func arg tag
Date: Thu, 25 Jan 2024 12:55:07 -0800
Message-Id: <20240125205510.3642094-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for passing PTR_TO_BTF_ID registers to global subprogs.
Currently only PTR_TRUSTED flavor of PTR_TO_BTF_ID is supported.
Non-NULL semantics is assumed, so caller will be forced to prove
PTR_TO_BTF_ID can't be NULL.

Note, we disallow global subprogs to destroy passed in PTR_TO_BTF_ID
arguments, even the trusted one. We achieve that by not setting
ref_obj_id when validating subprog code. This basically enforces (in
Rust terms) borrowing semantics vs move semantics. Borrowing semantics
seems to be a better fit for isolated global subprog validation
approach.

Implementation-wise, we utilize existing logic for matching
user-provided BTF type to kernel-side BTF type, used by BPF CO-RE logic
and following same matching rules. We enforce a unique match for types.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/btf.c             | 99 +++++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c        | 24 +++++++++
 3 files changed, 111 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7f5816482a10..0dcde339dc7e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -610,6 +610,7 @@ struct bpf_subprog_arg_info {
 	enum bpf_arg_type arg_type;
 	union {
 		u32 mem_size;
+		u32 btf_id;
 	};
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9ec08cfb2967..ed7a05815984 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6985,9 +6985,77 @@ static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 	return false;
 }
 
+struct bpf_cand_cache {
+	const char *name;
+	u32 name_len;
+	u16 kind;
+	u16 cnt;
+	struct {
+		const struct btf *btf;
+		u32 id;
+	} cands[];
+};
+
+static DEFINE_MUTEX(cand_cache_mutex);
+
+static struct bpf_cand_cache *
+bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id);
+
+static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
+				 const struct btf *btf, const struct btf_type *t)
+{
+	struct bpf_cand_cache *cc;
+	struct bpf_core_ctx ctx = {
+		.btf = btf,
+		.log = log,
+	};
+	u32 kern_type_id, type_id;
+	int err = 0;
+
+	/* skip PTR and modifiers */
+	type_id = t->type;
+	t = btf_type_by_id(btf, t->type);
+	while (btf_type_is_modifier(t)) {
+		type_id = t->type;
+		t = btf_type_by_id(btf, t->type);
+	}
+
+	mutex_lock(&cand_cache_mutex);
+	cc = bpf_core_find_cands(&ctx, type_id);
+	if (IS_ERR(cc)) {
+		err = PTR_ERR(cc);
+		bpf_log(log, "arg#%d reference type('%s %s') candidate matching error: %d\n",
+			arg_idx, btf_type_str(t), __btf_name_by_offset(btf, t->name_off),
+			err);
+		goto cand_cache_unlock;
+	}
+	if (cc->cnt != 1) {
+		bpf_log(log, "arg#%d reference type('%s %s') %s\n",
+			arg_idx, btf_type_str(t), __btf_name_by_offset(btf, t->name_off),
+			cc->cnt == 0 ? "has no matches" : "is ambiguous");
+		err = cc->cnt == 0 ? -ENOENT : -ESRCH;
+		goto cand_cache_unlock;
+	}
+	if (btf_is_module(cc->cands[0].btf)) {
+		bpf_log(log, "arg#%d reference type('%s %s') points to kernel module type (unsupported)\n",
+			arg_idx, btf_type_str(t), __btf_name_by_offset(btf, t->name_off));
+		err = -EOPNOTSUPP;
+		goto cand_cache_unlock;
+	}
+	kern_type_id = cc->cands[0].id;
+
+cand_cache_unlock:
+	mutex_unlock(&cand_cache_mutex);
+	if (err)
+		return err;
+
+	return kern_type_id;
+}
+
 enum btf_arg_tag {
 	ARG_TAG_CTX = 0x1,
 	ARG_TAG_NONNULL = 0x2,
+	ARG_TAG_TRUSTED = 0x4,
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7089,6 +7157,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 
 			if (strcmp(tag, "ctx") == 0) {
 				tags |= ARG_TAG_CTX;
+			} else if (strcmp(tag, "trusted") == 0) {
+				tags |= ARG_TAG_TRUSTED;
 			} else if (strcmp(tag, "nonnull") == 0) {
 				tags |= ARG_TAG_NONNULL;
 			} else {
@@ -7127,6 +7197,22 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].arg_type = ARG_PTR_TO_DYNPTR | MEM_RDONLY;
 			continue;
 		}
+		if (tags & ARG_TAG_TRUSTED) {
+			int kern_type_id;
+
+			if (tags & ARG_TAG_NONNULL) {
+				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
+				return -EINVAL;
+			}
+
+			kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
+			if (kern_type_id < 0)
+				return kern_type_id;
+
+			sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_TRUSTED;
+			sub->args[i].btf_id = kern_type_id;
+			continue;
+		}
 		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
@@ -8229,17 +8315,6 @@ size_t bpf_core_essential_name_len(const char *name)
 	return n;
 }
 
-struct bpf_cand_cache {
-	const char *name;
-	u32 name_len;
-	u16 kind;
-	u16 cnt;
-	struct {
-		const struct btf *btf;
-		u32 id;
-	} cands[];
-};
-
 static void bpf_free_cands(struct bpf_cand_cache *cands)
 {
 	if (!cands->cnt)
@@ -8260,8 +8335,6 @@ static struct bpf_cand_cache *vmlinux_cand_cache[VMLINUX_CAND_CACHE_SIZE];
 #define MODULE_CAND_CACHE_SIZE 31
 static struct bpf_cand_cache *module_cand_cache[MODULE_CAND_CACHE_SIZE];
 
-static DEFINE_MUTEX(cand_cache_mutex);
-
 static void __print_cand_cache(struct bpf_verifier_log *log,
 			       struct bpf_cand_cache **cache,
 			       int cache_size)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe833e831cb6..4879dee8d725 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9336,6 +9336,18 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
 			if (ret)
 				return ret;
+		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
+			struct bpf_call_arg_meta meta;
+			int err;
+
+			if (register_is_null(reg) && type_may_be_null(arg->arg_type))
+				continue;
+
+			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
+			err = check_reg_type(env, regno, arg->arg_type, &arg->btf_id, &meta);
+			err = err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type);
+			if (err)
+				return err;
 		} else {
 			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
 				i, arg->arg_type);
@@ -20137,6 +20149,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 				reg->mem_size = arg->mem_size;
 				reg->id = ++env->id_gen;
+			} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
+				reg->type = PTR_TO_BTF_ID;
+				if (arg->arg_type & PTR_MAYBE_NULL)
+					reg->type |= PTR_MAYBE_NULL;
+				if (arg->arg_type & PTR_UNTRUSTED)
+					reg->type |= PTR_UNTRUSTED;
+				if (arg->arg_type & PTR_TRUSTED)
+					reg->type |= PTR_TRUSTED;
+				mark_reg_known_zero(env, regs, i);
+				reg->btf = bpf_get_btf_vmlinux(); /* can't fail at this point */
+				reg->btf_id = arg->btf_id;
+				reg->id = ++env->id_gen;
 			} else {
 				WARN_ONCE(1, "BUG: unhandled arg#%d type %d\n",
 					  i - BPF_REG_1, arg->arg_type);
-- 
2.34.1


