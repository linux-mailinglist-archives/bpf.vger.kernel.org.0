Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC063ADE1
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiK1QfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 11:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiK1QfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 11:35:07 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2320F6B
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:35:06 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vp12so25983027ejc.8
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbz+FlGjq3WM9TxEKakN6lgmPncv25OUne2OVBd22hY=;
        b=UMWpvAPgXsFyzgFat6sDsR0YA1Wn7Ifi3zdHmmqNVmE97vO01bhgrJ9jubGyuOONFp
         XN/L6jfGNaI6Eh6MO2Z86L2Z3ow1tvfCN6q4DadEkhSllzCoyv3aIbMLE5j8w+mLUYw7
         XtZRJhZepy9W5L4zBuvOf7lbEU3BfxT/v1ngiMLRnioVFVKauXYn0ym5evmpXtd70lmq
         lzVlV0AHP9nKYhQGr/YuJjnuQrXVs02/P48ZZmUt1Jyc9i4RKOTgCca/CLsE2PmBmkRW
         JNM3E2YkwTnw97nB99/esgqsvbUudwmfwA93xdRXyAW/UDx3n2X4WTVYphVlCUe243Ud
         Gr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbz+FlGjq3WM9TxEKakN6lgmPncv25OUne2OVBd22hY=;
        b=driwM4kOH69wJcz1uqfstUz9M6CBs+2/44IX9N5sLqgAv6zLH/cQHGPRdxDwwtUaYf
         +sdpOm7H1q5nYxn6J15jCTMAqFeM13UspS1UHXJAeRaJheGi7EwnPXoGX4nv7Zg6xAFJ
         viWp/piRNyfZSpcjAKnoY37m9m7Ycd/YjCVjkiVzUn1qB4yr1YLOmL4E4V45ORNuj5p4
         wLK5vnSuVECHKo4FgiBzsxBWEFi5iPl5FFYcKFqHaEGvwnDvMY5B92vDj7y631vRDCUS
         s/mEg5NWt5GGz5Gg7zhvBu4/Lk8xhCyveuAL6ALAdgG7brmvQuQQg15+Y1SeksUsvgrf
         P/qw==
X-Gm-Message-State: ANoB5pn1mj58PLa5QpEOoXjUEgMY0kcNp9e/gFHEVyvUAJFgKwDG8abq
        5PWgOYZmPrApA95s4p19f5FZ5ChXIxI=
X-Google-Smtp-Source: AA0mqf7FgFLkRXARwjRRyfPMzB9x092LA12kHF0ifuufi9wsZYUzyqIElJJZyhVXtRNZItLWGlbGWA==
X-Received: by 2002:a17:906:4889:b0:7bc:42f6:372e with SMTP id v9-20020a170906488900b007bc42f6372emr15620135ejq.662.1669653304584;
        Mon, 28 Nov 2022 08:35:04 -0800 (PST)
Received: from pluto.. (178-133-113-180.mobile.vf-ua.net. [178.133.113.180])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b007417041fb2bsm5145605ejc.116.2022.11.28.08.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:35:04 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 1/2] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date:   Mon, 28 Nov 2022 18:34:41 +0200
Message-Id: <20221128163442.280187-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128163442.280187-1-eddyz87@gmail.com>
References: <20221128163442.280187-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prior to this commit the following unsafe example passed verification:

1: r9 = ... some pointer with range X ...
2: r6 = ... unbound scalar ID=a ...
3: r7 = ... unbound scalar ID=b ...
4: if (r6 > r7) goto +1
5: r6 = r7
6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created here
7: r9 += r7
8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical. If the
path 1-6 is taken by verifier first and checkpoint is created at (6)
the path 1-4, 6 would be considered safe.

This commit makes the following changes:
- a call to check_ids() is added in regsafe() for scalar registers case;
- a function mark_equal_scalars_as_read() is added to ensure that
  registers with identical IDs are preserved in the checkpoint states
  in case when find_equal_scalars() updates register range for several
  registers sharing the same ID.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6599d25dae38..8a5b7192514a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10638,10 +10638,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				/* case: R1 = R2
 				 * copy register state to dest reg
 				 */
-				if (src_reg->type == SCALAR_VALUE && !src_reg->id)
+				if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
+				    !tnum_is_const(src_reg->var_off))
 					/* Assign src and dst registers the same ID
 					 * that will be used by find_equal_scalars()
 					 * to propagate min/max range.
+					 * Skip constants to avoid allocation of useless ID.
 					 */
 					src_reg->id = ++env->id_gen;
 				*dst_reg = *src_reg;
@@ -11446,16 +11448,86 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	return true;
 }
 
+/* Scalar ID generation in check_alu_op() and logic of
+ * find_equal_scalars() make the following pattern possible:
+ *
+ * 1: r9 = ... some pointer with range X ...
+ * 2: r6 = ... unbound scalar ID=a ...
+ * 3: r7 = ... unbound scalar ID=b ...
+ * 4: if (r6 > r7) goto +1
+ * 5: r6 = r7
+ * 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created here
+ * 7: r9 += r7
+ * 8: *(u64 *)r9 = Y
+ *
+ * Because of the jump at (4) the verifier would arrive at (6) in two states:
+ * I.  r6{.id=b}, r7{.id=b}
+ * II. r6{.id=a}, r7{.id=b}
+ *
+ * Relevant facts:
+ * - regsafe() matches ID mappings for scalars using check_ids(), this makes
+ *   states (I) and (II) non-equal;
+ * - clean_func_state() removes registers not marked as REG_LIVE_READ from
+ *   checkpoint states;
+ * - mark_reg_read() modifies reg->live for reg->parent (and it's parents);
+ * - when r6 = r7 is process the bpf_reg_state is copied in full, meaning
+ *   that parent pointers are copied as well.
+ *
+ * Thus, for execution path 1-6:
+ * - both r6->parent and r7->parent point to the same register in the parent state (r7);
+ * - only *one* register in the checkpoint state would receive REG_LIVE_READ mark;
+ * - clean_func_state() would remove r6 from checkpoint state (mark it NOT_INIT).
+ *
+ * Consequently, when execution path 1-4, 6 reaches (6) in state (II)
+ * regsafe() won't be able to see a mismatch in ID mappings.
+ *
+ * To avoid this issue mark_equal_scalars_as_read() conservatively
+ * marks all registers with matching ID as REG_LIVE_READ, thus
+ * preserving r6 and r7 in the checkpoint state for the example above.
+ */
+static void mark_equal_scalars_as_read(struct bpf_verifier_state *vstate, int id)
+{
+	struct bpf_verifier_state *st;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	bool move_up;
+	int i = 0;
+
+	for (st = vstate, move_up = true; st && move_up; st = st->parent) {
+		move_up = false;
+		bpf_for_each_reg_in_vstate(st, state, reg, ({
+			if (reg->type == SCALAR_VALUE && reg->id == id &&
+			    !(reg->live & REG_LIVE_READ)) {
+				reg->live |= REG_LIVE_READ;
+				move_up = true;
+			}
+			++i;
+		}));
+	}
+}
+
 static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			       struct bpf_reg_state *known_reg)
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
+	int count = 0;
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
 			*reg = *known_reg;
+			++count;
+		}
 	}));
+
+	/* Count equal to 1 means that find_equal_scalars have not
+	 * found any registers with the same ID (except self), thus
+	 * the range knowledge have not been transferred and there is
+	 * no need to preserve registers with the same ID in a parent
+	 * state.
+	 */
+	if (count > 1)
+		mark_equal_scalars_as_read(vstate->parent, known_reg->id);
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
@@ -12878,6 +12950,12 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 */
 		return equal && rold->frameno == rcur->frameno;
 
+	/* even if two registers are identical the id mapping might diverge
+	 * e.g. rold{.id=1}, rcur{.id=1}, idmap{1->2}
+	 */
+	if (equal && rold->type == SCALAR_VALUE && rold->id)
+		return check_ids(rold->id, rcur->id, idmap);
+
 	if (equal)
 		return true;
 
@@ -12891,6 +12969,11 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type == SCALAR_VALUE) {
+			/* id relations must be preserved, see comment in
+			 * mark_equal_scalars_as_read() for SCALAR_VALUE example.
+			 */
+			if (rold->id && !check_ids(rold->id, rcur->id, idmap))
+				return false;
 			if (!rold->precise)
 				return true;
 			/* new val must satisfy old val knowledge */
-- 
2.34.1

