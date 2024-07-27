Return-Path: <bpf+bounces-35893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C5F93FBBA
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448D61F22F59
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFA18756E;
	Mon, 29 Jul 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XYBFcoMG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B616F0D0
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271571; cv=none; b=VFhav5kOvbh3qRSFb/hW+7V16Z0XUO4qDwcDIWoSwqsSTpTvs3P2rOtFaRg0rxp2l6+mXtqXX2sqxcuuYwsfWxyOS0ugIY62uGWKx8D2jS3++qhOcCK+++Sg3wIkyx7Yv+80WC5+aRyis1ppZ8Viy2JTDFZOPpYWkGmWLeTEsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271571; c=relaxed/simple;
	bh=54U0GOikZ5RAzxgP6rcXIBTwH6OjsP6nIPiaMnC28qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7dple6PqM8OUGqqsIX1SoOZ88LdeC64rxo+61qFN1F8+1AUKOdV1VsWFdLkQV7R9BWCbQ1ljjw6IBDVDkk2scvZFL/NFRNHzMGv/c0ctb0CyxZHPK/djJXrKvaMU3OmiGwjAL0DitD7vE8Z1hSSmZ/d7L8/cLyIQIfD2P8T8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XYBFcoMG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd90c2fc68so23171955ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271569; x=1722876369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7lNL7a7RnaEeEHqOAz4LqfV1YVzFzzZbPZA8bd7aYY=;
        b=XYBFcoMGO9GWA/bT4XFl/gAjnmAifflAAROJlrn1HoH7o0fC3h0G+9FJx/9TkQL4hL
         PQPTSjolFCo4GcTP2e7rj5ZKMyGuQ+/6ApUozIwtfYT76MNYAP8CrXnrcJdLva1+QjpZ
         x70CXXNvfFQ3ZUsT5qLgYrFT1fgAsKkPO+AizIC9iiBUz5GSk8cOSd3sMIMUHzjRBXlK
         07xxgZRFXO7OxmnsNta6Txfzm9QUvxRJmnbv/DhTPbC6hWX7FPmzt12y8qxCsQmYX9nF
         lJX1wd/Tt2nf53/ibZGKpO8tsagH6sH+kjKJiCfeKC4VwHMVByCC3wYeD1+UU02lAnsF
         2EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271569; x=1722876369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7lNL7a7RnaEeEHqOAz4LqfV1YVzFzzZbPZA8bd7aYY=;
        b=gIlclcUkejYWsrsrqXMQJY/PKcs9Z0DstpdJNgZDSG0gQSNnaZGevX5P7Tctm+iRjM
         EA/Gf+1fLegwFjKm7o80lQvW0woA6YOsAmkICQJ+XUR7Ub65njuUIOsjniEQHypdOish
         hYlSKrRTEz/wk7s2WcRBJ0ur6WXV89bZ4KxiOSScmBwoAz6tw+2o3AtHidIwfqf8I2Vq
         E6yv48BwvYFCIZDhqAbHzd2AypjHdKjgNohu8ELR+uCEVDzuf2REbbsoOOTYMt9A5/zq
         DCWVpZXqYwgSFk2hlGXB/nnQQwvF2g6lRkTFwWLULJMT++OWmQxwT3GvdjUyR9jk75f7
         9h9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqocBOMmZ+P8pMgwMDGQ7VsaOmUZ5c2DZIbKcw5SoIioircErCbRR017zU1c+Pz9ybkt3NZFHGH0ujyAF7ojJzi4ig
X-Gm-Message-State: AOJu0YwQzOIlpNcmu6WltIZaFjmtdUeMNi/A90uu4iq21xlhdDHd2JjE
	Idz9kbxdmNTb93dnGfvkpb9AVtRosk69acNKx8F6g2QFk5pT7L3b7NHk9uKBSG8=
X-Google-Smtp-Source: AGHT+IEDDXZa+6QWvwQqyxT5UERM3Q6JtNvwNq68P+XR9aZlgl//Sn9tiEuQaD04eysjXHhWZGRLcQ==
X-Received: by 2002:a17:902:dad0:b0:1fb:389b:1054 with SMTP id d9443c01a7336-1ff048f402cmr68217195ad.52.1722271569445;
        Mon, 29 Jul 2024 09:46:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:09 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:32 -0700
Subject: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=7398;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=54U0GOikZ5RAzxgP6rcXIBTwH6OjsP6nIPiaMnC28qs=;
 b=nRT6hIItDIVb3k4l/iTG0y78l/VSvtYH5Aq77UEkGeYTziNKgW7O3jJ03EqkBdAB64R0OOHKd
 l9oHIi4ae1NBYo/uXJckSHs1YGOa5dwGH17LuqtAABhpgbrJdAnPD63
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.c             |  1 +
 tools/lib/bpf/btf.c             |  1 +
 tools/lib/bpf/btf_dump.c        |  1 +
 tools/lib/bpf/libbpf.c          |  3 +-
 tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
 tools/lib/bpf/linker.c          |  1 +
 tools/lib/bpf/netlink.c         |  1 +
 tools/lib/bpf/ringbuf.c         |  1 +
 9 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/tools/include/tools/opts.h b/tools/include/tools/opts.h
new file mode 100644
index 000000000000..42b4c1a66cad
--- /dev/null
+++ b/tools/include/tools/opts.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+/*
+ * Options helpers.
+ *
+ * Originally in tools/lib/bpf/libbpf_internal.h
+ */
+
+#ifndef __TOOLS_OPTS_H
+#define __TOOLS_OPTS_H
+
+#include <stdint.h>
+#include <stdio.h>
+
+#ifndef offsetofend
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof((((TYPE *)0)->MEMBER)))
+#endif
+
+static inline bool lib_is_mem_zeroed(const char *p, ssize_t len)
+{
+	while (len > 0) {
+		if (*p)
+			return false;
+		p++;
+		len--;
+	}
+	return true;
+}
+
+static inline bool lib_validate_opts(const char *opts,
+					size_t opts_sz, size_t user_sz,
+					const char *type_name)
+{
+	if (user_sz < sizeof(size_t)) {
+		fprintf(stderr, "%s size (%zu) is too small\n", type_name, user_sz);
+		return false;
+	}
+	if (!lib_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {
+		fprintf(stderr, "%s has non-zero extra bytes\n", type_name);
+		return false;
+	}
+	return true;
+}
+
+#define OPTS_VALID(opts, type)						      \
+	(!(opts) || lib_validate_opts((const char *)opts,		      \
+					 offsetofend(struct type,	      \
+						     type##__last_field),     \
+					 (opts)->sz, #type))
+#define OPTS_HAS(opts, field) \
+	((opts) && opts->sz >= offsetofend(typeof(*(opts)), field))
+#define OPTS_GET(opts, field, fallback_value) \
+	(OPTS_HAS(opts, field) ? (opts)->field : fallback_value)
+#define OPTS_SET(opts, field, value)		\
+	do {					\
+		if (OPTS_HAS(opts, field))	\
+			(opts)->field = value;	\
+	} while (0)
+
+#define OPTS_ZEROED(opts, last_nonzero_field)				      \
+({									      \
+	ssize_t __off = offsetofend(typeof(*(opts)), last_nonzero_field);     \
+	!(opts) || lib_is_mem_zeroed((const void *)opts + __off,	      \
+					(opts)->sz - __off);		      \
+})
+
+#endif /* __TOOLS_OPTS_H */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2a4c71501a17..089f0e0be3a2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <limits.h>
 #include <sys/resource.h>
+#include <tools/opts.h>
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..e03974de2f02 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/btf.h>
 #include <gelf.h>
+#include <tools/opts.h>
 #include "btf.h"
 #include "bpf.h"
 #include "libbpf.h"
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 5dbca76b953f..877479228954 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/btf.h>
 #include <linux/kernel.h>
+#include <tools/opts.h>
 #include "btf.h"
 #include "hashmap.h"
 #include "libbpf.h"
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5401f2df463d..97a47a3d4e51 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -43,6 +43,7 @@
 #include <sys/vfs.h>
 #include <sys/utsname.h>
 #include <sys/resource.h>
+#include <tools/opts.h>
 #include <libelf.h>
 #include <gelf.h>
 #include <zlib.h>
@@ -1146,7 +1147,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 		kern_member = find_member_by_name(kern_btf, kern_type, mname);
 		if (!kern_member) {
-			if (!libbpf_is_mem_zeroed(mdata, msize)) {
+			if (!lib_is_mem_zeroed(mdata, msize)) {
 				pr_warn("struct_ops init_kern %s: Cannot find member %s in kernel BTF\n",
 					map->name, mname);
 				return -ENOTSUP;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index a0dcfb82e455..033b852ed9a7 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -283,54 +283,6 @@ void *libbpf_add_mem(void **data, size_t *cap_cnt, size_t elem_sz,
 		     size_t cur_cnt, size_t max_cnt, size_t add_cnt);
 int libbpf_ensure_mem(void **data, size_t *cap_cnt, size_t elem_sz, size_t need_cnt);
 
-static inline bool libbpf_is_mem_zeroed(const char *p, ssize_t len)
-{
-	while (len > 0) {
-		if (*p)
-			return false;
-		p++;
-		len--;
-	}
-	return true;
-}
-
-static inline bool libbpf_validate_opts(const char *opts,
-					size_t opts_sz, size_t user_sz,
-					const char *type_name)
-{
-	if (user_sz < sizeof(size_t)) {
-		pr_warn("%s size (%zu) is too small\n", type_name, user_sz);
-		return false;
-	}
-	if (!libbpf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {
-		pr_warn("%s has non-zero extra bytes\n", type_name);
-		return false;
-	}
-	return true;
-}
-
-#define OPTS_VALID(opts, type)						      \
-	(!(opts) || libbpf_validate_opts((const char *)opts,		      \
-					 offsetofend(struct type,	      \
-						     type##__last_field),     \
-					 (opts)->sz, #type))
-#define OPTS_HAS(opts, field) \
-	((opts) && opts->sz >= offsetofend(typeof(*(opts)), field))
-#define OPTS_GET(opts, field, fallback_value) \
-	(OPTS_HAS(opts, field) ? (opts)->field : fallback_value)
-#define OPTS_SET(opts, field, value)		\
-	do {					\
-		if (OPTS_HAS(opts, field))	\
-			(opts)->field = value;	\
-	} while (0)
-
-#define OPTS_ZEROED(opts, last_nonzero_field)				      \
-({									      \
-	ssize_t __off = offsetofend(typeof(*(opts)), last_nonzero_field);     \
-	!(opts) || libbpf_is_mem_zeroed((const void *)opts + __off,	      \
-					(opts)->sz - __off);		      \
-})
-
 enum kern_feature_id {
 	/* v4.14: kernel support for program & map names. */
 	FEAT_PROG_NAME,
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 0d4be829551b..e6fb12ba396c 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -16,6 +16,7 @@
 #include <elf.h>
 #include <libelf.h>
 #include <fcntl.h>
+#include <tools/opts.h>
 #include "libbpf.h"
 #include "btf.h"
 #include "libbpf_internal.h"
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 68a2def17175..786a4f6dc3ab 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -11,6 +11,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/netdev.h>
 #include <sys/socket.h>
+#include <tools/opts.h>
 #include <errno.h>
 #include <time.h>
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index bfd8dac4c0cc..547781cde26d 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -16,6 +16,7 @@
 #include <asm/barrier.h>
 #include <sys/mman.h>
 #include <sys/epoll.h>
+#include <tools/opts.h>
 #include <time.h>
 
 #include "libbpf.h"

-- 
2.44.0


