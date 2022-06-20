Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9C552842
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiFTXXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347409AbiFTXXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:23:07 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DE2C116
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:18:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 534EA240108
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655767088; bh=Cq6Nm8JiuyRCdBvioPzT77BBcV2NbrIR8+spzjI0rRg=;
        h=From:To:Subject:Date:From;
        b=MR//u4hBU9KzO6RVrVXWldW8deffV/2wiHuNyp1rkRPdFjPVwpoPrKUfIYyrpyGQ6
         RLXbcNC5f7oG4DUHixlZw5geeqMfcDwn2VQTTrZ2K9OV31fwD9POlimjNAXFuPJvbC
         1uJ/WtE0AXhJk2xGUiprmG4jDUwKyIHfQ+y3esJkMDIKDl1hRCdLPFe8KvPOGgxsTl
         EfL40rEiBVVugq90li5eaS6QWQ+haHVenZ+GbTODTDrs9SW3TmLOjn3APaWNZmaou0
         yKbh3Jn0vwkRFYkNi8iOsX+3KHypmWUbTAQh3NEMkWaSj2xdxjqKqz4ivEPF0hInd3
         9NvlO0pkS3wTw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LRltl3lm1z6tmj;
        Tue, 21 Jun 2022 01:18:07 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next 4/7] libbpf: Add type match support
Date:   Mon, 20 Jun 2022 23:17:10 +0000
Message-Id: <20220620231713.2143355-5-deso@posteo.net>
In-Reply-To: <20220620231713.2143355-1-deso@posteo.net>
References: <20220620231713.2143355-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support for the proposed type match relation to libbpf.
Support of this relation hinges on the corresponding relocation to be
understood by LLVM, which is happening as part of D126838
(https://reviews.llvm.org/D126838).
The functionality is present behind the newly introduced
bpf_core_type_matches macro (similar to bpf_core_type_exists). This
macro can be used to check whether a local type has a "match" in a
target BTF.

The matching relation is defined as follows (copy from source):
- modifiers and typedefs are stripped (and, hence, effectively ignored)
- generally speaking types need to be of same kind (struct vs. struct, union
  vs. union, etc.)
  - exceptions are struct/union behind a pointer which could also match a
    forward declaration of a struct or union, respectively, and enum vs.
    enum64 (see below)
Then, depending on type:
- integers:
  - match if size and signedness match
- arrays & pointers:
  - target types are recursively matched
- structs & unions:
  - local members need to exist in target with the same name
  - for each member we recursively check match unless it is already behind a
    pointer, in which case we only check matching names and compatible kind
- enums:
  - local variants have to have a match in target by symbolic name (but not
    numeric value)
  - size has to match (but enum may match enum64 and vice versa)
- function pointers:
  - number and position of arguments in local type has to match target
  - for each argument and the return value we recursively check match

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/bpf_core_read.h |  10 ++
 tools/lib/bpf/libbpf.c        | 277 ++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.c     |  16 +-
 tools/lib/bpf/relo_core.h     |   2 +
 4 files changed, 301 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 2308f49..496e6a 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -184,6 +184,16 @@ enum bpf_enum_value_kind {
 #define bpf_core_type_exists(type)					    \
 	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_EXISTS)
 
+/*
+ * Convenience macro to check that provided named type
+ * (struct/union/enum/typedef) "matches" that in a target kernel.
+ * Returns:
+ *    1, if the type matches in the target kernel's BTF;
+ *    0, if the type does not match any in the target kernel
+ */
+#define bpf_core_type_matches(type)					    \
+	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_MATCHES)
+
 /*
  * Convenience macro to get the byte size of a provided named type
  * (struct/union/enum/typedef) in a target kernel.
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49e359c..8f7674 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5805,6 +5805,283 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 	}
 }
 
+static bool bpf_core_names_match(const struct btf *local_btf, __u32 local_id,
+				 const struct btf *targ_btf, __u32 targ_id)
+{
+	const struct btf_type *local_t, *targ_t;
+	const char *local_n, *targ_n;
+	size_t local_len, targ_len;
+
+	local_t = btf__type_by_id(local_btf, local_id);
+	targ_t = btf__type_by_id(targ_btf, targ_id);
+	local_n = btf__str_by_offset(local_btf, local_t->name_off);
+	targ_n = btf__str_by_offset(targ_btf, targ_t->name_off);
+	local_len = bpf_core_essential_name_len(local_n);
+	targ_len = bpf_core_essential_name_len(targ_n);
+
+	return local_len == targ_len && strncmp(local_n, targ_n, local_len) == 0;
+}
+
+static int bpf_core_enums_match(const struct btf *local_btf, const struct btf_type *local_t,
+				const struct btf *targ_btf, const struct btf_type *targ_t)
+{
+	__u16 local_vlen = btf_vlen(local_t);
+	__u16 targ_vlen = btf_vlen(targ_t);
+	int i, j;
+
+	if (local_t->size != targ_t->size)
+		return 0;
+
+	if (local_vlen > targ_vlen)
+		return 0;
+
+	/* iterate over the local enum's variants and make sure each has
+	 * a symbolic name correspondent in the target
+	 */
+	for (i = 0; i < local_vlen; i++) {
+		bool matched = false;
+		const char *local_n;
+		__u32 local_n_off;
+		size_t local_len;
+
+		local_n_off = btf_is_enum(local_t) ? btf_enum(local_t)[i].name_off :
+						     btf_enum64(local_t)[i].name_off;
+
+		local_n = btf__str_by_offset(local_btf, local_n_off);
+		local_len = bpf_core_essential_name_len(local_n);
+
+		for (j = 0; j < targ_vlen; j++) {
+			__u32 targ_n_off;
+			const char *targ_n;
+			size_t targ_len;
+
+			targ_n_off = btf_is_enum(targ_t) ? btf_enum(targ_t)[j].name_off :
+							   btf_enum64(targ_t)[j].name_off;
+			targ_n = btf__str_by_offset(targ_btf, targ_n_off);
+
+			if (str_is_empty(targ_n))
+				continue;
+
+			targ_len = bpf_core_essential_name_len(targ_n);
+
+			if (local_len == targ_len && strncmp(local_n, targ_n, local_len) == 0) {
+				matched = true;
+				break;
+			}
+		}
+
+		if (!matched)
+			return 0;
+	}
+	return 1;
+}
+
+static int bpf_core_composites_match(const struct btf *local_btf, const struct btf_type *local_t,
+				     const struct btf *targ_btf, const struct btf_type *targ_t)
+{
+	const struct btf_member *local_m = btf_members(local_t);
+	__u16 local_vlen = btf_vlen(local_t);
+	__u16 targ_vlen = btf_vlen(targ_t);
+	int i, j, err;
+
+	if (local_vlen > targ_vlen)
+		return 0;
+
+	/* check that all local members have a match in the target */
+	for (i = 0; i < local_vlen; i++, local_m++) {
+		const char *local_n = btf__str_by_offset(local_btf, local_m->name_off);
+		const struct btf_member *targ_m = btf_members(targ_t);
+		bool matched = false;
+
+		for (j = 0; j < targ_vlen; j++, targ_m++) {
+			const char *targ_n = btf__str_by_offset(targ_btf, targ_m->name_off);
+
+			if (str_is_empty(targ_n))
+				continue;
+
+			if (strcmp(local_n, targ_n) != 0)
+				continue;
+
+			err = bpf_core_types_match(local_btf, local_m->type, targ_btf,
+						   targ_m->type);
+			if (err > 0) {
+				matched = true;
+				break;
+			}
+		}
+
+		if (!matched)
+			return 0;
+	}
+	return 1;
+}
+
+/* Check that two types "match".
+ *
+ * The matching relation is defined as follows:
+ * - modifiers and typedefs are stripped (and, hence, effectively ignored)
+ * - generally speaking types need to be of same kind (struct vs. struct, union
+ *   vs. union, etc.)
+ *   - exceptions are struct/union behind a pointer which could also match a
+ *     forward declaration of a struct or union, respectively, and enum vs.
+ *     enum64 (see below)
+ * Then, depending on type:
+ * - integers:
+ *   - match if size and signedness match
+ * - arrays & pointers:
+ *   - target types are recursively matched
+ * - structs & unions:
+ *   - local members need to exist in target with the same name
+ *   - for each member we recursively check match unless it is already behind a
+ *     pointer, in which case we only check matching names and compatible kind
+ * - enums:
+ *   - local variants have to have a match in target by symbolic name (but not
+ *     numeric value)
+ *   - size has to match (but enum may match enum64 and vice versa)
+ * - function pointers:
+ *   - number and position of arguments in local type has to match target
+ *   - for each argument and the return value we recursively check match
+ */
+int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
+			 const struct btf *targ_btf, __u32 targ_id)
+{
+	const struct btf_type *local_t, *targ_t, *prev_local_t;
+	int depth = 32; /* max recursion depth */
+	__u16 local_k;
+
+	local_t = btf__type_by_id(local_btf, local_id);
+	targ_t = btf__type_by_id(targ_btf, targ_id);
+
+recur:
+	depth--;
+	if (depth < 0)
+		return -EINVAL;
+
+	prev_local_t = local_t;
+
+	local_t = skip_mods_and_typedefs(local_btf, local_id, &local_id);
+	targ_t = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!local_t || !targ_t)
+		return -EINVAL;
+
+	if (!bpf_core_names_match(local_btf, local_id, targ_btf, targ_id))
+		return 0;
+
+	local_k = btf_kind(local_t);
+
+	switch (local_k) {
+	case BTF_KIND_UNKN:
+		return local_k == btf_kind(targ_t);
+	case BTF_KIND_FWD: {
+		bool local_f = btf_kflag(local_t);
+		__u16 targ_k = btf_kind(targ_t);
+
+		if (btf_is_ptr(prev_local_t)) {
+			if (local_k == targ_k)
+				return local_f == btf_kflag(local_t);
+
+			return (targ_k == BTF_KIND_STRUCT && !local_f) ||
+			       (targ_k == BTF_KIND_UNION && local_f);
+		} else {
+			if (local_k != targ_k)
+				return 0;
+
+			/* match if the forward declaration is for the same kind */
+			return local_f == btf_kflag(local_t);
+		}
+	}
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		if (!btf_is_any_enum(targ_t))
+			return 0;
+
+		return bpf_core_enums_match(local_btf, local_t, targ_btf, targ_t);
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		__u16 targ_k = btf_kind(targ_t);
+
+		if (btf_is_ptr(prev_local_t)) {
+			bool targ_f = btf_kflag(local_t);
+
+			if (local_k == targ_k)
+				return 1;
+
+			if (targ_k != BTF_KIND_FWD)
+				return 0;
+
+			return (local_k == BTF_KIND_UNION) == targ_f;
+		} else {
+			if (local_k != targ_k)
+				return 0;
+
+			return bpf_core_composites_match(local_btf, local_t, targ_btf, targ_t);
+		}
+	}
+	case BTF_KIND_INT: {
+		__u8 local_sgn;
+		__u8 targ_sgn;
+
+		if (local_k != btf_kind(targ_t))
+			return 0;
+
+		local_sgn = btf_int_encoding(local_t) & BTF_INT_SIGNED;
+		targ_sgn = btf_int_encoding(targ_t) & BTF_INT_SIGNED;
+
+		return btf_int_bits(local_t) == btf_int_bits(targ_t) && local_sgn == targ_sgn;
+	}
+	case BTF_KIND_PTR:
+		if (local_k != btf_kind(targ_t))
+			return 0;
+
+		local_id = local_t->type;
+		targ_id = targ_t->type;
+		goto recur;
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *local_array = btf_array(local_t);
+		const struct btf_array *targ_array = btf_array(targ_t);
+
+		if (local_k != btf_kind(targ_t))
+			return 0;
+
+		if (local_array->nelems != targ_array->nelems)
+			return 0;
+
+		local_id = local_array->type;
+		targ_id = targ_array->type;
+		goto recur;
+	}
+	case BTF_KIND_FUNC_PROTO: {
+		struct btf_param *local_p = btf_params(local_t);
+		struct btf_param *targ_p = btf_params(targ_t);
+		__u16 local_vlen = btf_vlen(local_t);
+		__u16 targ_vlen = btf_vlen(targ_t);
+		int i, err;
+
+		if (local_k != btf_kind(targ_t))
+			return 0;
+
+		if (local_vlen != targ_vlen)
+			return 0;
+
+		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
+			err = bpf_core_types_match(local_btf, local_p->type, targ_btf,
+						   targ_p->type);
+			if (err <= 0)
+				return err;
+		}
+
+		/* tail recurse for return type check */
+		local_id = local_t->type;
+		targ_id = targ_t->type;
+		goto recur;
+	}
+	default:
+		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
+			btf_kind_str(local_t), local_id, targ_id);
+		return 0;
+	}
+}
+
 static size_t bpf_core_hash_fn(const void *key, void *ctx)
 {
 	return (size_t)key;
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 6ad3c3..bb9b67a 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -95,6 +95,7 @@ static const char *core_relo_kind_str(enum bpf_core_relo_kind kind)
 	case BPF_CORE_TYPE_ID_LOCAL: return "local_type_id";
 	case BPF_CORE_TYPE_ID_TARGET: return "target_type_id";
 	case BPF_CORE_TYPE_EXISTS: return "type_exists";
+	case BPF_CORE_TYPE_MATCHES: return "type_matches";
 	case BPF_CORE_TYPE_SIZE: return "type_size";
 	case BPF_CORE_ENUMVAL_EXISTS: return "enumval_exists";
 	case BPF_CORE_ENUMVAL_VALUE: return "enumval_value";
@@ -123,6 +124,7 @@ static bool core_relo_is_type_based(enum bpf_core_relo_kind kind)
 	case BPF_CORE_TYPE_ID_LOCAL:
 	case BPF_CORE_TYPE_ID_TARGET:
 	case BPF_CORE_TYPE_EXISTS:
+	case BPF_CORE_TYPE_MATCHES:
 	case BPF_CORE_TYPE_SIZE:
 		return true;
 	default:
@@ -171,7 +173,7 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
  *   - field 'a' access (corresponds to '2' in low-level spec);
  *   - array element #3 access (corresponds to '3' in low-level spec).
  *
- * Type-based relocations (TYPE_EXISTS/TYPE_SIZE,
+ * Type-based relocations (TYPE_EXISTS/TYPE_MATCHES/TYPE_SIZE,
  * TYPE_ID_LOCAL/TYPE_ID_TARGET) don't capture any field information. Their
  * spec and raw_spec are kept empty.
  *
@@ -488,9 +490,14 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 	targ_spec->relo_kind = local_spec->relo_kind;
 
 	if (core_relo_is_type_based(local_spec->relo_kind)) {
-		return bpf_core_types_are_compat(local_spec->btf,
-						 local_spec->root_type_id,
-						 targ_btf, targ_id);
+		if (local_spec->relo_kind == BPF_CORE_TYPE_MATCHES)
+			return bpf_core_types_match(local_spec->btf,
+						    local_spec->root_type_id,
+						    targ_btf, targ_id);
+		else
+			return bpf_core_types_are_compat(local_spec->btf,
+							 local_spec->root_type_id,
+							 targ_btf, targ_id);
 	}
 
 	local_acc = &local_spec->spec[0];
@@ -739,6 +746,7 @@ static int bpf_core_calc_type_relo(const struct bpf_core_relo *relo,
 			*validate = false;
 		break;
 	case BPF_CORE_TYPE_EXISTS:
+	case BPF_CORE_TYPE_MATCHES:
 		*val = 1;
 		break;
 	case BPF_CORE_TYPE_SIZE:
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 7df0da0..6b6afa 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -70,6 +70,8 @@ struct bpf_core_relo_res {
 
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
+int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
+			 const struct btf *targ_btf, __u32 targ_id);
 
 size_t bpf_core_essential_name_len(const char *name);
 
-- 
2.30.2

