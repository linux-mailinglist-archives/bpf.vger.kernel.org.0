Return-Path: <bpf+bounces-58894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B0AC3106
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117ED17B88B
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20DC1EEA5D;
	Sat, 24 May 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP0WQ3El"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D518BB8E
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114392; cv=none; b=tKCrzhlDxlB54b3UeaduO5vjxRxnTnH8iGmkn4oIcFUVel9wVbOPLriZr99nH6KrkqsSPVKcgbj9yDQnRB6xqRZvwQTSmGC1gG94snbJpHlIHXeoJ0RWSNuJE5B7wZxdtnsDO0WECmcuivMjqGk4AukzgqUQX8m3xiQ90G0+o+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114392; c=relaxed/simple;
	bh=gAn31fV9eTQzLdiqalyGBAJYMJuqc2WeZf23wOW2AIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhDdxLHZ2rUzGDGRRqOu4tBDa59QzUZKeyU+xKoxWZtZCFkXxvwcSwlDrhyC8dgEZ/Aqs3YUZFul/7CI6H+F8GtAg55aWIDKc6IkKxRXNm1yqGTwCMKhLKgpahmu1BycwFa/0NpfwNOjkBN5JRh2KKKrVAYhhtg8g4VwM39yzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP0WQ3El; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7398d65476eso656874b3a.1
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114390; x=1748719190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28KEsV/esQ6ScHwra9lvsrMIEIpnEBpDEpCp4UrnK/U=;
        b=ZP0WQ3El/dIrPSTian2XB6Ei+MtklQmhWZlMDMAnGOhxx121FLsbTMEuEJ/qQdH+LR
         n63zsWAKcM5LQyAZxe0cDz64epeXKtYnXeyy56K2hBvuVvqU+IvQ8fGDEwVT6Qsw8DFK
         5jS5GKpCVrww475ABGUPMbAqHp2fyBm351jtyKr/ED0Cp3i5BcM+Z0z5X+RCXrEXGtaq
         t7WFzkuMLf94pdki3y3VtJcT6xQkb43UkVjhOOApgGj/uFqxSPH9sG9QXJYhakG9DPLf
         eYsFUsCbeW+nNJ5hV5mGX4lYjx2W/cLVpiXJWdoE8/nTTJdXrv3rqF0za0yMOQfh7eY5
         9ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114390; x=1748719190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28KEsV/esQ6ScHwra9lvsrMIEIpnEBpDEpCp4UrnK/U=;
        b=jtkCUQqiFhmKWohEqLQLb73fqJtZYNYLVMbc6zZzq3Ts37V3BL3P+FhxGhBHZ45qaW
         kROeXp7fwt/IgJZ7EIjDRQcrJ8rV9LRTrBNUC0W2vn8gcox8+JR74kXaH1mjkFytMioI
         COpn0XoDU4bWsUCR/50RWeYv/USF7v1SX59pRL/mnI0kAguM/RhbLgLGNtDzuxMhQ54M
         UY6jqWJMqf2g2AUedB5HcrojfD9C/k2GJw0CMlzkJxl3zMEGNAAVH8g5qrPRCofLt7qV
         jXBtIysTD2dluBdVv/brhDQc8RhltpdGBaJJAo3/a5XRoyYtd3Wz5wfmakuypL60k9qh
         5RBA==
X-Gm-Message-State: AOJu0Yz2eFbt1lLgBUNxjQyUfaEOxZk5V6+0bVSq3c7rJdJ/Cf7zNU+s
	T+Ij3zAXwNyQV94rW45kNnkPXF7874Mnkis8Sa1fsUYPK3t9dPU4K5B81nKRnNW5
X-Gm-Gg: ASbGnctewx9OboGggN11SrkIO1wDuePc6bh5gF2cQpmIH02AIZn7Do2tvkO2pQLzH3h
	ExzNTg4Ri++uaqffv1sH+DFdp4z74kH3XMB9M3GCdwsU5Y5OaTJqTBF0xcn24HKbCZME2WaulEG
	oBV/ihdB2KaaRgVl1OKARKGkoa+n80YdlISeImsdUy4ZhFXM6uYGkMw/A1w1QNvpaSNHLkJaZPM
	UL4N4RzZNlhmqTUz1zNLr0USmBk4VOrNr4jXTIGZImjpQA+N0E3dsqWhE20WGhIc08XKyuOo/RQ
	vSC2IiG3TpvhwhXQIRWXrJe1di0x4LBddM5iZTx+S+m6PR0=
X-Google-Smtp-Source: AGHT+IEpciFrdtbxeLYxWDHdBrS4UJJQNhQIPuLzV9mkn0zW58IJ8JD0Z6krVgwSqsVNfeDZXjPewg==
X-Received: by 2002:a05:6a00:8311:b0:742:b928:59cb with SMTP id d2e1a72fcca58-745ece6c82fmr8322403b3a.7.1748114389588;
        Sat, 24 May 2025 12:19:49 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 02/11] bpf: compute SCCs in program control flow graph
Date: Sat, 24 May 2025 12:19:23 -0700
Message-ID: <20250524191932.389444-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
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
index bba64c834234..b6730a2d6d43 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -604,6 +604,11 @@ struct bpf_insn_aux_data {
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
index df944cc9fc45..23c7136ab6ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23914,6 +23914,10 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
@@ -23935,6 +23939,180 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
@@ -24056,6 +24234,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
2.48.1


