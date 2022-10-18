Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67F60336F
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJRTpm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 15:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJRTpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 15:45:40 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7B34729
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 12:45:38 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id z30so9354006qkz.13
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 12:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbIxnlg8MS4JMFd9eI4EviUhNiGIdfCsm1ZKYV2nQEA=;
        b=sIl9DPqra2UZxe87+5GxTu8S/6Ew4sYeyFcSxwy/FxwL1DmLKwOXu/2ZZxjI8PNrIk
         9lzO43S0NhiCrkcgdDdjKwLIWGI9LPd5tlsi4QltK0JkY6GjS615MB8n+HLjPEA/M5v3
         gLNUntSLEdy5XBV13PKOYd4KDErtDHwih8fMnPOXcjRY2tH6ButoE4Y794adyL2bih6p
         7P/Cl4gXRYnJXh11z6ZWwGucVIcNM114yxejwtWazr8t9BDL3d23jfmiwk8PS/FZiHbk
         n0yjymTVaP0Y5DmPOeIG9PhCtMizn48HDW+utZVtZ47IfsrPVgy5tnH01mxElRneZwnE
         /U+Q==
X-Gm-Message-State: ACrzQf275CsYI4g0OEbrRJ/VvpKktApV9NdSi0RWUO4nMqj72Nxw6vxu
        9vESegFV0n1LhhVuxk06OfkeKXLWuu6LpA==
X-Google-Smtp-Source: AMsMyM4D33JWDcsKaa0uWB2r4NXcaCStdKQZcuDEvPoKDKoN0YRl0hbd229f05gMXHi5jn0UQDUACg==
X-Received: by 2002:a05:620a:44c6:b0:6ee:7a7a:93d1 with SMTP id y6-20020a05620a44c600b006ee7a7a93d1mr3032987qkp.256.1666122337169;
        Tue, 18 Oct 2022 12:45:37 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::62ae])
        by smtp.gmail.com with ESMTPSA id gb11-20020a05622a598b00b00398d83256ddsm2497064qtb.31.2022.10.18.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:45:36 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:45:37 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor ARG_PTR_TO_DYNPTR checks
 into process_dynptr_func
Message-ID: <Y08CYWzGTvKHQXvy@maniforge.dhcp.thefacebook.com>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-2-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018135920.726360-2-memxor@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 07:29:08PM +0530, Kumar Kartikeya Dwivedi wrote:

Hey Kumar, thanks for looking at this stuff.

> ARG_PTR_TO_DYNPTR is akin to ARG_PTR_TO_TIMER, ARG_PTR_TO_KPTR, where
> the underlying register type is subjected to more special checks to
> determine the type of object represented by the pointer and its state
> consistency.
> 
> Move dynptr checks to their own 'process_dynptr_func' function so that
> is consistent and in-line with existing code. This also makes it easier
> to reuse this code for kfunc handling.

Just out of curiosity, do you have a specific use case for when you'd envision
a kfunc taking a dynptr? I'm not saying there are none, just curious if you
have any specifically that you've considered.

> To this end, remove the dependency on bpf_call_arg_meta parameter by
> instead taking the uninit_dynptr_regno by pointer. This is only needed
> to be set to a valid pointer when arg_type has MEM_UNINIT.
> 
> Then, reuse this consolidated function in kfunc dynptr handling too.
> Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
> been lifted.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   8 +-
>  kernel/bpf/btf.c                              |  17 +--
>  kernel/bpf/verifier.c                         | 115 ++++++++++--------
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
>  5 files changed, 69 insertions(+), 88 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9e1e6965f407..a33683e0618b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -593,11 +593,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		   u32 regno, u32 mem_size);
> -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> -			      struct bpf_reg_state *reg);
> -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> -			     struct bpf_reg_state *reg,
> -			     enum bpf_arg_type arg_type);
> +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> +			enum bpf_arg_type arg_type, int argno,
> +			u8 *uninit_dynptr_regno);
>  
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index eba603cec2c5..1827d889e08a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6486,23 +6486,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  						return -EINVAL;
>  					}
>  
> -					if (!is_dynptr_reg_valid_init(env, reg)) {
> -						bpf_log(log,
> -							"arg#%d pointer type %s %s must be valid and initialized\n",
> -							i, btf_type_str(ref_t),
> -							ref_tname);
> +					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))
>  						return -EINVAL;
> -					}

Could you please clarify why you're removing the DYNPTR_TYPE_LOCAL constraint
for kfuncs?

You seemed to have removed the following negative selftest:

> -SEC("?lsm.s/bpf")
> -int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> -	     unsigned int size)
> -{
> -	char write_data[64] = "hello there, world!!";
> -	struct bpf_dynptr ptr;
> -
> -	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
> -
> -	return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> -}
> -

But it was clearly the intention of the test validate that we can't pass a
dynptr to a ringbuf region to this kfunc, so I'm curious what's changed since
that test was added.

> -
> -					if (!is_dynptr_type_expected(env, reg,
> -							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> -						bpf_log(log,
> -							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> -							i, btf_type_str(ref_t),
> -							ref_tname);
> -						return -EINVAL;
> -					}
> -
>  					continue;
>  				}
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6f6d2d511c06..31c0c999448e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -782,8 +782,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>  	return true;
>  }
>  
> -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> -			      struct bpf_reg_state *reg)
> +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>  	struct bpf_func_state *state = func(env, reg);
>  	int spi = get_spi(reg->off);
> @@ -802,9 +801,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
>  	return true;
>  }
>  
> -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> -			     struct bpf_reg_state *reg,
> -			     enum bpf_arg_type arg_type)
> +static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +				    enum bpf_arg_type arg_type)
>  {
>  	struct bpf_func_state *state = func(env, reg);
>  	enum bpf_dynptr_type dynptr_type;
> @@ -5573,6 +5571,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>  	return 0;
>  }
>  
> +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> +			enum bpf_arg_type arg_type, int argno,
> +			u8 *uninit_dynptr_regno)
> +{

IMO 'process' is a bit too generic of a term. If we decide to go with this,
what do you think about changing the name to check_func_dynptr_arg(), or just
check_dynptr_arg()?

> +	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> +
> +	/* We only need to check for initialized / uninitialized helper
> +	 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> +	 * assumption is that if it is, that a helper function
> +	 * initialized the dynptr on behalf of the BPF program.
> +	 */
> +	if (base_type(reg->type) == PTR_TO_DYNPTR)
> +		return 0;
> +	if (arg_type & MEM_UNINIT) {
> +		if (!is_dynptr_reg_valid_uninit(env, reg)) {
> +			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> +			return -EINVAL;
> +		}
> +
> +		/* We only support one dynptr being uninitialized at the moment,
> +		 * which is sufficient for the helper functions we have right now.
> +		 */
> +		if (*uninit_dynptr_regno) {
> +			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> +			return -EFAULT;
> +		}
> +
> +		*uninit_dynptr_regno = regno;
> +	} else {
> +		if (!is_dynptr_reg_valid_init(env, reg)) {
> +			verbose(env,
> +				"Expected an initialized dynptr as arg #%d\n",
> +				argno + 1);
> +			return -EINVAL;
> +		}
> +
> +		if (!is_dynptr_type_expected(env, reg, arg_type)) {
> +			const char *err_extra = "";
> +
> +			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> +			case DYNPTR_TYPE_LOCAL:
> +				err_extra = "local";
> +				break;
> +			case DYNPTR_TYPE_RINGBUF:
> +				err_extra = "ringbuf";
> +				break;
> +			default:
> +				err_extra = "<unknown>";
> +				break;
> +			}
> +			verbose(env,
> +				"Expected a dynptr of type %s as arg #%d\n",
> +				err_extra, argno + 1);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}

[...]

Seems like a reasonable cleanup overall, comments aside.

Thanks,
David
