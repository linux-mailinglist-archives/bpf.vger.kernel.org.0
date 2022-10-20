Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034D16054AE
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 03:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJTBKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 21:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTBKK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 21:10:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B891100BD9
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:10:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y8so18816129pfp.13
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtnfF76Vhhf2jeATpCMbZv9JSJYa3RNveQmfIbtJtBQ=;
        b=fAKkrprwJMjm297N3h1gwTabjJVdEbymCeCHmbXAOARlEE2JQ7zAdxOJuhSqNbmrIs
         jR+J1vu7TJo6uGgAPaY8CzZABWVKsjYPP4STv3k9S9CpptxQoK8xeW/anvSsQpx3YcaU
         NvdVUxfKMhwTEP9BTTz56eebnxOtc9m1PwSGpFOGtqqxz43d/CsS8+dLBBDneTTSA/MC
         2XNnu+55yLz51pJkEKtMo8OXXolWqpTR/xZ+jfj2qU4zIRQd4WDdaaiBLJHH71J8VFYY
         /8mqaL7m1RuuIXOOCV/yHxFwYAj+Ux8rw7nX5veA9U4yLUs8QSbQ2Vog3STQEw33dIgM
         8XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtnfF76Vhhf2jeATpCMbZv9JSJYa3RNveQmfIbtJtBQ=;
        b=DnE0nzTMvh7MK+o7wDiGFCkkemxFuv/WEsCosftYUL5goxBMlhgY/E83jNTZhiMIml
         MnFwOZXPmlV4Vacy2fbaXrdk76E6HNnWqGVcC/Ruk5l/QcOQ/0tsKLV1LZPXZNzLVgse
         cFWFuViODR4xlje0kBwVOAJJm4A4Cc5KwXkVQYjZFnA6R0+S2noCTN+UzxO5nvjDp3fq
         BbOMvIXvYb4bzJyYRkUrP+3DDemLQJvCUKEAdUK/+nnELrSUmW5H13SzHLZEaspRE4A2
         ZP/iMelv3cDyhN3pcyZvufloAxp1rUbZkYM1XmOyi9/5X8fT7KANBQ1A6H3KzeVwQTTR
         jl1g==
X-Gm-Message-State: ACrzQf0dSVqORli5pYZ0gJQLHkqe3bOq1/YHmR1dH34/vCIxz2xY/BWu
        eH/4ZCNgdf73ym/yfONDSK0=
X-Google-Smtp-Source: AMsMyM5mkgecO2PZTHqlpoi9+whOpHT8AlRO9NipoKE6a3uwiLOF2j1wbN00pT3I1j7nqBh8wEGvPQ==
X-Received: by 2002:a05:6a00:b85:b0:563:4623:ec40 with SMTP id g5-20020a056a000b8500b005634623ec40mr11358964pfj.56.1666228206952;
        Wed, 19 Oct 2022 18:10:06 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id i196-20020a636dcd000000b00434abd19eeasm10390400pgc.78.2022.10.19.18.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:10:06 -0700 (PDT)
Date:   Thu, 20 Oct 2022 06:39:55 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/13] bpf: Rework process_dynptr_func
Message-ID: <20221020010955.5vxirswpmqva2tq7@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-3-memxor@gmail.com>
 <Y08z6U1iAcv4IwDY@maniforge.DHCP.thefacebook.com>
 <20221019061821.4cpls2alap74uppu@apollo>
 <Y1AgLhWygv1yCRQ8@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AgLhWygv1yCRQ8@maniforge.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 09:35:02PM IST, David Vernet wrote:
> On Wed, Oct 19, 2022 at 11:48:21AM +0530, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > > In all of these cases, PTR_TO_DYNPTR shouldn't be allowed to be passed
> > > > to such helpers, however the current code simply returns 0.
> > > >
> > > > The rejection for helpers that release the dynptr is already handled.
> > > >
> > > > For fixing this, we take a step back and rework existing code in a way
> > > > that will allow fitting in all classes of helpers and have a coherent
> > > > model for dealing with the variety of use cases in which dynptr is used.
> > > >
> > > > First, for ARG_PTR_TO_DYNPTR, it can either be set alone or together
> > > > with a DYNPTR_TYPE_* constant that denotes the only type it accepts.
> > > >
> > > > Next, helpers which initialize a dynptr use MEM_UNINIT to indicate this
> > > > fact. To make the distinction clear, use MEM_RDONLY flag to indicate
> > > > that the helper only operates on the memory pointed to by the dynptr,
> > >
> > > Hmmm, it feels a bit confusing to overload MEM_RDONLY like this. I
> > > understand the intention (which is logical) to imply that the pointer to
> > > the dynptr is read only, but the fact that the memory contained in the
> > > dynptr may not be read only will doubtless confuse people.
> > >
> > > I don't really have a better suggestion. This is the proper use of
> > > MEM_RDONLY, but it really feels super confusing. I guess this is
> > > somewhat mitigated by the fact that the read-only nature of the dynptr
> > > is something that will be validated at runtime?
> > >
> >
> > Nope, both dynptr's const-ness and const-ness of the memory it points to are
> > supposed to be tracked statically. It's part of the type of the dynptr.
>
> Could you please clarify what you're "noping" here? The dynptr being
> read-only is tracked statically, but based on the discussion in the
> thread at [0] I thought the plan was to enforce this property at
> runtime. Am I wrong about that?
>
> [0]: https://lore.kernel.org/bpf/CAJnrk1Y0r3++RLpT2jvp4st-79x3dUYk3uP-4tfnAeL5_kgM0Q@mail.gmail.com/
>

The more updated version of [0] is https://lore.kernel.org/bpf/CAEf4BzawD+_buWqp_U3cu71QZH_OVTseuSUyEcva9qCd1=GQ-A@mail.gmail.com .

> My point was just that it might be less difficult to confuse
> CONST_PTR_TO_DYNPTR | MEM_RDONLY with the memory contained in the dynptr
> region if there's a separate field inside the dynptr itself which tracks
> whether that region is R/O. I'm mostly just thinking out loud -- as I
> said in the last email I think using MEM_RDONLY as you are is logical.
>
> > The second case doesn't exist yet, but will soon (with skb dynptrs abstracting
> > over read only __sk_buff ctx).
> >
> > So what MEM_RDONLY in argument type really means is that I take a pointer to
> > const struct bpf_dynptr, which means I can't modify the struct bpf_dynptr itself
> > (so it's size, offset, ptr, etc.), but that is independent of r/w state of what
> > it points to.
> >
> > const T *p vs T *const p
>
> Right, I understand the intention of the patch (which was why I said it
> was a logical choice) and the distinction between the two variants of
> const. My point was that at first glance, someone who's not a verifier
> expert who's trying to understand all of this to enable their writing of
> a BPF program may be thrown off by seeing "PTR_TO_DYNPTR | RDONLY".
> Hopefully that's something we can address with adequately documenting
> helpers, and in any case, it's certainly not an argument against your
> overall approach.
>
> Also, I think it will end up being more clear if and when we have e.g.
> a helper that takes a CONST_PTR_TO_DYNPTR | MEM_RDONLY dynptr, and
> returns e.g. an R/O PTR_TO_MEM | MEM_RDONLY pointer to its backing
> memory.
>
> Anyways, at the end of the day this is really all implementation details
> of the verifier and BPF internals, so I digress...
>
> > In this case it's the latter. Soon we will also support const T *const p.
> >
> > Hence, MEM_RDONLY is at the argument type level, translating to reg->type, and
> > the read only status for the dynptr's memory slice will be part of dynptr
> > specific register state (dynptr.type).
> >
> > But I am open to more suggestions on how to write this stuff, if it makes the
> > code easier to read.
>
> I think what you have makes sense and IMO is the cleanest way to express
> all of this.
>
> The only thing that I'm now wondering after sleeping on this is whether
> it's really necessary to rename the register type to CONST_PTR_TO_DYNPTR.
> We're already restricting that it always be called with MEM_RDONLY. Are
> we _100%_ sure that it will always be fully static whether a dynptr is
> R/O? I know that Joanne said probably yes in [1], but it feels perhaps
> unnecessarily restrictive to codify that by making the register type
> CONST_PTR_TO_DYNPTR. Why not just make it PTR_TO_DYNPTR and keep the
> verifications you added in this patch that it's always specified with
> MEM_RDONLY, and then if we ever change our minds and later decide to add
> helpers that can change the access permissions on the dynptr, it will
> just be a matter of changing our expectations around the presence of
> that MEM_RDONLY modifier?
>

I'm not too worried about whether it can change in the future or not, if it does
we can rename the register type and rework the code accordingly. But mostly this
will be used to pass in dynptr ref to callbacks and similar cases, where you
don't want the callback to modify the dynptr itself that is passed in.

Maybe a use case will come up later, but we can revisit it when that happens.

> [1]: https://lore.kernel.org/bpf/CAJnrk1Zmne1uDn8EKdNKJe6O-k_moU9Sryfws_J-TF2BvX2QMg@mail.gmail.com/
>
> [...]
>
> > > >  	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> > > >  	if (arg_type == ARG_PTR_TO_DYNPTR)
> > > >  		return true;
> > > >
> > > >  	dynptr_type = arg_to_dynptr_type(arg_type);
> > > > -
> > > > -	return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> > > > +	if (reg->type == CONST_PTR_TO_DYNPTR) {
> > > > +		return reg->dynptr.type == dynptr_type;
> > > > +	} else {
> > > > +		spi = get_spi(reg->off);
> > > > +		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> > > > +	}
> > > >  }
> > > >
> > > >  /* The reg state of a pointer or a bounded scalar was saved when
> > > > @@ -1317,9 +1346,6 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
> > > >  	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
> > > >  };
> > > >
> > > > -static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> > > > -				struct bpf_reg_state *reg);
> > > > -
> > > >  /* This helper doesn't clear reg->id */
> > > >  static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
> > > >  {
> > > > @@ -1382,6 +1408,25 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
> > > >  	__mark_reg_known_zero(regs + regno);
> > > >  }
> > > >
> > > > +static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
> > > > +			       struct bpf_reg_state *reg2,
> > > > +			       enum bpf_dynptr_type type)
> > > > +{
> > > > +	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
> > > > +	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR.
> > > > +	 */
> > >
> > > Meh, this is mildly confusing. Please correct me if my understanding is wrong,
> > > but the reason this is the case is that we only set the struct bpf_reg_state
> > > from the stack, whereas the actual reg itself of course has PTR_TO_STACK. If
> > > that's the case, can we go into just a bit more detail here in this comment
> > > about what's going on? It's kind of confusing that we have an actual register
> > > of type PTR_TO_STACK, which points to stack register state of (inconsequential)
> > > type CONST_PTR_TO_DYNPTR. It's also kind of weird (but also inconsequential)
> > > that we have dynptr.first_slot for CONST_PTR_TO_DYNPTR.
> > >
> >
> > There are two cases which this function is called for, one is for the
> > spilled registers for dynptr on the stack. In that case it *is* the dynptr, so
> > reg->type as CONST_PTR_TO_DYNPTR is meaningless/wrong, and not checked. The type
> > is already part of slot_type == STACK_DYNPTR.
>
> Ok, thanks for confirming my understanding.
>
> > We reuse spilled_reg part of stack state to store info about the dynptr. We need
> > two spilled_regs to fully track it.
> >
> > Later, we will have more owned objects on the stack (bpf_list_head, bpf_rb_root)
> > where you splice it out. Their handling will have to be similar.
> >
> > PTR_TO_STACK points to the slots whose spilled registers we will call this
> > function for. That is different from the second case, i.e. for callback R1,
> > where it will be CONST_PTR_TO_DYNPTR. For consistency, I marked it as first_slot
> > because we always work using the first dynptr slot.
> >
> > So to summarize:
> >
> > PTR_TO_STACK points to bpf_dynptr on stack. So we store this info as 2 spilled
> > registers on the stack. In that case both of them are the first and second slot
> > of the dynptr (8-bytes each). They are the actual dynptr object.
> >
> > In second case we set dynptr state on the reg itself, which points to actual
> > dynptr object. The reference now records the information we need about the
> > object.
> >
> > Yes, it is a bit confusing, and again, I'm open to better ideas. The
> > difference/confusion is mainly because of different places where state is
> > tracked. For the stack we track it in stack state precisely, for
> > CONST_PTR_TO_DYNPTR it is recorded in the pointer to dynptr object.
>
> Thanks for clarifying, then my initial understanding was correct. If
> that's the case, what do you think about this suggestion to make the
> code a bit more consistent:
>
> > > Just my two cents as well, but even if the field isn't really used for
> > > anything, I would still add an additional enum bpf_reg_type parameter that sets
> > > this to STACK_DYNPTR, with a comment that says it's currently only used by
> > > CONST_PTR_TO_DYNPTR registers.
>
> I would rather reg->type be _unused_ for the dynptr in the spilled
> registers on the stack, then be both unused and meaningless/wrong (as
> you put it).
>
> [...]
>
> Thanks,
> David
