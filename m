Return-Path: <bpf+bounces-29196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C68C11D7
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DE71F25260
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201C15E7E4;
	Thu,  9 May 2024 15:17:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BA15CD7D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267875; cv=none; b=DXfy2n/j705re+9AJFOSPlemFLEeiL/heYYEsSy89b/XJ8pzdPVaogSfRw4IlnwQrJWOnKml3FTmVgWSed0FmkK5RFlopJH1aBvbEPnH+L/H6EBTH+V/hHQNYFFKk0QWATKjuE0SuQpoygYLyrnhASYjax7KSsnZxek+Eew4/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267875; c=relaxed/simple;
	bh=6i+ys81wyp1oX0bHBTRtdf8YzzPOlJxRQWe1vqH16uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMhSJj5euEyd8KmSOTYW1/o/jFzvE3WtVCcFj3pUsjp9GI67QY1oEfCO8U2XMMhMBHcIV8UuMHeNiNv63wPCCSbz7Ibb39JB+dbPkQcWqtUYH7MGcn4RIudCq6rWmbqD/8ikWHybI+D4e5uFYNgM1gXzJtTCfjBE7NVUVCFjABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4702457ccbso258436666b.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 08:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267872; x=1715872672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qseT0/z7N0PNqCQsjVP6WKYnVgeLDEHPQt6Zf5k+lRk=;
        b=gYy3ITPjM7bhw3HkKYpOm3XhZueuT9c6/fEPGDQssvqnNBqYEsUMn2M3/QcCZu4XHf
         7/KTy6Hi7/d77k8n+zFPV5Xx345xSKM5VYkygVrDb5BVRM3mZUUjs+syp40eIMmHR5VU
         f96A8lpmZPDCMu05W4BCVFSaDr5RDF8444icskoK9PEmMocNP3FXNtkYgxyehcrJ9UIR
         FjFPik0EvseomrOFffKFgvZFYsve59JcYEGHR2BJ1RufzQvIou9/4bjbm+xWoQRxOWbR
         1xeG/E6ZkZ8Nr/rSK6vr4eT7teYwK6bQGY+228daG8YAHE4yNhCzozRrRH8unaX/LyiB
         ykDg==
X-Gm-Message-State: AOJu0Yy3dNbGMA8ED2Ux6HXJyOYFAloWBEG6DrWYNjQHrB5+GfdcsS3m
	uEiJt+vRjvOupZX0SDtDZ4kiEuScAhlZvRm6nodEw3WbHFmT10Ogln6qjw==
X-Google-Smtp-Source: AGHT+IHnvSV7JM9OO1vvECD9oATabkkuMSvSFFmmphJeOnxn5kD1alxi+8FN6mbGfdSXkSipc6zMNA==
X-Received: by 2002:a17:906:794a:b0:a59:ca33:683f with SMTP id a640c23a62f3a-a59fb94db6amr406522066b.28.1715267871591;
        Thu, 09 May 2024 08:17:51 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::5:fd51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d02sm83257166b.218.2024.05.09.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:17:51 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	kernel-team@meta.com,
	qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
Date: Thu,  9 May 2024 16:17:44 +0100
Message-ID: <20240509151744.131648-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
forcing more natural type definitions ordering.

Definitions are sorted first by their BTF kind ranks, then by their base
type name and by their own name.

Type ranks

Assign ranks to btf kinds (defined in function btf_type_rank) to set
next order:
1. Anonymous enums/enums64
2. Named enums/enums64
3. Trivial types typedefs (ints, then floats)
4. Structs/Unions
5. Function prototypes
6. Forward declarations

Type rank is set to maximum for unnamed reference types, structs and
unions to avoid emitting those types early. They will be emitted as
part of the type chain starting with named type.

Lexicographical ordering

Each type is assigned a sort_name and own_name.
sort_name is the resolved name of the final base type for reference
types (typedef, pointer, array etc). Sorting by sort_name allows to
group typedefs of the same base type. sort_name for non-reference type
is the same as own_name. own_name is a direct name of particular type,
is used as final sorting step.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/btf.c | 125 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..09ecd2abf066 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_ENUM64]	= "ENUM64",
 };
 
+struct sort_datum {
+	int index;
+	int type_rank;
+	const char *sort_name;
+	const char *own_name;
+};
+
 static const char *btf_int_enc_str(__u8 encoding)
 {
 	switch (encoding) {
@@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 	vfprintf(stdout, fmt, args);
 }
 
+static bool is_reference_type(const struct btf_type *t)
+{
+	int kind = btf_kind(t);
+
+	return kind == BTF_KIND_CONST || kind == BTF_KIND_PTR || kind == BTF_KIND_VOLATILE ||
+		kind == BTF_KIND_RESTRICT || kind == BTF_KIND_ARRAY || kind == BTF_KIND_TYPEDEF ||
+		kind == BTF_KIND_DECL_TAG;
+}
+
+static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
+{
+	const struct btf_type *t = btf__type_by_id(btf, index);
+	const int max_rank = 10;
+	const int kind = btf_kind(t);
+
+	if (t->name_off)
+		has_name = true;
+
+	switch (kind) {
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		return has_name ? 1 : 0;
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+		return 2;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		return has_name ? 3 : max_rank;
+	case BTF_KIND_FUNC_PROTO:
+		return has_name ? 4 : max_rank;
+
+	default: {
+		if (has_name && is_reference_type(t)) {
+			const int parent = kind == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
+
+			return btf_type_rank(btf, parent, has_name);
+		}
+		return max_rank;
+	}
+	}
+}
+
+static const char *btf_type_sort_name(const struct btf *btf, __u32 index)
+{
+	const struct btf_type *t = btf__type_by_id(btf, index);
+	int kind = btf_kind(t);
+
+	/* Use name of the first element for anonymous enums */
+	if (!t->name_off && (kind == BTF_KIND_ENUM || kind == BTF_KIND_ENUM64) &&
+	    BTF_INFO_VLEN(t->info))
+		return btf__name_by_offset(btf, btf_enum(t)->name_off);
+
+	/* Return base type name for reference types */
+	while (is_reference_type(t)) {
+		index = btf_kind(t) == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
+		t = btf__type_by_id(btf, index);
+	}
+
+	return btf__name_by_offset(btf, t->name_off);
+}
+
+static int btf_type_compare(const void *left, const void *right)
+{
+	const struct sort_datum *datum1 = (const struct sort_datum *)left;
+	const struct sort_datum *datum2 = (const struct sort_datum *)right;
+	int sort_name_cmp;
+
+	if (datum1->type_rank != datum2->type_rank)
+		return datum1->type_rank < datum2->type_rank ? -1 : 1;
+
+	sort_name_cmp = strcmp(datum1->sort_name, datum2->sort_name);
+	if (sort_name_cmp)
+		return sort_name_cmp;
+
+	return strcmp(datum1->own_name, datum2->own_name);
+}
+
+static struct sort_datum *sort_btf_c(const struct btf *btf)
+{
+	int total_root_types;
+	struct sort_datum *datums;
+
+	total_root_types = btf__type_cnt(btf);
+	datums = malloc(sizeof(struct sort_datum) * total_root_types);
+	if (!datums)
+		return NULL;
+
+	for (int i = 0; i < total_root_types; ++i) {
+		struct sort_datum *current_datum = datums + i;
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		current_datum->index = i;
+		current_datum->type_rank = btf_type_rank(btf, i, false);
+		current_datum->sort_name = btf_type_sort_name(btf, i);
+		current_datum->own_name = btf__name_by_offset(btf, t->name_off);
+	}
+
+	qsort(datums, total_root_types, sizeof(struct sort_datum), btf_type_compare);
+
+	return datums;
+}
+
 static int dump_btf_c(const struct btf *btf,
-		      __u32 *root_type_ids, int root_type_cnt)
+		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
 	struct btf_dump *d;
 	int err = 0, i;
+	struct sort_datum *datums = NULL;
 
 	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
 	if (!d)
@@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
 	} else {
 		int cnt = btf__type_cnt(btf);
 
+		if (sort_dump)
+			datums = sort_btf_c(btf);
 		for (i = 1; i < cnt; i++) {
-			err = btf_dump__dump_type(d, i);
+			int idx = datums ? datums[i].index : i;
+
+			err = btf_dump__dump_type(d, idx);
 			if (err)
 				goto done;
 		}
@@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
 
 done:
 	btf_dump__free(d);
+	free(datums);
 	return err;
 }
 
@@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
 	bool dump_c = false;
+	bool sort_dump_c = true;
 	__u32 btf_id = -1;
 	const char *src;
 	int fd = -1;
@@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
 				goto done;
 			}
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "unordered")) {
+			sort_dump_c = false;
+			NEXT_ARG();
 		} else {
 			p_err("unrecognized option: '%s'", *argv);
 			err = -EINVAL;
@@ -691,7 +810,7 @@ static int do_dump(int argc, char **argv)
 			err = -ENOTSUP;
 			goto done;
 		}
-		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
+		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
-- 
2.44.0


