Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2EE631A32
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKUH1d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKUH12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:27:28 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB48F2A419
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:27:23 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id s20so7485695qkg.5
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N/GzluyPSWkkiafMQ/X3ad8pY6FQLM6tSWe5wFhwPI=;
        b=azHIx70oLf6cNP8B+tA+bK7BGGIzjp08wRjFa7ZRS7XcB1oN3t4BHNl0jSVlqbNjMV
         FuiiCKAZa8KAP+YZV5PiQrWYpOxk2tCJoZIfNI4c80/HRRdb7raHdIeFcWmOpC3BC6OL
         YtEcG1m6EG2QpNxnAsAS8iIm1yjuiPb2k1d6LhduZt1Ft7u8zLGgQaD9EP85PUr2LlzG
         bWWl20sPM9EnY3Ptba2Z/6PVyGuSbOk7o3oNVCkhtu+WOtHRhli/H5xZaHXH24RkL9jZ
         SkUscX0QHCmoA7JR5mKSukr1jJ4737ZkzbCWgaQf+uY8QZ6AufIiAdKJT8zK+u0JjP3h
         Kp/Q==
X-Gm-Message-State: ANoB5pkHV8OwiMxq8Crk5HSz0NL6ySmAHH3NbCF7YqtbKhl0vc+t4/a1
        laA1cE5oGYO6u6bYaiLJ4zo=
X-Google-Smtp-Source: AA0mqf5bblSJ5pHyI83z59m4tH1wc/iVE2r/ABMrTlP9528+y23ZpdMNUw13MA8HSa99P/EEvQoDqQ==
X-Received: by 2002:a05:620a:8019:b0:6fa:5257:9aa7 with SMTP id ee25-20020a05620a801900b006fa52579aa7mr639233qkb.150.1669015642493;
        Sun, 20 Nov 2022 23:27:22 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a241100b006f87d28ea3asm7753751qkn.54.2022.11.20.23.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:27:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 01:27:26 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check
 to process_dynptr_func
Message-ID: <Y3soXvFs4WV7/KXj@maniforge.lan>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-6-memxor@gmail.com>
 <Y3bIhyOWs1r22R+2@maniforge.lan>
 <20221120191013.plzlna24vwluxebk@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120191013.plzlna24vwluxebk@apollo>
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

On Mon, Nov 21, 2022 at 12:40:13AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 18, 2022 at 05:19:27AM IST, David Vernet wrote:
> > On Tue, Nov 15, 2022 at 05:31:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > After previous commit, we are minimizing helper specific assumptions
> > > from check_func_arg_reg_off, making it generic, and offloading checks
> > > for a specific argument type to their respective functions called after
> > > check_func_arg_reg_off has been called.
> >
> > What's the point of check_func_arg_reg_off() if helpers have to check
> > offsets after it's been called? Also, in [0], there's now logic in
> > check_func_arg_reg_off() which checks for OBJ_RELEASE arg types, so
> > there's still a precedent for looking at arg types there. IMO it's
> > actually less confusing to just push as much offset checking as possible
> > into one place.
> >
> 
> I think you need to define 'as much offset checking'.

We certainly don't want to make check_func_arg_reg_off() a monster
function, but I think we can do better in terms of making the verifier
consistent and easier to reason about by pushing more logic into it.

My view (subject to change upon learning new context I may be missing)
is that the job of check_func_arg_reg_off() should be to map all
(reg_type x arg_type) combinations to checking the correct offset,
likely by calling __check_ptr_off_reg() with the correct arguments. The
signature / implementation of __check_ptr_off_reg() may need to change
for that to happen, and we may need to e.g. also leverage
__check_mem_access() to accommodate the mem register types.

Yes, doing this may cause check_func_arg_reg_off() to have a potentially
very large switch statement (though there are other ways to address
that), but isn't that preferable to having to read through hundreds or
thousands of lines of verifier code to convince yourself that an offset
was correctly determined for every possible (register x arg_type)?
Having all of that contained in one, well-defined spot seems much
simpler. Please let me know if I've grossly misunderstood something, or
am missing important / relevant context.

> Consider process_kptr_func, it requires var_off to be constant. Same for

IMO that check should certainly go in check_func_arg_reg_off().
__check_ptr_off_reg() already checks for tnum_is_const(reg->var_off) in
__check_ptr_off_reg(), and check_func_arg_reg_off() has all the
information it needs to encapsulate the logic for that check.

> bpf_timer, bpf_spin_lock, bpf_list_head, bpf_list_node, etc. They take
> PTR_TO_MAP_VALUE, PTR_TO_BTF_ID, PTR_TO_BTF_ID | MEM_ALLOC. Should we move all
> of that into check_func_arg_reg_off?
> 
> Some argument types like ARG_PTR_TO_MEM are ok with variable offset, should that
> exception go in this function as well?
> 
> Where do you draw the line here in terms of what that function does?

Personally I think "drawing the line" is the wrong way to think about
it. We need to decide what role the function plays, and generalize it in
a way that's consistent and clear. IMO its role at a high level should
be, "The verify arg / register offsets step in the verifier". If you
break that encapsulation, it becomes much more difficult to build a
consistent mental model of what the verifier is doing. Note that this
applies to other verification steps as well, such as e.g. verifying
types, verifying proper refcounts, etc. Perhaps I'm grossly naive for
thinking this is possible? Please let me know if you think that's the
case.

Anyways, it might not be possible to aggregate all logic for checking
reg->off into the function in the codebase as it exists today, but it
seems like a desirable end-state, and it feels like a step backwards to
start selectively moving reg->off checking out of
check_func_arg_reg_off() and into arg / helper specific functions.

> IMO, there are a certain set of properties that check_func_arg_reg_off provides,
> you could say that if each register type was a class, then the checks there
> would be what you would do while constructing them on calling:
> 
> PtrToStack(off, var_off /* can be const or variable */)
> PtrToMapValue(off, var_off /* can be const or variable */)
> PtrToBtfId(off /* must be >= 0 */) /* no var_off */

Hmmm, but these are all just reg_type, right? Why are we checking
OBJ_RELEASE in check_func_arg_reg_off() if that's the case?

> How they get used by each helper and what further checks each helper needs to do
> on them based on the arg_type should be done at a later stage when the specific
> argument type is processed.

I definitely agree that there may be helper-specific verification that
needs to be done. We're talking about arg_type and reg_type, though.
Those aren't specific to an _individual_ helper (though yes, of course
arg_types are specific to whatever _sets_ of helpers take them, such as
e.g. dynptrs).

If we go with the approach of having individual arg types or sets of
helpers verify offsets, I think that still needs to be generalized so
that it's happening in a single place. This would involve something
like:

1. Having check_func_arg_reg_off() as it exists today be renamed to
check_func_reg_off(), and be solely responsible for checking reg_type.

2. Update check_func_arg_reg_off() to contain all the logic which does
actual arg type checking, possibly calling out to one of many possible
helper functions depending on the arg type.

My main issue is really just the fact that all of this logic is
scattered throughout the verifier.

> Agreed that, it's not perfect, with the odd case for PTR_TO_STACK having non-0
> reg->off for OBJ_RELEASE. But IMO once you realise it makes no sense to release
> PTR_TO_STACK and that PTR_TO_STACK actually points to the real pointer being
> released, it needs to be handled specially.
> 
> > [0]: https://lore.kernel.org/all/20221115000130.1967465-5-memxor@gmail.com/
> >
> > > This allows relying on a consistent set of guarantees after that call
> > > and then relying on them in code that deals with registers for each
> > > argument type later. This is in line with how process_spin_lock,
> > > process_timer_func, process_kptr_func check reg->var_off to be constant.
> > > The same reasoning is used here to move the alignment check into
> > > process_dynptr_func. Note that it also needs to check for constant
> > > var_off, and accumulate the constant var_off when computing the spi in
> > > get_spi, but that fix will come in later changes.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 34e67d04579b..fd292f762d53 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5774,6 +5774,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > >  		return -EFAULT;
> > >  	}
> > >
> > > +	/* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
> > > +	 * check_func_arg_reg_off's logic. We only need to check offset
> > > +	 * alignment for PTR_TO_STACK.
> > > +	 */
> > > +	if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
> > > +		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > > +		return -EINVAL;
> > > +	}
> >
> > As alluded to above, I personally think it's more confusing to have this
> > check in process_dynptr_func(). On the one hand you have
> > check_func_arg_reg_off() which verifies that a register has the correct
> > offset, but then here we have to check for the register offset for
> > PTR_TO_STACK dynptrs specifically? Wouldn't it be better to try and push
> > as much of the offset-checking complexity into one place as possible?
> >
> 
> I'm trying to make a split between 'offset correct for the reg->type in
> general', and 'offset correct for the reg->type when when passed as an argument
> for arg_type'. I think the latter is specific and different for each case and
> thus belongs inside the case ARG_TYPE_* block of each of those.

If we're going to do that, IMO we should just remove the arg_type
parameter from the function altogether. Having specific arg_type logic
in the function feels artificial.

> Anyhow, all of this is not to reject your point, but to say that if we're
> keeping that check in check_func_arg_reg_off for dynptr, let's also examine why
> we should/shouldn't move checks for other arg_types inside it as well, and
> whether the end result is going to be better than this.

Agreed that this is the crux of the issue. I think I've said my piece so
I won't reply directly to this point here.

> In that case, atleast to me, it doesn't make sense to check reg->off %
> BPF_REG_SIZE for ARG_PTR_TO_DYNPTR while leaving out other arg types.
