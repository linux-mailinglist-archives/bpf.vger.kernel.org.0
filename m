Return-Path: <bpf+bounces-68890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D2B87B5A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BA53AC2FF
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD327056B;
	Fri, 19 Sep 2025 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuawPN2k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA0246786
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248347; cv=none; b=MzixXa8MQy+wuBJcnMbumhk8wEA19KTIz7MyUsR+Yfr3VIw2n55yiPo4xSL1afnnHbr3zJIX0u1QUrJ+1FNDpx4wH1zqJRPnu4cwoV9uDcdsB8h7U7YAskbkzKiWqI67XI+nDocgWyqlJ/Swx8juBN08682zIO+a3j9xe/zHfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248347; c=relaxed/simple;
	bh=KRq00QgOXFDvPNY05OAJIcio4DipiBA0rkHCoRVUXoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9nzauX08iLS2oleszWyu4iuHGS2Tr5uHnp36pwTq+Eouxqiz48VhyBIsZJVPLqg4zW+mUhL0NkVlQTm/klWOjOhhj2LyqPA5MFru2ccM2rPmfL9OCNEnLNJifMNvXUqLkZj5X90QwViwyOpM86UAGaDcpiGURQ1VUPByjieVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuawPN2k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2570bf6058aso21279045ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248344; x=1758853144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp7TTEcq7Qjc/owrxkdf9kJ6LG0SdySsbHAVw01qxas=;
        b=HuawPN2kTtnxe/mLPRUxU39UDiNhz8SQSqlKitOs57NGFD4LP7r9im+TdH13cw7+Z3
         mgFj0Zn2dkfcWQODStLwWnwWWxnMg3X8BcfKHQb1elRGUamSou1sB5Tmv+OacQsOLDgL
         DU3b6hFMEC7hC+lSAt7tUvwSHiZQ7ZjSQjKm6T/nn/9w3d4mCnPzb5Fm/X1P/hzuRWbm
         H6iKSLnJMg3m5cKj4DzZTLydnGXFgt3/9K1GwvRprKZqFh2RQPsZTOok1DWWlszvNVtU
         sHTOA8OzubcP/J/3AyWT15xHbTpclD8jyXJi/VdHrTgtAEWmD+CMxAWXXHs7islEegxS
         oWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248344; x=1758853144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp7TTEcq7Qjc/owrxkdf9kJ6LG0SdySsbHAVw01qxas=;
        b=PziAc5yzZNo0ngJAI3RsGzPeg83rjYuPorFDldLNbBomUjpwwHd9nfxnfJvu+7fw5v
         wmO71Xz/AgQw+55hf0jDOqmefeyfVb3ByMCf2PMmjwMl3jIkK263ezmchTRPFHGK8B1q
         JCnRECIb4xJDwSphoQdxpf2yCLZYUMIkVgiyCl8xxy4gwBtMeRmFvcikFY2vwSvxojzj
         MHJzDg0qdZdmViSslpuCS1BlfIH80ViMPlGeNGuqgHzvs76qCzFSK7CZIefJJVg9OZoW
         mSuw8GLJvatdKhOADMCFY+XUXRZ9b0cpNcURyeD6fRS2HFoO7tfQAMXJRP71haHB3jGm
         YQIw==
X-Gm-Message-State: AOJu0YxllVALRlMgRlHTFoCFqLF2UkUirmCyTL1cYdiYpLVgGO3MYupB
	DB9pD7BNPb6JqfzJEy1P6eStBwNGttPEwFFOPSYHHeg3v9Ke7OXrbeGb4KHYIg==
X-Gm-Gg: ASbGncuyqURz2LKEHheFmHLGP/Z3EleJ2a/R+mTjD2vyTxkWwKtXXTTEaUIPRmj3IL0
	RK0YWPkyUTcxo2653/dxu9EPxduI00CPCaXHcZZ6XvMJ9TrY9B45SCoFo76mZDgH+lRL5tOkUBm
	VIl4KtcJz7UJ682bPCYYoCZkRixW/zLOVO1gh8lH+5bnrLu7wP3X1G01uG/QJKxL7Rw0EUw4nO9
	+dxjaOQ5Rm4o3F9EN+L/n308Du3EjtojU0fHAZvlTtesFRNO8Yv+G/sh++lO4Jw1PgCI28EkUGA
	HmfkHcBgkljT13RhBtsQXFEI20vfQ95Tk5JwMCxganuDS49JP4g0LN2px9hSt4dxst8GDFCVADz
	krIUe7O3whuEhoFcJ
X-Google-Smtp-Source: AGHT+IHIvEMtQ2j0gwycCNseoEEVAjZSXLjCfyKZb1IeXwPUGd5pf2y+9XfBvt+KH7Cb94hskpTEQw==
X-Received: by 2002:a17:903:1210:b0:262:4878:9e13 with SMTP id d9443c01a7336-269ba4799c9mr24604485ad.26.1758248344351;
        Thu, 18 Sep 2025 19:19:04 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 04/12] bpf: declare a few utility functions as internal api
Date: Thu, 18 Sep 2025 19:18:37 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-4-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Namely, rename the following functions and add prototypes to
bpf_verifier.h:
- find_containing_subprog -> bpf_find_containing_subprog
- insn_successors         -> bpf_insn_successors
- calls_callback          -> bpf_calls_callback
- fmt_stack_mask          -> bpf_fmt_stack_mask

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/verifier.c        | 34 ++++++++++++++++------------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ac16da8b49dc1c1e2ba371df785ca32aa7c5415a..93563564bde5947d08fad7b33f9e38b16942fa31 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1065,4 +1065,9 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 		      u32 frameno);
 
+struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
+int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2]);
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
+bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 04cd5a66968dc81c130933517135e135d61cb4f1..a8a0d489a32db7fa43bc38066449332c63e5ac17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2979,7 +2979,7 @@ static int cmp_subprogs(const void *a, const void *b)
 }
 
 /* Find subprogram that contains instruction at 'off' */
-static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *vals = env->subprog_info;
 	int l, r, m;
@@ -3004,7 +3004,7 @@ static int find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
-	p = find_containing_subprog(env, off);
+	p = bpf_find_containing_subprog(env, off);
 	if (!p || p->start != off)
 		return -ENOENT;
 	return p - env->subprog_info;
@@ -4211,7 +4211,7 @@ static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
 	}
 }
 /* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
-static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 {
 	DECLARE_BITMAP(mask, 64);
 	bool first = true;
@@ -4266,8 +4266,6 @@ static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_histo
 	}
 }
 
-static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
-
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -4294,7 +4292,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
 		verbose(env, "mark_precise: frame%d: regs=%s ",
 			bt->frame, env->tmp_str_buf);
-		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+		bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		verbose_insn(env, insn);
@@ -4495,7 +4493,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * backtracking, as these registers are set by the function
 			 * invoking callback.
 			 */
-			if (subseq_idx >= 0 && calls_callback(env, subseq_idx))
+			if (subseq_idx >= 0 && bpf_calls_callback(env, subseq_idx))
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
@@ -4934,7 +4932,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 					     bt_frame_reg_mask(bt, fr));
 				verbose(env, "mark_precise: frame%d: parent state regs=%s ",
 					fr, env->tmp_str_buf);
-				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+				bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
 					       bt_frame_stack_mask(bt, fr));
 				verbose(env, "stack=%s: ", env->tmp_str_buf);
 				print_verifier_state(env, st, fr, true);
@@ -11023,7 +11021,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					       "At callback return", "R0");
 			return -EINVAL;
 		}
-		if (!calls_callback(env, callee->callsite)) {
+		if (!bpf_calls_callback(env, callee->callsite)) {
 			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
 				     *insn_idx, callee->callsite);
 			return -EFAULT;
@@ -17298,7 +17296,7 @@ static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
 
-	subprog = find_containing_subprog(env, off);
+	subprog = bpf_find_containing_subprog(env, off);
 	subprog->changes_pkt_data = true;
 }
 
@@ -17306,7 +17304,7 @@ static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
 
-	subprog = find_containing_subprog(env, off);
+	subprog = bpf_find_containing_subprog(env, off);
 	subprog->might_sleep = true;
 }
 
@@ -17320,8 +17318,8 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 {
 	struct bpf_subprog_info *caller, *callee;
 
-	caller = find_containing_subprog(env, t);
-	callee = find_containing_subprog(env, w);
+	caller = bpf_find_containing_subprog(env, t);
+	callee = bpf_find_containing_subprog(env, w);
 	caller->changes_pkt_data |= callee->changes_pkt_data;
 	caller->might_sleep |= callee->might_sleep;
 }
@@ -17391,7 +17389,7 @@ static void mark_calls_callback(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].calls_callback = true;
 }
 
-static bool calls_callback(struct bpf_verifier_env *env, int insn_idx)
+bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx)
 {
 	return env->insn_aux_data[insn_idx].calls_callback;
 }
@@ -19439,7 +19437,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					goto hit;
 				}
 			}
-			if (calls_callback(env, insn_idx)) {
+			if (bpf_calls_callback(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
 				goto skip_inf_loop_check;
@@ -24165,7 +24163,7 @@ static bool can_jump(struct bpf_insn *insn)
 	return false;
 }
 
-static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
 {
 	struct bpf_insn *insn = &prog->insnsi[idx];
 	int i = 0, insn_sz;
@@ -24381,7 +24379,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 			u16 new_out = 0;
 			u16 new_in = 0;
 
-			succ_num = insn_successors(env->prog, insn_idx, succ);
+			succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
 			for (int s = 0; s < succ_num; ++s)
 				new_out |= state[succ[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
@@ -24550,7 +24548,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = insn_successors(env->prog, w, succ);
+			succ_cnt = bpf_insn_successors(env->prog, w, succ);
 			for (j = 0; j < succ_cnt; ++j) {
 				if (pre[succ[j]]) {
 					low[w] = min(low[w], low[succ[j]]);

-- 
2.51.0

