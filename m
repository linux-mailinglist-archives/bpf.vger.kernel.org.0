Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A93603693
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 01:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJRXRA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 19:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJRXQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 19:16:59 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1FD57E3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:16:57 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id j21so9688957qkk.9
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05epyZHxeeuKn/nWSvRJ5nmaXNzH9PEUHU13+1NFLdo=;
        b=IgOqhhlc0T46GWKO6jNLmvqDjbNd/9qsAlSJ/s8lpdYNDVCG2XkWHGsYfFPmtKD5Ow
         NV6FBPllg9e33tPlDjuyNvhCF09px8t6g8jxrm86g7c3uZaTm7FeZQAv2KSugbmJ/cKY
         +fNocLSUlDMphWlo2Olhc+inRN7Fz9bFWMPXKdb5qNWthHFv6FvdFbHCdcv682EiS73b
         f96tPmSA7lNbDLLyE8S2VdB0QTl4QIqFl3LSRxhp9bNHsicKAhMxBA+7Whe+kTyb0t1O
         49xa+jHKbhhsKYeQf++X9Z05E5BNukH0jwxc8UNB3I8oTrtjUkzXP2oRHaMaxVAtWWts
         xOZA==
X-Gm-Message-State: ACrzQf3VGl1ek+E9ZAd0JCc55HWH759MsAgjdyroUSpeQ50df+mnZ5Lt
        stzubzqAUdIdZXEtxR5zdxY=
X-Google-Smtp-Source: AMsMyM63oppB9GhSioYBdO5cmMx7a4LlvFceCmMSu+iNzy1z3fNyjR4vVvT5wUzYg7/waJW4tGvXiA==
X-Received: by 2002:a05:620a:4114:b0:6ee:dfb7:1584 with SMTP id j20-20020a05620a411400b006eedfb71584mr3624068qko.262.1666135016382;
        Tue, 18 Oct 2022 16:16:56 -0700 (PDT)
Received: from maniforge.DHCP.thefacebook.com ([2620:10d:c091:480::62ae])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006ecdfcf9d81sm3303525qkg.84.2022.10.18.16.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:16:55 -0700 (PDT)
Date:   Tue, 18 Oct 2022 18:16:57 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/13] bpf: Rework process_dynptr_func
Message-ID: <Y08z6U1iAcv4IwDY@maniforge.DHCP.thefacebook.com>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-3-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018135920.726360-3-memxor@gmail.com>
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

On Tue, Oct 18, 2022 at 07:29:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> Recently, user ringbuf support introduced a PTR_TO_DYNPTR register type
> for use in callback state, because in case of user ringbuf helpers,
> there is no dynptr on the stack that is passed into the callback. To
> reflect such a state, a special register type was created.
> 
> However, some checks have been bypassed incorrectly during the addition
> of this feature. First, for arg_type with MEM_UNINIT flag which
> initialize a dynptr, they must be rejected for such register type.

Ahhh, great point. Thanks a lot for catching this.

> Secondly, in the future, there are plans to dynptr helpers that operate
> on the dynptr itself and may change its offset and other properties.

small nit: s/to dynptr helpers/to add dynptr helpers

> In all of these cases, PTR_TO_DYNPTR shouldn't be allowed to be passed
> to such helpers, however the current code simply returns 0.
>
> The rejection for helpers that release the dynptr is already handled.
> 
> For fixing this, we take a step back and rework existing code in a way
> that will allow fitting in all classes of helpers and have a coherent
> model for dealing with the variety of use cases in which dynptr is used.
> 
> First, for ARG_PTR_TO_DYNPTR, it can either be set alone or together
> with a DYNPTR_TYPE_* constant that denotes the only type it accepts.
>
> Next, helpers which initialize a dynptr use MEM_UNINIT to indicate this
> fact. To make the distinction clear, use MEM_RDONLY flag to indicate
> that the helper only operates on the memory pointed to by the dynptr,

Hmmm, it feels a bit confusing to overload MEM_RDONLY like this. I
understand the intention (which is logical) to imply that the pointer to
the dynptr is read only, but the fact that the memory contained in the
dynptr may not be read only will doubtless confuse people.

I don't really have a better suggestion. This is the proper use of
MEM_RDONLY, but it really feels super confusing. I guess this is
somewhat mitigated by the fact that the read-only nature of the dynptr
is something that will be validated at runtime?

> not the dynptr itself. In C parlance, it would be equivalent to taking
> the dynptr as a point to const argument.
> 
> When either of these flags are not present, the helper is allowed to
> mutate both the dynptr itself and also the memory it points to.
> Currently, the read only status of the memory is not tracked in the
> dynptr, but it would be trivial to add this support inside dynptr state
> of the register.
> 
> With these changes and renaming PTR_TO_DYNPTR to CONST_PTR_TO_DYNPTR to
> better reflect its usage, it can no longer be passed to helpers that
> initialize a dynptr, i.e. bpf_dynptr_from_mem, bpf_ringbuf_reserve_dynptr.
> 
> A note to reviewers is that in code that does mark_stack_slots_dynptr,
> and unmark_stack_slots_dynptr, we implicitly rely on the fact that
> PTR_TO_STACK reg is the only case that can reach that code path, as one
> cannot pass CONST_PTR_TO_DYNPTR to helpers that don't set MEM_RDONLY. In
> both cases such helpers won't be setting that flag.
> 
> The next patch will add a couple of selftest cases to make sure this
> doesn't break.
> 
> Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h                           |   4 +-
>  include/uapi/linux/bpf.h                      |   8 +-
>  kernel/bpf/btf.c                              |   7 +-
>  kernel/bpf/helpers.c                          |  18 +-
>  kernel/bpf/verifier.c                         | 203 ++++++++++++++----
>  scripts/bpf_doc.py                            |   1 +
>  tools/include/uapi/linux/bpf.h                |   8 +-
>  .../selftests/bpf/prog_tests/user_ringbuf.c   |  10 +-
>  8 files changed, 185 insertions(+), 74 deletions(-)

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 31c0c999448e..87d9cccd1623 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -563,7 +563,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>  		[PTR_TO_BUF]		= "buf",
>  		[PTR_TO_FUNC]		= "func",
>  		[PTR_TO_MAP_KEY]	= "map_key",
> -		[PTR_TO_DYNPTR]		= "dynptr_ptr",
> +		[CONST_PTR_TO_DYNPTR]	= "dynptr",
>  	};
>  
>  	if (type & PTR_MAYBE_NULL) {
> @@ -697,6 +697,27 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
>  	return type == BPF_DYNPTR_TYPE_RINGBUF;
>  }
>  
> +static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
> +			       struct bpf_reg_state *reg2,
> +			       enum bpf_dynptr_type type);
> +
> +static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> +				struct bpf_reg_state *reg);
> +
> +static void mark_dynptr_stack_regs(struct bpf_reg_state *sreg1,
> +				   struct bpf_reg_state *sreg2,
> +				   enum bpf_dynptr_type type)
> +{
> +	__mark_dynptr_regs(sreg1, sreg2, type);
> +}
> +
> +static void mark_dynptr_cb_reg(struct bpf_reg_state *reg1,
> +			       enum bpf_dynptr_type type)
> +{
> +	__mark_dynptr_regs(reg1, NULL, type);
> +}
> +
> +
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  				   enum bpf_arg_type arg_type, int insn_idx)
>  {
> @@ -718,9 +739,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>  	if (type == BPF_DYNPTR_TYPE_INVALID)
>  		return -EINVAL;
>  
> -	state->stack[spi].spilled_ptr.dynptr.first_slot = true;
> -	state->stack[spi].spilled_ptr.dynptr.type = type;
> -	state->stack[spi - 1].spilled_ptr.dynptr.type = type;
> +	mark_dynptr_stack_regs(&state->stack[spi].spilled_ptr,
> +			       &state->stack[spi - 1].spilled_ptr, type);
>  
>  	if (dynptr_type_refcounted(type)) {
>  		/* The id is used to track proper releasing */
> @@ -728,8 +748,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>  		if (id < 0)
>  			return id;
>  
> -		state->stack[spi].spilled_ptr.id = id;
> -		state->stack[spi - 1].spilled_ptr.id = id;
> +		state->stack[spi].spilled_ptr.ref_obj_id = id;
> +		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
>  	}
>  
>  	return 0;
> @@ -751,25 +771,23 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
>  	}
>  
>  	/* Invalidate any slices associated with this dynptr */
> -	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> -		release_reference(env, state->stack[spi].spilled_ptr.id);
> -		state->stack[spi].spilled_ptr.id = 0;
> -		state->stack[spi - 1].spilled_ptr.id = 0;
> -	}
> -
> -	state->stack[spi].spilled_ptr.dynptr.first_slot = false;
> -	state->stack[spi].spilled_ptr.dynptr.type = 0;
> -	state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> +	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type))
> +		WARN_ON_ONCE(release_reference(env, state->stack[spi].spilled_ptr.ref_obj_id));
>  
> +	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> +	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
>  	return 0;
>  }
>  
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>  	struct bpf_func_state *state = func(env, reg);
> -	int spi = get_spi(reg->off);
> -	int i;
> +	int spi, i;
>  
> +	if (reg->type == CONST_PTR_TO_DYNPTR)
> +		return false;
> +
> +	spi = get_spi(reg->off);
>  	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>  		return true;
>  
> @@ -785,9 +803,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>  static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>  	struct bpf_func_state *state = func(env, reg);
> -	int spi = get_spi(reg->off);
> +	int spi;
>  	int i;
>  
> +	/* This already represents first slot of initialized bpf_dynptr */
> +	if (reg->type == CONST_PTR_TO_DYNPTR)
> +		return true;
> +
> +	spi = get_spi(reg->off);
>  	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
>  	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
>  		return false;
> @@ -806,15 +829,21 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
>  {
>  	struct bpf_func_state *state = func(env, reg);
>  	enum bpf_dynptr_type dynptr_type;
> -	int spi = get_spi(reg->off);
> +	int spi;
>  
> +	/* Fold MEM_RDONLY, caller already checked it */
> +	arg_type &= ~MEM_RDONLY;

This is already done in the caller, I think it can just be removed?

>  	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
>  	if (arg_type == ARG_PTR_TO_DYNPTR)
>  		return true;
>  
>  	dynptr_type = arg_to_dynptr_type(arg_type);
> -
> -	return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> +	if (reg->type == CONST_PTR_TO_DYNPTR) {
> +		return reg->dynptr.type == dynptr_type;
> +	} else {
> +		spi = get_spi(reg->off);
> +		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> +	}
>  }
>  
>  /* The reg state of a pointer or a bounded scalar was saved when
> @@ -1317,9 +1346,6 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
>  	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
>  };
>  
> -static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> -				struct bpf_reg_state *reg);
> -
>  /* This helper doesn't clear reg->id */
>  static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>  {
> @@ -1382,6 +1408,25 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
>  	__mark_reg_known_zero(regs + regno);
>  }
>  
> +static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
> +			       struct bpf_reg_state *reg2,
> +			       enum bpf_dynptr_type type)
> +{
> +	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
> +	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR.
> +	 */

Meh, this is mildly confusing. Please correct me if my understanding is wrong,
but the reason this is the case is that we only set the struct bpf_reg_state
from the stack, whereas the actual reg itself of course has PTR_TO_STACK. If
that's the case, can we go into just a bit more detail here in this comment
about what's going on? It's kind of confusing that we have an actual register
of type PTR_TO_STACK, which points to stack register state of (inconsequential)
type CONST_PTR_TO_DYNPTR. It's also kind of weird (but also inconsequential)
that we have dynptr.first_slot for CONST_PTR_TO_DYNPTR.

Just my two cents as well, but even if the field isn't really used for
anything, I would still add an additional enum bpf_reg_type parameter that sets
this to STACK_DYNPTR, with a comment that says it's currently only used by
CONST_PTR_TO_DYNPTR registers.

> +	__mark_reg_known_zero(reg1);
> +	reg1->type = CONST_PTR_TO_DYNPTR;
> +	reg1->dynptr.type = type;
> +	reg1->dynptr.first_slot = true;
> +	if (!reg2)
> +		return;
> +	__mark_reg_known_zero(reg2);
> +	reg2->type = CONST_PTR_TO_DYNPTR;
> +	reg2->dynptr.type = type;
> +	reg2->dynptr.first_slot = false;
> +}
> +
>  static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>  {
>  	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
> @@ -5571,19 +5616,62 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>  	return 0;
>  }
>  
> +/* Implementation details:
> + *
> + * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
> + * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
> + *
> + * In both cases we deal with the first 8 bytes, but need to mark the next 8
> + * bytes as STACK_DYNPTR in case of PTR_TO_STACK. In case of
> + * CONST_PTR_TO_DYNPTR, we are guaranteed to get the beginning of the object.
> + *
> + * Mutability of bpf_dynptr is at two levels, one is at the level of struct
> + * bpf_dynptr itself, i.e. whether the helper is receiving a pointer to struct
> + * bpf_dynptr or pointer to const struct bpf_dynptr. In the former case, it can
> + * mutate the view of the dynptr and also possibly destroy it. In the latter
> + * case, it cannot mutate the bpf_dynptr itself but it can still mutate the
> + * memory that dynptr points to.
> + *
> + * The verifier will keep track both levels of mutation (bpf_dynptr's in
> + * reg->type and the memory's in reg->dynptr.type), but there is no support for
> + * readonly dynptr view yet, hence only the first case is tracked and checked.
> + *
> + * This is consistent with how C applies the const modifier to a struct object,
> + * where the pointer itself inside bpf_dynptr becomes const but not what it
> + * points to.
> + *
> + * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
> + * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
> + */
>  int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>  			enum bpf_arg_type arg_type, int argno,
>  			u8 *uninit_dynptr_regno)
>  {
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>  
> -	/* We only need to check for initialized / uninitialized helper
> -	 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> -	 * assumption is that if it is, that a helper function
> -	 * initialized the dynptr on behalf of the BPF program.
> +	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
> +		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
> +		return -EFAULT;
> +	}
> +
> +	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
> +	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> +	 *
> +	 *  MEM_UNINIT - Points to memory that is an appropriate candidate for
> +	 *		 constructing a mutable bpf_dynptr object.
> +	 *
> +	 *		 Currently, this is only possible with PTR_TO_STACK
> +	 *		 pointing to a region of atleast 16 bytes which doesn't
> +	 *		 contain an existing bpf_dynptr.
> +	 *
> +	 *  MEM_RDONLY - Points to a initialized bpf_dynptr that will not be
> +	 *		 mutated or destroyed. However, the memory it points to
> +	 *		 may be mutated.
> +	 *
> +	 *  None       - Points to a initialized dynptr that can be mutated and
> +	 *		 destroyed, including mutation of the memory it points
> +	 *		 to.
>  	 */
> -	if (base_type(reg->type) == PTR_TO_DYNPTR)
> -		return 0;
>  	if (arg_type & MEM_UNINIT) {
>  		if (!is_dynptr_reg_valid_uninit(env, reg)) {
>  			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -5597,9 +5685,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>  			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
>  			return -EFAULT;
>  		}
> -
>  		*uninit_dynptr_regno = regno;
>  	} else {
> +		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
> +		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
> +			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
> +			return -EINVAL;
> +		}
> +
>  		if (!is_dynptr_reg_valid_init(env, reg)) {
>  			verbose(env,
>  				"Expected an initialized dynptr as arg #%d\n",
> @@ -5607,6 +5700,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>  			return -EINVAL;
>  		}
>  
> +		arg_type &= ~MEM_RDONLY;
>  		if (!is_dynptr_type_expected(env, reg, arg_type)) {
>  			const char *err_extra = "";
>  
> @@ -5762,7 +5856,7 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
>  static const struct bpf_reg_types dynptr_types = {
>  	.types = {
>  		PTR_TO_STACK,
> -		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
> +		CONST_PTR_TO_DYNPTR,
>  	}
>  };
>  
> @@ -5938,12 +6032,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  }
>  
> -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>  	struct bpf_func_state *state = func(env, reg);
> -	int spi = get_spi(reg->off);
> +	int spi;
>  
> -	return state->stack[spi].spilled_ptr.id;
> +	if (reg->type == CONST_PTR_TO_DYNPTR)
> +		return reg->ref_obj_id;
> +	spi = get_spi(reg->off);
> +	return state->stack[spi].spilled_ptr.ref_obj_id;
>  }
>  
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> @@ -6007,11 +6104,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  	if (arg_type_is_release(arg_type)) {
>  		if (arg_type_is_dynptr(arg_type)) {
>  			struct bpf_func_state *state = func(env, reg);
> -			int spi = get_spi(reg->off);
> +			int spi;
>  
> -			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> -			    !state->stack[spi].spilled_ptr.id) {
> -				verbose(env, "arg %d is an unacquired reference\n", regno);
> +			if (reg->type == PTR_TO_STACK) {
> +				spi = get_spi(reg->off);
> +				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> +				    !state->stack[spi].spilled_ptr.ref_obj_id) {
> +					verbose(env, "arg %d is an unacquired reference\n", regno);
> +					return -EINVAL;
> +				}
> +			} else {
> +				verbose(env, "cannot release unowned const bpf_dynptr\n");
>  				return -EINVAL;
>  			}
>  		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
> @@ -6946,11 +7049,10 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
>  {
>  	/* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
>  	 *			  callback_ctx, u64 flags);
> -	 * callback_fn(struct bpf_dynptr_t* dynptr, void *callback_ctx);
> +	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
>  	 */
>  	__mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
> -	callee->regs[BPF_REG_1].type = PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL;
> -	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	mark_dynptr_cb_reg(&callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
>  	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
>  
>  	/* unused */
> @@ -7328,6 +7430,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  
>  	regs = cur_regs(env);
>  
> +	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> +	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
> +	 * is safe to do.
> +	 */
>  	if (meta.uninit_dynptr_regno) {
>  		/* we write BPF_DW bits (8 bytes) at a time */
>  		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
> @@ -7346,6 +7452,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  
>  	if (meta.release_regno) {
>  		err = -EINVAL;
> +		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> +		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
> +		 * is safe to do.
> +		 */
>  		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
>  			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
>  		else if (meta.ref_obj_id)
> @@ -7428,11 +7538,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  					return -EFAULT;
>  				}
>  
> -				if (base_type(reg->type) != PTR_TO_DYNPTR)
> -					/* Find the id of the dynptr we're
> -					 * tracking the reference of
> -					 */
> -					meta.ref_obj_id = stack_slot_get_id(env, reg);
> +				/* Find the id of the dynptr we're
> +				 * tracking the reference of
> +				 */

I think this can be brought onto one line now.

> +				meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
>  				break;
>  			}
>  		}

[...]

Overall this looks great. Thanks again for working on this. I'd love to hear
Andrii and/or Joanne's thoughts, but overall this looks good and like a solid
improvement (both in terms of fixing 205715673844 ("bpf: Add
bpf_user_ringbuf_drain() helper"), and in terms of the right direction for
dynptrs architecturally).

Thanks,
David
