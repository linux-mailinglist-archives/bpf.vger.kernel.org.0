Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8461798DD
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgCDTTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:19:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36686 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgCDTTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so3896057wrt.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwJ/lEQbGlXVsZnbKvzZuJddWa90yHQNeHuRAfmMm6M=;
        b=YuW+r0RbYRXdAkIUknNFTEZBRZv7OC6YDbAI60Wq2zRM0dPwoWy5dQKy6DGbtUIOpn
         puJLaUyBrJ+4Ivs50kITQXHVrH/Yd4/s96h4/hvRSRbYdJValZN2Jizp70/Io9ktQYT+
         rO8SSdbboVJTJtGY/ZaeV3fI1olfAAXFYvaqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwJ/lEQbGlXVsZnbKvzZuJddWa90yHQNeHuRAfmMm6M=;
        b=Woh2s8s25c+KJfHSryZj1BqQ4VVFuB3u7FSUyogYiAJnYlxLIth2e4bbn9jHoAbMrP
         LYIshNNvmvCOi6TrCwU76LPXwp9azO9sJHcJwgcmc6lt2NQdnF1C32KHwBYd9TUVvPZj
         zN20Zz1iJkDABU8lugPTbKiLcuLD2HXKi4Yl5OfS4Dn712vo2DxeS/G7XHMt3SSzVL7p
         O9+Y7OC5D31QCDwVMEiKmvwSKXAe6grDGwnshENP8y0hYmX3ZO8D0SY8h322u+f9VzuE
         nKGzg1reLzV+W4eTpv2thZDPor+m+6dNpxZUmNp0Ab0uugfshBFCk6Bf9UBQiZFA+517
         t2DA==
X-Gm-Message-State: ANhLgQ3R6eDg5EnhPK8ph8vIteh1x1iqzf2eJYdJw1Q1BH+Ii4+g/Yh8
        tSlRqJ9r1DgJ5PPYerxpLU66pQ==
X-Google-Smtp-Source: ADFU+vtv3MhCAV7jzqkIyXGSneU1Spf0xXDb/bKfvj5B9IBmup6Pm4xF9QFcW2d4JNzwLoMP53rtEw==
X-Received: by 2002:a05:6000:1207:: with SMTP id e7mr3785748wrx.229.1583349541734;
        Wed, 04 Mar 2020 11:19:01 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:19:01 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 20:18:49 +0100
Message-Id: <20200304191853.1529-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
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
int BPF_PROG(func_name, int a, int b, int ret)
{
        // This will skip the original function logic.
        return 1;
}

The first fmod_ret program is passed 0 in its return argument.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    | 130 ++++++++++++++++++++++++++++++---
 include/linux/bpf.h            |   1 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/btf.c               |   3 +-
 kernel/bpf/syscall.c           |   1 +
 kernel/bpf/trampoline.c        |   5 +-
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   1 +
 8 files changed, 130 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d6349e930b06..b1fd000feb89 100644
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
@@ -1442,6 +1449,23 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
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
@@ -1449,9 +1473,49 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tp->nr_progs; i++) {
-		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size))
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, false))
+			return -EINVAL;
+	}
+	*pprog = prog;
+	return 0;
+}
+
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
 			return -EINVAL;
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
 	}
+
 	*pprog = prog;
 	return 0;
 }
@@ -1521,10 +1585,12 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				struct bpf_tramp_progs *tprogs,
 				void *orig_call)
 {
-	int cnt = 0, nr_args = m->nr_args;
+	int ret, i, cnt = 0, nr_args = m->nr_args;
 	int stack_size = nr_args * 8;
 	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
+	u8 **branches = NULL;
 	u8 *prog;
 
 	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
@@ -1557,24 +1623,60 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		if (invoke_bpf(m, &prog, fentry, stack_size))
 			return -EINVAL;
 
+	if (fmod_ret->nr_progs) {
+		branches = kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
+				   GFP_KERNEL);
+		if (!branches)
+			return -ENOMEM;
+
+		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, stack_size,
+				       branches)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		if (fentry->nr_progs)
+		if (fentry->nr_progs || fmod_ret->nr_progs)
 			restore_regs(m, &prog, nr_args, stack_size);
 
 		/* call original function */
-		if (emit_call(&prog, orig_call, prog))
-			return -EINVAL;
+		if (emit_call(&prog, orig_call, prog)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	}
 
+	if (fmod_ret->nr_progs) {
+		/* From Intel 64 and IA-32 Architectures Optimization
+		 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
+		 * Coding Rule 11: All branch targets should be 16-byte
+		 * aligned.
+		 */
+		emit_align(&prog, 16);
+		/* Update the branches saved in invoke_bpf_mod_ret with the
+		 * aligned address of do_fexit.
+		 */
+		for (i = 0; i < fmod_ret->nr_progs; i++)
+			emit_cond_near_jump(&branches[i], prog, branches[i],
+					    X86_JNE);
+	}
+
 	if (fexit->nr_progs)
-		if (invoke_bpf(m, &prog, fexit, stack_size))
-			return -EINVAL;
+		if (invoke_bpf(m, &prog, fexit, stack_size)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, nr_args, stack_size);
 
+	/* This needs to be done regardless. If there were fmod_ret programs,
+	 * the return value is only updated on the stack and still needs to be
+	 * restored to R0.
+	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG)
 		/* restore original return value back into RAX */
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
@@ -1586,9 +1688,15 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
 	EMIT1(0xC3); /* ret */
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY))
-		return -EFAULT;
-	return prog - (u8 *)image;
+	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+	ret = prog - (u8 *)image;
+
+cleanup:
+	kfree(branches);
+	return ret;
 }
 
 static int emit_fallback_jump(u8 **pprog)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 98ec10b23dbb..f748b31e5888 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -474,6 +474,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
 enum bpf_tramp_prog_type {
 	BPF_TRAMP_FENTRY,
 	BPF_TRAMP_FEXIT,
+	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d6b33ea27bcc..40b2d9476268 100644
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
index 546198f6f307..221a17af1f81 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -232,7 +232,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 		goto out;
 	}
 
-	if (tprogs[BPF_TRAMP_FEXIT].nr_progs)
+	if (tprogs[BPF_TRAMP_FEXIT].nr_progs ||
+	    tprogs[BPF_TRAMP_MODIFY_RETURN].nr_progs)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
 	/* Though the second half of trampoline page is unused a task could be
@@ -269,6 +270,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
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
index d6b33ea27bcc..40b2d9476268 100644
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

