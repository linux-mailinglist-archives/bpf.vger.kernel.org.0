Return-Path: <bpf+bounces-15444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC47F2115
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D0CB219C5
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF713AC32;
	Mon, 20 Nov 2023 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ5r/ENj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4BC1
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so9816181fa.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521208; x=1701126008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzOpEZBlHgfwx1ttrCgbtEL+22hxnr/l8skkpIvAc88=;
        b=QZ5r/ENjoHh8mkM0ru/oa/E9EipZO6nrSawRtrf6DMrcupJqDkMfaHNzAgqlxSZ/aC
         kQiZ1m3b0wujlSbd7xzc8kbIz/jTLIOjqMCfWtycPYV4PGtxvUmMz05ausubOCusA+kt
         3x4norqaevMfta3+TVuK6cTkX7TlEx9Y7zGbfF6HZlyuL1ok33Q4d/f26c0QWejJFm+g
         41rI6A3PF1+Iqbbr88vScLfmjAXLv6XjqOSjsur9olNMPgwbeXz7RD8W01qggVyqQ6U1
         StbW3Zl4J+glYKD3BgAX/3xnqKUsgpbs5kaxiyMqyT4fIdUNXrmN9rqDiR1d5Eo5eO00
         qmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521208; x=1701126008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzOpEZBlHgfwx1ttrCgbtEL+22hxnr/l8skkpIvAc88=;
        b=xHT8bynqrP4yeSLF/Lg/GLlmI+V8l5JdsUjgZ8UaxORMBdaQtmA8KJrGPCSu4N1rDu
         K+Zgih2YxLB9cj0lJx1WTGxH4BbqQvHy87MahVyKmloRmZMBeOqi7jtY0A+Wzom7vH30
         4DlUjV810foAsHTvPdN3G7xTVeGixW0ucKSwC8tCZ9rUDhKaNz1LSw8eEKraQs7r9eJ8
         WGmzb6FUMsBuNtd6YktPna8Ca0uRR8lZuL4yLm83NK81PrMLjPMqzgx+3Tk5+aVE8tV3
         CP+1zBIBMhS8c/K85BJx4LqjGCijXIiccpadxJrh/VZiO/sBFrjsOeyGsm+wRYKGyysp
         JRxA==
X-Gm-Message-State: AOJu0YzUS7Nh9VF2lsYKY3MmJV7UYLWK3cjYnl1l3x5hlHpqFUz57Qoa
	dp1Pp3YpRUIpwfwUarqK/tBzEJXCEoLVTg==
X-Google-Smtp-Source: AGHT+IG5mWAmBQWxrgIwWbtbuX+T+mOIlJLCrRT1dNFRyd4St+JX5tp70l3e4kCDSfxq3O2zUP3vyw==
X-Received: by 2002:a2e:2243:0:b0:2c5:1045:71cb with SMTP id i64-20020a2e2243000000b002c5104571cbmr5872215lji.32.1700521208329;
        Mon, 20 Nov 2023 15:00:08 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:07 -0800 (PST)
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
Subject: [PATCH bpf v3 05/11] bpf: extract setup_func_entry() utility function
Date: Tue, 21 Nov 2023 00:59:39 +0200
Message-ID: <20231120225945.11741-6-eddyz87@gmail.com>
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

Move code for simulated stack frame creation to a separate utility
function. This function would be used in the follow-up change for
callbacks handling.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6e1bcfe00f5..68ee4803d3a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9370,11 +9370,10 @@ static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
 
-static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			     int *insn_idx, int subprog,
-			     set_callee_state_fn set_callee_state_cb)
+static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int callsite,
+			    set_callee_state_fn set_callee_state_cb,
+			    struct bpf_verifier_state *state)
 {
-	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_func_state *caller, *callee;
 	int err;
 
@@ -9384,13 +9383,53 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -E2BIG;
 	}
 
-	caller = state->frame[state->curframe];
 	if (state->frame[state->curframe + 1]) {
 		verbose(env, "verifier bug. Frame %d already allocated\n",
 			state->curframe + 1);
 		return -EFAULT;
 	}
 
+	caller = state->frame[state->curframe];
+	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
+	if (!callee)
+		return -ENOMEM;
+	state->frame[state->curframe + 1] = callee;
+
+	/* callee cannot access r0, r6 - r9 for reading and has to write
+	 * into its own stack before reading from it.
+	 * callee can read/write into caller's stack
+	 */
+	init_func_state(env, callee,
+			/* remember the callsite, it will be used by bpf_exit */
+			callsite,
+			state->curframe + 1 /* frameno within this callchain */,
+			subprog /* subprog number within this prog */);
+	/* Transfer references to the callee */
+	err = copy_reference_state(callee, caller);
+	err = err ?: set_callee_state_cb(env, caller, callee, callsite);
+	if (err)
+		goto err_out;
+
+	/* only increment it after check_reg_arg() finished */
+	state->curframe++;
+
+	return 0;
+
+err_out:
+	free_func_state(callee);
+	state->frame[state->curframe + 1] = NULL;
+	return err;
+}
+
+static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			     int *insn_idx, int subprog,
+			     set_callee_state_fn set_callee_state_cb)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller, *callee;
+	int err;
+
+	caller = state->frame[state->curframe];
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
@@ -9460,35 +9499,12 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return 0;
 	}
 
-	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
-	if (!callee)
-		return -ENOMEM;
-	state->frame[state->curframe + 1] = callee;
-
-	/* callee cannot access r0, r6 - r9 for reading and has to write
-	 * into its own stack before reading from it.
-	 * callee can read/write into caller's stack
-	 */
-	init_func_state(env, callee,
-			/* remember the callsite, it will be used by bpf_exit */
-			*insn_idx /* callsite */,
-			state->curframe + 1 /* frameno within this callchain */,
-			subprog /* subprog number within this prog */);
-
-	/* Transfer references to the callee */
-	err = copy_reference_state(callee, caller);
+	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state_cb, state);
 	if (err)
-		goto err_out;
-
-	err = set_callee_state_cb(env, caller, callee, *insn_idx);
-	if (err)
-		goto err_out;
+		return err;
 
 	clear_caller_saved_regs(env, caller->regs);
 
-	/* only increment it after check_reg_arg() finished */
-	state->curframe++;
-
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
@@ -9496,14 +9512,10 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		verbose(env, "caller:\n");
 		print_verifier_state(env, caller, true);
 		verbose(env, "callee:\n");
-		print_verifier_state(env, callee, true);
+		print_verifier_state(env, state->frame[state->curframe], true);
 	}
-	return 0;
 
-err_out:
-	free_func_state(callee);
-	state->frame[state->curframe + 1] = NULL;
-	return err;
+	return 0;
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
-- 
2.42.1


