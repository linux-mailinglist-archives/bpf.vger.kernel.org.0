Return-Path: <bpf+bounces-74970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7DC69A8B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 370162AD53
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CED35581F;
	Tue, 18 Nov 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="Jpf/J2Ev"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BD302CD9
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473533; cv=none; b=dgzG4f+fxAFd4srlWs6N3Eu+HWQTN8Kc1AP5B1Q5hLdA8VwYM692lj/G3gNM8UXRm92xFqFU9McgxXnAQBrb3cLzSgC1626YOXF4X2EGnth7u3+PwdHMGO7THfKh4m+6SKDL5Xanfkfe/YjMVHfd0CW2y+nKCuiwfy4vxUnaoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473533; c=relaxed/simple;
	bh=mcZ4LhawogliqBVIkG3C3rIlwFNUTxjXQ8NOYDdUIV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKqDR8m2PFNWuIq/4rf6w6tNu62mgIrIelMYMjguGeUc/a32qdBAnIFhPRm4T3aQZ4Pa4rhurIRRu16RhkypIzo6aWKuoDJHsFYKqUhYnyD4cxhVcaEVt8nl2qFdTSHfPKpkV9Bqzy1qnKphR4mkH+O/oLvyrtkomHeEAhwY5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=Jpf/J2Ev; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A6DB411F99D
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:40:02 +0100 (CET)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id BE51311F752
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:39:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de BE51311F752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763473194; bh=tkjCRDPQ765txlV8JZ+ABr9PS/7sfDaodlYcpIi9qns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jpf/J2EvIPDWtbVPuP/AKcWYhjS7zzNNDXdunkcATBdEFJuw3IyqMW/XhdOQLPz3U
	 utG6I3bXz30hzosIM3EJVVgK6DJfWZkGqWZhpLjOn9oD29bl6hbWWHxdEyYmv5Cuxh
	 0qcyXECbM1HkG/WZie/lICBNLk08BY1CNDdX7KDA=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id B024220056;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id A4C5B16003F;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 2ABE13200A8;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 0EDBC80046;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 0B119201AE; Tue, 18 Nov 2025 14:39:54 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v5 bpf-next 3/4] bpf: correct stack liveness for tail calls
Date: Tue, 18 Nov 2025 14:39:43 +0100
Message-ID: <20251118133944.979865-4-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates bpf_insn_successors() reflecting that control flow might
jump over the instructions between tail call and function exit, verifier
might assume that some writes to parent stack always happen, which is
not the case.
---
 include/linux/bpf_verifier.h |  5 +++--
 kernel/bpf/liveness.c        |  7 ++++---
 kernel/bpf/verifier.c        | 29 +++++++++++++++++++++++++++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5441341f1ab9..8d0b60fa5f2b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -527,7 +527,6 @@ struct bpf_insn_aux_data {
 		struct {
 			u32 map_index;		/* index into used_maps[] */
 			u32 map_off;		/* offset from value base address */
-			struct bpf_iarray *jt;	/* jump table for gotox instruction */
 		};
 		struct {
 			enum bpf_reg_type reg_type;	/* type of pseudo_btf_id */
@@ -550,6 +549,7 @@ struct bpf_insn_aux_data {
 		/* remember the offset of node field within type to rewrite */
 		u64 insert_off;
 	};
+	struct bpf_iarray *jt;	/* jump table for gotox or bpf_tailcall call instruction */
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
@@ -652,6 +652,7 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
+	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
@@ -669,9 +670,9 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	u8 arg_cnt:3;
 
 	enum priv_stack_mode priv_stack_mode;
-	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
 };
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index a7240013fd9d..60db5d655495 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -482,11 +482,12 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = &prog->insnsi[idx];
 	const struct opcode_info *opcode_info;
-	struct bpf_iarray *succ;
+	struct bpf_iarray *succ, *jt;
 	int insn_sz;
 
-	if (unlikely(insn_is_gotox(insn)))
-		return env->insn_aux_data[idx].jt;
+	jt = env->insn_aux_data[idx].jt;
+	if (unlikely(jt))
+		return jt;
 
 	/* pre-allocated array of size up to 2; reset cnt, as it may have been used already */
 	succ = env->succ;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 117a2b1cf87c..f564150ec807 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3555,8 +3555,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			subprog[cur_subprog].has_ld_abs = true;
 		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
 			goto next;
-		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
+		if (BPF_OP(code) == BPF_CALL)
 			goto next;
+		if (BPF_OP(code) == BPF_EXIT) {
+			subprog[cur_subprog].exit_idx = i;
+			goto next;
+		}
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
@@ -18150,6 +18154,25 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
 }
 
+static int visit_tailcall_insn(struct bpf_verifier_env *env, int t)
+{
+	static struct bpf_subprog_info *subprog;
+	struct bpf_iarray *jt;
+
+	if (env->insn_aux_data[t].jt)
+		return 0;
+
+	jt = iarray_realloc(NULL, 2);
+	if (!jt)
+		return -ENOMEM;
+
+	subprog = bpf_find_containing_subprog(env, t);
+	jt->items[0] = t + 1;
+	jt->items[1] = subprog->exit_idx;
+	env->insn_aux_data[t].jt = jt;
+	return 0;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -18210,6 +18233,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_subprog_might_sleep(env, t);
 			if (bpf_helper_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
+			if (insn->imm == BPF_FUNC_tail_call)
+				visit_tailcall_insn(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
@@ -21471,7 +21496,7 @@ static void clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len
 	int i;
 
 	for (i = start; i < end; i++) {
-		if (insn_is_gotox(&insns[i])) {
+		if (aux_data[i].jt) {
 			kvfree(aux_data[i].jt);
 			aux_data[i].jt = NULL;
 		}
-- 
2.43.0


