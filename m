Return-Path: <bpf+bounces-61971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78003AF02DE
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DC91C03B60
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383E27F747;
	Tue,  1 Jul 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFWzYbE8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713C27FB30
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394982; cv=none; b=IynEE9rrhL/3l7WxEj1HpDutTsoG42Mm6A9PfWMwVsYThjMcCqaw+Idf1ANGudtyW7SB1w+3riU3NMYqA3RRNA3dkqogT75bZWZdY/v6Qld/qTXzamXJPHRXt3GTisHVQJXUziOy8laQ8sFiUESh2iQGo96xioT2A5dqyICHOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394982; c=relaxed/simple;
	bh=8OXtKDUCmsyuMX4khvILbwQUpGrjniY+EtdTepSOMD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LLCaA8hOMDQfl+OUGJraRgRCEoYyM5lnNN28IvfjlYBTS/zV0rHP0/1Z3xHlXXJkyNsS3hrlTSJhnB7uXg/G7PavyJseu3J1pWGsD8iTze5O8mEK4r3iYY4OHY3wsoFEAE4f3p//ZkxDthGrORmbzLllht7GwB9m4YgjaSRNJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFWzYbE8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cf214200so30340645e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751394978; x=1751999778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6VLyqzd0AGFdC/DrfiKpxVCTo/qGoPdD/PKg/w7nVs=;
        b=KFWzYbE8I3tVO5CO0vBs3Z7ruJSr1Fcjl6hI09ztZcydCyx+svKBHPs4kr91Tf+WQL
         ZNVzrySHIPFb9Ib0RSsI9TOUbGwG8b6iJ6ttX1uD1BiAiHIypAClKjXI5bFmjBIB+8ec
         5umc/E9dhGad6CXLMyV4Yb+0RwS7Q7mwRcZmzd5cO1ZMTYYIp5z+bjU+2OwHf9b3B/+C
         Zi5izFih8HDJv2YqtDvnSR8BkRsUmGqWwvENdee3LVkNQ2SMArojbdxJpGMCUZcnjTWk
         1DyfTfdzojINjDUZJ75Tw5OuVUiRu+wLIzxPBwhsNWGKRtEJ4buljn2F6zaFRXjBP+li
         ux9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751394978; x=1751999778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6VLyqzd0AGFdC/DrfiKpxVCTo/qGoPdD/PKg/w7nVs=;
        b=oUdRYYQ+KSzkwhhpEP2wM5BaVTzOAG4vSfId8jbRP3mdNdJLFG7D5H1r35dpbCPSAh
         EtalrwHxqxcpKoZ0JcjTnwFKvwN0BbU06GFRz6jMU+h63/0ehEPulDB5UEIlpm6rWeRZ
         CU0hOYV/mjn1Whor+1l6QHBkhpMMUUIDh4K3Vj3fJkCY81rANLgJuU1GxD/RN7bDwAfu
         EvOLmKf2nvjDmiEweyjELaUPpmbbr9lBJSznheiF5cdtPBJN9TbRg97w/z8v+MeQnpF/
         xGpDjOfGeP0gIv42VqaGtGFNkJE+lzksgglmQnTaNaqRwvj8hKidrzmnlSdEKj9s50o0
         v1ug==
X-Gm-Message-State: AOJu0YzL4qejBInXHz2fSuGDIqEx4a0xDS+TSwb80xvghUBMoowygaga
	WbO/I3XcP9MDyVNGfLLWZyE7AYs9wGtiYdJcAVUn0k8BsOBbEsa7AWZLXvzgwQ==
X-Gm-Gg: ASbGncuIK5zBHYKCLWttC4Jg4Lso3xSNFdLgDh1NeF1tu/2O2E+XLY8HcSBC6r89MSF
	74puoDSJNPt6XSTvv42FqsQ7NcQk5ZTX75LMSTJjzOWF45/TtSaYcLgxuBy/ayyxcCfV6PlkcWN
	rpO+29OZCpB0XN7s6Eoo0xMzL2FIWQ7YhYek70/7wvas8piPYvhEpw7sawLlNwoy2+pkYxsVuRS
	KCUhM0Ukzl1QpBsJxIdJLCS65gh0kivgOBPZcWmaHdOKbRc/5GO6YVHfFBsKa5XWeYDNPj7U+kV
	Jf9ybm4qZAvB5iArLsB7A9wYt420JoVuWISByalN6g0S9poXXK5T9fhjZZHqcUeqIKQOqy0qYXc
	FhkDVfZjbXZBfUtSGZXXbX4ypn3IiYKmGCpUvwvAI4CUNrv+2TA==
X-Google-Smtp-Source: AGHT+IFmLIlGOVxyxqS+ZwxGkEQ7NlP2Po8AXFb2jH/9aMScn78clvjnnejk5GdyxN+Cl9pcNvtDVg==
X-Received: by 2002:a05:600c:3d96:b0:444:34c7:3ed9 with SMTP id 5b1f17b1804b1-454a3725bcdmr1286495e9.26.1751394977384;
        Tue, 01 Jul 2025 11:36:17 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00024ac52d8fa7f8001.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:24ac:52d8:fa7f:8001])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5fd2sm172863365e9.15.2025.07.01.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:36:16 -0700 (PDT)
Date: Tue, 1 Jul 2025 20:36:15 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3] bpf: Warn on internal verifier errors
Message-ID: <aGQqnzMyeagzgkCK@Tunnel>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is a follow up to commit 1cb0f56d9618 ("bpf: WARN_ONCE on
verifier bugs"). It generalizes the use of verifier_error throughout
the verifier, in particular for logs previously marked "verifier
internal error". As a consequence, all of those verifier bugs will now
come with a kernel warning (under CONFIG_DBEUG_KERNEL) detectable by
fuzzers.

While at it, some error messages that were too generic (ex., "bpf
verifier is misconfigured") have been reworded.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v3:
  - Revert two lines that already have both a kernel warning and a
    verbose(), per Alexei's review.
Changes in v2:
  - Addressed new checkpatch complaints.
  - Rebased on bpf-next.

 kernel/bpf/verifier.c | 211 ++++++++++++++++++++----------------------
 1 file changed, 102 insertions(+), 109 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 90e688f81a48..a352b35be479 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -861,7 +861,7 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		 * dynptr
 		 */
 		if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
-			verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
+			verifier_bug(env, "misconfigured ref_obj_id");
 			return -EFAULT;
 		}
 		if (state->stack[i].spilled_ptr.dynptr.first_slot)
@@ -2030,12 +2030,10 @@ static int update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifie
 	while (st) {
 		u32 br = --st->branches;
 
-		/* WARN_ON(br > 1) technically makes sense here,
+		/* verifier_bug_if(br > 1, ...) technically makes sense here,
 		 * but see comment in push_stack(), hence:
 		 */
-		WARN_ONCE((int)br < 0,
-			  "BUG update_branch_counts:branches_to_explore=%d\n",
-			  br);
+		verifier_bug_if((int)br < 0, env, "%s:branches_to_explore=%d", __func__, br);
 		if (br)
 			break;
 		err = maybe_exit_scc(env, st);
@@ -2681,13 +2679,13 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 
 	return 0;
 out:
-	verbose(env, "REG INVARIANTS VIOLATION (%s): %s u64=[%#llx, %#llx] "
-		"s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)\n",
-		ctx, msg, reg->umin_value, reg->umax_value,
-		reg->smin_value, reg->smax_value,
-		reg->u32_min_value, reg->u32_max_value,
-		reg->s32_min_value, reg->s32_max_value,
-		reg->var_off.value, reg->var_off.mask);
+	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s u64=[%#llx, %#llx] "
+		     "s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)",
+		     ctx, msg, reg->umin_value, reg->umax_value,
+		     reg->smin_value, reg->smax_value,
+		     reg->u32_min_value, reg->u32_max_value,
+		     reg->s32_min_value, reg->s32_max_value,
+		     reg->var_off.value, reg->var_off.mask);
 	if (env->test_reg_invariants)
 		return -EFAULT;
 	__mark_reg_unbounded(reg);
@@ -4741,7 +4739,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 	if (regno >= 0) {
 		reg = &func->regs[regno];
 		if (reg->type != SCALAR_VALUE) {
-			WARN_ONCE(1, "backtracing misuse");
+			verifier_bug(env, "backtracking misuse");
 			return -EFAULT;
 		}
 		bt_set_reg(bt, regno);
@@ -7213,7 +7211,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 
 	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
 		if (!btf_is_kernel(reg->btf)) {
-			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
+			verifier_bug(env, "reg->btf must be kernel btf");
 			return -EFAULT;
 		}
 		ret = env->ops->btf_struct_access(&env->log, reg, off, size);
@@ -7229,7 +7227,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 
 		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
 		    !(reg->type & MEM_RCU) && !reg->ref_obj_id) {
-			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
+			verifier_bug(env, "ref_obj_id for allocated object must be non-zero");
 			return -EFAULT;
 		}
 
@@ -8597,7 +8595,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
 	 */
 	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
-		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
+		verifier_bug(env, "misconfigured dynptr helper type flags");
 		return -EFAULT;
 	}
 
@@ -8963,8 +8961,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
 	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
-		verbose(env, "verifier internal error: unexpected iterator state %d (%s)\n",
-			cur_iter->iter.state, iter_state_str(cur_iter->iter.state));
+		verifier_bug(env, "unexpected iterator state %d (%s)",
+			     cur_iter->iter.state, iter_state_str(cur_iter->iter.state));
 		return -EFAULT;
 	}
 
@@ -8974,7 +8972,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		 */
 		if (!cur_st->parent || cur_st->parent->insn_idx != insn_idx ||
 		    !same_callsites(cur_st->parent, cur_st)) {
-			verbose(env, "bug: bad parent state for iter next call");
+			verifier_bug(env, "bad parent state for iter next call");
 			return -EFAULT;
 		}
 		/* Note cur_st->parent in the call below, it is necessary to skip
@@ -9033,7 +9031,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 {
 	if (!meta->map_ptr) {
 		/* kernel subsystem misconfigured verifier */
-		verbose(env, "invalid map_ptr to access map->type\n");
+		verifier_bug(env, "invalid map_ptr to access map->type");
 		return -EFAULT;
 	}
 
@@ -9180,7 +9178,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 	compatible = compatible_reg_types[base_type(arg_type)];
 	if (!compatible) {
-		verbose(env, "verifier internal error: unsupported arg type %d\n", arg_type);
+		verifier_bug(env, "unsupported arg type %d", arg_type);
 		return -EFAULT;
 	}
 
@@ -9262,7 +9260,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 		if (!arg_btf_id) {
 			if (!compatible->btf_id) {
-				verbose(env, "verifier internal error: missing arg compatible BTF ID\n");
+				verifier_bug(env, "missing arg compatible BTF ID");
 				return -EFAULT;
 			}
 			arg_btf_id = compatible->btf_id;
@@ -9294,7 +9292,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
-			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
+			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
 			return -EFAULT;
 		}
 		/* Check if local kptr in src arg matches kptr in dst arg */
@@ -9309,7 +9307,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		/* Handled by helper specific checks */
 		break;
 	default:
-		verbose(env, "verifier internal error: invalid PTR_TO_BTF_ID register for type match\n");
+		verifier_bug(env, "invalid PTR_TO_BTF_ID register for type match");
 		return -EFAULT;
 	}
 	return 0;
@@ -9667,7 +9665,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EINVAL;
 		}
 		if (meta->release_regno) {
-			verbose(env, "verifier internal error: more than one release argument\n");
+			verifier_bug(env, "more than one release argument");
 			return -EFAULT;
 		}
 		meta->release_regno = regno;
@@ -9675,9 +9673,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
-			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-				regno, reg->ref_obj_id,
-				meta->ref_obj_id);
+			verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
+				     regno, reg->ref_obj_id,
+				     meta->ref_obj_id);
 			return -EFAULT;
 		}
 		meta->ref_obj_id = reg->ref_obj_id;
@@ -9721,7 +9719,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 * we have to check map_key here. Otherwise it means
 			 * that kernel subsystem misconfigured verifier
 			 */
-			verbose(env, "invalid map_ptr to access map->key\n");
+			verifier_bug(env, "invalid map_ptr to access map->key");
 			return -EFAULT;
 		}
 		key_size = meta->map_ptr->key_size;
@@ -9748,7 +9746,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		if (!meta->map_ptr) {
 			/* kernel subsystem misconfigured verifier */
-			verbose(env, "invalid map_ptr to access map->value\n");
+			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
@@ -9778,7 +9776,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			if (err)
 				return err;
 		} else {
-			verbose(env, "verifier internal error\n");
+			verifier_bug(env, "spin lock arg on unexpected helper");
 			return -EFAULT;
 		}
 		break;
@@ -10936,8 +10934,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return -EINVAL;
 		}
 		if (!calls_callback(env, callee->callsite)) {
-			verbose(env, "BUG: in callback at %d, callsite %d !calls_callback\n",
-				*insn_idx, callee->callsite);
+			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
+				     *insn_idx, callee->callsite);
 			return -EFAULT;
 		}
 	} else {
@@ -11044,7 +11042,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 
 	if (map == NULL) {
-		verbose(env, "kernel subsystem misconfigured verifier\n");
+		verifier_bug(env, "expected map for helper call");
 		return -EFAULT;
 	}
 
@@ -11083,7 +11081,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (func_id != BPF_FUNC_tail_call)
 		return 0;
 	if (!map || map->map_type != BPF_MAP_TYPE_PROG_ARRAY) {
-		verbose(env, "kernel subsystem misconfigured verifier\n");
+		verifier_bug(env, "expected array map for tail call");
 		return -EFAULT;
 	}
 
@@ -11336,8 +11334,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
 	changes_data = bpf_helper_changes_pkt_data(func_id);
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
-		verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
-			func_id_name(func_id), func_id);
+		verifier_bug(env, "func %s#%d: r1 != ctx", func_id_name(func_id), func_id);
 		return -EFAULT;
 	}
 
@@ -11346,8 +11343,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	err = check_func_proto(fn, func_id);
 	if (err) {
-		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
-			func_id_name(func_id), func_id);
+		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id), func_id);
 		return err;
 	}
 
@@ -11420,7 +11416,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		 */
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
 			if (regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR) {
-				verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be released\n");
+				verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
 				return -EFAULT;
 			}
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
@@ -11537,23 +11533,23 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 
 		if (meta.dynptr_id) {
-			verbose(env, "verifier internal error: meta.dynptr_id already set\n");
+			verifier_bug(env, "meta.dynptr_id already set");
 			return -EFAULT;
 		}
 		if (meta.ref_obj_id) {
-			verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
+			verifier_bug(env, "meta.ref_obj_id already set");
 			return -EFAULT;
 		}
 
 		id = dynptr_id(env, reg);
 		if (id < 0) {
-			verbose(env, "verifier internal error: failed to obtain dynptr id\n");
+			verifier_bug(env, "failed to obtain dynptr id");
 			return id;
 		}
 
 		ref_obj_id = dynptr_ref_obj_id(env, reg);
 		if (ref_obj_id < 0) {
-			verbose(env, "verifier internal error: failed to obtain dynptr ref_obj_id\n");
+			verifier_bug(env, "failed to obtain dynptr ref_obj_id");
 			return ref_obj_id;
 		}
 
@@ -11638,8 +11634,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		 * to map element returned from bpf_map_lookup_elem()
 		 */
 		if (meta.map_ptr == NULL) {
-			verbose(env,
-				"kernel subsystem misconfigured verifier\n");
+			verifier_bug(env, "unexpected null map_ptr");
 			return -EFAULT;
 		}
 
@@ -11730,9 +11725,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			}
 		} else {
 			if (fn->ret_btf_id == BPF_PTR_POISON) {
-				verbose(env, "verifier internal error:");
-				verbose(env, "func %s has non-overwritten BPF_PTR_POISON return type\n",
-					func_id_name(func_id));
+				verifier_bug(env, "func %s has non-overwritten BPF_PTR_POISON return type",
+					     func_id_name(func_id));
 				return -EFAULT;
 			}
 			ret_btf = btf_vmlinux;
@@ -11758,8 +11752,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].id = ++env->id_gen;
 
 	if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
-		verbose(env, "verifier internal error: func %s#%d sets ref_obj_id more than once\n",
-			func_id_name(func_id), func_id);
+		verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
+			     func_id_name(func_id), func_id);
 		return -EFAULT;
 	}
 
@@ -12471,7 +12465,7 @@ static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 		if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])
 			kfunc_class = IRQ_LOCK_KFUNC;
 	} else {
-		verbose(env, "verifier internal error: unknown irq flags kfunc\n");
+		verifier_bug(env, "unknown irq flags kfunc");
 		return -EFAULT;
 	}
 
@@ -12512,12 +12506,12 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	struct btf_record *rec = reg_btf_record(reg);
 
 	if (!env->cur_state->active_locks) {
-		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
+		verifier_bug(env, "%s w/o active lock", __func__);
 		return -EFAULT;
 	}
 
 	if (type_flag(reg->type) & NON_OWN_REF) {
-		verbose(env, "verifier internal error: NON_OWN_REF already set\n");
+		verifier_bug(env, "NON_OWN_REF already set");
 		return -EFAULT;
 	}
 
@@ -12536,8 +12530,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
 	int i;
 
 	if (!ref_obj_id) {
-		verbose(env, "verifier internal error: ref_obj_id is zero for "
-			     "owning -> non-owning conversion\n");
+		verifier_bug(env, "ref_obj_id is zero for owning -> non-owning conversion");
 		return -EFAULT;
 	}
 
@@ -12557,7 +12550,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
 		return 0;
 	}
 
-	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
+	verifier_bug(env, "ref state missing for ref_obj_id");
 	return -EFAULT;
 }
 
@@ -12619,7 +12612,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 		ptr = reg->btf;
 		break;
 	default:
-		verbose(env, "verifier internal error: unknown reg type for lock check\n");
+		verifier_bug(env, "unknown reg type for lock check");
 		return -EFAULT;
 	}
 	id = reg->id;
@@ -12780,7 +12773,7 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 	u32 head_off;
 
 	if (meta->btf != btf_vmlinux) {
-		verbose(env, "verifier internal error: unexpected btf mismatch in kfunc call\n");
+		verifier_bug(env, "unexpected btf mismatch in kfunc call");
 		return -EFAULT;
 	}
 
@@ -12811,7 +12804,7 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 	}
 
 	if (*head_field) {
-		verbose(env, "verifier internal error: repeating %s arg\n", head_type_name);
+		verifier_bug(env, "repeating %s arg", head_type_name);
 		return -EFAULT;
 	}
 	*head_field = field;
@@ -12848,7 +12841,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 	u32 node_off;
 
 	if (meta->btf != btf_vmlinux) {
-		verbose(env, "verifier internal error: unexpected btf mismatch in kfunc call\n");
+		verifier_bug(env, "unexpected btf mismatch in kfunc call");
 		return -EFAULT;
 	}
 
@@ -12976,7 +12969,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_prog(btf, &args[i])) {
 			/* Used to reject repeated use of __prog. */
 			if (meta->arg_prog) {
-				verbose(env, "Only 1 prog->aux argument supported per-kfunc\n");
+				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
 				return -EFAULT;
 			}
 			meta->arg_prog = true;
@@ -12992,7 +12985,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 			if (is_kfunc_arg_constant(meta->btf, &args[i])) {
 				if (meta->arg_constant.found) {
-					verbose(env, "verifier internal error: only one constant argument permitted\n");
+					verifier_bug(env, "only one constant argument permitted");
 					return -EFAULT;
 				}
 				if (!tnum_is_const(reg->var_off)) {
@@ -13044,9 +13037,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-					regno, reg->ref_obj_id,
-					meta->ref_obj_id);
+				verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
+					     regno, reg->ref_obj_id,
+					     meta->ref_obj_id);
 				return -EFAULT;
 			}
 			meta->ref_obj_id = reg->ref_obj_id;
@@ -13126,7 +13119,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
 		default:
-			WARN_ON_ONCE(1);
+			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
 			return -EFAULT;
 		}
 
@@ -13195,14 +13188,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
-					verbose(env, "verifier internal error: no dynptr type for parent of clone\n");
+					verifier_bug(env, "no dynptr type for parent of clone");
 					return -EFAULT;
 				}
 
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
 				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
 				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
-					verbose(env, "verifier internal error: missing ref obj id for parent of clone\n");
+					verifier_bug(env, "missing ref obj id for parent of clone");
 					return -EFAULT;
 				}
 			}
@@ -13215,7 +13208,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				int id = dynptr_id(env, reg);
 
 				if (id < 0) {
-					verbose(env, "verifier internal error: failed to obtain dynptr id\n");
+					verifier_bug(env, "failed to obtain dynptr id");
 					return id;
 				}
 				meta->initialized_dynptr.id = id;
@@ -13351,7 +13344,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 			if (is_kfunc_arg_const_mem_size(meta->btf, size_arg, size_reg)) {
 				if (meta->arg_constant.found) {
-					verbose(env, "verifier internal error: only one constant argument permitted\n");
+					verifier_bug(env, "only one constant argument permitted");
 					return -EFAULT;
 				}
 				if (!tnum_is_const(size_reg->var_off)) {
@@ -13383,7 +13376,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 			rec = reg_btf_record(reg);
 			if (!rec) {
-				verbose(env, "verifier internal error: Couldn't find btf_record\n");
+				verifier_bug(env, "Couldn't find btf_record");
 				return -EFAULT;
 			}
 
@@ -13642,7 +13635,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 
 		if (!meta->arg_constant.found) {
-			verbose(env, "verifier internal error: bpf_dynptr_slice(_rdwr) no constant size\n");
+			verifier_bug(env, "bpf_dynptr_slice(_rdwr) no constant size");
 			return -EFAULT;
 		}
 
@@ -13662,7 +13655,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		}
 
 		if (!meta->initialized_dynptr.id) {
-			verbose(env, "verifier internal error: no dynptr id\n");
+			verifier_bug(env, "no dynptr id");
 			return -EFAULT;
 		}
 		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
@@ -14306,8 +14299,7 @@ static int sanitize_err(struct bpf_verifier_env *env,
 			dst, err);
 		return -ENOMEM;
 	default:
-		verbose(env, "verifier internal error: unknown reason (%d)\n",
-			reason);
+		verifier_bug(env, "unknown reason (%d)", reason);
 		break;
 	}
 
@@ -16842,7 +16834,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			dst_reg->btf_id = aux->btf_var.btf_id;
 			break;
 		default:
-			verbose(env, "bpf verifier is misconfigured\n");
+			verifier_bug(env, "pseudo btf id: unexpected dst reg type");
 			return -EFAULT;
 		}
 		return 0;
@@ -16884,7 +16876,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
 	} else {
-		verbose(env, "bpf verifier is misconfigured\n");
+		verifier_bug(env, "unexpected src reg value for ldimm64");
 		return -EFAULT;
 	}
 
@@ -16931,7 +16923,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	}
 
 	if (!env->ops->gen_ld_abs) {
-		verbose(env, "bpf verifier is misconfigured\n");
+		verifier_bug(env, "gen_ld_abs is null");
 		return -EFAULT;
 	}
 
@@ -17342,7 +17334,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		/* forward- or cross-edge */
 		insn_state[t] = DISCOVERED | e;
 	} else {
-		verbose(env, "insn state internal bug\n");
+		verifier_bug(env, "insn state internal bug");
 		return -EFAULT;
 	}
 	return DONE_EXPLORING;
@@ -17803,7 +17795,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 			break;
 		default:
 			if (ret > 0) {
-				verbose(env, "visit_insn internal bug\n");
+				verifier_bug(env, "visit_insn internal bug");
 				ret = -EFAULT;
 			}
 			goto err_free;
@@ -17811,7 +17803,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 	}
 
 	if (env->cfg.cur_stack < 0) {
-		verbose(env, "pop stack internal bug\n");
+		verifier_bug(env, "pop stack internal bug");
 		ret = -EFAULT;
 		goto err_free;
 	}
@@ -19564,8 +19556,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		return err;
 	}
 	new->insn_idx = insn_idx;
-	WARN_ONCE(new->branches != 1,
-		  "BUG is_state_visited:branches_to_explore=%d insn %d\n", new->branches, insn_idx);
+	verifier_bug_if(new->branches != 1, env,
+			"%s:branches_to_explore=%d insn %d",
+			__func__, new->branches, insn_idx);
 	err = maybe_enter_scc(env, new);
 	if (err) {
 		free_verifier_state(new, false);
@@ -21136,7 +21129,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
 						 -(subprogs[0].stack_depth + 8));
 		if (epilogue_cnt >= INSN_BUF_SIZE) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verifier_bug(env, "epilogue is too long");
 			return -EFAULT;
 		} else if (epilogue_cnt) {
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
@@ -21159,13 +21152,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 					env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
 			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
@@ -21349,7 +21342,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			u8 size_code;
 
 			if (type == BPF_WRITE) {
-				verbose(env, "bpf verifier narrow ctx access misconfigured\n");
+				verifier_bug(env, "narrow ctx access misconfigured");
 				return -EFAULT;
 			}
 
@@ -21368,7 +21361,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					 &target_size);
 		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
 		    (ctx_field_size && !target_size)) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verifier_bug(env, "error during ctx access conversion");
 			return -EFAULT;
 		}
 
@@ -21376,7 +21369,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			u8 shift = bpf_ctx_narrow_access_offset(
 				off, size, size_default) * 8;
 			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
-				verbose(env, "bpf verifier narrow ctx load misconfigured\n");
+				verifier_bug(env, "narrow ctx load misconfigured");
 				return -EFAULT;
 			}
 			if (ctx_field_size <= 4) {
@@ -21807,8 +21800,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 */
 	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
 	if (!desc) {
-		verbose(env, "verifier internal error: kernel function descriptor not found for func_id %u\n",
-			insn->imm);
+		verifier_bug(env, "kernel function descriptor not found for func_id %u",
+			     insn->imm);
 		return -EFAULT;
 	}
 
@@ -21823,8 +21816,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
 
 		if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && kptr_struct_meta) {
-			verbose(env, "verifier internal error: NULL kptr_struct_meta expected at insn_idx %d\n",
-				insn_idx);
+			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
 			return -EFAULT;
 		}
 
@@ -21840,15 +21833,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
 
 		if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] && kptr_struct_meta) {
-			verbose(env, "verifier internal error: NULL kptr_struct_meta expected at insn_idx %d\n",
-				insn_idx);
+			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
 			return -EFAULT;
 		}
 
 		if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
 		    !kptr_struct_meta) {
-			verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
-				insn_idx);
+			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
 			return -EFAULT;
 		}
 
@@ -21870,8 +21863,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		if (!kptr_struct_meta) {
-			verbose(env, "verifier internal error: kptr_struct_meta expected at insn_idx %d\n",
-				insn_idx);
+			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
 			return -EFAULT;
 		}
 
@@ -21905,7 +21898,7 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 
 	/* We only reserve one slot for hidden subprogs in subprog_info. */
 	if (env->hidden_subprog_cnt) {
-		verbose(env, "verifier internal error: only one hidden subprog supported\n");
+		verifier_bug(env, "only one hidden subprog supported");
 		return -EFAULT;
 	}
 	/* We're not patching any existing instruction, just appending the new
@@ -22141,7 +22134,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		     BPF_MODE(insn->code) == BPF_IND)) {
 			cnt = env->ops->gen_ld_abs(insn, insn_buf);
 			if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
-				verbose(env, "bpf verifier is misconfigured\n");
+				verifier_bug(env, "%d insns generated for ld_abs", cnt);
 				return -EFAULT;
 			}
 
@@ -22477,7 +22470,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				if (cnt == -EOPNOTSUPP)
 					goto patch_map_ops_generic;
 				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
-					verbose(env, "bpf verifier is misconfigured\n");
+					verifier_bug(env, "%d insns generated for map lookup", cnt);
 					return -EFAULT;
 				}
 
@@ -22765,9 +22758,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		 * programs to call them, must be real in-kernel functions
 		 */
 		if (!fn->func) {
-			verbose(env,
-				"kernel subsystem misconfigured func %s#%d\n",
-				func_id_name(insn->imm), insn->imm);
+			verifier_bug(env,
+				     "not inlined functions %s#%d is missing func",
+				     func_id_name(insn->imm), insn->imm);
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
@@ -22837,7 +22830,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (!map_ptr->ops->map_poke_track ||
 		    !map_ptr->ops->map_poke_untrack ||
 		    !map_ptr->ops->map_poke_run) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verifier_bug(env, "poke tab is misconfigured");
 			return -EFAULT;
 		}
 
@@ -23155,8 +23148,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				/* caller can pass either PTR_TO_ARENA or SCALAR */
 				mark_reg_unknown(env, regs, i);
 			} else {
-				WARN_ONCE(1, "BUG: unhandled arg#%d type %d\n",
-					  i - BPF_REG_1, arg->arg_type);
+				verifier_bug(env, "unhandled arg#%d type %d",
+					     i - BPF_REG_1, arg->arg_type);
 				ret = -EFAULT;
 				goto out;
 			}
-- 
2.43.0


