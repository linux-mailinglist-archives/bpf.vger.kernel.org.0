Return-Path: <bpf+bounces-56776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9B1A9DA2B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600DA92676A
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1B221FC2;
	Sat, 26 Apr 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/L/zyNP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D151146D6A
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664410; cv=none; b=MkDYhWXxpXMR0tJLKzaZkkr6i4dPSq5Yn5U5zw8wChlQOxffBgvZrX1FSbmsGq++Ti5N7ruQSc0UXOEsAazPjMoxdsyv5vMQaytBzO9/jmhAkw2Qyu6GRAAOGMPMAGnR16LHJ7T1PsQ17vWVRjYLUv+oJKZqf1rD+Sz63dL+jJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664410; c=relaxed/simple;
	bh=GGE1qnfx254JaObCup7VaSVvPwVllXHakykKCZCFjyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv7X+5jNbRY6IeM4ihihhVyAzEqNpKVkgYmSAdsWrTN22LnoALZfcjTKSSTbDGotegWZaE10SfRagDGRWziR6SWQRJ55KIJvXVYetpTYa0JEHPGiZR33UmvTXVz/q+C81sS5NRtDJD1NT0j1yk4NGtfmOtXpJ/3i5uYjhhHgo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/L/zyNP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so54345495ad.0
        for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 03:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745664407; x=1746269207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTl0slZZZC614eITWt3ChZytyxJXYbhIAL4TSOqtBao=;
        b=I/L/zyNPm6c9lVSCABMzu3lHOMEAk5bEsEryaV+i39LIBBoIDlf1bzvw4xizXIkc/h
         Y39rIT4eWqn0davzR1hAiEhYb7ILSr7OoCE1ufFwMCmJftp8GGeEWEDWpb05T4KEbZYb
         o5BRtt408Av9z77tobUBpcwjYGOL4nvmnaP0h3p4LmosvVBsl/S5YMZBULpZ+d6/3TMG
         gGJo4uPQy7Wl1W4cUowlFg+PaHuWiQI0RrYpNwfPq7nDcAe9H841zC5Y0YqLNO4tjdoy
         9IZjJ0JG3NbEcQVV4l4Av5obLFwgpe6rkTSpadc3ZNfRphtNj8urhBaITvbW2WLFxPJu
         N5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745664407; x=1746269207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTl0slZZZC614eITWt3ChZytyxJXYbhIAL4TSOqtBao=;
        b=LxGY34hNDzRl/cmjo0iofA6aDyDOE2+nhmYX5gCUl7bpAatydofWjZSb0tH+9VMsUR
         fA8bkiYZIzJj4Rkzr3+QtflDXKco1nhdzf2gOjfyiZCh6Ru/kWxYP+b6DSTPGcy6m4uT
         eznlx733z5hYdc+X/+ETGNp9nvBa+BR49MiYXs2z4DN4Zc0oAi6s+fV5KmbF6RG6S8iD
         nbK2gJTHxOokLeySqfpwnFGjePXrjcK6+f6u9s6P73kC1dffYEvElkCObfyT2E4J9ynD
         6ma/kDGm4d1LsRD+u8whuTkWkxJV4nwsf55ZIYTe3g000h1rPVTaqF5kMqyiXh81OcMs
         4Bjg==
X-Gm-Message-State: AOJu0Ywn2A+wccsfmEt+yGolCj5wMj2hXfcYIKEAC6EtedA68YLsGFXd
	zgQZMrwufDWwfaJCC5pHucNmRJDij1wU3TvZ5rJ/ZlvteQK/skMtRkAhzems
X-Gm-Gg: ASbGncsiOPRxbMNllpB6+jN0rhRfvjDFy/+CzcguV645zdUJ6LMn6OXscaUTUoM/yd3
	TZv0u9gqis1L5EWWMKg8PvODNVvfZlMmT/hWs3KtCywkyCAySgsAxm87WYDttEW/yI/q3TY/8aQ
	wNIzCqBDa/tOHfxc6pS70M+Fjsxw4nofjeKCfMie/wgSGJaa4Xmcw2xF0vDMfWth3zvCQHQ9LQo
	yhgmUAkSfVwv0gomfuJOTTmgKa5EjBZEkgaHIYkI3sjjMLmhvqPsDQvC+bbuej8hQ0tZyCeHWjs
	FTBJS624xleSfbF2KQhTLgy4sF+iHTj/hiF2
X-Google-Smtp-Source: AGHT+IFq/8JLCuERliAfMDFtcQMgQIZ7hQFsD/u+8Vesax2oyWdnpOp6H3q7mp+k6zGs6fsnxN/jIg==
X-Received: by 2002:a17:903:1947:b0:223:f408:c3dc with SMTP id d9443c01a7336-22dbf4c8438mr77405125ad.9.1745664407453;
        Sat, 26 Apr 2025 03:46:47 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102e13sm47094115ad.201.2025.04.26.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 03:46:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/4] bpf: compute SCCs in program control flow graph
Date: Sat, 26 Apr 2025 03:46:31 -0700
Message-ID: <20250426104634.744077-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250426104634.744077-1-eddyz87@gmail.com>
References: <20250426104634.744077-1-eddyz87@gmail.com>
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
 include/linux/bpf_verifier.h |   4 +
 kernel/bpf/verifier.c        | 178 +++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9734544b6957..cb8e1ae67180 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -604,6 +604,10 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* CFG strongly connected component this instruction belongs to,
+	 * zero if it is a singleton SCC.
+	 */
+	u32 scc;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..9d1f912c12a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23880,6 +23880,10 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
@@ -23901,6 +23905,176 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	return err;
 }
 
+/* Compute strongly connected components (SCCs) on the CFG.
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
+	/* - 'stack' accumulates vertices in DFS order, see invariant comment below;
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
+			/* Preserve the invariant: if some vertex above in the stack
+			 * is reachable from 'w', keep 'w' on the stack.
+			 */
+			if (low[w] < pre[w]) {
+				dfs_sz--;
+				goto dfs_continue;
+			}
+			/* Assign SCC number only if component has two or more elements,
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
@@ -24022,6 +24196,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


