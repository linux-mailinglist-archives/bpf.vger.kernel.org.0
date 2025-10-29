Return-Path: <bpf+bounces-72857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8780C1CDCD
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4D348C65
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423330ACEE;
	Wed, 29 Oct 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FjSKRlun"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F22F12CC
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764512; cv=none; b=fIs9a/wijTdoAPaFNKYar1D+ISoIBeKh0l87kdnBWDqieg6N/pfFWNkyKkgbFh24HFppP5TKhR+b6J/X8dXL+PBIhMl1bnPV2uSPDbXRWfTX2scU7Dv3tZLapw2CUdBT8VLxdmuBkoS82xc/s1GlAv08izd8TJtPH1VP7WAFHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764512; c=relaxed/simple;
	bh=j63u3ryh/iAOp9419Mm6WUWnn4BunK0KiBKxrdXiqJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U39jaovlehl42DBf0BA/pdYY7Piny9LYXYEVx7deMo0lHUkPayhXnCUbjRT1MOrM61Z9hpKn0wH0wwhO9QJzrnRJ9827iybm4lZ9sd6lktSL4+LXZaFVeySC2WbDYpxwRyGsoSQE/wyh0OKDmgKs/xGup3ObVf4pMXs0H/+F4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FjSKRlun; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKD951PcQJ2WQJ00UziYUT0K3eIXw9EMgjI+WFE7ASU=;
	b=FjSKRlun93Ya1Xbfyw+XHGsIbEALsRY/JGbNYtJsJbUlVihQt3jJ80V0y+pIKbKSZLVYGW
	vV+T939ZD1k6SXMfiak7sIoobgB5dse90mkKawqe1M4JrujYmdrHkH5NX5aw1ujXfeYdfR
	6A36+sIbBx9ZFX4+mec7PdcZn9ZOJNI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with KF_MAGIC_ARGS
Date: Wed, 29 Oct 2025 12:01:08 -0700
Message-ID: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A kernel function bpf_foo with KF_MAGIC_ARGS flag is expected to have
two types in BTF:
  * `bpf_foo` with a function prototype that omits __magic arguments
  * `bpf_foo_impl` with a function prototype that matches kernel
     declaration, but doesn't have a ksym associated with its name

In order to support magic kfuncs the verifier has to know how to
resolve calls both of `bpf_foo` and `bpf_foo_impl` to the correct BTF
function prototype and address.

In add_kfunc_call() kfunc flags are inspected to detect a magic kfunc
or its _impl, and then the address and func_proto are adjusted for the
kfunc descriptor.

In fetch_kfunc_meta() similar logic is used to fixup the contents of
struct bpf_kfunc_call_arg_meta.

In check_kfunc_call() reset the subreg_def of registers holding magic
arguments to correctly track zero extensions.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |   1 +
 kernel/bpf/verifier.c | 123 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9c64bc5e5789..3fe20514692f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
+#define KF_MAGIC_ARGS   (1 << 16) /* kfunc signature is different from its BPF signature */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb1b483be0fa..fcf0872b9e3d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3263,17 +3263,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
 
+/*
+ * magic_kfuncs is used as a list of (foo, foo_impl) pairs
+ */
+BTF_ID_LIST(magic_kfuncs)
+BTF_ID_UNUSED
+BTF_ID_LIST_END(magic_kfuncs)
+
+static s32 magic_kfunc_by_impl(s32 impl_func_id)
+{
+	int i;
+
+	for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
+		if (magic_kfuncs[i] == impl_func_id)
+			return magic_kfuncs[i - 1];
+	}
+	return -ENOENT;
+}
+
+static s32 impl_by_magic_kfunc(s32 func_id)
+{
+	int i;
+
+	for (i = 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
+		if (magic_kfuncs[i] == func_id)
+			return magic_kfuncs[i + 1];
+	}
+	return -ENOENT;
+}
+
+static const struct btf_type *find_magic_kfunc_proto(struct btf *desc_btf, s32 func_id)
+{
+	const struct btf_type *impl_func, *func_proto;
+	u32 impl_func_id;
+
+	impl_func_id = impl_by_magic_kfunc(func_id);
+	if (impl_func_id < 0)
+		return NULL;
+
+	impl_func = btf_type_by_id(desc_btf, impl_func_id);
+	if (!impl_func || !btf_type_is_func(impl_func))
+		return NULL;
+
+	func_proto = btf_type_by_id(desc_btf, impl_func->type);
+	if (!func_proto || !btf_type_is_func_proto(func_proto))
+		return NULL;
+
+	return func_proto;
+}
+
 static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 {
-	const struct btf_type *func, *func_proto;
+	const struct btf_type *func, *func_proto, *tmp_func;
 	struct bpf_kfunc_btf_tab *btf_tab;
+	const char *func_name, *tmp_name;
 	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
 	struct bpf_kfunc_desc *desc;
-	const char *func_name;
 	struct btf *desc_btf;
 	unsigned long addr;
+	u32 *kfunc_flags;
+	s32 tmp_func_id;
 	int err;
 
 	prog_aux = env->prog->aux;
@@ -3349,8 +3400,37 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -EINVAL;
 	}
 
+	kfunc_flags = btf_kfunc_flags(desc_btf, func_id, env->prog);
 	func_name = btf_name_by_offset(desc_btf, func->name_off);
 	addr = kallsyms_lookup_name(func_name);
+
+	/* This may be an _impl kfunc with KF_MAGIC_ARGS counterpart */
+	if (unlikely(!addr && !kfunc_flags)) {
+		tmp_func_id = magic_kfunc_by_impl(func_id);
+		if (tmp_func_id < 0)
+			return -EACCES;
+		tmp_func = btf_type_by_id(desc_btf, tmp_func_id);
+		if (!tmp_func || !btf_type_is_func(tmp_func))
+			return -EACCES;
+		tmp_name = btf_name_by_offset(desc_btf, tmp_func->name_off);
+		addr = kallsyms_lookup_name(tmp_name);
+	}
+
+	/*
+	 * Note that kfunc_flags may be NULL at this point, which means that we couldn't find
+	 * func_id in any relevant kfunc_id_set. This most likely indicates an invalid kfunc call.
+	 * However we don't want to fail the verification here, because invalid calls may be
+	 * eliminated as dead code later.
+	 */
+	if (unlikely(kfunc_flags && KF_MAGIC_ARGS & *kfunc_flags)) {
+		func_proto = find_magic_kfunc_proto(desc_btf, func_id);
+		if (!func_proto) {
+			verbose(env, "cannot find _impl proto for kernel function %s\n",
+			func_name);
+			return -EINVAL;
+		}
+	}
+
 	if (!addr) {
 		verbose(env, "cannot find address for kernel function %s\n",
 			func_name);
@@ -12051,6 +12131,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_magic(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__magic");
+}
+
 static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__prog");
@@ -13613,6 +13698,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	u32 func_id, *kfunc_flags;
 	const char *func_name;
 	struct btf *desc_btf;
+	s32 tmp_func_id;
 
 	if (kfunc_name)
 		*kfunc_name = NULL;
@@ -13632,10 +13718,28 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
 	kfunc_flags = btf_kfunc_flags_if_allowed(desc_btf, func_id, env->prog);
-	if (!kfunc_flags) {
-		return -EACCES;
+	if (unlikely(!kfunc_flags)) {
+		/*
+		 * An _impl kfunc with KF_MAGIC_ARGS counterpart
+		 * does not have its own kfunc flags.
+		 */
+		tmp_func_id = magic_kfunc_by_impl(func_id);
+		if (tmp_func_id < 0)
+			return -EACCES;
+		kfunc_flags = btf_kfunc_flags_if_allowed(desc_btf, tmp_func_id, env->prog);
+		if (!kfunc_flags)
+			return -EACCES;
+	} else if (unlikely(KF_MAGIC_ARGS & *kfunc_flags)) {
+		/*
+		 * An actual func_proto of a kfunc with KF_MAGIC_ARGS flag
+		 * can be found through the corresponding _impl kfunc.
+		 */
+		func_proto = find_magic_kfunc_proto(desc_btf, func_id);
 	}
 
+	if (!func_proto)
+		return -EACCES;
+
 	memset(meta, 0, sizeof(*meta));
 	meta->btf = desc_btf;
 	meta->func_id = func_id;
@@ -14189,6 +14293,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	for (i = 0; i < nargs; i++) {
 		u32 regno = i + 1;
 
+		/*
+		 * Magic arguments are set after main verification pass.
+		 * For correct tracking of zero-extensions we have to reset subreg_def for such
+		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_def of regs
+		 * from an earlier (irrelevant) point in the program, which may lead to an error
+		 * in opt_subreg_zext_lo32_rnd_hi32().
+		 */
+		if (unlikely(KF_MAGIC_ARGS & meta.kfunc_flags
+				&& is_kfunc_arg_magic(desc_btf, &args[i])))
+			regs[regno].subreg_def = DEF_NOT_SUBREG;
+
 		t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
 		if (btf_type_is_ptr(t))
 			mark_btf_func_reg_size(env, regno, sizeof(void *));
-- 
2.51.1


