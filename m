Return-Path: <bpf+bounces-20640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB784174B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13E71F2373B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDFA9442;
	Tue, 30 Jan 2024 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvXVpvAM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3492F2D
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573216; cv=none; b=HlQA+r2ZlKwwZf2zq2dAWvB3bFtSWZ8ju2jHeqCHO8FGxCKwDbZKK16uFeSlgEbasuGB24yHZGzoBRITKUan2qs660uSKMVJqIUyWPdHwi2CNByBvWqVivLNmbCQQtByh9CJriPdSRm+cgAslVVGiJqvGAjihZ7eH2MUQWLhU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573216; c=relaxed/simple;
	bh=z3awuv8ZyRi14h+4EwQeT10MhKSmqyaOVfZm+/7uZzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAXh5wCDKymeJpq+rLP3aXtZyG97+CwryZ5eLIvgxvLFBywfMC17CBqLocQ9grYsyGJBP5+pvDAEbweEDZhD83CYVNXFZIY9QhDpCrs3Ikx4KRc+TPbtDEUrRtJslo0frxK3Xqbc9qmidB6/XjTRD+1qUqnP145vYwW8siDtWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvXVpvAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C506FC433F1;
	Tue, 30 Jan 2024 00:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573216;
	bh=z3awuv8ZyRi14h+4EwQeT10MhKSmqyaOVfZm+/7uZzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvXVpvAM2aWOYXc9zpuBWCMBkFhTgSvnsFJo9ZM68HI6PEDZPtCh8XTJPqhaYSGG8
	 qElzDyvDfDhCmRSFFOjNQBmF+WkSLXBv1Tix97gJKEbaTJKoWZlvQDWWvzJGPoKT61
	 jvKNEBM5FpJW263PRMcSCZg7ozsgS4AvnZJEtLt/dtBqlD3V8XTYtCSooMfUZeoc6K
	 /ley8+DX1WYWPihRxZ3JgokE5lwBuR9mZW1n1dXpPLc/dOqRkizRgNl/I6CJRq2So4
	 9oCnQKloyyEdn9A+02WUVRU3dqYOfmuaw1Ga3nWAsNDqK0jfySNzD9ZWDhUYDma4WA
	 gGYT3gooHZHIQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 1/4] bpf: add __arg_trusted global func arg tag
Date: Mon, 29 Jan 2024 16:06:45 -0800
Message-Id: <20240130000648.2144827-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130000648.2144827-1-andrii@kernel.org>
References: <20240130000648.2144827-1-andrii@kernel.org>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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
index c5d68a9d8acc..cd4d780e5400 100644
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


