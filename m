Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB27B63198A
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 06:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKUFjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 00:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKUFjh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 00:39:37 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09611A05
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 21:39:35 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id l2so6678753qtq.11
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 21:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOjw9UuRQ6zQ8UUPxg+5+S/jpUhuzxsS1fU+b95A3s8=;
        b=dp8bwcfuCZsFCRe7yviZnvIlS0tudf+MCRb1bRJMTUl9lUdEEbWf/zcZyU6dqCLdUd
         4dwK+eGzqq5oPFzsGlyJvGd+cjhwu2fxS+raEPYUgvpNiui0MrQiQlsMxAEMIEsT9S0R
         /k8IOC/K1jNBYAzFCYxd+Aw5h0dopmpCOVY8u1Dmqn1MkTsu0RbGNg7F3A45ai2wGg79
         n7ooaUmYrV6fVL9qxKRnUYYo1QgldYVzvxjeSmjZeH+gWUz1sdCSmAMh3kvii24slKNq
         Le6bjqEugr1NWvYCnmOqVxZRD5OLfJCN6pMiW1NJ7HXP3tJeGablPH/Tz2Q7bLgPrsHh
         yedg==
X-Gm-Message-State: ANoB5pkiJsNRXTfcKTVNVRcZIFHAbEOK+XB5G9WguRjgT5VaOwkKplnl
        Bcyh51yPCOejyMDiAqF2iW8=
X-Google-Smtp-Source: AA0mqf6WBdUdZDcXMhAZLHaczCShnEOycg4AubUPl8PA/28mpNJdafNTa4UVL5KUy46s0hOd6MI5aw==
X-Received: by 2002:ac8:7ee9:0:b0:3a5:869b:2222 with SMTP id r9-20020ac87ee9000000b003a5869b2222mr16229397qtc.657.1669009174682;
        Sun, 20 Nov 2022 21:39:34 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id v4-20020a05620a0a8400b006fa8299b4d5sm7411642qkg.100.2022.11.20.21.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:39:34 -0800 (PST)
Date:   Sun, 20 Nov 2022 23:39:38 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Rework check_func_arg_reg_off
Message-ID: <Y3sPGl8WM2SStWrS@maniforge.lan>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-5-memxor@gmail.com>
 <Y3bGz6glidknanpf@maniforge.lan>
 <20221120184137.6sshrzwlpojggv2y@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120184137.6sshrzwlpojggv2y@apollo>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 12:11:37AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 18, 2022 at 05:12:07AM IST, David Vernet wrote:
> > On Tue, Nov 15, 2022 at 05:31:27AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > While check_func_arg_reg_off is the place which performs generic checks
> > > needed by various candidates of reg->type, there is some handling for
> > > special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> > > ARG_PTR_TO_ALLOC_MEM.
> > >
> > > This commit aims to streamline these special cases and instead leave
> > > other things up to argument type specific code to handle. The function
> > > will be restrictive by default, and cover all possible cases when
> > > OBJ_RELEASE is set, without having to update the function again (and
> > > missing to do that being a bug).
> > >
> > > This is done primarily for two reasons: associating back reg->type to
> > > its argument leaves room for the list getting out of sync when a new
> > > reg->type is supported by an arg_type.
> > >
> > > The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> > > we already handle, whenever a release argument is expected, it should
> > > be passed as the pointer that was received from the acquire function.
> > > Hence zero fixed and variable offset.
> > >
> > > There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> > > its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> > > with non-zero offset to other helper functions, which makes sense.
> >
> > Agreed -- just out of curiosity do you know what the rationale was for
> > it disallowing offsets in the first place?
> >
> 
> 64620e0a1e71 ("bpf: Fix out of bounds access for ringbuf helpers")
> It predates OBJ_RELEASE's addition.

Thanks

[...]

TL;DR: going to ack this for now so the set can land before in plenty of
time before the 6.1 release. Thanks again for the cleanup + fixes in
this set. Left some other comments below that I'd like to discuss and
then possibly address at some point down the road.

Acked-by: David Vernet <void@manifault.com>

> > > +	 * offset must be 0.
> > > +	 *
> > > +	 * We will check arg_type_is_release reg has ref_obj_id when storing
> > > +	 * meta->release_regno.
> > > +	 */
> > > +	if (arg_type_is_release(arg_type)) {
> > > +		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
> > > +		 * may not directly point to the object being released, but to
> > > +		 * dynptr pointing to such object, which might be at some offset
> > > +		 * on the stack. In that case, we simply to fallback to the
> > > +		 * default handling.
> > > +		 */
> >
> > I personally am not a fan of this. We'd now have an entirely separate
> > branch of logic for most OBJ_RELEASE args, but then we fall through to
> > default handling for only PTR_TO_STACK specifically? That kind of
> > tactical complexity / readability tax is unfortunate, and adds up
> > quickly. It's already gotten pretty pervasive in the verifier, and I
> > personally would prefer to see us moving away from adding small one-off
> > conditional branches like this in the verifier when possible.
> 
> I think that's because PTR_TO_STACK is a bit special. Unlike normal register
> types which you get from acquire functions, you instead create some kind of
> resource on the stack in this case. So the actual pointer that is to be released
> (dynptr wrapping ringbuf reservation) is actually on the stack, and unlike the
> normal case there is an indirection.
> 
> This will be the same with more cases in the future (e.g. moving a list_head to
> the stack, which you will have to release, etc.).

Yeah, I understand why it's this way. For now I think it's fine, but IMO
the fact that we branch out like this for different register types is a
sign that we need to add some more indirection here to clarify things a
bit. As you reasonably requested below, once I have more time on my
hands (probably not until 2023), I'm happy to explore this and send out
an RFC patch set. Alexei mentioned that Daniel had been considering
spending some time cleaning up the verifier as well, so I'd be curious
to chat with him and see what he's been thinking.

> > It seems to me like the problem we're trying to solve is that both arg
> > type and register type are relevant when detecting whether a register is
> > allowed to have nonzero offsets. It would be ideal if we could encode
> > some of this at build-time, similar to how we statically define and
> > compare compatible_reg_types in check_reg_type(). Is there some way for
> > us to do this for allowing offsets? Like maybe we can hoist some of the
> > build logic for how we define compatible_reg_types into a separate
> > table-like header file that can be included in multiple places to
> > construct statically-defined, constant arrays where all of this logic is
> > encoded? These check-offset / check-type functions could then really
> > just be lookups into these const arrays, and e.g. enabling new arg types
> > for register types could be captured by adding an entry to that
> > header-file table.
> >
> 
> It would be easier to understand this if you can share it as an RFC/PoC (i.e. if
> you determine it helps and is an improvement in terms of readability).

Totally reasonable request, I'll try to work on this once I get a few
more things taken care of (probably won't be until 2023).

> 
> > Maybe that's overkill for this specific example, but I really feel like
> > we need to start to try and move away from these one-off conditional
> > branches which collectively create a lot of complexity, and make it
> > difficult to reason about high-level correctness in the verifier.
> >
> 
> I totally agree. The code is complicated.
> 
> > To be clear: I won't block your change on this, but I'd like to hear
> > what you think about it as an idea, and I personally would really like
> > to see the verifier moving in that direction in general.
> >
> 
> I'm all for simplifications. I already tried dropping a few special cases, but I
> was not able to figure out how we can capture the requirement for objects on
> stack being released any better than this.
> 
> Feel free to provide more suggestions though, based on the above.

I don't have anything concrete to suggest for this revision.

> > > +		if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {
> 
> So technically this will be called arg_type_is_object_on_stack once we have more
> cases in the future.
> 
> > > +			/* Doing check_ptr_off_reg check for the offset will
> > > +			 * catch this because fixed_off_ok is false, but
> > > +			 * checking here allows us to give the user a better
> > > +			 * error message.
> > > +			 */
> > > +			if (reg->off) {
> > > +				verbose(env, "R%d must have zero offset when passed to release func\n",
> > > +					regno);
> > > +				return -EINVAL;
> > > +			}
> >
> > Why is this check necessary? To get a better error message in the
> > verifier if the register offset is nonzero? If so, IMO I don't think
> > that's a good enough reason to completely circumvent calling
> > __check_ptr_off_reg().
> 
> But it's not circumvented, it's called after this check?

Circumvent was probably the wrong word. What I meant was to say that
this is unnecessarily short-circuiting the same offset check that is
already present in __check_ptr_off_reg(). IMO, the purpose of
check_func_arg_reg_off() is essentially to call __check_ptr_off_reg()
with the correct parameters. It's mapping (reg x arg_type) -> what type
of offset check should be performed for this register. I'm not convinced
that adding another verifier message which complains about specifically
release args is worth the extra cognitive overhead of someone reading
this and trying to understand why there are multiple places where we're
checking reg->off > 0. I think that is especially true given that some
callers are setting OBJ_RELEASE to force a zero-offset check even though
they're not actually release args, so the message may be misleading for
some programs. Perhaps something like this is more generalizable:

int err;
bool fixed_off_ok = false;

...

err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
if (err)
	verbose(env, "R%d reg with reg type %s, arg type %s had invalid offset %d\n",
		regno, reg_type_str(...), arg_type_str(...), reg->off);

return err;

This could be done at the bottom of the function so that all callers
receive the same information in the event of an invalid reg offset.
Apologies for the poor choice of using the word "circumvent" on the
first email.

> 
> > Not for correctness, but because it's
> > __check_ptr_off_reg()'s job to look at the register offset (that's what
> > the fixed_off_ok arg is for after all), and adding one-off checks like
> > which duplicate checks in other functions, it ends up ballooning the
> > code and complexity in the verifier. If we want to have a different
> > message for testing the offset being zero depending on the arg type,
> > that's where it belongs.
> >
> 
> The problem is that it's also invoked in other places outside of
> check_func_arg_reg_off where that bool is_release_arg parameter would make no
> sense.

I agree with you on this -- adding arg_type to __check_ptr_off_reg()
doesn't make sense (that's the point of check_func_arg_reg_off()). What
do you think about my suggestion above instead?

> I don't have a strong opinion on moving it inside the function though, just
> sharing my thoughts.

You're making reasonable points as well. Let me know if the above
clarifies what I meant a bit.

> > > +			return __check_ptr_off_reg(env, reg, regno, false);
> > > +		}
> > > +		/* Fallback to default handling */
> > > +	}
> > > +	switch (type) {
> > > +	/* Pointer types where both fixed and variable offset is explicitly allowed: */
> > >  	case PTR_TO_STACK:
> > >  		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> > >  			verbose(env, "cannot pass in dynptr at an offset\n");
> > > @@ -6113,35 +6140,22 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > >  	case PTR_TO_BUF:
> > >  	case PTR_TO_BUF | MEM_RDONLY:
> > >  	case SCALAR_VALUE:
> > > -		/* Some of the argument types nevertheless require a
> > > -		 * zero register offset.
> > > -		 */
> > > -		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> > > -			return 0;
> >
> > Doesn't this result in a change of behavior beyond just verifying an
> > offset of 0? Before, in addition to checking offset 0, we were also
> > verifying that e.g. reg->off was nonnegative for ARG_PTR_TO_ALLOC_MEM.
> 
> Since that translates to PTR_TO_MEM, __check_mem_access handles the negative
> offset case (all memory types do, and PTR_TO_BTF_ID interprets off as u32).
> PTR_TO_STACK has to explicitly permit reg->off < 0.

Ahh right, it's just PTR_TO_MEM. Thanks for clarifying.

> > Now we only do that if it's OBJ_RELEASE. I'm actually not following why
> > we wouldn't want to invoke __check_ptr_offset() for any of these other
> > register types.
> >
> 
> Because all of them having non-zero reg->off, reg->var_off is totally ok. The
> point of this function is to reject all other register types.

Fair enough. I think part of my confusion here stemmed from the fact
that these register types actually _do_ need to have their offsets
verified, it just happens to be checked somewhere else (as you said, in
__check_mem_access()). I wonder if at some point we want to refactor the
verifier to bring __check_mem_access() into this function, and call it
here for these pointer types? Or some other refactor that unifies where
and how validation is done for different register types and arg types.

IMO a somehwat significant part of the complexity in the verifier is the
result of divergences like this between e.g. different reg types and arg
types. Someone reading check_func_arg(), for example, will see that we
call check_func_arg_reg_off(), and would arguably reasonably assume that
the register offset has been verified by the time this is called.

Anyways, I certainly don't mean to drag your patches through this
digression. If and when we start to consider doing some more refactoring
in the verifier, I think this is something we should keep in mind.

In general this patch LGTM. As mentioned above, I'll sign off now so we
can make sure this gets in before the 6.1 release, but I think it'd be
good to revisit the verifier message thing I mentioned above once we all
have a bit more bandwidth.

Acked-by: David Vernet <void@manifault.com>

[...]
