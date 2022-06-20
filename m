Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E324855283B
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbiFTXXN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347563AbiFTXXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:23:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5F2BB2A
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:18:07 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 23673240027
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655767086; bh=8Xgm0JYtPy2iGYTc7vM3tB+KvIQuGWFPNKtreZQ37uU=;
        h=From:To:Subject:Date:From;
        b=dn6GH8n5OPeTcV0Yav2DEkmf218eQeXNHijEYEu0nbLbykLsS7AOQx4y8kGT8nB/J
         yAAQLU8iUhsmPrlPXEM3FgcQWZHOGG14Q7e8KXKHPDKL0eCdvpkW25+RSF9TkpfjHC
         8/FrQrH5qImA9l2eOfHFWlVtV/yYBju07zlZyx5pHPrWWwkQ4OCx1OipGvbeGh7Fbf
         g8K2fiJmHjytYzTvJf+IlnlHbsDjibuhoSzwCCaRB6kq2WCUzMh43hIRt46mAu7cPE
         5R7P06cqk3BCR+ZU+SLmWM97m0RgGhzBWT5zQBZbMcmN6Q2bN9SklY5ip8+Jjr1qCz
         tR/1BlS14EwjA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LRltj2nC3z6tmX;
        Tue, 21 Jun 2022 01:18:05 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next 3/7] bpf: Add type match support
Date:   Mon, 20 Jun 2022 23:17:09 +0000
Message-Id: <20220620231713.2143355-4-deso@posteo.net>
In-Reply-To: <20220620231713.2143355-1-deso@posteo.net>
References: <20220620231713.2143355-1-deso@posteo.net>
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

This change implements the kernel side of the "type matches" support.
Please refer to the next change ("libbpf: Add type match support") for
more details on the relation. This one is first in the stack because
the follow-on libbpf changes depend on it.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 include/linux/btf.h |   5 +
 kernel/bpf/btf.c    | 267 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 272 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7..7376934 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -242,6 +242,11 @@ static inline u8 btf_int_offset(const struct btf_type *t)
 	return BTF_INT_OFFSET(*(u32 *)(t + 1));
 }
 
+static inline u8 btf_int_bits(const struct btf_type *t)
+{
+	return BTF_INT_BITS(*(__u32 *)(t + 1));
+}
+
 static inline u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(u32 *)(t + 1));
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f08037..3790b4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7524,6 +7524,273 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 					   MAX_TYPES_ARE_COMPAT_DEPTH);
 }
 
+#define MAX_TYPES_MATCH_DEPTH 2
+
+static bool bpf_core_names_match(const struct btf *local_btf, u32 local_id,
+				 const struct btf *targ_btf, u32 targ_id)
+{
+	const struct btf_type *local_t, *targ_t;
+	const char *local_n, *targ_n;
+	size_t local_len, targ_len;
+
+	local_t = btf_type_by_id(local_btf, local_id);
+	targ_t = btf_type_by_id(targ_btf, targ_id);
+	local_n = btf_str_by_offset(local_btf, local_t->name_off);
+	targ_n = btf_str_by_offset(targ_btf, targ_t->name_off);
+	local_len = bpf_core_essential_name_len(local_n);
+	targ_len = bpf_core_essential_name_len(targ_n);
+
+	return local_len == targ_len && strncmp(local_n, targ_n, local_len) == 0;
+}
+
+static int bpf_core_enums_match(const struct btf *local_btf, const struct btf_type *local_t,
+				const struct btf *targ_btf, const struct btf_type *targ_t)
+{
+	u16 local_vlen = btf_vlen(local_t);
+	u16 targ_vlen = btf_vlen(targ_t);
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
+		local_n_off = btf_is_enum(local_t) ? btf_type_enum(local_t)[i].name_off :
+						     btf_type_enum64(local_t)[i].name_off;
+
+		local_n = btf_name_by_offset(local_btf, local_n_off);
+		local_len = bpf_core_essential_name_len(local_n);
+
+		for (j = 0; j < targ_vlen; j++) {
+			const char *targ_n;
+			__u32 targ_n_off;
+			size_t targ_len;
+
+			targ_n_off = btf_is_enum(targ_t) ? btf_type_enum(targ_t)[j].name_off :
+							   btf_type_enum64(targ_t)[j].name_off;
+			targ_n = btf_name_by_offset(targ_btf, targ_n_off);
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
+static int __bpf_core_types_match(const struct btf *local_btf, u32 local_id,
+				  const struct btf *targ_btf, u32 targ_id, int level);
+
+static int bpf_core_composites_match(const struct btf *local_btf, const struct btf_type *local_t,
+				     const struct btf *targ_btf, const struct btf_type *targ_t,
+				     int level)
+{
+	/* check that all local members have a match in the target */
+	const struct btf_member *local_m = btf_members(local_t);
+	u16 local_vlen = btf_vlen(local_t);
+	u16 targ_vlen = btf_vlen(targ_t);
+	int i, j, err;
+
+	if (local_vlen > targ_vlen)
+		return 0;
+
+	for (i = 0; i < local_vlen; i++, local_m++) {
+		const char *local_n = btf_name_by_offset(local_btf, local_m->name_off);
+		const struct btf_member *targ_m = btf_members(targ_t);
+		bool matched = false;
+
+		for (j = 0; j < targ_vlen; j++, targ_m++) {
+			const char *targ_n = btf_name_by_offset(targ_btf, targ_m->name_off);
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
+static int __bpf_core_types_match(const struct btf *local_btf, u32 local_id,
+				  const struct btf *targ_btf, u32 targ_id, int level)
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
+	local_t = btf_type_skip_modifiers(local_btf, local_id, &local_id);
+	targ_t = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
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
+		bool local_f = btf_type_kflag(local_t);
+		__u16 targ_k = btf_kind(targ_t);
+
+		if (btf_is_ptr(prev_local_t)) {
+			if (local_k == targ_k)
+				return local_f == btf_type_kflag(local_t);
+
+			return (targ_k == BTF_KIND_STRUCT && !local_f) ||
+			       (targ_k == BTF_KIND_UNION && local_f);
+		} else {
+			if (local_k != targ_k)
+				return 0;
+
+			/* match if the forward declaration is for the same kind */
+			return local_f == btf_type_kflag(local_t);
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
+			bool targ_f = btf_type_kflag(local_t);
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
+		const struct btf_array *local_array = btf_type_array(local_t);
+		const struct btf_array *targ_array = btf_type_array(targ_t);
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
+		u16 local_vlen = btf_vlen(local_t);
+		u16 targ_vlen = btf_vlen(targ_t);
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
+		return 0;
+	}
+}
+
+int bpf_core_types_match(const struct btf *local_btf, u32 local_id,
+			 const struct btf *targ_btf, u32 targ_id)
+{
+	return __bpf_core_types_match(local_btf, local_id,
+				      targ_btf, targ_id,
+				      MAX_TYPES_MATCH_DEPTH);
+}
+
 static bool bpf_core_is_flavor_sep(const char *s)
 {
 	/* check X___Y name pattern, where X and Y are not underscores */
-- 
2.30.2

