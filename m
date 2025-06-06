Return-Path: <bpf+bounces-59928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676BAD0944
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A43B166126
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128B21CC46;
	Fri,  6 Jun 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJkK4s+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF23201013
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243874; cv=none; b=pDBK1jCBxjTr5zL/4rNwv4PYRPk7F/mqB8HP74sYW0kFqbOFgSxJHmttHH53ZMtVsBAJxSeF+Z107JvN74G2mC/ciV3VLll7PsDyl77HUy8dAdAF1v773TmYhWXOjG2+vide2B6+MTnKTQIGaN/XkaxRe0rEZYfXTAhPzaH6wXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243874; c=relaxed/simple;
	bh=pKjrCvXiIW58o21Xo2qHpM1jA70bz2ptHFPR1fktYG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbMSDkscW50lpd2WP/Gvou+4AqtL9dzdCzbHtLrwB7joBM4gXc2r93cDp1iKDvszjZk9rNOw5W/YuADfuj8afzODtdXmWN+D/stuOpuanDtSEV3QRVayKmd0jF0d4HXvhKAm7MUQxL+mN98Z0AJPahhQqnjmnDOBVjDRJ+66kCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJkK4s+u; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2102737b3a.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243872; x=1749848672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKShGazAN8dcVF3ElTvC/3Fy7Qe00m71+NgEH7MTWEs=;
        b=AJkK4s+ugiozNeUxFe7hRXudYCjrr4+lcfH0QBJ4YtAyoat9dUmDzzxZqkHkHCIehv
         WIDYG03LZVbphHl9bSA2tNuJkSsem8GuZxhb4MesxkG5acOWMXbox+OrNyxkxEnz6C1H
         NRCfPfy4Duk4r7LaSRrzjVj8rwMxwoGLKFKHs4KU7wz12SkUjdynMs2Nzpg2jp2y9jYc
         /50Di4PbjtKd76Evcng2v0QPGudbWPZBbW1PP6eAmZwS8ksxo142EAzf/axLwk1PV3zb
         3pyKs5gnFTzmLSwfXElrOylAzgKW/IMDgv6oASpXRLXLWFiE1Qd7LiSs1S6A/5cR3kaG
         gMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243872; x=1749848672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKShGazAN8dcVF3ElTvC/3Fy7Qe00m71+NgEH7MTWEs=;
        b=EUE/RGdJmkiMOyiY4zTEPzpLyyy2Y5GFx8YhKDj3S8WSgcHhTxdkrm+R2HmcUjj/zU
         4OUMhx260gf5c06LJD7QoKJ1Ngpi2wW+PAb/S0vIXTcFQ9wQ4w8V7jzvN/fHCmboY88Z
         Y0Ne0xb+XqYRc23z2GeAuP2WG/MDENI1vUgBvfOn6/P1H7fFBZIKdyAzU3sqvvuDOESd
         Tm1gccdq7ZAY7yP7Yj8fU+UjsbzUp/kkQkwpkuuym5j5NukU6Q1OKy8HHGZz78tSdLvT
         1rcOGAOwjDQLHsTlw6Pc1Q4KJ8T6tSshW00gwRMDRYgBhSiy5NYRVHthyqodnq8KoI7I
         +G5g==
X-Gm-Message-State: AOJu0Yy6Po7xq+bH+nCTG3j6Iaq35Ez5FEXFqxKnWmFf7/Jj8NxtACHg
	H4nTusid0F2z0C7L4tcBsOXVtmyxKyLRjiQV19K47oORPbR40zyDm7efIlu8qCy0
X-Gm-Gg: ASbGncsXldrV4cqHx09TujaJ35CG8wYamuVt/RXYVvKTtY6gZ01G63BF4mIMFa2gQXX
	i4Hpe4VbVDhcd6iFIqhTlpwNHDYfncf2KuW2oqP2oAevb/f6VLTSgk6XEX3+pdnEhWw2/INPPtc
	FLqsftP2h0QJWh9m1cuHZ249csiakB2gYaNJb00CenZpV4eV1F11OrjGrneYS+SgtIKjbeyiF7p
	MT3M2AooAlfXe7CRjYrIM3ZDUjHnFv5+0p041Ku1+vNam40Ff6lqoglrTh4Qfp1Mgm3acUs08r2
	1Kd0NIkTGJQb9/k++pFhTclbxfFi4RXqJde53uANj7RlaSQfCtgNHdvkfg==
X-Google-Smtp-Source: AGHT+IGRbFmFnY+V5V8LYDDbmy+t0zhn85Msp1NNeukw3WOX1caVq4T2nEfxO7NdLJgJB0vmQIaqWw==
X-Received: by 2002:a05:6a21:7702:b0:216:1476:f71 with SMTP id adf61e73a8af0-21ee264c286mr5287038637.39.1749243871542;
        Fri, 06 Jun 2025 14:04:31 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 02/11] bpf: compute SCCs in program control flow graph
Date: Fri,  6 Jun 2025 14:03:43 -0700
Message-ID: <20250606210352.1692944-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
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
index 489105d0c8ab..f0b4e48c9d90 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -608,6 +608,11 @@ struct bpf_insn_aux_data {
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
index 98130b982a37..fa8c227775a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23924,6 +23924,10 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
@@ -23945,6 +23949,180 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
@@ -24066,6 +24244,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


