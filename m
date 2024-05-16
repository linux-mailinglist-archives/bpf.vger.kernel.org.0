Return-Path: <bpf+bounces-29879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D448C7EDF
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0AF1F22483
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8B2CCD0;
	Thu, 16 May 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUQ2+DvZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC41F19A
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900697; cv=none; b=auWYN4uYZGTvW46R1gLX7KZ9yPs+izU91HhVIBxKDlBFWJtTpiJg8aa4LXJQGbGscG26t+KWBLrWhiToqjc50J/0iy0376OaIWOqJdEawnZNl3F4bN2GioOYlc8eswRKXobK7thMyaNXve+LlimBfsPDWk0pOHxFHRd1/HwUlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900697; c=relaxed/simple;
	bh=+sBjI6nBe6cs5Lcub01vksQ/AGHiSIq4TO4zXZZAKEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNy4jYXy9cwha6L7qg9jorupLPuWv1OGWGyE0JmpQAXXDHpRtrUf76KQ/BL9yAR40XqS4GZrjaGSLvPTxKmXXpRgrF59lhy2EN3seJhg69db30czqSYok9hnElexG4b9+2Q7VWnM7OdeYmZG9Vea8HPM5zQp0/NH2WUT9PUO1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUQ2+DvZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso697405b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900695; x=1716505495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArA+Dj3tdMPcKT7j0RX7HW96yN7AjV3KIvOEAVeP/AQ=;
        b=GUQ2+DvZFgk3wDra+uMomVODk4AgJIo/3zYN3ZXCrcKQsPCRCEn4o3blY0+V9L3y0/
         DGLXXQAlz00e6eV7q68KTTclleechQrVsHxA9fC093tEtRak52BUzpOmu8F9aQ4vFYkn
         UDkEsZqFiDeuZtaQ6cUsB8TDqiqckuNYy6Up5IQCx3wMZJA2yQ/A0qkOpbKGAYdPxwpd
         6QLnxcssBvi555JD/nU3bjb2gIiWioOY5BBZ9T58/Bub9I/v8pOWUGYEtC/g8lA1wCsg
         nW/4OE3aJYBXH18yilCddZ7KqI6Swdak++gQHDLaAz9Z5dWPNZo2C/rPuHVLAI7uA7m4
         1gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900695; x=1716505495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArA+Dj3tdMPcKT7j0RX7HW96yN7AjV3KIvOEAVeP/AQ=;
        b=mgUjiAzXMBjbT3OzPSkPxgrGbSJy45NT3cCwHgWrFyMrKexdDyFoZuwiTGInj/+m+Z
         nm/JFLvrqR/b5ca1HmXzdVO8cauGg8Lj4HD4mcjm9+4/6CXPF88ZqDfyE9GRosZ1PMYy
         CUYHcBmCOtJLypZpVoJlmiPHSloTUmXlKU5mHTEdzXkMSMu0zyucf2OJxLHNWIBFykF+
         mBQ81pVjcH/KJqli2lbJ4TbtJvMpQe/Kw3UxAMj7LGqIQQ3XsCQMTc6Q5fTI+C5YdE4N
         WZFa+RFLemtc1sGdcpEDZM5kNNJCYUX3N6sVwI//TYQHZf5ENXYpEH7eP99W52RUc+BU
         zYCg==
X-Gm-Message-State: AOJu0Yy7Mnzc6tOn/Sca/ZB0VA/ux9yD/igLd1E7RtZ4OR3Jl5vcJg23
	AnemoixuGONkIVrIzZZZYs8u98HM9XwP95RFYXxyAnUZfTzBoA+ORP7iNQ==
X-Google-Smtp-Source: AGHT+IFdbSst7WkFspMIr4LIMZk5N6AniqdMAKC2SLz5NLiUHZTH/65Eg4oTmUxO7UPGgmkMMVo3sw==
X-Received: by 2002:a05:6a21:c95:b0:1a7:94ea:a9b4 with SMTP id adf61e73a8af0-1afde10f2d0mr20963710637.32.1715900694476;
        Thu, 16 May 2024 16:04:54 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67a5ffc54sm3013405b3a.34.2024.05.16.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:04:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 2/3] libbpf: API to access btf_dump emit queue and print single type
Date: Thu, 16 May 2024 16:04:42 -0700
Message-Id: <20240516230443.3436233-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516230443.3436233-1-eddyz87@gmail.com>
References: <20240516230443.3436233-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several API functions to allow more flexibility with btf dump:
- int btf_dump__order_type(struct btf_dump *d, __u32 id);
  adds a type and all it's dependencies to the emit queue
  in topological order;
- struct btf_dump_emit_queue_item *btf_dump__emit_queue(struct btf_dump *d);
  __u32 btf_dump__emit_queue_cnt(struct btf_dump *d);
  provide access to the emit queue owned by btf_dump object;
- int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd);
  prints a given type in C format (skipping any dependencies).

This API should allow to do the following on the libbpf client side:
- filter printed types using arbitrary criteria;
- add arbitrary type attributes or pre-processor statements for
  selected types.

This is a follow-up to the following discussion:
https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.h      | 33 ++++++++++++++++++++++
 tools/lib/bpf/btf_dump.c | 61 ++++++++++++++++++++++------------------
 tools/lib/bpf/libbpf.map |  4 +++
 3 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..81d70ac35562 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -249,6 +249,39 @@ LIBBPF_API void btf_dump__free(struct btf_dump *d);
 
 LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
 
+/* Dumps C language definition or forward declaration for type **id**:
+ * - returns 1 if type is printable;
+ * - returns 0 if type is non-printable.
+ */
+LIBBPF_API int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd);
+
+/* **struct btf_dump** tracks a list of types that should be dumped,
+ * these types are sorted in the topological order satisfying C language semantics:
+ * - if type A includes type B (e.g. A is a struct with a field of type B),
+ *   then B comes before A;
+ * - if type A references type B via a pointer
+ *   (e.g. A is a struct with a field of type pointer to B),
+ *   then B's forward declaration comes before A.
+ *
+ * **struct btf_dump_emit_queue_item** represents a single entry of the emit queue.
+ */
+struct btf_dump_emit_queue_item {
+	__u32 id:31;
+	__u32 fwd:1;
+};
+
+/* Adds type **id** and it's dependencies to the emit queue. */
+LIBBPF_API int btf_dump__order_type(struct btf_dump *d, __u32 id);
+
+/* Provides access to currently accumulated emit queue,
+ * returned pointer is owned by **struct btf_dump** and should not be
+ * freed explicitly.
+ */
+LIBBPF_API struct btf_dump_emit_queue_item *btf_dump__emit_queue(struct btf_dump *d);
+
+/* Returns the size of currently accumulated emit queue */
+LIBBPF_API __u32 btf_dump__emit_queue_cnt(struct btf_dump *d);
+
 struct btf_dump_emit_type_decl_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 1d0ec57d01a9..cb233f891582 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -85,10 +85,7 @@ struct btf_dump {
 	size_t cached_names_cap;
 
 	/* topo-sorted list of dependent type definitions */
-	struct {
-		__u32 id:31;
-		__u32 fwd:1;
-	} *emit_queue;
+	struct btf_dump_emit_queue_item *emit_queue;
 	int emit_queue_cap;
 	int emit_queue_cnt;
 
@@ -250,7 +247,6 @@ void btf_dump__free(struct btf_dump *d)
 }
 
 static int btf_dump_order_type(struct btf_dump *d, __u32 id, __u32 cont_id, bool through_ptr);
-static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd);
 
 /*
  * Dump BTF type in a compilable C syntax, including all the necessary
@@ -296,12 +292,32 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 		break;
 	};
 
-	for (i = 0; i < d->emit_queue_cnt; i++)
-		btf_dump_emit_type(d, d->emit_queue[i].id, d->emit_queue[i].fwd);
+	for (i = 0; i < d->emit_queue_cnt; i++) {
+		err = btf_dump__dump_one_type(d, d->emit_queue[i].id, d->emit_queue[i].fwd);
+		if (err < 0)
+			return libbpf_err(err);
+		if (err > 0)
+			btf_dump_printf(d, ";\n\n");
+	}
 
 	return 0;
 }
 
+int btf_dump__order_type(struct btf_dump *d, __u32 id)
+{
+	return btf_dump_order_type(d, id, id, false);
+}
+
+struct btf_dump_emit_queue_item *btf_dump__emit_queue(struct btf_dump *d)
+{
+	return d->emit_queue;
+}
+
+__u32 btf_dump__emit_queue_cnt(struct btf_dump *d)
+{
+	return d->emit_queue_cnt;
+}
+
 /*
  * Mark all types that are referenced from any other type. This is used to
  * determine top-level anonymous enums that need to be emitted as an
@@ -382,7 +398,7 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 
 static int __btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id, bool fwd)
 {
-	typeof(d->emit_queue[0]) *new_queue = NULL;
+	struct btf_dump_emit_queue_item *new_queue = NULL;
 	size_t new_cap;
 
 	if (d->emit_queue_cnt >= d->emit_queue_cap) {
@@ -724,7 +740,7 @@ static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
  * that doesn't comply to C rules completely), algorithm will try to proceed
  * and produce as much meaningful output as possible.
  */
-static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
+int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd)
 {
 	const struct btf_type *t;
 	__u16 kind;
@@ -737,8 +753,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
 			btf_dump_emit_struct_fwd(d, id, t);
-			btf_dump_printf(d, ";\n\n");
-			break;
+			return 1;
 		case BTF_KIND_TYPEDEF:
 			/*
 			 * for typedef fwd_emitted means typedef definition
@@ -746,29 +761,23 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
 			 * references through pointer only, not for embedding
 			 */
 			btf_dump_emit_typedef_def(d, id, t, 0);
-			btf_dump_printf(d, ";\n\n");
-			break;
+			return 1;
 		default:
-			break;
+			return 0;
 		}
-
-		return;
 	}
 
 	switch (kind) {
 	case BTF_KIND_INT:
 		/* Emit type alias definitions if necessary */
-		btf_dump_emit_missing_aliases(d, id, false);
-		break;
+		return btf_dump_emit_missing_aliases(d, id, false);
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
 		btf_dump_emit_enum_def(d, id, t, 0);
-		btf_dump_printf(d, ";\n\n");
-		break;
+		return 1;
 	case BTF_KIND_FWD:
 		btf_dump_emit_fwd_def(d, id, t);
-		btf_dump_printf(d, ";\n\n");
-		break;
+		return 1;
 	case BTF_KIND_TYPEDEF:
 		/*
 		 * typedef can server as both definition and forward
@@ -778,15 +787,13 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
 		 * emit typedef as a forward declaration
 		 */
 		btf_dump_emit_typedef_def(d, id, t, 0);
-		btf_dump_printf(d, ";\n\n");
-		break;
+		return 1;
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 		btf_dump_emit_struct_def(d, id, t, 0);
-		btf_dump_printf(d, ";\n\n");
-		break;
+		return 1;
 	default:
-		break;
+		return 0;
 	}
 }
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c1ce8aa3520b..137e4cbaa7a7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -422,4 +422,8 @@ LIBBPF_1.5.0 {
 		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
+		btf_dump__emit_queue;
+		btf_dump__emit_queue_cnt;
+		btf_dump__order_type;
+		btf_dump__dump_one_type;
 } LIBBPF_1.4.0;
-- 
2.34.1


