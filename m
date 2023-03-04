Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3446AAC48
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 21:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCDUCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 15:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDUCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 15:02:38 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7C13515
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 12:02:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y11so6255348plg.1
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 12:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fM1ReqyDEKDh20COb9WIpvGEyKZHeqIQOdKIJ1/rodQ=;
        b=anCdB0GskrhlzCwxoVaj99YE747hNz6sOCGljeKowAw5f3q6ozPrcpE72k5MJGNqJP
         COAB6KKSm+3bxvVbyEmEUNBwZ8av+nEzJeJahe2msiZ2cLbqEPjD1l9FjZ7caYzs+Ah/
         1qt2YCAktVUmOGEEhrwfz6aOmnYGPh26bG1GF4+lQ3sI/cbB0WimLLz9hflMV4k4bhwW
         NY8VOUb0MZL7yd17p5CghZyq8tvJ9cz+B0NG4xrO6/J+ZgiAM56cHCpQB/rSzwDkTAFU
         BmNA9401X+1UVKjF9i7WO9fiOqfeuPDoiTzA5pa/i/26PzH1aJILLFmbOAtaGlhw9Itx
         xYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM1ReqyDEKDh20COb9WIpvGEyKZHeqIQOdKIJ1/rodQ=;
        b=ZspsEjRurIKw6ww1tFt/kAKwaKNzy7VFbUJWHHN3tKIwNIpE2vevG3yq9U9lsT0DyK
         jXsA2m7DUNyZmwgV1p3BUz9sOzlOdCcmXBgru8ABgkfBPqELsmMGOC5RCcgH/pGRD246
         ttkUTNEdQ6z5uWeG/2ia9hANFZYlyPJzxZqDnQZeuEA+L5zvWAqGXxGSssYgtJZ2JZdf
         5agXt9NRisKuJbeLNCLeqSBTgur6fvEiC5F762EvJpXcqVsTwIRoSjwrpB+gyR8JicEa
         P7UvMBAkhCD8RfjnJZfJrZgPta5k8izL3+rdWS5AtZR0tfLQy6wKfohOMK8baQCf08Qc
         cHhA==
X-Gm-Message-State: AO0yUKU5h5q3ujs0UAeaDw87Zec1+HP60JSSCHRr+K0wAHXsU2Kl6P3k
        aRDQyStXLessgfSlF9ViSaQ=
X-Google-Smtp-Source: AK7set+zLQLjhQvDgKGOXDkfGCS9Ko4TjQtIGE6AV96ZX/aqSRg8EyHMra39Wx/9JhLJCWs1P87UuQ==
X-Received: by 2002:a17:902:ea03:b0:19e:2869:7793 with SMTP id s3-20020a170902ea0300b0019e28697793mr7084431plg.16.1677960155611;
        Sat, 04 Mar 2023 12:02:35 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id jy14-20020a17090342ce00b00199023c688esm3702927plb.26.2023.03.04.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 12:02:35 -0800 (PST)
Date:   Sat, 4 Mar 2023 12:02:32 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 13/17] bpf: add support for open-coded iterator
 loops
Message-ID: <20230304200232.ueac44amyhpptpay@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-14-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302235015.2044271-14-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:50:11PM -0800, Andrii Nakryiko wrote:
> Teach verifier about the concept of open-coded (or inline) iterators.
> 
> This patch adds generic iterator loop verification logic, new STACK_ITER
> stack slot type to contain iterator state, and necessary kfunc plumbing
> for iterator's constructor, destructor and next "methods". Next patch
> implements first specific version of iterator (number iterator for
> implementing for loop). Such split allows to have more focused commits
> for verifier logic and separate commit that we could point later to what
> it takes to add new kind of iterator.
> 
> First, we add new fixed-size opaque struct bpf_iter (24-byte long) to
> contain runtime state of any possible iterator. struct bpf_iter state is

Looking at the verifier changes it seems that it should be possible to support
any sized iterator and we don't have to fit all of them in 24-bytes.
The same bpf_iter_<kind>_{new,next,destroy}() naming convention can apply
to types and we can have 8-byte struct bpf_iter_num
The bpf_for() macros would work with bpf_iter_<kind> too.
iirc that was your plan earlier (to have different structs).
What prompted you to change that plan?

> Any other iterator implementation will have to implement at least these
> three methods. It is enforced that for any given type of iterator only
> applicable constructor/destructor/next are callable. I.e., verifier
> ensures you can't pass number iterator into, say, cgroup iterator's next
> method.

is_iter_type_compatible() does that, right?

> +
> +static int mark_stack_slots_iter(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +				 enum bpf_arg_type arg_type, int insn_idx)
> +{
> +	struct bpf_func_state *state = func(env, reg);
> +	enum bpf_iter_type type;
> +	int spi, i, j, id;
> +
> +	spi = iter_get_spi(env, reg);
> +	if (spi < 0)
> +		return spi;
> +
> +	type = arg_to_iter_type(arg_type);
> +	if (type == BPF_ITER_TYPE_INVALID)
> +		return -EINVAL;

Do we need destroy_if_dynptr_stack_slot() equivalent here?

> +	id = acquire_reference_state(env, insn_idx);
> +	if (id < 0)
> +		return id;
> +
> +	for (i = 0; i < BPF_ITER_NR_SLOTS; i++) {
> +		struct bpf_stack_state *slot = &state->stack[spi - i];
> +		struct bpf_reg_state *st = &slot->spilled_ptr;
> +
> +		__mark_reg_known_zero(st);
> +		st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
> +		st->live |= REG_LIVE_WRITTEN;
> +		st->ref_obj_id = i == 0 ? id : 0;
> +		st->iter.type = i == 0 ? type : BPF_ITER_TYPE_INVALID;
> +		st->iter.state = BPF_ITER_STATE_ACTIVE;
> +		st->iter.depth = 0;
> +
> +		for (j = 0; j < BPF_REG_SIZE; j++)
> +			slot->slot_type[j] = STACK_ITER;
> +
> +		mark_stack_slot_scratched(env, spi - i);

dynptr needs similar mark_stack_slot_scratched() fix, right?

> +	}
> +
> +	return 0;
> +}

...

> @@ -3691,8 +3928,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>  
>  		/* regular write of data into stack destroys any spilled ptr */
>  		state->stack[spi].spilled_ptr.type = NOT_INIT;
> -		/* Mark slots as STACK_MISC if they belonged to spilled ptr. */
> -		if (is_spilled_reg(&state->stack[spi]))
> +		/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
> +		if (is_stack_slot_special(&state->stack[spi]))
>  			for (i = 0; i < BPF_REG_SIZE; i++)
>  				scrub_spilled_slot(&state->stack[spi].slot_type[i]);

It fixes something for dynptr, right?

> +static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
> +				  struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st;
> +	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
> +	struct bpf_reg_state *cur_iter, *queued_iter;
> +	int iter_frameno = meta->iter.frameno;
> +	int iter_spi = meta->iter.spi;
> +
> +	BTF_TYPE_EMIT(struct bpf_iter);
> +
> +	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
> +
> +	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
> +	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
> +		verbose(env, "verifier internal error: unexpected iterator state %d (%s)\n",
> +			cur_iter->iter.state, iter_state_str(cur_iter->iter.state));
> +		return -EFAULT;
> +	}
> +
> +	if (cur_iter->iter.state == BPF_ITER_STATE_ACTIVE) {
> +		/* branch out active iter state */
> +		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
> +		if (!queued_st)
> +			return -ENOMEM;
> +
> +		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
> +		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
> +		queued_iter->iter.depth++;
> +
> +		queued_fr = queued_st->frame[queued_st->curframe];
> +		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
> +	}
> +
> +	/* switch to DRAINED state, but keep the depth unchanged */
> +	/* mark current iter state as drained and assume returned NULL */
> +	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
> +	__mark_reg_known_zero(&cur_fr->regs[BPF_REG_0]);
> +	cur_fr->regs[BPF_REG_0].type = SCALAR_VALUE;

__mark_reg_const_zero() instead?

> +
> +	return 0;
> +}
...
> +static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx, int *reg_idx)
> +{
> +	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> +	const struct btf_param *args;
> +	const struct btf_type *t;
> +	const struct btf *btf;
> +	int nargs, i;
> +
> +	if (!bpf_pseudo_kfunc_call(insn))
> +		return false;
> +	if (!is_iter_next_kfunc(insn->imm))
> +		return false;
> +
> +	btf = find_kfunc_desc_btf(env, insn->off);
> +	if (IS_ERR(btf))
> +		return false;
> +
> +	t = btf_type_by_id(btf, insn->imm);	/* FUNC */
> +	t = btf_type_by_id(btf, t->type);	/* FUNC_PROTO */
> +
> +	args = btf_params(t);
> +	nargs = btf_vlen(t);
> +	for (i = 0; i < nargs; i++) {
> +		if (is_kfunc_arg_iter(btf, &args[i])) {
> +			*reg_idx = BPF_REG_1 + i;
> +			return true;
> +		}
> +	}

This is some future-proofing ?
The commit log says that all iterators has to in the form:
bpf_iter_<kind>_next(struct bpf_iter* it)
Should we check for one and only arg here instead?

> +
> +	return false;
> +}
> +
> +/* is_state_visited() handles iter_next() (see process_iter_next_call() for
> + * terminology) calls specially: as opposed to bounded BPF loops, it *expects*
> + * state matching, which otherwise looks like an infinite loop. So while
> + * iter_next() calls are taken care of, we still need to be careful and
> + * prevent erroneous and too eager declaration of "ininite loop", when
> + * iterators are involved.
> + *
> + * Here's a situation in pseudo-BPF assembly form:
> + *
> + *   0: again:                          ; set up iter_next() call args
> + *   1:   r1 = &it                      ; <CHECKPOINT HERE>
> + *   2:   call bpf_iter_num_next        ; this is iter_next() call
> + *   3:   if r0 == 0 goto done
> + *   4:   ... something useful here ...
> + *   5:   goto again                    ; another iteration
> + *   6: done:
> + *   7:   r1 = &it
> + *   8:   call bpf_iter_num_destroy     ; clean up iter state
> + *   9:   exit
> + *
> + * This is a typical loop. Let's assume that we have a prune point at 1:,
> + * before we get to `call bpf_iter_num_next` (e.g., because of that `goto
> + * again`, assuming other heuristics don't get in a way).
> + *
> + * When we first time come to 1:, let's say we have some state X. We proceed
> + * to 2:, fork states, enqueue ACTIVE, validate NULL case successfully, exit.
> + * Now we come back to validate that forked ACTIVE state. We proceed through
> + * 3-5, come to goto, jump to 1:. Let's assume our state didn't change, so we
> + * are converging. But the problem is that we don't know that yet, as this
> + * convergence has to happen at iter_next() call site only. So if nothing is
> + * done, at 1: verifier will use bounded loop logic and declare infinite
> + * looping (and would be *technically* correct, if not for iterator "eventual
> + * sticky NULL" contract, see process_iter_next_call()). But we don't want
> + * that. So what we do in process_iter_next_call() when we go on another
> + * ACTIVE iteration, we bump slot->iter.depth, to mark that it's a different
> + * iteration. So when we detect soon-to-be-declared infinite loop, we also
> + * check if any of *ACTIVE* iterator state's depth differs. If yes, we pretend
> + * we are not looping and wait for next iter_next() call.

'depth' part of bpf_reg_state will be checked for equality in regsafe(), right?
Everytime we branch out in process_iter_next_call() there is depth++
So how come we're able to converge with:
 +                     if (is_iter_next_insn(env, insn_idx, &iter_arg_reg_idx)) {
 +                             if (states_equal(env, &sl->state, cur)) {
That's because states_equal() is done right before doing process_iter_next_call(), right?

So depth counts the number of times bpf_iter*_next() was processed.
In other words it's a number of ways the body of the loop can be walked?

> +			if (is_iter_next_insn(env, insn_idx, &iter_arg_reg_idx)) {
> +				if (states_equal(env, &sl->state, cur)) {
> +					struct bpf_func_state *cur_frame;
> +					struct bpf_reg_state *iter_state, *iter_reg;
> +					int spi;
> +
> +					/* current state is valid due to states_equal(),
> +					 * so we can assume valid iter state, no need for extra
> +					 * (re-)validations
> +					 */
> +					cur_frame = cur->frame[cur->curframe];
> +					iter_reg = &cur_frame->regs[iter_arg_reg_idx];
> +					spi = iter_get_spi(env, iter_reg);
> +					if (spi < 0)
> +						return spi;
> +					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
> +					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE)
> +						goto hit;
> +				}
> +				goto skip_inf_loop_check;

This goto is "optional", right?
Meaning that if we remove it the states_maybe_looping() + states_equal() won't match anyway.
The goto avoids wasting cycles.

> +			}
> +			/* attempt to detect infinite loop to avoid unnecessary doomed work */
> +			if (states_maybe_looping(&sl->state, cur) &&

Maybe cleaner is to remove above 'goto' and do '} else if (states_maybe_looping' here ?

> +			    states_equal(env, &sl->state, cur) &&
> +			    !iter_active_depths_differ(&sl->state, cur)) {
>  				verbose_linfo(env, insn_idx, "; ");
>  				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
>  				return -EINVAL;
