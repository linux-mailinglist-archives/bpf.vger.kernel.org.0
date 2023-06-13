Return-Path: <bpf+bounces-2522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123872E770
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D61C2035A
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D23C095;
	Tue, 13 Jun 2023 15:39:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BD23DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:39:06 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4E11BF9
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso7015282e87.0
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686670721; x=1689262721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/jYIB3hsXiHg+qlW/9YXhP9wKARQm1UFkZX7Cpm2JA=;
        b=IMjb6Gh98JsXMJWIKB+D1av/wJXAVxWRQdidr8g+1AjlDQxp1ZRgMZceI+WCu/XAta
         70b5A0NtUnKCl8ecQMNofC3bWJEEIKgvQndHmNbrO7axwy4la8Z2eB9NiZZDBKQR8gPD
         XzS7TMaOzNzuVY3SDW19UR9aLr7+stn5K/PJxlIk9EkA9kWDa7iDZm1KENZ9lrU8Nf7i
         LPFQhqP3ByUhPr8HAXA1PJjcMSvAmztSafLeP7B0+lhvnttqfFbjlAmaADS+ZmgjV726
         bOH9xymF8/voxIl7AzUPROjVh4qLnqcrl6NMwcz2QYRMnkGBgy6rdKs7F1gsVXZTBHDI
         yURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670721; x=1689262721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/jYIB3hsXiHg+qlW/9YXhP9wKARQm1UFkZX7Cpm2JA=;
        b=g+T9rHR6ys0vU7dTIMoJgEp4RPz5sbO6A+c+jA/112cFbtBtcCabueVzrfc/g3l9xC
         dhCwRU3fzHpVjeAWgHs1KaKn3dP9jw9rkmFzBCfGIuiRQZqEU5akQD15JSwzRvMla0pb
         6gkoJd1XHCrYMMlcvV5v2eRbTR5rqrsdmPWp8+PJf+kc2/tnnVxm4wwg5przJVHcc7Ob
         gmjIUPhIhiH6b6ht/+3xck2+LN0h4VzvEcwbhKhZJXb3QudtQcWZtfQczb35gEY/wMke
         k6crU/WfrkxJEH6XRGd6OMD1gZQzTIvSOoEv0I25Fey4q3Lw/blJEaVeQlSQab3iYyVG
         2Kag==
X-Gm-Message-State: AC+VfDxMaN7OkUrIfNQG37l+tmGHt0fUcYz7Vfudkzx3KEMjrueM+ryl
	FgrRABg58uAvLRjNZlW+zOHa6bo+P2904g==
X-Google-Smtp-Source: ACHHUZ5Oc7B6DF7f4A3o3WF4oFKgUErx9pCEWt0cGZiWsGS5454hzqOJys8sCOl7FDlyAqsr2UCMtQ==
X-Received: by 2002:a19:4352:0:b0:4f1:4cdc:ec03 with SMTP id m18-20020a194352000000b004f14cdcec03mr5161804lfj.18.1686670720746;
        Tue, 13 Jun 2023 08:38:40 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004f24db9248dsm1818576lff.141.2023.06.13.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:38:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v6 3/4] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date: Tue, 13 Jun 2023 18:38:23 +0300
Message-Id: <20230613153824.3324830-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613153824.3324830-1-eddyz87@gmail.com>
References: <20230613153824.3324830-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure that the following unsafe example is rejected by verifier:

1: r9 = ... some pointer with range X ...
2: r6 = ... unbound scalar ID=a ...
3: r7 = ... unbound scalar ID=b ...
4: if (r6 > r7) goto +1
5: r6 = r7
6: if (r6 > X) goto ...
--- checkpoint ---
7: r9 += r7
8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical. If the
path 1-6 is taken by verifier first, and checkpoint is created at (6)
the path [1-4, 6] would be considered safe.

Changes in this commit:
- check_ids() is modified to disallow mapping multiple old_id to the
  same cur_id.
- check_scalar_ids() is added, unlike check_ids() it treats ID zero as
  a unique scalar ID.
- check_scalar_ids() needs to generate temporary unique IDs, field
  'tmp_id_gen' is added to bpf_verifier_env::idmap_scratch to
  facilitate this.
- regsafe() is updated to:
  - use check_scalar_ids() for precise scalar registers.
  - compare scalar registers using memcmp only for explore_alu_limits
    branch. This simplifies control flow for scalar case, and has no
    measurable performance impact.
- check_alu_op() is updated to avoid generating bpf_reg_state::id for
  constant scalar values when processing BPF_MOV. ID is needed to
  propagate range information for identical values, but there is
  nothing to propagate for constants.

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 17 ++++---
 kernel/bpf/verifier.c        | 91 +++++++++++++++++++++++++++---------
 2 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 73a98f6240fd..042b76fe8e29 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -313,11 +313,6 @@ struct bpf_idx_pair {
 	u32 idx;
 };
 
-struct bpf_id_pair {
-	u32 old;
-	u32 cur;
-};
-
 #define MAX_CALL_FRAMES 8
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
@@ -559,6 +554,16 @@ struct backtrack_state {
 	u64 stack_masks[MAX_CALL_FRAMES];
 };
 
+struct bpf_id_pair {
+	u32 old;
+	u32 cur;
+};
+
+struct bpf_idmap {
+	u32 tmp_id_gen;
+	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
+};
+
 struct bpf_idset {
 	u32 count;
 	u32 ids[BPF_ID_MAP_SIZE];
@@ -596,7 +601,7 @@ struct bpf_verifier_env {
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
 	union {
-		struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
+		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
 	};
 	struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 747d69b2eaa5..3d4be26b046f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12942,12 +12942,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		if (BPF_SRC(insn->code) == BPF_X) {
 			struct bpf_reg_state *src_reg = regs + insn->src_reg;
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
+			bool need_id = src_reg->type == SCALAR_VALUE && !src_reg->id &&
+				       !tnum_is_const(src_reg->var_off);
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				/* case: R1 = R2
 				 * copy register state to dest reg
 				 */
-				if (src_reg->type == SCALAR_VALUE && !src_reg->id)
+				if (need_id)
 					/* Assign src and dst registers the same ID
 					 * that will be used by find_equal_scalars()
 					 * to propagate min/max range.
@@ -12966,7 +12968,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
 
-					if (is_src_reg_u32 && !src_reg->id)
+					if (is_src_reg_u32 && need_id)
 						src_reg->id = ++env->id_gen;
 					copy_register_state(dst_reg, src_reg);
 					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
@@ -15122,8 +15124,9 @@ static bool range_within(struct bpf_reg_state *old,
  * So we look through our idmap to see if this old id has been seen before.  If
  * so, we require the new id to match; otherwise, we add the id pair to the map.
  */
-static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
+static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
+	struct bpf_id_pair *map = idmap->map;
 	unsigned int i;
 
 	/* either both IDs should be set or both should be zero */
@@ -15134,20 +15137,34 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
 		return true;
 
 	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
-		if (!idmap[i].old) {
+		if (!map[i].old) {
 			/* Reached an empty slot; haven't seen this id before */
-			idmap[i].old = old_id;
-			idmap[i].cur = cur_id;
+			map[i].old = old_id;
+			map[i].cur = cur_id;
 			return true;
 		}
-		if (idmap[i].old == old_id)
-			return idmap[i].cur == cur_id;
+		if (map[i].old == old_id)
+			return map[i].cur == cur_id;
+		if (map[i].cur == cur_id)
+			return false;
 	}
 	/* We ran out of idmap slots, which should be impossible */
 	WARN_ON_ONCE(1);
 	return false;
 }
 
+/* Similar to check_ids(), but allocate a unique temporary ID
+ * for 'old_id' or 'cur_id' of zero.
+ * This makes pairs like '0 vs unique ID', 'unique ID vs 0' valid.
+ */
+static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
+{
+	old_id = old_id ? old_id : ++idmap->tmp_id_gen;
+	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
+
+	return check_ids(old_id, cur_id, idmap);
+}
+
 static void clean_func_state(struct bpf_verifier_env *env,
 			     struct bpf_func_state *st)
 {
@@ -15246,7 +15263,7 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 
 static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
-		       struct bpf_id_pair *idmap)
+		       struct bpf_idmap *idmap)
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
@@ -15255,7 +15272,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
 {
 	if (!(rold->live & REG_LIVE_READ))
 		/* explored state didn't use this */
@@ -15292,15 +15309,42 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
-		if (regs_exact(rold, rcur, idmap))
-			return true;
-		if (env->explore_alu_limits)
-			return false;
+		if (env->explore_alu_limits) {
+			/* explore_alu_limits disables tnum_in() and range_within()
+			 * logic and requires everything to be strict
+			 */
+			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+			       check_scalar_ids(rold->id, rcur->id, idmap);
+		}
 		if (!rold->precise)
 			return true;
-		/* new val must satisfy old val knowledge */
+		/* Why check_ids() for scalar registers?
+		 *
+		 * Consider the following BPF code:
+		 *   1: r6 = ... unbound scalar, ID=a ...
+		 *   2: r7 = ... unbound scalar, ID=b ...
+		 *   3: if (r6 > r7) goto +1
+		 *   4: r6 = r7
+		 *   5: if (r6 > X) goto ...
+		 *   6: ... memory operation using r7 ...
+		 *
+		 * First verification path is [1-6]:
+		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
+		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
+		 *   r7 <= X, because r6 and r7 share same id.
+		 * Next verification path is [1-4, 6].
+		 *
+		 * Instruction (6) would be reached in two states:
+		 *   I.  r6{.id=b}, r7{.id=b} via path 1-6;
+		 *   II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
+		 *
+		 * Use check_ids() to distinguish these states.
+		 * ---
+		 * Also verify that new value satisfies old value range knowledge.
+		 */
 		return range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off);
+		       tnum_in(rold->var_off, rcur->var_off) &&
+		       check_scalar_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
@@ -15346,7 +15390,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_id_pair *idmap)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
 {
 	int i, spi;
 
@@ -15449,7 +15493,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 }
 
 static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
-		    struct bpf_id_pair *idmap)
+		    struct bpf_idmap *idmap)
 {
 	int i;
 
@@ -15497,13 +15541,13 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
-			     env->idmap_scratch))
+			     &env->idmap_scratch))
 			return false;
 
-	if (!stacksafe(env, old, cur, env->idmap_scratch))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch))
 		return false;
 
-	if (!refsafe(old, cur, env->idmap_scratch))
+	if (!refsafe(old, cur, &env->idmap_scratch))
 		return false;
 
 	return true;
@@ -15518,7 +15562,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->curframe != cur->curframe)
 		return false;
 
-	memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
+	env->idmap_scratch.tmp_id_gen = env->id_gen;
+	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
 
 	/* Verification state from speculative execution simulation
 	 * must never prune a non-speculative execution one.
@@ -15536,7 +15581,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 		return false;
 
 	if (old->active_lock.id &&
-	    !check_ids(old->active_lock.id, cur->active_lock.id, env->idmap_scratch))
+	    !check_ids(old->active_lock.id, cur->active_lock.id, &env->idmap_scratch))
 		return false;
 
 	if (old->active_rcu_lock != cur->active_rcu_lock)
-- 
2.40.1


