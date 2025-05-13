Return-Path: <bpf+bounces-58074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C5AB4842
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523E81B42D13
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBEC18DB20;
	Tue, 13 May 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE1uZFkY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0318C932
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094828; cv=none; b=R48A+M1b86pWp1MB5bBTXRm3qiYHWCOHPS0kXnZJ2hMRoOG/M6dPaDn/MkzXeH+wWYMqyiROU/B3810HKsexXLQnfc/wsdL9FDEIBLPvk6YamH+tznXQi2tsnxI3zCtfYBVhrkL+6tgi578lE9TTiK1aLtbJorQ/I6jd0PykUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094828; c=relaxed/simple;
	bh=zFISzlTdFAgnzT4xezEUtPhbE/zGusoZE0fb+jq/yg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pegE5ste30ynEOOtOa4ukEmiwAOqe14BXDO+FUN2qlClYW7mSZV3xL1jBeK4/7D2vJ/rBa8/wG+DdLVzntpdU/+taateUMnFVgmWCDLzP6ndbYoAzeDKmcPDKmeeZA1t4bR9X9ebtzuhGKqGFxXzKSWjca10iypMlDLV61Zi+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE1uZFkY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso4880304b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094826; x=1747699626; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gkEtbigvAnIv0feEiYLTGDPb1DHH0YnnXWoAGUdhU4=;
        b=JE1uZFkY1OwuVgC1VYNBXsUYU3YXrEXuFrNa+muSqwnkqxos/buMy70sm2+uv8Zx4i
         CNix7Ah2YjEuD2pI6fnHTmFxjbIDqcp6JVF5NuSqktdYDEUJQZ4XMF9chLiZieBJpzWa
         TAsAp1PbiPXsl0/JZSHx6//rNoDlgy1HZkgbsJtHuacPfY6FAdwHes3/3+Bq7CrstuNu
         n0QTdGqhr82DpEcJWSOs0IjBrgLS3o+JmLl1szvyqtCurJ789jOWKiQBufcv4sDRvjju
         Y32f+8lNghBAS94iwAIPDVWrOL1shiauoGolUJWIEpeR7dwW4sPOhmO4tX/tfn0d0L+P
         n1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094826; x=1747699626;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gkEtbigvAnIv0feEiYLTGDPb1DHH0YnnXWoAGUdhU4=;
        b=P3eTxW9eexyBSc2RlBUHBURhFhpFffrL0K5OWYjkIccxdlq9fjHIs6O8sZkdJixoJ3
         BRFtowKm0ooPxdV6zaGyKu7QMMi8JxcyKKpY7dEuED9XV6Tr8+tmaoPJ7cVJIj2+f1ww
         H4d/tZv054uL+Kqi3Stp3iR4F7i05l2goUrqIRmcc9cX3UCWmlLeaxZ+kEBGgKc47tXC
         QaxZiGnMP7rDf9yT/PgBUJeVkASuG9lBlJgEjlgwQKCH0/YFX1EvAOkraYuDLKehwVAD
         P6UrS/ANn8iQkxAgmAquss5qSDhxg95SUdmGbZEgsOR4TfLX7im52O3WegqiGC3h8VxC
         HVkA==
X-Gm-Message-State: AOJu0YxyAcWlvanZzAl2nFmUxG03DuxrnmOVerVy1YPIk4Qhwlbj5tX2
	cAtujyJ1UsYQGp1kHETV2ZnWD0DuOyZMnAFaFyWRD4etjDojgWa1
X-Gm-Gg: ASbGncstoO73YCrpsR62/PVHn1m+mrQKmtegudhxX6xdYMee5HX3CT/ELbVdpUCf6lN
	uu3M+37DVmZ0UhZALwfwU1rHoTkO5eUKbtk49+FnhR8SOryW1bsUrrSEGxHSAfIfwloE2rRzwTJ
	uv+tj8Z+I/aubj3eAAGxCJMbj/h0hucUBNTkNTbvBJP5jm9c/yPAzqjrtIKv6SCrmG0UfKuI486
	sk6juEwSI0jPF+XD7ZwE3W4ctqTqt/tPWYMeGJHATt05Skg6FqRtDU7aiX6fIiRmfpfOFTaHPyK
	Inl0p/3TiQTCnN/EN0bdzAypm/xGBNNAM4CPDsYLEODd2pe/gSLlAPoAriA=
X-Google-Smtp-Source: AGHT+IEF/oNrNKt4NdNrFFzQ8yQjQeOvDWsSXqT866RpAaXmXnh9fX3SnCSjdiGSku1k2/6evE5l3g==
X-Received: by 2002:a05:6a00:8482:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-74278f8ce19mr1374478b3a.2.1747094825824;
        Mon, 12 May 2025 17:07:05 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:10d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8f674sm6619439b3a.168.2025.05.12.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:07:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Raj Sahu <rjsu26@gmail.com>
Cc: bpf@vger.kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,  djwillia@vt.edu,
  miloc@vt.edu,  ericts@vt.edu,  rahult@vt.edu,  doniaghazy@vt.edu,
  quanzhif@vt.edu,  jinghao7@illinois.edu,  sidchintamaneni@gmail.com,
  memxor@gmail.com
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
In-Reply-To: <20250420105524.2115690-4-rjsu26@gmail.com> (Raj Sahu's message
	of "Sun, 20 Apr 2025 06:55:21 -0400")
References: <20250420105524.2115690-1-rjsu26@gmail.com>
	<20250420105524.2115690-4-rjsu26@gmail.com>
Date: Mon, 12 May 2025 17:07:02 -0700
Message-ID: <m27c2l1ihl.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raj Sahu <rjsu26@gmail.com> writes:

[...]

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 380e9a7cac75..e5dceebfb302 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -6,6 +6,7 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/rcupdate_trace.h>
> +#include <asm/unwind.h>
>  
>  struct bpf_iter_target_info {
>  	struct list_head list;
> @@ -775,6 +776,70 @@ const struct bpf_func_proto bpf_loop_proto = {
>  	.arg4_type	= ARG_ANYTHING,
>  };
>  
> +BPF_CALL_4(bpf_loop_termination, u32, nr_loops, void *, callback_fn,
> +		void *, callback_ctx, u64, flags)
> +{
> +	/* Since a patched BPF program for termination will want
> +	 * to finish as fast as possible,
> +	 * we simply don't run any loop in here.
> +	 */
> +
> +	/* Restoring the callee-saved registers and exit.
> +	 * Hacky/ err prone way of restoring the registers.
> +	 * We are figuring out a way to have arch independent
> +	 * way to do this.
> +	 */
> +
> +	asm volatile(
> +	"pop %rbx\n\t"
> +	"pop %rbp\n\t"
> +	"pop %r12\n\t"
> +	"pop %r13\n\t"
> +	);

Why do anything special here?
I'd expect a bpf_loop() version simplified to a single return to work.

> +
> +	return 0;
> +}

[...]

> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[...]

> +
> +static bool find_in_skiplist(int func_id) {

Nit: "skip list" is a name of an (unrelated) data structure,
     maybe disambiguate the name here?

> +	return is_verifier_inlined_function(func_id) ||
> +	       is_debug_function(func_id) ||
> +	       is_resource_release_function(func_id);
> +}
> +
> +static int get_replacement_helper(int func_id, enum bpf_return_type ret_type) {
> +
> +	switch (func_id) {
> +		case BPF_FUNC_loop:
> +			return BPF_FUNC_loop_termination;
> +		case BPF_FUNC_for_each_map_elem:
> +		case BPF_FUNC_user_ringbuf_drain:
> +			return -ENOTSUPP;
> +	}
> +
> +	switch (ret_type) {
> +		case RET_VOID:
> +			return BPF_FUNC_dummy_void;
> +		case RET_INTEGER:
> +			return BPF_FUNC_dummy_int;
> +		case RET_PTR_TO_MAP_VALUE_OR_NULL:
> +			return BPF_FUNC_dummy_ptr_to_map;
> +		case RET_PTR_TO_SOCKET_OR_NULL:
> +		case RET_PTR_TO_TCP_SOCK_OR_NULL:
> +		case RET_PTR_TO_SOCK_COMMON_OR_NULL:
> +		case RET_PTR_TO_RINGBUF_MEM_OR_NULL:
> +		case RET_PTR_TO_DYNPTR_MEM_OR_NULL:
> +		case RET_PTR_TO_BTF_ID_OR_NULL:
> +		case RET_PTR_TO_BTF_ID_TRUSTED:
> +		case RET_PTR_TO_MAP_VALUE:
> +		case RET_PTR_TO_SOCKET:
> +		case RET_PTR_TO_TCP_SOCK:
> +		case RET_PTR_TO_SOCK_COMMON:
> +		case RET_PTR_TO_MEM:
> +		case RET_PTR_TO_MEM_OR_BTF_ID:
> +		case RET_PTR_TO_BTF_ID:

I'm curious what's the plan for RET_PTR_TO_BTF_ID?
verifier.c:check_ptr_tp_btf_access() has the following comment:

  /* By default any pointer obtained from walking a trusted pointer is no
   * longer trusted, unless the field being accessed has explicitly been
   * marked as inheriting its parent's state of trust (either full or RCU).
   * For example:
   * 'cgroups' pointer is untrusted if task->cgroups dereference
   * happened in a sleepable program outside of bpf_rcu_read_lock()
   * section. In a non-sleepable program it's trusted while in RCU CS (aka MEM_RCU).
   * Note bpf_rcu_read_unlock() converts MEM_RCU pointers to PTR_UNTRUSTED.
   *
   * A regular RCU-protected pointer with __rcu tag can also be deemed
   * trusted if we are in an RCU CS. Such pointer can be NULL.
   */

> +		default:
> +			return -ENOTSUPP;
> +	}
> +}
> +
> +static void patch_generator(struct bpf_prog *prog)
> +{
> +	struct call_insn_aux{
> +		int insn_idx;
> +		int replacement_helper;
> +	};
> +
> +	struct call_insn_aux *call_indices;
> +	int num_calls=0;
> +	call_indices = vmalloc(sizeof(call_indices) * prog->len);

clang-tidy spotted a warning here, the expression should be `sizeof(*call_indices)`.

> +
> +	/* Find all call insns */
> +	for(int insn_idx =0 ;insn_idx < prog->len; insn_idx++)
> +	{
> +		struct bpf_insn *insn = &prog->insnsi[insn_idx] ;
> +		u8 class = BPF_CLASS(insn->code);
> +		if (class == BPF_JMP || class == BPF_JMP32) {
> +			if (BPF_OP(insn->code) == BPF_CALL){
> +				if (insn->src_reg == BPF_PSEUDO_CALL) {
> +					continue;
> +				}
> +				if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL){ /*kfunc */
> +					// TODO Need to use btf for getting proto
> +					// If release function --> skip
> +					// If acquire function --> find return type and add to list
> +				}
> +				else {
> +					int func_id = insn->imm;
> +					const struct bpf_func_proto *fn = NULL;
> +					int new_helper_id = -1;
> +
> +					if (find_in_skiplist(func_id)) {
> +						continue;
> +					}
> +
> +					fn = bpf_verifier_ops[prog->type]->get_func_proto(func_id, prog);

Nit: please reuse verifier.c:get_helper_proto() utility function here.

> +					if (!fn && !fn->func) {
> +						continue;
> +					}
> +
> +					new_helper_id = get_replacement_helper(func_id, fn->ret_type);
> +					if (new_helper_id < 0) {
> +						continue;

Nit: propagate error?

> +					}
> +
> +					call_indices[num_calls].insn_idx = insn_idx;
> +					call_indices[num_calls].replacement_helper= new_helper_id;
> +					num_calls++;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Patch all call insns */
> +	for(int k =0; k < num_calls; k++){
> +		prog->insnsi[call_indices[k].insn_idx].imm = call_indices[k].replacement_helper;

Nit: each instruction is visited only once, so it appears that patching
     can be done in-place w/o need for call_indices array.

> +	}
> +}
> +
> +static bool create_termination_prog(struct bpf_prog *prog,
> +					union bpf_attr *attr,
> +					bpfptr_t uattr,
> +					u32 uattr_size)
> +{
> +	if (prog->len < 10)
> +		return false;
> +
> +	int err;
> +	struct bpf_prog *patch_prog;
> +	patch_prog = bpf_prog_alloc_no_stats(bpf_prog_size(prog->len), 0);
> +	if (!patch_prog) {
> +		return false;
> +	}
> +
> +	patch_prog->termination_states->is_termination_prog = true;
> +
> +	err = clone_bpf_prog(patch_prog, prog);
> +	if (err)
> +			goto free_termination_prog;
> +
> +	patch_generator(patch_prog);
> +
> +	err = bpf_check(&patch_prog, attr, uattr, uattr_size);

There might be issues with program verification if bpf_check is called
for a patched program. For example, for a full implementation you'd need
to handle kfuncs, replacing loops like:

  while (bpf_iter_next()) {}

with loops like:

  while (dummy_return_null()) {}

won't work as verifier would assume that the loop is infinite.
In general, check_helper_call, check_kfunc_call and is_state_visited
have logic for specific helpers/kfuncs that modifies verifier state
basing not only on the helper return value type.

What do you plan to do with functions that unconditionally take
resources, e.g. bpf_spin_lock()?

- From verification point of view:
  this function is RET_VOID and is not in
  find_in_skiplist(), patch_generator() would replace its call with a
  dummy. However, a corresponding bpf_spin_unlock() would remain and thus
  bpf_check() will exit with error.
  So, you would need some special version of bpf_check, that collects
  all resources needed for program translation (e.g. maps), but does
  not perform semantic checks.
  Or patch_generator() has to be called for a program that is already
  verified.

- From termination point of view:
  this function cannot be replaced with a dummy w/o removing
  corresponding unlock. Do you plan to leave these as-is?

> +	if (err) {
> +		goto free_termination_prog;
> +	}
> +
> +	patch_prog = bpf_prog_select_runtime(patch_prog, &err);
> +	if (err) {
> +		goto free_termination_prog;
> +	}
> +
> +	prog->termination_states->patch_prog = patch_prog;
> +	return true;
> +
> +free_termination_prog:
> +	free_percpu(patch_prog->stats);
> +	free_percpu(patch_prog->active);
> +	kfree(patch_prog->aux);
> +	return false;


In case of a load failure of the main program bpf_prog_load_load() does
much more cleanup.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54c6953a8b84..57b4fd1f6a72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -22502,7 +22506,14 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
>  	 */
>  	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
>  	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
> -	insn_buf[cnt++] = BPF_CALL_REL(0);
> +
> +	if (termination_states && termination_states->is_termination_prog) {
> +		/* In a termination BPF prog, we want to exit - set R0 = 1 */
> +		insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 1);
> +	} else {
> +		insn_buf[cnt++] = BPF_CALL_REL(0);
> +	}
> +

Q: Do you need 1:1 instruction pointer correspondence between original
   and patched programs?
   Since you patch inlined bpf_loop instead of disallowing inlining in
   the patched program I assume you do. In this case, there is no
   guarantee that instructions above have the same size after jit.

>  	/* increment loop counter */
>  	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
>  	/* jump to loop header if callback returned 0 */

[...]

