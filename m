Return-Path: <bpf+bounces-38186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF79616B0
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF291F254B4
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F561D3192;
	Tue, 27 Aug 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rrqsTn5D"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C631D2F4D
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782633; cv=none; b=iQ5FunQDlNAzgXfsH3lNvfe2cBUf0aaDi638t0nZEWRrnXhU2p+yQGJXqicQ9XdCazwpwLqdl01JSqPX2oapch95PczCczGs1sTzia86M4zEwh4gRBB87FYQ4yVIN59y49N6qfMCalDbJdSGNoMwp/z7tKC91ZXwyA8vFdww30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782633; c=relaxed/simple;
	bh=cvqOOqpdt8Qy6om02YyBdZJGO7w4GUTqJ3dF8uF8XDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV8VW7eFk4omBS76wI3sHbZcTUrnr22dviPQhl7PUNOZj5S5JLb6DL+1TRKYQZP7dI6ASbAsGV4UKouec7YR3codYk6/bxKs9NLz21gnf7owDL13YS82F3Z/7jfVG2iid9TN8P7XW3YkqfItr7KgYA30aeWQzULG7RUHdp4UV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rrqsTn5D; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724782627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdWEuEMTdZ17pB1mw0lmMqSHTXFlIS86D8briORIeIU=;
	b=rrqsTn5DOqO9ag7HAKHxgcPTeqvFwRcPPYcODMtcq2+cm9WYV+S9V02AIDo94OS93q1m+U
	ltreXR+SLppHlYVQQ7FKp3clJV3oqnh2N8sWYvDt6fxDrViHAnBjBJEzmixUh5PSJIkb6/
	xNMXx8Yjkabnuah+NiRxh23/8vv/9gg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 3/9] bpf: Add gen_epilogue to bpf_verifier_ops
Date: Tue, 27 Aug 2024 11:16:39 -0700
Message-ID: <20240827181647.847890-4-martin.lau@linux.dev>
In-Reply-To: <20240827181647.847890-1-martin.lau@linux.dev>
References: <20240827181647.847890-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a .gen_epilogue to the bpf_verifier_ops. It is similar
to the existing .gen_prologue. Instead of allowing a subsystem
to run code at the beginning of a bpf prog, it allows the subsystem
to run code just before the bpf prog exit.

One of the use case is to allow the upcoming bpf qdisc to ensure that
the skb->dev is the same as the qdisc->dev_queue->dev. The bpf qdisc
struct_ops implementation could either fix it up or drop the skb.
Another use case could be in bpf_tcp_ca.c to enforce snd_cwnd
has sane value (e.g. non zero).

The epilogue can do the useful thing (like checking skb->dev) if it
can access the bpf prog's ctx. Unlike prologue, r1 may not hold the
ctx pointer. This patch saves the r1 in the stack if the .gen_epilogue
has returned some instructions in the "epilogue_buf".

The existing .gen_prologue is done in convert_ctx_accesses().
The new .gen_epilogue is done in the convert_ctx_accesses() also.
When it sees the (BPF_JMP | BPF_EXIT) instruction, it will be patched
with the earlier generated "epilogue_buf". The epilogue patching is
only done for the main prog.

Only one epilogue will be patched to the main program. When the
bpf prog has multiple BPF_EXIT instructions, a BPF_JA is used
to goto the earlier patched epilogue. Majority of the archs
support (BPF_JMP32 | BPF_JA): x86, arm, s390, risv64, loongarch,
powerpc and arc. This patch keeps it simple and always
use (BPF_JMP32 | BPF_JA).

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 46 +++++++++++++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dc63083f76b7..6f87fb014fba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -974,6 +974,8 @@ struct bpf_verifier_ops {
 				struct bpf_insn_access_aux *info);
 	int (*gen_prologue)(struct bpf_insn *insn, bool direct_write,
 			    const struct bpf_prog *prog);
+	int (*gen_epilogue)(struct bpf_insn *insn, const struct bpf_prog *prog,
+			    s16 ctx_stack_off);
 	int (*gen_ld_abs)(const struct bpf_insn *orig,
 			  struct bpf_insn *insn_buf);
 	u32 (*convert_ctx_access)(enum bpf_access_type type,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0ad2d189c546..2e20207315a9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -783,6 +783,7 @@ struct bpf_verifier_env {
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
+	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8714b83c5fb8..8ed2aec54f68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19675,15 +19675,39 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
  */
 static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
+	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, delta = 0;
+	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
+	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	int epilogue_idx = 0;
+
+	if (ops->gen_epilogue) {
+		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
+						 -(subprogs[0].stack_depth + 8));
+		if (epilogue_cnt >= INSN_BUF_SIZE) {
+			verbose(env, "bpf verifier is misconfigured\n");
+			return -EINVAL;
+		} else if (epilogue_cnt) {
+			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
+			cnt = 0;
+			subprogs[0].stack_depth += 8;
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
+						      -subprogs[0].stack_depth);
+			insn_buf[cnt++] = env->prog->insnsi[0];
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = new_prog;
+			delta += cnt - 1;
+		}
+	}
 
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
@@ -19740,6 +19764,25 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
 			env->prog->aux->num_exentries++;
 			continue;
+		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
+			   epilogue_cnt &&
+			   i + delta < subprogs[1].start) {
+			/* Generate epilogue for the main prog */
+			if (epilogue_idx) {
+				/* jump back to the earlier generated epilogue */
+				insn_buf[0] = BPF_JMP32_IMM(BPF_JA, 0,
+							    epilogue_idx - i - delta - 1, 0);
+				cnt = 1;
+			} else {
+				memcpy(insn_buf, epilogue_buf, INSN_BUF_SIZE);
+				cnt = epilogue_cnt;
+				/* epilogue_idx cannot be 0. It must have at
+				 * least one ctx ptr saving insn before the
+				 * epilogue.
+				 */
+				 epilogue_idx = i + delta;
+			}
+			goto patch_insn_buf;
 		} else {
 			continue;
 		}
@@ -19876,6 +19919,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 						       insn->dst_reg, insn->dst_reg,
 						       size * 8, 0);
 
+patch_insn_buf:
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
-- 
2.43.5


