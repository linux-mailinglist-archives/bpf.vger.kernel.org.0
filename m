Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7447730676D
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 00:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhA0XBK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 18:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhA0W7E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 17:59:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E940C06174A
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 14:58:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so2411737pfk.1
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V9tm3H82Ynd5lskHs4j1AND5vq5N2pcEbKrKXO3vUxI=;
        b=XF4lpeMp1FZ/FLZPzBz+qkBSrBAH/CLpTz8pi/YT9lox8rEPrgnY0f6t8LrW7HCUcM
         T+Pk4f8/DD9W/tybXzo/aK9uq8rUCoC09/a6UtVZP6IDZmIj4BoxcXSUYysCU6xEjBR9
         8yt/9g0pt3TjrnEDQVb93J4vkgOVxd3UJUMN0Gj2sNr7fhqVlEY4iaH+fwkvwPBF13Tc
         Qn3CSH9zHyaF7igw9GSe/rH39lXIAycKffh8h2y+mMsUS7vEL/3SRywuIFYHpFL5bcVT
         zFQjYvdjRKJKCxW7koQd78P/1NAwVsvYqvh5GiigsWIyte6TXgSExDMh4AGg+PQagz2D
         k28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9tm3H82Ynd5lskHs4j1AND5vq5N2pcEbKrKXO3vUxI=;
        b=BdSAvKnxsEqNAxGoEix6SYMuYASUJ8jE4OwhMEw75dSglVwbdpt39+Cl1dYRu/aHEO
         aizMeS0M2iPRAll4Ep18knY9nq4JW+KzpAH+E8vvLP53PIRNy8q5uKl4Uz5pOzQc8tOy
         hu78X4mVwN5DXZFbdkRyCD6frTWDRFPbftIriQoJgE7PbRMAc33u7gEKnQf/AARhEoqK
         lIR/tOtksJmN8IAa62Ug7G/Q+HOkratcEOBjHVUju7EOt5+ikKmRND6OMhdCIU79qiHs
         l4HlsCLDPHpoKDFSlDYxb3M5FqPTfBvwE0HIkB0tFlZ7SuheQik0VC/skCPwLpcbMswb
         o4FA==
X-Gm-Message-State: AOAM531qeRfUTl77QEfBjmDIEy9C5pLxjTHJSK2yx8teBCRXESKDRBHb
        gPA2fOmVGSHRP6vctshEsBbN46/NRqQ=
X-Google-Smtp-Source: ABdhPJxi5I0nCa3jpvU88QqeP2vgHod/rQdhG5gUAOvXRfrlRqIeL8hC6VgKi0EBk3US8frffu6Qtw==
X-Received: by 2002:a62:2c50:0:b029:1b9:1846:b490 with SMTP id s77-20020a622c500000b02901b91846b490mr12839992pfs.76.1611788301501;
        Wed, 27 Jan 2021 14:58:21 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b3c1])
        by smtp.gmail.com with ESMTPSA id b18sm3552386pfi.173.2021.01.27.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 14:58:20 -0800 (PST)
Date:   Wed, 27 Jan 2021 14:58:18 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: allow variable-offset stack access
Message-ID: <20210127225818.3uzw3tehbu3qlyd6@ast-mbp.dhcp.thefacebook.com>
References: <20210124194909.453844-1-andreimatei1@gmail.com>
 <20210124194909.453844-2-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124194909.453844-2-andreimatei1@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 24, 2021 at 02:49:05PM -0500, Andrei Matei wrote:
> + *
> + * If some stack slots in range are uninitialized (i.e. STACK_INVALID), the
> + * write is not automatically rejected. However, they are left as
> + * STACK_INVALID, which means that reads with the same variable offset will be
> + * rejected.
...
> +		/* If the slot is STACK_INVALID, we leave it as such. We can't
> +		 * mark the slot as initialized, as the slot might not actually
> +		 * be written to (and so marking it as initialized opens the
> +		 * door to leaks of uninitialized stack memory.
> +		 */
> +		if (*stype != STACK_INVALID)
> +			*stype = new_type;

'leaks of uninitialized stack memory'...
well that's true, but the way the user would have to deal with this
is to use __builtin_memset(&buf, 0, 16); for the whole buffer
before doing var_off write into it.
In the test in patch 5 would be good to add a read after this write:
buf[len] = buf[idx];
// need to do another read of buf[len] here.

Without memset() it would fail and the user would flame us:
"I just wrote into this stack slot!! Why cannot the verifier figure out
that the read from the same location is safe?... stupid verifier..."

I think for your use case where you read the whole thing into a stack and
then parse it all locations potentially touched by reads/writes would
be already written via helper, but imo this error is too unpleasant to
explain to users.
Especially since it happens later at a different instruction there is
no good verifier hint we can print.
It would just hit 'invalid read from stack'.

Currently we don't allow uninit read from stack even for root.
I think we have to sacrifice the perfection of the verification here.
We can either allow reading uninit for _fixed and _var_off
or better yet do unconditional '*stype = new_type' here.
Yes it would mean that following _fixed or _var_off read could be
reading uninited stack. I think we have to do it for the sake
of user friendliness.
The completely buggy uninited reads from stack will still be disallowed.
Only the [min,max] of var_off range in stack will be considered
init, so imo it's a reasonable trade-off between user friendliness
and verifier's perfection.
Wdyt?

> +	}
> +	if (zero_used) {
> +		/* backtracking doesn't work for STACK_ZERO yet. */
> +		err = mark_chain_precision(env, value_regno);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +/* When register 'regno' is assigned some values from stack[min_off, max_off),
> + * we set the register's type according to the types of the respective stack
> + * slots. If all the stack values are known to be zeros, then so is the
> + * destination reg. Otherwise, the register is considered to be SCALAR. This
> + * function does not deal with register filling; the caller must ensure that
> + * all spilled registers in the stack range have been marked as read.
> + */
> +static void mark_reg_stack_read(struct bpf_verifier_env *env,
> +				/* func where src register points to */
> +				struct bpf_func_state *ptr_state,
> +				int min_off, int max_off, int regno)

may be use 'dst_regno' here like you've renamed below?

> -static int check_stack_access(struct bpf_verifier_env *env,
> -			      const struct bpf_reg_state *reg,
> -			      int off, int size)
> +enum stack_access_src {
> +	ACCESS_DIRECT = 1,  /* the access is performed by an instruction */
> +	ACCESS_HELPER = 2,  /* the access is performed by a helper */
> +};
> +
> +static int check_stack_range_initialized(struct bpf_verifier_env *env,
> +					 int regno, int off, int access_size,
> +					 bool zero_size_allowed,
> +					 enum stack_access_src type,
> +					 struct bpf_call_arg_meta *meta);
> +
> +static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
> +{
> +	return cur_regs(env) + regno;
> +}
> +
> +/* Read the stack at 'ptr_regno + off' and put the result into the register
> + * 'dst_regno'.
> + * 'off' includes the pointer register's fixed offset(i.e. 'ptr_regno.off'),
> + * but not its variable offset.
> + * 'size' is assumed to be <= reg size and the access is assumed to be aligned.
> + *
> + * As opposed to check_stack_read_fixed_off, this function doesn't deal with
> + * filling registers (i.e. reads of spilled register cannot be detected when
> + * the offset is not fixed). We conservatively mark 'dst_regno' as containing
> + * SCALAR_VALUE. That's why we assert that the 'ptr_regno' has a variable
> + * offset; for a fixed offset check_stack_read_fixed_off should be used
> + * instead.
> + */
> +static int check_stack_read_var_off(struct bpf_verifier_env *env,
> +				    int ptr_regno, int off, int size, int dst_regno)
>  {
> -	/* Stack accesses must be at a fixed offset, so that we
> -	 * can determine what type of data were returned. See
> -	 * check_stack_read().
> +	/* The state of the source register. */
> +	struct bpf_reg_state *reg = reg_state(env, ptr_regno);
> +	struct bpf_func_state *ptr_state = func(env, reg);
> +	int err;
> +	int min_off, max_off;
> +
> +	if (tnum_is_const(reg->var_off)) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "%s: fixed stack access illegal: reg=%d var_off=%s off=%d size=%d\n",
> +			__func__, ptr_regno, tn_buf, off, size);
> +		return -EINVAL;

The caller just checked that and this condition can never happen, right?
What is the point of checking it again?

> +	}
> +	/* Note that we pass a NULL meta, so raw access will not be permitted.
>  	 */
> -	if (!tnum_is_const(reg->var_off)) {
> +	err = check_stack_range_initialized(env, ptr_regno, off, size,
> +					    false, ACCESS_DIRECT, NULL);
> +	if (err)
> +		return err;
> +
> +	min_off = reg->smin_value + off;
> +	max_off = reg->smax_value + off;
> +	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
> +	return 0;
> +}
> +
> +/* check_stack_read dispatches to check_stack_read_fixed_off or
> + * check_stack_read_var_off.
> + *
> + * The caller must ensure that the offset falls within the allocated stack
> + * bounds.
> + *
> + * 'dst_regno' is a register which will receive the value from the stack. It
> + * can be -1, meaning that the read value is not going to a register.
> + */
> +static int check_stack_read(struct bpf_verifier_env *env,
> +			    int ptr_regno, int off, int size,
> +			    int dst_regno)
> +{
> +	struct bpf_reg_state *reg = reg_state(env, ptr_regno);
> +	struct bpf_func_state *state = func(env, reg);
> +	int err;
> +	/* Some accesses are only permitted with a static offset. */
> +	bool var_off = !tnum_is_const(reg->var_off);
> +
> +	/* The offset is required to be static when reads don't go to a
> +	 * register, in order to not leak pointers (see
> +	 * check_stack_read_fixed_off).
> +	 */
> +	if (dst_regno < 0 && var_off) {
>  		char tn_buf[48];
>  
>  		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -		verbose(env, "variable stack access var_off=%s off=%d size=%d\n",
> +		verbose(env, "var-offset stack reads only permitted to register; var_off=%s off=%d size=%d\n",

The message is confusing. "read to register"? what is "read to not register" ?
Users won't be able to figure out that it means helpers access.
Also nowadays it means that atomic ops won't be able to use var_off into stack.
I think both limitations are ok for now. Only the message needs to be clear.

>  			tn_buf, off, size);
>  		return -EACCES;
>  	}
> +	/* Variable offset is prohibited for unprivileged mode for simplicity
> +	 * since it requires corresponding support in Spectre masking for stack
> +	 * ALU. See also retrieve_ptr_limit().
> +	 */
> +	if (!env->bypass_spec_v1 && var_off) {
> +		char tn_buf[48];
>  
> -	if (off >= 0 || off < -MAX_BPF_STACK) {
> -		verbose(env, "invalid stack off=%d size=%d\n", off, size);
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
> +				ptr_regno, tn_buf);
>  		return -EACCES;
>  	}
>  
> -	return 0;
> +	if (tnum_is_const(reg->var_off)) {

This is the same as 'bool var_off' variable above. Why not to use it here?

> +		off += reg->var_off.value;
> +		err = check_stack_read_fixed_off(env, state, off, size,
> +						 dst_regno);
> +	} else {
> +		/* Variable offset stack reads need more conservative handling
> +		 * than fixed offset ones. Note that dst_regno >= 0 on this
> +		 * branch.
> +		 */
> +		err = check_stack_read_var_off(env, ptr_regno, off, size,
> +					       dst_regno);
> +	}
> +	return err;
> +}
> +
> +
> +/* check_stack_write dispatches to check_stack_write_fixed_off or
> + * check_stack_write_var_off.
> + *
> + * 'ptr_regno' is the register used as a pointer into the stack.
> + * 'off' includes 'ptr_regno->off', but not its variable offset (if any).
> + * 'value_regno' is the register whose value we're writing to the stack. It can
> + * be -1, meaning that we're not writing from a register.
> + *
> + * The caller must ensure that the offset falls within the maximum stack size.
> + */
> +static int check_stack_write(struct bpf_verifier_env *env,
> +			     int ptr_regno, int off, int size,
> +			     int value_regno, int insn_idx)
> +{
> +	struct bpf_reg_state *reg = reg_state(env, ptr_regno);
> +	struct bpf_func_state *state = func(env, reg);
> +	int err;
> +
> +	if (tnum_is_const(reg->var_off)) {
> +		off += reg->var_off.value;
> +		err = check_stack_write_fixed_off(env, state, off, size,
> +						  value_regno, insn_idx);
> +	} else {
> +		/* Variable offset stack reads need more conservative handling
> +		 * than fixed offset ones. Note that value_regno >= 0 on this
> +		 * branch.

I don't understand what the last sentence above means.
The value_regno can still be == -1 here. It's not a bug.
It's not handled yet, but it probably should be eventually.
Please rephrase it.

> +		 */
> +		err = check_stack_write_var_off(env, state,
> +						ptr_regno, off, size,
> +						value_regno, insn_idx);
> +	}
> +	return err;
>  }
>  
> +/* Check that the stack access at the given offset is within bounds. The
> + * maximum valid offset is -1.
> + *
> + * The minimum valid offset is -MAX_BPF_STACK for writes, and
> + * -state->allocated_stack for reads.
> + */
> +static int check_stack_slot_within_bounds(int off,
> +					  struct bpf_func_state *state,
> +					  enum bpf_access_type t)
> +{
> +	int min_valid_off;
> +
> +	if (t == BPF_WRITE)
> +		min_valid_off = -MAX_BPF_STACK;
> +	else
> +		min_valid_off = -state->allocated_stack;
> +
> +	if (off < min_valid_off || off > -1)
> +		return -EACCES;
> +	return 0;
> +}
> +
> +/* Check that the stack access at 'regno + off' falls within the maximum stack
> + * bounds.
> + *
> + * 'off' includes `regno->offset`, but not its dynamic part (if any).
> + */
> +static int check_stack_access_within_bounds(
> +		struct bpf_verifier_env *env,
> +		int regno, int off, int access_size,
> +		enum stack_access_src src, enum bpf_access_type type)
> +{
> +	struct bpf_reg_state *regs = cur_regs(env);
> +	struct bpf_reg_state *reg = regs + regno;
> +	struct bpf_func_state *state = func(env, reg);
> +	int min_off, max_off;
> +	int err;
> +	char *err_extra;
> +
> +	if (src == ACCESS_HELPER)

the ACCESS_HELPER|DIRECT enum should probably be moved right before this function.
It's not used earlier, I think, and it made the reviewing a bit harder than could have been.

> +		/* We don't know if helpers are reading or writing (or both). */
> +		err_extra = " indirect access to";
> +	else if (type == BPF_READ)
> +		err_extra = " read from";
> +	else
> +		err_extra = " write to";

Thanks for improving verifier errors.

> +
> +	if (tnum_is_const(reg->var_off)) {
> +		min_off = reg->var_off.value + off;
> +		if (access_size > 0)
> +			max_off = min_off + access_size - 1;
> +		else
> +			max_off = min_off;
> +	} else {
> +		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
> +		    reg->smax_value <= -BPF_MAX_VAR_OFF) {

hmm. are you sure about smax in both conditions? looks like typo?

> +			verbose(env, "invalid unbounded variable-offset%s stack R%d\n",
> +				err_extra, regno);
> +			return -EACCES;
> +		}
> +		min_off = reg->smin_value + off;
> +		if (access_size > 0)
> +			max_off = reg->smax_value + off + access_size - 1;
> +		else
> +			max_off = min_off;
> +	}

The rest looks good.
