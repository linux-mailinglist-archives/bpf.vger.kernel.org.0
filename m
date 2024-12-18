Return-Path: <bpf+bounces-47158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864289F5BFA
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629A47A1A81
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7735941;
	Wed, 18 Dec 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W35aPu4P"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288528691
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483505; cv=none; b=Y3Sk014whKhenBphRrFJg+2qruI+RBe3EbE3A32S5rUDvuY6mkM6kULlCkmztUkk99zepA31vYoBps2fv9jen7HTmjFWRCwEdAXLseLUwGpiY2h3v8AHF19AHrP+TNa6kvAS8LpxI5bMT9R0eR2bfSbG7MCJ+VPWolb16Y9s3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483505; c=relaxed/simple;
	bh=ojGfl5SHibUvpLfRcRApihK5waB7qEav9L64FtsMlA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sv9ZdiNfgTyfEzhkjA8ZTy/bWxwOwjon+wYv2e138irjEImbISi6PsYz9kAus2z4G3Snbwk9mOgZwLROrqnnipIOucPwISgrW++/js4dLOKRJbTXdRHp8OztjzLfDcftFptAZMajAGtobQkcEUaJWD4w7q0xoGIuohOkXhmHnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W35aPu4P; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734483500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mc4ji3tVzdyWxvyeLwYeLMPx8IVQdD8BScnBye2t3o=;
	b=W35aPu4PAjAPkqF+Y8dQS4DlJ1ZykeUx4dLhI6s7kcawgmBgDji2YW3IjK+VIaH2j8eBdq
	jDNE3MMQvDzMGKtfZKDU63Wr0TXxIEUSCMyT16KVNowMb6TUPPG6pJSXrjhFH1E93U4TC1
	LoA1LXFSx6dXgp1PnBj0LqNEde/Z4yM=
Date: Tue, 17 Dec 2024 16:58:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr
 from struct_ops argument
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-2-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241213232958.2388301-2-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 3:29 PM, Amery Hung wrote:
> Allows struct_ops programs to acqurie referenced kptrs from arguments
> by directly reading the argument.
> 
> The verifier will acquire a reference for struct_ops a argument tagged
> with "__ref" in the stub function in the beginning of the main program.
> The user will be able to access the referenced kptr directly by reading
> the context as long as it has not been released by the program.
> 
> This new mechanism to acquire referenced kptr (compared to the existing
> "kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reasons.
> In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
> first argument. This mechanism provides a natural way for users to get a
> referenced kptr in the .enqueue struct_ops programs and makes sure that a
> qdisc will always enqueue or drop the skb.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   include/linux/bpf.h         |  3 +++
>   kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
>   kernel/bpf/btf.c            |  1 +
>   kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++---
>   4 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1b84613b10ac..72bf941d1daf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -968,6 +968,7 @@ struct bpf_insn_access_aux {
>   		struct {
>   			struct btf *btf;
>   			u32 btf_id;
> +			u32 ref_obj_id;
>   		};
>   	};
>   	struct bpf_verifier_log *log; /* for verbose logs */
> @@ -1480,6 +1481,8 @@ struct bpf_ctx_arg_aux {
>   	enum bpf_reg_type reg_type;
>   	struct btf *btf;
>   	u32 btf_id;
> +	u32 ref_obj_id;
> +	bool refcounted;
>   };
>   
>   struct btf_mod_pair {
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fda3dd2ee984..6e7795744f6a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -145,6 +145,7 @@ void bpf_struct_ops_image_free(void *image)
>   }
>   
>   #define MAYBE_NULL_SUFFIX "__nullable"
> +#define REFCOUNTED_SUFFIX "__ref"
>   #define MAX_STUB_NAME 128
>   
>   /* Return the type info of a stub function, if it exists.
> @@ -206,9 +207,11 @@ static int prepare_arg_info(struct btf *btf,
>   			    struct bpf_struct_ops_arg_info *arg_info)
>   {
>   	const struct btf_type *stub_func_proto, *pointed_type;
> +	bool is_nullable = false, is_refcounted = false;
>   	const struct btf_param *stub_args, *args;
>   	struct bpf_ctx_arg_aux *info, *info_buf;
>   	u32 nargs, arg_no, info_cnt = 0;
> +	const char *suffix;
>   	u32 arg_btf_id;
>   	int offset;
>   
> @@ -240,12 +243,19 @@ static int prepare_arg_info(struct btf *btf,
>   	info = info_buf;
>   	for (arg_no = 0; arg_no < nargs; arg_no++) {
>   		/* Skip arguments that is not suffixed with
> -		 * "__nullable".
> +		 * "__nullable or __ref".
>   		 */
> -		if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> -					    MAYBE_NULL_SUFFIX))
> +		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
> +						     MAYBE_NULL_SUFFIX);
> +		is_refcounted = btf_param_match_suffix(btf, &stub_args[arg_no],
> +						       REFCOUNTED_SUFFIX);
> +		if (!is_nullable && !is_refcounted)
>   			continue;
>   
> +		if (is_nullable)
> +			suffix = MAYBE_NULL_SUFFIX;
> +		else if (is_refcounted)
> +			suffix = REFCOUNTED_SUFFIX;
>   		/* Should be a pointer to struct */
>   		pointed_type = btf_type_resolve_ptr(btf,
>   						    args[arg_no].type,
> @@ -253,7 +263,7 @@ static int prepare_arg_info(struct btf *btf,
>   		if (!pointed_type ||
>   		    !btf_type_is_struct(pointed_type)) {
>   			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
> -				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
> +				st_ops_name, member_name, suffix);
>   			goto err_out;
>   		}
>   
> @@ -271,11 +281,15 @@ static int prepare_arg_info(struct btf *btf,
>   		}
>   
>   		/* Fill the information of the new argument */
> -		info->reg_type =
> -			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
>   		info->btf_id = arg_btf_id;
>   		info->btf = btf;
>   		info->offset = offset;
> +		if (is_nullable) {
> +			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> +		} else if (is_refcounted) {
> +			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
> +			info->refcounted = true;
> +		}
>   
>   		info++;
>   		info_cnt++;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e7a59e6462a9..a05ccf9ee032 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6580,6 +6580,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>   			info->reg_type = ctx_arg_info->reg_type;
>   			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
>   			info->btf_id = ctx_arg_info->btf_id;
> +			info->ref_obj_id = ctx_arg_info->ref_obj_id;
>   			return true;
>   		}
>   	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9f5de8d4fbd0..69753096075f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1402,6 +1402,17 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
>   	return -EINVAL;
>   }
>   
> +static bool find_reference_state(struct bpf_func_state *state, int ptr_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < state->acquired_refs; i++)
> +		if (state->refs[i].id == ptr_id)
> +			return true;
> +
> +	return false;
> +}
> +
>   static int release_lock_state(struct bpf_func_state *state, int type, int id, void *ptr)
>   {
>   	int i, last_idx;
> @@ -5798,7 +5809,8 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
>   /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
>   static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
>   			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
> -			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
> +			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx,
> +			    u32 *ref_obj_id)
>   {
>   	struct bpf_insn_access_aux info = {
>   		.reg_type = *reg_type,
> @@ -5820,8 +5832,16 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
>   		*is_retval = info.is_retval;
>   
>   		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
> +			if (info.ref_obj_id &&
> +			    !find_reference_state(cur_func(env), info.ref_obj_id)) {
> +				verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n",
> +					off);
> +				return -EACCES;
> +			}
> +
>   			*btf = info.btf;
>   			*btf_id = info.btf_id;
> +			*ref_obj_id = info.ref_obj_id;
>   		} else {
>   			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
>   		}
> @@ -7135,7 +7155,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>   		struct bpf_retval_range range;
>   		enum bpf_reg_type reg_type = SCALAR_VALUE;
>   		struct btf *btf = NULL;
> -		u32 btf_id = 0;
> +		u32 btf_id = 0, ref_obj_id = 0;
>   
>   		if (t == BPF_WRITE && value_regno >= 0 &&
>   		    is_pointer_value(env, value_regno)) {
> @@ -7148,7 +7168,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>   			return err;
>   
>   		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
> -				       &btf_id, &is_retval, is_ldsx);
> +				       &btf_id, &is_retval, is_ldsx, &ref_obj_id);
>   		if (err)
>   			verbose_linfo(env, insn_idx, "; ");
>   		if (!err && t == BPF_READ && value_regno >= 0) {
> @@ -7179,6 +7199,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>   				if (base_type(reg_type) == PTR_TO_BTF_ID) {
>   					regs[value_regno].btf = btf;
>   					regs[value_regno].btf_id = btf_id;
> +					regs[value_regno].ref_obj_id = ref_obj_id;
>   				}
>   			}
>   			regs[value_regno].type = reg_type;
> @@ -21662,6 +21683,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>   {
>   	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
>   	struct bpf_subprog_info *sub = subprog_info(env, subprog);
> +	struct bpf_ctx_arg_aux *ctx_arg_info;
>   	struct bpf_verifier_state *state;
>   	struct bpf_reg_state *regs;
>   	int ret, i;
> @@ -21769,6 +21791,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>   		mark_reg_known_zero(env, regs, BPF_REG_1);
>   	}
>   
> +	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> +		ctx_arg_info = (struct bpf_ctx_arg_aux *)env->prog->aux->ctx_arg_info;
> +		for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
> +			if (ctx_arg_info[i].refcounted)
> +				ctx_arg_info[i].ref_obj_id = acquire_reference_state(env, 0);

There is a conflict in the bpf-next/master. acquire_reference_state has been 
refactored in commit 769b0f1c8214. From looking at the net/sched/sch_*.c 
changes, they should not have conflict with the net-next/main. I would suggest 
to rebase this set on bpf-next/master.

At the first glance, the ref_obj_id assignment looks racy because ctx_arg_info 
is shared by different bpf progs that may be verified in parallel. After another 
thought, this should be fine because it should always end up having the same 
ref_obj_id for the same arg-no, right? Not sure if UBSAN can understand this 
without using the READ/WRITE_ONCE. but adding READ/WRITE_ONCE when using 
ref_obj_id will be quite puzzling when reading the verifier code. Any better idea?

Other than the subprog, afaik, the bpf prog triggered by the bpf_tail_call can 
also take the 'u64 *ctx' array. May be disallow using tailcall in all ops in the 
bpf qdisc. env->subprog_info[i].has_tail_call has already tracked whether the 
tail_call is used.

> +	}
> +
>   	ret = do_check(env);
>   out:
>   	/* check for NULL is necessary, since cur_state can be freed inside


