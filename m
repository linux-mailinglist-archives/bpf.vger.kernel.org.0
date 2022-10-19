Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198A96039AC
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 08:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJSGSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 02:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJSGSj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 02:18:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC1604B1
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:18:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so19612574pjq.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kGvGbT3PZOtUPJehj8ESqcSipHPYEFn1PbEhSRpugk=;
        b=X/yiCwNbFkE1WTPzTw2S6F0Saf6eOMMzDW+RmgTYDM4XBIfNsuB2Wl1pVcG9vJ2yNU
         MiEaPHPupF2kWAz1vUIiLllcXX8Hex4J8F0f6rn2n23fAb66ug0dxwFQG5VlDT7cw6Y+
         9NLxewtGwIswrNtZH4sBkqYK0cN/OwwwzjJBHIn9FPPWpnjvOVQnEXq3lJiOMfuNEJcs
         3gl1zXZItaaQUXpqlJ0MLtqjMV2gNauXXre/d3G53L/M38xLds6CPoSFyyIogYSA3hqt
         eFhMVkMQU44d3hq0ApGKlpkq/rYwGzFBOKICtXjLC5plImoYs/z+0Af2m27iChHpAju2
         3uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kGvGbT3PZOtUPJehj8ESqcSipHPYEFn1PbEhSRpugk=;
        b=LPtxNGogUMkizUUVhJf8e43ynFj5TnQZsspg0uMa1ENXRWKv4kjT84wtnh8SXp0DDN
         NhypUFf4jdM7/hmz/W38H6/Gm/guQ8cTs67KPfycz4tU0kVf3IbQiRxZefe5UvHtuade
         CsihtUjxN5/OFG3RB4/5aJETAGv5HjunCFyLUnGxVS624VNJ6l2qcy0EfpUQM/k9KHvz
         CfRYNPbYb8hZFHBXoAC9GjyYF6+Gh8UGTSaECS4blxuGN9b7Kq54XyMLkLaDTPnXL8ge
         9iu5hE6smq2+r1hVi2i6DC8tcDOmU+R38FA9upmjaqVhkUtctts9C9BdU+cwGr8EIKrZ
         +wSQ==
X-Gm-Message-State: ACrzQf2f2wu5QWgSwFLxPF1FY2pG7Ij5Rj7pwFOI9hnPlB7aquuDc4Qt
        d4edaJ3JzPEpo3EQnZNZo67RNiVMqO8jqw==
X-Google-Smtp-Source: AMsMyM6EvSBxj65ssNihxB2DY9B1yw/kKN0oa7QmIRp2v99jxiYsmK78QhXnWCqwf6rczHXEM1B2FA==
X-Received: by 2002:a17:902:e890:b0:185:4ac7:9757 with SMTP id w16-20020a170902e89000b001854ac79757mr6907223plg.150.1666160316917;
        Tue, 18 Oct 2022 23:18:36 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id x14-20020a63484e000000b00463cd99cdb7sm9072889pgk.50.2022.10.18.23.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:18:36 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:48:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/13] bpf: Rework process_dynptr_func
Message-ID: <20221019061821.4cpls2alap74uppu@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-3-memxor@gmail.com>
 <Y08z6U1iAcv4IwDY@maniforge.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08z6U1iAcv4IwDY@maniforge.DHCP.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 04:46:57AM IST, David Vernet wrote:
> On Tue, Oct 18, 2022 at 07:29:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Recently, user ringbuf support introduced a PTR_TO_DYNPTR register type
> > for use in callback state, because in case of user ringbuf helpers,
> > there is no dynptr on the stack that is passed into the callback. To
> > reflect such a state, a special register type was created.
> >
> > However, some checks have been bypassed incorrectly during the addition
> > of this feature. First, for arg_type with MEM_UNINIT flag which
> > initialize a dynptr, they must be rejected for such register type.
>
> Ahhh, great point. Thanks a lot for catching this.
>
> > Secondly, in the future, there are plans to dynptr helpers that operate
> > on the dynptr itself and may change its offset and other properties.
>
> small nit: s/to dynptr helpers/to add dynptr helpers
>

Ack.

> > In all of these cases, PTR_TO_DYNPTR shouldn't be allowed to be passed
> > to such helpers, however the current code simply returns 0.
> >
> > The rejection for helpers that release the dynptr is already handled.
> >
> > For fixing this, we take a step back and rework existing code in a way
> > that will allow fitting in all classes of helpers and have a coherent
> > model for dealing with the variety of use cases in which dynptr is used.
> >
> > First, for ARG_PTR_TO_DYNPTR, it can either be set alone or together
> > with a DYNPTR_TYPE_* constant that denotes the only type it accepts.
> >
> > Next, helpers which initialize a dynptr use MEM_UNINIT to indicate this
> > fact. To make the distinction clear, use MEM_RDONLY flag to indicate
> > that the helper only operates on the memory pointed to by the dynptr,
>
> Hmmm, it feels a bit confusing to overload MEM_RDONLY like this. I
> understand the intention (which is logical) to imply that the pointer to
> the dynptr is read only, but the fact that the memory contained in the
> dynptr may not be read only will doubtless confuse people.
>
> I don't really have a better suggestion. This is the proper use of
> MEM_RDONLY, but it really feels super confusing. I guess this is
> somewhat mitigated by the fact that the read-only nature of the dynptr
> is something that will be validated at runtime?
>

Nope, both dynptr's const-ness and const-ness of the memory it points to are
supposed to be tracked statically. It's part of the type of the dynptr.

The second case doesn't exist yet, but will soon (with skb dynptrs abstracting
over read only __sk_buff ctx).

So what MEM_RDONLY in argument type really means is that I take a pointer to
const struct bpf_dynptr, which means I can't modify the struct bpf_dynptr itself
(so it's size, offset, ptr, etc.), but that is independent of r/w state of what
it points to.

const T *p vs T *const p

In this case it's the latter. Soon we will also support const T *const p.

Hence, MEM_RDONLY is at the argument type level, translating to reg->type, and
the read only status for the dynptr's memory slice will be part of dynptr
specific register state (dynptr.type).

But I am open to more suggestions on how to write this stuff, if it makes the
code easier to read.

> >  [...]
> >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >  	struct bpf_func_state *state = func(env, reg);
> > -	int spi = get_spi(reg->off);
> > -	int i;
> > +	int spi, i;
> >
> > +	if (reg->type == CONST_PTR_TO_DYNPTR)
> > +		return false;
> > +
> > +	spi = get_spi(reg->off);
> >  	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> >  		return true;
> >
> > @@ -785,9 +803,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> >  static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >  	struct bpf_func_state *state = func(env, reg);
> > -	int spi = get_spi(reg->off);
> > +	int spi;
> >  	int i;
> >
> > +	/* This already represents first slot of initialized bpf_dynptr */
> > +	if (reg->type == CONST_PTR_TO_DYNPTR)
> > +		return true;
> > +
> > +	spi = get_spi(reg->off);
> >  	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> >  	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
> >  		return false;
> > @@ -806,15 +829,21 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
> >  {
> >  	struct bpf_func_state *state = func(env, reg);
> >  	enum bpf_dynptr_type dynptr_type;
> > -	int spi = get_spi(reg->off);
> > +	int spi;
> >
> > +	/* Fold MEM_RDONLY, caller already checked it */
> > +	arg_type &= ~MEM_RDONLY;
>
> This is already done in the caller, I think it can just be removed?
>

Right, I was first doing it inside, but then I moved it out and forgot to remove
this hunk.

> >  	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> >  	if (arg_type == ARG_PTR_TO_DYNPTR)
> >  		return true;
> >
> >  	dynptr_type = arg_to_dynptr_type(arg_type);
> > -
> > -	return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> > +	if (reg->type == CONST_PTR_TO_DYNPTR) {
> > +		return reg->dynptr.type == dynptr_type;
> > +	} else {
> > +		spi = get_spi(reg->off);
> > +		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> > +	}
> >  }
> >
> >  /* The reg state of a pointer or a bounded scalar was saved when
> > @@ -1317,9 +1346,6 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
> >  	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
> >  };
> >
> > -static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> > -				struct bpf_reg_state *reg);
> > -
> >  /* This helper doesn't clear reg->id */
> >  static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
> >  {
> > @@ -1382,6 +1408,25 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
> >  	__mark_reg_known_zero(regs + regno);
> >  }
> >
> > +static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
> > +			       struct bpf_reg_state *reg2,
> > +			       enum bpf_dynptr_type type)
> > +{
> > +	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
> > +	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR.
> > +	 */
>
> Meh, this is mildly confusing. Please correct me if my understanding is wrong,
> but the reason this is the case is that we only set the struct bpf_reg_state
> from the stack, whereas the actual reg itself of course has PTR_TO_STACK. If
> that's the case, can we go into just a bit more detail here in this comment
> about what's going on? It's kind of confusing that we have an actual register
> of type PTR_TO_STACK, which points to stack register state of (inconsequential)
> type CONST_PTR_TO_DYNPTR. It's also kind of weird (but also inconsequential)
> that we have dynptr.first_slot for CONST_PTR_TO_DYNPTR.
>

There are two cases which this function is called for, one is for the
spilled registers for dynptr on the stack. In that case it *is* the dynptr, so
reg->type as CONST_PTR_TO_DYNPTR is meaningless/wrong, and not checked. The type
is already part of slot_type == STACK_DYNPTR.

We reuse spilled_reg part of stack state to store info about the dynptr. We need
two spilled_regs to fully track it.

Later, we will have more owned objects on the stack (bpf_list_head, bpf_rb_root)
where you splice it out. Their handling will have to be similar.

PTR_TO_STACK points to the slots whose spilled registers we will call this
function for. That is different from the second case, i.e. for callback R1,
where it will be CONST_PTR_TO_DYNPTR. For consistency, I marked it as first_slot
because we always work using the first dynptr slot.

So to summarize:

PTR_TO_STACK points to bpf_dynptr on stack. So we store this info as 2 spilled
registers on the stack. In that case both of them are the first and second slot
of the dynptr (8-bytes each). They are the actual dynptr object.

In second case we set dynptr state on the reg itself, which points to actual
dynptr object. The reference now records the information we need about the
object.

Yes, it is a bit confusing, and again, I'm open to better ideas. The
difference/confusion is mainly because of different places where state is
tracked. For the stack we track it in stack state precisely, for
CONST_PTR_TO_DYNPTR it is recorded in the pointer to dynptr object.

> Just my two cents as well, but even if the field isn't really used for
> anything, I would still add an additional enum bpf_reg_type parameter that sets
> this to STACK_DYNPTR, with a comment that says it's currently only used by
> CONST_PTR_TO_DYNPTR registers.
>
> > +	__mark_reg_known_zero(reg1);
> > +	reg1->type = CONST_PTR_TO_DYNPTR;
> > +	reg1->dynptr.type = type;
> > +	reg1->dynptr.first_slot = true;
> > +	if (!reg2)
> > +		return;
> > +	__mark_reg_known_zero(reg2);
> > +	reg2->type = CONST_PTR_TO_DYNPTR;
> > +	reg2->dynptr.type = type;
> > +	reg2->dynptr.first_slot = false;
> > +}
> > +
> >  static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
> >  {
> >  	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
> > @@ -5571,19 +5616,62 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> >  	return 0;
> >  }
> >
> > +/* Implementation details:
> > + *
> > + * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
> > + * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
> > + *
> > + * In both cases we deal with the first 8 bytes, but need to mark the next 8
> > + * bytes as STACK_DYNPTR in case of PTR_TO_STACK. In case of
> > + * CONST_PTR_TO_DYNPTR, we are guaranteed to get the beginning of the object.
> > + *
> > + * Mutability of bpf_dynptr is at two levels, one is at the level of struct
> > + * bpf_dynptr itself, i.e. whether the helper is receiving a pointer to struct
> > + * bpf_dynptr or pointer to const struct bpf_dynptr. In the former case, it can
> > + * mutate the view of the dynptr and also possibly destroy it. In the latter
> > + * case, it cannot mutate the bpf_dynptr itself but it can still mutate the
> > + * memory that dynptr points to.
> > + *
> > + * The verifier will keep track both levels of mutation (bpf_dynptr's in
> > + * reg->type and the memory's in reg->dynptr.type), but there is no support for
> > + * readonly dynptr view yet, hence only the first case is tracked and checked.
> > + *
> > + * This is consistent with how C applies the const modifier to a struct object,
> > + * where the pointer itself inside bpf_dynptr becomes const but not what it
> > + * points to.
> > + *
> > + * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
> > + * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
> > + */
> >  int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >  			enum bpf_arg_type arg_type, int argno,
> >  			u8 *uninit_dynptr_regno)
> >  {
> >  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> >
> > -	/* We only need to check for initialized / uninitialized helper
> > -	 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> > -	 * assumption is that if it is, that a helper function
> > -	 * initialized the dynptr on behalf of the BPF program.
> > +	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
> > +		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
> > +	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> > +	 *
> > +	 *  MEM_UNINIT - Points to memory that is an appropriate candidate for
> > +	 *		 constructing a mutable bpf_dynptr object.
> > +	 *
> > +	 *		 Currently, this is only possible with PTR_TO_STACK
> > +	 *		 pointing to a region of atleast 16 bytes which doesn't
> > +	 *		 contain an existing bpf_dynptr.
> > +	 *
> > +	 *  MEM_RDONLY - Points to a initialized bpf_dynptr that will not be
> > +	 *		 mutated or destroyed. However, the memory it points to
> > +	 *		 may be mutated.
> > +	 *
> > +	 *  None       - Points to a initialized dynptr that can be mutated and
> > +	 *		 destroyed, including mutation of the memory it points
> > +	 *		 to.
> >  	 */
> > -	if (base_type(reg->type) == PTR_TO_DYNPTR)
> > -		return 0;
> >  	if (arg_type & MEM_UNINIT) {
> >  		if (!is_dynptr_reg_valid_uninit(env, reg)) {
> >  			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> > @@ -5597,9 +5685,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >  			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> >  			return -EFAULT;
> >  		}
> > -
> >  		*uninit_dynptr_regno = regno;
> >  	} else {
> > +		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
> > +		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
> > +			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
> > +			return -EINVAL;
> > +		}
> > +
> >  		if (!is_dynptr_reg_valid_init(env, reg)) {
> >  			verbose(env,
> >  				"Expected an initialized dynptr as arg #%d\n",
> > @@ -5607,6 +5700,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >  			return -EINVAL;
> >  		}
> >
> > +		arg_type &= ~MEM_RDONLY;
> >  		if (!is_dynptr_type_expected(env, reg, arg_type)) {
> >  			const char *err_extra = "";
> >
> > @@ -5762,7 +5856,7 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
> >  static const struct bpf_reg_types dynptr_types = {
> >  	.types = {
> >  		PTR_TO_STACK,
> > -		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
> > +		CONST_PTR_TO_DYNPTR,
> >  	}
> >  };
> >
> > @@ -5938,12 +6032,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> >  }
> >
> > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >  	struct bpf_func_state *state = func(env, reg);
> > -	int spi = get_spi(reg->off);
> > +	int spi;
> >
> > -	return state->stack[spi].spilled_ptr.id;
> > +	if (reg->type == CONST_PTR_TO_DYNPTR)
> > +		return reg->ref_obj_id;
> > +	spi = get_spi(reg->off);
> > +	return state->stack[spi].spilled_ptr.ref_obj_id;
> >  }
> >
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > @@ -6007,11 +6104,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >  	if (arg_type_is_release(arg_type)) {
> >  		if (arg_type_is_dynptr(arg_type)) {
> >  			struct bpf_func_state *state = func(env, reg);
> > -			int spi = get_spi(reg->off);
> > +			int spi;
> >
> > -			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > -			    !state->stack[spi].spilled_ptr.id) {
> > -				verbose(env, "arg %d is an unacquired reference\n", regno);
> > +			if (reg->type == PTR_TO_STACK) {
> > +				spi = get_spi(reg->off);
> > +				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > +				    !state->stack[spi].spilled_ptr.ref_obj_id) {
> > +					verbose(env, "arg %d is an unacquired reference\n", regno);
> > +					return -EINVAL;
> > +				}
> > +			} else {
> > +				verbose(env, "cannot release unowned const bpf_dynptr\n");
> >  				return -EINVAL;
> >  			}
> >  		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
> > @@ -6946,11 +7049,10 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
> >  {
> >  	/* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
> >  	 *			  callback_ctx, u64 flags);
> > -	 * callback_fn(struct bpf_dynptr_t* dynptr, void *callback_ctx);
> > +	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
> >  	 */
> >  	__mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
> > -	callee->regs[BPF_REG_1].type = PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL;
> > -	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> > +	mark_dynptr_cb_reg(&callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
> >  	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
> >
> >  	/* unused */
> > @@ -7328,6 +7430,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >
> >  	regs = cur_regs(env);
> >
> > +	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> > +	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
> > +	 * is safe to do.
> > +	 */
> >  	if (meta.uninit_dynptr_regno) {
> >  		/* we write BPF_DW bits (8 bytes) at a time */
> >  		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
> > @@ -7346,6 +7452,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >
> >  	if (meta.release_regno) {
> >  		err = -EINVAL;
> > +		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> > +		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
> > +		 * is safe to do.
> > +		 */
> >  		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
> >  			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> >  		else if (meta.ref_obj_id)
> > @@ -7428,11 +7538,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  					return -EFAULT;
> >  				}
> >
> > -				if (base_type(reg->type) != PTR_TO_DYNPTR)
> > -					/* Find the id of the dynptr we're
> > -					 * tracking the reference of
> > -					 */
> > -					meta.ref_obj_id = stack_slot_get_id(env, reg);
> > +				/* Find the id of the dynptr we're
> > +				 * tracking the reference of
> > +				 */
>
> I think this can be brought onto one line now.
>

Ack.

> > +				meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
> >  				break;
> >  			}
> >  		}
>
> [...]
>
> Overall this looks great. Thanks again for working on this. I'd love to hear
> Andrii and/or Joanne's thoughts, but overall this looks good and like a solid
> improvement (both in terms of fixing 205715673844 ("bpf: Add
> bpf_user_ringbuf_drain() helper"), and in terms of the right direction for
> dynptrs architecturally).
>

Thanks for the reviews!
