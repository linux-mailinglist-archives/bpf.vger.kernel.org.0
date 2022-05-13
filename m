Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7DD526C5E
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiEMVgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiEMVgP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 17:36:15 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA13135E
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:36:14 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id c1so8328497qkf.13
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wS7ywOzZt2XtrNci6zu6F6iMA8CkZkUFYx7MRjosu4=;
        b=CqnuD7taUv+n+TI46tCtOJNNfZqWP7wFTGgCEdhmtxESniO4sHO0wUW2XNyTnnS3d6
         5z1DCAN12+kfEKTfnCsNAOQb1Nv9WcliJlHx0668A0ffJG9DyEGKIjJf/pV4X9a12U3V
         5wP569rjXpJKwc1q/OIlJHcxlrTdP1r6tQzptSc3wRdlbHy1hv1bi5x8ksrfXjX+vNqz
         p71vQcXPZCxkaX/ZE+oVCATuSBOmpGNqERsNTzc1JU9ZJMh8BmsY73lSaEW3lOpjnmKr
         KFApjqJ4FBnrozsOBzi7h1KYnQFhWsGadZiJPy995J4+xqs4Y88DLbb51EuICagAofKn
         i7Dw==
X-Gm-Message-State: AOAM532qArZIv+dCQKfpNGw1QIx5MEw/Obw2820PMUkxCrouJuREvuKc
        jYtDXpMei/hoymbxZSLBPWM=
X-Google-Smtp-Source: ABdhPJxGbukvIphMpf+CMo+k9wmmoytTVeVq3fmgaMQX20SQBu4ouToigDepQuYtRK1bVO02Mwh8wQ==
X-Received: by 2002:a05:620a:2910:b0:6a0:40d:2c8b with SMTP id m16-20020a05620a291000b006a0040d2c8bmr5283858qkp.195.1652477772848;
        Fri, 13 May 2022 14:36:12 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-015.fbsv.net. [2a03:2880:20ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id l5-20020ac848c5000000b002f3fbf28826sm2139296qtr.23.2022.05.13.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 14:36:12 -0700 (PDT)
Date:   Fri, 13 May 2022 14:36:11 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs
 and implement malloc dynptrs
Message-ID: <20220513213611.exm67qnqrlti22a5@dev0025.ash9.facebook.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509224257.3222614-3-joannelkoong@gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 09, 2022 at 03:42:53PM -0700, Joanne Koong wrote:
> This patch adds the bulk of the verifier work for supporting dynamic
> pointers (dynptrs) in bpf. This patch implements malloc-type dynptrs
> through 2 new APIs (bpf_dynptr_alloc and bpf_dynptr_put) that can be
> called by a bpf program. Malloc-type dynptrs are dynptrs that dynamically
> allocate memory on behalf of the program.
> 
> A bpf_dynptr is opaque to the bpf program. It is a 16-byte structure
> defined internally as:
> 
> struct bpf_dynptr_kern {
>     void *data;
>     u32 size;
>     u32 offset;
> } __aligned(8);
> 
> The upper 8 bits of *size* is reserved (it contains extra metadata about
> read-only status and dynptr type); consequently, a dynptr only supports
> memory less than 16 MB.
> 

Small nit: s/less than/up to?


[...]

> +/* the implementation of the opaque uapi struct bpf_dynptr */
> +struct bpf_dynptr_kern {
> +	void *data;
> +	/* Size represents the number of usable bytes in the dynptr.
> +	 * If for example the offset is at 200 for a malloc dynptr with
> +	 * allocation size 256, the number of usable bytes is 56.
> +	 *
> +	 * The upper 8 bits are reserved.
> +	 * Bit 31 denotes whether the dynptr is read-only.
> +	 * Bits 28-30 denote the dynptr type.

It's pretty clear from context, but just for completeness, could you also
explicitly specify what bits 0 - 27 denote (24 - 27 reserved, 0 - 23 size)?

> +	 */
> +	u32 size;
> +	u32 offset;
> +} __aligned(8);
> +
> +enum bpf_dynptr_type {
> +	BPF_DYNPTR_TYPE_INVALID,
> +	/* Memory allocated dynamically by the kernel for the dynptr */
> +	BPF_DYNPTR_TYPE_MALLOC,
> +};
> +
> +/* Since the upper 8 bits of dynptr->size is reserved, the
> + * maximum supported size is 2^24 - 1.
> + */
> +#define DYNPTR_MAX_SIZE	((1UL << 24) - 1)
> +#define DYNPTR_SIZE_MASK	0xFFFFFF
> +#define DYNPTR_TYPE_SHIFT	28
> +#define DYNPTR_TYPE_MASK	0x7

Should we add a static_assert(DYNPTR_SIZE_MASK >= DYNPTR_MAX_SIZE);
Potentially overkill, but if we're going to have separate macros for them
it might be prudent to add it?

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0fe1dea520ae..8cdedc776987 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -187,6 +187,10 @@ struct bpf_verifier_stack_elem {
>  					  POISON_POINTER_DELTA))
>  #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
>  
> +static bool arg_type_is_mem_size(enum bpf_arg_type type);
> +static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
> +
>  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>  {
>  	return BPF_MAP_PTR(aux->map_ptr_state) == BPF_MAP_PTR_POISON;
> @@ -259,6 +263,7 @@ struct bpf_call_arg_meta {
>  	u32 ret_btf_id;
>  	u32 subprogno;
>  	struct bpf_map_value_off_desc *kptr_off_desc;
> +	u8 uninit_dynptr_regno;
>  };
>  
>  struct btf *btf_vmlinux;
> @@ -580,6 +585,7 @@ static char slot_type_char[] = {
>  	[STACK_SPILL]	= 'r',
>  	[STACK_MISC]	= 'm',
>  	[STACK_ZERO]	= '0',
> +	[STACK_DYNPTR]	= 'd',
>  };
>  
>  static void print_liveness(struct bpf_verifier_env *env,
> @@ -595,6 +601,25 @@ static void print_liveness(struct bpf_verifier_env *env,
>  		verbose(env, "D");
>  }
>  
> +static inline int get_spi(s32 off)
> +{
> +	return (-off - 1) / BPF_REG_SIZE;
> +}

Small / optional nit: It's probably harmless to leave this as inline as the
compiler will almost certainly inline it for you, but to that point, it's
probably not necessary to mark this as inline. It looks like most other
static functions in verifier.c are non-inline, so IMO it's probably best to
follow that lead.

[...]

>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -5725,7 +5885,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  
>  skip_type_check:
>  	if (arg_type_is_release(arg_type)) {
> -		if (!reg->ref_obj_id && !register_is_null(reg)) {
> +		if (arg_type_is_dynptr(arg_type)) {
> +			struct bpf_func_state *state = func(env, reg);
> +			int spi = get_spi(reg->off);
> +
> +			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> +			    !state->stack[spi].spilled_ptr.id) {
> +				verbose(env, "arg %d is an unacquired reference\n", regno);
> +				return -EINVAL;
> +			}
> +		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
>  			verbose(env, "R%d must be referenced when passed to release function\n",
>  				regno);
>  			return -EINVAL;
> @@ -5837,6 +6006,43 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
>  
>  		err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> +	} else if (arg_type_is_dynptr(arg_type)) {
> +		/* Can't pass in a dynptr at a weird offset */
> +		if (reg->off % BPF_REG_SIZE) {
> +			verbose(env, "cannot pass in non-zero dynptr offset\n");
> +			return -EINVAL;
> +		}

Should this check be moved to check_func_arg_reg_off()?

> +
> +		if (arg_type & MEM_UNINIT)  {
> +			if (!is_dynptr_reg_valid_uninit(env, reg)) {
> +				verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
> +					arg + BPF_REG_1);
> +				return -EINVAL;
> +			}
> +
> +			/* We only support one dynptr being uninitialized at the moment,
> +			 * which is sufficient for the helper functions we have right now.
> +			 */
> +			if (meta->uninit_dynptr_regno) {
> +				verbose(env, "verifier internal error: more than one uninitialized dynptr arg\n");
> +				return -EFAULT;
> +			}
> +
> +			meta->uninit_dynptr_regno = arg + BPF_REG_1;

Can this be simplified to:

meta->uninit_dynptr_regno = regno;

[...]

Looks good otherwise, thanks!

Acked-by: David Vernet <void@manifault.com>
