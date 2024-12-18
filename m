Return-Path: <bpf+bounces-47279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C143B9F7005
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 23:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BDC16B27E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417A1FC11C;
	Wed, 18 Dec 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D53o4+xX"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47B17A586
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560993; cv=none; b=nsPOf/3CYVUsn0U6MIR04xuIPt2RdgWVFE2opz3HAGd6BGBxZYbhwLsFq9X/qRvjGJdegf3UqcobcKpgMYPlQczAjEQFhF8oC02yksXsI0XPtu5TKNB6foWmxWPCK6CsRymuxLn+MOiduSSH1OllbzrHYaaWic5K4RWELeIGxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560993; c=relaxed/simple;
	bh=JFR8+kseyLJhd//6WbvbJrjsSIRftpdG948dnZ4pFhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJT9WYfdYf682pa5DxsJjAycx28dzeIqbPvJjkw9M39OgcJ4U5eBKxgnTslCLJgjabJtZD9sv2Sad/gF6O3jGqzTO5WzfK8rYRxd2xSqUePG0LpsP9UtCifMlaryqKCVaGk5vgd3qz/dXp7hsVblxeqz4dH7Zua74mI+J4wCYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D53o4+xX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f857105-3f75-47ea-934c-129289b475e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734560988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fp3yqO3IL8VYELA0A+BT5pptYQygYQEOLe1XbCoS9I=;
	b=D53o4+xXIbwbguaCU59Nssxarqhw7xwkizHCRrBCTGmRl3FOy0jbEzn0WHsqi1eD/qE/if
	dq81R2M9R4A22XfxWovEm1oqYj+NW/gIH3sz/qXRqtpJ+Ytndho5rzQ0dr9k4xKqQQCjBU
	kPq4bbAo5IqW3JwGTNenRjhO4CeryVY=
Date: Wed, 18 Dec 2024 14:29:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 03/13] bpf: Allow struct_ops prog to return
 referenced kptr
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-4-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241213232958.2388301-4-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 3:29 PM, Amery Hung wrote:
> @@ -15993,13 +16001,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
>   	bool return_32bit = false;
> +	struct btf *btf = bpf_prog_get_target_btf(prog);
> +	const struct btf_type *ret_type = NULL;
>   
>   	/* LSM and struct_ops func-ptr's return type could be "void" */
>   	if (!is_subprog || frame->in_exception_callback_fn) {
> @@ -16008,10 +16018,31 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
> +			if (frame->in_exception_callback_fn)
> +				break;
> +
> +			/* Allow a struct_ops program to return a referenced kptr if it
> +			 * matches the operator's return type and is in its unmodified
> +			 * form. A scalar zero (i.e., a null pointer) is also allowed.
> +			 */
> +			ret_type = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
> +			if (btf_type_is_ptr(ret_type) && reg->type & PTR_TO_BTF_ID &&

The "reg->type & PTR_TO_BTF_ID" does not look right. It should be 
"base_type(reg->type) == PTR_TO_BTF_ID".

> +			    reg->ref_obj_id) {
> +				if (reg->btf_id != ret_type->type) {

reg->btf could be a bpf prog's btf (i.e. prog->aux->btf) instead of the kernel 
btf, so only comparing btf_id here is not very correct.

One way could be to first compare the reg->btf == prog->aux->attach_btf.
prog->aux->attach_btf here must be a kernel btf.

Another way is, btf_type_resolve_ptr() should be a better helper than 
btf_type_by_id() here. It only returns non NULL if the type is a pointer and 
also skips the modifiers like "const" before returning. Then it can directly
compare the "struct btf_type *" returned by 
'btf_type_resolve_ptr(prog->aux->attach_btf, prog->aux->attach_func_proto->type, 
NULL)' and 'btf_type_resolve_ptr(reg->btf, reg->btf_id, NULL)'

May as well enforce the pointer returned by an "ops" must be a struct (i.e. 
__btf_type_is_struct(t) == true). This enforcement can be done in 
bpf_struct_ops_desc_init().



> +					verbose(env, "Return kptr type, struct %s, doesn't match function prototype, struct %s\n",
> +						btf_type_name(reg->btf, reg->btf_id),
> +						btf_type_name(btf, ret_type->type));
> +					return -EINVAL;
> +				}
> +				return __check_ptr_off_reg(env, reg, regno, false);
> +			}
>   			break;
>   		default:
>   			break;
> @@ -16033,8 +16064,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>   		return -EACCES;
>   	}
>   
> -	reg = cur_regs(env) + regno;
> -
>   	if (frame->in_async_callback_fn) {
>   		/* enforce return zero from async callbacks like timer */
>   		exit_ctx = "At async callback return";
> @@ -16133,6 +16162,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>   	case BPF_PROG_TYPE_NETFILTER:
>   		range = retval_range(NF_DROP, NF_ACCEPT);
>   		break;
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		if (!ret_type || !btf_type_is_ptr(ret_type))
> +			return 0;
> +		range = retval_range(0, 0);
> +		break;
>   	case BPF_PROG_TYPE_EXT:
>   		/* freplace program can return anything as its return value
>   		 * depends on the to-be-replaced kernel func or bpf program.


