Return-Path: <bpf+bounces-39991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7513979E42
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E5CB23683
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0014AD24;
	Mon, 16 Sep 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eys1glCE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9851494C3
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478303; cv=none; b=bYQZMcGcW8OiozK/g1TSamEGNydTl0hWXxgZCTFGphkA2Cj/mBj9V889ueePHrvIzvzN5vcLDNsQ7EfNE3UBxlo9jTjxWeVg8Rone7Xd3H2vfVadEWjQhcIftA4E0bxNVpkVSLRK63MFCqKFcqsynUG6/4Y3his8BYYdvvRibNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478303; c=relaxed/simple;
	bh=K80yxk0AV47JDXGFLo8wruR+a8ZyuuRvgzgspHU/G+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUDDCADdSzovD80G1//9y8dknsw8zb1mfWMZw+Y8/d3HX1R9DP+raUoP+d84LTFp1DXlH1fMKQK/uZ8bDwEugcUqOI9AoTVSwyD2APqREAEqPq7NIV8AF0K0nseji2v7WKB4pknSQ/55zFiLlJsUvx3xt8XlZ2M39aUgQaLJ2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eys1glCE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47abc040so32362755ad.0
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478301; x=1727083101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwdTK5lWXY0gtZJbf5sNwJbD9nyZDZ8gEoQ29EROv9M=;
        b=eys1glCEq2UIBg6X7yv12zyAhMocXhySZ7TVK00sMAAWayCKDfr3TQ9FuZJyg/rBn/
         5C8y3IdvwOGKxEbbT11Y8argpsJVaxn1ztp4U8CvuHvFeI1ncs27Z4/dyj5SUe0KqUGm
         LA6/3vlihBMPWQpggzqsgU8DwnNPSufUgysQ/+aX85VMpjhqinoEym+/ZjF9eEiR14RF
         HGYpefDUFR6RNgCEqqa3nkZfFnB44NXaLvjXQHtEvMKIUc6IkTru4L2GpntBbQjKfThm
         pgERjBnt8eJMdZbLKochJT2BsQpSYz5HncYkaY+tG+H+ZYl3pmTdVq33ec/I0VYn2oD4
         Ci6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478301; x=1727083101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwdTK5lWXY0gtZJbf5sNwJbD9nyZDZ8gEoQ29EROv9M=;
        b=h00Jn3wnyEiWlZleFLPx3lhA1+IR8NZr3xk7/OkjOPRQ796WZ8qGtxNlljlbwgFLQ6
         GjEZvLLyvnEr+9yWe8KeuygkFOqpJHGiVnCNcNmRVdkLgvPMRFQvN0v9aafXYahnfjnD
         rJz4uXdrFAeg9ERrmeqAV+/7nJIKcua06trTe+2Oi9Jzy1VM6nwUXG5iNMM7xyjzoNGK
         dvu0kgw/fMe+Xi14omjonoFbMozNmMJ+/u/BeX+qhWfeAmrLbj5HPseVpg4FG/AgWPzu
         +zyUos43OsCucKsS3ipe7E4NZ3+q29LYaEm81sjKYvTkRO2ivEUeAmS0XwVsihPGa+wJ
         Wu3w==
X-Gm-Message-State: AOJu0YwY7A341XnEj0xRLABt/y8dZI/S7/Dnb7NskJX3KRmxsEX/YSuS
	AE1dN4G5v+pBA6AJyzcCoXFOlCbdm5206l70akW/N0vkZ3wz1hh3KEgibg==
X-Google-Smtp-Source: AGHT+IHTCwta+fra8I1s98kINEFwUjQEJgAs+mJaGsv1CCYCPuvIp/AUBDIkBNU+xwLx81O29yFv8w==
X-Received: by 2002:a17:902:ea0b:b0:206:ae0b:bfb6 with SMTP id d9443c01a7336-2076e412914mr199980555ad.40.1726478300455;
        Mon, 16 Sep 2024 02:18:20 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm32882195ad.38.2024.09.16.02.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:18:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	arnaldo.melo@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 4/4] bpftool:  __bpf_fastcall for kfuncs marked with special decl_tag
Date: Mon, 16 Sep 2024 02:17:12 -0700
Message-ID: <20240916091712.2929279-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916091712.2929279-1-eddyz87@gmail.com>
References: <20240916091712.2929279-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generate __attribute__((bpf_fastcall)) for kfuncs marked with
"bpf_fastcall" decl tag. E.g. for the following BTF:

    $ bpftool btf dump file vmlinux
    ...
    [A] FUNC 'bpf_rdonly_cast' type_id=...
    ...
    [B] DECL_TAG 'bpf_kfunc' type_id=A component_idx=-1
    [C] DECL_TAG 'bpf_fastcall' type_id=A component_idx=-1

Generate the following vmlinux.h:

    #ifndef __VMLINUX_H__
    #define __VMLINUX_H__
    ...
    #ifndef __bpf_fastcall
    #if __has_attribute(bpf_fastcall)
    #define __bpf_fastcall __attribute__((bpf_fastcall))
    #else
    #define __bpf_fastcall
    #endif
    #endif
    ...
    __bpf_fastcall extern void *bpf_rdonly_cast(...) ...;

The "bpf_fastcall" / "bpf_kfunc" tags pair would generated by pahole
when constructing vmlinux BTF.

While at it, sort printed kfuncs by name for better vmlinux.h
stability.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/bpftool/btf.c | 98 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 7d2af1ff3c8d..98810b83e976 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (C) 2019 Facebook */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/err.h>
 #include <stdbool.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <linux/btf.h>
@@ -21,6 +25,7 @@
 #include "main.h"
 
 #define KFUNC_DECL_TAG		"bpf_kfunc"
+#define FASTCALL_DECL_TAG	"bpf_fastcall"
 
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
@@ -464,19 +469,59 @@ static int dump_btf_raw(const struct btf *btf,
 	return 0;
 }
 
+struct ptr_array {
+	__u32 cnt;
+	__u32 cap;
+	const void **elems;
+};
+
+static int ptr_array_push(const void *ptr, struct ptr_array *arr)
+{
+	__u32 new_cap;
+	void *tmp;
+
+	if (arr->cnt == arr->cap) {
+		new_cap = (arr->cap ?: 16) * 2;
+		tmp = realloc(arr->elems, sizeof(*arr->elems) * new_cap);
+		if (!tmp)
+			return -ENOMEM;
+		arr->elems = tmp;
+		arr->cap = new_cap;
+	}
+	arr->elems[arr->cnt++] = ptr;
+	return 0;
+}
+
+static void ptr_array_free(struct ptr_array *arr)
+{
+	free(arr->elems);
+}
+
+static int cmp_kfuncs(const void *pa, const void *pb, void *ctx)
+{
+	struct btf *btf = ctx;
+	const struct btf_type *a = *(void **)pa;
+	const struct btf_type *b = *(void **)pb;
+
+	return strcmp(btf__str_by_offset(btf, a->name_off),
+		      btf__str_by_offset(btf, b->name_off));
+}
+
 static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
 {
 	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);
-	int cnt = btf__type_cnt(btf);
-	int i;
+	__u32 cnt = btf__type_cnt(btf), i, j;
+	struct ptr_array fastcalls = {};
+	struct ptr_array kfuncs = {};
+	int err = 0;
 
 	printf("\n/* BPF kfuncs */\n");
 	printf("#ifndef BPF_NO_KFUNC_PROTOTYPES\n");
 
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
+		const struct btf_type *ft;
 		const char *name;
-		int err;
 
 		if (!btf_is_decl_tag(t))
 			continue;
@@ -484,27 +529,53 @@ static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
 		if (btf_decl_tag(t)->component_idx != -1)
 			continue;
 
-		name = btf__name_by_offset(btf, t->name_off);
-		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
+		ft = btf__type_by_id(btf, t->type);
+		if (!btf_is_func(ft))
 			continue;
 
-		t = btf__type_by_id(btf, t->type);
-		if (!btf_is_func(t))
-			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)) == 0) {
+			err = ptr_array_push(ft, &kfuncs);
+			if (err)
+				goto out;
+		}
+
+		if (strncmp(name, FASTCALL_DECL_TAG, sizeof(FASTCALL_DECL_TAG)) == 0) {
+			err = ptr_array_push(ft, &fastcalls);
+			if (err)
+				goto out;
+		}
+	}
+
+	/* Sort kfuncs by name for improved vmlinux.h stability  */
+	qsort_r(kfuncs.elems, kfuncs.cnt, sizeof(*kfuncs.elems), cmp_kfuncs, (void *)btf);
+	for (i = 0; i < kfuncs.cnt; i++) {
+		const struct btf_type *t = kfuncs.elems[i];
+
+		/* Assume small amount of fastcall kfuncs */
+		for (j = 0; j < fastcalls.cnt; j++) {
+			if (fastcalls.elems[j] == t) {
+				printf("__bpf_fastcall ");
+				break;
+			}
+		}
 
 		printf("extern ");
 
 		opts.field_name = btf__name_by_offset(btf, t->name_off);
 		err = btf_dump__emit_type_decl(d, t->type, &opts);
 		if (err)
-			return err;
+			goto out;
 
 		printf(" __weak __ksym;\n");
 	}
 
 	printf("#endif\n\n");
 
-	return 0;
+out:
+	ptr_array_free(&fastcalls);
+	ptr_array_free(&kfuncs);
+	return err;
 }
 
 static void __printf(2, 0) btf_dump_printf(void *ctx,
@@ -718,6 +789,13 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#ifndef __weak\n");
 	printf("#define __weak __attribute__((weak))\n");
 	printf("#endif\n\n");
+	printf("#ifndef __bpf_fastcall\n");
+	printf("#if __has_attribute(bpf_fastcall)\n");
+	printf("#define __bpf_fastcall __attribute__((bpf_fastcall))\n");
+	printf("#else\n");
+	printf("#define __bpf_fastcall\n");
+	printf("#endif\n");
+	printf("#endif\n\n");
 
 	if (root_type_cnt) {
 		for (i = 0; i < root_type_cnt; i++) {
-- 
2.46.0


