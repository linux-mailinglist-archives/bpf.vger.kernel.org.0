Return-Path: <bpf+bounces-48463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C674A08261
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA23A8269
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A420013C;
	Thu,  9 Jan 2025 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nz+4lmEz"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237223C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459239; cv=none; b=tKPHN67PoCeUcVVbaa6NXQGZfdO3gij7lYlapjLay7d2RJIdeKGn3Xu3FVQTFhtWVRX/73Fk18+1lTVU7IgESr3a+ExIPog2PshvJa2cbA2Ea+LGhR2nDUwPRhwRW4fGHylIky4oT+4dpNqhbco463jA91NIpM9xCp6W/ZKI1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459239; c=relaxed/simple;
	bh=WiBeSHh+LQBVxJ5aCQNltlsVfruaGCAStrDSs98cAC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dipwiKQUrt7YlfnVtT+9A5ahI3jV5k2RpNl5GbRQ90aTj9K9pab9wN9Lpcg6v8q9X4GNeXowJijKi0d9dA610DHeRGpyDaWdpOqeUZdxTybD1ErM/A5sVgO3vib0GfxLXCNXK6O5/b2xWkbpab4d8LA5QtSuc1kED6gFxTT+8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nz+4lmEz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DD9B203E3A1;
	Thu,  9 Jan 2025 13:47:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DD9B203E3A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459237;
	bh=FEHyd+flmhRzT6tWzUbZ/8QmogqhJn4Q0lSgDMVMCEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nz+4lmEzpL4P1XEZfRMbGF9lqTYb2cRKwcDwObtQIM1vSWgZKDnxYky86xDK4rr/W
	 pKc31Bq8K2TMIJT+fgJ0cfj6B+pNMdaQ4m7xEIrtKz7pfFB0siUx8JBl5pAJibD+0Z
	 /ehDQdOwgoknuxZh3nJOvgSt5oyRb7eO6BVpHAWk=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 01/14] bpf: Port prerequiste BTF handling functions from userspace
Date: Thu,  9 Jan 2025 13:43:43 -0800
Message-ID: <20250109214617.485144-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel and userspace btf libraries unfortunately differ in
functionality, API, and scope. There are many functions missing from
the kernel implementation that are used in logic for calculating
instruction relocation metadata for bpf instructions. Here we port
over functions directly from the userspace implementation, as-is, that
are used in these calculations.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/btf.h |  68 ++++++++++-
 kernel/bpf/btf.c    | 272 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 317 insertions(+), 23 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c91686..0c6a4ef47a581 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -258,6 +258,11 @@ static inline bool btf_type_is_int(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_INT;
 }
 
+static inline u8 btf_type_int_bits(const struct btf_type *t)
+{
+	return BTF_INT_BITS(*(__u32 *)(t + 1));
+}
+
 static inline bool btf_type_is_small_int(const struct btf_type *t)
 {
 	return btf_type_is_int(t) && t->size <= sizeof(u64);
@@ -278,6 +283,21 @@ static inline bool btf_type_is_enum(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM;
 }
 
+static inline bool btf_is_typedef(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
+}
+
+static inline bool btf_is_mod(const struct btf_type *t)
+{
+	u16 kind = BTF_INFO_KIND(t->info);
+
+	return kind == BTF_KIND_VOLATILE ||
+	       kind == BTF_KIND_CONST ||
+	       kind == BTF_KIND_RESTRICT ||
+	       kind == BTF_KIND_TYPE_TAG;
+}
+
 static inline bool btf_is_any_enum(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM ||
@@ -353,6 +373,16 @@ static inline bool btf_type_is_scalar(const struct btf_type *t)
 	return btf_type_is_int(t) || btf_type_is_enum(t);
 }
 
+static inline bool btf_type_is_mod(const struct btf_type *t)
+{
+	u16 kind = btf_kind(t);
+
+	return kind == BTF_KIND_VOLATILE ||
+	       kind == BTF_KIND_CONST ||
+	       kind == BTF_KIND_RESTRICT ||
+	       kind == BTF_KIND_TYPE_TAG;
+}
+
 static inline bool btf_type_is_typedef(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
@@ -383,6 +413,21 @@ static inline bool btf_type_is_type_tag(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPE_TAG;
 }
 
+static inline bool btf_type_is_datasec(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
+}
+
+static inline bool btf_is_decl_tag(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
+}
+
+static inline bool btf_is_func(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_FUNC;
+}
+
 /* union is only a special case of struct:
  * all its offsetof(member) == 0
  */
@@ -482,14 +527,19 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 	return (const struct btf_var_secinfo *)(t + 1);
 }
 
-static inline struct btf_param *btf_params(const struct btf_type *t)
+static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 {
-	return (struct btf_param *)(t + 1);
+	return (struct btf_decl_tag *)(t + 1);
 }
 
-static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
+static inline struct btf_var *btf_var(const struct btf_type *t)
 {
-	return (struct btf_decl_tag *)(t + 1);
+	return (struct btf_var *)(t + 1);
+}
+
+static inline struct btf_param *btf_params(const struct btf_type *t)
+{
+	return (struct btf_param *)(t + 1);
 }
 
 static inline int btf_id_cmp_func(const void *a, const void *b)
@@ -517,6 +567,16 @@ int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 
 struct bpf_verifier_log;
 
+struct btf *btf_init_mem(void *btf_data,
+			 u32 size,
+			 u64 btf_log_buf,
+			 u32 btf_log_level,
+			 u32 btf_log_size);
+int btf_parse_mem(struct btf *btf);
+const char *btf_str_by_offset(const struct btf *btf, u32 offset);
+u32 btf_type_cnt(const struct btf *btf);
+int btf_align_of(const struct btf *btf, u32 id);
+int btf_add_var(struct btf *btf, int name_off, int linkage, int type_id);
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 struct bpf_struct_ops;
 int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a93..02d300b8de0bc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -503,11 +503,6 @@ static bool btf_type_is_fwd(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
 }
 
-static bool btf_type_is_datasec(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
-}
-
 static bool btf_type_is_decl_tag(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
@@ -1585,10 +1580,8 @@ static void btf_verifier_log_hdr(struct btf_verifier_env *env,
 	__btf_verifier_log(log, "btf_total_size: %u\n", btf_data_size);
 }
 
-static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
+static int btf_add_type(struct btf *btf, struct btf_verifier_env *env, struct btf_type *t)
 {
-	struct btf *btf = env->btf;
-
 	if (btf->types_size == btf->nr_types) {
 		/* Expand 'types' array */
 
@@ -1630,6 +1623,23 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
 	return 0;
 }
 
+int btf_add_var(struct btf *btf, int name_off, int linkage, int type_id)
+{
+	struct btf_var *v;
+	struct btf_type *t = kmalloc(sizeof(struct btf_type) + sizeof(struct btf_var), GFP_KERNEL);
+
+	if (!t)
+		return -ENOMEM;
+
+	t->name_off = name_off;
+	t->info = BTF_KIND_VAR;
+	t->type = type_id;
+	v = btf_var(t);
+	v->linkage = linkage;
+
+	return btf_add_type(btf, NULL, t);
+}
+
 static int btf_alloc_id(struct btf *btf)
 {
 	int id;
@@ -1965,6 +1975,7 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_VAR:
 			id = type->type;
 			type = btf_type_by_id(btf, type->type);
 			break;
@@ -1978,7 +1989,6 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 			nelems *= array->nelems;
 			type = btf_type_by_id(btf, array->type);
 			break;
-
 		/* type without size */
 		default:
 			return ERR_PTR(-EINVAL);
@@ -4667,13 +4677,6 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	var = btf_type_var(t);
-	if (var->linkage != BTF_VAR_STATIC &&
-	    var->linkage != BTF_VAR_GLOBAL_ALLOCATED) {
-		btf_verifier_log_type(env, t, "Linkage not supported");
-		return -EINVAL;
-	}
-
 	btf_verifier_log_type(env, t, NULL);
 
 	return meta_needed;
@@ -5232,7 +5235,7 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
 		if (meta_size < 0)
 			return meta_size;
 
-		btf_add_type(env, t);
+		btf_add_type(btf, env, t);
 		cur += meta_size;
 		env->log_type_id++;
 	}
@@ -5348,6 +5351,71 @@ static int btf_check_all_types(struct btf_verifier_env *env)
 	return 0;
 }
 
+static int btf_type_size(const struct btf_type *t)
+{
+	const int base_size = sizeof(struct btf_type);
+	__u16 vlen = btf_vlen(t);
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_FWD:
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_TYPE_TAG:
+		return base_size;
+	case BTF_KIND_INT:
+		return base_size + sizeof(__u32);
+	case BTF_KIND_ENUM:
+		return base_size + vlen * sizeof(struct btf_enum);
+	case BTF_KIND_ENUM64:
+		return base_size + vlen * sizeof(struct btf_enum64);
+	case BTF_KIND_ARRAY:
+		return base_size + sizeof(struct btf_array);
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		return base_size + vlen * sizeof(struct btf_member);
+	case BTF_KIND_FUNC_PROTO:
+		return base_size + vlen * sizeof(struct btf_param);
+	case BTF_KIND_VAR:
+		return base_size + sizeof(struct btf_var);
+	case BTF_KIND_DATASEC:
+		return base_size + vlen * sizeof(struct btf_var_secinfo);
+	case BTF_KIND_DECL_TAG:
+		return base_size + sizeof(struct btf_decl_tag);
+	default:
+		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
+		return -EINVAL;
+	}
+}
+
+static int btf_parse_type_sec_loose(struct btf_verifier_env *env)
+{
+	struct btf *btf = env->btf;
+	struct btf_header *hdr;
+	void *cur, *end;
+
+	hdr = &btf->hdr;
+	cur = btf->nohdr_data + hdr->type_off;
+	end = cur + hdr->type_len;
+
+	env->log_type_id = btf->base_btf ? btf->start_id : 1;
+	while (cur < end) {
+		struct btf_type *t = cur;
+		s32 meta_size;
+
+		meta_size = btf_type_size(t);
+		btf_add_type(btf, env, t);
+		cur += meta_size;
+		env->log_type_id++;
+	}
+
+	return 0;
+}
+
 static int btf_parse_type_sec(struct btf_verifier_env *env)
 {
 	const struct btf_header *hdr = &env->btf->hdr;
@@ -5367,7 +5435,6 @@ static int btf_parse_type_sec(struct btf_verifier_env *env)
 	err = btf_check_all_metas(env);
 	if (err)
 		return err;
-
 	return btf_check_all_types(env);
 }
 
@@ -5736,6 +5803,173 @@ static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u32 uattr_
 	return err;
 }
 
+u32 btf_type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
+
+static u32 determine_ptr_size(const struct btf *btf)
+{
+	static const char * const long_aliases[] = {
+		"long",
+		"long int",
+		"int long",
+		"unsigned long",
+		"long unsigned",
+		"unsigned long int",
+		"unsigned int long",
+		"long unsigned int",
+		"long int unsigned",
+		"int unsigned long",
+		"int long unsigned",
+	};
+	const struct btf_type *t;
+	const char *name;
+	int i, j, n;
+
+	n = btf_type_cnt(btf);
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(btf, i);
+		if (!btf_type_is_int(t))
+			continue;
+
+		if (t->size != 4 && t->size != 8)
+			continue;
+
+		name = btf_str_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(long_aliases); j++) {
+			if (strcmp(name, long_aliases[j]) == 0)
+				return t->size;
+		}
+	}
+
+	return -1;
+}
+
+int btf_align_of(const struct btf *btf, u32 id)
+{
+	const struct btf_type *t = btf_type_by_id(btf, id);
+	__u16 kind = btf_kind(t);
+
+	switch (kind) {
+	case BTF_KIND_INT:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+	case BTF_KIND_FLOAT:
+		return min(determine_ptr_size(btf), (size_t)t->size);
+	case BTF_KIND_PTR:
+		return determine_ptr_size(btf);
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
+		return btf_align_of(btf, t->type);
+	case BTF_KIND_ARRAY:
+		return btf_align_of(btf, btf_array(t)->type);
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m = btf_members(t);
+		__u16 vlen = btf_vlen(t);
+		int i, max_align = 1, align;
+
+		for (i = 0; i < vlen; i++, m++) {
+			align = btf_align_of(btf, m->type);
+			if (align <= 0)
+				return -EINVAL;
+			max_align = max(max_align, align);
+
+			/* if field offset isn't aligned according to field
+			 * type's alignment, then struct must be packed
+			 */
+			if (btf_member_bitfield_size(t, i) == 0 &&
+			    (m->offset % (8 * align)) != 0)
+				return 1;
+		}
+
+		/* if struct/union size isn't a multiple of its alignment,
+		 * then struct must be packed
+		 */
+		if ((t->size % max_align) != 0)
+			return 1;
+
+		return max_align;
+	}
+	default:
+		pr_warn("unsupported BTF_KIND:%u\n", btf_kind(t));
+		return -EINVAL;
+	}
+}
+
+struct btf *btf_init_mem(void *btf_data,
+			 u32 size,
+			 u64 btf_log_buf,
+			 u32 btf_log_level,
+			 u32 btf_log_size)
+{
+	struct btf_verifier_env *env = NULL;
+	char __user *log_ubuf = u64_to_user_ptr(btf_log_buf);
+	struct btf *btf = NULL;
+	u8 *data;
+	int err;
+
+	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
+	if (!env)
+		return ERR_PTR(-ENOMEM);
+
+	err = bpf_vlog_init(&env->log, btf_log_level,
+			    log_ubuf, btf_log_size);
+	if (err)
+		goto errout_free;
+
+	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
+	if (!btf) {
+		err = -ENOMEM;
+		goto errout;
+	}
+	env->btf = btf;
+
+	data = kvmalloc(size, GFP_KERNEL | __GFP_NOWARN);
+	if (!data) {
+		err = -ENOMEM;
+		goto errout;
+	}
+
+	btf->data = data;
+	btf->data_size = size;
+
+	memcpy(btf->data, btf_data, size);
+
+	err = btf_parse_hdr(env);
+	if (err)
+		goto errout;
+
+	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
+
+	err = btf_parse_str_sec(env);
+	if (err)
+		goto errout;
+
+
+	err = btf_parse_type_sec_loose(env);
+	if (err)
+		goto errout;
+
+	btf_verifier_env_free(env);
+	refcount_set(&btf->refcnt, 1);
+	return btf;
+
+errout:
+errout_free:
+	btf_verifier_env_free(env);
+	if (btf)
+		btf_free(btf);
+	return ERR_PTR(err);
+}
+
 static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
@@ -9045,7 +9279,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (need_cands) {
 		kfree(cands.cands);
 		mutex_unlock(&cand_cache_mutex);
-		if (ctx->log->level & BPF_LOG_LEVEL2)
+		if (ctx->log && ctx->log->level & BPF_LOG_LEVEL2)
 			print_cand_cache(ctx->log);
 	}
 	return err;
-- 
2.47.1


