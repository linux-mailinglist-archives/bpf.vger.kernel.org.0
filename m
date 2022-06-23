Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9F55889D
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiFWTXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiFWTWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 15:22:51 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB007705F
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 11:29:47 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id DE2B724010C
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 20:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656008984; bh=4FjHMfarM6qXU4d68jTT5/I4KH0Hyb19qryKtzqkNFY=;
        h=From:To:Subject:Date:From;
        b=CUL+lHwmN5CGv+BNB8HY9WPywtML7SlVll+cEjvPcbTwDTjLAvLQKIxHzumrT1d/i
         LPU2tlP17NJE6owsz5chBR+TgQq9QkWgzKQCqjs62lfyZoPVDbJpuytXRlJHVu05h7
         vVho9KO+GvEHm3FYfLbEn3CLH09A5GUPmcDf3WJETRggPp+hWmzWnb2I++/Z1YX8Zc
         EAPj/dh73OVuArUbedqiQ1oJ+h8VqpJ3RzAPpGD4QAHfJ60eCF7596Gk0UM5V4elSp
         2aK5jtyJb+UQh9q3tqU90gX5dUss8LOVV9CgjFolUPSJ7rINX6bTaXpI0wEgxpeItR
         BlL8WoqAxk3kg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTTLY65gqz6tmy;
        Thu, 23 Jun 2022 20:29:41 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next v2] bpf: Merge "types_are_compat" logic into relo_core.c
Date:   Thu, 23 Jun 2022 18:29:34 +0000
Message-Id: <20220623182934.2582827-1-deso@posteo.net>
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

BPF type compatibility checks (bpf_core_types_are_compat()) are
currently duplicated between kernel and user space. That's a historical
artifact more than intentional doing and can lead to subtle bugs where
one implementation is adjusted but another is forgotten.

That happened with the enum64 work, for example, where the libbpf side
was changed (commit 23b2a3a8f63a ("libbpf: Add enum64 relocation
support")) to use the btf_kind_core_compat() helper function but the
kernel side was not (commit 6089fb325cf7 ("bpf: Add btf enum64
support")).

This patch addresses both the duplication issue, by merging both
implementations and moving them into relo_core.c, and fixes the alluded
to kind check (by giving preference to libbpf's already adjusted logic).

For discussion of the topic, please refer to:
https://lore.kernel.org/bpf/CAADnVQKbWR7oarBdewgOBZUPzryhRYvEbkhyPJQHHuxq=0K1gw@mail.gmail.com/T/#mcc99f4a33ad9a322afaf1b9276fb1f0b7add9665

Changelog:
v1 -> v2:
- limited libbpf recursion limit to 32
- changed name to __bpf_core_types_are_compat
- included warning previously present in libbpf version
- merged kernel and user space changes into a single patch

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 kernel/bpf/btf.c          | 84 +--------------------------------------
 tools/lib/bpf/libbpf.c    | 72 +--------------------------------
 tools/lib/bpf/relo_core.c | 80 +++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.h |  2 +
 4 files changed, 84 insertions(+), 154 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f08037..2e2066 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7416,87 +7416,6 @@ EXPORT_SYMBOL_GPL(register_btf_id_dtor_kfuncs);
 
 #define MAX_TYPES_ARE_COMPAT_DEPTH 2
 
-static
-int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
-				const struct btf *targ_btf, __u32 targ_id,
-				int level)
-{
-	const struct btf_type *local_type, *targ_type;
-	int depth = 32; /* max recursion depth */
-
-	/* caller made sure that names match (ignoring flavor suffix) */
-	local_type = btf_type_by_id(local_btf, local_id);
-	targ_type = btf_type_by_id(targ_btf, targ_id);
-	if (btf_kind(local_type) != btf_kind(targ_type))
-		return 0;
-
-recur:
-	depth--;
-	if (depth < 0)
-		return -EINVAL;
-
-	local_type = btf_type_skip_modifiers(local_btf, local_id, &local_id);
-	targ_type = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
-	if (!local_type || !targ_type)
-		return -EINVAL;
-
-	if (btf_kind(local_type) != btf_kind(targ_type))
-		return 0;
-
-	switch (btf_kind(local_type)) {
-	case BTF_KIND_UNKN:
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION:
-	case BTF_KIND_ENUM:
-	case BTF_KIND_FWD:
-	case BTF_KIND_ENUM64:
-		return 1;
-	case BTF_KIND_INT:
-		/* just reject deprecated bitfield-like integers; all other
-		 * integers are by default compatible between each other
-		 */
-		return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
-	case BTF_KIND_PTR:
-		local_id = local_type->type;
-		targ_id = targ_type->type;
-		goto recur;
-	case BTF_KIND_ARRAY:
-		local_id = btf_array(local_type)->type;
-		targ_id = btf_array(targ_type)->type;
-		goto recur;
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *local_p = btf_params(local_type);
-		struct btf_param *targ_p = btf_params(targ_type);
-		__u16 local_vlen = btf_vlen(local_type);
-		__u16 targ_vlen = btf_vlen(targ_type);
-		int i, err;
-
-		if (local_vlen != targ_vlen)
-			return 0;
-
-		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
-			if (level <= 0)
-				return -EINVAL;
-
-			btf_type_skip_modifiers(local_btf, local_p->type, &local_id);
-			btf_type_skip_modifiers(targ_btf, targ_p->type, &targ_id);
-			err = __bpf_core_types_are_compat(local_btf, local_id,
-							  targ_btf, targ_id,
-							  level - 1);
-			if (err <= 0)
-				return err;
-		}
-
-		/* tail recurse for return type check */
-		btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
-		btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
-		goto recur;
-	}
-	default:
-		return 0;
-	}
-}
-
 /* Check local and target types for compatibility. This check is used for
  * type-based CO-RE relocations and follow slightly different rules than
  * field-based relocations. This function assumes that root types were already
@@ -7519,8 +7438,7 @@ int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id)
 {
-	return __bpf_core_types_are_compat(local_btf, local_id,
-					   targ_btf, targ_id,
+	return __bpf_core_types_are_compat(local_btf, local_id, targ_btf, targ_id,
 					   MAX_TYPES_ARE_COMPAT_DEPTH);
 }
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49e359c..335467 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5732,77 +5732,7 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id)
 {
-	const struct btf_type *local_type, *targ_type;
-	int depth = 32; /* max recursion depth */
-
-	/* caller made sure that names match (ignoring flavor suffix) */
-	local_type = btf__type_by_id(local_btf, local_id);
-	targ_type = btf__type_by_id(targ_btf, targ_id);
-	if (!btf_kind_core_compat(local_type, targ_type))
-		return 0;
-
-recur:
-	depth--;
-	if (depth < 0)
-		return -EINVAL;
-
-	local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
-	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
-	if (!local_type || !targ_type)
-		return -EINVAL;
-
-	if (!btf_kind_core_compat(local_type, targ_type))
-		return 0;
-
-	switch (btf_kind(local_type)) {
-	case BTF_KIND_UNKN:
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION:
-	case BTF_KIND_ENUM:
-	case BTF_KIND_ENUM64:
-	case BTF_KIND_FWD:
-		return 1;
-	case BTF_KIND_INT:
-		/* just reject deprecated bitfield-like integers; all other
-		 * integers are by default compatible between each other
-		 */
-		return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
-	case BTF_KIND_PTR:
-		local_id = local_type->type;
-		targ_id = targ_type->type;
-		goto recur;
-	case BTF_KIND_ARRAY:
-		local_id = btf_array(local_type)->type;
-		targ_id = btf_array(targ_type)->type;
-		goto recur;
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *local_p = btf_params(local_type);
-		struct btf_param *targ_p = btf_params(targ_type);
-		__u16 local_vlen = btf_vlen(local_type);
-		__u16 targ_vlen = btf_vlen(targ_type);
-		int i, err;
-
-		if (local_vlen != targ_vlen)
-			return 0;
-
-		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
-			skip_mods_and_typedefs(local_btf, local_p->type, &local_id);
-			skip_mods_and_typedefs(targ_btf, targ_p->type, &targ_id);
-			err = bpf_core_types_are_compat(local_btf, local_id, targ_btf, targ_id);
-			if (err <= 0)
-				return err;
-		}
-
-		/* tail recurse for return type check */
-		skip_mods_and_typedefs(local_btf, local_type->type, &local_id);
-		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
-		goto recur;
-	}
-	default:
-		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
-			btf_kind_str(local_type), local_id, targ_id);
-		return 0;
-	}
+	return __bpf_core_types_are_compat(local_btf, local_id, targ_btf, targ_id, 32);
 }
 
 static size_t bpf_core_hash_fn(const void *key, void *ctx)
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 6ad3c3..e070123 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -141,6 +141,86 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
 	}
 }
 
+int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
+				const struct btf *targ_btf, __u32 targ_id, int level)
+{
+	const struct btf_type *local_type, *targ_type;
+	int depth = 32; /* max recursion depth */
+
+	/* caller made sure that names match (ignoring flavor suffix) */
+	local_type = btf_type_by_id(local_btf, local_id);
+	targ_type = btf_type_by_id(targ_btf, targ_id);
+	if (!btf_kind_core_compat(local_type, targ_type))
+		return 0;
+
+recur:
+	depth--;
+	if (depth < 0)
+		return -EINVAL;
+
+	local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
+	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!local_type || !targ_type)
+		return -EINVAL;
+
+	if (!btf_kind_core_compat(local_type, targ_type))
+		return 0;
+
+	switch (btf_kind(local_type)) {
+	case BTF_KIND_UNKN:
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_FWD:
+	case BTF_KIND_ENUM64:
+		return 1;
+	case BTF_KIND_INT:
+		/* just reject deprecated bitfield-like integers; all other
+		 * integers are by default compatible between each other
+		 */
+		return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
+	case BTF_KIND_PTR:
+		local_id = local_type->type;
+		targ_id = targ_type->type;
+		goto recur;
+	case BTF_KIND_ARRAY:
+		local_id = btf_array(local_type)->type;
+		targ_id = btf_array(targ_type)->type;
+		goto recur;
+	case BTF_KIND_FUNC_PROTO: {
+		struct btf_param *local_p = btf_params(local_type);
+		struct btf_param *targ_p = btf_params(targ_type);
+		__u16 local_vlen = btf_vlen(local_type);
+		__u16 targ_vlen = btf_vlen(targ_type);
+		int i, err;
+
+		if (local_vlen != targ_vlen)
+			return 0;
+
+		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
+			if (level <= 0)
+				return -EINVAL;
+
+			skip_mods_and_typedefs(local_btf, local_p->type, &local_id);
+			skip_mods_and_typedefs(targ_btf, targ_p->type, &targ_id);
+			err = __bpf_core_types_are_compat(local_btf, local_id, targ_btf, targ_id,
+							  level - 1);
+			if (err <= 0)
+				return err;
+		}
+
+		/* tail recurse for return type check */
+		skip_mods_and_typedefs(local_btf, local_type->type, &local_id);
+		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
+		goto recur;
+	}
+	default:
+		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
+			btf_kind_str(local_type), local_id, targ_id);
+		return 0;
+	}
+}
+
 /*
  * Turn bpf_core_relo into a low- and high-level spec representation,
  * validating correctness along the way, as well as calculating resulting
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 7df0da0..3fd384 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -68,6 +68,8 @@ struct bpf_core_relo_res {
 	__u32 new_type_id;
 };
 
+int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
+				const struct btf *targ_btf, __u32 targ_id, int level);
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
 
-- 
2.30.2

