Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D26155E8CF
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348311AbiF1QCw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbiF1QCc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:32 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814E37A20
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:01:56 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A267D240113
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432114; bh=S9CYs8b1NvCzaeAdVHbsj4/zoWAt9cf/xdKBx585V3A=;
        h=From:To:Cc:Subject:Date:From;
        b=gO7x24XBFA4zSq02Oi+hgvSonk9QG+rWcUtOzzSC+POUQEyNa5Z067pQlnx8VAJra
         DAig/5trhrcvtqAR6o2DRK2B6xgnG8PTtHGxNqOxg2GMz1YZ8l2KJSGrI1b5vF8o9A
         BvPxvo3nu/mT8TmQvCwHR0V+9JIy18gk4BggEWadSZMsPXO4Hrp+W7vhP07LIOS+qb
         XFEurZcXxmmApsZRmpp2HGa9M559DAC2UFWIUDRgqLvn1d79hzE+I9sTkLZzDlO972
         sBYnh2VtKkDXogeMCRM0IlUpPHD1w9nMuyeikskZhNgL9h3SfboYI5tACWGaMQdBh7
         6JLufUw4t7R+g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTqj35LGz6tmS;
        Tue, 28 Jun 2022 18:01:53 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 04/10] libbpf: Add type match support
Date:   Tue, 28 Jun 2022 16:01:21 +0000
Message-Id: <20220628160127.607834-5-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
References: <20220628160127.607834-1-deso@posteo.net>
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
 tools/lib/bpf/relo_core.c | 268 ++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.h |   2 +
 2 files changed, 270 insertions(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index e070123..b3f5d7e 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1410,3 +1410,271 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 
 	return 0;
 }
+
+static bool bpf_core_names_match(const struct btf *local_btf, size_t local_name_off,
+				 const struct btf *targ_btf, size_t targ_name_off)
+{
+	const char *local_n, *targ_n;
+	size_t local_len, targ_len;
+
+	local_n = btf__name_by_offset(local_btf, local_name_off);
+	targ_n = btf__name_by_offset(targ_btf, targ_name_off);
+
+	if (str_is_empty(targ_n))
+		return str_is_empty(local_n);
+
+	targ_len = bpf_core_essential_name_len(targ_n);
+	local_len = bpf_core_essential_name_len(local_n);
+
+	return targ_len == local_len && strncmp(local_n, targ_n, local_len) == 0;
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
+		__u32 local_n_off;
+
+		local_n_off = btf_is_enum(local_t) ? btf_enum(local_t)[i].name_off :
+						     btf_enum64(local_t)[i].name_off;
+
+		for (j = 0; j < targ_vlen; j++) {
+			__u32 targ_n_off;
+
+			targ_n_off = btf_is_enum(targ_t) ? btf_enum(targ_t)[j].name_off :
+							   btf_enum64(targ_t)[j].name_off;
+
+			if (bpf_core_names_match(local_btf, local_n_off, targ_btf, targ_n_off)) {
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
+				     bool behind_ptr, int level)
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
+		const struct btf_member *targ_m = btf_members(targ_t);
+		bool matched = false;
+
+		for (j = 0; j < targ_vlen; j++, targ_m++) {
+			if (!bpf_core_names_match(local_btf, local_m->name_off, targ_btf,
+						  targ_m->name_off))
+				continue;
+
+			err = __bpf_core_types_match(local_btf, local_m->type, targ_btf,
+						     targ_m->type, behind_ptr, level - 1);
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
+			   __u32 targ_id, bool behind_ptr, int level)
+{
+	const struct btf_type *local_t, *targ_t;
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
+	local_t = skip_mods_and_typedefs(local_btf, local_id, &local_id);
+	targ_t = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!local_t || !targ_t)
+		return -EINVAL;
+
+	if (!bpf_core_names_match(local_btf, local_t->name_off, targ_btf, targ_t->name_off))
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
+		if (behind_ptr) {
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
+		if (behind_ptr) {
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
+							 behind_ptr, level);
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
+		behind_ptr = true;
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
+						     targ_p->type, behind_ptr, level - 1);
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
index 3fd384..8462e0a 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -72,6 +72,8 @@ int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 				const struct btf *targ_btf, __u32 targ_id, int level);
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
+int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const struct btf *targ_btf,
+			   __u32 targ_id, bool behind_ptr, int level);
 
 size_t bpf_core_essential_name_len(const char *name);
 
-- 
2.30.2

