Return-Path: <bpf+bounces-55871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD3A88844
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19AD1673BF
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1C27F745;
	Mon, 14 Apr 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXinVMVe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B427B51A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647290; cv=none; b=Xk5fKkE1wUmhOHgXbF4V6zXCwx657dEoTueQ9WVb6/jIgnNsHjizeWvY+ws4+RYXPqe91MF4hLPw50RCY+95hLI0ndtrlV43GldiL3yRXPeerjM5I0GQhscoqDRntdAEfxjUFVkVErHYm2zttyTXYBgGBQoL6mtUC7rNlFI+80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647290; c=relaxed/simple;
	bh=8/GWJNlBBHq8hXZ+7LGuh2/PbvxRJpl/4O3IxwbmP64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/tscZC2hTsbB8h8X3Ww4wKTVHRYE6MAXv+NTx0Gsr34CkVZKPof7uhYOrJylZICkiodxQutD0YtMwDtNC+JmW3PY+5byGZAm8lHSMTxgNAaZWfVCQh9x9b9VokI5T5oRYaqtckcfQFTLC2EQdbJJIClPg1QCiLLldnHqTChwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXinVMVe; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so2694507f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647286; x=1745252086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cCzAR97tVgk6M9m+yfZFMkTrE4OxL1yNHEqNsg02x8=;
        b=iXinVMVe2XAiJib4+UD8kqa7rP6+ehiKZDdu/T2weDq8CvNroe0DSvVQyoKJNAJzt+
         VIGSIbc9xSDoE4u8qrTuRcjo32fkmiYH/rek37kH09PaDR0glcJQmfDED26vwrL8ZIzi
         pSFzWMX5SCmzEZ7G3lvPnvNvDW1bt9+E9H8pDmZ+DFvvIpJ8BE5T+r6WFakvOAmruBXk
         X3I94M3P+mj+Nm4E0wceukLuKAMrSBb/gaTTnl9h2USgOVK4vd7AQ/2HvbuyJuSc0Y4v
         BE4RV1ojXEBBxd+GHc2y1NICGak3UR9K/r64ajtE/NrfCOLvRKv8TkClWpGUsXQmI/9g
         fSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647286; x=1745252086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cCzAR97tVgk6M9m+yfZFMkTrE4OxL1yNHEqNsg02x8=;
        b=SodX8lsux3YEP6Nemf79cTIMe2bnHOjCcMGdLdHCS+erGG04+2lx4m+XmqDRrEQKaB
         79t8WXQexW7RucwD2cxJMiYGmK1rB/pnLvxBko5KHkCGkx8SRymCwc4FIQ3XJPdC/MEg
         nVvRTeP5xd6gi8j0BtWFfva07/278zHse/bNAFN2+gnnlOUc+qaWJmTPjRfO2k5k8iKl
         v1GTHuWkv4YbrIOTETYovSE2OwMJoop3jbrAhkVJbcNtXXFdzRuDyKPFRGQ4M7Qydo2F
         yVEYmnAYkSkXnJK06gcCNxHll8KJGSHvjR/2cL/bEwvUkGlAgvY8UThEtA6YllEIN22U
         aBjw==
X-Gm-Message-State: AOJu0Ywi2ee/9bnejAHu0KCvJenb4TSrwtiVcUqAa8RvM8H8lNQvagHx
	tBJNAzIQzEFwijNDSOQnhs4I+axvl/JF9jGCACrOJVsQNIWldKpdh0qnMm+F7eE=
X-Gm-Gg: ASbGnctEEjuE7Ufnem0EVkByCdgS40kz4RfWdmuTzJzQsRWBKEHL9Q4ANsT55zxncZK
	CQz5vlMMpwwnGk1hO70qpwc+kIMENV7xo4lcK96gZU9A9KO7jEaBn4R2HMzTj94sST6XN1HWrTp
	/udabfSRoI650HdT3kQ1gIEyA9XT2hLnpa6sImcNmlZmiYVnff5mplY1pGyCZRoUdMpkYsr0ab9
	Q22g/dz7YrtNAqRB/LrXXdFCdkf4mrsiq/c4/J7S76yr0vnyCtpO8xhZSaJAtJ2eW6PHVcMxG6U
	XFaYSzPWjbXMTXBwAH314RYqy9TH01U=
X-Google-Smtp-Source: AGHT+IFhs0sJ1PfYCpxPgpWLm4bW8pznMW7Pu7AIqcldDO1obYqmPWF2P4hZvHfJZl/RWhuVBDUeCA==
X-Received: by 2002:a05:6000:4310:b0:391:3988:1c7c with SMTP id ffacd0b85a97d-39ea51f57eemr10521973f8f.24.1744647285721;
        Mon, 14 Apr 2025 09:14:45 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc8esm186805945e9.30.2025.04.14.09.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to referenced source objects
Date: Mon, 14 Apr 2025 09:14:31 -0700
Message-ID: <20250414161443.1146103-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10980; h=from:subject; bh=8/GWJNlBBHq8hXZ+7LGuh2/PbvxRJpl/4O3IxwbmP64=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOITAwGa4D4drfzh4LVTAv5S+hvREahg+RBivNJ ZXJ+fQaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziAAKCRBM4MiGSL8RypMkEA CqWgcNa0ERmHxU9tcEMMIXXHNm4+4EPO3qFPilFMGS/FOBe2jU6WVk64JQJUhbfrNv3TL2qtHFUPcq +yTOD8An6j1N1aEkKeunWgq0EfqJJsHtZ2L4KaPnXiHCAQRt9cYfP24KeQkLVx6NYopTWHT1d5ORag iBYjtMAObkFpR3jRqizBzjub2gTyNZ3xV3t151Ff4lnG+QRw/Yd1aFn6nWEuj/6vXjVVTjYb9gL1PI g8eFPnwzKMalJuUTTo++jZZAq0XGCRSEg+vrc4gIx/AdjfwBCSw+46+pAgbKt/ToXR1XWzItIMmSf9 bTckHqvHtNOcqVr+S2p30LnIotz0Umzn3q8k07UctDuv4eMq3Lwl4KYFK11wcS/WhAjV/b1A9ZXKHA hjut9bmZcfKu3WKx4sBIzM2v7FMTsem0y8IoS4g6JAl8LiWYOqlqj7xhYcPYnYaE2TKGvq3Wd0sqr/ cz/2eVgOf+nnAslXX+6unJ6HOySIxb5NYXg1Ocow6P6ehl6f49HPwXdK99+wN1RAdUoaL7PrufB+98 dqI2R+LZUvrNVyEbvJmcW9/53aA+/2As7Xb2DD7BVyhla/q6JSc0oOj9uGzx3HZlUMo1iUHg2ovZJ/ CLHH90xaHm3VBTS1bka1BY+Ey9HqKlvypH8xX2CnNhBEBIa0Q8kVz+2kUXVw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that for dynptr constructors (MEM_UNINIT arg_type) taking a
referenced object (ref_obj_id) as their memory source, we set the
ref_obj_id of the dynptr appropriately as well. This allows us to
tie the lifetime of the dynptr to its source and properly invalidate
it when the source object is released.

For helpers, we don't have such cases yet as bpf_dynptr_from_mem is
not permitted for anything other than PTR_TO_MAP_VALUE, but still pass
meta->ref_obj_id as clone_ref_obj_id in case this is relaxed in future.
Since they are ossified we know dynptr_from_mem is the only relevant
helper and takes one memory argument, so we know the meta->ref_obj_id if
non-zero will belong to it.

For kfuncs, make sure for constructors, only 1 ref_obj_id argument is
seen, as more than one can be ambiguous in terms of ref_obj_id transfer.
Since more kfuncs can be added with possibly multiple memory arguments,
make sure meta->ref_obj_id reassignment won't cause incorrect lifetime
analysis in the future using ref_obj_cnt logic.  Set this ref_obj_id as
the clone_ref_obj_id, so that it is transferred to the spilled_ptr stack
slot register state.

Add support to unmark_stack_slots_dynptr to not descend to its child
slices (using bool slice parameter) so that we don't have circular calls
when invoking release_reference. With this logic in place, we may have
the following object relationships:
				     +-- slice 1 (ref=1)
 source (ref=1) --> dynptr (ref=1) --|-- slice 2 (ref=1)
				     +-- slice 3 (ref=1)

Destroying dynptr prunes the dynptr and all its children slices, but
does not affect the source. Releasing the source will effectively prune
the entire ownership tree. Dynptr clones with same ref=1 will be
parallel in the ownership tree.

		  +-- orig  dptr (ref=1) --> slice 1 (ref=1)
 source (ref=1) --|-- clone dptr (ref=1) --> slice 2 (ref=1)
		  +-- clone dptr (ref=1) --> slice 3 (ref=1)

In such a case, only child slices of the dynptr clone being destroyed
are invalidated. Likewise, if the source object goes away, the whole
tree ends up getting pruned.

Cc: Amery Hung <ameryhung@gmail.com>
Fixes: 81bb1c2c3e8e ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 81 ++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..a62dfab9aea6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -198,7 +198,7 @@ struct bpf_verifier_stack_elem {
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_id, bool objects);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
@@ -299,6 +299,7 @@ struct bpf_kfunc_call_arg_meta {
 	const char *func_name;
 	/* Out parameters */
 	u32 ref_obj_id;
+	u32 ref_obj_cnt;
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
@@ -759,7 +760,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
 			       &state->stack[spi - 1].spilled_ptr, type);
 
-	if (dynptr_type_refcounted(type)) {
+	if (dynptr_type_refcounted(type) || clone_ref_obj_id) {
 		/* The id is used to track proper releasing */
 		int id;
 
@@ -818,22 +819,19 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 }
 
-static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_func_state *state,
+				       int spi, bool slice)
 {
-	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i;
+	u32 ref_obj_id;
+	int i;
 
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
+	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
 
-	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type) && !ref_obj_id) {
 		invalidate_dynptr(env, state, spi);
 		return 0;
 	}
 
-	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
-
 	/* If the dynptr has a ref_obj_id, then we need to invalidate
 	 * two things:
 	 *
@@ -842,7 +840,8 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	 */
 
 	/* Invalidate any slices associated with this dynptr */
-	WARN_ON_ONCE(release_reference(env, ref_obj_id));
+	if (slice)
+		WARN_ON_ONCE(release_reference(env, ref_obj_id, false));
 
 	/* Invalidate any dynptr clones */
 	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -864,6 +863,18 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	return 0;
 }
 
+static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg, bool slice)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi;
+
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	return __unmark_stack_slots_dynptr(env, state, spi, slice);
+}
+
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg);
 
@@ -1075,7 +1086,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+			WARN_ON_ONCE(release_reference(env, st->ref_obj_id, false));
 
 		__mark_reg_not_init(env, st);
 
@@ -9749,7 +9760,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
+		err = process_dynptr_func(env, regno, insn_idx, arg_type, meta->ref_obj_id);
 		if (err)
 			return err;
 		break;
@@ -10220,12 +10231,12 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob
  *
  * This is the release function corresponding to acquire_reference(). Idempotent.
  */
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_id, bool objects)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int err;
+	int err, spi;
 
 	err = release_reference_nomark(vstate, ref_obj_id);
 	if (err)
@@ -10236,6 +10247,19 @@ static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
 			mark_reg_invalid(env, reg);
 	}));
 
+	if (!objects)
+		return 0;
+
+	bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
+		if (!reg)
+			continue;
+		if (!reg->dynptr.first_slot || reg->ref_obj_id != ref_obj_id)
+			continue;
+		err = __unmark_stack_slots_dynptr(env, state, spi, false);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -11357,7 +11381,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be released\n");
 				return -EFAULT;
 			}
-			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno], true);
 		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
 			u32 ref_obj_id = meta.ref_obj_id;
 			bool in_rcu = in_rcu_cs(env);
@@ -11379,7 +11403,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				}));
 			}
 		} else if (meta.ref_obj_id) {
-			err = release_reference(env, meta.ref_obj_id);
+			err = release_reference(env, meta.ref_obj_id, true);
 		} else if (register_is_null(&regs[meta.release_regno])) {
 			/* meta.ref_obj_id can only be 0 if register that is meant to be
 			 * released is NULL, which must be > R0.
@@ -12974,6 +12998,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			meta->ref_obj_id = reg->ref_obj_id;
 			if (is_kfunc_release(meta))
 				meta->release_regno = regno;
+			meta->ref_obj_cnt++;
 		}
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
@@ -13100,13 +13125,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
-			int clone_ref_obj_id = 0;
+			int clone_ref_obj_id = meta->ref_obj_id;
 
 			if (reg->type == CONST_PTR_TO_DYNPTR)
 				dynptr_arg_type |= MEM_RDONLY;
 
-			if (is_kfunc_arg_uninit(btf, &args[i]))
+			if (is_kfunc_arg_uninit(btf, &args[i])) {
 				dynptr_arg_type |= MEM_UNINIT;
+				/* It's confusing if dynptr constructor takes multiple referenced arguments. */
+				if (meta->ref_obj_cnt > 1) {
+					verbose(env, "verifier internal error: multiple referenced arguments\n");
+					return -EFAULT;
+				}
+			}
 
 			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
@@ -13582,7 +13613,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
+		err = release_reference(env, regs[meta.release_regno].ref_obj_id, true);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
@@ -13603,7 +13634,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 		}
 
-		err = release_reference(env, release_ref_obj_id);
+		err = release_reference(env, release_ref_obj_id, true);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
@@ -13803,11 +13834,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					return -EFAULT;
 				}
 				regs[BPF_REG_0].dynptr_id = meta.initialized_dynptr.id;
-
-				/* we don't need to set BPF_REG_0's ref obj id
-				 * because packet slices are not refcounted (see
-				 * dynptr_type_refcounted)
-				 */
+				regs[BPF_REG_0].ref_obj_id = meta.initialized_dynptr.ref_obj_id;
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
-- 
2.47.1


