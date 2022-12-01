Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8863EA1C
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLAHGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 02:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLAHGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 02:06:02 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08958DFD4
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 23:05:59 -0800 (PST)
Message-ID: <d46efd51-e6f5-dbb5-ab38-238b6d2ea314@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669878358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KSbVxa9fS5aBURbJbuUoITW8arY0T1CIEbrktS2+BU=;
        b=IYonLZMcpgfUb0ZjPBMbAs77UILRWJnH38aSqCMXXmhpMoHc7voL5ttVxBWyJMZn3CfSBr
        rwH0P5JvzhgraNmcwFRAfQH/iVA1Ku6vqLOK7IP5GpJZ2+yimwHPLZk2EeOMia53uACqmf
        3wNjKZpBGw8Mur5AxxAIKHogjjAwXxI=
Date:   Wed, 30 Nov 2022 23:05:53 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Handle MEM_RCU type properly
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221129023713.2216451-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221129023713.2216451-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/28/22 6:37 PM, Yonghong Song wrote:
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c05aa6e1f6f5..6f192dd9025e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -683,7 +683,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
>   	}
>   }
>   
> -#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
> +#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)

[ ... ]

> +static bool is_rcu_reg(const struct bpf_reg_state *reg)
> +{
> +	return reg->type & MEM_RCU;
> +}
> +
>   static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
>   				   const struct bpf_reg_state *reg,
>   				   int off, int size, bool strict)
> @@ -4775,12 +4780,10 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>   		/* Mark value register as MEM_RCU only if it is protected by
>   		 * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
>   		 * itself can already indicate trustedness inside the rcu
> -		 * read lock region. Also mark it as PTR_TRUSTED.
> +		 * read lock region.
>   		 */
>   		if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
>   			flag &= ~MEM_RCU;

How about dereferencing a PTR_TO_BTF_ID | MEM_RCU, like:

	/* parent: PTR_TO_BTF_ID | MEM_RCU */
	parent = current->real_parent;
	/* gparent: PTR_TO_BTF_ID */
	gparent = parent->real_parent;

Should "gparent" have MEM_RCU also?

Also, should PTR_MAYBE_NULL be added to "parent"?
	
> -		else
> -			flag |= PTR_TRUSTED;
>   	} else if (reg->type & MEM_RCU) {
>   		/* ptr (reg) is marked as MEM_RCU, but the struct field is not tagged
>   		 * with __rcu. Mark the flag as PTR_UNTRUSTED conservatively.
> @@ -5945,7 +5948,7 @@ static const struct bpf_reg_types btf_ptr_types = {
>   	.types = {
>   		PTR_TO_BTF_ID,
>   		PTR_TO_BTF_ID | PTR_TRUSTED,
> -		PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
> +		PTR_TO_BTF_ID | MEM_RCU,
>   	},
>   };
>   static const struct bpf_reg_types percpu_btf_ptr_types = {
> @@ -6124,7 +6127,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>   	case PTR_TO_BTF_ID:
>   	case PTR_TO_BTF_ID | MEM_ALLOC:
>   	case PTR_TO_BTF_ID | PTR_TRUSTED:
> -	case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
> +	case PTR_TO_BTF_ID | MEM_RCU:
>   	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
>   		/* When referenced PTR_TO_BTF_ID is passed to release function,
>   		 * it's fixed offset must be 0.	In the other cases, fixed offset
> @@ -8022,6 +8025,11 @@ static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
>   	return meta->kfunc_flags & KF_DESTRUCTIVE;
>   }
>   
> +static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_RCU;
> +}
> +
>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>   {
>   	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> @@ -8706,13 +8714,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   		switch (kf_arg_type) {
>   		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>   		case KF_ARG_PTR_TO_BTF_ID:
> -			if (!is_kfunc_trusted_args(meta))
> +			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
>   				break;
>   
> -			if (!is_trusted_reg(reg)) {
> -				verbose(env, "R%d must be referenced or trusted\n", regno);
> +			if (!is_trusted_reg(reg) && !is_rcu_reg(reg)) {
> +				verbose(env, "R%d must be referenced, trusted or rcu\n", regno);
>   				return -EINVAL;
>   			}
> +
> +			if (is_kfunc_rcu(meta) != is_rcu_reg(reg)) {

I think is_trusted_reg(reg) should also be acceptable to bpf_task_acquire_rcu().

nit. bpf_task_acquire_not_zero() may be a better kfunc name.

> +				verbose(env, "R%d does not match kf arg rcu tagging\n", regno);
> +				return -EINVAL;
> +			}
> +
>   			fallthrough;
>   		case KF_ARG_PTR_TO_CTX:
>   			/* Trusted arguments have the same offset checks as release arguments */
> @@ -8823,7 +8837,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>   		case KF_ARG_PTR_TO_BTF_ID:
>   			/* Only base_type is checked, further checks are done here */
>   			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
> -			     bpf_type_has_unsafe_modifiers(reg->type)) &&
> +			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
>   			    !reg2btf_ids[base_type(reg->type)]) {
>   				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
>   				verbose(env, "expected %s or socket\n",
> @@ -8938,7 +8952,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   		} else if (rcu_unlock) {
>   			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>   				if (reg->type & MEM_RCU) {
> -					reg->type &= ~(MEM_RCU | PTR_TRUSTED);
> +					reg->type &= ~MEM_RCU;
>   					reg->type |= PTR_UNTRUSTED;
>   				}
>   			}));
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> index 973f0c5af965..5fbd9edd2c4c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> @@ -93,10 +93,10 @@ static struct {
>   	const char *prog_name;
>   	const char *expected_err_msg;
>   } failure_tests[] = {
> -	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
> +	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced, trusted or rcu"},
>   	{"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must point"},
>   	{"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
> -	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
> +	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced, trusted or rcu"},
>   	{"cgrp_kfunc_acquire_null", "arg#0 pointer type STRUCT cgroup must point"},
>   	{"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
>   	{"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> index ffd8ef4303c8..80708c073de6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -87,10 +87,10 @@ static struct {
>   	const char *prog_name;
>   	const char *expected_err_msg;
>   } failure_tests[] = {
> -	{"task_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
> +	{"task_kfunc_acquire_untrusted", "R1 must be referenced, trusted or rcu"},
>   	{"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct must point"},
>   	{"task_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
> -	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
> +	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced, trusted or rcu"},

hmm... why this description is changed here?  The bpf_task_acquire kfunc-flags 
has not changed.

