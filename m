Return-Path: <bpf+bounces-35475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F293AC43
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 07:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162601C20D3D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D34317C;
	Wed, 24 Jul 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsntqv8k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390884C84;
	Wed, 24 Jul 2024 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799414; cv=none; b=NT+1HTGaBv5Bo0SFf8AdEBrSunwaI13fQObHpvqI5UqgX27XiFqO4aZly/oBp9tDeAJoaz2EsJHXnoXy0tCKjY8ud2Lc5EHkJACS1S1fI/sGAKxqPUaoNs0QgTzlktvehbRkvlHf7lNwzNfoPkSzTuzsG5t6unIz0b10HcWUl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799414; c=relaxed/simple;
	bh=cnIyFsZw1Kq2xHCk+ElHjucMXcuOLmlOO02U6oJfZiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qypbJQLm8p2+9LCgoTC6Q0ihToQoe0g/jF6N0QOB0JJpWop5CRjcaA7Ag3VkhJAaek1ml1dSPag0nNRJ3rlJyRnXbDQwo5tOrWTsrVRg4sM9G0RH1CJ83N/T1LmbRPwfAOz2b78hIC3mU6FmMrh0o/ZGYF2NJzt1aFVyVOJDRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsntqv8k; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e05f913e382so5689954276.2;
        Tue, 23 Jul 2024 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721799412; x=1722404212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBwqzrVykvJCx7DmRUdqofSbQrKIL1dtus8MSt/lBJI=;
        b=Jsntqv8kwIWRY9qTwAhAdxSkmNL1pNTsfaljFtdRGalFg4bbLKtpE+vE8pry+odDif
         ARdTTEPaYrHMCZ3hEsdt4oCb/LQ9qEd4LZV4ZJ2rodNUp9khP/d7NJZYETKDpL8eESmr
         7LWwq7qyCx/hBQfemyBQNDV/MUZfztiBy4jaaUVBs0FpmskbkigszRslRH77WQ+VkBNp
         SrH2YseLnseMCRmg4JkGeMO9iamG07ke4qSU9oVuL5ckbr1ScqJC54Drlr4bkzBZK0D2
         PWfB+3IYEJGUYof1YXTyBPdAV1dmi60Zmt2gx0Igc2SELx8Ws6S3pJ4MzhTyp7/ylI6+
         aNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721799412; x=1722404212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBwqzrVykvJCx7DmRUdqofSbQrKIL1dtus8MSt/lBJI=;
        b=IAt6le9RX471V22pFyzHwbZ9iIjUVQYn7771OgxhyYbi1fHMmZn4wQHUjDhlF6pvJl
         KqJEvNTUpMoZ280+MHnzxRGWxWxRwfdVj7laDcRl+g2KvLDudR5XgnQRLAjMjuiEmI59
         8G31uyB8EhJZ+ivRdE9AgjtB1af5HpztYq35ZS33l3T+vU8gGj7pX8irrZ3V0cLDUW+/
         qUh64B3jVk6cEprxYYSZR4eVC6bbxjReGD+S1PiW5Q5UK2EnFiJdmckQjaDnRzMHeyg9
         RbAPMx2alQht1pV8XJNsyto7v9M/t7xMT+qIuWisLik/0BXb9irF1YvyP8qebZr5cREL
         zZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHAmq0ITYSo67n8y3PTgF1xNZ8s5cze7ONhL+ez9gmOswHVZupkWxtJc1qRl0bi5AFUSxC5pIws9yIF/2iVFeKI5eb0EKM
X-Gm-Message-State: AOJu0Yw1RJf52tAg/FXUCzdHxI2JU1vPy/gokXX0O0O4iqCjvCigw3Kd
	hor9UEFDweX5s5oua3dJAei0OitV41ANG4QvleFlMy5rIS62GptP
X-Google-Smtp-Source: AGHT+IHzcdBpPq/38a5fu6f6o84QlYErnyi72rveIVY80T+K4uJGu5jL88K65Oq0Y3pbRTLEBl18DQ==
X-Received: by 2002:a05:6902:150a:b0:e08:726a:5a93 with SMTP id 3f1490d57ef6-e087b9bd2a5mr15535416276.44.1721799412115;
        Tue, 23 Jul 2024 22:36:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8343:a788:55dc:60a4? ([2600:1700:6cf8:1240:8343:a788:55dc:60a4])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e08609ab341sm2271732276.19.2024.07.23.22.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 22:36:51 -0700 (PDT)
Message-ID: <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
Date: Tue, 23 Jul 2024 22:36:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return
 referenced kptr
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-4-amery.hung@bytedance.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240714175130.4051012-4-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/14/24 10:51, Amery Hung wrote:
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

Is it possible having two kptrs that both are in the returned type
passing into a function?


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
> +			return 0;
> +		range = retval_range(0, 0);
> +		break;
>   	case BPF_PROG_TYPE_EXT:
>   		/* freplace program can return anything as its return value
>   		 * depends on the to-be-replaced kernel func or bpf program.

