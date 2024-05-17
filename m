Return-Path: <bpf+bounces-29970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE88C8C8F
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DDB286032
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57513E058;
	Fri, 17 May 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvRPXdeR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3856A005
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972770; cv=none; b=rPje7QYbhr4td815kfrUzo8oCtBknJSfyORwBwejOudTHtf0tLS+hibIqW/b0eHYF3bjjVaFOJdKLquOFk6SUfuLFDmbof/dHrNNcRoWvRRPE9VTs1Jvyi/zBtKOYbe1UHI2vSzoVkWT/oJ4gcwMLBLw2klbnkZLQek3yUy8LhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972770; c=relaxed/simple;
	bh=hDg8uRncuM+2DdOmQDZqVQJvOuV9MpfOZM/VsSe0G00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fw0hjODmOUQhzK/MgAxIoxomhrPaqHPej8HXnQuH3N/+OvANLM+896ZaBOrHqFKYOr1hVM6OEoIL15e9QZLzzYvNNpO6AwEi72NBBboqKvDY04ryBMqvddmZAGd7RxzHjdjKD84+W4xLwnQ8GazZlr53AqIZN6KWh0YMd7EuTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvRPXdeR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f2ecea41deso1460965ad.1
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715972768; x=1716577568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozI7d8wwJtrIshDd63M8LYnf1u/sIwIfUY2uiayDpAA=;
        b=jvRPXdeR9Fc3cj4eRPiBdrBBNtLsxr+vQwpKpyrow9ML7Q4BjZtSfxxAyCjuIrcEhc
         lBzQY+r8b+OSkPQiTzVZ27qAIN/b9DNqr/Rn/Zv5SyveNVpD9v0EsQx9wm2LOL4Pfrsj
         oD2qJuy0t213ZlljqCAdXQJBYWeEAxfa1QwBGDnHCdm3POERN3p8uPO7jMWaBmxqCPbI
         trfGa6K54OI/Z3ZmHlsGMbCJlGiqIUOYhDa/7NnnAFwjXL0AENUO5ZuDTqbsO6xYKGZ0
         NfKmMkg8TAInMJd6g/jZOdE5MrM5S2QnExe5m+w88UKux/1cXPq3pfWMIrrC+l3W+L4F
         mfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715972768; x=1716577568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozI7d8wwJtrIshDd63M8LYnf1u/sIwIfUY2uiayDpAA=;
        b=e0X3jsa0fDDBouboPW3kBAuOPvIpeshfeV7bf4Qcv/XBrOCECOQdQ63ecbVMF9G2i9
         3xGHIMQN0hTyAyXUlT5xrlxtOAsL+2TLYLk5EDtknl8VEnXTF0/7+ByCkWRvgBqbYMQ3
         3R14g9O99zfc/SLBIEVtn+hrOsjxX9NsTLoUEPGbCPCYiEFRMbz9/BufP+2pngmIfq8d
         Z1YiiCCAeOt8s73PrOX6pZQHANCVUsBOBwZNKGajDCt+Zne7H+xmZpoAa3/Qdgjb3alF
         +eMRZsAK+Msz13fGC4IwVCy1JL1aLek7lZT6MN65vAAeNbpZQO+1SzdhuLJdnoTsCpHk
         Y4Tw==
X-Gm-Message-State: AOJu0YwCJS7+djTW8TdI6fyDDvoAXhYkXySkoSIxvMDUYr5W2o3mEFCS
	2FYzAE2ZChUjwWPSyPpXkK8bssRwXuiE9pB9Dyt+KJKrhjScHBZio5IxmA==
X-Google-Smtp-Source: AGHT+IFoouJm/BtC2yHetJ1oxElKlTHgeYbJFCfyZIzvKuUCPdWiefEiLMUsix8BixBJasBcSAiKdw==
X-Received: by 2002:a17:90a:348d:b0:2b4:32ae:4712 with SMTP id 98e67ed59e1d1-2b6cc141d7emr22286658a91.9.1715972768240;
        Fri, 17 May 2024 12:06:08 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b9ddbcf05csm5459747a91.45.2024.05.17.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:06:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit queue and print single type
Date: Fri, 17 May 2024 12:05:53 -0700
Message-Id: <20240517190555.4032078-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517190555.4032078-1-eddyz87@gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
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
index 10532ae9ff14..c3af6bb606a0 100644
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
@@ -733,7 +749,7 @@ static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
  * that doesn't comply to C rules completely), algorithm will try to proceed
  * and produce as much meaningful output as possible.
  */
-static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
+int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd)
 {
 	const struct btf_type *t;
 	__u16 kind;
@@ -746,8 +762,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
 			btf_dump_emit_struct_fwd(d, id, t);
-			btf_dump_printf(d, ";\n\n");
-			break;
+			return 1;
 		case BTF_KIND_TYPEDEF:
 			/*
 			 * for typedef fwd_emitted means typedef definition
@@ -755,29 +770,23 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
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
@@ -787,15 +796,13 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
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


