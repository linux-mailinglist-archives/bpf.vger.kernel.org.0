Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360AF572971
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 00:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiGLWoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGLWoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 18:44:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C73C9941
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:44:03 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c21-20020a624e15000000b0052abf43401fso2710528pfb.14
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FaKQPtmqnXhPYDCHaET65+Vo7EO7FxaawECjEm7R0Ps=;
        b=X/0m3KvGYaK4X9G0SpyN4O9/1/6pGOtrnrEROVw+j+GPaWR04xVPXmWiE5lj/NXP1m
         cPd8WHGHsLkpp7saDau0tiVa+i4aa+BLR1iMfnaN3LrxhYIE993LlqwjwTHnpvlMQ+er
         HKrb7kTIb+odjDs6FtZQfolxqoAkXZKTZOkOLGLbEaMgTBQkJUwB5o46U83Qmw5GKqFT
         Qmn9x0Uiuzr10kF+jw3XfR1q8YG7VmYGjbLDeJe6TTyJAeaEbroIVVyt/HXzuOw1RCiv
         KoyB6ubGLdKPX1mdpTWLfO429hiIEHrDFrZkCXobrnZxMU3UAGxWy9PwwOMhpwVZ5NSD
         kTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FaKQPtmqnXhPYDCHaET65+Vo7EO7FxaawECjEm7R0Ps=;
        b=MXWtU7yOL2SBRP15SOzD4/G0ttS3NjY2/KATHuUHNjAgZcW3VwvxVMmqp2sRbMkbu1
         Ok1BxkXcIPgNkMI5V8AblsJfT2LUepA6kDX4QoJnjQ6SiBUSuTsRrtsrcadY1O4kGUAm
         BmDLkVEV2kO8VX4cQhk37BBv1eflO0CE+HN/s/FNboAPNjl4eSaPCt9LlELBspbhAFkp
         vOgkDOef3JTAtvC492N3qwW/Rvp/6pIxtNjWhOI7XfvNnNQ+lK5sgRIlB9ZovfZFaOWO
         4V9r8W89U1J6u7FnDPbmW/Gkkv92jgpAus8gNiuXYt7oprCMAHPSzUsyV6tjpuECfLZI
         vyFA==
X-Gm-Message-State: AJIora+QdzQtNqRPmUmVsdErjlPg7MDMd4n0qiQxivonh6+u/usUbCVk
        2bJZMLNlZNKBE/oBhLVmAaWTotw=
X-Google-Smtp-Source: AGRyM1sskz0gB2neFVGU7prWVit/Ckh6LyGik7SEdoGlkvyaliCYT3zYgaVO89hMQ3rwkgvmCF6PvaA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:778c:b0:16a:6cd5:469f with SMTP id
 o12-20020a170902778c00b0016a6cd5469fmr198183pll.102.1657665842876; Tue, 12
 Jul 2022 15:44:02 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:44:01 -0700
In-Reply-To: <20220712210603.123791-1-joannelkoong@gmail.com>
Message-Id: <Ys35McCz+TZEdorp@google.com>
Mime-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
From:   sdf@google.com
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/12, Joanne Koong wrote:
> This patch does two things:

> 1. For matching against the arg type, the match should be against the
> base type of the arg type, since the arg type can have different
> bpf_type_flags set on it.

Does this need a fixes tag? Something around the following maybe:

Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")

?

> 2. Uses switch casing to improve readability + efficiency.

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++------------------
>   1 file changed, 38 insertions(+), 28 deletions(-)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 328cfab3af60..26e7e787c20a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5533,17 +5533,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type  
> type)
>   	       type == ARG_CONST_SIZE_OR_ZERO;
>   }

> -static bool arg_type_is_alloc_size(enum bpf_arg_type type)
> -{
> -	return type == ARG_CONST_ALLOC_SIZE_OR_ZERO;
> -}
> -
> -static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> -{
> -	return type == ARG_PTR_TO_INT ||
> -	       type == ARG_PTR_TO_LONG;
> -}
> -
>   static bool arg_type_is_release(enum bpf_arg_type type)
>   {
>   	return type & OBJ_RELEASE;
> @@ -5929,7 +5918,8 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   		meta->ref_obj_id = reg->ref_obj_id;
>   	}

> -	if (arg_type == ARG_CONST_MAP_PTR) {
> +	switch (base_type(arg_type)) {
> +	case ARG_CONST_MAP_PTR:
>   		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
>   		if (meta->map_ptr) {
>   			/* Use map_uid (which is unique id of inner map) to reject:
> @@ -5954,7 +5944,8 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   		}
>   		meta->map_ptr = reg->map_ptr;
>   		meta->map_uid = reg->map_uid;
> -	} else if (arg_type == ARG_PTR_TO_MAP_KEY) {
> +		break;
> +	case ARG_PTR_TO_MAP_KEY:
>   		/* bpf_map_xxx(..., map_ptr, ..., key) call:
>   		 * check that [key, key + map->key_size) are within
>   		 * stack limits and initialized
> @@ -5971,7 +5962,8 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   		err = check_helper_mem_access(env, regno,
>   					      meta->map_ptr->key_size, false,
>   					      NULL);
> -	} else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
> +		break;
> +	case ARG_PTR_TO_MAP_VALUE:
>   		if (type_may_be_null(arg_type) && register_is_null(reg))
>   			return 0;

> @@ -5987,14 +5979,16 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   		err = check_helper_mem_access(env, regno,
>   					      meta->map_ptr->value_size, false,
>   					      meta);
> -	} else if (arg_type == ARG_PTR_TO_PERCPU_BTF_ID) {
> +		break;
> +	case ARG_PTR_TO_PERCPU_BTF_ID:
>   		if (!reg->btf_id) {
>   			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
>   			return -EACCES;
>   		}
>   		meta->ret_btf = reg->btf;
>   		meta->ret_btf_id = reg->btf_id;
> -	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
> +		break;
> +	case ARG_PTR_TO_SPIN_LOCK:
>   		if (meta->func_id == BPF_FUNC_spin_lock) {
>   			if (process_spin_lock(env, regno, true))
>   				return -EACCES;
> @@ -6005,12 +5999,15 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   			verbose(env, "verifier internal error\n");
>   			return -EFAULT;
>   		}
> -	} else if (arg_type == ARG_PTR_TO_TIMER) {
> +		break;
> +	case ARG_PTR_TO_TIMER:
>   		if (process_timer_func(env, regno, meta))
>   			return -EACCES;
> -	} else if (arg_type == ARG_PTR_TO_FUNC) {
> +		break;
> +	case ARG_PTR_TO_FUNC:
>   		meta->subprogno = reg->subprogno;
> -	} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
> +		break;
> +	case ARG_PTR_TO_MEM:
>   		/* The access to this pointer is only checked when we hit the
>   		 * next is_mem_size argument below.
>   		 */
> @@ -6020,11 +6017,14 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   						      fn->arg_size[arg], false,
>   						      meta);
>   		}
> -	} else if (arg_type_is_mem_size(arg_type)) {
> -		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> -
> -		err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> -	} else if (arg_type_is_dynptr(arg_type)) {
> +		break;
> +	case ARG_CONST_SIZE:
> +		err = check_mem_size_reg(env, reg, regno, false, meta);
> +		break;
> +	case ARG_CONST_SIZE_OR_ZERO:
> +		err = check_mem_size_reg(env, reg, regno, true, meta);
> +		break;
> +	case ARG_PTR_TO_DYNPTR:
>   		if (arg_type & MEM_UNINIT) {
>   			if (!is_dynptr_reg_valid_uninit(env, reg)) {
>   				verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -6058,21 +6058,28 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   				err_extra, arg + 1);
>   			return -EINVAL;
>   		}
> -	} else if (arg_type_is_alloc_size(arg_type)) {
> +		break;
> +	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
>   		if (!tnum_is_const(reg->var_off)) {
>   			verbose(env, "R%d is not a known constant'\n",
>   				regno);
>   			return -EACCES;
>   		}
>   		meta->mem_size = reg->var_off.value;
> -	} else if (arg_type_is_int_ptr(arg_type)) {
> +		break;
> +	case ARG_PTR_TO_INT:
> +	case ARG_PTR_TO_LONG:
> +	{
>   		int size = int_ptr_type_to_size(arg_type);

>   		err = check_helper_mem_access(env, regno, size, false, meta);
>   		if (err)
>   			return err;
>   		err = check_ptr_alignment(env, reg, 0, size, true);
> -	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
> +		break;
> +	}
> +	case ARG_PTR_TO_CONST_STR:
> +	{
>   		struct bpf_map *map = reg->map_ptr;
>   		int map_off;
>   		u64 map_addr;
> @@ -6111,9 +6118,12 @@ static int check_func_arg(struct bpf_verifier_env  
> *env, u32 arg,
>   			verbose(env, "string is not zero-terminated\n");
>   			return -EINVAL;
>   		}
> -	} else if (arg_type == ARG_PTR_TO_KPTR) {
> +		break;
> +	}
> +	case ARG_PTR_TO_KPTR:
>   		if (process_kptr_func(env, regno, meta))
>   			return -EACCES;
> +		break;
>   	}

>   	return err;
> --
> 2.30.2

