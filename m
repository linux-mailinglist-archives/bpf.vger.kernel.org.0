Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD46315A1
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKTSHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKTSHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:07:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38632C659
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:07:03 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 130so9387330pfu.8
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COybZMF8BX9031g6+17GNjVVyKY7jhWZnu9LeXu1UTw=;
        b=Dz1SEhsElva6BljirFj/SqNlL7QBWu3vBPPGiAVFYX9sBkKuBxME9DhMMgq7qfgcQa
         I/XCbAjM+njCzYo5/5MR8Q0UHV2Ql84vFT0hGT236qE5BhZOfoLUacuIyIlXH4todSVq
         N6DaLBM27DnU57ivA9wPVWbTtgHEkKp+tHkK3AyE9gDkAjUiSgFEq0KlD/2dDFwdW8nX
         IGJEujGg5CQLORWf/ei0K+jlgEyUXncdyFtR6BSLS/69xeihXFiG7OADxwM3MFjAoX5U
         yqe4fXndrRSDY0VEYkigt67Vat1MGyj5mfu+tiz6lxAx07OlOS6dUwU0r8Ne9C1A1J5m
         XReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COybZMF8BX9031g6+17GNjVVyKY7jhWZnu9LeXu1UTw=;
        b=evLOZDajR8xW6KNuEbSku72AuZrsqu7RvjTW9xtIt7R3/Jsn7882Aw4/JmHCQCenK4
         JbXvFY10udvITUItcWCinOtViqJ67O2ZaooC14yN9yqH45t8TUV7FN8EtcpXglc4SWPf
         PbRfoSI85fPvsb1Re8ebSN/WQUVOdp/iiYVxcgNcW2STOErgcPCKmubvNfCe05JBwR/i
         gCRkB/gaJsU43cLQ0PwVsgZeInuTqT0QylCBYkeOFp0KD7S2oq75sem5DKIoV7Qtia60
         O5jRzSQRkBZ6MGe5BmMNnpbbWE/sv+tCH9U1PSB8YFm3cRY+TuTb6QC8Dn89FyjJPX5+
         EzQQ==
X-Gm-Message-State: ANoB5pkVggxAckcPPTmv9lDxP0DWO7JzcW3ITusilR0dyvASggqybHS0
        EuZOGuDSFUaUN5Dijb3SeIJOh6AN2rM=
X-Google-Smtp-Source: AA0mqf4cmQCwtZaEGCGVc7q/Rd/3w35S5FH1nrZsZYUjuFg9ZhqgFUut2PuEoVbQWjilhosjmzdDUg==
X-Received: by 2002:a63:54d:0:b0:461:8b6a:fe30 with SMTP id 74-20020a63054d000000b004618b6afe30mr14222212pgf.267.1668967623040;
        Sun, 20 Nov 2022 10:07:03 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 21-20020a621615000000b00572552feef3sm6949222pfw.51.2022.11.20.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 10:07:02 -0800 (PST)
Date:   Sun, 20 Nov 2022 23:36:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Rework process_dynptr_func
Message-ID: <20221120180651.5zhi62yjsdgzqbyk@apollo>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-4-memxor@gmail.com>
 <Y3ajnSVA20j3o/16@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ajnSVA20j3o/16@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 02:41:57AM IST, David Vernet wrote:
> On Tue, Nov 15, 2022 at 05:31:26AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Recently, user ringbuf support introduced a PTR_TO_DYNPTR register type
> > for use in callback state, because in case of user ringbuf helpers,
> > there is no dynptr on the stack that is passed into the callback. To
> > reflect such a state, a special register type was created.
> >
> > However, some checks have been bypassed incorrectly during the addition
> > of this feature. First, for arg_type with MEM_UNINIT flag which
> > initialize a dynptr, they must be rejected for such register type.
> > Secondly, in the future, there are plans to add dynptr helpers that
> > operate on the dynptr itself and may change its offset and other
> > properties.
> >
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
> > not the dynptr itself. In C parlance, it would be equivalent to taking
> > the dynptr as a point to const argument.
> >
> > When either of these flags are not present, the helper is allowed to
> > mutate both the dynptr itself and also the memory it points to.
> > Currently, the read only status of the memory is not tracked in the
> > dynptr, but it would be trivial to add this support inside dynptr state
> > of the register.
> >
> > With these changes and renaming PTR_TO_DYNPTR to CONST_PTR_TO_DYNPTR to
> > better reflect its usage, it can no longer be passed to helpers that
> > initialize a dynptr, i.e. bpf_dynptr_from_mem, bpf_ringbuf_reserve_dynptr.
> >
> > A note to reviewers is that in code that does mark_stack_slots_dynptr,
> > and unmark_stack_slots_dynptr, we implicitly rely on the fact that
> > PTR_TO_STACK reg is the only case that can reach that code path, as one
> > cannot pass CONST_PTR_TO_DYNPTR to helpers that don't set MEM_RDONLY. In
> > both cases such helpers won't be setting that flag.
> >
> > The next patch will add a couple of selftest cases to make sure this
> > doesn't break.
> >
> > Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Overall this LGTM. Left some comments / nits before stamping.
> [...]
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index d02ae2f4249b..ba3b50895f6b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6568,14 +6568,15 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  				}
> >
> >  				if (arg_dynptr) {
> > -					if (reg->type != PTR_TO_STACK) {
> > -						bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
> > +					if (reg->type != PTR_TO_STACK &&
> > +					    reg->type != CONST_PTR_TO_DYNPTR) {
> > +						bpf_log(log, "arg#%d pointer type %s %s not to stack or dynptr\n",
> >  							i, btf_type_str(ref_t),
> >  							ref_tname);
> >  						return -EINVAL;
> >  					}
>
> Should we bring this check into process_dynptr_func()? It's kind of
> unfortunate that we have divergent logic between helpers and kfuncs,
> when it comes to checking types. Let's at least be uniform here?
>

Maybe. This is just a hardcoded version of check_reg_type for arg_dynptr.
process_dynptr_func can then just assume it only gets called with these two
register types in case of helpers or kfuncs. You would then just be repeating
the same check for check_helper_call inside process_dynptr_func.

So yes, we have to repeat the check differently here, but we're still a few
refactorings away before we can reasonably share code directly between
check_helper_call and check_kfunc_call. kfunc support has grown organically, it
was never meant to do all this. The recent refactor is one step in that
direction.

> > [...]
> > +/* Implementation details:
>
> I don't think "Implementation details" is necessary to include in the
> function header (and thank you for adding this header btw).
>

Ack.

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
> > -			enum bpf_arg_type arg_type,
> > -			struct bpf_call_arg_meta *meta)
> > +			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
> >  {
> >  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> >  	int argno = regno - 1;
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
>
> s/applied to a/applied to an
>

Ack.

> > +	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> > +	 *
> > +	 *  MEM_UNINIT - Points to memory that is an appropriate candidate for
> > +	 *		 constructing a mutable bpf_dynptr object.
> > +	 *
> > +	 *		 Currently, this is only possible with PTR_TO_STACK
> > +	 *		 pointing to a region of atleast 16 bytes which doesn't
>
> s/atleast/at least
>

Ack.

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
>
> Not your change, but this is an awkwardly phrased error message. IMO
> "dynptr must be initialized" is more succinct. Feel free to ignore if
> you'd like, I'm happy to submit a separate patch to change it as some
> point.
>

Feel free to, since I think unrelated changes should not be mixed in this patch.

> > @@ -5722,6 +5808,12 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >
> >  		meta->uninit_dynptr_regno = regno;
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
> > @@ -5729,6 +5821,8 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >  			return -EINVAL;
> >  		}
> >
> > +		/* Fold MEM_RDONLY, only inspect arg_type */
> > +		arg_type &= ~MEM_RDONLY;
>
> This seems brittle. Can is_dynptr_type_expected() just check the base
> type?
>

Yeah, it can. I'll switch it.

> >  		if (!is_dynptr_type_expected(env, reg, arg_type)) {
> >  			const char *err_extra = "";
> >
> > @@ -5874,7 +5968,7 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
> >  static const struct bpf_reg_types dynptr_types = {
> >  	.types = {
> >  		PTR_TO_STACK,
> > -		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
> > +		CONST_PTR_TO_DYNPTR,
> >  	}
> >  };
> >
> > @@ -6050,12 +6144,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
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
> > @@ -6119,11 +6216,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >  	if (arg_type_is_release(arg_type)) {
> >  		if (arg_type_is_dynptr(arg_type)) {
> >  			struct bpf_func_state *state = func(env, reg);
> > -			int spi = get_spi(reg->off);
> > +			int spi;
> >
> > -			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > -			    !state->stack[spi].spilled_ptr.id) {
> > -				verbose(env, "arg %d is an unacquired reference\n", regno);
>
> Can we add a comment here explaining why only PTR_TO_STACK dynptrs are
> expected to be released? I know we have such comments elsewhere already,
> but if we're going to have logic like this which is hard-coded against
> assumptions of what types of dynptrs can be used in which contexts /
> helpers, I think it is important to be verbose in calling that out as
> it's not obvious from the code itself why this is the case.
>

Sure, but you mean a code comment, right?

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
> > @@ -7091,11 +7194,10 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
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
> > @@ -7474,7 +7576,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >
> >  	regs = cur_regs(env);
> >
> > +	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> > +	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
> > +	 * is safe to do directly.
> > +	 */
> >  	if (meta.uninit_dynptr_regno) {
> > +		if (WARN_ON_ONCE(regs[meta.uninit_dynptr_regno].type == CONST_PTR_TO_DYNPTR))
>
> I think we tend to do "verifier internal error" logs for situations like
> this rather than WARN_ON_ONCE(), right?
>

Yeah, I'll switch it.

> > +			return -EFAULT;
> >  		/* we write BPF_DW bits (8 bytes) at a time */
> >  		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
> >  			err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
> > @@ -7492,15 +7600,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >
> >  	if (meta.release_regno) {
> >  		err = -EINVAL;
> > -		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
> > +		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> > +		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
> > +		 * is safe to do directly.
> > +		 */
> > +		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
> > +			if (WARN_ON_ONCE(regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR))
>
> Same here r.e. using verifier log rather than WARN_ON_ONCE(). Also, can
> we bring this comment inside the if statement to match the alignemnt of
> the one you added below?
>

Ack.

> > +				return -EFAULT;
> >  			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> > -		else if (meta.ref_obj_id)
> > +		} else if (meta.ref_obj_id) {
> >  			err = release_reference(env, meta.ref_obj_id);
> > -		/* meta.ref_obj_id can only be 0 if register that is meant to be
> > -		 * released is NULL, which must be > R0.
> > -		 */
> > -		else if (register_is_null(&regs[meta.release_regno]))
> > +		} else if (register_is_null(&regs[meta.release_regno])) {
> > +			/* meta.ref_obj_id can only be 0 if register that is meant to be
> > +			 * released is NULL, which must be > R0.
> > +			 */
> >  			err = 0;
> > +		}
> >  		if (err) {
> >  			verbose(env, "func %s#%d reference has not been acquired before\n",
> >  				func_id_name(func_id), func_id);
> > @@ -7574,11 +7689,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  					return -EFAULT;
> >  				}
> >
> > -				if (base_type(reg->type) != PTR_TO_DYNPTR)
> > -					/* Find the id of the dynptr we're
> > -					 * tracking the reference of
> > -					 */
> > -					meta.ref_obj_id = stack_slot_get_id(env, reg);
> > +				/* Find the id of the dynptr we're tracking the reference of */
>
> Not your change, but IMO this comment does not add any value.
>

Ok, I'll drop it.
