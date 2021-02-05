Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB553104BC
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 06:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBEFuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 00:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEFuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 00:50:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA649C061786
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 21:49:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y10so3006735plk.7
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 21:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnPFAUYTYFx6h/5e7Et1086NRgMiZ2LmFOMIJN2roWI=;
        b=j/SKW5co4Fl4CJSnVzEBcSc52flA88qdWiDGCsg2D3Ty2VseYjO3q0Y2wz1e9C4oue
         RcY3ca06UJfTJ2AQD5IDyJa9OldOmUBH8bH0LSII/PAxxaSSI6pAzjVfcFyP8hKyFWj2
         vkqPubW0LTbrAwycUfvB7GSKN90oHg7SQSsJlp0HZxc5zzbTWlBxm98KTkO0f2X6HUOZ
         ERlI/6SwzFYUcmiv9e8pMhEie0bTR0WXNl3jQYYHteC4NaJ1Vw48iyj1YbsPGewqBKsf
         p7ZnWBUpJCTVrFlq3hESOcazPg3f5vkYm70gZ9zNpkO+NEgvoYs79dngamjuR4jkcELI
         pPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnPFAUYTYFx6h/5e7Et1086NRgMiZ2LmFOMIJN2roWI=;
        b=YgE0X5YY+RW0itmSgCQYFtwUAXQNVQA31k6YiQHJkRMcojUj8ikxmkAxjDTLMdmuhs
         HmVQGRyGLk4bgR1kcDM9Hh+o47XK7FCGehDPVhZxOaeeIPtV8x4afj++t/E3enhVAJwO
         x+55EaLLJpX6ezAgqIolb1YlwnyR714YKN7wdVULBjTCT95bzcGfeSSbX6mDKCLEE3JI
         +Y/C4HIES0a0KYb81OitMpMDtjuFOWOOiHFBXxFfQI5QFwpbkQ2YJqmj34vgN1zGap1T
         Kb7IRUphPS5uDuHBQJP9VmCYtbCoaSz7BEgTgLGI14NH3crJLWtzkntg/ixczhBl15bB
         KQZw==
X-Gm-Message-State: AOAM532A8tOYU0FrVS5UIRc+gO2HptkDkBvL1ocWhiqSVKHhrVwtjONi
        af1Mu+XcpJ7pv4JIfV+kUU4=
X-Google-Smtp-Source: ABdhPJzDys09jbM3SBicF84WmyOUIC/SbV9VaXwpYUzStwzzpOY2DwV2gozbiE+JmfSsbbN/cLnHrg==
X-Received: by 2002:a17:90a:4fe6:: with SMTP id q93mr2611211pjh.16.1612504182215;
        Thu, 04 Feb 2021 21:49:42 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:52b9])
        by smtp.gmail.com with ESMTPSA id j185sm8590029pge.46.2021.02.04.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:49:41 -0800 (PST)
Date:   Thu, 4 Feb 2021 21:49:39 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/8] bpf: add bpf_for_each_map_elem() helper
Message-ID: <20210205054939.i6rpdvhphkv7szi4@ast-mbp.dhcp.thefacebook.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234829.1629159-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204234829.1629159-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 04, 2021 at 03:48:29PM -0800, Yonghong Song wrote:
> The bpf_for_each_map_elem() helper is introduced which
> iterates all map elements with a callback function. The
> helper signature looks like
>   long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
> and for each map element, the callback_fn will be called. For example,
> like hashmap, the callback signature may look like
>   long callback_fn(map, key, val, callback_ctx)
> 
> There are two known use cases for this. One is from upstream ([1]) where
> a for_each_map_elem helper may help implement a timeout mechanism
> in a more generic way. Another is from our internal discussion
> for a firewall use case where a map contains all the rules. The packet
> data can be compared to all these rules to decide allow or deny
> the packet.
> 
> For array maps, users can already use a bounded loop to traverse
> elements. Using this helper can avoid using bounded loop. For other
> type of maps (e.g., hash maps) where bounded loop is hard or
> impossible to use, this helper provides a convenient way to
> operate on all elements.
> 
> For callback_fn, besides map and map element, a callback_ctx,
> allocated on caller stack, is also passed to the callback
> function. This callback_ctx argument can provide additional
> input and allow to write to caller stack for output.

The approach and implementation look great!
Few ideas below:

> +static int check_map_elem_callback(struct bpf_verifier_env *env, int *insn_idx)
> +{
> +	struct bpf_verifier_state *state = env->cur_state;
> +	struct bpf_prog_aux *aux = env->prog->aux;
> +	struct bpf_func_state *caller, *callee;
> +	struct bpf_map *map;
> +	int err, subprog;
> +
> +	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
> +		verbose(env, "the call stack of %d frames is too deep\n",
> +			state->curframe + 2);
> +		return -E2BIG;
> +	}
> +
> +	caller = state->frame[state->curframe];
> +	if (state->frame[state->curframe + 1]) {
> +		verbose(env, "verifier bug. Frame %d already allocated\n",
> +			state->curframe + 1);
> +		return -EFAULT;
> +	}
> +
> +	caller->with_callback_fn = true;
> +
> +	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
> +	if (!callee)
> +		return -ENOMEM;
> +	state->frame[state->curframe + 1] = callee;
> +
> +	/* callee cannot access r0, r6 - r9 for reading and has to write
> +	 * into its own stack before reading from it.
> +	 * callee can read/write into caller's stack
> +	 */
> +	init_func_state(env, callee,
> +			/* remember the callsite, it will be used by bpf_exit */
> +			*insn_idx /* callsite */,
> +			state->curframe + 1 /* frameno within this callchain */,
> +			subprog /* subprog number within this prog */);
> +
> +	/* Transfer references to the callee */
> +	err = transfer_reference_state(callee, caller);
> +	if (err)
> +		return err;
> +
> +	subprog = caller->regs[BPF_REG_2].subprog;
> +	if (aux->func_info && aux->func_info_aux[subprog].linkage != BTF_FUNC_STATIC) {
> +		verbose(env, "callback function R2 not static\n");
> +		return -EINVAL;
> +	}
> +
> +	map = caller->regs[BPF_REG_1].map_ptr;

Take a look at for (i = 0; i < 5; i++)  err = check_func_arg loop and record_func_map.
It stores the map pointer into map_ptr_state and makes sure it's unique,
so that program doesn't try to pass two different maps into the same 'call insn'.
It can make this function a bit more generic.
There would be no need to hard code regs[BPF_REG_1].
The code would take it from map_ptr_state.
Also it will help later with optimizing
  return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
since the map pointer will be the same the optimization (that is applied to other map
operations) can be applied for this callback as well.

The regs[BPF_REG_2] can be generalized a bit as well.
It think linkage != BTF_FUNC_STATIC can be moved to early check_ld_imm phase.
While here the check_func_arg() loop can look for PTR_TO_FUNC type,
remeber the subprog into meta (just like map_ptr_state) and ... continues below

> +	if (!map->ops->map_set_for_each_callback_args ||
> +	    !map->ops->map_for_each_callback) {
> +		verbose(env, "callback function not allowed for map R1\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	/* the following is only for hashmap, different maps
> +	 * can have different callback signatures.
> +	 */
> +	err = map->ops->map_set_for_each_callback_args(env, caller, callee);
> +	if (err)
> +		return err;
> +
> +	clear_caller_saved_regs(env, caller->regs);
> +
> +	/* only increment it after check_reg_arg() finished */
> +	state->curframe++;
> +
> +	/* and go analyze first insn of the callee */
> +	*insn_idx = env->subprog_info[subprog].start - 1;
> +
> +	if (env->log.level & BPF_LOG_LEVEL) {
> +		verbose(env, "caller:\n");
> +		print_verifier_state(env, caller);
> +		verbose(env, "callee:\n");
> +		print_verifier_state(env, callee);
> +	}
> +	return 0;
> +}
> +
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>  	struct bpf_verifier_state *state = env->cur_state;
>  	struct bpf_func_state *caller, *callee;
>  	struct bpf_reg_state *r0;
> -	int err;
> +	int i, err;
>  
>  	callee = state->frame[state->curframe];
>  	r0 = &callee->regs[BPF_REG_0];
> @@ -4955,7 +5090,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  	state->curframe--;
>  	caller = state->frame[state->curframe];
>  	/* return to the caller whatever r0 had in the callee */
> -	caller->regs[BPF_REG_0] = *r0;
> +	if (caller->with_callback_fn) {
> +		/* reset caller saved regs, the helper calling callback_fn
> +		 * has RET_INTEGER return types.
> +		 */
> +		for (i = 0; i < CALLER_SAVED_REGS; i++)
> +			mark_reg_not_init(env, caller->regs, caller_saved[i]);
> +		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> +		mark_reg_unknown(env, caller->regs, BPF_REG_0);

this part can stay in check_helper_call().

> +	} else {
> +		caller->regs[BPF_REG_0] = *r0;
> +	}
>  
>  	/* Transfer references to the caller */
>  	err = transfer_reference_state(caller, callee);
> @@ -5091,7 +5236,8 @@ static int check_reference_leak(struct bpf_verifier_env *env)
>  	return state->acquired_refs ? -EINVAL : 0;
>  }
>  
> -static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
> +static int check_helper_call(struct bpf_verifier_env *env, int func_id, int *insn_idx,
> +			     bool map_elem_callback)
>  {
>  	const struct bpf_func_proto *fn = NULL;
>  	struct bpf_reg_state *regs;
> @@ -5151,11 +5297,11 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  			return err;
>  	}
>  
> -	err = record_func_map(env, &meta, func_id, insn_idx);
> +	err = record_func_map(env, &meta, func_id, *insn_idx);
>  	if (err)
>  		return err;
>  
> -	err = record_func_key(env, &meta, func_id, insn_idx);
> +	err = record_func_key(env, &meta, func_id, *insn_idx);
>  	if (err)
>  		return err;
>  
> @@ -5163,7 +5309,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  	 * is inferred from register state.
>  	 */
>  	for (i = 0; i < meta.access_size; i++) {
> -		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
> +		err = check_mem_access(env, *insn_idx, meta.regno, i, BPF_B,
>  				       BPF_WRITE, -1, false);
>  		if (err)
>  			return err;
> @@ -5195,6 +5341,11 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  		return -EINVAL;
>  	}
>  
> +	if (map_elem_callback) {
> +		env->prog->aux->with_callback_fn = true;
> +		return check_map_elem_callback(env, insn_idx);

Instead of returning early here.
The check_func_arg() loop can look for PTR_TO_FUNC type.
The allocate new callee state,
do map_set_for_each_callback_args() here.
and then proceed further.

> +	}
> +
>  	/* reset caller saved regs */
>  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>  		mark_reg_not_init(env, regs, caller_saved[i]);

Instead of doing this loop in prepare_func_exit().
This code can just proceed here and clear caller regs. This loop can stay as-is.
The transfer of caller->callee would happen already.

Then there are few lines here that diff didn't show.
They do regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG and mark_reg_unknown.
No need to do them in prepare_func_exit().
This function can proceed further reusing this caller regs clearing loop and r0 marking.

Then before returning from check_helper_call()
it will do what you have in check_map_elem_callback() and it will adjust *insn_idx.

At this point caller would have regs cleared and r0=undef.
And callee would have regs setup the way map_set_for_each_callback_args callback meant to do it.
The only thing prepare_func_exit would need to do is to make sure that assignment:
caller->regs[BPF_REG_0] = *r0
doesn't happen. caller's r0 was already set to undef.
To achieve that I think would be a bit cleaner to mark callee state instead of caller state.
So instead of caller->with_callback_fn=true maybe callee->in_callback_fn=true ?

> @@ -5306,7 +5457,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>  	} else if (is_acquire_function(func_id, meta.map_ptr)) {
> -		int id = acquire_reference_state(env, insn_idx);
> +		int id = acquire_reference_state(env, *insn_idx);
>  
>  		if (id < 0)
>  			return id;
> @@ -5448,6 +5599,14 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
>  		else
>  			*ptr_limit = -off;
>  		return 0;
> +	case PTR_TO_MAP_KEY:
> +		if (mask_to_left) {
> +			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
> +		} else {
> +			off = ptr_reg->smin_value + ptr_reg->off;
> +			*ptr_limit = ptr_reg->map_ptr->key_size - off;
> +		}
> +		return 0;
>  	case PTR_TO_MAP_VALUE:
>  		if (mask_to_left) {
>  			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
> @@ -5614,6 +5773,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>  		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
>  			dst, reg_type_str[ptr_reg->type]);
>  		return -EACCES;
> +	case PTR_TO_MAP_KEY:
>  	case PTR_TO_MAP_VALUE:
>  		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
>  			verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
> @@ -7818,6 +7978,12 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		return 0;
>  	}
>  
> +	if (insn->src_reg == BPF_PSEUDO_FUNC) {
> +		dst_reg->type = PTR_TO_FUNC;
> +		dst_reg->subprog = insn[1].imm;

Like here check for linkage==static can happen ?

> +		return 0;
> +	}
> +
>  	map = env->used_maps[aux->map_index];
>  	mark_reg_known_zero(env, regs, insn->dst_reg);
>  	dst_reg->map_ptr = map;
> @@ -8195,9 +8361,23 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>  
>  	/* All non-branch instructions have a single fall-through edge. */
>  	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
> -	    BPF_CLASS(insns[t].code) != BPF_JMP32)
> +	    BPF_CLASS(insns[t].code) != BPF_JMP32 &&
> +	    !bpf_pseudo_func(insns + t))
>  		return push_insn(t, t + 1, FALLTHROUGH, env, false);
>  
> +	if (bpf_pseudo_func(insns + t)) {
> +		ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> +		if (ret)
> +			return ret;
> +
> +		if (t + 1 < insn_cnt)
> +			init_explored_state(env, t + 1);
> +		init_explored_state(env, t);
> +		ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> +				env, false);
> +		return ret;
> +	}
> +
>  	switch (BPF_OP(insns[t].code)) {
>  	case BPF_EXIT:
>  		return DONE_EXPLORING;
> @@ -8819,6 +8999,7 @@ static bool regsafe(struct bpf_reg_state *rold, struct bpf_reg_state *rcur,
>  			 */
>  			return false;
>  		}
> +	case PTR_TO_MAP_KEY:
>  	case PTR_TO_MAP_VALUE:
>  		/* If the new min/max/var_off satisfy the old ones and
>  		 * everything else matches, we are OK.
> @@ -9646,6 +9827,8 @@ static int do_check(struct bpf_verifier_env *env)
>  
>  			env->jmps_processed++;
>  			if (opcode == BPF_CALL) {
> +				bool map_elem_callback;
> +
>  				if (BPF_SRC(insn->code) != BPF_K ||
>  				    insn->off != 0 ||
>  				    (insn->src_reg != BPF_REG_0 &&
> @@ -9662,13 +9845,15 @@ static int do_check(struct bpf_verifier_env *env)
>  					verbose(env, "function calls are not allowed while holding a lock\n");
>  					return -EINVAL;
>  				}
> +				map_elem_callback = insn->src_reg != BPF_PSEUDO_CALL &&
> +						   insn->imm == BPF_FUNC_for_each_map_elem;
>  				if (insn->src_reg == BPF_PSEUDO_CALL)
>  					err = check_func_call(env, insn, &env->insn_idx);
>  				else
> -					err = check_helper_call(env, insn->imm, env->insn_idx);
> +					err = check_helper_call(env, insn->imm, &env->insn_idx,
> +								map_elem_callback);

then hopefully this extra 'map_elem_callback' boolean won't be needed.
Only env->insn_idx into &env->insn_idx.
In that sense check_helper_call will become a superset of check_func_call.
Maybe some code between them can be shared too.
Beyond bpf_for_each_map_elem() helper other helpers might use PTR_TO_FUNC.
I hope with this approach all of them will be handled a bit more generically.

>  				if (err)
>  					return err;
> -
>  			} else if (opcode == BPF_JA) {
>  				if (BPF_SRC(insn->code) != BPF_K ||
>  				    insn->imm != 0 ||
> @@ -10090,6 +10275,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  				goto next_insn;
>  			}
>  
> +			if (insn[0].src_reg == BPF_PSEUDO_FUNC) {
> +				aux = &env->insn_aux_data[i];
> +				aux->ptr_type = PTR_TO_FUNC;
> +				goto next_insn;
> +			}
> +
>  			/* In final convert_pseudo_ld_imm64() step, this is
>  			 * converted into regular 64-bit imm load insn.
>  			 */
> @@ -10222,9 +10413,13 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
>  	int insn_cnt = env->prog->len;
>  	int i;
>  
> -	for (i = 0; i < insn_cnt; i++, insn++)
> -		if (insn->code == (BPF_LD | BPF_IMM | BPF_DW))
> -			insn->src_reg = 0;
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		if (insn->code != (BPF_LD | BPF_IMM | BPF_DW))
> +			continue;
> +		if (insn->src_reg == BPF_PSEUDO_FUNC)
> +			continue;
> +		insn->src_reg = 0;
> +	}
>  }
>  
>  /* single env->prog->insni[off] instruction was replaced with the range
> @@ -10846,6 +11041,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		return 0;
>  
>  	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> +		if (bpf_pseudo_func(insn)) {
> +			env->insn_aux_data[i].call_imm = insn->imm;
> +			/* subprog is encoded in insn[1].imm */
> +			continue;
> +		}
> +
>  		if (!bpf_pseudo_call(insn))
>  			continue;
>  		/* Upon error here we cannot fall back to interpreter but
> @@ -10975,6 +11176,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	for (i = 0; i < env->subprog_cnt; i++) {
>  		insn = func[i]->insnsi;
>  		for (j = 0; j < func[i]->len; j++, insn++) {
> +			if (bpf_pseudo_func(insn)) {
> +				subprog = insn[1].imm;
> +				insn[0].imm = (u32)(long)func[subprog]->bpf_func;
> +				insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
> +				continue;
> +			}
>  			if (!bpf_pseudo_call(insn))
>  				continue;
>  			subprog = insn->off;
> @@ -11020,6 +11227,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	 * later look the same as if they were interpreted only.
>  	 */
>  	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> +		if (bpf_pseudo_func(insn)) {
> +			insn[0].imm = env->insn_aux_data[i].call_imm;
> +			insn[1].imm = find_subprog(env, i + insn[0].imm + 1);
> +			continue;
> +		}
>  		if (!bpf_pseudo_call(insn))
>  			continue;
>  		insn->off = env->insn_aux_data[i].call_imm;
> @@ -11083,6 +11295,13 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
>  		return -EINVAL;
>  	}
> +	if (env->subprog_cnt > 1 && env->prog->aux->with_callback_fn) {

Does this bool really need to be be part of 'aux'?
There is a loop below that does if (!bpf_pseudo_call
to fixup insns for the interpreter.
May be add if (bpf_pseudo_func()) { return callbacks are not allowed in non-JITed }
to the loop below as well?
It's a trade off between memory and few extra insn.

> +		/* When JIT fails the progs with callback calls
> +		 * have to be rejected, since interpreter doesn't support them yet.
> +		 */
> +		verbose(env, "callbacks are not allowed in non-JITed programs\n");
> +		return -EINVAL;
> +	}
>  	for (i = 0; i < prog->len; i++, insn++) {
>  		if (!bpf_pseudo_call(insn))
>  			continue;

to this loop.

Thanks!
