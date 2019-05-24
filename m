Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599D529EAC
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfEXS7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 14:59:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44860 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403967AbfEXS7d (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 May 2019 14:59:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OIxCxA004488
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 11:59:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=vJn6Q+9VldXZI93gBamMfi9XmS4qJ+eTvh6RXAG/vwY=;
 b=i0yBWSCLQE7wvXCjyFaXjJIF5J7/7AwP8FdCUSUtgJCWmbo5bWax+zBWb2Tk5KXcPdI4
 C3BRejeAKfVvr0irJm0MGylwPgXQ8dFjsBsTvWl3BiTpfkPBH+PpSIQtTO8QbarvLl8c
 n9QvlmY7Ezb3TuR6790zZ1BFBe3MOQjeKI4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2spbs6a4hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 11:59:30 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 24 May 2019 11:59:29 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 9D4798613DC; Fri, 24 May 2019 11:59:27 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 08/12] libbpf: add btf_dump API for BTF-to-C conversion
Date:   Fri, 24 May 2019 11:59:03 -0700
Message-ID: <20190524185908.3562231-9-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524185908.3562231-1-andriin@fb.com>
References: <20190524185908.3562231-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF contains enough type information to allow generating valid
compilable C header w/ correct layout of structs/unions and all the
typedef/enum definitions. This patch adds a new "object" - btf_dump to
facilitate dumping BTF as valid C. btf_dump__dump_type() is the main API
which takes care of dumping out (through user-provided printf-like
callback function) C definitions for given type ID and it's required
dependencies. This allows for not just dumping out entirety of BTF types,
but also selective filtering based on user-provided criterias w/ minimal
set of dependent types.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/Build      |    4 +-
 tools/lib/bpf/btf.h      |   17 +
 tools/lib/bpf/btf_dump.c | 1336 ++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |    3 +
 4 files changed, 1359 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/btf_dump.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index dcf0d36598e0..e3962cfbc9a6 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1 +1,3 @@
-libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o netlink.o bpf_prog_linfo.o libbpf_probes.o xsk.o hashmap.o
+libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
+	    netlink.o bpf_prog_linfo.o libbpf_probes.o xsk.o hashmap.o \
+	    btf_dump.o
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index bded210df9e8..ba4ffa831aa4 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -4,6 +4,7 @@
 #ifndef __LIBBPF_BTF_H
 #define __LIBBPF_BTF_H
 
+#include <stdarg.h>
 #include <linux/types.h>
 
 #ifdef __cplusplus
@@ -102,6 +103,22 @@ struct btf_dedup_opts {
 LIBBPF_API int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
 			  const struct btf_dedup_opts *opts);
 
+struct btf_dump;
+
+struct btf_dump_opts {
+	void *ctx;
+};
+
+typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
+
+LIBBPF_API struct btf_dump *btf_dump__new(const struct btf *btf,
+					  const struct btf_ext *btf_ext,
+					  const struct btf_dump_opts *opts,
+					  btf_dump_printf_fn_t printf_fn);
+LIBBPF_API void btf_dump__free(struct btf_dump *d);
+
+LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
new file mode 100644
index 000000000000..4b22db77e2cc
--- /dev/null
+++ b/tools/lib/bpf/btf_dump.c
@@ -0,0 +1,1336 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+/*
+ * BTF-to-C type converter.
+ *
+ * Copyright (c) 2019 Facebook
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <linux/err.h>
+#include <linux/btf.h>
+#include "btf.h"
+#include "hashmap.h"
+#include "libbpf.h"
+#include "libbpf_internal.h"
+
+#define min(x, y) ((x) < (y) ? (x) : (y))
+#define max(x, y) ((x) < (y) ? (y) : (x))
+
+static const char PREFIXES[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t";
+static const size_t PREFIX_CNT = sizeof(PREFIXES) - 1;
+
+static const char *pfx(int lvl)
+{
+	return lvl >= PREFIX_CNT ? PREFIXES : &PREFIXES[PREFIX_CNT - lvl];
+}
+
+enum btf_dump_type_order_state {
+	NOT_ORDERED,
+	ORDERING,
+	ORDERED,
+};
+
+enum btf_dump_type_emit_state {
+	NOT_EMITTED,
+	EMITTING,
+	EMITTED,
+};
+
+/* per-type auxiliary state */
+struct btf_dump_type_aux_state {
+	/* topological sorting state */
+	enum btf_dump_type_order_state order_state: 2;
+	/* emitting state used to determine the need for forward declaration */
+	enum btf_dump_type_emit_state emit_state: 2;
+	/* whether forward declaration was already emitted */
+	__u8 fwd_emitted: 1;
+	/* whether unique non-duplicate name was already assigned */
+	__u8 name_resolved: 1;
+};
+
+struct btf_dump {
+	const struct btf *btf;
+	const struct btf_ext *btf_ext;
+	btf_dump_printf_fn_t printf_fn;
+	struct btf_dump_opts opts;
+
+	/* per-type auxiliary state */
+	struct btf_dump_type_aux_state *type_states;
+	/* per-type optional cached unique name, must be freed, if present */
+	const char **cached_names;
+
+	/* topo-sorted list of dependent type definitions */
+	__u32 *emit_queue;
+	int emit_queue_cap;
+	int emit_queue_cnt;
+
+	/*
+	 * stack of type declarations (e.g., chain of modifiers, arrays,
+	 * funcs, etc)
+	 */
+	__u32 *decl_stack;
+	int decl_stack_cap;
+	int decl_stack_cnt;
+
+	/* maps struct/union/enum name to a number of name occurrences */
+	struct hashmap *type_names;
+	/*
+	 * maps typedef identifiers and enum value names to a number of such
+	 * name occurrences
+	 */
+	struct hashmap *ident_names;
+};
+
+static size_t str_hash_fn(const void *key, void *ctx)
+{
+	const char *s = key;
+	size_t h = 0;
+
+	while (*s) {
+		h = h * 31 + *s;
+		s++;
+	}
+	return h;
+}
+
+static bool str_equal_fn(const void *a, const void *b, void *ctx)
+{
+	return strcmp(a, b) == 0;
+}
+
+static __u16 btf_kind_of(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info);
+}
+
+static __u16 btf_vlen_of(const struct btf_type *t)
+{
+	return BTF_INFO_VLEN(t->info);
+}
+
+static bool btf_kflag_of(const struct btf_type *t)
+{
+	return BTF_INFO_KFLAG(t->info);
+}
+
+static const char *btf_name_of(const struct btf_dump *d, __u32 name_off)
+{
+	return btf__name_by_offset(d->btf, name_off);
+}
+
+static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	d->printf_fn(d->opts.ctx, fmt, args);
+	va_end(args);
+}
+
+struct btf_dump *btf_dump__new(const struct btf *btf,
+			       const struct btf_ext *btf_ext,
+			       const struct btf_dump_opts *opts,
+			       btf_dump_printf_fn_t printf_fn)
+{
+	struct btf_dump *d;
+	int err;
+
+	d = calloc(1, sizeof(struct btf_dump));
+	if (!d)
+		return ERR_PTR(-ENOMEM);
+
+	d->btf = btf;
+	d->btf_ext = btf_ext;
+	d->printf_fn = printf_fn;
+	d->opts.ctx = opts ? opts->ctx : NULL;
+
+	d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
+	if (IS_ERR(d->type_names)) {
+		err = PTR_ERR(d->type_names);
+		d->type_names = NULL;
+		btf_dump__free(d);
+		return ERR_PTR(err);
+	}
+	d->ident_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
+	if (IS_ERR(d->ident_names)) {
+		err = PTR_ERR(d->ident_names);
+		d->ident_names = NULL;
+		btf_dump__free(d);
+		return ERR_PTR(err);
+	}
+
+	return d;
+}
+
+void btf_dump__free(struct btf_dump *d)
+{
+	int i, cnt;
+
+	if (!d)
+		return;
+
+	free(d->type_states);
+	if (d->cached_names) {
+		/* any set cached name is owned by us and should be freed */
+		for (i = 0, cnt = btf__get_nr_types(d->btf); i <= cnt; i++) {
+			if (d->cached_names[i])
+				free((void *)d->cached_names[i]);
+		}
+	}
+	free(d->cached_names);
+	free(d->emit_queue);
+	free(d->decl_stack);
+	hashmap__free(d->type_names);
+	hashmap__free(d->ident_names);
+
+	free(d);
+}
+
+static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr);
+static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
+
+/*
+ * Dump BTF type in a compilable C syntax, including all the necessary
+ * dependent types, necessary for compilation. If some of the dependent types
+ * were already emitted as part of previous btf_dump__dump_type() invocation
+ * for another type, they won't be emitted again. This API allows callers to
+ * filter out BTF types according to user-defined criterias and emitted only
+ * minimal subset of types, necessary to compile everything. Full struct/union
+ * definitions will still be emitted, even if the only usage is through
+ * pointer and could be satisfied with just a forward declaration.
+ *
+ * Dumping is done in two high-level passes:
+ *   1. Topologically sort type definitions to satisfy C rules of compilation.
+ *   2. Emit type definitions in C syntax.
+ *
+ * Returns 0 on success; <0, otherwise.
+ */
+int btf_dump__dump_type(struct btf_dump *d, __u32 id)
+{
+	int err, i;
+
+	if (id > btf__get_nr_types(d->btf))
+		return -EINVAL;
+
+	/* type states are lazily allocated, as they might not be needed */
+	if (!d->type_states) {
+		d->type_states = calloc(1 + btf__get_nr_types(d->btf),
+					sizeof(d->type_states[0]));
+		if (!d->type_states)
+			return -ENOMEM;
+		d->cached_names = calloc(1 + btf__get_nr_types(d->btf),
+					 sizeof(d->cached_names[0]));
+		if (!d->cached_names)
+			return -ENOMEM;
+
+		/* VOID is special */
+		d->type_states[0].order_state = ORDERED;
+		d->type_states[0].emit_state = EMITTED;
+	}
+
+	d->emit_queue_cnt = 0;
+	err = btf_dump_order_type(d, id, false);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < d->emit_queue_cnt; i++)
+		btf_dump_emit_type(d, d->emit_queue[i], 0 /*top-level*/);
+
+	return 0;
+}
+
+static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
+{
+	__u32 *new_queue;
+	size_t new_cap;
+
+	if (d->emit_queue_cnt >= d->emit_queue_cap) {
+		new_cap = max(16, d->emit_queue_cap * 3 / 2);
+		new_queue = realloc(d->emit_queue,
+				    new_cap * sizeof(new_queue[0]));
+		if (!new_queue)
+			return -ENOMEM;
+		d->emit_queue = new_queue;
+		d->emit_queue_cap = new_cap;
+	}
+
+	d->emit_queue[d->emit_queue_cnt++] = id;
+	return 0;
+}
+
+/*
+ * Determine order of emitting dependent types and specified type to satisfy
+ * C compilation rules.  This is done through topological sorting with an
+ * additional complication which comes from C rules. The main idea for C is
+ * that if some type is "embedded" into a struct/union, it's size needs to be
+ * known at the time of definition of containing type. E.g., for:
+ *
+ *	struct A {};
+ *	struct B { struct A x; }
+ *
+ * struct A *HAS* to be defined before struct B, because it's "embedded",
+ * i.e., it is part of struct B layout. But in the following case:
+ *
+ *	struct A;
+ *	struct B { struct A *x; }
+ *	struct A {};
+ *
+ * it's enough to just have a forward declaration of struct A at the time of
+ * struct B definition, as struct B has a pointer to struct A, so the size of
+ * field x is known without knowing struct A size: it's sizeof(void *).
+ *
+ * Unfortunately, there are some trickier cases we need to handle, e.g.:
+ *
+ *	struct A {}; // if this was forward-declaration: compilation error
+ *	struct B {
+ *		struct { // anonymous struct
+ *			struct A y;
+ *		} *x;
+ *	};
+ *
+ * In this case, struct B's field x is a pointer, so it's size is known
+ * regardless of the size of (anonymous) struct it points to. But because this
+ * struct is anonymous and thus defined inline inside struct B, *and* it
+ * embeds struct A, compiler requires full definition of struct A to be known
+ * before struct B can be defined. This creates a transitive dependency
+ * between struct A and struct B. If struct A was forward-declared before
+ * struct B definition and fully defined after struct B definition, that would
+ * trigger compilation error.
+ *
+ * All this means that while we are doing topological sorting on BTF type
+ * graph, we need to determine relationships between different types (graph
+ * nodes):
+ *   - weak link (relationship) between X and Y, if Y *CAN* be
+ *   forward-declared at the point of X definition;
+ *   - strong link, if Y *HAS* to be fully-defined before X can be defined.
+ *
+ * The rule is as follows. Given a chain of BTF types from X to Y, if there is
+ * BTF_KIND_PTR type in the chain and at least one non-anonymous type
+ * Z (excluding X, including Y), then link is weak. Otherwise, it's strong.
+ * Weak/strong relationship is determined recursively during DFS traversal and
+ * is returned as a result from btf_dump_order_type().
+ *
+ * btf_dump_order_type() is trying to avoid unnecessary forward declarations,
+ * but it is not guaranteeing that no extraneous forward declarations will be
+ * emitted.
+ *
+ * To avoid extra work, algorithm marks some of BTF types as ORDERED, when
+ * it's done with them, but not for all (e.g., VOLATILE, CONST, RESTRICT,
+ * ARRAY, FUNC_PROTO), as weak/strong semantics for those depends on the
+ * entire graph path, so depending where from one came to that BTF type, it
+ * might cause weak or strong ordering. For types like STRUCT/UNION/INT/ENUM,
+ * once they are processed, there is no need to do it again, so they are
+ * marked as ORDERED. We can mark PTR as ORDERED as well, as it semi-forces
+ * weak link, unless subsequent referenced STRUCT/UNION/ENUM is anonymous. But
+ * in any case, once those are processed, no need to do it again, as the
+ * result won't change.
+ *
+ * Returns:
+ *   - 1, if type is part of strong link (so there is strong topological
+ *   ordering requirements);
+ *   - 0, if type is part of weak link (so can be satisfied through forward
+ *   declaration);
+ *   - <0, on error (e.g., unsatisfiable type loop detected).
+ */
+static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
+{
+	/*
+	 * Order state is used to detect strong link cycles, but only for BTF
+	 * kinds that are or could be an independent definition (i.e.,
+	 * stand-alone fwd decl, enum, typedef, struct, union). Ptrs, arrays,
+	 * func_protos, modifiers are just means to get to these definitions.
+	 * Int/void don't need definitions, they are assumed to be always
+	 * properly defined.  We also ignore datasec, var, and funcs for now.
+	 * So for all non-defining kinds, we never even set ordering state,
+	 * for defining kinds we set ORDERING and subsequently ORDERED if it
+	 * forms a strong link.
+	 */
+	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
+	const struct btf_type *t;
+	__u16 kind, vlen;
+	int err, i;
+
+	/* return true, letting typedefs know that it's ok to be emitted */
+	if (tstate->order_state == ORDERED)
+		return 1;
+
+	t = btf__type_by_id(d->btf, id);
+	kind = btf_kind_of(t);
+
+	if (tstate->order_state == ORDERING) {
+		/* type loop, but resolvable through fwd declaration */
+		if ((kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION) &&
+		    through_ptr && t->name_off != 0)
+			return 0;
+		pr_warning("unsatisfiable type cycle, id:[%u]\n", id);
+		return -ELOOP;
+	}
+
+	switch (kind) {
+	case BTF_KIND_INT:
+		tstate->order_state = ORDERED;
+		return 0;
+
+	case BTF_KIND_PTR:
+		err = btf_dump_order_type(d, t->type, true);
+		tstate->order_state = ORDERED;
+		return err;
+
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *a = (void *)(t + 1);
+
+		return btf_dump_order_type(d, a->type, through_ptr);
+	}
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m = (void *)(t + 1);
+		/*
+		 * struct/union is part of strong link, only if it's embedded
+		 * (so no ptr in a path) or it's anonymous (so has to be
+		 * defined inline, even if declared through ptr)
+		 */
+		if (through_ptr && t->name_off != 0)
+			return 0;
+
+		tstate->order_state = ORDERING;
+
+		vlen = btf_vlen_of(t);
+		for (i = 0; i < vlen; i++, m++) {
+			err = btf_dump_order_type(d, m->type, false);
+			if (err < 0)
+				return err;
+		}
+
+		if (t->name_off != 0) {
+			err = btf_dump_add_emit_queue_id(d, id);
+			if (err < 0)
+				return err;
+		}
+
+		tstate->order_state = ORDERED;
+		return 1;
+	}
+	case BTF_KIND_ENUM:
+	case BTF_KIND_FWD:
+		if (t->name_off != 0) {
+			err = btf_dump_add_emit_queue_id(d, id);
+			if (err)
+				return err;
+		}
+		tstate->order_state = ORDERED;
+		return 1;
+
+	case BTF_KIND_TYPEDEF: {
+		int is_strong;
+
+		is_strong = btf_dump_order_type(d, t->type, through_ptr);
+		if (is_strong < 0)
+			return is_strong;
+
+		/* typedef is similar to struct/union w.r.t. fwd-decls */
+		if (through_ptr && !is_strong)
+			return 0;
+
+		/* typedef is always a named definition */
+		err = btf_dump_add_emit_queue_id(d, id);
+		if (err)
+			return err;
+
+		d->type_states[id].order_state = ORDERED;
+		return 1;
+	}
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		return btf_dump_order_type(d, t->type, through_ptr);
+
+	case BTF_KIND_FUNC_PROTO: {
+		const struct btf_param *p = (void *)(t + 1);
+		bool is_strong;
+
+		err = btf_dump_order_type(d, t->type, through_ptr);
+		if (err < 0)
+			return err;
+		is_strong = err > 0;
+
+		vlen = btf_vlen_of(t);
+		for (i = 0; i < vlen; i++, p++) {
+			err = btf_dump_order_type(d, p->type, through_ptr);
+			if (err < 0)
+				return err;
+			if (err > 0)
+				is_strong = true;
+		}
+		return is_strong;
+	}
+	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DATASEC:
+		d->type_states[id].order_state = ORDERED;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
+				     const struct btf_type *t);
+static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
+				     const struct btf_type *t, int lvl);
+
+static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
+				   const struct btf_type *t);
+static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
+				   const struct btf_type *t, int lvl);
+
+static void btf_dump_emit_fwd_def(struct btf_dump *d, __u32 id,
+				  const struct btf_type *t);
+
+static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
+				      const struct btf_type *t, int lvl);
+
+/* a local view into a shared stack */
+struct id_stack {
+	const __u32 *ids;
+	int cnt;
+};
+
+static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
+				    const char *fname, int lvl);
+static void btf_dump_emit_type_chain(struct btf_dump *d,
+				     struct id_stack *decl_stack,
+				     const char *fname, int lvl);
+
+static const char *btf_dump_type_name(struct btf_dump *d, __u32 id);
+static const char *btf_dump_ident_name(struct btf_dump *d, __u32 id);
+static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
+				 const char *orig_name);
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
+/*
+ * Emit C-syntax definitions of types from chains of BTF types.
+ *
+ * High-level handling of determining necessary forward declarations are handled
+ * by btf_dump_emit_type() itself, but all nitty-gritty details of emitting type
+ * declarations/definitions in C syntax  are handled by a combo of
+ * btf_dump_emit_type_decl()/btf_dump_emit_type_chain() w/ delegation to
+ * corresponding btf_dump_emit_*_{def,fwd}() functions.
+ *
+ * We also keep track of "containing struct/union type ID" to determine when
+ * we reference it from inside and thus can avoid emitting unnecessary forward
+ * declaration.
+ *
+ * This algorithm is designed in such a way, that even if some error occurs
+ * (either technical, e.g., out of memory, or logical, i.e., malformed BTF
+ * that doesn't comply to C rules completely), algorithm will try to proceed
+ * and produce as much meaningful output as possible.
+ */
+static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
+{
+	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
+	bool top_level_def = cont_id == 0;
+	const struct btf_type *t;
+	__u16 kind;
+
+	if (tstate->emit_state == EMITTED)
+		return;
+
+	t = btf__type_by_id(d->btf, id);
+	kind = btf_kind_of(t);
+
+	if (top_level_def && t->name_off == 0) {
+		pr_warning("unexpected nameless definition, id:[%u]\n", id);
+		return;
+	}
+
+	if (tstate->emit_state == EMITTING) {
+		if (tstate->fwd_emitted)
+			return;
+
+		switch (kind) {
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			/*
+			 * if we are referencing a struct/union that we are
+			 * part of - then no need for fwd declaration
+			 */
+			if (id == cont_id)
+				return;
+			if (t->name_off == 0) {
+				pr_warning("anonymous struct/union loop, id:[%u]\n",
+					   id);
+				return;
+			}
+			btf_dump_emit_struct_fwd(d, id, t);
+			btf_dump_printf(d, ";\n\n");
+			tstate->fwd_emitted = 1;
+			break;
+		case BTF_KIND_TYPEDEF:
+			/*
+			 * for typedef fwd_emitted means typedef definition
+			 * was emitted, but it can be used only for "weak"
+			 * references through pointer only, not for embedding
+			 */
+			if (!btf_dump_is_blacklisted(d, id)) {
+				btf_dump_emit_typedef_def(d, id, t, 0);
+				btf_dump_printf(d, ";\n\n");
+			};
+			tstate->fwd_emitted = 1;
+			break;
+		default:
+			break;
+		}
+
+		return;
+	}
+
+	switch (kind) {
+	case BTF_KIND_INT:
+		tstate->emit_state = EMITTED;
+		break;
+	case BTF_KIND_ENUM:
+		if (top_level_def) {
+			btf_dump_emit_enum_def(d, id, t, 0);
+			btf_dump_printf(d, ";\n\n");
+		}
+		tstate->emit_state = EMITTED;
+		break;
+	case BTF_KIND_PTR:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		btf_dump_emit_type(d, t->type, cont_id);
+		break;
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *a = (void *)(t + 1);
+
+		btf_dump_emit_type(d, a->type, cont_id);
+		break;
+	}
+	case BTF_KIND_FWD:
+		btf_dump_emit_fwd_def(d, id, t);
+		btf_dump_printf(d, ";\n\n");
+		tstate->emit_state = EMITTED;
+		break;
+	case BTF_KIND_TYPEDEF:
+		tstate->emit_state = EMITTING;
+		btf_dump_emit_type(d, t->type, id);
+		/*
+		 * typedef can server as both definition and forward
+		 * declaration; at this stage someone depends on
+		 * typedef as a forward declaration (refers to it
+		 * through pointer), so unless we already did it,
+		 * emit typedef as a forward declaration
+		 */
+		if (!tstate->fwd_emitted && !btf_dump_is_blacklisted(d, id)) {
+			btf_dump_emit_typedef_def(d, id, t, 0);
+			btf_dump_printf(d, ";\n\n");
+		}
+		tstate->emit_state = EMITTED;
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		tstate->emit_state = EMITTING;
+		/* if it's a top-level struct/union definition or struct/union
+		 * is anonymous, then in C we'll be emitting all fields and
+		 * their types (as opposed to just `struct X`), so we need to
+		 * make sure that all types, referenced from struct/union
+		 * members have necessary forward-declarations, where
+		 * applicable
+		 */
+		if (top_level_def || t->name_off == 0) {
+			const struct btf_member *m = (void *)(t + 1);
+			__u16 vlen = btf_vlen_of(t);
+			int i, new_cont_id;
+
+			new_cont_id = t->name_off == 0 ? cont_id : id;
+			for (i = 0; i < vlen; i++, m++)
+				btf_dump_emit_type(d, m->type, new_cont_id);
+		} else if (!tstate->fwd_emitted && id != cont_id) {
+			btf_dump_emit_struct_fwd(d, id, t);
+			btf_dump_printf(d, ";\n\n");
+			tstate->fwd_emitted = 1;
+		}
+
+		if (top_level_def) {
+			btf_dump_emit_struct_def(d, id, t, 0);
+			btf_dump_printf(d, ";\n\n");
+			tstate->emit_state = EMITTED;
+		} else {
+			tstate->emit_state = NOT_EMITTED;
+		}
+		break;
+	case BTF_KIND_FUNC_PROTO: {
+		const struct btf_param *p = (void *)(t + 1);
+		__u16 vlen = btf_vlen_of(t);
+		int i;
+
+		btf_dump_emit_type(d, t->type, cont_id);
+		for (i = 0; i < vlen; i++, p++)
+			btf_dump_emit_type(d, p->type, cont_id);
+
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static int btf_align_of(const struct btf *btf, __u32 id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	__u16 kind = btf_kind_of(t);
+
+	switch (kind) {
+	case BTF_KIND_INT:
+	case BTF_KIND_ENUM:
+		return min(sizeof(void *), t->size);
+	case BTF_KIND_PTR:
+		return sizeof(void *);
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		return btf_align_of(btf, t->type);
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *a = (void *)(t + 1);
+
+		return btf_align_of(btf, a->type);
+	}
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m = (void *)(t + 1);
+		__u16 vlen = btf_vlen_of(t);
+		int i, align = 1;
+
+		for (i = 0; i < vlen; i++, m++)
+			align = max(align, btf_align_of(btf, m->type));
+
+		return align;
+	}
+	default:
+		pr_warning("unsupported BTF_KIND:%u\n", btf_kind_of(t));
+		return 1;
+	}
+}
+
+static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
+				 const struct btf_type *t)
+{
+	const struct btf_member *m;
+	int align, i, bit_sz;
+	__u16 vlen;
+	bool kflag;
+
+	align = btf_align_of(btf, id);
+	/* size of a non-packed struct has to be a multiple of its alignment*/
+	if (t->size % align)
+		return true;
+
+	m = (void *)(t + 1);
+	kflag = btf_kflag_of(t);
+	vlen = btf_vlen_of(t);
+	/* all non-bitfield fields have to be naturally aligned */
+	for (i = 0; i < vlen; i++, m++) {
+		align = btf_align_of(btf, m->type);
+		bit_sz = kflag ? BTF_MEMBER_BITFIELD_SIZE(m->offset) : 0;
+		if (bit_sz == 0 && m->offset % (8 * align) != 0)
+			return true;
+	}
+
+	/*
+	 * if original struct was marked as packed, but its layout is
+	 * naturally aligned, we'll detect that it's not packed
+	 */
+	return false;
+}
+
+static int chip_away_bits(int total, int at_most)
+{
+	return total % at_most ? : at_most;
+}
+
+static void btf_dump_emit_bit_padding(const struct btf_dump *d,
+				      int cur_off, int m_off, int m_bit_sz,
+				      int align, int lvl)
+{
+	int off_diff = m_off - cur_off;
+	int ptr_bits = sizeof(void *) * 8;
+
+	if (off_diff <= 0)
+		/* no gap */
+		return;
+	if (m_bit_sz == 0 && off_diff < align * 8)
+		/* natural padding will take care of a gap */
+		return;
+
+	while (off_diff > 0) {
+		const char *pad_type;
+		int pad_bits;
+
+		if (ptr_bits > 32 && off_diff > 32) {
+			pad_type = "long";
+			pad_bits = chip_away_bits(off_diff, ptr_bits);
+		} else if (off_diff > 16) {
+			pad_type = "int";
+			pad_bits = chip_away_bits(off_diff, 32);
+		} else if (off_diff > 8) {
+			pad_type = "short";
+			pad_bits = chip_away_bits(off_diff, 16);
+		} else {
+			pad_type = "char";
+			pad_bits = chip_away_bits(off_diff, 8);
+		}
+		btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type, pad_bits);
+		off_diff -= pad_bits;
+	}
+}
+
+static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
+				     const struct btf_type *t)
+{
+	btf_dump_printf(d, "%s %s",
+			btf_kind_of(t) == BTF_KIND_STRUCT ? "struct" : "union",
+			btf_dump_type_name(d, id));
+}
+
+static void btf_dump_emit_struct_def(struct btf_dump *d,
+				     __u32 id,
+				     const struct btf_type *t,
+				     int lvl)
+{
+	const struct btf_member *m = (void *)(t + 1);
+	bool kflag = btf_kflag_of(t), is_struct;
+	int align, i, packed, off = 0;
+	__u16 vlen = btf_vlen_of(t);
+
+	is_struct = btf_kind_of(t) == BTF_KIND_STRUCT;
+	packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
+	align = packed ? 1 : btf_align_of(d->btf, id);
+
+	btf_dump_printf(d, "%s%s%s {",
+			is_struct ? "struct" : "union",
+			t->name_off ? " " : "",
+			btf_dump_type_name(d, id));
+
+	for (i = 0; i < vlen; i++, m++) {
+		const char *fname;
+		int m_off, m_sz;
+
+		fname = btf_name_of(d, m->name_off);
+		m_sz = kflag ? BTF_MEMBER_BITFIELD_SIZE(m->offset) : 0;
+		m_off = kflag ? BTF_MEMBER_BIT_OFFSET(m->offset) : m->offset;
+		align = packed ? 1 : btf_align_of(d->btf, m->type);
+
+		btf_dump_emit_bit_padding(d, off, m_off, m_sz, align, lvl + 1);
+		btf_dump_printf(d, "\n%s", pfx(lvl + 1));
+		btf_dump_emit_type_decl(d, m->type, fname, lvl + 1);
+
+		if (m_sz) {
+			btf_dump_printf(d, ": %d", m_sz);
+			off = m_off + m_sz;
+		} else {
+			m_sz = max(0, btf__resolve_size(d->btf, m->type));
+			off = m_off + m_sz * 8;
+		}
+		btf_dump_printf(d, ";");
+	}
+
+	if (vlen)
+		btf_dump_printf(d, "\n");
+	btf_dump_printf(d, "%s}", pfx(lvl));
+	if (packed)
+		btf_dump_printf(d, " __attribute__((packed))");
+}
+
+static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
+				   const struct btf_type *t)
+{
+	btf_dump_printf(d, "enum %s", btf_dump_type_name(d, id));
+}
+
+static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
+				   const struct btf_type *t,
+				   int lvl)
+{
+	const struct btf_enum *v = (void *)(t+1);
+	__u16 vlen = btf_vlen_of(t);
+	const char *name;
+	size_t dup_cnt;
+	int i;
+
+	btf_dump_printf(d, "enum%s%s",
+			t->name_off ? " " : "",
+			btf_dump_type_name(d, id));
+
+	if (vlen) {
+		btf_dump_printf(d, " {");
+		for (i = 0; i < vlen; i++, v++) {
+			name = btf_name_of(d, v->name_off);
+			/* enumerators share namespace with typedef idents */
+			dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
+			if (dup_cnt > 1) {
+				btf_dump_printf(d, "\n%s%s___%zu = %d,",
+						pfx(lvl + 1), name, dup_cnt,
+						(__s32)v->val);
+			} else {
+				btf_dump_printf(d, "\n%s%s = %d,",
+						pfx(lvl + 1), name,
+						(__s32)v->val);
+			}
+		}
+		btf_dump_printf(d, "\n%s}", pfx(lvl));
+	}
+}
+
+static void btf_dump_emit_fwd_def(struct btf_dump *d, __u32 id,
+				  const struct btf_type *t)
+{
+	const char *name = btf_dump_type_name(d, id);
+
+	if (btf_kflag_of(t))
+		btf_dump_printf(d, "union %s", name);
+	else
+		btf_dump_printf(d, "struct %s", name);
+}
+
+static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
+				     const struct btf_type *t, int lvl)
+{
+	const char *name = btf_dump_ident_name(d, id);
+
+	btf_dump_printf(d, "typedef ");
+	btf_dump_emit_type_decl(d, t->type, name, lvl);
+}
+
+static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
+{
+	__u32 *new_stack;
+	size_t new_cap;
+
+	if (d->decl_stack_cnt >= d->decl_stack_cap) {
+		new_cap = max(16, d->decl_stack_cap * 3 / 2);
+		new_stack = realloc(d->decl_stack,
+				    new_cap * sizeof(new_stack[0]));
+		if (!new_stack)
+			return -ENOMEM;
+		d->decl_stack = new_stack;
+		d->decl_stack_cap = new_cap;
+	}
+
+	d->decl_stack[d->decl_stack_cnt++] = id;
+
+	return 0;
+}
+
+/*
+ * Emit type declaration (e.g., field type declaration in a struct or argument
+ * declaration in function prototype) in correct C syntax.
+ *
+ * For most types it's trivial, but there are few quirky type declaration
+ * cases worth mentioning:
+ *   - function prototypes (especially nesting of function prototypes);
+ *   - arrays;
+ *   - const/volatile/restrict for pointers vs other types.
+ *
+ * For a good discussion of *PARSING* C syntax (as a human), see
+ * Peter van der Linden's "Expert C Programming: Deep C Secrets",
+ * Ch.3 "Unscrambling Declarations in C".
+ *
+ * It won't help with BTF to C conversion much, though, as it's an opposite
+ * problem. So we came up with this algorithm in reverse to van der Linden's
+ * parsing algorithm. It goes from structured BTF representation of type
+ * declaration to a valid compilable C syntax.
+ *
+ * For instance, consider this C typedef:
+ *	typedef const int * const * arr[10] arr_t;
+ * It will be represented in BTF with this chain of BTF types:
+ *	[typedef] -> [array] -> [ptr] -> [const] -> [ptr] -> [const] -> [int]
+ *
+ * Notice how [const] modifier always goes before type it modifies in BTF type
+ * graph, but in C syntax, const/volatile/restrict modifiers are written to
+ * the right of pointers, but to the left of other types. There are also other
+ * quirks, like function pointers, arrays of them, functions returning other
+ * functions, etc.
+ *
+ * We handle that by pushing all the types to a stack, until we hit "terminal"
+ * type (int/enum/struct/union/fwd). Then depending on the kind of a type on
+ * top of a stack, modifiers are handled differently. Array/function pointers
+ * have also wildly different syntax and how nesting of them are done. See
+ * code for authoritative definition.
+ *
+ * To avoid allocating new stack for each independent chain of BTF types, we
+ * share one bigger stack, with each chain working only on its own local view
+ * of a stack frame. Some care is required to "pop" stack frames after
+ * processing type declaration chain.
+ */
+static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
+				    const char *fname, int lvl)
+{
+	struct id_stack decl_stack;
+	const struct btf_type *t;
+	int err, stack_start;
+	__u16 kind;
+
+	stack_start = d->decl_stack_cnt;
+	for (;;) {
+		err = btf_dump_push_decl_stack_id(d, id);
+		if (err < 0) {
+			/*
+			 * if we don't have enough memory for entire type decl
+			 * chain, restore stack, emit warning, and try to
+			 * proceed nevertheless
+			 */
+			pr_warning("not enough memory for decl stack:%d", err);
+			d->decl_stack_cnt = stack_start;
+			return;
+		}
+
+		/* VOID */
+		if (id == 0)
+			break;
+
+		t = btf__type_by_id(d->btf, id);
+		kind = btf_kind_of(t);
+		switch (kind) {
+		case BTF_KIND_PTR:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_CONST:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_FUNC_PROTO:
+			id = t->type;
+			break;
+		case BTF_KIND_ARRAY: {
+			const struct btf_array *a = (void *)(t + 1);
+
+			id = a->type;
+			break;
+		}
+		case BTF_KIND_INT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_FWD:
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+		case BTF_KIND_TYPEDEF:
+			goto done;
+		default:
+			pr_warning("unexpected type in decl chain, kind:%u, id:[%u]\n",
+				   kind, id);
+			goto done;
+		}
+	}
+done:
+	/*
+	 * We might be inside a chain of declarations (e.g., array of function
+	 * pointers returning anonymous (so inlined) structs, having another
+	 * array field). Each of those needs its own "stack frame" to handle
+	 * emitting of declarations. Those stack frames are non-overlapping
+	 * portions of shared btf_dump->decl_stack. To make it a bit nicer to
+	 * handle this set of nested stacks, we create a view corresponding to
+	 * our own "stack frame" and work with it as an independent stack.
+	 * We'll need to clean up after emit_type_chain() returns, though.
+	 */
+	decl_stack.ids = d->decl_stack + stack_start;
+	decl_stack.cnt = d->decl_stack_cnt - stack_start;
+	btf_dump_emit_type_chain(d, &decl_stack, fname, lvl);
+	/*
+	 * emit_type_chain() guarantees that it will pop its entire decl_stack
+	 * frame before returning. But it works with a read-only view into
+	 * decl_stack, so it doesn't actually pop anything from the
+	 * perspective of shared btf_dump->decl_stack, per se. We need to
+	 * reset decl_stack state to how it was before us to avoid it growing
+	 * all the time.
+	 */
+	d->decl_stack_cnt = stack_start;
+}
+
+static void btf_dump_emit_mods(struct btf_dump *d, struct id_stack *decl_stack)
+{
+	const struct btf_type *t;
+	__u32 id;
+
+	while (decl_stack->cnt) {
+		id = decl_stack->ids[decl_stack->cnt - 1];
+		t = btf__type_by_id(d->btf, id);
+
+		switch (btf_kind_of(t)) {
+		case BTF_KIND_VOLATILE:
+			btf_dump_printf(d, "volatile ");
+			break;
+		case BTF_KIND_CONST:
+			btf_dump_printf(d, "const ");
+			break;
+		case BTF_KIND_RESTRICT:
+			btf_dump_printf(d, "restrict ");
+			break;
+		default:
+			return;
+		}
+		decl_stack->cnt--;
+	}
+}
+
+static bool btf_is_mod_kind(const struct btf *btf, __u32 id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+
+	switch (btf_kind_of(t)) {
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void btf_dump_emit_name(const struct btf_dump *d,
+			       const char *name, bool last_was_ptr)
+{
+	bool separate = name[0] && !last_was_ptr;
+
+	btf_dump_printf(d, "%s%s", separate ? " " : "", name);
+}
+
+static void btf_dump_emit_type_chain(struct btf_dump *d,
+				     struct id_stack *decls,
+				     const char *fname, int lvl)
+{
+	/*
+	 * last_was_ptr is used to determine if we need to separate pointer
+	 * asterisk (*) from previous part of type signature with space, so
+	 * that we get `int ***`, instead of `int * * *`. We default to true
+	 * for cases where we have single pointer in a chain. E.g., in ptr ->
+	 * func_proto case. func_proto will start a new emit_type_chain call
+	 * with just ptr, which should be emitted as (*) or (*<fname>), so we
+	 * don't want to prepend space for that last pointer.
+	 */
+	bool last_was_ptr = true;
+	const struct btf_type *t;
+	const char *name;
+	__u16 kind;
+	__u32 id;
+
+	while (decls->cnt) {
+		id = decls->ids[--decls->cnt];
+		if (id == 0) {
+			/* VOID is a special snowflake */
+			btf_dump_emit_mods(d, decls);
+			btf_dump_printf(d, "void");
+			last_was_ptr = false;
+			continue;
+		}
+
+		t = btf__type_by_id(d->btf, id);
+		kind = btf_kind_of(t);
+
+		switch (kind) {
+		case BTF_KIND_INT:
+			btf_dump_emit_mods(d, decls);
+			name = btf_name_of(d, t->name_off);
+			btf_dump_printf(d, "%s", name);
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			btf_dump_emit_mods(d, decls);
+			/* inline anonymous struct/union */
+			if (t->name_off == 0)
+				btf_dump_emit_struct_def(d, id, t, lvl);
+			else
+				btf_dump_emit_struct_fwd(d, id, t);
+			break;
+		case BTF_KIND_ENUM:
+			btf_dump_emit_mods(d, decls);
+			/* inline anonymous enum */
+			if (t->name_off == 0)
+				btf_dump_emit_enum_def(d, id, t, lvl);
+			else
+				btf_dump_emit_enum_fwd(d, id, t);
+			break;
+		case BTF_KIND_FWD:
+			btf_dump_emit_mods(d, decls);
+			btf_dump_emit_fwd_def(d, id, t);
+			break;
+		case BTF_KIND_TYPEDEF:
+			btf_dump_emit_mods(d, decls);
+			btf_dump_printf(d, "%s", btf_dump_ident_name(d, id));
+			break;
+		case BTF_KIND_PTR:
+			btf_dump_printf(d, "%s", last_was_ptr ? "*" : " *");
+			break;
+		case BTF_KIND_VOLATILE:
+			btf_dump_printf(d, " volatile");
+			break;
+		case BTF_KIND_CONST:
+			btf_dump_printf(d, " const");
+			break;
+		case BTF_KIND_RESTRICT:
+			btf_dump_printf(d, " restrict");
+			break;
+		case BTF_KIND_ARRAY: {
+			const struct btf_array *a = (void *)(t + 1);
+			const struct btf_type *next_t;
+			__u32 next_id;
+			bool multidim;
+			/*
+			 * GCC has a bug
+			 * (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=8354)
+			 * which causes it to emit extra const/volatile
+			 * modifiers for an array, if array's element type has
+			 * const/volatile modifiers. Clang doesn't do that.
+			 * In general, it doesn't seem very meaningful to have
+			 * a const/volatile modifier for array, so we are
+			 * going to silently skip them here.
+			 */
+			while (decls->cnt) {
+				next_id = decls->ids[decls->cnt - 1];
+				if (btf_is_mod_kind(d->btf, next_id))
+					decls->cnt--;
+				else
+					break;
+			}
+
+			if (decls->cnt == 0) {
+				btf_dump_emit_name(d, fname, last_was_ptr);
+				btf_dump_printf(d, "[%u]", a->nelems);
+				return;
+			}
+
+			next_t = btf__type_by_id(d->btf, next_id);
+			multidim = btf_kind_of(next_t) == BTF_KIND_ARRAY;
+			/* we need space if we have named non-pointer */
+			if (fname[0] && !last_was_ptr)
+				btf_dump_printf(d, " ");
+			/* no parentheses for multi-dimensional array */
+			if (!multidim)
+				btf_dump_printf(d, "(");
+			btf_dump_emit_type_chain(d, decls, fname, lvl);
+			if (!multidim)
+				btf_dump_printf(d, ")");
+			btf_dump_printf(d, "[%u]", a->nelems);
+			return;
+		}
+		case BTF_KIND_FUNC_PROTO: {
+			const struct btf_param *p = (void *)(t + 1);
+			__u16 vlen = btf_vlen_of(t);
+			int i;
+
+			btf_dump_emit_mods(d, decls);
+			if (decls->cnt) {
+				btf_dump_printf(d, " (");
+				btf_dump_emit_type_chain(d, decls, fname, lvl);
+				btf_dump_printf(d, ")");
+			} else {
+				btf_dump_emit_name(d, fname, last_was_ptr);
+			}
+			btf_dump_printf(d, "(");
+			/*
+			 * Clang for BPF target generates func_proto with no
+			 * args as a func_proto with a single void arg (e.g.,
+			 * `int (*f)(void)` vs just `int (*f)()`). We are
+			 * going to pretend there are no args for such case.
+			 */
+			if (vlen == 1 && p->type == 0) {
+				btf_dump_printf(d, ")");
+				return;
+			}
+
+			for (i = 0; i < vlen; i++, p++) {
+				if (i > 0)
+					btf_dump_printf(d, ", ");
+
+				/* last arg of type void is vararg */
+				if (i == vlen - 1 && p->type == 0) {
+					btf_dump_printf(d, "...");
+					break;
+				}
+
+				name = btf_name_of(d, p->name_off);
+				btf_dump_emit_type_decl(d, p->type, name, lvl);
+			}
+
+			btf_dump_printf(d, ")");
+			return;
+		}
+		default:
+			pr_warning("unexpected type in decl chain, kind:%u, id:[%u]\n",
+				   kind, id);
+			return;
+		}
+
+		last_was_ptr = kind == BTF_KIND_PTR;
+	}
+
+	btf_dump_emit_name(d, fname, last_was_ptr);
+}
+
+/* return number of duplicates (occurrences) of a given name */
+static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
+				 const char *orig_name)
+{
+	size_t dup_cnt = 0;
+
+	hashmap__find(name_map, orig_name, (void **)&dup_cnt);
+	dup_cnt++;
+	hashmap__set(name_map, orig_name, (void *)dup_cnt, NULL, NULL);
+
+	return dup_cnt;
+}
+
+static const char *btf_dump_resolve_name(struct btf_dump *d, __u32 id,
+					 struct hashmap *name_map)
+{
+	struct btf_dump_type_aux_state *s = &d->type_states[id];
+	const struct btf_type *t = btf__type_by_id(d->btf, id);
+	const char *orig_name = btf_name_of(d, t->name_off);
+	const char **cached_name = &d->cached_names[id];
+	size_t dup_cnt;
+
+	if (t->name_off == 0)
+		return "";
+
+	if (s->name_resolved)
+		return *cached_name ? *cached_name : orig_name;
+
+	dup_cnt = btf_dump_name_dups(d, name_map, orig_name);
+	if (dup_cnt > 1) {
+		const size_t max_len = 256;
+		char new_name[max_len];
+
+		snprintf(new_name, max_len, "%s___%zu", orig_name, dup_cnt);
+		*cached_name = strdup(new_name);
+	}
+
+	s->name_resolved = 1;
+	return *cached_name ? *cached_name : orig_name;
+}
+
+static const char *btf_dump_type_name(struct btf_dump *d, __u32 id)
+{
+	return btf_dump_resolve_name(d, id, d->type_names);
+}
+
+static const char *btf_dump_ident_name(struct btf_dump *d, __u32 id)
+{
+	return btf_dump_resolve_name(d, id, d->ident_names);
+}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6ea5ce19b9e0..8bf51d0a6072 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -167,5 +167,8 @@ LIBBPF_0.0.3 {
 
 LIBBPF_0.0.4 {
 	global:
+		btf_dump__dump_type;
+		btf_dump__free;
+		btf_dump__new;
 		btf__parse_elf;
 } LIBBPF_0.0.3;
-- 
2.17.1

