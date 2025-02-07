Return-Path: <bpf+bounces-50726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE7A2B8B3
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D584A1889124
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A28155316;
	Fri,  7 Feb 2025 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjFtDuS7"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B631A89
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894502; cv=none; b=ZyUcEslCqRoyWG1qlfxhfY8XOTW4SmOSt0/xzvdZ08abiSSjkT6W/8RL0ZSBSGw0Ooi/M2Nl3i/5McOm5U+tJgePH4Qc/xyoZDZSRSqudFBfetGuWKijTEsI77zfvsWuHGn8gbnaEF/BjizLcMbcHFYtWkimaDWaiM3x4ccmM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894502; c=relaxed/simple;
	bh=hTZK4fJFV4wz4mxSVNhzk+nVPLCOxAuXpL4jlX/Hrt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOBJfVRcyZ1AnjwaMl2i3Y4NGR2ScaBBEkVkPCyuOiye3RBKaoOiX94aLVJKqfEjWMXNRTlAzyjcrBjIqP1XGHab9F+15DUq1zUYMpcvDOl2mEedSp2oAx7Z83to4Dq6Er7HkuQNEZE3Gc8IJfavORQmb9CLOdcbwFymAbJdDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjFtDuS7; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738894498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmWw1aCGijLdPWWGvxKTFfBiabzcN8HCR+SwKE3cTF4=;
	b=EjFtDuS7TDkKVXn+wrE27jRfP1t33baWwfKRaOv1C7NHArKrJepFaDuZsJRpdOa07GMUmb
	vFfAUt1B0emJ7IEyfm6ywLARz3Y4R2TkcawHYYWY6+GpcBPfe1FKn7/KVyLDZ/SFiptd71
	moaFS76MLotwEaovnCnugADBJlZ/DIM=
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
Subject: [PATCH dwarves 1/3] btf_encoder: collect kfuncs info in btf_encoder__new
Date: Thu,  6 Feb 2025 18:14:40 -0800
Message-ID: <20250207021442.155703-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250207021442.155703-1-ihor.solodrai@linux.dev>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ihor Solodrai <ihor.solodrai@pm.me>

btf_encoder__tag_kfuncs() is a post-processing step of BTF encoding,
executed right before BTF is deduped and dumped to the output.

Split btf_encoder__tag_kfuncs() routine in two parts:
  * btf_encoder__collect_kfuncs()
  * btf_encoder__tag_kfuncs()

btf_encoder__collect_kfuncs() reads the .BTF_ids section of the ELF,
collecting kfunc information into a list of kfunc_info structs in the
btf_encoder. It is executed in btf_encoder__new() when tag_kfuncs flag
is set. This way kfunc information is available during entire lifetime
of the btf_encoder.

btf_encoder__tag_kfuncs() is basically the same: collect BTF
functions, and then for each kfunc find and tag correspoding BTF
func. Except now kfunc information is not collected in-place, but is
simply read from the btf_encoder.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 89 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 511c1ea..e9f4baf 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -89,6 +89,7 @@ struct elf_function {
 	const char	*name;
 	char		*alias;
 	size_t		prefixlen;
+	bool		kfunc;
 };
 
 struct elf_secinfo {
@@ -100,6 +101,13 @@ struct elf_secinfo {
 	struct gobuffer secinfo;
 };
 
+struct kfunc_info {
+	struct list_head node;
+	uint32_t id;
+	uint32_t flags;
+	const char* name;
+};
+
 struct elf_functions {
 	struct list_head node; /* for elf_functions_list */
 	Elf *elf; /* source ELF */
@@ -143,6 +151,7 @@ struct btf_encoder {
 	 * so we have to store elf_functions tables per ELF.
 	 */
 	struct list_head elf_functions_list;
+	struct list_head kfuncs; /* list of kfunc_info */
 };
 
 struct btf_func {
@@ -1842,9 +1851,9 @@ static int btf__add_kfunc_decl_tag(struct btf *btf, const char *tag, __u32 id, c
 	return 0;
 }
 
-static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc, __u32 flags)
+static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const struct kfunc_info *kfunc)
 {
-	struct btf_func key = { .name = kfunc };
+	struct btf_func key = { .name = kfunc->name };
 	struct btf *btf = encoder->btf;
 	struct btf_func *target;
 	const void *base;
@@ -1855,7 +1864,7 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
 	cnt = gobuffer__nr_entries(funcs);
 	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
 	if (!target) {
-		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
+		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc->name);
 		return -1;
 	}
 
@@ -1864,11 +1873,12 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
 	 * We are ok to do this b/c we will later btf__dedup() to remove
 	 * any duplicates.
 	 */
-	err = btf__add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, kfunc);
+	err = btf__add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, kfunc->name);
 	if (err < 0)
 		return err;
-	if (flags & KF_FASTCALL) {
-		err = btf__add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->type_id, kfunc);
+
+	if (kfunc->flags & KF_FASTCALL) {
+		err = btf__add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->type_id, kfunc->name);
 		if (err < 0)
 			return err;
 	}
@@ -1876,11 +1886,10 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
 	return 0;
 }
 
-static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
+static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 {
 	const char *filename = encoder->source_filename;
 	struct gobuffer btf_kfunc_ranges = {};
-	struct gobuffer btf_funcs = {};
 	Elf_Data *symbols = NULL;
 	Elf_Data *idlist = NULL;
 	Elf_Scn *symscn = NULL;
@@ -1897,6 +1906,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 	int nr_syms;
 	int i = 0;
 
+	INIT_LIST_HEAD(&encoder->kfuncs);
+
 	fd = open(filename, O_RDONLY);
 	if (fd < 0) {
 		fprintf(stderr, "Cannot open %s\n", filename);
@@ -1977,12 +1988,6 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
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
@@ -2015,12 +2020,13 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 	for (i = 0; i < nr_syms; i++) {
 		const struct btf_kfunc_set_range *ranges;
 		const struct btf_id_and_flag *pair;
+		struct elf_function *elf_fn;
+		struct kfunc_info *kfunc;
 		unsigned int ranges_cnt;
 		char *func, *name;
 		ptrdiff_t off;
 		GElf_Sym sym;
 		bool found;
-		int err;
 		int j;
 
 		if (!gelf_getsym(symbols, i, &sym)) {
@@ -2061,18 +2067,26 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			continue;
 		}
 
-		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func, pair->flags);
-		if (err) {
-			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
-			free(func);
+		elf_fn = btf_encoder__find_function(encoder, func, 0);
+		free(func);
+		if (!elf_fn)
+			continue;
+		elf_fn->kfunc = true;
+
+		kfunc = calloc(1, sizeof(*kfunc));
+		if (!kfunc) {
+			fprintf(stderr, "%s: failed to allocate memory for kfunc info\n", __func__);
+			err = -ENOMEM;
 			goto out;
 		}
-		free(func);
+		kfunc->id = pair->id;
+		kfunc->flags = pair->flags;
+		kfunc->name = elf_fn->name;
+		list_add(&kfunc->node, &encoder->kfuncs);
 	}
 
 	err = 0;
 out:
-	__gobuffer__delete(&btf_funcs);
 	__gobuffer__delete(&btf_kfunc_ranges);
 	if (elf)
 		elf_end(elf);
@@ -2081,6 +2095,34 @@ out:
 	return err;
 }
 
+static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
+{
+	struct gobuffer btf_funcs = {};
+	int err;
+
+	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
+	if (err) {
+		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
+		goto out;
+	}
+
+	struct kfunc_info *kfunc, *tmp;
+	list_for_each_entry_safe(kfunc, tmp, &encoder->kfuncs, node) {
+		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, kfunc);
+		if (err) {
+			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, kfunc->name);
+			goto out;
+		}
+		list_del(&kfunc->node);
+		free(kfunc);
+	}
+
+	err = 0;
+out:
+	__gobuffer__delete(&btf_funcs);
+	return err;
+}
+
 int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 {
 	bool should_tag_kfuncs;
@@ -2496,6 +2538,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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


