Return-Path: <bpf+bounces-8206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B53783804
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 04:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8AA280F0F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40721111F;
	Tue, 22 Aug 2023 02:37:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D17F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 02:37:33 +0000 (UTC)
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [IPv6:2001:41d0:1004:224b::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49951DB
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:37:32 -0700 (PDT)
Message-ID: <fafb9664-2473-1993-ea0d-4e4228f32c7b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692671850; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoRI/BqS2sTcItc+Iwy7Szi2M9Lr+00S851MrOeiuXY=;
	b=u4FDjbRwMAV/cbzsNL+NEPqNOYjrFeyYl6tQtlwwv5QBCgaK9OJgQtEiHHN19vp7zK3Ixe
	jkRt/qXwqOwiMv0llbVvX9HvHL8lvr2I6cB2kAMbvA6UIXvwF+6/Enjb3z7RdLUQU2eChW
	G9AUjE2BIPTEmzm6AOewqPI+mMWuM8w=
Date: Mon, 21 Aug 2023 19:37:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 5/7] bpf: Consider non-owning refs to
 refcounted nodes RCU protected
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-6-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821193311.3290257-6-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> An earlier patch in the series ensures that the underlying memory of
> nodes with bpf_refcount - which can have multiple owners - is not reused
> until RCU grace period has elapsed. This prevents
> use-after-free with non-owning references that may point to
> recently-freed memory. While RCU read lock is held, it's safe to
> dereference such a non-owning ref, as by definition RCU GP couldn't have
> elapsed and therefore underlying memory couldn't have been reused.
> 
>  From the perspective of verifier "trustedness" non-owning refs to
> refcounted nodes are now trusted only in RCU CS and therefore should no
> longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
> MEM_RCU in order to reflect this new state.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/linux/bpf.h   |  3 ++-
>   kernel/bpf/verifier.c | 13 ++++++++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eced6400f778..12596af59c00 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -653,7 +653,8 @@ enum bpf_type_flag {
>   	MEM_RCU			= BIT(13 + BPF_BASE_TYPE_BITS),
>   
>   	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
> -	 * Currently only valid for linked-list and rbtree nodes.
> +	 * Currently only valid for linked-list and rbtree nodes. If the nodes
> +	 * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
>   	 */
>   	NON_OWN_REF		= BIT(14 + BPF_BASE_TYPE_BITS),
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8db0afa5985c..55607ab30522 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8013,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>   	case PTR_TO_BTF_ID | PTR_TRUSTED:
>   	case PTR_TO_BTF_ID | MEM_RCU:
>   	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
>   		/* When referenced PTR_TO_BTF_ID is passed to release function,
>   		 * its fixed offset must be 0. In the other cases, fixed offset
>   		 * can be non-zero. This was already checked above. So pass
> @@ -10479,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
>   static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>   {
>   	struct bpf_verifier_state *state = env->cur_state;
> +	struct btf_record *rec = reg_btf_record(reg);
>   
>   	if (!state->active_lock.ptr) {
>   		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
> @@ -10491,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
>   	}
>   
>   	reg->type |= NON_OWN_REF;
> +	if (rec->refcount_off >= 0)
> +		reg->type |= MEM_RCU;

Should the above MEM_RCU marking be done unless reg access is in
rcu critical section?

I think we still have issues for state resetting
with bpf_spin_unlock() and bpf_rcu_read_unlock(), both of which
will try to convert the reg state to PTR_UNTRUSTED.

Let us say reg state is
   PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU

(1). If hitting bpf_spin_unlock(), since MEM_RCU is in
the reg state, the state should become
   PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU
some additional code might be needed so we wont have
verifier complaints about ref_obj_id == 0.

(2). If hitting bpf_rcu_read_unlock(), the state should become
   PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
since register access still in bpf_spin_lock() region.

Does this make sense?

> +
>   	return 0;
>   }
>   
> @@ -11328,6 +11333,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   		struct bpf_func_state *state;
>   		struct bpf_reg_state *reg;
>   
> +		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
> +			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
> +			return -EACCES;
> +		}
> +
>   		if (rcu_lock) {
>   			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>   			return -EINVAL;
> @@ -16689,7 +16699,8 @@ static int do_check(struct bpf_verifier_env *env)
>   					return -EINVAL;
>   				}
>   
> -				if (env->cur_state->active_rcu_lock) {
> +				if (env->cur_state->active_rcu_lock &&
> +				    !in_rbtree_lock_required_cb(env)) {
>   					verbose(env, "bpf_rcu_read_unlock is missing\n");
>   					return -EINVAL;
>   				}

