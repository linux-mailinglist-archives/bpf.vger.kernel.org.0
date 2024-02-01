Return-Path: <bpf+bounces-20890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F11845020
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA681F25306
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E73BB27;
	Thu,  1 Feb 2024 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TazvSpIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50F3A8EE
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761277; cv=none; b=cVnJ8wQnrDi414+VfeJSfG3kUuuiCDqJEfxsKKl2WiGaYlnMQKjItj3Lw5Y5euMvIG67X+2/WpQQW2dwe5ghQYWm0CQYalcS/58SB+GLoUNHlMyxjbZl/vBT7y3AHBevrN7nA80/MDelHnno3dvcIlKuKyen54VHqD25lKwM5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761277; c=relaxed/simple;
	bh=qKYwvKsLrw3JsKcg64nkIme+xoRLx4arV2gWZJ4CE2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aj8gzgmSoTN4Yb829Tdx0lBKkSu1iPDV9zeYpW9FON5oqnQ8zYJbgc6TNfO+aDyJN6ntPfcHANeX6cIryXFwy9zs59SyvbeaEndJIhLryBoywmCkFbGdO0B+VtMhV1vzeDsho1otgZm6mXgpLQux50KMcFAb/beqzxDmai75hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TazvSpIi; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so583659a12.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761273; x=1707366073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHXSg/hnGXQwFDv+dpmcNyKdBOSJCDlZGg07N4nhKKg=;
        b=TazvSpIivWeT7qIf0SjHujdI1CdgVdMrECnKJ8yqBZUdzlzLoHCqDzP0c17h5Q8miN
         KNdzKlY4uMe2JMpRLUjXM+PEc6katiD3Dk/iFM6oc+nRVaXFZ5SHWnOGt2YZLG0ITKdj
         oM4fy2dz6HH4uiGGVinOzVZfxCQnP1Tmb5JDTFxJuStWJHf3Ot2uKldAj2G13WCPgKpV
         xmXHmxkQyIyPKi/5wwGHavImB4sHTtdc3/z6bF9geiNopM69AewJSbPHo5eg2X9XjoQP
         ofmro5dJwx8Bu/3owy1YkcL/1Pf/2vLYHwTkMbA8/HRkrA/qIum5jCdW2KqKQ2bD9qXc
         0Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761273; x=1707366073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHXSg/hnGXQwFDv+dpmcNyKdBOSJCDlZGg07N4nhKKg=;
        b=PFiz6hEgAlDPUzrjem2scK1sH7laaDjavMS7CLBS5g6jdgeiVeK9o+hSCXPvh+EVm/
         Ex3H7AE+qzbfmDBtRrInN6yLE3aWg9AoTHErFxvEFZBXbdwjU4ejeVunUrxEo3OpbDHA
         PwxAgbsyBCOivMAjwoBATtL1YStXkOrnVDft7BhxQoBWFvwubtGLk9jt9MJbklYCNMek
         +B3p32zX0MYAzDuDXrSrZjCtLIvDBMpnlSBT+7eJ0iC0OvuAggNGRE1U9T3pDmxk/RNR
         4Mmz+RZiMErPVzwUGBQ5r8VBOLDLwjQjjImTW5nYnbfHOtnA1G1rJF9LLWlYGfeZ59C0
         8Lgw==
X-Gm-Message-State: AOJu0YzE5R3h1L0o0cIV16dMTmqomOCnsyZmezyLKbf9g6s2d9U5DxGg
	LjvpF85WkM/o1GBbsqTHwFAttTIiYj6Ja5NK70a3RUXPogplk3ZOpBe0rqVqjr0=
X-Google-Smtp-Source: AGHT+IEDfD3aXNX6mJb2XFZw4iDgZi8uDV8NVhFchr3XxFqB05aDxc2JoQB4abARwlS5FBCN/JRohQ==
X-Received: by 2002:a05:6402:b23:b0:55e:ee3a:723 with SMTP id bo3-20020a0564020b2300b0055eee3a0723mr2303523edb.12.1706761272524;
        Wed, 31 Jan 2024 20:21:12 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ba8-20020a0564021ac800b0055f2af9b01bsm2703825edb.17.2024.01.31.20.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:11 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 01/14] bpf: Mark subprogs as throw reachable before do_check pass
Date: Thu,  1 Feb 2024 04:20:56 +0000
Message-Id: <20240201042109.1150490-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7543; i=memxor@gmail.com; h=from:subject; bh=qKYwvKsLrw3JsKcg64nkIme+xoRLx4arV2gWZJ4CE2w=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwMtn4aVsJ7zkZzBzOj5IAVI/huSU9j6vdPw Vb+avFqUoWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDAAKCRBM4MiGSL8R yp0TD/46YPc0jk/GpfbeYkLPxmJuxWQ2dDF3YaprVZCf67FFbh6sHrXNTAW+1Jo44MQwULTrpTo bbT/q4CGwfFcMEqWpxyjxjghGLvajN/6886mhqk36HJyMsF9X09EP0ZcFVGJ0rXEPpsq9ZopRlx kLlbj51UPksokivbtlhjJ2zSjUzh7/6aPG8ByD5hCXrmEjUq9ACXZqi7DdmyKEdFJ6Fg+DO4Tc8 0hHoTlBrBAh46CkmVYH+HtWMigRMvVBm8sMN5+reLOiP+TlAXGmcoB6NfPhh0jt0symMns8QfcJ hDLe93rJvDR90Cc+9VSnAhkgTMAhGrSvU554YZEz5fvcYvRlDElQAZPjm2OO+jS8Vgs56fR9vOQ UOwaHNxM8pw2fvdeqM5sXE4T6tLTOimaeKGZaEiGgul7TckV1uT3t70w5z7gjr4wXgfTNf8/2Vn kNBUcw24e2CAB2VOhqT6sG9gS6+RGg7WMwrXyp1Hdh6B5Egc46frk5MfDyl3tZwc7VTfoGjqskt 48Re100ITxnsQWliRYPUhPwlRXLAPthHIeHeHfNKh+2ePuaopyqv3mBSJX+w9//TQFAGTKcBywL RvfTYyX6J4m0ibLNoXyQ7QvRLLtm9w8ZdajvEbElI3FpGzcHNoeC5E1ThNWk0TJaTMBcT8ksVnu GmUTGU7C+3mrwiw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The motivation of this patch is to figure out which subprogs participate
in exception propagation. In other words, whichever subprog's execution
can lead to an exception being thrown either directly or indirectly (by
way of calling other subprogs).

With the current exceptions support, the runtime performs stack
unwinding when bpf_throw is called. For now, any resources acquired by
the program cannot be released, therefore bpf_throw calls made with
non-zero acquired references must be rejected during verification.

However, there currently exists a loophole in this restriction due to
the way the verification procedure is structured. The verifier will
first walk over the main subprog's instructions, but not descend into
subprog calls to ones with global linkage. These global subprogs will
then be independently verified instead. Therefore, in a situation where
a global subprog ends up throwing an exception (either directly by
calling bpf_throw, or indirectly by way of calling another subprog that
does so), the verifier will fail to notice this fact and may permit
throwing BPF exceptions with non-zero acquired references.

Therefore, to fix this, we add a summarization pass before the do_check
stage which walks all call chains of the program and marks all of the
subprogs that are reachable from a bpf_throw call which unwinds the
program stack.

We only do so if we actually see a bpf_throw call in the program though,
since we do not want to walk all instructions unless we need to.  One we
analyze all possible call chains of the program, we will be able to mark
them as 'is_throw_reachable' in their subprog_info.

After performing this step, we need to make another change as to how
subprog call verification occurs. In case of global subprog, we will
need to explore an alternate program path where the call instruction
processing of a global subprog's call will immediately throw an
exception. We will thus simulate a normal path without any exceptions,
and one where the exception is thrown and the program proceeds no
further. In this way, the verifier will be able to detect the whether
any acquired references or locks exist in the verifier state and thus
reject the program if needed.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 86 ++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0dcde339dc7e..1d666b6c21e6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -626,6 +626,7 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
+	bool is_throw_reachable: 1;
 
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
@@ -691,6 +692,7 @@ struct bpf_verifier_env {
 	bool bypass_spec_v4;
 	bool seen_direct_write;
 	bool seen_exception;
+	bool seen_throw_insn;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd4d780e5400..bba53c4e3a0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2941,6 +2941,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		    insn[i].src_reg == 0 &&
 		    insn[i].imm == BPF_FUNC_tail_call)
 			subprog[cur_subprog].has_tail_call = true;
+		if (!env->seen_throw_insn && is_bpf_throw_kfunc(&insn[i]))
+			env->seen_throw_insn = true;
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;
@@ -5866,6 +5868,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 
 			if (!is_bpf_throw_kfunc(insn + i))
 				continue;
+			/* When this is allowed, don't forget to update logic for sync and
+			 * async callbacks in mark_exception_reachable_subprogs.
+			 */
 			if (subprog[idx].is_cb)
 				err = true;
 			for (int c = 0; c < frame && !err; c++) {
@@ -16205,6 +16210,83 @@ static int check_btf_info(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* We walk the call graph of the program in this function, and mark everything in
+ * the call chain as 'is_throw_reachable'. This allows us to know which subprog
+ * calls may propagate an exception and generate exception frame descriptors for
+ * those call instructions. We already do that for bpf_throw calls made directly,
+ * but we need to mark the subprogs as we won't be able to see the call chains
+ * during symbolic execution in do_check_common due to global subprogs.
+ *
+ * Note that unlike check_max_stack_depth, we don't explore the async callbacks
+ * apart from main subprogs, as we don't support throwing from them for now, but
+ */
+static int mark_exception_reachable_subprogs(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int idx = 0, frame = 0, i, subprog_end;
+	int ret_insn[MAX_CALL_FRAMES];
+	int ret_prog[MAX_CALL_FRAMES];
+
+	/* No need if we never saw any bpf_throw() call in the program. */
+	if (!env->seen_throw_insn)
+		return 0;
+
+	i = subprog[idx].start;
+restart:
+	subprog_end = subprog[idx + 1].start;
+	for (; i < subprog_end; i++) {
+		int next_insn, sidx;
+
+		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
+			if (!is_bpf_throw_kfunc(insn + i))
+				continue;
+			subprog[idx].is_throw_reachable = true;
+			for (int j = 0; j < frame; j++)
+				subprog[ret_prog[j]].is_throw_reachable = true;
+		}
+
+		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
+			continue;
+		/* remember insn and function to return to */
+		ret_insn[frame] = i + 1;
+		ret_prog[frame] = idx;
+
+		/* find the callee */
+		next_insn = i + insn[i].imm + 1;
+		sidx = find_subprog(env, next_insn);
+		if (sidx < 0) {
+			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n", next_insn);
+			return -EFAULT;
+		}
+		/* We cannot distinguish between sync or async cb, so we need to follow
+		 * both.  Async callbacks don't really propagate exceptions but calling
+		 * bpf_throw from them is not allowed anyway, so there is no harm in
+		 * exploring them.
+		 * TODO: To address this properly, we will have to move is_cb,
+		 * is_async_cb markings to the stage before do_check.
+		 */
+		i = next_insn;
+		idx = sidx;
+
+		frame++;
+		if (frame >= MAX_CALL_FRAMES) {
+			verbose(env, "the call stack of %d frames is too deep !\n", frame);
+			return -E2BIG;
+		}
+		goto restart;
+	}
+	/* end of for() loop means the last insn of the 'subprog'
+	 * was reached. Doesn't matter whether it was JA or EXIT
+	 */
+	if (frame == 0)
+		return 0;
+	frame--;
+	i = ret_insn[frame];
+	idx = ret_prog[frame];
+	goto restart;
+}
+
 /* check %cur's range satisfies %old's */
 static bool range_within(struct bpf_reg_state *old,
 			 struct bpf_reg_state *cur)
@@ -20939,6 +21021,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = mark_exception_reachable_subprogs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
-- 
2.40.1


