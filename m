Return-Path: <bpf+bounces-37784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16295A858
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A33B210F3
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BE17D354;
	Wed, 21 Aug 2024 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B10IUlIc"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10E17C7C8
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283310; cv=none; b=N39xzhf71EeXoKcOsPnTcSwoJMBiHT72faGT3XX//wQIcq4d0lxRK05JAmpsacoPn6FHCTpMDsJAsWokQwzTHHJ6vkOFld02evt/tNqfdHR9TEZ3NpvrUulNOrXMbfe72zwQVnHGrU7swEFoJEtqoIlj4lTni6XGfCaw2fmKgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283310; c=relaxed/simple;
	bh=1tUz7zNqpa/RPRqNNxSuDRIigz0sbgLO5pE15f82oZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3GIQORVorD6n9JHsTAcFqY61adjG4O+8VHCe5QE+u0U3rniAQI4+KI8eGDLvFQcz5R4mGyIKW95efrx8MpWwwL9APPPQq/SABDzhFYIKVv01MJod5Ptfol7loL80pm5NGZMCXZ8Ad3niRwXCsopkpPZsgW7Dod4jWBf3UXx3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B10IUlIc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724283306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4PlrW+FTIpAcA25s45OsEq9wnBOMT9A/V04nPt0HFk=;
	b=B10IUlIcxA+UFhpWfRvPj29AdDdRYjz47yZdaYS1qApffBpnn2kXo8Xm4ogjcq80chL0It
	BGtlbvGoeWALQc9qERuih6YFjBgdgyLwy7bAIUGWf7LPa5RpovEMYVqXWgyiMet+vTHPNS
	jjntkXyobniNdsE8vTel7AE4SHkULYU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/8] bpf: Add gen_epilogue to bpf_verifier_ops
Date: Wed, 21 Aug 2024 16:34:31 -0700
Message-ID: <20240821233440.1855263-2-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-1-martin.lau@linux.dev>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f0192c173ed8..8ee9d87c332a 100644
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..bbb655f0c7b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19610,15 +19610,37 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
  */
 static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
+	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, delta = 0;
+	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
-	struct bpf_insn insn_buf[16], *insn;
+	struct bpf_insn insn_buf[16], epilogue_buf[16], *insn;
 	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
 
+	if (ops->gen_epilogue) {
+		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
+						 -(subprogs[0].stack_depth + 8));
+		if (epilogue_cnt >= ARRAY_SIZE(epilogue_buf)) {
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
+
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verbose(env, "bpf verifier is misconfigured\n");
@@ -19671,6 +19693,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
 			env->prog->aux->num_exentries++;
 			continue;
+		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
+			   epilogue_cnt &&
+			   i + delta < subprogs[1].start) {
+			/* Generate epilogue for the main prog */
+			memcpy(insn_buf, epilogue_buf, sizeof(epilogue_buf));
+			cnt = epilogue_cnt;
+			goto patch_insn_buf;
 		} else {
 			continue;
 		}
@@ -19807,6 +19836,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 						       insn->dst_reg, insn->dst_reg,
 						       size * 8, 0);
 
+patch_insn_buf:
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
-- 
2.43.5


