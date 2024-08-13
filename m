Return-Path: <bpf+bounces-37073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14466950C85
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63AD28303D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A759A1A4F0C;
	Tue, 13 Aug 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JnTY5/Gv"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F81A3BA8
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575001; cv=none; b=gx76QmePtIbGd4pY85upO1XpPjAuMAAEpxlqFirshke+OgcYghqHoYug6jiRS5uWdBLqL5gMzx419cW1sEED8tZ2EQiZmoMc1hPo2/ujb2C9OZHtQEsTz/hwJcCYgGhP/51f4mVqSD7Iw2PtOmQAAsBkRMqCKfXNP6AwZNPL23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575001; c=relaxed/simple;
	bh=TRwFfv4Z5pQwu2YpqBlGrfL0WfNS1evcbsUWQaiVUww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JK2uZkoLgi3hjam6VIBybDBHOqdhcZDv0vGWK/7Z9Zk5esuoQu5dj4PWshY2kNgyWE4LcIal77kmQYMWTK8mTpTRzw8GkLFsWNrI+N7T44O93NMLL6DnQwYhmAb0Bz1J5QUMoASy75J9Ytui0fRsrLBEessqQz699XUkAPV+PFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JnTY5/Gv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723574996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiSiHRm8uHhYxBfMcZIq670oTpeg0ezmWWluCd/4MuU=;
	b=JnTY5/Gv9kf5VhoxXX45L8hinRpzqM6G6TIFCLWmzsJu+iZ73mjQpRkTcYDtmQKQ8ztbbw
	fIlVG+GQswNgKRBLco6BPzWd9pF/+PK+Ru6Z+tbViZxPllmZw/Vs2XUMAboJtRpVlJpFO9
	GB3e2w8ixIed+1kz25a0JqdpHIfsz5c=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 1/6] bpf: Add gen_epilogue to bpf_verifier_ops
Date: Tue, 13 Aug 2024 11:49:34 -0700
Message-ID: <20240813184943.3759630-2-martin.lau@linux.dev>
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

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
The .gen_epilogue will need 8 extra bytes in the stack to save
the ctx pointer. It is now done after the check_max_stack_depth.
The ctx pointer saving will need to be done earlier before
check_max_stack_depth.

 include/linux/bpf.h   |  2 ++
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b9425e410bcb..2de67bc497f4 100644
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


