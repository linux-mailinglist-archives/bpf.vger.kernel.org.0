Return-Path: <bpf+bounces-15141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1E7ED935
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C915280F40
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2446AA4;
	Thu, 16 Nov 2023 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg1Wo+TA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A397A6
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9f2a53704aaso39410166b.3
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101116; x=1700705916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYBz5+FRx8jGtlc1wIaA1iruO/flQ5TzphJVV+9nhn8=;
        b=Cg1Wo+TAaS56lfVjEol9G7iDR0sZVNvlo/vII40EgF5rMgch0dEFg6amdf2gXfXmGV
         JdOZ1kM7cmdmfOcBH3ka/jOTSexVNt4OwbfXw8C7yHf2MFt+iMjajaZ7gXr7zMDxx1io
         RIDkYl3Qr5zwI56RWLLvDD7aFTK9D7QUYQRNpGXGnNFw+3U2pmXTsSWcuxy6mbU/qwEp
         rsYFfRYsMYrf6+pFcRZyeHwQkfAFi8mCZZ/13D0Dv5wb7vCFMFSX8aRAAKaH5VlhhAj8
         BhtCGKk1d2o9X4SZAWYceoVoJhdcQwqvvGpahCp5Owhom2aVN+hBZl0uCnB01QXPz7Ps
         Y3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101116; x=1700705916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYBz5+FRx8jGtlc1wIaA1iruO/flQ5TzphJVV+9nhn8=;
        b=hBMiG8sEwZ4C8H9Tkifvryqmf+kJ7wXVbWBTQ1ujydWncN3qb1+wQ/XmEfbvisyVkG
         TtT9cvN+UnPUiZnd643j3x2x06FDu2YPiE5G8T466feZhuF2zV68WVLKddv6w5N/v8kp
         o0aC69ETmObhc685TJw2LR73cIxf3Sxi3Li9FgfGanW74ahJV8zDfC3EIpaP61s9gByF
         3PxczZn3mQrSW7ZBSS5sj82Ovoiz9mWTP62/ioGlfchlzIgASYVoYzYdH52vJA2bgN/F
         oOIxz95DXkDPpJop2wuGkNv4QLF7sPBpFs0azYZDyalNrUuWd/T5r9FuGuvKa22s7MVD
         ep3g==
X-Gm-Message-State: AOJu0Yyt00mYWJTTpdcIDZOhFIGqVlNwLNNL1ZV/x8sDilk85QEgx0Qh
	rTeA0U4j1VQcQT78VXipFyMuFjBCHMGIiw==
X-Google-Smtp-Source: AGHT+IGu8IDbDZKHg8QzPJxNSsg4C9mrAV9TGRsM5NgETDBVLEvSzMDkKSnYJs+5IJxEMY5ojPN71Q==
X-Received: by 2002:a17:906:1dd3:b0:9d3:afe1:b3e5 with SMTP id v19-20020a1709061dd300b009d3afe1b3e5mr10787174ejh.75.1700101116269;
        Wed, 15 Nov 2023 18:18:36 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:35 -0800 (PST)
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
Subject: [PATCH bpf 05/12] bpf: extract setup_func_entry() utility function
Date: Thu, 16 Nov 2023 04:17:56 +0200
Message-ID: <20231116021803.9982-6-eddyz87@gmail.com>
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

Move code for simulated stack frame creation to a separate utility
function. This function would be used in the follow-up change for
callbacks handling.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 87 +++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0576fc1ddc4d..d9513fd58c7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9542,11 +9542,10 @@ static int set_callee_state(struct bpf_verifier_env *env,
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
 
@@ -9556,13 +9555,56 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
+	if (err)
+		goto err_out;
+
+	err = set_callee_state_cb(env, caller, callee, callsite);
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
@@ -9632,35 +9674,12 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
-	if (err)
-		goto err_out;
-
-	err = set_callee_state_cb(env, caller, callee, *insn_idx);
+	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state_cb, state);
 	if (err)
-		goto err_out;
+		return err;
 
 	clear_caller_saved_regs(env, caller->regs);
 
-	/* only increment it after check_reg_arg() finished */
-	state->curframe++;
-
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
@@ -9668,14 +9687,10 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
2.42.0


