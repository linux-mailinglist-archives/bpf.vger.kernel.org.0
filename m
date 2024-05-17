Return-Path: <bpf+bounces-29969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56438C8C8E
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CFD1F281DF
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F313E3FE;
	Fri, 17 May 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgXBz/sT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9313E058
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972770; cv=none; b=uZSzMs7kJzctY6dQxVHwWC0+AIPyhaplYHxTEuEMYSh4sDLkd44A6dt3yvc+0+M+qvrePgrlqQOcNB3gG28nUrTKgdzQC/1HeeTYuYqjdeMj+XR26ZRVyFZxkIctSvOVWKAMpFpvUcOfZhEgYSvxcXSIqeu8o0/hRiH3i8Tmj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972770; c=relaxed/simple;
	bh=SjTjv8qA/NC8e8exkpdLAO5LcqGblPiHgvV2yQrS0uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZUg5J0fZgQeJElZ/plHDH1HmgXEXuI7RX+Xe/otZ/VuX8JnnFl9Imon2o9IHZ1nc9R1E7PRBTPTkDz4OFRioD+fu1k+fcDV+KGCW21ed5RFD1ct8KT1DKnf21JZV+m+wKGOyudiakC/m43idp8dG5fRzRM4ml1lvGWUuX2cY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgXBz/sT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec92e355bfso19900385ad.3
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715972767; x=1716577567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6Fxrb/2/88WVf9ERm3nTOgjhdEBZvp0au6T7fTa2N0=;
        b=FgXBz/sT1p1Gs6hyxwqzrJhi3T1fNlmDX2nfo5nEHrrq5zvoxh0nva9AuQdF0Q6Cbb
         hX7iXMxScI3Br+Hr40KUZANsp4RdhFFd1Om/edgcMskbObMNtBlBKHqfEWV1C11lKZJ3
         f/A/87nQn6n4R0DFSSc5ilaT6grG9Gl4jQ1gJajO6bkuJpErhRMEwJaMYXP0s7G4RkU5
         iym/E/G2SxD5EEBlwXLwixS0KKOZWlYoUXBCSg/gOFYhgRLTnP/77PvJgS26ipchRxEv
         BcAYFcM8/6jYjj9ntnVO6yE2GA41YL9cl4FxqMsVJj6jgq/rZysN18KRCRlr5pcKLQcf
         rOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715972767; x=1716577567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Fxrb/2/88WVf9ERm3nTOgjhdEBZvp0au6T7fTa2N0=;
        b=fOnWTPgXayhjrwCSR3os3CD7/mjuMF4ZNWmn4uAjyfDabmP4k/PNHY1K53FUKg6NTn
         CdP35O0lszKA/ewqojQ7uDcVdy4If3NfEdqgfdBbHgL6nOwKXL86o7Jg7jG+WFZoHoEz
         2YkVw0Mq0ybkYigdscecRrPsnVh8hkXT9ty5Kk0rcEnL8Laix5LJmU+r8GXeQ1+hJxjm
         E9U6Ktgrv7ZroDkv/T2Rve1p+d4qh0ePVHzlezMFEsmt0NUiesLb2yM4ougozbnxWLOt
         kHGf8mD4t60apHDUYDw4lM76lXIwQpUsi9YEUiDyjeCcVErb5plK2Sv+PgS8jlB9kzoQ
         0v+g==
X-Gm-Message-State: AOJu0YxJvdCH1sNdfApXdyieLrlb0ium0csWdOVfCOrP7JghOu9UFOjw
	f47zuvB8j8FC/Q5ZYWbahFP/xoI+udeoMMpK/9LZ1Ys1BTeG6VnCBfC7iA==
X-Google-Smtp-Source: AGHT+IHGk7NXWWrDSShWrP5XtKBto39jqlo57ii6ZtLam1vIKn9DMPu5Q1laMCf758OBKNnT+splOg==
X-Received: by 2002:a17:90b:d0b:b0:2a2:c16:d673 with SMTP id 98e67ed59e1d1-2b6ccc73005mr21319428a91.36.1715972767000;
        Fri, 17 May 2024 12:06:07 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b9ddbcf05csm5459747a91.45.2024.05.17.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:06:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/4] libbpf: put forward declarations to btf_dump->emit_queue
Date: Fri, 17 May 2024 12:05:52 -0700
Message-Id: <20240517190555.4032078-2-eddyz87@gmail.com>
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
                     llvm  gcc
- before this patch: 1772  1235
- after  this patch: 1786  1249

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 351 ++++++++++++++++++---------------------
 1 file changed, 161 insertions(+), 190 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 5dbca76b953f..10532ae9ff14 100644
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
- * ARRAY, FUNC_PROTO), as weak/strong semantics for those depends on the
+ * it's done with them, but not for all (e.g., PTR, VOLATILE, CONST, RESTRICT,
+ * ARRAY, FUNC_PROTO, TYPEDEF), as weak/strong semantics for those depends on the
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
@@ -555,51 +627,53 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 				return err;
 		}
 		tstate->order_state = ORDERED;
-		return 1;
-
-	case BTF_KIND_TYPEDEF: {
-		int is_strong;
-
-		is_strong = btf_dump_order_type(d, t->type, through_ptr);
-		if (is_strong < 0)
-			return is_strong;
+		return 0;
 
-		/* typedef is similar to struct/union w.r.t. fwd-decls */
-		if (through_ptr && !is_strong)
+	case BTF_KIND_TYPEDEF:
+		/* Do not mark typedef as ORDERED, always emit a forward declaration for
+		 * it instead. Otherwise the following situation would be troublesome:
+		 *
+		 *   typedef struct foo foo_alias;
+		 *
+		 *   struct foo {};
+		 *
+		 *   struct root {
+		 *      foo_alias *a;
+		 *      foo_alias b;
+		 *   };
+		 *
+		 */
+		if (btf_dump_is_blacklisted(d, id))
 			return 0;
 
-		/* typedef is always a named definition */
-		err = btf_dump_add_emit_queue_id(d, id);
-		if (err)
+		err = btf_dump_order_type(d, t->type, t->type, through_ptr);
+		if (err < 0)
 			return err;
 
-		d->type_states[id].order_state = ORDERED;
-		return 1;
-	}
+		err = btf_dump_add_emit_queue_fwd(d, id);
+		if (err)
+			return err;
+		return 0;
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
@@ -613,9 +687,6 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 	}
 }
 
-static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
-					  const struct btf_type *t);
-
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t);
 static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
@@ -649,73 +720,33 @@ static const char *btf_dump_ident_name(struct btf_dump *d, __u32 id);
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
@@ -723,11 +754,8 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
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
@@ -739,36 +767,18 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
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
@@ -776,55 +786,14 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
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
@@ -1037,19 +1006,21 @@ static const char *missing_base_types[][2] = {
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


