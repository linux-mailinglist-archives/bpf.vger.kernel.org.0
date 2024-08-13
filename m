Return-Path: <bpf+bounces-37076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8665950C89
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A301C21F0E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816341A4F22;
	Tue, 13 Aug 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SA4zHMBU"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6A1A38F3
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575009; cv=none; b=tYtswZSHPbRnfyiGf0cJWxp+F6IhwD4vGRUpRJC+CaLv/R4uGHs8R5puK0sEqXBBy9Xv0NYGKB0hhKW1m+yXRBydnv9yIL5Yk6Wh+8/xYS+kRDoWKnmXYj620hnx5btj2rOQ8/Dy54uBAur3HP8f6UlgKJWMl/etFKA9C/6B8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575009; c=relaxed/simple;
	bh=uz8So6SUo0sr548lwQw+WAuLUgYUjcnUBFVsq33o9Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8307o+3Lyxua9ydbavLF+OOBQwM75kqtOLWnfmAz0+ZDrR83yiGYtxUSR9/Bbod60XoVi68Ngd5QNq1TT3BePXK6CJdBayNiCVQASOqhvdF/9Z2kjTaXIlSe0j1I6kxJ6kRZeT81Hf/nI2tU4KrmU11nbbCyi6URV+ub8fc1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SA4zHMBU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723575005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrNjme+CrgULDqDJJQjj2SGh+l76UDKL/LsE2MqOgcc=;
	b=SA4zHMBUdFeMhKJRIHKNS9gbuSkMluew2RFTj9zi5q7CTG9/QJRsbl8Egc9GxrUo86xemx
	YABQaTnYCjV2FxfroXx98Yuzva0yQweLw0ALO2B8BfPB+XPLIpXKHZU49yOuGlGWJuISCz
	YnEwB82KS85kNoQBtlSEVd4hnTPtHKs=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 4/6] bpf: Add module parameter to gen_prologue and gen_epilogue
Date: Tue, 13 Aug 2024 11:49:37 -0700
Message-ID: <20240813184943.3759630-5-martin.lau@linux.dev>
In-Reply-To: <20240813184943.3759630-1-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a "struct module **module" arg to the .gen_prologue
and .gen_epilogue. This will allow the .gen_pro/epilogue to
make kfunc call because the verifer needs to know the kfunc's BTF.
The next patch will figure the kfunc's BTF from the module.
It also exposes the "btf_get_module_btf" function to help
figuring out the btf from a module.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h                                   | 4 ++--
 include/linux/btf.h                                   | 1 +
 kernel/bpf/btf.c                                      | 2 +-
 kernel/bpf/cgroup.c                                   | 3 ++-
 kernel/bpf/verifier.c                                 | 4 ++--
 net/core/filter.c                                     | 6 +++---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 4 ++--
 7 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2de67bc497f4..9787532813e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -973,9 +973,9 @@ struct bpf_verifier_ops {
 				const struct bpf_prog *prog,
 				struct bpf_insn_access_aux *info);
 	int (*gen_prologue)(struct bpf_insn *insn, bool direct_write,
-			    const struct bpf_prog *prog);
+			    const struct bpf_prog *prog, struct module **module);
 	int (*gen_epilogue)(struct bpf_insn *insn, const struct bpf_prog *prog,
-			    s16 ctx_stack_off);
+			    s16 ctx_stack_off, struct module **module);
 	int (*gen_ld_abs)(const struct bpf_insn *orig,
 			  struct bpf_insn *insn_buf);
 	u32 (*convert_ctx_access)(enum bpf_access_type type,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..177187fa3819 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -580,6 +580,7 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
+struct btf *btf_get_module_btf(const struct module *module);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..b230f7ff9388 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7970,7 +7970,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..0be053d86b56 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2503,7 +2503,8 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 
 static int cg_sockopt_get_prologue(struct bpf_insn *insn_buf,
 				   bool direct_write,
-				   const struct bpf_prog *prog)
+				   const struct bpf_prog *prog,
+				   struct module **module)
 {
 	/* Nothing to do for sockopt argument. The data is kzalloc'ated.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bbb655f0c7b5..5e995b7884fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19622,7 +19622,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	if (ops->gen_epilogue) {
 		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
-						 -(subprogs[0].stack_depth + 8));
+						 -(subprogs[0].stack_depth + 8), NULL);
 		if (epilogue_cnt >= ARRAY_SIZE(epilogue_buf)) {
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
@@ -19647,7 +19647,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog);
+					env->prog, NULL);
 		if (cnt >= ARRAY_SIZE(insn_buf)) {
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..65d219e71ae8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8844,7 +8844,7 @@ static bool sock_filter_is_valid_access(int off, int size,
 }
 
 static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
-			     const struct bpf_prog *prog)
+			     const struct bpf_prog *prog, struct module **module)
 {
 	/* Neither direct read nor direct write requires any preliminary
 	 * action.
@@ -8927,7 +8927,7 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 }
 
 static int tc_cls_act_prologue(struct bpf_insn *insn_buf, bool direct_write,
-			       const struct bpf_prog *prog)
+			       const struct bpf_prog *prog, struct module **module)
 {
 	return bpf_unclone_prologue(insn_buf, direct_write, prog, TC_ACT_SHOT);
 }
@@ -9263,7 +9263,7 @@ static bool sock_ops_is_valid_access(int off, int size,
 }
 
 static int sk_skb_prologue(struct bpf_insn *insn_buf, bool direct_write,
-			   const struct bpf_prog *prog)
+			   const struct bpf_prog *prog, struct module **module)
 {
 	return bpf_unclone_prologue(insn_buf, direct_write, prog, SK_DROP);
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 7194330bdefc..4c75346376d9 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1141,7 +1141,7 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 }
 
 static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
-			       const struct bpf_prog *prog)
+			       const struct bpf_prog *prog, struct module **module)
 {
 	struct bpf_insn *insn = insn_buf;
 
@@ -1164,7 +1164,7 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 }
 
 static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
-			       s16 ctx_stack_off)
+			       s16 ctx_stack_off, struct module **module)
 {
 	struct bpf_insn *insn = insn_buf;
 
-- 
2.43.5


