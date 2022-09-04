Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DDE5AC671
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiIDUmS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiIDUmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527162CDFD
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z8so9034365edb.6
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7v44R7KdOMvSvZbxWOK4PQcFdEHyTp2kwAIBQChxsM4=;
        b=IzWgUBpAYum1bYwHk8unRyD9knTfAo/hqcPzC4pDdoD3/+6Wx0KatdnSoPyMoJBXG1
         LhH4rKU2E4LNhLkHy96pWxKNsCJn+EqJ9WelaYIMKue2YJ4UDUWfY28DXzGRiPDToH15
         +7ktaJU3CvAsOrRE57RaduAI71LG0CwBjOZAmSt9kVrsPQAOA7BYGxo/Ehf5ozcITdUm
         yGQWpH8D/SE1TGKAgDWo5N5ER72TY4W2c/Cx8chQYfyl8a0iTlJl+AEqNOzHBmPTuScd
         AXTOzsvEEJRRmlo8M7OGJAkkH7XFYHP4wrEHltTpf8FMx2y5eKZUbt0W4Xl4KgPAkS0x
         nXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7v44R7KdOMvSvZbxWOK4PQcFdEHyTp2kwAIBQChxsM4=;
        b=4sEIsxiHLjim2ir+Jh0GPLlIuKvYle8gu3r/HdKb8TscE06KFHzjmm6MrJWv8hQMmQ
         /ME8IV1F27SwnXeSH6IOLe8079S8qChx7jdX1OUsBpL2/QmA/0FBcGBeNprP5lC0CUrJ
         w9PQdg2xwLbW6E7Hd0PJ94w9pGcihia4HHRGBIFzBJ82GCS0dPeKtgyPqXuI8Tb9C94G
         h3Q68xJjT6+cfYPxP0sAnuRe5yr0M2AJtvZONsxt4uzwCd3y+6e811L521sturgssF0c
         EXTGpG0h0BrJAgg7ubqVI5eTyXQQZtZWHyfo+DiRhe6h0d3lDO1+GD53NTKUVS5L6bCK
         S0Tg==
X-Gm-Message-State: ACgBeo2cfpHGiY1KnhfQk+Fc/6xzXduRSNDTI7OWS/gdfok/pO+NJDWs
        tmrD60zGp7RYvlV8U3pOCfyYRmF4hM7R+g==
X-Google-Smtp-Source: AA6agR4+bmIV91lkdbWGiMFgYynfb2PZRS9HFNQEX2EFxZLwAGti2kgs/65EQGp0HdlJHK+IW4J5Ng==
X-Received: by 2002:a05:6402:10d2:b0:445:d9ee:fc19 with SMTP id p18-20020a05640210d200b00445d9eefc19mr39520020edu.81.1662324125151;
        Sun, 04 Sep 2022 13:42:05 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id da8-20020a056402176800b004477c582ffdsm1839252edb.80.2022.09.04.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:04 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 15/32] bpf: Add helper macro bpf_expr_for_each_reg_in_vstate
Date:   Sun,  4 Sep 2022 22:41:28 +0200
Message-Id: <20220904204145.3089-16-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10199; i=memxor@gmail.com; h=from:subject; bh=Jlyivut4K7AYYySEez2kwJGzSw1YcRrIvCIL0xR/7Io=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wpauD7H9i8Dq9RI4awresnHDmwaEpA18y/LUv bgFNqgGJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8Ryo+NEA Cmv+CcXxaMMDo2J0jbaDL5yVgCKkmAQmtliJ/F6rG8ntlXhjESSSDLn+DiAOUPJT6awkXqO7Wy6AMd 0acJQqMwLBNWCFRHvmBXsP1SBRTCSXgynaUYtm43nXSzyLBm5swpGLIpifo2lfG9loo+SfGLLaNYR0 vp0E9qUeQDZoyHR+egLg+k3PAxJOC0k5DBP9Gtsfm3hplZYxKoAHyJ7Yf+/ytysX+xYivy9WyrIC8B OjjRAxdjshck/gu5YEHtRACjRn/HRn51zR2oNKBEF7rTSYcgzAP8fGCdS5RoJ/sthvaVVofzCg1Ery gnI5yD8SJhbqzelE3hJVHTH4s5pNvuopk2RKUEo6i+DXILs8woYKEFtpTfGa8q34scf+Qz5MQbtNFD O0+9+uRC/vYLFsLnqOg7CNJXnqNvuhzyNRAvTg1Q9FIQeWqG6EtOCwH7l3R2Hos1aXE4yE0WTue5ng XQP638U+gTEyddOID3JL9bCup3cSV0arPa+Iy52E566M8vljMifFu3DOfjsvvhag7f+1idUBT5skkM XbHJEjwqZ/5nn0ow4YSTy0bJKbE9s36K3gj+astU3l/pcDhiO8wrDpGRxget8V3+PO2Wt8sylN69FB B9RdTsAVhMwSgit6hxRKFq6E+fhN39ghoDvqUqsUzhBs9Nc3KcStNoNmENCg==
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

For a lot of use cases in future patches, we will want to modify the
state of registers part of some same 'group' (e.g. same ref_obj_id). It
won't just be limited to releasing reference state, but setting a type
flag dynamically based on certain actions, etc.

Hence, we need a way to easily pass a callback to the function that
iterates over all registers in current bpf_verifier_state in all frames
upto (and including) the curframe.

While in C++ we would be able to easily use a lambda to pass state and
the callback together, sadly we aren't using C++ in the kernel. The next
best thing to avoid defining a function for each case seems like
statement expressions in GNU C. The kernel already uses them heavily,
hence they can passed to the macro in the style of a lambda. The
statement expression will then be substituted in the for loop bodies.

Variables __state and __reg are set to current bpf_func_state and reg
for each invocation of the expression inside the passed in verifier
state.

Then, convert mark_ptr_or_null_regs, clear_all_pkt_pointers,
release_reference, find_good_pkt_pointers, find_equal_scalars to
use bpf_expr_for_each_reg_in_vstate.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  21 ++++++
 kernel/bpf/verifier.c        | 135 ++++++++---------------------------
 2 files changed, 49 insertions(+), 107 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c6d550978d63..73d9443d0074 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -354,6 +354,27 @@ struct bpf_verifier_state {
 	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
 	     iter++, reg = bpf_get_spilled_reg(iter, frame))
 
+/* Invoke __expr over regsiters in __vst, setting __state and __reg */
+#define bpf_expr_for_each_reg_in_vstate(__vst, __state, __reg, __expr)   \
+	({                                                               \
+		struct bpf_verifier_state *___vstate = __vst;            \
+		int ___i, ___j;                                          \
+		for (___i = 0; ___i <= ___vstate->curframe; ___i++) {    \
+			struct bpf_reg_state *___regs;                   \
+			__state = ___vstate->frame[___i];                \
+			___regs = __state->regs;                         \
+			for (___j = 0; ___j < MAX_BPF_REG; ___j++) {     \
+				__reg = &___regs[___j];                  \
+				(void)(__expr);                          \
+			}                                                \
+			bpf_for_each_spilled_reg(___j, __state, __reg) { \
+				if (!__reg)                              \
+					continue;                        \
+				(void)(__expr);                          \
+			}                                                \
+		}                                                        \
+	})
+
 /* linked list of verifier states used to prune search */
 struct bpf_verifier_state_list {
 	struct bpf_verifier_state state;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f28aa7f1e8d..817131537adb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6546,31 +6546,15 @@ static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
 /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
  * are now invalid, so turn them into unknown SCALAR_VALUE.
  */
-static void __clear_all_pkt_pointers(struct bpf_verifier_env *env,
-				     struct bpf_func_state *state)
+static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 {
-	struct bpf_reg_state *regs = state->regs, *reg;
-	int i;
-
-	for (i = 0; i < MAX_BPF_REG; i++)
-		if (reg_is_pkt_pointer_any(&regs[i]))
-			mark_reg_unknown(env, regs, i);
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
 
-	bpf_for_each_spilled_reg(i, state, reg) {
-		if (!reg)
-			continue;
+	bpf_expr_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg_is_pkt_pointer_any(reg))
 			__mark_reg_unknown(env, reg);
-	}
-}
-
-static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
-{
-	struct bpf_verifier_state *vstate = env->cur_state;
-	int i;
-
-	for (i = 0; i <= vstate->curframe; i++)
-		__clear_all_pkt_pointers(env, vstate->frame[i]);
+	}));
 }
 
 enum {
@@ -6599,41 +6583,24 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
-static void release_reg_references(struct bpf_verifier_env *env,
-				   struct bpf_func_state *state,
-				   int ref_obj_id)
-{
-	struct bpf_reg_state *regs = state->regs, *reg;
-	int i;
-
-	for (i = 0; i < MAX_BPF_REG; i++)
-		if (regs[i].ref_obj_id == ref_obj_id)
-			mark_reg_unknown(env, regs, i);
-
-	bpf_for_each_spilled_reg(i, state, reg) {
-		if (!reg)
-			continue;
-		if (reg->ref_obj_id == ref_obj_id)
-			__mark_reg_unknown(env, reg);
-	}
-}
-
 /* The pointer with the specified id has released its reference to kernel
  * resources. Identify all copies of the same pointer and clear the reference.
  */
 static int release_reference(struct bpf_verifier_env *env,
 			     int ref_obj_id)
 {
-	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
 	int err;
-	int i;
 
 	err = release_reference_state(cur_func(env), ref_obj_id);
 	if (err)
 		return err;
 
-	for (i = 0; i <= vstate->curframe; i++)
-		release_reg_references(env, vstate->frame[i], ref_obj_id);
+	bpf_expr_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+		if (reg->ref_obj_id == ref_obj_id)
+			__mark_reg_unknown(env, reg);
+	}));
 
 	return 0;
 }
@@ -9844,34 +9811,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-static void __find_good_pkt_pointers(struct bpf_func_state *state,
-				     struct bpf_reg_state *dst_reg,
-				     enum bpf_reg_type type, int new_range)
-{
-	struct bpf_reg_state *reg;
-	int i;
-
-	for (i = 0; i < MAX_BPF_REG; i++) {
-		reg = &state->regs[i];
-		if (reg->type == type && reg->id == dst_reg->id)
-			/* keep the maximum range already checked */
-			reg->range = max(reg->range, new_range);
-	}
-
-	bpf_for_each_spilled_reg(i, state, reg) {
-		if (!reg)
-			continue;
-		if (reg->type == type && reg->id == dst_reg->id)
-			reg->range = max(reg->range, new_range);
-	}
-}
-
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 				   struct bpf_reg_state *dst_reg,
 				   enum bpf_reg_type type,
 				   bool range_right_open)
 {
-	int new_range, i;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int new_range;
 
 	if (dst_reg->off < 0 ||
 	    (dst_reg->off == 0 && range_right_open))
@@ -9936,9 +9883,11 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	 * the range won't allow anything.
 	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
-	for (i = 0; i <= vstate->curframe; i++)
-		__find_good_pkt_pointers(vstate->frame[i], dst_reg, type,
-					 new_range);
+	bpf_expr_for_each_reg_in_vstate(vstate, state, reg, ({
+		if (reg->type == type && reg->id == dst_reg->id)
+			/* keep the maximum range already checked */
+			reg->range = max(reg->range, new_range);
+	}));
 }
 
 static int is_branch32_taken(struct bpf_reg_state *reg, u32 val, u8 opcode)
@@ -10427,7 +10376,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
 		if (!reg_may_point_to_spin_lock(reg)) {
 			/* For not-NULL ptr, reg->ref_obj_id will be reset
-			 * in release_reg_references().
+			 * in release_reference().
 			 *
 			 * reg->id is still used by spin_lock ptr. Other
 			 * than spin_lock ptr type, reg->id can be reset.
@@ -10437,22 +10386,6 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 	}
 }
 
-static void __mark_ptr_or_null_regs(struct bpf_func_state *state, u32 id,
-				    bool is_null)
-{
-	struct bpf_reg_state *reg;
-	int i;
-
-	for (i = 0; i < MAX_BPF_REG; i++)
-		mark_ptr_or_null_reg(state, &state->regs[i], id, is_null);
-
-	bpf_for_each_spilled_reg(i, state, reg) {
-		if (!reg)
-			continue;
-		mark_ptr_or_null_reg(state, reg, id, is_null);
-	}
-}
-
 /* The logic is similar to find_good_pkt_pointers(), both could eventually
  * be folded together at some point.
  */
@@ -10460,10 +10393,9 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 				  bool is_null)
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *regs = state->regs;
+	struct bpf_reg_state *regs = state->regs, *reg;
 	u32 ref_obj_id = regs[regno].ref_obj_id;
 	u32 id = regs[regno].id;
-	int i;
 
 	if (ref_obj_id && ref_obj_id == id && is_null)
 		/* regs[regno] is in the " == NULL" branch.
@@ -10472,8 +10404,9 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 */
 		WARN_ON_ONCE(release_reference_state(state, id));
 
-	for (i = 0; i <= vstate->curframe; i++)
-		__mark_ptr_or_null_regs(vstate->frame[i], id, is_null);
+	bpf_expr_for_each_reg_in_vstate(vstate, state, reg, ({
+		mark_ptr_or_null_reg(state, reg, id, is_null);
+	}));
 }
 
 static bool try_match_pkt_pointers(const struct bpf_insn *insn,
@@ -10586,23 +10519,11 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int i, j;
 
-	for (i = 0; i <= vstate->curframe; i++) {
-		state = vstate->frame[i];
-		for (j = 0; j < MAX_BPF_REG; j++) {
-			reg = &state->regs[j];
-			if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
-				*reg = *known_reg;
-		}
-
-		bpf_for_each_spilled_reg(j, state, reg) {
-			if (!reg)
-				continue;
-			if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
-				*reg = *known_reg;
-		}
-	}
+	bpf_expr_for_each_reg_in_vstate(vstate, state, reg, ({
+		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+			*reg = *known_reg;
+	}));
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
-- 
2.34.1

