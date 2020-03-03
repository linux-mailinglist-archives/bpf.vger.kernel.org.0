Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EB177860
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 15:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgCCOKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 09:10:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40056 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgCCOKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id e26so2971884wme.5
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 06:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3wLmnedtRIsQ31GvMeMyuxUeke3IeM+qgkOo8SETBQ=;
        b=hRBSNYgEstsK/3CMS6BLHyiJfM1xFXVsvevjgSv77CH5SJM8V6sTICslZmptn01wKT
         XZ/t47q/YqriWqXLHGdCOTewEdXxmLvZxKeuKLFfQ9nP4bqjJjaLnmUrzivSDxQXCRfh
         ph76wS6/lpxMnBLbHX1kC7q1GLlym8YGTS1wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3wLmnedtRIsQ31GvMeMyuxUeke3IeM+qgkOo8SETBQ=;
        b=JB0AfUGzFZXSCJFPL2MZ7LXPkP/nrqRB/PiyMH4HtZGIhK/lsFOH3IcNBkL0R8kVhc
         SIboGcLvrxRRC79A7pLe2B7wo3MofZvbU7s0shQOW25QzAYBl8T5eR20k59t9y4VQpUy
         xYHNvg3TKwT6px7kCmqGVSvE9+lNm2FuqR7cKxAxXvr2PkgZcsAa1mCTNPw51t7T5cOG
         N0BCkgRYqDPyF0l8iw+UPY6tG3fK4J0HMiIgrpBPfR2OcqnCOs8PcC+GlWvGThMIXTQX
         fb2FeVgvaWWZ4/eLhlnltmqfC9V6b37w0npHKwFr+lDQF3G0vaDIehxrfZLtCMCUCXiQ
         Nskg==
X-Gm-Message-State: ANhLgQ3AZ7feGHdTomplTH7eMdb4a0NasgD4E8Auc1RZqbK6OlaXjRVZ
        JHCLT2/R5a0jhtwmrkMoPOlVfg==
X-Google-Smtp-Source: ADFU+vviivw9RKpvO9qxugKPxzPx3aTUxhL2y0hL9kESVzW3lRnIX+8hy80lpDaeewaq5TKiMTxfSg==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr4363989wmc.78.1583244603305;
        Tue, 03 Mar 2020 06:10:03 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:2811:c80d:9375:bf8a])
        by smtp.gmail.com with ESMTPSA id h20sm11746823wrc.47.2020.03.03.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:10:02 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 3/7] bpf: Introduce BPF_MODIFY_RETURN
Date:   Tue,  3 Mar 2020 15:09:46 +0100
Message-Id: <20200303140950.6355-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303140950.6355-1-kpsingh@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

When multiple programs are attached, each program receives the return
value from the previous program on the stack and the last program
provides the return value to the attached function.

The fmod_ret bpf programs are run after the fentry programs and before
the fexit programs. The original function is only called if all the
fmod_ret programs return 0 to avoid any unintended side-effects. The
success value, i.e. 0 is not currently configurable but can be made so
where user-space can specify it at load time.

For example:

int func_to_be_attached(int a, int b)
{  <--- do_fentry

do_fmod_ret:
   <update ret by calling fmod_ret>
   if (ret != 0)
        goto do_fexit;

original_function:

    <side_effects_happen_here>

}  <--- do_fexit

The fmod_ret program attached to this function can be defined as:

SEC("fmod_ret/func_to_be_attached")
BPF_PROG(func_name, int a, int b, int ret)
{
        // This will skip the original function logic.
        return 1;
}

The first fmod_ret program is passed 0 in its return argument.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 arch/x86/net/bpf_jit_comp.c    | 96 ++++++++++++++++++++++++++++++++--
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/btf.c               |  3 +-
 kernel/bpf/syscall.c           |  1 +
 kernel/bpf/trampoline.c        |  5 +-
 kernel/bpf/verifier.c          |  1 +
 tools/include/uapi/linux/bpf.h |  1 +
 8 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 475e354c2e88..f16f78aeecf9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1362,7 +1362,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_prog *p, int stack_size)
+			   struct bpf_prog *p, int stack_size, bool mod_ret)
 {
 	u8 *prog = *pprog;
 	int cnt = 0;
@@ -1383,6 +1383,13 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	if (emit_call(&prog, p->bpf_func, prog))
 		return -EINVAL;
 
+	/* BPF_TRAMP_MODIFY_RETURN trampolines can modify the return
+	 * of the previous call which is then passed on the stack to
+	 * the next BPF program.
+	 */
+	if (mod_ret)
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32,
 		       (u32) (long) p);
@@ -1447,6 +1454,23 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 	return 0;
 }
 
+static int emit_mod_ret_check_imm8(u8 **pprog, int value)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (!is_imm8(value))
+		return -EINVAL;
+
+	if (value == 0)
+		EMIT2(0x85, add_2reg(0xC0, BPF_REG_0, BPF_REG_0));
+	else
+		EMIT3(0x83, add_1reg(0xF8, BPF_REG_0), value);
+
+	*pprog = prog;
+	return 0;
+}
+
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_progs *tp, int stack_size)
 {
@@ -1454,13 +1478,53 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tp->nr_progs; i++) {
-		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size))
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, false))
 			return -EINVAL;
 	}
 	*pprog = prog;
 	return 0;
 }
 
+static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
+			      struct bpf_tramp_progs *tp, int stack_size,
+			      u8 **branches)
+{
+	u8 *prog = *pprog;
+	int i;
+
+	/* The first fmod_ret program will receive a garbage return value.
+	 * Set this to 0 to avoid confusing the program.
+	 */
+	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+	for (i = 0; i < tp->nr_progs; i++) {
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, true))
+			return -EINVAL;
+
+		/* Generate a branch:
+		 *
+		 * if (ret !=  0)
+		 *	goto do_fexit;
+		 *
+		 * If needed this can be extended to any integer value which can
+		 * be passed by user-space when the program is loaded.
+		 */
+		if (emit_mod_ret_check_imm8(&prog, 0))
+			return -EINVAL;
+
+		/* Save the location of the branch and Generate 6 nops
+		 * (4 bytes for an offset and 2 bytes for the jump) These nops
+		 * are replaced with a conditional jump once do_fexit (i.e. the
+		 * start of the fexit invocation) is finalized.
+		 */
+		branches[i] = prog;
+		emit_nops(&prog, 4 + 2);
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
 /* Example:
  * __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
  * its 'struct btf_func_model' will be nr_args=2
@@ -1526,10 +1590,12 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				struct bpf_tramp_progs *tprogs,
 				void *orig_call)
 {
-	int cnt = 0, nr_args = m->nr_args;
+	int i, cnt = 0, nr_args = m->nr_args;
 	int stack_size = nr_args * 8;
 	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
+	u8 **branches = NULL;
 	u8 *prog;
 
 	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
@@ -1562,8 +1628,18 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		if (invoke_bpf(m, &prog, fentry, stack_size))
 			return -EINVAL;
 
+	if (fmod_ret->nr_progs) {
+		branches = kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
+				   GFP_KERNEL);
+		if (!branches)
+			return -ENOMEM;
+		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, stack_size,
+				       branches))
+			return -EINVAL;
+	}
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		if (fentry->nr_progs)
+		if (fentry->nr_progs || fmod_ret->nr_progs)
 			restore_regs(m, &prog, nr_args, stack_size);
 
 		/* call original function */
@@ -1573,6 +1649,14 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	}
 
+	if (fmod_ret->nr_progs) {
+		align16_branch_target(&prog);
+		for (i = 0; i < fmod_ret->nr_progs; i++)
+			emit_cond_near_jump(&branches[i], prog, branches[i],
+					    X86_JNE);
+		kfree(branches);
+	}
+
 	if (fexit->nr_progs)
 		if (invoke_bpf(m, &prog, fexit, stack_size))
 			return -EINVAL;
@@ -1580,6 +1664,10 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, nr_args, stack_size);
 
+	/* This needs to be done regardless. If there were fmod_ret programs,
+	 * the return value is only updated on the stack and still needs to be
+	 * restored to R0.
+	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG)
 		/* restore original return value back into RAX */
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 98ec10b23dbb..3cfdc216a2f4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -473,6 +473,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
 
 enum bpf_tramp_prog_type {
 	BPF_TRAMP_FENTRY,
+	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_FEXIT,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8e98ced0963b..b049f69925f5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -210,6 +210,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_MODIFY_RETURN,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 787140095e58..30841fb8b3c0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,7 +3710,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
-	if (prog->expected_attach_type == BPF_TRACE_FEXIT &&
+	if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+	     prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 	    arg == nr_args) {
 		if (!t)
 			/* Default prog with 5 args. 6th arg is retval. */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 13de65363ba2..7ce0815793dd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2324,6 +2324,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 
 	if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 	    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+	    prog->expected_attach_type != BPF_MODIFY_RETURN &&
 	    prog->type != BPF_PROG_TYPE_EXT) {
 		err = -EINVAL;
 		goto out_put_prog;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9daeb094f054..ebf0f2131848 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -233,7 +233,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 		goto out;
 	}
 
-	if (tprogs[BPF_TRAMP_FEXIT].nr_progs)
+	if (tprogs[BPF_TRAMP_FEXIT].nr_progs ||
+	    tprogs[BPF_TRAMP_MODIFY_RETURN].nr_progs)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
 	/* Though the second half of trampoline page is unused a task could be
@@ -270,6 +271,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
 	switch (t) {
 	case BPF_TRACE_FENTRY:
 		return BPF_TRAMP_FENTRY;
+	case BPF_MODIFY_RETURN:
+		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 289383edfc8c..2460c8e6b5be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9950,6 +9950,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		if (!prog_extension)
 			return -EINVAL;
 		/* fallthrough */
+	case BPF_MODIFY_RETURN:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 		if (!btf_type_is_func(t)) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 906e9f2752db..c44ee9bf3479 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -210,6 +210,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_MODIFY_RETURN,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1

