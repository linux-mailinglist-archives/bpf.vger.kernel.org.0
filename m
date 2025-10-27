Return-Path: <bpf+bounces-72326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B7C0E2F9
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52721888E6B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39F3081D6;
	Mon, 27 Oct 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlvpf7ul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676A307491
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573279; cv=none; b=vGL3ibFbuToytFjEOuUFV6DFrI7BaiGG7RJKSE24zPpLL0/w4gml3t5ri4HhXZ2iu+zuc+XxuN1eshUcmGchUo2TYCvt4fiOfCj0BTZKhU1Nc019ZQKTNGyWu3PtAxBHfFHoHBHvCkaoxZ05YPL1CfSO2cg5N+z4rzA8ZqzhCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573279; c=relaxed/simple;
	bh=kTJF/ccwNDazzGvPAMxXtm7s7Se9RjNlffjPWzGQmjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSQoas7DS+0MES75mBzz15FK9pNY455lPgQwgiq1ai31qSSVhGe5hVrOCpQIm+4C/tIQkTCux8fywd2BF1QyjQOg202tg7Wrjb39rn/RaKLNkOgV6WPXDQiAJjXocIPklxXa87qWZVPjZV3d3WUe5bxrnZcYAP5qT/GRCi4moho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlvpf7ul; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso4011289a91.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573276; x=1762178076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OlcMMK8Cd+16DJOp+mJkp5fktcMj5EaiRx1/DUOfXA=;
        b=mlvpf7ulFCtL/oaJn6oOkQfZjjqKo7zW9nCF8rP0jeqigmP22QQ+pxHCmY4rmEmGs8
         SVcrddNztJ+TP9xj2Rb7a2LIfu7x1SLfUxswprdwEh2tLwMgSSeoAFE8wnI11NEUg9j/
         Y2Fj7jWn0syjb3cFVwl8Y2Oo1xcnKCt7DyVGvzDsrX7xC6b/wQ5g3NLmvQ1tf+RMMasv
         hsWBJxg3qKwXn4bpoNzVRiO+vC6vvY6u5/Oz9iO65ydXjIbalKRxuhzri3oDVcnIyoEO
         xV2FgmS2Z0g7Kx7ALA13swYLsYKi00JY66xTLtBuMynfy1PliEjF9JdItGxI/zv4kfe1
         mm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573276; x=1762178076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OlcMMK8Cd+16DJOp+mJkp5fktcMj5EaiRx1/DUOfXA=;
        b=vaD9WAIVT3dxvDEh8J6pkmBObFPp6uI3J8+YdsOwHO8OCsvRhLHTyyp4ATXWQVoa+V
         R99r71DZKO+0p0x0lapj8QJydEyHsbWSLCmNRz8iF/8VGvFrHG2zSIXah/M44aKS+Ats
         lO6vgnq6KH/ES97qF4UQqIUTphF3tZnWOUWmzOTXLfkQ78bXGmFRx29QVB9U+vEn7HL8
         1mtq6n0vKA4GI4bojme/wIaB/D6YTTBRacfBsYLT5SPFIkFboMgD52SYWHCNxrMlbLDk
         ZwCpyDumo6IzPz+c2646vJlzLWPRC2yb4LDoA60FO1An3bgguMvBP7N2m+gV7Y7Uf37C
         okPA==
X-Forwarded-Encrypted: i=1; AJvYcCUzlslxAWerEINhaBQkAnCXV7J64uXzsdwbYJwjeSqg1bgFpwl7bMKusfNQcQVmR5nlwRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+RqRKzDCyCBcm69gbGaQaNXJ7bHbLBJPi40zJbVvvjmNZSeA
	lS9iOIIYxmep25gbVVvitHziXULB43aCzjxBOObreV1gKYpD+L4YmXmX
X-Gm-Gg: ASbGnctPJ3rcN5RoGM3reAlyy2RhWo5ekOSsUcWMSHFNWOyi1PWuP0wcfDupXZBgaHT
	OMs5VfvUFmH19259Hcbl2ssVNRgHxBfyLtYm47YRuMlwD64icRujN1tifdZUO+dNnXH6CYpqhz0
	0Q7sAc42TRkDZTvEZ0HqilpO/Ml6G7X2A9znNKw2wvSeEJYIdiUdnah5Cr1HgZ1IglJIJe13MJd
	n2hFCM7CbFL2SieT92He4/nJN8zUOqbBY9ei3iYRGF7v6/TyHyJigUKLGYvwvbNJ7PRXVreoCML
	F0fQSw561GLP17N8iMbiVBNUaa6m8C19GZnHJnPUGAF7gAA4JC3RvkmrzA67+cT82C04k4/zSCS
	mUjmS5ZCXfD2hzpha2F96RqBBWhjY/3W5EP3OIbT10IYO1yEPetLVaUsrBlflscmt6RQx4dbf6n
	rFMZHfSA79+DRx3eXQ
X-Google-Smtp-Source: AGHT+IEX5c4gQQrdCPE+LcKI9qXW9JDLRDKeH4KCfWLifwt768E51P1orSn78v1yDOwdfFDfTJyNmg==
X-Received: by 2002:a17:90b:3c42:b0:33b:ae28:5eae with SMTP id 98e67ed59e1d1-33bcf87ac11mr43573347a91.14.1761573275831;
        Mon, 27 Oct 2025 06:54:35 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:34 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v3 1/3] btf: implement BTF type sorting for accelerated lookups
Date: Mon, 27 Oct 2025 21:54:21 +0800
Message-Id: <20251027135423.3098490-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027135423.3098490-1-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new libbpf interface btf__permute() to reorganize
BTF types according to a provided mapping. The BTF lookup mechanism is
enhanced with binary search capability, significantly improving lookup
performance for large type sets.

The pahole tool can invoke this interface with a sorted type ID array,
enabling binary search in both user space and kernel. To share core logic
between kernel and libbpf, common sorting functionality is implemented
in a new btf_sort.c source file.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
v2->v3:
- Remove sorting logic from libbpf and provide a generic btf__permute() interface
- Remove the search direction patch since sorted lookup provides sufficient performance
  and changing search order could cause conflicts between BTF and base BTF
- Include btf_sort.c directly in btf.c to reduce function call overhead
---
 tools/lib/bpf/btf.c            | 262 ++++++++++++++++++++++++++++++---
 tools/lib/bpf/btf.h            |  17 +++
 tools/lib/bpf/btf_sort.c       | 174 ++++++++++++++++++++++
 tools/lib/bpf/btf_sort.h       |  11 ++
 tools/lib/bpf/libbpf.map       |   6 +
 tools/lib/bpf/libbpf_version.h |   2 +-
 6 files changed, 447 insertions(+), 25 deletions(-)
 create mode 100644 tools/lib/bpf/btf_sort.c
 create mode 100644 tools/lib/bpf/btf_sort.h

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..d20bf81a21ce 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -23,6 +23,7 @@
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "strset.h"
+#include "btf_sort.h"
 
 #define BTF_MAX_NR_TYPES 0x7fffffffU
 #define BTF_MAX_STR_OFFSET 0x7fffffffU
@@ -92,6 +93,12 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* number of sorted and named types in this BTF instance:
+	 *   - doesn't include special [0] void type;
+	 *   - for split BTF counts number of sorted and named types added on
+	 *     top of base BTF.
+	 */
+	__u32 nr_sorted_types;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -624,6 +631,11 @@ const struct btf *btf__base_btf(const struct btf *btf)
 	return btf->base_btf;
 }
 
+__u32 btf__start_id(const struct btf *btf)
+{
+	return btf->start_id;
+}
+
 /* internal helper returning non-const pointer to a type */
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
 {
@@ -915,38 +927,16 @@ __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
 	return libbpf_err(-ENOENT);
 }
 
-static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
-				   const char *type_name, __u32 kind)
-{
-	__u32 i, nr_types = btf__type_cnt(btf);
-
-	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
-		return 0;
-
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
-
-		if (btf_kind(t) != kind)
-			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
-	}
-
-	return libbpf_err(-ENOENT);
-}
-
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
-	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
+	return _btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
 }
 
 __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 			     __u32 kind)
 {
-	return btf_find_by_name_kind(btf, 1, type_name, kind);
+	return _btf_find_by_name_kind(btf, 1, type_name, kind);
 }
 
 static bool btf_is_modifiable(const struct btf *btf)
@@ -1091,6 +1081,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf, btf->start_id);
 
 done:
 	if (err) {
@@ -1715,6 +1706,8 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	if (btf->nr_sorted_types)
+		btf->nr_sorted_types = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
@@ -5829,3 +5822,224 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 		btf->owns_base = false;
 	return libbpf_err(err);
 }
+
+struct btf_permute;
+
+static struct btf_permute *btf_permute_new(struct btf *btf, const struct btf_permute_opts *opts);
+static void btf_permute_free(struct btf_permute *p);
+static int btf_permute_shuffle_types(struct btf_permute *p);
+static int btf_permute_remap_types(struct btf_permute *p);
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
+
+/*
+ * Permute BTF types in-place using the ID mapping from btf_permute_opts->ids.
+ * After permutation, all type ID references are updated to reflect the new
+ * ordering. If a struct btf_ext (representing '.BTF.ext' section) is provided,
+ * type ID references within the BTF extension data are also updated.
+ */
+int btf__permute(struct btf *btf, const struct btf_permute_opts *opts)
+{
+	struct btf_permute *p;
+	int err = 0;
+
+	if (!OPTS_VALID(opts, btf_permute_opts))
+		return libbpf_err(-EINVAL);
+
+	p = btf_permute_new(btf, opts);
+	if (!p) {
+		pr_debug("btf_permute_new failed: %ld\n", PTR_ERR(p));
+		return libbpf_err(-EINVAL);
+	}
+
+	if (btf_ensure_modifiable(btf)) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	err = btf_permute_shuffle_types(p);
+	if (err < 0) {
+		pr_debug("btf_permute_shuffle_types failed: %s\n", errstr(err));
+		goto done;
+	}
+	err = btf_permute_remap_types(p);
+	if (err) {
+		pr_debug("btf_permute_remap_types failed: %s\n", errstr(err));
+		goto done;
+	}
+
+done:
+	btf_permute_free(p);
+	return libbpf_err(err);
+}
+
+struct btf_permute {
+	/* .BTF section to be permuted in-place */
+	struct btf *btf;
+	struct btf_ext *btf_ext;
+	/* Array of type IDs used for permutation. The array length must equal
+	 * the number of types in the BTF being permuted, excluding the special
+	 * void type at ID 0. For split BTF, the length corresponds to the
+	 * number of types added on top of the base BTF.
+	 */
+	__u32 *ids;
+	/* Array of type IDs used to map from original type ID to a new permuted
+	 * type ID, its length equals to the above ids */
+	__u32 *map;
+};
+
+static struct btf_permute *btf_permute_new(struct btf *btf, const struct btf_permute_opts *opts)
+{
+	struct btf_permute *p = calloc(1, sizeof(struct btf_permute));
+	__u32 *map;
+	int err = 0;
+
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	p->btf = btf;
+	p->btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	p->ids = OPTS_GET(opts, ids, NULL);
+	if (!p->ids) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	map = calloc(btf->nr_types, sizeof(*map));
+	if (!map) {
+		err = -ENOMEM;
+		goto done;
+	}
+	p->map = map;
+
+done:
+	if (err) {
+		btf_permute_free(p);
+		return ERR_PTR(err);
+	}
+
+	return p;
+}
+
+static void btf_permute_free(struct btf_permute *p)
+{
+	if (p->map) {
+		free(p->map);
+		p->map = NULL;
+	}
+	free(p);
+}
+
+/*
+ * Shuffle BTF types.
+ *
+ * Rearranges types according to the permutation map in p->ids. The p->map
+ * array stores the mapping from original type IDs to new shuffled IDs,
+ * which is used in the next phase to update type references.
+ */
+static int btf_permute_shuffle_types(struct btf_permute *p)
+{
+	struct btf *btf = p->btf;
+	const struct btf_type *t;
+	__u32 *new_offs = NULL;
+	void *l, *new_types = NULL;
+	int i, id, len, err;
+
+	new_offs = calloc(btf->nr_types, sizeof(*new_offs));
+	new_types = calloc(btf->hdr->type_len, 1);
+	if (!new_types || !new_offs) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	l = new_types;
+	for (i = 0; i < btf->nr_types; i++) {
+		id = p->ids[i];
+		t = btf__type_by_id(btf, id);
+		len = btf_type_size(t);
+		memcpy(l, t, len);
+		new_offs[i] = l - new_types;
+		p->map[id - btf->start_id] = btf->start_id + i;
+		l += len;
+	}
+
+	free(btf->types_data);
+	free(btf->type_offs);
+	btf->types_data = new_types;
+	btf->type_offs = new_offs;
+	return 0;
+
+out_err:
+	return err;
+}
+
+/*
+ * Remap referenced type IDs into permuted type IDs.
+ *
+ * After BTF types are permuted, their final type IDs may differ from original
+ * ones. The map from original to a corresponding permuted type ID is stored
+ * in btf_permute->map and is populated during shuffle phase. During remapping
+ * phase we are rewriting all type IDs  referenced from any BTF type (e.g.,
+ * struct fields, func proto args, etc) to their final deduped type IDs.
+ */
+static int btf_permute_remap_types(struct btf_permute *p)
+{
+	struct btf *btf = p->btf;
+	int i, r;
+
+	for (i = 0; i < btf->nr_types; i++) {
+		struct btf_type *t = btf_type_by_id(btf, btf->start_id + i);
+		struct btf_field_iter it;
+		__u32 *type_id;
+
+		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+		if (r)
+			return r;
+
+		while ((type_id = btf_field_iter_next(&it))) {
+			__u32 new_id = *type_id;
+
+			/* skip references that point into the base BTF */
+			if (new_id < btf->start_id)
+				continue;
+
+			new_id = p->map[new_id - btf->start_id];
+			if (new_id > BTF_MAX_NR_TYPES)
+				return -EINVAL;
+
+			*type_id = new_id;
+		}
+	}
+
+	if (!p->btf_ext)
+		return 0;
+
+	r = btf_ext_visit_type_ids(p->btf_ext, btf_permute_remap_type_id, p);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
+{
+	struct btf_permute *p = ctx;
+	__u32 new_type_id = *type_id;
+
+	/* skip references that point into the base BTF */
+	if (new_type_id < p->btf->start_id)
+		return 0;
+
+	new_type_id = p->map[*type_id - p->btf->start_id];
+	if (new_type_id > BTF_MAX_NR_TYPES)
+		return -EINVAL;
+
+	*type_id = new_type_id;
+	return 0;
+}
+
+/*
+ * btf_sort.c is included directly to avoid function call overhead
+ * when accessing BTF private data, as this file is shared between
+ * libbpf and kernel and may be called frequently.
+ */
+#include "./btf_sort.c"
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..3aac0a729bd5 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -149,6 +149,7 @@ LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
 					const char *type_name, __u32 kind);
 LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
 LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
+LIBBPF_API __u32 btf__start_id(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
 						  __u32 id);
 LIBBPF_API size_t btf__pointer_size(const struct btf *btf);
@@ -273,6 +274,22 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
  */
 LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf);
 
+struct btf_permute_opts {
+	size_t sz;
+	/* optional .BTF.ext info along the main BTF info */
+	struct btf_ext *btf_ext;
+	/* Array of type IDs used for permutation. The array length must equal
+	 * the number of types in the BTF being permuted, excluding the special
+	 * void type at ID 0. For split BTF, the length corresponds to the
+	 * number of types added on top of the base BTF.
+	 */
+	__u32 *ids;
+	size_t :0;
+};
+#define btf_permute_opts__last_field ids
+
+LIBBPF_API int btf__permute(struct btf *btf, const struct btf_permute_opts *opts);
+
 struct btf_dump;
 
 struct btf_dump_opts {
diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
new file mode 100644
index 000000000000..553c5f5e61bd
--- /dev/null
+++ b/tools/lib/bpf/btf_sort.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2025 Xiaomi */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#ifdef __KERNEL__
+
+#define btf_type_by_id				(struct btf_type *)btf_type_by_id
+#define btf__str_by_offset			btf_str_by_offset
+#define btf__type_cnt				btf_nr_types
+#define btf__start_id				btf_start_id
+#define libbpf_err(x)				x
+
+#else
+
+#define notrace
+
+#endif /* __KERNEL__ */
+
+/*
+ * Skip the sorted check if the number of BTF types is below this threshold.
+ * The value 4 is chosen based on the theoretical break-even point where
+ * linear search (N/2) and binary search (LOG2(N)) require approximately
+ * the same number of comparisons.
+ */
+#define BTF_CHECK_SORT_THRESHOLD  4
+
+struct btf;
+
+static int cmp_btf_kind_name(int ka, const char *na, int kb, const char *nb)
+{
+	return (ka - kb) ?: strcmp(na, nb);
+}
+
+/*
+ * Sort BTF types by kind and name in ascending order, placing named types
+ * before anonymous ones.
+ */
+static int btf_compare_type_kinds_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+	bool anon_a, anon_b;
+	int ka, kb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	anon_a = str_is_empty(na);
+	anon_b = str_is_empty(nb);
+
+	/* ta w/o name is greater than tb */
+	if (anon_a && !anon_b)
+		return 1;
+	/* tb w/o name is smaller than ta */
+	if (!anon_a && anon_b)
+		return -1;
+
+	ka = btf_kind(ta);
+	kb = btf_kind(tb);
+
+	if (anon_a && anon_b)
+		return ka - kb;
+
+	return cmp_btf_kind_name(ka, na, kb, nb);
+}
+
+static __s32 notrace __btf_find_by_name_kind(const struct btf *btf, int start_id,
+				   const char *type_name, __u32 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int err = -ENOENT;
+
+	if (!btf)
+		goto out;
+
+	if (start_id < btf__start_id(btf)) {
+		err = __btf_find_by_name_kind(btf->base_btf, start_id, type_name, kind);
+		if (err == -ENOENT)
+			start_id = btf__start_id(btf);
+	}
+
+	if (err == -ENOENT) {
+		if (btf->nr_sorted_types) {
+			/* binary search */
+			__s32 start, end, mid, found = -1;
+			int ret;
+
+			start = start_id;
+			end = start + btf->nr_sorted_types - 1;
+			/* found the leftmost btf_type that matches */
+			while(start <= end) {
+				mid = start + (end - start) / 2;
+				t = btf_type_by_id(btf, mid);
+				tname = btf__str_by_offset(btf, t->name_off);
+				ret = cmp_btf_kind_name(BTF_INFO_KIND(t->info), tname,
+							kind, type_name);
+				if (ret < 0)
+					start = mid + 1;
+				else {
+					if (ret == 0)
+						found = mid;
+					end = mid - 1;
+				}
+			}
+
+			if (found != -1)
+				return found;
+		} else {
+			/* linear search */
+			__u32 i, total;
+
+			total = btf__type_cnt(btf);
+			for (i = start_id; i < total; i++) {
+				t = btf_type_by_id(btf, i);
+				if (btf_kind(t) != kind)
+					continue;
+
+				tname = btf__str_by_offset(btf, t->name_off);
+				if (tname && !strcmp(tname, type_name))
+					return i;
+			}
+		}
+	}
+
+out:
+	return err;
+}
+
+/* start_id specifies the starting BTF to search */
+static __s32 notrace _btf_find_by_name_kind(const struct btf *btf, int start_id,
+				   const char *type_name, __u32 kind)
+{
+	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
+		return 0;
+
+	return libbpf_err(__btf_find_by_name_kind(btf, start_id, type_name, kind));
+}
+
+static void btf_check_sorted(struct btf *btf, int start_id)
+{
+	const struct btf_type *t;
+	int i, n, nr_sorted_types;
+
+	n = btf__type_cnt(btf);
+	if (btf->nr_types < BTF_CHECK_SORT_THRESHOLD)
+		return;
+
+	n--;
+	nr_sorted_types = 0;
+	for (i = start_id; i < n; i++) {
+		int k = i + 1;
+
+		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
+			return;
+
+		t = btf_type_by_id(btf, k);
+		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, start_id);
+	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+		nr_sorted_types++;
+
+	if (nr_sorted_types < BTF_CHECK_SORT_THRESHOLD)
+		return;
+
+	btf->nr_sorted_types = nr_sorted_types;
+}
diff --git a/tools/lib/bpf/btf_sort.h b/tools/lib/bpf/btf_sort.h
new file mode 100644
index 000000000000..4dedc67286d9
--- /dev/null
+++ b/tools/lib/bpf/btf_sort.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2025 Xiaomi */
+
+#ifndef __BTF_SORT_H
+#define __BTF_SORT_H
+
+static __s32 _btf_find_by_name_kind(const struct btf *btf, int start_id, const char *type_name, __u32 kind);
+static int btf_compare_type_kinds_names(const void *a, const void *b, void *priv);
+static void btf_check_sorted(struct btf *btf, int start_id);
+
+#endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..8ce7b1d08650 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -452,3 +452,9 @@ LIBBPF_1.7.0 {
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
 } LIBBPF_1.6.0;
+
+LIBBPF_1.8.0 {
+	global:
+		btf__start_id;
+		btf__permute;
+} LIBBPF_1.7.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 99331e317dee..c446c0cd8cf9 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 7
+#define LIBBPF_MINOR_VERSION 8
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.34.1


