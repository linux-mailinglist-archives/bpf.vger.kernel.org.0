Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4E592909
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiHOFQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiHOFPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:15:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD471128
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kb8so11810575ejc.4
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=52ncQDVoLEQypCLCdmrT3cs77W6vwPXVBdFEABVVW3U=;
        b=NKLhdjdLtFVLDwKvPoxSVykPcweR1euFbusy/LzFNtXemJfOqCC0jXwfsCuaGqq/x3
         +U01mtgx0OUAh6JdNr/QBCMW4dPsiDmtsy9VunUBLoHOlGYoSkMk1GbCTFsJXMitIa5n
         YbvuQd436fviSqCwvv2BvAAZkoEBDxtzwJkACSB70RdgN5LZXQ0t7jlA+Hfkz+vwH5kz
         08QbKjkgwx8V8zn2Jg9L/AwIkpItoqRmw4VcoPaAYRZmx0sfkNStdJL1u/B+3SlJRHw6
         k7Vn/sGg5TXC2vwZH/d+0O0W6lmNHYiksVMs9oqbll8sCQTiqXeID3NdE8K/3gF/aApo
         LlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=52ncQDVoLEQypCLCdmrT3cs77W6vwPXVBdFEABVVW3U=;
        b=09rfGvhNAW1q7yaqqK519tF5/N7T0uR32+ond+7Uf7+1mGpSlBZ2d0pSzugDJvqQgx
         vrtBf+bN/1yW5fgkewpT4yjJYJLd7yX/FC2pWtc8tyvV5o/LKyrLGT8hkhQZDXsitEaq
         NOEvw1wYvl+eFjCkaDCZMUGRE8B+aK75qOFbsZE5t4TC8BGa0I9Mql/G/7wmVR+NR2JK
         YNS44hf3KFVJqSSx6ol+xlnuj6wVXrAemQLLQuleyDZsPmrSSAMOLbkkDRrVyJgglEU1
         nvRrXkFu0hXTMDfaOBib81yENcUyr4S7BQurOUzAdaHujzhm38u/LahLLIOccR7pg+ZE
         A1wQ==
X-Gm-Message-State: ACgBeo3EkYA2JOldEDyVoLCjjim8scvH44MJO79hE1EAnZieRATCHX7r
        XkM25ZwXdHHvO2MK4cejQu6ExzP7YLk=
X-Google-Smtp-Source: AA6agR6o0S0M/TNsL7n32FSUgm4TIiV2zqc8ca6V7hEO6aE68z6AaKWc8P4hl/6nZ7mqfC1Hv3r93g==
X-Received: by 2002:a17:907:6818:b0:730:d99f:7b91 with SMTP id qz24-20020a170907681800b00730d99f7b91mr9303979ejc.496.1660540544208;
        Sun, 14 Aug 2022 22:15:44 -0700 (PDT)
Received: from localhost (vpn-253-028.epfl.ch. [128.179.253.28])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7d641000000b004417eeff836sm5994992edr.53.2022.08.14.22.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 22:15:43 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC bpf v1 2/3] bpf: Fix reference state management for synchronous callbacks
Date:   Mon, 15 Aug 2022 07:15:39 +0200
Message-Id: <20220815051540.18791-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815051540.18791-1-memxor@gmail.com>
References: <20220815051540.18791-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7099; i=memxor@gmail.com; h=from:subject; bh=+IBqn92ZFNOVZO9Jc/1W/xdv3IJSIaVeDd6nTi5A5oU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi+dZIpZoH/oY0RJ0C2k6SLOGWxYi3qCkDRFdS/gwl g/BFeh+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvnWSAAKCRBM4MiGSL8RyrKED/ 4w0mhPDimnYNnz18/iZhEhbDlkaJr7T4+0TXrRrqO3zvw4kAqIMXdQU8V1eZBsYmuX/XDwtAVkhfUJ rNVlticiMYcpfFI8PZFu0wryZyEdMJfS4YvlLMcFsMavb+rGWCRUau6uMS7CbYl0grG+FAvhYTgOlW DCkqOlINXez0VZFkJgtf0IQ9wAH7Lh/K8ny4WPAyfBIyMgz1dzdo+Z5p5japL8UDUEadtyZCuaNrxp bA6JUrlDjcWapzLOaP7BYNIyCYE1bGs+RUUdYSVaitNyIOURmkYt5Mqlg/B7owKZrg1luOQ6N5SYBo KxYFeQe/Zs7jm5tzq//bsAfmf290eC8kM/RKmZ54JuN5JwRu+UMfKoccXwAzgh+O+tcEO2DC0vIg0k QRD+7M+azuMjdNaQG32Yd0FVivpMf9rcNFMuHrms97Aq4U2Tt8qVW1aLclyzLLDhZV4yqRiL1TICdb n4YN/UszI4CL4W+rnpwQCYIb8t2UTsrQz7z307VyR87HF2dhnQcuYXCCHkBQN0D792l6B/LDxIChbF GbpNLFxDngsm9AfITNfrB4LzGdCpUzkJeG8LZHEFtfYwF2yTovf8Q2OoYF46Og3ruK5KuTXYBYgrBk rA7+tUgWQCHZFXWr4oLXn8Ud1Dr/Km42gWoW+bMYY/EGfQjvqa+jx9nP0ffw==
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
callback.

Note that for async callback case, things are different. While currently
we have bpf_timer_set_callback which only executes it once, even for
multiple executions it would be safe, as reference state is NULL and
check_reference_leak would force program to release state before
BPF_EXIT. The state is also unaffected by analysis for the caller frame.
Hence async callback is safe.

To fix this, we disallow callbacks to transfer acquired references back
to caller. They must be released before callback hits BPF_EXIT, since
the number of times callback is invoked is not known to the verifier, it
cannot reliably track how many references will be created. Likewise, it
is not allowed to release caller reference state, since we don't know
how many times the callback will be invoked.

Lastly, now that callback function cannot change reference state it
copied from its parent, there is no need to copy reference state back to
the parent, since it won't change. It may be changed for the callee
frame but that state must match parent reference state by the time
callee exits, and it is going to be discarded anyway. So skip this copy
too. To be clear, it won't be incorrect if the copy was done, but it
would be inefficient and may be confusing to people reading the code.

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

