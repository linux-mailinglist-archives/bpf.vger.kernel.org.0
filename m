Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219BF558AA5
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiFWVWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiFWVWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:39 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D352515BE
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:38 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CCF35240027
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019356; bh=O7N/d4cUnWI52awx/Z8cQIgyVZSFdozdz5E9PFuk0pg=;
        h=From:To:Cc:Subject:Date:From;
        b=k/gCENKXcP8QG+cNnjaFfRk/EO/v0m6wZuCH1xNFAGQxMRZGuB7G9iNTZYk/f4TNN
         geSQfXRukP1K4+KkgTpNDo/eSJqDEGSagd4FjXg8WtVpuyXcmoul1KpmVIUcj4RSXx
         khZ+wLa9nTY6jULLYNqwEBq4QjCAp1CLgREKg/pBi3WD4xP95L5ko6dfbW9Rf2m6H1
         /tu3h3IIwRFRbNjhVpGkbAgENXkMI2nDsjNsVZZ7UB0ga0c6mEV0sPkk+dcwBrZwrb
         GN3lmXBHw96jJKZCQGvE47g3T/ZGsX0+/kNxh8M300Lyyv5CYS1CEeY8jzhhGqsHac
         HeVU3kMin/HiA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTYB40Jplz6tmq;
        Thu, 23 Jun 2022 23:22:36 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 4/9] libbpf: Add type match support
Date:   Thu, 23 Jun 2022 21:22:00 +0000
Message-Id: <20220623212205.2805002-5-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-1-deso@posteo.net>
References: <20220623212205.2805002-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support for the proposed type match relation to
relo_core where it is shared between userspace and kernel. A bit more
plumbing is necessary and will arrive with subsequent changes to
actually use it -- this patch only introduces the main matching
algorithm.

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
 tools/lib/bpf/relo_core.c | 276 ++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.h |   2 +
 2 files changed, 278 insertions(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 6ad3c3..bc5b060 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1330,3 +1330,279 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 
 	return 0;
 }
+
+static bool bpf_core_names_match(const struct btf *local_btf, const struct btf_type *local_t,
+				 const struct btf *targ_btf, const struct btf_type *targ_t)
+{
+	const char *local_n, *targ_n;
+
+	local_n = btf__name_by_offset(local_btf, local_t->name_off);
+	targ_n = btf__name_by_offset(targ_btf, targ_t->name_off);
+
+	return !strncmp(local_n, targ_n, bpf_core_essential_name_len(local_n));
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
+		local_n = btf__name_by_offset(local_btf, local_n_off);
+		local_len = bpf_core_essential_name_len(local_n);
+
+		for (j = 0; j < targ_vlen; j++) {
+			const char *targ_n;
+			__u32 targ_n_off;
+
+			targ_n_off = btf_is_enum(targ_t) ? btf_enum(targ_t)[j].name_off :
+							   btf_enum64(targ_t)[j].name_off;
+			targ_n = btf__name_by_offset(targ_btf, targ_n_off);
+
+			if (str_is_empty(targ_n))
+				continue;
+
+			if (!strncmp(local_n, targ_n, local_len)) {
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
+				     const struct btf *targ_btf, const struct btf_type *targ_t,
+				     int level)
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
+		const char *local_n = btf__name_by_offset(local_btf, local_m->name_off);
+		const struct btf_member *targ_m = btf_members(targ_t);
+		bool matched = false;
+
+		for (j = 0; j < targ_vlen; j++, targ_m++) {
+			const char *targ_n = btf__name_by_offset(targ_btf, targ_m->name_off);
+
+			if (str_is_empty(targ_n))
+				continue;
+
+			if (strcmp(local_n, targ_n) != 0)
+				continue;
+
+			err = __bpf_core_types_match(local_btf, local_m->type, targ_btf,
+						     targ_m->type, level - 1);
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
+int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const struct btf *targ_btf,
+			   __u32 targ_id, int level)
+{
+	const struct btf_type *local_t, *targ_t, *prev_local_t;
+	int depth = 32; /* max recursion depth */
+	__u16 local_k;
+
+	if (level <= 0)
+		return -EINVAL;
+
+	local_t = btf_type_by_id(local_btf, local_id);
+	targ_t = btf_type_by_id(targ_btf, targ_id);
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
+	if (!bpf_core_names_match(local_btf, local_t, targ_btf, targ_t))
+		return 0;
+
+	local_k = btf_kind(local_t);
+
+	switch (local_k) {
+	case BTF_KIND_UNKN:
+		return local_k == btf_kind(targ_t);
+	case BTF_KIND_FWD: {
+		bool local_f = BTF_INFO_KFLAG(local_t->info);
+		__u16 targ_k = btf_kind(targ_t);
+
+		if (btf_is_ptr(prev_local_t)) {
+			if (local_k == targ_k)
+				return local_f == BTF_INFO_KFLAG(targ_t->info);
+
+			/* for forward declarations kflag dictates whether the
+			 * target is a struct (0) or union (1)
+			 */
+			return (targ_k == BTF_KIND_STRUCT && !local_f) ||
+			       (targ_k == BTF_KIND_UNION && local_f);
+		} else {
+			if (local_k != targ_k)
+				return 0;
+
+			/* match if the forward declaration is for the same kind */
+			return local_f == BTF_INFO_KFLAG(targ_t->info);
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
+			bool targ_f = BTF_INFO_KFLAG(targ_t->info);
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
+			return bpf_core_composites_match(local_btf, local_t, targ_btf, targ_t,
+							 level);
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
+			err = __bpf_core_types_match(local_btf, local_p->type, targ_btf,
+						     targ_p->type, level - 1);
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
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 7df0da0..289c63 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -70,6 +70,8 @@ struct bpf_core_relo_res {
 
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
+int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const struct btf *targ_btf,
+			   __u32 targ_id, int level);
 
 size_t bpf_core_essential_name_len(const char *name);
 
-- 
2.30.2

