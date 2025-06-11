Return-Path: <bpf+bounces-60373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E075AD5FD3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3EB179342
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A82BDC2F;
	Wed, 11 Jun 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OChf/iT+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C312BDC1B
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672529; cv=none; b=oSQqYa7/6yMaKfDx7TeCKDRXtXGrlWRk9vvuF1GjshY0G8r5IGV4COg5SkcLa8+Kt//4AT90athIW2dQQU0ghpBsJQya9jza2SVzt+Sr2a5mIKnUd/o3wKJaxc1tj3QavsChE0vfiMcgw9e/OvxKnHvWEffI3jlXwMQpOS8xUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672529; c=relaxed/simple;
	bh=/VOeBJGXJuU7SVvzqkQ72nO3jlUJrKiMRy6fpyyhCio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaIS3rKF/mDQlCNV83wwd08hUOiLmNzfZiWsT33YuWZorj2441eqH4ikwO6fQ+l69CiG1gudoQE/AjDdkH3LWFZWbDFQpobJyqWtOc5+r1S8wSCyGvdHfdxtd6Ykv6pRTKOhWJVRSsfsNFdad3H25XTXp48XGPMO2cv44HNCnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OChf/iT+; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e812c817de0so203561276.0
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672526; x=1750277326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bQXPQlpYHt+QLssOCfxDQtox/ZPZLN25fe8XqfkhRc=;
        b=OChf/iT+cICNH2JKC423P7qXhWFtoZeT3gX3sc+dcZDAQSMI9d66UnmjwJZTkqb7YD
         UeI2WaA4JaN6kHe4xQrscgO9iIfbf9AdzbnvMbo0PLwEdOQcglACwhsfiZ6czpudPhnA
         txYiLMag3e5RuUs2drH/uKBEqaCysHrxyvGgzPsjoFPB+b1lQngHxCUTUMC/7U6aL5qn
         +X5p1WzgFSSw/4Cx6gJqT5iXH47CbLXkJ6HBZMieIB619sb1FoAiiD6iunFvVJCVI8QJ
         KGfRYl2pqLb28OX1WEN31NvfGQ9ZixkS9vJMwdzyaFqTP3xeKjZf/MJZvFo8ulHp+zNo
         O3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672526; x=1750277326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bQXPQlpYHt+QLssOCfxDQtox/ZPZLN25fe8XqfkhRc=;
        b=QkBmNTRMtrwY09sn9PEAJvrouk4Sn9qNpRYmI5Hb3cbPYsJmk5Aau9nwY0piRa77Ub
         SgSv5z9s3FyRfZr4gvyN0SBDkTVx8f573UJTgZOP7CA1EOFxdaZ3ChOUaqhShkgmkDNh
         lgORoF50O6X5MXpT14UtjHQjONCYi2mst9InuGfIgjH1bLHcrYKBEdvDyfJ6J8wdaIO0
         zOu8lTmv1V6rOgz4o5GuP3RZwreYfJNhpNbaw0qsoDvsvH6aAe6AUyFL0BCxRaPmonXL
         e8wwZOXYVPIP9uifi1syrVfnPXWLEJOo55MDU0qNa+pXO1Fo1fAKd8M/xYiHls78erb2
         sWfA==
X-Gm-Message-State: AOJu0YyCe/LMotfZwEUc2k8KbQe7mUt9Zj+aSuBjK6p+ZsbEuOg7XQeu
	HuSAGFRkW7/l6Gj2B+cLzSqfT2CUuLyEH3vXJwP6qtbf+p/mrwqgwaPcmDsRejPO
X-Gm-Gg: ASbGnct0mKUeOi8byBeNzlrSnu2cOhGXRBW7UFKeGE8ib3/8qLJC0DRmiwOExtOvkaL
	N1npGJUg7HkzxZKm52KqEnh+UOslkfJV69KDOTvRItXabKvit0UfOBdhK//5sOCKVLxlZChnpwv
	0LamPsuTJa9OyiK23kEG6GzD4Qyw5c6xGeeqS0cpwPmHz4wKuwXGETI0mLsxw6cL66gOonC2Ctf
	euELfwqe0UL27bTHpzE/QXOOqxYGsN64apNK2rgTwS4Kij6f4lf3sjDudxFE3AwhUr32E4CWI+H
	vw30MF94qg7WZIBT0g6UpEXsN8tcfqay5/vYYM52P5HNhnc2HcbVNg==
X-Google-Smtp-Source: AGHT+IF1raP133VPmXWJ14t5fifXlMxVT9n99YfgRZhXoGGDeB7Z7Id1OtzYmUTp/3ZZfTJHXy0bWQ==
X-Received: by 2002:a05:6902:3102:b0:e82:d5a:bebf with SMTP id 3f1490d57ef6-e820d5abfb0mr385781276.35.1749672526294;
        Wed, 11 Jun 2025 13:08:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e317057sm11796276.47.2025.06.11.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:08:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 02/11] bpf: compute SCCs in program control flow graph
Date: Wed, 11 Jun 2025 13:08:27 -0700
Message-ID: <20250611200836.4135542-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compute strongly connected components in the program CFG.
Assign an SCC number to each instruction, recorded in
env->insn_aux[*].scc. Use Tarjan's algorithm for SCC computation
adapted to run non-recursively.

For debug purposes print out computed SCCs as a part of full program
dump in compute_live_registers() at log level 2, e.g.:

  func#0 @0
  Live regs before insn:
        0: .......... (b4) w6 = 10
    2   1: ......6... (18) r1 = 0xffff88810bbb5565
    2   3: .1....6... (b4) w2 = 2
    2   4: .12...6... (85) call bpf_trace_printk#6
    2   5: ......6... (04) w6 += -1
    2   6: ......6... (56) if w6 != 0x0 goto pc-6
        7: .......... (b4) w6 = 5
    1   8: ......6... (18) r1 = 0xffff88810bbb5567
    1  10: .1....6... (b4) w2 = 2
    1  11: .12...6... (85) call bpf_trace_printk#6
    1  12: ......6... (04) w6 += -1
    1  13: ......6... (56) if w6 != 0x0 goto pc-6
       14: .......... (b4) w0 = 0
       15: 0......... (95) exit
   ^^^
  SCC number for the instruction

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   5 +
 kernel/bpf/verifier.c        | 182 +++++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3e77befdbc4b..95f5211610f4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -609,6 +609,11 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/*
+	 * CFG strongly connected component this instruction belongs to,
+	 * zero if it is a singleton SCC.
+	 */
+	u32 scc;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2eee3a5d6797..882079f16291 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24013,6 +24013,10 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	if (env->log.level & BPF_LOG_LEVEL2) {
 		verbose(env, "Live regs before insn:\n");
 		for (i = 0; i < insn_cnt; ++i) {
+			if (env->insn_aux_data[i].scc)
+				verbose(env, "%3d ", env->insn_aux_data[i].scc);
+			else
+				verbose(env, "    ");
 			verbose(env, "%3d: ", i);
 			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
 				if (insn_aux[i].live_regs_before & BIT(j))
@@ -24034,6 +24038,180 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	return err;
 }
 
+/*
+ * Compute strongly connected components (SCCs) on the CFG.
+ * Assign an SCC number to each instruction, recorded in env->insn_aux[*].scc.
+ * If instruction is a sole member of its SCC and there are no self edges,
+ * assign it SCC number of zero.
+ * Uses a non-recursive adaptation of Tarjan's algorithm for SCC computation.
+ */
+static int compute_scc(struct bpf_verifier_env *env)
+{
+	const u32 NOT_ON_STACK = U32_MAX;
+
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	const u32 insn_cnt = env->prog->len;
+	int stack_sz, dfs_sz, err = 0;
+	u32 *stack, *pre, *low, *dfs;
+	u32 succ_cnt, i, j, t, w;
+	u32 next_preorder_num;
+	u32 next_scc_id;
+	bool assign_scc;
+	u32 succ[2];
+
+	next_preorder_num = 1;
+	next_scc_id = 1;
+	/*
+	 * - 'stack' accumulates vertices in DFS order, see invariant comment below;
+	 * - 'pre[t] == p' => preorder number of vertex 't' is 'p';
+	 * - 'low[t] == n' => smallest preorder number of the vertex reachable from 't' is 'n';
+	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion.
+	 */
+	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL);
+	if (!stack || !pre || !low || !dfs) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	/*
+	 * References:
+	 * [1] R. Tarjan "Depth-First Search and Linear Graph Algorithms"
+	 * [2] D. J. Pearce "A Space-Efficient Algorithm for Finding Strongly Connected Components"
+	 *
+	 * The algorithm maintains the following invariant:
+	 * - suppose there is a path 'u' ~> 'v', such that 'pre[v] < pre[u]';
+	 * - then, vertex 'u' remains on stack while vertex 'v' is on stack.
+	 *
+	 * Consequently:
+	 * - If 'low[v] < pre[v]', there is a path from 'v' to some vertex 'u',
+	 *   such that 'pre[u] == low[v]'; vertex 'u' is currently on the stack,
+	 *   and thus there is an SCC (loop) containing both 'u' and 'v'.
+	 * - If 'low[v] == pre[v]', loops containing 'v' have been explored,
+	 *   and 'v' can be considered the root of some SCC.
+	 *
+	 * Here is a pseudo-code for an explicitly recursive version of the algorithm:
+	 *
+	 *    NOT_ON_STACK = insn_cnt + 1
+	 *    pre = [0] * insn_cnt
+	 *    low = [0] * insn_cnt
+	 *    scc = [0] * insn_cnt
+	 *    stack = []
+	 *
+	 *    next_preorder_num = 1
+	 *    next_scc_id = 1
+	 *
+	 *    def recur(w):
+	 *        nonlocal next_preorder_num
+	 *        nonlocal next_scc_id
+	 *
+	 *        pre[w] = next_preorder_num
+	 *        low[w] = next_preorder_num
+	 *        next_preorder_num += 1
+	 *        stack.append(w)
+	 *        for s in successors(w):
+	 *            # Note: for classic algorithm the block below should look as:
+	 *            #
+	 *            # if pre[s] == 0:
+	 *            #     recur(s)
+	 *            #	    low[w] = min(low[w], low[s])
+	 *            # elif low[s] != NOT_ON_STACK:
+	 *            #     low[w] = min(low[w], pre[s])
+	 *            #
+	 *            # But replacing both 'min' instructions with 'low[w] = min(low[w], low[s])'
+	 *            # does not break the invariant and makes itartive version of the algorithm
+	 *            # simpler. See 'Algorithm #3' from [2].
+	 *
+	 *            # 's' not yet visited
+	 *            if pre[s] == 0:
+	 *                recur(s)
+	 *            # if 's' is on stack, pick lowest reachable preorder number from it;
+	 *            # if 's' is not on stack 'low[s] == NOT_ON_STACK > low[w]',
+	 *            # so 'min' would be a noop.
+	 *            low[w] = min(low[w], low[s])
+	 *
+	 *        if low[w] == pre[w]:
+	 *            # 'w' is the root of an SCC, pop all vertices
+	 *            # below 'w' on stack and assign same SCC to them.
+	 *            while True:
+	 *                t = stack.pop()
+	 *                low[t] = NOT_ON_STACK
+	 *                scc[t] = next_scc_id
+	 *                if t == w:
+	 *                    break
+	 *            next_scc_id += 1
+	 *
+	 *    for i in range(0, insn_cnt):
+	 *        if pre[i] == 0:
+	 *            recur(i)
+	 *
+	 * Below implementation replaces explicit recusion with array 'dfs'.
+	 */
+	for (i = 0; i < insn_cnt; i++) {
+		if (pre[i])
+			continue;
+		stack_sz = 0;
+		dfs_sz = 1;
+		dfs[0] = i;
+dfs_continue:
+		while (dfs_sz) {
+			w = dfs[dfs_sz - 1];
+			if (pre[w] == 0) {
+				low[w] = next_preorder_num;
+				pre[w] = next_preorder_num;
+				next_preorder_num++;
+				stack[stack_sz++] = w;
+			}
+			/* Visit 'w' successors */
+			succ_cnt = insn_successors(env->prog, w, succ);
+			for (j = 0; j < succ_cnt; ++j) {
+				if (pre[succ[j]]) {
+					low[w] = min(low[w], low[succ[j]]);
+				} else {
+					dfs[dfs_sz++] = succ[j];
+					goto dfs_continue;
+				}
+			}
+			/*
+			 * Preserve the invariant: if some vertex above in the stack
+			 * is reachable from 'w', keep 'w' on the stack.
+			 */
+			if (low[w] < pre[w]) {
+				dfs_sz--;
+				goto dfs_continue;
+			}
+			/*
+			 * Assign SCC number only if component has two or more elements,
+			 * or if component has a self reference.
+			 */
+			assign_scc = stack[stack_sz - 1] != w;
+			for (j = 0; j < succ_cnt; ++j) {
+				if (succ[j] == w) {
+					assign_scc = true;
+					break;
+				}
+			}
+			/* Pop component elements from stack */
+			do {
+				t = stack[--stack_sz];
+				low[t] = NOT_ON_STACK;
+				if (assign_scc)
+					aux[t].scc = next_scc_id;
+			} while (t != w);
+			if (assign_scc)
+				next_scc_id++;
+			dfs_sz--;
+		}
+	}
+exit:
+	kvfree(stack);
+	kvfree(pre);
+	kvfree(low);
+	kvfree(dfs);
+	return err;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -24155,6 +24333,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = compute_scc(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.47.1


