Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF81A55527C
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 19:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiFVRfU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFVRfT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 13:35:19 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974431DDD
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:35:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CE810240027
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655919316; bh=Fet6ovzBUh+b3fMdS2OSjxPeOKwsGtvEPoU+B6fz2Ks=;
        h=From:To:Subject:Date:From;
        b=XhEdIcLnB1fb3EcR7KQM4jtQSjF4D4syDo/qdWld6iNC7bIsYPffpK520GJK/SbDB
         7gCx+NwLleNZvV2ag4cA8LEdo2Rgu672tqW2ItI7OG/DIe3BYONTMqQAnnXcegNvH4
         J8qe2PPbQhGnhgI7XTS4p+/BxRND/iHfLEK8WhWdgcF2sV4wL41cEuo1OIaX6Md3HE
         u8xPH+baxcEl7WHQ57Wmeqe7IHQ6lLhPSsBqJsfRTx1LTY6fNHCpMhggYPvPmHP3FB
         4/uYImjjdjkoyPB8pRbn6loRqEsNYMTVs0jBNFenQHMsB3u3TbRyqACLsqf9wkQFWx
         48PRstLLQ1liQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSrBC6qS9z6tmb;
        Wed, 22 Jun 2022 19:35:15 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] libbpf: Move core "types_are_compat" logic into relo_core.c
Date:   Wed, 22 Jun 2022 17:35:05 +0000
Message-Id: <20220622173506.860578-2-deso@posteo.net>
In-Reply-To: <20220622173506.860578-1-deso@posteo.net>
References: <20220622173506.860578-1-deso@posteo.net>
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

This change merges the two existing implementations of the
bpf_core_types_are_compat() function into relo_core.c, inheriting the
recursion tracking from the kernel and the usage of
btf_kind_core_compat() from libbpf. The kernel is left untouched and
will be adjusted subsequently.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c    | 72 +-----------------------------------
 tools/lib/bpf/relo_core.c | 78 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.h |  2 +
 3 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49e359c..ca912c 100644
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
+	return bpf_core_types_are_compat_recur(local_btf, local_id, targ_btf, targ_id, INT_MAX);
 }
 
 static size_t bpf_core_hash_fn(const void *key, void *ctx)
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 6ad3c3..e54370 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -141,6 +141,84 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
 	}
 }
 
+int bpf_core_types_are_compat_recur(const struct btf *local_btf, __u32 local_id,
+				    const struct btf *targ_btf, __u32 targ_id, int level)
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
+			err = bpf_core_types_are_compat_recur(local_btf, local_id, targ_btf,
+							      targ_id, level - 1);
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
+		return 0;
+	}
+}
+
 /*
  * Turn bpf_core_relo into a low- and high-level spec representation,
  * validating correctness along the way, as well as calculating resulting
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 7df0da0..b8998f 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -68,6 +68,8 @@ struct bpf_core_relo_res {
 	__u32 new_type_id;
 };
 
+int bpf_core_types_are_compat_recur(const struct btf *local_btf, __u32 local_id,
+				    const struct btf *targ_btf, __u32 targ_id, int level);
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
 
-- 
2.30.2

