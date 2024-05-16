Return-Path: <bpf+bounces-29878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19D8C7EDE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B46E1C20E97
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64D364AC;
	Thu, 16 May 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij1WLsBf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AD282F4
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900696; cv=none; b=IGsAl1Yi9K9CaNq3+6PvuHpBTeYkkBdrNTmq1yIANcuh8Aw1dohFnFbrrOKrhC5iMCR5/imD7YtVeCZSh04NYlHgwKCo7NrvbeOhgVrIss9i+mxrPFjvXIbeULp/ChX8nKkf9hlPqKAjataLMPyIBlWJs89FIK3vUOpciBKHqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900696; c=relaxed/simple;
	bh=7XsQblwzBR6pkyVFAyddzniNBrO7CHAYLPw6DGKZHzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssxCfKLJjdhD2uTVEf/yGEdl7EQjkkHxYHvrfrfAERCQloXhzwMxzlVi1ZuLSTQMHWJF2NHPrSQd7bXPyzGCDdGg1XOSNrWA1g1QjFhLCZw4V1AGBwkTrwnzY/L6VR/5BkENtTqgoC2OWqoxrz1Auy/rgKTedzT/blDQmAXdN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij1WLsBf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so777483b3a.2
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900694; x=1716505494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaLVSURDEq6lysWVP9IXtwHvCqiDei/ZsKI7fWTZ6GE=;
        b=ij1WLsBfj5SYZWBZZVyH60ct1i+eAKribe5yQtTdakFu5nDIJRwk/AQWWvkgrBz3ho
         Jlo++LoxaVWPQUrU21ULone/AtL5B62DadQOn57M4PROT6mI/qMU8RnzXxWdwJlUIR8I
         S9MMXHQ65R9v93AyYx9gK/HLjhlwiuhnz9ldkfY7M4AxYW5IrXwHxncd8CUjP3HnGU1A
         ARCcQ5SbnCwofA5xznFc1Hxyw1n3EInkqE5Sbe/ScAFI7Ln4TqDymzhyncTQvVzmAyNN
         85c5JrI/u3XvqaDcbqGAptChtM4DPLpeh1AIRxRRCGJVIq+Ld8VXQAV3UWS/ZnxV21XE
         yfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900694; x=1716505494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaLVSURDEq6lysWVP9IXtwHvCqiDei/ZsKI7fWTZ6GE=;
        b=CY42CNRQkcbiScdfYvIHfFGULp74u295jhPNsMOf1lwkBrcvLWufChC0IegaM4DwfZ
         w57E9TIJGLBKmty3p2PPP30QwKWseMRNQwnpHHplVQeZgDn3f59B4yYqWFDJs6IIr4iY
         m2+ZmNY57SbwWFpodKc7HK948zO+8yPHj059ebNI9aeDxSjscKe/SUJyWZugNXUvN6OX
         xSSnfS0vCJlMOc/NNe95LyrywEAFhSH8t0QX+o5I6HzPuLHesyyGGRr/s3HaGfaLJs4q
         cM/pGHRtosQM3Zj1et709jJUaQN7ZcLQMAzslck5LGzxiqjgZsXDL/TGtAngj1kSaNSi
         d6qg==
X-Gm-Message-State: AOJu0Yz8drj4/+qSJDGg/GYZQ3MsfRcxIA4emmwVu37maMvBgvA+oqJ+
	oo9DkGVvQG/+tvdjdh2bB9CInAD9ja/+G/FggOZ61DXvZbpZ8+UaD0lPpw==
X-Google-Smtp-Source: AGHT+IGVYgeKnZpxEhHJSqYkThFqsJGwSPvRyzuEO6+yBgiRMKzYKGRGzGUlg00nV3izDStzkk2dUA==
X-Received: by 2002:a05:6a00:1409:b0:6f3:e9bd:62cb with SMTP id d2e1a72fcca58-6f4e02f5ef5mr25419425b3a.23.1715900693515;
        Thu, 16 May 2024 16:04:53 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67a5ffc54sm3013405b3a.34.2024.05.16.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:04:52 -0700 (PDT)
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
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/3] libbpf: put forward declarations to btf_dump->emit_queue
Date: Thu, 16 May 2024 16:04:41 -0700
Message-Id: <20240516230443.3436233-2-eddyz87@gmail.com>
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

As a preparatory step for introducing public API for BTF topological
ordering / single type printing, this commit removes ordering logic
from btf_dump_emit_type() and moves parts necessary to compute forward
declarations to btf_dump_order_type().

Before this commit the topological ordering of types was effectively
done twice:
- first time in btf_dump_order_type(), which ordered types using only
  "strong" links (one structure embedded in another);
- second time in btf_dump_emit_type() to emit forward declarations.

After this commit:
- btf_dump_emit_type() is responsible only for printing
  declaration / forward declaration of a single type;
- btf_dump->emit_queue now contains pairs of form
  {id, forward declaration flag};
- btf_dump->emit_state is no longer necessary,
  as EMITTED state is effectively replaced by ORDERED state
  in btf_dump->order_state;

Notable changes to btf_dump_order_type() logic:
- no need to return strong / weak result, emit forward declaration to
  the queue for weak links instead;
- track containing type id ('cont_id'), as btf_dump_emit_type() did,
  to avoid unnecessary forward declarations in recursive structs;
- PTRs can no longer be marked ORDERED (see comment in the code);
- incorporate btf_dump_emit_missing_aliases() and
  btf_dump_is_blacklisted() checks from btf_dump_emit_type().

When called for e.g. PTR type pointing to a struct
btf_dump__dump_type() would previously result in an empty emit queue:
btf_dump_order_type() would have reached struct with
'through_ptr' == true, thus not adding it to the queue.
To mimic such behavior this patch adds a type filter to
btf_dump__dump_type(): only STRUCT, UNION, TYPEDEF, ENUM, ENUM64, FWD
types are ordered.

The downside of a single pass algorithm is that for the following
situation old logic would have avoided extra forward declaration:

	struct bar {};

	struct foo {		/* Suppose btf_dump__dump_type(foo) */
	    struct bar *a;	/* is called first.                 */
	    struct bar b;
	};

The btf_dump_order_type() would have ordered 'bar' before 'foo',
btf_dump_emit_type() would have been first called for 'bar' thus
avoiding forward declaration for 'sturct bar' when processing 'foo'.

In contrast, new logic would act as follows:
- when processing foo->a forward declaration for 'bar' would be enqueued;
- when processing foo->b full declaration for 'bar' would be enqueued;

In practice this does not seem to be a big issue, number of forward
declarations in vmlinux.h (for BPF selftests config) compared:
- before this patch: 1223
- after  this patch: 1236

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 328 +++++++++++++++++----------------------
 1 file changed, 145 insertions(+), 183 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 5dbca76b953f..1d0ec57d01a9 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -36,24 +36,16 @@ enum btf_dump_type_order_state {
 	ORDERED,
 };
 
-enum btf_dump_type_emit_state {
-	NOT_EMITTED,
-	EMITTING,
-	EMITTED,
-};
-
 /* per-type auxiliary state */
 struct btf_dump_type_aux_state {
 	/* topological sorting state */
 	enum btf_dump_type_order_state order_state: 2;
-	/* emitting state used to determine the need for forward declaration */
-	enum btf_dump_type_emit_state emit_state: 2;
-	/* whether forward declaration was already emitted */
-	__u8 fwd_emitted: 1;
 	/* whether unique non-duplicate name was already assigned */
 	__u8 name_resolved: 1;
 	/* whether type is referenced from any other type */
 	__u8 referenced: 1;
+	/* whether forward declaration was already ordered */
+	__u8 fwd_ordered: 1;
 };
 
 /* indent string length; one indent string is added for each indent level */
@@ -93,7 +85,10 @@ struct btf_dump {
 	size_t cached_names_cap;
 
 	/* topo-sorted list of dependent type definitions */
-	__u32 *emit_queue;
+	struct {
+		__u32 id:31;
+		__u32 fwd:1;
+	} *emit_queue;
 	int emit_queue_cap;
 	int emit_queue_cnt;
 
@@ -208,7 +203,6 @@ static int btf_dump_resize(struct btf_dump *d)
 	if (d->last_id == 0) {
 		/* VOID is special */
 		d->type_states[0].order_state = ORDERED;
-		d->type_states[0].emit_state = EMITTED;
 	}
 
 	/* eagerly determine referenced types for anon enums */
@@ -255,8 +249,8 @@ void btf_dump__free(struct btf_dump *d)
 	free(d);
 }
 
-static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr);
-static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
+static int btf_dump_order_type(struct btf_dump *d, __u32 id, __u32 cont_id, bool through_ptr);
+static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd);
 
 /*
  * Dump BTF type in a compilable C syntax, including all the necessary
@@ -276,6 +270,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
  */
 int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 {
+	const struct btf_type *t;
 	int err, i;
 
 	if (id >= btf__type_cnt(d->btf))
@@ -286,12 +281,23 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 		return libbpf_err(err);
 
 	d->emit_queue_cnt = 0;
-	err = btf_dump_order_type(d, id, false);
-	if (err < 0)
-		return libbpf_err(err);
+	t = btf_type_by_id(d->btf, id);
+	switch (btf_kind(t)) {
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+	case BTF_KIND_FWD:
+		err = btf_dump_order_type(d, id, id, false);
+		if (err < 0)
+			return libbpf_err(err);
+	default:
+		break;
+	};
 
 	for (i = 0; i < d->emit_queue_cnt; i++)
-		btf_dump_emit_type(d, d->emit_queue[i], 0 /*top-level*/);
+		btf_dump_emit_type(d, d->emit_queue[i].id, d->emit_queue[i].fwd);
 
 	return 0;
 }
@@ -374,9 +380,9 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 	return 0;
 }
 
-static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
+static int __btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id, bool fwd)
 {
-	__u32 *new_queue;
+	typeof(d->emit_queue[0]) *new_queue = NULL;
 	size_t new_cap;
 
 	if (d->emit_queue_cnt >= d->emit_queue_cap) {
@@ -388,10 +394,45 @@ static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
 		d->emit_queue_cap = new_cap;
 	}
 
-	d->emit_queue[d->emit_queue_cnt++] = id;
+	d->emit_queue[d->emit_queue_cnt].id = id;
+	d->emit_queue[d->emit_queue_cnt].fwd = fwd;
+	d->emit_queue_cnt++;
 	return 0;
 }
 
+static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
+{
+	return __btf_dump_add_emit_queue_id(d, id, false);
+}
+
+static int btf_dump_add_emit_queue_fwd(struct btf_dump *d, __u32 id)
+{
+	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
+
+	if (tstate->fwd_ordered)
+		return 0;
+
+	tstate->fwd_ordered = 1;
+	return __btf_dump_add_emit_queue_id(d, id, true);
+}
+
+static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id, bool dry_run);
+
+static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, id);
+
+	/* __builtin_va_list is a compiler built-in, which causes compilation
+	 * errors, when compiling w/ different compiler, then used to compile
+	 * original code (e.g., GCC to compile kernel, Clang to use generated
+	 * C header from BTF). As it is built-in, it should be already defined
+	 * properly internally in compiler.
+	 */
+	if (t->name_off == 0)
+		return false;
+	return strcmp(btf_name_of(d, t->name_off), "__builtin_va_list") == 0;
+}
+
 /*
  * Determine order of emitting dependent types and specified type to satisfy
  * C compilation rules.  This is done through topological sorting with an
@@ -441,32 +482,33 @@ static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
  * The rule is as follows. Given a chain of BTF types from X to Y, if there is
  * BTF_KIND_PTR type in the chain and at least one non-anonymous type
  * Z (excluding X, including Y), then link is weak. Otherwise, it's strong.
- * Weak/strong relationship is determined recursively during DFS traversal and
- * is returned as a result from btf_dump_order_type().
+ * Weak/strong relationship is determined recursively during DFS traversal.
+ *
+ * When type id is reached via a weak link a forward declaration for
+ * that type is added to the emit queue, otherwise "full" declaration
+ * is added to the emit queue.
+ *
+ * We also keep track of "containing struct/union type ID" to determine when
+ * we reference it from inside and thus can avoid emitting unnecessary forward
+ * declaration.
  *
  * btf_dump_order_type() is trying to avoid unnecessary forward declarations,
  * but it is not guaranteeing that no extraneous forward declarations will be
  * emitted.
  *
  * To avoid extra work, algorithm marks some of BTF types as ORDERED, when
- * it's done with them, but not for all (e.g., VOLATILE, CONST, RESTRICT,
+ * it's done with them, but not for all (e.g., PTR, VOLATILE, CONST, RESTRICT,
  * ARRAY, FUNC_PROTO), as weak/strong semantics for those depends on the
  * entire graph path, so depending where from one came to that BTF type, it
  * might cause weak or strong ordering. For types like STRUCT/UNION/INT/ENUM,
  * once they are processed, there is no need to do it again, so they are
- * marked as ORDERED. We can mark PTR as ORDERED as well, as it semi-forces
- * weak link, unless subsequent referenced STRUCT/UNION/ENUM is anonymous. But
- * in any case, once those are processed, no need to do it again, as the
- * result won't change.
+ * marked as ORDERED.
  *
  * Returns:
- *   - 1, if type is part of strong link (so there is strong topological
- *   ordering requirements);
- *   - 0, if type is part of weak link (so can be satisfied through forward
- *   declaration);
+ *   - 0, on success;
  *   - <0, on error (e.g., unsatisfiable type loop detected).
  */
-static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
+static int btf_dump_order_type(struct btf_dump *d, __u32 id, __u32 cont_id, bool through_ptr)
 {
 	/*
 	 * Order state is used to detect strong link cycles, but only for BTF
@@ -486,48 +528,78 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 
 	/* return true, letting typedefs know that it's ok to be emitted */
 	if (tstate->order_state == ORDERED)
-		return 1;
+		return 0;
 
 	t = btf__type_by_id(d->btf, id);
 
 	if (tstate->order_state == ORDERING) {
 		/* type loop, but resolvable through fwd declaration */
-		if (btf_is_composite(t) && through_ptr && t->name_off != 0)
-			return 0;
+		if (btf_is_composite(t) && through_ptr && t->name_off != 0) {
+			if (id != cont_id)
+				return btf_dump_add_emit_queue_fwd(d, id);
+			else
+				return 0;
+		}
 		pr_warn("unsatisfiable type cycle, id:[%u]\n", id);
 		return -ELOOP;
 	}
 
 	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
+		tstate->order_state = ORDERED;
+		if (btf_dump_emit_missing_aliases(d, id, true))
+			return btf_dump_add_emit_queue_id(d, id);
+		else
+			return 0;
 	case BTF_KIND_FLOAT:
 		tstate->order_state = ORDERED;
 		return 0;
 
 	case BTF_KIND_PTR:
-		err = btf_dump_order_type(d, t->type, true);
-		tstate->order_state = ORDERED;
+		/* Depending on whether pointer is a part of a recursive struct
+		 * declaration, it might not necessitate generation of a forward
+		 * declaration for the target type, e.g.:
+		 *
+		 * struct foo {
+		 *	struct foo *p; // no need for forward declaration
+		 * }
+		 *
+		 * struct bar {
+		 *	struct foo *p; // forward declaration is needed
+		 * }
+		 *
+		 * Hence, don't mark pointer as ORDERED, to allow traversal
+		 * to the target type and comparison with 'cont_id'.
+		 */
+		err = btf_dump_order_type(d, t->type, cont_id, true);
 		return err;
 
 	case BTF_KIND_ARRAY:
-		return btf_dump_order_type(d, btf_array(t)->type, false);
+		return btf_dump_order_type(d, btf_array(t)->type, cont_id, false);
 
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *m = btf_members(t);
+		__u32 new_cont_id;
+
 		/*
 		 * struct/union is part of strong link, only if it's embedded
 		 * (so no ptr in a path) or it's anonymous (so has to be
 		 * defined inline, even if declared through ptr)
 		 */
-		if (through_ptr && t->name_off != 0)
-			return 0;
+		if (through_ptr && t->name_off != 0) {
+			if (id != cont_id)
+				return btf_dump_add_emit_queue_fwd(d, id);
+			else
+				return 0;
+		}
 
 		tstate->order_state = ORDERING;
 
+		new_cont_id = t->name_off == 0 ? cont_id : id;
 		vlen = btf_vlen(t);
 		for (i = 0; i < vlen; i++, m++) {
-			err = btf_dump_order_type(d, m->type, false);
+			err = btf_dump_order_type(d, m->type, new_cont_id, false);
 			if (err < 0)
 				return err;
 		}
@@ -539,7 +611,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 		}
 
 		tstate->order_state = ORDERED;
-		return 1;
+		return 0;
 	}
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
@@ -555,51 +627,44 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 				return err;
 		}
 		tstate->order_state = ORDERED;
-		return 1;
+		return 0;
 
 	case BTF_KIND_TYPEDEF: {
-		int is_strong;
-
-		is_strong = btf_dump_order_type(d, t->type, through_ptr);
-		if (is_strong < 0)
-			return is_strong;
-
-		/* typedef is similar to struct/union w.r.t. fwd-decls */
-		if (through_ptr && !is_strong)
+		if (btf_dump_is_blacklisted(d, id))
 			return 0;
 
+		err = btf_dump_order_type(d, t->type, t->type, through_ptr);
+		if (err < 0)
+			return err;
+
 		/* typedef is always a named definition */
 		err = btf_dump_add_emit_queue_id(d, id);
 		if (err)
 			return err;
 
 		d->type_states[id].order_state = ORDERED;
-		return 1;
+		return 0;
 	}
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_TYPE_TAG:
-		return btf_dump_order_type(d, t->type, through_ptr);
+		return btf_dump_order_type(d, t->type, cont_id, through_ptr);
 
 	case BTF_KIND_FUNC_PROTO: {
 		const struct btf_param *p = btf_params(t);
-		bool is_strong;
 
-		err = btf_dump_order_type(d, t->type, through_ptr);
+		err = btf_dump_order_type(d, t->type, cont_id, through_ptr);
 		if (err < 0)
 			return err;
-		is_strong = err > 0;
 
 		vlen = btf_vlen(t);
 		for (i = 0; i < vlen; i++, p++) {
-			err = btf_dump_order_type(d, p->type, through_ptr);
+			err = btf_dump_order_type(d, p->type, cont_id, through_ptr);
 			if (err < 0)
 				return err;
-			if (err > 0)
-				is_strong = true;
 		}
-		return is_strong;
+		return err;
 	}
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
@@ -613,9 +678,6 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 	}
 }
 
-static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
-					  const struct btf_type *t);
-
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t);
 static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
@@ -649,73 +711,33 @@ static const char *btf_dump_ident_name(struct btf_dump *d, __u32 id);
 static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
 				 const char *orig_name);
 
-static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
-{
-	const struct btf_type *t = btf__type_by_id(d->btf, id);
-
-	/* __builtin_va_list is a compiler built-in, which causes compilation
-	 * errors, when compiling w/ different compiler, then used to compile
-	 * original code (e.g., GCC to compile kernel, Clang to use generated
-	 * C header from BTF). As it is built-in, it should be already defined
-	 * properly internally in compiler.
-	 */
-	if (t->name_off == 0)
-		return false;
-	return strcmp(btf_name_of(d, t->name_off), "__builtin_va_list") == 0;
-}
-
 /*
  * Emit C-syntax definitions of types from chains of BTF types.
  *
- * High-level handling of determining necessary forward declarations are handled
- * by btf_dump_emit_type() itself, but all nitty-gritty details of emitting type
+ * All nitty-gritty details of emitting type
  * declarations/definitions in C syntax  are handled by a combo of
  * btf_dump_emit_type_decl()/btf_dump_emit_type_chain() w/ delegation to
  * corresponding btf_dump_emit_*_{def,fwd}() functions.
  *
- * We also keep track of "containing struct/union type ID" to determine when
- * we reference it from inside and thus can avoid emitting unnecessary forward
- * declaration.
- *
  * This algorithm is designed in such a way, that even if some error occurs
  * (either technical, e.g., out of memory, or logical, i.e., malformed BTF
  * that doesn't comply to C rules completely), algorithm will try to proceed
  * and produce as much meaningful output as possible.
  */
-static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
+static void btf_dump_emit_type(struct btf_dump *d, __u32 id, bool fwd)
 {
-	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
-	bool top_level_def = cont_id == 0;
 	const struct btf_type *t;
 	__u16 kind;
 
-	if (tstate->emit_state == EMITTED)
-		return;
-
 	t = btf__type_by_id(d->btf, id);
 	kind = btf_kind(t);
 
-	if (tstate->emit_state == EMITTING) {
-		if (tstate->fwd_emitted)
-			return;
-
+	if (fwd) {
 		switch (kind) {
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
-			/*
-			 * if we are referencing a struct/union that we are
-			 * part of - then no need for fwd declaration
-			 */
-			if (id == cont_id)
-				return;
-			if (t->name_off == 0) {
-				pr_warn("anonymous struct/union loop, id:[%u]\n",
-					id);
-				return;
-			}
 			btf_dump_emit_struct_fwd(d, id, t);
 			btf_dump_printf(d, ";\n\n");
-			tstate->fwd_emitted = 1;
 			break;
 		case BTF_KIND_TYPEDEF:
 			/*
@@ -723,11 +745,8 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 			 * was emitted, but it can be used only for "weak"
 			 * references through pointer only, not for embedding
 			 */
-			if (!btf_dump_is_blacklisted(d, id)) {
-				btf_dump_emit_typedef_def(d, id, t, 0);
-				btf_dump_printf(d, ";\n\n");
-			}
-			tstate->fwd_emitted = 1;
+			btf_dump_emit_typedef_def(d, id, t, 0);
+			btf_dump_printf(d, ";\n\n");
 			break;
 		default:
 			break;
@@ -739,36 +758,18 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 	switch (kind) {
 	case BTF_KIND_INT:
 		/* Emit type alias definitions if necessary */
-		btf_dump_emit_missing_aliases(d, id, t);
-
-		tstate->emit_state = EMITTED;
+		btf_dump_emit_missing_aliases(d, id, false);
 		break;
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
-		if (top_level_def) {
-			btf_dump_emit_enum_def(d, id, t, 0);
-			btf_dump_printf(d, ";\n\n");
-		}
-		tstate->emit_state = EMITTED;
-		break;
-	case BTF_KIND_PTR:
-	case BTF_KIND_VOLATILE:
-	case BTF_KIND_CONST:
-	case BTF_KIND_RESTRICT:
-	case BTF_KIND_TYPE_TAG:
-		btf_dump_emit_type(d, t->type, cont_id);
-		break;
-	case BTF_KIND_ARRAY:
-		btf_dump_emit_type(d, btf_array(t)->type, cont_id);
+		btf_dump_emit_enum_def(d, id, t, 0);
+		btf_dump_printf(d, ";\n\n");
 		break;
 	case BTF_KIND_FWD:
 		btf_dump_emit_fwd_def(d, id, t);
 		btf_dump_printf(d, ";\n\n");
-		tstate->emit_state = EMITTED;
 		break;
 	case BTF_KIND_TYPEDEF:
-		tstate->emit_state = EMITTING;
-		btf_dump_emit_type(d, t->type, id);
 		/*
 		 * typedef can server as both definition and forward
 		 * declaration; at this stage someone depends on
@@ -776,55 +777,14 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		 * through pointer), so unless we already did it,
 		 * emit typedef as a forward declaration
 		 */
-		if (!tstate->fwd_emitted && !btf_dump_is_blacklisted(d, id)) {
-			btf_dump_emit_typedef_def(d, id, t, 0);
-			btf_dump_printf(d, ";\n\n");
-		}
-		tstate->emit_state = EMITTED;
+		btf_dump_emit_typedef_def(d, id, t, 0);
+		btf_dump_printf(d, ";\n\n");
 		break;
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
-		tstate->emit_state = EMITTING;
-		/* if it's a top-level struct/union definition or struct/union
-		 * is anonymous, then in C we'll be emitting all fields and
-		 * their types (as opposed to just `struct X`), so we need to
-		 * make sure that all types, referenced from struct/union
-		 * members have necessary forward-declarations, where
-		 * applicable
-		 */
-		if (top_level_def || t->name_off == 0) {
-			const struct btf_member *m = btf_members(t);
-			__u16 vlen = btf_vlen(t);
-			int i, new_cont_id;
-
-			new_cont_id = t->name_off == 0 ? cont_id : id;
-			for (i = 0; i < vlen; i++, m++)
-				btf_dump_emit_type(d, m->type, new_cont_id);
-		} else if (!tstate->fwd_emitted && id != cont_id) {
-			btf_dump_emit_struct_fwd(d, id, t);
-			btf_dump_printf(d, ";\n\n");
-			tstate->fwd_emitted = 1;
-		}
-
-		if (top_level_def) {
-			btf_dump_emit_struct_def(d, id, t, 0);
-			btf_dump_printf(d, ";\n\n");
-			tstate->emit_state = EMITTED;
-		} else {
-			tstate->emit_state = NOT_EMITTED;
-		}
-		break;
-	case BTF_KIND_FUNC_PROTO: {
-		const struct btf_param *p = btf_params(t);
-		__u16 n = btf_vlen(t);
-		int i;
-
-		btf_dump_emit_type(d, t->type, cont_id);
-		for (i = 0; i < n; i++, p++)
-			btf_dump_emit_type(d, p->type, cont_id);
-
+		btf_dump_emit_struct_def(d, id, t, 0);
+		btf_dump_printf(d, ";\n\n");
 		break;
-	}
 	default:
 		break;
 	}
@@ -1037,19 +997,21 @@ static const char *missing_base_types[][2] = {
 	{ "__Poly128_t",	"unsigned __int128" },
 };
 
-static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
-					  const struct btf_type *t)
+static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id, bool dry_run)
 {
 	const char *name = btf_dump_type_name(d, id);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(missing_base_types); i++) {
-		if (strcmp(name, missing_base_types[i][0]) == 0) {
+		if (strcmp(name, missing_base_types[i][0]) != 0)
+			continue;
+		if (!dry_run)
 			btf_dump_printf(d, "typedef %s %s;\n\n",
 					missing_base_types[i][1], name);
-			break;
-		}
+		return true;
 	}
+
+	return false;
 }
 
 static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
-- 
2.34.1


