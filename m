Return-Path: <bpf+bounces-15487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0567F239B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3561F26626
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7877134C6;
	Tue, 21 Nov 2023 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFbqwsQk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A992
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso688459766b.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532449; x=1701137249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzOpEZBlHgfwx1ttrCgbtEL+22hxnr/l8skkpIvAc88=;
        b=YFbqwsQkpBoyVVHrpnPLxsByW2SEnSnQrILejd0s5+nv77N7JCctyVpRUJ4yeJwTuW
         1z79L1rJXtfGNyu4YcX74L4l/FqEwqqjPHxxDwuDflZwsohp2SGT+29M5mh+JrnO87Ki
         OU76VNhmrOxANjU2JrsgTk+HOy1yBZ2Z5YjWR1xvi+tvJ01g9S/RnWQkYMPup9PXp6/l
         2m+8XlkriCAatzpouHl2uaNQnD4zzyAhvEJiibN3SRk4245prmxRZbCgfLlMS3nnJsvp
         7A3kP2MBMl5Cm8V+KHcBuK2ZLSquEzqdDNyAlGf3zddzcsvEsv0yV4igJClBRQ6zapiT
         4+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532449; x=1701137249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzOpEZBlHgfwx1ttrCgbtEL+22hxnr/l8skkpIvAc88=;
        b=DTi1FLQntOGvTHATBoY39MLtseSVqWhQgWNLV393H0vXqTQwzIQBP3Sl7+Xe8rS2ks
         k25ldG36CimSyx6+vX1wMa13Har8F6QA1XleU46Ybou0aC9iezcdH1/dnDIBcso8lI5L
         6fGnVFlUHiNUukJmHD7+1rkMmnyZA7jqaZs91OAX6H0AlxsKCIdzQY0IxSQMp3hHkHuY
         DmBphxRsMgJiSAns7iK/y/jwQLl+cl3D5NNvvArgzpcO76h1klAOx8xqqiGzBu3zbI6I
         hNCpAgqwps5iWp2Opg3KdNIZ+rYGc4tffM3Zh0qbyG5m3Pz76g2c1otg/04GNuzLGyCg
         HAzg==
X-Gm-Message-State: AOJu0YzDNCPynSTJyT34W/5fEk3u53sGUoKDHLzwCOXWIZCU//Zitf/i
	qkewKSjgzKN9eUwzT2OjM2xUcOC/9SNMXA==
X-Google-Smtp-Source: AGHT+IE+ijgH3ryj6ItxNvSzAv/P3BGdXUgPG0gx4Ekfpo6irZHIxOjkjbIFa17fh3UV3KIWM13l2A==
X-Received: by 2002:a17:906:1096:b0:9e6:2dcf:e11e with SMTP id u22-20020a170906109600b009e62dcfe11emr5620637eju.5.1700532449321;
        Mon, 20 Nov 2023 18:07:29 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:28 -0800 (PST)
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
Subject: [PATCH bpf v4 05/11] bpf: extract setup_func_entry() utility function
Date: Tue, 21 Nov 2023 04:06:55 +0200
Message-ID: <20231121020701.26440-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
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


