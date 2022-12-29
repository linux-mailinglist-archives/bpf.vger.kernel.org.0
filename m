Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B796589C0
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 07:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiL2GkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 01:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiL2GkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 01:40:08 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A4BE04
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 22:40:06 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id bp44so11761825qtb.0
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 22:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFtqKMhMcQb76PWxOqyL1oFpXf5xYx46WNplY5qdfuE=;
        b=Cr+WSQ36ddIswbA/kNskrPG/zBg8fnNcG2138+IhbxDQzulqQgDk8DoG3JKbvS+xXr
         +OMUi9ikfaJAi/WQFWTlm3VSe1IrXE4wj3t9SL+Rd6i9MzkcaIBXurR2C4dztF1m+0+s
         ijgZPXaSdOZsdroGRa812sXVM+7196leOwt4egEh/lj/wYBQIQHV6/UXBp4xDDuUu0SY
         YwB0mHN98xF9QBcKDUR9IA/fRmGuknMWfu2Mcn34z+8Y8lPo3N3zEer3w0YJT2ah8Vli
         Ha5SFQaILfmSv332/WJkiQWmNnLbQbKmYPW+L8AlPPSGBZpwYOh46zCUZVrYtUiGVh7g
         u7EA==
X-Gm-Message-State: AFqh2koP9nfFmVbwxPUaE3rWYg0I9YPjr9HMwV0Yvgvd5sFz9qg+3Sk1
        fE87oBRCH/b3tgFvES7wXRw=
X-Google-Smtp-Source: AMrXdXuqb24gi5vZDUZ+AW1XYslHq2G9L0R487gGomIf7Y+f+KfAFmQJ6uPx52AvYhAhWsp0UGIrUQ==
X-Received: by 2002:ac8:5406:0:b0:3a6:930b:b3b1 with SMTP id b6-20020ac85406000000b003a6930bb3b1mr39882613qtq.20.1672296005601;
        Wed, 28 Dec 2022 22:40:05 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8b37])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006cbc6e1478csm12674532qko.57.2022.12.28.22.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 22:40:05 -0800 (PST)
Date:   Thu, 29 Dec 2022 00:40:10 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
Message-ID: <Y602StijD+4Nymf6@maniforge.lan>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217082506.1570898-2-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 12:24:54AM -0800, Dave Marchevsky wrote:
> Currently, kfuncs marked KF_RELEASE indicate that they release some
> previously-acquired arg. The verifier assumes that such a function will
> only have one arg reg w/ ref_obj_id set, and that that arg is the one to
> be released. Multiple kfunc arg regs have ref_obj_id set is considered
> an invalid state.
> 
> For helpers, RELEASE is used to tag a particular arg in the function
> proto, not the function itself. The arg with OBJ_RELEASE type tag is the
> arg that the helper will release. There can only be one such tagged arg.
> When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
> also considered an invalid state.
> 
> Later patches in this series will result in some linked_list helpers
> marked KF_RELEASE having a valid reason to take two ref_obj_id args.
> Specifically, bpf_list_push_{front,back} can push a node to a list head
> which is itself part of a list node. In such a scenario both arguments
> to these functions would have ref_obj_id > 0, thus would fail
> verification under current logic.
> 
> This patch changes kfunc ref_obj_id searching logic to find the last arg
> reg w/ ref_obj_id and consider that the reg-to-release. This should be
> backwards-compatible with all current kfuncs as they only expect one
> such arg reg.

Can't say I'm a huge fan of this proposal :-( While I think it's really
unfortunate that kfunc flags are not defined per-arg for this exact type
of reason, adding more flag-specific semantics like this is IMO a step
in the wrong direction.  It's similar to the existing __sz and __k
argument-naming semantics that inform the verifier that the arguments
have special meaning. All of these little additions of special-case
handling for kfunc flags end up requiring people writing kfuncs (and
sometimes calling them) to read through the verifier to understand
what's going on (though I will say that it's nice that __sz and __k are
properly documented in [0]).

[0]: https://docs.kernel.org/bpf/kfuncs.html#sz-annotation

The correct thing to do here, in my opinion, is to work to combine kfunc
and helper definitions. Right now that's of course not possible for a
number of reasons, including the fact that kfuncs can do things that
helpers cannot. If we do end up merging it, at the very least I'd ask
you to please loudly document the behavior both in
Documentation/bpf/kfuncs.rst, and in the code where the kfunc flags are
defined, if you don't mind.

Of course, that's assuming that we decide that we still need this, per
Alexei's comment in [1].

[1]: https://lore.kernel.org/all/20221229032442.dkastsstktsxjymb@MacBook-Pro-6.local/

> 
> Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
> that examines each individual arg (check_func_arg for helpers and
> check_kfunc_args inner loop for kfuncs). This patch pulls out this
> searching to occur before individual arg type handling, resulting in a
> cleaner separation of logic.
> 
> Two new helpers are added:
>   * args_find_ref_obj_id_regno
>     * For helpers and kfuncs. Searches through arg regs to find
>       ref_obj_id reg and returns its regno. Helpers set allow_multi =
>       false, retaining "only one ref_obj_id arg" behavior, while kfuncs
>       set allow_multi = true and get the last ref_obj_id arg reg back.
> 
>   * helper_proto_find_release_arg_regno
>     * For helpers only. Searches through fn proto args to find the
>       OBJ_RELEASE arg and returns the corresponding regno.
> 
> Aside from the intentional semantic change for kfuncs, the rest of the
> refactoring strives to keep failure logic and error messages unchanged.
> However, because the release arg searching is now done before any
> arg-specific type checking, verifier states that are invalid due to both
> invalid release arg state _and_ some type- or helper-specific checking
> might see release arg-related error message first.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/verifier.c | 206 ++++++++++++++++++++++++++++--------------
>  1 file changed, 138 insertions(+), 68 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5255a0dcbb6..824e2242eae5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6412,49 +6412,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		return err;
>  
>  skip_type_check:
> -	if (arg_type_is_release(arg_type)) {
> -		if (arg_type_is_dynptr(arg_type)) {
> -			struct bpf_func_state *state = func(env, reg);
> -			int spi;
> -
> -			/* Only dynptr created on stack can be released, thus
> -			 * the get_spi and stack state checks for spilled_ptr
> -			 * should only be done before process_dynptr_func for
> -			 * PTR_TO_STACK.
> -			 */
> -			if (reg->type == PTR_TO_STACK) {
> -				spi = get_spi(reg->off);
> -				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> -				    !state->stack[spi].spilled_ptr.ref_obj_id) {
> -					verbose(env, "arg %d is an unacquired reference\n", regno);
> -					return -EINVAL;
> -				}
> -			} else {
> -				verbose(env, "cannot release unowned const bpf_dynptr\n");
> -				return -EINVAL;
> -			}
> -		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
> -			verbose(env, "R%d must be referenced when passed to release function\n",
> -				regno);
> -			return -EINVAL;
> -		}
> -		if (meta->release_regno) {
> -			verbose(env, "verifier internal error: more than one release argument\n");
> -			return -EFAULT;
> -		}
> -		meta->release_regno = regno;
> -	}
> -
> -	if (reg->ref_obj_id) {
> -		if (meta->ref_obj_id) {
> -			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -				regno, reg->ref_obj_id,
> -				meta->ref_obj_id);
> -			return -EFAULT;
> -		}
> -		meta->ref_obj_id = reg->ref_obj_id;
> -	}
> -
>  	switch (base_type(arg_type)) {
>  	case ARG_CONST_MAP_PTR:
>  		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
> @@ -6565,6 +6522,27 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		err = check_mem_size_reg(env, reg, regno, true, meta);
>  		break;
>  	case ARG_PTR_TO_DYNPTR:
> +		if (meta->release_regno == regno) {
> +			struct bpf_func_state *state = func(env, reg);
> +			int spi;
> +
> +			/* Only dynptr created on stack can be released, thus
> +			 * the get_spi and stack state checks for spilled_ptr
> +			 * should only be done before process_dynptr_func for
> +			 * PTR_TO_STACK.
> +			 */
> +			if (reg->type == PTR_TO_STACK) {
> +				spi = get_spi(reg->off);
> +				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> +				    !state->stack[spi].spilled_ptr.ref_obj_id) {
> +					verbose(env, "arg %d is an unacquired reference\n", regno);
> +					return -EINVAL;
> +				}
> +			} else {
> +				verbose(env, "cannot release unowned const bpf_dynptr\n");
> +				return -EINVAL;
> +			}
> +		}
>  		err = process_dynptr_func(env, regno, arg_type, meta);
>  		if (err)
>  			return err;
> @@ -7699,10 +7677,78 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>  				 state->callback_subprogno == subprogno);
>  }
>  
> +/* Call arg meta's ref_obj_id is used to either:
> + *   - For release funcs, keep track of ref that needs to be released
> + *   - For other funcs, keep track of ref that needs to be propagated to retval
> + *
> + * Find and return:
> + *   - Regno that should become meta->ref_obj_id on success
> + *     (regno > 0 since BPF_REG_1 is first arg)
> + *   - 0 if no arg had ref_obj_id set
> + *   - Negative err if some invalid arg reg state
> + *
> + * allow_multi controls whether multiple args w/ ref_obj_id set is valid
> + *   - true: regno of _last_ such arg reg is returned
> + *   - false: err if multiple args w/ ref_obj_id set are seen
> + */

Could you please update this function header to match the suggested
formatting in the coding style ([1])? Applies to
helper_proto_find_release_arg_regno() as well.

[1]: https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

> +static int args_find_ref_obj_id_regno(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
> +				      u32 nargs, bool allow_multi)
> +{
> +	struct bpf_reg_state *reg;
> +	u32 i, regno, found_regno = 0;
> +
> +	for (i = 0; i < nargs; i++) {
> +		regno = i + 1;
> +		reg = &regs[regno];
> +
> +		if (!reg->ref_obj_id)
> +			continue;
> +
> +		if (!allow_multi && found_regno) {
> +			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> +				regno, reg->ref_obj_id, regs[found_regno].ref_obj_id);
> +			return -EFAULT;
> +		}
> +
> +		found_regno = regno;
> +	}
> +
> +	return found_regno;
> +}
> +
> +/* Find the OBJ_RELEASE arg in helper func proto and return:
> + *   - regno of single OBJ_RELEASE arg
> + *   - 0 if no arg in the proto was OBJ_RELEASE
> + *   - Negative err if some invalid func proto state
> + */
> +static int helper_proto_find_release_arg_regno(struct bpf_verifier_env *env,
> +					       const struct bpf_func_proto *fn, u32 nargs)
> +{
> +	enum bpf_arg_type arg_type;
> +	int i, release_regno = 0;
> +
> +	for (i = 0; i < nargs; i++) {
> +		arg_type = fn->arg_type[i];
> +
> +		if (!arg_type_is_release(arg_type))
> +			continue;
> +
> +		if (release_regno) {
> +			verbose(env, "verifier internal error: more than one release argument\n");
> +			return -EFAULT;
> +		}
> +
> +		release_regno = i + BPF_REG_1;
> +	}
> +
> +	return release_regno;
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     int *insn_idx_p)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> +	int i, err, func_id, nargs, release_regno, ref_regno;
>  	const struct bpf_func_proto *fn = NULL;
>  	enum bpf_return_type ret_type;
>  	enum bpf_type_flag ret_flag;
> @@ -7710,7 +7756,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	struct bpf_call_arg_meta meta;
>  	int insn_idx = *insn_idx_p;
>  	bool changes_data;
> -	int i, err, func_id;
>  
>  	/* find function prototype */
>  	func_id = insn->imm;
> @@ -7774,8 +7819,38 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	}
>  
>  	meta.func_id = func_id;
> +	regs = cur_regs(env);
> +
> +	/* find actual arg count */
> +	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
> +		if (fn->arg_type[i] == ARG_DONTCARE)
> +			break;
> +	nargs = i;

Is this just an optimization to avoid unnecessary loop iterations? If
so, can we pull it into a separate patch? Also, you could very slightly
simplify this by doing the for loop over nargs here instead of i. Feel
free to ignore though if you think that will be less readable.

> +
> +	release_regno = helper_proto_find_release_arg_regno(env, fn, nargs);
> +	if (release_regno < 0)
> +		return release_regno;
> +
> +	ref_regno = args_find_ref_obj_id_regno(env, regs, nargs, false);
> +	if (ref_regno < 0)
> +		return ref_regno;

Hmm, I'm confused. Why are we tracking two different registers here,
given that it's a helper function so the release argument should be
unambiguous? Can we just get rid of ref_regno and use release_regno
here? Or am I missing something?

Note that I don't think it's necessarily incorrect to pass multiple
arguments with ref_obj_id > 0 to a helper function precisly because
there's no ambiguity as to which argument is being released. One
argument could be a refcounted object that's not being released, and
another could be the object being released. I don't think we have any
such helpers, but conceptually it doesn't seem like something we'd need
to protect against. It's actually kfuncs where it feels problematic to
have multiple ref_obj_id > 0 args due to the inherent ambiguity, though
I realize the intention of this patch is to enable the behavior for
kfuncs.

> +	else if (ref_regno > 0)
> +		meta.ref_obj_id = regs[ref_regno].ref_obj_id;
> +
> +	if (release_regno > 0) {
> +		if (!regs[release_regno].ref_obj_id &&
> +		    !register_is_null(&regs[release_regno]) &&
> +		    !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
> +			verbose(env, "R%d must be referenced when passed to release function\n",
> +				release_regno);
> +			return -EINVAL;
> +		}
> +
> +		meta.release_regno = release_regno;
> +	}
> +
>  	/* check args */
> -	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +	for (i = 0; i < nargs; i++) {
>  		err = check_func_arg(env, i, &meta, fn);
>  		if (err)
>  			return err;
> @@ -7799,8 +7874,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			return err;
>  	}
>  
> -	regs = cur_regs(env);
> -
>  	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
>  	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
>  	 * is safe to do directly.
> @@ -8795,10 +8868,11 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>  {
>  	const char *func_name = meta->func_name, *ref_tname;
> +	struct bpf_reg_state *regs = cur_regs(env);
>  	const struct btf *btf = meta->btf;
>  	const struct btf_param *args;
>  	u32 i, nargs;
> -	int ret;
> +	int ret, ref_regno;
>  
>  	args = (const struct btf_param *)(meta->func_proto + 1);
>  	nargs = btf_type_vlen(meta->func_proto);
> @@ -8808,17 +8882,31 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		return -EINVAL;
>  	}
>  
> +	ref_regno = args_find_ref_obj_id_regno(env, cur_regs(env), nargs, true);
> +	if (ref_regno < 0) {
> +		return ref_regno;
> +	} else if (!ref_regno && is_kfunc_release(meta)) {
> +		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> +			func_name);
> +		return -EINVAL;
> +	}
> +
> +	meta->ref_obj_id = regs[ref_regno].ref_obj_id;
> +	if (is_kfunc_release(meta))
> +		meta->release_regno = ref_regno;
> +
>  	/* Check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
>  	for (i = 0; i < nargs; i++) {
> -		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
>  		const struct btf_type *t, *ref_t, *resolve_ret;
>  		enum bpf_arg_type arg_type = ARG_DONTCARE;
>  		u32 regno = i + 1, ref_id, type_size;
>  		bool is_ret_buf_sz = false;
> +		struct bpf_reg_state *reg;
>  		int kf_arg_type;
>  
> +		reg = &regs[regno];
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>  
>  		if (is_kfunc_arg_ignore(btf, &args[i]))
> @@ -8875,18 +8963,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			return -EINVAL;
>  		}
>  
> -		if (reg->ref_obj_id) {
> -			if (is_kfunc_release(meta) && meta->ref_obj_id) {
> -				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -					regno, reg->ref_obj_id,
> -					meta->ref_obj_id);
> -				return -EFAULT;
> -			}
> -			meta->ref_obj_id = reg->ref_obj_id;
> -			if (is_kfunc_release(meta))
> -				meta->release_regno = regno;
> -		}
> -
>  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>  
> @@ -8929,7 +9005,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			return -EFAULT;
>  		}
>  
> -		if (is_kfunc_release(meta) && reg->ref_obj_id)
> +		if (is_kfunc_release(meta) && regno == meta->release_regno)
>  			arg_type |= OBJ_RELEASE;
>  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
>  		if (ret < 0)
> @@ -9049,12 +9125,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		}
>  	}
>  
> -	if (is_kfunc_release(meta) && !meta->release_regno) {
> -		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> -			func_name);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
