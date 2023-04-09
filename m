Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290AA6DBE6B
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 05:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDIDex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 23:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIDev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 23:34:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5985FC5
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 20:34:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h24so2211922plr.1
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681011289; x=1683603289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JSMWO9ng+z6X49BKLxvDPY6cTR8qytXEgrcjihSQWU=;
        b=PYrEvYuRBjCzscBtVzNN5hZJWII6vs8m5nogrwNQoy6/ElP0mj+H1lH63ALj5gQ0Lf
         /9kgSyUYG45d4jVVK3O2+mInSSa9ulAhcbimVDGdwLpxO882I9r5VllWaZCLTbeAYlzs
         JiYv1mZAeaCofrHy5yn+9gPUKRrDXRjM4iW9FTehV1DtY8uHFu6/7exRCFNSg0mq2kQy
         tV0MdJSZvcXwWqRZZCtNFqyj0ltNXz2xqpG255P50+UE0pbyAnCDoc4efd4nI3HIf43s
         ieMeEy2p5Dn72Re6Gf4SvILTCQxLBwCecnWmYno11q+aLSFetBhCD/c+WcmP2fnc0IAi
         Wtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681011289; x=1683603289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JSMWO9ng+z6X49BKLxvDPY6cTR8qytXEgrcjihSQWU=;
        b=JCFK6m3O7u7aecmPvbG1DA7fcoci9oQ6EJ0ZafZh1CNf1+io9bXP/kGN5eCjff7fgJ
         36oDqLoYX7V6O3AjU7Pf7OUK1aCtUzAnap/LQrs41D/qWtbnFnNV3xkzX7doEEahqBi4
         Yf1z0szjPwGdJlp1L1QeAUmlRT3lABDHPJ9XriqgO3rbwhBSLE3SLIToT1yS7OEG4fzf
         FHYqYTIhl4jItQpfYpiGfPEVlnA2+MlyH4pD0i+BdGoPjuE3vVG4hUVXJ3lIOCI9hnzf
         IPsu9Hz6RTj9Pl/11d8B6SSoF+ZWmnemptTvHg6oSgPV7eIbzvLy7FKwEM3u4mV5gnFA
         iCEA==
X-Gm-Message-State: AAQBX9e97lEQmnfOohkB77RxAAtTAti1pbbP/JOMXToh+cpqCm+qmV6Y
        FIw3sS1DqqM34tmGqh6T3BHugqXdqWlI3A==
X-Google-Smtp-Source: AKy350ZnUvkKoWN0Isv1RaBS/5XTMZckc7UiNEXXw1gHLBu34eVV9bAto3u+kuEeVbAWHXK/new74w==
X-Received: by 2002:a17:90b:1a85:b0:23d:10f2:bda2 with SMTP id ng5-20020a17090b1a8500b0023d10f2bda2mr9047250pjb.30.1681011289624;
        Sat, 08 Apr 2023 20:34:49 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001a212a93295sm5185877plm.189.2023.04.08.20.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 20:34:49 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
Date:   Sat,  8 Apr 2023 20:34:30 -0700
Message-Id: <20230409033431.3992432-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230409033431.3992432-1-joannelkoong@gmail.com>
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 kernel/bpf/helpers.c  |  14 +++++
 kernel/bpf/verifier.c | 125 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bac4c6fe49f0..108f3bcfa6da 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2351,6 +2351,19 @@ __bpf_kfunc __u32 bpf_dynptr_get_offset(const struct bpf_dynptr_kern *ptr)
 	return ptr->offset;
 }
 
+__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
+				 struct bpf_dynptr_kern *clone__uninit)
+{
+	if (!ptr->data) {
+		bpf_dynptr_set_null(clone__uninit);
+		return -EINVAL;
+	}
+
+	memcpy(clone__uninit, ptr, sizeof(*clone__uninit));
+
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2429,6 +2442,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_get_size)
 BTF_ID_FLAGS(func, bpf_dynptr_get_offset)
+BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3660b573048a..804cb50050f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -302,6 +302,7 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		enum bpf_dynptr_type type;
 		u32 id;
+		u32 ref_obj_id;
 	} initialized_dynptr;
 	struct {
 		u8 spi;
@@ -963,24 +964,15 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
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
 
@@ -1007,6 +999,51 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
+		/* If the dynptr has a ref_obj_id, then we need to invaldiate
+		 * two things:
+		 *
+		 * 1) Any dynptrs with a matching ref_obj_id (clones)
+		 * 2) Any slices associated with the ref_obj_id
+		 */
+
+		/* Invalidate any slices associated with this dynptr */
+		WARN_ON_ONCE(release_reference(env, ref_obj_id));
+
+		/* Invalidate any dynptr clones */
+		for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (state->stack[i].spilled_ptr.ref_obj_id == ref_obj_id) {
+				/* it should always be the case that if the ref obj id
+				 * matches then the stack slot also belongs to a
+				 * dynptr
+				 */
+				if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
+					verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
+					return -EFAULT;
+				}
+				if (state->stack[i].spilled_ptr.dynptr.first_slot)
+					invalidate_dynptr(env, state, i);
+			}
+		}
+
+		return 0;
+	}
+
+	invalidate_dynptr(env, state, spi);
 
 	return 0;
 }
@@ -6967,6 +7004,50 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	return 0;
 }
 
+static int handle_dynptr_clone(struct bpf_verifier_env *env, enum bpf_arg_type arg_type,
+			       int regno, int insn_idx, struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *first_reg_state, *second_reg_state;
+	struct bpf_func_state *state = func(env, reg);
+	enum bpf_dynptr_type dynptr_type = meta->initialized_dynptr.type;
+	int err, spi, ref_obj_id;
+
+	if (!dynptr_type) {
+		verbose(env, "verifier internal error: no dynptr type for bpf_dynptr_clone\n");
+		return -EFAULT;
+	}
+	arg_type |= get_dynptr_type_flag(dynptr_type);
+
+	err = process_dynptr_func(env, regno, insn_idx, arg_type);
+	if (err < 0)
+		return err;
+
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	first_reg_state = &state->stack[spi].spilled_ptr;
+	second_reg_state = &state->stack[spi - 1].spilled_ptr;
+	ref_obj_id = first_reg_state->ref_obj_id;
+
+	/* reassign the clone the same dynptr id as the original */
+	__mark_dynptr_reg(first_reg_state, dynptr_type, true, meta->initialized_dynptr.id);
+	__mark_dynptr_reg(second_reg_state, dynptr_type, false, meta->initialized_dynptr.id);
+
+	if (meta->initialized_dynptr.ref_obj_id) {
+		/* release the new ref obj id assigned during process_dynptr_func */
+		err = release_reference_state(cur_func(env), ref_obj_id);
+		if (err)
+			return err;
+		/* reassign the clone the same ref obj id as the original */
+		first_reg_state->ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+		second_reg_state->ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+	}
+
+	return 0;
+}
+
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
@@ -9615,6 +9696,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_dynptr_clone,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -9633,6 +9715,7 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_dynptr_clone)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -9653,6 +9736,7 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_dynptr_clone)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10414,10 +10498,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
+				/* bpf_dynptr_clone is special.
+				 *
+				 * we need to assign the clone the same dynptr type and
+				 * the clone needs to have the same id and ref_obj_id as
+				 * the original dynptr
+				 */
+				ret = handle_dynptr_clone(env, dynptr_arg_type, regno, insn_idx, meta);
+				if (ret < 0)
+					return ret;
+
+				break;
+			}
 
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type);
 			if (ret < 0)
@@ -10432,6 +10530,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 				meta->initialized_dynptr.id = id;
 				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
+				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
 			}
 
 			break;
-- 
2.34.1

