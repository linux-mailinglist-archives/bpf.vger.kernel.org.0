Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6BF59C05A
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiHVNTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiHVNTc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 09:19:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5209DF8A
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gt3so8715895ejb.12
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w3DIblq5I4goc0U89COhLl4RqI0oajOLovsgFfN6l1M=;
        b=k6NLgxweWuXyE7beCGfNhL5x2KgnJ7amDTVARGd/Y7xjCspIDYq2u7a6VMq2GuNEq4
         CW+qjWjfN92Cbg0186NIfJZTc07mvA/b1n6YuFADgo5CXpqBAsPRxWRhYsxmEscUnJlu
         2Xnj8tWaOmyHIKvf20PsbwHT5hc7WUSYjfG29MQQeqhI3CyZxOUa8GC41KI2idIGthKo
         EpVbblUQO1ynS5oCJr1Maae1943Qgw9m3H3jIWQNI/HS5YYw7R+p8VFhWCPMel9luKic
         oIM/b1IJ0WhtQ7HubmaLH1KfDHW+cDzBhOy/BDjyO4enJ9pVnIn0PrJX4PlB6tAc8iyC
         0WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w3DIblq5I4goc0U89COhLl4RqI0oajOLovsgFfN6l1M=;
        b=OXMjVB3rdJgU8KoipgmzNdv2WvSn42PoUGQEwrryOduBKLNU4F4UI/msTxPZA8TqOn
         cLZjDrcioVP6amCfJLJG/WbB9MXY97blEDh24WhiBSJn09LndPRKwymueCRpgB+OSApK
         RFhJuSei82Sw58Yhw4ugoTbYz/0VWeCRelngM1+kWZe2C3truizO54jYvoNwDFICkxxE
         GgoKtQeP9aemQbpmYTV/VSmvidnPADqRDaj7qTAjass9KsMKCzRgVXt5p1awhxE4V2zE
         l6zzh5ix/Yq/PwCu/SR4eLQeeY2j5pxr5ZeRIxppW+lmohuzZgVtlk4Fc+urE3feyZ8a
         HcrA==
X-Gm-Message-State: ACgBeo1PcnoilSfl6t+fdn44KNCHv9aqMD2OSoK6tb78L3YiRNYKfaYJ
        wrf4yV22myS0DYxpsgR60H3pa8GT0Lg=
X-Google-Smtp-Source: AA6agR7uE96OEo7TrilZiuuyuMMkrXktOdT6rj7x7MAtfOLICu9HMkKBtndDTd1yBZAUvvS942FGcQ==
X-Received: by 2002:a17:907:6295:b0:703:92b8:e113 with SMTP id nd21-20020a170907629500b0070392b8e113mr13253009ejc.594.1661174369024;
        Mon, 22 Aug 2022 06:19:29 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0073a62f3b447sm6165918ejd.44.2022.08.22.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:19:28 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 2/3] bpf: Fix reference state management for synchronous callbacks
Date:   Mon, 22 Aug 2022 15:19:22 +0200
Message-Id: <20220822131923.21476-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822131923.21476-1-memxor@gmail.com>
References: <20220822131923.21476-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7453; i=memxor@gmail.com; h=from:subject; bh=4iF0BwftQkv5QRVp4VMUTpHeTouhrf3u55v38lpIXoM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjA4GpyRA+JphAwZsi+Rls7plm9Qxbr9MYyC6JRQqc 5tp3nKiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwOBqQAKCRBM4MiGSL8RypLZD/ 9NADh6PXYit00fP1i2j/VWH63Xh3CfncJU5TcmLzbfyfx1FpgMAeIPTWczQEzde7+6u58JtpjDPkpM DIrdx8W9e36eQnWpo6GWRYyOd9yv8BrEDWA7IzdM5CQ2KXYbSFx2yDcYQthsmzdizNs4NtruATHzVe VdL0Vvd1vG01eMvpjSyc5GTZq0ThHCaTkZsXzHyC1APRkIuUtYEKyJA8U7cFfX+M+qcLFzjdcFqjMy KHLy1XIlXFANbY39VHJVpkZpDKi5Xk6ZqW18ZTe7K7eDRxWjznQ1W/51GdCHPlylOM6RVIXU4gFS2N P5B29Ms+yJTAwMecTfTuFYn/pIXon6Ro5Czw7hoqwsBHz+HYmSxsG6FmtJl7utv09P7s0dk36R/T6e LG4s254OklHTJs1zQK8dxtv6pcwaVm8qNJSuQhjLPhx52K1vxs5J0cZmNMomaBKSNRBazsOBnemeBa YUW3kkr1Xf1oSM8DBi9yZdwVy2lGEasl3UXLN1eOWZtYE7eLVUeLZZya62U9wLpUtK3k1N2mjGzqMa 4xQIsiCSyvPPfQrnYlZ8kF7PGxTDBoazfTsyvSLc8Lhetd+HeUkq+imknt5QEQD+9+DxufOCmH9E3R wMnvlYyyFa1VrvrrbhWt0L8/+c1ix9o01QdP/7REDy23yYwFAzHOqE8KCSjQ==
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

