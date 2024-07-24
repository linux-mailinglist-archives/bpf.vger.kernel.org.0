Return-Path: <bpf+bounces-35586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE193B9AF
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5371C2370F
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01099146D79;
	Wed, 24 Jul 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iXNoG0Uv"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A73143878
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865487; cv=none; b=WFF9iR2bpI/4FWkLS42ylnoGNWkfaPCKfHxU+vrZWQI5qoSLaE8Vw3EBtXmyMLjaTmGeGwNqeyEhAqkEifMKt+8cJqc8T4osHOWY6QzjhpEImrEzJadAQBbyHNDdyRr5wTYDObDXN918dDKlAWf6qRsCUtIkg+k3NYZ1ImaCk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865487; c=relaxed/simple;
	bh=61ubFr3zjrpd6YXy92yPTIUAqlK/lzMSQRJUlilJ2jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mERUtkXwuGP02yuAV2cOTaiLJTSaW88nJhErh549EQJyh3iwjx2W2nIvFqfwjZ9e6QSI+NwTHhJ6rh7xcahdaEjgIUD8aDz3FJ6j8dpmAAjpUmMATjp3OH4HWyycjoHWWEbi2CLWKkMCl3WxcZBFQdWCL7jOhLtbbk3ZibP42nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iXNoG0Uv; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94e9a21b-676b-47d7-97cd-ccf6e7511c1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721865483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxtaaXkmhkWInuo365av/v9KHm3veguGVoHIRlRhf5g=;
	b=iXNoG0Uv8iQFvCarXxEP0N8sumq/2UTR5mVZQ56t6suaQwPew8pmHUkKKfjPMDTB59OrWk
	kj8nWBYrq0BoaRi1BKkd6oFlawtY9oXTgHhL3illJwJ+PBJuigCH8lSinr7jMhf7tp9xH7
	SWfMYIKSAagpYw7++G5hu3paP0GMrjc=
Date: Wed, 24 Jul 2024 16:57:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return
 referenced kptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-4-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240714175130.4051012-4-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/24 10:51 AM, Amery Hung wrote:
> Allow a struct_ops program to return a referenced kptr if the struct_ops
> operator has pointer to struct as the return type. To make sure the
> returned pointer continues to be valid in the kernel, several
> constraints are required:
> 
> 1) The type of the pointer must matches the return type
> 2) The pointer originally comes from the kernel (not locally allocated)
> 3) The pointer is in its unmodified form
> 
> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
> pointer to be returned when there is no skb to be dequeued, we will allow
> a scalar value with value equals to NULL to be returned.
> 
> In the future when there is a struct_ops user that always expects a valid
> pointer to be returned from an operator, we may extend tagging to the
> return value. We can tell the verifier to only allow NULL pointer return
> if the return value is tagged with MAY_BE_NULL.
> 
> The check is split into two parts since check_reference_leak() happens
> before check_return_code(). We first allow a reference object to leak
> through return if it is in the return register and the type matches the
> return type. Then, we check whether the pointer to-be-returned is valid in
> check_return_code().
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f614ab283c37..e7f356098902 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10188,16 +10188,36 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>   
>   static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
>   {
> +	enum bpf_prog_type type = resolve_prog_type(env->prog);
> +	u32 regno = exception_exit ? BPF_REG_1 : BPF_REG_0;

hmm... Can reg_1 hold a PTR_TO_BTF_ID during bpf_throw()?

Beside, if I read how the current check_reference_leak() handles "exception_exit 
== true" correctly, any leak is a leak. Does it need special handling for 
struct_ops program here when "exception_exit == true"?

> +	struct bpf_reg_state *reg = reg_state(env, regno);
>   	struct bpf_func_state *state = cur_func(env);
> +	const struct bpf_prog *prog = env->prog;
> +	const struct btf_type *ret_type = NULL;
>   	bool refs_lingering = false;
> +	struct btf *btf;
>   	int i;
>   
>   	if (!exception_exit && state->frameno && !state->in_callback_fn)
>   		return 0;
>   
> +	if (type == BPF_PROG_TYPE_STRUCT_OPS &&
> +	    reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
> +		btf = bpf_prog_get_target_btf(prog);
> +		ret_type = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
> +		if (reg->btf_id != ret_type->type) {
> +			verbose(env, "Return kptr type, struct %s, doesn't match function prototype, struct %s\n",
> +				btf_type_name(reg->btf, reg->btf_id),
> +				btf_type_name(btf, ret_type->type));
> +			return -EINVAL;
> +		}
> +	}
> +
>   	for (i = 0; i < state->acquired_refs; i++) {
>   		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
>   			continue;
> +		if (ret_type && reg->ref_obj_id == state->refs[i].id)
> +			continue;
>   		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
>   			state->refs[i].id, state->refs[i].insn_idx);
>   		refs_lingering = true;
> @@ -15677,12 +15697,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>   	const char *exit_ctx = "At program exit";
>   	struct tnum enforce_attach_type_range = tnum_unknown;
>   	const struct bpf_prog *prog = env->prog;
> -	struct bpf_reg_state *reg;
> +	struct bpf_reg_state *reg = reg_state(env, regno);
>   	struct bpf_retval_range range = retval_range(0, 1);
>   	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>   	int err;
>   	struct bpf_func_state *frame = env->cur_state->frame[0];
>   	const bool is_subprog = frame->subprogno;
> +	struct btf *btf = bpf_prog_get_target_btf(prog);
> +	bool st_ops_ret_is_kptr = false;
> +	const struct btf_type *t;
>   
>   	/* LSM and struct_ops func-ptr's return type could be "void" */
>   	if (!is_subprog || frame->in_exception_callback_fn) {
> @@ -15691,10 +15714,26 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>   			if (prog->expected_attach_type == BPF_LSM_CGROUP)
>   				/* See below, can be 0 or 0-1 depending on hook. */
>   				break;
> -			fallthrough;
> +			if (!prog->aux->attach_func_proto->type)
> +				return 0;
> +			break;
>   		case BPF_PROG_TYPE_STRUCT_OPS:
>   			if (!prog->aux->attach_func_proto->type)
>   				return 0;
> +
> +			t = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
> +			if (btf_type_is_ptr(t)) {
> +				/* Allow struct_ops programs to return kptr or null if
> +				 * the return type is a pointer type.
> +				 * check_reference_leak has ensured the returning kptr
> +				 * matches the type of the function prototype and is

It needs to ensure reg->ref_obj_id != 0 also for non-null pointer. Then it can 
rely on the check_reference_leak() for the type checking. I think 
reg->ref_obj_id needs to be checked at here anyway because the prog should not 
return a non-refcounted PTR_TO_BTF_ID ptr.

may be more straightforward (?) to move the type checking from 
check_reference_leak() to check_return_code() here. Leave the 
check_reference_leak() to check for leak and check_return_code() to check for 
the return value/ptr-type.

another thing is....

> +				 * the only leaking reference. Thus, we can safely return
> +				 * if the pointer is in its unmodified form
> +				 */
> +				if (reg->type & PTR_TO_BTF_ID)
> +					return __check_ptr_off_reg(env, reg, regno, false);
> +				st_ops_ret_is_kptr = true;
> +			}
>   			break;
>   		default:
>   			break;
> @@ -15716,8 +15755,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>   		return -EACCES;
>   	}
>   
> -	reg = cur_regs(env) + regno;
> -
>   	if (frame->in_async_callback_fn) {
>   		/* enforce return zero from async callbacks like timer */
>   		exit_ctx = "At async callback return";
> @@ -15804,6 +15841,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>   	case BPF_PROG_TYPE_NETFILTER:
>   		range = retval_range(NF_DROP, NF_ACCEPT);
>   		break;
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		if (!st_ops_ret_is_kptr)

... can the changes added earlier in this function be done here together instead 
of gluing by "st_ops_ret_is_kptr"?

> +			return 0;
> +		range = retval_range(0, 0);
> +		break;
>   	case BPF_PROG_TYPE_EXT:
>   		/* freplace program can return anything as its return value
>   		 * depends on the to-be-replaced kernel func or bpf program.


