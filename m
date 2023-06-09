Return-Path: <bpf+bounces-2265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101B72A511
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50A3281A68
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A351F17E;
	Fri,  9 Jun 2023 21:02:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF91DDDC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:02:00 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE7273D
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:01:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f65779894eso1866038e87.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686344517; x=1688936517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJsvF/MTlkt7OyoIQxFak0WPsDWsjDRDWEkPqI2qnb0=;
        b=f+ykYe/EZnA8sXk46gVGAbkIwjajm5/CMfxNTsQqpLQpCh2/WVf7Bf5uyI4IkZRFwT
         5Xr6JAIqGIAzhMeuBF1GlNz8Iy6A1ekQHrlni7lyBR8ewzV4lLhIgBSqHvDk3pDNmptD
         5nMFY6Tawstat5HC2E0Z9E8n/qQxBBdUkmsc56jxoMGJaDmX9E5RIy7QFkiD5oG09XUB
         vTG0QCl5cYj+Yq0pvVaDyk/kp3k9eEkSnewl2B1iKE9z6bnjJ6X7nxiarwahGI/uylgJ
         UXD9gcPVbCjbn9hxFyYLsv+X+Pty2gIyrAhcElzIpTOHKkiloApFrLGa/SdI2ZsprRG7
         9LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344517; x=1688936517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJsvF/MTlkt7OyoIQxFak0WPsDWsjDRDWEkPqI2qnb0=;
        b=Rd/DLzcLeQ+oE5AqzwI1ng7kofhS0NSItpMrT5xx9uBOxoP4U7sH6XB8P731z0n2A1
         VG0GCx3BKI6ZKAiJBXnxEioEr0W3EiiVTOwBiguIxFSktxlUuQt+wElHo3NmR0xx2MwS
         5g90qbCq2IaXXB7fDZLlSgnnBPHKeUuzPpavzsGbpTsTAw2zv+nFEdz5SMK/D4rOe/8h
         zAJoGZr/on3pvg5cw4Scp29i52kmqffNAJrQRP5WIbLmYcgMKrAc58JCMEhOfE8UHv4I
         CjLhXtZA9j8lHWs260Jbyf3iGTuv4USQ39o2gscKw+AQclzY8xX437Um38w+s/m9oT4h
         OSlQ==
X-Gm-Message-State: AC+VfDzxhyFJ9jlBWLEEOMHqJ4JeI40vJZmEOMdSr6XzxdON/bguDNiF
	rWNQw+oOm62v3P5jsn4rlIAMKIobeik=
X-Google-Smtp-Source: ACHHUZ42hhNy87kksgDRJbxUViInKQhKcwnonRXcVTE4buSYWoBVqj0DC+EsXXSvIcUgayCeA4Dbhg==
X-Received: by 2002:a05:6512:3b26:b0:4f6:2d47:274c with SMTP id f38-20020a0565123b2600b004f62d47274cmr870476lfv.15.1686344516810;
        Fri, 09 Jun 2023 14:01:56 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002a8bc2fb3cesm521732ljj.115.2023.06.09.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:01:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 3/4] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date: Sat, 10 Jun 2023 00:01:42 +0300
Message-Id: <20230609210143.2625430-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609210143.2625430-1-eddyz87@gmail.com>
References: <20230609210143.2625430-1-eddyz87@gmail.com>
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

This commit adds a new function: check_scalar_ids() and updates
regsafe() to call it for precise scalar registers.
check_scalar_ids() differs from check_ids() in order to:
- treat ID zero as a unique scalar ID;
- disallow mapping same 'cur_id' to multiple 'old_id'.

To minimize the impact on verification performance, avoid generating
bpf_reg_state::id for constant scalar values when processing BPF_MOV
in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
propagate information about value ranges for registers that hold the
same value. However, there is no need to propagate range information
for constants.

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 77 +++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 73a98f6240fd..1bdda17fad70 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -584,6 +584,7 @@ struct bpf_verifier_env {
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 id_gen;			/* used to generate unique reg IDs */
+	u32 tmp_id_gen;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	bool allow_uninit_stack;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f719de396c61..c6797742f38e 100644
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
@@ -15148,6 +15150,36 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
 	return false;
 }
 
+/* Similar to check_ids(), but:
+ * - disallow mapping of different 'old_id' values to same 'cur_id' value;
+ * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
+ *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
+ */
+static bool check_scalar_ids(struct bpf_verifier_env *env, u32 old_id, u32 cur_id,
+			     struct bpf_id_pair *idmap)
+{
+	unsigned int i;
+
+	old_id = old_id ? old_id : ++env->tmp_id_gen;
+	cur_id = cur_id ? cur_id : ++env->tmp_id_gen;
+
+	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
+		if (!idmap[i].old) {
+			/* Reached an empty slot; haven't seen this id before */
+			idmap[i].old = old_id;
+			idmap[i].cur = cur_id;
+			return true;
+		}
+		if (idmap[i].old == old_id)
+			return idmap[i].cur == cur_id;
+		if (idmap[i].cur == cur_id)
+			return false;
+	}
+	/* We ran out of idmap slots, which should be impossible */
+	WARN_ON_ONCE(1);
+	return false;
+}
+
 static void clean_func_state(struct bpf_verifier_env *env,
 			     struct bpf_func_state *st)
 {
@@ -15253,6 +15285,15 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 }
 
+static bool scalar_regs_exact(struct bpf_verifier_env *env,
+			      const struct bpf_reg_state *rold,
+			      const struct bpf_reg_state *rcur,
+			      struct bpf_id_pair *idmap)
+{
+	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+	       check_scalar_ids(env, rold->id, rcur->id, idmap);
+}
+
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
@@ -15292,15 +15333,39 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
-		if (regs_exact(rold, rcur, idmap))
+		if (scalar_regs_exact(env, rold, rcur, idmap))
 			return true;
 		if (env->explore_alu_limits)
 			return false;
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
+		       check_scalar_ids(env, rold->id, rcur->id, idmap);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
@@ -15542,6 +15607,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	env->tmp_id_gen = env->id_gen;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
-- 
2.40.1


