Return-Path: <bpf+bounces-15146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79B7ED93A
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA98FB20C81
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6E8F61;
	Thu, 16 Nov 2023 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euEsgyna"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953718E
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9f26ee4a6e5so44605166b.2
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101123; x=1700705923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxsC59wgrnDLmVnRtuQwR/bUZTDdC0J2RI/gLw5ciVg=;
        b=euEsgynaZVjZ1DHBbmtkayTBdj4RqncyQMAW4LWBLB4cKSf+xD6q4XqYCfPE+MFVCP
         oKaJNH9ZW5tSHBLSVgcqnXDvuEPAIcW66MWXg5KMg1HBtCg/zeV6O3LPwMdf/t1lfZmv
         tHIwJw05xAcRH/u4lVn1oY2Dg9PeyndxRuDh5cvBS6ngfkJeRR31RHW9CLfg76L6VD6f
         EEcnuSv7+ZXK1bfPNuCyablT++is0I+amfSOEUx9WgyDL0Y6s2CGsQqNbqu9JjtvWg1G
         DwLSR0VDz1yoj9kCezTgtqZ8/brh8aToXI7aFkI74L7UgvBdi0gBrBGKDYIy1YrHbPgN
         24qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101123; x=1700705923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxsC59wgrnDLmVnRtuQwR/bUZTDdC0J2RI/gLw5ciVg=;
        b=FRemZxQDT4pQ9UzRAzaEjnOSTZSroCtYbfTV3itQC8M6nFBjbdOpcRTfVqLeGELTMR
         Ad/uwt+VnLOr8N8K+CfGVITefRQG1ryToYVCZJCFnLEqq0y8vZPxHs4iiCbaLYT2dTmG
         gb8efTKdV3YKCy+wrq4xeMHUXGgqjzaITDvpo6pJY+BTa/H9lDgxj/LjetWPVRp9dQif
         YAjtWukz5iWsgGjfmcFKtGXQTtqbPOMWl0V7P9ZESmlqbgB2onxhTiRSkeWhmS6JYy6R
         qhNirn2qeZjrYOGwW00hKtjalu7/CPNwY5cwnOTLoGOCPFjIpATV9tW12BDVpQ0Q/Ldi
         pKLg==
X-Gm-Message-State: AOJu0YxaFPg6UloFh8p3IGHqM4UClkdwbqCHxRT42PbJnLOw2yFKbs/O
	29dOBM9jBEp0XNKHD3MpwUgTHy+cDdOqiQ==
X-Google-Smtp-Source: AGHT+IFzLB+VfIYmeJ28MoYMx9DXyhvAh77o8M+ta+XzbQS3P50zwpFVIifRoZ5M12yGTvLCz5zGgw==
X-Received: by 2002:a17:906:538b:b0:9d4:2080:61d2 with SMTP id g11-20020a170906538b00b009d4208061d2mr9117969ejo.2.1700101122736;
        Wed, 15 Nov 2023 18:18:42 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:42 -0800 (PST)
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
Subject: [PATCH bpf 10/12] bpf: keep track of max number of bpf_loop callback iterations
Date: Thu, 16 Nov 2023 04:18:01 +0200
Message-ID: <20231116021803.9982-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
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
 include/linux/bpf_verifier.h |  9 +++++++++
 kernel/bpf/verifier.c        | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0ffb479c72d8..302f9c310de7 100644
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
index 5b8c0ebcb4f6..474af277ea54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9680,6 +9680,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return err;
 
 	callback_state->callback_iter_depth++;
+	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
+	caller->callback_depth = 0;
 	return 0;
 }
 
@@ -10479,8 +10481,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	case BPF_FUNC_loop:
 		update_loop_inline_state(env, meta.subprogno);
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_loop_callback_state);
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "frame%d callback_depth=%u\n",
+				env->cur_state->curframe, cur_func(env)->callback_depth);
+		if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_value)
+			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+						 set_loop_callback_state);
+		else
+			cur_func(env)->callback_depth = 0;
 		break;
 	case BPF_FUNC_dynptr_from_mem:
 		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
-- 
2.42.0


