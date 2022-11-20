Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F136315C5
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKTTK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:10:26 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB66B27FEA
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:10:25 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so12556594pjc.3
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxnjpJKSt6OMF0R5zZCZM7Kk3MDgZtUF6KV/jPCzEfA=;
        b=g85bsTdb2KoyuWJ6WWaPHBEQN2uZvEDoeQSdHNB6ZuURt5fjl26miJU1f/db9vOXiN
         pBpf8YOSSUoyaCenAFOcPq3NbQq+/T8+xUwGvLCKxLqZXKIxa2JkryA0mqgTwmJOcE7P
         M7wd+tbPQF6F+vJK0kFpHBP87P+xFqmclm0CYKthcnXnwZ8mK1eA/+TBLeN57gkwPQSK
         nNoIbLcfDn+X+FHAaEdOmteMNaQ49hY5GkJ5hWmyofwJLTmBd/UPNa5pkfZKYfZ0T03t
         /ZW+UbYe/21ogyLHR01SW/cTB3ohf1DMTmzk7kTploqF852rIQkHLsBAOkJmX8+92LZs
         AiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxnjpJKSt6OMF0R5zZCZM7Kk3MDgZtUF6KV/jPCzEfA=;
        b=0JHKacSz0MNT26PaCSTeseIvZN5zT+eyzEXj2Su/+nXTItOGoGm4a+KmWeewXWgCgY
         8YEIZnqUhmURljZgqAnMycU+aVkaS1Uh4qh+Fiub+dAOKDm91LhW4xr/22h/GAlpPYGP
         9P5WQ/BNWmeBFZQuTCtVKFbTcxq1Fn25t6b76xCmUH1wWIILYl45246pGsCUQS3PAlAp
         zP4SmcoYIISLELnBIYXT1Xa009iOGUBRFYKMS9U7hTiSkE01hvR4jr0WUaI43tOWxwSf
         6bugiP2/fUMCU/kKkaO1WsQ0Oq94AYPv27w1NWFPPOnKrrUdruLONE0Ls6pdoHb6DF9U
         gwnQ==
X-Gm-Message-State: ANoB5pkmp/AwAO1NU8jWqWp7d9rgzn+lpgZJWTFddO0uMQTFI2s6Q4fz
        YRz0DwcEeEA2PsJ6OkrOB+s=
X-Google-Smtp-Source: AA0mqf7BufU8m9imjGlQlOxoIblZevSPN1ewiCxNOd5pvlz9DLwLNVqTuIv3PVcySg2dtSAiIHVKpw==
X-Received: by 2002:a17:902:ccd1:b0:189:2370:7f6a with SMTP id z17-20020a170902ccd100b0018923707f6amr1195433ple.158.1668971425110;
        Sun, 20 Nov 2022 11:10:25 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b00179e1f08634sm7865338plx.222.2022.11.20.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 11:10:24 -0800 (PST)
Date:   Mon, 21 Nov 2022 00:40:13 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check
 to process_dynptr_func
Message-ID: <20221120191013.plzlna24vwluxebk@apollo>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-6-memxor@gmail.com>
 <Y3bIhyOWs1r22R+2@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3bIhyOWs1r22R+2@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 05:19:27AM IST, David Vernet wrote:
> On Tue, Nov 15, 2022 at 05:31:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> > After previous commit, we are minimizing helper specific assumptions
> > from check_func_arg_reg_off, making it generic, and offloading checks
> > for a specific argument type to their respective functions called after
> > check_func_arg_reg_off has been called.
>
> What's the point of check_func_arg_reg_off() if helpers have to check
> offsets after it's been called? Also, in [0], there's now logic in
> check_func_arg_reg_off() which checks for OBJ_RELEASE arg types, so
> there's still a precedent for looking at arg types there. IMO it's
> actually less confusing to just push as much offset checking as possible
> into one place.
>

I think you need to define 'as much offset checking'.

Consider process_kptr_func, it requires var_off to be constant. Same for
bpf_timer, bpf_spin_lock, bpf_list_head, bpf_list_node, etc. They take
PTR_TO_MAP_VALUE, PTR_TO_BTF_ID, PTR_TO_BTF_ID | MEM_ALLOC. Should we move all
of that into check_func_arg_reg_off?

Some argument types like ARG_PTR_TO_MEM are ok with variable offset, should that
exception go in this function as well?

Where do you draw the line here in terms of what that function does?

IMO, there are a certain set of properties that check_func_arg_reg_off provides,
you could say that if each register type was a class, then the checks there
would be what you would do while constructing them on calling:

PtrToStack(off, var_off /* can be const or variable */)
PtrToMapValue(off, var_off /* can be const or variable */)
PtrToBtfId(off /* must be >= 0 */) /* no var_off */

How they get used by each helper and what further checks each helper needs to do
on them based on the arg_type should be done at a later stage when the specific
argument type is processed.

Agreed that, it's not perfect, with the odd case for PTR_TO_STACK having non-0
reg->off for OBJ_RELEASE. But IMO once you realise it makes no sense to release
PTR_TO_STACK and that PTR_TO_STACK actually points to the real pointer being
released, it needs to be handled specially.

> [0]: https://lore.kernel.org/all/20221115000130.1967465-5-memxor@gmail.com/
>
> > This allows relying on a consistent set of guarantees after that call
> > and then relying on them in code that deals with registers for each
> > argument type later. This is in line with how process_spin_lock,
> > process_timer_func, process_kptr_func check reg->var_off to be constant.
> > The same reasoning is used here to move the alignment check into
> > process_dynptr_func. Note that it also needs to check for constant
> > var_off, and accumulate the constant var_off when computing the spi in
> > get_spi, but that fix will come in later changes.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 34e67d04579b..fd292f762d53 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5774,6 +5774,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >  		return -EFAULT;
> >  	}
> >
> > +	/* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
> > +	 * check_func_arg_reg_off's logic. We only need to check offset
> > +	 * alignment for PTR_TO_STACK.
> > +	 */
> > +	if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
> > +		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > +		return -EINVAL;
> > +	}
>
> As alluded to above, I personally think it's more confusing to have this
> check in process_dynptr_func(). On the one hand you have
> check_func_arg_reg_off() which verifies that a register has the correct
> offset, but then here we have to check for the register offset for
> PTR_TO_STACK dynptrs specifically? Wouldn't it be better to try and push
> as much of the offset-checking complexity into one place as possible?
>

I'm trying to make a split between 'offset correct for the reg->type in
general', and 'offset correct for the reg->type when when passed as an argument
for arg_type'. I think the latter is specific and different for each case and
thus belongs inside the case ARG_TYPE_* block of each of those.

Anyhow, all of this is not to reject your point, but to say that if we're
keeping that check in check_func_arg_reg_off for dynptr, let's also examine why
we should/shouldn't move checks for other arg_types inside it as well, and
whether the end result is going to be better than this.

In that case, atleast to me, it doesn't make sense to check reg->off %
BPF_REG_SIZE for ARG_PTR_TO_DYNPTR while leaving out other arg types.
