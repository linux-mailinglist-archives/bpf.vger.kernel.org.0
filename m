Return-Path: <bpf+bounces-15449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1F7F2119
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAE4B21AAF
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4803AC22;
	Mon, 20 Nov 2023 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxgWmN3q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C64CF
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c773ac9b15so664201366b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521218; x=1701126018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/ZOU4kCKz13LpT3X3cOziT4V1fKJtQbR+Fw/mR+7iM=;
        b=YxgWmN3qwzxCOdlyLIRxwWr7fVbocqFuvQbye0DgypfWYCVpxtVCAsWj065JQNQHcU
         mdQda+JrZspL+bu+ts76n/lmpfkLNIwpUQTs+HDSY2oY9diyjs7QqYifez+ScFWSmRLa
         3zT1xyBewWQ78+lqoSnB/cwySaZfNQDKTlXt8luzPH/foX5yKEe3e8l05s3Z99QfoZmG
         lZWInn5+4HkT65g9FeaP0ck5uUPQUho+h9SNeWWKl5x/dnr0+NjT0tWJ8akYcKaTs4Wt
         gzaoU9u2wQuIfj2pCJFiupbU3t8JX74x6PpiDe86ZvCJBgc/61LxmWwtVj71xpscBI3t
         Vg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521218; x=1701126018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/ZOU4kCKz13LpT3X3cOziT4V1fKJtQbR+Fw/mR+7iM=;
        b=D9j7Fi4IekHqgBgtsWiUL3RqxJwnRyP+IzlLfkwSSkhugBsHMqycwDZuUROPz4VE0B
         U8oYtCb+bHUi77hP4Z9Sug33SiWaZ/FTetLsiZ5vgLTJYVbDQe0uo3DYvunIm1kN3UCm
         NE/EivFb84Iu38lxQ8QzGKj+8I8n6N8LqHC2wb9ZTAbuRxFbwBVqZlNTQLz17XmL4HZ+
         pZXk8hMxbpwj2GPp8/Wt2JObl5A9xMKKwQFXtqIQFx5ahBSn9nG/eafsT6JwCeIE0TP5
         1YFz4QOFpcWzT6cD4CushhfMyIWcFf8ZaIrAwK8T5x7J0ybXR51bjMGVIqw67Lmrx7VF
         Vx6A==
X-Gm-Message-State: AOJu0YwWDncHcpxScowIpK+HDJ4JispeTXGv0K4AbKxbq0eCOFl+baZW
	FA9GceCDoGNoBhND8bEbMkt/+3JYlXrvlg==
X-Google-Smtp-Source: AGHT+IFy0XeB2i1yiR0Q7/GVLWymMEaRSja0el2fGSUibJOYGng4374iGNv8GY1pn9IipQ68phceDQ==
X-Received: by 2002:a17:906:2253:b0:a00:4162:5d98 with SMTP id 19-20020a170906225300b00a0041625d98mr1894468ejr.19.1700521217940;
        Mon, 20 Nov 2023 15:00:17 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:16 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v3 10/11] bpf: keep track of max number of bpf_loop callback iterations
Date: Tue, 21 Nov 2023 00:59:44 +0200
Message-ID: <20231120225945.11741-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120225945.11741-1-eddyz87@gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases verifier can't infer convergence of the bpf_loop()
iteration. E.g. for the following program:

    static int cb(__u32 idx, struct num_context* ctx)
    {
        ctx->i++;
        return 0;
    }

    SEC("?raw_tp")
    int prog(void *_)
    {
        struct num_context ctx = { .i = 0 };
        __u8 choice_arr[2] = { 0, 1 };

        bpf_loop(2, cb, &ctx, 0);
        return choice_arr[ctx.i];
    }

Each 'cb' simulation would eventually return to 'prog' and reach
'return choice_arr[ctx.i]' statement. At which point ctx.i would be
marked precise, thus forcing verifier to track multitude of separate
states with {.i=0}, {.i=1}, ... at bpf_loop() callback entry.

This commit allows "brute force" handling for such cases by limiting
number of callback body simulations using 'umax' value of the first
bpf_loop() parameter.

For this, extend bpf_func_state with 'callback_depth' field.
Increment this field when callback visiting state is pushed to states
traversal stack. For frame #N it's 'callback_depth' field counts how
many times callback with frame depth N+1 had been executed.
Use bpf_func_state specifically to allow independent tracking of
callback depths when multiple nested bpf_loop() calls are present.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  | 11 ++++++
 kernel/bpf/verifier.c                         | 17 +++++++--
 .../bpf/progs/verifier_subprog_precision.c    | 35 +++++++++++++------
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6e21d74a64e7..9ed6672534c7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -301,6 +301,17 @@ struct bpf_func_state {
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
+	/* For callback calling functions that limit number of possible
+	 * callback executions (e.g. bpf_loop) keeps track of current
+	 * simulated iteration number.
+	 * Value in frame N refers to number of times callback with frame
+	 * N+1 was simulated, e.g. for the following call:
+	 *
+	 *   bpf_loop(..., fn, ...); | suppose current frame is N
+	 *                           | fn would be simulated in frame N+1
+	 *                           | number of simulations is tracked in frame N
+	 */
+	u32 callback_depth;
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 004de7c32bae..37d8c22c292a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9505,6 +9505,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return err;
 
 	callback_state->cumulative_callback_depth++;
+	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
+	caller->callback_depth = 0;
 	return 0;
 }
 
@@ -10309,8 +10311,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	case BPF_FUNC_loop:
 		update_loop_inline_state(env, meta.subprogno);
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_loop_callback_state);
+		/* Verifier relies on R1 value to determine if bpf_loop() iteration
+		 * is finished, thus mark it precise.
+		 */
+		mark_chain_precision(env, BPF_REG_1);
+		if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_value) {
+			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+						 set_loop_callback_state);
+		} else {
+			cur_func(env)->callback_depth = 0;
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "frame%d bpf_loop iteration limit reached\n",
+					env->cur_state->curframe);
+		}
 		break;
 	case BPF_FUNC_dynptr_from_mem:
 		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index da803cffb5ef..f61d623b1ce8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -119,7 +119,23 @@ __naked int global_subprog_result_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body */
+/* First simulated path does not include callback body,
+ * r1 and r4 are always precise for bpf_loop() calls.
+ */
+__msg("9: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
+__msg("mark_precise: frame0: parent state regs=r4 stack=:")
+__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
+__msg("mark_precise: frame0: regs=r4 stack= before 8: (b7) r4 = 0")
+__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
+__msg("mark_precise: frame0: parent state regs=r1 stack=:")
+__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
+__msg("mark_precise: frame0: regs=r1 stack= before 8: (b7) r4 = 0")
+__msg("mark_precise: frame0: regs=r1 stack= before 7: (b7) r3 = 0")
+__msg("mark_precise: frame0: regs=r1 stack= before 6: (bf) r2 = r8")
+__msg("mark_precise: frame0: regs=r1 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
+/* r6 precision propagation */
 __msg("14: (0f) r1 += r6")
 __msg("mark_precise: frame0: last_idx 14 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
@@ -134,10 +150,9 @@ __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r4 (flags) is always precise for bpf_loop() */
-__msg("frame 0: propagating r4")
+__msg("frame 0: propagating r1,r4")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r4 stack= before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r4 stack= before 18: (95) exit")
 __msg("from 18 to 9: safe")
 __naked int callback_result_precise(void)
 {
@@ -264,12 +279,12 @@ __msg("15: (b7) r0 = 0")
 __msg("16: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r4 (flags) is always precise for bpf_loop(),
+/* r1, r4 are always precise for bpf_loop(),
  * r6 was marked before backtracking to callback body.
  */
-__msg("frame 0: propagating r4,r6")
+__msg("frame 0: propagating r1,r4,r6")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r4,r6 stack= before 16: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r4,r6 stack= before 16: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
 __msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs= stack=:")
@@ -422,12 +437,12 @@ __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 10:")
-/* r4 (flags) is always precise for bpf_loop(),
+/* r1, r4 are always precise for bpf_loop(),
  * fp-8 was marked before backtracking to callback body.
  */
-__msg("frame 0: propagating r4,fp-8")
+__msg("frame 0: propagating r1,r4,fp-8")
 __msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r4 stack=-8 before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r1,r4 stack=-8 before 18: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
 __msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
 __msg("mark_precise: frame0: parent state regs= stack=:")
-- 
2.42.1


