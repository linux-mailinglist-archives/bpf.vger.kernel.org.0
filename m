Return-Path: <bpf+bounces-38472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE996517C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DA31C223C6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECF1B9B32;
	Thu, 29 Aug 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GUEF/XH8"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413418C015
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965734; cv=none; b=lrZab4EBUKcxaf6KietBk2OdbJgUFX105xRix4MNAbtauRlVf0jTG0JTvOzW/J+cc5BGYCASEIBOpMm6qyS7P2tcBmS9C8UFJxP+oV/QyHsNr7xx+THxB2KrrvmF65fB8mmknWikEa6Gy2Jro31dw9SmfQGVD3zuF79I4McwxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965734; c=relaxed/simple;
	bh=72hM8Q/c4OY02Z9UpA3q3CVpE5x0KeQ4yaSK7NPRR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJGA7uKVpWvCXyt/o4ELz6LnA6hy+qlM75RM0GzuvQPNwjPllfCXlgbdbdXjrWyVJdgLdu3HXPc7nHT/+alzu5xjjbEv8h1cNZBg4Tvo7x40oNf3fHoRx4FyI9aXnR6Nq3fCNhWH5TdvkQi0rc5nCo35VKrlOWBOKZg188yw0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GUEF/XH8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724965730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVF3hYOvHOlvnW8WgvCC4JHNIUU38Snmke2PjbezUZE=;
	b=GUEF/XH8Q2HlMiGlH8lX9ARtj479kp4gOqmvfa8uEq3oA99p+sLDhKcWX1Kvik0bf2qGNb
	LaBOojhMViSz9izn5wPiMPbY7I+MdHC5HCAupFvcjMV6y1hE4Rps+9LoNAQ6DKvA68kab+
	HdTVkX+EZrkA5YaJ06eWim3W4JqfE40=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 1/9] bpf: Move insn_buf[16] to bpf_verifier_env
Date: Thu, 29 Aug 2024 14:08:23 -0700
Message-ID: <20240829210833.388152-2-martin.lau@linux.dev>
In-Reply-To: <20240829210833.388152-1-martin.lau@linux.dev>
References: <20240829210833.388152-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch moves the 'struct bpf_insn insn_buf[16]' stack usage
to the bpf_verifier_env. A '#define INSN_BUF_SIZE 16' is also added
to replace the ARRAY_SIZE(insn_buf) usages.

Both convert_ctx_accesses() and do_misc_fixup() are changed
to use the env->insn_buf.

It is a refactoring work for adding the epilogue_buf[16] in a later patch.

With this patch, the stack size usage decreased.

Before:
./kernel/bpf/verifier.c:22133:5: warning: stack frame size (2584)

After:
./kernel/bpf/verifier.c:22184:5: warning: stack frame size (2264)

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 15 ++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 279b4a640644..0ad2d189c546 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -23,6 +23,8 @@
  * (in the "-8,-16,...,-512" form)
  */
 #define TMP_STR_BUF_LEN 320
+/* Patch buffer size */
+#define INSN_BUF_SIZE 16
 
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record that
@@ -780,6 +782,7 @@ struct bpf_verifier_env {
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
+	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f32e3b9bb4e5..261849384ea8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19677,7 +19677,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	const struct bpf_verifier_ops *ops = env->ops;
 	int i, cnt, size, ctx_field_size, delta = 0;
 	const int insn_cnt = env->prog->len;
-	struct bpf_insn insn_buf[16], *insn;
+	struct bpf_insn *insn_buf = env->insn_buf;
+	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
@@ -19690,7 +19691,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 					env->prog);
-		if (cnt >= ARRAY_SIZE(insn_buf)) {
+		if (cnt >= INSN_BUF_SIZE) {
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
 		} else if (cnt) {
@@ -19837,7 +19838,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		target_size = 0;
 		cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
 					 &target_size);
-		if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf) ||
+		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
 		    (ctx_field_size && !target_size)) {
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
@@ -19846,7 +19847,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (is_narrower_load && size < target_size) {
 			u8 shift = bpf_ctx_narrow_access_offset(
 				off, size, size_default) * 8;
-			if (shift && cnt + 1 >= ARRAY_SIZE(insn_buf)) {
+			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
 				verbose(env, "bpf verifier narrow ctx load misconfigured\n");
 				return -EINVAL;
 			}
@@ -20391,7 +20392,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	const int insn_cnt = prog->len;
 	const struct bpf_map_ops *ops;
 	struct bpf_insn_aux_data *aux;
-	struct bpf_insn insn_buf[16];
+	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0, cur_subprog = 0;
@@ -20510,7 +20511,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    (BPF_MODE(insn->code) == BPF_ABS ||
 		     BPF_MODE(insn->code) == BPF_IND)) {
 			cnt = env->ops->gen_ld_abs(insn, insn_buf);
-			if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
+			if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
 				verbose(env, "bpf verifier is misconfigured\n");
 				return -EINVAL;
 			}
@@ -20803,7 +20804,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = ops->map_gen_lookup(map_ptr, insn_buf);
 				if (cnt == -EOPNOTSUPP)
 					goto patch_map_ops_generic;
-				if (cnt <= 0 || cnt >= ARRAY_SIZE(insn_buf)) {
+				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
 					verbose(env, "bpf verifier is misconfigured\n");
 					return -EINVAL;
 				}
-- 
2.43.5


