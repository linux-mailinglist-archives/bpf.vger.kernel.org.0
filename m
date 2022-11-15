Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E726291A5
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 06:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKOFsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 00:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKOFsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 00:48:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBC1ADA2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 21:48:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so15904367pjc.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 21:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ghaqiA5ZORDqJSeuGAwGkyGytz21rNx2Nwal26Cm0E=;
        b=J85u52To4+6LnlHYycphH/x46mfz6jINjl1yL51dgjvPorXmtSDCfhGsS2c8kDA4vO
         cQdIPmDy0kwp85J1hJTniasIAp4io6IIgMZzfSTQy5TuebnFRCwoW48nJkDdLf2RCooI
         WRWqVpKKH6cx+eI/uraYT8Juc24J7hOBF9GfJvbBYQnmPN9WIWx8XH0Ypw2HSHEOOr6K
         4SGgGjO+kP8g4WjBbz/VylOPsisOoCz1lyinZ7RrIcOB62heIgFAt/Ka8PKEUWHzm6go
         0yXrR7F06TLD2mm94jqQZnkt9QOReccB9pKhK4bFXhQDFBeeOtJCCQQACrQrT/bp6NVN
         T2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ghaqiA5ZORDqJSeuGAwGkyGytz21rNx2Nwal26Cm0E=;
        b=HWfFYgUwYuky9fYZQ4K4OyC7xSWgtVo/7mC0MxOYqcVgUVnArG65GSrZnxJsWhDgmb
         7+N/QQ6ndlgSZIeqOQ7e1jn2PSAgyyBOlDTeDhMfGa9GTsxb2xWkBNAAF6FMCVQ6OYym
         aitun05/Xyx14armLcmSmw+KkKBPeD75PsDUkwpTqx72X0z9ACHY5HBYckw2okeFobr+
         bwcbZKwEracS2/WqNVbSHzDLmUSdkWEEsyIrMfQAdnt1im9l17acYZm46ybTBjDxPFhB
         FygqbYD0K0Vh9EJHxV1FKzA7g+nOk64El6Lp/yj8bsazbVjWX6HPPM6VlGxHrI2dBwD/
         aUtg==
X-Gm-Message-State: ANoB5pk9Us9QhDIgCYKB5FUrxugV1//2DM9t+aVRF01wN6wwwJUUp0dx
        7TtO8H7B4BAVewvMqLOuK/g=
X-Google-Smtp-Source: AA0mqf4npVjRuaHIplhZGDWhhvgD9fStJJtKvVyxERCffpInQRmt5HH7ogXUpaEd+2/SSCYRTGE/2w==
X-Received: by 2002:a17:90a:d803:b0:213:13f2:1635 with SMTP id a3-20020a17090ad80300b0021313f21635mr526250pjv.242.1668491302205;
        Mon, 14 Nov 2022 21:48:22 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:cee6])
        by smtp.gmail.com with ESMTPSA id c5-20020a634e05000000b0046f7e1ca434sm6948191pgb.0.2022.11.14.21.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 21:48:21 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:48:18 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 08/26] bpf: Introduce allocated objects
 support
Message-ID: <20221115054818.r7p3jbqg352obbb6@macbook-pro-5.dhcp.thefacebook.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-9-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114191547.1694267-9-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 12:45:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> Introduce support for representing pointers to objects allocated by the
> BPF program, i.e. PTR_TO_BTF_ID that point to a type in program BTF.
> This is indicated by the presence of MEM_ALLOC type flag in reg->type to
> avoid having to check btf_is_kernel when trying to match argument types
> in helpers.
> 
> Whenever walking such types, any pointers being walked will always yield
> a SCALAR instead of pointer. In the future we might permit kptr inside
> such allocated objects (either kernel or local), and it will then form a

(either kernel or program allocated) ?

> PTR_TO_BTF_ID of the respective type.
> 
> For now, such allocated objects will always be referenced in verifier
> context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> to such objects, as long fields that are special are not touched
> (support for which will be added in subsequent patches). Note that once
> such a pointer is marked PTR_UNTRUSTED, it is no longer allowed to write
> to it.
> 
> No PROBE_MEM handling is therefore done for loads into this type unless
> PTR_UNTRUSTED is part of the register type, since they can never be in
> an undefined state, and their lifetime will always be valid.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   | 11 +++++++++++
>  kernel/bpf/btf.c      |  5 +++++
>  kernel/bpf/verifier.c | 25 +++++++++++++++++++++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 49f9d2bec401..3cab113b149e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -524,6 +524,11 @@ enum bpf_type_flag {
>  	/* Size is known at compile time. */
>  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>  
> +	/* MEM is of a an allocated object of type from program BTF. This is
> +	 * used to tag PTR_TO_BTF_ID allocated using bpf_obj_new.
> +	 */
> +	MEM_ALLOC		= BIT(11 + BPF_BASE_TYPE_BITS),
> +
>  	__BPF_TYPE_FLAG_MAX,
>  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>  };
> @@ -2791,4 +2796,10 @@ struct bpf_key {
>  	bool has_ref;
>  };
>  #endif /* CONFIG_KEYS */
> +
> +static inline bool type_is_alloc(u32 type)
> +{
> +	return type & MEM_ALLOC;
> +}
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 875355ff3718..9a596f430558 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6034,6 +6034,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  
>  		switch (err) {
>  		case WALK_PTR:
> +			/* For local types, the destination register cannot
> +			 * become a pointer again.
> +			 */
> +			if (type_is_alloc(reg->type))
> +				return SCALAR_VALUE;
>  			/* If we found the pointer or scalar on t+off,
>  			 * we're done.
>  			 */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e74f460dfd0..d726d55622c9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4687,14 +4687,27 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> -	if (env->ops->btf_struct_access) {
> +	if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
> +		if (!btf_is_kernel(reg->btf)) {
> +			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
> +			return -EFAULT;
> +		}
>  		ret = env->ops->btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
>  	} else {
> -		if (atype != BPF_READ) {
> +		/* Writes are permitted with default btf_struct_access for local
> +		 * kptrs (which always have ref_obj_id > 0), but not for

for program allocated objects (which always have ref_obj_id > 0) ?

> +		 * untrusted PTR_TO_BTF_ID | MEM_ALLOC.
> +		 */
> +		if (atype != BPF_READ && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>  			verbose(env, "only read is supported\n");
>  			return -EACCES;
>  		}
>  
> +		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
> +			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
> +			return -EFAULT;
> +		}
> +
>  		ret = btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
>  	}
>  
> @@ -5973,6 +5986,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	 * fixed offset.
>  	 */
>  	case PTR_TO_BTF_ID:
> +	case PTR_TO_BTF_ID | MEM_ALLOC:
>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>  		 * it's fixed offset must be 0.	In the other cases, fixed offset
>  		 * can be non-zero.
> @@ -13659,6 +13673,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			break;
>  		case PTR_TO_BTF_ID:
>  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> +		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
> +		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
> +		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
> +		 * any faults for loads into such types. BPF_WRITE is disallowed
> +		 * for this case.
> +		 */
> +		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
>  			if (type == BPF_READ) {
>  				insn->code = BPF_LDX | BPF_PROBE_MEM |
>  					BPF_SIZE((insn)->code);
> -- 
> 2.38.1
> 
