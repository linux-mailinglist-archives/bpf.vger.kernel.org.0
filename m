Return-Path: <bpf+bounces-73838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4F1C3B0CC
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650BB1AA68DB
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEDC336EDF;
	Thu,  6 Nov 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd4FRocV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AB32ED39
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433621; cv=none; b=QPkpNLt4XGF7dTZjV4Y7GvUvEjVlWYYrilab89BwZzHWjinsXRCG5aih9K9FXk42nNHKCv4kXWaoijcfhlsI2Jea/rz8dhBp/xtyazZqwHqHkbZRweZP1Rm5IOT9QAp1LWe1DS1Ef0nJgDEMob3jKfO6YFd3lJFcvyCPgk4PeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433621; c=relaxed/simple;
	bh=Wn62Zez1jdd7w4AVVJUjEc4EUS5oDZoivioEIfat5uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8W3+DfOyqXE+1x/oSnu15DHRi39+r3LpjxXSPR9MzBZYhSHjg6pIyWbgdGonDSAxdYRAGQhsEnzyOF64Jw/uaaGOP+QoGNolmoZp7xvZV+faRtN+W+QGnODNI11NF6vMl/c88m3iCCERtQMRJTCtX1F4CMj+n4jeo4vLnraPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd4FRocV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7869704so821218f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433617; x=1763038417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjtDkhHcJRxmLbo+3NnqG1n70KbrxmZUo5oVszYsvH4=;
        b=gd4FRocVNvDTcz6qPQrSEdwDKmDEKTtgqDpA+Oz5v9aDOcXWuKMrZc0hOh8njm7awe
         4QqTf/aIigxwakvL9XUMq6/vaejFmSb91PhJ7jFv5jVjnRSByufGXp7/9xN/4EVo9+o5
         Scb9o2U+TDbg8MS6GZXr1JpFigx2FaIW1FEtcsZgjmGFPdHI21UwoV23WnBezwWUuthb
         nntfdAKJ7z2sibNz3HWBhayWscM1sg8dlinIkoYdI1P+Z3WTJRmxFSQnkKxZVGpz3cqN
         jY1R5vu5YLI613ZUxyNlrTqWwcAGRmTz+jPXp/B5wWlI9EE0Ocsts5mamTLEUBVh9qql
         jdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433617; x=1763038417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjtDkhHcJRxmLbo+3NnqG1n70KbrxmZUo5oVszYsvH4=;
        b=vmquRmTBPAKT1bzXswUru3qa21+iOqjfDJIRUxMiCNU3bM81mE+O4BVp7keueZRgq2
         ZOyjM59TXdfMPhm5icU8ry4SJ9qHtWrtYYjtHbvFWKhzjA0cx8G6KROC68fjfEiNm8Zs
         paAXD9zzGL4lG7xZO2mvlL/iB6EctNAcUlW6XUAXGP/VcLJz8jgrjGStGPvGGfl7/MtT
         ff2aHXdwyilJ3cDraJr3ZnMjw+b4qGFa12wTw9ORyjS0N9r3JEZyBfiyhU6NeZ5ZLhCf
         jZ2lNK6AB21AvptoOQQd+3EW28rd7REJ02RXnfXmvpcJrbYwMN1+Bjj9t0WeOtR/Sh0C
         ltLA==
X-Gm-Message-State: AOJu0YzF2V5TsRjRfchX0l+qCCN74M1kOCrAvCtsbI01SAVYdbKDZu97
	uis4bkMZUi+J/E32g8pr9F8s/jw/SrzZnvrkRuXmZ6dNQPIVFLis35BsSaAO
X-Gm-Gg: ASbGncs00U8Hm/OKm0p3y9I3ANDxQ/b7nPsc93uGeMPQHhaXtmYHezxP4vxudxZE5ra
	HHtx6GKh30TEEtb1O9A63cRwasJMKRFY8sxHakt0huMsgIVqeIx8+zmOrU6ccbkthJmYMpAv6oF
	pk/690YJHUuhUI4/CbJgEdCh3nBjA4LhUUaQOAzmUc2n7IR514lluVLxBO1b5jsIRGR3Mht1DzD
	bTbt3d/dbDcAQ4Z1hDA/EAL3rSdar6/UAoTb/vz1jePy6+YoyiHnv8SwFZ76XAlyAWc3RZeHnHo
	mkgVpDYkD8Uruz5nPaXsoIKpH4v3zggdS/ZSWEEObPtKyY/CFVP5zZ61u3jlj4LMTib+Dr0I/tx
	bv3il78WzFJv1sWAacNPTwwuH6FpkwMtQb4iWVdDhvpmjB87lSEkjdvGKjPWT4lR7O/DV0Vb8jX
	l3qzTHDtKsBTcijG8TfaEAoPlFiv7PQiwT3OCtx0vFmv+AyY5oAOFWuWWMiv86Ra59Jg==
X-Google-Smtp-Source: AGHT+IGG+QFoVtb620WWFyrVxoAV2LS1/PGKzF2MVcldpxTRUrKcWwcJB+ZdIU69/0EzvgaWMLX4bQ==
X-Received: by 2002:a05:6000:4308:b0:429:be56:e508 with SMTP id ffacd0b85a97d-429e3311e53mr6100201f8f.58.1762433616900;
        Thu, 06 Nov 2025 04:53:36 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:36 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 02/17] bpf: Add bcf_checker top-level workflow
Date: Thu,  6 Nov 2025 13:52:40 +0100
Message-Id: <20251106125255.1969938-3-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the in-kernel BCF proof checker skeleton and public entry point.
The checker validates userspace proofs of refinement conditions.
Proof size hard limit: MAX_BCF_PROOF_SIZE 8M.

kernel/bpf/bcf_checker.c implements:
- Buffer/header validation (check_hdr): enforces BCF_MAGIC, size alignment,
  and overflow-safe size arithmetic for expr/step regions.

- Expression arena load (check_exprs):
  builds a bitmap of validated indices, enforces that each non-VAL argument
  points to an earlier index, stubs type_check() for future semantic checks,
  and records the arena size as the starting point for dynamic ids (id_gen).

- Step load/validation (check_steps): copies steps, verifies per-step size,
  rule class/id bounds via rule_class_max(), that all premises refer to
  strictly earlier steps, records the single ASSUME step (check_assume stub),
  computes last_ref for each step for lifetime mgmt, and requires every
  non-final step to be referenced later.

- Rule application loop (apply_rules): iterates steps in order, dispatches by
  rule class to apply_core_rule/apply_bool_rule/apply_bv_rule (stubs now),

- Memory management: bcf_checker_state owns copied arenas and per-step state;
  dynamically created exprs (facts) are ref-counted, and tracked in an xarray
  indexed by new ids >= expr_size, to be added in the next patch set.

Rule semantics, type checking, and integration with the verifier appear in
later patches; this change only defines the top-level checker structure.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 .clang-format               |   2 +
 include/linux/bcf_checker.h |  18 ++
 kernel/bpf/Makefile         |   2 +-
 kernel/bpf/bcf_checker.c    | 440 ++++++++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/bcf_checker.h
 create mode 100644 kernel/bpf/bcf_checker.c

diff --git a/.clang-format b/.clang-format
index f371a13b4d19..7f2f85bc4c1f 100644
--- a/.clang-format
+++ b/.clang-format
@@ -747,6 +747,8 @@ ForEachMacros:
   - 'ynl_attr_for_each_nested'
   - 'ynl_attr_for_each_payload'
   - 'zorro_for_each_dev'
+  - 'bcf_for_each_arg'
+  - 'bcf_for_each_pm_step'
 
 IncludeBlocks: Preserve
 IncludeCategories:
diff --git a/include/linux/bcf_checker.h b/include/linux/bcf_checker.h
new file mode 100644
index 000000000000..220552653c80
--- /dev/null
+++ b/include/linux/bcf_checker.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_BCF_CHECKER_H__
+#define __LINUX_BCF_CHECKER_H__
+
+#include <uapi/linux/bcf.h>
+#include <linux/stdarg.h>
+#include <linux/bpfptr.h>
+#include <linux/bpf_verifier.h> /* For log level. */
+
+#define MAX_BCF_PROOF_SIZE (8 * 1024 * 1024)
+
+typedef void (*bcf_logger_cb)(void *private, const char *fmt, va_list args);
+
+int bcf_check_proof(struct bcf_expr *goal_exprs, u32 goal, bpfptr_t proof,
+		    u32 proof_size, bcf_logger_cb logger, u32 level,
+		    void *private);
+
+#endif /* __LINUX_BCF_CHECKER_H__ */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7fd0badfacb1..5084a0a918e4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o bcf_checker.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/bcf_checker.c b/kernel/bpf/bcf_checker.c
new file mode 100644
index 000000000000..33b6e5f04e7f
--- /dev/null
+++ b/kernel/bpf/bcf_checker.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/overflow.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/cleanup.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include <linux/refcount.h>
+#include <linux/bitmap.h>
+#include <linux/sched/signal.h>
+#include <linux/sched.h>
+#include <linux/bcf_checker.h>
+
+/* Per proof step state. */
+struct bcf_step_state {
+	/* The conclusion of the current step. */
+	struct bcf_expr *fact;
+	u32 fact_id;
+	/*
+	 * The last step referring to the current step. After `last_ref`, the
+	 * `fact` is no longer used by any other steps and can be freed.
+	 */
+	u32 last_ref;
+};
+
+/*
+ * The expr buffer `exprs` below as well as `steps` rely on the fact that the
+ * size of each arg is the same as the size of the struct bcf_expr, and no
+ * padings in between and after.
+ */
+static_assert(struct_size_t(struct bcf_expr, args, 1) ==
+	      sizeof_field(struct bcf_expr, args[0]) * 2);
+static_assert(struct_size_t(struct bcf_proof_step, args, 1) ==
+	      sizeof_field(struct bcf_proof_step, args[0]) * 2);
+
+/* Size of expr/step in u32 plus the node itself */
+#define EXPR_SZ(expr) ((expr)->vlen + 1)
+#define STEP_SZ(step) ((step)->premise_cnt + (step)->param_cnt + 1)
+
+#define bcf_for_each_arg(arg_id, expr)                                   \
+	for (u32 ___i = 0;                                               \
+	     ___i < (expr)->vlen && (arg_id = (expr)->args[___i], true); \
+	     ___i++)
+
+#define bcf_for_each_pm_step(step_id, step)                      \
+	for (u32 ___i = 0; ___i < (step)->premise_cnt &&         \
+			   (step_id = (step)->args[___i], true); \
+	     ___i++)
+
+struct bcf_checker_state {
+	/*
+	 * Exprs from the proof, referred to as `static expr`. They exist
+	 * during the entire checking phase.
+	 */
+	struct bcf_expr *exprs;
+	/*
+	 * Each expr of `exprs` is followed by their arguments. The `valid_idx`
+	 * bitmap records the valid indices of exprs.
+	 */
+	unsigned long *valid_idx;
+	/* Size of exprs array. */
+	u32 expr_size;
+	/*
+	 * For exprs that are allocated dynamically during proof checking, e.g.,
+	 * conclusions from proof steps, they are refcounted, and each allocated
+	 * expr has an id (increased after `expr_size`) and is stored in xarray.
+	 *
+	 * With this xarray, any routines below can exit early on any error
+	 * without worrying about freeing the exprs allocated; they can be
+	 * freed once when freeing the xarray, see free_checker_state().
+	 */
+	u32 id_gen;
+	struct xarray expr_id_map; /* Id (u32) to `struct bcf_expr_ref` */
+
+	/* Step state tracking */
+	struct bcf_proof_step *steps;
+	struct bcf_step_state *step_state;
+	u32 step_size; /* size of steps array */
+	u32 step_cnt; /* valid number of steps */
+	u32 cur_step;
+	u32 cur_step_idx;
+
+	bcf_logger_cb logger;
+	void *logger_private;
+	u32 level;
+
+	u32 goal;
+	struct bcf_expr *goal_exprs;
+};
+
+static void free_checker_state(struct bcf_checker_state *st)
+{
+	unsigned long id;
+	void *expr;
+
+	kvfree(st->exprs);
+	kvfree(st->valid_idx);
+	xa_for_each(&st->expr_id_map, id, expr) {
+		kfree(expr);
+	}
+	xa_destroy(&st->expr_id_map);
+	kvfree(st->steps);
+	kvfree(st->step_state);
+
+	kfree(st);
+}
+DEFINE_FREE(free_checker, struct bcf_checker_state *,
+	    if (_T) free_checker_state(_T))
+
+__printf(2, 3) static void verbose(struct bcf_checker_state *st,
+				   const char *fmt, ...)
+{
+	va_list args;
+
+	if (!st->logger || !st->level)
+		return;
+	va_start(args, fmt);
+	st->logger(st->logger_private, fmt, args);
+	va_end(args);
+}
+
+/*
+ * Every expr has an id: (1) for static exprs, the idx to `exprs` is its id;
+ * (2) dynamically-allocated ones get one from st->id_gen++.
+ */
+static bool is_static_expr_id(struct bcf_checker_state *st, u32 id)
+{
+	return id < st->expr_size;
+}
+
+/*
+ * Each arg of a bcf_expr must be an id, except for bv_val, which is a
+ * sequence of u32 values.
+ */
+static bool expr_arg_is_id(u8 code)
+{
+	return code != (BCF_BV | BCF_VAL);
+}
+
+static bool is_false(const struct bcf_expr *expr)
+{
+	return expr->code == (BCF_BOOL | BCF_VAL) &&
+	       BCF_BOOL_LITERAL(expr->params) == BCF_FALSE;
+}
+
+/*
+ * Exprs referred to by the proof steps are static exprs from the proof.
+ * Hence, must be valid id in st->exprs.
+ */
+static bool valid_arg_id(struct bcf_checker_state *st, u32 id)
+{
+	return is_static_expr_id(st, id) && test_bit(id, st->valid_idx);
+}
+
+/*
+ * Rather than using:
+ *	if (!correct_condition0 or !correct_condition1)
+ *		return err;
+ * the `ENSURE` macro make this more readable:
+ *	ENSURE(c0 && c1);
+ */
+#define ENSURE(cond)                    \
+	do {                            \
+		if (!(cond))            \
+			return -EINVAL; \
+	} while (0)
+
+static int type_check(struct bcf_checker_state *st, struct bcf_expr *expr)
+{
+	return -EOPNOTSUPP;
+}
+
+static int check_exprs(struct bcf_checker_state *st, bpfptr_t bcf_buf,
+		       u32 expr_size)
+{
+	u32 idx = 0;
+	int err;
+
+	st->exprs =
+		kvmemdup_bpfptr(bcf_buf, expr_size * sizeof(struct bcf_expr));
+	if (IS_ERR(st->exprs)) {
+		err = PTR_ERR(st->exprs);
+		st->exprs = NULL;
+		return err;
+	}
+	st->expr_size = expr_size;
+	st->id_gen = expr_size;
+
+	st->valid_idx = kvzalloc(bitmap_size(expr_size), GFP_KERNEL);
+	if (!st->valid_idx) {
+		kvfree(st->exprs);
+		st->exprs = NULL;
+		return -ENOMEM;
+	}
+
+	while (idx < expr_size) {
+		struct bcf_expr *expr = st->exprs + idx;
+		u32 expr_sz = EXPR_SZ(expr), arg_id;
+
+		ENSURE(idx + expr_sz <= expr_size);
+
+		bcf_for_each_arg(arg_id, expr) {
+			if (!expr_arg_is_id(expr->code))
+				break;
+			/*
+			 * The bitmap enforces that each expr can refer only to
+			 * valid, previous exprs.
+			 */
+			ENSURE(valid_arg_id(st, arg_id));
+		}
+
+		err = type_check(st, expr);
+		if (err)
+			return err;
+
+		set_bit(idx, st->valid_idx);
+		idx += expr_sz;
+	}
+	ENSURE(idx == expr_size);
+
+	return 0;
+}
+
+static int check_assume(struct bcf_checker_state *st,
+			struct bcf_proof_step *step)
+{
+	return -EOPNOTSUPP;
+}
+
+static bool is_assume(u16 rule)
+{
+	return rule == (BCF_RULE_CORE | BCF_RULE_ASSUME);
+}
+
+static u16 rule_class_max(u16 rule)
+{
+	switch (BCF_RULE_CLASS(rule)) {
+	case BCF_RULE_CORE:
+		return __MAX_BCF_CORE_RULES;
+	case BCF_RULE_BOOL:
+		return __MAX_BCF_BOOL_RULES;
+	case BCF_RULE_BV:
+		return __MAX_BCF_BV_RULES;
+	default:
+		return 0;
+	}
+}
+
+static int check_steps(struct bcf_checker_state *st, bpfptr_t bcf_buf,
+		       u32 step_size)
+{
+	u32 pos = 0, cur_step = 0, rule, step_id;
+	struct bcf_proof_step *step;
+	bool goal_found = false;
+	int err;
+
+	st->steps = kvmemdup_bpfptr(bcf_buf,
+				    step_size * sizeof(struct bcf_proof_step));
+	if (IS_ERR(st->steps)) {
+		err = PTR_ERR(st->steps);
+		st->steps = NULL;
+		return err;
+	}
+	st->step_size = step_size;
+
+	/*
+	 * First pass: validate each step and count how many there are.  While
+	 * iterating we also ensure that premises only reference *earlier* steps.
+	 */
+	while (pos < step_size) {
+		step = st->steps + pos;
+		rule = BCF_STEP_RULE(step->rule);
+
+		ENSURE(pos + STEP_SZ(step) <= step_size);
+		ENSURE(rule && rule < rule_class_max(step->rule));
+
+		/* Every step must only refer to previous established steps */
+		bcf_for_each_pm_step(step_id, step)
+			ENSURE(step_id < cur_step);
+
+		/* Must introduce a goal that is consistent to the one required */
+		if (is_assume(step->rule)) {
+			ENSURE(!goal_found); /* only one goal intro step */
+			goal_found = true;
+
+			err = check_assume(st, step);
+			if (err)
+				return err;
+		}
+
+		pos += STEP_SZ(step);
+		cur_step++;
+	}
+
+	/* No trailing garbage and at least two valid steps. */
+	ENSURE(pos == step_size && cur_step >= 2 && goal_found);
+
+	st->step_cnt = cur_step;
+	st->step_state =
+		kvcalloc(cur_step, sizeof(*st->step_state), GFP_KERNEL);
+	if (!st->step_state) {
+		kvfree(st->steps);
+		st->steps = NULL;
+		return -ENOMEM;
+	}
+
+	/* Second pass: fill in last reference index for each step. */
+	for (pos = 0, cur_step = 0; pos < step_size; cur_step++) {
+		step = st->steps + pos;
+		bcf_for_each_pm_step(step_id, step)
+			st->step_state[step_id].last_ref = cur_step;
+
+		pos += STEP_SZ(step);
+	}
+
+	/*
+	 * Every step (except the last one) must be referenced by at
+	 * least one later step.
+	 */
+	for (cur_step = 0; cur_step < st->step_cnt - 1; cur_step++)
+		ENSURE(st->step_state[cur_step].last_ref);
+
+	return 0;
+}
+
+static int apply_core_rule(struct bcf_checker_state *st,
+			   struct bcf_proof_step *step)
+{
+	return -EOPNOTSUPP;
+}
+
+static int apply_bool_rule(struct bcf_checker_state *st,
+			   struct bcf_proof_step *step)
+{
+	return -EOPNOTSUPP;
+}
+
+static int apply_bv_rule(struct bcf_checker_state *st,
+			 struct bcf_proof_step *step)
+{
+	return -EOPNOTSUPP;
+}
+
+static int apply_rules(struct bcf_checker_state *st)
+{
+	struct bcf_expr *fact;
+	int err;
+
+	verbose(st, "checking %u proof steps\n", st->step_cnt);
+
+	while (st->cur_step_idx < st->step_size) {
+		struct bcf_proof_step *step = st->steps + st->cur_step_idx;
+		u16 class = BCF_RULE_CLASS(step->rule);
+
+		if (signal_pending(current))
+			return -EAGAIN;
+		if (need_resched())
+			cond_resched();
+
+		if (class == BCF_RULE_CORE)
+			err = apply_core_rule(st, step);
+		else if (class == BCF_RULE_BOOL)
+			err = apply_bool_rule(st, step);
+		else if (class == BCF_RULE_BV)
+			err = apply_bv_rule(st, step);
+		else {
+			WARN_ONCE(1, "Unknown rule class: %u", class);
+			err = -EFAULT;
+		}
+		if (err)
+			return err;
+
+		st->cur_step_idx += STEP_SZ(step);
+		st->cur_step++;
+	}
+
+	/* The last step must refute the goal by concluding `false` */
+	fact = st->step_state[st->step_cnt - 1].fact;
+	ENSURE(is_false(fact));
+	verbose(st, "proof accepted\n");
+
+	return 0;
+}
+
+static int check_hdr(struct bcf_proof_header *hdr, bpfptr_t proof,
+		     u32 proof_size)
+{
+	u32 expr_size, step_size, sz;
+	bool overflow = false;
+
+	ENSURE(proof_size < MAX_BCF_PROOF_SIZE && proof_size > sizeof(*hdr) &&
+	       (proof_size % sizeof(u32) == 0));
+
+	if (copy_from_bpfptr(hdr, proof, sizeof(*hdr)))
+		return -EFAULT;
+
+	ENSURE(hdr->magic == BCF_MAGIC && hdr->expr_cnt && hdr->step_cnt > 1);
+
+	overflow |= check_mul_overflow(hdr->expr_cnt, sizeof(struct bcf_expr),
+				       &expr_size);
+	overflow |= check_mul_overflow(
+		hdr->step_cnt, sizeof(struct bcf_proof_step), &step_size);
+	overflow |= check_add_overflow(expr_size, step_size, &sz);
+	ENSURE(!overflow && (proof_size - sizeof(*hdr)) == sz);
+
+	return 0;
+}
+
+int bcf_check_proof(struct bcf_expr *goal_exprs, u32 goal, bpfptr_t proof,
+		    u32 proof_size, bcf_logger_cb logger, u32 level,
+		    void *private)
+{
+	struct bcf_checker_state *st __free(free_checker) = NULL;
+	struct bcf_proof_header hdr;
+	int err;
+
+	err = check_hdr(&hdr, proof, proof_size);
+	if (err)
+		return err;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL_ACCOUNT);
+	if (!st)
+		return -ENOMEM;
+	xa_init(&st->expr_id_map);
+	st->goal_exprs = goal_exprs;
+	st->goal = goal;
+	st->logger = logger;
+	st->logger_private = private;
+	st->level = level;
+
+	bpfptr_add(&proof, sizeof(struct bcf_proof_header));
+	err = check_exprs(st, proof, hdr.expr_cnt);
+
+	bpfptr_add(&proof, hdr.expr_cnt * sizeof(struct bcf_expr));
+	err = err ?: check_steps(st, proof, hdr.step_cnt);
+	err = err ?: apply_rules(st);
+	return err;
+}
+EXPORT_SYMBOL_GPL(bcf_check_proof);
-- 
2.34.1


