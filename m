Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4356E8B32
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjDTHPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjDTHPb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C73D3AA8
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2466f65d7e0so404508a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974928; x=1684566928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gghPNvRhC1KND3ZXhUUwZ2GZ9XHTJ8bFXjW0qe8qDc=;
        b=pKyyFAbljlXWHp2wf7UZMHLstTvOIjv2Vx+izwVRUUekWOtIibGw0Dl05cwYgdKoyd
         rd2+C/P/DVj+pQt/77raJJSbAVVcVZoQ5vldLgQgLTXKqFJ10qMi1i+zoxj/EjDLxhT7
         Pnfc70YlmyChzvKDrBN/it4eD2Fsc7/bCnJV8zE6MrMDDPWSfOw4ioj5xGa7/dHQ6REH
         T0ZryIj8a16ayRs9pjtvrbepFUcOh9RbT2zcEHaAhsdLfQuto5OFd5uoYSFBaOn6pOvV
         +zoh7JXdbVV48O09b8R+3VIK8f0m6DaFsknaWXZWYwO/q9PV4deucCNRsMylSvX3vp/M
         OG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974928; x=1684566928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gghPNvRhC1KND3ZXhUUwZ2GZ9XHTJ8bFXjW0qe8qDc=;
        b=AuJXDoVjJzsvUB3vz2lcR8djwhweZo68mV3mGIlXJVVemJVN9GOEx3QHjftCWQ3oze
         /Ie5+tuJh8Ooa3xs7qM7N3v8u4ouU1NiIvboMH4VdwhujUSHgwTtz/wj4jWLS24FgstU
         UnrXBxx9eyVlIWQFaCJKEDq+FawPIdMgb45v9rhZFsLSh3DcrBVFCMEL0TdbHzGqp4fD
         OyaEGcjId3YUbqzbpNYOT/S6kvsyZbdwT3cnNe3n+7/6kCCjgXggW4gPLOaUV/3TTry9
         9yOA/HNDkm2j17u+FTV+IhLDFf7ILM5Dya0Z8F7ccqeSbCc76eG+7czCQ24aVXqiLOtV
         pY6g==
X-Gm-Message-State: AAQBX9dhRelOP2WundOUCd2nOjoulNAEapn+BjeTDXA2NrHH5okwPc9U
        llH1egIhOCJy+0RpdufHMcQDs9CHeEAfrQ==
X-Google-Smtp-Source: AKy350aBNjOMYrOL0g3UsJfTWBWPyc3WzgVtY4VV13L61Sq+6CHQw7EUNEqmOf38dmwdztjOsNO25A==
X-Received: by 2002:a17:90a:ee86:b0:247:90ea:1a81 with SMTP id i6-20020a17090aee8600b0024790ea1a81mr704727pjz.37.1681974928415;
        Thu, 20 Apr 2023 00:15:28 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm588208pju.27.2023.04.20.00.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:15:28 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 4/5] bpf: Add bpf_dynptr_clone
Date:   Thu, 20 Apr 2023 00:14:13 -0700
Message-Id: <20230420071414.570108-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420071414.570108-1-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
MIME-Version: 1.0
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

The cloned dynptr will point to the same data as its parent dynptr,
with the same type, offset, size and read-only properties.

Any writes to a dynptr will be reflected across all instances
(by 'instance', this means any dynptrs that point to the same
underlying data).

Please note that data slice and dynptr invalidations will affect all
instances as well. For example, if bpf_dynptr_write() is called on an
skb-type dynptr, all data slices of dynptr instances to that skb
will be invalidated as well (eg data slices of any clones, parents,
grandparents, ...). Another example is if a ringbuf dynptr is submitted,
any instance of that dynptr will be invalidated.

Changing the view of the dynptr (eg advancing the offset or
trimming the size) will only affect that dynptr and not affect any
other instances.

One example use case where cloning may be helpful is for hashing or
iterating through dynptr data. Cloning will allow the user to maintain
the original view of the dynptr for future use, while also allowing
views to smaller subsets of the data after the offset is advanced or the
size is trimmed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/helpers.c  |  14 ++++++
 kernel/bpf/verifier.c | 105 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9018646b86db..1ebdc7f1a574 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2343,6 +2343,19 @@ __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
 	return __bpf_dynptr_size(ptr);
 }
 
+__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
+				 struct bpf_dynptr_kern *clone__uninit)
+{
+	if (!ptr->data) {
+		bpf_dynptr_set_null(clone__uninit);
+		return -EINVAL;
+	}
+
+	*clone__uninit = *ptr;
+
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2419,6 +2432,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
+BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e05355facdc..164726673086 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -309,6 +309,7 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		enum bpf_dynptr_type type;
 		u32 id;
+		u32 ref_obj_id;
 	} initialized_dynptr;
 	struct {
 		u8 spi;
@@ -847,11 +848,11 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx)
+				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i, id, err;
+	int spi, i, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -887,7 +888,13 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 
 	if (dynptr_type_refcounted(type)) {
 		/* The id is used to track proper releasing */
-		id = acquire_reference_state(env, insn_idx);
+		int id;
+
+		if (clone_ref_obj_id)
+			id = clone_ref_obj_id;
+		else
+			id = acquire_reference_state(env, insn_idx);
+
 		if (id < 0)
 			return id;
 
@@ -901,24 +908,15 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	return 0;
 }
 
-static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_state *state, int spi)
 {
-	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
-
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
+	int i;
 
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_INVALID;
 		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
 	}
 
-	/* Invalidate any slices associated with this dynptr */
-	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type))
-		WARN_ON_ONCE(release_reference(env, state->stack[spi].spilled_ptr.ref_obj_id));
-
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
@@ -945,6 +943,52 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	 */
 	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+}
+
+static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	int spi;
+
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		int ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
+		int i;
+
+		/* If the dynptr has a ref_obj_id, then we need to invalidate
+		 * two things:
+		 *
+		 * 1) Any dynptrs with a matching ref_obj_id (clones)
+		 * 2) Any slices derived from this dynptr.
+		 */
+
+		/* Invalidate any slices associated with this dynptr */
+		WARN_ON_ONCE(release_reference(env, ref_obj_id));
+
+		/* Invalidate any dynptr clones */
+		for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (state->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
+				continue;
+
+			/* it should always be the case that if the ref obj id
+			 * matches then the stack slot also belongs to a
+			 * dynptr
+			 */
+			if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
+				verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
+				return -EFAULT;
+			}
+			if (state->stack[i].spilled_ptr.dynptr.first_slot)
+				invalidate_dynptr(env, state, i);
+		}
+
+		return 0;
+	}
+
+	invalidate_dynptr(env, state, spi);
 
 	return 0;
 }
@@ -6662,7 +6706,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
-			       enum bpf_arg_type arg_type)
+			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	int err;
@@ -6706,7 +6750,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
 	} else /* MEM_RDONLY and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
@@ -7616,7 +7660,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, regno, insn_idx, arg_type);
+		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
 		if (err)
 			return err;
 		break;
@@ -9580,6 +9624,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_dynptr_clone,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -9599,6 +9644,7 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_dynptr_clone)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -9620,6 +9666,7 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_dynptr_clone)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10315,6 +10362,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
+			int clone_ref_obj_id = 0;
 
 			if (reg->type != PTR_TO_STACK &&
 			    reg->type != CONST_PTR_TO_DYNPTR) {
@@ -10328,12 +10376,28 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
-			else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp])
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
+				   (dynptr_arg_type & MEM_UNINIT)) {
+				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
+
+				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
+					verbose(env, "verifier internal error: no dynptr type for parent of clone\n");
+					return -EFAULT;
+				}
+
+				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
+				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
+					verbose(env, "verifier internal error: missing ref obj id for parent of clone\n");
+					return -EFAULT;
+				}
+			}
 
-			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type);
+			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
 			if (ret < 0)
 				return ret;
 
@@ -10346,6 +10410,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 				meta->initialized_dynptr.id = id;
 				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
+				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
 			}
 
 			break;
-- 
2.34.1

