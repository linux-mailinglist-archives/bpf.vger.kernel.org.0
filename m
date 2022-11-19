Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AA63112C
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 23:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiKSWCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 17:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSWCw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 17:02:52 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFBB6262;
        Sat, 19 Nov 2022 14:02:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d192so8135708pfd.0;
        Sat, 19 Nov 2022 14:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EebatYo3O/AC36Z3zpp8STKWNpTkrz+6XYDKU8WPVes=;
        b=aGtKr+U7iwMo5hm/zHLr6aaU7F/8cS3j3rmnMki4hnLNfPLxDpRALE5A37eY+6M3RD
         MOpzY5AoTA0AQF3vN4mz7fsTTynZ2VJAwn3h/gLAm6qKEMfmvl3Wzj4vgAM4+DepGP5f
         odmUjA23yl9dI01qPJjuk5K/uDDBxI/GxTG1BY3Quz9883GNsnrvbV4gxxGBLalAMYOZ
         RkQ52H8ttF5y8J5YNNCHQzgovTkG+IeAcK9+O7ETVc1ymoo9nmvF4Rww6hdNYVk9dvyy
         KIM2QGfn3D7iicZ2yHYuznuOw7iam7KzZJLeb+2KngtLko9Ith2IJC5xsteMMO3G8Vm2
         2WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EebatYo3O/AC36Z3zpp8STKWNpTkrz+6XYDKU8WPVes=;
        b=U1i0k1OYMU7I6kGZufmgOpid8BqmTqlvvmzSv8WKXxMn1h8Z2TIOnvWOGA+Kj880sy
         EgHJnenYQM1pURPFMsXoYhBJueIhDVREyniCTCdtJaT5E0Ouoaw9kDI5oJ15FcaPPgEC
         Mzdrq/1/UpK9CRHoUKPvZLv/wfZlXmozvGn8WO5C54Y4k4jsfevPr2pL4XWJVrdCisV3
         rGESrVG8gkJsbGvbY9moz5Auj4/dPD6tYpkUdRUSWANxbwy5L4lB5brxF8U+PLmjEIkm
         RjAnAFrbk0qrw5432vN8zv/0zxoo/ee1wfJnQkfVCfW/8rqy4bM0xunGoT4VvD22Fqcj
         A0fg==
X-Gm-Message-State: ANoB5pk6Z0L9pZ1ja+Q9J/Lf8xjx8Z/VSKv+NoZnxXOjpeW5nE0ivqty
        0MvN0epdDVrcY5t+Pp1czDM=
X-Google-Smtp-Source: AA0mqf7Zwkuj7WAIIxTMs3hKoGYFzIFLsZZDj4yJX1eXRu1LDczYhwRVSa44mOfx8GPz6C2cVRWGOg==
X-Received: by 2002:a05:6a00:b84:b0:563:4643:db33 with SMTP id g4-20020a056a000b8400b005634643db33mr13794741pfj.22.1668895370526;
        Sat, 19 Nov 2022 14:02:50 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0018691ce1696sm6317480plf.131.2022.11.19.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 14:02:49 -0800 (PST)
Date:   Sat, 19 Nov 2022 14:02:46 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v8 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221119220246.k4i3zp5wmsm6g2al@macbook-pro-5.dhcp.thefacebook.com>
References: <20221119210748.3325667-1-void@manifault.com>
 <20221119210748.3325667-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119210748.3325667-2-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 19, 2022 at 03:07:46PM -0600, David Vernet wrote:
> @@ -6887,6 +6895,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
>  			}
>  
>  			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
> +

No need to add empty line here.

>  			reg->id = ++env->id_gen;
>  
>  			continue;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 195d24316750..3a90a1c7613f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -557,7 +557,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
>  static const char *reg_type_str(struct bpf_verifier_env *env,
>  				enum bpf_reg_type type)
>  {
> -	char postfix[16] = {0}, prefix[32] = {0};
> +	char postfix[16] = {0}, prefix[64] = {0};
>  	static const char * const str[] = {
>  		[NOT_INIT]		= "?",
>  		[SCALAR_VALUE]		= "scalar",
> @@ -589,16 +589,14 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>  			strncpy(postfix, "_or_null", 16);
>  	}
>  
> -	if (type & MEM_RDONLY)
> -		strncpy(prefix, "rdonly_", 32);
> -	if (type & MEM_RINGBUF)
> -		strncpy(prefix, "ringbuf_", 32);
> -	if (type & MEM_USER)
> -		strncpy(prefix, "user_", 32);
> -	if (type & MEM_PERCPU)
> -		strncpy(prefix, "percpu_", 32);
> -	if (type & PTR_UNTRUSTED)
> -		strncpy(prefix, "untrusted_", 32);
> +	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
> +		 type & MEM_RDONLY ? "rdonly_" : "",
> +		 type & MEM_RINGBUF ? "ringbuf_" : "",
> +		 type & MEM_USER ? "user_" : "",
> +		 type & MEM_PERCPU ? "percpu_" : "",
> +		 type & PTR_UNTRUSTED ? "untrusted_" : "",
> +		 type & PTR_TRUSTED ? "trusted_" : ""
> +	);

Nice. Could have been a separate patch, but ok.

>  
>  found:
> -	if (reg->type == PTR_TO_BTF_ID) {
> +	if (reg->type == PTR_TO_BTF_ID || (reg->type & PTR_TRUSTED)) {

No need for (). The operator precedence is pretty clear.

>  		/* For bpf_sk_release, it needs to match against first member
>  		 * 'struct sock_common', hence make an exception for it. This
>  		 * allows bpf_sk_release to work for multiple socket types.
> @@ -6058,6 +6070,8 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	 */
>  	case PTR_TO_BTF_ID:
>  	case PTR_TO_BTF_ID | MEM_ALLOC:
> +	case PTR_TO_BTF_ID | PTR_TRUSTED:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>  		 * it's fixed offset must be 0.	In the other cases, fixed offset
>  		 * can be non-zero.
> @@ -7942,6 +7956,25 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>  	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>  }
>  
> +static bool is_trusted_reg(const struct bpf_reg_state *reg)
> +{
> +	/* A referenced register is always trusted. */
> +	if (reg->ref_obj_id)
> +		return true;
> +
> +	/* If a register is not referenced, it is trusted if it has either the
> +	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
> +	 * other type modifiers may be safe, but we elect to take an opt-in
> +	 * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
> +	 * not.
> +	 *
> +	 * Eventually, we should make PTR_TRUSTED the single source of truth
> +	 * for whether a register is trusted.
> +	 */
> +	return (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS) &&

No need for ().

> +	       !bpf_type_has_unsafe_modifiers(reg->type);
> +}
> +
...
> -		if (is_kfunc_release(meta) && reg->ref_obj_id)
> +		if (is_kfunc_release(meta) && reg->ref_obj_id) {
>  			arg_type |= OBJ_RELEASE;
> +			if (bpf_type_has_unsafe_modifiers(reg->type)) {
> +				verbose(env, "R%d release reg has unsafe modifiers\n", i);
> +				return -EINVAL;
> +			}

This part is a bit controversial, sicne it messes up the verifier messages.
Meaning that doing the check that early is losing important context.

> +		}
>  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
>  		if (ret < 0)
>  			return ret;
> @@ -8705,7 +8745,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			break;
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			/* Only base_type is checked, further checks are done here */
> -			if (reg->type != PTR_TO_BTF_ID &&
> +			if (base_type(reg->type) != PTR_TO_BTF_ID &&
>  			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
>  				verbose(env, "arg#%d expected pointer to btf or socket\n", i);

With base_type() addition maybe the bpf_type_has_unsafe_modifiers() check
should be done here ?
Then test_verifier wouldn't need to change.
It's not the change itself that is a concern, but the loss of context in the messages.
I guess one can argue that erroring on PTR_TO_BTF_ID | PTR_MAYBE_NULL
with "reg has unsafe modifiers" is just as correct as saying
"expected pointer to btf or socket" a bit later.
Both could be improved.
If we keep it early while doing is_kfunc_release(meta) && reg->ref_obj_id
we could say:
"%s is not allowed in release function"
reg_type_str(env,reg->type)
Which for verifier/calls.c test case will be:
"ptr_prog_test_ref_kfunc_or_null is not allowed in release function"

If we do it later here it could be:
"arg#$d is %s. Expected %s or socket",
reg_type_str(env,reg->type)
reg_type_str(env,base_type(reg->type) | type_flag(reg->type) & ~BPF_REG_TRUSTED_MODIFIERS)
"arg#0 is ptr_prog_test_ref_kfunc_or_null. Expected ptr_prog_test_ref_kfunc or socket"

which is even better and it will make it easier for user to fix the code.

wdyt?
