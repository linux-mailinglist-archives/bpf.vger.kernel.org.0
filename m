Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B676315B3
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKTSlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKTSlu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:41:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ECE24BFA
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:41:49 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 6so9310837pgm.6
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZCco4S5dk7GQ/DEkq/+jsFiKN0P6BX0SoLxdQldOVs=;
        b=mFRHp+EZhYYPutcHoTcVO/T1uMnnjnldXkfiTJJENGPztJOL76HnVaegNS3YEuhP/x
         T6Jqn73SQjB84r+OO2WQq9BQsnPUwY9W8cq1nVHZY2nyT4enRLtE9jCpeN644Kpg3kqy
         u+MYvp8FP0bmAaAg6dtLkFcXcn/sOfUgXpz2sR+4tTEGPXIfLyc/FwOyBX4h28sPCGzs
         erUEJfxCsmcbpP6wd38hw1n9tYNj9Eewx1TGC3wHUwbNRdjdG9u0XKL5PMHiiBdc+uQJ
         +FZZ6rhCrJrNTEnpL44mGWIHijtWhI1C9geuveuRbj7UkQ6DFF21fbTaIN/+ATmg9fc1
         19Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZCco4S5dk7GQ/DEkq/+jsFiKN0P6BX0SoLxdQldOVs=;
        b=Jr1wgcIqF7HKzCKvad+mClW8B8U+UsRgaDmzW5R0y6JQ0L15vTa1zBXdzcnCnGvZwg
         puSElH29fFM8nyVeR9e7x2HyPmu+okF39zSAT9gYW9pPcMR1ynjfBL0QQpwQnNEMv5El
         j3ARPGafYn1utB1yAbo/SmP3D3mNvDHG/5Q0BmGEJ+0Khs+GQpE6O0baOtVoTTHPmLvb
         oJShUR+ceUDZS/y2bqmTqI0N2mwA1LC+tYfs7+r7Kcwrb8Dh7YhweUobPezc6s3pMWi2
         tY7XRB47wy/P/xdCXWc10BKeuUwj2vm/hFrn3kyiVMnlDqfIjxFIDxs9cBuYrSaEsay6
         RIHQ==
X-Gm-Message-State: ANoB5pmuPqX8pdptcS76+OFy4lEOmH2hnFQJlXsmKuwbiFTjWbXpB5OQ
        ellmOykxmZWQow9VEq7dR+o=
X-Google-Smtp-Source: AA0mqf4E7R4ji/wVWHiwFQt5+aEweofa2F4ZaKKHp7i6PU6+EMHRaoKH9WtNAM8sDF8uRHrZ6kra2w==
X-Received: by 2002:a63:db0a:0:b0:459:35b1:1396 with SMTP id e10-20020a63db0a000000b0045935b11396mr14993357pgg.593.1668969708724;
        Sun, 20 Nov 2022 10:41:48 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b00186afd756edsm7828718plk.283.2022.11.20.10.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 10:41:48 -0800 (PST)
Date:   Mon, 21 Nov 2022 00:11:37 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Rework check_func_arg_reg_off
Message-ID: <20221120184137.6sshrzwlpojggv2y@apollo>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-5-memxor@gmail.com>
 <Y3bGz6glidknanpf@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3bGz6glidknanpf@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 05:12:07AM IST, David Vernet wrote:
> On Tue, Nov 15, 2022 at 05:31:27AM +0530, Kumar Kartikeya Dwivedi wrote:
> > While check_func_arg_reg_off is the place which performs generic checks
> > needed by various candidates of reg->type, there is some handling for
> > special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> > ARG_PTR_TO_ALLOC_MEM.
> >
> > This commit aims to streamline these special cases and instead leave
> > other things up to argument type specific code to handle. The function
> > will be restrictive by default, and cover all possible cases when
> > OBJ_RELEASE is set, without having to update the function again (and
> > missing to do that being a bug).
> >
> > This is done primarily for two reasons: associating back reg->type to
> > its argument leaves room for the list getting out of sync when a new
> > reg->type is supported by an arg_type.
> >
> > The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> > we already handle, whenever a release argument is expected, it should
> > be passed as the pointer that was received from the acquire function.
> > Hence zero fixed and variable offset.
> >
> > There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> > its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> > with non-zero offset to other helper functions, which makes sense.
>
> Agreed -- just out of curiosity do you know what the rationale was for
> it disallowing offsets in the first place?
>

64620e0a1e71 ("bpf: Fix out of bounds access for ringbuf helpers")
It predates OBJ_RELEASE's addition.

> > Hence, lift the arg_type_is_release check for reg->off and cover all
> > possible register types, instead of duplicating the same kind of check
> > twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).
> >
> > For the release argument, arg_type_is_dynptr is the special case, where
> > we go to actual object being freed through the dynptr, so the offset of
> > the pointer still needs to allow fixed and variable offset and
> > process_dynptr_func will verify them later for the release argument case
> > as well.
> >
> > This is not specific to ARG_PTR_TO_DYNPTR though, we will need to make
> > this exception for any future object on the stack that needs to be
> > released. In this sense, PTR_TO_STACK as a candidate for object on stack
> > argument is a special case for release offset checks, and they need to
> > be done by the helper releasing the object on stack.
> >
> > Since the check has been lifted above all register type checks, remove
> > the duplicated check that is being done for PTR_TO_BTF_ID.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 62 ++++++++++++-------
> >  .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
> >  2 files changed, 39 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c484e632b0cd..34e67d04579b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6092,11 +6092,38 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  			   const struct bpf_reg_state *reg, int regno,
> >  			   enum bpf_arg_type arg_type)
> >  {
> > -	enum bpf_reg_type type = reg->type;
> > -	bool fixed_off_ok = false;
> > +	u32 type = reg->type;
> >
> > -	switch ((u32)type) {
> > -	/* Pointer types where reg offset is explicitly allowed: */
> > +	/* When referenced register is passed to release function, it's fixed
>
> s/it's/its
>

Ack.

> > +	 * offset must be 0.
> > +	 *
> > +	 * We will check arg_type_is_release reg has ref_obj_id when storing
> > +	 * meta->release_regno.
> > +	 */
> > +	if (arg_type_is_release(arg_type)) {
> > +		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
> > +		 * may not directly point to the object being released, but to
> > +		 * dynptr pointing to such object, which might be at some offset
> > +		 * on the stack. In that case, we simply to fallback to the
> > +		 * default handling.
> > +		 */
>
> I personally am not a fan of this. We'd now have an entirely separate
> branch of logic for most OBJ_RELEASE args, but then we fall through to
> default handling for only PTR_TO_STACK specifically? That kind of
> tactical complexity / readability tax is unfortunate, and adds up
> quickly. It's already gotten pretty pervasive in the verifier, and I
> personally would prefer to see us moving away from adding small one-off
> conditional branches like this in the verifier when possible.

I think that's because PTR_TO_STACK is a bit special. Unlike normal register
types which you get from acquire functions, you instead create some kind of
resource on the stack in this case. So the actual pointer that is to be released
(dynptr wrapping ringbuf reservation) is actually on the stack, and unlike the
normal case there is an indirection.

This will be the same with more cases in the future (e.g. moving a list_head to
the stack, which you will have to release, etc.).

>
> It seems to me like the problem we're trying to solve is that both arg
> type and register type are relevant when detecting whether a register is
> allowed to have nonzero offsets. It would be ideal if we could encode
> some of this at build-time, similar to how we statically define and
> compare compatible_reg_types in check_reg_type(). Is there some way for
> us to do this for allowing offsets? Like maybe we can hoist some of the
> build logic for how we define compatible_reg_types into a separate
> table-like header file that can be included in multiple places to
> construct statically-defined, constant arrays where all of this logic is
> encoded? These check-offset / check-type functions could then really
> just be lookups into these const arrays, and e.g. enabling new arg types
> for register types could be captured by adding an entry to that
> header-file table.
>

It would be easier to understand this if you can share it as an RFC/PoC (i.e. if
you determine it helps and is an improvement in terms of readability).

> Maybe that's overkill for this specific example, but I really feel like
> we need to start to try and move away from these one-off conditional
> branches which collectively create a lot of complexity, and make it
> difficult to reason about high-level correctness in the verifier.
>

I totally agree. The code is complicated.

> To be clear: I won't block your change on this, but I'd like to hear
> what you think about it as an idea, and I personally would really like
> to see the verifier moving in that direction in general.
>

I'm all for simplifications. I already tried dropping a few special cases, but I
was not able to figure out how we can capture the requirement for objects on
stack being released any better than this.

Feel free to provide more suggestions though, based on the above.

> > +		if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {

So technically this will be called arg_type_is_object_on_stack once we have more
cases in the future.

> > +			/* Doing check_ptr_off_reg check for the offset will
> > +			 * catch this because fixed_off_ok is false, but
> > +			 * checking here allows us to give the user a better
> > +			 * error message.
> > +			 */
> > +			if (reg->off) {
> > +				verbose(env, "R%d must have zero offset when passed to release func\n",
> > +					regno);
> > +				return -EINVAL;
> > +			}
>
> Why is this check necessary? To get a better error message in the
> verifier if the register offset is nonzero? If so, IMO I don't think
> that's a good enough reason to completely circumvent calling
> __check_ptr_off_reg().

But it's not circumvented, it's called after this check?

> Not for correctness, but because it's
> __check_ptr_off_reg()'s job to look at the register offset (that's what
> the fixed_off_ok arg is for after all), and adding one-off checks like
> which duplicate checks in other functions, it ends up ballooning the
> code and complexity in the verifier. If we want to have a different
> message for testing the offset being zero depending on the arg type,
> that's where it belongs.
>

The problem is that it's also invoked in other places outside of
check_func_arg_reg_off where that bool is_release_arg parameter would make no
sense.

I don't have a strong opinion on moving it inside the function though, just
sharing my thoughts.

> > +			return __check_ptr_off_reg(env, reg, regno, false);
> > +		}
> > +		/* Fallback to default handling */
> > +	}
> > +	switch (type) {
> > +	/* Pointer types where both fixed and variable offset is explicitly allowed: */
> >  	case PTR_TO_STACK:
> >  		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> >  			verbose(env, "cannot pass in dynptr at an offset\n");
> > @@ -6113,35 +6140,22 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	case PTR_TO_BUF:
> >  	case PTR_TO_BUF | MEM_RDONLY:
> >  	case SCALAR_VALUE:
> > -		/* Some of the argument types nevertheless require a
> > -		 * zero register offset.
> > -		 */
> > -		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> > -			return 0;
>
> Doesn't this result in a change of behavior beyond just verifying an
> offset of 0? Before, in addition to checking offset 0, we were also
> verifying that e.g. reg->off was nonnegative for ARG_PTR_TO_ALLOC_MEM.

Since that translates to PTR_TO_MEM, __check_mem_access handles the negative
offset case (all memory types do, and PTR_TO_BTF_ID interprets off as u32).
PTR_TO_STACK has to explicitly permit reg->off < 0.

> Now we only do that if it's OBJ_RELEASE. I'm actually not following why
> we wouldn't want to invoke __check_ptr_offset() for any of these other
> register types.
>

Because all of them having non-zero reg->off, reg->var_off is totally ok. The
point of this function is to reject all other register types.

> > -		break;
> > +		return 0;
> >  	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
> >  	 * fixed offset.
> >  	 */
> >  	case PTR_TO_BTF_ID:
> >  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> >  		 * it's fixed offset must be 0.	In the other cases, fixed offset
>
> Not your change, but while you're here could you please fix s/it's/its
>

Will do.
