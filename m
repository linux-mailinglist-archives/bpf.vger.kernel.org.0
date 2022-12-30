Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910176593F6
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 02:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiL3BHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 20:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiL3BHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 20:07:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC01705B
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 17:07:42 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so24491618pjj.2
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 17:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mk7eTc/g+JW3v95IB3XTpO+FkZ1FcayCoWvpigWeF4=;
        b=JSO9Zj/rXb1o3UvBWIvhTwGbfobQwqsppBzg2/+YiE/Xitjl3w3LsKPELSAtDEcg3c
         NKweNul3OQYY1am6F6hl7sbpPBf+ztvHew4jt+HMh097KR5uIwfKTpDjVFUgouJNE+iV
         a0YQYYDP3Iru29lGTfvcx2bsavV+Du3If9jGo/02yDVmZGf60nwmXLsiiU9qn7t4FaCG
         pzeX6k1gpQSNnYnjySFax80O8pAldUOFCaOCr3c7sKmLqYnPDiSJA1SyojIfwlcCsTpj
         XPenAE8vAF4CImBZyDZtXBKxC1S4aRFIvhxBCrUDzBysxJX6Z3lcJOzWMMufnaVBqNqg
         1rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Mk7eTc/g+JW3v95IB3XTpO+FkZ1FcayCoWvpigWeF4=;
        b=NVfYnAmF9H1rap5u2vGjUqEcctIvUxvLzWcjupHFS4JS6eoj0Ye8BP+WcclJ0shY9e
         SBAjj99YeSnezb99K7FU0Ck13vI6Y/CT5iP65VcHPAkl7FQGNio0iGjzm6Hl6ED0jXlM
         aVWy9+MlICwTLcOCJ/27imZ+BX8RCgcAH9Mo/Kz8Fnp7UKfywa6sffy+c67vsyuzZmlG
         ZV3s/siAEIo1l5KgPsPxVfly3U1eoXy68isDHUfzxplty5RvR+loPNOJJ19O6raZ3wqL
         oS5eOGhysU7iKeFiivCQ8ODd7B10vUEHdMl8q6hX+qIo0bOWNV745kxNkZ+mW7iyBloU
         ge5Q==
X-Gm-Message-State: AFqh2kqXIbfxvyeRUbm/s4fL9XRIPgUv8rp2doqjJcYM/jUWzlluwSr2
        vFJg0tHLM002FMbzmQ3SVvs=
X-Google-Smtp-Source: AMrXdXu0r0KsehRfXzOYQWL8hapYUeTOsaSHVzypccLVT8T+q1wKrWoQNfA8N93je/pQ/dMixslAuA==
X-Received: by 2002:a17:902:aa94:b0:192:8d74:d218 with SMTP id d20-20020a170902aa9400b001928d74d218mr10026517plr.40.1672362462231;
        Thu, 29 Dec 2022 17:07:42 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:afb4])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709029a0900b001898ee9f723sm13626220plp.2.2022.12.29.17.07.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Dec 2022 17:07:41 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        void@manifault.com, memxor@gmail.com, davemarchevsky@fb.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Migrate release_on_unlock logic to non-owning ref semantics
Date:   Thu, 29 Dec 2022 17:07:37 -0800
Message-Id: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

This patch introduces non-owning reference semantics to the verifier,
specifically linked_list API kfunc handling. release_on_unlock logic for
refs is refactored - with small functional changes - to implement these
semantics, and bpf_list_push_{front,back} are migrated to use them.

When a list node is pushed to a list, the program still has a pointer to
the node:

  n = bpf_obj_new(typeof(*n));

  bpf_spin_lock(&l);
  bpf_list_push_back(&l, n);
  /* n still points to the just-added node */
  bpf_spin_unlock(&l);

What the verifier considers n to be after the push, and thus what can be
done with n, are changed by this patch.

Common properties both before/after this patch:
  * After push, n is only a valid reference to the node until end of
    critical section
  * After push, n cannot be pushed to any list
  * After push, the program can read the node's fields using n

Before:
  * After push, n retains the ref_obj_id which it received on
    bpf_obj_new, but the associated bpf_reference_state's
    release_on_unlock field is set to true
    * release_on_unlock field and associated logic is used to implement
      "n is only a valid ref until end of critical section"
  * After push, n cannot be written to, the node must be removed from
    the list before writing to its fields
  * After push, n is marked PTR_UNTRUSTED

After:
  * After push, n's ref is released and ref_obj_id set to 0. The
    bpf_reg_state's non_owning_ref_lock struct is populated with the
    currently active lock
    * non_owning_ref_lock and logic is used to implement "n is only a
      valid ref until end of critical section"
  * n can be written to (except for special fields e.g. bpf_list_node,
    timer, ...)
  * No special type flag is added to n after push

Summary of specific implementation changes to achieve the above:

  * release_on_unlock field, ref_set_release_on_unlock helper, and logic
    to "release on unlock" based on that field are removed

  * Convert pair { map | btf, id } into single u32

  * u32 active_lock_id field is added to bpf_reg_state's PTR_TO_BTF_ID union

  * Helpers are added to implement non-owning ref semantics as described above
    * invalidate_non_owning_refs - helper to clobber all non-owning refs
      matching a particular bpf_active_lock identity. Replaces
      release_on_unlock logic in process_spin_lock.
    * ref_convert_owning_non_owning - convert owning reference w/
      specified ref_obj_id to non-owning references. Setup
      active_lock_id for each reg with that ref_obj_id,
      clear its ref_obj_id, and remove ref_obj_id from state->acquired_refs

After these changes, linked_list's "release on unlock" logic continues
to function as before, except for the semantic differences noted above.
The patch immediately following this one makes minor changes to
linked_list selftests to account for the differing behavior.

Co-developed-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  6 +--
 kernel/bpf/verifier.c        | 92 ++++++++++++++++++------------------
 2 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 127058cfec47..3fc41edff267 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -68,6 +68,7 @@ struct bpf_reg_state {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			u32 active_lock_id;
 		};
 
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
@@ -223,11 +224,6 @@ struct bpf_reference_state {
 	 * exiting a callback function.
 	 */
 	int callback_ref;
-	/* Mark the reference state to release the registers sharing the same id
-	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
-	 * safe to access inside the critical section).
-	 */
-	bool release_on_unlock;
 };
 
 /* state of the program:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a25375ebb0d..3e7fd564132c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -190,6 +190,7 @@ struct bpf_verifier_stack_elem {
 
 static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env, u32 lock_id);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -931,6 +932,8 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 				verbose_a("id=%d", reg->id);
 			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
+			if (reg->active_lock_id)
+				verbose_a("lock_id=%d", reg->active_lock_id);
 			if (t != SCALAR_VALUE)
 				verbose_a("off=%d", reg->off);
 			if (type_is_pkt_pointer(t))
@@ -5782,9 +5785,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_lock.ptr = btf;
 		cur->active_lock.id = reg->id;
 	} else {
-		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
-		int i;
 
 		if (map)
 			ptr = map;
@@ -5800,25 +5801,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
-		cur->active_lock.ptr = NULL;
-		cur->active_lock.id = 0;
 
-		for (i = fstate->acquired_refs - 1; i >= 0; i--) {
-			int err;
+		invalidate_non_owning_refs(env, cur->active_lock.id);
 
-			/* Complain on error because this reference state cannot
-			 * be freed before this point, as bpf_spin_lock critical
-			 * section does not allow functions that release the
-			 * allocated object immediately.
-			 */
-			if (!fstate->refs[i].release_on_unlock)
-				continue;
-			err = release_reference(env, fstate->refs[i].id);
-			if (err) {
-				verbose(env, "failed to release release_on_unlock reference");
-				return err;
-			}
-		}
+		cur->active_lock.ptr = NULL;
+		cur->active_lock.id = 0;
 	}
 	return 0;
 }
@@ -7081,6 +7068,17 @@ static int release_reference(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env, u32 lock_id)
+{
+	struct bpf_func_state *unused;
+	struct bpf_reg_state *reg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+		if (base_type(reg->type) == PTR_TO_BTF_ID && reg->active_lock_id == lock_id)
+			__mark_reg_unknown(env, reg);
+	}));
+}
+
 static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs)
 {
@@ -8583,38 +8581,38 @@ static int process_kf_arg_ptr_to_kptr(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
+static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_obj_id)
 {
-	struct bpf_func_state *state = cur_func(env);
+	struct bpf_func_state *state, *unused;
 	struct bpf_reg_state *reg;
 	int i;
 
-	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
-	 * subprogs, no global functions. This means that the references would
-	 * not be released inside the critical section but they may be added to
-	 * the reference state, and the acquired_refs are never copied out for a
-	 * different frame as BPF to BPF calls don't work in bpf_spin_lock
-	 * critical sections.
-	 */
+	state = cur_func(env);
+
 	if (!ref_obj_id) {
-		verbose(env, "verifier internal error: ref_obj_id is zero for release_on_unlock\n");
+		verbose(env, "verifier internal error: ref_obj_id is zero for "
+			     "owning -> non-owning conversion\n");
 		return -EFAULT;
 	}
+
 	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].id == ref_obj_id) {
-			if (state->refs[i].release_on_unlock) {
-				verbose(env, "verifier internal error: expected false release_on_unlock");
-				return -EFAULT;
+		if (state->refs[i].id != ref_obj_id)
+			continue;
+
+		bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+			if (reg->ref_obj_id == ref_obj_id) {
+				/* Clear ref_obj_id only. The rest of PTR_TO_BTF_ID stays as-is */
+				reg->ref_obj_id = 0;
+				reg->active_lock_id = env->cur_state->active_lock.id;
 			}
-			state->refs[i].release_on_unlock = true;
-			/* Now mark everyone sharing same ref_obj_id as untrusted */
-			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-				if (reg->ref_obj_id == ref_obj_id)
-					reg->type |= PTR_UNTRUSTED;
-			}));
-			return 0;
-		}
+		}));
+
+		/* There are no referenced regs with this ref_obj_id in the current state.
+		 * Removed ref_obj_id from acquired_refs. It should definitely succeed.
+		 */
+		return release_reference_state(state, ref_obj_id);
 	}
+
 	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
 	return -EFAULT;
 }
@@ -8794,8 +8792,7 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 			btf_name_by_offset(field->graph_root.btf, et->name_off));
 		return -EINVAL;
 	}
-	/* Set arg#1 for expiration after unlock */
-	return ref_set_release_on_unlock(env, reg->ref_obj_id);
+	return ref_convert_owning_non_owning(env, reg->ref_obj_id);
 }
 
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
@@ -8997,7 +8994,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
-				verbose(env, "allocated object must be referenced\n");
+				verbose(env, "Allocated list_head must be referenced\n");
 				return -EINVAL;
 			}
 			ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
@@ -9010,7 +9007,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			if (!reg->ref_obj_id) {
-				verbose(env, "allocated object must be referenced\n");
+				verbose(env, "Allocated list_node must be referenced\n");
 				return -EINVAL;
 			}
 			ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
@@ -11959,7 +11956,10 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
 		WARN_ON_ONCE(map->max_entries != 1);
-		/* We want reg->id to be same (0) as map_value is not distinct */
+		/* map->id is positive s32. Negative map->id will not collide with env->id_gen.
+		 * This lets us track active_lock state as single u32 instead of pair { map|btf, id }
+		 */
+		dst_reg->id = -map->id;
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
-- 
2.30.2

