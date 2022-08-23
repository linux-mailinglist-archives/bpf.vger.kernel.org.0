Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E159CDEA
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiHWBbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 21:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 21:31:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD55A3D3
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:31:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w19so24613040ejc.7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w3DIblq5I4goc0U89COhLl4RqI0oajOLovsgFfN6l1M=;
        b=N+7WWUSvVBdusAEB/bieE7jMERrbJt9tCcJVR1gnp/cHgpdhClYr3HHvUbXTAFW7gx
         EYUZeXacIrqxpgyb5hR5cODyNVEQKhBe7hzMu81q03onoicsLTbqJEFfEs+57q740pOb
         bB05S0fUehbFE9YuqeWvfsGN6sz0GOI1owVXLQl+Q78PcLqUgFDgyzfP4FYlSrR1wtV8
         /30v2gW/UDhkHuUwJCwnL13cN4h/L59w8Va/8f4o0ueZ6ARYEpTO+aeL4qE6nCv+/zQn
         etnwfQNK1cYVxRRzNJhh4EGEu5M/GH7V/6B6oKk9h6vaSeaNUaIyasuKDyqOPPskk3TX
         YSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w3DIblq5I4goc0U89COhLl4RqI0oajOLovsgFfN6l1M=;
        b=c8TbbqR0+HRTOQSy/3BRnT+uXpxpwRa3b9G65ePVnJv9PPRjslK8oVbWUk/cCFH0bD
         G044kyvxwwV+LzrIB8E/Jyv1OCCME/CCqb1W/3jfW+Vcq6EgzuYtddXiYEhfzJFW+VhV
         3zJOakiwCgIhRdYDj7FOL883duuVJLI6JAIcIPTDOllKgAQCVq0RcyzTraiVXCjDp4bd
         HFCCjHtrdA9wMZD/uq/78DnQq3J9sX8Pcn3wTXuz+xZHEVzuvFgphKnHWy6Hkq0YF/W2
         8qu9PltVvAl3TyydSU7ey9wdNYb65AiS/Hav1TWdD6bYMs3DJgCsXbkqCMUwoAneD71c
         t4qA==
X-Gm-Message-State: ACgBeo2bKGS9l333FjhCsV4yXeBdhxE/cvSzW8NI3Z0Wf0og+Pe5YVHS
        UYx504xFJ+t3/xawZJy2oYnUZIefhAM=
X-Google-Smtp-Source: AA6agR6Sb0WMBFHgDBcY5itCWmGVQO8y5zFTBjPK3DafT78IGuPyunQ4z9e8vRJMyOmU/6QtkQrhwQ==
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id e8-20020a17090658c800b006fe91d518d2mr15074185ejs.190.1661218287606;
        Mon, 22 Aug 2022 18:31:27 -0700 (PDT)
Received: from localhost (vpn-253-070.epfl.ch. [128.179.253.70])
        by smtp.gmail.com with ESMTPSA id bm2-20020a0564020b0200b0044604ad8b41sm565890edb.23.2022.08.22.18.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:31:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/3] bpf: Fix reference state management for synchronous callbacks
Date:   Tue, 23 Aug 2022 03:31:25 +0200
Message-Id: <20220823013125.24938-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823012759.24844-1-memxor@gmail.com>
References: <20220823012759.24844-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7453; i=memxor@gmail.com; h=from:subject; bh=4iF0BwftQkv5QRVp4VMUTpHeTouhrf3u55v38lpIXoM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBCbayRA+JphAwZsi+Rls7plm9Qxbr9MYyC6JRQqc 5tp3nKiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwQm2gAKCRBM4MiGSL8Ryh3XD/ 0bSagr8SZOXSHN+fD0q62NmoheIZkVfcd069YgXPsjg+NGOICvJg7iSDkzSIAkZULF0osJFlgu1SSV 4N0TfS3vGoInS0WbghOJcG9UCJQhNBsGFaa1Tr2LEGqDacgS9HMqJBlX1npmEdMLApCeoa31c/iojT SzXrJBFJ7L/gycSg1ADbBWlkA8h72puMYAGvZme4gCZ7LA/T2Jm9ZgSJY4fwJxwO9ddrPYuUnZESXe MloxzVKrPc8r6YUOqG+AkLdW8fY3Dk31vwHefFoes+TNc/aUxyLLbnZiS5/BCN7w4VLNCKKPJkl7Gx DceQ/ylxatdEUfrH2PcdHfSf53gIGWbkDquMNiio5ttFnXP9FD3Va/of0E53tropcKpnujATcx+Zat rQ27Vcf1Vln2UHyb9Al+VKwV5AEaEl2fR0C3cisUgoCnNn4tsxJ6hsQ5ItCTkYXpUgseY4OzLRqUss K6dx1XV7nwcRUAIwXCyCj9/KZ7/WgEx6iQWqjJmvJJPw6k2lefggcSDCG8Db0ok0BeOF6816IimIPQ 49WrUjxGNjBA4X/X92TjM8bxzR35JCMBdHOoRlkyWPofGunklnFTR/HUEzs4pOAmcXOgjuZ3brIxGq E5Lz1ESgpizxwa0+grJEJaSDFvs9SMI9S3e9Hs9vYGDFoa1uirOnJS6Q5RUw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, verifier verifies callback functions (sync and async) as if
they will be executed once, (i.e. it explores execution state as if the
function was being called once). The next insn to explore is set to
start of subprog and the exit from nested frame is handled using
curframe > 0 and prepare_func_exit. In case of async callback it uses a
customized variant of push_stack simulating a kind of branch to set up
custom state and execution context for the async callback.

While this approach is simple and works when callback really will be
executed only once, it is unsafe for all of our current helpers which
are for_each style, i.e. they execute the callback multiple times.

A callback releasing acquired references of the caller may do so
multiple times, but currently verifier sees it as one call inside the
frame, which then returns to caller. Hence, it thinks it released some
reference that the cb e.g. got access through callback_ctx (register
filled inside cb from spilled typed register on stack).

Similarly, it may see that an acquire call is unpaired inside the
callback, so the caller will copy the reference state of callback and
then will have to release the register with new ref_obj_ids. But again,
the callback may execute multiple times, but the verifier will only
account for acquired references for a single symbolic execution of the
callback, which will cause leaks.

Note that for async callback case, things are different. While currently
we have bpf_timer_set_callback which only executes it once, even for
multiple executions it would be safe, as reference state is NULL and
check_reference_leak would force program to release state before
BPF_EXIT. The state is also unaffected by analysis for the caller frame.
Hence async callback is safe.

Since we want the reference state to be accessible, e.g. for pointers
loaded from stack through callback_ctx's PTR_TO_STACK, we still have to
copy caller's reference_state to callback's bpf_func_state, but we
enforce that whatever references it adds to that reference_state has
been released before it hits BPF_EXIT. This requires introducing a new
callback_ref member in the reference state to distinguish between caller
vs callee references. Hence, check_reference_leak now errors out if it
sees we are in callback_fn and we have not released callback_ref refs.
Since there can be multiple nested callbacks, like frame 0 -> cb1 -> cb2
etc. we need to also distinguish between whether this particular ref
belongs to this callback frame or parent, and only error for our own, so
we store state->frameno (which is always non-zero for callbacks).

In short, callbacks can read parent reference_state, but cannot mutate
it, to be able to use pointers acquired by the caller. They must only
undo their changes (by releasing their own acquired_refs before
BPF_EXIT) on top of caller reference_state before returning (at which
point the caller and callback state will match anyway, so no need to
copy it back to caller).

Fixes: 69c87ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 11 ++++++++++
 kernel/bpf/verifier.c        | 42 ++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bad8640dc..1fdddbf3546b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -212,6 +212,17 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
+	/* There can be a case like:
+	 * main (frame 0)
+	 *  cb (frame 1)
+	 *   func (frame 3)
+	 *    cb (frame 4)
+	 * Hence for frame 4, if callback_ref just stored boolean, it would be
+	 * impossible to distinguish nested callback refs. Hence store the
+	 * frameno and compare that to callback_ref in check_reference_leak when
+	 * exiting a callback function.
+	 */
+	int callback_ref;
 };
 
 /* state of the program:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 096fdac70165..3e885ba88b02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1086,6 +1086,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	id = ++env->id_gen;
 	state->refs[new_ofs].id = id;
 	state->refs[new_ofs].insn_idx = insn_idx;
+	state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
 
 	return id;
 }
@@ -1098,6 +1099,9 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 	last_idx = state->acquired_refs - 1;
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].id == ptr_id) {
+			/* Cannot release caller references in callbacks */
+			if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
+				return -EINVAL;
 			if (last_idx && i != last_idx)
 				memcpy(&state->refs[i], &state->refs[last_idx],
 				       sizeof(*state->refs));
@@ -6938,10 +6942,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		caller->regs[BPF_REG_0] = *r0;
 	}
 
-	/* Transfer references to the caller */
-	err = copy_reference_state(caller, callee);
-	if (err)
-		return err;
+	/* callback_fn frame should have released its own additions to parent's
+	 * reference state at this point, or check_reference_leak would
+	 * complain, hence it must be the same as the caller. There is no need
+	 * to copy it back.
+	 */
+	if (!callee->in_callback_fn) {
+		/* Transfer references to the caller */
+		err = copy_reference_state(caller, callee);
+		if (err)
+			return err;
+	}
 
 	*insn_idx = callee->callsite + 1;
 	if (env->log.level & BPF_LOG_LEVEL) {
@@ -7065,13 +7076,20 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 static int check_reference_leak(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *state = cur_func(env);
+	bool refs_lingering = false;
 	int i;
 
+	if (state->frameno && !state->in_callback_fn)
+		return 0;
+
 	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
+			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
+		refs_lingering = true;
 	}
-	return state->acquired_refs ? -EINVAL : 0;
+	return refs_lingering ? -EINVAL : 0;
 }
 
 static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
@@ -12332,6 +12350,16 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
+				/* We must do check_reference_leak here before
+				 * prepare_func_exit to handle the case when
+				 * state->curframe > 0, it may be a callback
+				 * function, for which reference_state must
+				 * match caller reference state when it exits.
+				 */
+				err = check_reference_leak(env);
+				if (err)
+					return err;
+
 				if (state->curframe) {
 					/* exit from nested function */
 					err = prepare_func_exit(env, &env->insn_idx);
@@ -12341,10 +12369,6 @@ static int do_check(struct bpf_verifier_env *env)
 					continue;
 				}
 
-				err = check_reference_leak(env);
-				if (err)
-					return err;
-
 				err = check_return_code(env);
 				if (err)
 					return err;
-- 
2.34.1

