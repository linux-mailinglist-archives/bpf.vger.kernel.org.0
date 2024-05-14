Return-Path: <bpf+bounces-29699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972198C56B4
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 15:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF65B2835CA
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF314036F;
	Tue, 14 May 2024 13:12:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEB13FD9D
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692348; cv=none; b=HOvUeA70jGI9ZUNuq2ypqeijJTCwNg38SYqcluvSyDEXJq6TMnKJY+CtgPBqXcm065wgB4FWBVvf9SH2DqGjzmvYWrA7dvX4mdv0gabsvt3ZhD1I5CbblsvKflJb4ucOvgUPVfO4BW8nOLl9CQ9SRNNVCF+Pt+ym9Q6tcPlBSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692348; c=relaxed/simple;
	bh=d7lcXHaUqXem2nm8DXl7dkqdfArezPbwRNve46KuwVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKV6BUiMJXhDe/24yvU2NRT1F7pLBzYbZDD077VF7hDo9dHIWjSHh6UUvAJnSYfWQ3lbC3WhWqbOhV64AgwJUB2aiPXHfKX3P9+5Ic0UONSaj7uDxCV+8VHodwOpRRsoXsj2Wqx6eytRCCaGMIJkjKCmJepm9fUXaQl5BUONgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso80923a12.3
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 06:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692344; x=1716297144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNm+gsJoEcPi/ZqDZUgkP9snRBuhRXrOFThqffdaaE8=;
        b=YlpejCzOGtcpVpr7nBvqPcaX91jAgTwoLEUcSghOCv5JfeYPqDDbmDOYDd4eXkbYqe
         BwwtgRJO+JUmXvLACAB22JXkDoUMW3BYlVNElaysKdlw3wNyRrhkmUXS6NTkal/xtECT
         9HqvLHKRnZLoQj1eZlWjsiR0kKzjMHKhTvcM/b0sYxGmbubGJBvjlgSKv91vzCaIecur
         x6Thu16z8bBgU7+WVtdjqDNx9mHwVk4OUU+/+Z1NqqFpHPkF3Vq+uhpL+8r4BJWkcQvZ
         LwMVOJkjkbX4lURYcO9zq5JmMNwhGEakuXBnxsa3fsOoo8utf+75OEQBN2jTBlHDXvWY
         J4YA==
X-Gm-Message-State: AOJu0Yyv4QxFks3XT0cx0rTEGI29u88u71Rrqa9d19o/qd0rexCNYira
	ZuK2rmLdDRDdRwawNRB5wogDANYmNrjpUgbAm3oPwAQQx71KtRVFpkNZfw==
X-Google-Smtp-Source: AGHT+IFB6RrD85GT7PIi2FN37xmIO9o/DtS5p3hSuvm8DnlQnR1WMKlQ/7sNGBEH73DDDF1L0d6yZw==
X-Received: by 2002:a50:cc9a:0:b0:568:a30c:2db5 with SMTP id 4fb4d7f45d1cf-5734d6b2e5fmr7066397a12.40.1715692344115;
        Tue, 14 May 2024 06:12:24 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::6:6825])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65c0sm7390632a12.10.2024.05.14.06.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:12:23 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH v4 bpf-next] bpftool: introduce btf c dump sorting
Date: Tue, 14 May 2024 14:12:21 +0100
Message-ID: <20240514131221.20585-1-yatsenko@meta.com>
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
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   6 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/btf.c                       | 138 +++++++++++++++++-
 3 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index eaba24320fb2..3f6bca03ad2e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -28,7 +28,7 @@ BTF COMMANDS
 | **bpftool** **btf help**
 |
 | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
-| *FORMAT* := { **raw** | **c** }
+| *FORMAT* := { **raw** | **c** [**unsorted**] }
 | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 
@@ -63,7 +63,9 @@ bpftool btf dump *BTF_SRC*
     pahole.
 
     **format** option can be used to override default (raw) output format. Raw
-    (**raw**) or C-syntax (**c**) output formats are supported.
+    (**raw**) or C-syntax (**c**) output formats are supported. With C-style
+    formatting, the output is sorted by default. Use the **unsorted** option
+    to avoid sorting the output.
 
 bpftool btf help
     Print short help message.
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 04afe2ac2228..be99d49b8714 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -930,6 +930,9 @@ _bpftool()
                         format)
                             COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
                             ;;
+                        c)
+                            COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
+                            ;;
                         *)
                             # emit extra options
                             case ${words[3]} in
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..af047dedde38 100644
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
@@ -460,9 +467,122 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 	vfprintf(stdout, fmt, args);
 }
 
+static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
+{
+	const struct btf_type *t = btf__type_by_id(btf, index);
+	const int kind = btf_kind(t);
+	const int max_rank = 10;
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
+	case BTF_KIND_ARRAY:
+		if (has_name)
+			return btf_type_rank(btf, btf_array(t)->type, has_name);
+		return max_rank;
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_CONST:
+	case BTF_KIND_PTR:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_DECL_TAG:
+		if (has_name)
+			return btf_type_rank(btf, t->type, has_name);
+		return max_rank;
+	default:
+		return max_rank;
+	}
+}
+
+static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool from_ref)
+{
+	const struct btf_type *t = btf__type_by_id(btf, index);
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64: {
+		int name_off = t->name_off;
+
+		/* Use name of the first element for anonymous enums if allowed */
+		if (!from_ref && !t->name_off && btf_vlen(t))
+			name_off = btf_enum(t)->name_off;
+
+		return btf__name_by_offset(btf, name_off);
+	}
+	case BTF_KIND_ARRAY:
+		return btf_type_sort_name(btf, btf_array(t)->type, true);
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_CONST:
+	case BTF_KIND_PTR:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_DECL_TAG:
+		return btf_type_sort_name(btf, t->type, true);
+	default:
+		return btf__name_by_offset(btf, t->name_off);
+	}
+	return NULL;
+}
+
+static int btf_type_compare(const void *left, const void *right)
+{
+	const struct sort_datum *d1 = (const struct sort_datum *)left;
+	const struct sort_datum *d2 = (const struct sort_datum *)right;
+	int r;
+
+	if (d1->type_rank != d2->type_rank)
+		return d1->type_rank < d2->type_rank ? -1 : 1;
+
+	r = strcmp(d1->sort_name, d2->sort_name);
+	if (r)
+		return r;
+
+	return strcmp(d1->own_name, d2->own_name);
+}
+
+static struct sort_datum *sort_btf_c(const struct btf *btf)
+{
+	struct sort_datum *datums;
+	int n;
+
+	n = btf__type_cnt(btf);
+	datums = malloc(sizeof(struct sort_datum) * n);
+	if (!datums)
+		return NULL;
+
+	for (int i = 0; i < n; ++i) {
+		struct sort_datum *d = datums + i;
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		d->index = i;
+		d->type_rank = btf_type_rank(btf, i, false);
+		d->sort_name = btf_type_sort_name(btf, i, false);
+		d->own_name = btf__name_by_offset(btf, t->name_off);
+	}
+
+	qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
+
+	return datums;
+}
+
 static int dump_btf_c(const struct btf *btf,
-		      __u32 *root_type_ids, int root_type_cnt)
+		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
+	struct sort_datum *datums = NULL;
 	struct btf_dump *d;
 	int err = 0, i;
 
@@ -486,8 +606,12 @@ static int dump_btf_c(const struct btf *btf,
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
@@ -500,6 +624,7 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#endif /* __VMLINUX_H__ */\n");
 
 done:
+	free(datums);
 	btf_dump__free(d);
 	return err;
 }
@@ -549,10 +674,10 @@ static bool btf_is_kernel_module(__u32 btf_id)
 
 static int do_dump(int argc, char **argv)
 {
+	bool dump_c = false, sort_dump_c = true;
 	struct btf *btf = NULL, *base = NULL;
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
-	bool dump_c = false;
 	__u32 btf_id = -1;
 	const char *src;
 	int fd = -1;
@@ -663,6 +788,9 @@ static int do_dump(int argc, char **argv)
 				goto done;
 			}
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "unsorted")) {
+			sort_dump_c = false;
+			NEXT_ARG();
 		} else {
 			p_err("unrecognized option: '%s'", *argv);
 			err = -EINVAL;
@@ -691,7 +819,7 @@ static int do_dump(int argc, char **argv)
 			err = -ENOTSUP;
 			goto done;
 		}
-		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
+		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1063,7 +1191,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-		"       FORMAT  := { raw | c }\n"
+		"       FORMAT  := { raw | c [unsorted] }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-- 
2.44.0


