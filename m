Return-Path: <bpf+bounces-46485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55889EA716
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB27169111
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967B22616A;
	Tue, 10 Dec 2024 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB5/0pxc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B0224AEB
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803878; cv=none; b=PYJNFh+C0QYzZh0Q3xu31OCyMc4sxhuiqTgkM/Yf444EwdYRVQMwqhSN6K+/w6VO8yjlQIbEwogpXInkaU2tSNAAYzxsukK3BmpnFkdQFm5fUvDhiLk5Fe6T4fA5t61btA6IACOpIXvVPAaoG32XN45n83/+IlqwgsiJj7oewh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803878; c=relaxed/simple;
	bh=S8eLAcahG6C9uX/tSZrTGXoNB55Ezb7Y4u/tRY6NGWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZlIv+ieZmjwfoQ1+4/s4BLwbHfQY0/9zF/n9wh35rPvo/Oj1waG4febm0jL6DgwaShUVCdG2GH0SiAeC5ugEyDn4vVusJ6YvvYOdg/TbeGo0+bSRMDPDMqI/SQQh+1KrhE5RPrUW0eaH0W0zB//0Qvwl2EreeQWQWU4NWdi0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB5/0pxc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21654fdd5daso14752185ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803876; x=1734408676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h83A3P54g6xxUOUZa1brscRPZaqWdc3qDXjky3riX5U=;
        b=DB5/0pxc9hK7rsRMGnao3ETshxxx9TOWP4UiPZfzHNAeQgN+TynsgPGd4ExSrJIn/k
         FF+l+CUIybFwQBglZvvC7sElg5K+ghRLz+XVf1eQP00MVddnOhy70wY5C9t9m6GindpM
         n2x4Q6Cng3UPPcgI20AfLyaMWtbkkJV42HLEFCVm0tsVvY6GAMVSOSM95Skim/OFx+w5
         CXg5/qpwaWJ3UlHSRI26LP2+hV1N89i5JhnGtP3HcHaWaikEJw9YA5TUwX7klFHv9Ztu
         fXaFbusn2Hdw51aR+j7dAKuGjqL2R6HRVokrLPTbBoRGlcdir3QpFRPD7ZpboCnBTyb4
         /l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803876; x=1734408676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h83A3P54g6xxUOUZa1brscRPZaqWdc3qDXjky3riX5U=;
        b=EqXUPhiOTNgfNN6kzykfj2PTuYBee0tNhXnEo7WZMOqEby+E59kTNCbgalrbzavflG
         kBuW8yI7b2373s6ZgmIjUVHte4cDxVExsOfTX1qTzXATri8R/k3Bad8zvHPkMWbzIOfh
         5Be0PvFtFtjMPRtyeXBo5BxrvHTQ2P8iZ/Cl4c+CNPu1RMhCRutmSAgRwQKXqBN7MDh9
         tI40OD1GU02puXLUVNRzzmhM3emRrd1VUi7F0lkYg/l6FlURuFInucTdJRBR5LxO2QOl
         rQ7OguqDTltcA0YidqILPiEbDlKPluuMlyn5W9lKw8DbHVW95mUyR2Yp1w1HlAgQQuVh
         3bWA==
X-Gm-Message-State: AOJu0YzZaTL8t8TIyQqN72GqPGrx5p4Kjxe0YizsaoJoUbOXrmSK/PDf
	scNeMqzPFKFDlgoUxOMSAzvMjpx85dD8rRON/IQRym2lN1xKl3P1o0mjjw==
X-Gm-Gg: ASbGncunQUgBMWPNAMNLimWRDn57rRGXyFV+q5OJeg1q2uhne9eNILxUgpeNdmhFp8H
	bwZvKzbSUlDa32S1noricRiAZnnzGtGpuPWue76xMyiL67QcWNrJ38kt1AVi/lpeANn3NK50geS
	UZFdxIQp4fD2JGp8CtTYymWpcXkbUJa7XNnpYR1q2Z8D3RqqKwqMZxw0F6c4hqCvH4LdIK+L4Vn
	kAxxyiYw6cJC55PDgeLjt4kKsIp2lmVTdm6LB51l7qFJt0n2A==
X-Google-Smtp-Source: AGHT+IEceikijZevBKgmuX7BAepzD4rtW8xGpbgkYxlWBKPMGm7+4yLjvh9tg7FP7aHMyXeK8oDrfQ==
X-Received: by 2002:a17:903:2305:b0:216:3eaf:3781 with SMTP id d9443c01a7336-2163eaf3fa4mr121466805ad.43.1733803876114;
        Mon, 09 Dec 2024 20:11:16 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:15 -0800 (PST)
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
Subject: [PATCH bpf v2 3/8] bpf: track changes_pkt_data property for global functions
Date: Mon,  9 Dec 2024 20:10:55 -0800
Message-ID: <20241210041100.1898468-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
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

At the moment verifier invalidates packet pointers when processing
helper function calls, and does not traverse global sub-programs when
processing calls to global sub-programs. This means that calls to
helpers done from global sub-programs do not invalidate pointers in
the caller state. E.g. the program above is unsafe, but is not
rejected by verifier.

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


