Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65E34975F2
	for <lists+bpf@lfdr.de>; Sun, 23 Jan 2022 23:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiAWWTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 17:19:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240318AbiAWWTj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 Jan 2022 17:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642976378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tXEItSupQgFSC2afgoHIVdgndV87MLnEtCy5AB7b1BY=;
        b=QTiWf8JVHewf839+6IPKhJtW84nxVctHnl3kCJS7dqz9iCcol9U2xKUmvThknAFBWFgwRf
        E9H/vNd5q40XMI82+s3QrmfMfRzQJ7mOs/VuXXgNBHzwBKbxZdyweIoTzBFoQRhzp3Tii5
        UJbEslCVyOeIW7hjN68rvop2C//SjK8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-7aq8vRhBO8ysiuw9OdUM6g-1; Sun, 23 Jan 2022 17:19:37 -0500
X-MC-Unique: 7aq8vRhBO8ysiuw9OdUM6g-1
Received: by mail-ed1-f72.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso11902617ede.12
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 14:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXEItSupQgFSC2afgoHIVdgndV87MLnEtCy5AB7b1BY=;
        b=JZWQbAG29nTkiAU3xDPaktAFTnBK3iUxrkTLQvo8lLYSviSqG7On28udwQtHfO+EsA
         bajQfqLcNWnbQ93ynDyXIqHh/wdTAW/tuNbFuoiIEVtp570Vgb0s5LZ0plQnjlG4XbGV
         4ElAFATNQIx+RtmQ+cV6e7pxVLvzIiUyRfcY6ftIVWYFm8uMLEUDG3h8H4dgZ9gdAk15
         qH1efBO3VN/q04dNf2jqFPV0rGK0KbmEW8a3ed86/y7si1qoASPg1vktvb7LK2NRTNad
         P7yBfdzMY8P7GojCxeXsgkMrKBkZzBOElW/r6Y29mhxKmmsz3PVHLPQR2CuaORzrbgDz
         QphQ==
X-Gm-Message-State: AOAM53194EwB30qb+4j9RvPQBcxPd4Lcglhk+6B8D1rvoZvDKGvtTR+i
        sSdS86KAh8P8uZ+KSR49jESrNJw5FLhK0jDBJs6QVNGzHa6kPk/51+7tH67kWOFLgps9U8m0Uos
        3XlNDzpR2c41F
X-Received: by 2002:a17:907:20ad:: with SMTP id pw13mr10321126ejb.73.1642976375271;
        Sun, 23 Jan 2022 14:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkU2ceDDF5bTZdN3f1rZzG+ZozJVPhFxTq4LZ0Do6RGnxOWiKaQ6oD4Zt+2wryl5aLAFdBAw==
X-Received: by 2002:a17:907:20ad:: with SMTP id pw13mr10321106ejb.73.1642976374800;
        Sun, 23 Jan 2022 14:19:34 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id d2sm4210269ejw.70.2022.01.23.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:19:34 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: [PATCH 1/3] perf/bpf: Remove prologue generation
Date:   Sun, 23 Jan 2022 23:19:30 +0100
Message-Id: <20220123221932.537060-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Removing code for ebpf program prologue generation.

The prologue code was used to get data for extra arguments specified
in program section name, like:

  SEC("lock_page=__lock_page page->flags")
  int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
  {
         return 1;
  }

This code is using deprecated libbpf API and blocks its removal.

This feature was not documented and broken for some time without
anyone complaining, also original authors are not responding,
so I'm removing it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config     |  11 -
 tools/perf/builtin-record.c    |  14 -
 tools/perf/util/bpf-loader.c   | 242 +---------------
 tools/perf/util/bpf-prologue.c | 508 ---------------------------------
 tools/perf/util/bpf-prologue.h |  37 ---
 5 files changed, 1 insertion(+), 811 deletions(-)
 delete mode 100644 tools/perf/util/bpf-prologue.c
 delete mode 100644 tools/perf/util/bpf-prologue.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 96ad944ca6a8..d9ff537d999e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -556,17 +556,6 @@ ifndef NO_LIBELF
       endif
     endif
 
-    ifndef NO_DWARF
-      ifdef PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-        CFLAGS += -DHAVE_BPF_PROLOGUE
-        $(call detected,CONFIG_BPF_PROLOGUE)
-      else
-        msg := $(warning BPF prologue is not supported by architecture $(SRCARCH), missing regs_query_register_offset());
-      endif
-    else
-      msg := $(warning DWARF support is off, BPF prologue is disabled);
-    endif
-
   endif # NO_LIBBPF
 endif # NO_LIBELF
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bb716c953d02..1a8111fdff2e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2696,20 +2696,6 @@ int cmd_record(int argc, const char **argv)
 	set_nobuild('\0', "clang-path", true);
 	set_nobuild('\0', "clang-opt", true);
 # undef set_nobuild
-#endif
-
-#ifndef HAVE_BPF_PROLOGUE
-# if !defined (HAVE_DWARF_SUPPORT)
-#  define REASON  "NO_DWARF=1"
-# elif !defined (HAVE_LIBBPF_SUPPORT)
-#  define REASON  "NO_LIBBPF=1"
-# else
-#  define REASON  "this architecture doesn't support BPF prologue"
-# endif
-# define set_nobuild(s, l, c) set_option_nobuild(record_options, s, l, REASON, c)
-	set_nobuild('\0', "vmlinux", true);
-# undef set_nobuild
-# undef REASON
 #endif
 
 	rec->opts.affinity = PERF_AFFINITY_SYS;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 7ecfaac7536a..f9f329a48892 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -18,7 +18,6 @@
 #include "debug.h"
 #include "evlist.h"
 #include "bpf-loader.h"
-#include "bpf-prologue.h"
 #include "probe-event.h"
 #include "probe-finder.h" // for MAX_PROBES
 #include "parse-events.h"
@@ -43,10 +42,6 @@ struct bpf_prog_priv {
 	char *sys_name;
 	char *evt_name;
 	struct perf_probe_event pev;
-	bool need_prologue;
-	struct bpf_insn *insns_buf;
-	int nr_types;
-	int *type_mapping;
 };
 
 static bool libbpf_initialized;
@@ -128,8 +123,6 @@ clear_prog_priv(struct bpf_program *prog __maybe_unused,
 	struct bpf_prog_priv *priv = _priv;
 
 	cleanup_perf_probe_events(&priv->pev, 1);
-	zfree(&priv->insns_buf);
-	zfree(&priv->type_mapping);
 	zfree(&priv->sys_name);
 	zfree(&priv->evt_name);
 	free(priv);
@@ -412,220 +405,6 @@ static int bpf__prepare_probe(void)
 	return err;
 }
 
-static int
-preproc_gen_prologue(struct bpf_program *prog, int n,
-		     struct bpf_insn *orig_insns, int orig_insns_cnt,
-		     struct bpf_prog_prep_result *res)
-{
-	struct bpf_prog_priv *priv = bpf_program__priv(prog);
-	struct probe_trace_event *tev;
-	struct perf_probe_event *pev;
-	struct bpf_insn *buf;
-	size_t prologue_cnt = 0;
-	int i, err;
-
-	if (IS_ERR_OR_NULL(priv) || priv->is_tp)
-		goto errout;
-
-	pev = &priv->pev;
-
-	if (n < 0 || n >= priv->nr_types)
-		goto errout;
-
-	/* Find a tev belongs to that type */
-	for (i = 0; i < pev->ntevs; i++) {
-		if (priv->type_mapping[i] == n)
-			break;
-	}
-
-	if (i >= pev->ntevs) {
-		pr_debug("Internal error: prologue type %d not found\n", n);
-		return -BPF_LOADER_ERRNO__PROLOGUE;
-	}
-
-	tev = &pev->tevs[i];
-
-	buf = priv->insns_buf;
-	err = bpf__gen_prologue(tev->args, tev->nargs,
-				buf, &prologue_cnt,
-				BPF_MAXINSNS - orig_insns_cnt);
-	if (err) {
-		const char *title;
-
-		title = bpf_program__section_name(prog);
-		pr_debug("Failed to generate prologue for program %s\n",
-			 title);
-		return err;
-	}
-
-	memcpy(&buf[prologue_cnt], orig_insns,
-	       sizeof(struct bpf_insn) * orig_insns_cnt);
-
-	res->new_insn_ptr = buf;
-	res->new_insn_cnt = prologue_cnt + orig_insns_cnt;
-	res->pfd = NULL;
-	return 0;
-
-errout:
-	pr_debug("Internal error in preproc_gen_prologue\n");
-	return -BPF_LOADER_ERRNO__PROLOGUE;
-}
-
-/*
- * compare_tev_args is reflexive, transitive and antisymmetric.
- * I can proof it but this margin is too narrow to contain.
- */
-static int compare_tev_args(const void *ptev1, const void *ptev2)
-{
-	int i, ret;
-	const struct probe_trace_event *tev1 =
-		*(const struct probe_trace_event **)ptev1;
-	const struct probe_trace_event *tev2 =
-		*(const struct probe_trace_event **)ptev2;
-
-	ret = tev2->nargs - tev1->nargs;
-	if (ret)
-		return ret;
-
-	for (i = 0; i < tev1->nargs; i++) {
-		struct probe_trace_arg *arg1, *arg2;
-		struct probe_trace_arg_ref *ref1, *ref2;
-
-		arg1 = &tev1->args[i];
-		arg2 = &tev2->args[i];
-
-		ret = strcmp(arg1->value, arg2->value);
-		if (ret)
-			return ret;
-
-		ref1 = arg1->ref;
-		ref2 = arg2->ref;
-
-		while (ref1 && ref2) {
-			ret = ref2->offset - ref1->offset;
-			if (ret)
-				return ret;
-
-			ref1 = ref1->next;
-			ref2 = ref2->next;
-		}
-
-		if (ref1 || ref2)
-			return ref2 ? 1 : -1;
-	}
-
-	return 0;
-}
-
-/*
- * Assign a type number to each tevs in a pev.
- * mapping is an array with same slots as tevs in that pev.
- * nr_types will be set to number of types.
- */
-static int map_prologue(struct perf_probe_event *pev, int *mapping,
-			int *nr_types)
-{
-	int i, type = 0;
-	struct probe_trace_event **ptevs;
-
-	size_t array_sz = sizeof(*ptevs) * pev->ntevs;
-
-	ptevs = malloc(array_sz);
-	if (!ptevs) {
-		pr_debug("Not enough memory: alloc ptevs failed\n");
-		return -ENOMEM;
-	}
-
-	pr_debug("In map_prologue, ntevs=%d\n", pev->ntevs);
-	for (i = 0; i < pev->ntevs; i++)
-		ptevs[i] = &pev->tevs[i];
-
-	qsort(ptevs, pev->ntevs, sizeof(*ptevs),
-	      compare_tev_args);
-
-	for (i = 0; i < pev->ntevs; i++) {
-		int n;
-
-		n = ptevs[i] - pev->tevs;
-		if (i == 0) {
-			mapping[n] = type;
-			pr_debug("mapping[%d]=%d\n", n, type);
-			continue;
-		}
-
-		if (compare_tev_args(ptevs + i, ptevs + i - 1) == 0)
-			mapping[n] = type;
-		else
-			mapping[n] = ++type;
-
-		pr_debug("mapping[%d]=%d\n", n, mapping[n]);
-	}
-	free(ptevs);
-	*nr_types = type + 1;
-
-	return 0;
-}
-
-static int hook_load_preprocessor(struct bpf_program *prog)
-{
-	struct bpf_prog_priv *priv = bpf_program__priv(prog);
-	struct perf_probe_event *pev;
-	bool need_prologue = false;
-	int err, i;
-
-	if (IS_ERR_OR_NULL(priv)) {
-		pr_debug("Internal error when hook preprocessor\n");
-		return -BPF_LOADER_ERRNO__INTERNAL;
-	}
-
-	if (priv->is_tp) {
-		priv->need_prologue = false;
-		return 0;
-	}
-
-	pev = &priv->pev;
-	for (i = 0; i < pev->ntevs; i++) {
-		struct probe_trace_event *tev = &pev->tevs[i];
-
-		if (tev->nargs > 0) {
-			need_prologue = true;
-			break;
-		}
-	}
-
-	/*
-	 * Since all tevs don't have argument, we don't need generate
-	 * prologue.
-	 */
-	if (!need_prologue) {
-		priv->need_prologue = false;
-		return 0;
-	}
-
-	priv->need_prologue = true;
-	priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
-	if (!priv->insns_buf) {
-		pr_debug("Not enough memory: alloc insns_buf failed\n");
-		return -ENOMEM;
-	}
-
-	priv->type_mapping = malloc(sizeof(int) * pev->ntevs);
-	if (!priv->type_mapping) {
-		pr_debug("Not enough memory: alloc type_mapping failed\n");
-		return -ENOMEM;
-	}
-	memset(priv->type_mapping, -1,
-	       sizeof(int) * pev->ntevs);
-
-	err = map_prologue(pev, priv->type_mapping, &priv->nr_types);
-	if (err)
-		return err;
-
-	err = bpf_program__set_prep(prog, priv->nr_types,
-				    preproc_gen_prologue);
-	return err;
-}
-
 int bpf__probe(struct bpf_object *obj)
 {
 	int err = 0;
@@ -672,18 +451,6 @@ int bpf__probe(struct bpf_object *obj)
 			pr_debug("bpf_probe: failed to apply perf probe events\n");
 			goto out;
 		}
-
-		/*
-		 * After probing, let's consider prologue, which
-		 * adds program fetcher to BPF programs.
-		 *
-		 * hook_load_preprocessor() hooks pre-processor
-		 * to bpf_program, let it generate prologue
-		 * dynamically during loading.
-		 */
-		err = hook_load_preprocessor(prog);
-		if (err)
-			goto out;
 	}
 out:
 	return err < 0 ? err : 0;
@@ -776,14 +543,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 		for (i = 0; i < pev->ntevs; i++) {
 			tev = &pev->tevs[i];
 
-			if (priv->need_prologue) {
-				int type = priv->type_mapping[i];
-
-				fd = bpf_program__nth_fd(prog, type);
-			} else {
-				fd = bpf_program__fd(prog);
-			}
-
+			fd = bpf_program__fd(prog);
 			if (fd < 0) {
 				pr_debug("bpf: failed to get file descriptor\n");
 				return fd;
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
deleted file mode 100644
index 9887ae09242d..000000000000
--- a/tools/perf/util/bpf-prologue.c
+++ /dev/null
@@ -1,508 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * bpf-prologue.c
- *
- * Copyright (C) 2015 He Kuang <hekuang@huawei.com>
- * Copyright (C) 2015 Wang Nan <wangnan0@huawei.com>
- * Copyright (C) 2015 Huawei Inc.
- */
-
-#include <bpf/libbpf.h>
-#include "debug.h"
-#include "bpf-loader.h"
-#include "bpf-prologue.h"
-#include "probe-finder.h"
-#include <errno.h>
-#include <stdlib.h>
-#include <dwarf-regs.h>
-#include <linux/filter.h>
-
-#define BPF_REG_SIZE		8
-
-#define JMP_TO_ERROR_CODE	-1
-#define JMP_TO_SUCCESS_CODE	-2
-#define JMP_TO_USER_CODE	-3
-
-struct bpf_insn_pos {
-	struct bpf_insn *begin;
-	struct bpf_insn *end;
-	struct bpf_insn *pos;
-};
-
-static inline int
-pos_get_cnt(struct bpf_insn_pos *pos)
-{
-	return pos->pos - pos->begin;
-}
-
-static int
-append_insn(struct bpf_insn new_insn, struct bpf_insn_pos *pos)
-{
-	if (!pos->pos)
-		return -BPF_LOADER_ERRNO__PROLOGUE2BIG;
-
-	if (pos->pos + 1 >= pos->end) {
-		pr_err("bpf prologue: prologue too long\n");
-		pos->pos = NULL;
-		return -BPF_LOADER_ERRNO__PROLOGUE2BIG;
-	}
-
-	*(pos->pos)++ = new_insn;
-	return 0;
-}
-
-static int
-check_pos(struct bpf_insn_pos *pos)
-{
-	if (!pos->pos || pos->pos >= pos->end)
-		return -BPF_LOADER_ERRNO__PROLOGUE2BIG;
-	return 0;
-}
-
-/*
- * Convert type string (u8/u16/u32/u64/s8/s16/s32/s64 ..., see
- * Documentation/trace/kprobetrace.rst) to size field of BPF_LDX_MEM
- * instruction (BPF_{B,H,W,DW}).
- */
-static int
-argtype_to_ldx_size(const char *type)
-{
-	int arg_size = type ? atoi(&type[1]) : 64;
-
-	switch (arg_size) {
-	case 8:
-		return BPF_B;
-	case 16:
-		return BPF_H;
-	case 32:
-		return BPF_W;
-	case 64:
-	default:
-		return BPF_DW;
-	}
-}
-
-static const char *
-insn_sz_to_str(int insn_sz)
-{
-	switch (insn_sz) {
-	case BPF_B:
-		return "BPF_B";
-	case BPF_H:
-		return "BPF_H";
-	case BPF_W:
-		return "BPF_W";
-	case BPF_DW:
-		return "BPF_DW";
-	default:
-		return "UNKNOWN";
-	}
-}
-
-/* Give it a shorter name */
-#define ins(i, p) append_insn((i), (p))
-
-/*
- * Give a register name (in 'reg'), generate instruction to
- * load register into an eBPF register rd:
- *   'ldd target_reg, offset(ctx_reg)', where:
- * ctx_reg is pre initialized to pointer of 'struct pt_regs'.
- */
-static int
-gen_ldx_reg_from_ctx(struct bpf_insn_pos *pos, int ctx_reg,
-		     const char *reg, int target_reg)
-{
-	int offset = regs_query_register_offset(reg);
-
-	if (offset < 0) {
-		pr_err("bpf: prologue: failed to get register %s\n",
-		       reg);
-		return offset;
-	}
-	ins(BPF_LDX_MEM(BPF_DW, target_reg, ctx_reg, offset), pos);
-
-	return check_pos(pos);
-}
-
-/*
- * Generate a BPF_FUNC_probe_read function call.
- *
- * src_base_addr_reg is a register holding base address,
- * dst_addr_reg is a register holding dest address (on stack),
- * result is:
- *
- *  *[dst_addr_reg] = *([src_base_addr_reg] + offset)
- *
- * Arguments of BPF_FUNC_probe_read:
- *     ARG1: ptr to stack (dest)
- *     ARG2: size (8)
- *     ARG3: unsafe ptr (src)
- */
-static int
-gen_read_mem(struct bpf_insn_pos *pos,
-	     int src_base_addr_reg,
-	     int dst_addr_reg,
-	     long offset,
-	     int probeid)
-{
-	/* mov arg3, src_base_addr_reg */
-	if (src_base_addr_reg != BPF_REG_ARG3)
-		ins(BPF_MOV64_REG(BPF_REG_ARG3, src_base_addr_reg), pos);
-	/* add arg3, #offset */
-	if (offset)
-		ins(BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG3, offset), pos);
-
-	/* mov arg2, #reg_size */
-	ins(BPF_ALU64_IMM(BPF_MOV, BPF_REG_ARG2, BPF_REG_SIZE), pos);
-
-	/* mov arg1, dst_addr_reg */
-	if (dst_addr_reg != BPF_REG_ARG1)
-		ins(BPF_MOV64_REG(BPF_REG_ARG1, dst_addr_reg), pos);
-
-	/* Call probe_read  */
-	ins(BPF_EMIT_CALL(probeid), pos);
-	/*
-	 * Error processing: if read fail, goto error code,
-	 * will be relocated. Target should be the start of
-	 * error processing code.
-	 */
-	ins(BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, JMP_TO_ERROR_CODE),
-	    pos);
-
-	return check_pos(pos);
-}
-
-/*
- * Each arg should be bare register. Fetch and save them into argument
- * registers (r3 - r5).
- *
- * BPF_REG_1 should have been initialized with pointer to
- * 'struct pt_regs'.
- */
-static int
-gen_prologue_fastpath(struct bpf_insn_pos *pos,
-		      struct probe_trace_arg *args, int nargs)
-{
-	int i, err = 0;
-
-	for (i = 0; i < nargs; i++) {
-		err = gen_ldx_reg_from_ctx(pos, BPF_REG_1, args[i].value,
-					   BPF_PROLOGUE_START_ARG_REG + i);
-		if (err)
-			goto errout;
-	}
-
-	return check_pos(pos);
-errout:
-	return err;
-}
-
-/*
- * Slow path:
- *   At least one argument has the form of 'offset($rx)'.
- *
- * Following code first stores them into stack, then loads all of then
- * to r2 - r5.
- * Before final loading, the final result should be:
- *
- * low address
- * BPF_REG_FP - 24  ARG3
- * BPF_REG_FP - 16  ARG2
- * BPF_REG_FP - 8   ARG1
- * BPF_REG_FP
- * high address
- *
- * For each argument (described as: offn(...off2(off1(reg)))),
- * generates following code:
- *
- *  r7 <- fp
- *  r7 <- r7 - stack_offset  // Ideal code should initialize r7 using
- *                           // fp before generating args. However,
- *                           // eBPF won't regard r7 as stack pointer
- *                           // if it is generated by minus 8 from
- *                           // another stack pointer except fp.
- *                           // This is why we have to set r7
- *                           // to fp for each variable.
- *  r3 <- value of 'reg'-> generated using gen_ldx_reg_from_ctx()
- *  (r7) <- r3       // skip following instructions for bare reg
- *  r3 <- r3 + off1  . // skip if off1 == 0
- *  r2 <- 8           \
- *  r1 <- r7           |-> generated by gen_read_mem()
- *  call probe_read    /
- *  jnei r0, 0, err  ./
- *  r3 <- (r7)
- *  r3 <- r3 + off2  . // skip if off2 == 0
- *  r2 <- 8           \  // r2 may be broken by probe_read, so set again
- *  r1 <- r7           |-> generated by gen_read_mem()
- *  call probe_read    /
- *  jnei r0, 0, err  ./
- *  ...
- */
-static int
-gen_prologue_slowpath(struct bpf_insn_pos *pos,
-		      struct probe_trace_arg *args, int nargs)
-{
-	int err, i, probeid;
-
-	for (i = 0; i < nargs; i++) {
-		struct probe_trace_arg *arg = &args[i];
-		const char *reg = arg->value;
-		struct probe_trace_arg_ref *ref = NULL;
-		int stack_offset = (i + 1) * -8;
-
-		pr_debug("prologue: fetch arg %d, base reg is %s\n",
-			 i, reg);
-
-		/* value of base register is stored into ARG3 */
-		err = gen_ldx_reg_from_ctx(pos, BPF_REG_CTX, reg,
-					   BPF_REG_ARG3);
-		if (err) {
-			pr_err("prologue: failed to get offset of register %s\n",
-			       reg);
-			goto errout;
-		}
-
-		/* Make r7 the stack pointer. */
-		ins(BPF_MOV64_REG(BPF_REG_7, BPF_REG_FP), pos);
-		/* r7 += -8 */
-		ins(BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, stack_offset), pos);
-		/*
-		 * Store r3 (base register) onto stack
-		 * Ensure fp[offset] is set.
-		 * fp is the only valid base register when storing
-		 * into stack. We are not allowed to use r7 as base
-		 * register here.
-		 */
-		ins(BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_ARG3,
-				stack_offset), pos);
-
-		ref = arg->ref;
-		probeid = BPF_FUNC_probe_read_kernel;
-		while (ref) {
-			pr_debug("prologue: arg %d: offset %ld\n",
-				 i, ref->offset);
-
-			if (ref->user_access)
-				probeid = BPF_FUNC_probe_read_user;
-
-			err = gen_read_mem(pos, BPF_REG_3, BPF_REG_7,
-					   ref->offset, probeid);
-			if (err) {
-				pr_err("prologue: failed to generate probe_read function call\n");
-				goto errout;
-			}
-
-			ref = ref->next;
-			/*
-			 * Load previous result into ARG3. Use
-			 * BPF_REG_FP instead of r7 because verifier
-			 * allows FP based addressing only.
-			 */
-			if (ref)
-				ins(BPF_LDX_MEM(BPF_DW, BPF_REG_ARG3,
-						BPF_REG_FP, stack_offset), pos);
-		}
-	}
-
-	/* Final pass: read to registers */
-	for (i = 0; i < nargs; i++) {
-		int insn_sz = (args[i].ref) ? argtype_to_ldx_size(args[i].type) : BPF_DW;
-
-		pr_debug("prologue: load arg %d, insn_sz is %s\n",
-			 i, insn_sz_to_str(insn_sz));
-		ins(BPF_LDX_MEM(insn_sz, BPF_PROLOGUE_START_ARG_REG + i,
-				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
-	}
-
-	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
-
-	return check_pos(pos);
-errout:
-	return err;
-}
-
-static int
-prologue_relocate(struct bpf_insn_pos *pos, struct bpf_insn *error_code,
-		  struct bpf_insn *success_code, struct bpf_insn *user_code)
-{
-	struct bpf_insn *insn;
-
-	if (check_pos(pos))
-		return -BPF_LOADER_ERRNO__PROLOGUE2BIG;
-
-	for (insn = pos->begin; insn < pos->pos; insn++) {
-		struct bpf_insn *target;
-		u8 class = BPF_CLASS(insn->code);
-		u8 opcode;
-
-		if (class != BPF_JMP)
-			continue;
-		opcode = BPF_OP(insn->code);
-		if (opcode == BPF_CALL)
-			continue;
-
-		switch (insn->off) {
-		case JMP_TO_ERROR_CODE:
-			target = error_code;
-			break;
-		case JMP_TO_SUCCESS_CODE:
-			target = success_code;
-			break;
-		case JMP_TO_USER_CODE:
-			target = user_code;
-			break;
-		default:
-			pr_err("bpf prologue: internal error: relocation failed\n");
-			return -BPF_LOADER_ERRNO__PROLOGUE;
-		}
-
-		insn->off = target - (insn + 1);
-	}
-	return 0;
-}
-
-int bpf__gen_prologue(struct probe_trace_arg *args, int nargs,
-		      struct bpf_insn *new_prog, size_t *new_cnt,
-		      size_t cnt_space)
-{
-	struct bpf_insn *success_code = NULL;
-	struct bpf_insn *error_code = NULL;
-	struct bpf_insn *user_code = NULL;
-	struct bpf_insn_pos pos;
-	bool fastpath = true;
-	int err = 0, i;
-
-	if (!new_prog || !new_cnt)
-		return -EINVAL;
-
-	if (cnt_space > BPF_MAXINSNS)
-		cnt_space = BPF_MAXINSNS;
-
-	pos.begin = new_prog;
-	pos.end = new_prog + cnt_space;
-	pos.pos = new_prog;
-
-	if (!nargs) {
-		ins(BPF_ALU64_IMM(BPF_MOV, BPF_PROLOGUE_FETCH_RESULT_REG, 0),
-		    &pos);
-
-		if (check_pos(&pos))
-			goto errout;
-
-		*new_cnt = pos_get_cnt(&pos);
-		return 0;
-	}
-
-	if (nargs > BPF_PROLOGUE_MAX_ARGS) {
-		pr_warning("bpf: prologue: %d arguments are dropped\n",
-			   nargs - BPF_PROLOGUE_MAX_ARGS);
-		nargs = BPF_PROLOGUE_MAX_ARGS;
-	}
-
-	/* First pass: validation */
-	for (i = 0; i < nargs; i++) {
-		struct probe_trace_arg_ref *ref = args[i].ref;
-
-		if (args[i].value[0] == '@') {
-			/* TODO: fetch global variable */
-			pr_err("bpf: prologue: global %s%+ld not support\n",
-				args[i].value, ref ? ref->offset : 0);
-			return -ENOTSUP;
-		}
-
-		while (ref) {
-			/* fastpath is true if all args has ref == NULL */
-			fastpath = false;
-
-			/*
-			 * Instruction encodes immediate value using
-			 * s32, ref->offset is long. On systems which
-			 * can't fill long in s32, refuse to process if
-			 * ref->offset too large (or small).
-			 */
-#ifdef __LP64__
-#define OFFSET_MAX	((1LL << 31) - 1)
-#define OFFSET_MIN	((1LL << 31) * -1)
-			if (ref->offset > OFFSET_MAX ||
-					ref->offset < OFFSET_MIN) {
-				pr_err("bpf: prologue: offset out of bound: %ld\n",
-				       ref->offset);
-				return -BPF_LOADER_ERRNO__PROLOGUEOOB;
-			}
-#endif
-			ref = ref->next;
-		}
-	}
-	pr_debug("prologue: pass validation\n");
-
-	if (fastpath) {
-		/* If all variables are registers... */
-		pr_debug("prologue: fast path\n");
-		err = gen_prologue_fastpath(&pos, args, nargs);
-		if (err)
-			goto errout;
-	} else {
-		pr_debug("prologue: slow path\n");
-
-		/* Initialization: move ctx to a callee saved register. */
-		ins(BPF_MOV64_REG(BPF_REG_CTX, BPF_REG_ARG1), &pos);
-
-		err = gen_prologue_slowpath(&pos, args, nargs);
-		if (err)
-			goto errout;
-		/*
-		 * start of ERROR_CODE (only slow pass needs error code)
-		 *   mov r2 <- 1  // r2 is error number
-		 *   mov r3 <- 0  // r3, r4... should be touched or
-		 *                // verifier would complain
-		 *   mov r4 <- 0
-		 *   ...
-		 *   goto usercode
-		 */
-		error_code = pos.pos;
-		ins(BPF_ALU64_IMM(BPF_MOV, BPF_PROLOGUE_FETCH_RESULT_REG, 1),
-		    &pos);
-
-		for (i = 0; i < nargs; i++)
-			ins(BPF_ALU64_IMM(BPF_MOV,
-					  BPF_PROLOGUE_START_ARG_REG + i,
-					  0),
-			    &pos);
-		ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_USER_CODE),
-				&pos);
-	}
-
-	/*
-	 * start of SUCCESS_CODE:
-	 *   mov r2 <- 0
-	 *   goto usercode  // skip
-	 */
-	success_code = pos.pos;
-	ins(BPF_ALU64_IMM(BPF_MOV, BPF_PROLOGUE_FETCH_RESULT_REG, 0), &pos);
-
-	/*
-	 * start of USER_CODE:
-	 *   Restore ctx to r1
-	 */
-	user_code = pos.pos;
-	if (!fastpath) {
-		/*
-		 * Only slow path needs restoring of ctx. In fast path,
-		 * register are loaded directly from r1.
-		 */
-		ins(BPF_MOV64_REG(BPF_REG_ARG1, BPF_REG_CTX), &pos);
-		err = prologue_relocate(&pos, error_code, success_code,
-					user_code);
-		if (err)
-			goto errout;
-	}
-
-	err = check_pos(&pos);
-	if (err)
-		goto errout;
-
-	*new_cnt = pos_get_cnt(&pos);
-	return 0;
-errout:
-	return err;
-}
diff --git a/tools/perf/util/bpf-prologue.h b/tools/perf/util/bpf-prologue.h
deleted file mode 100644
index c50c7358009f..000000000000
--- a/tools/perf/util/bpf-prologue.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2015, He Kuang <hekuang@huawei.com>
- * Copyright (C) 2015, Huawei Inc.
- */
-#ifndef __BPF_PROLOGUE_H
-#define __BPF_PROLOGUE_H
-
-#include <linux/compiler.h>
-#include <linux/filter.h>
-#include "probe-event.h"
-
-#define BPF_PROLOGUE_MAX_ARGS 3
-#define BPF_PROLOGUE_START_ARG_REG BPF_REG_3
-#define BPF_PROLOGUE_FETCH_RESULT_REG BPF_REG_2
-
-#ifdef HAVE_BPF_PROLOGUE
-int bpf__gen_prologue(struct probe_trace_arg *args, int nargs,
-		      struct bpf_insn *new_prog, size_t *new_cnt,
-		      size_t cnt_space);
-#else
-#include <errno.h>
-
-static inline int
-bpf__gen_prologue(struct probe_trace_arg *args __maybe_unused,
-		  int nargs __maybe_unused,
-		  struct bpf_insn *new_prog __maybe_unused,
-		  size_t *new_cnt,
-		  size_t cnt_space __maybe_unused)
-{
-	if (!new_cnt)
-		return -EINVAL;
-	*new_cnt = 0;
-	return -ENOTSUP;
-}
-#endif
-#endif /* __BPF_PROLOGUE_H */
-- 
2.34.1

