Return-Path: <bpf+bounces-51984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FFEA3CAF6
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C48F3B353D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839B255E31;
	Wed, 19 Feb 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c9e/z0T9"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10B25335F
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999133; cv=none; b=UvO8/6oKORsBkxMq1PRgBCXH9+CqTB+rgevzMZZMC/sU42nk5g/HmQ5iB3pKy9uTYaolY1rUYoNiStDLcYJcytcNZbKvG5x1ekbkQ75PiBeFZ0FaWlTa2z2kwgS7uLA+6c2Lr1NvnLsQ4mgzewuMbNIeOPWGyPg7AegAm22Px48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999133; c=relaxed/simple;
	bh=qLHgGhwBEwacMuYSNyCqUY96Diq8gRExKcI49kXbwPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WASq+fihVN9X9J85lDL0OkPRKbIbjUBz4DVotRh+QIq/c2wF1lXOSkexqLN7IHRa/0C6ApIY9XeeF24rBbeaPXE9dOP3DPjifob6rS1XjV5Sa1T0JfEa8jmwvBRkNe3p21LbSkJEIgqRN/zF4QtGwO6c5P2rX5UBdggoPuXF9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c9e/z0T9; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkxGYcxN0+BcmdBXN6OKPpltu0VWJVCQetbVHuPgcw8=;
	b=c9e/z0T9ypNScWIfg0RXPgJM2wBDWNmT54Ua1dDdA/tvDW0Wljrq2a4gZpIpuJpL4OGzrq
	6YPdwuEAuNbnC6ukCMK+D8F7GuVa3BWoNLx2ZQTCXf43VkKuLN4J5hBViC+zWYsWnm+S41
	rnnb5BtfN2x/OfBE7pLntl0DheHbwLU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/4] btf_encoder: refactor btf_encoder__tag_kfuncs()
Date: Wed, 19 Feb 2025 13:05:17 -0800
Message-ID: <20250219210520.2245369-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf_encoder__tag_kfuncs() is a post-processing step of BTF encoding,
executed right before BTF is deduped and dumped to the output.

Rewrite btf_encoder__tag_kfuncs() into btf_encoder__collect_kfuncs().
Now it only reads the .BTF_ids section of the ELF, collecting kfunc
information and adding it to corresponding elf_function structs. It is
executed in btf_encoder__new() if tag_kfuncs flag is set. This way
kfunc information is available within entire lifetime of the
btf_encoder.

BTF decl tags for kfuncs are added immediately after the function is
added to BTF in btf_encoder__add_func(). It's done by btf__tag_kfunc()
factored out from the btf_encoder__tag_kfunc().

As a result btf_encoder__collect_btf_funcs(), struct btf_func type and
other relevant code are deleted, as they are no longer necessary.

Link: https://lore.kernel.org/dwarves/3782640a577e6945c86d6330bc8a05018a1e5c52.camel@gmail.com/

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 189 +++++++++++++++-----------------------------------
 1 file changed, 54 insertions(+), 135 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 511c1ea..2bea5ee 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -89,6 +89,8 @@ struct elf_function {
 	const char	*name;
 	char		*alias;
 	size_t		prefixlen;
+	bool		kfunc;
+	uint32_t	kfunc_flags;
 };
 
 struct elf_secinfo {
@@ -145,11 +147,6 @@ struct btf_encoder {
 	struct list_head elf_functions_list;
 };
 
-struct btf_func {
-	const char *name;
-	int	    type_id;
-};
-
 /* Half open interval representing range of addresses containing kfuncs */
 struct btf_kfunc_set_range {
 	uint64_t start;
@@ -1178,6 +1175,39 @@ out:
 	return err;
 }
 
+static int btf__add_kfunc_decl_tag(struct btf *btf, const char *tag, __u32 id, const char *kfunc)
+{
+	int err = btf__add_decl_tag(btf, tag, id, -1);
+
+	if (err < 0) {
+		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
+			__func__, kfunc, err);
+		return err;
+	}
+	return 0;
+}
+
+static int btf__tag_kfunc(struct btf *btf, struct elf_function *kfunc, __u32 btf_fn_id)
+{
+	int err;
+
+	/* Note we are unconditionally adding the btf_decl_tag even
+	 * though vmlinux may already contain btf_decl_tags for kfuncs.
+	 * We are ok to do this b/c we will later btf__dedup() to remove
+	 * any duplicates.
+	 */
+	err = btf__add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, btf_fn_id, kfunc->name);
+	if (err < 0)
+		return err;
+
+	if (kfunc->kfunc_flags & KF_FASTCALL) {
+		err = btf__add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, btf_fn_id, kfunc->name);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 				     struct btf_encoder_func_state *state)
 {
@@ -1188,6 +1218,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	const char *value;
 	char tmp_value[KSYM_NAME_LEN];
 	uint16_t idx;
+	int err;
 
 	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
 	name = func->alias ?: func->name;
@@ -1199,6 +1230,13 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 		       name, btf_fnproto_id < 0 ? "proto" : "func");
 		return -1;
 	}
+
+	if (func->kfunc && encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
+		err = btf__tag_kfunc(encoder->btf, func, btf_fn_id);
+		if (err < 0)
+			return err;
+	}
+
 	if (state->nr_annots == 0)
 		return 0;
 
@@ -1771,116 +1809,10 @@ static char *get_func_name(const char *sym)
 	return func;
 }
 
-static int btf_func_cmp(const void *_a, const void *_b)
-{
-	const struct btf_func *a = _a;
-	const struct btf_func *b = _b;
-
-	return strcmp(a->name, b->name);
-}
-
-/*
- * Collects all functions described in BTF.
- * Returns non-zero on error.
- */
-static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
-{
-	struct btf *btf = encoder->btf;
-	int nr_types, type_id;
-	int err = -1;
-
-	/* First collect all the func entries into an array */
-	nr_types = btf__type_cnt(btf);
-	for (type_id = 1; type_id < nr_types; type_id++) {
-		const struct btf_type *type;
-		struct btf_func func = {};
-		const char *name;
-
-		type = btf__type_by_id(btf, type_id);
-		if (!type) {
-			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
-				__func__, type_id);
-			err = -EINVAL;
-			goto out;
-		}
-
-		if (!btf_is_func(type))
-			continue;
-
-		name = btf__name_by_offset(btf, type->name_off);
-		if (!name) {
-			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
-				__func__, type_id);
-			err = -EINVAL;
-			goto out;
-		}
-
-		func.name = name;
-		func.type_id = type_id;
-		err = gobuffer__add(funcs, &func, sizeof(func));
-		if (err < 0)
-			goto out;
-	}
-
-	/* Now that we've collected funcs, sort them by name */
-	gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
-
-	err = 0;
-out:
-	return err;
-}
-
-static int btf__add_kfunc_decl_tag(struct btf *btf, const char *tag, __u32 id, const char *kfunc)
-{
-	int err = btf__add_decl_tag(btf, tag, id, -1);
-
-	if (err < 0) {
-		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
-			__func__, kfunc, err);
-		return err;
-	}
-	return 0;
-}
-
-static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc, __u32 flags)
-{
-	struct btf_func key = { .name = kfunc };
-	struct btf *btf = encoder->btf;
-	struct btf_func *target;
-	const void *base;
-	unsigned int cnt;
-	int err;
-
-	base = gobuffer__entries(funcs);
-	cnt = gobuffer__nr_entries(funcs);
-	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
-	if (!target) {
-		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
-		return -1;
-	}
-
-	/* Note we are unconditionally adding the btf_decl_tag even
-	 * though vmlinux may already contain btf_decl_tags for kfuncs.
-	 * We are ok to do this b/c we will later btf__dedup() to remove
-	 * any duplicates.
-	 */
-	err = btf__add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, kfunc);
-	if (err < 0)
-		return err;
-	if (flags & KF_FASTCALL) {
-		err = btf__add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->type_id, kfunc);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
+static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 {
 	const char *filename = encoder->source_filename;
 	struct gobuffer btf_kfunc_ranges = {};
-	struct gobuffer btf_funcs = {};
 	Elf_Data *symbols = NULL;
 	Elf_Data *idlist = NULL;
 	Elf_Scn *symscn = NULL;
@@ -1977,12 +1909,6 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 	}
 	nr_syms = shdr.sh_size / shdr.sh_entsize;
 
-	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
-	if (err) {
-		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
-		goto out;
-	}
-
 	/* First collect all kfunc set ranges.
 	 *
 	 * Note we choose not to sort these ranges and accept a linear
@@ -2015,12 +1941,12 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 	for (i = 0; i < nr_syms; i++) {
 		const struct btf_kfunc_set_range *ranges;
 		const struct btf_id_and_flag *pair;
+		struct elf_function *elf_fn;
 		unsigned int ranges_cnt;
 		char *func, *name;
 		ptrdiff_t off;
 		GElf_Sym sym;
 		bool found;
-		int err;
 		int j;
 
 		if (!gelf_getsym(symbols, i, &sym)) {
@@ -2061,18 +1987,16 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			continue;
 		}
 
-		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func, pair->flags);
-		if (err) {
-			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
-			free(func);
-			goto out;
+		elf_fn = btf_encoder__find_function(encoder, func, 0);
+		if (elf_fn) {
+			elf_fn->kfunc = true;
+			elf_fn->kfunc_flags = pair->flags;
 		}
 		free(func);
 	}
 
 	err = 0;
 out:
-	__gobuffer__delete(&btf_funcs);
 	__gobuffer__delete(&btf_kfunc_ranges);
 	if (elf)
 		elf_end(elf);
@@ -2083,7 +2007,6 @@ out:
 
 int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 {
-	bool should_tag_kfuncs;
 	int err;
 	size_t shndx;
 
@@ -2099,15 +2022,6 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
 
-	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
-	 * take care to call this before btf_dedup().
-	 */
-	should_tag_kfuncs = encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag;
-	if (should_tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
-		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
-		return -1;
-	}
-
 	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
@@ -2496,6 +2410,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		if (!found_percpu && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
+		if (encoder->tag_kfuncs) {
+			if (btf_encoder__collect_kfuncs(encoder))
+				goto out_delete;
+		}
+
 		if (encoder->verbose)
 			printf("File %s:\n", cu->filename);
 	}
-- 
2.48.1


