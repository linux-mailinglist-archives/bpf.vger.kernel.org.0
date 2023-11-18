Return-Path: <bpf+bounces-15286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00967EFCF8
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A60B20BB8
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD21C3B;
	Sat, 18 Nov 2023 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxzd3duj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DFD6C
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:14 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a55302e0so3849192e87.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271252; x=1700876052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrLACO7cAkTeoYv6U1JOBkcT9/qbEg1/2Qgwxt+keLk=;
        b=mxzd3dujjFoWng6WD1L5QTRLqZv+6rSERcWXhy1BF1i9QalY+IBOcoxjrwGyCWSsyC
         TQND6uULH5fcXIFC+mE9F125dJPMD3vZYAUew9Q4+uUhuKuko6hX3Xgb5LvZbnazZeag
         bviZXbXQ98KVQVGs3hQVN7jycxmVAnzpKMvVN/Q7+NW6YoMLuOexWY1LLu7xipC9ycSC
         Eht9+3K8ZoQWkrRbdNu2cRNrBrlN1/VTwg/usnf4BWwBiDHBt0TwdMri+floevOFI5yG
         pMzQTmRQlpDASC5UszvmSrKJ1oDs28/1583EATWVkz6fgaNWrPaa1nw+EDwATgI9+5z8
         ySnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271252; x=1700876052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrLACO7cAkTeoYv6U1JOBkcT9/qbEg1/2Qgwxt+keLk=;
        b=vzMs+FgV4bmu5drQzmx7Z1sA9GELWObBatDQQi5U5Ztd/oQjF97y4wVYXGhmMIPV04
         4ob41KZBymNfoR9mOug9o+hX4eIfToUx4sx86P+mtglalbNqkRPT7P+HGRvnLHAGpmLq
         cEswUJgxJYlhIO+vjRPJseEOfK9q+Uta+24hbOPDpbXs595iGf5WZB5uNBLtvUXifl7m
         PFOGPoFOxxVc8mwobeZ8CSMA9Cb7hLPOgbCC/pgxkQi7nbDXOh5W3BDxq5wjUYPZXNmK
         5wJcrvtNtuOiKyIapsW6mGAOHzIya7rcQYiW2A4/Et+Mpykqm+cX1Nu3u+gvQt1vOdhZ
         ACjQ==
X-Gm-Message-State: AOJu0Yw4DRnYx2e/3dIB58oTJTa4InL5YFyyCKN+hapqUfBzhyWRM3gS
	UQBC9jMdEchYpWD0FnyMGBVcMNjO30c=
X-Google-Smtp-Source: AGHT+IEKJNqTP+ERpUMHryr8pGQP3bQCdec0shQa4qeml6MQvzXizFg/7wfGcSzLmuusf5MKNVYbnA==
X-Received: by 2002:ac2:599b:0:b0:507:a5e7:724 with SMTP id w27-20020ac2599b000000b00507a5e70724mr799657lfn.38.1700271252240;
        Fri, 17 Nov 2023 17:34:12 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:11 -0800 (PST)
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
Subject: [PATCH bpf v2 05/11] bpf: extract setup_func_entry() utility function
Date: Sat, 18 Nov 2023 03:33:49 +0200
Message-ID: <20231118013355.7943-6-eddyz87@gmail.com>
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

Move code for simulated stack frame creation to a separate utility
function. This function would be used in the follow-up change for
callbacks handling.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 84 ++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca54f738cfae..0b695014da3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9548,11 +9548,10 @@ static int set_callee_state(struct bpf_verifier_env *env,
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
 
@@ -9562,13 +9561,53 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -9638,35 +9677,12 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 
@@ -9674,14 +9690,10 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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


