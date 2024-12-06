Return-Path: <bpf+bounces-46240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6D9E653F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212CE188571F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6504C194A49;
	Fri,  6 Dec 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQedV5Lp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2A8194120
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457809; cv=none; b=SuCMtzIdAkr7B2nptjHn64AnU0QGM2MSHqTJE25KlSrcTN8duxxhxpYbB2tT3t1EA9u7i0NamJWITxcLi41bBUbQ298wHnMfe+PU8ENY5dz358LG2wffuLRZM6q226aCDPNpKnJ4/KEwQ4MDpiN4k9+/hAb5MmLWp4vLZIPQtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457809; c=relaxed/simple;
	bh=ETgZc24McfcPAcX2yubnpzSEOfbz3gxmaXfMfYvsdak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/AzDRqfz0JZwdGI1h8tBkGQvnixDMq3Tf8vvcAVKDL60Lm4PMntRhX0ImMJXJQvyPZKkndvO/H1NitAP3/TdsZeOaDKCVxrq8BgpGpNKfKsxVzW5+wWaFsTSM4Qj9DNit53wqLtzEeyu0IvYh65FVBo8k+AfHDPhRzhbOycbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQedV5Lp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724f42c1c38so1487113b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733457807; x=1734062607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ4GQ7+KCdCyL8YNQozZccMYcpExv9M3xriogwMx2ho=;
        b=kQedV5LpwIORYhLuzZSn1kOGUFb0L3Yh7tsYqrxgoGAPIbmjPg7nObsqp4T0TCzoAo
         TrBRxaApVQNBloQ7QWb1WNQDUt3pKf4NmuEJKCP8JfmpIr4mLnjZzrGsCPcpS5ULL2E3
         c3vnsSXlyWU3usqLkoSsNs+k3Jy9rS4CzkpjeXHBKjQxrRrKDoiPWV/bekQRV0lvkqz2
         KvBejwEHMNHpNWGE96jPKHsuS3AbPiHga+8z7wf3Q2M7EdCywC1LAoP4t7MNfhxIM5YE
         1y8gV6o43JKNqwik1aAxkGZs7KxttYRyAO90Ci073tgnMXki2PrxsMPpHewBoFXeiKMY
         xRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457807; x=1734062607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ4GQ7+KCdCyL8YNQozZccMYcpExv9M3xriogwMx2ho=;
        b=jRx4jBEHRN1b5sYbO8msALLSFQHmDYYhoEOEbBgNOitojGFU6R5ETHJhkLPTfccoMm
         LyMNWsx2vj+GuxSuY58qtCU3GKegGOw141c4mg/gCKwGNz34ODIvSoVx385xR8JrMkHT
         yj3bzomwTPkomjYl9scYnlcWqHm3ncL95sWCLg8iOBSD4Pljlbz4IDewYX4l2eRaC1q0
         +yej+xB+FiBWeTbzZde8d+Q/2Av8MA8Zqoctu7n8rbAhvAWezNcjWwmvydqg/N3CdkwB
         g2iFqz/cuem1guu+VMJiUfTlygkr/zzzixA+ihTOAvIB0ggV+CJFLOtyC6VKSVdFHe6v
         VexA==
X-Gm-Message-State: AOJu0YyKZmlXMSKR9aMjFqF3kO6pIjYXoHxpgpVt9zNqnHsDxQNtS6pu
	9vaJTQJOAoIGm20BziOyT/bXL9HxCGB56KPPyqQogBX+u+b/eVOZJadc6Q==
X-Gm-Gg: ASbGncsptF8L3WNA+VUtVIMNhTtthF8YbIEHEfYXmqkJjd1/FzVMtH3E0txJhcSNfBp
	kKgZraj4ZaIjTM3uUPTOd65Vxkgm2sEBnJhBpjs+2v2AZ1pqwvG/lEJfiPfb/xcq9NHZ0RRpikY
	OYBIq2q7radZOWgy/iWPNJIhL99uflV00QQy7ciuh3t7ozUUCMUbYXbFCNiIVPmQDIa7/xrpQSF
	LE3ZwZ0hgZgAWzVR/qZBCLdXm5b37dnrYfZA5eXVzYQaQ==
X-Google-Smtp-Source: AGHT+IEwSQWlwAJ/53FpebvrKhZHIbI33908doWKwtLNnZl5Bo2Vm0RBWF+riPP4TBR1BSG72xlyEQ==
X-Received: by 2002:a17:90b:2f0b:b0:2ee:d35c:39ab with SMTP id 98e67ed59e1d1-2ef6a6c1436mr2300485a91.22.1733457807223;
        Thu, 05 Dec 2024 20:03:27 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff97ffsm4101846a91.10.2024.12.05.20.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:03:26 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global functions
Date: Thu,  5 Dec 2024 20:03:06 -0800
Message-ID: <20241206040307.568065-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206040307.568065-1-eddyz87@gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing calls to certain helpers, verifier invalidates all
packet pointers in a current state. For example, consider the
following program:

    __attribute__((__noinline__))
    long skb_pull_data(struct __sk_buff *sk, __u32 len)
    {
        return bpf_skb_pull_data(sk, len);
    }

    SEC("tc")
    int test_invalidate_checks(struct __sk_buff *sk)
    {
        int *p = (void *)(long)sk->data;
        if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
        skb_pull_data(sk, 0);
        *p = 42;
        return TCX_PASS;
    }

After a call to bpf_skb_pull_data() the pointer 'p' can't be used
safely. See function filter.c:bpf_helper_changes_pkt_data() for a list
of such helpers.

At the moment verifier does packet pointers invalidation only upon
processing calls to helper functions. This means that calls to helpers
done from global sub-programs do not invalidate pointers in the caller
state. E.g. the following program above is unsafe, but is not rejected
by verifier.

This commit fixes the omission by computing field
bpf_subprog_info->changes_pkt_data for each sub-program before main
verification pass.
changes_pkt_data should be set if:
- subprogram calls helper for which bpf_helper_changes_pkt_data
  returns true;
- subprogram calls a global function,
  for which bpf_subprog_info->changes_pkt_data should be set.

The verifier.c:check_cfg() pass is modified to compute this
information. The commit relies on depth first instruction traversal
done by check_cfg() and absence of recursive function calls:
- check_cfg() would eventually visit every call to subprogram S in a
  state when S is fully explored;
- when S is fully explored:
  - every direct helper call within S is explored
    (and thus changes_pkt_data is set if needed);
  - every call to subprogram S1 called by S was visited with S1 fully
    explored (and thus S inherits changes_pkt_data from S1).

The downside of such approach is that dead code elimination is not
taken into account: if a helper call inside global function is dead
because of current configuration, verifier would conservatively assume
that the call occurs for the purpose of the changes_pkt_data
computation.

Reported-by: Nick Zavaritsky <mejedi@gmail.com>
Closes: https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f4290c179bee..48b7b2eeb7e2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -659,6 +659,7 @@ struct bpf_subprog_info {
 	bool args_cached: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
 	bool keep_fastcall_stack: 1;
+	bool changes_pkt_data: 1;
 
 	enum priv_stack_mode priv_stack_mode;
 	u8 arg_cnt;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad3f6d28e8e4..6a29b68cebd6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10042,6 +10042,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 			subprog, sub_name);
+		if (env->subprog_info[subprog].changes_pkt_data)
+			clear_all_pkt_pointers(env);
 		/* mark global subprog for verifying after main prog */
 		subprog_aux(env, subprog)->called = true;
 		clear_caller_saved_regs(env, caller->regs);
@@ -16246,6 +16248,29 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	return 0;
 }
 
+static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = find_containing_subprog(env, off);
+	subprog->changes_pkt_data = true;
+}
+
+/* 't' is an index of a call-site.
+ * 'w' is a callee entry point.
+ * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
+ * Rely on DFS traversal order and absence of recursive calls to guarantee that
+ * callee's change_pkt_data marks would be correct at that moment.
+ */
+static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
+{
+	struct bpf_subprog_info *caller, *callee;
+
+	caller = find_containing_subprog(env, t);
+	callee = find_containing_subprog(env, w);
+	caller->changes_pkt_data |= callee->changes_pkt_data;
+}
+
 /* non-recursive DFS pseudo code
  * 1  procedure DFS-iterative(G,v):
  * 2      label v as discovered
@@ -16379,6 +16404,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				bool visit_callee)
 {
 	int ret, insn_sz;
+	int w;
 
 	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
 	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
@@ -16390,8 +16416,10 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 	mark_jmp_point(env, t + insn_sz);
 
 	if (visit_callee) {
+		w = t + insns[t].imm + 1;
 		mark_prune_point(env, t);
-		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env);
+		merge_callee_effects(env, t, w);
+		ret = push_insn(t, w, BRANCH, env);
 	}
 	return ret;
 }
@@ -16708,6 +16736,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			mark_prune_point(env, t);
 			mark_jmp_point(env, t);
 		}
+		if (bpf_helper_call(insn) && bpf_helper_changes_pkt_data(insn->imm))
+			mark_subprog_changes_pkt_data(env, t);
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-- 
2.47.0


