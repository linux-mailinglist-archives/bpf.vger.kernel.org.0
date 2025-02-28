Return-Path: <bpf+bounces-52852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C589A49148
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2183B7298
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19E1C3C12;
	Fri, 28 Feb 2025 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM8IWkzD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2D849C
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722460; cv=none; b=EWrPwt/FHoZP4oC2JvC1uE2hg1RXkfNY2e70CfLPH0ldMFMZ7kmsJPep9EnWvbvr27lWi66udkRepsCkQoZbSZwiCVN9DtVDFJrfkCHTFwf8dCXhrDj4wtW5R0sXO1plYIMtX9oIhtJxd9kWNzLpsCY0RuvTvoV/4Dq+1OQKXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722460; c=relaxed/simple;
	bh=2+cYnICyDnBWCNrH77LDhSDEYAcWdg5APrgORB9jTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONraqoTsAXXF6oQ7Prm2hlCFYZnW2D/2dIQP3WajBrFqVU/IfN/2JAW2cUzx50Osj9ErWFXW7vCYTjYJ5m9bjFUNmjNa1YFMq5ctEZg/bkdIPpBFnhTtbazYtBvQAsekvtWsQkE4PA/5c7uihMEF7HLr2gmmaqZdXITly3tTT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM8IWkzD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223480ea43aso43717065ad.1
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 22:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740722457; x=1741327257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJqtmJmSdbVv1/i4cPlNtB6O7qSEOQkEqTdM6K9zkUA=;
        b=UM8IWkzD66dU+/Q0/lEkrTDZztl9VwnO0laLXGbO1rpUinDxcHWVNSBunjDz7HvxoV
         9WgpQUBA7qQ8joiXcwAYTmFqXVA2SyJ6mPRbaRzh37KrF/SdLrt/4lsvyisOqlp4nHTe
         KLz3Xi+6iOmtqjDWUK1Jzx2sDXsn5cWs++CZm3Vrs99lmrmSxcCBgmlv8655+K+RmNIQ
         5ONH2wPVM5L4RyQjsynbCWrFk6JuqakWNEYm7WQAELPtK3KB0jeNhcEwnoZiiJqoJPRr
         HQYgtAC/a2Y0BdHVcn8sqeFMHMP2/yyjn8nHqHru+LWHxx5KzLAg8+KVtNT4kpND/dN7
         XSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722457; x=1741327257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJqtmJmSdbVv1/i4cPlNtB6O7qSEOQkEqTdM6K9zkUA=;
        b=FQtqUAqVDJznlvBXQSNEoq4QVc+HlAbgGsk58qRx1VG1Z0w4MDitAyuBQTvK5PK70M
         1MScJ/9ZERrTfWJ2zuWliTuJklD5dZlszaYs8A4Rsl+A4uV+Yw0Ev0k3GE5t31Uet1fc
         mbtlj72fnprl1SqPaQCLKtsChfUCewUv9U6C1DTUX/y/huSN8hs0ua9RcOM83GvvMnJt
         C374xponR3vvXW21Ol0+7aPkQ4ehQWLX1TCmBplFLwdJEXwj4eb5e+SaHM6uC0lvwL1B
         Jlg9nmFTSBaLL8+YVynGSsDRY8bP4ue//DD+AWzcTkKpkSBdkbeOyNqGWjK2mex8sQ2W
         Vq0g==
X-Gm-Message-State: AOJu0YxiiUKXK36w7hPnPrTuiKa6rc/p6KbnOSNYfQQWXAjQ23nlhyfX
	H+eU7ylTK69x9cWmuUOj9hg9sc8ri/DRBxpxi8xbaRFSTv6squ6SckBjog==
X-Gm-Gg: ASbGnctb7O0jZQjIEtoYf/M15J9i71YWkfVd56TMCnJYbAo9Be4EoIDJUd0GhrSS1hS
	2/oYYb1L+lupD7gpmNqFYVx0N3zzmzNm1TOxFkOE1nlvS1LN+DKCZMpGEyDdqNs0cti+cwv1Efy
	P2/lunviN6SJmojSq4H5HsgPg+CEceRWAlaUWK6oQnFCd2WRncGU0NxtQYEinUR7I8UYzFunsma
	odOUS6oWVsriT0VoL+kPfMHuLJ6Gr/skbHrxTig22BTHOV0eLe0T5YLm5OeZsMNsvSsSADh2Bqu
	DeFbUjU/QY7VVgDVDOOngA==
X-Google-Smtp-Source: AGHT+IH8pHgHXo6V0FeoEBE9Jd7rUxc+HfQxisxg4IG5hrycUz0rJuJkORfH7whDGz42xxoz0rbg5w==
X-Received: by 2002:a05:6a00:2194:b0:730:74f8:25b9 with SMTP id d2e1a72fcca58-734ac3d5f9cmr3277765b3a.17.1740722457186;
        Thu, 27 Feb 2025 22:00:57 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb97sm2927018b3a.148.2025.02.27.22.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:00:56 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/3] bpf: simple DFA-based live registers analysis
Date: Thu, 27 Feb 2025 22:00:30 -0800
Message-ID: <20250228060032.1425870-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228060032.1425870-1-eddyz87@gmail.com>
References: <20250228060032.1425870-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compute may-live registers before each instruction in the program.
A register is live before instruction I if it is read by I or by some
instruction S that follows I, provided it is not overwritten between I
and S.

This information will be used in the next patch as a hint in
func_states_equal().

Use a simple algorithm described in [1] to compute this information:
- define the following:
  - I.use : the set of all registers read by instruction I;
  - I.def : the set of all registers written by instruction I;
  - I.in  : the set of all registers that may be alive before I
            execution;
  - I.out : the set of all registers that may be alive after I
            execution;
  - I.successors : the set of instructions S that might immediately
                   follow I for some program execution;
- associate separate empty sets 'I.in' and 'I.out' with each instruction;
- visit each instruction in a postorder and update the corresponding
  'I.in' and 'I.out' sets as follows:

      I.out = U [S.in for S in I.successors]
      I.in  = (I.out / I.def) U I.use

  (where U stands for set union, / stands for set difference)
- repeat the computation while I.{in,out} changes for any instruction.

On implementation side keep things as simple, as possible:
- check_cfg() already marks instructions EXPLORED in post-order,
  modify it to save the index of each EXPLORED instruction in a vector;
- represent I.{in,out,use,def} as bitmasks;
- don't split the program into basic blocks and don't maintain the
  work queue, instead:
  - perform fixed-point computation by visiting each instruction;
  - maintain a simple 'changed' flag to track if I.{in,out} changes
    for any instruction;

  Measurements show that even this simplistic implementation does not
  add measurable verification time overhead (at least for selftests).

Note on check_cfg() ex_insn_beg/ex_done change:
To avoid out of bounds access to env->cfg.insn_postorder array,
it must be guaranteed that an instruction transitions to the EXPLORED
state only once. Previously, this was not the case for incorrect
programs with direct calls to exception callbacks.

The 'align' selftest needs adjustment to skip the computed
instruction/live registers printout. Otherwise, it matches lines from
this printout instead of verification log.

[1] https://en.wikipedia.org/wiki/Live-variable_analysis

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   6 +
 kernel/bpf/verifier.c                         | 376 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 3 files changed, 369 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bbd013c38ff9..8c23958bc471 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -591,6 +591,8 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* registers alive before this instruction. */
+	u16 live_regs_before;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -747,7 +749,11 @@ struct bpf_verifier_env {
 	struct {
 		int *insn_state;
 		int *insn_stack;
+		/* vector of instruction indexes sorted in post-order */
+		int *insn_postorder;
 		int cur_stack;
+		/* current position in the insn_postorder vector */
+		int cur_postorder;
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_insn_hist_entry *insn_hist;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcd0da4e62fc..4ac7dc58d9b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3353,6 +3353,15 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int jmp_offset(struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	if (code == (BPF_JMP32 | BPF_JA))
+		return insn->imm;
+	return insn->off;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3379,10 +3388,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
-		if (code == (BPF_JMP32 | BPF_JA))
-			off = i + insn[i].imm + 1;
-		else
-			off = i + insn[i].off + 1;
+		off = i + jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -3912,6 +3918,17 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
+static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_insn_cbs cbs = {
+		.cb_call	= disasm_kfunc_name,
+		.cb_print	= verbose,
+		.private_data	= env,
+	};
+
+	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+}
+
 static inline void bt_init(struct backtrack_state *bt, u32 frame)
 {
 	bt->frame = frame;
@@ -4112,11 +4129,6 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
-	const struct bpf_insn_cbs cbs = {
-		.cb_call	= disasm_kfunc_name,
-		.cb_print	= verbose,
-		.private_data	= env,
-	};
 	struct bpf_insn *insn = env->prog->insnsi + idx;
 	u8 class = BPF_CLASS(insn->code);
 	u8 opcode = BPF_OP(insn->code);
@@ -4134,7 +4146,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+		verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -11011,6 +11023,9 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 	return *ptr ? 0 : -EINVAL;
 }
 
+/* Bitmask with 1s for all caller saved registers */
+#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -17246,9 +17261,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state;
+	int *insn_stack, *insn_state, *insn_postorder;
 	int ex_insn_beg, i, ret = 0;
-	bool ex_done = false;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
@@ -17260,6 +17274,17 @@ static int check_cfg(struct bpf_verifier_env *env)
 		return -ENOMEM;
 	}
 
+	insn_postorder = env->cfg.insn_postorder = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	if (!insn_postorder) {
+		kvfree(insn_state);
+		kvfree(insn_stack);
+		return -ENOMEM;
+	}
+
+	ex_insn_beg = env->exception_callback_subprog
+		      ? env->subprog_info[env->exception_callback_subprog].start
+		      : 0;
+
 	insn_state[0] = DISCOVERED; /* mark 1st insn as discovered */
 	insn_stack[0] = 0; /* 0 is the first instruction */
 	env->cfg.cur_stack = 1;
@@ -17273,6 +17298,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
 			env->cfg.cur_stack--;
+			insn_postorder[env->cfg.cur_postorder++] = t;
 			break;
 		case KEEP_EXPLORING:
 			break;
@@ -17291,13 +17317,10 @@ static int check_cfg(struct bpf_verifier_env *env)
 		goto err_free;
 	}
 
-	if (env->exception_callback_subprog && !ex_done) {
-		ex_insn_beg = env->subprog_info[env->exception_callback_subprog].start;
-
+	if (ex_insn_beg && insn_state[ex_insn_beg] != EXPLORED) {
 		insn_state[ex_insn_beg] = DISCOVERED;
 		insn_stack[0] = ex_insn_beg;
 		env->cfg.cur_stack = 1;
-		ex_done = true;
 		goto walk_cfg;
 	}
 
@@ -19121,19 +19144,13 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (env->log.level & BPF_LOG_LEVEL) {
-			const struct bpf_insn_cbs cbs = {
-				.cb_call	= disasm_kfunc_name,
-				.cb_print	= verbose,
-				.private_data	= env,
-			};
-
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
 
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+			verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
@@ -23199,6 +23216,312 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
+static bool can_fallthrough(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return true;
+
+	if (opcode == BPF_EXIT || opcode == BPF_JA)
+		return false;
+
+	return true;
+}
+
+static bool can_jump(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return false;
+
+	switch (opcode) {
+	case BPF_JA:
+	case BPF_JEQ:
+	case BPF_JNE:
+	case BPF_JLT:
+	case BPF_JLE:
+	case BPF_JGT:
+	case BPF_JGE:
+	case BPF_JSGT:
+	case BPF_JSGE:
+	case BPF_JSLT:
+	case BPF_JSLE:
+	case BPF_JCOND:
+		return true;
+	}
+
+	return false;
+}
+
+static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+{
+	struct bpf_insn *insn = &prog->insnsi[idx];
+	int i = 0, insn_sz;
+	u32 dst;
+
+	succ[0] = prog->len;
+	succ[1] = prog->len;
+
+	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+	if (can_fallthrough(insn) && idx + 1 < prog->len)
+		succ[i++] = idx + insn_sz;
+
+	if (can_jump(insn)) {
+		dst = idx + jmp_offset(insn) + 1;
+		if (i == 0 || succ[0] != dst)
+			succ[i++] = dst;
+	}
+
+	return i;
+}
+
+/* Each field is a register bitmask */
+struct insn_live_regs {
+	u16 use;	/* registers read by instruction */
+	u16 def;	/* registers written by instruction */
+	u16 in;		/* registers that may be alive before instruction */
+	u16 out;	/* registers that may be alive after instruction */
+};
+
+/* Compute *use and *def values for the call instruction */
+static void compute_call_live_regs(struct bpf_verifier_env *env,
+				   struct bpf_insn *insn,
+				   u16 *use, u16 *def)
+{
+	struct bpf_kfunc_call_arg_meta meta;
+	const struct bpf_func_proto *fn;
+	int err, i, nargs;
+
+	*def = ALL_CALLER_SAVED_REGS;
+	*use = *def & ~BIT(BPF_REG_0);
+	if (bpf_helper_call(insn)) {
+		err = get_helper_proto(env, insn->imm, &fn);
+		if (err)
+			return;
+		*use = 0;
+		for (i = 1; i < CALLER_SAVED_REGS; i++) {
+			if (fn->arg_type[i - 1] == ARG_DONTCARE)
+				break;
+			*use |= BIT(i);
+		}
+	} else if (bpf_pseudo_kfunc_call(insn)) {
+		err = fetch_kfunc_meta(env, insn, &meta, NULL);
+		if (err)
+			return;
+		nargs = btf_type_vlen(meta.func_proto);
+		*use = 0;
+		for (i = 1; i <= nargs; i++)
+			*use |= BIT(i);
+	}
+}
+
+/* Compute info->{use,def} fields for the instruction */
+static void compute_insn_live_regs(struct bpf_verifier_env *env,
+				   struct bpf_insn *insn,
+				   struct insn_live_regs *info)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 code = BPF_OP(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	u16 src = BIT(insn->src_reg);
+	u16 dst = BIT(insn->dst_reg);
+	u16 r0  = BIT(0);
+	u16 def = 0;
+	u16 use = 0xffff;
+
+	switch (class) {
+	case BPF_LD:
+		switch (mode) {
+		case BPF_IMM:
+			if (BPF_SIZE(insn->code) == BPF_DW) {
+				def = dst;
+				use = 0;
+			}
+			break;
+		case BPF_LD | BPF_ABS:
+		case BPF_LD | BPF_IND:
+			/* stick with defaults */
+			break;
+		}
+		break;
+	case BPF_LDX:
+		switch (mode) {
+		case BPF_MEM:
+		case BPF_MEMSX:
+			def = dst;
+			use = src;
+			break;
+		}
+		break;
+	case BPF_ST:
+		switch (mode) {
+		case BPF_MEM:
+			def = 0;
+			use = dst;
+			break;
+		}
+		break;
+	case BPF_STX:
+		switch (mode) {
+		case BPF_MEM:
+			def = 0;
+			use = dst | src;
+			break;
+		case BPF_ATOMIC:
+			use = dst | src;
+			if (insn->imm & BPF_FETCH) {
+				if (insn->imm == BPF_CMPXCHG)
+					def = r0;
+				else
+					def = src;
+			} else {
+				def = 0;
+			}
+			break;
+		}
+		break;
+	case BPF_ALU:
+	case BPF_ALU64:
+		switch (code) {
+		case BPF_END:
+			use = dst;
+			def = dst;
+			break;
+		case BPF_MOV:
+			def = dst;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = 0;
+			else
+				use = src;
+			break;
+		default:
+			def = dst;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = dst;
+			else
+				use = dst | src;
+		}
+		break;
+	case BPF_JMP:
+	case BPF_JMP32:
+		switch (code) {
+		case BPF_JA:
+			def = 0;
+			use = 0;
+			break;
+		case BPF_EXIT:
+			def = 0;
+			use = r0;
+			break;
+		case BPF_CALL:
+			compute_call_live_regs(env, insn, &use, &def);
+			break;
+		default:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = dst;
+			else
+				use = dst | src;
+		}
+		break;
+	}
+
+	info->def = def;
+	info->use = use;
+}
+
+/* Compute may-live registers before each instruction in the program.
+ * A register is live before instruction I if it is read by I or by some
+ * instruction S that follows I, provided it is not overwritten between I
+ * and S.
+ *
+ * Store result in env->insn_aux_data[i].live_regs.
+ */
+static int compute_live_registers(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct insn_live_regs *state;
+	int insn_cnt = env->prog->len;
+	int err = 0, i, j;
+	bool changed;
+
+	/* Use simple algorithm desribed in:
+	 * https://en.wikipedia.org/wiki/Live-variable_analysis
+	 *
+	 * - visit each instruction in a postorder and update
+	 *   state[i].in, state[i].out as follows:
+	 *
+	 *       state[i].out = U [state[s].in for S in insn_successors(i)]
+	 *       state[i].in  = (state[i].out / state[i].def) U state[i].use
+	 *
+	 *   (where U stands for set union, / stands for set difference)
+	 * - repeat the computation while {in,out} fields change for
+	 *   any instruction.
+	 */
+	state = kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < insn_cnt; ++i)
+		compute_insn_live_regs(env, &insns[i], &state[i]);
+
+	changed = true;
+	while (changed) {
+		changed = false;
+		for (i = 0; i < env->cfg.cur_postorder; ++i) {
+			int insn_idx = env->cfg.insn_postorder[i];
+			struct insn_live_regs *live = &state[insn_idx];
+			int succ_num;
+			u32 succ[2];
+			u16 new_out = 0;
+			u16 new_in = 0;
+
+			succ_num = insn_successors(env->prog, insn_idx, succ);
+			for (int s = 0; s < succ_num; ++s)
+				new_out |= state[succ[s]].in;
+			new_in = (new_out & ~live->def) | live->use;
+			if (new_out != live->out || new_in != live->in) {
+				live->in = new_in;
+				live->out = new_out;
+				changed = true;
+			}
+		}
+	}
+
+	for (i = 0; i < insn_cnt; ++i)
+		insn_aux[i].live_regs_before = state[i].in;
+
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		verbose(env, "Live regs before insn:\n");
+		for (i = 0; i < insn_cnt; ++i) {
+			verbose(env, "%3d: ", i);
+			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
+				if (insn_aux[i].live_regs_before & BIT(j))
+					verbose(env, "%d", j);
+				else
+					verbose(env, ".");
+			verbose(env, " ");
+			verbose_insn(env, &insns[i]);
+			if (bpf_is_ldimm64(&insns[i]))
+				i++;
+		}
+	}
+
+out:
+	kvfree(state);
+	kvfree(env->cfg.insn_postorder);
+	env->cfg.insn_postorder = NULL;
+	env->cfg.cur_postorder = 0;
+	return err;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -23320,6 +23643,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	if (is_priv) {
+		ret = compute_live_registers(env);
+		if (ret < 0)
+			goto skip_full_check;
+	}
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23458,6 +23787,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	vfree(env->insn_aux_data);
 	kvfree(env->insn_hist);
 err_free_env:
+	kvfree(env->cfg.insn_postorder);
 	kvfree(env);
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 4ebd0da898f5..1d53a8561ee2 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -610,9 +610,11 @@ static int do_test_single(struct bpf_align_test *test)
 		.log_size = sizeof(bpf_vlog),
 		.log_level = 2,
 	);
+	const char *main_pass_start = "0: R1=ctx() R10=fp0";
 	const char *line_ptr;
 	int cur_line = -1;
 	int prog_len, i;
+	char *start;
 	int fd_prog;
 	int ret;
 
@@ -632,7 +634,13 @@ static int do_test_single(struct bpf_align_test *test)
 		ret = 0;
 		/* We make a local copy so that we can strtok() it */
 		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
-		line_ptr = strtok(bpf_vlog_copy, "\n");
+		start = strstr(bpf_vlog_copy, main_pass_start);
+		if (!start) {
+			ret = 1;
+			printf("Can't find initial line '%s'\n", main_pass_start);
+			goto out;
+		}
+		line_ptr = strtok(start, "\n");
 		for (i = 0; i < MAX_MATCHES; i++) {
 			struct bpf_reg_match m = test->matches[i];
 			const char *p;
@@ -682,6 +690,7 @@ static int do_test_single(struct bpf_align_test *test)
 				break;
 			}
 		}
+out:
 		if (fd_prog >= 0)
 			close(fd_prog);
 	}
-- 
2.48.1


