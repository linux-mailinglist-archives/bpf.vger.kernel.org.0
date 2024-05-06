Return-Path: <bpf+bounces-28671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3678BCF5B
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7454288237
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BC78C6C;
	Mon,  6 May 2024 13:45:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6077F2F
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003117; cv=none; b=dTVJJ8lKQknZw36NgUfdFk4gz2TDwE5jFXpBwLGYyKqyC6EXszyIa0RybBefIZyWflIS62Ow6mAycJt514paXlKRRj0/XEmDTa9Knn0lo1fWFSXesWARNFnuNso8R7Dbxh+xwHE9IRJIWqI7nUOAIxbOvJ9UGH7rTmS9PJjCLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003117; c=relaxed/simple;
	bh=/BjDU3XhI1hhP47tqKrY1oZiizwF9vQ8sHTeLnQvyI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0hcVdAB8riPHV+fDyBvTsdzji6B2KAcszI8ag5oBitsStnWNF6laHPq+PI3nJGnwoMCGpKRZCQ8z9f/uDyUbe7Twu5CHDUNeyR4ReWcf6O7F8CAL9RopghYyq23IKw5B8MhyNnbNoOARFXblypgU2ZEQV6FYlITxNVrXcLjdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f57713684so2385916e87.1
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 06:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715003114; x=1715607914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhKS9tL2ICLoIW3I/8d5fM+9a33yhxidd3gcA27RLpM=;
        b=rergvaUVcqKUKIOjorMxsouF8LdlrRiA5cz5gWJ7pT5w0sL3CLyPkatrn/cSP92gC5
         WRDJY1SdNBrODEnX2KKg9y26vHnPifovzQDzTF/seE6kqSZJz8s9NFWBUCGqZtbZQGZj
         5huRPqKCzMYxkpJPi+INUjfXJbuaBycER1dppX6hJNJW0tlx9TPzQfKTYxnwb13MZ/eH
         AM3+lLmNXgnMst0Gg1v0bfAUmjokUaHKY37pTgCS+EAgkVb0LUuWctI7lE6sKswrSsc/
         QwMaZ5cI78Um8RHgW9/hyjHgjthZ6Bz9u/iXlf7ElZFnuLeAoNJ58byI6isWDOMAgoSN
         UGaA==
X-Gm-Message-State: AOJu0YypRwv1jSji8jLECHZAkMSgddlrWiQqdFoNyDPn+EC3pLetlWGB
	/kUxdEJ2PlHs2IzZ2SjCavFbYhzJlHFlOQ0CELLmNVs4g30mHgKsBp6Y1Q==
X-Google-Smtp-Source: AGHT+IHTIefRgfwRR2QzcgIsUSbrqIbLPtqC/6O3H5OXRAiCa10BDMxydWOSJyIig5p9iT9E0BzHqQ==
X-Received: by 2002:a05:6512:7c:b0:51c:22fb:182f with SMTP id i28-20020a056512007c00b0051c22fb182fmr6771060lfo.13.1715003113322;
        Mon, 06 May 2024 06:45:13 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:400::5:81ce])
        by smtp.gmail.com with ESMTPSA id c10-20020a0564021f8a00b005727e826977sm5222028edc.19.2024.05.06.06.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 06:45:12 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpftool: introduce btf c dump sorting
Date: Mon,  6 May 2024 14:44:58 +0100
Message-ID: <20240506134458.727621-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Provide a way to sort bpftool c dump output, to simplify vmlinux.h
diffing and forcing more natural definitions ordering.

Use `normalized` argument in bpftool CLI after `format c` for example:
```
bpftool btf dump file /sys/kernel/btf/fuse format c normalized
```

Definitions are sorted by their BTF kind ranks, lexicographically and
typedefs are forced to go right after their base type.

Type ranks

Assign ranks to btf kinds (defined in function btf_type_rank) to set
next order:
1. Anonymous enums
2. Anonymous enums64
3. Named enums
4. Named enums64
5. Trivial types typedefs (ints, then floats)
6. Structs
7. Unions
8. Function prototypes
9. Forward declarations

Lexicographical ordering

Definitions within the same BTF kind are ordered by their names.
Anonymous enums are ordered by their first element.

Forcing typedefs to go right after their base type

To make sure that typedefs are emitted right after their base type,
we build a list of type's typedefs (struct typedef_ref) and after
emitting type, its typedefs are emitted as well (lexicographically)

There is a small flaw in this implementation:
Type dependencies are resolved by bpf lib, so when type is dumped
because it is a dependency, its typedefs are not output right after it,
as bpflib does not have the list of typedefs for a given type.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/btf.c | 264 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..93c876e90b04 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -11,6 +11,7 @@
 #include <linux/btf.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <linux/list.h>
 
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
@@ -43,6 +44,20 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_ENUM64]	= "ENUM64",
 };
 
+struct typedef_ref {
+	struct sort_datum *datum;
+	struct list_head list;
+};
+
+struct sort_datum {
+	__u32 index;
+	int type_rank;
+	bool emitted;
+	const char *name;
+	// List of typedefs of this type
+	struct list_head *typedef_list;
+};
+
 static const char *btf_int_enc_str(__u8 encoding)
 {
 	switch (encoding) {
@@ -460,8 +475,233 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 	vfprintf(stdout, fmt, args);
 }
 
+static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
+{
+	const struct btf_type *btf_type = btf__type_by_id(btf, index);
+	const int max_rank = 1000;
+
+	has_name |= (bool)btf_type->name_off;
+
+	switch (btf_kind(btf_type)) {
+	case BTF_KIND_ENUM:
+		return 100 + (btf_type->name_off == 0 ? 0 : 1);
+	case BTF_KIND_ENUM64:
+		return 200 + (btf_type->name_off == 0 ? 0 : 1);
+	case BTF_KIND_INT:
+		return 300;
+	case BTF_KIND_FLOAT:
+		return 400;
+	case BTF_KIND_VAR:
+		return 500;
+
+	case BTF_KIND_STRUCT:
+		return 600 + (has_name ? 0 : max_rank);
+	case BTF_KIND_UNION:
+		return 700 + (has_name ? 0 : max_rank);
+	case BTF_KIND_FUNC_PROTO:
+		return 800 + (has_name ? 0 : max_rank);
+
+	case BTF_KIND_FWD:
+		return 900;
+
+	case BTF_KIND_ARRAY:
+		return 1 + btf_type_rank(btf, btf_array(btf_type)->type, has_name);
+
+	case BTF_KIND_CONST:
+	case BTF_KIND_PTR:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_TYPEDEF:
+		return 1 + btf_type_rank(btf, btf_type->type, has_name);
+
+	default:
+		return max_rank;
+	}
+}
+
+static const char *btf_type_sort_name(const struct btf *btf, __u32 index)
+{
+	const struct btf_type *btf_type = btf__type_by_id(btf, index);
+	const int kind = btf_kind(btf_type);
+	const char *name = btf__name_by_offset(btf, btf_type->name_off);
+
+	// Use name of the first element for anonymous enums
+	if (!btf_type->name_off && (kind == BTF_KIND_ENUM || kind == BTF_KIND_ENUM64))
+		name = btf__name_by_offset(btf, btf_enum(btf_type)->name_off);
+
+	return name;
+}
+
+static int btf_type_compare(const void *left, const void *right)
+{
+	const struct sort_datum *datum1 = (const struct sort_datum *)left;
+	const struct sort_datum *datum2 = (const struct sort_datum *)right;
+
+	if (datum1->type_rank != datum2->type_rank)
+		return datum1->type_rank < datum2->type_rank ? -1 : 1;
+
+	return strcmp(datum1->name, datum2->name);
+}
+
+static int emit_typedefs(struct list_head *typedef_list, int *sorted_indexes)
+{
+	struct typedef_ref *type;
+	int current_index = 0;
+
+	if (!typedef_list)
+		return 0;
+	list_for_each_entry(type, typedef_list, list) {
+		if (type->datum->emitted)
+			continue;
+		type->datum->emitted = true;
+		sorted_indexes[current_index++] = type->datum->index;
+		current_index += emit_typedefs(type->datum->typedef_list,
+					sorted_indexes + current_index);
+	}
+	return current_index;
+}
+
+static void free_typedefs(struct list_head *typedef_list)
+{
+	struct typedef_ref *type;
+	struct typedef_ref *temp_type;
+
+	if (!typedef_list)
+		return;
+	list_for_each_entry_safe(type, temp_type, typedef_list, list) {
+		list_del(&type->list);
+		free(type);
+	}
+	free(typedef_list);
+}
+
+static void add_typedef_ref(const struct btf *btf, struct sort_datum *parent,
+			    struct typedef_ref *new_ref)
+{
+	struct typedef_ref *current_child;
+	const char *new_child_name = new_ref->datum->name;
+
+	if (!parent->typedef_list) {
+		parent->typedef_list = malloc(sizeof(struct list_head));
+		INIT_LIST_HEAD(parent->typedef_list);
+		list_add(&new_ref->list, parent->typedef_list);
+		return;
+	}
+	list_for_each_entry(current_child, parent->typedef_list, list) {
+		const struct btf_type *t = btf__type_by_id(btf, current_child->datum->index);
+		const char *current_name = btf_str(btf, t->name_off);
+
+		if (list_is_last(&current_child->list, parent->typedef_list)) {
+			list_add(&new_ref->list, &current_child->list);
+			return;
+		}
+		if (strcmp(new_child_name, current_name) < 0) {
+			list_add_tail(&new_ref->list, &current_child->list);
+			return;
+		}
+	}
+}
+
+static int find_base_typedef_type(const struct btf *btf, int index)
+{
+	const struct btf_type *type = btf__type_by_id(btf, index);
+	int kind = btf_kind(type);
+	int base_idx;
+
+	if (kind != BTF_KIND_TYPEDEF)
+		return 0;
+
+	do {
+		base_idx = kind == BTF_KIND_ARRAY ? btf_array(type)->type : type->type;
+		type = btf__type_by_id(btf, base_idx);
+		kind = btf_kind(type);
+	} while (kind == BTF_KIND_ARRAY ||
+		   kind == BTF_KIND_PTR ||
+		   kind == BTF_KIND_CONST ||
+		   kind == BTF_KIND_VOLATILE ||
+		   kind == BTF_KIND_RESTRICT ||
+		   kind == BTF_KIND_TYPE_TAG);
+
+	return base_idx;
+}
+
+static int *sort_btf_c(const struct btf *btf)
+{
+	int total_root_types;
+	struct sort_datum *datums;
+	int *sorted_indexes = NULL;
+	int *type_index_to_datum_index;
+
+	if (!btf)
+		return sorted_indexes;
+
+	total_root_types = btf__type_cnt(btf);
+	datums = malloc(sizeof(struct sort_datum) * total_root_types);
+
+	for (int i = 1; i < total_root_types; ++i) {
+		struct sort_datum *current_datum = datums + i;
+
+		current_datum->index = i;
+		current_datum->name = btf_type_sort_name(btf, i);
+		current_datum->type_rank = btf_type_rank(btf, i, false);
+		current_datum->emitted = false;
+		current_datum->typedef_list = NULL;
+	}
+
+	qsort(datums + 1, total_root_types - 1, sizeof(struct sort_datum), btf_type_compare);
+
+	// Build a mapping from btf type id to datums array index
+	type_index_to_datum_index = malloc(sizeof(int) * total_root_types);
+	type_index_to_datum_index[0] = 0;
+	for (int i = 1; i < total_root_types; ++i)
+		type_index_to_datum_index[datums[i].index] = i;
+
+	for (int i = 1; i < total_root_types; ++i) {
+		struct sort_datum *current_datum = datums + i;
+		const struct btf_type *current_type = btf__type_by_id(btf, current_datum->index);
+		int base_index;
+		struct sort_datum *base_datum;
+		const struct btf_type *base_type;
+		struct typedef_ref *new_ref;
+
+		if (btf_kind(current_type) != BTF_KIND_TYPEDEF)
+			continue;
+
+		base_index = find_base_typedef_type(btf, current_datum->index);
+		if (!base_index)
+			continue;
+
+		base_datum = datums + type_index_to_datum_index[base_index];
+		base_type = btf__type_by_id(btf, base_datum->index);
+		if (!base_type->name_off)
+			continue;
+
+		new_ref = malloc(sizeof(struct typedef_ref));
+		new_ref->datum = current_datum;
+
+		add_typedef_ref(btf, base_datum, new_ref);
+	}
+
+	sorted_indexes = malloc(sizeof(int) * total_root_types);
+	sorted_indexes[0] = 0;
+	for (int emit_index = 1, datum_index = 1; emit_index < total_root_types; ++datum_index) {
+		struct sort_datum *datum = datums + datum_index;
+
+		if (datum->emitted)
+			continue;
+		datum->emitted = true;
+		sorted_indexes[emit_index++] = datum->index;
+		emit_index += emit_typedefs(datum->typedef_list, sorted_indexes + emit_index);
+		free_typedefs(datum->typedef_list);
+	}
+	free(type_index_to_datum_index);
+	free(datums);
+	return sorted_indexes;
+}
+
 static int dump_btf_c(const struct btf *btf,
-		      __u32 *root_type_ids, int root_type_cnt)
+		      __u32 *root_type_ids, int root_type_cnt, bool normalized)
 {
 	struct btf_dump *d;
 	int err = 0, i;
@@ -485,12 +725,17 @@ static int dump_btf_c(const struct btf *btf,
 		}
 	} else {
 		int cnt = btf__type_cnt(btf);
-
+		int *sorted_indexes = normalized ? sort_btf_c(btf) : NULL;
 		for (i = 1; i < cnt; i++) {
-			err = btf_dump__dump_type(d, i);
+			int idx = sorted_indexes ? sorted_indexes[i] : i;
+
+			err = btf_dump__dump_type(d, idx);
 			if (err)
-				goto done;
+				break;
 		}
+		free(sorted_indexes);
+		if (err)
+			goto done;
 	}
 
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
@@ -553,6 +798,7 @@ static int do_dump(int argc, char **argv)
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
 	bool dump_c = false;
+	bool normalized = false;
 	__u32 btf_id = -1;
 	const char *src;
 	int fd = -1;
@@ -663,6 +909,14 @@ static int do_dump(int argc, char **argv)
 				goto done;
 			}
 			NEXT_ARG();
+		} else if (strcmp(*argv, "normalized") == 0) {
+			if (!dump_c) {
+				p_err("Only C dump supports normalization");
+				err = -EINVAL;
+				goto done;
+			}
+			normalized = true;
+			NEXT_ARG();
 		} else {
 			p_err("unrecognized option: '%s'", *argv);
 			err = -EINVAL;
@@ -691,7 +945,7 @@ static int do_dump(int argc, char **argv)
 			err = -ENOTSUP;
 			goto done;
 		}
-		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
+		err = dump_btf_c(btf, root_type_ids, root_type_cnt, normalized);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
-- 
2.44.0


