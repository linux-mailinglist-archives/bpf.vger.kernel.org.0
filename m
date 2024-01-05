Return-Path: <bpf+bounces-19088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49503824C0D
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BDF1C227CC
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3015811;
	Fri,  5 Jan 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQFKDagV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76330A32
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD38C433C7;
	Fri,  5 Jan 2024 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413368;
	bh=5q7rLso+6iqLLJhTORBY4u0/G2CT3RZgwXuRQ5xaDeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQFKDagV9tfNCXvSqOZMwXb7kcoxg0IPRaDC8anf/Yok998Lx3SY4q5LYxmc+dpA8
	 WhHxWjQ7NezNF2r24dWpykBX6e/pvXktf41yOMcRuj3kAuYtNzvNG+S/i+gJ3CfYVU
	 XJtnuyRq2l9XdzZfVv+kITELqnyqddUQ3enFZVFCwUSyLKCmk1dF/wtFGHPjqF7SnF
	 e57fFGfi/be5zKUZQk/aFmm5cejUzt1jyM/RpaNDfRkxlsvpU6Jq32YHxddpdrMfHf
	 aCWCpmvIPK0y+XhEpYNU4aSgccTSqRhTLIoMwuKbR7prNmxOK17tipna9dihUElh0F
	 5SmpWE5M+oOXg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 5/8] bpf: add __arg_trusted and __arg_untrusted global func tags
Date: Thu,  4 Jan 2024 16:09:06 -0800
Message-Id: <20240105000909.2818934-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for passing PTR_TO_BTF_ID registers to global subprogs.
Currently two flavors are supported: trusted and untrusted. In both
cases we assume _OR_NULL variants, so user would be forced to do a NULL
check. __arg_nonnull can be used in conjunction with
__arg_{trusted,untrusted} annotation to avoid unnecessary NULL checks,
and subprog caller will be forced to provided known non-NULL pointers.

Alternatively, we can add __arg_nullable and change default to be
non-_OR_NULL, and __arg_nullable will allow to force NULL checks, if
necessary. This probably would be a better usability overall, so let's
discuss this.

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
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              | 103 +++++++++++++++---
 kernel/bpf/verifier.c                         |  31 ++++++
 .../bpf/progs/nested_trust_failure.c          |   2 +-
 4 files changed, 123 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d07d857ca67f..eaea129c38ff 100644
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
index 368d8fe19d35..287a0581516e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6802,9 +6802,78 @@ static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
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
+	if (strcmp(cc->cands[0].btf->name, "vmlinux") != 0) {
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
+	ARG_TAG_UNTRUSTED = 0x8,
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -6906,6 +6975,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 
 			if (strcmp(tag, "ctx") == 0) {
 				tags |= ARG_TAG_CTX;
+			} else if (strcmp(tag, "trusted") == 0) {
+				tags |= ARG_TAG_TRUSTED;
+			} else if (strcmp(tag, "untrusted") == 0) {
+				tags |= ARG_TAG_UNTRUSTED;
 			} else if (strcmp(tag, "nonnull") == 0) {
 				tags |= ARG_TAG_NONNULL;
 			} else {
@@ -6940,6 +7013,23 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].arg_type = ARG_PTR_TO_DYNPTR | MEM_RDONLY;
 			continue;
 		}
+		if (tags & (ARG_TAG_TRUSTED | ARG_TAG_UNTRUSTED)) {
+			int kern_type_id;
+
+			kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
+			if (kern_type_id < 0)
+				return kern_type_id;
+
+			sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_MAYBE_NULL;
+			if (tags & ARG_TAG_TRUSTED) {
+				sub->args[i].arg_type &= ~PTR_UNTRUSTED;
+				sub->args[i].arg_type |= PTR_TRUSTED;
+			}
+			if (tags & ARG_TAG_NONNULL)
+				sub->args[i].arg_type &= ~PTR_MAYBE_NULL;
+			sub->args[i].btf_id = kern_type_id;
+			continue;
+		}
 		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
@@ -8042,17 +8132,6 @@ size_t bpf_core_essential_name_len(const char *name)
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
@@ -8073,8 +8152,6 @@ static struct bpf_cand_cache *vmlinux_cand_cache[VMLINUX_CAND_CACHE_SIZE];
 #define MODULE_CAND_CACHE_SIZE 31
 static struct bpf_cand_cache *module_cand_cache[MODULE_CAND_CACHE_SIZE];
 
-static DEFINE_MUTEX(cand_cache_mutex);
-
 static void __print_cand_cache(struct bpf_verifier_log *log,
 			       struct bpf_cand_cache **cache,
 			       int cache_size)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 271c82bf9697..b43a74b8487b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8076,6 +8076,7 @@ static const struct bpf_reg_types btf_ptr_types = {
 		PTR_TO_BTF_ID,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
 		PTR_TO_BTF_ID | MEM_RCU,
+		PTR_TO_BTF_ID | PTR_UNTRUSTED,
 	},
 };
 static const struct bpf_reg_types percpu_btf_ptr_types = {
@@ -8262,6 +8263,12 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
 		/* Handled by helper specific checks */
 		break;
+	case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		if (!(arg_type & PTR_UNTRUSTED)) {
+			verbose(env, "Passing unexpected untrusted pointer as arg#%d\n", regno);
+			return -EACCES;
+		}
+		break;
 	default:
 		verbose(env, "verifier internal error: invalid PTR_TO_BTF_ID register for type match\n");
 		return -EFAULT;
@@ -9300,6 +9307,18 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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
@@ -20080,6 +20099,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_failure.c b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
index ea39497f11ed..bb1001a1fb19 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_failure.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
@@ -41,7 +41,7 @@ int BPF_PROG(test_invalid_nested_offset, struct task_struct *task, u64 clone_fla
 
 /* Although R2 is of type sk_buff but sock_common is expected, we will hit untrusted ptr first. */
 SEC("tp_btf/tcp_probe")
-__failure __msg("R2 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__failure __msg("Passing unexpected untrusted pointer as arg#2")
 int BPF_PROG(test_invalid_skb_field, struct sock *sk, struct sk_buff *skb)
 {
 	bpf_sk_storage_get(&sk_storage_map, skb->next, 0, 0);
-- 
2.34.1


