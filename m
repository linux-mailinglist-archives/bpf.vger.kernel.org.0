Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7642A51DB8C
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442648AbiEFPLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEFPLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 11:11:14 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7655DA5C
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 08:07:31 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id c8so5592681qvh.10
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 08:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9b6YJa/bKekZ7vGcKyqVWDk+TdNBKRhSmR8tXnqH4I=;
        b=KqF6YXUuH6r6a+WW9u/e7gEUQmCF9sh14w/SvsgAcz84EPsYaNXMxaHS6NvyjcJJTy
         1PA2QWlHb8HX+OipngTJf/GWUCYWIAekClxiNUKhaq8W294Xcy4753G98udIcLTbNUqJ
         MB1DU2NDhEE+DAanai3ak6udNffKmAbFFbQa40Y9OkgspDrs/iqlFOgdkOrHDuNiCSzI
         v/cMKFV+ZbcQqg6OdMCX5Zi70oOnb+ZON6UYoHAV6Tfmzlopu9bJG4g8koicnWf2avPl
         KRxo9XMnGaurz4LGFwWA5nVYZF2uyEfz4w+el/bM8pBrAEXJV5sqhAAObLDUV1+gsCl6
         tBQQ==
X-Gm-Message-State: AOAM532aSSHTpnFd4Lve8qsGWVBHUz/navv/fG/dFRzSioiBiRxwZ28M
        nVTi+I6mIxJIvsPrPoZwNUY=
X-Google-Smtp-Source: ABdhPJzbXJ7rNNQLFuXDK62iRi7N544oRf1QFcZuWOxM3nQ0kjXqeEPggUMJRayyelfQTHg/EfcyOg==
X-Received: by 2002:ad4:5e89:0:b0:45a:d9c8:e04b with SMTP id jl9-20020ad45e89000000b0045ad9c8e04bmr2924137qvb.112.1651849650277;
        Fri, 06 May 2022 08:07:30 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-024.fbsv.net. [2a03:2880:20ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id w24-20020ac87198000000b002f39b99f697sm2623653qto.49.2022.05.06.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:07:30 -0700 (PDT)
Date:   Fri, 6 May 2022 08:07:27 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, toke@redhat.com
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
Message-ID: <20220506150727.73dvaiyf5rerggj3@dev0025.ash9.facebook.com>
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-2-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428211059.4065379-2-joannelkoong@gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

On Thu, Apr 28, 2022 at 02:10:54PM -0700, Joanne Koong wrote:
> @@ -5523,7 +5517,6 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
>  	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
> -	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
>  	[ARG_CONST_SIZE]		= &scalar_types,
>  	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
>  	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
> @@ -5537,7 +5530,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
>  	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
>  	[ARG_PTR_TO_MEM]		= &mem_types,
> -	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
>  	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
>  	[ARG_PTR_TO_INT]		= &int_ptr_types,
>  	[ARG_PTR_TO_LONG]		= &int_ptr_types,
> @@ -5711,8 +5703,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		return -EACCES;
>  	}

Could (or should) this go in a separate patch? Even with removing
ARG_PTR_TO_UNINIT_MAP_VALUE, it seems like this could stand on its own. Not
sure what the norm is for how granular to split patches for bpf, so even if
it could go in its own patch, feel free to disregard if you think splitting
this off is excessive / unnecessary.

> -	} else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> -		   base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> +	} else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
>  		if (type_may_be_null(arg_type) && register_is_null(reg))
>  			return 0;
>  
> @@ -5811,7 +5801,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			verbose(env, "invalid map_ptr to access map->value\n");
>  			return -EACCES;
>  		}
> -		meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE);
> +		meta->raw_mode = arg_type & MEM_UNINIT;

Given that we're stashing in a bool here, should this be:

	meta->raw_mode = (arg_type & MEM_UNINIT) != 0;

>  		err = check_helper_mem_access(env, regno,
>  					      meta->map_ptr->value_size, false,
>  					      meta);
> @@ -5838,11 +5828,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			return -EACCES;
>  	} else if (arg_type == ARG_PTR_TO_FUNC) {
>  		meta->subprogno = reg->subprogno;
> -	} else if (arg_type_is_mem_ptr(arg_type)) {
> +	} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
>  		/* The access to this pointer is only checked when we hit the
>  		 * next is_mem_size argument below.
>  		 */
> -		meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MEM);
> +		meta->raw_mode = arg_type & MEM_UNINIT;

Same here.

>  	} else if (arg_type_is_mem_size(arg_type)) {
>  		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
>  
> @@ -6189,9 +6179,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
>  static bool check_args_pair_invalid(enum bpf_arg_type arg_curr,
>  				    enum bpf_arg_type arg_next)
>  {
> -	return (arg_type_is_mem_ptr(arg_curr) &&
> +	return (base_type(arg_curr) == ARG_PTR_TO_MEM &&
>  	        !arg_type_is_mem_size(arg_next)) ||
> -	       (!arg_type_is_mem_ptr(arg_curr) &&
> +	       (base_type(arg_curr) != ARG_PTR_TO_MEM &&
>  		arg_type_is_mem_size(arg_next));
>  }

What do you think about this as a possibly more concise way to express that
the curr and next args differ?

	return (base_type(arg_curr) == ARG_PTR_TO_MEM) !=
		arg_type_is_mem_size(arg_next);


Looks great overall!

Thanks,
David
