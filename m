Return-Path: <bpf+bounces-15291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EBD7EFCFE
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0509DB20B7E
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434315B0;
	Sat, 18 Nov 2023 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1cOWp+i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F70D79
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a3b8b113so3786929e87.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271258; x=1700876058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puI7dKGKydeFQ9oVeOcwkhGLijEh4uJPMsM7jH3Ze9Y=;
        b=M1cOWp+iv9ymRlvWfo8bEOiClhWzCXiQa/jbd223jYb9yZJmydsQCdHXRg12oKmkZm
         ATrvdeIETQ14ArHSPWdDEvSWxXymDBph0Bqv3nqlaagZ5QK1A/bEpPu/bKX3yXoI8O4H
         cqdBMfZchBOy4iqNqJviOpQYPvhNd5muKZ7UGv75PzWFCx33xiBZjxGFFiCMT+Z6ci+R
         Ed7WTDsMHKBqi2MiyWeXIKfLBkrztqz15E0JQStrcxHPdxp76sYtcx/Vbspdt9q01Msd
         RIuuiIliJEmWsmGZOlgIQHtUpaGKfyjVPG5gmNLrdBsFvsalSxOicFZaPXocbIczJlHj
         /icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271258; x=1700876058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puI7dKGKydeFQ9oVeOcwkhGLijEh4uJPMsM7jH3Ze9Y=;
        b=EAxYLSxFyradfgm+lNdfQrDZ6N6q0I6Dv9NiGDaVz0SszdB08QAxEogDYP4lCjpmUp
         2zQRjKBviVrUkafGSCcffQhsCRyseGaub0Hq5lYo+W+hgG7UQAchqNGrSGi28uLKwh+m
         xW4V+UiJGm0LN7+6NgO1aHz0Tj2aFgtpd0Fk02mnovarIZyT10VRZRtuDxZ2Fsbe2gn4
         uLcEw2An1aU9g+4WwoI2HGUILPj98KAqOdLIcB6m68MhrH2DXQXcvcpDgOMv1N8GlVRE
         w8Lin679j5Rdy/bW6/mqogD50B/NjuL3VIcQxDihPjB/8kFVNVBxWes6Hn/A74hgZNnp
         rREg==
X-Gm-Message-State: AOJu0Yz07knaVeYcxDVpzr4sebgbZ71HRRlhKs+geOEdAImTSqVA941H
	nEtOrEysLSZaXis/lXF5EO33cmPqZ8A=
X-Google-Smtp-Source: AGHT+IHmjL86UpVElj55gA1DeNzNOe/wG1g/d+q/JZjsijPKqaKpiGTSQMh8lRYKyJNx3YpLRXSIYQ==
X-Received: by 2002:ac2:5a44:0:b0:509:4492:2a94 with SMTP id r4-20020ac25a44000000b0050944922a94mr877726lfn.49.1700271258315;
        Fri, 17 Nov 2023 17:34:18 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:17 -0800 (PST)
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
Subject: [PATCH bpf v2 10/11] bpf: keep track of max number of bpf_loop callback iterations
Date: Sat, 18 Nov 2023 03:33:54 +0200
Message-ID: <20231118013355.7943-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
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
 include/linux/bpf_verifier.h                  |  9 ++++++
 kernel/bpf/verifier.c                         | 17 +++++++++--
 .../bpf/progs/verifier_subprog_precision.c    | 29 ++++++++++++++-----
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7def320aceef..71b7c7c39cea 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -301,6 +301,15 @@ struct bpf_func_state {
 	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
+	/* For callback calling functions that limit number of possible
+	 * callback executions (e.g. bpf_loop) keeps track of current
+	 * simulated iteration number. When non-zero either:
+	 * - current frame has a child frame, in such case it's callsite points
+	 *   to callback calling function;
+	 * - current frame is a topmost frame, in such case callback has just
+	 *   returned and env->insn_idx points to callback calling function.
+	 */
+	u32 callback_depth;
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9e3067890b7..843d1d3be63e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9683,6 +9683,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return err;
 
 	callback_state->callback_iter_depth++;
+	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
+	caller->callback_depth = 0;
 	return 0;
 }
 
@@ -10485,8 +10487,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
index ec4cd596b8c6..e753fb52dcdd 100644
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
@@ -134,8 +150,7 @@ __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r4 (flags) is always precise for bpf_loop() */
-__msg("frame 0: propagating r4")
+__msg("frame 0: propagating r1,r4")
 __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
 __msg("mark_precise: frame0: parent state regs= stack=:")
 __msg("from 18 to 9: safe")
@@ -264,10 +279,10 @@ __msg("15: (b7) r0 = 0")
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
 __msg("mark_precise: frame0: parent state regs= stack=:")
 __msg("from 16 to 9: safe")
@@ -419,10 +434,10 @@ __msg("17: (b7) r0 = 0")
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
 __msg("mark_precise: frame0: parent state regs= stack=:")
 __msg("from 18 to 10: safe")
-- 
2.42.1


